local composer = require("composer")
local scene = composer.newScene()
local widget = require ("widget")

local me
local backButton


-- "scene:create()"
function scene:create( event )
    local sceneGroup = self.view
    
    local function handleButtonEvent( event )
        if ( "ended" == event.phase ) then
            composer.gotoScene(event.target.goto, {effect = "fade"})
        end
    end
    
     --detail game credits
     local meText = [[This app was made by David Kane, a software design student, for his final year project.]]
        
        local options = {
            text = meText,
            x = 160, 
            y = 255,
            fontSize = 25,
            width= 250,
            height = 500,
            font = "PixelSix00",
            align = "center"
        }
        
        local meTextField = display.newText( options )
        sceneGroup:insert(meTextField)
    
    --8bit me
    me = display.newImage("images/me.png", 160, 310)
    sceneGroup:insert(me)
    
    --create back button to return to menu page
    backButton = widget.newButton
    {
        width = 83,
        height = 51,
        defaultFile = "images/Bunpressed.png",
        overFile = "images/Bpressed.png",
        onEvent = handleButtonEvent
    }
    -- position the button
    backButton.x = 50
    backButton.y = 470
    backButton.goto = "menu"
    sceneGroup:insert(backButton)
    

    -- Initialize the scene here.
    -- Example: add display objects to "sceneGroup", add touch listeners, etc.
end


-- "scene:show()"
function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
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

