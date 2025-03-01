#include maps\mp\zombies\_zm;

/*
    Mod: afk

    This script adds the feature to afk safely during a zombies match.
*/
init()
{
	initAFK();
}

initAFK()
{
    level thread onPlayerConnect();
    level thread onPlayerMessage();
}

onPlayerConnect()
{
    self endon("end_game");

    for (;;)
    {
        level waittill( "connecting", player );
        player.is_afk = false;
    }
}

enableAFK(player)
{
    player.is_afk = true;
    player IPrintLn("ATIVANDO O MODO AFK");
    player.sessionstate = "spectator";
    player.pers["team"] = "spectator";
    set_third_person(0);
}

disableAFK(player)
{
    player.is_afk = false;
    player IPrintLn("DESATIVANDO O MODO AFK");
    player.sessionstate = "playing";
    set_third_person(0);
    // player.pers["team"] = "spectator";
}

onPlayerMessage()
{
    for (;;)
    {
        self waittill( "say", message, player );
    
        if (message == ".afk") {
            if (player.is_afk) {
                disableAFK(player);
            } else {
                enableAFK(player);
            }
        }
    }
}