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