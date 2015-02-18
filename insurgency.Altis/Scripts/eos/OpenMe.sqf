EOS_Spawn = compile preprocessfilelinenumbers "Scripts\eos\core\eos_launch.sqf";null=[] execVM "Scripts\eos\core\spawn_fnc.sqf";onplayerConnected {[] execVM "Scripts\eos\Functions\EOS_Markers.sqf";};
/* 
GROUP SIZES
 0 = 1
 1 = 2,4
 2 = 4,8
 3 = 8,12
 4 = 12,16
 5 = 16,20

EXAMPLE CALL - EOS
 null = [["MARKERNAME","MARKERNAME2"],[2,1,70],[0,1],[1,2,30],[2,60],[2],[1,0,10],[1,0,250,WEST]] call EOS_Spawn;
 null=[["M1","M2","M3"],[HOUSE GROUPS,SIZE OF GROUPS,PROBABILITY],[PATROL GROUPS,SIZE OF GROUPS,PROBABILITY],[LIGHT VEHICLES,SIZE OF CARGO,PROBABILITY],[ARMOURED VEHICLES,PROBABILITY], [STATIC VEHICLES,PROBABILITY],[HELICOPTERS,SIZE OF HELICOPTER CARGO,PROBABILITY],[FACTION,MARKERTYPE,DISTANCE,SIDE,HEIGHTLIMIT,DEBUG]] call EOS_Spawn;
*/
VictoryColor="colorGreen";
hostileColor="colorRed";	
bastionColor="colorRed";	
EOS_DAMAGE_MULTIPLIER=2;	
EOS_KILLCOUNTER=false;		

