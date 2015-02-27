local composer = require("composer")
local scene = composer.newScene()

local myTimer
local loadingImage



-- "scene:create()"
function scene:create( event )
    local sceneGroup = self.view
    composer.removeScene("menu")
    
    
    -- Initialize the scene here.
    -- Example: add display objects to "sceneGroup", add touch listeners, etc.
end


-- "scene:show()"
function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase
    

    if ( phase == "will" ) then
        
        muteUnmuteText.isVisible = false
        --display loading image
        loadingImage = display.newImage( "images/loading.png", 160, 240 )
        sceneGroup:insert( loadingImage )
        --create timer that transitions from loading page to playgame page
        local goToPlaygame = function()
		composer.gotoScene( "playgame", "fade", 500 )
                
	end
	myTimer = timer.performWithDelay( 1000, goToPlaygame, 1 )
        
        
        
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
        
        if myTimer then timer.cancel( myTimer ); end	
	print( "loadmainmenu: exitScene event" )
        
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



