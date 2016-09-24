DELETE FROM `spell_proc_event` WHERE `entry` IN (49028);
INSERT INTO `spell_proc_event` (entry, procFlags) VALUES('49028','69652');

UPDATE creature_template SET `ScriptName`="npc_dancing_rune_weapon" WHERE entry=27893;