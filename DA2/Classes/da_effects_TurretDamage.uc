class da_effects_TurretDamage extends Emitter;

simulated function PostBeginPlay()
{
	Super.PostBeginPlay();

	SetTimer(0.1, true);
}

simulated function Timer()
{
	local da_turrets_turret turret;
    local float tmp;

    turret=da_turrets_turret(owner);
    if(turret==none || turret.health<=0) {
        Kill();
        return;
    }
    else tmp=1-(float(turret.health)/turret.default.health);

    if(frand()*7<3+turret.stuntime-level.timeseconds)
        Emitters[1].SpawnParticle(2);

	if(tmp>0.2)
	{
        Emitters[0].AllParticlesDead = false;
        Emitters[0].ParticlesPerSecond = default.Emitters[0].ParticlesPerSecond*(0.75+tmp*0.25);
	    Emitters[0].InitialParticlesPerSecond = default.Emitters[0].InitialParticlesPerSecond*(0.75+tmp*0.25);
	    Emitters[0].opacity=(tmp-0.2)/0.8;

        if(frand()*0.3+0.6<tmp)
            Emitters[2].SpawnParticle(1);
	}
	else
	{
        Emitters[0].AllParticlesDead = true;
        Emitters[0].ParticlesPerSecond = 0;
		Emitters[0].InitialParticlesPerSecond = 0;
		Emitters[0].opacity=0;
    }
}

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter1
         UseColorScale=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         Acceleration=(Z=150.000000)
         ColorScale(0)=(Color=(B=176,G=223,R=255))
         ColorScale(1)=(RelativeTime=0.200000,Color=(B=128,G=128,R=128,A=192))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=80,G=80,R=80))
         FadeOutStartTime=1.000000
         MaxParticles=40
         StartLocationRange=(X=(Min=-10.000000,Max=30.000000),Y=(Min=-10.000000,Max=10.000000),Z=(Min=-15.000000,Max=15.000000))
         SphereRadiusRange=(Max=20.000000)
         UseRotationFrom=PTRS_Actor
         SpinsPerSecondRange=(X=(Min=-0.200000,Max=0.200000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.200000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=20.000000,Max=60.000000),Y=(Min=20.000000,Max=50.000000))
         ParticlesPerSecond=6.000000
         InitialParticlesPerSecond=6.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'SpecialEffects.Smoke.MuchSmoke2t'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         LifetimeRange=(Min=1.000000)
         StartVelocityRange=(X=(Min=-20.000000,Max=20.000000),Y=(Min=-10.000000,Max=10.000000),Z=(Max=50.000000))
         VelocityLossRange=(X=(Min=3.000000,Max=3.000000),Y=(Min=3.000000,Max=3.000000),Z=(Min=3.000000,Max=3.000000))
     End Object
     Emitters(0)=SpriteEmitter'DA2.da_effects_TurretDamage.SpriteEmitter1'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter2
         UseColorScale=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         ColorScale(0)=(Color=(B=255,G=255,R=255))
         ColorScale(1)=(RelativeTime=0.800000,Color=(B=179,G=153,R=136,A=255))
         ColorScale(2)=(RelativeTime=1.000000)
         ColorMultiplierRange=(Y=(Min=0.900000))
         FadeOutStartTime=1.000000
         StartLocationRange=(X=(Min=-20.000000,Max=40.000000),Y=(Min=-15.000000,Max=15.000000),Z=(Min=-15.000000,Max=15.000000))
         SphereRadiusRange=(Min=10.000000,Max=20.000000)
         UseRotationFrom=PTRS_Actor
         SpinsPerSecondRange=(X=(Min=-1.000000,Max=1.000000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(0)=(RelativeSize=1.000000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=0.200000)
         StartSizeRange=(X=(Min=30.000000,Max=60.000000))
         InitialParticlesPerSecond=0.200000
         Texture=Texture'da2effects2.EmitterTextures.electric'
         TextureUSubdivisions=2
         TextureVSubdivisions=2
         LifetimeRange=(Min=0.050000,Max=0.150000)
         VelocityLossRange=(X=(Min=3.000000,Max=3.000000),Y=(Min=3.000000,Max=3.000000),Z=(Min=3.000000,Max=3.000000))
     End Object
     Emitters(1)=SpriteEmitter'DA2.da_effects_TurretDamage.SpriteEmitter2'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter3
         UseColorScale=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         BlendBetweenSubdivisions=True
         Acceleration=(Z=300.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=188,G=198,R=231))
         FadeOutStartTime=1.000000
         MaxParticles=25
         StartLocationRange=(X=(Min=-10.000000,Max=30.000000),Y=(Min=-10.000000,Max=10.000000),Z=(Min=-10.000000,Max=10.000000))
         SphereRadiusRange=(Max=10.000000)
         UseRotationFrom=PTRS_Actor
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(0)=(RelativeSize=0.400000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=10.000000,Max=60.000000),Y=(Min=10.000000,Max=60.000000))
         InitialParticlesPerSecond=15.000000
         DrawStyle=PTDS_Brighten
         Texture=Texture'da2effects2.EmitterTextures.electric'
         TextureUSubdivisions=2
         TextureVSubdivisions=2
         LifetimeRange=(Min=0.200000,Max=0.300000)
         InitialDelayRange=(Max=0.400000)
         StartVelocityRange=(X=(Min=-30.000000,Max=30.000000),Y=(Min=-30.000000,Max=30.000000))
         VelocityLossRange=(X=(Min=3.000000,Max=3.000000),Y=(Min=3.000000,Max=3.000000),Z=(Min=3.000000,Max=3.000000))
     End Object
     Emitters(2)=SpriteEmitter'DA2.da_effects_TurretDamage.SpriteEmitter3'

     bNoDelete=False
     Physics=PHYS_Trailer
     bHardAttach=True
}
