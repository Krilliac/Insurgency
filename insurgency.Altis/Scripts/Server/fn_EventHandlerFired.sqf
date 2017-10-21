addEventHandler['fired', {

    _safeZonePosition = (getMarkerPos "safeZone"); 
    _range = 500; // Radius of safe zone

    // Check unit range from safe zone marker, or where they are aiming at
    if ((_this select 0) distance _safeZonePosition <= _range) || 
        ((screenToWorld [0.5, 0.5]) distance _safeZonePosition <= _range)) exitWith {
        deleteVehicle (_this select 6);
    };

}];