%clear matlab
clc
clear all
close all

%wii is player one - color yellow - has to goal bottom
%mouse is player two - color cyan - has to goal top
%first to fifteen goals wins

figure;
close all
figure('units','normalized','outerposition',[0 0 1 1],'WindowStyle','modal');
        % imagesc([0 4000], [0 8000]);
    hold on
    % set(gca,'ydir','normal')

    %making board
    H = 8000;
    W = 4000;
    r_puck = 100;
    axis equal
    axis([-10000 W+100 0-100 H+100]);
      
    %boundaries and goals
    rectangle('Position',[0 0 W H],'FaceColor',[0.7 0 1]);
    rectangle('position',[-100,-100,4200,100],'facecolor','g');
    rectangle('position',[-100,8000,4200,100],'facecolor','g');
    rectangle('position',[-100,-100,100,8200],'facecolor','g');
    rectangle('position',[4000,-100,100,8200],'facecolor','g');
    rectangle('position',[1000,-100,2000,200],'facecolor','c');
    rectangle('position',[1000,7900,2000,200],'facecolor','c');
    
    %background image
    im = imread('bariers.jpg');
    imagesc([0 W], [0 H], flipdim(im,3));
    axis off
    
    zx=3;
    
    %connect wii
    addpath('C:\Program Files\WiiLAB\WiiLAB_Matlab\WiimoteFunctions')
    initializeWiimote();

    %take mouse input for striker one
    set(gcf, 'WindowButtonMotionFcn', ...
        'mouseLoc = get(gca, ''CurrentPoint'');');
    mouseLoc = [0 0 0 0];
    
    %wii input and scaling
    awii=0;
    bwii=0;
    cwii=0;
    scaling=8000;
    awiiscaled=awii*scaling;
    bwiiscaled=bwii*scaling;
    cwiiscaled=cwii*scaling;
    
    %reading game audio
    [yyyyy,Fs] = wavread('hitwall.wav');
            player=audioplayer(yyyyy,Fs);
       [xxxxx,Fs] = wavread('marbcup.wav');
       goal_sound=audioplayer(xxxxx,Fs);
    
    % set initial position of the ball as x and y
    x = 2000-r_puck; 
    y = 4000-r_puck;

    % set intial velocity dx and dy of puck
    dx = 1;
    dy = 1;


    tic
