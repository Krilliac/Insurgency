if(!isMultiplayer) exitWith {};
tawvd_foot = viewDistance;
tawvd_car = viewDistance;
tawvd_air = viewDistance;
tawvd_addon_disable = true;

[] spawn
{
	waitUntil {!isNull player && player == player};
	waitUntil{!isNil "BIS_fnc_init"};
	waitUntil {!(isNull (findDisplay 46))};

	tawvd_action = player addAction["<t color='#ffffff'>Settings</t>",TAWVD_fnc_openTAWVD,[],-99,false,false,"",''];

	[] spawn TAWVD_fnc_trackViewDistance;
};