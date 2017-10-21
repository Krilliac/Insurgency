if (!isServer && isNull player) then {isJIP=true;} else {isJIP=false;};
if (!isDedicated) then {waitUntil {!isNull player && isPlayer player};};

enableSentences false;
enableSaving [false,false];
enableTeamswitch false;

if (isServer) then {
null = [] execVM "Scripts\brief.sqf";
null = [] execVM "Scripts\Tasks\complete.sqf";
["%1 --- Executing Briefing and Tasks",diag_ticktime] call BIS_fnc_logFormat;
};

if (isServer) then {
null = [] execVM "Scripts\eos\OpenMe.sqf";
["%1 --- Executing EOS Markers",diag_ticktime] call BIS_fnc_logFormat;
};

/*
if (isServer) then {
null = [] execVM "Scripts\Server\fn_EventHandlerFired.sqf";
["%1 --- Executing EventHandlerFired",diag_ticktime] call BIS_fnc_logFormat;
};

if (isServer) then {
null = [] execVM "Scripts\Server\fn_EventHandlerHandleDamage.sqf";
["%1 --- Executing EventHandlerHandleDamage",diag_ticktime] call BIS_fnc_logFormat;
};
*/

[120,120,120,120,600,120] execVM 'Scripts\cleanup.sqf';
["%1 --- Executing Cleanup Script",diag_ticktime] call BIS_fnc_logFormat;

//if (PARAMS_PilotCheck == 1) then { null = [] execVM "Scripts\pilotcheck.sqf"; };
//if (PARAMS_PlayerMarkers == 1) then { null = [] execVM "Scripts\playermarker.sqf"; };	

//null = [] execVM "Scripts\playermarker.sqf";
//["%1 --- Executing Cleanup Script",diag_ticktime] call BIS_fnc_logFormat;