null = [["5_EOS","5_EOS_1","5_EOS_2","5_EOS_3","5_EOS_4","5_EOS_5","5_EOS_6","5_EOS_7","5_EOS_8","5_EOS_9","5_EOS_10","5_EOS_11","5_EOS_105",
"5_EOS_13","5_EOS_14","5_EOS_15","5_EOS_17","5_EOS_18","5_EOS_19","5_EOS_21","5_EOS_23","5_EOS_24","5_EOS_25","5_EOS_26","5_EOS_27",
"5_EOS_28","5_EOS_29","5_EOS_30","5_EOS_31","5_EOS_33","5_EOS_34","5_EOS_35","5_EOS_36","5_EOS_37","5_EOS_38","5_EOS_39","5_EOS_40",
"5_EOS_41","5_EOS_43","5_EOS_44","5_EOS_45","5_EOS_46","5_EOS_47","5_EOS_48","5_EOS_49","5_EOS_50","5_EOS_51","5_EOS_53","5_EOS_54",
"5_EOS_55","5_EOS_56","5_EOS_57","5_EOS_58","5_EOS_59","5_EOS_70","5_EOS_71","5_EOS_73","5_EOS_74","5_EOS_75","5_EOS_76","5_EOS_77",
"5_EOS_78","5_EOS_79","5_EOS_80","5_EOS_81","5_EOS_83","5_EOS_84","5_EOS_85","5_EOS_86","5_EOS_87","5_EOS_88","5_EOS_89","5_EOS_90",
"5_EOS_91","5_EOS_93","5_EOS_94","5_EOS_96","5_EOS_97","5_EOS_98","5_EOS_99","5_EOS_100","5_EOS_101","5_EOS_103","5_EOS_104","5_EOS_106",
"5_EOS_107","5_EOS_108","5_EOS_109","5_EOS_110","5_EOS_111","5_EOS_113","5_EOS_114","5_EOS_115","5_EOS_116","5_EOS_117","5_EOS_118",
"5_EOS_119","4_EOS","4_EOS_1","4_EOS_2","4_EOS_3","4_EOS_4","4_EOS_5","4_EOS_6","4_EOS_7","4_EOS_8","4_EOS_9","4_EOS_10","4_EOS_11",
"4_EOS_13","4_EOS_14","4_EOS_15","4_EOS_17","4_EOS_18","4_EOS_19","4_EOS_21","4_EOS_23","4_EOS_24","4_EOS_25","4_EOS_26","4_EOS_27",
"4_EOS_28","4_EOS_29","4_EOS_30","4_EOS_31","4_EOS_33","4_EOS_34","4_EOS_35","4_EOS_36","4_EOS_37","4_EOS_38","4_EOS_39","4_EOS_40",
"4_EOS_41","4_EOS_43","4_EOS_44","4_EOS_45","4_EOS_46","4_EOS_47","4_EOS_48","4_EOS_49","4_EOS_50","4_EOS_51","4_EOS_53","4_EOS_54",
"4_EOS_55","4_EOS_56","4_EOS_57","4_EOS_58","4_EOS_59","4_EOS_70","4_EOS_71","4_EOS_76","4_EOS_77",
"4_EOS_78","4_EOS_79","4_EOS_83","4_EOS_84","4_EOS_85","4_EOS_86","4_EOS_87","4_EOS_88","4_EOS_89","4_EOS_90","4_EOS_91","4_EOS_93",
"4_EOS_225","4_EOS_226","4_EOS_251","4_EOS_252","4_EOS_227","4_EOS_228","4_EOS_229","4_EOS_230","4_EOS_231","4_EOS_232","4_EOS_233",
"4_EOS_234","4_EOS_253","4_EOS_254","4_EOS_235","4_EOS_236","4_EOS_237","4_EOS_238","4_EOS_239","4_EOS_240","4_EOS_241","4_EOS_242",
"4_EOS_257","4_EOS_258","4_EOS_243","4_EOS_244","4_EOS_245","4_EOS_246","4_EOS_247","4_EOS_248","4_EOS_249","4_EOS_250","4_EOS_255",
"4_EOS_256","4_EOS_100","4_EOS_101","4_EOS_103","4_EOS_104","4_EOS_105","4_EOS_106","4_EOS_107","4_EOS_108","4_EOS_109","4_EOS_110",
"4_EOS_111","4_EOS_113","4_EOS_114","4_EOS_115","4_EOS_116","4_EOS_117","4_EOS_118","4_EOS_119","3_EOS","3_EOS_1","3_EOS_2","3_EOS_3",
"3_EOS_4","3_EOS_5","3_EOS_6","3_EOS_7","3_EOS_8","3_EOS_9","3_EOS_10","3_EOS_11","3_EOS_14","3_EOS_15","3_EOS_17","3_EOS_18",
"3_EOS_19","3_EOS_21","3_EOS_23","3_EOS_24","3_EOS_25","3_EOS_26","3_EOS_27","3_EOS_28","3_EOS_29","3_EOS_30","3_EOS_31","3_EOS_33",
"3_EOS_34","3_EOS_35","3_EOS_36","3_EOS_37","3_EOS_38","3_EOS_39","3_EOS_40","3_EOS_41","3_EOS_43","3_EOS_44","3_EOS_45","3_EOS_46",
"3_EOS_47","3_EOS_48","3_EOS_49","3_EOS_50","3_EOS_51","3_EOS_53","3_EOS_54","3_EOS_55","3_EOS_56","3_EOS_57","3_EOS_58","3_EOS_59",
"3_EOS_70","3_EOS_71","3_EOS_73","3_EOS_74","3_EOS_75","3_EOS_76","3_EOS_77","3_EOS_78","3_EOS_79","3_EOS_80","3_EOS_81","3_EOS_83",
"3_EOS_84","3_EOS_85","3_EOS_86","3_EOS_87","3_EOS_88","3_EOS_89","3_EOS_90","3_EOS_91","3_EOS_93","3_EOS_94","3_EOS_95","3_EOS_96",
"3_EOS_97","3_EOS_98","3_EOS_99","3_EOS_100","3_EOS_101","3_EOS_103","3_EOS_104","3_EOS_105","3_EOS_106","3_EOS_107","3_EOS_108","3_EOS_109",
"3_EOS_110","3_EOS_111","3_EOS_113","3_EOS_114","3_EOS_115","3_EOS_116","3_EOS_117","3_EOS_118","3_EOS_119","2_EOS","2_EOS_1","2_EOS_2",
"2_EOS_3","2_EOS_4","2_EOS_5","2_EOS_6","2_EOS_7","2_EOS_8","2_EOS_9","2_EOS_10","2_EOS_11","2_EOS_13","2_EOS_14","2_EOS_15","2_EOS_17",
"2_EOS_18","2_EOS_19","2_EOS_21","2_EOS_23","2_EOS_24","2_EOS_25","2_EOS_26","2_EOS_27","2_EOS_28","2_EOS_29","2_EOS_30","2_EOS_31",
"2_EOS_33","2_EOS_34","2_EOS_35","2_EOS_36","2_EOS_37","2_EOS_38","2_EOS_39","2_EOS_40","2_EOS_41","2_EOS_43","2_EOS_44","2_EOS_45",
"2_EOS_46","2_EOS_47","2_EOS_48","2_EOS_49","2_EOS_50","2_EOS_51","2_EOS_53","2_EOS_54","2_EOS_55","2_EOS_56","2_EOS_57","2_EOS_58",
"2_EOS_59","2_EOS_60","2_EOS_61","2_EOS_63","2_EOS_64","2_EOS_65","2_EOS_67","2_EOS_68","2_EOS_69","2_EOS_70","2_EOS_71","2_EOS_73",
"2_EOS_74","2_EOS_75","2_EOS_76","2_EOS_77","2_EOS_78","2_EOS_79","2_EOS_80","2_EOS_81","2_EOS_83","2_EOS_84","2_EOS_85","2_EOS_86",
"2_EOS_87","2_EOS_88","2_EOS_89","2_EOS_90","2_EOS_91","2_EOS_93","2_EOS_94","2_EOS_95","2_EOS_96","2_EOS_97","2_EOS_98","2_EOS_99",
"2_EOS_100","2_EOS_101","2_EOS_103","2_EOS_104","2_EOS_105","2_EOS_106","2_EOS_107","2_EOS_108","2_EOS_109","2_EOS_110","2_EOS_111",
"2_EOS_113","2_EOS_114","2_EOS_115","2_EOS_116","2_EOS_117","2_EOS_118","2_EOS_119","EOS_70","EOS_71","EOS_73","EOS_74","EOS_75","EOS_76",
"4_EOS_94","4_EOS_95","4_EOS_96","4_EOS_97","4_EOS_98","4_EOS_99","4_EOS_219","4_EOS_220","4_EOS_221","4_EOS_222","4_EOS_223","4_EOS_224",
"EOS_77","EOS_78","EOS_79","EOS_80","EOS_81","EOS_83","EOS_84","EOS_85","EOS_86","EOS_87","EOS_88","EOS_89","EOS_90","EOS_91","EOS_93",
"EOS_94","EOS_95","EOS_96","EOS_97","EOS_98","EOS_99","EOS_100","EOS_101","EOS_103","EOS_105","EOS_106","EOS_107","EOS_108",
"EOS_109","EOS_114","EOS_116","EOS_117","EOS_118","EOS_119","EOS","EOS_1","EOS_2","EOS_3","EOS_4","EOS_5","EOS_6","EOS_7","EOS_8","EOS_9",
"EOS_10","EOS_11","EOS_13","EOS_14","EOS_15","EOS_17","EOS_18","EOS_19","EOS_21","EOS_23","EOS_24","EOS_25","EOS_26","EOS_27","EOS_28",
"EOS_29","EOS_30","EOS_31","EOS_33","EOS_34","EOS_35","EOS_36","EOS_37","EOS_38","EOS_39","EOS_40","EOS_41","EOS_43","EOS_44","EOS_45",
"EOS_46","EOS_47","EOS_48","EOS_49","EOS_50","EOS_51","EOS_53","EOS_54","EOS_55","EOS_56","EOS_57","EOS_58","EOS_59","5_EOS_120","5_EOS_121",
"5_EOS_123","5_EOS_124","5_EOS_125","5_EOS_126","5_EOS_128","5_EOS_129","5_EOS_140","5_EOS_141","5_EOS_143","5_EOS_144","5_EOS_145",
"5_EOS_146","5_EOS_147","5_EOS_148","5_EOS_149","5_EOS_150","5_EOS_151","5_EOS_153","5_EOS_154","5_EOS_155","5_EOS_156","5_EOS_157",
"5_EOS_158","5_EOS_159","5_EOS_160","5_EOS_161","5_EOS_163","5_EOS_164","5_EOS_165","5_EOS_166","5_EOS_167","5_EOS_168","5_EOS_169",
"5_EOS_170","5_EOS_171","5_EOS_173","5_EOS_174","5_EOS_175","5_EOS_176","5_EOS_177","5_EOS_178","5_EOS_179","5_EOS_180","5_EOS_181",
"5_EOS_183","5_EOS_184","5_EOS_185","5_EOS_186","5_EOS_187","5_EOS_188","5_EOS_189","5_EOS_190","5_EOS_191","5_EOS_193","5_EOS_194","5_EOS_195",
"5_EOS_196","5_EOS_197","5_EOS_198","5_EOS_199","4_EOS_120","4_EOS_121","4_EOS_123","4_EOS_124","4_EOS_125","4_EOS_126","4_EOS_128",
"4_EOS_129","4_EOS_140","4_EOS_141","4_EOS_143","4_EOS_144","4_EOS_145","4_EOS_146","4_EOS_147","4_EOS_148","4_EOS_149","4_EOS_150",
"4_EOS_151","4_EOS_153","4_EOS_154","4_EOS_155","4_EOS_156","4_EOS_157","4_EOS_158","4_EOS_159","4_EOS_160","4_EOS_161","4_EOS_163",
"4_EOS_164","4_EOS_165","4_EOS_166","4_EOS_167","4_EOS_168","4_EOS_169","4_EOS_170","4_EOS_171","4_EOS_173","4_EOS_174","4_EOS_175",
"4_EOS_176","4_EOS_177","4_EOS_178","4_EOS_179","4_EOS_180","4_EOS_181","4_EOS_183","4_EOS_184","4_EOS_185","4_EOS_186","4_EOS_187",
"4_EOS_188","4_EOS_189","4_EOS_190","4_EOS_191","4_EOS_193","4_EOS_194","4_EOS_195","4_EOS_196","4_EOS_197","4_EOS_198","4_EOS_199",
"3_EOS_140","3_EOS_141","3_EOS_143","3_EOS_144","3_EOS_145","3_EOS_146","3_EOS_147","3_EOS_148","3_EOS_149","3_EOS_150","3_EOS_151",
"3_EOS_153","3_EOS_154","3_EOS_155","3_EOS_156","3_EOS_157","3_EOS_158","3_EOS_159","3_EOS_160","3_EOS_161","3_EOS_163","3_EOS_164",
"3_EOS_165","3_EOS_166","3_EOS_167","3_EOS_168","3_EOS_169","3_EOS_170","3_EOS_171","3_EOS_173","3_EOS_174","3_EOS_175","3_EOS_176",
"3_EOS_177","3_EOS_178","3_EOS_179","3_EOS_180","3_EOS_181","3_EOS_183","3_EOS_184","3_EOS_185","3_EOS_186","3_EOS_187","3_EOS_188",
"3_EOS_189","3_EOS_190","3_EOS_191","3_EOS_193","3_EOS_194","3_EOS_195","3_EOS_196","3_EOS_197","3_EOS_198","3_EOS_199","2_EOS_140",
"2_EOS_141","2_EOS_143","2_EOS_144","2_EOS_145","2_EOS_146","2_EOS_147","2_EOS_148","2_EOS_149","2_EOS_150","2_EOS_151","2_EOS_153",
"2_EOS_154","2_EOS_155","2_EOS_156","2_EOS_157","2_EOS_158","2_EOS_159","2_EOS_160","2_EOS_161","2_EOS_163","2_EOS_164","2_EOS_165",
"2_EOS_166","2_EOS_167","2_EOS_168","2_EOS_169","2_EOS_170","2_EOS_171","2_EOS_173","2_EOS_174","2_EOS_175","2_EOS_176","2_EOS_177",
"2_EOS_178","2_EOS_179","2_EOS_180","2_EOS_181","2_EOS_183","2_EOS_184","2_EOS_185","2_EOS_186","2_EOS_187","2_EOS_188","2_EOS_189",
"2_EOS_190","2_EOS_191","2_EOS_193","2_EOS_194","2_EOS_195","2_EOS_196","2_EOS_197","2_EOS_198","2_EOS_199","3_EOS_120","3_EOS_121",
"3_EOS_123","3_EOS_124","3_EOS_125","3_EOS_126","3_EOS_128","3_EOS_129","2_EOS_120","2_EOS_121","2_EOS_123","2_EOS_124","2_EOS_125",
"2_EOS_126","2_EOS_128","2_EOS_129","EOS_123","EOS_124","EOS_125","EOS_126","EOS_128","EOS_129","EOS_140","EOS_141","EOS_143","EOS_144",
"EOS_145","EOS_146","EOS_147","EOS_148","EOS_149","EOS_150","EOS_151","EOS_153","EOS_154","EOS_155","EOS_156","EOS_157","EOS_158","EOS_159",
"EOS_160","EOS_161","EOS_163","EOS_164","EOS_165","EOS_166","EOS_167","EOS_168","EOS_169","EOS_170","EOS_171","EOS_173","EOS_174","EOS_175",
"EOS_176","EOS_177","EOS_178","EOS_179","EOS_180","EOS_181","EOS_183","EOS_184","EOS_185","EOS_186","EOS_187","EOS_188","EOS_189","EOS_190",
"EOS_191","EOS_193","EOS_194","EOS_195","EOS_196","EOS_197","EOS_198","EOS_199","5_EOS_130","5_EOS_131","5_EOS_133","5_EOS_134","5_EOS_135",
"5_EOS_136","5_EOS_137","5_EOS_138","5_EOS_60","5_EOS_61","5_EOS_63","5_EOS_64","5_EOS_65","5_EOS_67","5_EOS_68","5_EOS_69","5_EOS_200",
"5_EOS_201","5_EOS_202","5_EOS_203","5_EOS_204","5_EOS_206","5_EOS_207","5_EOS_208","5_EOS_209","5_EOS_210","5_EOS_211",
"5_EOS_215","5_EOS_216","5_EOS_217","5_EOS_218","4_EOS_60","4_EOS_61","4_EOS_63","4_EOS_64","4_EOS_65","4_EOS_67","4_EOS_68","4_EOS_69",
"4_EOS_130","4_EOS_131","4_EOS_133","4_EOS_134","4_EOS_135","4_EOS_136","4_EOS_137","4_EOS_138","4_EOS_200","4_EOS_201","4_EOS_202",
"4_EOS_203","4_EOS_204","4_EOS_205","4_EOS_206","4_EOS_207","4_EOS_208","4_EOS_209","4_EOS_210","4_EOS_211","4_EOS_212","4_EOS_213",
"4_EOS_214","4_EOS_215","4_EOS_216","4_EOS_217","4_EOS_218","2_EOS_130","2_EOS_131","2_EOS_133","2_EOS_134","2_EOS_135","2_EOS_136",
"2_EOS_137","2_EOS_138","2_EOS_200","2_EOS_201","2_EOS_202","2_EOS_203","3_EOS_60","3_EOS_61","3_EOS_63","3_EOS_64","3_EOS_65","3_EOS_67",
"3_EOS_68","3_EOS_69","3_EOS_130","3_EOS_131","3_EOS_133","3_EOS_134","3_EOS_135","3_EOS_136","3_EOS_137","3_EOS_138","3_EOS_200","3_EOS_201",
"3_EOS_202","3_EOS_203","EOS_60","EOS_61","EOS_63","EOS_64","EOS_65","EOS_67","EOS_68","EOS_69","EOS_130","EOS_131","EOS_133","EOS_134",
"EOS_135","EOS_136","EOS_137","EOS_138","EOS_200","EOS_201","EOS_202","EOS_203","5_EOS_127","4_EOS_127","3_EOS_127","2_EOS_127","EOS_127",
"4_EOS_259","4_EOS_260","4_EOS_261","4_EOS_262","4_EOS_263","4_EOS_264","4_EOS_265","4_EOS_266","4_EOS_267","4_EOS_268","4_EOS_269",
"4_EOS_270","4_EOS_271","4_EOS_272","4_EOS_273","4_EOS_274","4_EOS_275","4_EOS_276","4_EOS_277","4_EOS_278","4_EOS_279","4_EOS_280","4_EOS_290","4_EOS_291",
"4_EOS_292","4_EOS_293","4_EOS_294","4_EOS_295","4_EOS_296","4_EOS_297","4_EOS_298","4_EOS_299","4_EOS_300","4_EOS_301","4_EOS_302",
"4_EOS_303","4_EOS_304","4_EOS_305","4_EOS_306","4_EOS_307","4_EOS_308","4_EOS_309","4_EOS_310","4_EOS_311","4_EOS_312","4_EOS_313",
"4_EOS_314","4_EOS_315","4_EOS_316","4_EOS_317","4_EOS_318","4_EOS_319","4_EOS_320","4_EOS_321","4_EOS_322","4_EOS_323","4_EOS_324",
"4_EOS_325","4_EOS_326","4_EOS_327","4_EOS_328","4_EOS_329","4_EOS_330","4_EOS_331","4_EOS_332","4_EOS_333","4_EOS_334","4_EOS_335",
"4_EOS_336","4_EOS_337","4_EOS_338","4_EOS_339","4_EOS_340","4_EOS_341","4_EOS_342","4_EOS_343","4_EOS_344","4_EOS_345","4_EOS_346",
"4_EOS_347","4_EOS_348","4_EOS_349","4_EOS_350","4_EOS_351","4_EOS_352","4_EOS_353","4_EOS_354","4_EOS_355","4_EOS_356","5_EOS_95",
"5_EOS_84_2","5_EOS_84_3","5_EOS_84_6","5_EOS_84_8","5_EOS_84_10","5_EOS_84_9","5_EOS_84_11","5_EOS_84_4"],[1,1,100],[1,1,100],[1,2,20],[1,7], [0,0],[1,3,10],[2,0,175,INDEPENDENT,TRUE,FALSE]] call EOS_Spawn;

