% Função que recebe uma imagem e retorna uma imagem com o triplo de resolução
% utilizando interpolação bilinear

function imageZoom = bilinear3x(imageNormal) 

    %Armazena linhas, colunas e canal RGB
    [row,col,rgb] = size(imageNormal);
    
    % Inicializa a imagem escalada
    imageAux = zeros(3*row, 3*col, rgb, class(imageNormal));
    
    % Aplica o algoritmo de interpolação por vizinho mais próximo 3x
    % para facilitar o cálculo dos 4 vizinhos mais próximos
    for i = 2:(3*row)+1
        for j = 2:(3*col)+1
            x = round(j/3);
            y = round(i/3);
            
            x = max(1,min(col,x));
            y = max(1,min(row,y));
    
            imageAux(i-1,j-1,:) = imageNormal(y,x,:);
        end
    end
    
    % Insere pixels interpolados na imagem de retorno
    % A variável k representa cada canal RGB
    for k = 1:3
        for i = 1:3*row-1
            for j = 1:3*col-1
    
                if i == 1 && j == 1
                % Pixels no canto da imagem, ou seja, há apenas dois vizinhos mais próximos
                imageZoom(i,j,k) = imageAux(i+1,j,k)*1/2 + imageAux(i,j+1,k)*1/2;
                elseif i == 1
                % Pixels na borda horizontal da imagem
                imageZoom(i,j,k) = imageAux(i+1,j,k)*1/3 + imageAux(i,j+1,k)*1/3 + imageAux(i,j-1,k)*1/3;
                elseif j == 1
                % Pixels na borda vertical da imagem    
                imageZoom(i,j,k) = imageAux(i+1,j,k)*1/3 + imageAux(i,j+1,k)*1/3 + imageAux(i-1,j,k)*1/3;
                else
                % Pixels que não estão na borda da imagem, ou seja, a interpolação usa a média dos 4 vizinhos mais próximos
                imageZoom(i,j,k) = imageAux(i+1,j,k)*1/4 + imageAux(i-1,j,k)*1/4 + imageAux(i,j+1,k)*1/4 + imageAux(i,j-1,k)*1/4;
                end
            end
        end
    end