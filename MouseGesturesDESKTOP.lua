--[[
편저자: Gomdolius
제작일: 2025. 2. 11.
Mark van den Berg의 https://github.com/mark-vandenberg/g-hub-mouse-gestures 에 기초함
* Special credits to https://github.com/wookiefriseur for showing a way to do this for windows gestures which inspired this script
For some windows gestures check https://github.com/wookiefriseur/LogitechMouseGestures
]]--

 
-- 제스처를 매핑할 버튼 / G1 = 1, G2 = 2 etc..
gestureButtonNumber = 5;

-- 최소 이동 거리
minimalHorizontalMovement = 2500;
minimalVerticalMovement = 2500;

-- 클릭으로 간주할 이동 거리
noMovementThreshold = 750

-- 키 누름 기본 간격 (ms)
delay = 20

-- 디버깅 메시지 표시 여부 (콘솔)
debuggingEnabled = true


-- 이벤트 감지

horizontalStartingPosistion = 0;
verticalStartingPosistion = 0;
horizontalEndingPosistion = 0;
verticalEndingPosistion = 0;

function OnEvent(event, arg, family)
	if event == "MOUSE_BUTTON_PRESSED" and arg == gestureButtonNumber then
		if debuggingEnabled then OutputLogMessage("\nEvent: " .. event .. " for button: " .. arg .. "\n") end
		
		-- 시작점 산출
		horizontalStartingPosistion, verticalStartingPosistion = GetMousePosition()
		
		if debuggingEnabled then 
			OutputLogMessage("Horizontal starting posistion: " .. horizontalStartingPosistion .. "\n") 
			OutputLogMessage("Vertical starting posistion: " .. verticalStartingPosistion .. "\n") 
		end
	end

	if event == "MOUSE_BUTTON_RELEASED" and arg == gestureButtonNumber then
		if debuggingEnabled then OutputLogMessage("\nEvent: " .. event .. " for button: " .. arg .. "\n") end
		
		-- 끝점 산출
		horizontalEndingPosistion, verticalEndingPosistion = GetMousePosition()
		
		if debuggingEnabled then 
			OutputLogMessage("Horizontal ending posistion: " .. horizontalEndingPosistion .. "\n") 
			OutputLogMessage("Vertical ending posistion: " .. verticalEndingPosistion .. "\n") 
		end

		-- 시작지점과 끝점 간 거리 산출
		horizontalDifference = horizontalStartingPosistion - horizontalEndingPosistion
		verticalDifference = verticalStartingPosistion - verticalEndingPosistion
		abshorizontalDifference = math.abs(horizontalDifference)
		absverticalDifference = math.abs(verticalDifference)

		-- 움직인 방향과 거리를 결정
		if horizontalDifference > minimalHorizontalMovement then mouseMovedLeft(arg) end
		if horizontalDifference < -minimalHorizontalMovement then mouseMovedRight(arg) end
		if verticalDifference > minimalVerticalMovement then mouseMovedUp(arg) end
		if verticalDifference < -minimalVerticalMovement then mouseMovedDown(arg) end
		if abshorizontalDifference < noMovementThreshold and absverticalDifference < noMovementThreshold then mouseClicked(arg) end
	end
end

-- 마우스 이동
function mouseMovedUp(buttonNumber)
	if debuggingEnabled then OutputLogMessage("\nmouseMovedUp\n") end
	
	if buttonNumber == gestureButtonNumber then 
		performUpGesture()
	end
end

function mouseMovedDown(buttonNumber)
	if debuggingEnabled then OutputLogMessage("\nmouseMovedDown\n") end
	
	if buttonNumber == gestureButtonNumber then 
		performDownGesture()
	end
end

function mouseMovedRight(buttonNumber)
	if debuggingEnabled then OutputLogMessage("\nmouseMovedRight\n") end
	
	if buttonNumber == gestureButtonNumber then 
		performRightGesture()
	end
end

function mouseMovedLeft(buttonNumber)
	if debuggingEnabled then OutputLogMessage("\nmouseMovedLeft\n") end
	
	if buttonNumber == gestureButtonNumber then 
		performLeftGesture()
	end
end

-- 마우스 클릭
function mouseClicked(buttonNumber)
	if debuggingEnabled then OutputLogMessage("\nmouseClicked\n") end
	
	if buttonNumber == gestureButtonNumber then 
		performClickGesture()
	end
end

-- 제스처 및 클릭 동작
function performUpGesture()
	if debuggingEnabled then OutputLogMessage("performUpGesture\n") end
	firstKey = "lgui"
	secondKey = "up"
	pressTwoKeys(firstKey, secondKey)
end

function performLeftGesture()
	if debuggingEnabled then OutputLogMessage("performLeftGesture\n") end
	firstKey = "lctrl"
	secondKey = "lgui"
	thirdKey = "left"
	pressThreeKeys(firstKey, secondKey, thirdKey)
end

function performRightGesture()
	if debuggingEnabled then OutputLogMessage("performRightGesture\n") end
	firstKey = "lctrl"
	secondKey = "lgui"
	thirdKey = "right"
	pressThreeKeys(firstKey, secondKey, thirdKey)
end

function performDownGesture()
	if debuggingEnabled then OutputLogMessage("performDownGesture\n") end
	firstKey = "lgui"
	secondKey = "down"
	pressTwoKeys(firstKey, secondKey)
end

function performClickGesture()
	if debuggingEnabled then OutputLogMessage("performClickGesture\n") end
	firstKey = "lgui"
	secondKey = "t"
	pressTwoKeys(firstKey, secondKey)
end

-- 보조 함수
function pressOneKey(firstKey)
	PressKey(firstKey)
	Sleep(delay)
	ReleaseKey(firstKey)
end

function pressTwoKeys(firstKey, secondKey)
	PressKey(firstKey)
	Sleep(delay)
	PressKey(secondKey)
	Sleep(delay)
	ReleaseKey(firstKey)
	ReleaseKey(secondKey)
end

function pressThreeKeys(firstKey, secondKey, thirdKey)
	PressKey(firstKey)
	Sleep(delay)
	PressKey(secondKey)
	Sleep(delay)
	PressKey(thirdKey)
	Sleep(delay)
	ReleaseKey(firstKey)
	ReleaseKey(secondKey)
	ReleaseKey(thirdKey)
end
