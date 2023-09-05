%% Adding ball and paddles to the game

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
ball = annotation('rectangle', ballPosition, 'Color', 'white',FaceColor='white');
