clc
clear

maximum_num_points = 10000;
last_time_stamp=0;
start_flag=0;
record=[];

% 创建 TCP/IP 对象
client = tcpclient('192.168.1.106', 30013,'TimeOut',3);
client.ByteOrder = "big-endian";
display_type=1;   %1:force 2：tcp pos 3:joint 4:I
time_start=0;
while(1)
%     tic;
    % 退出
    if strcmpi(get(gcf,'CurrentCharacter'), 'q')
%         keyboard
        break;
    end
    % 暂停
    if strcmpi(get(gcf,'CurrentCharacter'), 'p')
        pause(1)
        continue;
    end
    %清理数据
    if strcmpi(get(gcf,'CurrentCharacter'), 'c')
        for i=1:6
            clearpoints(line11(i))
            clearpoints(line111(i))
            clearpoints(line12(i))
            clearpoints(line13(i))
        end
    end
    
    while(1)
        if  client.BytesAvailable > 0
%             client.BytesAvailable
            num_bytes=client.NumBytesAvailable;
            row = floor(num_bytes/1220);
            data = zeros(row,152);
            lenght = zeros(row,1);
            for i=1:row
                lenght(i) = read(client,1,'uint32');
                data(i,:) = read(client,152,'double');
            end
            break;
        end
    end
    pause(0.001)
%     flush(client)    
    time_stamp=data(:,1);
    if time_start==0
        time_start=time_stamp(1);
    end
    time_stamp=time_stamp-time_start;
    q_target=rad2deg(data(:,2:7));
    qd_target=rad2deg(data(:,8:13));
    qdd_target=rad2deg(data(:,14:19));
    q_actual=rad2deg(data(:,32:37));
    qd_actual=rad2deg(data(:,38:43));

    M_target=rad2deg(data(:,26:31));


    tcp_target_pos=[];
    tcp_target_pos(:,1:3)=1000*(data(:,74:76));
    tcp_target_pos(:,4:6)=rad2deg((data(:,77:79)));
    tcp_actual_pos=[];
    tcp_actual_pos(:,1:3)=1000*(data(:,56:58));
    tcp_actual_pos(:,4:6)=rad2deg((data(:,59:61)));
    tcp_target_speed=1000*(data(:,80:85));
    tcp_actual_speed=1000*(data(:,62:67));
    
    I_target=data(:,20:25);
    I_actual=data(:,44:49);
    I_control=data(:,50:55);
    
    tcp_force=data(:,68:73);

    Accelerometer=data(:,109:111);
    
    DI=data(:,86);

    if DI==132
        record=[record; time_stamp,tcp_target_pos,tcp_actual_speed,tcp_force];
    end
    %%
    if start_flag==0
        start_flag=1;
        switch display_type
            case 1
                %% Force
                figure(1)
                clf
                tiledlayout(3,2,'TileSpacing', 'compact','Padding', 'compact')

                for i=1:6
                    ax1(i) = nexttile;
                    grid on
                    yyaxis left
                    line11(i) = animatedline('Color', '#0072BD','MaximumNumPoints',maximum_num_points);
                    line111(i) = animatedline('Color', '#000000','MaximumNumPoints',maximum_num_points);
                    if i<4
                      axis([-inf,+inf,-20,20])
                    else
                      axis([-inf,+inf,-2,2])
                    end
                      
                    yyaxis right