%     scoreboard
    [scoreboard blah blah111]= imread('scoreboard.png');
    p=imagesc([-8000 -2000], [4500 7000], flipdim(scoreboard,1));

    % draw a puck
    puck = rectangle('Position',[x-r_puck,y-r_puck, 2*r_puck,2*r_puck], 'Curvature',[1 1], 'FaceColor',[1 0 0]);

    %draw striker number one
    r_striker = 300;
    striker_1 = rectangle('Position',[2000-r_striker,6000-r_striker, 2*r_striker,2*r_striker], 'Curvature',[1 1], 'FaceColor',[1 1 0]);
    striker_2 = rectangle('Position',[2000-r_striker,2000-r_striker, 2*r_striker,2*r_striker], 'Curvature',[1 1], 'FaceColor','c');
    sum_of_r=r_striker+r_puck;
    score=0;
    score2=0;
    con=1;
    
    %making gui buttons    
     btn22 = imread('back.png');
    btni22 = imresize(btn22, [75 115]);
    h2 = uicontrol('Style','PushButton','Units','normalized',...
        'cdata', btni22,'Position',[.32 .18 .076 .107]);
    set(h2, 'callback', 'game_menu')
    
    %scoring on scoreboard
    scoretext=text(-6900,5750,num2str(score),'fontname','Kristen ITC','fontsize',28,'color','b');
    scoretext2=text(-4100,5750,num2str(score2),'fontname','Kristen ITC','fontsize',28,'color','b');
    rectangle('position',[-7500,5500,1650,500],'facecolor','r')
    rectangle('position',[-4700,5500,1650,500],'facecolor','r')
    set(scoretext,'string',(num2str(score)));
    set(scoretext2,'string',(num2str(score2)));
    
    %main game loop
    while ~isButtonPressed('B');
        [bwii cwii]=getWiimoteIR();
        awiiscaled=awii*scaling;
        bwiiscaled=4000-(bwii*scaling);
        cwiiscaled=8000-(cwii*scaling);
        game_start=tic;      
        
        %ends game after 120 seconds have elapsed
        time_elapsed=floor(toc);
        
        %ending conditions and messages
        if score==15 || score2==15
            if score>score2
            %message
            text(-11000,5000,'Congratulations Player One!','fontname','Kristen ITC','fontsize',40,'color','y');    
            
            %buttons when game ends
            buttongame = imread('beattheclockicon.png');
            btt = imresize(buttongame, [100 215]);
            h2 = uicontrol('Style','PushButton','Units','normalized',...
            'cdata', btt,'Position',[.44 .40 .159 .137]);
            set(h2, 'callback', 'airhockey_beat_the_clock')
            buttongame2 = imread('multiplayericon.png');
            btt2 = imresize(buttongame2, [100 215]);
            h2 = uicontrol('Style','PushButton','Units','normalized',...
            'cdata', btt2,'Position',[.44 .20 .159 .137]);
            set(h2, 'callback', 'airhockey_multiplayer')
           break
            end
            
            if score2>score
                %message
           text(-11000,5000,'Congratulations Player Two!','fontname','Kristen ITC','fontsize',40,'color','c'); 
           
            %ending messages
            buttongame = imread('beattheclockicon.png');
            btt = imresize(buttongame, [100 215]);
            h2 = uicontrol('Style','PushButton','Units','normalized',...
            'cdata', btt,'Position',[.44 .40 .159 .137]);
            set(h2, 'callback', 'airhockey_beat_the_clock')
            buttongame2 = imread('multiplayericon.png');
            btt2 = imresize(buttongame2, [100 215]);
            h2 = uicontrol('Style','PushButton','Units','normalized',...
            'cdata', btt2,'Position',[.44 .20 .159 .137]);
            set(h2, 'callback', 'airhockey_multiplayer')
           break
            end
                
        end
                
        zx=zx+1;
          
        mouseH(zx,:)=[(bwiiscaled) cwiiscaled];
        mouseH1(zx,:)=[mouseLoc(1) mouseLoc(3)];
                               
        %x and y cordinates of puck and striker
        x_of_striker=(bwiiscaled)-r_striker;
        x_of_puck=x-r_puck;
        y_of_striker=cwiiscaled-r_striker;
        y_of_puck=y-r_puck;
        x_of_striker2=mouseLoc(1)-r_striker;
        y_of_striker2=mouseLoc(3)-r_striker;
        
        %moving the puck
        x=x+dx;
        y=y+dy;

        %goal
        if x>1000 && x<3000 &&y<=100
            x = 2000;
            y = 4000;
            dy=0;
            dx=0;
            score=score+1; 
            
            rectangle('position',[-7500,5500,1650,500],'facecolor','r')
            scoretext=text(-6900,5750,num2str(score),'fontname','Kristen ITC','fontsize',28,'color','b');
            set(scoretext,'string',(num2str(score)));
            
            play(goal_sound)
        end
        
         if x>1000 && x<3000 && y>=7900
            x = 2000;
            y = 4000;
            dy=0;
            dx=0;
            score2=score2+1;
            
            rectangle('position',[-4700,5500,1650,500],'facecolor','r')
            scoretext2=text(-4100,5750,num2str(score2),'fontname','Kristen ITC','fontsize',28,'color','b');
            set(scoretext2,'string',(num2str(score2)));
            
            play(goal_sound)
         end

        %bouncing off the sides of the walls
        if x>W-r_puck || x<0+r_puck
            dx=-dx;            
            play(player)
        end

        if y>H-r_puck || y<0+r_puck
           dy=-dy;
           play(player)
        end

        %angle between puck and striker_1
        hello_angle=(y-cwiiscaled)/(x-(bwiiscaled));
        angle_puck_striker=atand(hello_angle);
        theta=abs(angle_puck_striker);
        
        hello_angle2=(y-mouseLoc(3))/(x-mouseLoc(1));
        angle_puck_striker2=atand(hello_angle2);
        theta2=abs(angle_puck_striker2);

        %calculation of distance between the puck and the striker
        delta_x=((bwiiscaled))-(x);
        delta_y=(cwiiscaled)-(y+r_puck);
        
        delta_x2=(mouseLoc(1)-x);
        delta_y2=(mouseLoc(3)-y);

        distance=sqrt((delta_x)^2 + (delta_y)^2);
        distance2=sqrt((delta_x2)^2 + (delta_y2)^2);

        %frames
        ddd=norm(mouseH(zx,:)-mouseH(zx-3,:));
        ddd2=norm(mouseH1(zx,:)-mouseH1(zx-3,:));
        
        ddd2=ddd2/170;
        ddd=ddd/170;
        %pushing the puck once it stops
          
        if x_of_striker>x_of_puck && y_of_striker>y_of_puck

            if distance<=sum_of_r && dx>0 && dy>0
                dx=-floor((10000/distance)*cosd(theta)*ddd);
                dy=-floor((10000/distance)*sind(theta)*ddd);
            end

            if distance<=sum_of_r && dx==0 && dy>0
                  dx=-floor((10000/distance)*cosd(theta)*ddd);
                  dy=-floor((10000/distance)*sind(theta)*ddd);
            end

            if distance<=sum_of_r && dx>0 && dy==0
                  dx=-floor((10000/distance)*cosd(theta)*ddd);
                  dy=-floor((10000/distance)*sind(theta)*ddd);
            end

            if distance<=sum_of_r && dx==0 && dy==0
                 dx=-floor((10000/distance)*cosd(theta)*ddd);
                 dy=-floor((10000/distance)*sind(theta)*ddd);
            end
        end

        if x_of_striker<x_of_puck && y_of_striker>y_of_puck

            if distance<=sum_of_r && dx>0 && dy>0
                dx=floor((10000/distance)*cosd(theta)*ddd);
                dy=-floor((10000/distance)*sind(theta)*ddd);
            end

            if distance<=sum_of_r && dx==0 && dy>0
                  dx=floor((10000/distance)*cosd(theta)*ddd);
                  dy=-floor((10000/distance)*sind(theta)*ddd);
            end

            if distance<=sum_of_r && dx>0 && dy==0
                  dx=floor((10000/distance)*cosd(theta)*ddd);
                  dy=-floor((10000/distance)*sind(theta)*ddd);
            end

            if distance<=sum_of_r && dx==0 && dy==0
                 dx=floor((10000/distance)*cosd(theta)*ddd);
                 dy=-floor((10000/distance)*sind(theta)*ddd);
            end
        end

        if x_of_striker>x_of_puck && y_of_striker<y_of_puck

            if distance<=sum_of_r && dx>0 && dy>0
                dx=-floor((10000/distance)*cosd(theta)*ddd);
                dy=floor((10000/distance)*sind(theta)*ddd);
            end

            if distance<=sum_of_r && dx==0 && dy>0
                  dx=-floor((10000/distance)*cosd(theta)*ddd);
                  dy=floor((10000/distance)*sind(theta)*ddd);
            end

            if distance<=sum_of_r && dx>0 && dy==0
                  dx=-floor((10000/distance)*cosd(theta)*ddd);
                  dy=floor((10000/distance)*sind(theta)*ddd);
            end

            if distance<=sum_of_r && dx==0 && dy==0
                 dx=-floor((10000/distance)*cosd(theta)*ddd);
                 dy=floor((10000/distance)*sind(theta)*ddd);
            end
        end

        if x_of_striker<x_of_puck && y_of_striker<y_of_puck

            if distance<=sum_of_r && dx>0 && dy>0
                dx=floor((10000/distance)*cosd(theta)*ddd);
                dy=floor((10000/distance)*sind(theta)*ddd);
            end

            if distance<=sum_of_r && dx==0 && dy>0
                  dx=floor((10000/distance)*cosd(theta)*ddd);
                  dy=floor((10000/distance)*sind(theta)*ddd);
            end

            if distance<=sum_of_r && dx>0 && dy==0
                  dx=floor((10000/distance)*cosd(theta)*ddd);
                  dy=floor((10000/distance)*sind(theta)*ddd);
            end

            if distance<=sum_of_r && dx==0 && dy==0
                 dx=floor((10000/distance)*cosd(theta)*ddd);
                 dy=floor((10000/distance)*sind(theta)*ddd);
            end
        end
        
        %%%%%%%%%%%%%%%%%%%%%
        
        if x_of_striker2>x_of_puck && y_of_striker2>y_of_puck

            if distance2<=sum_of_r && dx>0 && dy>0
                dx=-floor((10000/distance2)*cosd(theta2)*ddd2);
                dy=-floor((10000/distance2)*sind(theta2)*ddd2);
            end

            if distance2<=sum_of_r && dx==0 && dy>0
                  dx=-floor((10000/distance2)*cosd(theta2)*ddd2);
                  dy=-floor((10000/distance2)*sind(theta2)*ddd2);
            end

            if distance2<=sum_of_r && dx>0 && dy==0
                  dx=-floor((10000/distance2)*cosd(theta2)*ddd2);
                  dy=-floor((10000/distance2)*sind(theta2)*ddd2);
            end

            if distance2<=sum_of_r && dx==0 && dy==0
                 dx=-floor((10000/distance2)*cosd(theta2)*ddd2);
                 dy=-floor((10000/distance2)*sind(theta2)*ddd2);
            end
        end

        if x_of_striker2<x_of_puck && y_of_striker2>y_of_puck

            if distance2<=sum_of_r && dx>0 && dy>0
                dx=floor((10000/distance2)*cosd(theta2)*ddd2);
                dy=-floor((10000/distance2)*sind(theta2)*ddd2);
            end

            if distance2<=sum_of_r && dx==0 && dy>0
                  dx=floor((10000/distance2)*cosd(theta2)*ddd2);
                  dy=-floor((10000/distance2)*sind(theta2)*ddd2);
            end

            if distance2<=sum_of_r && dx>0 && dy==0
                  dx=floor((10000/distance2)*cosd(theta2)*ddd2);
                  dy=-floor((10000/distance2)*sind(theta2)*ddd2);
            end

            if distance2<=sum_of_r && dx==0 && dy==0
                 dx=floor((10000/distance2)*cosd(theta2)*ddd2);
                 dy=-floor((10000/distance2)*sind(theta2)*ddd2);
            end
        end

        if x_of_striker2>x_of_puck && y_of_striker2<y_of_puck

            if distance2<=sum_of_r && dx>0 && dy>0
                dx=-floor((10000/distance2)*cosd(theta2)*ddd2);
                dy=floor((10000/distance2)*sind(theta2)*ddd2);
            end

            if distance2<=sum_of_r && dx==0 && dy>0
                  dx=-floor((10000/distance2)*cosd(theta2)*ddd2);
                  dy=floor((10000/distance2)*sind(theta2)*ddd2);
            end

            if distance2<=sum_of_r && dx>0 && dy==0
                  dx=-floor((10000/distance2)*cosd(theta2)*ddd2);
                  dy=floor((10000/distance2)*sind(theta2)*ddd2);
            end

            if distance2<=sum_of_r && dx==0 && dy==0
                 dx=-floor((10000/distance2)*cosd(theta2)*ddd2);
                 dy=floor((10000/distance2)*sind(theta2)*ddd2);
            end
        end

        if x_of_striker2<x_of_puck && y_of_striker2<y_of_puck

            if distance2<=sum_of_r && dx>0 && dy>0
                dx=floor((10000/distance2)*cosd(theta2)*ddd2);
                dy=floor((10000/distance2)*sind(theta2)*ddd2);
            end

            if distance2<=sum_of_r && dx==0 && dy>0
                  dx=floor((10000/distance2)*cosd(theta2)*ddd2);
                  dy=floor((10000/distance2)*sind(theta2)*ddd2);
            end

            if distance2<=sum_of_r && dx>0 && dy==0
                  dx=floor((10000/distance2)*cosd(theta2)*ddd2);
                  dy=floor((10000/distance2)*sind(theta2)*ddd2);
            end

            if distance2<=sum_of_r && dx==0 && dy==0
                 dx=floor((10000/distance2)*cosd(theta2)*ddd2);
                 dy=floor((10000/distance2)*sind(theta2)*ddd2);
            end
        end

        %slowing the speed of the puck with time
        if dx>0
            dx=dx-0.5;
        end

        if dx<0
            dx=dx+0.5;
        end

        if dx==0
            dx=dx*0;
        end

        if dy>0
            dy=dy-0.5;
        end

        if dy<0
            dy=dy+0.5;
        end

        if dy==0
            dy=dx*0;
        end
        
