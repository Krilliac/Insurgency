  /* Configuration */

_Enabled = true;							//Enable or disable the anticheat
_Admins = ["76561198025857979","76561197963574618","76561198012395359","76561198022038914","76561198107171318","76561198156476721","76561198132566134"]; 			//Add your admin UID here
_Use_Life_fnc_MP = false;					//If you are using altis life change this to true

//Add new cheat files & variables & menus to these lists
_DetectedFiles = ["JM3.sqf","JM3.png","wookie.sqf","wookie_wuat\start.sqf","lystoarma3\start.sqf","help.sqf","hack.sqf","cheat.sqf","JxMxE.sqf","JME.sqf","wookiev5.sqf","menu.sqf","proving_ground\fnc_ammo.sqf","proving_ground\fnc_autoheal.sqf","proving_ground\fnc_booster","proving_ground\fnc_bulletcam","proving_ground\fnc_bullettrack","proving_ground\fnc_create_vehicle","proving_ground\fnc_create_weapon","proving_ground\fnc_environment","proving_ground\fnc_exec_console.sqf","proving_ground\fnc_global.sqf","proving_ground\fnc_satcam_keyhandler.sqf","proving_ground\fnc_satcam_keyhandler_OA.sqf","proving_ground\fnc_sattelite.sqf","proving_ground\fnc_show_dialog.sqf","proving_ground\fnc_sound.sqf","proving_ground\fnc_statistics","proving_ground\fnc_status","proving_ground\fnc_target"];			
_DetectedVariables = ["ESP","Wookie","Extasy","GOD","GodMode","JxMxE_Exec","Lystic","Hack","Script","Wookie_Exec","Bypass","createVehicle","W_O_O_K_I_E_FUD_Pro_RE","W_O_O_K_I_E_FUD_Car_RE","W_O_O_K_I_E_FUD_Car_RE","W_O_O_K_I_E_FUD_FuckUp_GunStore","W_O_O_K_I_E_FUD_M_E_N_U_initMenu","W_O_O_K_I_E_FuckUp_GunStore_a",
"W_O_O_K_I_E_M_E_N_U_funcs_inited","Menu_Init_Lol","E_X_T_A_S_Y_Atm","W_O_O_K_I_E_Pro_RE","W_O_O_K_I_E_Debug_Mon","W_O_O_K_I_E_Debug_1337","Veh_S_P_A_W_N_Shitt","sfsefse","tw4etinitMenu","tw4etgetControl",
"efr4243234","sdfwesrfwesf233","sdgff4535hfgvcxghn","adadawer24_1337","lkjhgfuyhgfd","E_X_T_A_S_Y_M_E_N_U_funcs_inited","dayz_serverObjectMonitor","fsfgdggdzgfd","fsdddInfectLOL","Wookie_List",
"Wookie_Pro_RE","Wookie_Car_RE","Wookie_Debug_Mon","faze_funcs_inited","advertising_banner_infiSTAR","atext_star_xa","Monky_hax_dbclick","qopfkqpofqk","debug_star_colorful","AntiAntiAntiAntiHax","antiantiantiantih4x",
"hub","scrollinit","gfYJV","Lystic_LMAOOOOOOOOOOOOOOOOOOO","Lystic_Re","Lysto_Lyst","E_X_T_A_S_Y_Keybinds","Menulocations","Lystic_Init","scroll_m_init_star","exstr1","pathtoscrdir3","Monky_funcs_inited",
"Monky_initMenu","player_zombieCheck","E_X_T_A_S_Y_Recoil","godlol","playericons","abcdefGEH","wierdo","go_invisible_infiSTAR","serverObjectMonitor","enamearr","initarr3","locdb","sCode","infAmmoIndex",
"nukeDONEstar","Wookie_List","Wookie_Pro_RE","FUCKTONIC","E_X_T_A_S_Y_FuckUp_GunStore_a","E_X_T_A_S_Y_Cash_1k_t","E_X_T_A_S_Y_Cash_a","E_X_T_A_S_Y_LicenseDrive","E_X_T_A_S_Y_Menu_LOOOOOOOOOL"];
_DetectedMenus = [3030],[64],[101],[162],[129];
/* End Configuration */

if(!_Enabled) exitWith {};

_toCompilableString = {
	_code = _this select 0;
	_string = "";
	if(typename _code == "CODE") then {
		_string = str(_code);
		_arr = toArray(_string);
		_arr set[0,32];
		_arr set[count(_arr)-1,32];
		_string = toString(_arr);
	};
	_string;
};
//Protect BIS_fnc_MP
BIS_fnc_MP = compileFinal ([BIS_fnc_MP] call _toCompilableString);
BIS_fnc_MPExec = compileFinal ([BIS_fnc_MPExec] call _toCompilableString);

