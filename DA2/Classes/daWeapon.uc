/** Of course you all hate my for again a new naming scheme ^^ But it's quicker to write and not ambigous (Dante)
  * This is the base weapon code that allows guns more than just shooting and switching
  */

class daWeapon extends Weapon;

var	name	Action;	// The current action performed by this weapon == '' if idle
var name	pendingAction;

simulated function bool allowAction(name newAction) {
//	log(self@"1) Requested Action:"@newAction@action);
	return newAction == '' || (newAction == 'BringUp' || newAction == 'PutDown' && Action == 'BringUp' || Action == 'PutDown') || (Action != 'BringUp' && Action != 'PutDown');
}

/** Tries to switch to the new Action 
  * Return false if that failed.
  */
simulated function bool setAction(name newAction) {
	if (!allowAction(newAction)) {
		if (action != newAction)
			pendingAction = newAction;
		else
			pendingAction = '';
		return false;
	}
	if (newAction != '')
		pendingAction = '';
	Action = newAction;
	performAction();
	return true;
}

simulated function performAction() {
//	log("performing:"@action);
	// 'Fire' is handled by StartFire
	switch (Action) {
		case '':
			gotoState('');
			if (Instigator.Weapon == self && Instigator.PendingWeapon != self && Instigator.PendingWeapon != None) 
        		PutDown();
			else if (pendingAction != '') {
				setAction(pendingAction);
				break;
			}
			break;
		case 'BringUp':
		case 'PutDown':
		case 'Fire': // We should go to a safe state or else the weapon might continue the previous action
			gotoState('');
		break;
	}
}

simulated function bool PutDown() {
	if (allowAction('PutDown') && super.putDown()) { 
		setAction('PutDown');
		return true;
	}
	return false;
}

simulated function BringUp(optional Weapon PrevWeapon) {
	if (allowAction('BringUp')) {
		super.BringUp(prevWeapon);
		if (ClientState == WS_BringUp)
			setAction('BringUp');
	}
}


simulated function bool StartFire(int Mode) {
	if (allowAction('Fire') && super.StartFire(mode)) {
		setAction('Fire');
		return true;
	} else
		pendingAction = 'Fire';
	return false;
}

simulated function DisplayDebug(Canvas Canvas, out float YL, out float YPos) {
	super.DisplayDebug(canvas, YL, Ypos);
	Canvas.drawText("Current Action:"@Action,false);
	Ypos += YL;
	Canvas.setPos(4, YPos);
	Canvas.drawText("Pending Action:"@PendingAction,false);
	Ypos += YL;
	Canvas.setPos(4, YPos);
}

simulated function Timer() {
//	log("Timer");
	super.Timer();
	
	if (Action == 'BringUp' && ClientState == WS_ReadyToFire)
		setAction('');

	if (Action == 'PutDown' && (ClientState == WS_Hidden || ClientState == WS_ReadyToFire))
		setAction('');
}

simulated function AnimEnd(int channel) {
	if (Action == '' || Action == 'Fire')
		super.animEnd(channel);
	if (Action == 'Fire' && (FireMode[0] != none && !FireMode[0].bIsFiring ||
				FireMode[1] != none && !FireMode[1].bIsFiring))
		setAction('');
}

defaultproperties
{
}
