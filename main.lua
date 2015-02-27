require "CiderDebugger";--local background

--insert background, since on main.lua it displays on every page
local background = display.newImage("images/bg.png", 160, 240)
background:scale(1.5, 1.5)

local composer = require("composer")

muteUnmuteText = display.newText("Mute", 285, 480, "PixelSix00", 25)
            muteUnmuteText.status = "playing"
            --sceneGroup:insert(muteUnmuteText)

            function muteUnmuteText:tap(event)
                if(self.status == "playing")then
                    audio.setVolume(0)
                    audio.pause(backgroundMusic)
                    self.status = "paused"
                    self.text = "Play"

                elseif(self.status == "paused")then
                    audio.resume(backgroundMusic)
                    audio.setVolume(1)
                    self.status = "playing"
                    self.text = "Mute"

                end
    
            end
            
            muteUnmuteText:addEventListener("tap", muteUnmuteText)


composer.gotoScene("loadmenu")






