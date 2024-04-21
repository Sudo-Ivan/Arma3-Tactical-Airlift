params ["_zone", "_crateType", "_crate"];

private _pointsToAdd = 0;
private _suppliesToAdd = 0;

switch (_crateType) do {
    case "B_Slingload_01_Cargo_F": {
        _pointsToAdd = 800;
        _suppliesToAdd = 50;
    };
    case "CargoNet_01_box_F": {
        _pointsToAdd = 200;
        _suppliesToAdd = 20;
    };
};

private _currentGear = profileNamespace getVariable [format ["zone%1_gearSupplies", _zone], 0];
private _newGear = _currentGear + _suppliesToAdd;
profileNamespace setVariable [format ["zone%1_gearSupplies", _zone], _newGear];
profileNamespace, saveProfileNamespace;
execVM "updateSupplies.sqf";
deleteVehicle _crate;

private _playerPoints = profileNamespace getVariable ["playerPoints", 0];
private _newPoints = _playerPoints + _pointsToAdd;
profileNamespace setVariable ["playerPoints", _newPoints];
profileNamespace, saveProfileNamespace;

hint format ["+%1 Points!", _pointsToAdd];