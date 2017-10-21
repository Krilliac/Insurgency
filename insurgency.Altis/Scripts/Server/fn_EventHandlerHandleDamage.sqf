addEventHandler['handleDamage', {

    _unit = (_this select 0);
    _pos = (ASLtoATL visiblePositionASL _unit);

    // Abort and ignore damage if inside range of safe zone
    if(_pos distance (getMarkerPos "safeZone") <= 500) exitWith { false };

    // Return damage normally if we're outside
    (_this select 2)

}];