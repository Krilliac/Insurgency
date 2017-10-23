if (!isServer && isNull player) then {isJIP=true;} else {isJIP=false;};
if (!isDedicated) then {waitUntil {!isNull player && isPlayer player};};

//Make sure the HC1 Entity exists in a way.
if(isNil "HC1") exitWith {hint "The Headless Client is not connected.";};

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

if (hasInterface) then { systemchat "Insurgency Version 1.1"};
if (hasInterface) then { systemchat "----CHANGELOG----"};
if (hasInterface) then { systemchat "Added more objects to Base"};
if (hasInterface) then { systemchat "Fixed AAF being spawned as OPFOR"};
if (hasInterface) then { systemchat "Music now plays when you enter the server"};
if (hasInterface) then { systemchat "Epic Color Corrections and this changelog ;)"};

{
   private ["_group", "_leader", "_data"];
   _group  = group player;
   _leader = leader _group;
   _data   = [nil, "Blufor Delta", false]; // [<Insignia>, <Group Name>, <Private>]
 
   ["RegisterGroup", [_group, _leader, _data]] call BIS_fnc_dynamicGroups;
};