%         bound strikers
        if bwiiscaled>=4000-r_striker-1
            bwiscaled=4000;
        end
        
        if bwiiscaled<=0+r_striker+1
            bwiiscaled=0;
        end
        
        if mouseLoc(1)>=4000-r_striker-1
            mouseLoc(1)=4000;
        end
        
        if mouseLoc(1)<=0+r_striker+1
            mouseLoc(1)=0;
        end
    
        if cwiiscaled<=4000
            cwiiscaled=4000;
        end
        
        if cwiiscaled>=8000-r_striker
            cwiiscaled=0;
        end
        
        if mouseLoc(3)>=4000
            mouseLoc(3)=4000;
        end
        
        if mouseLoc(3)<=0+r_striker
            mouseLoc(3)=0;
        end
                       

        %updating the positions of the puck and striker
        set(striker_1,'Position',[(bwiiscaled)-r_striker cwiiscaled-r_striker 2*r_striker,2*r_striker ]); 
        set(striker_2,'Position',[(mouseLoc(1))-r_striker mouseLoc(3)-r_striker 2*r_striker,2*r_striker ]);
        set(puck,'position',[x-r_puck,y-r_puck,2.*r_puck,2.*r_puck]);
                
        %score title
        
        score_string=num2str(score);
        score_string2=num2str(score2);
        string_time_elapsed=num2str(time_elapsed);
        top_text=char('Time Elapsed: ',string_time_elapsed);
        mytitle=title(top_text,'fontsize', 35,'position',[-5000,2000],'color','b','fontname','Kristen ITC');
        set(mytitle,'HorizontalAlignment','center');
        
        pause(0.0001)
        
        end

disconnectAllWiimotes();