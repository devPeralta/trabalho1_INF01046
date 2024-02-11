% Função que recebe uma imagem e retorna uma imagem com o dobro de resolução
% utilizando interpolação por vizinho mais próximo

function outputImage = nearestNeighbor2x(inputImage) 

    % Armazena linhas, colunas e canal RGB
    [row,col,rgb] = size(inputImage);
    
    % Inicializa a imagem escalada
    outputImage = zeros(2*row, 2*col, rgb, class(inputImage));
    
    % Insere pixels interpolados na imagem de retorno
    for i = 1:2*row
        for j = 1:2*col
            x = round(j/2);
            y = round(i/2);
            outputImage(i,j,:) = inputImage(y,x,:);
        end
    end