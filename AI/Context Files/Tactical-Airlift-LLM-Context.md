
Arma 3 Tactical Airlift Mission
SQF Scripted Mission
Updated as of 20 May 2024

This is for LLM context to help expand the mission using SQF. Add any relevant arma 3 docs to the bottom, use a large context model.

# Mission Structure:
The mission is structured into several components:

1. **init.sqf**: This is the main initialization file that sets up the mission.
2. **updateSupplies.sqf**: This file updates the supply markers and zones.
3. **triggers**: In-game objects that contain logic for delivering supplies.
4. **profilenamespace**: This is where the mission's data is stored and remains persistent.
5. **reduction.sqf**: Reduces the supply points in a zone based on its distance to the nearest enemy point. 
6. **heal.sqf**: heals a player if there are medical supplies available in a specific zone.
7. **ammoSupplies.sqf**: This script handles the addition of ammo supplies and points when a specific type of crate is delivered to a zone.
8. **spawnEnemy.sqf**: This script spawns enemy units at specific locations and assigns them to groups.
9. **medicalSupplies.sqf**: This script likely handles the addition of medical supplies when a specific type of crate is delivered to a zone.
10. **points.sqf**: This script handles the player's points, including initializing, adding, and subtracting points.
11. **gearSupplies.sqf**: This script likely handles the addition of gear supplies when a specific type of crate is delivered to a zone.

**What needs to be added:**
1. vehiclestore.sqf: buy vehicle with points.
2. aistore.sqf: buy AI with points.
3. morale system based on troops and supplies.
4. Reaction Forces context menu.

**Basic Arma 3 Syntax:**
- **Variables**: In Arma 3, variables are declared using the `private` keyword, followed by the variable name and its value. For example: `private _myVariable = 10;`
- **Arrays**: Arrays are declared using square brackets `[]`. For example: `private _myArray = [1, 2, 3];`
- **Functions**: Functions are declared using the `private` keyword, followed by the function name and its parameters. For example: `private _myFunction = { params ["_param1", "_param2"]; };`
- **Loops**: Loops are used to iterate over arrays or execute a block of code repeatedly. For example: `for "_i" from 0 to 10 do { };`
- **Conditional Statements**: Conditional statements are used to execute a block of code based on a condition. For example: `if (_condition) then { };`

## Code

**init.sqf:**
``` 
execVM "updateSupplies.sqf";
```

