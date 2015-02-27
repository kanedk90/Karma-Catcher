local composer = require("composer")
local scene = composer.newScene()
composer.recycleOnSceneChange = true
local widget = require ("widget")
local physics = require("physics")
local physicsData = (require "shapedefs").physicsData(1.0)
physics.start()
--physics.setDrawMode( "hybrid" )


--Add in the display objects
local snoo
local upvote
local downvote
local gold
local scoreText
local livesText
local left
local right
local pauseBtn
local pausedBG
--local muteUnmuteText
local gameOverScreen
local shade
local background
local ground

--Add in the variables
local gameIsActive = false
local startUpvoteDrop
local startDownvoteDrop
local startGoldDrop
local gameLives = 3
local gameScore = 0
--local highScoreText
--highScore = 0
local motionx = 0
speed = 6

--declare shapes if physical objects
local downvoteShape = {   12, 9.5  ,  7, 6.5  ,  15, 6.5  ,  15, 9.5  }
local snooShape = {   12, -46.5  ,  8, -42.5  ,  7, -42.5  ,  7, -47.5  }
local upvoteShape = {   12, -13.5  ,  9, -16.5  ,  12, -16.5  }
local goldRadius = 14.000

--declare collision filter
local snooCollisionFilter = {categoryBits = 1, maskBits = 14}
local downvoteCollisionFilter = {categoryBits = 4, maskBits = 1}
local upvoteCollisionFilter = {categoryBits = 2, maskBits = 1}
local goldCollisionFilter = {categoryBits = 8, maskBits = 1}

--load music
local backgroundMusicChannel
local gameoverMusicChannel
local upvoteMusicChannel
local downvoteMusicChannel
local goldMusicChannel
local goldMusic = audio.loadSound("media/gold00.wav")
local downvoteMusic = audio.loadSound("media/downvote00.wav")
local upvoteMusic = audio.loadSound("media/upvote00.wav")
local backgroundMusic = audio.loadSound( "media/Theme.wav" )
local gameoverMusic = audio.loadSound("media/Gameover_04.wav")


--save the players highscore
local saveValue = function( strFilename, strValue )
	local theFile = strFilename
	local theValue = strValue
	
	local path = system.pathForFile( theFile, system.DocumentsDirectory )

	local file = io.open( path, "w+" )
	if file then
	   file:write( theValue )
	   io.close( file )
	end
end

--load players highscore
local loadValue = function( strFilename )
	
	local theFile = strFilename
	local path = system.pathForFile( theFile, system.DocumentsDirectory )
	
	local file = io.open( path, "r" )
	if file then
	   local contents = file:read( "*a" )
	   io.close( file )
	   return contents
	else
	   file = io.open( path, "w" )
	   file:write( "0" )
	   io.close( file )
	   return "0"
	end
end


-- "scene:create()"
function scene:create( event )
    local sceneGroup = self.view
    
    --composer.removeScene("loadplaygame") 
    
    
end


