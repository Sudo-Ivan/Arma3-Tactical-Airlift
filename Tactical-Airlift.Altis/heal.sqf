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