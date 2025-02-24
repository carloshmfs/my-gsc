
init()
{
	level thread onplayerconnect();
}

onplayerconnect()
{
	for ( ;; )
	{
		level waittill( "connecting", player );
		player thread onplayerspawned();
        player thread onplayerdamaged();
        // player thread onplayertext();
        player thread OnPlayerStartSprint();
	}
}

OnPlayerStartSprint()
{
    for ( ;; )
    {
        self waittill( "sprint_begin" );
		self IPrintLn( "TA CORRENDO"  );
    }
}

onplayertext()
{
    for ( ;; )
    {
        self waittill( "message" );
		self IPrintLn( "OLHA A MENSAGEM"  );
    }
}

onplayerdamaged()
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

onplayerspawned()
{
	level endon( "game_ended" );
    self endon( "disconnect" );
	
	for( ;; )
	{
		self waittill( "spawned_player" );
		self IPrintLn( "VADIAS PONTO COM" );
	}
}