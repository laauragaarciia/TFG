clear variables;
%clear all;
%([xmin ymin width height])
maxBitNumber=65535;

%% Folios en blanco
filmPathB1 = 'BLANCO1.tif';
IB1=imread(filmPathB1);
filmPathB2 = 'BLANCO2.tif';
IB2=imread(filmPathB2);
figure
subplot(1,2,1)
imshow(IB1)
subplot(1,2,2)
imshow(IB2)

%% Análisis folio blanco
%Recortar la imagen y obtener solo la parte central
Recorte=[137.5 176.5 871 1213];
IB1C=imcrop(IB1,Recorte);
figure
imshow(IB1C)
RB1C = double(IB1C(:,:,1)) / maxBitNumber;
GB1C = double(IB1C(:,:,2)) / maxBitNumber;
BB1C = double(IB1C(:,:,3)) / maxBitNumber;
figure
subplot(2,2,1)
hold off
plot(mean(RB1C),'r'); hold on
plot(mean(GB1C),'g');
plot(mean(BB1C),'b')
title('Horizontal')
xlim([0 Recorte(3)])
ylim([0 1])

subplot(2,2,2)
hold off
plot(mean(RB1C,2),'r'); hold on
plot(mean(GB1C,2),'g');
plot(mean(BB1C,2),'b')
title('Vertical')
xlim([0 Recorte(4)])
ylim([0 1])

subplot(2,2,3)
hold off
plot(mean(RB1C),'r'); hold on
plot(mean(GB1C),'g');
plot(mean(BB1C),'b')
title('Horizontal')
xlim([0 Recorte(3)])


subplot(2,2,4)
hold off
plot(mean(RB1C,2),'r'); hold on
plot(mean(GB1C,2),'g');
plot(mean(BB1C,2),'b')
title('Vertical')
xlim([0 Recorte(4)])


%% Radiocrómicas
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

filmPath5 = 'RC1(sin)-buena (5).tif';
I5 = imread(filmPath5);
I5R = imcrop(I5,recorte);
R5R = double(I5R(:,:,1)) / maxBitNumber;
G5R = double(I5R(:,:,2)) / maxBitNumber;
B5R = double(I5R(:,:,3)) / maxBitNumber;

filmPath6 = 'RC1(sin)-buena (6).tif';
I6 = imread(filmPath6);
I6R = imcrop(I6,recorte);
R6R = double(I6R(:,:,1)) / maxBitNumber;
G6R = double(I6R(:,:,2)) / maxBitNumber;
B6R = double(I6R(:,:,3)) / maxBitNumber;

figure
subplot(2,3,1)
imshow(I1R);
subplot(2,3,2)
imshow(I2R);
subplot(2,3,3)
imshow(I3R);
subplot(2,3,4)
imshow(I4R);
subplot(2,3,5)
imshow(I5R);
subplot(2,3,6)
imshow(I6R);

%% Análisis 4 Primeras
%Pixel a pixel 
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


%Desviación estándar de las matrices pixel a pixel de la 4 dimensión
desvRR = std(juntasR(:,:,1,:),0,4)
desvGR = std(juntasR(:,:,2,:),0,4)
desvBR = std(juntasR(:,:,3,:),0,4)
Media
%Matriz promedio
mediaRR = mean(juntasR(:,:,1,:),4);
mediaGR = mean(juntasR(:,:,2,:),4);
mediaBR = mean(juntasR(:,:,3,:),4);

RRfinal = round(maxBitNumber*mediaRR,0);
GRfinal = round(maxBitNumber*mediaGR,0);
BRfinal = round(maxBitNumber*mediaBR,0);


%desviación estándar de los elementos de cada columna 1x1183
dsv_MediaRRc=std(mediaRR,0,1)
dsv_MediaGRc=std(mediaGR,0,1)
dsv_MediaBRc=std(mediaBR,0,1)
%desviación estándar de los elementos de cada fila 1500x1
dsv_MediaRRf=std(mediaRR,0,2)
dsv_MediaGRf=std(mediaGR,0,2)
dsv_MediaBRf=std(mediaBR,0,2)


%% Dibujar 
imFinalR = uint16(zeros(recorte(4)+1,recorte(3)+1,3));
imFinalR(:,:,1) = uint16(RRfinal);
imFinalR(:,:,2) = uint16(GRfinal);
imFinalR(:,:,3) = uint16(BRfinal);
figure
imshow(imFinalR)
Variación horizontal
juntasmeanHR = zeros(size(mean(double(I1R(:,:,1)) / maxBitNumber),1),size(mean(double(I1R(:,:,1)) / maxBitNumber),2),3,4);
%Promedio: 1x1183

