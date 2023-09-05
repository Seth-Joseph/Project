%% ping pong for multiplayer

function multiPlayerPingPong(playerName1,playerName2)
    % figure
    figure('Color', 'black', 'Position', [250,200, 800, 600],'Name','Ping Pong: Multi Player',NumberTitle='off');  % [x, y, width, height]

    % axes to hold the game elements
    ax = axes('Color', 'none', 'Position', [0, 0, 1, 1]);

    % marking boundaries and net
    x = [0.5, 0.5];
    y = [0,1 ];
    set(line(ax, x, y, 'LineStyle', '--', 'Color', [0.5, 0.5, 0.5]),'LineWidth',2);
    set(line(ax, [0, 1], [0.9, 0.9], 'LineStyle', '-', 'Color', [1, 1, 1]),'LineWidth',2);
    set(line(ax, [0, 1], [0.1, 0.1], 'LineStyle', '-', 'Color', [1, 1, 1]),'LineWidth',2);

    set(line(ax, [0.5, 0.5], [0.9, 1], 'LineStyle', '-', 'Color', [0, 0, 0]),'LineWidth',2);
    set(line(ax, [0.5, 0.5], [0, 0.1], 'LineStyle', '-', 'Color', [0, 0, 0]),'LineWidth',2);

    annotation('textbox', [0.5, 0, 0.5, 0.1], 'String','Use ↑ and ↓ keys', 'Color', 'white', 'LineStyle', 'none', 'FontSize', 14, 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle','FontName','Consolas');
    annotation('textbox', [0, 0, 0.5, 0.1], 'String','Use W and S keys', 'Color', 'white', 'LineStyle', 'none', 'FontSize', 14, 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle','FontName','Consolas');


    % Define the size of the paddles
    paddleWidth = 0.02;
    paddleHeight = 0.1;

    % Create paddles using rectangles
    player1Paddle = rectangle(ax, 'Position', [0, 0.45, paddleWidth, paddleHeight], 'EdgeColor', 'white', 'FaceColor', 'white');
    player2Paddle = rectangle(ax, 'Position', [1-paddleWidth, 0.45, paddleWidth, paddleHeight], 'EdgeColor', 'white', 'FaceColor', 'white');

    % Initialize scores
    player1Score = 0;
    player2Score = 0;
    
    % Create score labels using annotations
    scoreLabel1 = annotation('textbox', [0.4, 0.9, 0.1, 0.05], 'String', sprintf('%d', player1Score), 'Color', 'white', 'LineStyle', 'none','FontSize', 16,'FontName','Consolas');
    scoreLabel2 = annotation('textbox', [0.6, 0.9, 0.1, 0.05], 'String', sprintf('%d', player2Score), 'Color', 'white', 'LineStyle', 'none','fontsize',16,'FontName','Consolas');

    

    % Define the size of the ball
    ballSize = 0.01;

    % Initialize arrow key states
    upArrowPressed = false;
    downArrowPressed = false;
    wKeyPressed = false;
    sKeyPressed = false;

    % Set up keyboard event handler
    set(gcf, 'KeyPressFcn', @keyDown, 'KeyReleaseFcn', @keyUp);

    % Initialize ball position and velocity
    ballPosition = [0.1, 0.4, 0.01, 0.01];  % [x, y, width, height]
    ballVelocity = [0.01, 0.01];
    ball = annotation('rectangle', ballPosition, 'Color', 'white',FaceColor='white');

    % Create a game loop using a loop structure
    while true
        % Update ball position
        ballPosition = ballPosition + [ballVelocity(1), ballVelocity(2), 0, 0];

        % Check for collision with the edges
        if ballPosition(1) <= 0 
            ballVelocity(1) = -ballVelocity(1);  % Reverse x-velocity
            player2Score = player2Score + 1;
            set(scoreLabel2, 'String', sprintf('%d', player2Score));
        elseif ballPosition(1) + ballPosition(3) >= 1
            ballVelocity(1) = -ballVelocity(1);  % Reverse x-velocity
            player1Score = player1Score + 1;
            set(scoreLabel1, 'String', sprintf('%d', player1Score));
        end
        
        if ballPosition(2) <= 0.1 || ballPosition(2) + ballPosition(4) >= 0.9   
            ballVelocity(2) = -ballVelocity(2);  % Reverse y-velocity
        end
        
        
        % Check for collision with paddles
        if checkCollision(player1Paddle, ballPosition, ballSize) || ...
           checkCollision(player2Paddle, ballPosition, ballSize)
            ballVelocity(1) = -ballVelocity(1);  % Reverse x-velocity
        end

        % Update ball position in the figure
        set(ball, 'Position', ballPosition);

        % Update player1 paddle position based on w,s key states
        if wKeyPressed 
            player1PaddlePosition = get(player1Paddle, 'Position');
            player1PaddlePosition(2) = player1PaddlePosition(2) + 0.01;
            set(player1Paddle, 'Position', player1PaddlePosition);
        elseif sKeyPressed
            player1PaddlePosition = get(player1Paddle, 'Position');
            player1PaddlePosition(2) = player1PaddlePosition(2) - 0.01;
            set(player1Paddle, 'Position', player1PaddlePosition);
        end
        
        % Update player2 paddle position based on arrow key states
        if downArrowPressed 
            player2PaddlePosition = get(player2Paddle, 'Position');
            player2PaddlePosition(2) = player2PaddlePosition(2) - 0.01;
            set(player2Paddle, 'Position', player2PaddlePosition);
        elseif upArrowPressed
            player2PaddlePosition = get(player2Paddle, 'Position');
            player2PaddlePosition(2) = player2PaddlePosition(2) + 0.01;
            set(player2Paddle, 'Position', player2PaddlePosition);
        end

        % Check for game over condition
        if player1Score >= 5
            annotation('textbox', [0.35, 0.4, 0.3, 0.2], 'String', {'Game Over'; playerName1 ;'wins'}, 'Color', 'red', 'EdgeColor', 'none', 'FontSize', 24, 'FontWeight', 'bold', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle');
            break;  % Exit the game loop
        elseif player2Score >= 5
            annotation('textbox', [0.35, 0.4, 0.3, 0.2], 'String', {'Game Over'; playerName2;' wins'}, 'Color', 'red', 'EdgeColor', 'none', 'FontSize', 24, 'FontWeight', 'bold', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle');
            break;  % Exit the game loop
        end
        
        % Pause for a short interval to control frame rate
        pause(0.1);
    end

    % Callback function for key press
    function keyDown(~, event)
        switch event.Key
            case 'uparrow'
                upArrowPressed = true;
            case 'downarrow'
                downArrowPressed = true;
            case 'w'
                wKeyPressed = true;
            case 's'
                sKeyPressed = true;
        end
    end

    % Callback function for key release
    function keyUp(~, event)
        switch event.Key
            case 'uparrow'
                upArrowPressed = false;
            case 'downarrow'
                downArrowPressed = false;
            case 'w'
                wKeyPressed = false;
            case 's'
                sKeyPressed = false;
        end
    end

    % Function to check collision between ball and paddle
    function collision = checkCollision(paddle, ballPosition, ballSize)
        paddlePosition = get(paddle, 'Position');
        collision = ballPosition(1) + ballSize >= paddlePosition(1) && ...
                    ballPosition(1) <= paddlePosition(1) + paddleWidth && ...
                    ballPosition(2) + ballSize >= paddlePosition(2) && ...
                    ballPosition(2) <= paddlePosition(2) + paddleHeight;
    end
end


