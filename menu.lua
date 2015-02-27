
--Include the external modules in the game
local composer = require("composer")
local scene = composer.newScene()
local widget = require ("widget")

local title
local startButton
local tutorialButton
local creditsButton

-- "scene:create()"
function scene:create( event )
    

    local sceneGroup = self.view
    --composer.removeScene("playgame")
    composer.removeScene("gamecredits")
    composer.removeScene("options")
    
    
    
   
    -- Initialize the scene here.
    -- Example: add display objects to "sceneGroup", add touch listeners, etc.
end


-- "scene:show()"
function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        
    local function handleButtonEvent( event )
        if ( "ended" == event.phase ) then
            composer.gotoScene(event.target.goto, {effect = "fade"})
        end
    end
    
    
    
    --insert "karma catcher" title
    title = display.newImage("images/title.png", 160, 60)
    sceneGroup:insert(title)
    
   
   --created start button widget
   startButton = widget.newButton
    {
        width = 250,
        height = 70,
        defaultFile = "images/Sunpressed.png",
        overFile = "images/Spressed.png",
        onEvent = handleButtonEvent
    }
    -- Center the button
    startButton.x = 160
    startButton.y = 200
    startButton.goto = "loadplaygame"
    sceneGroup:insert(startButton)
    
    --create the tutorial budget widget
    tutorialButton = widget.newButton
    {
        width = 250,
        height = 70,
        defaultFile = "images/Tunpressed.png",
        overFile = "images/Tpressed.png",
        onEvent = handleButtonEvent
    }
    -- Center the button
    tutorialButton.x = 160
    tutorialButton.y = 310
    tutorialButton.goto = "tutorial"
    sceneGroup:insert(tutorialButton)
    
    --create credits button
    creditsButton = widget.newButton
    {
        width = 250,
        height = 70,
        defaultFile = "images/Cunpressed.png",
        overFile = "images/Cpressed.png",
        onEvent = handleButtonEvent
    }
    -- Center the button
    creditsButton.x = 160
    creditsButton.y = 420
    creditsButton.goto = "gamecredits"
    sceneGroup:insert(creditsButton)
    
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


