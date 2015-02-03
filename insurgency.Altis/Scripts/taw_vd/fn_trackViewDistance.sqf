private["_old","_recorded"];
while {true} do
{
	_recorded = vehicle player;
	if(!alive player) then
	{
		_old = player;
		_old removeAction tawvd_action;
		waitUntil {alive player};
		tawvd_action = player addAction["<t color='#ffffff'>Settings</t>",TAWVD_fnc_openTAWVD,[],-99,false,false,"",''];
	};
	[] call TAWVD_fnc_updateViewDistance;
	waitUntil {_recorded != vehicle player || !alive player};
};