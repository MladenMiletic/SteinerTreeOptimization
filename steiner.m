clear all;
loaddata;
for i=1:1:100
clearvars -except timer X Y steinerpath FromEdge ToEdge Distance DelFrom DelTo TerminalsA i;


%% Construct a graph
Terminals = TerminalsA;
G = graph(FromEdge, ToEdge, Distance);
G = rmedge(G, DelFrom, DelTo);
%%
%Plot a graph and highlight Terminal nodes in red
p = plot(G, 'MarkerSize', 0.1,'LineWidth', 0.1, 'XData',X,'YData',Y);
highlight(p,Terminals,'NodeColor','r', 'MarkerSize', 3);
%%
%Steiner Tree algorithm #1
tic

%Start with random terminal and create a subgraph which is a list of nodes
%pos = randi(length(Terminals));
pos = i;
 initialNode = Terminals(pos);
Terminals(pos) = [];
Steiner = initialNode;
steinerpath(i) = 0;
% Add terminals one by one and connect them to the subgraph
while ~isempty(Terminals)
    %Get distance matrix of all nodes in subgraph to other Terminals %This is the most computationaly
    %heavy segment of the algorithm
    
    d = distances(G, Steiner, Terminals);
    %Determine Terminal which is closest to Subgraph
    [min_val,idx]=min(d(:));
    [row,col]=ind2sub(size(d),idx);
    [path, D] = shortestpath(G,Steiner(row),Terminals(col));
    steinerpath(i) = steinerpath(i) + D;
    %Add all nodes on path to Steiner subgraph
    for j=2:1:length(path)
        Steiner(end+1) = path(j);
    end
    Steiner = unique(Steiner);
    Terminals(col) = [];
    highlight(p,path,'EdgeColor', 'r', 'LineWidth', 4);
    drawnow;
end
timer(i) = toc

%disp(steinerpath(i));
%plot(G,'XData',X,'YData',Y,'ZData',Z)
end

%%

