// D:\mods\UT2004Script3339\XInterface\Classes\GUIVertScrollButton.uc

class da_GUI_VertScrollButton extends GUIScrollButtonBase; // GUIVertScrollButton;

function InitComponent(GUIController MyController, GUIComponent MyOwner) {

	if (bIncreaseButton) {
    	StyleName="DA2Style_VertDownButton";
		ImageIndex = 7;
    }

	Super.Initcomponent(MyController, MyOwner);

}

defaultproperties
{
     ImageIndex=6
     StyleName="DA2Style_VertUpButton"
}
