private _spawnPos1 = getPos enemySpawn1Zone2; 
private _spawnPos2 = getPos enemySpawn2Zone2; 
private _spawnPos3 = getPos enemySpawn3Zone2; 

private _markerPos1 = getPos zone2Central;
private _markerPos2 = getPos zone2Central;
private _markerPos3 = getPos zone2Central;

private _side = east;
private _unitTypes = ["O_Soldier_F", "O_Soldier_LAT_F", "O_medic_F"];
private _numUnits = 3;

private _group1 = createGroup _side;
private _group2 = createGroup _side;
private _group3 = createGroup _side;

for "_i" from 1 to _numUnits do {
	private _unitType = selectRandom _unitTypes;
	private _unit1 = _group1 createUnit [_unitType, _spawnPos1, [], 0, "FORM"];
	private _unit2 = _group2 createUnit [_unitType, _spawnPos2, [], 0, "FORM"];
	private _unit3 = _group3 createUnit [_unitType, _spawnPos3, [], 0, "FORM"];
};

private _waypoint1 = _group1 addWaypoint [_markerPos1, 0];
private _waypoint2 = _group2 addWaypoint [_markerPos2, 0];
private _waypoint3 = _group3 addWaypoint [_markerPos3, 0];

_waypoint1 setWaypointType "MOVE";
_waypoint1 setWaypointCompletionRadius 10;
_group1 setBehaviour "AWARE";

_waypoint2 setWaypointType "MOVE";
_waypoint2 setWaypointCompletionRadius 10;
_group2 setBehaviour "AWARE";

_waypoint3 setWaypointType "MOVE";
_waypoint3 setWaypointCompletionRadius 10;
_group3 setBehaviour "AWARE";

private _markerDir1 = 300;
private _markerDir2 = 300;
private _markerDir3 = 280;

private _markerColor = "ColorRed";
private _markerType = "mil_arrow";

private _markerName1 = "MyMarker1";
private _markerName2 = "MyMarker2";
private _markerName3 = "MyMarker3";

createMarker [_markerName1, _spawnPos1];
createMarker [_markerName2, _spawnPos2];
createMarker [_markerName3, _spawnPos3];

_markerName1 setMarkerDir _markerDir1;
_markerName1 setMarkerColor _markerColor;
_markerName1 setMarkerType _markerType;

_markerName2 setMarkerDir _markerDir2;
_markerName2 setMarkerColor _markerColor;
_markerName2 setMarkerType _markerType;

_markerName3 setMarkerDir _markerDir3;
_markerName3 setMarkerColor _markerColor;
_markerName3 setMarkerType _markerType;

private _taskPos = getPos zone2Central;
private _description = ["Defend the central area of Zone 2 against all enemies.", "DEFEND Zone 2", ""];
[west, "DefendZone2", _description, _taskPos, "ASSIGNED", 2, true] call BIS_fnc_taskCreate;