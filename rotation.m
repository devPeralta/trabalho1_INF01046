% Função que recebe uma imagem e retorna uma imagem rotacionada no proprio eixo
 
function outputImage = rotation(inputImage, degrees) 

    %Conversão para radianos
    angulo = degrees * pi / 180;
    
    %Armazena linhas, colunas e canal RGB
    [row, col, ~] = size(inputImage);
    
    %Cálculo do centro da imagem
    centerRow = floor(row / 2);
    centerCol = floor(col / 2);
    
    % Inicializa a imagem rotacionada
    outputImage = zeros(size(inputImage), 'uint8');
    
    % Aplica a transformação de rotação a cada pixel na imagem original
    for i = 1:row
        for j = 1:col

            % Calcula as coordenadas originais em relação ao centro da imagem
            x = i - centerRow;
            y = j - centerCol;
            
            % Aplica a transformação de rotação
            xRot = round(x * cos(angulo) - y * sin(angulo));
            yRot = round(x * sin(angulo) + y * cos(angulo));
            
            % Ajusta as coordenadas rotacionadas para o sistema de coordenadas da imagem
            xRot = xRot + centerRow;
            yRot = yRot + centerCol;
            
            % Verifica se as coordenadas estão dentro dos limites da imagem original
            if xRot >= 1 && xRot <= row && yRot >= 1 && yRot <= col
                outputImage(i, j, :) = inputImage(xRot, yRot, :);
            end
        end
    end