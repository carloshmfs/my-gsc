#include maps\mp\zombies\_zm_utility;

init()
{
	level thread onPlayerConnect();
	level thread onPlayerMessage();
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