**updateSupplies.sqf:**
```
private _fullMedicalSupplies = 100;
private _fullGearSupplies = 100;
private _fullAmmoSupplies = 100;

private _zoneMarkers = [
    ["zone1_medicalMarker", "zone1_gearMarker", "zone1_ammoMarker"],
    ["zone2_medicalMarker", "zone2_gearMarker", "zone2_ammoMarker"],
    ["zone3_medicalMarker", "zone3_gearMarker", "zone3_ammoMarker"]
];

private _zoneNamespaces = [
    "zone1_medicalSupplies",
    "zone1_gearSupplies",
    "zone1_ammoSupplies",
    "zone2_medicalSupplies",
    "zone2_gearSupplies",
    "zone2_ammoSupplies",
    "zone3_medicalSupplies",
    "zone3_gearSupplies",
    "zone3_ammoSupplies"
];

private _enabledZones = "enabledZones";

private _enabledZonesArray = profileNamespace getVariable [_enabledZones, []];

private _currentSupplies = [
    [profileNamespace getVariable ["zone1_medicalSupplies", 0], profileNamespace getVariable ["zone1_gearSupplies", 0], profileNamespace getVariable ["zone1_ammoSupplies", 0]],
    [profileNamespace getVariable ["zone2_medicalSupplies", 0], profileNamespace getVariable ["zone2_gearSupplies", 0], profileNamespace getVariable ["zone2_ammoSupplies", 0]],
    [profileNamespace getVariable ["zone3_medicalSupplies", 0], profileNamespace getVariable ["zone3_gearSupplies", 0], profileNamespace getVariable ["zone3_ammoSupplies", 0]]
];

// Change to allow hiding of markers
findDisplay 12 displayCtrl 51 ctrlAddEventHandler ["Draw", {
    _this select 0 drawIcon [
        getMissionPath "icons\ammo.paa",
        [1, 1, 1, 1],
        getPosASLVisual zone1_trigger_ammo,
        24,
        24,
        0,
        format ["%1", profileNamespace getVariable ["zone1_ammoSupplies", " 0"]],
        1,
        0.03,
        "TahomaB",
        "right"
    ];

    _this select 0 drawIcon [
        getMissionPath "icons\gear.paa",
        [1, 1, 1, 1],
        getPosASLVisual zone1_trigger_gear,
        24,
        24,
        0,
        format ["%1", profileNamespace getVariable ["zone1_gearSupplies", " 0"]],
        1,
        0.03,
        "TahomaB",
        "right"
    ];

    _this select 0 drawIcon [
        getMissionPath "icons\medical.paa",
        [1, 1, 1, 1],
        getPosASLVisual zone1_trigger_medical,
        24,
        24,
        0,
        format ["%1", profileNamespace getVariable ["zone1_medicalSupplies", " 0"]],
        1,
        0.03,
        "TahomaB",
        "right"
    ];
        _this select 0 drawIcon [
        getMissionPath "icons\ammo.paa",
        [1, 1, 1, 1],
        getPosASLVisual zone2_trigger_ammo,
        24,
        24,
        0,
        format ["%1", profileNamespace getVariable ["zone2_ammoSupplies", " 0"]],
        1,
        0.03,
        "TahomaB",
        "right"
    ];

    _this select 0 drawIcon [
        getMissionPath "icons\gear.paa",
        [1, 1, 1, 1],
        getPosASLVisual zone2_trigger_gear,
        24,
        24,
        0,
        format ["%1", profileNamespace getVariable ["zone2_gearSupplies", " 0"]],
        1,
        0.03,
        "TahomaB",
        "right"
    ];

    _this select 0 drawIcon [
        getMissionPath "icons\medical.paa",
        [1, 1, 1, 1],
        getPosASLVisual zone2_trigger_medical,
        24,
        24,
        0,
        format ["%1", profileNamespace getVariable ["zone2_medicalSupplies", " 0"]],
        1,
        0.03,
        "TahomaB",
        "right"
    ];
}];
```

**spawnEnemy.sqf**
```
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
```

**reduction.sqf**
```
private _reduceSupplies = {
    params ["_zone"];

    // Get distance to nearest enemy point
    private _nearestEnemyPoint = getMarkerPos (format ["enemypos%1", _zone]);
    private _distanceToEnemy = _zone distance _nearestEnemyPoint;

    // Check if distance is less than some number (e.g. 1000 meters)
    if (_distanceToEnemy < 1000) then {
        // Get current supply points
        private _currentSupplyPoints = profileNamespace getVariable [format ["zone%1_supplyPoints", _zone], 0];

        // Check if supply points are less than some number (e.g. 500)
        if (_currentSupplyPoints < 500) then {
            // Calculate reduction amount based on distance and supply points
            private _reductionAmount = (_distanceToEnemy / 1000) * (_currentSupplyPoints / 500) * (random 0.1 + 2);
            private _newSupplyPoints = _currentSupplyPoints - _reductionAmount;

            // Update supply points
            profileNamespace setVariable [format ["zone%1_supplyPoints", _zone], _newSupplyPoints];
            profileNamespace, saveProfileNamespace;
        };
    };
};

// Run reduction system every day in-game
while {true} do {
    // Wait for 24 hours in-game
    waitUntil {dayTime > 24};

    // Run reduction system for each zone
    for "_zone" from 1 to 4 do {
        [_zone] call _reduceSupplies;
    };
};
```

**points.sqf**
```
// points.sqf

// Initialize player points to 200
private _playerPoints = profileNamespace getVariable ["playerPoints", 200];

// Function to add points to a player
private _addPoints = {
    params ["_points"];
    private _currentPoints = profileNamespace getVariable ["playerPoints", 0];
    private _newPoints = _currentPoints + _points;
    profileNamespace setVariable ["playerPoints", _newPoints];
    profileNamespace, saveProfileNamespace;
};

// Function to subtract points from a player
private _subtractPoints = {
    params ["_points"];
    private _currentPoints = profileNamespace getVariable ["playerPoints", 0];
    private _newPoints = _currentPoints - _points;
    profileNamespace setVariable ["playerPoints", _newPoints];
    profileNamespace, saveProfileNamespace;
};

// Get the current points of the player
private _currentPoints = profileNamespace getVariable ["playerPoints", 0];
hint format ["You have %1 points", _currentPoints];
```

