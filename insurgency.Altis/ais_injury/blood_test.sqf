//fnc_usec_damageBleed = {
	/***********************************************************
	PROCESS DAMAGE TO A UNIT
	- Function fnc_usec_damageBleed: Draw a creepy blood stream from a player limb
	- [_unit, _wound, _injury] call fnc_usec_damageBleed;
	************************************************************/
	private["_wound","_modelPos","_point","_source"];
	_unit = _this select 0;
	_wound = _this select 1;

hint "an";
	_modelPos = [0,0,0];

	switch (_wound) do {
		case "Pelvis": {
			_modelPos = [0,0,0.2];
		};
		case "aimpoint": {
			_rndX = (0.1 - random 0.2);
			_modelPos = [_rndX,0,0.2];
		};
		case "RightShoulder": {
			_modelPos = [0,0,0.2];
		};
		case "LeftShoulder": {
			_modelPos = [0,0,0.2];
		};
	};

	while {true} do {
		scopeName "main";

		waitUntil {(vehicle _unit == _unit)};
		hint format ["loop %1", time];

		_point = "Logic" createVehicleLocal getPosATL _unit;
		_source = "#particlesource" createVehicleLocal getPosATL _unit;
		_source setParticleParams
		[["\Ca\Data\ParticleEffects\Universal\Universal", 16, 13, 1],"",	
		[["\a3\Data_f\ParticleEffects\Universal\Universal", 16, 13, 1],"",
		"Billboard",
		1,
		0.2,
		[0,0,0],
		[0,0,0.5],
		1,0.32,0.1,0.05,
		[0.05,0.25],
		[[0.2,0.01,0.01,1],[0.2,0.01,0.01,0]],
		[0.1],
		0,
		0,
		"",
		"",
		_point];
		_source setParticleRandom [2, [0, 0, 0], [0.0, 0.0, 0.0], 0, 0.5, [0, 0, 0, 0.1], 0, 0, 10];
		_source setDropInterval 0.02;
		_point attachTo [_unit,_modelPos,_wound];

		sleep 5;

		while {alive _unit} do {
			scopeName "loop";
			if (vehicle _unit != _unit) then {
				BreakOut "loop";
			};
			sleep 1;
		};
		deleteVehicle _source;
		deleteVehicle _point;

		if (false) then {
			BreakOut "main";
		};
	};

	deleteVehicle _source;
	deleteVehicle _point;
//};