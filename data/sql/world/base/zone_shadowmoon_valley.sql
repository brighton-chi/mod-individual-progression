-- flight masters at Sanctum of the Stars and Altar of Sha'tar only visible if at least friendly with Scryers/Aldor
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 30 AND `ConditionTypeOrReference` = 5 AND `SourceEntry` IN (19581, 21766);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, 
`ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES 
--
(30, 0, 19581, 0, 0, 5, 0, 932, 240, 0, 0, 0, 0, '', 'Only able to activate flight path if friendly with Aldor'),
(30, 0, 21766, 0, 0, 5, 0, 934, 240, 0, 0, 0, 0, '', 'Only able to activate flight path if friendly with Scryers');

-- fix movement for Parsha
UPDATE `creature` SET `MovementType` = 2, `currentwaypoint` = 1, `position_x` = -3493.5701, `position_y` = 2277.0901, `position_z` = 65.3081 WHERE `id` = 22024;

DELETE FROM `creature_addon` WHERE `guid` IN (83112);
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES 
(83112, 831120, 0, 0, 0, 0, 0, '');

DELETE FROM `waypoint_data` WHERE `id` IN (831120);
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES 
--
(831120, 1,  -3478.58, 2278.88, 64.3024, 0.466765, 0, 0, 0, 100, 0),
(831120, 2,  -3465.33, 2287.22, 63.4117, 0.258635, 0, 0, 0, 100, 0),
(831120, 3,  -3396.56, 2289.24, 62.6846, 5.86481, 0, 0, 0, 100, 0),
(831120, 4,  -3375.29, 2283.54, 62.2904, 5.94728, 0, 0, 0, 100, 0),
(831120, 5,  -3361.75, 2279.95, 61.9273, 6.18918, 0, 0, 0, 100, 0),
(831120, 6,  -3346.63, 2278.56, 61.3279, 6.26065, 0, 0, 0, 100, 0),
(831120, 7,  -3292.68, 2278.75, 60.6095, 3.15071, 0, 0, 0, 100, 0),
(831120, 8,  -3365.18, 2279.23, 62.0737, 2.84283, 0, 0, 0, 100, 0),
(831120, 9,  -3387.64, 2287.59, 62.3845, 2.89703, 0, 0, 0, 100, 0),
(831120, 10, -3399.74, 2289.47, 62.7643, 3.19548, 0, 0, 0, 100, 0),
(831120, 11, -3457.02, 2289.38, 63.4614, 3.32978, 0, 0, 0, 100, 0),
(831120, 12, -3465.55, 2286.99, 63.416, 3.6997, 0, 0, 0, 100, 0),
(831120, 13, -3476.52, 2280.52, 64.1385, 3.41225, 0, 0, 0, 100, 0),
(831120, 14, -3494.46, 2277.87, 65.362, 0.162269, 0, 0, 0, 100, 0);

-- Deathforged Infernal, shorten respawn to solve range issue of remote control (was 120 secs)
UPDATE `gameobject` SET `spawntimesecs` = 30 WHERE `id` = 184979;

-- fix Neltharaku, flying too fast
UPDATE `waypoint_data` SET `move_type` = 0 WHERE `id` = 756540; -- walk instead of run

-- fix Quest: Zuluhed the Whacked
SET @CGUID   := 670000;
SET @WPID    := 6700000;

DELETE FROM `creature` WHERE `id` = 22331; -- remove Dragonmaw Elites incorrectly placed by AC

DELETE FROM `creature` WHERE `id` IN (22112, 22332);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, 
`wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`) VALUES
--
(77644, 22112, 530, 0, 0, 1, 1, 0, -4200.89, 382.464, 118.055, 1.309, 300, 0, 0, 110700, 0, 0, 0, 0, 0, 'npc_karynaku_ipp', 0, 0, NULL),
--
(@CGUID+351, 22332, 530, 0, 0, 1, 1, 0, -4086.10, 298.374, 142.117, 2.98056, 300, 0, 0, 27044, 0, 0, 0, 0, 0, '', NULL, 0, NULL), -- Brood of Neltharaku
(@CGUID+352, 22332, 530, 0, 0, 1, 1, 0, -4151.71, 228.527, 168.212, 1.83387, 300, 0, 0, 27044, 0, 0, 0, 0, 0, '', NULL, 0, NULL),
(@CGUID+353, 22332, 530, 0, 0, 1, 1, 0, -4337.75, 380.471, 135.265, 5.64305, 300, 0, 0, 27044, 0, 0, 0, 0, 0, '', NULL, 0, NULL);

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` IN (11980, 22331, 22332);
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryorguid` IN (11980, 22331, 22332);
DELETE FROM `smart_scripts` WHERE `source_type` = 9 AND `entryorguid` IN (1198000, 1198001);
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryorguid` IN (-(@CGUID+351), -(@CGUID+352), -(@CGUID+353));

INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, 
`event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, 
`action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, 
`target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
--
(11980, 0, 0, 0, 54, 0, 100, 512, 0, 0, 0, 0, 0, 0, 80, 1198000, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0,             'Zuluhed the Whacked - Just Summoned - action list'),
(11980, 0, 1, 0, 0, 0, 100, 0, 8000, 8000, 20000, 20000, 0, 0, 11, 19717, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0,    'Zuluhed the Whacked - IC - Cast rain'),
(11980, 0, 2, 0, 0, 0, 100, 0, 30000, 30000, 60000, 60000, 0, 0, 11, 38876, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0,  'Zuluhed the Whacked - IC - Summon portal'),
(11980, 0, 3, 0, 2, 0, 100, 513, 0, 25, 0, 0, 0, 0, 80, 1198001, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0,             'Zuluhed the Whacked - On 25% health - ActionList'),
--
(1198000, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 24240, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0,                'Zuluhed the Whacked - action list - Cast Red Lightning'),
(1198000, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 47, 1, 0, 0, 0, 0, 0, 9, 22331, 0, 100, 1, 0, 0, 0, 0,              'Zuluhed the Whacked - action list - Dragonmaw Elite Set Visible On'),
(1198000, 9, 2, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0,               'Zuluhed the Whacked - action list - text'),
(1198000, 9, 3, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0,               'Zuluhed the Whacked - action list - text'),
(1198000, 9, 4, 0, 0, 0, 100, 0, 4000, 4000, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0,               'Zuluhed the Whacked - action list - text'),
(1198000, 9, 5, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 9, 22331, 0, 100, 1, 0, 0, 0, 0,               'Zuluhed the Whacked - action list - Dragonmaw Elite Reset Faction'),
(1198000, 9, 6, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 47, 1, 0, 0, 0, 0, 0, 9, 22332, 0, 200, 1, 0, 0, 0, 0,              'Zuluhed the Whacked - action list - Brood of Neltharaku Set Visible On'),
(1198000, 9, 7, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 232, @WPID+3510, 0, 0, 0, 0, 0, 10, @CGUID+351, 22332, 0,0,0,0,0,0, 'Zuluhed the Whacked - action list - Brood of Neltharaku Start Waypoints'),
(1198000, 9, 8, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 232, @WPID+3520, 0, 0, 0, 0, 0, 10, @CGUID+352, 22332, 0,0,0,0,0,0, 'Zuluhed the Whacked - action list - Brood of Neltharaku Start Waypoints'),
(1198000, 9, 9, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 232, @WPID+3530, 0, 0, 0, 0, 0, 10, @CGUID+353, 22332, 0,0,0,0,0,0, 'Zuluhed the Whacked - action list - Brood of Neltharaku Start Waypoints'),
--
(1198001, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 38853, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0,                'Zuluhed the Whacked - ActionList - Cast Infusion'),
(1198001, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0,                     'Zuluhed the Whacked - ActionList - Text'),
--
(22331, 0, 0, 0, 1, 0, 100, 513, 0, 0, 0, 0, 0, 0, 21, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0,                    'Dragonmaw Elite - Out of Combat - Disable Combat Movement (No Repeat)'),
(22331, 0, 1, 0, 10, 0, 100, 0, 0, 80, 2300, 3900, 0, 0, 11, 38858, 64, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0,         'Dragonmaw Elite - Within 0-80 Range - Cast Shoot'), -- OOC
(22331, 0, 2, 0, 0, 0, 100, 0, 0, 80, 2300, 3900, 0, 0, 11, 38858, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0,          'Dragonmaw Elite - Within 0-80 Range - Cast Shoot'), -- IC
(22331, 0, 3, 0, 0, 0, 100, 0, 4000, 6000, 12000, 16000, 0, 0, 11, 38859, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0,   'Dragonmaw Elite - In Combat - Cast Serpent Sting'),
(22331, 0, 4, 0, 0, 0, 100, 0, 6000, 9000, 12000, 16000, 0, 0, 11, 38861, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0,    'Dragonmaw Elite - In Combat - Cast Aimed Shot'),
(22331, 0, 5, 6, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 2, 16, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0,                     'Dragonmaw Elite - On Respawn - Set Faction Friendly'),
(22331, 0, 6, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 47, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0,                     'Dragonmaw Elite - On Respawn - Set Visible Off'),
--
(-(@CGUID+351), 0, 0, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 47, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0,             'Brood of Neltharaku - On Respawn - Set Visible Off'),
(-(@CGUID+351), 0, 1, 0, 108, 0, 100, 0, 6, @WPID+3510, 0, 0, 0, 0, 11, 38906, 0, 0, 0, 0, 0, 1, 0,0,0,0,0,0,0,0,      'Brood of Neltharaku - On Waypoint Reached - Cast Arcane Breath'),
(-(@CGUID+351), 0, 2, 0, 108, 0, 100, 0, 15, @WPID+3510, 0, 0, 0, 0, 47, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0,  'Brood of Neltharaku - On Waypoint Reached - Set Visible Off'),
(-(@CGUID+351), 0, 3, 0, 108, 0, 100, 0, 15, @WPID+3510, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0,  'Brood of Neltharaku - On Waypoint Reached - Despawn'),
(-(@CGUID+352), 0, 0, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 47, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0,             'Brood of Neltharaku - On Respawn - Set Visible Off'),
(-(@CGUID+352), 0, 1, 0, 108, 0, 100, 0, 6, @WPID+3520, 0, 0, 0, 0, 11, 38906, 0, 0, 0, 0, 0, 1, 0,0,0,0,0,0,0,0,      'Brood of Neltharaku - On Waypoint Reached - Cast Arcane Breath'),
(-(@CGUID+352), 0, 2, 0, 108, 0, 100, 0, 13, @WPID+3520, 0, 0, 0, 0, 47, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0,  'Brood of Neltharaku - On Waypoint Reached - Set Visible Off'),
(-(@CGUID+352), 0, 3, 0, 108, 0, 100, 0, 13, @WPID+3520, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0,  'Brood of Neltharaku - On Waypoint Reached - Despawn'),
(-(@CGUID+353), 0, 0, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 47, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0,             'Brood of Neltharaku - On Respawn - Set Visible Off'),
(-(@CGUID+353), 0, 1, 0, 108, 0, 100, 0, 7, @WPID+3530, 0, 0, 0, 0, 11, 38906, 0, 0, 0, 0, 0, 1, 0,0,0,0,0,0,0,0,      'Brood of Neltharaku - On Waypoint Reached - Cast Arcane Breath'),
(-(@CGUID+353), 0, 2, 0, 108, 0, 100, 0, 14, @WPID+3530, 0, 0, 0, 0, 47, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0,  'Brood of Neltharaku - On Waypoint Reached - Set Visible Off'),
(-(@CGUID+353), 0, 3, 0, 108, 0, 100, 0, 14, @WPID+3530, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0,  'Brood of Neltharaku - On Waypoint Reached - Despawn');

DELETE FROM `creature_movement_override` WHERE `SpawnId` BETWEEN @CGUID+451 AND @CGUID+453;
INSERT INTO `creature_movement_override` (`SpawnId`, `Ground`, `Swim`, `Flight`, `Rooted`) VALUES
(@CGUID+351, 1, 0, 2, 0),
(@CGUID+352, 1, 0, 2, 0),
(@CGUID+353, 1, 0, 2, 0);

DELETE FROM `creature_addon` WHERE `guid` IN (@CGUID+351, @CGUID+352, @CGUID+353);
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(@CGUID+351, @WPID+3510, 0, 0, 0, 0, 0, NULL),
(@CGUID+352, @WPID+3520, 0, 0, 0, 0, 0, NULL),
(@CGUID+353, @WPID+3530, 0, 0, 0, 0, 0, NULL);

DELETE FROM `waypoint_data` WHERE `id` IN (@WPID+3510, @WPID+3520, @WPID+3530);
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES 
--
(@WPID+3510, 1, -4086.10, 298.374, 141.729, 0, 0, 1, 0, 100, 0),
(@WPID+3510, 2, -4110.57, 308.073, 159.287, 0, 0, 1, 0, 100, 0),
(@WPID+3510, 3, -4110.57, 308.073, 159.287, 0, 0, 1, 0, 100, 0),
(@WPID+3510, 4, -4142.47, 314.224, 157.704, 0, 0, 1, 0, 100, 0),
(@WPID+3510, 5, -4157.19, 327.177, 156.787, 0, 0, 1, 0, 100, 0),
(@WPID+3510, 6, -4163.87, 333.673, 153.982, 0, 0, 1, 0, 100, 0), -- cast Arcane Breath Chain
(@WPID+3510, 7, -4163.86, 368.368, 161.611, 0, 0, 1, 0, 100, 0),
(@WPID+3510, 8, -4182.26, 374.932, 161.611, 0, 0, 1, 0, 100, 0),
(@WPID+3510, 9, -4207.38, 370.833, 161.611, 0, 0, 1, 0, 100, 0),
(@WPID+3510, 10, -4215.42, 364.493, 161.611, 0, 0, 1, 0, 100, 0),
(@WPID+3510, 11, -4229.56, 331.400, 161.611, 0, 0, 1, 0, 100, 0),
(@WPID+3510, 12, -4213.94, 303.698, 161.611, 0, 0, 1, 0, 100, 0),
(@WPID+3510, 13, -4184.99, 306.452, 161.611, 0, 0, 1, 0, 100, 0),
(@WPID+3510, 14, -4167.67, 334.389, 161.611, 0, 0, 1, 0, 100, 0),
(@WPID+3510, 15, -4086.10, 298.374, 141.729, 0, 0, 1, 0, 100, 0), -- despawn
--
(@WPID+3520, 1, -4153.90, 228.013, 167.625, 0, 0, 1, 0, 100, 0),
(@WPID+3520, 2, -4159.24, 240.449, 174.983, 0, 0, 1, 0, 100, 0),
(@WPID+3520, 3, -4159.24, 240.449, 174.983, 0, 0, 1, 0, 100, 0),
(@WPID+3520, 4, -4172.24, 284.199, 174.983, 0, 0, 1, 0, 100, 0),
(@WPID+3520, 5, -4184.01, 304.716, 174.983, 0, 0, 1, 0, 100, 0),
(@WPID+3520, 6, -4197.63, 309.556, 175.236, 0, 0, 1, 0, 100, 0), -- cast Arcane Breath Chain
(@WPID+3520, 7, -4216.68, 321.548, 175.236, 0, 0, 1, 0, 100, 0),
(@WPID+3520, 8, -4227.50, 348.093, 175.236, 0, 0, 1, 0, 100, 0),
(@WPID+3520, 9, -4217.70, 367.116, 175.236, 0, 0, 1, 0, 100, 0),
(@WPID+3520, 10, -4190.34, 372.94, 175.236, 0, 0, 1, 0, 100, 0),
(@WPID+3520, 11, -4168.04, 358.986, 175.236, 0, 0, 1, 0, 100, 0),
(@WPID+3520, 12, -4167.60, 331.767, 175.236, 0, 0, 1, 0, 100, 0),
(@WPID+3520, 13, -4153.90, 228.013, 167.625, 0, 0, 1, 0, 100, 0), -- despawn
--
(@WPID+3530, 1, -4338.94, 379.093, 134.61, 0, 0, 1, 0, 100, 0),
(@WPID+3530, 2, -4317.74, 364.965, 148.729, 0, 0, 1, 0, 100, 0),
(@WPID+3530, 3, -4317.74, 364.965, 148.729, 0, 0, 1, 0, 100, 0),
(@WPID+3530, 4, -4282.66, 346.887, 170.312, 0, 0, 1, 0, 100, 0),
(@WPID+3530, 5, -4236.21, 332.221, 170.312, 0, 0, 1, 0, 100, 0),
(@WPID+3530, 6, -4215.42, 364.493, 161.611, 0, 0, 1, 0, 100, 0),
(@WPID+3530, 7, -4207.38, 370.833, 161.611, 0, 0, 1, 0, 100, 0), -- cast Arcane Breath Chain
(@WPID+3530, 8, -4182.26, 374.932, 161.611, 0, 0, 1, 0, 100, 0),
(@WPID+3530, 9, -4163.86, 368.368, 161.611, 0, 0, 1, 0, 100, 0),
(@WPID+3530, 10, -4167.67, 334.389, 161.611, 0, 0, 1, 0, 100, 0),
(@WPID+3530, 11, -4184.99, 306.452, 161.611, 0, 0, 1, 0, 100, 0),
(@WPID+3530, 12, -4213.94, 303.698, 161.611, 0, 0, 1, 0, 100, 0),
(@WPID+3530, 13, -4229.56, 331.400, 161.611, 0, 0, 1, 0, 100, 0),
(@WPID+3530, 14, -4317.74, 364.965, 148.729, 0, 0, 1, 0, 100, 0); -- despawn