%Rojo
juntasmeanHR(:,:,1,1) = mean(double(I1R(:,:,1)) / maxBitNumber);
juntasmeanHR(:,:,1,2) = mean(double(I2R(:,:,1)) / maxBitNumber);
juntasmeanHR(:,:,1,3) = mean(double(I3R(:,:,1)) / maxBitNumber);
juntasmeanHR(:,:,1,4) = mean(double(I4R(:,:,1)) / maxBitNumber);

%Verde
juntasmeanHR(:,:,2,1) = mean(double(I1R(:,:,2)) / maxBitNumber);
juntasmeanHR(:,:,2,2) = mean(double(I2R(:,:,2)) / maxBitNumber);
juntasmeanHR(:,:,2,3) = mean(double(I3R(:,:,2)) / maxBitNumber);
juntasmeanHR(:,:,2,4) = mean(double(I4R(:,:,2)) / maxBitNumber);


%Azul
juntasmeanHR(:,:,3,1) = mean(double(I1R(:,:,3)) / maxBitNumber);
juntasmeanHR(:,:,3,2) = mean(double(I2R(:,:,3)) / maxBitNumber);
juntasmeanHR(:,:,3,3) = mean(double(I3R(:,:,3)) / maxBitNumber);
juntasmeanHR(:,:,3,4) = mean(double(I4R(:,:,3)) / maxBitNumber);

desvRmeanHR = std(juntasmeanHR(:,:,1,:),0,4)
desvGmeanHR = std(juntasmeanHR(:,:,2,:),0,4)
desvBmeanHR = std(juntasmeanHR(:,:,3,:),0,4)

%% Variación horizontal de la media

%desviación estándar de los elementos de cada fila 1500x1
%Rojo
dsv_MediaRmeanHfR=std(mean(juntasmeanHR(:,:,1,:),4),0,2)
%Verde
dsv_MediaGmeanHfR=std(mean(juntasmeanHR(:,:,2,:),4),0,2)
%Azul
dsv_MediaBmeanHfR=std(mean(juntasmeanHR(:,:,3,:),4),0,2)
Variación vertical
juntasmeanVR = zeros(size(mean(double(I1R(:,:,1)) / maxBitNumber,2),1),size(mean(double(I1R(:,:,1)) / maxBitNumber,2),2),3,4);

%Promedio: 1500x1
%Rojo
juntasmeanVR(:,:,1,1) = mean(double(I1R(:,:,1)) / maxBitNumber,2);
juntasmeanVR(:,:,1,2) = mean(double(I2R(:,:,1)) / maxBitNumber,2);
juntasmeanVR(:,:,1,3) = mean(double(I3R(:,:,1)) / maxBitNumber,2);
juntasmeanVR(:,:,1,4) = mean(double(I4R(:,:,1)) / maxBitNumber,2);

%Verde
juntasmeanVR(:,:,2,1) = mean(double(I1R(:,:,2)) / maxBitNumber,2);
juntasmeanVR(:,:,2,2) = mean(double(I2R(:,:,2)) / maxBitNumber,2);
juntasmeanVR(:,:,2,3) = mean(double(I3R(:,:,2)) / maxBitNumber,2);
juntasmeanVR(:,:,2,4) = mean(double(I4R(:,:,2)) / maxBitNumber,2);

%Azul
juntasmeanVR(:,:,3,1) = mean(double(I1R(:,:,3)) / maxBitNumber,2);
juntasmeanVR(:,:,3,2) = mean(double(I2R(:,:,3)) / maxBitNumber,2);
juntasmeanVR(:,:,3,3) = mean(double(I3R(:,:,3)) / maxBitNumber,2);
juntasmeanVR(:,:,3,4) = mean(double(I4R(:,:,3)) / maxBitNumber,2);


desvRmeanVR = std(juntasmeanVR(:,:,1,:),0,4)
desvGmeanVR = std(juntasmeanVR(:,:,2,:),0,4)
desvBmeanVR = std(juntasmeanVR(:,:,3,:),0,4)

%% Variación vertical de la media
%desviación estándar de los elementos de cada columna 1x1183
dsv_MediameanVRf=std(mean(juntasmeanVR(:,:,1,:),4),0,1)
dsv_MediaGmeanVRf=std(mean(juntasmeanVR(:,:,2,:),4),0,1)
dsv_MediaBmeanVRf=std(mean(juntasmeanVR(:,:,3,:),4),0,1)


