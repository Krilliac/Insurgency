if (!isServer) exitwith {};
if(!isServer && !hasInterface) then{
sleep 1;
_eosMarkers = profileNamespace GetVariable "EOSmarkers";
{
waituntil {getMarkerColor _x == "ColorGreen";};
}foreach _eosMarkers;

["Task1","succeeded"] call SHK_Taskmaster_upd;

["Altis has been secured from the enemey opposition. Great Job. Thank you for playing on Altis Insurgency.",True,true] call BIS_fnc_endMission;
forceEnd;
};