class da_objective_MOHack extends Actor;

function tick(float deltaTime) {
	da_objective_MultiObjective(owner).check();
}

defaultproperties
{
     bHidden=True
}