%% Análisis 2 últimos
Pixel a pixel 
juntasR2 = zeros(recorte(4)+1,recorte(3)+1,3,2);

% Rojo
juntasR2(:,:,1,1) = R5R;
juntasR2(:,:,1,2) = R6R;
% Verde
juntasR2(:,:,2,1) = G5R;
juntasR2(:,:,2,2) = G6R;
% Azul 
juntasR2(:,:,3,1) = B5R;
juntasR2(:,:,3,2) = B6R;

%Desviación estándar de las matrices pixel a pixel de la 4 dimensión
desvRR2 = std(juntasR2(:,:,1,:),0,4)
desvGR2 = std(juntasR2(:,:,2,:),0,4)
desvBR2 = std(juntasR2(:,:,3,:),0,4)
Media
%Matriz promedio
mediaRR2 = mean(juntasR2(:,:,1,:),4);
mediaGR2 = mean(juntasR2(:,:,2,:),4);
mediaBR2 = mean(juntasR2(:,:,3,:),4);

RRfinal2 = round(maxBitNumber*mediaRR2,0);
GRfinal2 = round(maxBitNumber*mediaGR2,0);
BRfinal2 = round(maxBitNumber*mediaBR2,0);


%desviación estándar de los elementos de cada columna 1x1183
dsv_MediaRRc2=std(mediaRR2,0,1)
dsv_MediaGRc2=std(mediaGR2,0,1)
dsv_MediaBRc2=std(mediaBR2,0,1)
%desviación estándar de los elementos de cada fila 1500x1
dsv_MediaRRf2=std(mediaRR2,0,2)
dsv_MediaGRf2=std(mediaGR2,0,2)
dsv_MediaBRf2=std(mediaBR2,0,2)


%% Dibujar 
imFinalR2 = uint16(zeros(recorte(4)+1,recorte(3)+1,3));
imFinalR2(:,:,1) = uint16(RRfinal2);
imFinalR2(:,:,2) = uint16(GRfinal2);
imFinalR2(:,:,3) = uint16(BRfinal2);
figure
imshow(imFinalR2)

%% Variación horizontal
juntasmeanHR2 = zeros(size(mean(double(I1R(:,:,1)) / maxBitNumber),1),size(mean(double(I1R(:,:,1)) / maxBitNumber),2),3,2);
%Promedio: 1x1183
%Rojo
juntasmeanHR2(:,:,1,1) = mean(double(I5R(:,:,1)) / maxBitNumber);
juntasmeanHR2(:,:,1,2) = mean(double(I6R(:,:,1)) / maxBitNumber);
%Verde
juntasmeanHR2(:,:,2,1) = mean(double(I5R(:,:,2)) / maxBitNumber);
juntasmeanHR2(:,:,2,2) = mean(double(I6R(:,:,2)) / maxBitNumber);
%Azul
juntasmeanHR2(:,:,3,1) = mean(double(I5R(:,:,3)) / maxBitNumber);
juntasmeanHR2(:,:,3,2) = mean(double(I6R(:,:,3)) / maxBitNumber);

desvRmeanHR2 = std(juntasmeanHR2(:,:,1,:),0,4)
desvGmeanHR2 = std(juntasmeanHR2(:,:,2,:),0,4)
desvBmeanHR2 = std(juntasmeanHR2(:,:,3,:),0,4)

%% Variación horizontal de la media

%desviación estándar de los elementos de cada fila 1500x1
%Rojo
dsv_MediaRmeanHfR2=std(mean(juntasmeanHR2(:,:,1,:),4),0,2)
%Verde
dsv_MediaGmeanHfR2=std(mean(juntasmeanHR2(:,:,2,:),4),0,2)
%Azul
dsv_MediaBmeanHfR2=std(mean(juntasmeanHR2(:,:,3,:),4),0,2)
Variación vertical
juntasmeanVR2 = zeros(size(mean(double(I1R(:,:,1)) / maxBitNumber,2),1),size(mean(double(I1R(:,:,1)) / maxBitNumber,2),2),3,6);

