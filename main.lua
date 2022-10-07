-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

local tapCount = 0

local background = display.newImageRect("assets/background.png", 360, 570)
background.x = display.contentCenterX
background.y = display.contentCenterY

local tapText = display.newText(tapCount, display.contentCenterX, 20, native.systemFont, 40)
tapText:setFillColor(0, 0, 0)

local platform = display.newImageRect("assets/platform.png", 300, 50)
platform.x = display.contentCenterX
platform.y = display.contentHeight-25
platform.myName = "platform"

local balloon = display.newImageRect("assets/balloon.png", 112, 112)
balloon.x = display.contentCenterX
balloon.y = display.contentCenterY
balloon.alpha = 0.8
balloon.myName = "balloon"

local physics = require("physics")
physics.start()

physics.addBody(platform, "static")
physics.addBody(balloon, "dynamic", {radius=50, bounce=0.3})

local function pushBalloon()
    balloon:applyLinearImpulse(0, -0.75, balloon.x, balloon.y)
    tapCount = tapCount + 1
    tapText.text = tapCount
end

balloon:addEventListener("tap", pushBalloon)

local function onCollion(event)
    if(event.phase == "began") then
        local obj1 = event.object1
        local obj2 = event.object2

        if((obj1.myName == "balloon" and obj2.myName == "platform") or
        (obj1.myName == "platform" and obj2.myName == "balloon")) then
            tapCount = 0
            tapText.text = tapCount
        end
    end
end

Runtime:addEventListener("collision", onCollion)