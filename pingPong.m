function pingPong()
    % Create a black background figure with fixed size for game options
    fig = figure('Color', 'black', 'Position', [250, 200, 800, 600], 'Name', 'Ping Pong: Options', NumberTitle='off');
    
    % Create options title using annotation
    annotation('textbox', [0.25, 0.7, 0.5, 0.2], 'String', 'Game Options', 'Color', 'white', 'LineStyle', 'none', 'FontSize', 24, 'FontWeight', 'bold', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle','FontName','Brush Script MT');

    % Create options using annotation
    singlePlayerOption = annotation('textbox', [0.4, 0.5, 0.2, 0.1], 'String', 'Single Player', 'Color', 'white', 'LineStyle', 'none', 'FontSize', 20, 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle','FontName','Consolas');
    multiPlayerOption = annotation('textbox', [0.4, 0.3, 0.2, 0.1], 'String', 'Multi Player', 'Color', 'white', 'LineStyle', 'none', 'FontSize', 20, 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle','FontName','Consolas');
    
    % Set up callback function for single player option
    singlePlayerOption.ButtonDownFcn = @startSinglePlayer;
    
    % Callback function to start single player game
    function startSinglePlayer(~, ~)
        close(fig);  % Close the game options figure
        singlePlayerPingPong();
    end
    
    % Set up callback function for multiplayer option
    multiPlayerOption.ButtonDownFcn = @startMultiplayer;
    
    % Callback function to start multiplayer game
    function startMultiplayer(~, ~)
        prompt = {'Enter name of player 1:','Enter name of player 2:'};
        dlgtitle = 'Ping Pong: Multi Player';
        definput = {'Player 1','Player 2'};
        dims = [1 50];
        playerName = inputdlg(prompt,dlgtitle,dims,definput);
        
        if ~isempty(playerName)
            playerName1 = playerName{1};  % Extract the entered name from the cell array
            playerName2 = playerName{2};  % Extract the entered name from the cell array
            
            close(fig);  % Close the game options figure
            multiPlayerPingPong(playerName1, playerName2);  % Start multiplayer game with the player's names
        end
    end
end

function singlePlayerPingPong()
    % Create a black background figure with fixed size
    figure('Color', 'black', 'Position', [250, 200, 800, 600],'Name','Ping Pong: Single Player',NumberTitle='off');  % [x, y, width, height]

    % Create an axes to hold the game elements
    ax = axes('Color', 'none', 'Position', [0, 0, 1, 1]);

    % Create dashed line through the center using the plot function
    x = [0.5, 0.5];
    y = [0,1 ];
    set(line(ax, x, y, 'LineStyle', '--', 'Color', [0.5, 0.5, 0.5]),'LineWidth',2);
    set(line(ax, [0, 1], [0.9, 0.9], 'LineStyle', '-', 'Color', [1, 1, 1]),'LineWidth',2);
    set(line(ax, [0, 1], [0.1, 0.1], 'LineStyle', '-', 'Color', [1, 1, 1]),'LineWidth',2);

    set(line(ax, [0.5, 0.5], [0.9, 1], 'LineStyle', '-', 'Color', [0, 0, 0]),'LineWidth',2);
    set(line(ax, [0.5, 0.5], [0, 0.1], 'LineStyle', '-', 'Color', [0, 0, 0]),'LineWidth',2);
    
    % instructions
    annotation('textbox', [0.25, 0, 0.5, 0.1], 'String','Use ↑ and ↓ to control your paddle', 'Color', 'white', 'LineStyle', 'none', 'FontSize', 14, 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle','FontName','Consolas');

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

    % Set up keyboard event handler
    set(gcf, 'KeyPressFcn', @keyDown, 'KeyReleaseFcn', @keyUp);

    % Initialize ball position and velocity
    ballPosition = [0.1, 0.4, 0.01, 0.01];  % [x, y, width, height]
    initialBallVelocity = [0.01, 0.01];
    ballVelocity = initialBallVelocity;
    ball = annotation('rectangle', ballPosition, 'Color', 'white',FaceColor='white');

    % Create a game loop using while loop
    while true
        % Update ball position
        ballPosition = ballPosition + [ballVelocity(1), ballVelocity(2), 0, 0];

        % Update player1 paddle position based on ball's y-coordinate
        player1PaddlePosition = [0, ballPosition(2) - paddleHeight/2, paddleWidth, paddleHeight];
        set(player1Paddle, 'Position', player1PaddlePosition);


        % Check for collision with the edges
        if ballPosition(1) <= 0 
            player2Score = player2Score + 1;
            set(scoreLabel2, 'String', sprintf('%d', player2Score));
            ballPosition = [0.1, 0.4, 0.01, 0.01];  % Reset ball position
            ballVelocity = initialBallVelocity;  % Reset ball velocity
        elseif ballPosition(1) + ballPosition(3) >= 1
            player1Score = player1Score + 1;
            set(scoreLabel1, 'String', sprintf('%d', player1Score));
            ballPosition = [0.1, 0.4, 0.01, 0.01];  % Reset ball position
            ballVelocity = initialBallVelocity;  % Reset ball velocity
        end
        
        if ballPosition(2) <= 0.1 || ballPosition(2) + ballPosition(4) >= 0.9   

            ballVelocity(2) = -ballVelocity(2);  % Reverse y-velocity

        end
        
        % Check for collision with paddles
        if checkCollision(player1Paddle, ballPosition, ballSize) || ...
            checkCollision(player2Paddle, ballPosition, ballSize)
            ballVelocity(1) = -ballVelocity(1);  % Reverse x-velocity
            ballVelocity = ballVelocity * (1 + rand() * 0.5);  % Increase velocity with random factor
            fprintf('Speed increased\n')

        end

        % Update ball position in the figure
        set(ball, 'Position', ballPosition);
        
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
            % Create the "Game Over" text
            annotation('textbox', [0.35, 0.4, 0.3, 0.2], 'String', {'Game Over'; 'Player 1 wins'}, 'Color', 'red', 'EdgeColor', 'none', 'FontSize', 24, 'FontWeight', 'bold', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle');
            break;  % Exit the game loop
        elseif player2Score >= 5
            annotation('textbox', [0.35, 0.4, 0.3, 0.2], 'String', {'Game Over'; 'Player 2 wins'}, 'Color', 'red', 'EdgeColor', 'none', 'FontSize', 24, 'FontWeight', 'bold', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle');
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
        end
    end

    % Callback function for key release
    function keyUp(~, event)
        switch event.Key
            case 'uparrow'
                upArrowPressed = false;
            case 'downarrow'
                downArrowPressed = false;
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

function multiPlayerPingPong(playerName1,playerName2)
    % Create a black background figure with fixed size
    figure('Color', 'black', 'Position', [250, 200, 800, 600],'Name','Ping Pong: Multi Player',NumberTitle='off');  % [x, y, width, height]

    % Create an axes to hold the game elements
    ax = axes('Color', 'none', 'Position', [0, 0, 1, 1]);

    % Create dashed line around the game area

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