%Promedio: 1500x1
%Rojo
juntasmeanVR2(:,:,1,1) = mean(double(I5R(:,:,1)) / maxBitNumber,2);
juntasmeanVR2(:,:,1,2) = mean(double(I6R(:,:,1)) / maxBitNumber,2);
%Verde
juntasmeanVR2(:,:,2,1) = mean(double(I5R(:,:,2)) / maxBitNumber,2);
juntasmeanVR2(:,:,2,2) = mean(double(I6R(:,:,2)) / maxBitNumber,2);
%Azul
juntasmeanVR2(:,:,3,1) = mean(double(I5R(:,:,3)) / maxBitNumber,2);
juntasmeanVR2(:,:,3,2) = mean(double(I6R(:,:,3)) / maxBitNumber,2);

desvRmeanVR2 = std(juntasmeanVR2(:,:,1,:),0,4)
desvGmeanVR2 = std(juntasmeanVR2(:,:,2,:),0,4)
desvBmeanVR2 = std(juntasmeanVR2(:,:,3,:),0,4)


%% Variación vertical de la media
%desviación estándar de los elementos de cada columna 1x1183
dsv_MediameanVRf2=std(mean(juntasmeanVR2(:,:,1,:),4),0,1)
dsv_MediaGmeanVRf2=std(mean(juntasmeanVR2(:,:,2,:),4),0,1)
dsv_MediaBmeanVRf2=std(mean(juntasmeanVR2(:,:,3,:),4),0,1)

%% Comparar las dos radiocrómicas
figure
subplot(1,2,1)
imshow(imFinalR)
subplot(1,2,2)
imshow(imFinalR2)

%Construir matrices que representen las desviaciones pixel a pixel
DesviacionPromediosR=abs((RRfinal2-RRfinal)*100./RRfinal)
DesviacionPromediosG=abs((GRfinal2-GRfinal)*100./GRfinal)
DesviacionPromediosB=abs((BRfinal2-BRfinal)*100./BRfinal)

figure
%Horizontal
subplot(2,2,1)
hold off
plot(mean(juntasmeanHR(:,:,1,:),4),'r'); hold on
plot(mean(juntasmeanHR(:,:,2,:),4),'g');
plot(mean(juntasmeanHR(:,:,3,:),4),'b')
title('Horizontal 4 primeras')
errorbar(mean(juntasmeanHR(:,:,1,:),4),desvRmeanHR,'r')
errorbar(mean(juntasmeanHR(:,:,2,:),4),desvGmeanHR,'g')
errorbar(mean(juntasmeanHR(:,:,3,:),4),desvBmeanHR,'b')
ylim([0 1])
xlim([0 recorte(3)+1])


subplot(2,2,2)
hold off
plot(mean(juntasmeanHR2(:,:,1,:),4),'r'); hold on
plot(mean(juntasmeanHR2(:,:,2,:),4),'g');
plot(mean(juntasmeanHR2(:,:,3,:),4),'b')
title('Horizontal 2 últimas')
errorbar(mean(juntasmeanHR2(:,:,1,:),4),desvRmeanHR2,'r')
errorbar(mean(juntasmeanHR2(:,:,2,:),4),desvGmeanHR2,'g')
errorbar(mean(juntasmeanHR2(:,:,3,:),4),desvBmeanHR2,'b')
ylim([0 1])
xlim([0 recorte(3)+1])

%Vertical
subplot(2,2,3)
hold on 
plot(mean(juntasmeanVR(:,:,1,:),4),'r'); hold on
plot(mean(juntasmeanVR(:,:,2,:),4),'g');
plot(mean(juntasmeanVR(:,:,3,:),4),'b')
title('Vertical 4 primeras')
errorbar(mean(juntasmeanVR(:,:,1,:),4),desvRmeanVR,'r')
errorbar(mean(juntasmeanVR(:,:,2,:),4),desvGmeanVR,'g')
errorbar(mean(juntasmeanVR(:,:,3,:),4),desvBmeanVR,'b')
ylim([0 1])
xlim([0 recorte(4)+1])

subplot(2,2,4)
hold off
plot(mean(juntasmeanVR2(:,:,1,:),4),'r'); hold on
plot(mean(juntasmeanVR2(:,:,2,:),4),'g');
plot(mean(juntasmeanVR2(:,:,3,:),4),'b')
title('Vertical 2 últimas')
errorbar(mean(juntasmeanVR2(:,:,1,:),4),desvRmeanVR2,'r')
errorbar(mean(juntasmeanVR2(:,:,2,:),4),desvGmeanVR2,'g')
errorbar(mean(juntasmeanVR2(:,:,3,:),4),desvBmeanVR2,'b')
ylim([0 1])
xlim([0 recorte(4)+1])