null = [["5_EOS_12","5_EOS_22","5_EOS_32","5_EOS_42","5_EOS_66","5_EOS_72","5_EOS_82","5_EOS_92","5_EOS_112","5_EOS_122","5_EOS_132","5_EOS_162",
"5_EOS_172","5_EOS_182","4_EOS_12","4_EOS_22","4_EOS_32","4_EOS_42","4_EOS_66","4_EOS_72","4_EOS_82","4_EOS_92","4_EOS_112","4_EOS_122",
"4_EOS_132","4_EOS_162","4_EOS_172","4_EOS_182","3_EOS_12","3_EOS_22","3_EOS_32","3_EOS_42","3_EOS_66","3_EOS_72","3_EOS_82","3_EOS_92",
"3_EOS_112","3_EOS_122","3_EOS_132","3_EOS_162","3_EOS_172","3_EOS_182","2_EOS_12","2_EOS_22","2_EOS_32","2_EOS_42","2_EOS_66","2_EOS_72",
"2_EOS_82","2_EOS_92","2_EOS_112","2_EOS_122","2_EOS_132","2_EOS_162","2_EOS_172","2_EOS_182","EOS_12","EOS_22","EOS_32","EOS_42","EOS_66",
"EOS_72","EOS_82","EOS_92","EOS_122","EOS_132","EOS_162","EOS_172","EOS_182","5_EOS_16","5_EOS_52","5_EOS_102","5_EOS_192","5_EOS_139",
"4_EOS_16","4_EOS_52","4_EOS_102","4_EOS_192","4_EOS_139","3_EOS_16","3_EOS_52",
"3_EOS_102","3_EOS_192","3_EOS_139","2_EOS_16","2_EOS_52","2_EOS_102","2_EOS_192","2_EOS_139","EOS_16","EOS_52","EOS_102","EOS_192","EOS_139",
"5_EOS_20","5_EOS_62","5_EOS_142","5_EOS_152","4_EOS_20","4_EOS_62","4_EOS_142","4_EOS_152","3_EOS_20","3_EOS_62","3_EOS_142","3_EOS_152",
"2_EOS_20","2_EOS_62","2_EOS_142","2_EOS_152","EOS_20","EOS_62","EOS_142","EOS_152","5_EOS_84_1","5_EOS_84_7","5_EOS_84_5","6_EOS","6_EOS_1",
"6_EOS_2","6_EOS_3","6_EOS_4","6_EOS_5","6_EOS_6","6_EOS_7","6_EOS_8","6_EOS_9","6_EOS_10"]
,[1,1,100],[1,1,100],[1,2,100],[1,7], [1,1],[1,2,30],[2,0,175,INDEPENDENT,TRUE,FALSE]] call EOS_Spawn;

