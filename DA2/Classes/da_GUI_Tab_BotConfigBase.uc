class da_GUI_Tab_BotConfigBase extends UT2K4Tab_BotConfigBase;

function bool InternalOnClick(GUIComponent Sender)
{
    if (Sender==b_Left)
    {
      li_Bots.SetFocus(none);
        li_Bots.PgUp();
        return true;
    }

    if (Sender==b_Right)
    {
      li_Bots.SetFocus(none);
        li_Bots.PgDown();
        return true;
    }

    if (Sender == b_AddR)
    {
        bIgnoreListChange = True;
    li_Red.Add( li_Bots.GetPortrait(), li_Bots.Index );
        return true;
    }

    if (Sender == b_AddB)
    {
        bIgnoreListChange = True;
    li_Blue.Add( li_Bots.GetPortrait(), li_Bots.Index );
        return true;
    }

    if (Sender == b_RemoveR)
    {
        li_Red.Remove(li_Red.Index);
        return true;
    }

    if (Sender == b_RemoveB)
    {
        li_Blue.Remove(li_Blue.Index);
        return true;
    }

    if (Sender == b_Config)
    {
        if (Controller.OpenMenu("DA2.da_GUI_BotInfoPage"))
            da_GUI_BotInfoPage(Controller.ActivePage).SetupBotInfo(li_bots.GetPortrait(), li_Bots.GetDecoText(), li_Bots.GetRecord());
        return true;
    }
    if (Sender == b_DoConfig)
    {
        if (Controller.OpenMenu("DA2.da_GUI_BotConfigPage"))
            da_GUI_BotConfigPage(Controller.ActivePage).SetupBotInfo(li_Bots.GetPortrait(), li_Bots.GetDecoText(), li_Bots.GetRecord());
        return true;
    }

    return false;
}

defaultproperties
{
     Begin Object Class=da_GUI_SectionBackground Name=BotConfigMainBG
         Caption="Drag a character on to its respective team"
         WinTop=0.650734
         WinLeft=0.058516
         WinWidth=0.887501
         WinHeight=0.328047
         OnPreDraw=BotConfigMainBG.InternalPreDraw
     End Object
     sb_Bots=da_GUI_SectionBackground'DA2.da_GUI_Tab_BotConfigBase.BotConfigMainBG'

     Begin Object Class=da_GUI_SectionBackground Name=BotConfigRedBackground
         Caption="Defending Team"
         WinTop=0.008334
         WinLeft=0.011758
         WinWidth=0.358731
         WinHeight=0.576876
         OnPreDraw=BotConfigRedBackground.InternalPreDraw
     End Object
     sb_Red=da_GUI_SectionBackground'DA2.da_GUI_Tab_BotConfigBase.BotConfigRedBackground'

     Begin Object Class=da_GUI_SectionBackground Name=BotConfigBlueBackground
         Caption="Attacking Team"
         WinTop=0.008334
         WinLeft=0.629743
         WinWidth=0.358731
         WinHeight=0.576876
         OnPreDraw=BotConfigBlueBackground.InternalPreDraw
     End Object
     sb_Blue=da_GUI_SectionBackground'DA2.da_GUI_Tab_BotConfigBase.BotConfigBlueBackground'

     Begin Object Class=da_GUI_AltSectionBackground Name=BotConfigPortraitBackground
         WinTop=0.037820
         WinLeft=0.392777
         WinWidth=0.220218
         WinHeight=0.512104
         OnPreDraw=BotConfigPortraitBackground.InternalPreDraw
     End Object
     sb_PBK=da_GUI_AltSectionBackground'DA2.da_GUI_Tab_BotConfigBase.BotConfigPortraitBackground'

     Begin Object Class=GUIImage Name=BotConfigPortrait
         DropShadow=Texture'PlayerPictures.PlayerPictures.cDefault'
         ImageStyle=ISTY_Scaled
         ImageRenderStyle=MSTY_Normal
         DropShadowY=6
         WinTop=0.003986
         WinLeft=0.400000
         WinWidth=0.200000
         WinHeight=0.573754
         RenderWeight=1.101000
     End Object
     i_Portrait=GUIImage'DA2.da_GUI_Tab_BotConfigBase.BotConfigPortrait'

     Begin Object Class=da_GUI_Button Name=IABotConfigConfig
         Caption="Info"
         Hint="View detailed stats for this bot."
         WinTop=0.593949
         WinLeft=0.357306
         WinWidth=0.136563
         WinHeight=0.049765
         TabOrder=9
         OnClick=UT2K4Tab_BotConfigBase.InternalOnClick
         OnKeyEvent=IABotConfigConfig.InternalOnKeyEvent
     End Object
     b_Config=da_GUI_Button'DA2.da_GUI_Tab_BotConfigBase.IABotConfigConfig'

     Begin Object Class=da_GUI_Button Name=BotLeft
         StyleName="ArrowLeft"
         WinTop=0.790963
         WinLeft=0.101953
         WinWidth=0.043555
         WinHeight=0.084414
         TabOrder=6
         bNeverFocus=True
         bRepeatClick=True
         OnClick=UT2K4Tab_BotConfigBase.InternalOnClick
         OnKeyEvent=BotLeft.InternalOnKeyEvent
     End Object
     b_Left=da_GUI_Button'DA2.da_GUI_Tab_BotConfigBase.BotLeft'

     Begin Object Class=da_GUI_Button Name=BotRight
         StyleName="ArrowRight"
         WinTop=0.790963
         WinLeft=0.854649
         WinWidth=0.043555
         WinHeight=0.084414
         TabOrder=8
         bNeverFocus=True
         bRepeatClick=True
         OnClick=UT2K4Tab_BotConfigBase.InternalOnClick
         OnKeyEvent=BotRight.InternalOnKeyEvent
     End Object
     b_Right=da_GUI_Button'DA2.da_GUI_Tab_BotConfigBase.BotRight'

     Begin Object Class=da_GUI_Button Name=IABotConfigDoConfig
         Caption="Edit"
         Hint="Customize the AI attributes for this bot"
         WinTop=0.593949
         WinLeft=0.505743
         WinWidth=0.136563
         WinHeight=0.049765
         TabOrder=10
         OnClick=UT2K4Tab_BotConfigBase.InternalOnClick
         OnKeyEvent=IABotConfigDoConfig.InternalOnKeyEvent
     End Object
     b_DoConfig=da_GUI_Button'DA2.da_GUI_Tab_BotConfigBase.IABotConfigDoConfig'

}
