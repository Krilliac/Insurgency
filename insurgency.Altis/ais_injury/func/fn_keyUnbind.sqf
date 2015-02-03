private ["_key","_return"];
_key = _this select 1;
_return = false;

if ((player getVariable 'unit_is_unconscious') && {_key in [35]}) then {[player] call tcb_fnc_callHelp};	
_return = if ((player getVariable 'unit_is_unconscious') && {_key in [34]}) then {true} else {false};		

{
	if ((player getVariable 'unit_is_unconscious') && {_key in (actionkeys _x)}) then {
		_return = (_key == (actionkeys _x) select 0);
	};
} forEach ['ReloadMagazine','Gear','SwitchWeapon','Diary'];

_return