**medicalSupplies**
```
params ["_zone", "_crateType", "_crate"];

private _pointsToAdd = 0;
private _suppliesToAdd = 0;

switch (_crateType) do {
    case "Box_Cargo_Medical_RF": {
        _pointsToAdd = 200;
        _suppliesToAdd = 50;
    };
    case "B_Slingload_01_Medevac_F": {
        _pointsToAdd = 200;
        _suppliesToAdd = 50;
    };
};

private _currentMedical = profileNamespace getVariable [format ["zone%1_medicalSupplies", _zone], 0];
private _newMedical = _currentMedical + _suppliesToAdd;
profileNamespace setVariable [format ["zone%1_medicalSupplies", _zone], _newMedical];
profileNamespace, saveProfileNamespace;
execVM "updateSupplies.sqf";

private _playerPoints = profileNamespace getVariable ["playerPoints", 0];
private _newPoints = _playerPoints + _pointsToAdd;
profileNamespace setVariable ["playerPoints", _newPoints];
profileNamespace, saveProfileNamespace;

hint format ["+%1 Points!", _pointsToAdd];
```

**heal.sqf**
```
params ["_vehicle", "_zone"];

if (isNull _vehicle) exitWith {};

private _currentMedical = profileNamespace getVariable [format ["zone%1_medicalSupplies", _zone], 0];

if (_currentMedical > 0) then {
	_vehicle setDamage 0;
	hint "You are healed!";
	
	_currentMedical = _currentMedical - 1;
	profileNamespace setVariable [format ["zone%1_medicalSupplies", _zone], _currentMedical];
	profileNamespace, saveProfileNamespace;
	
	execVM "updateSupplies.sqf";
	
	if (isClass (configFile >> "CfgPatches" >> "ace_medical_treatment") && {typeName _vehicle == "OBJECT" && {alive _vehicle}}) then {
		[_vehicle] call ace_medical_treatment_fnc_fullHealLocal;
	};
} else {
	hint "No medical supplies available!";
};
```

**gearSupplies.sqf**
```
params ["_vehicle", "_zone"];

if (isNull _vehicle) exitWith {};

private _currentMedical = profileNamespace getVariable [format ["zone%1_medicalSupplies", _zone], 0];

if (_currentMedical > 0) then {
	_vehicle setDamage 0;
	hint "You are healed!";
	
	_currentMedical = _currentMedical - 1;
	profileNamespace setVariable [format ["zone%1_medicalSupplies", _zone], _currentMedical];
	profileNamespace, saveProfileNamespace;
	
	execVM "updateSupplies.sqf";
	
	if (isClass (configFile >> "CfgPatches" >> "ace_medical_treatment") && {typeName _vehicle == "OBJECT" && {alive _vehicle}}) then {
		[_vehicle] call ace_medical_treatment_fnc_fullHealLocal;
	};
} else {
	hint "No medical supplies available!";
};
```

**ammoSupplies.sqf**
```
params ["_zone", "_crateType", "_crate"];

private _pointsToAdd = 0;
private _suppliesToAdd = 0;

switch (_crateType) do {
    case "I_E_CargoNet_01_ammo_F": {
        _pointsToAdd = 200;
        _suppliesToAdd = 50;
    };
    case "B_Slingload_01_Ammo_F": {
        _pointsToAdd = 200;
        _suppliesToAdd = 50;
    };
};

private _currentAmmo = profileNamespace getVariable [format ["zone%1_ammoSupplies", _zone], 0];
private _newAmmo = _currentAmmo + _suppliesToAdd;
profileNamespace setVariable [format ["zone%1_ammoSupplies", _zone], _newAmmo];
profileNamespace, saveProfileNamespace;
execVM "updateSupplies.sqf";
deleteVehicle _crate;

private _playerPoints = profileNamespace getVariable ["playerPoints", 0];
private _newPoints = _playerPoints + _pointsToAdd;
profileNamespace setVariable ["playerPoints", _newPoints];
profileNamespace, saveProfileNamespace;

hint format ["+%1 Points!", _pointsToAdd];
```
### In-Game Triggers

