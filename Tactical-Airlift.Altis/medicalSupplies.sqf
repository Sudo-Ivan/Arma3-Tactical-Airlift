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