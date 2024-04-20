// Define the custom icon textures
private _medicalIcon = getMissionPath "icons\medical.paa";
private _gearIcon = getMissionPath "icons\gear.paa";
private _ammoIcon = getMissionPath "icons\ammo.paa";

// Cache the map control for performance
private _mapCtrl = findDisplay 12 displayCtrl 51;

// Define your icon size scaling based on world size and map scale
private _scale = 6.4 * worldSize / 8192 * ctrlMapScale _mapCtrl;
private _size = 50 / _scale; // Let's assume you want the icons to represent a 50m size on the map

// Define the trigger positions
private _zone1MedicalTrigger = getMarkerPos "zone1_trigger_medical";
private _zone1GearTrigger = getMarkerPos "zone1_trigger_gear";
private _zone1AmmoTrigger = getMarkerPos "zone1_trigger_ammo";

//private _zone2MedicalTrigger = getMarkerPos "zone2_trigger_medical";
//private _zone2GearTrigger = getMarkerPos "zone2_trigger_gear";
//private _zone2AmmoTrigger = getMarkerPos "zone2_trigger_ammo";

//private _zone3MedicalTrigger = getMarkerPos "zone3_trigger_medical";
//private _zone3GearTrigger = getMarkerPos "zone3_trigger_gear";
//private _zone3AmmoTrigger = getMarkerPos "zone3_trigger_ammo";

// Define a function to handle the drawing of icons
private _drawIconOnMap = {
    params ["_mapCtrl", "_icon", "_color", "_triggerPos", "_text"];
    _mapCtrl ctrlAddEventHandler ["Draw", {
        params ["_ctrl"];
        _ctrl drawIcon [
            _icon, _color, _triggerPos,
            _size, _size, 0, _text, 2, 0.05, "PuristaMedium", "center"
        ];
    }];
};

// Call the function for each zone and icon type
_drawIconOnMap, [_mapCtrl, _medicalIcon, [1, 1, 1, 1], _zone1MedicalTrigger, "Medical Supplies"];
_drawIconOnMap, [_mapCtrl, _gearIcon, [1, 1, 1, 1], _zone1GearTrigger, "Gear Supplies"];
_drawIconOnMap, [_mapCtrl, _ammoIcon, [1, 1, 1, 1], _zone1AmmoTrigger, "Ammo Supplies"];

//_drawIconOnMap [_mapCtrl, _medicalIcon, [1, 0, 0, 1], _zone2MedicalTrigger, "Medical Supplies"];
//_drawIconOnMap [_mapCtrl, _gearIcon, [0, 1, 0, 1], _zone2GearTrigger, "Gear Supplies"];
//_drawIconOnMap [_mapCtrl, _ammoIcon, [0, 0, 1, 1], _zone2AmmoTrigger, "Ammo Supplies"];

//_drawIconOnMap [_mapCtrl, _medicalIcon, [1, 0, 0, 1], _zone3MedicalTrigger, "Medical Supplies"];
//_drawIconOnMap [_mapCtrl, _gearIcon, [0, 1, 0, 1], _zone3GearTrigger, "Gear Supplies"];
//_drawIconOnMap [_mapCtrl, _ammoIcon, [0, 0, 1, 1], _zone3AmmoTrigger, "Ammo Supplies"];
