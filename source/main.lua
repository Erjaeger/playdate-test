import "CoreLibs/sprites"
import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/math"

import "scenes/launchMenu"
import "utils/sceneManager"
import "scenes/game"



local gfx <const> = playdate.graphics

SCENE_MANAGER = SceneManager()

function init()
	math.randomseed(playdate.getSecondsSinceEpoch())
	SCENE_MANAGER:switchScene(LaunchMenu)
	gfx.setBackgroundColor(gfx.kColorBlack)
end

function playdate.update()
	gfx.sprite.update()
	playdate.timer.updateTimers()
end

init()
