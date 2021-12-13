resx,resy = 65535/1920, 65535/1080

lmb_state = 0

OVERFLOW_AT = 1000
OVERFLOW_COUNTER = 1

function OnEvent(event, arg)
	EnablePrimaryMouseButtonEvents(1);
	OutputLogMessage("\n");
	OutputLogMessage("event = %s, arg = %s\n", event, arg);

	if(event == "G_RELEASED") then
		if(arg >= 26 and arg <= 29) then
			if(lmb_state == 1) then
				--ReleaseMouseButton(1)
				lmb_state = 0
			end			
		end
	end

	if(event == "G_PRESSED") then
		x,y = GetMousePosition();
		ClearLCD()
		OutputLCDMessage(string.format("MouseX: %d, MouseY: %d",x/(65535/1920), x/(65535/1080)))
		OutputLCDMessage(string.format("MouseX: %d, MouseY: %d",x/(65535/1920), x/(65535/1080)))
				
		
		
		if(arg >= 26 and arg <= 29) then
			OutputLogMessage("ok");
			local dx, dy = 0,0
			if(arg == 26) then
				--top
				dy = -1
			end
			if(arg == 28) then
				--down
				dy = 1
			end
			if(arg == 27) then
				--left
				dx = 1
			end
			if(arg == 29) then
				--right
				dx = -1
			end			

			mult = 1.0	
			spd = 10
			Sleep(75)		

			for counter=0, OVERFLOW_AT, 1 do
				if(counter >= OVERFLOW_AT-1) then
					OutputLogMessage("Overflow.\n")
					break
				end
				if(not IsMouseButtonPressed(1)) then
					break
				end
				Sleep(1)
				for i=1,spd,1 do				
					MoveMouseRelative(dx*mult,dy*mult)
				end			
			end		
		end


		local rangemin,rangemax = 1,7
		local sx,sy = 600,1050		
		local offset = 50
		if(arg > rangemin and arg < rangemax) then
			SelectTool(arg-rangemin-1, sx,sy,offset)
		elseif(arg == rangemin) then
			SelectTool(7, sx,sy,offset)
		elseif(arg == rangemax) then
			SelectTool(9, sx,sy,offset)
		end

		

	end
	--EnablePrimaryMouseButtonEvents(0);
end

function SelectTool(i,sx,sy,offx)
	local oldx, oldy = GetMousePosition()
	MoveMouseTo(sx*resx+(i*offx*resx),sy*resy)
	PressAndReleaseMouseButton(1)
	MoveMouseTo(oldx,oldy)
end
