local composer = require("composer")
local scene = composer.newScene()
local widget = require("widget")

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
        
        local function handleResumeButtonEvent( event )

        if ( "ended" == event.phase ) then
            composer.hideOverlay("fade", 400)
        end
    end
    
    
    local pauseGame = display.newImage("images/gamepause.png", 160, 240)
    pauseGame:scale(1.5,1.5)
    sceneGroup:insert(pauseGame)
    
    local resumeButton = widget.newButton
    {
       
        defaultFile = "images/RESunpressed.png",
        overFile = "images/RESpressed.png",
        onEvent = handleResumeButtonEvent
    }
    -- Center the button
    resumeButton.x = 160
    resumeButton.y = 335
    resumeButton.goto = "playgame"
    sceneGroup:insert(resumeButton)
        

    
        
        
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
    local parent = event.parent

    if ( phase == "will" ) then
        
        
    
     
        
        
        parent.resumeGame()
       
        
        -- Called when the scene is on screen (but is about to go off screen).
        -- Insert code here to "pause" the scene.
        -- Example: stop timers, stop animation, stop audio, etc.
    elseif ( phase == "did" ) then

        -- Called immediately after scene goes off screen.
    end
end


-- "scene:destroy()"
function scene:destroy( event )

    

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

