function MST = Prim(nodes) 

    numNode = length(nodes);
    
    % Xóa các liên kết đến nút bị xóa và cập nhật trạng thái visited
    dead = [];
    cnt_dead = 1;
    for i = 1:numNode
        if nodes(i).status == 0
            DeleteNodesFromNeighbor(i, nodes);
            nodes(i).neighbor = [];
            nodes(i).parent = [];
            nodes(i).child = [];
            dead(cnt_dead) = nodes(i).ID;
            cnt_dead = cnt_dead + 1;
        end     
    end
    
    % Khởi tạo visited với tất cả các nút chưa được duyệt
    visited = false(1, numNode); 
    
    % Lưu trữ các cạnh của cây tìm kiếm nhỏ nhất
    MST = zeros(numNode - 1, 2);   
    edgeCount = 0;
    
    % Dead -> visisted
    for i = 1 : length(dead)
        visited(dead(i)) = true;
    end

    % Bắt đầu với nút đầu tiên
    visited(1) = true;
    

    %Vong lap quet den khi tat cac diem duoc quet ==> bang true
    while(edgeCount < numNode - cnt_dead)
        max = 0;
        u = 0;
        v = 0;
        for i = 1:numNode
            if(visited(i))
                for j = 1:length(nodes(i).neighbor)
                    if(~visited(nodes(i).neighbor(j)) && nodes(i).link(j) > max)
                        max = nodes(i).link(j);
                        u = i;
                        v = nodes(i).neighbor(j);
                    end
                end
            end
        end
        visited(v) = true ;
        edgeCount = edgeCount + 1;
        MST(edgeCount, :) = [u, v];
    end
    
    % Vẽ các cạnh của cây tìm kiếm nhỏ nhất
    for i = 1 : (numNode - cnt_dead)
        h = line([nodes(MST(i, 1)).x, nodes(MST(i, 2)).x], [nodes(MST(i, 1)).y, nodes(MST(i, 2)).y]);
        h.LineStyle = '-';
        h.LineWidth = 2;
        h.Color = [0 1 0];
        pause(0.2);
    end
end
