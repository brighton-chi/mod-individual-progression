-- fix drop Mature Bone Sifter Carcass (didn't drop)
UPDATE `creature_loot_template` SET `GroupId` = 2 WHERE `Item` = 31814 AND `Entry` = 22482;

-- quest: Evil Draws Near - fix turn in screen
UPDATE `quest_template` SET `RequiredItemId3` = 0, `RequiredItemCount3` = 0 WHERE `ID` = 10923;

-- quest: Safety is Job One - fix turn in text
UPDATE `quest_template` SET `QuestCompletionLog` = 'Return to the Ethereal Transporter Control Panel in the Mana-Tombs.' WHERE `ID` = 10216;

-- fix movement Teribus the Cursed - patrols while nobody is doing the quest.
DELETE FROM `creature_template` WHERE `entry` IN (22441, 122441);
INSERT INTO `creature_template` (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `name`, `subname`, `IconName`, `gossip_menu_id`, 
`minlevel`, `maxlevel`, `exp`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `speed_swim`, `speed_flight`, `detection_range`, `rank`, `dmgschool`, `DamageModifier`, 
`BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `dynamicflags`, `family`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, 
`PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `HoverHeight`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `ExperienceModifier`, `RacialLeader`, `movementId`, 
`RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `VerifiedBuild`) VALUES
--
(22441,0,0,0,0,0,'Teribus the Cursed',NULL,NULL,0,65,65,1,16,0,1,2.28571,1,1,20,1,0,3,2000,2000,1,1,1,33536,2048,0,0,6,8,0,0,0,0,0,0,0,'SmartAI',1,1,5,1,1,1,0,0,1,-93,2,'',0),
(122441,0,0,0,0,0,'Teribus the Cursed',NULL,NULL,0,65,65,1,16,0,1,2.28571,1,1,20,1,0,3,2000,2000,1,1,1,33538,0,0,0,6,8,0,0,0,0,0,0,0,'',1,1,5,1,1,1,0,0,1,-93,2,'',0);

DELETE FROM `creature_template_model` WHERE `CreatureID` IN (122441);
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`) VALUES 
(122441, 0, 21018, 1, 1, 12340);

DELETE FROM `creature_template_movement` WHERE `CreatureID` IN (122441);
INSERT INTO `creature_template_movement` (`CreatureId`, `Ground`, `Swim`, `Flight`, `Rooted`, `Chase`, `Random`, `InteractionPauseTimer`) VALUES 
(122441, 1, 0, 1, 0, 0, 0, NULL);

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` IN (5355, 22441);
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryorguid` IN (5355, 22441);

INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, 
`event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, 
`action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, 
`target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
--
(5355, 0, 0, 0, 9, 0, 100, 0, 0, 0, 3000, 6000, 0, 5, 11, 11976, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0,             'Firewing Defender - Within 0-5 Range - Cast Strike'),
(5355, 0, 1, 0, 0, 0, 100, 0, 6000, 8000, 12000, 18000, 0, 0, 11, 33483, 1, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 0,    'Firewing Defender - In Combat - Cast Mana Tap'),
(5355, 0, 2, 0, 0, 0, 100, 0, 8000, 13000, 1300, 18000, 0, 0, 11, 33390, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0,     'Firewing Defender - In Combat - Cast Arcane Torrent'),
(5355, 0, 3, 0, 4, 0, 30, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 21, 40, 0, 0, 0, 0, 0, 0, 0,                       'Firewing Defender - On Agro - Say'),
--
(22441, 0, 0, 1, 38, 0, 100, 512, 1, 1, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0,                   'Teribus the Cursed - On Data Set - Set Active'),
(22441, 0, 1, 2, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 47, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0,                   'Teribus the Cursed - On Data Set - Set Visible ON'),
(22441, 0, 2, 3, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 47, 0, 0, 0, 0, 0, 0, 10, 622441, 122441, 0, 0, 0, 0, 0, 0,        'Teribus the Cursed - On Data Set - Set Visible OFF for patrol'),
(22441, 0, 3, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 69, 1, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, -3398.96, 4466.33, -11.18, 0, 'Teribus the Cursed - On Data Set - Move To Position'),
(22441, 0, 4, 5, 34, 0, 100, 0, 8, 1, 0, 0, 0, 0, 5, 293, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0,                    'Teribus the Cursed - Movement Inform - Play Emote'),
(22441, 0, 5, 6, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 48, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0,                   'Teribus the Cursed - On Data Set - Set Active off'),
(22441, 0, 6, 7, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0,                   'Teribus the Cursed - On Data Set - Set Event Phase'),
(22441, 0, 7, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 101, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0,                  'Teribus the Cursed - On Data Set - Set Home Position'),
(22441, 0, 8, 9, 60, 1, 100, 513, 2000, 2000, 0, 0, 0, 0, 19, 768, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0,           'Teribus the Cursed - On Update - Remove Unit Flags'),
(22441, 0, 9, 0, 61, 0, 100, 513, 0, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 70, 0, 0, 0, 0, 0, 0, 0,                 'Teribus the Cursed - On Update - Attack Start'),
(22441, 0, 10, 0, 7, 0, 100, 512, 0, 0, 0, 0, 0, 0, 101, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0,                  'Teribus the Cursed - On Data Set - Set Home Position'),
(22441, 0, 11, 12, 11, 0, 100, 512, 0, 0, 0, 0, 0, 0, 47, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0,                 'Teribus the Cursed - On Respawn - Set Visible OFF'),
(22441, 0, 12, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 47, 1, 0, 0, 0, 0, 0, 10, 622441, 122441, 0, 0, 0, 0, 0, 0,       'Teribus the Cursed - On Respawn - Set Visible ON for patrol');

-- fix Terokk evade issue -- 00_cleanup (this can be removed at some point)
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryorguid` = 21838;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(21838, 0, 0, 0, 0, 0, 100, 0, 4000, 7000, 10000, 15000, 0, 0, 11, 40721, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0,     'Terokk - In Combat - Cast \'Shadow Bolt Volley\''),
(21838, 0, 1, 0, 0, 0, 100, 0, 6000, 9000, 7000, 9000, 0, 0, 11, 15284, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0,       'Terokk - In Combat - Cast \'Cleave\''),
(21838, 0, 2, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 0, 80, 2183800, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0,                'Terokk - On Just Summoned - Run Script'),
(21838, 0, 3, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 0, 112, 97, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0,                     'Terokk - On Aggro - Start Skyguard Ace Event'),
(21838, 0, 4, 0, 0, 0, 100, 0, 18000, 30000, 16000, 32000, 0, 0, 80, 2183801, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Terokk - In Combat and Outside \'Divine Shield\' Phase - Run Chosen One Script'), -- Only Outside Divine Shield
(21838, 0, 5, 6, 0, 0, 100, 0, 45000, 60000, 45000, 75000, 0, 0, 11, 40733, 32, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0,  'Terokk - In Combat - Cast \'Divine Shield\''),
(21838, 0, 6, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0,                       'Terokk - On \'Divine Shield\' Cast - Say Line 1'),
(21838, 0, 7, 8, 32, 0, 100, 0, 0, 1000000, 0, 0, 0, 0, 28, 40733, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0,            'Terokk - On Damaged by \'Ancient Flames\' - Remove Aura \'Divine Shield\' (Phase 1)'), -- Only with Divine Shield
(21838, 0, 8, 9, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 2, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0,                       'Terokk - On Spellhit \'Ancient Flames\' - Say Line 2'),
(21838, 0, 9, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 28747, 34, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0,                 'Terokk - On Spellhit \'Ancient Flames\' - Cast \'Frenzy\''),
(21838, 0, 10, 11, 7, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 19, 23377, 90, 0, 0, 0, 0, 0, 0,               'Terokk - On Evade - Despawn Target'),
(21838, 0, 11, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0,                     'Terokk - On Evade - Despawn Instant'),
(21838, 0, 12, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 223, 1, 0, 0, 0, 0, 0, 10, 12478, 23377, 0, 0, 0, 0, 0, 0,            'Terokk - On Just Died - Do Action Terokk Dead');

-- add UNIT_FLAG_IMMUNE_TO_PC and UNIT_FLAG_IMMUNE_TO_NPC flags to avoid evade
UPDATE `creature_template` SET `unit_flags` = 33600 WHERE `entry` = 21838;

-- fix SMART_ACTION_TALK worldserver errors
UPDATE `smart_scripts` SET `target_type` = 21, `target_param1` = 40 WHERE `entryorguid` = 1410 AND `source_type` = 0 AND `id` = 3;
UPDATE `smart_scripts` SET `target_type` = 21, `target_param1` = 40 WHERE `entryorguid` = 16769 AND `source_type` = 0 AND `id` = 17;

DELETE FROM `creature` WHERE `guid` IN (247237, 622441);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, 
`wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`) VALUES
(247237, 22441, 530, 0, 0, 1, 1, 0, -3400.86, 4665.3, 99.6544, 4.62677, 300, 0, 0, 29570, 0, 0, 0, 0, 0, '', 0, 0, 'SAI Target'),
(622441, 122441, 530, 0, 0, 1, 1, 0, -3536.9500, 4552.8501, 83.9206, 1.4071, 300, 0, 1, 29570, 0, 2, 0, 0, 0, '', 0, 0, 'Patrol');

