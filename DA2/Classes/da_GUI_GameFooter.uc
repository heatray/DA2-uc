// D:\mods\UT2004Script3339\GUI2K4\Classes\UT2K4GameFooter.uc
// D:\mods\UT2004Script3339\GUI2K4\Classes\ButtonFooter.uc

//==============================================================================
//  Created on: 12/14/2003
//  This footer goes on Instant Action & Host Multiplayer pages
//
//  Written by Ron Prestenback
//  © 2003, Epic Games, Inc. All Rights Reserved
//==============================================================================

class da_GUI_GameFooter extends UT2K4GameFooter;

/*

var automated GUIButton b_Primary, b_Secondary, b_Back;
var() localized string PrimaryCaption, PrimaryHint, SecondaryCaption, SecondaryHint;

var UT2K4GamePageBase Owner;

function InitComponent(GUIController InController, GUIComponent InOwner) {
	Super.InitComponent(InController, InOwner);

	Owner = UT2K4GamePageBase(MenuOwner);
	b_Primary.OnClick = Owner.InternalOnClick;
	b_Secondary.OnClick = Owner.InternalOnClick;
	b_Back.OnClick = Owner.InternalOnClick;
}

function SetupButtons( optional string bPerButtonSizes ) {
	b_Primary.Caption = PrimaryCaption;
	b_Primary.SetHint( PrimaryHint );

	b_Secondary.Caption = SecondaryCaption;
	b_Secondary.SetHint( SecondaryHint );
	
	Super.SetupButtons(bPerButtonSizes);
}
*/

defaultproperties
{
     Begin Object Class=GUIButton Name=GamePrimaryButton
         MenuState=MSAT_Disabled
         StyleName="DA2Style_Button"
         TabOrder=0
         bBoundToParent=True
         OnKeyEvent=GamePrimaryButton.InternalOnKeyEvent
     End Object
     b_Primary=GUIButton'DA2.da_GUI_GameFooter.GamePrimaryButton'

     Begin Object Class=GUIButton Name=GameSecondaryButton
         MenuState=MSAT_Disabled
         StyleName="DA2Style_Button"
         TabOrder=1
         bBoundToParent=True
         OnKeyEvent=GameSecondaryButton.InternalOnKeyEvent
     End Object
     b_Secondary=GUIButton'DA2.da_GUI_GameFooter.GameSecondaryButton'

     Begin Object Class=GUIButton Name=GameBackButton
         Caption="BACK"
         StyleName="DA2Style_Button"
         Hint="Return to Previous Menu"
         TabOrder=2
         bBoundToParent=True
         OnKeyEvent=GameBackButton.InternalOnKeyEvent
     End Object
     b_Back=GUIButton'DA2.da_GUI_GameFooter.GameBackButton'

     ButtonHeight=0.042000
     Padding=1.000000
     Margin=0.020000
     Spacer=0.010000
     StyleName="DA2Style_Footer"
     WinHeight=0.064000
}