%                     line12(i) = animatedline('Color', '#D95319','MaximumNumPoints',maximum_num_points);
                    line13(i) = animatedline('Color', '#7E2F8E','MaximumNumPoints',maximum_num_points);
                    axis([-inf,+inf,-210,210])
                end
                sgtitle('力-速度')
                legend('力','速度','location','SouthWest')
            case 2
              %% TCP 
                figure(2)
                clf
                tiledlayout(3,2,'TileSpacing', 'compact','Padding', 'compact')

                for i=1:6
                    ax1(i) = nexttile;
                    grid on
                    line21(i) = animatedline('Color', '#0072BD','MaximumNumPoints',maximum_num_points);
                    line22(i) = animatedline('Color', '#D95319','MaximumNumPoints',maximum_num_points);
                end
                sgtitle('TCP位置（mm & deg - s)')
                legend('反馈','指令','location','SouthWest')
        
            case 3
                %% q 
                figure(3)
                clf
                tiledlayout(3,2,'TileSpacing', 'compact','Padding', 'compact')

                for i=1:6
                    ax1(i) = nexttile;
                    grid on
                    line31(i) = animatedline('Color', '#0072BD','MaximumNumPoints',maximum_num_points);
                    line32(i) = animatedline('Color', '#D95319','MaximumNumPoints',maximum_num_points);
                end
                 sgtitle('轴位置（deg - s）')
                legend('反馈','指令','location','SouthWest')
            case 4
                %% I
                figure(4)
                clf
                tiledlayout(3,2,'TileSpacing', 'compact','Padding', 'compact')

                for i=1:6
                    ax1(i) = nexttile;
                    grid on
                    line41(i) = animatedline('Color', '#0072BD','MaximumNumPoints',maximum_num_points);
                    line42(i) = animatedline('Color', '#D95319','MaximumNumPoints',maximum_num_points);
                end
                 sgtitle('电流')
                legend('反馈','指令','location','SouthWest')
            case 5
                %% tcp norm s-v
                figure(5)
                clf
                tiledlayout(3,1,'TileSpacing', 'compact','Padding', 'compact')

                for i=1:3
                    ax1(i) = nexttile;
                    grid on
                    line51(i) = animatedline('Color', '#0072BD','MaximumNumPoints',maximum_num_points);
                    line52(i) = animatedline('Color', '#D95319','MaximumNumPoints',maximum_num_points);
                end
                 sgtitle('位移、速度')
                legend('反馈','指令','location','SouthWest')
            case 6
                %% q qd qdd
                figure(4)
                clf
                tiledlayout(3,2,'TileSpacing', 'compact','Padding', 'compact')

                for i=1:6
                    ax1(i) = nexttile;
                    grid on
                    line41(i) = animatedline('Color', '#0072BD','MaximumNumPoints',maximum_num_points);
                    line42(i) = animatedline('Color', '#D95319','MaximumNumPoints',maximum_num_points);
                end
                 sgtitle('电流')
                legend('反馈','指令','location','SouthWest')
        end
    end
    %%
    switch display_type
        %% Force & Speed
        case 1
            for i=1:6
                addpoints(line11(i), time_stamp, tcp_force(:,i))
                addpoints(line111(i), time_stamp, DI)
%                 addpoints(line12(i), time_stamp, tcp_actual_speed(:,i))
                addpoints(line13(i), time_stamp, tcp_target_speed(:,i))
            end
        %% TCP
        case 2
            for i=1:6
                addpoints(line21(i), time_stamp,tcp_actual_pos(:,i))
                addpoints(line22(i), time_stamp,tcp_target_pos(:,i))
            end
        %% TCP
        case 3
            for i=1:6
                addpoints(line31(i), time_stamp,q_actual(:,i))
                addpoints(line32(i), time_stamp,q_target(:,i))
            end
        %% I
        case 4
            for i=1:6
                addpoints(line41(i), time_stamp,I_actual(:,i))
                addpoints(line42(i), time_stamp,I_target(:,i))
            end
        %% tcp norm s-v
        case 5
            tcp_target_pos_norm = sqrt(tcp_target_pos(:,1).^2+tcp_target_pos(:,2).^2+tcp_target_pos(:,3).^2);
            tcp_actual_pos_norm = sqrt(tcp_actual_pos(:,1).^2+tcp_actual_pos(:,2).^2+tcp_actual_pos(:,3).^2);
            addpoints(line51(1), time_stamp,tcp_actual_pos_norm)
            addpoints(line52(1), time_stamp,tcp_target_pos_norm)
            
            tcp_target_speed_norm = sqrt(tcp_target_speed(:,1).^2+tcp_target_speed(:,2).^2+tcp_target_speed(:,3).^2);
            tcp_actual_speed_norm = sqrt(tcp_actual_speed(:,1).^2+tcp_actual_speed(:,2).^2+tcp_actual_speed(:,3).^2);
            addpoints(line51(2), time_stamp,tcp_actual_speed_norm)
            addpoints(line52(2), time_stamp,tcp_target_speed_norm)
            
    end
 


    
    %%
%     dt=time_stamp -last_time_stamp;
    last_time_stamp = time_stamp(end);

    drawnow
 end

