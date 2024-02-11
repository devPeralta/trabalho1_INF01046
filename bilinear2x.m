% Função que recebe uma imagem e retorna uma imagem com o dobro de resolução
% utilizando interpolação bilinear
 
function outputImage = bilinear2x(inputImage) 

    %Armazena linhas, colunas e canal RGB
    [row,col,rgb] = size(inputImage);
    
    % Inicializa a imagem escalada
    auxImage = zeros(2*row, 2*col, rgb, class(inputImage));
    
    % Aplica o algoritmo de interpolação por vizinho mais próximo 2x
    % para facilitar o cálculo dos 4 vizinhos mais próximos
    for i = 1:2*row
        for j = 1:2*col
            x = round(j/2);
            y = round(i/2);
            auxImage(i,j,:) = inputImage(y,x,:);
        end
    end
    
    % Insere pixels interpolados na imagem de retorno
    % A variável k representa cada canal RGB
    for k = 1:3
        for i = 1:2*row-1
            for j = 1:2*col-1
    
                if i == 1 && j == 1
                % Pixels no canto da imagem, ou seja, há apenas dois vizinhos mais próximos
                outputImage(i,j,k) = auxImage(i+1,j,k)*1/2 + auxImage(i,j+1,k)*1/2;
                elseif i == 1
                % Pixels na borda horizontal da imagem
                outputImage(i,j,k) = auxImage(i+1,j,k)*1/3 + auxImage(i,j+1,k)*1/3 + auxImage(i,j-1,k)*1/3;
                elseif j == 1
                % Pixels na borda vertical da imagem
                outputImage(i,j,k) = auxImage(i+1,j,k)*1/3 + auxImage(i,j+1,k)*1/3 + auxImage(i-1,j,k)*1/3;
                else
                % Pixels que não estão na borda da imagem, ou seja, a interpolação usa a média dos 4 vizinhos mais próximos
                outputImage(i,j,k) = auxImage(i+1,j,k)*1/4 + auxImage(i-1,j,k)*1/4 + auxImage(i,j+1,k)*1/4 + auxImage(i,j-1,k)*1/4;
                end
            end
        end
    end