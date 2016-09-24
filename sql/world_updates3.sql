UPDATE `smart_scripts` SET `event_flags`=`event_flags`|0x200 WHERE  `entryorguid`=25401 AND `source_type`=0;
UPDATE `smart_scripts` SET `event_flags`=`event_flags`|0x200 WHERE  `entryorguid`=2540100 AND `source_type`=9;
--
UPDATE `quest_template_addon` SET `PrevQuestID`=10143 WHERE `ID`=9575;

DELETE FROM `quest_template_addon` WHERE `ID` IN (9558, 10050);
INSERT INTO `quest_template_addon` (`ID`, `PrevQuestID`) VALUES
(9558, 10143),
(10050, 10143);
UPDATE `smart_scripts` SET `event_flags`=512 WHERE  `entryorguid`=3040300 AND `source_type`=9;
UPDATE `smart_scripts` SET `event_flags`=512 WHERE  `entryorguid`=30403 AND `source_type`=0;

UPDATE `smart_scripts` SET `event_flags`=512 WHERE  `entryorguid`=28669 AND `source_type`=0;
UPDATE `smart_scripts` SET `event_flags`=512 WHERE  `entryorguid`=2866900 AND `source_type`=9 AND `id`=0 AND `link`=0;
UPDATE `smart_scripts` SET `event_flags`=512 WHERE  `entryorguid`=28521 AND `source_type`=0;
UPDATE `smart_scripts` SET `event_flags`=512 WHERE  `entryorguid`=2852100 AND `source_type`=9 AND `id`=0 AND `link`=0;
UPDATE `smart_scripts` SET `event_flags`=512 WHERE  `entryorguid`=25969 AND `source_type`=0;
UPDATE `smart_scripts` SET `event_flags`=512 WHERE  `entryorguid`IN(2546000,2546001) AND `source_type`=9;
--
DELETE FROM `quest_template_addon` WHERE `ID` IN (10141, 10160);
INSERT INTO `quest_template_addon` (`ID`, `PrevQuestID`) VALUES
(10141, 10254),
(10160, 10254);
UPDATE `smart_scripts` SET `event_flags`=`event_flags`|0x200 WHERE  `entryorguid`=27587 AND `source_type`=0;
UPDATE `smart_scripts` SET `event_flags`=`event_flags`|0x200 WHERE  `entryorguid`=2758700 AND `source_type`=9;
UPDATE `smart_scripts` SET `event_flags`=512 WHERE  `entryorguid`=28308 AND `source_type`=0;
UPDATE `smart_scripts` SET `event_flags`=512 WHERE  `entryorguid`=2830800 AND `source_type`=9 AND `id`=1 AND `link`=0;
-- XT-002: Heartbreaker improvements
UPDATE `creature_template` SET `ScriptName`='npc_xt_void_zone' WHERE entry = 34001;
--
UPDATE `creature_template` SET `InhabitType`=4 WHERE `entry` IN (22432);
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=17 AND `SourceEntry`=39371 AND `ElseGroup`>0;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `Comment`) VALUES
(17, 0, 39371, 1, 31, 1, 3, 22507,0, "Ritual Prayer Beads"),
(17, 0, 39371, 2, 31, 1, 3, 22506,0, "Ritual Prayer Beads");

