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