if (!isServer && isNull player) then {isJIP=true;} else {isJIP=false;};
if (!isDedicated) then {waitUntil {!isNull player && isPlayer player};};

enableSentences false;

["%1 --- Executing TcB AIS init.sqf",diag_ticktime] call BIS_fnc_logFormat;

if (!isDedicated) then {
	TCB_AIS_PATH = "ais_injury\";
	{[_x] call compile preprocessFile (TCB_AIS_PATH+"init_ais.sqf")} forEach (if (isMultiplayer) then {playableUnits} else {switchableUnits});
};

getLoadout = compile preprocessFileLineNumbers 'get_loadout.sqf';
setLoadout = compile preprocessFileLineNumbers 'set_loadout.sqf';
                                             
[] spawn {
    while{true} do {
        if(alive player) then {
            respawnLoadout = [player] call getLoadout;
        };
    sleep 2;  
    };
};

player addEventHandler ["Respawn", {
        [player, respawnLoadout] spawn setLoadout;
    }
];  

null = [] execVM "Scripts\brief.sqf";
null = [] execVM "Scripts\safezone.sqf";
null = [] execVM "Scripts\eos\OpenMe.sqf";
null = [] execVM "Scripts\groupmanager.sqf";
null = [] execVM "Scripts\Tasks\complete.sqf";

[120,120,120,120,600,120] execVM 'Scripts\cleanup.sqf';


for [ {_i = 0}, {_i < count(paramsArray)}, {_i = _i + 1} ] do {
	call compile format
	[
		"PARAMS_%1 = %2",
		(configName ((missionConfigFile >> "Params") select _i)),
		(paramsArray select _i)
	];
};

skipTime PARAMS_TimeOfDay;

0 setWindForce random 1;
0 setWindDir random 360;
0 setGusts random 1;

switch (PARAMS_Weather) do
{
	case 1: {
		0 setOvercast 0;
		0 setRain 0;
		0 setFog 0;
	};

	case 2: {
		0 setOvercast 1;
		0 setRain 1;
		0 setFog 0.2;
		0 setGusts 1;
		0 setLightnings 1;
		0 setWaves 1;
		0 setWindForce 0.5;
	};

	case 3: {
		0 setOvercast 0.7;
		0 setRain 0;
		0 setFog 0;
		0 setGusts 0.5;
		0 setWaves 0.7;
		0 setWindForce 0.3;
	};

	case 4: {
		0 setOvercast 0.7;
		0 setRain 1;
		0 setFog 0.7;
	};
};

if (PARAMS_PilotCheck == 1) then { null = [] execVM "Scripts\pilotcheck.sqf"; };
if (PARAMS_PlayerMarkers == 1) then { null = [] execVM "Scripts\playermarker.sqf"; };	

// vehicle HUD
_null = [] execVM 'scripts\groupmanager.sqf';									// group manager


null = [] execVM "playermarker.sqf";

[] execVM "anticheat.sqf"; 