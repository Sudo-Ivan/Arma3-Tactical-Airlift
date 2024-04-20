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