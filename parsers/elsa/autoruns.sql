use syslog;

/*  Creates AUTORUNS Class & associated fields */

INSERT INTO classes (id, class) VALUES (10678, "AUTORUNS");

/* Add new fields: (only if they don't exist already) */
	
INSERT IGNORE INTO fields (field, field_type, pattern_type) VALUES ("hostname","string", "QSTRING");  
	
INSERT IGNORE INTO fields (field, field_type, pattern_type) VALUES ("entry","string", "QSTRING");
	
INSERT IGNORE INTO fields (field, field_type, pattern_type) VALUES ("category","string", "QSTRING");
	
INSERT IGNORE INTO fields (field, field_type, pattern_type) VALUES ("profile","string", "QSTRING");
	
INSERT IGNORE INTO fields (field, field_type, pattern_type) VALUES ("company","string", "QSTRING");
	
INSERT IGNORE INTO fields (field, field_type, pattern_type) VALUES ("path","string", "QSTRING");
	
	
/* Add mappings to the fields_classes_map */

INSERT IGNORE INTO fields_classes_map (class_id, field_id, field_order) VALUES ((SELECT id FROM classes WHERE class="AUTORUNS"), (SELECT id FROM fields WHERE field="hostname"), 11);
	
INSERT IGNORE INTO fields_classes_map (class_id, field_id, field_order) VALUES ((SELECT id FROM classes WHERE class="AUTORUNS"), (SELECT id FROM fields WHERE field="entry"), 12);
	
INSERT IGNORE INTO fields_classes_map (class_id, field_id, field_order) VALUES ((SELECT id FROM classes WHERE class="AUTORUNS"), (SELECT id FROM fields WHERE field="category"), 13);
	
INSERT IGNORE INTO fields_classes_map (class_id, field_id, field_order) VALUES ((SELECT id FROM classes WHERE class="AUTORUNS"), (SELECT id FROM fields WHERE field="profile"), 14);
	
INSERT IGNORE INTO fields_classes_map (class_id, field_id, field_order) VALUES ((SELECT id FROM classes WHERE class="AUTORUNS"), (SELECT id FROM fields WHERE field="company"), 15);
	
INSERT IGNORE INTO fields_classes_map (class_id, field_id, field_order) VALUES ((SELECT id FROM classes WHERE class="AUTORUNS"), (SELECT id FROM fields WHERE field="path"), 16);	
