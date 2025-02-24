
init()
{
	level thread onPlayerConnect();
	level thread onPlayerMessage();
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
		player IPrintLn( "OLHA A MENSAGEM " + player.health  );
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