DELETE FROM `creature_addon` WHERE `guid` = 622441;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES 
(622441, 6224410, 0, 0, 0, 0, 4, '');

DELETE FROM `waypoint_data` WHERE `id` = 6224410;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES 
--
(6224410, 1, -3536.95, 4552.85, 83.9206, 0, 0, 2, 0, 100, 0),
(6224410, 2, -3409.62, 4449.58, 83.9206, 0, 0, 2, 0, 100, 0),
(6224410, 3, -3375.35, 4441.38, 83.9206, 0, 0, 2, 0, 100, 0),
(6224410, 4, -3349.25, 4439.43, 83.9206, 0, 0, 2, 0, 100, 0),
(6224410, 5, -3313.64, 4444.91, 83.9206, 0, 0, 2, 0, 100, 0),
(6224410, 6, -3279.4, 4454.19, 83.9206, 0, 0, 2, 0, 100, 0),
(6224410, 7, -3234.19, 4473.26, 83.9206, 0, 0, 2, 0, 100, 0),
(6224410, 8, -3196.13, 4495.16, 83.9206, 0, 0, 2, 0, 100, 0),
(6224410, 9, -3171.48, 4517.38, 83.9206, 0, 0, 2, 0, 100, 0),
(6224410, 10, -3151.42, 4535.17, 83.9206, 0, 0, 2, 0, 100, 0),
(6224410, 11, -3123.37, 4561.55, 83.9206, 0, 0, 2, 0, 100, 0),
(6224410, 12, -3095.09, 4595.4, 83.9206, 0, 0, 2, 0, 100, 0),
(6224410, 13, -3068.84, 4630.34, 83.9206, 0, 0, 2, 0, 100, 0),
(6224410, 14, -3045.78, 4664.11, 83.9206, 0, 0, 2, 0, 100, 0),
(6224410, 15, -3026.6, 4694.87, 83.9206, 0, 0, 2, 0, 100, 0),
(6224410, 16, -2995.64, 4732.21, 83.9206, 0, 0, 2, 0, 100, 0),
(6224410, 17, -2978.61, 4756.44, 83.9206, 0, 0, 2, 0, 100, 0),
(6224410, 18, -2947.33, 4792.06, 83.9206, 0, 0, 2, 0, 100, 0),
(6224410, 19, -2923.64, 4824.37, 83.9206, 0, 0, 2, 0, 100, 0),
(6224410, 20, -2906.17, 4847.41, 83.9206, 0, 0, 2, 0, 100, 0),
(6224410, 21, -2891.8, 4874.13, 83.9206, 0, 0, 2, 0, 100, 0),
(6224410, 22, -2877.48, 4912.11, 83.9206, 0, 0, 2, 0, 100, 0),
(6224410, 23, -2864.91, 4943.6, 83.9206, 0, 0, 2, 0, 100, 0),
(6224410, 24, -2849.98, 4977.14, 83.9206, 0, 0, 2, 0, 100, 0),
(6224410, 25, -2846.4, 5005.69, 83.9206, 0, 0, 2, 0, 100, 0),
(6224410, 26, -2847, 5047.85, 83.9206, 0, 0, 2, 0, 100, 0),
(6224410, 27, -2857.18, 5095.88, 83.9206, 0, 0, 2, 0, 100, 0),
(6224410, 28, -2886.46, 5132.28, 83.9206, 0, 0, 2, 0, 100, 0),
(6224410, 29, -2918.97, 5168.65, 83.9206, 0, 0, 2, 0, 100, 0),
(6224410, 30, -2953.35, 5195.61, 83.9206, 0, 0, 2, 0, 100, 0),
(6224410, 31, -2978.21, 5215.58, 83.9206, 0, 0, 2, 0, 100, 0),
(6224410, 32, -3008.71, 5233.99, 83.9206, 0, 0, 2, 0, 100, 0),
(6224410, 33, -3046.67, 5256.23, 83.9206, 0, 0, 2, 0, 100, 0),
(6224410, 34, -3080.47, 5271.79, 83.9206, 0, 0, 2, 0, 100, 0),
(6224410, 35, -3120.41, 5288.65, 83.9206, 0, 0, 2, 0, 100, 0),
(6224410, 36, -3165.92, 5299.69, 83.9206, 0, 0, 2, 0, 100, 0),
(6224410, 37, -3199.94, 5307.78, 83.9206, 0, 0, 2, 0, 100, 0),
(6224410, 38, -3235.6, 5312.55, 83.9206, 0, 0, 2, 0, 100, 0),
(6224410, 39, -3283.41, 5319.14, 83.9206, 0, 0, 2, 0, 100, 0),
(6224410, 40, -3312.06, 5321.95, 83.9206, 0, 0, 2, 0, 100, 0),
(6224410, 41, -3346.04, 5326.45, 83.9206, 0, 0, 2, 0, 100, 0),
(6224410, 42, -3387.92, 5326.46, 83.9206, 0, 0, 2, 0, 100, 0),
(6224410, 43, -3436.25, 5327.4, 83.9206, 0, 0, 2, 0, 100, 0),
(6224410, 44, -3475.92, 5333.69, 83.9206, 0, 0, 2, 0, 100, 0),
(6224410, 45, -3517.05, 5338.55, 83.9206, 0, 0, 2, 0, 100, 0),
(6224410, 46, -3557.72, 5343.17, 83.9206, 0, 0, 2, 0, 100, 0),
(6224410, 47, -3602.69, 5336.2, 83.9206, 0, 0, 2, 0, 100, 0),
(6224410, 48, -3650.57, 5328.92, 83.9206, 0, 0, 2, 0, 100, 0),
(6224410, 49, -3684.33, 5309.17, 83.9206, 0, 0, 2, 0, 100, 0),
(6224410, 50, -3706.66, 5290.85, 83.9206, 0, 0, 2, 0, 100, 0),
(6224410, 51, -3732.21, 5262.83, 83.9206, 0, 0, 2, 0, 100, 0),
(6224410, 52, -3749.45, 5217.35, 83.9206, 0, 0, 2, 0, 100, 0),
(6224410, 53, -3752.95, 5185.75, 83.9206, 0, 0, 2, 0, 100, 0),
(6224410, 54, -3756.9, 5145.65, 83.9206, 0, 0, 2, 0, 100, 0),
(6224410, 55, -3755.04, 5099.2, 83.9206, 0, 0, 2, 0, 100, 0),
(6224410, 56, -3751.65, 5054.66, 83.9206, 0, 0, 2, 0, 100, 0),
(6224410, 57, -3752.23, 5019.97, 83.9206, 0, 0, 2, 0, 100, 0),
(6224410, 58, -3751.52, 4985.04, 83.9206, 0, 0, 2, 0, 100, 0),
(6224410, 59, -3748.57, 4947.28, 83.9206, 0, 0, 2, 0, 100, 0),
(6224410, 60, -3746.74, 4898.95, 83.9206, 0, 0, 2, 0, 100, 0),
(6224410, 61, -3741.4, 4859.79, 83.9206, 0, 0, 2, 0, 100, 0),
(6224410, 62, -3731.88, 4829.11, 83.9206, 0, 0, 2, 0, 100, 0),
(6224410, 63, -3716.06, 4788.73, 83.9206, 0, 0, 2, 0, 100, 0),
(6224410, 64, -3696.45, 4749.87, 83.9206, 0, 0, 2, 0, 100, 0),
(6224410, 65, -3681.39, 4712.53, 83.9206, 0, 0, 2, 0, 100, 0),
(6224410, 66, -3654.75, 4670.41, 83.9206, 0, 0, 2, 0, 100, 0),
(6224410, 67, -3633.88, 4642.1, 83.9206, 0, 0, 2, 0, 100, 0),
(6224410, 68, -3600.05, 4613.08, 83.9206, 0, 0, 2, 0, 100, 0),
(6224410, 69, -3564.84, 4580.33, 83.9206, 0, 0, 2, 0, 100, 0),
(6224410, 70, -3536.95, 4552.85, 83.9206, 0, 0, 2, 0, 100, 0),
(6224410, 71, -3409.62, 4449.58, 83.9206, 0, 0, 2, 0, 100, 0),
(6224410, 72, -3375.35, 4441.38, 83.9206, 0, 0, 2, 0, 100, 0);

