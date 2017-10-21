if(!isServer && !hasInterface) then{
_eosMarkers = profileNamespace GetVariable "EOSmarkers";

{_x setMarkerAlpha (MarkerAlpha _x);
_x setMarkercolor (getMarkercolor _x);
}foreach _eosMarkers;
};