All Triggers

Type: None
Activation: Anybody
Activation Type: Present
Repeatable Checked

**ammo trigger:**
condition
```
(thisList findIf {(_x isKindOf "I_E_CargoNet_01_ammo_F" || _x isKindOf "B_Slingload_01_Ammo_F") && velocity _x isEqualTo [0,0,0]}) != -1
```
on activation
```
{ 
    if (_x isKindOf "I_E_CargoNet_01_ammo_F") then { 
        [2, "I_E_CargoNet_01_ammo_F", _x] execVM "ammoSupplies.sqf"; 
        deleteVehicle _x; 
    }; 
    if (_x isKindOf "B_Slingload_01_Ammo_F") then { 
        [2, "B_Slingload_01_Ammo_F", _x] execVM "ammoSupplies.sqf"; 
        deleteVehicle _x; 
    }; 
} forEach thisList;
```

**medical trigger:**
condition
```
(thisList findIf {(_x isKindOf "Box_Cargo_Medical_RF" || _x isKindOf "B_Slingload_01_Medevac_F") && velocity _x isEqualTo [0,0,0]}) != -1
```
on activation
```
{ 
    if (_x isKindOf "B_Slingload_01_Medevac_F") then { 
        [2, "B_Slingload_01_Medevac_F", _x] execVM "medicalSupplies.sqf"; 
        deleteVehicle _x; 
    }; 
    if (_x isKindOf "Box_Cargo_Medical_RF") then { 
        [2, "Box_Cargo_Medical_RF", _x] execVM "medicalSupplies.sqf"; 
        deleteVehicle _x; 
    }; 
} forEach thisList; 
```
**gear trigger:** 
condition
```
(thisList findIf {(_x isKindOf "B_Slingload_01_Cargo_F" || _x isKindOf "CargoNet_01_box_F") && velocity _x isEqualTo [0,0,0]}) != -1
```
on activation
```
{ 
    if (_x isKindOf "CargoNet_01_box_F") then { 
        [2, "CargoNet_01_box_F", _x] execVM "ammoSupplies.sqf"; 
        deleteVehicle _x; 
    }; 
    if (_x isKindOf "B_Slingload_01_Cargo_F") then { 
        [2, "B_Slingload_01_Cargo_F", _x] execVM "ammoSupplies.sqf"; 
        deleteVehicle _x; 
    }; 
} forEach thisList; 
```

Note: The hard-coded item variables will later be change to allow more crate types and different point values, probably an array.

**Custom PAA Icons Path**
```
icons/ammo.paa
icons/gear.paa
icons/medical.paa
```
## Goals:

The goal of this mission is to deliver supplies to various zones using a helicopter and vehicles. The supplies are represented by markers on the map with dynamic text created using updateSupplies.sqf to indicate amount of supplies at the zone, and supply script is triggered by a in-game trigger as seen above.

I want to add custom PAA icons using `drawIcon` and a player points system, supply reduction system, vehicle spawn system (uses player points), AI store and points arsenal (by this I mean subtract x amount to access arsenal)

There will also be a morale system for zones, which is based on amount of supplies and troops.

## Debug Commands
### Current Tactical Airlift Mission Debug Commands:

**Spawn Enemy, Markers and Task for Zone 2**
```
execVM "spawnEnemy.sqf";
```

**Modify Player Points**
```
private _pointsToAdd = 50;
profileNamespace setVariable ["playerPoints", (profileNamespace getVariable ["playerPoints", 0]) + _pointsToAdd];
saveProfileNamespace;
```

**Subtract Points from Player**
```
private _pointsToSubtract = 30;
profileNamespace setVariable ["playerPoints", (profileNamespace getVariable ["playerPoints", 0]) - _pointsToSubtract];
saveProfileNamespace;
```

**Set Supplies for a Specific Zone**
```
private _zone1MedicalSuppliesToSet = 80;
profileNamespace setVariable ["zone1_medicalSupplies", _zone1MedicalSuppliesToSet];
saveProfileNamespace;
```
‎  
**Increase Ammo Supplies for a Specific Zone**
```
private _ammoToAdd = 20;
profileNamespace setVariable ["zone2_ammoSupplies", (profileNamespace getVariable ["zone2_ammoSupplies", 0]) + _ammoToAdd];
saveProfileNamespace;
```