-- fix movement Rotting Forest-Rager (entry 22307)
UPDATE `creature` SET `MovementType` = 2, `currentwaypoint` = 1, `wander_distance` = 0 WHERE `guid` IN (78435, 78436, 78437, 78438, 78439);

DELETE FROM `creature_addon` WHERE `guid` BETWEEN 78435 AND 78439;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES 
(78435, 784350, 0, 0, 0, 0, 0, ''),
(78436, 784360, 0, 0, 0, 0, 0, ''),
(78437, 784370, 0, 0, 0, 0, 0, ''),
(78438, 784380, 0, 0, 0, 0, 0, ''),
(78439, 784390, 0, 0, 0, 0, 0, '');

DELETE FROM `waypoint_data` WHERE `id` BETWEEN 784350 AND 784390;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES 
--
(784350, 1, -2831, 4488.55, -5.40144, 0, 0, 0, 0, 100, 0),
(784350, 2, -2833.69, 4511.24, -6.97536, 0, 0, 0, 0, 100, 0),
(784350, 3, -2842.93, 4539.57, -8.92945, 0, 0, 0, 0, 100, 0),
(784350, 4, -2832.84, 4562.57, -10.6274, 0, 0, 0, 0, 100, 0),
(784350, 5, -2812.07, 4585.45, -8.46509, 0, 0, 0, 0, 100, 0),
(784350, 6, -2787.71, 4619.89, -9.44887, 0.898668, 4000, 0, 0, 100, 0),
(784350, 7, -2803.7, 4593.78, -8.32121, 0, 0, 0, 0, 100, 0),
(784350, 8, -2832.8, 4562.59, -10.6239, 0, 0, 0, 0, 100, 0),
(784350, 9, -2841.43, 4548.17, -9.81332, 0, 0, 0, 0, 100, 0),
(784350, 10, -2842.89, 4536.18, -8.57972, 0, 0, 0, 0, 100, 0),
(784350, 11, -2832.78, 4509.27, -6.88285, 0, 0, 0, 0, 100, 0),
(784350, 12, -2831.88, 4486.51, -5.39805, 0, 0, 0, 0, 100, 0),
(784350, 13, -2845.88, 4456.93, -7.39068, 0, 0, 0, 0, 100, 0),
(784350, 14, -2859.88, 4439.34, -7.46962, 0, 0, 0, 0, 100, 0),
(784350, 15, -2890.42, 4435.54, -9.61593, 0, 0, 0, 0, 100, 0),
(784350, 16, -2914.65, 4419.62, -10.2268, 3.67392, 4000,0, 0, 100, 0),
(784350, 17, -2888.55, 4435.11, -9.39205, 0, 0, 0, 0, 100, 0),
(784350, 18, -2859.97, 4439.61, -7.46688, 0, 0, 0, 0, 100, 0),
(784350, 19, -2848.79, 4453.25, -7.47306, 0, 0, 0, 0, 100, 0),
--
(784360, 1, -2751.24, 4888.25, -9.28854, 3.74443, 4000,0, 0, 100, 0),
(784360, 2, -2731.95, 4896.86, -6.58817, 0, 0, 0, 0, 100, 0),
(784360, 3, -2718.83, 4895.61, -4.4686, 0, 0, 0, 0, 100, 0),
(784360, 4, -2709.21, 4893.35, -2.85624, 0, 0, 0, 0, 100, 0),
(784360, 5, -2703.63, 4899.27, -2.11423, 1.10156, 4000, 0, 0, 100, 0),
(784360, 6, -2708.72, 4891.87, -2.74489, 0, 0, 0, 0, 100, 0),
(784360, 7, -2715.36, 4890.9, -3.81047, 0, 0, 0, 0, 100, 0),
(784360, 8, -2733.71, 4896.45, -6.85721, 0, 0, 0, 0, 100, 0),
--
(784370, 1, -3912.88, 4442.68, -21.8564, 0, 0, 0, 0, 100, 0),
(784370, 2, -3885.3, 4449.06, -17.6061, 0, 0, 0, 0, 100, 0),
(784370, 3, -3870.17, 4444.44, -17.0983, 0, 0, 0, 0, 100, 0),
(784370, 4, -3857.8, 4425.22, -11.9723, 0, 0, 0, 0, 100, 0),
(784370, 5, -3843.65, 4414.56, -5.42625, 0, 0, 0, 0, 100, 0),
(784370, 6, -3826, 4395.88, -2.76405, 0, 0, 0, 0, 100, 0),
(784370, 7, -3816.99, 4386.3, -1.74294, 0.453158, 25000, 0, 0, 100, 0),
(784370, 8, -3843.95, 4414.5, -5.43119, 0, 0, 0, 0, 100, 0),
(784370, 9, -3858.05, 4425.61, -12.0773, 0, 0, 0, 0, 100, 0),
(784370, 10, -3870.53, 4444.23, -17.1895, 0, 0, 0, 0, 100, 0),
(784370, 11, -3885.38, 4448.33, -17.5162, 0, 0, 0, 0, 100, 0),
(784370, 12, -3901.84, 4441.53, -20.5696, 0, 0, 0, 0, 100, 0),
(784370, 13, -3912.32, 4442.49, -21.6698, 0, 0, 0, 0, 100, 0),
(784370, 14, -3922.04, 4441.38, -24.3755, 0, 0, 0, 0, 100, 0),
(784370, 15, -3929.11, 4435.51, -24.3135, 0.757902, 25000, 0, 0, 100, 0),
--
(784380, 1, -3526.37, 4199.18, -4.18007, 0, 0, 0, 0, 100, 0),
(784380, 2, -3502.95, 4204.91, -3.86274, 0, 0, 0, 0, 100, 0),
(784380, 3, -3485.76, 4213.2, -5.05477, 0, 0, 0, 0, 100, 0),
(784380, 4, -3478.05, 4210.96, -4.81493, 0, 0, 0, 0, 100, 0),
(784380, 5, -3466.32, 4196, -3.19562, 0, 0, 0, 0, 100, 0),
(784380, 6, -3458.17, 4190.77, -2.7045, 0, 0, 0, 0, 100, 0),
(784380, 7, -3442.91, 4194.63, -4.69759, 0, 0, 0, 0, 100, 0),
(784380, 8, -3419.98, 4207.14, -7.63673, 0, 0, 0, 0, 100, 0),
(784380, 9, -3392.66, 4211.94, -9.26122, 0, 0, 0, 0, 100, 0),
(784380, 10, -3371.72, 4209.28, -9.76929, 0, 0, 0, 0, 100, 0),
(784380, 11, -3345.31, 4200.04, -8.81895, 0, 0, 0, 0, 100, 0),
(784380, 12, -3318.96, 4181.89, -7.0849, 0, 0, 0, 0, 100, 0),
(784380, 13, -3302.02, 4175.35, -7.40304, 0, 0, 0, 0, 100, 0),
(784380, 14, -3292.47, 4177.36, -8.09926, 0, 0, 0, 0, 100, 0),
(784380, 15, -3291.31, 4189.23, -9.51124, 1.70764, 4000, 0, 0, 100, 0),
(784380, 16, -3293.06, 4177.42, -8.07473, 0, 0, 0, 0, 100, 0),
(784380, 17, -3300.57, 4172.31, -7.15121, 0, 0, 0, 0, 100, 0),
(784380, 18, -3310.15, 4173.36, -6.84514, 0, 0, 0, 0, 100, 0),
(784380, 19, -3334.44, 4193.86, -7.95459, 0, 0, 0, 0, 100, 0),
(784380, 20, -3355.39, 4203.79, -9.36296, 0, 0, 0, 0, 100, 0),
(784380, 21, -3380.73, 4211.96, -9.7678, 0, 0, 0, 0, 100, 0),
(784380, 22, -3393.45, 4211.85, -9.21899, 0, 0, 0, 0, 100, 0),
(784380, 23, -3421.38, 4206.5, -7.50797, 0, 0, 0, 0, 100, 0),
(784380, 24, -3444.25, 4194.58, -4.59379, 0, 0, 0, 0, 100, 0),
(784380, 25, -3458.62, 4190.86, -2.68858, 0, 0, 0, 0, 100, 0),
(784380, 26, -3469.01, 4198.23, -3.41623, 0, 0, 0, 0, 100, 0),
(784380, 27, -3479, 4211.13, -4.81482, 0, 0, 0, 0, 100, 0),
(784380, 28, -3488.95, 4213.56, -5.12335, 0, 0, 0, 0, 100, 0),
(784380, 29, -3504.71, 4205.71, -4.04269, 0, 0, 0, 0, 100, 0),
(784380, 30, -3522.31, 4198.98, -3.97894, 0, 0, 0, 0, 100, 0),
(784380, 31, -3532.67, 4201.09, -4.47656, 0, 0, 0, 0, 100, 0),
(784380, 32, -3553.74, 4222.86, -4.66667, 2.27873, 4000, 0, 0, 100, 0),
--
(784390, 1, -3082.88, 4264, -8.33045, 0, 0, 0, 0, 100, 0),
(784390, 2, -3041.47, 4307.55, -11.0783, 0.823214, 4000, 0, 0, 100, 0),
(784390, 3, -3063.64, 4284.76, -9.75672, 0, 0, 0, 0, 100, 0),
(784390, 4, -3083.91, 4262.66, -8.21446, 0, 0, 0, 0, 100, 0),
(784390, 5, -3096.39, 4258.22, -8.41367, 0, 0, 0, 0, 100, 0),
(784390, 6, -3119.69, 4258.84, -10.3825, 0, 0, 0, 0, 100, 0),
(784390, 7, -3136.22, 4243.77, -9.69491, 0, 0, 0, 0, 100, 0),
(784390, 8, -3168.68, 4213.08, -8.5083, 0, 0, 0, 0, 100, 0),
(784390, 9, -3167.28, 4197.63, -6.32812, 4.82227, 4000, 0, 0, 100, 0),
(784390, 10, -3168.68, 4213.08, -8.5083, 0, 0, 0, 0, 100, 0),
(784390, 11, -3120.7, 4259.65, -10.5223, 0, 0, 0, 0, 100, 0);

