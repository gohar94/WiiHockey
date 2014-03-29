close all
clear all
clc
figure;
close all
figure('units','normalized','outerposition',[0 0 1 1],'WindowStyle','modal');

bk = imread('homescreen.jpg');
image(bk);
hold on
axis off

btn2 = imread('multitimer.png');
btni2 = imresize(btn2, [100 215]);
h2 = uicontrol('Style','PushButton','Units','normalized',...
    'cdata', btni2,'Position',[.72 .60 .159 .137]);
set(h2, 'callback', 'airhockey_multiplayer_time')

btn21 = imread('goalmulti.jpeg');
btni21 = imresize(btn21, [100 215]);
h2 = uicontrol('Style','PushButton','Units','normalized',...
    'cdata', btni21,'Position',[.72 .780 .159 .137]);
set(h2, 'callback', 'airhockey_multiplayer_goals')

btn22 = imread('back.png');
btni22 = imresize(btn22, [75 115]);
h2 = uicontrol('Style','PushButton','Units','normalized',...
    'cdata', btni22,'Position',[.72 .18 .076 .107]);
set(h2, 'callback', 'game_menu')