**Debug Current Points and Supplies**
```
private _playerPoints = profileNamespace getVariable ["playerPoints", 0];
hint format ["Current Player Points: %1", _playerPoints];
```

```
private _zone1MedicalSupplies = profileNamespace getVariable ["zone1_medicalSupplies", 0];
private _zone1GearSupplies = profileNamespace getVariable ["zone1_gearSupplies", 0];
private _zone1AmmoSupplies = profileNamespace getVariable ["zone1_ammoSupplies", 0];
hint format ["Zone 1 - Medical: %1, Gear: %2, Ammo: %3", _zone1MedicalSupplies, _zone1GearSupplies, _zone1AmmoSupplies];
```
# Arma 3 Useful Documentation
# **Array**

### Working with Arrays

#### Array Properties
An array is a list of items of varying variable types (including other arrays). Different types can coexist within the same array.

**Note:** Since Arma 3 v1.56, arrays are limited to a maximum of 9,999,999 (sometimes 10,000,000) elements.

#### Create an Array
An array variable is a reference to the array. This means that if the array is edited, all scripts/functions using a reference to this array will see the edition.

`   private _myArray = ["a", "b", "c"]; private _myNewArray = _myArray; _myArray set [1, "z"]; _myNewArray select 1; // will be "z"   `

An array set through `setVariable` does not need to be assigned again if you modify it by reference:

`   player setVariable ["myArray", ["a", "b", "c"]]; private _myArray = player getVariable "myArray"; _myArray set [1, "z"]; player getVariable "myArray"; // is ["a", "z", "c"]   `

#### Create an Empty Array
`   private _myArray = []; count _myArray; // returns 0   `

#### Create a Filled Array
`   private _myFilledArray = ["abc", "def"]; count _myFilledArray; // returns 2   `

An array can hold another array within it, that can hold another array itself, etc:

`   private _myArray = [["my", "subArray", 1], ["mySubArray2"], [["my", "sub", "sub", "array"]]]; count _myArray; // returns 3 count (_myArray select 0); // returns 3 count (_myArray select 1); // returns 1 count (_myArray select 2); // returns 1 count ((_myArray select 2) select 0); // returns 4   `

#### Getting an Element
An array uses a zero-based index for its elements:

`   private _myArray = ["first item", "second item", "third item"]; _myArray select 0; // returns "first item" _myArray # 2; // returns "third item" - Arma 3 only   `

#### Setting an Element
`   private _myArray = ["first item", "second item", "third item"]; _myArray select 1; // returns "second item" _myArray set [1, "hello there"]; // _myArray is ["first item", "hello there", "third item"]   `

**Note:** If the index given to the `set` command is out of bounds, the array will resize to incorporate the index as its last value. All the "empty spaces" between the last valid element and the new set element will be filled with `nil`.

#### Counting Elements
`   private _myArray = ["first item", ["second item's subitem 1", "second item's subitem 2"], "third item"]; count _myArray; // returns 3 - arrays are not counted recursively   `

#### Changing Array Size
The `resize` command is made to reduce or expand an array:

`   private _myArray = ["a", "b", "c", "d", "e"]; _myArray resize 3; // _myArray is ["a", "b", "c"] private _myArray = ["a", "b", "c"]; _myArray resize 5; // _myArray is ["a", "b", "c", nil, nil]   `

**Note:** You do not need to extend an array before adding any elements.

#### Array Copy

`   private _myArray = ["a", "b", "c"]; private _myNewArray = _myArray; _myArray set [1, "z"]; _myNewArray select 1; // will be "z"   `

To avoid this behavior, copy the array with `+` (plus):

`   private _myArray = ["a", "b", "c"]; private _myNewArray = +_myArray; _myArray set [1, "z"]; _myNewArray select 1; // still "b"   `

# **BIS_fnc_infoText**

### Description

Display a text in the "mission" GUI area with some effects. Good for the beginning of a mission.
### Syntax

`   [string_1, string_2, string_n] spawn BIS_fnc_infoText   `

### Parameters

- `Array of Strings`
### Examples

#### Example 1

`   ["Somewhere on Altis", format ["Year %1", date select 0], mapGridPosition player] spawn BIS_fnc_infoText;   `
# **Position**
### Commands
### Types