DELETE FROM `gossip_menu` WHERE `entry`=8554 AND `text_id`=10707;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (8554,10707);
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=14 AND `SourceGroup`=8554;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`, `ErrorTextId`,`ScriptName`,`Comment`, `NegativeCondition`) VALUES
(14,8554,10706,0,28,10935,0,0,0,'','Show gossip text if player  Exorcism of Colonel Jules is completed',0),
(14,8554,10706,1,8,10935,0,0,0,'','Show gossip text if player  Exorcism of Colonel Jules is rewarded',0),
(14,8554,10707,1,28,10935,0,0,0,'','Show gossip text if player  Exorcism of Colonel Jules is not completed',1),
(14,8554,10707,1,8,10935,0,0,0,'','Show gossip text if player  Exorcism of Colonel Jules is not rewarded',1);

DELETE FROM `spell_linked_spell` WHERE `spell_trigger` = 39371;
INSERT INTO `spell_linked_spell` VALUES (39371, 39322, 0, 'Heal Barada');

UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry` IN (22506, 22507);
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (22506, 22507);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(22506, 0, 0, 0, 8, 0, 100, 0, 39371, 0, 0, 0, 37, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Foul Purge - On Spellhit - Die"),
(22507, 0, 0, 0, 8, 0, 100, 0, 39371, 0, 0, 0, 37, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Darkness Released - On Spellhit - Die");
--
UPDATE `creature_text` SET `BroadcastTextId`=20755 WHERE `entry`=16819 AND `groupid`=2;
-- Remove all Blighted Elk & Rabid Grizzly spawns
DELETE FROM `creature` WHERE `id` IN (26616,26643);
 
-- Blighted Elk / Rabid Grizzly spawns
SET @CGUID := 145656;
DELETE FROM `creature` WHERE `guid` BETWEEN @CGUID+0 AND @CGUID+42;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `VerifiedBuild`) VALUES
(@CGUID+00, 26616, 571, 0, 0, 1, 1, 0, 0, 3608.987, 2706.795, 81.61842, 3.489897, 120, 10, 0, 0, 0, 1, 0, 0, 0, 22594),
(@CGUID+01, 26616, 571, 0, 0, 1, 1, 0, 0, 3631.727, 2687.107, 90.62743, 3.151358, 120, 10, 0, 0, 0, 1, 0, 0, 0, 22594),
(@CGUID+02, 26616, 571, 0, 0, 1, 1, 0, 0, 3633.847, 2099.581, 81.77094, 1.811403, 120, 10, 0, 0, 0, 1, 0, 0, 0, 22594),
(@CGUID+03, 26616, 571, 0, 0, 1, 1, 0, 0, 3635.306, 2161.763, 80.04393, 4.633221, 120, 10, 0, 0, 0, 1, 0, 0, 0, 22594),
(@CGUID+04, 26616, 571, 0, 0, 1, 1, 0, 0, 3658.856, 2091.767, 75.24414, 2.323115, 120, 10, 0, 0, 0, 1, 0, 0, 0, 22594),
(@CGUID+05, 26616, 571, 0, 0, 1, 1, 0, 0, 3667.841, 2208.016, 86.08277, 1.964503, 120, 10, 0, 0, 0, 1, 0, 0, 0, 22594),
(@CGUID+06, 26616, 571, 0, 0, 1, 1, 0, 0, 3673.516, 2463.127, 105.6333, 1.83448, 120, 10, 0, 0, 0, 1, 0, 0, 0, 22594),
(@CGUID+07, 26616, 571, 0, 0, 1, 1, 0, 0, 3679.703, 2009.963, 84.35659, 4.623409, 120, 10, 0, 0, 0, 1, 0, 0, 0, 22594),
(@CGUID+08, 26616, 571, 0, 0, 1, 1, 0, 0, 3689.573, 2296.82, 90.76158, 2.045934, 120, 10, 0, 0, 0, 1, 0, 0, 0, 22594),
(@CGUID+09, 26616, 571, 0, 0, 1, 1, 0, 0, 3695.083, 1933.479, 83.85369, 4.954051, 120, 10, 0, 0, 0, 1, 0, 0, 0, 22594),
(@CGUID+10, 26616, 571, 0, 0, 1, 1, 0, 0, 3701.474, 2514.475, 107.2812, 0.6286527, 120, 10, 0, 0, 0, 1, 0, 0, 0, 22594),
(@CGUID+11, 26616, 571, 0, 0, 1, 1, 0, 0, 3704.587, 2266.464, 92.08928, 5.654926, 120, 10, 0, 0, 0, 1, 0, 0, 0, 22594),
(@CGUID+12, 26616, 571, 0, 0, 1, 1, 0, 0, 3706.076, 2743.281, 104.7514, 4.170875, 120, 10, 0, 0, 0, 1, 0, 0, 0, 22594),
(@CGUID+13, 26616, 571, 0, 0, 1, 1, 0, 0, 3722.648, 2691.479, 114.6539, 3.485274, 120, 10, 0, 0, 0, 1, 0, 0, 0, 22594),
(@CGUID+14, 26616, 571, 0, 0, 1, 1, 0, 0, 3723.551, 2651.437, 121.4505, 0.8676791, 120, 10, 0, 0, 0, 1, 0, 0, 0, 22594),
(@CGUID+15, 26616, 571, 0, 0, 1, 1, 0, 0, 3725.103, 2049.998, 89.27189, 5.984902, 120, 10, 0, 0, 0, 1, 0, 0, 0, 22594),
(@CGUID+16, 26616, 571, 0, 0, 1, 1, 0, 0, 3737.078, 2379.541, 125.9424, 4.658678, 120, 10, 0, 0, 0, 1, 0, 0, 0, 22594),
(@CGUID+17, 26616, 571, 0, 0, 1, 1, 0, 0, 3738.888, 2511.032, 111.2622, 0.516483, 120, 10, 0, 0, 0, 1, 0, 0, 0, 22594),
(@CGUID+18, 26616, 571, 0, 0, 1, 1, 0, 0, 3742.809, 1906.732, 93.08707, 4.087896, 120, 10, 0, 0, 0, 1, 0, 0, 0, 22594),
(@CGUID+19, 26616, 571, 0, 0, 1, 1, 0, 0, 3750.026, 2256.787, 96.6433, 1.183217, 120, 10, 0, 0, 0, 1, 0, 0, 0, 22594),
(@CGUID+20, 26616, 571, 0, 0, 1, 1, 0, 0, 3755.162, 2109.537, 90.18472, 1.407896, 120, 10, 0, 0, 0, 1, 0, 0, 0, 22594),
(@CGUID+21, 26616, 571, 0, 0, 1, 1, 0, 0, 3778.959, 2595.174, 131.6573, 1.944773, 120, 10, 0, 0, 0, 1, 0, 0, 0, 22594),
(@CGUID+22, 26616, 571, 0, 0, 1, 1, 0, 0, 3789.701, 2439.881, 120.3564, 3.098214, 120, 10, 0, 0, 0, 1, 0, 0, 0, 22594),
(@CGUID+23, 26616, 571, 0, 0, 1, 1, 0, 0, 3793.529, 1991.409, 92.70969, 4.130076, 120, 10, 0, 0, 0, 1, 0, 0, 0, 22594),
(@CGUID+24, 26616, 571, 0, 0, 1, 1, 0, 0, 3811.9, 1883.307, 103.4728, 2.977729, 120, 10, 0, 0, 0, 1, 0, 0, 0, 22594),
(@CGUID+25, 26616, 571, 0, 0, 1, 1, 0, 0, 3830.944, 2745.978, 125.2044, 6.277326, 120, 10, 0, 0, 0, 1, 0, 0, 0, 22594),
(@CGUID+26, 26616, 571, 0, 0, 1, 1, 0, 0, 3841.809, 2670.203, 133.9133, 1.616634, 120, 10, 0, 0, 0, 1, 0, 0, 0, 22594),
(@CGUID+27, 26616, 571, 0, 0, 1, 1, 0, 0, 3846.796, 1855.145, 112.7773, 1.445089, 120, 10, 0, 0, 0, 1, 0, 0, 0, 22594),
(@CGUID+28, 26616, 571, 0, 0, 1, 1, 0, 0, 3885.523, 2723.021, 143.0718, 5.040751, 120, 10, 0, 0, 0, 1, 0, 0, 0, 22594),
(@CGUID+29, 26643, 571, 0, 0, 1, 1, 0, 0, 3644.814, 2108.32, 82.52487, 3.955455, 120, 10, 0, 0, 0, 1, 0, 0, 0, 22594),
(@CGUID+30, 26643, 571, 0, 0, 1, 1, 0, 0, 3653.489, 2038.248, 80.83339, 3.821825, 120, 10, 0, 0, 0, 1, 0, 0, 0, 22594),
(@CGUID+31, 26643, 571, 0, 0, 1, 1, 0, 0, 3658.551, 2177.805, 84.84097, 4.881752, 120, 10, 0, 0, 0, 1, 0, 0, 0, 22594),
(@CGUID+32, 26643, 571, 0, 0, 1, 1, 0, 0, 3694.929, 2288.579, 90.93569, 0.6433057, 120, 10, 0, 0, 0, 1, 0, 0, 0, 22594),
(@CGUID+33, 26643, 571, 0, 0, 1, 1, 0, 0, 3712.812, 2251.845, 92.32622, 2.203486, 120, 10, 0, 0, 0, 1, 0, 0, 0, 22594),
(@CGUID+34, 26643, 571, 0, 0, 1, 1, 0, 0, 3724.282, 1928.43, 88.45173, 5.032287, 120, 10, 0, 0, 0, 1, 0, 0, 0, 22594),
(@CGUID+35, 26643, 571, 0, 0, 1, 1, 0, 0, 3736.312, 2004.773, 89.53041, 5.835526, 120, 10, 0, 0, 0, 1, 0, 0, 0, 22594),
(@CGUID+36, 26643, 571, 0, 0, 1, 1, 0, 0, 3739.045, 2076.328, 90.76255, 0.2246024, 120, 10, 0, 0, 0, 1, 0, 0, 0, 22594),
(@CGUID+37, 26643, 571, 0, 0, 1, 1, 0, 0, 3761.153, 2253.946, 98.04789, 1.439007, 120, 10, 0, 0, 0, 1, 0, 0, 0, 22594),
(@CGUID+38, 26643, 571, 0, 0, 1, 1, 0, 0, 3766.299, 1923.924, 94.87557, 5.925901, 120, 10, 0, 0, 0, 1, 0, 0, 0, 22594),
(@CGUID+39, 26643, 571, 0, 0, 1, 1, 0, 0, 3767.844, 1891.139, 97.21929, 4.958078, 120, 10, 0, 0, 0, 1, 0, 0, 0, 22594),
(@CGUID+40, 26643, 571, 0, 0, 1, 1, 0, 0, 3821.683, 1853.887, 109.9058, 4.463461, 120, 10, 0, 0, 0, 1, 0, 0, 0, 22594),
(@CGUID+41, 26643, 571, 0, 0, 1, 1, 0, 0, 3826.253, 1899.961, 101.9508, 5.78898, 120, 10, 0, 0, 0, 1, 0, 0, 0, 22594),
(@CGUID+42, 26643, 571, 0, 0, 1, 1, 0, 0, 3881.319, 1850.369, 120.3408, 4.88412, 120, 10, 0, 0, 0, 1, 0, 0, 0, 22594);
UPDATE `smart_scripts` SET `event_flags`=512 WHERE  `entryorguid`=27409 AND `source_type`=0;
UPDATE `smart_scripts` SET `event_flags`=512 WHERE  `entryorguid`=2740900 AND `source_type`=9;

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry`=48682;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES 
(13, 2, 48682, 0, 0, 31, 0, 3, 27417, 0, 0, 0, 0, '', 'Escape from Silverbrook - Periodic Dummy targets Silverbrook Worgen');
UPDATE `smart_scripts` SET `target_type`=23 WHERE  `entryorguid`=3033100 AND `source_type`=9 AND `target_type`=7;
--
UPDATE `creature_template` SET `flags_extra`=`flags_extra`|64 WHERE `entry` IN (22506, 22507);

UPDATE `quest_template_addon` SET `PrevQuestID`=0 WHERE `ID`=10935;
UPDATE `quest_template_addon` SET `ExclusiveGroup`=-10909, `NextQuestID`=10935 WHERE `ID` IN (10909, 10916);
--
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (13, 17) AND `SourceEntry` IN (42767, 42788);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 2, 42788, 0, 0, 31, 0, 3, 23943, 0, 0, 0, 0, "", "Spell 'Feed Plaguehound' targets NPC 'Hungry Plaguehound'"),
(17, 0, 42788, 0, 0, 29, 0, 23943, 10, 0, 0, 0, 0, "", "Spell 'Feed Plaguehound' requires NPC 'Hungry Plaguehound' within 10 yards"),
(13, 1, 42767, 0, 0, 31, 0, 3, 23945, 0, 0, 0, 0, "", "Spell 'Sic'em' targets NPC 'Fjord Crow'");

UPDATE `creature_template` SET `spell1`=42767 WHERE `entry`=23943;

UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=23945;
DELETE FROM `smart_scripts` WHERE `entryorguid`=23945;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(23945, 0, 0, 0, 8, 0, 100, 0, 42767, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "Fjord Crow - On Spellhit 'Sic'em' - Attack Invoker");
-- NPC entry: 12144 Lunaclaw Spirit. Druid quest: Body and Heart (Alliance: 6001, Horde: 6002)

SET @Spirit := 12144;
SET @menu   := 3862;

DELETE FROM `gossip_menu_option` WHERE `menu_id` = @menu;
INSERT INTO `gossip_menu_option` (`menu_id`,`id`,`option_icon`,`option_text`,`OptionBroadcastTextID`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`,`BoxBroadcastTextID`,`VerifiedBuild`) VALUES
(@menu,0,0,'You have fought well, spirit.  I ask you to grant me the strength of your body and the strength of your heart.',7405,1,1,3863,0,0,0,'',0,0),
(@menu,1,0,'You have fought well, spirit.  I ask you to grant me the strength of your body and the strength of your heart.',7405,1,1,3863,0,0,0,'',0,0);

