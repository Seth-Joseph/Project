%% Adding collision of the ball with edges and paddles

function collision()
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
        end

        % Update ball position in the figure
        set(ball, 'Position', ballPosition);
    
        % Pause for a short interval to control frame rate
        pause(0.1);
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
