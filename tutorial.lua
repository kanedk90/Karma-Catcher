local composer = require("composer")
local scene = composer.newScene()
local widget = require ("widget")

local backButton


-- "scene:create()"
function scene:create( event )
    local sceneGroup = self.view
    -- Initialize the scene here.
    -- Example: add display objects to "sceneGroup", add touch listeners, etc.
end


-- "scene:show()"
function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        
        --display snoo and explain instruction how to move snoo
        local snoo = display.newImage("images/snoo.png", 70, 40)
        sceneGroup:insert(snoo)
        
        local snooText = [[Tap the left and right sides of the screen to move the snoo]]
        
        local options = {
            text = snooText,
            x = 220, 
            y = 250,
            fontSize = 20,
            width= 200,
            height = 500,
            font = "PixelSix00",
            align = "center"
        }
        
        local snooTextField = display.newText( options )
        sceneGroup:insert(snooTextField)
        
        --display upvote arrow and explain there worth 500 when caught
        local upvote = display.newImage("images/upvote.png", 70, 180)
        sceneGroup:insert(upvote)
        
        local upvoteText = [[Catch the upvotes (500 points)]]
        
        local options = {
            text = upvoteText,
            x = 220, 
            y = 390,
            fontSize = 20,
            width= 155,
            height = 500,
            font = "PixelSix00",
            align = "center"
        }
        
        local upvoteTextField = display.newText( options )
        sceneGroup:insert(upvoteTextField)
        
        --display gold image and explain there worth 1000 when caught
        local gold = display.newImage("images/gold.png", 70, 290)
        sceneGroup:insert(gold)
        
        local goldText = [[Catch the gold (1000 points)]]
        
        local options = {
            text = goldText,
            x = 220, 
            y = 510,
            fontSize = 20,
            width= 155,
            height = 500,
            font = "PixelSix00",
            align = "center"
        }
        
        local goldTextField = display.newText( options )
        sceneGroup:insert(goldTextField)
        
        --display downvote arrow and explain player loses 1 life when caught
        local downvote = display.newImage("images/downvote.png", 70, 390)
        sceneGroup:insert(downvote)
        
        local downvoteText = [[Avoid the downvotes (-1 life)]]
        
        local options = {
            text = downvoteText,
            x = 220, 
            y = 600,
            fontSize = 20,
            width= 155,
            height = 500,
            font = "PixelSix00",
            align = "center"
        }
        
        local downvoteTextField = display.newText( options )
        sceneGroup:insert(downvoteTextField)
        
        
        
        
       
        
        local function handleButtonEvent( event )
            if ( "ended" == event.phase ) then
                composer.gotoScene(event.target.goto, {effect = "fade"})
            end
        end
    
    --create back button to return to menu page
    local backButton = widget.newButton
    {
        width = 83,
        height = 51,
        defaultFile = "images/Bunpressed.png",
        overFile = "images/Bpressed.png",
        onEvent = handleButtonEvent
    }
    -- Position the button
    backButton.x = 50
    backButton.y = 470
    backButton.goto = "menu"
    sceneGroup:insert(backButton)
        -- Called when the scene is still off screen (but is about to come on screen).
    elseif ( phase == "did" ) then
        -- Called when the scene is now on screen.
        -- Insert code here to make the scene come alive.
        -- Example: start timers, begin animation, play audio, etc.
    end
end


-- "scene:hide()"
function scene:hide( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Called when the scene is on screen (but is about to go off screen).
        -- Insert code here to "pause" the scene.
        -- Example: stop timers, stop animation, stop audio, etc.
    elseif ( phase == "did" ) then
        -- Called immediately after scene goes off screen.
    end
end


-- "scene:destroy()"
function scene:destroy( event )

    local sceneGroup = self.view

    -- Called prior to the removal of scene's view ("sceneGroup").
    -- Insert code here to clean up the scene.
    -- Example: remove display objects, save state, etc.
end


-- -------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-- -------------------------------------------------------------------------------

return scene



