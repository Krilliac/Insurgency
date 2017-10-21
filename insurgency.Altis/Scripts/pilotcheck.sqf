if (isServer) then {
true spawn {

    _pilots = ["B_Helipilot_F","B_Soldier_TL_F"];
    _aircraft_nocopilot = [];

    waitUntil {player == player};

    _iampilot = ({typeOf player == _x} count _pilots) > 0;

    while { true } do {
        _oldvehicle = vehicle player;
        waitUntil {vehicle player != _oldvehicle};

        if(vehicle player != player) then {
            _veh = vehicle player;
			
            if((_veh isKindOf "Helicopter" || _veh isKindOf "Plane") && !(_veh isKindOf "ParachuteBase")) then {
				if(({typeOf _veh == _x} count _aircraft_nocopilot) > 0) then {
					_forbidden = [_veh turretUnit [0]];
					if(player in _forbidden) then {
						systemChat "Co-pilot is disabled on this vehicle";
						player action ["getOut", _veh];
					};
				};
				if(!_iampilot) then {
					_forbidden = [driver _veh];
					if(player in _forbidden) then {
						systemChat "You must be a pilot to operate this aircraft";
						player action ["getOut", _veh];
						};
					};
				};
			};
		};
	};
}; 