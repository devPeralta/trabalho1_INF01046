% Função que recebe uma imagem e retorna uma imagem com o triplo de resolução
% utilizando interpolação por vizinho mais próximo

function outputImage = nearestNeighbor3x(inputImage) 

    % Armazena linhas, colunas e canal RGB
    [row,col,rgb] = size(inputImage);
    
    % Inicializa a imagem escalada
    outputImage = zeros(3*row, 3*col, rgb, class(inputImage));
    
    % Insere pixels interpolados na imagem de retorno
    for i = 1:3*row
        for j = 1:3*col
            x = round(j/3);
            y = round(i/3);
            
            % Garantia de que as coordenadas estão nos limites da imagem original
            x = max(1,min(col,x));
            y = max(1,min(row,y));
    
            outputImage(i,j,:) = inputImage(y,x,:);
        end
    end