null = [["5_EOS","5_EOS_1","5_EOS_2","5_EOS_3","5_EOS_4","5_EOS_5","5_EOS_6","5_EOS_7","5_EOS_8","5_EOS_9","5_EOS_10","5_EOS_11","5_EOS_105",
"5_EOS_13","5_EOS_14","5_EOS_15","5_EOS_17","5_EOS_18","5_EOS_19","5_EOS_21","5_EOS_23","5_EOS_24","5_EOS_25","5_EOS_26","5_EOS_27",
"5_EOS_28","5_EOS_29","5_EOS_30","5_EOS_31","5_EOS_33","5_EOS_34","5_EOS_35","5_EOS_36","5_EOS_37","5_EOS_38","5_EOS_39","5_EOS_40",
"5_EOS_41","5_EOS_43","5_EOS_44","5_EOS_45","5_EOS_46","5_EOS_47","5_EOS_48","5_EOS_49","5_EOS_50","5_EOS_51","5_EOS_53","5_EOS_54",
"5_EOS_55","5_EOS_56","5_EOS_57","5_EOS_58","5_EOS_59","5_EOS_70","5_EOS_71","5_EOS_73","5_EOS_74","5_EOS_75","5_EOS_76","5_EOS_77",
"5_EOS_78","5_EOS_79","5_EOS_80","5_EOS_81","5_EOS_83","5_EOS_84","5_EOS_85","5_EOS_86","5_EOS_87","5_EOS_88","5_EOS_89","5_EOS_90",
"5_EOS_91","5_EOS_93","5_EOS_94","5_EOS_96","5_EOS_97","5_EOS_98","5_EOS_99","5_EOS_100","5_EOS_101","5_EOS_103","5_EOS_104","5_EOS_106",
"5_EOS_107","5_EOS_108","5_EOS_109","5_EOS_110","5_EOS_111","5_EOS_113","5_EOS_114","5_EOS_115","5_EOS_116","5_EOS_117","5_EOS_118",
"5_EOS_119","4_EOS","4_EOS_1","4_EOS_2","4_EOS_3","4_EOS_4","4_EOS_5","4_EOS_6","4_EOS_7","4_EOS_8","4_EOS_9","4_EOS_10","4_EOS_11",
"4_EOS_13","4_EOS_14","4_EOS_15","4_EOS_17","4_EOS_18","4_EOS_19","4_EOS_21","4_EOS_23","4_EOS_24","4_EOS_25","4_EOS_26","4_EOS_27",
"4_EOS_28","4_EOS_29","4_EOS_30","4_EOS_31","4_EOS_33","4_EOS_34","4_EOS_35","4_EOS_36","4_EOS_37","4_EOS_38","4_EOS_39","4_EOS_40",
"4_EOS_41","4_EOS_43","4_EOS_44","4_EOS_45","4_EOS_46","4_EOS_47","4_EOS_48","4_EOS_49","4_EOS_50","4_EOS_51","4_EOS_53","4_EOS_54",
"4_EOS_55","4_EOS_56","4_EOS_57","4_EOS_58","4_EOS_59","4_EOS_70","4_EOS_71","4_EOS_76","4_EOS_77",
"4_EOS_78","4_EOS_79","4_EOS_83","4_EOS_84","4_EOS_85","4_EOS_86","4_EOS_87","4_EOS_88","4_EOS_89","4_EOS_90","4_EOS_91","4_EOS_93",
"4_EOS_225","4_EOS_226","4_EOS_251","4_EOS_252","4_EOS_227","4_EOS_228","4_EOS_229","4_EOS_230","4_EOS_231","4_EOS_232","4_EOS_233",
"4_EOS_234","4_EOS_253","4_EOS_254","4_EOS_235","4_EOS_236","4_EOS_237","4_EOS_238","4_EOS_239","4_EOS_240","4_EOS_241","4_EOS_242",
"4_EOS_257","4_EOS_258","4_EOS_243","4_EOS_244","4_EOS_245","4_EOS_246","4_EOS_247","4_EOS_248","4_EOS_249","4_EOS_250","4_EOS_255",
"4_EOS_256","4_EOS_100","4_EOS_101","4_EOS_103","4_EOS_104","4_EOS_105","4_EOS_106","4_EOS_107","4_EOS_108","4_EOS_109","4_EOS_110",
"4_EOS_111","4_EOS_113","4_EOS_114","4_EOS_115","4_EOS_116","4_EOS_117","4_EOS_118","4_EOS_119","3_EOS","3_EOS_1","3_EOS_2","3_EOS_3",
"3_EOS_4","3_EOS_5","3_EOS_6","3_EOS_7","3_EOS_8","3_EOS_9","3_EOS_10","3_EOS_11","3_EOS_14","3_EOS_15","3_EOS_17","3_EOS_18",
"3_EOS_19","3_EOS_21","3_EOS_23","3_EOS_24","3_EOS_25","3_EOS_26","3_EOS_27","3_EOS_28","3_EOS_29","3_EOS_30","3_EOS_31","3_EOS_33",
"3_EOS_34","3_EOS_35","3_EOS_36","3_EOS_37","3_EOS_38","3_EOS_39","3_EOS_40","3_EOS_41","3_EOS_43","3_EOS_44","3_EOS_45","3_EOS_46",
"3_EOS_47","3_EOS_48","3_EOS_49","3_EOS_50","3_EOS_51","3_EOS_53","3_EOS_54","3_EOS_55","3_EOS_56","3_EOS_57","3_EOS_58","3_EOS_59",
"3_EOS_70","3_EOS_71","3_EOS_73","3_EOS_74","3_EOS_75","3_EOS_76","3_EOS_77","3_EOS_78","3_EOS_79","3_EOS_80","3_EOS_81","3_EOS_83",
"3_EOS_84","3_EOS_85","3_EOS_86","3_EOS_87","3_EOS_88","3_EOS_89","3_EOS_90","3_EOS_91","3_EOS_93","3_EOS_94","3_EOS_95","3_EOS_96",
"3_EOS_97","3_EOS_98","3_EOS_99","3_EOS_100","3_EOS_101","3_EOS_103","3_EOS_104","3_EOS_105","3_EOS_106","3_EOS_107","3_EOS_108","3_EOS_109",
"3_EOS_110","3_EOS_111","3_EOS_113","3_EOS_114","3_EOS_115","3_EOS_116","3_EOS_117","3_EOS_118","3_EOS_119","2_EOS","2_EOS_1","2_EOS_2",
"2_EOS_3","2_EOS_4","2_EOS_5","2_EOS_6","2_EOS_7","2_EOS_8","2_EOS_9","2_EOS_10","2_EOS_11","2_EOS_13","2_EOS_14","2_EOS_15","2_EOS_17",
"2_EOS_18","2_EOS_19","2_EOS_21","2_EOS_23","2_EOS_24","2_EOS_25","2_EOS_26","2_EOS_27","2_EOS_28","2_EOS_29","2_EOS_30","2_EOS_31",
"2_EOS_33","2_EOS_34","2_EOS_35","2_EOS_36","2_EOS_37","2_EOS_38","2_EOS_39","2_EOS_40","2_EOS_41","2_EOS_43","2_EOS_44","2_EOS_45",
"2_EOS_46","2_EOS_47","2_EOS_48","2_EOS_49","2_EOS_50","2_EOS_51","2_EOS_53","2_EOS_54","2_EOS_55","2_EOS_56","2_EOS_57","2_EOS_58",
"2_EOS_59","2_EOS_60","2_EOS_61","2_EOS_63","2_EOS_64","2_EOS_65","2_EOS_67","2_EOS_68","2_EOS_69","2_EOS_70","2_EOS_71","2_EOS_73",
"2_EOS_74","2_EOS_75","2_EOS_76","2_EOS_77","2_EOS_78","2_EOS_79","2_EOS_80","2_EOS_81","2_EOS_83","2_EOS_84","2_EOS_85","2_EOS_86",
"2_EOS_87","2_EOS_88","2_EOS_89","2_EOS_90","2_EOS_91","2_EOS_93","2_EOS_94","2_EOS_95","2_EOS_96","2_EOS_97","2_EOS_98","2_EOS_99",
"2_EOS_100","2_EOS_101","2_EOS_103","2_EOS_104","2_EOS_105","2_EOS_106","2_EOS_107","2_EOS_108","2_EOS_109","2_EOS_110","2_EOS_111",
"2_EOS_113","2_EOS_114","2_EOS_115","2_EOS_116","2_EOS_117","2_EOS_118","2_EOS_119","EOS_70","EOS_71","EOS_73","EOS_74","EOS_75","EOS_76",
"4_EOS_94","4_EOS_95","4_EOS_96","4_EOS_97","4_EOS_98","4_EOS_99","4_EOS_219","4_EOS_220","4_EOS_221","4_EOS_222","4_EOS_223","4_EOS_224",
"EOS_77","EOS_78","EOS_79","EOS_80","EOS_81","EOS_83","EOS_84","EOS_85","EOS_86","EOS_87","EOS_88","EOS_89","EOS_90","EOS_91","EOS_93",
"EOS_94","EOS_95","EOS_96","EOS_97","EOS_98","EOS_99","EOS_100","EOS_101","EOS_103","EOS_105","EOS_106","EOS_107","EOS_108",
"EOS_109","EOS_114","EOS_116","EOS_117","EOS_118","EOS_119","EOS","EOS_1","EOS_2","EOS_3","EOS_4","EOS_5","EOS_6","EOS_7","EOS_8","EOS_9",
"EOS_10","EOS_11","EOS_13","EOS_14","EOS_15","EOS_17","EOS_18","EOS_19","EOS_21","EOS_23","EOS_24","EOS_25","EOS_26","EOS_27","EOS_28",
"EOS_29","EOS_30","EOS_31","EOS_33","EOS_34","EOS_35","EOS_36","EOS_37","EOS_38","EOS_39","EOS_40","EOS_41","EOS_43","EOS_44","EOS_45",
"EOS_46","EOS_47","EOS_48","EOS_49","EOS_50","EOS_51","EOS_53","EOS_54","EOS_55","EOS_56","EOS_57","EOS_58","EOS_59","5_EOS_120","5_EOS_121",
"5_EOS_123","5_EOS_124","5_EOS_125","5_EOS_126","5_EOS_128","5_EOS_129","5_EOS_140","5_EOS_141","5_EOS_143","5_EOS_144","5_EOS_145",
"5_EOS_146","5_EOS_147","5_EOS_148","5_EOS_149","5_EOS_150","5_EOS_151","5_EOS_153","5_EOS_154","5_EOS_155","5_EOS_156","5_EOS_157",
"5_EOS_158","5_EOS_159","5_EOS_160","5_EOS_161","5_EOS_163","5_EOS_164","5_EOS_165","5_EOS_166","5_EOS_167","5_EOS_168","5_EOS_169",
"5_EOS_170","5_EOS_171","5_EOS_173","5_EOS_174","5_EOS_175","5_EOS_176","5_EOS_177","5_EOS_178","5_EOS_179","5_EOS_180","5_EOS_181",
"5_EOS_183","5_EOS_184","5_EOS_185","5_EOS_186","5_EOS_187","5_EOS_188","5_EOS_189","5_EOS_190","5_EOS_191","5_EOS_193","5_EOS_194","5_EOS_195",
"5_EOS_196","5_EOS_197","5_EOS_198","5_EOS_199","4_EOS_120","4_EOS_121","4_EOS_123","4_EOS_124","4_EOS_125","4_EOS_126","4_EOS_128",
"4_EOS_129","4_EOS_140","4_EOS_141","4_EOS_143","4_EOS_144","4_EOS_145","4_EOS_146","4_EOS_147","4_EOS_148","4_EOS_149","4_EOS_150",
"4_EOS_151","4_EOS_153","4_EOS_154","4_EOS_155","4_EOS_156","4_EOS_157","4_EOS_158","4_EOS_159","4_EOS_160","4_EOS_161","4_EOS_163",
"4_EOS_164","4_EOS_165","4_EOS_166","4_EOS_167","4_EOS_168","4_EOS_169","4_EOS_170","4_EOS_171","4_EOS_173","4_EOS_174","4_EOS_175",
"4_EOS_176","4_EOS_177","4_EOS_178","4_EOS_179","4_EOS_180","4_EOS_181","4_EOS_183","4_EOS_184","4_EOS_185","4_EOS_186","4_EOS_187",
"4_EOS_188","4_EOS_189","4_EOS_190","4_EOS_191","4_EOS_193","4_EOS_194","4_EOS_195","4_EOS_196","4_EOS_197","4_EOS_198","4_EOS_199",
"3_EOS_140","3_EOS_141","3_EOS_143","3_EOS_144","3_EOS_145","3_EOS_146","3_EOS_147","3_EOS_148","3_EOS_149","3_EOS_150","3_EOS_151",
"3_EOS_153","3_EOS_154","3_EOS_155","3_EOS_156","3_EOS_157","3_EOS_158","3_EOS_159","3_EOS_160","3_EOS_161","3_EOS_163","3_EOS_164",
"3_EOS_165","3_EOS_166","3_EOS_167","3_EOS_168","3_EOS_169","3_EOS_170","3_EOS_171","3_EOS_173","3_EOS_174","3_EOS_175","3_EOS_176",
"3_EOS_177","3_EOS_178","3_EOS_179","3_EOS_180","3_EOS_181","3_EOS_183","3_EOS_184","3_EOS_185","3_EOS_186","3_EOS_187","3_EOS_188",
"3_EOS_189","3_EOS_190","3_EOS_191","3_EOS_193","3_EOS_194","3_EOS_195","3_EOS_196","3_EOS_197","3_EOS_198","3_EOS_199","2_EOS_140",
"2_EOS_141","2_EOS_143","2_EOS_144","2_EOS_145","2_EOS_146","2_EOS_147","2_EOS_148","2_EOS_149","2_EOS_150","2_EOS_151","2_EOS_153",
"2_EOS_154","2_EOS_155","2_EOS_156","2_EOS_157","2_EOS_158","2_EOS_159","2_EOS_160","2_EOS_161","2_EOS_163","2_EOS_164","2_EOS_165",
"2_EOS_166","2_EOS_167","2_EOS_168","2_EOS_169","2_EOS_170","2_EOS_171","2_EOS_173","2_EOS_174","2_EOS_175","2_EOS_176","2_EOS_177",
"2_EOS_178","2_EOS_179","2_EOS_180","2_EOS_181","2_EOS_183","2_EOS_184","2_EOS_185","2_EOS_186","2_EOS_187","2_EOS_188","2_EOS_189",
"2_EOS_190","2_EOS_191","2_EOS_193","2_EOS_194","2_EOS_195","2_EOS_196","2_EOS_197","2_EOS_198","2_EOS_199","3_EOS_120","3_EOS_121",
"3_EOS_123","3_EOS_124","3_EOS_125","3_EOS_126","3_EOS_128","3_EOS_129","2_EOS_120","2_EOS_121","2_EOS_123","2_EOS_124","2_EOS_125",
"2_EOS_126","2_EOS_128","2_EOS_129","EOS_123","EOS_124","EOS_125","EOS_126","EOS_128","EOS_129","EOS_140","EOS_141","EOS_143","EOS_144",
"EOS_145","EOS_146","EOS_147","EOS_148","EOS_149","EOS_150","EOS_151","EOS_153","EOS_154","EOS_155","EOS_156","EOS_157","EOS_158","EOS_159",
"EOS_160","EOS_161","EOS_163","EOS_164","EOS_165","EOS_166","EOS_167","EOS_168","EOS_169","EOS_170","EOS_171","EOS_173","EOS_174","EOS_175",
"EOS_176","EOS_177","EOS_178","EOS_179","EOS_180","EOS_181","EOS_183","EOS_184","EOS_185","EOS_186","EOS_187","EOS_188","EOS_189","EOS_190",
"EOS_191","EOS_193","EOS_194","EOS_195","EOS_196","EOS_197","EOS_198","EOS_199","5_EOS_130","5_EOS_131","5_EOS_133","5_EOS_134","5_EOS_135",
"5_EOS_136","5_EOS_137","5_EOS_138","5_EOS_60","5_EOS_61","5_EOS_63","5_EOS_64","5_EOS_65","5_EOS_67","5_EOS_68","5_EOS_69","5_EOS_200",
"5_EOS_201","5_EOS_202","5_EOS_203","5_EOS_204","5_EOS_206","5_EOS_207","5_EOS_208","5_EOS_209","5_EOS_210","5_EOS_211",
"5_EOS_215","5_EOS_216","5_EOS_217","5_EOS_218","4_EOS_60","4_EOS_61","4_EOS_63","4_EOS_64","4_EOS_65","4_EOS_67","4_EOS_68","4_EOS_69",
"4_EOS_130","4_EOS_131","4_EOS_133","4_EOS_134","4_EOS_135","4_EOS_136","4_EOS_137","4_EOS_138","4_EOS_200","4_EOS_201","4_EOS_202",
"4_EOS_203","4_EOS_204","4_EOS_205","4_EOS_206","4_EOS_207","4_EOS_208","4_EOS_209","4_EOS_210","4_EOS_211","4_EOS_212","4_EOS_213",
"4_EOS_214","4_EOS_215","4_EOS_216","4_EOS_217","4_EOS_218","2_EOS_130","2_EOS_131","2_EOS_133","2_EOS_134","2_EOS_135","2_EOS_136",
"2_EOS_137","2_EOS_138","2_EOS_200","2_EOS_201","2_EOS_202","2_EOS_203","3_EOS_60","3_EOS_61","3_EOS_63","3_EOS_64","3_EOS_65","3_EOS_67",
"3_EOS_68","3_EOS_69","3_EOS_130","3_EOS_131","3_EOS_133","3_EOS_134","3_EOS_135","3_EOS_136","3_EOS_137","3_EOS_138","3_EOS_200","3_EOS_201",
"3_EOS_202","3_EOS_203","EOS_60","EOS_61","EOS_63","EOS_64","EOS_65","EOS_67","EOS_68","EOS_69","EOS_130","EOS_131","EOS_133","EOS_134",
"EOS_135","EOS_136","EOS_137","EOS_138","EOS_200","EOS_201","EOS_202","EOS_203","5_EOS_127","4_EOS_127","3_EOS_127","2_EOS_127","EOS_127",
"4_EOS_259","4_EOS_260","4_EOS_261","4_EOS_262","4_EOS_263","4_EOS_264","4_EOS_265","4_EOS_266","4_EOS_267","4_EOS_268","4_EOS_269",
"4_EOS_270","4_EOS_271","4_EOS_272","4_EOS_273","4_EOS_274","4_EOS_275","4_EOS_276","4_EOS_277","4_EOS_278","4_EOS_279","4_EOS_280","4_EOS_290","4_EOS_291",
"4_EOS_292","4_EOS_293","4_EOS_294","4_EOS_295","4_EOS_296","4_EOS_297","4_EOS_298","4_EOS_299","4_EOS_300","4_EOS_301","4_EOS_302",
"4_EOS_303","4_EOS_304","4_EOS_305","4_EOS_306","4_EOS_307","4_EOS_308","4_EOS_309","4_EOS_310","4_EOS_311","4_EOS_312","4_EOS_313",
"4_EOS_314","4_EOS_315","4_EOS_316","4_EOS_317","4_EOS_318","4_EOS_319","4_EOS_320","4_EOS_321","4_EOS_322","4_EOS_323","4_EOS_324",
"4_EOS_325","4_EOS_326","4_EOS_327","4_EOS_328","4_EOS_329","4_EOS_330","4_EOS_331","4_EOS_332","4_EOS_333","4_EOS_334","4_EOS_335",
"4_EOS_336","4_EOS_337","4_EOS_338","4_EOS_339","4_EOS_340","4_EOS_341","4_EOS_342","4_EOS_343","4_EOS_344","4_EOS_345","4_EOS_346",
"4_EOS_347","4_EOS_348","4_EOS_349","4_EOS_350","4_EOS_351","4_EOS_352","4_EOS_353","4_EOS_354","4_EOS_355","4_EOS_356","5_EOS_95",
"5_EOS_84_2","5_EOS_84_3","5_EOS_84_6","5_EOS_84_8","5_EOS_84_10","5_EOS_84_9","5_EOS_84_11","5_EOS_84_4"],[1,1,100],[1,1,100],[1,2,20],[1,7], [0,0],[1,3,10],[2,0,175,OPFOR,TRUE,FALSE]] call EOS_Spawn;