//Protect AH_fnc_MP
if(_Use_Life_fnc_MP) then {
	Life_fnc_MP = compileFinal ([Life_fnc_MP] call _toCompilableString);
	AH_fnc_MP = compileFinal ([Life_fnc_MP] call _toCompilableString);
	life_fnc_tazed = compileFinal ([life_fnc_tazed] call _toCompilableString);
} else {
	AH_fnc_MP = compileFinal ([BIS_fnc_MP] call _toCompilableString);
};

if(isDedicated) then {
	diag_log "<ANTICHEAT>: Initialized!";
	Notify_Kick = compileFinal '
		diag_log "<ANTICHEAT> Kicked User";
		diag_log str(_this);
		diag_log "<ANTICHEAT> End Kicked";
		[_this,"Receive_Notify",true,false] call AH_fnc_MP;
	';
	Notify_Load = compileFinal '
		diag_log format["<ANTICHEAT> %1",_this];
	';

	[] spawn {
		while{true} do {
			{
				_x hideObjectGlobal false;
			} forEach playableUnits;
			_time = time + 2;
			waitUntil{time >= _time};
		};
	};	

} else {
	waitUntil{!isnull player};
	waitUntil{alive player};
	Receive_Notify = compileFinal "
		hint format['%1 was kicked for %2. Notify an admin!',_this select 0,_this select 2];
	";

	if(getplayeruid player in _Admins) exitWith {
		hint "WELCOME ADMIN";
		[[format["The Admin %1 has Joined",name player]],"Notify_Load",false,false] call AH_fnc_MP; 
	};		

	Kick = compileFinal "
		endMission 'FAIL';
		for '_i' from 0 to 100 do {(findDisplay _i) closeDisplay 0;};
		disableUserInput true;
	";

	[_DetectedFiles] spawn {
		_name = name player;
		_uid = getplayeruid player;
		loadFile "";
		{
			_text = loadFile _x;
			_numLetters = count(toArray(_text));
			if(_numLetters > 0) exitWith {
				[[_name,_uid,format["Bad Script: %1",_x]],"Notify_Kick",false,false] call AH_fnc_MP;
				call Kick;
			};
		} foreach (_this select 0);
	};
	[_DetectedVariables] spawn {
		_name = name player;
		_uid = getplayeruid player;
		{
			_x spawn {
				waitUntil{!isNil _this};
				[[_name,_uid,format["Bad Variable: %1",_this]],"Notify_Kick",false,false] call AH_fnc_MP;
				call Kick;
			};
		} forEach (_this select 0);
	};
	[_DetectedMenus] spawn {
		_name = name player;
		_uid = getplayeruid player;
		{
			_x spawn {
				waitUntil{!isNUll (findDisplay _this)};
				[[_name,_uid,format["Bad Menu: %1",_this]],"Notify_Kick",false,false] call AH_fnc_MP;
				call Kick;
			};
		} forEach (_this select 0);
	};
	[] spawn {
		_name = name player;
		_uid = getplayeruid player;
		while{true} do {
			if(unitRecoilCoefficient player < 1) exitWith {
				[[_name,_uid,"Recoil Hack"],"Notify",false,false] call AH_fnc_MP;
				//call Kick;
			};
			_time = time + 5;
			setTerrainGrid 25;
			_nearObjects = vehicle player nearObjects 50;
			{
				vehicle player enableCollisionWith _x;
			} forEach _nearObjects;
			waitUntil{time >= _time};
		};
	};
	[] spawn {
		while{true} do {
			onMapSingleClick '';
			player allowDamage true;
			vehicle player allowDamage true;
		};
	};
	[] spawn {
		while{true} do {
			waitUntil{!isNull (findDisplay 49)};
			((findDisplay 49) displayCtrl 2) ctrlEnable false;
			((findDisplay 49) displayCtrl 2) ctrlSetText "Server Protection By:";
			((findDisplay 49) displayCtrl 103) ctrlEnable false;
			((findDisplay 49) displayCtrl 103) ctrlSetText "Krill's Heuristics";
			((findDisplay 49) displayCtrl 122) ctrlEnable false;
			((findDisplay 49) displayCtrl 122) ctrlShow false;
			((findDisplay 49) displayCtrl 523) ctrlSetText "v1";
			waitUntil{isNull (findDisplay 49)}
		};
	};
	[[format["The Player %1 Has Initialized",name player]],"Notify_Load",false,false] call AH_fnc_MP; 
};

_exists = loadFile "AdminMenu.sqf";
if(_exists != "") then {
	call compile preprocessfilelinenumbers "AdminMenu.sqf";
};