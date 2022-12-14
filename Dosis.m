
% X es el valor normalizado de R, G, B
% R: 0.0450380826239147 2.11956671492532 -3.28368654895324
% G: 0.0171158657931860 3.02794588913442 -4.75872048307099
% B: -0.133044775671637 14.9927317017188 -26.2991652925775
% clear variables;
%clear all;
maxBitNumber=65535;
disp('Hola');

%% Cargar Radiocrómicas
filmPath = 'RC1(sin)-buena.tif';
recorte=[29.5 169.5 1025 1230];
I1 = imread(filmPath);
I1R = imcrop(I1,recorte);
R1R = double(I1R(:,:,1)) / maxBitNumber;
G1R = double(I1R(:,:,2)) / maxBitNumber;
B1R = double(I1R(:,:,3)) / maxBitNumber;

filmPath2 = 'RC1(sin)-buena (2).tif';
I2 = imread(filmPath2);
I2R = imcrop(I2,recorte);
R2R = double(I2R(:,:,1)) / maxBitNumber;
G2R = double(I2R(:,:,2)) / maxBitNumber;
B2R = double(I2R(:,:,3)) / maxBitNumber;

filmPath3 = 'RC1(sin)-buena (3).tif';
I3 = imread(filmPath3);
I3R = imcrop(I3,recorte);
R3R = double(I3R(:,:,1)) / maxBitNumber;
G3R = double(I3R(:,:,2)) / maxBitNumber;
B3R = double(I3R(:,:,3)) / maxBitNumber;

filmPath4 = 'RC1(sin)-buena (4).tif';
I4 = imread(filmPath4);
I4R = imcrop(I4,recorte);
R4R = double(I4R(:,:,1)) / maxBitNumber;
G4R = double(I4R(:,:,2)) / maxBitNumber;
B4R = double(I4R(:,:,3)) / maxBitNumber;


%% Sacar promedios con errores
% Media
juntasR = zeros(recorte(4)+1,recorte(3)+1,3,4);

% Rojo
juntasR(:,:,1,1) = R1R;
juntasR(:,:,1,2) = R2R;
juntasR(:,:,1,3) = R3R;
juntasR(:,:,1,4) = R4R;
% Verde
juntasR(:,:,2,1) = G1R;
juntasR(:,:,2,2) = G2R;
juntasR(:,:,2,3) = G3R;
juntasR(:,:,2,4) = G4R;
% Azul 
juntasR(:,:,3,1) = B1R;
juntasR(:,:,3,2) = B2R;
juntasR(:,:,3,3) = B3R;
juntasR(:,:,3,4) = B4R;

% Desviación estándar de las matrices pixel a pixel de la 4 dimensión
desvRR = std(juntasR(:,:,1,:),0,4);
desvGR = std(juntasR(:,:,2,:),0,4);
desvBR = std(juntasR(:,:,3,:),0,4);

%Matriz promedio
mediaRR = mean(juntasR(:,:,1,:),4);
mediaGR = mean(juntasR(:,:,2,:),4);
mediaBR = mean(juntasR(:,:,3,:),4);



%% Definimos la función para cada uno de los canales
aR=0.0450380826239147; bR=2.11956671492532; cR=-3.28368654895324;
aG=0.0171158657931860; bG=3.02794588913442; cG=-4.75872048307099;
aB=-0.133044775671637; bB=14.9927317017188; cB=-26.2991652925775;


DR = @(mediaRR) aR + bR ./ (mediaRR - cR);
DG = @(mediaGR) aG + bG ./ (mediaGR - cG);
DB = @(mediaBR) aB + bB ./ (mediaBR - cB);


%% Pintamos la dosis por separados (utilizamos los tres canales)
DosisR = DR(mediaRR);
figure(1)
imagesc(DosisR)
caxis([0 1])
colorbar
title('Canal R')
set(get(colorbar,'title'),'string','Dosis')

DosisG = DG(mediaGR);
figure(2)
imagesc(DosisG)
caxis([0 1])
colorbar
title('Canal G')
set(get(colorbar,'title'),'string','Dosis')
 
DosisB = DB(mediaBR);
figure(3)
imagesc(DosisB)
caxis([0 1])
colorbar
title('canal B')
set(get(colorbar,'title'),'string','Dosis')

%% Obtenemos la dosis mediante una media ponderada y representamos
% DeltaR=@(PVR) bR.*(desvRR)./(PVR-aR).^2
% DeltaG=@(PVG) bG.*(desvGR)./(PVG-aG).^2
% DeltaB=@(PVB) bB.*(desvBR)./(PVB-aB).^2
DeltaR= bR.*(desvRR)./(DosisR-cR).^2;
DeltaG= bG.*(desvGR)./(DosisG-cG).^2;
DeltaB= bB.*(desvBR)./(DosisB-cB).^2;
DosisTotalRGB=(DosisR.*(DeltaR)+DosisG.*(DeltaG)+DosisB.*(DeltaB))./((DeltaR)+(DeltaG)+(DeltaB));
figure(4)
imagesc(DosisTotalRGB)
colorbar
caxis([0 1])
title('Dosis por pixel RGB')
set(get(colorbar,'title'),'string','Dosis')
%% Utilizando los canales RG media ponderada
DosisTotalRG=(DosisR.*(DeltaR)+DosisG.*(DeltaG))./((DeltaR)+(DeltaG));
figure(5)
imagesc(DosisTotalRG)
colorbar
caxis([0 1])
title('Dosis por pixel RG')
set(get(colorbar,'title'),'string','Dosis')
%% Utilizando los canales RG media aritmética
DosisTotalRG2=(DosisR+DosisG)./2;
figure(6)
imagesc(DosisTotalRG2)
colorbar
title('Dosis por pixel RG (m.a.)')
caxis([0 1])
set(get(colorbar,'title'),'string','Dosis')
%% Comparación de los métodos
DesviacionDosisRG=abs((DosisTotalRG-DosisTotalRG2)*100./DosisTotalRG);
DesviacionDosisRGByRG=abs(DosisTotalRGB-DosisTotalRG)*100./(DosisTotalRGB);

DosismaximaRGB=max(max(DosisTotalRGB));
DosismaximaRG=max(max(DosisTotalRG));
DosismaximaRG2=max(max(DosisTotalRG2));
DosisMaxima=[DosismaximaRGB DosismaximaRG DosismaximaRG2]


