_unit = _this select 1;

haloed = true;
openMap true;
hintSilent "Click on map to mark position for halo insertion.";
onMapSingleClick "player setPos [(_pos select 0), (_pos select 1), 600]; haloed = false;hint 'Halo initialized. Remember to open parachute.'";
waitUntil{!haloed};
onMapSingleClick "";
openMap false;

if (isDedicated) exitWith {};

_pack = typeof (unitBackpack _unit);
_loadout = [player] call getLoadout;
removeBackpack player;

_unit addBackpack "B_Parachute";

_nil = [_unit,_pack, _loadout] spawn {
	_unit = _this select 0;
	_pack = _this select 1;
	_loadout = _this select 2;
	
	waitUntil {animationState _unit == "para_pilot"}; 

	waitUntil {isTouchingGround _unit || (getPosASL _unit) select 2 < 0.1};

	_loadout = [player, _loadout] call setLoadout;
};