global buttonDown
global initialPos
global TAxisX
global TAxisY

fn lineLineIntersect p1 p2 p3 p4 = 
(
	local a=p2-p1
	local b=p4-p3
	local c=p3-p1
	local cross1 = cross a b
	local cross2 = cross c b
	p1 + ( a*( (dot cross2 cross1)/((length cross1)^2) ) )
)

lec = when geometry selection change obj do
(
	
	buttonRelease = false
	
	if snapmode.active AND snapmode.hit==true AND snapMode.axisConstraint==true do
	(
		modif = modPanel.getCurrentObject()
		level = getSelectionLevel modif
		axisV=toolmode.axisConstraints
		
		if mouse.buttonStates[1] == true then
		(
			if buttonDown!=true then
			(
				initialPos=snapmode.worldHitpoint
				global buttonDown = true
			)
			
		)		else
		(
			if buttonDown == true then
			(
				buttonRelease = true
				global buttonDown = false
			)
		)
		if buttonRelease == true then
		(
			if axisV == #X then
			(
				mouvement = snapmode.worldHitpoint - initialPos
				p3Line_1_Point_1 = initialPos
				p3Line_1_Point_2 = initialPos+(TAxisX*10)
				p3Line_2_Point_1 = point3 snapmode.worldHitpoint.x initialPos.y 0
				p3Line_2_Point_2 = (p3Line_2_Point_1 + (TAxisY*10))
				posTX = lineLineIntersect p3Line_1_Point_1 p3Line_1_Point_2 p3Line_2_Point_1 p3Line_2_Point_2
				print posTX
			)
			if axisV == #Y then
			(
				mouvement = snapmode.worldHitpoint - initialPos
				p3Line_1_Point_1 = initialPos
				p3Line_1_Point_2 = initialPos+(TAxisY*10)
				p3Line_2_Point_1 = point3 initialPos.x snapmode.worldHitpoint.y 0
				p3Line_2_Point_2 = (p3Line_2_Point_1 + (TAxisY*10))
				posTX = lineLineIntersect p3Line_1_Point_1 p3Line_1_Point_2 p3Line_2_Point_1 p3Line_2_Point_2
				print posTX
			)
		)
	)
)

fn startScriptX=
(
	rotAxisX = selection[1].rotation.z_rotation
	rmAxisX = rotateZMatrix rotAxisX
	TAxisX = x_axis * rmAxisX
	
)
fn startScriptY=
(
	rotAxisY = selection[1].rotation.z_rotation
	rmAxisY = rotateZMatrix rotAxisY
	TAxisY = y_axis * rmAxisY
)