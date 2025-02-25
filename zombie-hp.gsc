#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\zombies\_zm;
#include maps\mp\zombies\_zm_utility;
#include maps\mp\gametypes_zm\_hud_util;

init()
{
	initZombieHealthDisplay();
}

initZombieHealthDisplay()
{
	HpDisplay = createServerFontString("objective", 1.4);
	HpDisplay setPoint("BOTTOM RIGHT", "BOTTOM RIGHT", 0, 0, 0.5);
	HpDisplay.x = HpDisplay.x - 150;
	HpDisplay.hideWhenInMenu = 1;
	HpDisplay.archived = 0;
	HpDisplay.y = HpDisplay.y - 50;
	flag_wait("initial_blackscreen_passed");

	level thread ZH_monitor(HpDisplay);
	level thread ZH_hideOnEndGame(HpDisplay);
}

get_first_zombie()
{
	zombie_array = get_round_enemy_array();
	if ( isDefined( zombie_array ) && isDefined( zombie_array[0] ) ) {
		return zombie_array[0];
	}

	return undefined;
}

get_current_zombies_health()
{
	zombie = get_first_zombie();
	if ( isDefined( zombie ) && isDefined( zombie.health ) ) {
		return zombie.health;
	}

	return undefined;
}

ZH_monitor(HpDisplay)
{
	level endon("disconnect");

	last_zm_health_measured = 0;
	
	for ( ;; )
	{
		zm_health = get_current_zombies_health();
		if ( !isDefined( zm_health ) ) {
			zm_heath = last_zm_health_measured;
		}

		// IPrintLn( "ZOMBIE HP: " + zm_health );
		HpDisplay setText("Zombie HP: " + level.zombie_health);

		last_zm_health_measured = zm_health;

		wait 1;
	}
}

ZH_hideOnEndGame(HpDisplay)
{
	level waittill("end_game");
	// HpDisplay affectElement("alpha", 4, 0);
	wait 4;
	HpDisplay destroy();
}

onPlayerConnect()
{
	for ( ;; )
	{
		level waittill( "connecting", player );
		player thread onPlayerSpawned();
        player thread onPlayerDamaged();
        player thread onPlayerStartSprint();
	}
}

onPlayerStartSprint()
{
    for ( ;; )
	{
        self waittill( "sprint_begin" );
		self IPrintLn( "TA CORRENDO"  );
    }
}

onPlayerMessage()
{
    for ( ;; ) 
	{
        self waittill( "say", message, player );

		if (message == ".zp") {
			zombie_health = get_current_zombies_health();
			if ( isDefined(zombie_health) ) {
				player IPrintLn( "PINTO CU BOSTA " + zombie_health );
			}
		}
    }
}

onPlayerDamaged()
{
    for ( ;; ) 
    {
        self waittill( "damage", player, attacker, amount, direction, type );
		self IPrintLn( "DANO attacker " + attacker  );
		self IPrintLn( "DANO amount " + amount  );
		self IPrintLn( "DANO direction " + direction  );
		self IPrintLn( "DANO type " + type  );
    }
}

onPlayerSpawned()
{
	level endon( "game_ended" );
    self endon( "disconnect" );
	
	for( ;; )
	{
		self waittill( "spawned_player" );
		self IPrintLn( "VADIAS PONTO COM" );
	}
}