UPDATE `creature_template` SET `AIName`= 'SmartAI', `ScriptName`= '' WHERE `entry`= @Spirit;

DELETE FROM `smart_scripts` WHERE `entryorguid`= @Spirit AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@Spirit,0,0,1, 62,0,100,0,@menu,0,0,0, 72,    0,   0,0,0,0,0,7,0,0,0,0,0,0,0, 'Lunaclaw Spirit - On Gossip Option 0 Selected - Close Gossip'),
(@Spirit,0,1,2, 61,0,100,0,    0,0,0,0, 98, 3863,4715,0,0,0,0,7,0,0,0,0,0,0,0, 'Lunaclaw Spirit - On Gossip Option 0 Selected - Send Gossip'),
(@Spirit,0,2,0, 61,0,100,0,    0,0,0,0, 15, 6001,   0,0,0,0,0,7,0,0,0,0,0,0,0, "Lunaclaw Spirit - On Gossip Option 0 Selected - Credit Quest 'Body and Heart - Alliance'"),
(@Spirit,0,3,4, 62,0,100,0,@menu,1,0,0, 72,    0,   0,0,0,0,0,7,0,0,0,0,0,0,0, 'Lunaclaw Spirit - On Gossip Option 1 Selected - Close Gossip'),
(@Spirit,0,4,5, 61,0,100,0,    0,0,0,0, 98, 3863,4715,0,0,0,0,7,0,0,0,0,0,0,0, 'Lunaclaw Spirit - On Gossip Option 1 Selected - Send Gossip'),
(@Spirit,0,5,0, 61,0,100,0,    0,0,0,0, 15, 6002,   0,0,0,0,0,7,0,0,0,0,0,0,0, "Lunaclaw Spirit - On Gossip Option 1 Selected - Credit Quest 'Body and Heart - Horde'");

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`= 15 AND `SourceGroup`= @menu;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ErrorType`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(15,@menu,0,0,1, 6,0, 469,0,0,0,0,0,'','Show gossip menu 3862 option id 0 if player is on the Alliance team. -AND-'),
(15,@menu,0,0,1,28,0,6001,0,0,1,0,0,'','Show gossip menu 3862 option id 0 if quest Body and Heart has not been completed.'),
(15,@menu,1,0,2, 6,0,  67,0,0,0,0,0,'','Show gossip menu 3862 option id 1 if player is on the Horde team. -AND-'),
(15,@menu,1,0,2,28,0,6002,0,0,1,0,0,'','Show gossip menu 3862 option id 1 if quest Body and Heart has not been completed.');
-- uint8 -> uint16 for chain ID
ALTER TABLE `script_spline_chain_meta` MODIFY COLUMN `chainId` SMALLINT UNSIGNED NOT NULL;
ALTER TABLE `script_spline_chain_waypoints` MODIFY COLUMN `chainId` SMALLINT UNSIGNED NOT NULL;
--
UPDATE `gossip_menu_option` SET `option_id`=20 WHERE `OptionBroadcastTextID`=33762;
UPDATE `gossip_menu_option` SET `action_menu_id`=10373 WHERE `option_id`=18;
