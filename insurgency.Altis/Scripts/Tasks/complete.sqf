if (!isServer) exitwith {};
sleep 1;
_eosMarkers=server getvariable "EOSmarkers";
{
waituntil {getMarkerColor _x == "ColorGreen";};
}foreach _eosMarkers;

["Task1","succeeded"] call SHK_Taskmaster_upd;

["Altis has been secured from the enemey opposition. Great Job. Thank you for playing on [AFO] - Advanced Force Operations.",True,true] call BIS_fnc_endMission;
forceEnd;