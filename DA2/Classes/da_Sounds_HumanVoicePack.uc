//=============================================================================
// DA Team (Team0) Voice Pack - Going old skool...
//=============================================================================
class da_Sounds_HumanVoicePack extends xVoicePack;

#exec OBJ LOAD FILE=DA2Voices.uax

defaultproperties
{
     VoiceGender=VG_Male
     AckSound(0)=Sound'DA2Voices.acknowledged'
     AckSound(1)=Sound'DA2Voices.affirmative'
     AckSound(2)=Sound'DA2Voices.Copy'
     AckSound(3)=Sound'DA2Voices.copy_two'
     AckSound(4)=Sound'DA2Voices.OK'
     AckSound(5)=Sound'DA2Voices.rogerthat'
     AckSound(6)=Sound'DA2Voices.rogerthat_two'
     AckString(0)="Acknowledged"
     AckString(1)="Affirmative"
     AckString(2)="Copy"
     AckString(3)="Copy that"
     AckString(4)="OK"
     AckString(5)="Roger"
     AckString(6)="Roger that"
     numAcks=7
     FFireSound(0)=Sound'DA2Voices.heywatchit'
     FFireSound(1)=Sound'DA2Voices.heywatchit2'
     FFireSound(2)=Sound'DA2Voices.sameteammoron'
     FFireSound(3)=Sound'DA2Voices.imonyourside1'
     FFireString(0)="Hey watch it!"
     FFireString(1)="Hey watch it!!!"
     FFireString(2)="Same team moron..."
     FFireString(3)="I am on your side"
     numFFires=4
     TauntSound(0)=Sound'DA2Voices.Bubbye'
     TauntSound(1)=Sound'DA2Voices.eatthatbyatch1'
     TauntSound(2)=Sound'DA2Voices.eatthatbyatch2'
     TauntSound(3)=Sound'DA2Voices.eatthatbyatch3'
     TauntSound(4)=Sound'DA2Voices.EnemyDown'
     TauntSound(5)=Sound'DA2Voices.gapingwound'
     TauntSound(6)=Sound'DA2Voices.igotone'
     TauntSound(7)=Sound'DA2Voices.igotone_two'
     TauntSound(8)=Sound'DA2Voices.improvement'
     TauntSound(9)=Sound'DA2Voices.isthatallyoucando'
     TauntSound(10)=Sound'DA2Voices.Laugh1'
     TauntSound(11)=Sound'DA2Voices.Laugh2'
     TauntSound(12)=Sound'DA2Voices.notpretty'
     TauntSound(13)=Sound'DA2Voices.ohthatsgottahurt'
     TauntSound(14)=Sound'DA2Voices.pixelpile'
     TauntSound(15)=Sound'DA2Voices.Rubish'
     TauntSound(16)=Sound'DA2Voices.SeeYa'
     TauntSound(17)=Sound'DA2Voices.somthingburning'
     TauntSound(18)=Sound'DA2Voices.thatsgottahurt'
     TauntSound(19)=Sound'DA2Voices.Trash'
     TauntString(0)="Bubbye..."
     TauntString(1)="Eat that byatch!"
     TauntString(2)="Eat that byatch!!"
     TauntString(3)="EAT THAT BYATCH!!!"
     TauntString(4)="Enemy Down"
     TauntString(5)="Thats a gaping wound..."
     TauntString(6)="I got one!"
     TauntString(7)="I got one!!"
     TauntString(8)="Now that's an improvement"
     TauntString(9)="Is that all you can do?"
     TauntString(10)="HAHAHAHAHAHA!"
     TauntString(11)="HEHEHEHEHEHE!"
     TauntString(12)="Thats not pretty"
     TauntString(13)="Oh, thats gotta hurt?!"
     TauntString(14)="Steamin' pile of pixels..."
     TauntString(15)="Rubish"
     TauntString(16)="SeeYa"
     TauntString(17)="Something burning?"
     TauntString(18)="Now thats gotta hurt!"
     TauntString(19)="Trash"
     numTaunts=20
     OrderSound(0)=Sound'DA2Voices.getbacktobase'
     OrderSound(1)=Sound'DA2Voices.stayclosetoeachother'
     OrderSound(2)=Sound'DA2Voices.incoming2'
     OrderSound(3)=Sound'DA2Voices.coverme'
     OrderSound(4)=Sound'DA2Voices.movemovemove1'
     OrderSound(5)=Sound'DA2Voices.FollowMe'
     OrderSound(6)=Sound'DA2Voices.incoming2'
     OrderSound(7)=Sound'DA2Voices.incoming3'
     OrderSound(8)=Sound'DA2Voices.takecover'
     OrderSound(9)=Sound'DA2Voices.takecover2'
     OrderSound(10)=Sound'DA2Voices.movemovemove2'
     OrderSound(11)=Sound'DA2Voices.movemovemove3'
     OrderSound(12)=Sound'DA2Voices.ReGroup'
     OrderSound(13)=Sound'DA2Voices.weneedsomebackuphere'
     OrderSound(14)=Sound'DA2Voices.coverme'
     OrderSound(15)=Sound'DA2Voices.stayclosetoeachother'
     OrderString(2)="Attack the enemy!"
     OrderString(5)="Follow ME!"
     OrderString(6)="Incoming!"
     OrderString(7)="Incoming!!"
     OrderString(8)="Take cover!"
     OrderString(9)="Take cover !!"
     OrderString(10)="Move move move !!!"
     OrderString(11)="MOVE MOVE MOVE !!!"
     OrderString(12)="Regroup!"
     OrderString(13)="I need some backup here!"
     OrderString(14)="Cover me!"
     OrderString(15)="Stay close to each other!"
     OtherSound(0)=Sound'DA2Voices.stayclosetoeachother'
     OtherSound(1)=Sound'DA2Voices.HappyOK'
     OtherSound(2)=Sound'DA2Voices.OK'
     OtherSound(3)=Sound'DA2Voices.wheresthemedic'
     OtherSound(4)=Sound'DA2Voices.wheresthemedic_desparate'
     OtherSound(5)=Sound'DA2Voices.drivethroughplease'
     OtherString(0)="Stay close to each other!"
     OtherString(1)="OK :)"
     OtherString(2)="OK!"
     OtherString(3)="Where's the medic?"
     OtherString(4)="Where's the medic?!?!"
     OtherString(5)="Thank you drive through please"
     DeathPhrases(0)=Sound'DA2Voices.notpretty'
     DeathPhrases(1)=Sound'DA2Voices.Ptooey'
     DeathPhrases(2)=Sound'DA2Voices.isthatallyoucando'
     NumDeathPhrases=3
     VoicePackName="Defence Alliance 2 Marine"
}