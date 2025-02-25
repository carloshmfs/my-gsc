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

ZH_monitor(HpDisplay)
{
	level endon("disconnect");

	for ( ;; )
	{
		HpDisplay setText("Zombie HP: " + level.zombie_health);
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