/* fix Skettis area */

SET @CGUID    := 671000;

-- fix Raven Stone Fragments
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` IN (22986);
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryorguid` IN (22986);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, 
`event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, 
`action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, 
`target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
--
(22986, 0, 0, 0, 75, 0, 100, 0, 0, 22972, 5, 2000, 0, 0, 50, 185541, 15, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Invis Raven Stone - On Near Sparrowhawk - Spawn Raven Stone Fragment');

-- fix speed Monstrous Kaliri - https://www.youtube.com/watch?v=vLIzGAOyQjY
UPDATE `creature_template` SET `speed_walk` = 4 WHERE `Entry` = 23051; -- was set to 14

-- Alluvion: the sniffed core Skettis spawns don't cover it, so keep the module's pooled spawns
DELETE FROM `creature` WHERE `id` IN (21730);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, 
`wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`) VALUES
(@CGUID+131, 21730, 530, 0, 0, 1, 1, 0, -3889.0701, 3579.5601, 249.9330, 5.7596, 600, 0, 0, 29500, 6618, 0, 0, 0, 0, '', 0, 0, NULL),
(@CGUID+132, 21730, 530, 0, 0, 1, 1, 0, -3972.0100, 3429.2700, 263.5920, 4.2761, 600, 0, 0, 29500, 6618, 0, 0, 0, 0, '', 0, 0, NULL),
(@CGUID+133, 21730, 530, 0, 0, 1, 1, 0, -3744.4199, 3428.0901, 249.5810, 4.1539, 600, 0, 0, 29500, 6618, 0, 0, 0, 0, '', 0, 0, NULL),
(@CGUID+134, 21730, 530, 0, 0, 1, 1, 0, -3724.6001, 3545.6799, 252.3530, 5.7596, 600, 0, 0, 29500, 6618, 0, 0, 0, 0, '', 0, 0, NULL);

DELETE FROM `pool_creature` WHERE `pool_entry` IN (601055);
INSERT INTO `pool_creature` (`guid`, `pool_entry`, `chance`, `description`) VALUES 
(@CGUID+131, 601055, 0, 'Alluvion'),
(@CGUID+132, 601055, 0, 'Alluvion'),
(@CGUID+133, 601055, 0, 'Alluvion'),
(@CGUID+134, 601055, 0, 'Alluvion');

DELETE FROM `pool_template` WHERE `entry` IN (601055);
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES 
(601055, 1, 'Alluvion - Skettis');
