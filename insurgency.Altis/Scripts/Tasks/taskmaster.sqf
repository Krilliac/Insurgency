DEBUG = true;

  SHK_Taskmaster_initDone = false;
  SHK_Taskmaster_add = {

    if(!isServer && !hasInterface) then{
      private ["_name","_short","_long","_cond","_marker","_state","_dest"];
      _name = _this select 0;
      _short = _this select 1;
      _long = _this select 2;
      if (count _this > 3) then { _cond = _this select 3 } else { _cond = true };
      if (count _this > 4) then { _marker = _this select 4 } else { _marker = [] };
      if (count _this > 5) then { _state = _this select 5 } else { _state = "created" };
      if (count _this > 6) then { _dest = _this select 6 } else { _dest = 0 };
      SHK_Taskmaster_Tasks set [count SHK_Taskmaster_Tasks, [_name,_short,_long,_cond,_marker,_state,_dest]];
      publicvariable "SHK_Taskmaster_Tasks";

      if (!isdedicated && SHK_Taskmaster_initDone) then {
        SHK_Taskmaster_Tasks spawn SHK_Taskmaster_handleEvent;
      };
    };
  };
  SHK_Taskmaster_addNote = {

    private "_cond";
    if (count _this > 2) then { _cond = _this select 2 } else { _cond = true };
    {
      if ( [_x,_cond] call SHK_Taskmaster_checkCond ) then {
        _x creatediaryrecord ["Diary",[_this select 0,_this select 1]];
        if (time > 10) then{ hintsilent "Diary note added." };
      };
    } foreach  (if ismultiplayer then {playableunits} else {switchableunits});
  };
  SHK_Taskmaster_addTask = {

    private ["_handle","_handles","_name","_state","_marker","_dest"];
    _handles = [];
    _name = _this select 0;
    _marker = _this select 4;
    _state = _this select 5;
    _dest = _this select 6;
    if DEBUG then { diag_log format ["SHK_Taskmaster> addTask: %1, %2, %3, %4",_name,_marker,_state,_dest]};
    {
      if ( [_x,(_this select 3)] call SHK_Taskmaster_checkCond ) then {
        _handle = _x createsimpletask [_name];
        _handle setsimpletaskdescription [(_this select 2),(_this select 1),""];
        _handle settaskstate _state;
        
        switch (toupper(typename _dest)) do {
          case "OBJECT": { _handle setsimpletasktarget [_dest,true] };
          case "STRING": { _handle setsimpletaskdestination (getmarkerpos _dest) };
          case "ARRAY": { _handle setsimpletaskdestination _dest };
        };
        
        _handles set [count _handles,_handle];
        
        if (_x == player) then {
          if (SHK_Taskmaster_showHints) then { [_handle,_state] call SHK_Taskmaster_showHint };
          
          if (count _marker > 0) then {
            if !(_state in ["succeeded","failed","canceled"]) then {
              if (typename (_marker select 0) == typename "") then {
                _marker = [_marker];
              };
              private ["_m","_type","_color","_txt","_shape","_size"];
              {
                _m = createmarkerlocal [(_x select 0),(_x select 1)];
                
                _type = "selector_selectedMission";
                if (count _x > 2) then {
                  private "_tmp";
                  _tmp = (_x select 2); 
                  if (_tmp != "") then {
                    _type = _tmp;
                  };
                };
                _m setmarkertypelocal _type;
                
                _color = "ColorRed";
                if (count _x > 3) then {
                  private "_tmp";
                  _tmp = (_x select 3);
                  if (_tmp != "") then {
                    _color = _tmp;
                  };
                };
                _m setmarkercolorlocal _color;
                
                _txt = "";
                if (count _x > 4) then {
                  private "_tmp";
                  _tmp = (_x select 4);
                  if (_tmp != "") then {
                    _txt = _tmp;
                  };
                };
                _m setmarkertextlocal _txt;
                
                _shape = "ICON";
                if (count _x > 5) then {
                  private "_tmp";
                  _tmp = (_x select 5);
                  if (_tmp != "") then {
                    _shape = _tmp;
                  };
                };
                _m setmarkershapelocal _shape;
                
                _size = [1,1];
                if (count _x > 6) then {
                  private "_tmp";
                  _tmp = (_x select 6);
                  if (typeName _tmp == typeName 0) then {
                    _tmp = [_tmp,_tmp];
                  };
                  if !([_tmp,[1,1]] call BIS_fnc_areEqual) then {
                    _size = _tmp;
                  };
                };
                _m setmarkersizelocal _size;
                
              } foreach _marker;
            };
          };
        };
      };
    } foreach (if ismultiplayer then {playableunits} else {switchableunits});
    SHK_Taskmaster_TasksLocal set [count SHK_Taskmaster_TasksLocal,[_name,_state,_handles]];
  };
  SHK_Taskmaster_areCompleted = {

    private ["_b"];
    _b = false;
    _b = _this call SHK_Taskmaster_isCompleted;
    _b;
  };
  SHK_Taskmaster_assign = {

    if(!isServer && !hasInterface) then{
      private "_task";
      for "_i" from 0 to (count SHK_Taskmaster_Tasks - 1) do {
        if (_this == ((SHK_Taskmaster_Tasks select _i) select 0)) then {
          _task =+ SHK_Taskmaster_Tasks select _i;
          _task set [5,"assigned"];
          SHK_Taskmaster_Tasks set [_i,_task];
        };
      };
      publicvariable "SHK_Taskmaster_Tasks";
 
      if (!isdedicated && SHK_Taskmaster_initDone) then {
        SHK_Taskmaster_Tasks spawn SHK_Taskmaster_handleEvent;
      };
    };
  };
  SHK_Taskmaster_checkCond = {

    private ["_unit","_cond"];
    _unit = _this select 0;
    _cond = _this select 1;
    if (!isNil "_cond") then {
      if DEBUG then { diag_log format ["SHK_Taskmaster> typename condition: %1",typename _cond]};
      switch (typename _cond) do {
        case (typename grpNull): { (_unit in (units _cond)) };
        case (typename objNull): { _unit == _cond };
        case (typename WEST):    { (side _unit == _cond) };
        case (typename true):    { _cond };
        case (typename ""): {
          if (_cond call SHK_Taskmaster_isFaction) then {
            (faction _unit == _cond)
          } else {
            (call compile format ["%1",_cond])
          };
        };
        default { false };
      };
    } else { false };
  };
  SHK_Taskmaster_getAssigned = {

    private "_l";
    _l = [];
    {
      if ((_x select 5) == "assigned") then {
        _l set [count _l,(_x select 0)];
      };
    } foreach SHK_Taskmaster_Tasks;
    _l;
  };
  SHK_Taskmaster_getState = {

    private "_s";
    {
      if (_this == (_x select 0)) exitwith {
        _s = (_x select 5);
      };
    } foreach SHK_Taskmaster_Tasks;
    _s;
  };
  SHK_Taskmaster_handleEvent = {

    waituntil {alive player};
    private "_name";
    {
      _name = _x select 0;
      if (_name call SHK_Taskmaster_hasTaskLocal) then {
        if ([_name,(_x select 5)] call SHK_Taskmaster_hasStateChanged) then {
          if DEBUG then { diag_log format ["SHK_Taskmaster> handleEvent calling updateTask: %1",_name]};
          _x call SHK_Taskmaster_updateTask;
        };
      } else {
        if DEBUG then { diag_log format ["SHK_Taskmaster> handleEvent calling addTask: %1",_name]};
        _x call SHK_Taskmaster_addTask;
      };
    } foreach _this;
  };
  SHK_Taskmaster_hasState = {

    private "_b";
    _b = false;
    {
      if ((_this select  0) == (_x select 0)) then {
        if (((_this select 0) call SHK_Taskmaster_getState) == (_this select 1)) then {
          _b = true;
        };
      };
    } foreach SHK_Taskmaster_Tasks;
    _b;
  };
  SHK_Taskmaster_hasStateChanged = {

    private "_b";
    _b = false;
    {
      if ((_this select 0) == (_x select 0)) then {
        if ((_this select 1) != (_x select 1)) exitwith {
          _b = true;
        };
      };
    } foreach SHK_Taskmaster_TasksLocal;
    _b;
  };
  SHK_Taskmaster_hasTask = {

    private "_b";
    _b = false;
    {
      if (_this == (_x select 0)) exitwith { _b = true };
    } foreach SHK_Taskmaster_Tasks;
    _b;
  };
  SHK_Taskmaster_hasTaskLocal = {

    private "_b";
    _b = false;
    {
      if (_this == (_x select 0)) exitwith { _b = true };
    } foreach SHK_Taskmaster_TasksLocal;
    _b;
  };
  SHK_Taskmaster_isCompleted = {

    private ["_b","_t","_i","_foreachIndex"];
    _b = false;
    if (typeName _this == typeName "") then {
      _this = [_this];
    };
    
    {
      _t = _x;
      _i = _foreachIndex;
      {
        if (_t == (_x select 0)) then {
          if ((_x select 5) in ["succeeded","failed","canceled"]) then {
            _this set [_i,true];
          } else {
            _this set [_i,false]
          };
        } else {                           
            _this set [_i, false];          
        };                                  
      } foreach SHK_Taskmaster_Tasks;
    } foreach _this;
    
    if ({_x} count _this == count _this) then {
      _b = true;
    };
    
    _b;
  };
  SHK_Taskmaster_isFaction = {

    private ["_cond", "_cfg", "_result"];
    _cond = _this;
    _cfg = configFile >> "cfgFactionClasses";
    _result = false;
    for "_i" from 0 to (count _cfg)-1 do {
      if (configName (_cfg select _i) == _cond) exitWith {
        _result = true;
      };
    };
    _result;
  };
  SHK_Taskmaster_setCurrentLocal = {

    {
      if (_this == (_x select 0)) exitwith {
        private "_handle";
        {
          _handle = _x;
          {
            if (_handle in (simpletasks _x)) then {
              _x setcurrenttask _handle;
              
              if (_x == player) then {
                if (SHK_Taskmaster_showHints) then { [_handle,"Assigned"] call SHK_Taskmaster_showHint };
              };
            };
          } foreach (if ismultiplayer then {playableunits} else {switchableunits});
        } foreach (_x select 2);
      };
    } foreach SHK_Taskmaster_TasksLocal;
  };
  SHK_Taskmaster_showHint = {
    private ["_p", "_taskCase"];
    _p = switch (tolower (_this select 1)) do {
      case "created": {   _taskCase = "TaskCreated" };
      case "assigned": {  _taskCase = "TaskAssigned" };
      case "succeeded": { _taskCase = "TaskSucceeded" };
      case "failed": {    _taskCase = "TaskFailed" };
      case "canceled": {  _taskCase = "TaskCanceled" };
    };
    [_taskCase, ["", format ["%1", ((taskDescription (_this select 0)) select 1)]]] spawn BIS_fnc_showNotification;
  };
  SHK_Taskmaster_upd = {

    if isserver then {
      private ["_task","_state"];
      _state = (_this select 1);
      for "_i" from 0 to (count SHK_Taskmaster_Tasks - 1) do {
        _task =+ (SHK_Taskmaster_Tasks select _i);
        if ((_task select 0) == (_this select 0)) then {
          _task set [5,_state];
        };
        SHK_Taskmaster_Tasks set [_i,_task];
      };
      if (count _this > 2) then {
        switch (typename (_this select 2)) do {
          case (typename ""): { (_this select 2) call SHK_Taskmaster_assign };
          case (typename []): { (_this select 2) spawn { sleep 1; _this call SHK_Taskmaster_add} };
        };
      };
      publicvariable "SHK_Taskmaster_Tasks";

      if (!isdedicated && SHK_Taskmaster_initDone) then {
        SHK_Taskmaster_Tasks spawn SHK_Taskmaster_handleEvent;
      };
    };
  };
  SHK_Taskmaster_updateTask = {

    private ["_task","_name","_state","_handle","_marker"];
    for "_i" from 0 to (count SHK_Taskmaster_TasksLocal - 1) do {
      _task =+ SHK_Taskmaster_TasksLocal select _i;
      _name = _task select 0;
      if (_name == (_this select 0)) then {
        _marker = _this select 4;
        _state = _this select 5;
        _task set [1,_state];
        SHK_Taskmaster_TasksLocal set [_i,_task];
        {
          _handle = _x;
          {
            if (_handle in (simpletasks _x)) then {
              _handle settaskstate _state;
              
              if (_x == player) then {
                if (SHK_Taskmaster_showHints) then { [_handle,_state] call SHK_Taskmaster_showHint };
                
                if (count _marker > 0) then {
                  if (_state in ["succeeded","failed","canceled"]) then {
                    if DEBUG then { diag_log format ["SHK_Taskmaster> updateTask deleting marker: %1, state: %2",_marker,_state]};
                    if (typename (_marker select 0) == typename "") then {
                      _marker = [_marker];
                    };
                    {
                      deletemarkerlocal (_x select 0);
                    } foreach _marker;
                  };
                };
              };
            };
          } foreach (if ismultiplayer then {playableunits} else {switchableunits});
        } foreach (_task select 2);
      };
    };
  };

