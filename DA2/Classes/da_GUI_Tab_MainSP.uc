// D:\mods\UT2004Script3339\GUI2K4\Classes\UT2K4Tab_MainSP.uc
// D:\mods\UT2004Script3339\GUI2K4\Classes\UT2K4Tab_MainBase.uc

class da_GUI_Tab_MainSP extends UT2K4Tab_MainSP;

defaultproperties
{
     Begin Object Class=da_GUI_SectionBackground Name=SelectionGroup
         bFillClient=True
         Caption="Map Selection"
         WinTop=0.018125
         WinLeft=0.009000
         WinWidth=0.482149
         WinHeight=0.603330
         OnPreDraw=SelectionGroup.InternalPreDraw
     End Object
     sb_Selection=da_GUI_SectionBackground'DA2.da_GUI_Tab_MainSP.SelectionGroup'

     Begin Object Class=da_GUI_SectionBackground Name=PreviewGroup
         bFillClient=True
         Caption="Preview"
         WinTop=0.018125
         WinLeft=0.515743
         WinWidth=0.470899
         WinHeight=0.974305
         OnPreDraw=PreviewGroup.InternalPreDraw
     End Object
     sb_Preview=da_GUI_SectionBackground'DA2.da_GUI_Tab_MainSP.PreviewGroup'

     Begin Object Class=da_GUI_SectionBackground Name=OptionsGroup
         Caption="Options"
         BottomPadding=0.070000
         WinTop=0.642580
         WinLeft=0.009000
         WinWidth=0.482149
         WinHeight=0.351772
         OnPreDraw=OptionsGroup.InternalPreDraw
     End Object
     sb_Options=da_GUI_SectionBackground'DA2.da_GUI_Tab_MainSP.OptionsGroup'

     Begin Object Class=da_GUI_AltSectionBackground Name=ScrollSection
         bFillClient=True
         Caption="Map Desc"
         WinTop=0.525219
         WinLeft=0.546118
         WinWidth=0.409888
         WinHeight=0.437814
         OnPreDraw=ScrollSection.InternalPreDraw
     End Object
     asb_Scroll=da_GUI_AltSectionBackground'DA2.da_GUI_Tab_MainSP.ScrollSection'

     Begin Object Class=da_GUI_ScrollTextBox Name=MapDescription
         CharDelay=0.002500
         EOLDelay=0.500000
         OnCreateComponent=MapDescription.InternalOnCreateComponent
         WinTop=0.628421
         WinLeft=0.561065
         WinWidth=0.379993
         WinHeight=0.268410
         bTabStop=False
         bNeverFocus=True
     End Object
     lb_MapDesc=da_GUI_ScrollTextBox'DA2.da_GUI_Tab_MainSP.MapDescription'

     Begin Object Class=da_GUI_TreeListBox Name=AvailableMaps
         bVisibleWhenEmpty=True
         OnCreateComponent=AvailableMaps.InternalOnCreateComponent
         Hint="Click a mapname to see a preview and description. Double-click to play a match on the map."
         WinTop=0.169272
         WinLeft=0.045671
         WinWidth=0.422481
         WinHeight=0.449870
         TabOrder=0
         OnChange=da_GUI_Tab_MainSP.MapListChange
     End Object
     lb_Maps=da_GUI_TreeListBox'DA2.da_GUI_Tab_MainSP.AvailableMaps'

     Begin Object Class=da_GUI_moButton Name=MaplistButton
         ButtonCaption="Maplist Configuration"
         ComponentWidth=1.000000
         OnCreateComponent=MaplistButton.InternalOnCreateComponent
         Hint="Modify the maps that should be used in gameplay"
         WinTop=0.888587
         WinLeft=0.039258
         WinWidth=0.341797
         WinHeight=0.050000
         TabOrder=2
         OnChange=da_GUI_Tab_MainSP.MaplistConfigClick
     End Object
     b_Maplist=da_GUI_moButton'DA2.da_GUI_Tab_MainSP.MaplistButton'

     Begin Object Class=da_GUI_moButton Name=TutorialButton
         ButtonCaption="Watch Game Tutorial"
         ComponentWidth=1.000000
         OnCreateComponent=TutorialButton.InternalOnCreateComponent
         Hint="Watch the tutorial for this gametype."
         WinTop=0.913326
         WinLeft=0.556953
         WinWidth=0.348633
         WinHeight=0.050000
         TabOrder=3
         OnChange=da_GUI_Tab_MainSP.TutorialClicked
     End Object
     b_Tutorial=da_GUI_moButton'DA2.da_GUI_Tab_MainSP.TutorialButton'

     Begin Object Class=GUIImage Name=MapPreviewImage
         ImageStyle=ISTY_Scaled
         ImageRenderStyle=MSTY_Normal
         WinTop=0.107691
         WinLeft=0.562668
         WinWidth=0.372002
         WinHeight=0.357480
         RenderWeight=0.200000
     End Object
     i_MapPreview=GUIImage'DA2.da_GUI_Tab_MainSP.MapPreviewImage'

     Begin Object Class=GUILabel Name=MapAuthorLabel
         Caption="Testing"
         TextAlign=TXTA_Center
         StyleName="DA2Style_BodyText"
         WinTop=0.405278
         WinLeft=0.522265
         WinWidth=0.460000
         WinHeight=0.032552
         RenderWeight=0.300000
     End Object
     l_MapAuthor=GUILabel'DA2.da_GUI_Tab_MainSP.MapAuthorLabel'

     Begin Object Class=GUILabel Name=RecommendedPlayers
         Caption="Best for 4 to 8 players"
         TextAlign=TXTA_Center
         StyleName="DA2Style_BodyText"
         WinTop=0.474166
         WinLeft=0.521288
         WinWidth=0.460000
         WinHeight=0.032552
         RenderWeight=0.300000
     End Object
     l_MapPlayers=GUILabel'DA2.da_GUI_Tab_MainSP.RecommendedPlayers'

     Begin Object Class=GUILabel Name=NoPreview
         Caption="No Preview Available"
         TextAlign=TXTA_Center
         TextColor=(B=0,G=255,R=247)
         TextFont="UT2HeaderFont"
         bTransparent=False
         bMultiLine=True
         VertAlign=TXTA_Center
         WinTop=0.107691
         WinLeft=0.562668
         WinWidth=0.372002
         WinHeight=0.357480
     End Object
     l_NoPreview=GUILabel'DA2.da_GUI_Tab_MainSP.NoPreview'

     Begin Object Class=da_GUI_moCheckBox Name=FilterCheck
         Caption="Only Official Maps"
         OnCreateComponent=FilterCheck.InternalOnCreateComponent
         Hint="Hides all maps not created the Defence Alliance team."
         WinTop=0.772865
         WinLeft=0.051758
         WinWidth=0.341797
         WinHeight=0.030035
         TabOrder=1
         OnChange=da_GUI_Tab_MainSP.ChangeMapFilter
     End Object
     ch_OfficialMapsOnly=da_GUI_moCheckBox'DA2.da_GUI_Tab_MainSP.FilterCheck'

     MaplistEditorMenu="DA2.da_GUI_MaplistEditor"
     FadeInTime=0.000000
     WinHeight=0.780000
     bStandardized=True
     StandardHeight=0.780000
}
