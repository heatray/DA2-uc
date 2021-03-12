class da_GUI_Console extends ExtendedConsole;

#exec OBJ LOAD FILE=KFInterfaceContent.utx

state SpeechMenuVisible
{
	function PostRender( canvas Canvas )
	{
		local float XL, YL;
		local int SelLeft, i;
		local float XMax, YMax;

		Canvas.Font = class'UT2MidGameFont'.static.GetMidGameFont(Canvas.ClipX); // Update which font to use.

		// Figure out max key name size
		XMax = 0;
		YMax = 0;
		for(i=0; i<10; i++)
		{
			Canvas.TextSize(NumberToString(i)$"- ", XL, YL);
			XMax = Max(XMax, XL);
			YMax = Max(YMax, YL);
		}
		SMLineSpace = YMax * 1.1;
		SMTab = XMax;

		SelLeft = SMArraySize - SMOffset;

		// First we figure out how big the bounding box needs to be
		XMax = 0;
		YMax = 0;
		DrawNumbers( canvas, Min(SelLeft, 9), SelLeft > 9, true, XMax, YMax);
		DrawCurrentArray( canvas, true, XMax, YMax);
		Canvas.TextSize(SMStateName[SMState], XL, YL);
		XMax = Max(XMax, Canvas.ClipX*(SMOriginX+SMMargin) + XL);
		YMax = Max(YMax, (Canvas.ClipY*SMOriginY) - (1.2*SMLineSpace) + YL);
		// XMax, YMax now contain to maximum bottom-right corner we drew to.

		// Then draw the box
		XMax -= Canvas.ClipX * SMOriginX;
		YMax -= Canvas.ClipY * SMOriginY;
		Canvas.SetDrawColor(255,255,255,255);
		Canvas.SetPos(Canvas.ClipX * SMOriginX, Canvas.ClipY * SMOriginY);
		Canvas.DrawTileStretched(Texture'KFInterfaceContent.Menu.BorderBoxA', XMax + (SMMargin*Canvas.ClipX), YMax + (SMMargin*Canvas.ClipY));

		// Draw highlight
		if(bSpeechMenuUseMouseWheel)
		{
			Canvas.SetDrawColor(255,255,255,128);
			Canvas.SetPos( Canvas.ClipX*SMOriginX, Canvas.ClipY*(SMOriginY+SMMargin) + ((HighlightRow - 0.1)*SMLineSpace) );
			Canvas.DrawTileStretched(Texture'KFInterfaceContent.Menu.BorderBoxA', XMax + (SMMargin*Canvas.ClipX), 1.1*SMLineSpace );
		}

		// Then actually draw the stuff
		DrawNumbers( canvas, Min(SelLeft, 9), SelLeft > 9, false, XMax, YMax);
		DrawCurrentArray( canvas, false, XMax, YMax);

		// Finally, draw a nice title bar.
		Canvas.SetDrawColor(255,255,255,255);
		Canvas.SetPos(Canvas.ClipX*SMOriginX, (Canvas.ClipY*SMOriginY) - (1.5*SMLineSpace));
		Canvas.DrawTileStretched(Texture'KFInterfaceContent.Menu.BorderBoxA', XMax + (SMMargin*Canvas.ClipX), (1.5*SMLineSpace));

		Canvas.SetDrawColor(255,255,128,255);
		Canvas.SetPos(Canvas.ClipX*(SMOriginX+SMMargin), (Canvas.ClipY*SMOriginY) - (1.2*SMLineSpace));
		Canvas.DrawText(SMStateName[SMState]);

		if (SMState == SMS_VoiceChatChannel)
			DrawMembers(Canvas, XMax, YMax);
	}
}

defaultproperties
{
}
