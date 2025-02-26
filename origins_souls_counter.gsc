#include maps\mp\zm_tomb_challenges;
#include common_scripts\utility;

/*
    Mod: origins_souls_counter

    This script displays the remaining souls on the box challenge.
*/
init()
{
    initOrigins();
}

initOrigins()
{
    a_boxes = getentarray( "foot_box", "script_noteworthy" );
    array_thread( a_boxes, ::onSoulAbsorbed );

}

onSoulAbsorbed()
{
    self.m_souls_absorbed = 0;
    self thread onRobotFootStomp();

    for ( ;; )
    {
        self waittill( "soul_absorbed", player );
        self.m_souls_absorbed++;
        
        // Here you can display the souls the way you prefer.
        player IPrintLn( "ALMA ABSORVIDA " + self.m_souls_absorbed + "/30" );
    }
}

onRobotFootStomp()
{
    self endon( "box_finished" );

    for ( ;; )
    {
        self waittill( "robot_foot_stomp" );
        self.m_souls_absorbed = 0;
    }
}