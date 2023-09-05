%% Creating a main menu for the game so that we can select single player or multiplayer game mode.
function mainMenu()
    % window with black background
    fig = figure('Color', 'black', 'Position', [250, 200, 800, 600], 'Name', 'Ping Pong: Options', NumberTitle='off');
    
    % title
    annotation('textbox', [0.25, 0.7, 0.5, 0.2], 'String', 'Game Options', 'Color', 'white', 'LineStyle', 'none', 'FontSize', 24, 'FontWeight', 'bold', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle','FontName','Brush Script MT');

    % game options
    singlePlayerOption = annotation('textbox', [0.4, 0.5, 0.2, 0.1], 'String', 'Single Player', 'Color', 'white', 'LineStyle', 'none', 'FontSize', 20, 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle','FontName','Consolas');
    multiPlayerOption = annotation('textbox', [0.4, 0.3, 0.2, 0.1], 'String', 'Multi Player', 'Color', 'white', 'LineStyle', 'none', 'FontSize', 20, 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle','FontName','Consolas');
    
    % button click interaction 
    singlePlayerOption.ButtonDownFcn = @startSinglePlayer;
    multiPlayerOption.ButtonDownFcn = @startMultiplayer;

    % Callback function to start single player game
    function startSinglePlayer(~, ~)
        close(fig);  
    end
    
    % Callback function to start multiplayer game
    function startMultiplayer(~, ~)
        prompt = {'Enter name of player 1:','Enter name of player 2:'};
        dlgtitle = 'Ping Pong: Multi Player';
        definput = {'Player 1','Player 2'};
        dims = [1 50];
        playerName = inputdlg(prompt,dlgtitle,dims,definput);
        
        if ~isempty(playerName)
            playerName1 = playerName{1};  % extracting the name
            playerName2 = playerName{2};  % extracting the name
            
            close(fig);
        end
    end
end