-- "scene:show()"
function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        
        local gameActivate = function()
        gameIsActive = true
    end
    
    --Character movement function
    local  moveguy = function (event)
       
        snoo.x   = (snoo.x or 0)  + motionx;
         

            --add boundaries to character movement to stop it moving off screen
            if((snoo.x - (snoo.width or 1) * 0.5) < 0) then
                snoo.x = (snoo.width or 1) * 0.5
                elseif((snoo.x + (snoo.width or 1) * 0.5) > display.contentWidth) then
                snoo.x = display.contentWidth - (snoo.width or 1) * 0.5
            end
    end

            --create circle on left when tapped moves snoo right
            left = display.newCircle(20, 375, 90)
            left.alpha = 0.01
            sceneGroup:insert(left)

            --create circle on right when tapped moves snoo right
            right = display.newCircle(300, 375, 90)
            right.alpha = 0.01
            sceneGroup:insert(right)

            function left:touch()
            motionx = -speed;
            end
            left:addEventListener("touch",left)

            function right:touch()
            motionx = speed;
            end
            right:addEventListener("touch",right)

        -- Stop character movement when no arrow is pushed
        local function stop (event)
            if event.phase =="ended" then
            motionx = 0;
            end
        end
        
        -- Create the scoring function
        local setScore = function(scoreNum)
            local newScore = scoreNum
            gameScore = newScore
            if gameScore < 0 then gameScore = 0 end

            scoreText.text = "Score: "..gameScore
            scoreText.x = 93
            scoreText.y = 2
        end
        
        --create gameover function (called when lives are < 1)
        local callGameOver = function()
            gameIsActive = false
            left:removeEventListener("touch", left)
            right:removeEventListener("touch", right)
            physics.pause()
            audio.stop( backgroundMusicChannel )
            pauseBtn.isVisible = false
            muteUnmuteText.isVisible = false
            shade = display.newRect(0, 0, 320, 570)
            shade:setFillColor(0, 0, 0, 255)
            shade.x = 160
            shade.y = 240
            shade.alpha = 0
            gameOverScreen = display.newImage("images/gameover2.png", 165,235)
            gameOverScreen:scale(1.5, 1.5)
            local newScore = gameScore
            setScore(newScore)
            gameOverScreen.alpha = 0
            sceneGroup:insert(shade)
            sceneGroup:insert(gameOverScreen)
            local function handleButtonEvent( event )
                if ( "ended" == event.phase ) then
                    composer.gotoScene(event.target.goto, {effect = "fade"})
                end
                
            end
            
            --create button that takes user back to the menu page
             local menuButton = widget.newButton
            {
                defaultFile = "images/Munpressed.png",
                overFile = "images/Mpressed.png",
                onEvent = handleButtonEvent
            }
            -- position the button
            menuButton.x = 235
            menuButton.y = 425
            menuButton.goto = "menu"
            sceneGroup:insert(menuButton)
    
            --create button that restarts the game
            local restartButton = widget.newButton
            {
                defaultFile = "images/Runpressed.png",
                overFile = "images/Rpressed.png",
                onEvent = handleButtonEvent
            }
            -- position the button
            restartButton.x = 95
            restartButton.y = 425
            restartButton.goto = "loadplaygame"
            sceneGroup:insert(restartButton)
            transition.to(shade, {time = 200, alpha = 0.65})
            transition.to(gameOverScreen, {time = 500, alpha = 1})
            scoreText.isVisible = false
            scoreText.text = "Score: " .. gameScore
            scoreText.x = 160
            scoreText.y = 360
            scoreText:toFront()
            highScoreText = display.newText( "Highscore: " ..
            tostring( highScore ), 0, 0, "PixelSix00", 27  )
            highScoreText.x = 160
            highScoreText.y = 325
            sceneGroup:insert( highScoreText )
            timer.performWithDelay(0, function() scoreText.isVisible = true; end, 1)
            if gameScore > highScore then
                highScore = gameScore             
                local highScoreFilename = "highScore.data"
                saveValue( highScoreFilename, tostring(highScore) )
            end
            
        end

    --BG Music
    local playPlayBackgroundMusic = function()
        backgroundMusicChannel = audio.play( backgroundMusic, { channel=1, loops=-1, fadein=5000 } )
    end
    
    --game over music
    local playGameoverMusic = function()
        gameoverMusicChannel = audio.play(gameoverMusic, {channel=2, loops = 0, fadein = 100})
    end
    
    --upvote caught sound effect
    local playUpvoteMusic = function()
        upvoteMusicChannel = audio.play(upvoteMusic, {channel=3, loops = 0, fadein = 0})
    end
    
    --downvote hit sound effect
    local playDownvoteMusic = function()
        downvoteMusicChannel = audio.play(downvoteMusic, {channel=4, loops = 0, fadein = 0})
    end
    
    --gold caught sound effect
    local playGoldMusic = function()
        goldMusicChannel = audio.play(goldMusic, {channel=5, loops = 0, fadein = 0})
    end
    
    --Create the background function that creates play scene
     local drawBackground = function()
         background = display.newImage("images/bg.png", 160, 240)
         background:scale(1.5, 1.5)
         sceneGroup:insert(background)

         ground = display.newImage("images/floor.png", 160, 480)
         physics.addBody(ground, "static", { friction=0.5, bounce=0 } )
         ground.myName = "ground"
         sceneGroup:insert(ground)
     end

     -- Create the game's HUD
     local hud = function()
         --track players lives
         livesText = display.newText( "Lives: " .. gameLives, 265, 1, "PixelSix00", 27 )
         sceneGroup:insert( livesText )

         --track players score
         scoreText = display.newText( "Score: " .. gameScore, 93, 2, "PixelSix00", 27 )
         sceneGroup:insert( scoreText )
         
        --pause menu
        local function handleButtonEvent( event )
        if ( "ended" == event.phase ) then
            composer.showOverlay(event.target.goto, {effect = "fade"})
            physics.pause()
            audio.pause()
            pauseBtn.isVisible = false
            timer.pause(startGoldDrop)
            timer.pause(startDownvoteDrop)
            timer.pause(startUpvoteDrop)
            left:removeEventListener("touch", left)
            right:removeEventListener("touch", right)
        end
        
       
        end
             --create pause button widget
             pauseBtn = widget.newButton
            {
                defaultFile = "images/pausebtn.png",
                onEvent = handleButtonEvent
            }
            -- Position pause button
            pauseBtn.x = 33
            pauseBtn.y = 480
            pauseBtn.goto = "pausemenu"
            sceneGroup:insert(pauseBtn)--]]
            
            
            
            
        end
   --function to resume game after user unpauses game         
   function scene:resumeGame()
            audio.resume()
            physics.start()
            pauseBtn.isVisible = true
            timer.resume(startGoldDrop)
            timer.resume(startDownvoteDrop)
            timer.resume(startUpvoteDrop)
            left:addEventListener("touch", left)
            right:addEventListener("touch", right)
    end
    
    

     -- Create the lives function
     local livesCount = function()
         gameLives = gameLives - 1
         livesText.text = "Lives: ".. gameLives
         livesText.x = 265
         livesText.y = 1
         if gameLives < 1 then
             timer.cancel(startUpvoteDrop)
             timer.cancel(startGoldDrop)
             print("upvote and gold timer cancelled")
             callGameOver()
             playGameoverMusic()
         end
     end
     
     -- function to create the main character
    local createSnoo = function()
        
        snoo = display.newImageRect("images/snoo.png", 88, 107)
        snoo.x = 160
        snoo.y = 405
        physics.addBody( snoo, "static", { friction=0.5, bounce=0, filter = snooCollisionFilter, shape = snooShape }, physicsData:get("snoo"))
        snoo.rotation = 0
        snoo.isHit = false
        snoo.myName = "snoo"
        sceneGroup:insert(snoo)
    end
    
    --Behaviour of downvote collision
    local onDownvoteCollision = function(self, event)
    if event.force > 1 and not self.isHit then
        self.isHit = true
        print("Downvote")
        self.isVisible = false
	self.parent:remove( self )
	self = nil
        
        if event.other.myName == "snoo" then
            livesCount()
            playDownvoteMusic()
            print("downvote hit")	
        elseif event.other.myName == "ground" then
            print("ground hit")
            end
        end
        if gameLives < 1 then
            timer.cancel( startDownvoteDrop )
            print("downvote timer cancelled")
	end	
    end

    --function that generates downvote arrow at a random position (on the x axis) a the top of the screen
    local downvoteDrop =function()
       
        downvote = display.newImage("images/downvote.png")
        downvote.x = math.random(320)
        downvote.y = -100
        if((downvote.x - downvote.width * 0.5) < 0) then
                downvote.x = downvote.width * 0.5
                elseif((downvote.x + downvote.width * 0.5) > display.contentWidth) then
                downvote.x = display.contentWidth - downvote.width * 0.5
            end
        physics.addBody(downvote, "dynamic", {bounce = 0, friction= 0.5, filter = downvoteCollisionFilter, shape = downvoteShape},physicsData:get("downvote"))
        downvote.isFixedRotation = true
        sceneGroup:insert(downvote)
        
        downvote.postCollision = onDownvoteCollision
        downvote:addEventListener("postCollision", downvote)
        
    end
    
    --timer that calls the downvote drop function every second
    local downvoteTimer = function()
        startDownvoteDrop = timer.performWithDelay(1000, downvoteDrop, 0)
    end

    --Behaviour of upvote collision
    local onUpvoteCollision = function(self, event)
        if event.force > 1 and not self.isHit then
            self.isHit = true
            print("Upvote")
            self.isVisible = false
            self.parent:remove( self )
            self = nil

            if event.other.myName == "snoo" then
                local newScore = gameScore + 500
                setScore(newScore)
                playUpvoteMusic()
                print("catch")
                

            elseif event.other.myName == "ground" then
                print("ground hit")
            end
        end
    end

    --function that generates downvote arrow at a random position (on the x axis) at the top of the screen
    local upvoteDrop =function()
        
        upvote = display.newImage("images/upvote.png")
        upvote.x = math.random(320)
        upvote.y = -100
        if((upvote.x - upvote.width * 0.5) < 0) then
                upvote.x = upvote.width * 0.5
                elseif((upvote.x + upvote.width * 0.5) > display.contentWidth) then
                upvote.x = display.contentWidth - upvote.width * 0.5
            end
        physics.addBody(upvote, "dynamic", {bounce = 0, friction= 0.5, filter = upvoteCollisionFilter, shape = upvoteShape}, physicsData:get("upvote"))
        upvote.isFixedRotation = true
        sceneGroup:insert(upvote)

        upvote.postCollision = onUpvoteCollision
        upvote:addEventListener("postCollision", upvote)
    end

    --timer that calls the upvote drop function every 1.1 seconds
    local upvoteTimer = function()
        startUpvoteDrop = timer.performWithDelay(1100, upvoteDrop, 0)
    end

    --Behaviour of gold collision
    local onGoldCollision = function(self, event)
        if event.force > 1 and not self.isHit then
            self.isHit = true
            print("Gold")
            self.isVisible = false
            self.parent:remove( self )
            self = nil

            
            
            if event.other.myName == "snoo" then
                local newScore = gameScore + 1000
                setScore(newScore)
                playGoldMusic()
                print("catch gold")
        

            elseif event.other.myName == "ground" then
                print("ground hit gold")
            end
        end
    end

    --function that generates downvote arrow at a random position (on the x axis) a the top of the screen
    local goldDrop =function()
        
        gold = display.newImage("images/gold.png")
        gold.x = math.random(320)
        gold.y = -100
        if((gold.x - gold.width * 0.5) < 0) then
                gold.x = gold.width * 0.5
                elseif((gold.x + gold.width * 0.5) > display.contentWidth) then
                gold.x = display.contentWidth - gold.width * 0.5
            end
        physics.addBody(gold, "dynamic", {bounce = 0, friction= 0.5, filter = goldCollisionFilter, radius = goldRadius}, physicsData:get("gold"))
        gold.isFixedRotation = true
        sceneGroup:insert(gold)

        gold.postCollision = onGoldCollision
        gold:addEventListener("postCollision", gold)
    end

    --timer that calls the golddrop function every 5 seconds
    local goldTimer = function()
        startGoldDrop = timer.performWithDelay(5000, goldDrop, 0)
    end
    
    --function called when game begins that calls all the above functions
    local gameStart = function()
        muteUnmuteText.isVisible = true
        physics.start(true)
        physics.setGravity(0, 9.8)
        drawBackground()
        createSnoo()
        upvoteTimer()
        downvoteTimer()
        goldTimer()
        playPlayBackgroundMusic()
        hud()
        gameActivate()
        Runtime:addEventListener("enterFrame", moveguy)
        Runtime:addEventListener("touch", stop )
        local highScoreFilename = "highScore.data"
        local loadedHighScore = loadValue( highScoreFilename )
        highScore = tonumber(loadedHighScore)
        
        
    end

    gameStart()
    return sceneGroup
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
    
    --Runtime:removeEventListener( "poatCollision", downvote )

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

