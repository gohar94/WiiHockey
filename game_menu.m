close all
clc
figure;
close all;

%open game in fullscreen
figure('units','normalized','outerposition',[0 0 1 1],'WindowStyle','modal');
bk = imread('homescreen.jpg');
image(bk);
hold on
axis off

%single player button
button = imread('beattheclockicon.png');
buttonin2 = imresize(button, [100 215]);
h2 = uicontrol('Style','PushButton','Units','normalized',...
    'cdata', buttonin2,'Position',[.72 .60 .159 .137]);
set(h2, 'callback', 'airhockey_beat_the_clock')

%multiplayer menu opening button
button = imread('multiplayericon.png');
buttonin2 = imresize(button, [100 215]);
h2 = uicontrol('Style','PushButton','Units','normalized',...
    'cdata', buttonin2,'Position',[.72 .780 .159 .137]);
set(h2, 'callback', 'airhockey_multiplayer')

%exit game
button = imread('quiticon.png');
buttonin2 = imresize(button, [80 115]);
h2 = uicontrol('Style','PushButton','Units','normalized',...
    'cdata', buttonin2,'Position',[.790 .13 .085 .1]);
set(h2, 'callback', 'exit')