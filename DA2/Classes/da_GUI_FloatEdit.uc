// D:\mods\UT2004Script3339\XInterface\Classes\GUIFloatEdit.uc

class da_GUI_FloatEdit extends GUIFloatEdit;

defaultproperties
{
     Begin Object Class=da_GUI_EditBox Name=cMyEditBox
         bFloatOnly=True
         bNeverScale=True
         OnActivate=cMyEditBox.InternalActivate
         OnDeActivate=cMyEditBox.InternalDeactivate
         OnKeyType=cMyEditBox.InternalOnKeyType
         OnKeyEvent=cMyEditBox.InternalOnKeyEvent
     End Object
     MyEditBox=da_GUI_EditBox'DA2.da_GUI_FloatEdit.cMyEditBox'

     Begin Object Class=da_GUI_SpinnerButton Name=cMySpinner
         bTabStop=False
         bNeverScale=True
         OnClick=cMySpinner.InternalOnClick
         OnKeyEvent=cMySpinner.InternalOnKeyEvent
     End Object
     MySpinner=da_GUI_SpinnerButton'DA2.da_GUI_FloatEdit.cMySpinner'

     Begin Object Class=GUIToolTip Name=GUIFloatEditToolTip
     End Object
     ToolTip=GUIToolTip'DA2.da_GUI_FloatEdit.GUIFloatEditToolTip'

}