if(!isServer && !hasInterface) then{
  SHK_Taskmaster_Tasks = []; 

  if (!isnil "_this") then {
    if (count _this > 0) then {
      private ["_task","_tasks","_i"];
      _tasks = _this select 0;
      {
        _x call SHK_Taskmaster_add;
      } foreach _tasks;
    };
  };
  publicvariable "SHK_Taskmaster_Tasks";
  if DEBUG then {
    diag_log "-- SHK_Taskmaster_Tasks --";
    diag_log SHK_Taskmaster_Tasks;
  };
  
};

if !isdedicated then {
  SHK_Taskmaster_showHints = false;
  SHK_Taskmaster_TasksLocal = []; 

  if (!isnil "_this") then {
    if (count _this > 1) then {
      private ["_notes","_i"];
      _notes = _this select 1;
      for [{_i=(count _notes - 1)},{_i>-1},{_i=_i-1}] do {
        (_notes select _i) call SHK_Taskmaster_addNote;
      };
    };
  };

  [] spawn {
    waituntil {!isnull player};
    waituntil {!isnil "SHK_Taskmaster_Tasks"};
    if DEBUG then {diag_log format ["SHK_Taskmaster> Tasks received first time: %1",SHK_Taskmaster_Tasks]};
    private "_sh";
    _sh = SHK_Taskmaster_Tasks spawn SHK_Taskmaster_handleEvent;
    waituntil {scriptdone _sh};
    
    SHK_Taskmaster_showHints = true;
    SHK_Taskmaster_initDone = true;

    "SHK_Taskmaster_Tasks" addpublicvariableeventhandler {
      (_this select 1) spawn SHK_Taskmaster_handleEvent;
    };
  };
};