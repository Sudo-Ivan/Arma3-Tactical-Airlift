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