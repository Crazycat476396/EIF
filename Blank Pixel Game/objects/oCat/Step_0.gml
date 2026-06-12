ysp += 0.1
xsp = 0
idleTime += (1/60)

//onGround variable naming and defining
if (place_meeting(x, y + 1, oSolid)) {
    onGround = true
} else {
    onGround = false
}
//onSlope variable naming and defining
if (place_meeting(x - 1, y - 1, oSlopeL)){
	onSlope = true
} else {
	onSlope = false
}

//stopping edge pixel glitch
if (place_meeting(x - 1, y, oSolid)){
	xsp = 0
	x += 1
}

if (place_meeting(x + 1, y, oSolid)){
	xsp = 0
	x -= 1
}

//movement & jumping
	//main movement (L & R)
if (keyboard_check(vk_right)){
	if keyboard_check(vk_lshift){
		xsp = 2
		sprite_index = sprCatRun
	} else {
		xsp = 1
		sprite_index = sprCatWalk
	}
	image_xscale = 1
	idleTime = 0
} else if (keyboard_check(vk_left)){
	if (keyboard_check(vk_lshift)){	
		xsp = -2
		sprite_index = sprCatRun
	} else {	
		xsp = -1
		sprite_index = sprCatWalk
	}
    image_xscale = -1
	idleTime = 0
	
}
else {
	xsp = 0
	if (idleTime < 3){
		sprite_index = sprCatSitIdle
	} else {
		sprite_index = sprCatSitLickIdle
	}
}

	//jumping
if (onGround){
	if (keyboard_check_pressed(vk_up)){
		ysp = -2
	}
}
	//Slopes
		//SlopeL
if (onSlope){
	ysp = 2
	xsp = -1
}

//no phasing
	//through walls
if (place_meeting(x + xsp, y, oSolid)) {
    while (!place_meeting(x + sign(xsp), y, oSolid)) {
		x += sign(xsp)
    }
    xsp = 0
}
x += xsp

	//through the floor
if (place_meeting(x, y + ysp, oSolid)) {
    while (!place_meeting(x, y + sign(ysp), oSolid)) {
        y += sign(ysp)
    }
    ysp = 0
}
y += ysp

//jump sprites
if (!onGround){
	if (ysp < 0){
		sprite_index = sprCatJumpUp
	}
	else if (ysp > 0){
		sprite_index = sprCatJumpDown
	}
}

if place_meeting(x, y, oBikewheel){
	room_goto_next()
}