null = [["5_EOS_12","5_EOS_22","5_EOS_32","5_EOS_42","5_EOS_66","5_EOS_72","5_EOS_82","5_EOS_92","5_EOS_112","5_EOS_122","5_EOS_132","5_EOS_162",
"5_EOS_172","5_EOS_182","4_EOS_12","4_EOS_22","4_EOS_32","4_EOS_42","4_EOS_66","4_EOS_72","4_EOS_82","4_EOS_92","4_EOS_112","4_EOS_122",
"4_EOS_132","4_EOS_162","4_EOS_172","4_EOS_182","3_EOS_12","3_EOS_22","3_EOS_32","3_EOS_42","3_EOS_66","3_EOS_72","3_EOS_82","3_EOS_92",
"3_EOS_112","3_EOS_122","3_EOS_132","3_EOS_162","3_EOS_172","3_EOS_182","2_EOS_12","2_EOS_22","2_EOS_32","2_EOS_42","2_EOS_66","2_EOS_72",
"2_EOS_82","2_EOS_92","2_EOS_112","2_EOS_122","2_EOS_132","2_EOS_162","2_EOS_172","2_EOS_182","EOS_12","EOS_22","EOS_32","EOS_42","EOS_66",
"EOS_72","EOS_82","EOS_92","EOS_122","EOS_132","EOS_162","EOS_172","EOS_182","5_EOS_16","5_EOS_52","5_EOS_102","5_EOS_192","5_EOS_139",
"4_EOS_16","4_EOS_52","4_EOS_102","4_EOS_192","4_EOS_139","3_EOS_16","3_EOS_52",
"3_EOS_102","3_EOS_192","3_EOS_139","2_EOS_16","2_EOS_52","2_EOS_102","2_EOS_192","2_EOS_139","EOS_16","EOS_52","EOS_102","EOS_192","EOS_139",
"5_EOS_20","5_EOS_62","5_EOS_142","5_EOS_152","4_EOS_20","4_EOS_62","4_EOS_142","4_EOS_152","3_EOS_20","3_EOS_62","3_EOS_142","3_EOS_152",
"2_EOS_20","2_EOS_62","2_EOS_142","2_EOS_152","EOS_20","EOS_62","EOS_142","EOS_152","5_EOS_84_1","5_EOS_84_7","5_EOS_84_5","6_EOS","6_EOS_1",
"6_EOS_2","6_EOS_3","6_EOS_4","6_EOS_5","6_EOS_6","6_EOS_7","6_EOS_8","6_EOS_9","6_EOS_10"]
,[1,1,100],[1,1,100],[1,2,100],[1,7], [1,1],[1,2,30],[2,0,175,OPFOR,TRUE,FALSE]] call EOS_Spawn;