#### Position2D
A 2D position represented as an array with two elements: `[X, Y]`. Usually used with 2D information, such as standard markers or UI commands. If used with `distance`, `Z` is assumed to be 0.
#### PositionASL
A 3D position represented as an array with three elements: `[X, Y, Z]`. `Z` is measured from the sea level, which is constant across the map.
#### PositionASLW
A 3D position represented as an array with three elements: `[X, Y, Z]`. `Z` is measured from the surface of water at that position, taking into account waves and pond objects.
#### PositionATL
A 3D position represented as an array with three elements: `[X, Y, Z]`. `Z` is measured from the terrain level, which varies across the map.
#### PositionAGL
A 3D position represented as an array with three elements: `[X, Y, Z]`. `Z` is the same as in `PositionASLW` when over sea and is the same as in `PositionATL` when over land. Most commands either take or return `PositionAGL`.
#### PositionAGLS
A 3D position represented as an array with three elements: `[X, Y, Z]`. Over land, `Z` is measured as height over terrain level minus the height of surface over terrain level underneath. If such surface exists and is counted in, the resulting `Z` becomes 0. Over sea, it gets even more complicated as instead of `PositionATL`, `PositionASLW` is used minus the offset for the surface height, presumably over waves too, as `Z` seems static.`
#### setPosAGLS
A function that places an object onto a walkable surface, if there is one, otherwise on the ground. If only `X` and `Y` of the position are supplied, the object will be placed on surface, if `Z` is supplied, it will be treated as offset from the surface level.
#### PositionWorld
A 3D position represented as an array with three elements: `[X, Y, Z]`. Similar to `PositionASL`, however `Z` is measured from the sea level to the model centre `[0, 0, 0]` of the object, rather than transformed boundingCenter or land contact vertices.`
#### PositionRelative
A relative position is normally an `[X, Y, Z]` offset from the model centre.
# **drawIcon**
Draws an icon on the map. As this command needs to be called every frame, it is preferable to use the `onDraw` UI Event Handler.
### Syntax

`   map drawIcon [texture, color, position, width, height, angle, text, shadow, textSize, font, align]   `

### Parameters

- `map`: Control
- `texture`: String - icon texture
- `color`: Array - text and icon color in format `Color(RGBA)`
- `position`: Object, Array format `Position2D` or `Position3D`
- `width`: Number - width of the icon (but not the text)
- `height`: Number - height of the icon (but not the text)
- `angle`: Number - rotation angle of the icon (but not the text)
- `text`: String - (Optional, default "") text to display
- `shadow`: Number or Boolean - (Optional, default `false`) can be one of:
    - `0` (false): no shadow
    - `1`: shadow (for text)
    - `2` (true): outline (works for text and for icon only if icon angle is `0`)
- `textSize`: Number - (Optional, default `-1`) size of the text in UI units
- `font`: String - (Optional, default "") text's font
- `align`: String - (Optional, default "right") text alignment. Can be:
    - "left"
    - "right"
    - "center"

### Examples
#### Example 1: Red icon with text
`   findDisplay 12 displayCtrl 51 ctrlAddEventHandler ["Draw", { _this select 0 drawIcon [ "iconStaticMG", [1, 0, 0, 1], getPosASLVisual player, 24, 24, getDirVisual player, "Player Vehicle", 1, 0.03, "TahomaB", "right" ] }];   `

#### Example 2: Green text only
`   findDisplay 12 displayCtrl 51 ctrlAddEventHandler ["Draw", { _this select 0 drawIcon [ "#(rgb,1,1,1)color(1,1,1,1)", [0, 1, 0, 1], player, 0, 0, 0, name player ] }];   `

### Additional Information

See also:
- `drawArrow`
- `drawEllipse`
- `drawLine`
- `drawRectangle`
- `drawPolygon`
- `drawTriangle`

### Notes
- This command does not seem to play nice with `onEachFrame`. It seems to draw on the main screen while maintaining position relative to the map position.
- The icon size always stays the same, even after zooming in/out. To make the icon get bigger with map zoom, use the following formula for width and height size: `private _scale = 6.4 * worldSize / 8192 * ctrlMapScale _map; private _size = _sizeInMeters / _scale;`