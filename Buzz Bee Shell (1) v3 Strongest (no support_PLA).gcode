; HEADER_BLOCK_START
; BambuStudio 01.10.01.50
; model printing time: 12m 58s; total estimated time: 19m 40s
; total layer number: 101
; total filament length [mm] : 2178.61
; total filament volume [cm^3] : 5240.18
; total filament weight [g] : 6.60
; filament_density: 1.26
; filament_diameter: 1.75
; max_z_height: 20.20
; HEADER_BLOCK_END

; CONFIG_BLOCK_START
; accel_to_decel_enable = 0
; accel_to_decel_factor = 50%
; activate_air_filtration = 0
; additional_cooling_fan_speed = 70
; auxiliary_fan = 1
; bed_custom_model = 
; bed_custom_texture = 
; bed_exclude_area = 0x0,18x0,18x28,0x28
; before_layer_change_gcode = 
; best_object_pos = 0.5,0.5
; bottom_shell_layers = 3
; bottom_shell_thickness = 0
; bottom_surface_pattern = monotonic
; bridge_angle = 0
; bridge_flow = 1
; bridge_no_support = 0
; bridge_speed = 50
; brim_object_gap = 0.1
; brim_type = auto_brim
; brim_width = 5
; chamber_temperatures = 0
; change_filament_gcode = M620 S[next_extruder]A\nM204 S9000\n{if toolchange_count > 1 && (z_hop_types[current_extruder] == 0 || z_hop_types[current_extruder] == 3)}\nG17\nG2 Z{z_after_toolchange + 0.4} I0.86 J0.86 P1 F10000 ; spiral lift a little from second lift\n{endif}\nG1 Z{max_layer_z + 3.0} F1200\n\nG1 X70 F21000\nG1 Y245\nG1 Y265 F3000\nM400\nM106 P1 S0\nM106 P2 S0\n{if old_filament_temp > 142 && next_extruder < 255}\nM104 S[old_filament_temp]\n{endif}\n{if long_retractions_when_cut[previous_extruder]}\nM620.11 S1 I[previous_extruder] E-{retraction_distances_when_cut[previous_extruder]} F{old_filament_e_feedrate}\n{else}\nM620.11 S0\n{endif}\nM400\nG1 X90 F3000\nG1 Y255 F4000\nG1 X100 F5000\nG1 X120 F15000\nG1 X20 Y50 F21000\nG1 Y-3\n{if toolchange_count == 2}\n; get travel path for change filament\nM620.1 X[travel_point_1_x] Y[travel_point_1_y] F21000 P0\nM620.1 X[travel_point_2_x] Y[travel_point_2_y] F21000 P1\nM620.1 X[travel_point_3_x] Y[travel_point_3_y] F21000 P2\n{endif}\nM620.1 E F[old_filament_e_feedrate] T{nozzle_temperature_range_high[previous_extruder]}\nT[next_extruder]\nM620.1 E F[new_filament_e_feedrate] T{nozzle_temperature_range_high[next_extruder]}\n\n{if next_extruder < 255}\n{if long_retractions_when_cut[previous_extruder]}\nM620.11 S1 I[previous_extruder] E{retraction_distances_when_cut[previous_extruder]} F{old_filament_e_feedrate}\nM628 S1\nG92 E0\nG1 E{retraction_distances_when_cut[previous_extruder]} F[old_filament_e_feedrate]\nM400\nM629 S1\n{else}\nM620.11 S0\n{endif}\nG92 E0\n{if flush_length_1 > 1}\nM83\n; FLUSH_START\n; always use highest temperature to flush\nM400\n{if filament_type[next_extruder] == "PETG"}\nM109 S260\n{elsif filament_type[next_extruder] == "PVA"}\nM109 S210\n{else}\nM109 S[nozzle_temperature_range_high]\n{endif}\n{if flush_length_1 > 23.7}\nG1 E23.7 F{old_filament_e_feedrate} ; do not need pulsatile flushing for start part\nG1 E{(flush_length_1 - 23.7) * 0.02} F50\nG1 E{(flush_length_1 - 23.7) * 0.23} F{old_filament_e_feedrate}\nG1 E{(flush_length_1 - 23.7) * 0.02} F50\nG1 E{(flush_length_1 - 23.7) * 0.23} F{new_filament_e_feedrate}\nG1 E{(flush_length_1 - 23.7) * 0.02} F50\nG1 E{(flush_length_1 - 23.7) * 0.23} F{new_filament_e_feedrate}\nG1 E{(flush_length_1 - 23.7) * 0.02} F50\nG1 E{(flush_length_1 - 23.7) * 0.23} F{new_filament_e_feedrate}\n{else}\nG1 E{flush_length_1} F{old_filament_e_feedrate}\n{endif}\n; FLUSH_END\nG1 E-[old_retract_length_toolchange] F1800\nG1 E[old_retract_length_toolchange] F300\n{endif}\n\n{if flush_length_2 > 1}\n\nG91\nG1 X3 F12000; move aside to extrude\nG90\nM83\n\n; FLUSH_START\nG1 E{flush_length_2 * 0.18} F{new_filament_e_feedrate}\nG1 E{flush_length_2 * 0.02} F50\nG1 E{flush_length_2 * 0.18} F{new_filament_e_feedrate}\nG1 E{flush_length_2 * 0.02} F50\nG1 E{flush_length_2 * 0.18} F{new_filament_e_feedrate}\nG1 E{flush_length_2 * 0.02} F50\nG1 E{flush_length_2 * 0.18} F{new_filament_e_feedrate}\nG1 E{flush_length_2 * 0.02} F50\nG1 E{flush_length_2 * 0.18} F{new_filament_e_feedrate}\nG1 E{flush_length_2 * 0.02} F50\n; FLUSH_END\nG1 E-[new_retract_length_toolchange] F1800\nG1 E[new_retract_length_toolchange] F300\n{endif}\n\n{if flush_length_3 > 1}\n\nG91\nG1 X3 F12000; move aside to extrude\nG90\nM83\n\n; FLUSH_START\nG1 E{flush_length_3 * 0.18} F{new_filament_e_feedrate}\nG1 E{flush_length_3 * 0.02} F50\nG1 E{flush_length_3 * 0.18} F{new_filament_e_feedrate}\nG1 E{flush_length_3 * 0.02} F50\nG1 E{flush_length_3 * 0.18} F{new_filament_e_feedrate}\nG1 E{flush_length_3 * 0.02} F50\nG1 E{flush_length_3 * 0.18} F{new_filament_e_feedrate}\nG1 E{flush_length_3 * 0.02} F50\nG1 E{flush_length_3 * 0.18} F{new_filament_e_feedrate}\nG1 E{flush_length_3 * 0.02} F50\n; FLUSH_END\nG1 E-[new_retract_length_toolchange] F1800\nG1 E[new_retract_length_toolchange] F300\n{endif}\n\n{if flush_length_4 > 1}\n\nG91\nG1 X3 F12000; move aside to extrude\nG90\nM83\n\n; FLUSH_START\nG1 E{flush_length_4 * 0.18} F{new_filament_e_feedrate}\nG1 E{flush_length_4 * 0.02} F50\nG1 E{flush_length_4 * 0.18} F{new_filament_e_feedrate}\nG1 E{flush_length_4 * 0.02} F50\nG1 E{flush_length_4 * 0.18} F{new_filament_e_feedrate}\nG1 E{flush_length_4 * 0.02} F50\nG1 E{flush_length_4 * 0.18} F{new_filament_e_feedrate}\nG1 E{flush_length_4 * 0.02} F50\nG1 E{flush_length_4 * 0.18} F{new_filament_e_feedrate}\nG1 E{flush_length_4 * 0.02} F50\n; FLUSH_END\n{endif}\n; FLUSH_START\nM400\nM109 S[new_filament_temp]\nG1 E2 F{new_filament_e_feedrate} ;Compensate for filament spillage during waiting temperature\n; FLUSH_END\nM400\nG92 E0\nG1 E-[new_retract_length_toolchange] F1800\nM106 P1 S255\nM400 S3\n\nG1 X70 F5000\nG1 X90 F3000\nG1 Y255 F4000\nG1 X105 F5000\nG1 Y265 F5000\nG1 X70 F10000\nG1 X100 F5000\nG1 X70 F10000\nG1 X100 F5000\n\nG1 X70 F10000\nG1 X80 F15000\nG1 X60\nG1 X80\nG1 X60\nG1 X80 ; shake to put down garbage\nG1 X100 F5000\nG1 X165 F15000; wipe and shake\nG1 Y256 ; move Y to aside, prevent collision\nM400\nG1 Z{max_layer_z + 3.0} F3000\n{if layer_z <= (initial_layer_print_height + 0.001)}\nM204 S[initial_layer_acceleration]\n{else}\nM204 S[default_acceleration]\n{endif}\n{else}\nG1 X[x_after_toolchange] Y[y_after_toolchange] Z[z_after_toolchange] F12000\n{endif}\nM621 S[next_extruder]A\n
; close_fan_the_first_x_layers = 1
; complete_print_exhaust_fan_speed = 70
; cool_plate_temp = 35
; cool_plate_temp_initial_layer = 35
; curr_bed_type = Cool Plate
; default_acceleration = 10000
; default_filament_colour = ""
; default_filament_profile = "Bambu PLA Basic @BBL X1C"
; default_jerk = 0
; default_print_profile = 0.20mm Standard @BBL X1C
; deretraction_speed = 30
; detect_narrow_internal_solid_infill = 1
; detect_overhang_wall = 1
; detect_thin_wall = 0
; draft_shield = disabled
; during_print_exhaust_fan_speed = 70
; elefant_foot_compensation = 0.15
; enable_arc_fitting = 1
; enable_long_retraction_when_cut = 2
; enable_overhang_bridge_fan = 1
; enable_overhang_speed = 1
; enable_pressure_advance = 0
; enable_prime_tower = 0
; enable_support = 0
; enforce_support_layers = 0
; eng_plate_temp = 0
; eng_plate_temp_initial_layer = 0
; ensure_vertical_shell_thickness = 1
; exclude_object = 1
; extruder_clearance_dist_to_rod = 33
; extruder_clearance_height_to_lid = 90
; extruder_clearance_height_to_rod = 34
; extruder_clearance_max_radius = 68
; extruder_colour = #018001
; extruder_offset = 0x2
; extruder_type = DirectDrive
; fan_cooling_layer_time = 100
; fan_max_speed = 100
; fan_min_speed = 100
; filament_colour = #00AE42
; filament_cost = 24.99
; filament_density = 1.26
; filament_diameter = 1.75
; filament_end_gcode = "; filament end gcode \nM106 P3 S0\n"
; filament_flow_ratio = 0.98
; filament_ids = GFA00
; filament_is_support = 0
; filament_long_retractions_when_cut = 1
; filament_max_volumetric_speed = 21
; filament_minimal_purge_on_wipe_tower = 15
; filament_notes = 
; filament_retraction_distances_when_cut = 18
; filament_scarf_gap = 0%
; filament_scarf_height = 10%
; filament_scarf_length = 10
; filament_scarf_seam_type = none
; filament_settings_id = "Bambu PLA Basic @BBL X1C"
; filament_shrink = 100%
; filament_soluble = 0
; filament_start_gcode = "; filament start gcode\n{if  (bed_temperature[current_extruder] >55)||(bed_temperature_initial_layer[current_extruder] >55)}M106 P3 S200\n{elsif(bed_temperature[current_extruder] >50)||(bed_temperature_initial_layer[current_extruder] >50)}M106 P3 S150\n{elsif(bed_temperature[current_extruder] >45)||(bed_temperature_initial_layer[current_extruder] >45)}M106 P3 S50\n{endif}\nM142 P1 R35 S40\n{if activate_air_filtration[current_extruder] && support_air_filtration}\nM106 P3 S{during_print_exhaust_fan_speed_num[current_extruder]} \n{endif}"
; filament_type = PLA
; filament_vendor = "Bambu Lab"
; filename_format = {input_filename_base}_{filament_type[0]}_{print_time}.gcode
; filter_out_gap_fill = 0
; first_layer_print_sequence = 0
; flush_into_infill = 0
; flush_into_objects = 0
; flush_into_support = 1
; flush_multiplier = 1
; flush_volumes_matrix = 0
; flush_volumes_vector = 140,140
; full_fan_speed_layer = 0
; fuzzy_skin = none
; fuzzy_skin_point_distance = 0.8
; fuzzy_skin_thickness = 0.3
; gap_infill_speed = 250
; gcode_add_line_number = 0
; gcode_flavor = marlin
; has_scarf_joint_seam = 0
; head_wrap_detect_zone = 
; host_type = octoprint
; hot_plate_temp = 55
; hot_plate_temp_initial_layer = 55
; independent_support_layer_height = 1
; infill_combination = 0
; infill_direction = 45
; infill_jerk = 9
; infill_wall_overlap = 15%
; initial_layer_acceleration = 500
; initial_layer_flow_ratio = 1
; initial_layer_infill_speed = 105
; initial_layer_jerk = 9
; initial_layer_line_width = 0.5
; initial_layer_print_height = 0.2
; initial_layer_speed = 50
; inner_wall_acceleration = 0
; inner_wall_jerk = 9
; inner_wall_line_width = 0.45
; inner_wall_speed = 300
; interface_shells = 0
; internal_bridge_support_thickness = 0.8
; internal_solid_infill_line_width = 0.42
; internal_solid_infill_pattern = zig-zag
; internal_solid_infill_speed = 250
; ironing_direction = 45
; ironing_flow = 10%
; ironing_inset = 0.21
; ironing_pattern = zig-zag
; ironing_spacing = 0.15
; ironing_speed = 30
; ironing_type = no ironing
; is_infill_first = 0
; layer_change_gcode = ; layer num/total_layer_count: {layer_num+1}/[total_layer_count]\nM622.1 S1 ; for prev firware, default turned on\nM1002 judge_flag timelapse_record_flag\nM622 J1\n{if timelapse_type == 0} ; timelapse without wipe tower\nM971 S11 C10 O0\nM1004 S5 P1  ; external shutter\n{elsif timelapse_type == 1} ; timelapse with wipe tower\nG92 E0\nG1 E-[retraction_length] F1800\nG17\nG2 Z{layer_z + 0.4} I0.86 J0.86 P1 F20000 ; spiral lift a little\nG1 X65 Y245 F20000 ; move to safe pos\nG17\nG2 Z{layer_z} I0.86 J0.86 P1 F20000\nG1 Y265 F3000\nM400\nM1004 S5 P1  ; external shutter\nM400 P300\nM971 S11 C10 O0\nG92 E0\nG1 E[retraction_length] F300\nG1 X100 F5000\nG1 Y255 F20000\n{endif}\nM623\n; update layer progress\nM73 L{layer_num+1}\nM991 S0 P{layer_num} ;notify layer change
; layer_height = 0.2
; line_width = 0.42
; long_retractions_when_cut = 0
; machine_end_gcode = ;===== date: 20240528 =====================\nM400 ; wait for buffer to clear\nG92 E0 ; zero the extruder\nG1 E-0.8 F1800 ; retract\nG1 Z{max_layer_z + 0.5} F900 ; lower z a little\nG1 X65 Y245 F12000 ; move to safe pos\nG1 Y265 F3000\n\nG1 X65 Y245 F12000\nG1 Y265 F3000\nM140 S0 ; turn off bed\nM106 S0 ; turn off fan\nM106 P2 S0 ; turn off remote part cooling fan\nM106 P3 S0 ; turn off chamber cooling fan\n\nG1 X100 F12000 ; wipe\n; pull back filament to AMS\nM620 S255\nG1 X20 Y50 F12000\nG1 Y-3\nT255\nG1 X65 F12000\nG1 Y265\nG1 X100 F12000 ; wipe\nM621 S255\nM104 S0 ; turn off hotend\n\nM622.1 S1 ; for prev firware, default turned on\nM1002 judge_flag timelapse_record_flag\nM622 J1\n    M400 ; wait all motion done\n    M991 S0 P-1 ;end smooth timelapse at safe pos\n    M400 S3 ;wait for last picture to be taken\nM623; end of "timelapse_record_flag"\n\nM400 ; wait all motion done\nM17 S\nM17 Z0.4 ; lower z motor current to reduce impact if there is something in the bottom\n{if (max_layer_z + 100.0) < 250}\n    G1 Z{max_layer_z + 100.0} F600\n    G1 Z{max_layer_z +98.0}\n{else}\n    G1 Z250 F600\n    G1 Z248\n{endif}\nM400 P100\nM17 R ; restore z current\n\nM220 S100  ; Reset feedrate magnitude\nM201.2 K1.0 ; Reset acc magnitude\nM73.2   R1.0 ;Reset left time magnitude\nM1002 set_gcode_claim_speed_level : 0\n;=====printer finish  sound=========\nM17\nM400 S1\nM1006 S1\nM1006 A0 B20 L100 C37 D20 M40 E42 F20 N60\nM1006 A0 B10 L100 C44 D10 M60 E44 F10 N60\nM1006 A0 B10 L100 C46 D10 M80 E46 F10 N80\nM1006 A44 B20 L100 C39 D20 M60 E48 F20 N60\nM1006 A0 B10 L100 C44 D10 M60 E44 F10 N60\nM1006 A0 B10 L100 C0 D10 M60 E0 F10 N60\nM1006 A0 B10 L100 C39 D10 M60 E39 F10 N60\nM1006 A0 B10 L100 C0 D10 M60 E0 F10 N60\nM1006 A0 B10 L100 C44 D10 M60 E44 F10 N60\nM1006 A0 B10 L100 C0 D10 M60 E0 F10 N60\nM1006 A0 B10 L100 C39 D10 M60 E39 F10 N60\nM1006 A0 B10 L100 C0 D10 M60 E0 F10 N60\nM1006 A0 B10 L100 C48 D10 M60 E44 F10 N100\nM1006 A0 B10 L100 C0 D10 M60 E0 F10  N100\nM1006 A49 B20 L100 C44 D20 M100 E41 F20 N100\nM1006 A0 B20 L100 C0 D20 M60 E0 F20 N100\nM1006 A0 B20 L100 C37 D20 M30 E37 F20 N60\nM1006 W\n\nM17 X0.8 Y0.8 Z0.5 ; lower motor current to 45% power\nM960 S5 P0 ; turn off logo lamp\n
; machine_load_filament_time = 29
; machine_max_acceleration_e = 5000,5000
; machine_max_acceleration_extruding = 20000,20000
; machine_max_acceleration_retracting = 5000,5000
; machine_max_acceleration_travel = 9000,9000
; machine_max_acceleration_x = 20000,20000
; machine_max_acceleration_y = 20000,20000
; machine_max_acceleration_z = 500,200
; machine_max_jerk_e = 2.5,2.5
; machine_max_jerk_x = 9,9
; machine_max_jerk_y = 9,9
; machine_max_jerk_z = 3,3
; machine_max_speed_e = 30,30
; machine_max_speed_x = 500,200
; machine_max_speed_y = 500,200
; machine_max_speed_z = 20,20
; machine_min_extruding_rate = 0,0
; machine_min_travel_rate = 0,0
; machine_pause_gcode = M400 U1
; machine_start_gcode = ;===== machine: X1 ====================\n;===== date: 20240919 ==================\n;===== start printer sound ================\nM17\nM400 S1\nM1006 S1\nM1006 A0 B10 L100 C37 D10 M60 E37 F10 N60\nM1006 A0 B10 L100 C41 D10 M60 E41 F10 N60\nM1006 A0 B10 L100 C44 D10 M60 E44 F10 N60\nM1006 A0 B10 L100 C0 D10 M60 E0 F10 N60\nM1006 A46 B10 L100 C43 D10 M70 E39 F10 N100\nM1006 A0 B10 L100 C0 D10 M60 E0 F10 N100\nM1006 A43 B10 L100 C0 D10 M60 E39 F10 N100\nM1006 A0 B10 L100 C0 D10 M60 E0 F10 N100\nM1006 A41 B10 L100 C0 D10 M100 E41 F10 N100\nM1006 A44 B10 L100 C0 D10 M100 E44 F10 N100\nM1006 A49 B10 L100 C0 D10 M100 E49 F10 N100\nM1006 A0 B10 L100 C0 D10 M100 E0 F10 N100\nM1006 A48 B10 L100 C44 D10 M60 E39 F10 N100\nM1006 A0 B10 L100 C0 D10 M60 E0 F10 N100\nM1006 A44 B10 L100 C0 D10 M90 E39 F10 N100\nM1006 A0 B10 L100 C0 D10 M60 E0 F10 N100\nM1006 A46 B10 L100 C43 D10 M60 E39 F10 N100\nM1006 W\n;===== turn on the HB fan =================\nM104 S75 ;set extruder temp to turn on the HB fan and prevent filament oozing from nozzle\n;===== reset machine status =================\nM290 X40 Y40 Z2.6666666\nG91\nM17 Z0.4 ; lower the z-motor current\nG380 S2 Z30 F300 ; G380 is same as G38; lower the hotbed , to prevent the nozzle is below the hotbed\nG380 S2 Z-25 F300 ;\nG1 Z5 F300;\nG90\nM17 X1.2 Y1.2 Z0.75 ; reset motor current to default\nM960 S5 P1 ; turn on logo lamp\nG90\nM220 S100 ;Reset Feedrate\nM221 S100 ;Reset Flowrate\nM73.2   R1.0 ;Reset left time magnitude\nM1002 set_gcode_claim_speed_level : 5\nM221 X0 Y0 Z0 ; turn off soft endstop to prevent protential logic problem\nG29.1 Z{+0.0} ; clear z-trim value first\nM204 S10000 ; init ACC set to 10m/s^2\n\n;===== heatbed preheat ====================\nM1002 gcode_claim_action : 2\nM140 S[bed_temperature_initial_layer_single] ;set bed temp\nM190 S[bed_temperature_initial_layer_single] ;wait for bed temp\n\n{if scan_first_layer}\n;=========register first layer scan=====\nM977 S1 P60\n{endif}\n\n;=============turn on fans to prevent PLA jamming=================\n{if filament_type[initial_no_support_extruder]=="PLA"}\n    {if (bed_temperature[initial_no_support_extruder] >45)||(bed_temperature_initial_layer[initial_no_support_extruder] >45)}\n    M106 P3 S180\n    {endif};Prevent PLA from jamming\n    M142 P1 R35 S40\n{endif}\nM106 P2 S100 ; turn on big fan ,to cool down toolhead\n\n;===== prepare print temperature and material ==========\nM104 S[nozzle_temperature_initial_layer] ;set extruder temp\nG91\nG0 Z10 F1200\nG90\nG28 X\nM975 S1 ; turn on\nG1 X60 F12000\nG1 Y245\nG1 Y265 F3000\nM620 M\nM620 S[initial_no_support_extruder]A   ; switch material if AMS exist\n    M109 S[nozzle_temperature_initial_layer]\n    G1 X120 F12000\n\n    G1 X20 Y50 F12000\n    G1 Y-3\n    T[initial_no_support_extruder]\n    G1 X54 F12000\n    G1 Y265\n    M400\nM621 S[initial_no_support_extruder]A\nM620.1 E F{filament_max_volumetric_speed[initial_no_support_extruder]/2.4053*60} T{nozzle_temperature_range_high[initial_no_support_extruder]}\n\nM412 S1 ; ===turn on filament runout detection===\n\nM109 S250 ;set nozzle to common flush temp\nM106 P1 S0\nG92 E0\nG1 E50 F200\nM400\nM104 S[nozzle_temperature_initial_layer]\nG92 E0\nG1 E50 F200\nM400\nM106 P1 S255\nG92 E0\nG1 E5 F300\nM109 S{nozzle_temperature_initial_layer[initial_no_support_extruder]-20} ; drop nozzle temp, make filament shink a bit\nG92 E0\nG1 E-0.5 F300\n\nG1 X70 F9000\nG1 X76 F15000\nG1 X65 F15000\nG1 X76 F15000\nG1 X65 F15000; shake to put down garbage\nG1 X80 F6000\nG1 X95 F15000\nG1 X80 F15000\nG1 X165 F15000; wipe and shake\nM400\nM106 P1 S0\n;===== prepare print temperature and material end =====\n\n\n;===== wipe nozzle ===============================\nM1002 gcode_claim_action : 14\nM975 S1\nM106 S255\nG1 X65 Y230 F18000\nG1 Y264 F6000\nM109 S{nozzle_temperature_initial_layer[initial_no_support_extruder]-20}\nG1 X100 F18000 ; first wipe mouth\n\nG0 X135 Y253 F20000  ; move to exposed steel surface edge\nG28 Z P0 T300; home z with low precision,permit 300deg temperature\nG29.2 S0 ; turn off ABL\nG0 Z5 F20000\n\nG1 X60 Y265\nG92 E0\nG1 E-0.5 F300 ; retrack more\nG1 X100 F5000; second wipe mouth\nG1 X70 F15000\nG1 X100 F5000\nG1 X70 F15000\nG1 X100 F5000\nG1 X70 F15000\nG1 X100 F5000\nG1 X70 F15000\nG1 X90 F5000\nG0 X128 Y261 Z-1.5 F20000  ; move to exposed steel surface and stop the nozzle\nM104 S140 ; set temp down to heatbed acceptable\nM106 S255 ; turn on fan (G28 has turn off fan)\n\nM221 S; push soft endstop status\nM221 Z0 ;turn off Z axis endstop\nG0 Z0.5 F20000\nG0 X125 Y259.5 Z-1.01\nG0 X131 F211\nG0 X124\nG0 Z0.5 F20000\nG0 X125 Y262.5\nG0 Z-1.01\nG0 X131 F211\nG0 X124\nG0 Z0.5 F20000\nG0 X125 Y260.0\nG0 Z-1.01\nG0 X131 F211\nG0 X124\nG0 Z0.5 F20000\nG0 X125 Y262.0\nG0 Z-1.01\nG0 X131 F211\nG0 X124\nG0 Z0.5 F20000\nG0 X125 Y260.5\nG0 Z-1.01\nG0 X131 F211\nG0 X124\nG0 Z0.5 F20000\nG0 X125 Y261.5\nG0 Z-1.01\nG0 X131 F211\nG0 X124\nG0 Z0.5 F20000\nG0 X125 Y261.0\nG0 Z-1.01\nG0 X131 F211\nG0 X124\nG0 X128\nG2 I0.5 J0 F300\nG2 I0.5 J0 F300\nG2 I0.5 J0 F300\nG2 I0.5 J0 F300\n\nM109 S140 ; wait nozzle temp down to heatbed acceptable\nG2 I0.5 J0 F3000\nG2 I0.5 J0 F3000\nG2 I0.5 J0 F3000\nG2 I0.5 J0 F3000\n\nM221 R; pop softend status\nG1 Z10 F1200\nM400\nG1 Z10\nG1 F30000\nG1 X128 Y128\nG29.2 S1 ; turn on ABL\n;G28 ; home again after hard wipe mouth\nM106 S0 ; turn off fan , too noisy\n;===== wipe nozzle end ================================\n\n;===== check scanner clarity ===========================\nG1 X128 Y128 F24000\nG28 Z P0\nM972 S5 P0\nG1 X230 Y15 F24000\n;===== check scanner clarity end =======================\n\n;===== bed leveling ==================================\nM1002 judge_flag g29_before_print_flag\nM622 J1\n\n    M1002 gcode_claim_action : 1\n    G29 A X{first_layer_print_min[0]} Y{first_layer_print_min[1]} I{first_layer_print_size[0]} J{first_layer_print_size[1]}\n    M400\n    M500 ; save cali data\n\nM623\n;===== bed leveling end ================================\n\n;===== home after wipe mouth============================\nM1002 judge_flag g29_before_print_flag\nM622 J0\n\n    M1002 gcode_claim_action : 13\n    G28\n\nM623\n;===== home after wipe mouth end =======================\n\nM975 S1 ; turn on vibration supression\n\n;=============turn on fans to prevent PLA jamming=================\n{if filament_type[initial_no_support_extruder]=="PLA"}\n    {if (bed_temperature[initial_no_support_extruder] >45)||(bed_temperature_initial_layer[initial_no_support_extruder] >45)}\n    M106 P3 S180\n    {endif};Prevent PLA from jamming\n    M142 P1 R35 S40\n{endif}\nM106 P2 S100 ; turn on big fan ,to cool down toolhead\n\nM104 S{nozzle_temperature_initial_layer[initial_no_support_extruder]} ; set extrude temp earlier, to reduce wait time\n\n;===== mech mode fast check============================\nG1 X128 Y128 Z10 F20000\nM400 P200\nM970.3 Q1 A7 B30 C80  H15 K0\nM974 Q1 S2 P0\n\nG1 X128 Y128 Z10 F20000\nM400 P200\nM970.3 Q0 A7 B30 C90 Q0 H15 K0\nM974 Q0 S2 P0\n\nM975 S1\nG1 F30000\nG1 X230 Y15\nG28 X ; re-home XY\n;===== mech mode fast check============================\n\n{if scan_first_layer}\n;start heatbed  scan====================================\nM976 S2 P1\nG90\nG1 X128 Y128 F20000\nM976 S3 P2  ;register void printing detection\n{endif}\n\n;===== nozzle load line ===============================\nM975 S1\nG90\nM83\nT1000\nG1 X18.0 Y1.0 Z0.8 F18000;Move to start position\nM109 S{nozzle_temperature[initial_no_support_extruder]}\nG1 Z0.2\nG0 E2 F300\nG0 X240 E15 F{outer_wall_volumetric_speed/(0.3*0.5)     * 60}\nG0 Y11 E0.700 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\nG0 X239.5\nG0 E0.2\nG0 Y1.5 E0.700\nG0 X231 E0.700 F{outer_wall_volumetric_speed/(0.3*0.5)     * 60}\nM400\n\n;===== for Textured PEI Plate , lower the nozzle as the nozzle was touching topmost of the texture when homing ==\n;curr_bed_type={curr_bed_type}\n{if curr_bed_type=="Textured PEI Plate"}\nG29.1 Z{-0.04} ; for Textured PEI Plate\n{endif}\n\n;===== draw extrinsic para cali paint =================\nM1002 judge_flag extrude_cali_flag\nM622 J1\n\n    M1002 gcode_claim_action : 8\n\n    T1000\n\n    G0 F1200.0 X231 Y15   Z0.2 E0.741\n    G0 F1200.0 X226 Y15   Z0.2 E0.275\n    G0 F1200.0 X226 Y8    Z0.2 E0.384\n    G0 F1200.0 X216 Y8    Z0.2 E0.549\n    G0 F1200.0 X216 Y1.5  Z0.2 E0.357\n\n    G0 X48.0 E12.0 F{outer_wall_volumetric_speed/(0.3*0.5)     * 60}\n    G0 X48.0 Y14 E0.92 F1200.0\n    G0 X35.0 Y6.0 E1.03 F1200.0\n\n    ;=========== extruder cali extrusion ==================\n    T1000\n    M83\n    {if default_acceleration > 0}\n        {if outer_wall_acceleration > 0}\n            M204 S[outer_wall_acceleration]\n        {else}\n            M204 S[default_acceleration]\n        {endif}\n    {endif}\n    G0 X35.000 Y6.000 Z0.300 F30000 E0\n    G1 F1500.000 E0.800\n    M106 S0 ; turn off fan\n    G0 X185.000 E9.35441 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G0 X187 Z0\n    G1 F1500.000 E-0.800\n    G0 Z1\n    G0 X180 Z0.3 F18000\n\n    M900 L1000.0 M1.0\n    M900 K0.040\n    G0 X45.000 F30000\n    G0 Y8.000 F30000\n    G1 F1500.000 E0.800\n    G1 X65.000 E1.24726 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X70.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X75.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X80.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X85.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X90.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X95.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X100.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X105.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X110.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X115.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X120.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X125.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X130.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X135.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X140.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X145.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X150.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X155.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X160.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X165.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X170.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X175.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X180.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 F1500.000 E-0.800\n    G1 X183 Z0.15 F30000\n    G1 X185\n    G1 Z1.0\n    G0 Y6.000 F30000 ; move y to clear pos\n    G1 Z0.3\n    M400\n\n    G0 X45.000 F30000\n    M900 K0.020\n    G0 X45.000 F30000\n    G0 Y10.000 F30000\n    G1 F1500.000 E0.800\n    G1 X65.000 E1.24726 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X70.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X75.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X80.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X85.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X90.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X95.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X100.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X105.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X110.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X115.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X120.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X125.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X130.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X135.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X140.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X145.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X150.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X155.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X160.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X165.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X170.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X175.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X180.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 F1500.000 E-0.800\n    G1 X183 Z0.15 F30000\n    G1 X185\n    G1 Z1.0\n    G0 Y6.000 F30000 ; move y to clear pos\n    G1 Z0.3\n    M400\n\n    G0 X45.000 F30000\n    M900 K0.000\n    G0 X45.000 F30000\n    G0 Y12.000 F30000\n    G1 F1500.000 E0.800\n    G1 X65.000 E1.24726 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X70.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X75.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X80.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X85.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X90.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X95.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X100.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X105.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X110.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X115.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X120.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X125.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X130.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X135.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X140.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X145.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X150.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X155.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X160.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X165.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X170.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X175.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X180.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 F1500.000 E-0.800\n    G1 X183 Z0.15 F30000\n    G1 X185\n    G1 Z1.0\n    G0 Y6.000 F30000 ; move y to clear pos\n    G1 Z0.3\n\n    G0 X45.000 F30000 ; move to start point\n\nM623 ; end of "draw extrinsic para cali paint"\n\n\nM1002 judge_flag extrude_cali_flag\nM622 J0\n    G0 X231 Y1.5 F30000\n    G0 X18 E14.3 F{outer_wall_volumetric_speed/(0.3*0.5)     * 60}\nM623\n\nM104 S140\n\n\n;=========== laser and rgb calibration ===========\nM400\nM18 E\nM500 R\n\nM973 S3 P14\n\nG1 X120 Y1.0 Z0.3 F18000.0;Move to first extrude line pos\nT1100\nG1 X235.0 Y1.0 Z0.3 F18000.0;Move to first extrude line pos\nM400 P100\nM960 S1 P1\nM400 P100\nM973 S6 P0; use auto exposure for horizontal laser by xcam\nM960 S0 P0\n\nG1 X240.0 Y6.0 Z0.3 F18000.0;Move to vertical extrude line pos\nM960 S2 P1\nM400 P100\nM973 S6 P1; use auto exposure for vertical laser by xcam\nM960 S0 P0\n\n;=========== handeye calibration ======================\nM1002 judge_flag extrude_cali_flag\nM622 J1\n\n    M973 S3 P1 ; camera start stream\n    M400 P500\n    M973 S1\n    G0 F6000 X228.500 Y4.500 Z0.000\n    M960 S0 P1\n    M973 S1\n    M400 P800\n    M971 S6 P0\n    M973 S2 P0\n    M400 P500\n    G0 Z0.000 F12000\n    M960 S0 P0\n    M960 S1 P1\n    G0 X221.00 Y4.50\n    M400 P200\n    M971 S5 P1\n    M973 S2 P1\n    M400 P500\n    M960 S0 P0\n    M960 S2 P1\n    G0 X228.5 Y11.0\n    M400 P200\n    M971 S5 P3\n    G0 Z0.500 F12000\n    M960 S0 P0\n    M960 S2 P1\n    G0 X228.5 Y11.0\n    M400 P200\n    M971 S5 P4\n    M973 S2 P0\n    M400 P500\n    M960 S0 P0\n    M960 S1 P1\n    G0 X221.00 Y4.50\n    M400 P500\n    M971 S5 P2\n    M963 S1\n    M400 P1500\n    M964\n    T1100\n    G0 F6000 X228.500 Y4.500 Z0.000\n    M960 S0 P1\n    M973 S1\n    M400 P800\n    M971 S6 P0\n    M973 S2 P0\n    M400 P500\n    G0 Z0.000 F12000\n    M960 S0 P0\n    M960 S1 P1\n    G0 X221.00 Y4.50\n    M400 P200\n    M971 S5 P1\n    M973 S2 P1\n    M400 P500\n    M960 S0 P0\n    M960 S2 P1\n    G0 X228.5 Y11.0\n    M400 P200\n    M971 S5 P3\n    G0 Z0.500 F12000\n    M960 S0 P0\n    M960 S2 P1\n    G0 X228.5 Y11.0\n    M400 P200\n    M971 S5 P4\n    M973 S2 P0\n    M400 P500\n    M960 S0 P0\n    M960 S1 P1\n    G0 X221.00 Y4.50\n    M400 P500\n    M971 S5 P2\n    M963 S1\n    M400 P1500\n    M964\n    T1100\n    G1 Z3 F3000\n\n    M400\n    M500 ; save cali data\n\n    M104 S{nozzle_temperature[initial_no_support_extruder]} ; rise nozzle temp now ,to reduce temp waiting time.\n\n    T1100\n    M400 P400\n    M960 S0 P0\n    G0 F30000.000 Y10.000 X65.000 Z0.000\n    M400 P400\n    M960 S1 P1\n    M400 P50\n\n    M969 S1 N3 A2000\n    G0 F360.000 X181.000 Z0.000\n    M980.3 A70.000 B{outer_wall_volumetric_speed/(1.75*1.75/4*3.14)*60/4} C5.000 D{outer_wall_volumetric_speed/(1.75*1.75/4*3.14)*60} E5.000 F175.000 H1.000 I0.000 J0.020 K0.040\n    M400 P100\n    G0 F20000\n    G0 Z1 ; rise nozzle up\n    T1000 ; change to nozzle space\n    G0 X45.000 Y4.000 F30000 ; move to test line pos\n    M969 S0 ; turn off scanning\n    M960 S0 P0\n\n\n    G1 Z2 F20000\n    T1000\n    G0 X45.000 Y4.000 F30000 E0\n    M109 S{nozzle_temperature[initial_no_support_extruder]}\n    G0 Z0.3\n    G1 F1500.000 E3.600\n    G1 X65.000 E1.24726 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X70.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X75.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X80.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X85.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X90.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X95.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X100.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X105.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X110.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X115.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X120.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X125.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X130.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X135.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n\n    ; see if extrude cali success, if not ,use default value\n    M1002 judge_last_extrude_cali_success\n    M622 J0\n        M400\n        M900 K0.02 M{outer_wall_volumetric_speed/(1.75*1.75/4*3.14)*0.02}\n    M623\n\n    G1 X140.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X145.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X150.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X155.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X160.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X165.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X170.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X175.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X180.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X185.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X190.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X195.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X200.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X205.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X210.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X215.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X220.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X225.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    M973 S4\n\nM623\n\n;========turn off light and wait extrude temperature =============\nM1002 gcode_claim_action : 0\nM973 S4 ; turn off scanner\nM400 ; wait all motion done before implement the emprical L parameters\n;M900 L500.0 ; Empirical parameters\nM109 S[nozzle_temperature_initial_layer]\nM960 S1 P0 ; turn off laser\nM960 S2 P0 ; turn off laser\nM106 S0 ; turn off fan\nM106 P2 S0 ; turn off big fan\nM106 P3 S0 ; turn off chamber fan\n\nM975 S1 ; turn on mech mode supression\nG90\nM83\nT1000\n;===== purge line to wipe the nozzle ============================\nG1 E{-retraction_length[initial_no_support_extruder]} F1800\nG1 X18.0 Y2.5 Z0.8 F18000.0;Move to start position\nG1 E{retraction_length[initial_no_support_extruder]} F1800\nM109 S{nozzle_temperature_initial_layer[initial_no_support_extruder]}\nG1 Z0.2\nG0 X239 E15 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\nG0 Y12 E0.7 F{outer_wall_volumetric_speed/(0.3*0.5)/4* 60}\n
; machine_unload_filament_time = 28
; max_bridge_length = 0
; max_layer_height = 0.28
; max_travel_detour_distance = 0
; min_bead_width = 85%
; min_feature_size = 25%
; min_layer_height = 0.08
; minimum_sparse_infill_area = 15
; mmu_segmented_region_interlocking_depth = 0
; mmu_segmented_region_max_width = 0
; nozzle_diameter = 0.4
; nozzle_height = 4.2
; nozzle_temperature = 220
; nozzle_temperature_initial_layer = 220
; nozzle_temperature_range_high = 240
; nozzle_temperature_range_low = 190
; nozzle_type = hardened_steel
; nozzle_volume = 107
; only_one_wall_first_layer = 0
; ooze_prevention = 0
; other_layers_print_sequence = 0
; other_layers_print_sequence_nums = 0
; outer_wall_acceleration = 5000
; outer_wall_jerk = 9
; outer_wall_line_width = 0.42
; outer_wall_speed = 200
; overhang_1_4_speed = 0
; overhang_2_4_speed = 50
; overhang_3_4_speed = 30
; overhang_4_4_speed = 10
; overhang_fan_speed = 100
; overhang_fan_threshold = 50%
; overhang_threshold_participating_cooling = 95%
; overhang_totally_speed = 50
; post_process = 
; precise_z_height = 0
; pressure_advance = 0.02
; prime_tower_brim_width = 3
; prime_tower_width = 35
; prime_volume = 45
; print_compatible_printers = "Bambu Lab X1 Carbon 0.4 nozzle";"Bambu Lab X1 0.4 nozzle";"Bambu Lab P1S 0.4 nozzle";"Bambu Lab X1E 0.4 nozzle"
; print_flow_ratio = 1
; print_sequence = by layer
; print_settings_id = 0.20mm Standard @BBL X1C
; printable_area = 0x0,256x0,256x256,0x256
; printable_height = 250
; printer_model = Bambu Lab X1 Carbon
; printer_notes = 
; printer_settings_id = Bambu Lab X1 Carbon 0.4 nozzle
; printer_structure = corexy
; printer_technology = FFF
; printer_variant = 0.4
; printhost_authorization_type = key
; printhost_ssl_ignore_revoke = 0
; printing_by_object_gcode = 
; process_notes = 
; raft_contact_distance = 0.1
; raft_expansion = 1.5
; raft_first_layer_density = 90%
; raft_first_layer_expansion = 2
; raft_layers = 0
; reduce_crossing_wall = 0
; reduce_fan_stop_start_freq = 1
; reduce_infill_retraction = 1
; required_nozzle_HRC = 3
; resolution = 0.012
; retract_before_wipe = 0%
; retract_length_toolchange = 2
; retract_lift_above = 0
; retract_lift_below = 249
; retract_restart_extra = 0
; retract_restart_extra_toolchange = 0
; retract_when_changing_layer = 1
; retraction_distances_when_cut = 18
; retraction_length = 0.8
; retraction_minimum_travel = 1
; retraction_speed = 30
; role_base_wipe_speed = 1
; scan_first_layer = 1
; scarf_angle_threshold = 155
; seam_gap = 15%
; seam_position = aligned
; seam_slope_conditional = 1
; seam_slope_entire_loop = 0
; seam_slope_inner_walls = 1
; seam_slope_steps = 10
; silent_mode = 0
; single_extruder_multi_material = 1
; skirt_distance = 2
; skirt_height = 1
; skirt_loops = 0
; slice_closing_radius = 0.049
; slicing_mode = regular
; slow_down_for_layer_cooling = 1
; slow_down_layer_time = 4
; slow_down_min_speed = 20
; small_perimeter_speed = 50%
; small_perimeter_threshold = 0
; smooth_coefficient = 150
; smooth_speed_discontinuity_area = 1
; solid_infill_filament = 1
; sparse_infill_acceleration = 100%
; sparse_infill_anchor = 400%
; sparse_infill_anchor_max = 20
; sparse_infill_density = 15%
; sparse_infill_filament = 1
; sparse_infill_line_width = 0.45
; sparse_infill_pattern = grid
; sparse_infill_speed = 270
; spiral_mode = 0
; spiral_mode_max_xy_smoothing = 200%
; spiral_mode_smooth = 0
; standby_temperature_delta = -5
; start_end_points = 30x-3,54x245
; supertack_plate_temp = 45
; supertack_plate_temp_initial_layer = 45
; support_air_filtration = 0
; support_angle = 0
; support_base_pattern = default
; support_base_pattern_spacing = 2.5
; support_bottom_interface_spacing = 0.5
; support_bottom_z_distance = 0.2
; support_chamber_temp_control = 0
; support_critical_regions_only = 0
; support_expansion = 0
; support_filament = 0
; support_interface_bottom_layers = 2
; support_interface_filament = 0
; support_interface_loop_pattern = 0
; support_interface_not_for_body = 1
; support_interface_pattern = auto
; support_interface_spacing = 0.5
; support_interface_speed = 80
; support_interface_top_layers = 2
; support_line_width = 0.42
; support_object_first_layer_gap = 0.2
; support_object_xy_distance = 0.35
; support_on_build_plate_only = 0
; support_remove_small_overhang = 1
; support_speed = 150
; support_style = default
; support_threshold_angle = 30
; support_top_z_distance = 0.2
; support_type = normal(auto)
; temperature_vitrification = 45
; template_custom_gcode = 
; textured_plate_temp = 55
; textured_plate_temp_initial_layer = 55
; thick_bridges = 0
; thumbnail_size = 50x50
; time_lapse_gcode = 
; timelapse_type = 0
; top_area_threshold = 100%
; top_one_wall_type = all top
; top_shell_layers = 5
; top_shell_thickness = 1
; top_solid_infill_flow_ratio = 1
; top_surface_acceleration = 2000
; top_surface_jerk = 9
; top_surface_line_width = 0.42
; top_surface_pattern = monotonicline
; top_surface_speed = 200
; travel_jerk = 9
; travel_speed = 500
; travel_speed_z = 0
; tree_support_branch_angle = 45
; tree_support_branch_diameter = 2
; tree_support_branch_diameter_angle = 5
; tree_support_branch_distance = 5
; tree_support_wall_count = 0
; upward_compatible_machine = "Bambu Lab P1S 0.4 nozzle";"Bambu Lab P1P 0.4 nozzle";"Bambu Lab X1 0.4 nozzle";"Bambu Lab X1E 0.4 nozzle";"Bambu Lab A1 0.4 nozzle"
; use_firmware_retraction = 0
; use_relative_e_distances = 1
; wall_distribution_count = 1
; wall_filament = 1
; wall_generator = classic
; wall_loops = 2
; wall_sequence = inner wall/outer wall
; wall_transition_angle = 10
; wall_transition_filter_deviation = 25%
; wall_transition_length = 100%
; wipe = 1
; wipe_distance = 2
; wipe_speed = 80%
; wipe_tower_no_sparse_layers = 0
; wipe_tower_rotation_angle = 0
; wipe_tower_x = 165
; wipe_tower_y = 250
; xy_contour_compensation = 0
; xy_hole_compensation = 0
; z_hop = 0.4
; z_hop_types = Auto Lift
; CONFIG_BLOCK_END

; EXECUTABLE_BLOCK_START
M73 P0 R19
M201 X20000 Y20000 Z500 E5000
M203 X500 Y500 Z20 E30
M204 P20000 R5000 T20000
M205 X9.00 Y9.00 Z3.00 E2.50
M106 S0
M106 P2 S0
; FEATURE: Custom
;===== machine: X1 ====================
;===== date: 20240919 ==================
;===== start printer sound ================
M17
M400 S1
M1006 S1
M1006 A0 B10 L100 C37 D10 M60 E37 F10 N60
M1006 A0 B10 L100 C41 D10 M60 E41 F10 N60
M1006 A0 B10 L100 C44 D10 M60 E44 F10 N60
M1006 A0 B10 L100 C0 D10 M60 E0 F10 N60
M1006 A46 B10 L100 C43 D10 M70 E39 F10 N100
M1006 A0 B10 L100 C0 D10 M60 E0 F10 N100
M1006 A43 B10 L100 C0 D10 M60 E39 F10 N100
M1006 A0 B10 L100 C0 D10 M60 E0 F10 N100
M1006 A41 B10 L100 C0 D10 M100 E41 F10 N100
M1006 A44 B10 L100 C0 D10 M100 E44 F10 N100
M1006 A49 B10 L100 C0 D10 M100 E49 F10 N100
M1006 A0 B10 L100 C0 D10 M100 E0 F10 N100
M1006 A48 B10 L100 C44 D10 M60 E39 F10 N100
M1006 A0 B10 L100 C0 D10 M60 E0 F10 N100
M1006 A44 B10 L100 C0 D10 M90 E39 F10 N100
M1006 A0 B10 L100 C0 D10 M60 E0 F10 N100
M1006 A46 B10 L100 C43 D10 M60 E39 F10 N100
M1006 W
;===== turn on the HB fan =================
M104 S75 ;set extruder temp to turn on the HB fan and prevent filament oozing from nozzle
;===== reset machine status =================
M290 X40 Y40 Z2.6666666
G91
M17 Z0.4 ; lower the z-motor current
G380 S2 Z30 F300 ; G380 is same as G38; lower the hotbed , to prevent the nozzle is below the hotbed
G380 S2 Z-25 F300 ;
G1 Z5 F300;
G90
M17 X1.2 Y1.2 Z0.75 ; reset motor current to default
M960 S5 P1 ; turn on logo lamp
G90
M220 S100 ;Reset Feedrate
M221 S100 ;Reset Flowrate
M73.2   R1.0 ;Reset left time magnitude
M1002 set_gcode_claim_speed_level : 5
M221 X0 Y0 Z0 ; turn off soft endstop to prevent protential logic problem
G29.1 Z0 ; clear z-trim value first
M204 S10000 ; init ACC set to 10m/s^2

;===== heatbed preheat ====================
M1002 gcode_claim_action : 2
M140 S35 ;set bed temp
M190 S35 ;wait for bed temp


;=========register first layer scan=====
M977 S1 P60


;=============turn on fans to prevent PLA jamming=================

    ;Prevent PLA from jamming
    M142 P1 R35 S40

M106 P2 S100 ; turn on big fan ,to cool down toolhead

;===== prepare print temperature and material ==========
M104 S220 ;set extruder temp
G91
G0 Z10 F1200
G90
G28 X
M975 S1 ; turn on
M73 P22 R15
G1 X60 F12000
G1 Y245
G1 Y265 F3000
M620 M
M620 S0A   ; switch material if AMS exist
    M109 S220
    G1 X120 F12000

    G1 X20 Y50 F12000
    G1 Y-3
    T0
    G1 X54 F12000
    G1 Y265
    M400
M621 S0A
M620.1 E F523.843 T240

M412 S1 ; ===turn on filament runout detection===

M109 S250 ;set nozzle to common flush temp
M106 P1 S0
G92 E0
G1 E50 F200
M400
M104 S220
G92 E0
G1 E50 F200
M400
M106 P1 S255
G92 E0
G1 E5 F300
M109 S200 ; drop nozzle temp, make filament shink a bit
G92 E0
M73 P23 R14
G1 E-0.5 F300

M73 P25 R14
G1 X70 F9000
G1 X76 F15000
G1 X65 F15000
G1 X76 F15000
G1 X65 F15000; shake to put down garbage
G1 X80 F6000
G1 X95 F15000
G1 X80 F15000
G1 X165 F15000; wipe and shake
M400
M106 P1 S0
;===== prepare print temperature and material end =====


;===== wipe nozzle ===============================
M1002 gcode_claim_action : 14
M975 S1
M106 S255
G1 X65 Y230 F18000
G1 Y264 F6000
M109 S200
G1 X100 F18000 ; first wipe mouth

G0 X135 Y253 F20000  ; move to exposed steel surface edge
G28 Z P0 T300; home z with low precision,permit 300deg temperature
G29.2 S0 ; turn off ABL
G0 Z5 F20000

G1 X60 Y265
G92 E0
G1 E-0.5 F300 ; retrack more
G1 X100 F5000; second wipe mouth
G1 X70 F15000
G1 X100 F5000
G1 X70 F15000
G1 X100 F5000
G1 X70 F15000
G1 X100 F5000
G1 X70 F15000
G1 X90 F5000
G0 X128 Y261 Z-1.5 F20000  ; move to exposed steel surface and stop the nozzle
M104 S140 ; set temp down to heatbed acceptable
M106 S255 ; turn on fan (G28 has turn off fan)

M221 S; push soft endstop status
M221 Z0 ;turn off Z axis endstop
G0 Z0.5 F20000
G0 X125 Y259.5 Z-1.01
G0 X131 F211
G0 X124
G0 Z0.5 F20000
G0 X125 Y262.5
G0 Z-1.01
G0 X131 F211
G0 X124
G0 Z0.5 F20000
G0 X125 Y260.0
G0 Z-1.01
G0 X131 F211
G0 X124
G0 Z0.5 F20000
G0 X125 Y262.0
G0 Z-1.01
G0 X131 F211
G0 X124
G0 Z0.5 F20000
G0 X125 Y260.5
G0 Z-1.01
G0 X131 F211
G0 X124
G0 Z0.5 F20000
G0 X125 Y261.5
G0 Z-1.01
G0 X131 F211
G0 X124
G0 Z0.5 F20000
G0 X125 Y261.0
G0 Z-1.01
G0 X131 F211
G0 X124
G0 X128
G2 I0.5 J0 F300
G2 I0.5 J0 F300
G2 I0.5 J0 F300
G2 I0.5 J0 F300

M109 S140 ; wait nozzle temp down to heatbed acceptable
G2 I0.5 J0 F3000
G2 I0.5 J0 F3000
G2 I0.5 J0 F3000
G2 I0.5 J0 F3000

M221 R; pop softend status
G1 Z10 F1200
M400
G1 Z10
M73 P26 R14
G1 F30000
G1 X128 Y128
G29.2 S1 ; turn on ABL
;G28 ; home again after hard wipe mouth
M106 S0 ; turn off fan , too noisy
;===== wipe nozzle end ================================

;===== check scanner clarity ===========================
G1 X128 Y128 F24000
G28 Z P0
M972 S5 P0
G1 X230 Y15 F24000
;===== check scanner clarity end =======================

;===== bed leveling ==================================
M1002 judge_flag g29_before_print_flag
M622 J1

    M1002 gcode_claim_action : 1
    G29 A X103.444 Y117.884 I50 J20.2318
    M400
    M500 ; save cali data

M623
;===== bed leveling end ================================

;===== home after wipe mouth============================
M1002 judge_flag g29_before_print_flag
M622 J0

    M1002 gcode_claim_action : 13
    G28

M623
;===== home after wipe mouth end =======================

M975 S1 ; turn on vibration supression

;=============turn on fans to prevent PLA jamming=================

    ;Prevent PLA from jamming
    M142 P1 R35 S40

M106 P2 S100 ; turn on big fan ,to cool down toolhead

M104 S220 ; set extrude temp earlier, to reduce wait time

;===== mech mode fast check============================
G1 X128 Y128 Z10 F20000
M400 P200
M970.3 Q1 A7 B30 C80  H15 K0
M974 Q1 S2 P0

G1 X128 Y128 Z10 F20000
M400 P200
M970.3 Q0 A7 B30 C90 Q0 H15 K0
M974 Q0 S2 P0

M975 S1
G1 F30000
G1 X230 Y15
G28 X ; re-home XY
;===== mech mode fast check============================


;start heatbed  scan====================================
M976 S2 P1
G90
G1 X128 Y128 F20000
M976 S3 P2  ;register void printing detection


;===== nozzle load line ===============================
M975 S1
G90
M83
T1000
G1 X18.0 Y1.0 Z0.8 F18000;Move to start position
M109 S220
G1 Z0.2
G0 E2 F300
G0 X240 E15 F6033.27
G0 Y11 E0.700 F1508.32
G0 X239.5
G0 E0.2
G0 Y1.5 E0.700
G0 X231 E0.700 F6033.27
M400

;===== for Textured PEI Plate , lower the nozzle as the nozzle was touching topmost of the texture when homing ==
;curr_bed_type=Cool Plate


;===== draw extrinsic para cali paint =================
M1002 judge_flag extrude_cali_flag
M622 J1

    M1002 gcode_claim_action : 8

    T1000

    G0 F1200.0 X231 Y15   Z0.2 E0.741
    G0 F1200.0 X226 Y15   Z0.2 E0.275
    G0 F1200.0 X226 Y8    Z0.2 E0.384
    G0 F1200.0 X216 Y8    Z0.2 E0.549
    G0 F1200.0 X216 Y1.5  Z0.2 E0.357

    G0 X48.0 E12.0 F6033.27
    G0 X48.0 Y14 E0.92 F1200.0
    G0 X35.0 Y6.0 E1.03 F1200.0

    ;=========== extruder cali extrusion ==================
    T1000
    M83
    
        
            M204 S5000
        
    
    G0 X35.000 Y6.000 Z0.300 F30000 E0
    G1 F1500.000 E0.800
    M106 S0 ; turn off fan
    G0 X185.000 E9.35441 F6033.27
    G0 X187 Z0
    G1 F1500.000 E-0.800
    G0 Z1
    G0 X180 Z0.3 F18000

    M900 L1000.0 M1.0
    M900 K0.040
    G0 X45.000 F30000
    G0 Y8.000 F30000
    G1 F1500.000 E0.800
    G1 X65.000 E1.24726 F1508.32
M73 P27 R14
    G1 X70.000 E0.31181 F1508.32
    G1 X75.000 E0.31181 F6033.27
    G1 X80.000 E0.31181 F1508.32
    G1 X85.000 E0.31181 F6033.27
    G1 X90.000 E0.31181 F1508.32
    G1 X95.000 E0.31181 F6033.27
    G1 X100.000 E0.31181 F1508.32
    G1 X105.000 E0.31181 F6033.27
    G1 X110.000 E0.31181 F1508.32
    G1 X115.000 E0.31181 F6033.27
    G1 X120.000 E0.31181 F1508.32
    G1 X125.000 E0.31181 F6033.27
    G1 X130.000 E0.31181 F1508.32
    G1 X135.000 E0.31181 F6033.27
    G1 X140.000 E0.31181 F1508.32
M73 P28 R14
    G1 X145.000 E0.31181 F6033.27
    G1 X150.000 E0.31181 F1508.32
    G1 X155.000 E0.31181 F6033.27
    G1 X160.000 E0.31181 F1508.32
    G1 X165.000 E0.31181 F6033.27
    G1 X170.000 E0.31181 F1508.32
    G1 X175.000 E0.31181 F6033.27
    G1 X180.000 E0.31181 F6033.27
    G1 F1500.000 E-0.800
    G1 X183 Z0.15 F30000
    G1 X185
    G1 Z1.0
    G0 Y6.000 F30000 ; move y to clear pos
    G1 Z0.3
    M400

    G0 X45.000 F30000
    M900 K0.020
    G0 X45.000 F30000
    G0 Y10.000 F30000
    G1 F1500.000 E0.800
    G1 X65.000 E1.24726 F1508.32
    G1 X70.000 E0.31181 F1508.32
    G1 X75.000 E0.31181 F6033.27
    G1 X80.000 E0.31181 F1508.32
    G1 X85.000 E0.31181 F6033.27
    G1 X90.000 E0.31181 F1508.32
    G1 X95.000 E0.31181 F6033.27
    G1 X100.000 E0.31181 F1508.32
    G1 X105.000 E0.31181 F6033.27
    G1 X110.000 E0.31181 F1508.32
    G1 X115.000 E0.31181 F6033.27
    G1 X120.000 E0.31181 F1508.32
M73 P28 R13
    G1 X125.000 E0.31181 F6033.27
M73 P29 R13
    G1 X130.000 E0.31181 F1508.32
    G1 X135.000 E0.31181 F6033.27
    G1 X140.000 E0.31181 F1508.32
    G1 X145.000 E0.31181 F6033.27
    G1 X150.000 E0.31181 F1508.32
    G1 X155.000 E0.31181 F6033.27
    G1 X160.000 E0.31181 F1508.32
    G1 X165.000 E0.31181 F6033.27
    G1 X170.000 E0.31181 F1508.32
    G1 X175.000 E0.31181 F6033.27
    G1 X180.000 E0.31181 F6033.27
    G1 F1500.000 E-0.800
    G1 X183 Z0.15 F30000
    G1 X185
    G1 Z1.0
    G0 Y6.000 F30000 ; move y to clear pos
    G1 Z0.3
    M400

    G0 X45.000 F30000
    M900 K0.000
    G0 X45.000 F30000
    G0 Y12.000 F30000
    G1 F1500.000 E0.800
    G1 X65.000 E1.24726 F1508.32
    G1 X70.000 E0.31181 F1508.32
    G1 X75.000 E0.31181 F6033.27
    G1 X80.000 E0.31181 F1508.32
    G1 X85.000 E0.31181 F6033.27
    G1 X90.000 E0.31181 F1508.32
    G1 X95.000 E0.31181 F6033.27
    G1 X100.000 E0.31181 F1508.32
    G1 X105.000 E0.31181 F6033.27
    G1 X110.000 E0.31181 F1508.32
    G1 X115.000 E0.31181 F6033.27
    G1 X120.000 E0.31181 F1508.32
    G1 X125.000 E0.31181 F6033.27
    G1 X130.000 E0.31181 F1508.32
    G1 X135.000 E0.31181 F6033.27
    G1 X140.000 E0.31181 F1508.32
    G1 X145.000 E0.31181 F6033.27
    G1 X150.000 E0.31181 F1508.32
    G1 X155.000 E0.31181 F6033.27
M73 P30 R13
    G1 X160.000 E0.31181 F1508.32
    G1 X165.000 E0.31181 F6033.27
    G1 X170.000 E0.31181 F1508.32
    G1 X175.000 E0.31181 F6033.27
    G1 X180.000 E0.31181 F6033.27
    G1 F1500.000 E-0.800
    G1 X183 Z0.15 F30000
    G1 X185
    G1 Z1.0
    G0 Y6.000 F30000 ; move y to clear pos
    G1 Z0.3

    G0 X45.000 F30000 ; move to start point

M623 ; end of "draw extrinsic para cali paint"


M1002 judge_flag extrude_cali_flag
M622 J0
    G0 X231 Y1.5 F30000
    G0 X18 E14.3 F6033.27
M623

M104 S140


;=========== laser and rgb calibration ===========
M400
M18 E
M500 R

M973 S3 P14

G1 X120 Y1.0 Z0.3 F18000.0;Move to first extrude line pos
T1100
G1 X235.0 Y1.0 Z0.3 F18000.0;Move to first extrude line pos
M400 P100
M960 S1 P1
M400 P100
M973 S6 P0; use auto exposure for horizontal laser by xcam
M960 S0 P0

G1 X240.0 Y6.0 Z0.3 F18000.0;Move to vertical extrude line pos
M960 S2 P1
M400 P100
M973 S6 P1; use auto exposure for vertical laser by xcam
M960 S0 P0

;=========== handeye calibration ======================
M1002 judge_flag extrude_cali_flag
M622 J1

    M973 S3 P1 ; camera start stream
    M400 P500
    M973 S1
    G0 F6000 X228.500 Y4.500 Z0.000
    M960 S0 P1
    M973 S1
    M400 P800
    M971 S6 P0
    M973 S2 P0
    M400 P500
    G0 Z0.000 F12000
    M960 S0 P0
    M960 S1 P1
    G0 X221.00 Y4.50
    M400 P200
    M971 S5 P1
    M973 S2 P1
    M400 P500
    M960 S0 P0
    M960 S2 P1
    G0 X228.5 Y11.0
    M400 P200
    M971 S5 P3
    G0 Z0.500 F12000
    M960 S0 P0
    M960 S2 P1
    G0 X228.5 Y11.0
    M400 P200
    M971 S5 P4
    M973 S2 P0
    M400 P500
    M960 S0 P0
    M960 S1 P1
    G0 X221.00 Y4.50
    M400 P500
    M971 S5 P2
    M963 S1
    M400 P1500
    M964
    T1100
    G0 F6000 X228.500 Y4.500 Z0.000
    M960 S0 P1
    M973 S1
    M400 P800
    M971 S6 P0
    M973 S2 P0
    M400 P500
    G0 Z0.000 F12000
    M960 S0 P0
    M960 S1 P1
    G0 X221.00 Y4.50
    M400 P200
    M971 S5 P1
    M973 S2 P1
    M400 P500
    M960 S0 P0
    M960 S2 P1
    G0 X228.5 Y11.0
    M400 P200
    M971 S5 P3
    G0 Z0.500 F12000
    M960 S0 P0
    M960 S2 P1
    G0 X228.5 Y11.0
    M400 P200
    M971 S5 P4
    M973 S2 P0
    M400 P500
    M960 S0 P0
    M960 S1 P1
    G0 X221.00 Y4.50
    M400 P500
    M971 S5 P2
    M963 S1
    M400 P1500
    M964
    T1100
    G1 Z3 F3000

    M400
    M500 ; save cali data

    M104 S220 ; rise nozzle temp now ,to reduce temp waiting time.

    T1100
    M400 P400
    M960 S0 P0
    G0 F30000.000 Y10.000 X65.000 Z0.000
    M400 P400
    M960 S1 P1
    M400 P50

    M969 S1 N3 A2000
    G0 F360.000 X181.000 Z0.000
    M980.3 A70.000 B94.1106 C5.000 D376.442 E5.000 F175.000 H1.000 I0.000 J0.020 K0.040
    M400 P100
    G0 F20000
    G0 Z1 ; rise nozzle up
    T1000 ; change to nozzle space
    G0 X45.000 Y4.000 F30000 ; move to test line pos
    M969 S0 ; turn off scanning
    M960 S0 P0


    G1 Z2 F20000
    T1000
    G0 X45.000 Y4.000 F30000 E0
    M109 S220
    G0 Z0.3
    G1 F1500.000 E3.600
    G1 X65.000 E1.24726 F1508.32
    G1 X70.000 E0.31181 F1508.32
    G1 X75.000 E0.31181 F6033.27
    G1 X80.000 E0.31181 F1508.32
    G1 X85.000 E0.31181 F6033.27
    G1 X90.000 E0.31181 F1508.32
    G1 X95.000 E0.31181 F6033.27
    G1 X100.000 E0.31181 F1508.32
    G1 X105.000 E0.31181 F6033.27
    G1 X110.000 E0.31181 F1508.32
    G1 X115.000 E0.31181 F6033.27
    G1 X120.000 E0.31181 F1508.32
    G1 X125.000 E0.31181 F6033.27
    G1 X130.000 E0.31181 F1508.32
    G1 X135.000 E0.31181 F6033.27

    ; see if extrude cali success, if not ,use default value
    M1002 judge_last_extrude_cali_success
    M622 J0
        M400
        M900 K0.02 M0.125481
    M623

    G1 X140.000 E0.31181 F1508.32
    G1 X145.000 E0.31181 F6033.27
    G1 X150.000 E0.31181 F1508.32
    G1 X155.000 E0.31181 F6033.27
    G1 X160.000 E0.31181 F1508.32
    G1 X165.000 E0.31181 F6033.27
    G1 X170.000 E0.31181 F1508.32
    G1 X175.000 E0.31181 F6033.27
    G1 X180.000 E0.31181 F1508.32
    G1 X185.000 E0.31181 F6033.27
    G1 X190.000 E0.31181 F1508.32
    G1 X195.000 E0.31181 F6033.27
    G1 X200.000 E0.31181 F1508.32
    G1 X205.000 E0.31181 F6033.27
    G1 X210.000 E0.31181 F1508.32
    G1 X215.000 E0.31181 F6033.27
    G1 X220.000 E0.31181 F1508.32
    G1 X225.000 E0.31181 F6033.27
    M973 S4

M623

;========turn off light and wait extrude temperature =============
M1002 gcode_claim_action : 0
M973 S4 ; turn off scanner
M400 ; wait all motion done before implement the emprical L parameters
;M900 L500.0 ; Empirical parameters
M109 S220
M960 S1 P0 ; turn off laser
M960 S2 P0 ; turn off laser
M106 S0 ; turn off fan
M106 P2 S0 ; turn off big fan
M106 P3 S0 ; turn off chamber fan

M975 S1 ; turn on mech mode supression
G90
M83
T1000
;===== purge line to wipe the nozzle ============================
G1 E-0.8 F1800
G1 X18.0 Y2.5 Z0.8 F18000.0;Move to start position
G1 E0.8 F1800
M109 S220
G1 Z0.2
G0 X239 E15 F6033.27
G0 Y12 E0.7 F1508.32
G90
G21
M83 ; use relative distances for extrusion
; filament start gcode

M142 P1 R35 S40
M981 S1 P20000 ;open spaghetti detector
; CHANGE_LAYER
; Z_HEIGHT: 0.2
; LAYER_HEIGHT: 0.2
G1 E-.8 F1800
; layer num/total_layer_count: 1/101
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L1
M991 S0 P0 ;notify layer change
M106 S0
M106 P2 S0
M204 S500
G1 X104.301 Y126.498 F30000
G1 Z.4
G1 Z.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.5
G1 F2651
G1 X104.301 Y125.502 E.03707
G1 X133.447 Y125.502 E1.0856
G1 X133.605 Y125.574 E.00647
G1 X133.708 Y126 E.01631
G1 X133.605 Y126.426 E.01631
G1 X133.447 Y126.498 E.00647
G1 X104.361 Y126.498 E1.08336
G1 X103.844 Y126.955 F30000
; FEATURE: Outer wall
G1 F2651
G1 X103.844 Y125.045 E.07112
G1 X133.547 Y125.045 E1.10632
G1 X133.815 Y125.168 E.011
G3 X134.013 Y125.318 I-.033 J.25 E.00967
G1 X134.179 Y126 E.02615
G1 X134.013 Y126.682 E.02615
G1 X133.949 Y126.771 E.00408
G1 X133.547 Y126.955 E.01648
G1 X103.904 Y126.955 E1.10408
; WIPE_START
G1 F3000
G1 X103.844 Y125.045 E-.72596
G1 X103.933 Y125.045 E-.03404
; WIPE_END
G1 E-.04 F1800
G1 X104.529 Y126 Z.6 F30000
G1 Z.2
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.581156
G1 F2651
G1 X133.196 Y126 E1.25732
G1 X133.435 Y126.159 E.01257
; CHANGE_LAYER
; Z_HEIGHT: 0.4
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F3000
M73 P31 R13
G1 X133.196 Y126 E-.10888
G1 X131.483 Y126 E-.65112
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 2/101
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L2
M991 S0 P1 ;notify layer change
M106 S255
M106 P2 S178
; open powerlost recovery
M1003 S1
M976 S1 P1 ; scan model before printing 2nd layer
M400 P100
G1 E.8
M204 S10000
G1 E-.8
G1 X123.863 Y126.432 Z.6 F30000
G1 X104.046 Y127.555 Z.6
G1 Z.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X104.046 Y127.172 E.01269
G1 X104.046 Y125.628 E.05123
G1 X104.046 Y125.228 E.01327
G1 F8596.922
G1 X104.046 Y124.828 E.01327
G1 F3000
G1 X104.046 Y124.445 E.01269
M204 S5000
; FEATURE: Overhang wall

G1 X104.046 Y124.175 E.00897
G1 X133.578 Y124.182 E.97964

G1 X133.926 Y124.277 E.01197
M73 P33 R13
G1 X134.332 Y124.615 E.01752
G1 X134.456 Y124.906 E.01049
M204 S10000
; FEATURE: Inner wall
G1 X134.629 Y125.312 E.01463
M204 S5000
; FEATURE: Overhang wall

G3 X134.64 Y125.354 I-.074 J.041 E.00148
M204 S10000
; FEATURE: Inner wall
G1 F600
G1 X134.731 Y126 E.02163
G1 F3000
G1 X134.64 Y126.646 E.02163
M204 S5000
; FEATURE: Overhang wall

G3 X134.629 Y126.688 I-.084 J.002 E.00148
M204 S10000
; FEATURE: Inner wall
G1 X134.456 Y127.094 E.01463
M204 S5000
; FEATURE: Overhang wall

G1 X134.332 Y127.385 E.01049
G1 X133.926 Y127.723 E.01752
G1 X133.552 Y127.825 E.01286
G1 X104.046 Y127.825 E.97878
G1 X104.046 Y127.615 E.00698
M204 S10000
G1 X103.654 Y127.555 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
G1 X103.654 Y127.186 E.01134
G1 X103.654 Y125.614 E.04829
G1 X103.654 Y125.214 E.01229
G1 F8596.922
G1 X103.654 Y124.814 E.01229
G1 F3000
G1 X103.654 Y124.445 E.01134
; FEATURE: Overhang wall
; LINE_WIDTH: 0.45

G1 X103.654 Y123.783 E.02198
G1 X133.605 Y123.783 E.99354
G1 X133.682 Y123.804 E.00264

G1 X134.112 Y123.922 E.01478
G1 X134.626 Y124.349 E.02217
G1 X134.674 Y124.418 E.0028
G1 X135.017 Y125.221 E.02893
G1 X135.127 Y126 E.02611
G1 X135.017 Y126.779 E.02611
G1 X134.674 Y127.582 E.02893
G1 X134.626 Y127.651 E.0028
G1 X134.112 Y128.078 E.02217
G1 X133.605 Y128.217 E.01743
G1 X103.654 Y128.217 E.99354
G1 X103.654 Y127.615 E.01999
M204 S10000
G1 X104.209 Y127.47 F30000
; FEATURE: Bridge
; LINE_WIDTH: 0.463057
G1 F3000
G1 X133.586 Y127.47 E1.00573
G1 X133.768 Y127.42 E.00648
G1 X134.057 Y127.18 E.01287
G1 X134.113 Y127.05 E.00482
G1 X104.379 Y127.05 E1.01795
M73 P33 R12
G1 X104.379 Y126.63 E.01438
G1 X134.292 Y126.63 E1.02409
M73 P34 R12
G1 X134.365 Y126.21 E.0146
G1 X104.379 Y126.21 E1.02658
G1 X104.379 Y125.79 E.01438
G1 X134.365 Y125.79 E1.02658
G1 X134.292 Y125.37 E.0146
G1 X104.379 Y125.37 E1.02409
G1 X104.379 Y124.95 E.01438
G1 X134.113 Y124.95 E1.01795
G1 X134.057 Y124.82 E.00482
G1 X133.768 Y124.58 E.01287
G1 X133.586 Y124.529 E.00649
G1 X104.209 Y124.529 E1.00572
; CHANGE_LAYER
; Z_HEIGHT: 0.6
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F3000
G1 X106.209 Y124.529 E-.76
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 3/101
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L3
M991 S0 P2 ;notify layer change
G17
G3 Z.8 I-1.068 J-.584 P1  F30000
G1 X104.046 Y128.482 Z.8
G1 Z.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X104.046 Y128.245 E.00787
G1 X104.046 Y124.955 E.10913
G1 X104.046 Y124.555 E.01327
G1 F10552.935
G1 X104.046 Y124.155 E.01327
G1 F4196.468
G1 X104.046 Y123.755 E.01327
G1 F720
G1 X104.046 Y123.485 E.00896
G1 X133.575 Y123.485 E.97952
G1 F840
G1 X133.723 Y123.514 E.00503
G1 F600
G1 X133.992 Y123.567 E.00908
G1 F1080
G1 X134.406 Y123.815 E.01601
G1 F1200
G1 X134.471 Y123.881 E.00308
G1 F2640
G1 X134.816 Y124.37 E.01984
G1 F2400
G1 X134.915 Y124.57 E.00739
G1 F7500
G1 X135.13 Y125.297 E.02517
G1 F14426.543
G1 X135.2 Y126 E.02343
G1 F7500
G1 X135.13 Y126.703 E.02343
G1 F2400
G1 X134.915 Y127.43 E.02517
G1 F2640
G1 X134.816 Y127.63 E.00739
G1 F1200
G1 X134.471 Y128.119 E.01984
G1 F1080
G1 X134.406 Y128.185 E.00308
G1 F600
G1 X133.992 Y128.433 E.01601
G1 F720
G1 X133.575 Y128.515 E.01411
G1 X104.073 Y128.515 E.97863
G1 X103.654 Y128.482 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
G1 X103.654 Y128.258 E.00687
G1 X103.654 Y124.542 E.11421
G1 X103.654 Y124.142 E.01229
G1 F8596.922
G1 X103.654 Y123.742 E.01229
G1 F3000
G1 X103.654 Y123.373 E.01134
; FEATURE: Overhang wall
; LINE_WIDTH: 0.45

G1 X103.654 Y123.093 E.00928
G1 X133.613 Y123.093 E.9938
G1 X133.799 Y123.13 E.0063

G1 X134.135 Y123.196 E.01134
G1 X134.65 Y123.505 E.01993
G1 X134.773 Y123.629 E.00579
G1 X135.155 Y124.169 E.02193
G1 X135.281 Y124.426 E.00953
G1 X135.517 Y125.221 E.02751
G1 X135.594 Y126 E.02596
G1 X135.517 Y126.779 E.02596
G1 X135.281 Y127.574 E.02751
G1 X135.155 Y127.831 E.00953
G1 X134.773 Y128.371 E.02193
G1 X134.65 Y128.495 E.00579
G1 X134.135 Y128.804 E.01993
G1 X133.613 Y128.907 E.01764
G1 X103.654 Y128.907 E.9938
G1 X103.654 Y128.627 E.00928
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3952.02
G1 X103.654 Y128.542 E.00262
M204 S10000
; WIPE_START
G1 X103.654 Y128.258 E-.1078
G1 X103.654 Y126.542 E-.6522
; WIPE_END
G1 E-.04 F1800
G17
G3 Z1 I-.018 J1.217 P1  F30000
G1 X133.387 Y126.992 Z1
G1 Z.6
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.419999
G1 F15000
G1 X133.527 Y126.751 E.00856
G2 X133.66 Y126.098 I-1.971 J-.739 E.02056
G1 X133.629 Y125.591 E.0156
G1 X133.472 Y125.107 E.01563
G1 X133.402 Y125.008 E.00373
G1 X105.569 Y125.008 E.85523
G1 X105.569 Y126.992 E.06095
G1 X133.327 Y126.992 E.85293
M73 P35 R12
G1 X133.174 Y126.615 F30000
G1 F15000
G2 X133.248 Y125.632 I-1.759 J-.625 E.03063
G1 X133.174 Y125.385 E.00792
G1 X105.946 Y125.385 E.83665
G1 X105.946 Y126.615 E.03777
G1 X133.114 Y126.615 E.8348
G1 X132.866 Y126.213 F30000
; LINE_WIDTH: 0.469057
G1 F14783.996
G2 X132.866 Y125.787 I-1.172 J-.213 E.01488
G1 X106.348 Y125.787 E.92082
G1 X106.348 Y126.213 E.0148
G1 X132.806 Y126.213 E.91874
G1 X133.462 Y124.631 F30000
; LINE_WIDTH: 0.419999
G1 F15000
G1 X105.192 Y124.631 E.86866
G1 X105.192 Y127.369 E.08412
G1 X133.462 Y127.369 E.86866
G1 X133.635 Y127.302 E.00571
G1 X133.889 Y126.858 E.01571
G1 X134.011 Y126.378 E.01522
G1 X134.035 Y126.135 E.0075
G1 X134.011 Y125.622 E.01577
G1 X133.867 Y125.069 E.01756
G1 X133.652 Y124.709 E.0129
G1 X133.518 Y124.654 E.00445
G1 X133.281 Y124.254 F30000
G1 F15000
G1 X104.815 Y124.254 E.87468
G1 X104.815 Y127.746 E.10729
G1 X133.499 Y127.746 E.88138
G1 X133.704 Y127.705 E.0064
G1 X133.907 Y127.576 E.00741
G1 X134.205 Y127.117 E.01683
G1 X134.372 Y126.554 E.01802
G1 X134.41 Y126.172 E.01181
G1 X134.386 Y125.585 E.01805
G1 X134.229 Y124.962 E.01975
G2 X133.917 Y124.43 I-1.762 J.676 E.01902
G1 X133.704 Y124.295 E.00777
G1 X133.341 Y124.26 E.0112
G1 X133.431 Y123.877 F30000
G1 F15000
G1 X104.438 Y123.877 E.89087
G1 X104.438 Y128.123 E.13047
G1 X133.536 Y128.123 E.89411
G1 X133.846 Y128.062 E.00971
G1 X134.179 Y127.85 E.0121
G1 X134.551 Y127.276 E.02103
G1 X134.744 Y126.627 E.0208
G2 X134.548 Y124.713 I-3.801 J-.579 E.05977
G1 X134.182 Y124.152 E.02059
G1 X133.846 Y123.938 E.01222
G1 X133.49 Y123.886 E.01106
; CHANGE_LAYER
; Z_HEIGHT: 0.8
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F15000
G1 X133.846 Y123.938 E-.13679
G1 X134.182 Y124.152 E-.15113
G1 X134.548 Y124.713 E-.25462
G1 X134.694 Y125.204 E-.19469
G1 X134.703 Y125.263 E-.02277
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 4/101
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L4
M991 S0 P3 ;notify layer change
G17
G3 Z1 I-.14 J-1.209 P1  F30000
G1 X104.046 Y128.817 Z1
G1 Z.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X104.046 Y123.865 E.16425
G1 X104.046 Y123.465 E.01327
G1 F7558.064
G1 X104.046 Y123.065 E.01327
G1 F2400
G1 X104.046 Y122.926 E.00461
G1 X133.587 Y122.926 E.97994
G1 F2280
G1 X133.939 Y122.981 E.0118
G1 X134.033 Y122.996 E.00318
G1 F2400
G1 X134.421 Y123.178 E.01423
G1 F11988.756
G1 X134.869 Y123.633 E.02116
G1 F15000
G1 X135.017 Y123.85 E.00873
G1 F15476.087
G1 X135.141 Y124.102 E.00931
G3 X135.336 Y124.514 I-1.863 J1.133 E.01516
G3 X135.359 Y124.591 I-.274 J.123 E.00267
G1 X135.513 Y125.286 E.0236
G1 X135.565 Y126 E.02376
G1 X135.513 Y126.714 E.02376
G1 X135.359 Y127.409 E.0236
G3 X135.336 Y127.486 I-.296 J-.046 E.00267
G3 X135.141 Y127.898 I-2.058 J-.721 E.01516
G1 F10115.061
G1 X135.017 Y128.15 E.00931
G1 F5470.078
G1 X134.869 Y128.367 E.00873
G1 F2400
G1 X134.421 Y128.822 E.02116
G1 F2280
G1 X134.033 Y129.004 E.01423
G1 F2400
G1 X133.587 Y129.074 E.01498
G1 X104.046 Y129.074 E.97994
G1 F3866.07
G1 X104.046 Y128.935 E.00461
G1 F4579.169
G1 X104.046 Y128.877 E.00192
G1 X103.654 Y128.817 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
G1 X103.654 Y123.852 E.15256
G1 X103.654 Y123.452 E.01229
G1 F8596.922
G1 X103.654 Y123.052 E.01229
G1 F3000
G1 X103.654 Y122.683 E.01134
; FEATURE: Overhang wall
; LINE_WIDTH: 0.45

G1 X103.654 Y122.534 E.00493
G1 X133.617 Y122.534 E.99395
G1 X133.999 Y122.594 E.01281

G1 X134.149 Y122.617 E.00505
G1 X134.652 Y122.853 E.01842
G1 X135.173 Y123.383 E.02464
G3 X135.506 Y123.955 I-1.828 J1.447 E.02204
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 X135.666 Y124.28 E.01113
; FEATURE: Overhang wall
; LINE_WIDTH: 0.45

G3 X135.768 Y124.626 I-1.438 J.614 E.012
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F600
G1 X135.902 Y125.228 E.01895
G1 X135.959 Y126 E.02377
G1 X135.902 Y126.772 E.02377
G1 F3000
G1 X135.768 Y127.374 E.01895
; FEATURE: Overhang wall
; LINE_WIDTH: 0.45

G3 X135.666 Y127.72 I-1.54 J-.268 E.012
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 X135.506 Y128.045 E.01113
; FEATURE: Overhang wall
; LINE_WIDTH: 0.45

G3 X135.173 Y128.617 I-2.161 J-.874 E.02204
G1 X134.652 Y129.147 E.02464
G1 X134.149 Y129.383 E.01842
G1 X133.617 Y129.466 E.01785
G1 X103.654 Y129.466 E.99395
G1 X103.654 Y129.317 E.00493
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F8060.209
G1 X103.654 Y128.948 E.01134
G1 F9322.139
G1 X103.654 Y128.877 E.00219
M204 S10000
; WIPE_START
G1 X103.654 Y126.877 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z1.2 I.485 J1.116 P1  F30000
G1 X108.097 Y124.947 Z1.2
G1 Z.8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X106.469 Y124.947 E.05401
G1 X104.394 Y127.022 E.09734
G1 X104.394 Y124.978 E.06779
G1 X106.469 Y127.053 E.09734
G1 X112.039 Y127.053 E.18476
G1 X114.145 Y124.947 E.09881
G1 X112.039 Y124.947 E.06987
G1 X114.145 Y127.053 E.09881
G1 X119.715 Y127.053 E.18476
G1 X121.821 Y124.947 E.09881
G1 X119.715 Y124.947 E.06987
G1 X121.821 Y127.053 E.09881
G1 X127.391 Y127.053 E.18476
G1 X129.497 Y124.947 E.09881
G1 X127.391 Y124.947 E.06987
G1 X129.497 Y127.053 E.09881
G1 X131.125 Y127.053 E.05401
G1 X133.509 Y124.151 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.472187
G1 F14676.195
G1 X133.871 Y124.217 E.01288
G1 X134.371 Y124.445 E.01921
G1 X134.458 Y124.515 E.00393
G1 X134.249 Y124.129 E.01539
G1 X133.881 Y123.797 E.01731
G1 X133.509 Y123.722 E.01329
M73 P36 R12
G1 X104.841 Y123.722 E1.00279
G1 X104.841 Y124.151 E.01503
G1 X133.449 Y124.151 E1.00069
G1 X133.509 Y127.445 F30000
; LINE_WIDTH: 0.419999
G1 F15000
G1 X104.438 Y127.445 E.89327
G1 X104.438 Y128.682 E.03799
G1 X133.557 Y128.682 E.89474
G1 X133.996 Y128.588 E.01381
G1 X134.191 Y128.497 E.00661
G1 X134.565 Y128.117 E.01637
G1 X134.89 Y127.503 E.02134
; LINE_WIDTH: 0.438777
G1 X134.932 Y127.331 E.00571
; LINE_WIDTH: 0.476333
G1 F14535.815
G1 X134.974 Y127.16 E.00625
; LINE_WIDTH: 0.50299
G1 F13693.584
G2 X135.141 Y126.016 I-9.486 J-1.967 E.04334
G1 X135.073 Y125.368 E.02444
; LINE_WIDTH: 0.511316
G1 F13450.164
G1 X135.029 Y125.103 E.01025
; LINE_WIDTH: 0.484798
G1 F14257.353
G1 X134.985 Y124.838 E.00967
; LINE_WIDTH: 0.458654
G1 F15000
G1 X134.938 Y124.667 E.006
; LINE_WIDTH: 0.420036
G1 X134.89 Y124.497 E.00545
G1 X134.654 Y124.014 E.0165
G1 X134.266 Y123.579 E.01792
G1 X134.02 Y123.423 E.00896
G1 X133.557 Y123.318 E.01459
G1 X104.438 Y123.318 E.89483
G1 X104.438 Y124.555 E.03799
G1 X133.595 Y124.555 E.896
G1 X134.206 Y124.807 E.02031
; LINE_WIDTH: 0.43765
G1 X134.315 Y124.921 E.00507
; LINE_WIDTH: 0.472952
G1 F14650.072
G1 X134.423 Y125.035 E.00553
; LINE_WIDTH: 0.50825
G1 F13538.781
G1 X134.532 Y125.15 E.00598
G1 X134.699 Y125.969 E.03173
G3 X134.522 Y126.889 I-6.536 J-.787 E.03554
; LINE_WIDTH: 0.511295
G1 F13450.766
G1 X134.416 Y126.991 E.00561
; LINE_WIDTH: 0.474777
G1 F14588.179
G1 X134.31 Y127.092 E.00517
; LINE_WIDTH: 0.423224
G1 F15000
G1 X134.204 Y127.194 E.00455
G1 X133.671 Y127.429 E.01805
G1 X133.569 Y127.439 E.00318
G1 X133.509 Y127.849 F30000
; LINE_WIDTH: 0.471879
G1 F14686.72
G1 X104.841 Y127.849 E1.00207
G1 X104.841 Y128.278 E.01502
G1 X133.509 Y128.278 E1.00207
G1 X133.889 Y128.203 E.01355
G1 X134.26 Y127.867 E.01751
G1 X134.473 Y127.465 E.0159
G3 X133.685 Y127.836 I-1.946 J-3.113 E.03054
G1 X133.569 Y127.844 E.00406
; CHANGE_LAYER
; Z_HEIGHT: 1
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F14686.72
G1 X133.685 Y127.836 E-.04416
G1 X134.108 Y127.666 E-.17324
G1 X134.473 Y127.465 E-.15857
G1 X134.26 Y127.867 E-.17287
G1 X133.889 Y128.203 E-.19034
G1 X133.836 Y128.214 E-.02082
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 5/101
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L5
M991 S0 P4 ;notify layer change
G17
G3 Z1.2 I-.039 J-1.216 P1  F30000
G1 X104.046 Y129.172 Z1.2
G1 Z1
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F13694
G1 X104.046 Y122.907 E.20783
G1 X104.046 Y122.507 E.01327
G1 F7500
G1 X104.046 Y122.429 E.00257
G1 X133.591 Y122.429 E.98006
G1 F9000
G1 X134.033 Y122.498 E.01485
G1 F13694
G1 X134.461 Y122.699 E.01567
G1 X134.565 Y122.782 E.00441
G1 X134.823 Y122.988 E.01096
G1 X134.917 Y123.063 E.004
G1 X134.957 Y123.109 E.00202
G1 X134.991 Y123.159 E.002
G1 X135.349 Y123.682 E.02101
G1 X135.429 Y123.84 E.00587
G1 X135.704 Y124.588 E.02644
G3 X135.704 Y127.412 I-5.581 J1.412 E.09465
G1 X135.429 Y128.16 E.02645
G1 X135.349 Y128.318 E.00587
G1 X134.991 Y128.841 E.02101
G1 X134.957 Y128.891 E.002
G1 X134.917 Y128.937 E.00202
G1 X134.823 Y129.012 E.004
G1 X134.565 Y129.218 E.01096
G1 F11552.653
G1 X134.461 Y129.301 E.00441
G1 F9000
G1 X134.034 Y129.502 E.01566
G1 F7500
G1 X133.587 Y129.571 E.01498
G1 X104.046 Y129.571 E.97995
G1 F8828.278
G1 X104.046 Y129.493 E.00257
G1 F13694
G1 X104.046 Y129.232 E.00866
G1 X103.654 Y129.172 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
G1 X103.654 Y123.293 E.18064
G1 X103.654 Y122.893 E.01229
G1 F8596.922
G1 X103.654 Y122.493 E.01229
G1 F3000
G1 X103.654 Y122.124 E.01134
; FEATURE: Overhang wall
; LINE_WIDTH: 0.45

G1 X103.654 Y122.037 E.00289
G1 X133.626 Y122.038 E.99425

G1 X134.149 Y122.119 E.01754
G1 X134.669 Y122.364 E.01907
G1 X134.806 Y122.472 E.00578
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 X135.023 Y122.646 E.00856
; FEATURE: Overhang wall
; LINE_WIDTH: 0.45

G3 X135.326 Y122.954 I-.552 J.846 E.01442
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F600
G1 X135.686 Y123.481 E.01964
G1 X135.789 Y123.682 E.00693
G1 X136.081 Y124.477 E.02603
G1 X136.163 Y124.848 E.01165
G1 X136.23 Y125.232 E.01199
G1 X136.274 Y126 E.02363
G1 X136.23 Y126.768 E.02363
G3 X136.081 Y127.523 I-8.115 J-1.204 E.02365
G1 X135.789 Y128.318 E.02603
G1 X135.686 Y128.519 E.00693
G1 F3000
G1 X135.326 Y129.046 E.01964
; FEATURE: Overhang wall
; LINE_WIDTH: 0.45

G3 X135.023 Y129.354 I-.854 J-.538 E.01442
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 X134.806 Y129.528 E.00856
; FEATURE: Overhang wall
; LINE_WIDTH: 0.45

G1 X134.669 Y129.636 E.00578
G1 X134.149 Y129.881 E.01907
G1 X133.617 Y129.963 E.01785
G1 X103.654 Y129.963 E.99395
G1 X103.654 Y129.876 E.00289
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F8060.209
G1 X103.654 Y129.507 E.01134
G1 F12000
G1 X103.654 Y129.232 E.00844
M204 S10000
; WIPE_START
G1 X103.654 Y127.232 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X111.235 Y126.349 Z1.4 F30000
G1 X132.16 Y123.912 Z1.4
G1 Z1
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F13694
G1 X130.531 Y123.912 E.05401
G1 X126.356 Y128.088 E.19587
G1 X122.855 Y128.088 E.11613
G1 X118.68 Y123.912 E.19587
G1 X115.179 Y123.912 E.11613
G1 X111.004 Y128.088 E.19587
G1 X107.503 Y128.088 E.11613
G1 X104.394 Y124.978 E.14587
G1 X104.394 Y127.022 E.06779
G1 X107.503 Y123.912 E.14587
G1 X111.004 Y123.912 E.11613
G1 X115.179 Y128.088 E.19587
G1 X118.68 Y128.088 E.11613
G1 X122.855 Y123.912 E.19587
G1 X126.356 Y123.912 E.11613
G1 X130.531 Y128.088 E.19587
G1 X132.16 Y128.088 E.05401
G1 X133.53 Y128.478 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.419999
G1 F13694
G1 X104.438 Y128.48 E.89393
G1 X104.438 Y129.179 E.02148
G1 X133.557 Y129.179 E.89476
; LINE_WIDTH: 0.436991
G1 X133.685 Y129.138 E.00432
; LINE_WIDTH: 0.470973
G1 X133.814 Y129.097 E.00469
; LINE_WIDTH: 0.519166
G1 F13228.471
G1 X133.942 Y129.056 E.00522
G1 X134.559 Y128.656 E.02853
; LINE_WIDTH: 0.50603
G1 F13603.685
G1 X134.8 Y128.33 E.0153
; LINE_WIDTH: 0.474916
G1 F13694
G1 X135.042 Y128.004 E.01427
; LINE_WIDTH: 0.447823
G1 X135.312 Y127.318 E.02433
; LINE_WIDTH: 0.408369
G1 X135.429 Y126.817 E.01535
G2 X135.501 Y126.01 I-12.771 J-1.545 E.02411
G1 X135.457 Y125.338 E.02006
G1 X135.325 Y124.714 E.019
; LINE_WIDTH: 0.451011
G1 X134.992 Y123.913 E.02884
; LINE_WIDTH: 0.498062
G1 X134.61 Y123.398 E.02376
; LINE_WIDTH: 0.53586
G1 F12780.472
G1 X134.191 Y123.077 E.02122
; LINE_WIDTH: 0.526069
G1 F13039.463
G1 X133.944 Y122.969 E.01062
; LINE_WIDTH: 0.479331
G1 F13694
G1 X133.697 Y122.861 E.00959
; LINE_WIDTH: 0.42005
G1 X133.534 Y122.821 E.00515
G1 X104.438 Y122.821 E.89415
G1 X104.438 Y123.52 E.02148
G1 X133.545 Y123.52 E.89449
; LINE_WIDTH: 0.443864
G1 X133.662 Y123.517 E.00383
; LINE_WIDTH: 0.491592
G1 X133.779 Y123.515 E.00428
; LINE_WIDTH: 0.542031
G1 F12622.458
G1 X133.896 Y123.512 E.00476
G1 X134.287 Y123.738 E.01836
; LINE_WIDTH: 0.509254
G1 F13509.644
G1 X134.384 Y123.826 E.00499
; LINE_WIDTH: 0.483199
G1 F13694
G1 X134.481 Y123.914 E.00471
; LINE_WIDTH: 0.446233
G1 X134.861 Y124.542 E.02411
; LINE_WIDTH: 0.412486
G1 X135.081 Y125.281 E.02323
G1 X135.149 Y125.975 E.02097
G1 X135.094 Y126.633 E.01991
G3 X134.787 Y127.623 I-7.146 J-1.671 E.03124
; LINE_WIDTH: 0.450984
G1 X134.475 Y128.091 E.01869
; LINE_WIDTH: 0.482734
G1 X134.265 Y128.256 E.00957
; LINE_WIDTH: 0.517978
G1 F13261.539
G1 X134.055 Y128.421 E.01033
; LINE_WIDTH: 0.549712
G1 F12431.136
G1 X133.9 Y128.484 E.00693
; LINE_WIDTH: 0.539854
G1 F12677.761
G1 X133.797 Y128.483 E.00418
; LINE_WIDTH: 0.491912
G1 F13694
G1 X133.694 Y128.481 E.00377
; LINE_WIDTH: 0.44397
G1 X133.59 Y128.479 E.00337
G1 X104.787 Y128.829 F30000
; LINE_WIDTH: 0.365623
G1 F13694
G1 X133.5 Y128.828 E.75504
G1 X104.787 Y123.171 F30000
; LINE_WIDTH: 0.364855
G1 F13694
G1 X133.485 Y123.171 E.75284
; CHANGE_LAYER
; Z_HEIGHT: 1.2
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F15000
G1 X131.485 Y123.171 E-.76
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 6/101
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L6
M991 S0 P5 ;notify layer change
G17
G3 Z1.4 I-.293 J-1.181 P1  F30000
G1 X104.046 Y129.967 Z1.4
G1 Z1.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X104.046 Y122.033 E.26322
G1 X133.595 Y122.033 E.9802
G1 X133.858 Y122.066 E.00879
G1 X134.061 Y122.093 E.00681
G1 X134.503 Y122.264 E.01571
G3 X134.917 Y122.566 I-1.47 J2.46 E.01702
G1 X135.389 Y123.107 E.02383
G1 X135.789 Y123.892 E.02921
G3 X135.797 Y128.088 I-6.163 J2.109 E.14173
G1 X135.389 Y128.893 E.02992
G1 X134.917 Y129.435 E.02383
G3 X133.595 Y129.967 I-1.388 J-1.536 E.04828
G1 X104.106 Y129.967 E.97821
G1 X103.654 Y130.004 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
G1 X103.654 Y123.196 E.20918
G1 X103.654 Y122.796 E.01229
G1 F10078.064
G1 X103.654 Y122.396 E.01229
G1 F3899.032
G1 X103.654 Y121.996 E.01229
G1 F600
G1 X103.654 Y121.64 E.01093
G1 X133.62 Y121.64 E.92078
G1 X133.908 Y121.677 E.00891
G1 F2354.048
G1 X134.159 Y121.71 E.00778
G1 F3000
G1 X134.643 Y121.898 E.01596
; FEATURE: Overhang wall
; LINE_WIDTH: 0.45

G3 X134.701 Y121.926 I-.034 J.149 E.00216
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F600
G3 X135.19 Y122.281 I-1.736 J2.898 E.01858
G1 X135.731 Y122.917 E.02565
G1 X136.17 Y123.79 E.03003
G1 F1080
G1 X136.363 Y124.462 E.0215
G1 F1200
G3 X136.498 Y126.775 I-7.254 J1.584 E.07148
G1 F1080
G1 X136.363 Y127.538 E.0238
G1 F600
G3 X136.149 Y128.266 I-5.166 J-1.123 E.02333
G1 X135.699 Y129.133 E.03002
G1 X135.19 Y129.719 E.02386
G1 X134.951 Y129.91 E.0094
G1 F2791.231
G1 X134.701 Y130.074 E.00918
; FEATURE: Overhang wall
; LINE_WIDTH: 0.45
G1 F3000
G3 X134.643 Y130.102 I-.093 J-.122 E.00216
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 X134.159 Y130.29 E.01596
G1 F600
G1 X133.62 Y130.36 E.01669
G1 X103.654 Y130.36 E.92078
G1 F2761.007
G1 X103.654 Y130.064 E.00909
M204 S10000
; WIPE_START
G1 X103.654 Y128.064 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z1.6 I.594 J1.062 P1  F30000
G1 X112.074 Y123.354 Z1.6
G1 Z1.2
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X110.446 Y123.354 E.05401
G1 X115.738 Y128.646 E.24828
G1 X118.122 Y128.646 E.07907
G1 X123.414 Y123.354 E.24828
G1 X125.798 Y123.354 E.07907
G1 X131.09 Y128.646 E.24828
G1 X133.474 Y128.646 E.07907
G1 X134.981 Y127.139 E.07071
G2 X134.981 Y124.861 I-3.989 J-1.139 E.07655
G1 X133.474 Y123.354 E.07071
G1 X131.09 Y123.354 E.07907
G1 X125.798 Y128.646 E.24828
G1 X123.414 Y128.646 E.07907
G1 X118.122 Y123.354 E.24828
G1 X115.738 Y123.354 E.07907
G1 X110.446 Y128.646 E.24828
G1 X108.062 Y128.646 E.07907
G1 X104.394 Y124.978 E.17207
G1 X104.394 Y127.022 E.06779
G1 X108.062 Y123.354 E.17207
G1 X106.434 Y123.354 E.05401
G1 X133.553 Y129.078 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.500198
G1 F13777.175
G1 X104.478 Y129.078 E1.08339
G1 X104.478 Y129.535 E.01703
G1 X133.553 Y129.535 E1.08339
G1 X133.98 Y129.475 E.01608
G1 X134.325 Y129.343 E.01379
; LINE_WIDTH: 0.460912
G1 F15000
G1 X134.733 Y129.034 E.01742
; LINE_WIDTH: 0.418789
G1 X135.07 Y128.649 E.01566
G1 X135.428 Y127.983 E.02316
; LINE_WIDTH: 0.358096
G1 X135.592 Y127.496 E.0132
G2 X135.794 Y126.025 I-5.676 J-1.532 E.03823
G1 X135.795 Y126.009 E.00042
G2 X135.44 Y124.048 I-6.25 J.118 E.05141
; LINE_WIDTH: 0.402555
G2 X135.044 Y123.312 I-4.969 J2.207 E.02451
; LINE_WIDTH: 0.438165
G1 X134.652 Y122.882 E.01873
; LINE_WIDTH: 0.469413
G1 F14771.638
G1 X134.274 Y122.633 E.01574
; LINE_WIDTH: 0.499929
G1 F13785.29
G2 X133.553 Y122.465 I-.751 J1.589 E.0278
G1 X104.478 Y122.465 E1.08275
G1 X104.478 Y122.922 E.01702
G1 X133.553 Y122.922 E1.08275
G1 X133.99 Y122.997 E.01652
; LINE_WIDTH: 0.464932
G1 F14928.503
G1 X134.418 Y123.216 E.01655
; LINE_WIDTH: 0.427549
G1 F15000
G1 X134.821 Y123.64 E.01831
; LINE_WIDTH: 0.402298
G1 X135.115 Y124.171 E.01779
; LINE_WIDTH: 0.358936
G3 X135.492 Y125.983 I-4.407 J1.862 E.04794
G3 X135.317 Y127.296 I-4.99 J.005 E.03423
G1 X135.114 Y127.829 E.01468
; LINE_WIDTH: 0.409969
G1 X134.848 Y128.319 E.01668
G1 X134.442 Y128.765 E.01804
; LINE_WIDTH: 0.462353
G1 X134.013 Y129.001 E.01673
; LINE_WIDTH: 0.492757
G1 F14005.072
G1 X133.612 Y129.068 E.01491
; CHANGE_LAYER
; Z_HEIGHT: 1.4
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F14005.072
G1 X134.013 Y129.001 E-.76
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 7/101
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L7
M991 S0 P6 ;notify layer change
G17
G3 Z1.6 I-.055 J-1.216 P1  F30000
M73 P37 R12
G1 X104.046 Y130.359 Z1.6
G1 Z1.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X104.046 Y121.641 E.28919
G1 X133.6 Y121.641 E.98038
G1 X133.844 Y121.668 E.00813
G1 X134.061 Y121.696 E.00727
G1 X134.503 Y121.868 E.01571
G1 X134.959 Y122.169 E.01815
G3 X135.386 Y122.606 I-2.102 J2.479 E.02028
G1 X135.761 Y123.184 E.02286
G3 X136.242 Y124.534 I-6.807 J3.187 E.04761
G3 X136.361 Y126.734 I-7.558 J1.511 E.07334
G3 X136.034 Y128.168 I-5.745 J-.555 E.04891
G3 X135.761 Y128.816 I-3.721 J-1.186 E.02338
G1 X135.386 Y129.394 E.02286
G3 X134.061 Y130.304 I-2.156 J-1.719 E.05409
G3 X133.6 Y130.359 I-1.76 J-12.827 E.0154
G1 X104.106 Y130.359 E.97839
G1 X103.654 Y130.401 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
G1 X103.654 Y122.799 E.23356
G1 X103.654 Y122.399 E.01229
G1 F10078.064
G1 X103.654 Y121.999 E.01229
G1 F3899.032
G1 X103.654 Y121.599 E.01229
G1 F600
G1 X103.654 Y121.249 E.01077
G1 X133.622 Y121.249 E.92084
G1 X133.891 Y121.279 E.0083
G1 X134.159 Y121.313 E.00831
G1 X134.684 Y121.518 E.01731
G1 X135.204 Y121.861 E.01917
G3 X135.699 Y122.369 I-2.446 J2.879 E.02183
G1 F840
G1 X136.101 Y122.987 E.02264
G1 X136.178 Y123.138 E.00519
G1 F1440
G1 X136.405 Y123.703 E.01873
G1 F1320
G1 X136.625 Y124.446 E.02381
G1 F1440
G3 X136.751 Y126.776 I-7.997 J1.601 E.07194
G1 F1320
G1 X136.625 Y127.554 E.02422
G1 F1440
G1 X136.405 Y128.297 E.02381
G1 F840
G3 X136.101 Y129.013 I-4.11 J-1.322 E.02394
G1 F600
G1 X135.699 Y129.631 E.02264
G1 X135.514 Y129.844 E.00869
G1 X135.204 Y130.139 E.01313
G1 X134.684 Y130.482 E.01916
G1 X134.159 Y130.687 E.01731
G3 X133.622 Y130.751 I-2.058 J-14.939 E.01662
G1 X103.654 Y130.751 E.92084
G1 F2710.138
G1 X103.654 Y130.461 E.00893
M204 S10000
; WIPE_START
G1 X103.654 Y128.461 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z1.8 I1.204 J.174 P1  F30000
G1 X104.394 Y123.35 Z1.8
G1 Z1.4
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X104.394 Y124.978 E.05401
G1 X108.559 Y129.143 E.19539
G1 X109.948 Y129.143 E.04609
G1 X116.235 Y122.857 E.29492
G1 X117.624 Y122.857 E.04609
G1 X123.911 Y129.143 E.29492
G1 X125.3 Y129.143 E.04609
G1 X131.587 Y122.857 E.29492
G1 X132.976 Y122.857 E.04609
G1 X135.405 Y125.286 E.11395
G3 X135.405 Y126.714 I-28.685 J.714 E.04739
G1 X132.976 Y129.143 E.11395
G1 X131.587 Y129.143 E.04609
G1 X125.3 Y122.857 E.29492
G1 X123.911 Y122.857 E.04609
G1 X117.624 Y129.143 E.29492
G1 X116.235 Y129.143 E.04609
G1 X109.948 Y122.857 E.29492
G1 X108.559 Y122.857 E.04609
G1 X104.394 Y127.022 E.19539
G1 X104.394 Y128.65 E.05401
G1 X133.564 Y129.548 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.447282
G1 F15000
G1 X104.452 Y129.549 E.95928
G1 X104.452 Y129.953 E.01332
G1 X133.564 Y129.953 E.95928
G1 X133.986 Y129.896 E.01402
G1 X134.335 Y129.763 E.01231
G1 X134.727 Y129.513 E.01532
; LINE_WIDTH: 0.386689
G1 X135.088 Y129.163 E.01408
G1 X135.43 Y128.657 E.01712
; LINE_WIDTH: 0.343857
G2 X135.876 Y127.497 I-5.045 J-2.611 E.03053
; LINE_WIDTH: 0.317948
G2 X135.705 Y123.959 I-5.919 J-1.487 E.08055
; LINE_WIDTH: 0.365101
G1 X135.441 Y123.37 E.01694
G1 X135.114 Y122.872 E.01565
; LINE_WIDTH: 0.39781
G1 X134.727 Y122.487 E.01577
; LINE_WIDTH: 0.446805
G1 X134.298 Y122.218 E.01667
G2 X133.565 Y122.047 I-.751 J1.557 E.02496
G1 X104.452 Y122.047 E.95818
G1 X104.452 Y122.451 E.01331
G1 X133.565 Y122.451 E.95818
G1 X134.039 Y122.535 E.01583
G1 X134.477 Y122.761 E.01625
; LINE_WIDTH: 0.387034
G1 X134.865 Y123.096 E.01436
G1 X135.153 Y123.525 E.01448
; LINE_WIDTH: 0.354716
G1 X135.425 Y124.052 E.01508
; LINE_WIDTH: 0.321712
G1 X135.615 Y124.595 E.01307
G3 X135.754 Y126.675 I-6.261 J1.46 E.04758
G1 X135.633 Y127.332 E.01516
G3 X135.281 Y128.283 I-10.217 J-3.236 E.02305
; LINE_WIDTH: 0.357703
G1 X134.894 Y128.867 E.01797
; LINE_WIDTH: 0.393699
G1 X134.477 Y129.239 E.01597
; LINE_WIDTH: 0.432406
G1 X134.016 Y129.473 E.01642
G1 X133.623 Y129.539 E.01264
; CHANGE_LAYER
; Z_HEIGHT: 1.6
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F15000
G1 X134.016 Y129.473 E-.33063
G1 X134.477 Y129.239 E-.42937
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 8/101
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L8
M991 S0 P7 ;notify layer change
G17
G3 Z1.8 I-.058 J-1.216 P1  F30000
G1 X104.046 Y130.684 Z1.8
G1 Z1.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X104.046 Y121.316 E.31074
M73 P38 R12
G1 X133.6 Y121.316 E.98038
G1 X133.891 Y121.348 E.00971
G1 X134.081 Y121.369 E.00633
G1 X134.535 Y121.521 E.01586
G3 X134.959 Y121.773 I-1.641 J3.249 E.01638
G1 X135.421 Y122.212 E.02114
G3 X136.007 Y123.13 I-3.685 J3.001 E.03623
G1 X136.284 Y123.81 E.02434
G3 X136.007 Y128.87 I-6.57 J2.178 E.17209
G3 X134.842 Y130.305 I-3.279 J-1.472 E.06202
G1 X134.535 Y130.479 E.01172
G1 X134.081 Y130.631 E.01586
G1 X133.6 Y130.684 E.01605
G1 X104.106 Y130.684 E.97839
G1 X103.654 Y130.792 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
G1 X103.654 Y122.408 E.25762
G1 X103.654 Y122.008 E.01229
G1 F10078.064
G1 X103.654 Y121.608 E.01229
G1 F3899.032
G1 X103.654 Y121.208 E.01229
G1 F600
G1 X103.654 Y120.924 E.00872
G1 X133.622 Y120.924 E.92084
G1 X133.934 Y120.959 E.00966
G1 X134.166 Y120.984 E.00715
G1 X134.695 Y121.161 E.01715
G3 X135.204 Y121.465 I-1.98 J3.899 E.01823
G1 F960
G1 X135.712 Y121.948 E.02152
G1 F1200
G3 X136.187 Y122.622 I-3.538 J3.001 E.02539
G1 F1560
G1 X136.364 Y122.967 E.0119
G1 F1440
G1 X136.657 Y123.685 E.02382
G1 F1680
G1 X136.866 Y124.463 E.02478
G1 F1560
G3 X136.885 Y127.428 I-6.928 J1.527 E.09178
G1 F1680
G1 X136.866 Y127.536 E.00336
G1 F1440
G1 X136.657 Y128.315 E.02481
G1 F1560
G1 X136.364 Y129.033 E.02382
G1 F1200
G3 X135.928 Y129.776 I-3.83 J-1.748 E.02652
G1 F960
G1 X135.712 Y130.052 E.01078
G1 F600
G1 X135.204 Y130.535 E.02152
G3 X134.166 Y131.016 I-1.879 J-2.699 E.03534
G1 X133.622 Y131.076 E.01681
G1 X103.654 Y131.076 E.92084
G1 F2091.097
G1 X103.654 Y130.852 E.00688
M204 S10000
; WIPE_START
G1 X103.654 Y128.852 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z2 I.32 J1.174 P1  F30000
G1 X104.394 Y128.65 Z2
G1 Z1.6
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X104.394 Y127.022 E.05401
G1 X108.956 Y122.46 E.214
G1 X109.552 Y122.46 E.01977
G1 X116.632 Y129.54 E.33214
G1 X117.228 Y129.54 E.01977
G1 X124.308 Y122.46 E.33214
G1 X124.904 Y122.46 E.01977
G1 X131.984 Y129.54 E.33214
G1 X132.58 Y129.54 E.01977
G1 X135.698 Y126.422 E.14629
G2 X135.698 Y125.578 I-3.51 J-.422 E.02803
G1 X132.58 Y122.46 E.14629
G1 X131.984 Y122.46 E.01977
G1 X124.904 Y129.54 E.33214
G1 X124.308 Y129.54 E.01977
G1 X117.228 Y122.46 E.33214
G1 X116.632 Y122.46 E.01977
G1 X109.552 Y129.54 E.33214
G1 X108.956 Y129.54 E.01977
G1 X104.394 Y124.978 E.214
G1 X104.394 Y123.35 E.05401
G1 X133.569 Y129.927 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.411259
G1 F15000
G1 X104.434 Y129.928 E.87449
G1 X104.434 Y130.296 E.01106
G1 X133.579 Y130.296 E.8748
G1 X134.12 Y130.213 E.01642
G1 X134.618 Y129.995 E.01634
; LINE_WIDTH: 0.363912
G1 X135.06 Y129.633 E.01493
G1 X135.32 Y129.333 E.01039
; LINE_WIDTH: 0.338059
G1 X135.691 Y128.731 E.01701
; LINE_WIDTH: 0.302046
G1 X135.929 Y128.183 E.01262
G2 X135.971 Y123.928 I-6.254 J-2.189 E.09147
G1 X135.572 Y123.042 E.02051
; LINE_WIDTH: 0.340498
G1 X135.159 Y122.466 E.0172
; LINE_WIDTH: 0.381942
G1 X134.746 Y122.086 E.01549
G1 X134.356 Y121.866 E.01237
; LINE_WIDTH: 0.411086
G2 X133.569 Y121.704 I-.808 J1.927 E.02425
G1 X104.434 Y121.704 E.87408
G1 X104.434 Y122.072 E.01105
G1 X133.569 Y122.072 E.87408
G1 X134.06 Y122.143 E.01488
G1 X134.528 Y122.349 E.01535
; LINE_WIDTH: 0.371661
G1 X134.911 Y122.66 E.01321
; LINE_WIDTH: 0.342342
G1 X135.302 Y123.133 E.01498
; LINE_WIDTH: 0.302711
G1 X135.69 Y123.91 E.01837
G3 X135.72 Y128.006 I-5.982 J2.093 E.08831
G3 X135.31 Y128.847 I-7.426 J-3.102 E.01982
; LINE_WIDTH: 0.337999
G1 X134.916 Y129.335 E.01506
; LINE_WIDTH: 0.38242
G1 X134.528 Y129.653 E.0139
G1 X134.041 Y129.863 E.01465
; LINE_WIDTH: 0.407162
G1 X133.628 Y129.919 E.01237
; CHANGE_LAYER
; Z_HEIGHT: 1.8
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F15000
G1 X134.041 Y129.863 E-.76
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 9/101
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L9
M991 S0 P8 ;notify layer change
G17
G3 Z2 I-.046 J-1.216 P1  F30000
G1 X104.046 Y131.009 Z2
G1 Z1.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X104.046 Y120.991 E.33229
G1 X133.617 Y120.993 E.98094
G1 X134.081 Y121.044 E.01548
G1 X134.535 Y121.196 E.01586
G3 X135.421 Y121.815 I-1.731 J3.419 E.03598
G1 X135.875 Y122.394 E.02442
G1 X136.25 Y123.107 E.02671
G3 X136.881 Y126 I-6.977 J3.035 E.09886
G3 X135.875 Y129.606 I-7.393 J-.119 E.12553
G1 X135.421 Y130.185 E.02442
G3 X134.081 Y130.956 I-2.148 J-2.182 E.05183
G1 X133.6 Y131.009 E.01605
G1 X104.106 Y131.009 E.97839
G1 X103.654 Y131.117 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
G1 X103.654 Y122.083 E.27758
G1 X103.654 Y121.683 E.01229
G1 F10078.064
G1 X103.654 Y121.283 E.01229
G1 F3899.032
G1 X103.654 Y120.883 E.01229
G1 F600
G1 X103.654 Y120.599 E.00872
G1 X133.66 Y120.604 E.92202
G1 X134.166 Y120.659 E.01563
G1 F720
G1 X134.695 Y120.836 E.01715
G1 F960
G1 X135.216 Y121.132 E.01842
G3 X135.712 Y121.551 I-2.52 J3.481 E.01995
G1 F1320
G1 X136.197 Y122.169 E.02415
M73 P39 R11
G1 F1440
G1 X136.254 Y122.261 E.00332
G1 F1680
G1 X136.639 Y123.02 E.02616
G1 F1800
G1 X136.897 Y123.712 E.0227
G1 F1680
G1 X137.106 Y124.484 E.02457
G1 F1560
G3 X137.146 Y127.288 I-6.703 J1.497 E.08677
G1 F1680
G1 X137.106 Y127.515 E.00709
G1 F1800
G1 X136.897 Y128.288 E.02459
G1 F1680
G3 X136.607 Y129.058 I-11.863 J-4.027 E.02531
G1 F1440
G1 X136.254 Y129.739 E.02356
G1 F1320
G1 X136.197 Y129.831 E.00332
G1 F960
G1 X135.712 Y130.449 E.02415
G3 X135.216 Y130.868 I-3.015 J-3.062 E.01995
G1 F720
G1 X134.695 Y131.164 E.01842
G1 F600
G1 X134.166 Y131.341 E.01715
G1 X133.622 Y131.401 E.01681
G1 X103.654 Y131.401 E.92084
G1 F2091.089
G1 X103.654 Y131.177 E.00688
M204 S10000
; WIPE_START
G1 X103.654 Y129.177 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z2.2 I1.207 J.153 P1  F30000
G1 X104.394 Y123.35 Z2.2
G1 Z1.8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X104.394 Y124.978 E.05401
G1 X109.347 Y129.932 E.23237
G1 X109.16 Y129.932 E.00621
G1 X117.023 Y122.068 E.36887
G1 X116.836 Y122.068 E.00621
G1 X124.699 Y129.932 E.36887
G1 X124.512 Y129.932 E.00621
G1 X132.375 Y122.068 E.36887
G1 X132.188 Y122.068 E.00621
G1 X135.964 Y125.845 E.17714
G3 X135.964 Y126.155 I-1.43 J.155 E.01033
G1 X132.188 Y129.932 E.17714
G1 X132.375 Y129.932 E.00621
G1 X124.512 Y122.068 E.36887
G1 X124.699 Y122.068 E.00621
G1 X116.836 Y129.932 E.36887
G1 X117.023 Y129.932 E.00621
G1 X109.16 Y122.068 E.36887
G1 X109.347 Y122.068 E.00621
G1 X104.394 Y127.022 E.23237
G1 X104.394 Y128.65 E.05401
G1 X133.571 Y130.302 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.377587
G1 F15000
G1 X104.417 Y130.303 E.79506
G1 X104.417 Y130.638 E.00914
G1 X133.58 Y130.637 E.79531
G1 X134.108 Y130.56 E.01456
G1 X134.598 Y130.354 E.01449
G1 X135.083 Y130.009 E.01623
; LINE_WIDTH: 0.311966
G1 X135.501 Y129.534 E.01387
G1 X135.88 Y128.896 E.01629
; LINE_WIDTH: 0.28977
G2 X135.595 Y122.591 I-5.999 J-2.887 E.13226
; LINE_WIDTH: 0.33723
G1 X135.176 Y122.074 E.01597
G1 X134.787 Y121.755 E.01206
; LINE_WIDTH: 0.376923
G1 X134.369 Y121.529 E.01293
G2 X133.584 Y121.364 I-.801 J1.863 E.02199
G1 X104.417 Y121.362 E.79383
G1 X104.417 Y121.697 E.00912
G1 X133.584 Y121.698 E.79383
G1 X134.054 Y121.762 E.01292
G1 X134.477 Y121.935 E.01244
G1 X134.906 Y122.227 E.01411
; LINE_WIDTH: 0.311937
G1 X135.299 Y122.643 E.01256
G1 X135.662 Y123.216 E.01487
; LINE_WIDTH: 0.289566
G3 X135.72 Y128.658 I-5.773 J2.784 E.11298
G1 X135.36 Y129.271 E.01429
; LINE_WIDTH: 0.337014
G1 X134.953 Y129.731 E.01471
G1 X134.492 Y130.057 E.01352
; LINE_WIDTH: 0.36715
G1 X134.036 Y130.243 E.01302
G1 X133.63 Y130.295 E.01081
; CHANGE_LAYER
; Z_HEIGHT: 2
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F15000
G1 X134.036 Y130.243 E-.34485
G1 X134.492 Y130.057 E-.41515
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 10/101
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L10
M991 S0 P9 ;notify layer change
G17
G3 Z2.2 I-.049 J-1.216 P1  F30000
G1 X104.046 Y131.289 Z2.2
G1 Z2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X104.046 Y120.711 E.35089
G1 X133.604 Y120.711 E.98051
G1 X133.99 Y120.749 E.01287
G1 X134.096 Y120.759 E.00352
G1 X134.559 Y120.896 E.01604
G3 X136.143 Y122.428 I-1.539 J3.173 E.07433
G3 X137.121 Y126 I-6.783 J3.777 E.12404
G3 X135.875 Y130.002 I-7.664 J-.19 E.14083
G3 X134.559 Y131.104 I-2.739 J-1.933 E.05758
G3 X133.604 Y131.289 I-.958 J-2.397 E.03247
G1 X104.106 Y131.289 E.97852
G1 X103.654 Y131.442 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
G1 X103.654 Y121.758 E.29755
G1 X103.654 Y121.358 E.01229
G1 F11828.306
G1 X103.654 Y120.958 E.01229
G1 F5014.153
G1 X103.654 Y120.558 E.01229
G1 F1080
G1 X103.654 Y120.319 E.00735
G1 X133.623 Y120.319 E.92088
G1 F960
G1 X134.028 Y120.358 E.01251
G1 X134.171 Y120.372 E.0044
G1 F840
G1 X134.704 Y120.529 E.01707
G1 F960
G3 X135.216 Y120.807 I-2.403 J5.043 E.01793
G1 F1440
G1 X135.723 Y121.221 E.02009
G3 X136.197 Y121.773 I-3.428 J3.428 E.02237
G1 F1800
G3 X136.646 Y122.547 I-4.876 J3.348 E.02753
G1 F1920
G1 X136.846 Y122.967 E.01428
G1 F1800
G1 X137.138 Y123.745 E.02554
G1 F1680
G3 X137.346 Y124.504 I-22.717 J6.637 E.0242
G1 F1560
G3 X137.407 Y127.147 I-6.503 J1.471 E.08178
G1 F1680
G3 X137.212 Y127.998 I-4.772 J-.646 E.02684
G1 F1800
G1 X137.138 Y128.255 E.00823
G1 F1920
G1 X136.846 Y129.033 E.02554
G1 F1800
G3 X136.483 Y129.766 I-10.055 J-4.513 E.02512
G1 F1440
G3 X135.723 Y130.779 I-3.911 J-2.146 E.03905
G1 F960
G1 X135.216 Y131.193 E.02009
M73 P40 R11
G1 X134.897 Y131.374 E.01128
G1 F840
G1 X134.704 Y131.471 E.00665
G1 F960
G1 X134.171 Y131.628 E.01707
G1 F1080
G1 X133.623 Y131.681 E.01691
G1 X103.654 Y131.681 E.92088
G1 F2487.378
G1 X103.654 Y131.502 E.00551
M204 S10000
; WIPE_START
G1 X103.654 Y129.502 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z2.4 I.918 J.798 P1  F30000
G1 X104.394 Y128.65 Z2.4
G1 Z2
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X104.394 Y127.022 E.05401
G1 X109.672 Y121.744 E.24761
G1 X108.835 Y121.744 E.02776
G1 X117.348 Y130.256 E.39935
G1 X116.511 Y130.256 E.02776
G1 X125.024 Y121.744 E.39935
G1 X124.187 Y121.744 E.02776
G1 X132.7 Y130.256 E.39935
G1 X131.863 Y130.256 E.02776
G1 X136.208 Y125.912 E.20381
G3 X136.208 Y126.088 I-.802 J.088 E.00586
G1 X131.863 Y121.744 E.20381
G1 X132.7 Y121.744 E.02776
G1 X124.187 Y130.256 E.39935
G1 X125.024 Y130.256 E.02776
G1 X116.511 Y121.744 E.39935
G1 X117.348 Y121.744 E.02776
G1 X108.835 Y130.256 E.39935
G1 X109.672 Y130.256 E.02776
G1 X104.394 Y124.978 E.24761
G1 X104.394 Y123.35 E.05401
G1 X133.579 Y130.616 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.355396
G1 F15000
G1 X104.406 Y130.616 E.74284
G1 X104.406 Y130.929 E.00796
G1 X133.587 Y130.929 E.74303
G1 X134.119 Y130.861 E.01367
G1 X134.613 Y130.677 E.01341
G1 X135.055 Y130.38 E.01357
; LINE_WIDTH: 0.286186
G1 X135.529 Y129.898 E.01339
G1 X135.856 Y129.417 E.01153
G2 X136.791 Y126.016 I-6.362 J-3.578 E.07061
G2 X135.545 Y122.12 I-6.898 J.058 E.08233
; LINE_WIDTH: 0.318197
G2 X134.808 Y121.433 I-2.431 J1.871 E.0227
; LINE_WIDTH: 0.355226
G1 X134.406 Y121.224 E.01154
G2 X133.579 Y121.071 I-.839 J2.219 E.02151
G1 X104.406 Y121.071 E.74243
G1 X104.406 Y121.384 E.00796
G1 X133.579 Y121.384 E.74243
G1 X134.072 Y121.443 E.01264
G1 X134.507 Y121.597 E.01174
G1 X134.908 Y121.849 E.01207
; LINE_WIDTH: 0.284604
G1 X135.338 Y122.267 E.01179
G3 X136.174 Y123.834 I-4.625 J3.476 E.03513
G3 X135.966 Y128.656 I-6.253 J2.146 E.0973
G1 X135.756 Y129.118 E.00999
G1 X135.398 Y129.656 E.01272
; LINE_WIDTH: 0.318246
G1 X135.021 Y130.049 E.01222
G1 X134.523 Y130.395 E.01361
; LINE_WIDTH: 0.350044
G1 X133.979 Y130.574 E.01434
G1 X133.639 Y130.61 E.00855
; CHANGE_LAYER
; Z_HEIGHT: 2.2
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F15000
G1 X133.979 Y130.574 E-.28386
G1 X134.523 Y130.395 E-.47614
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 11/101
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L11
M991 S0 P10 ;notify layer change
G17
G3 Z2.4 I-.046 J-1.216 P1  F30000
G1 X104.046 Y131.559 Z2.4
G1 Z2.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X104.046 Y120.441 E.36883
G1 X133.604 Y120.441 E.98051
G1 X133.751 Y120.455 E.0049
G1 X134.096 Y120.489 E.01148
G3 X135.453 Y121.182 I-.708 J3.059 E.05105
G1 X135.902 Y121.673 E.02209
G3 X137.322 Y125.309 I-6.946 J4.808 E.13066
G3 X136.728 Y128.834 I-6.93 J.645 E.1199
G1 X136.365 Y129.597 E.02804
G3 X135.902 Y130.327 I-12.672 J-7.534 E.02867
G1 X135.453 Y130.818 E.02209
G3 X133.604 Y131.559 I-1.903 J-2.071 E.06752
G1 X104.106 Y131.559 E.97852
G1 X103.654 Y131.722 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
G1 X103.654 Y121.078 E.32706
G1 X103.654 Y120.678 E.01229
G1 F5269.068
G1 X103.654 Y120.278 E.01229
G1 F1200
G1 X103.654 Y120.049 E.00705
G1 X133.623 Y120.049 E.92088
G1 X133.789 Y120.065 E.00513
G1 X134.171 Y120.102 E.01178
G1 F1320
G1 X134.704 Y120.259 E.01707
G1 X135.227 Y120.521 E.01796
G1 F1440
G3 X135.723 Y120.896 I-2.841 J4.266 E.01914
G1 F1800
G1 X136.206 Y121.425 E.02202
G1 F1920
G1 X136.306 Y121.563 E.00523
G1 F2040
G1 X136.654 Y122.119 E.02015
G1 F1920
G1 X137.088 Y123.01 E.03045
G1 F1800
G3 X137.379 Y123.775 I-18.538 J7.487 E.02516
G1 F1680
G3 X137.587 Y124.525 I-22.42 J6.621 E.0239
G1 F1560
G3 X137.668 Y127.007 I-6.333 J1.449 E.07679
G1 F1680
G3 X137.489 Y127.839 I-4.663 J-.565 E.02618
G1 F1800
G3 X137.185 Y128.746 I-5.938 J-1.49 E.02942
G1 F1920
G3 X136.713 Y129.779 I-7.952 J-3.009 E.03493
G1 F2040
G1 X136.654 Y129.881 E.00362
G1 F1920
G1 X136.306 Y130.437 E.02015
G1 F1800
G1 X136.206 Y130.575 E.00523
G1 F1440
G1 X135.723 Y131.104 E.02202
G1 X135.535 Y131.257 E.00746
G1 F1320
G1 X135.227 Y131.479 E.01167
G1 X134.704 Y131.741 E.01796
G1 F1200
G1 X134.171 Y131.898 E.01707
G1 X133.623 Y131.951 E.01691
G1 X103.654 Y131.951 E.92088
G1 F2571.86
G1 X103.654 Y131.782 E.00521
M204 S10000
; WIPE_START
G1 X103.654 Y129.782 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z2.6 I1.209 J.139 P1  F30000
G1 X104.394 Y123.35 Z2.6
G1 Z2.2
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X104.394 Y124.978 E.05401
G1 X109.997 Y130.581 E.26285
G1 X108.511 Y130.581 E.04931
G1 X117.672 Y121.42 E.42979
G1 X116.187 Y121.42 E.04925
G1 X125.349 Y130.581 E.42979
G1 X123.863 Y130.581 E.04931
G1 X133.023 Y121.421 E.42974
G1 X131.54 Y121.421 E.04919
G1 X136.435 Y126.315 E.22963
G2 X136.435 Y125.685 I-2.84 J-.315 E.02097
G1 X131.539 Y130.581 E.22971
G1 X133.025 Y130.581 E.04931
G1 X123.864 Y121.42 E.42977
G1 X125.348 Y121.42 E.04922
G1 X116.187 Y130.581 E.42976
G1 X117.673 Y130.581 E.04931
G1 X108.511 Y121.419 E.42981
G1 X109.997 Y121.419 E.04928
G1 X104.394 Y127.022 E.26283
G1 X104.394 Y128.65 E.05401
G1 X104.535 Y120.93 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.614547
G1 F11021.186
G1 X133.58 Y120.931 E1.35295
G1 X134.104 Y120.995 E.02455
G1 X134.569 Y121.162 E.02305
; LINE_WIDTH: 0.573961
G1 F11863.49
G1 X135.016 Y121.431 E.02255
; LINE_WIDTH: 0.539671
G1 F12682.41
G1 X135.405 Y121.784 E.02128
; LINE_WIDTH: 0.488114
G1 F14151.135
G1 X135.852 Y122.377 E.02693
G3 X136.73 Y124.549 I-7.41 J4.261 E.08527
; LINE_WIDTH: 0.532378
G1 F12871.4
G3 X136.589 Y127.966 I-6.289 J1.451 E.13802
; LINE_WIDTH: 0.500787
G1 F13759.477
G3 X135.546 Y130.054 I-6.645 J-2.013 E.08753
; LINE_WIDTH: 0.548067
G1 F12471.618
G1 X135.135 Y130.475 E.02421
; LINE_WIDTH: 0.613092
G1 F11049.298
G1 X134.585 Y130.831 E.03044
G1 X134.073 Y131.013 E.02523
G1 X133.58 Y131.07 E.02303
G1 X104.595 Y131.07 E1.34672
; CHANGE_LAYER
; Z_HEIGHT: 2.4
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F11049.298
G1 X106.595 Y131.07 E-.76
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 12/101
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L12
M991 S0 P11 ;notify layer change
G17
G3 Z2.6 I-.343 J-1.168 P1  F30000
G1 X104.046 Y131.818 Z2.6
G1 Z2.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X104.046 Y120.182 E.38602
G1 X133.607 Y120.182 E.9806
G1 X134.107 Y120.225 E.01664
G3 X135.023 Y120.587 I-.76 J3.269 E.03278
G1 X135.48 Y120.916 E.01871
G3 X136.318 Y121.949 I-3.378 J3.596 E.04423
G3 X137.444 Y124.63 I-8.125 J4.99 E.09684
G3 X137.115 Y128.427 I-6.257 J1.37 E.12836
G3 X135.902 Y130.651 I-8.265 J-3.063 E.08435
G3 X134.107 Y131.775 I-2.528 J-2.044 E.07154
G1 X133.607 Y131.818 E.01664
G1 X104.106 Y131.818 E.97861
G1 X103.654 Y131.992 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
G1 X103.654 Y120.808 E.34368
G1 X103.654 Y120.408 E.01229
G1 F5517.39
G1 X103.654 Y120.008 E.01229
G1 F1320
G1 X103.654 Y119.789 E.0067
G1 X133.624 Y119.789 E.92091
G1 F1200
G1 X134.164 Y119.837 E.01666
G1 X134.175 Y119.838 E.00032
G1 F1320
G3 X134.704 Y119.989 I-2.494 J9.751 E.0169
G1 F1560
G1 X135.227 Y120.25 E.01796
G1 F1800
G1 X135.732 Y120.615 E.01916
G3 X136.206 Y121.1 I-3.62 J4.006 E.02086
G1 F2160
G3 X136.956 Y122.275 I-6.289 J4.843 E.04289
G1 F2040
G1 X137.047 Y122.455 E.00617
G1 F1920
G3 X137.481 Y123.433 I-7.211 J3.786 E.0329
G1 F1800
G1 X137.62 Y123.806 E.01224
G1 F1680
M73 P41 R11
G3 X137.827 Y124.545 I-22.125 J6.606 E.02361
G1 F1560
G3 X137.952 Y126.724 I-6.827 J1.483 E.06733
G1 F1680
G1 X137.827 Y127.455 E.02278
G1 X137.767 Y127.68 E.00718
G1 F1800
G1 X137.62 Y128.194 E.01642
G1 F1920
G3 X137.329 Y128.949 I-18.572 J-6.709 E.02485
G1 F2040
G1 X137.047 Y129.545 E.02027
G1 F2160
G3 X136.522 Y130.464 I-11.923 J-6.2 E.03252
G1 F1800
G3 X135.732 Y131.385 I-3.926 J-2.566 E.03739
G1 F1560
G1 X135.227 Y131.75 E.01916
G1 F1320
G1 X134.704 Y132.011 E.01796
G1 X134.349 Y132.116 E.01136
G1 F1200
G1 X134.175 Y132.162 E.00554
G1 F1320
G1 X133.624 Y132.211 E.01698
G1 X103.654 Y132.211 E.92091
G1 F2634.439
G1 X103.654 Y132.052 E.00486
M204 S10000
; WIPE_START
G1 X103.654 Y130.052 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z2.8 I-.322 J1.174 P1  F30000
G1 X106.602 Y130.861 Z2.8
G1 Z2.4
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X108.23 Y130.861 E.05401
G1 X117.953 Y121.139 E.45612
G1 X115.906 Y121.139 E.0679
G1 X125.629 Y130.861 E.45612
G1 X123.582 Y130.861 E.0679
G1 X133.305 Y121.139 E.45612
G1 X131.258 Y121.139 E.0679
G1 X136.662 Y126.543 E.25351
G2 X136.662 Y125.457 I-4.83 J-.543 E.03607
G1 X131.258 Y130.861 E.25351
G1 X133.305 Y130.861 E.0679
G1 X123.582 Y121.139 E.45612
G1 X125.629 Y121.139 E.0679
G1 X115.906 Y130.861 E.45612
G1 X117.953 Y130.861 E.0679
G1 X108.23 Y121.139 E.45612
G1 X110.277 Y121.139 E.0679
G1 X104.394 Y127.022 E.27599
G1 X104.394 Y124.978 E.06779
G1 X110.277 Y130.861 E.276
G1 X111.906 Y130.861 E.05401
G1 X104.524 Y120.66 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.592489
G1 F11463.541
G1 X133.586 Y120.66 E1.30148
G1 X134.038 Y120.705 E.02035
G1 X134.53 Y120.854 E.02301
; LINE_WIDTH: 0.540511
G1 F12661
G1 X134.977 Y121.102 E.02073
; LINE_WIDTH: 0.512173
G1 F13425.594
G1 X135.437 Y121.49 E.02301
; LINE_WIDTH: 0.468942
G1 F14787.996
G1 X135.724 Y121.823 E.01526
G3 X136.465 Y123.113 I-5.25 J3.877 E.05175
G1 X136.761 Y123.856 E.02779
; LINE_WIDTH: 0.513404
G1 F13390.485
G3 X137.096 Y125.253 I-6.531 J2.303 E.05515
; LINE_WIDTH: 0.528553
G1 F12972.782
G3 X136.572 Y128.621 I-6.544 J.707 E.13645
; LINE_WIDTH: 0.472964
G1 F14649.666
G3 X135.879 Y129.969 I-6.839 J-2.662 E.05322
G1 X135.471 Y130.473 E.02273
; LINE_WIDTH: 0.508463
G1 F13532.584
G1 X135.027 Y130.863 E.02239
; LINE_WIDTH: 0.536115
G1 F12773.853
G1 X134.594 Y131.118 E.02022
; LINE_WIDTH: 0.592411
G1 F11465.16
G1 X134.088 Y131.287 E.02386
G1 X133.586 Y131.34 E.02261
G1 X104.584 Y131.34 E1.29861
; CHANGE_LAYER
; Z_HEIGHT: 2.6
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F11465.16
G1 X106.584 Y131.34 E-.76
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 13/101
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L13
M991 S0 P12 ;notify layer change
G17
G3 Z2.8 I-.326 J-1.172 P1  F30000
G1 X104.046 Y132.046 Z2.8
G1 Z2.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X104.046 Y119.954 E.40109
G1 X133.607 Y119.954 E.9806
G1 X133.917 Y119.981 E.01032
G1 X134.107 Y119.998 E.00632
G3 X135.48 Y120.646 I-.502 J2.844 E.05098
G1 X135.926 Y121.076 E.02055
G3 X137.684 Y124.65 I-7.838 J6.075 E.13302
G3 X137.411 Y128.248 I-6.048 J1.349 E.12146
G3 X135.926 Y130.924 I-9.773 J-3.672 E.10186
G3 X135.049 Y131.665 I-3.017 J-2.683 E.03822
G3 X133.607 Y132.046 I-1.545 J-2.932 E.0499
G1 X104.106 Y132.046 E.97861
G1 X103.654 Y132.252 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
G1 X103.654 Y120.548 E.3596
G1 X103.654 Y120.148 E.01229
G1 F6230.756
G1 X103.654 Y119.748 E.01229
G1 F1680
G1 X103.654 Y119.562 E.00572
G1 X133.624 Y119.562 E.92091
G1 X133.951 Y119.591 E.01008
G1 X134.175 Y119.61 E.0069
G1 X134.711 Y119.753 E.01703
G1 F1560
G1 X135.235 Y119.989 E.01767
G1 F1680
G1 X135.278 Y120.017 E.00157
G1 F1800
G1 X135.732 Y120.344 E.01722
G1 F2040
G1 X136.215 Y120.81 E.02059
G1 F2160
G1 X136.293 Y120.904 E.00377
G1 F2280
G3 X136.777 Y121.591 I-6.077 J4.805 E.02584
G1 F2160
G1 X137.199 Y122.328 E.02608
G1 F2040
G1 X137.363 Y122.655 E.01125
G1 F1920
G3 X137.777 Y123.611 I-7.059 J3.617 E.03204
G1 F1800
G1 X137.861 Y123.836 E.00739
G1 F1680
G3 X138.068 Y124.566 I-21.794 J6.58 E.02329
G1 F1560
G3 X138.192 Y126.714 I-6.898 J1.477 E.06637
G1 F1680
G1 X138.068 Y127.433 E.02242
G1 F1800
G1 X137.861 Y128.164 E.02335
G1 F1920
G3 X137.571 Y128.908 I-18.3 J-6.692 E.02454
G1 F2040
G1 X137.363 Y129.345 E.01488
G1 F2160
G1 X137.199 Y129.672 E.01124
G1 F2280
G1 X136.662 Y130.588 E.03262
G1 F2160
G1 X136.293 Y131.096 E.0193
G1 F2040
G1 X136.215 Y131.19 E.00377
G1 F1800
G1 X135.732 Y131.656 E.02059
G1 F1680
G1 X135.278 Y131.983 E.01722
G1 F1560
G1 X135.235 Y132.011 E.00157
G1 F1680
G3 X133.624 Y132.438 I-1.736 J-3.302 E.05163
G1 X103.654 Y132.438 E.92091
G1 F2805.244
G1 X103.654 Y132.312 E.00388
M204 S10000
; WIPE_START
G1 X103.654 Y130.312 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z3 I-.117 J1.211 P1  F30000
G1 X112.176 Y131.132 Z3
G1 Z2.6
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X110.548 Y131.132 E.05401
G1 X104.394 Y124.978 E.28868
G1 X104.394 Y127.022 E.06779
G1 X110.548 Y120.868 E.28868
G1 X107.96 Y120.868 E.08584
G1 X118.224 Y131.132 E.4815
G1 X115.636 Y131.132 E.08584
G1 X125.9 Y120.868 E.4815
G1 X123.312 Y120.868 E.08584
G1 X133.576 Y131.132 E.4815
G1 X130.988 Y131.132 E.08584
G1 X136.877 Y125.243 E.27627
G3 X136.878 Y126.758 I-15.371 J.768 E.05029
G1 X130.988 Y120.868 E.27632
G1 X133.576 Y120.868 E.08584
G1 X123.312 Y131.132 E.4815
G1 X125.9 Y131.132 E.08584
G1 X115.636 Y120.868 E.4815
G1 X118.224 Y120.868 E.08584
G1 X107.96 Y131.132 E.4815
G1 X106.332 Y131.132 E.05401
G1 X104.503 Y120.411 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.548781
G1 F12454.029
G1 X133.587 Y120.411 E1.1989
G1 X134.109 Y120.467 E.02165
G1 X134.579 Y120.614 E.02027
G1 X135.032 Y120.858 E.02123
; LINE_WIDTH: 0.487675
G1 F14165.102
G1 X135.424 Y121.172 E.01821
; LINE_WIDTH: 0.444765
G1 F15000
G1 X135.865 Y121.67 E.02178
G3 X136.711 Y123.163 I-7.087 J5 E.05628
; LINE_WIDTH: 0.475699
G1 F14557.083
G1 X137.001 Y123.884 E.0274
; LINE_WIDTH: 0.512697
G1 F13410.639
G3 X137.34 Y125.289 I-6.389 J2.284 E.05543
; LINE_WIDTH: 0.53407
G1 F12827.053
G3 X137.072 Y127.904 I-6.105 J.696 E.106
; LINE_WIDTH: 0.498591
G1 F13825.765
G1 X136.822 Y128.58 E.0268
; LINE_WIDTH: 0.46553
G1 F14907.387
G3 X135.605 Y130.645 I-7.648 J-3.116 E.0828
; LINE_WIDTH: 0.495019
G1 F13935
G1 X135.201 Y131.019 E.02031
; LINE_WIDTH: 0.549404
G1 F12438.693
G3 X133.587 Y131.589 I-1.631 J-2.05 E.07194
G1 X104.563 Y131.589 E1.1979
; CHANGE_LAYER
; Z_HEIGHT: 2.8
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F12438.693
G1 X106.563 Y131.589 E-.76
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 14/101
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L14
M991 S0 P13 ;notify layer change
G17
G3 Z3 I-.319 J-1.174 P1  F30000
G1 X104.046 Y132.273 Z3
G1 Z2.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X104.046 Y119.727 E.41617
G1 X133.704 Y119.736 E.98381
G3 X135.504 Y120.404 I-.158 J3.186 E.06472
G3 X136.658 Y121.811 I-3.756 J4.255 E.0606
G3 X137.719 Y123.999 I-8.855 J5.648 E.08086
G1 X137.99 Y124.902 E.03128
G1 F4945.321
G1 X138.154 Y124.902 E.00544
G1 F3000
G1 X138.542 Y124.902 E.01288
M204 S5000
; FEATURE: Overhang wall

G1 X152.842 Y124.902 E.47435
G1 X152.842 Y127.098 E.07284
G1 X138.542 Y127.098 E.47435
M204 S10000
; FEATURE: Inner wall
G1 F8389.786
G1 X138.154 Y127.098 E.01288
G1 F11480.352
G1 X137.99 Y127.098 E.00544
G1 F15476.087
G1 X137.73 Y128.005 E.0313
G3 X135.926 Y131.194 I-10.234 J-3.684 E.12213
G3 X133.607 Y132.273 I-2.392 J-2.11 E.0873
G1 X104.106 Y132.273 E.97861
G1 X103.654 Y132.479 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
G1 X103.654 Y120.321 E.37357
G1 X103.654 Y119.921 E.01229
G1 F6230.756
G1 X103.654 Y119.521 E.01229
G1 F1680
G1 X103.654 Y119.335 E.00572
G1 X133.738 Y119.345 E.9244
G1 X134.175 Y119.383 E.01347
G1 F1800
G1 X134.711 Y119.525 E.01703
G1 F1920
G3 X135.741 Y120.09 I-1.323 J3.638 E.03624
G1 F2040
G1 X135.821 Y120.16 E.00328
G1 F2160
G1 X136.215 Y120.539 E.01679
G1 F2400
G3 X136.989 Y121.6 I-6.329 J5.429 E.04041
G1 F2280
G1 X137.116 Y121.811 E.00757
G1 F2160
M73 P42 R11
G1 X137.442 Y122.38 E.02013
G1 F2040
G1 X137.68 Y122.854 E.01632
G1 F1920
G1 X137.813 Y123.133 E.00948
G1 F1800
G3 X138.285 Y124.51 I-6.888 J3.135 E.0448
G1 F3000
G1 X138.474 Y124.51 E.0058
; FEATURE: Overhang wall
; LINE_WIDTH: 0.45

G1 X153.234 Y124.51 E.4896
G1 X153.234 Y127.49 E.09886
G1 X138.474 Y127.49 E.4896
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
G1 X138.285 Y127.49 E.0058
G1 X138.102 Y128.131 E.02048
G1 F1920
G1 X137.813 Y128.867 E.02429
G1 F2040
G1 X137.68 Y129.146 E.00948
G1 F2160
G1 X137.442 Y129.62 E.01632
G1 F2280
G3 X136.989 Y130.4 I-16.557 J-9.098 E.0277
G1 F2400
G3 X136.495 Y131.12 I-8.962 J-5.61 E.02686
G1 F2160
G1 X136.215 Y131.461 E.01355
G1 F2040
G1 X135.821 Y131.84 E.01679
G1 F1920
G1 X135.741 Y131.91 E.00328
G1 X135.235 Y132.238 E.01853
G1 F1800
G1 X134.711 Y132.475 E.01767
G1 F1680
G3 X133.624 Y132.665 I-1.091 J-3.033 E.03405
G1 X103.654 Y132.665 E.92091
G1 F2805.234
G1 X103.654 Y132.539 E.00388
M204 S10000
; WIPE_START
G1 X103.654 Y130.539 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z3.2 I-1.023 J.659 P1  F30000
G1 X104.487 Y131.832 Z3.2
G1 Z2.8
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.516989
G1 F13289.209
G1 X133.588 Y131.832 E1.12419
G1 X134.094 Y131.782 E.01966
G2 X135.031 Y131.401 I-.55 J-2.69 E.03928
; LINE_WIDTH: 0.466401
G1 F14876.701
G1 X135.461 Y131.073 E.01865
; LINE_WIDTH: 0.432266
G1 F15000
G2 X136.158 Y130.225 I-2.519 J-2.783 E.03496
G2 X136.734 Y129.241 I-8.448 J-5.608 E.0362
; LINE_WIDTH: 0.467249
G1 F14846.993
G2 X137.267 Y127.996 I-11.946 J-5.843 E.04685
G1 X137.263 Y127.213 F30000
; FEATURE: Bridge
; LINE_WIDTH: 0.445424
G1 F3000
G1 X137.61 Y127.213 E.0114
G1 X137.725 Y126.81 E.01373
G1 X137.504 Y126.81 E.00727
G2 X137.542 Y126.408 I-1.876 J-.382 E.01329
G1 X152.508 Y126.408 E.49089
G1 X152.508 Y126.005 E.0132
G1 X137.565 Y126.005 E.49014
G2 X137.536 Y125.603 I-3.131 J.017 E.01324
G1 X152.508 Y125.603 E.49107
G1 X152.508 Y125.235 E.01205
G1 X137.738 Y125.235 E.48444
G1 X137.728 Y125.2 E.00119
G1 X137.506 Y125.2 E.00728
G2 X137.437 Y124.798 I-4.131 J.504 E.0134
G1 X137.79 Y124.798 E.01156
G1 X106.073 Y131.391 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X107.701 Y131.391 E.05401
G1 X118.483 Y120.609 E.5058
G1 X115.377 Y120.609 E.10303
G1 X126.159 Y131.391 E.5058
G1 X123.053 Y131.391 E.10303
G1 X133.815 Y120.629 E.50487
G1 X130.729 Y120.609 E.10237
G1 X137.08 Y126.961 E.29796
G1 X137.124 Y126.704 E.00865
G2 X137.081 Y125.039 I-4.967 J-.704 E.0555
G1 X130.729 Y131.391 E.29799
G1 X133.815 Y131.371 E.10237
G1 X123.053 Y120.609 E.50487
G1 X126.159 Y120.609 E.10303
G1 X115.377 Y131.391 E.5058
G1 X118.483 Y131.391 E.10303
G1 X107.701 Y120.609 E.5058
G1 X110.807 Y120.609 E.10303
G1 X104.771 Y126.645 E.28314
G1 X104.771 Y125.355 E.04277
G1 X110.807 Y131.391 E.28314
G1 X112.435 Y131.391 E.05401
G1 X104.408 Y128.863 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.38292
G1 F15000
G1 X104.408 Y120.406 E.23432
; LINE_WIDTH: 0.407353
G1 X104.437 Y120.328 E.00244
; LINE_WIDTH: 0.456218
G1 X104.465 Y120.251 E.00276
; LINE_WIDTH: 0.512698
G1 F13410.587
G1 X104.493 Y120.174 E.00314
G1 X104.568 Y120.168 E.00288
G1 X133.594 Y120.172 E1.11115
G1 X134.118 Y120.223 E.02014
G3 X135.02 Y120.593 I-.575 J2.688 E.03752
; LINE_WIDTH: 0.467339
G1 F14843.823
G1 X135.448 Y120.916 E.01855
; LINE_WIDTH: 0.422195
G1 F15000
G1 X135.854 Y121.359 E.01858
G3 X136.579 Y122.466 I-5.835 J4.616 E.04096
; LINE_WIDTH: 0.445266
G1 X136.951 Y123.203 E.02704
; LINE_WIDTH: 0.476975
G1 F14514.287
G3 X137.275 Y124.015 I-6.689 J3.14 E.03097
; CHANGE_LAYER
; Z_HEIGHT: 3
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F14514.287
G1 X136.951 Y123.203 E-.76
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 15/101
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L15
M991 S0 P14 ;notify layer change
G17
G3 Z3.2 I-.33 J-1.171 P1  F30000
G1 X104.046 Y132.485 Z3.2
G1 Z3
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X104.046 Y119.515 E.43024
G1 X133.609 Y119.515 E.98068
G1 X134.114 Y119.555 E.0168
G3 X135.046 Y119.879 I-.416 J2.699 E.03292
G3 X136.385 Y121.099 I-2.16 J3.715 E.06054
G3 X138.035 Y124.19 I-10.434 J7.554 E.11656
G1 X138.222 Y124.19 E.00623
G1 X139.136 Y124.19 E.03031
G1 X140.05 Y124.19 E.03031
G1 X140.964 Y124.19 E.03031
G1 X141.877 Y124.19 E.03031
G1 F13500
G1 X142.791 Y124.19 E.03031
G1 F9000
G1 X143.705 Y124.19 E.03031
G1 F6000
G1 X144.618 Y124.19 E.03031
G1 F2880
G1 X145.532 Y124.19 E.03031
G1 F2640
G1 X146.446 Y124.19 E.03031
G1 F2280
G1 X147.359 Y124.19 E.03031
G1 F2040
G1 X148.273 Y124.19 E.03031
G1 F1680
G1 X149.187 Y124.19 E.03031
G1 F1440
G1 X150.101 Y124.19 E.03031
G1 F1080
G1 X151.014 Y124.19 E.03031
G1 F720
G1 X151.928 Y124.19 E.03031
G1 F600
G1 X152.842 Y124.19 E.03031
G1 F2731.158
G1 X152.842 Y124.482 E.00971
G1 F8137.45
G1 X152.842 Y124.882 E.01327
G1 F15476.087
G1 X152.842 Y125.282 E.01327
G1 X152.842 Y126.318 E.03434
G1 X152.842 Y126.718 E.01327
G1 F10078.064
G1 X152.842 Y127.118 E.01327
G1 F3899.032
G1 X152.842 Y127.518 E.01327
G1 F600
G1 X152.842 Y127.81 E.00971
G1 F720
G1 X151.928 Y127.81 E.03031
G1 F1080
G1 X151.014 Y127.81 E.03031
G1 F1440
G1 X150.101 Y127.81 E.03031
G1 F1680
G1 X149.187 Y127.81 E.03031
G1 F2040
G1 X148.273 Y127.81 E.03031
G1 F2280
G1 X147.359 Y127.81 E.03031
G1 F2640
G1 X146.446 Y127.81 E.03031
G1 F2880
G1 X145.532 Y127.81 E.03031
G1 F6000
G1 X144.618 Y127.81 E.03031
G1 F9000
G1 X143.705 Y127.81 E.03031
G1 F13500
G1 X142.791 Y127.81 E.03031
G1 F15476.087
G1 X141.877 Y127.81 E.03031
G1 X140.964 Y127.81 E.03031
G1 X140.05 Y127.81 E.03031
G1 X139.136 Y127.81 E.03031
G1 X138.222 Y127.81 E.03031
G1 X138.035 Y127.81 E.00623
G1 X137.694 Y128.669 E.03063
G3 X135.942 Y131.444 I-11.239 J-5.158 E.10919
G3 X134.584 Y132.329 I-2.934 J-3.017 E.05412
G3 X133.609 Y132.485 I-.966 J-2.911 E.03288
G1 X104.106 Y132.485 E.97869
G1 X103.654 Y132.706 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
G1 X103.654 Y120.094 E.38753
G1 X103.654 Y119.694 E.01229
G1 F6685.538
G1 X103.654 Y119.294 E.01229
G1 F1920
G1 X103.654 Y119.123 E.00526
G1 X133.625 Y119.123 E.92094
G1 X134.136 Y119.164 E.01574
G1 X134.177 Y119.167 E.00129
G1 F1800
G1 X134.712 Y119.299 E.01693
G1 F1920
G1 X135.235 Y119.534 E.01761
G1 F2160
G3 X136.218 Y120.277 I-2.156 J3.877 E.03799
G1 F2400
G1 X136.701 Y120.866 E.0234
G1 X137.233 Y121.664 E.02948
G1 F2280
G1 X137.457 Y122.035 E.0133
G1 F2160
G1 X137.684 Y122.432 E.01408
G1 F2040
G1 X137.997 Y123.054 E.02139
G1 F1920
G3 X138.301 Y123.798 I-5.496 J2.681 E.0247
G1 F3000
G1 X138.508 Y123.798 E.00636
; FEATURE: Overhang wall
; LINE_WIDTH: 0.45

G1 X153.234 Y123.798 E.48848
G1 X153.234 Y124.1 E.01003
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F8060.209
G1 X153.234 Y124.469 E.01134
G1 F12000
G1 X153.234 Y124.869 E.01229
G1 X153.234 Y126.731 E.05722
G1 X153.234 Y127.131 E.01229
G1 F8596.922
G1 X153.234 Y127.531 E.01229
G1 F3000
G1 X153.234 Y127.9 E.01134
; FEATURE: Overhang wall
; LINE_WIDTH: 0.45

G1 X153.234 Y128.202 E.01003
G1 X138.508 Y128.202 E.48848
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1920
G1 X138.301 Y128.202 E.00636
G1 X138.054 Y128.825 E.02059
G1 F2040
G1 X137.997 Y128.946 E.0041
G1 F2160
G1 X137.684 Y129.568 E.02139
G1 F2280
G1 X137.457 Y129.965 E.01408
G1 F2400
G3 X136.701 Y131.134 I-13.565 J-7.946 E.04279
G1 F2160
G3 X136.222 Y131.719 I-5.395 J-3.922 E.02323
G1 X135.741 Y132.137 E.0196
G1 F1920
G1 X135.235 Y132.466 E.01853
G1 F1800
G1 X134.712 Y132.701 E.01761
G1 F1920
G3 X133.625 Y132.877 I-1.084 J-3.247 E.03399
G1 X103.654 Y132.877 E.92094
G1 F2955.448
G1 X103.654 Y132.766 E.00342
M204 S10000
; WIPE_START
G1 X103.654 Y130.766 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z3.4 I1.179 J.301 P1  F30000
G1 X104.213 Y128.574 Z3.4
G1 Z3
G1 E.8 F1800
; FEATURE: Bridge
; LINE_WIDTH: 0.4
; LAYER_HEIGHT: 0.4
G1 F3000
G1 X107.088 Y131.449 E.20814
G1 X107.724 Y131.449 E.03258
G1 X104.416 Y128.14 E.23956
G1 X104.416 Y127.504 E.03258
G1 X108.125 Y131.214 E.26861
G2 X108.444 Y130.896 I-2.757 J-3.079 E.02305
G1 X104.416 Y126.868 E.29167
G1 X104.416 Y126.231 E.03258
G1 X108.762 Y130.577 E.31471
G1 X109.08 Y130.259 E.02304
G1 X104.416 Y125.595 E.33775
G1 X104.416 Y124.958 E.03258
G1 X109.398 Y129.941 E.36079
G1 X109.716 Y129.623 E.02304
G1 X104.416 Y124.322 E.38383
G1 X104.416 Y123.686 E.03258
G1 X110.035 Y129.305 E.40687
G1 X110.353 Y128.986 E.02304
G1 X113.411 Y132.045 E.22143
G1 X104.416 Y123.049 E.65134
G1 X104.416 Y122.413 E.03258
G1 X114.047 Y132.045 E.69742
G1 X114.684 Y132.045 E.03258
G1 X104.416 Y121.776 E.7435
G1 X104.416 Y121.14 E.03258
G1 X115.32 Y132.045 E.78958
G1 X115.957 Y132.045 E.03258
G1 X104.416 Y120.504 E.83566
G1 X104.416 Y119.955 E.02806
G1 X104.504 Y119.955 E.00452
G1 X115.782 Y131.233 E.81661
G1 X116.1 Y130.915 E.02304
G1 X108.177 Y122.992 E.57372
G1 X108.495 Y122.674 E.02304
G1 X116.418 Y130.597 E.57372
G1 X116.736 Y130.279 E.02304
M73 P43 R11
G1 X108.813 Y122.355 E.57372
G1 X109.131 Y122.037 E.02304
G1 X117.055 Y129.961 E.57372
G1 X117.373 Y129.642 E.02304
G1 X109.449 Y121.719 E.57372
G1 X109.768 Y121.401 E.02304
G1 X117.691 Y129.324 E.57372
G1 X118.009 Y129.006 E.02304
G1 X121.048 Y132.045 E.22001
G1 X110.086 Y121.083 E.79373
G1 X110.404 Y120.764 E.02304
G1 X121.684 Y132.045 E.81677
G1 X122.32 Y132.045 E.03258
G1 X110.231 Y119.955 E.87534
G1 X110.868 Y119.955 E.03258
G1 X122.957 Y132.045 E.87534
G1 X123.593 Y132.045 E.03258
G1 X111.504 Y119.955 E.87534
G1 X112.141 Y119.955 E.03258
G1 X123.438 Y131.253 E.81803
G1 X123.756 Y130.935 E.02304
G1 X115.833 Y123.011 E.57372
G1 X116.151 Y122.693 E.02304
G1 X124.075 Y130.617 E.57372
G1 X124.393 Y130.298 E.02304
G1 X116.469 Y122.375 E.57372
G1 X116.788 Y122.057 E.02304
G1 X124.711 Y129.98 E.57372
G1 X125.029 Y129.662 E.02304
G1 X117.106 Y121.739 E.57372
G1 X117.424 Y121.42 E.02304
G1 X125.347 Y129.344 E.57372
G1 X125.666 Y129.026 E.02304
G1 X128.684 Y132.045 E.21859
G1 X117.742 Y121.102 E.79231
G1 X118.06 Y120.784 E.02304
G1 X129.321 Y132.045 E.81535
G1 X129.957 Y132.045 E.03258
G1 X117.868 Y119.955 E.87534
G1 X118.505 Y119.955 E.03258
G1 X130.594 Y132.045 E.87534
G1 X131.23 Y132.045 E.03258
G1 X119.141 Y119.955 E.87534
G1 X119.777 Y119.955 E.03258
G1 X131.095 Y131.273 E.81945
G1 X131.413 Y130.954 E.02304
G1 X123.489 Y123.031 E.57372
G1 X123.807 Y122.713 E.02304
G1 X131.731 Y130.636 E.57372
G1 X132.049 Y130.318 E.02304
G1 X124.126 Y122.395 E.57372
G1 X124.444 Y122.076 E.02304
G1 X132.367 Y130 E.57372
G1 X132.686 Y129.682 E.02304
G1 X124.762 Y121.758 E.57372
G1 X125.08 Y121.44 E.02304
G1 X133.004 Y129.363 E.57372
G1 X133.322 Y129.045 E.02304
G1 X135.58 Y131.303 E.16347
G1 X125.398 Y121.122 E.73719
G1 X125.717 Y120.804 E.02304
G1 X135.866 Y130.953 E.73486
G2 X136.145 Y130.595 I-1.704 J-1.617 E.02325
G1 X126.035 Y120.485 E.73202
G1 X126.127 Y120.393 E.0067
G1 X126.007 Y119.955 E.02323
G1 X126.141 Y119.955 E.00688
G1 X136.399 Y130.213 E.74274
G2 X136.65 Y129.828 I-4.224 J-3.022 E.02356
G1 X126.778 Y119.955 E.71482
G1 X127.414 Y119.955 E.03258
G1 X136.887 Y129.428 E.68588
G2 X137.109 Y129.014 I-3.491 J-2.144 E.02407
G1 X131.146 Y123.051 E.43181
G1 X131.464 Y122.732 E.02304
G1 X137.299 Y128.567 E.42249
G2 X137.473 Y128.105 I-3.105 J-1.433 E.02532
G1 X131.782 Y122.414 E.41205
G1 X132.1 Y122.096 E.02304
G1 X137.614 Y127.61 E.39923
G2 X137.723 Y127.082 I-4.232 J-1.146 E.02761
G1 X132.418 Y121.778 E.38406
G1 X132.737 Y121.46 E.02304
G1 X137.797 Y126.52 E.36643
G2 X137.821 Y125.907 I-2.683 J-.409 E.03148
G1 X133.055 Y121.141 E.34508
G1 X133.373 Y120.823 E.02304
G1 X137.771 Y125.221 E.31842
G1 X137.768 Y125.185 E.00182
G2 X137.625 Y124.439 I-8.151 J1.172 E.03892
G1 X133.142 Y119.955 E.32465
G3 X133.794 Y119.971 I.233 J3.93 E.03342
G1 X137.669 Y123.847 E.28064
G1 X138.948 Y125.336 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.419999
; LAYER_HEIGHT: 0.2
G1 F15000
G1 X138.991 Y125.899 E.01733
G1 X138.958 Y126.664 E.02354
G1 X151.695 Y126.664 E.39138
G1 X151.695 Y125.336 E.04081
G1 X139.008 Y125.336 E.38983
G1 X139.407 Y126.238 F30000
; LINE_WIDTH: 0.518387
G1 F13250.146
G1 X151.269 Y126.238 E.45957
G1 X151.269 Y125.762 E.01842
G1 X139.408 Y125.762 E.45955
G1 X139.408 Y126.178 E.0161
G1 X138.53 Y127.041 F30000
; LINE_WIDTH: 0.419999
G1 F15000
G1 X152.073 Y127.041 E.41612
G1 X152.073 Y124.959 E.06398
G1 X138.533 Y124.959 E.41605
G1 X138.615 Y125.927 E.02985
G1 X138.577 Y126.737 E.02493
G1 X138.539 Y126.982 E.00761
G1 X138.078 Y127.418 F30000
G1 F15000
G1 X152.45 Y127.418 E.44159
G1 X152.45 Y124.582 E.08715
G1 X138.083 Y124.582 E.44144
G1 X138.173 Y125.09 E.01585
G1 X138.239 Y125.955 E.02666
G3 X138.092 Y127.36 I-7.989 J-.125 E.04345
G1 X134.024 Y131.58 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X132.709 Y130.265 E.0617
G1 X126.386 Y131.618 F30000
G1 F15476.087
G1 X125.033 Y130.265 E.06349
G1 X118.71 Y131.618 F30000
G1 F15476.087
G1 X117.357 Y130.265 E.06349
G1 X112.775 Y132.052 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.502725
G1 F13701.46
G1 X104.539 Y132.052 E.30857
G1 X116.491 Y132.052 F30000
G1 F13701.46
G1 X120.351 Y132.052 E.14466
G1 X128.048 Y132.052 F30000
G1 F13701.46
G1 X124.191 Y132.052 E.14451
M73 P44 R11
G1 X131.772 Y132.052 F30000
; LINE_WIDTH: 0.499708
G1 F13791.963
G1 X133.592 Y132.051 E.06775
G1 X134.095 Y132.005 E.01881
G1 X134.599 Y131.86 E.01951
; LINE_WIDTH: 0.453461
G1 F15000
G1 X135.056 Y131.627 E.01717
G1 X135.152 Y131.558 E.00397
G1 X131.855 Y121.735 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F15476.087
M73 P44 R10
G1 X130.502 Y120.382 E.06349
G1 X124.179 Y121.735 F30000
G1 F15476.087
G1 X122.826 Y120.382 E.06349
G1 X116.503 Y121.735 F30000
G1 F15476.087
G1 X115.15 Y120.382 E.06349
G1 X109.697 Y119.948 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.502725
G1 F13701.46
G1 X105.836 Y119.948 E.14464
G1 X117.337 Y119.948 F30000
; LINE_WIDTH: 0.502724
G1 F13701.491
G1 X113.473 Y119.948 E.14478
G1 X125.533 Y119.948 F30000
; LINE_WIDTH: 0.502725
G1 F13701.46
G1 X121.11 Y119.948 E.16573
G1 X128.687 Y119.948 F30000
; LINE_WIDTH: 0.502724
G1 F13701.491
G1 X132.558 Y119.948 E.14505
G1 X135.327 Y120.417 F30000
; LINE_WIDTH: 0.38292
G1 F15000
G3 X136.117 Y121.224 I-4.352 J5.053 E.03131
G1 X111.034 Y131.618 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X109.681 Y130.265 E.06349
G1 X108.827 Y121.735 F30000
G1 F15476.087
G1 X107.474 Y120.382 E.06349
; CHANGE_LAYER
; Z_HEIGHT: 3.2
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F15476.087
G1 X108.827 Y121.735 E-.76
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 16/101
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L16
M991 S0 P15 ;notify layer change
G17
G3 Z3.4 I-1.115 J-.487 P1  F30000
G1 X104.046 Y132.677 Z3.4
G1 Z3.2
G1 E.8 F1800
; FEATURE: Inner wall
G1 F15476.087
G1 X104.046 Y119.323 E.44296
G1 X133.609 Y119.323 E.98068
G1 X133.911 Y119.347 E.01002
G1 X134.115 Y119.364 E.00682
G3 X135.504 Y119.949 I-.6 J3.363 E.05042
G3 X136.361 Y120.815 I-2.781 J3.608 E.04053
G3 X138.073 Y123.647 I-11.595 J8.941 E.10998
G1 X138.271 Y123.647 E.00658
G1 X139.182 Y123.647 E.03021
G1 X140.092 Y123.647 E.03021
G1 X141.003 Y123.647 E.03021
G1 X141.914 Y123.647 E.03021
G1 X142.824 Y123.647 E.03021
G1 X143.735 Y123.647 E.03021
G1 X144.646 Y123.647 E.03021
G1 F15000
G1 X145.556 Y123.647 E.03021
G1 F13500
G1 X146.467 Y123.647 E.03021
G1 F10500
G1 X147.378 Y123.647 E.03021
G1 F9000
G1 X148.288 Y123.647 E.03021
G1 F6000
G1 X149.199 Y123.647 E.03021
G1 F4500
G1 X150.11 Y123.647 E.03021
G1 F2880
G1 X151.02 Y123.647 E.03021
G1 F2760
G1 X151.931 Y123.647 E.03021
G1 F2640
G1 X152.842 Y123.647 E.03021
G1 F3978.296
G1 X152.842 Y123.77 E.00409
G1 F10205.256
G1 X152.842 Y124.17 E.01327
G1 F15476.087
G1 X152.842 Y124.57 E.01327
G1 X152.842 Y127.43 E.09486
G1 X152.842 Y127.83 E.01327
G1 F7979.538
G1 X152.842 Y128.23 E.01327
G1 F2640
G1 X152.842 Y128.353 E.00409
G1 F2760
G1 X151.931 Y128.353 E.03021
G1 F2880
G1 X151.02 Y128.353 E.03021
G1 F4500
G1 X150.11 Y128.353 E.03021
G1 F6000
G1 X149.199 Y128.353 E.03021
G1 F9000
G1 X148.288 Y128.353 E.03021
G1 F10500
G1 X147.378 Y128.353 E.03021
G1 F13500
G1 X146.467 Y128.353 E.03021
G1 F15000
G1 X145.556 Y128.353 E.03021
G1 F15476.087
G1 X144.646 Y128.353 E.03021
G1 X143.735 Y128.353 E.03021
G1 X142.824 Y128.353 E.03021
G1 X141.914 Y128.353 E.03021
G1 X141.003 Y128.353 E.03021
G1 X140.092 Y128.353 E.03021
G1 X139.182 Y128.353 E.03021
G1 X138.271 Y128.353 E.03021
G1 X138.073 Y128.353 E.00658
G1 X137.649 Y129.195 E.03126
G3 X135.948 Y131.665 I-11.136 J-5.847 E.09972
G1 X135.504 Y132.051 E.0195
G3 X133.609 Y132.677 I-1.963 J-2.761 E.0672
G1 X104.106 Y132.677 E.97869
G1 X103.654 Y132.918 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
G1 X103.654 Y119.882 E.40057
G1 X103.654 Y119.482 E.01229
G1 F7127.265
G1 X103.654 Y119.082 E.01229
G1 F2160
G1 X103.654 Y118.931 E.00463
G1 X133.625 Y118.931 E.92094
G1 X133.942 Y118.957 E.00977
G1 X134.178 Y118.975 E.00727
G1 F2280
G1 X134.716 Y119.106 E.01702
G1 F2160
G1 X135.242 Y119.323 E.01747
G3 X135.741 Y119.635 I-3.68 J6.435 E.0181
G1 F2400
G1 X136.222 Y120.053 E.0196
G1 F2640
G1 X136.417 Y120.266 E.00888
G1 F2520
G3 X137.081 Y121.133 I-9.463 J7.934 E.03356
G1 F2400
G1 X137.477 Y121.728 E.02194
G1 F2280
G1 X137.797 Y122.258 E.01903
G1 F2160
G1 X137.927 Y122.484 E.00802
G1 F1920
G1 X138.314 Y123.255 E.0265
G1 F3000
G1 X138.527 Y123.255 E.00654
; FEATURE: Overhang wall
; LINE_WIDTH: 0.45

G1 X153.234 Y123.255 E.48785
G1 X153.234 Y123.388 E.00441
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F8060.209
G1 X153.234 Y123.757 E.01134
G1 F12000
G1 X153.234 Y124.157 E.01229
G1 X153.234 Y127.443 E.10099
G1 X153.234 Y127.843 E.01229
G1 F8596.922
G1 X153.234 Y128.243 E.01229
G1 F3000
G1 X153.234 Y128.612 E.01134
; FEATURE: Overhang wall
; LINE_WIDTH: 0.45

G1 X153.234 Y128.745 E.00441
G1 X138.527 Y128.745 E.48785
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1920
G1 X138.314 Y128.745 E.00654
G1 F2160
G1 X137.927 Y129.516 E.0265
G1 F2280
G1 X137.797 Y129.742 E.00802
G1 F2400
G1 X137.477 Y130.272 E.01903
G1 F2520
G3 X136.946 Y131.06 I-16.697 J-10.683 E.0292
G1 F2640
G3 X136.417 Y131.734 I-8.216 J-5.901 E.02631
G1 F2400
G1 X136.222 Y131.947 E.00888
G1 F2160
G1 X135.741 Y132.365 E.0196
G3 X135.242 Y132.677 I-4.18 J-6.122 E.0181
G1 F2280
G1 X134.716 Y132.894 E.01747
G1 F2160
G3 X133.625 Y133.069 I-1.094 J-3.332 E.03409
G1 X103.654 Y133.069 E.92094
G1 F3033.689
G1 X103.654 Y132.978 E.00279
M204 S10000
G1 X104.253 Y132.513 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.421234
G1 F15000
G1 X104.529 Y132.238 E.01202
G1 X105.064 Y132.238 E.01649
G1 X104.958 Y132.344 E.00462
G1 X105.493 Y132.344 E.01649
G1 X105.599 Y132.238 E.00462
G1 X106.134 Y132.238 E.01649
G1 X106.028 Y132.344 E.00462
G1 X106.563 Y132.344 E.01649
G1 X106.669 Y132.238 E.00462
G1 X107.204 Y132.238 E.01649
G1 X107.098 Y132.344 E.00462
G1 X107.633 Y132.344 E.01649
G1 X107.739 Y132.238 E.00462
G1 X108.274 Y132.238 E.01649
G1 X108.168 Y132.344 E.00462
G1 X108.703 Y132.344 E.01649
G1 X108.809 Y132.238 E.00462
G1 X109.344 Y132.238 E.01649
G1 X109.238 Y132.344 E.00462
G1 X109.773 Y132.344 E.01649
G1 X109.879 Y132.238 E.00462
G1 X110.414 Y132.238 E.01649
G1 X110.308 Y132.344 E.00462
G1 X110.843 Y132.344 E.01649
G1 X110.949 Y132.238 E.00462
G1 X111.484 Y132.238 E.01649
G1 X111.378 Y132.344 E.00462
G1 X111.913 Y132.344 E.01649
G1 X112.019 Y132.238 E.00462
G1 X112.554 Y132.238 E.01649
G1 X112.448 Y132.344 E.00462
G1 X112.983 Y132.344 E.01649
G1 X113.089 Y132.238 E.00462
G1 X113.624 Y132.238 E.01649
G1 X113.518 Y132.344 E.00462
G1 X114.053 Y132.344 E.01649
G1 X114.159 Y132.238 E.00462
G1 X114.694 Y132.238 E.01649
G1 X114.588 Y132.344 E.00462
G1 X115.123 Y132.344 E.01649
G1 X115.229 Y132.238 E.00462
G1 X115.764 Y132.238 E.01649
G1 X115.658 Y132.344 E.00462
G1 X116.193 Y132.344 E.01649
G1 X116.299 Y132.238 E.00462
G1 X116.834 Y132.238 E.01649
G1 X116.728 Y132.344 E.00462
G1 X117.263 Y132.344 E.01649
G1 X117.369 Y132.238 E.00462
G1 X117.904 Y132.238 E.01649
G1 X117.798 Y132.344 E.00462
G1 X118.333 Y132.344 E.01649
G1 X118.439 Y132.238 E.00462
G1 X118.974 Y132.238 E.01649
G1 X118.868 Y132.344 E.00462
G1 X119.403 Y132.344 E.01649
G1 X119.509 Y132.238 E.00462
G1 X120.044 Y132.238 E.01649
G1 X119.938 Y132.344 E.00462
G1 X120.473 Y132.344 E.01649
G1 X120.579 Y132.238 E.00462
G1 X121.114 Y132.238 E.01649
G1 X121.008 Y132.344 E.00462
G1 X121.543 Y132.344 E.01649
G1 X121.649 Y132.238 E.00462
G1 X122.184 Y132.238 E.01649
G1 X122.078 Y132.344 E.00462
G1 X122.613 Y132.344 E.01649
G1 X122.719 Y132.238 E.00462
G1 X123.254 Y132.238 E.01649
G1 X123.148 Y132.344 E.00462
G1 X123.683 Y132.344 E.01649
G1 X123.789 Y132.238 E.00462
G1 X124.324 Y132.238 E.01649
G1 X124.218 Y132.344 E.00462
G1 X124.753 Y132.344 E.01649
G1 X124.859 Y132.238 E.00462
G1 X125.394 Y132.238 E.01649
G1 X125.288 Y132.344 E.00462
G1 X125.824 Y132.344 E.01649
G1 X125.929 Y132.238 E.00462
G1 X126.464 Y132.238 E.01649
G1 X126.359 Y132.344 E.00462
G1 X126.894 Y132.344 E.01649
G1 X127 Y132.238 E.00462
G1 X127.535 Y132.238 E.01649
G1 X127.429 Y132.344 E.00462
G1 X127.964 Y132.344 E.01649
G1 X128.07 Y132.238 E.00462
G1 X128.605 Y132.238 E.01649
G1 X128.499 Y132.344 E.00462
G1 X129.034 Y132.344 E.01649
G1 X129.14 Y132.238 E.00462
G1 X129.675 Y132.238 E.01649
G1 X129.569 Y132.344 E.00462
G1 X130.104 Y132.344 E.01649
G1 X130.21 Y132.238 E.00462
M73 P45 R10
G1 X130.745 Y132.238 E.01649
G1 X130.639 Y132.344 E.00462
G1 X131.174 Y132.344 E.01649
G1 X131.28 Y132.238 E.00462
G1 X131.815 Y132.238 E.01649
G1 X131.709 Y132.344 E.00462
G1 X132.244 Y132.344 E.01649
G1 X132.35 Y132.238 E.00462
G1 X132.885 Y132.238 E.01649
G1 X132.779 Y132.344 E.00462
G1 X133.314 Y132.344 E.01649
G1 X133.42 Y132.238 E.00462
G2 X133.988 Y132.204 I.087 J-3.362 E.01758
G1 X133.871 Y132.321 E.00512
G1 X134.062 Y132.306 E.00593
G1 X134.491 Y132.202 E.01359
G1 X134.549 Y132.178 E.00195
G1 X134.73 Y131.997 E.0079
G2 X136.161 Y130.852 I-1.376 J-3.186 E.05717
G1 X136.733 Y129.995 E.03177
G1 X136.894 Y129.833 E.00705
G2 X137.558 Y128.634 I-8.096 J-5.267 E.04229
G1 X136.876 Y129.317 E.02977
G1 X136.8 Y129.186 E.00467
G1 X136.472 Y129.186 E.01011
G1 X141.677 Y123.98 E.22694
G1 X142.212 Y123.98 E.01649
G1 X138.172 Y128.02 E.17612
G1 X138.707 Y128.02 E.01649
G1 X142.747 Y123.98 E.17612
G1 X143.282 Y123.98 E.01649
G1 X139.242 Y128.02 E.17612
G1 X139.778 Y128.02 E.01649
G1 X143.817 Y123.98 E.17612
G1 X144.352 Y123.98 E.01649
G1 X140.313 Y128.02 E.17612
G1 X140.848 Y128.02 E.01649
G1 X144.887 Y123.98 E.17612
G1 X145.422 Y123.98 E.01649
G1 X141.383 Y128.02 E.17612
G1 X141.918 Y128.02 E.01649
G1 X145.957 Y123.98 E.17612
G1 X146.492 Y123.98 E.01649
G1 X142.453 Y128.02 E.17612
G1 X142.988 Y128.02 E.01649
G1 X147.027 Y123.98 E.17612
G1 X147.562 Y123.98 E.01649
G1 X143.523 Y128.02 E.17612
G1 X144.058 Y128.02 E.01649
G1 X148.097 Y123.98 E.17612
G1 X148.632 Y123.98 E.01649
G1 X144.593 Y128.02 E.17612
G1 X145.128 Y128.02 E.01649
G1 X149.167 Y123.98 E.17612
G1 X149.702 Y123.98 E.01649
G1 X145.663 Y128.02 E.17612
G1 X146.198 Y128.02 E.01649
G1 X150.237 Y123.98 E.17612
G1 X150.772 Y123.98 E.01649
G1 X146.733 Y128.02 E.17612
G1 X147.268 Y128.02 E.01649
G1 X151.307 Y123.98 E.17612
G1 X151.842 Y123.98 E.01649
G1 X147.803 Y128.02 E.17612
G1 X148.338 Y128.02 E.01649
G1 X152.377 Y123.98 E.17612
G1 X152.508 Y123.98 E.00404
G1 X152.508 Y124.384 E.01245
G1 X148.873 Y128.02 E.1585
G1 X149.408 Y128.02 E.01649
G1 X152.508 Y124.919 E.13518
G1 X152.508 Y125.454 E.01649
G1 X149.943 Y128.02 E.11185
G1 X150.478 Y128.02 E.01649
G1 X152.508 Y125.989 E.08853
G1 X152.508 Y126.524 E.01649
G1 X151.013 Y128.02 E.0652
G1 X151.548 Y128.02 E.01649
G1 X152.508 Y127.059 E.04188
G1 X152.508 Y127.594 E.01649
G1 X151.913 Y128.19 E.02595
; WIPE_START
G1 X152.508 Y127.594 E-.31986
G1 X152.508 Y127.059 E-.20331
G1 X152.068 Y127.5 E-.23683
; WIPE_END
G1 E-.04 F1800
G17
G3 Z3.6 I-.138 J-1.209 P1  F30000
G1 X135.767 Y129.355 Z3.6
G1 Z3.2
G1 E.8 F1800
G1 F15000
G1 X141.142 Y123.98 E.23434
G1 X140.607 Y123.98 E.01649
G1 X135.402 Y129.186 E.22694
G1 X134.867 Y129.186 E.01649
G1 X140.072 Y123.98 E.22694
G1 X139.537 Y123.98 E.01649
G1 X134.332 Y129.186 E.22694
G1 X133.797 Y129.186 E.01649
G1 X139.002 Y123.98 E.22694
G1 X138.467 Y123.98 E.01649
G1 X133.262 Y129.186 E.22694
G1 X132.727 Y129.186 E.01649
G1 X137.932 Y123.98 E.22694
G1 X137.867 Y123.98 E.002
G1 X137.71 Y123.667 E.01079
G1 X132.192 Y129.186 E.24058
G1 X131.657 Y129.186 E.01649
G1 X137.531 Y123.311 E.2561
G1 X137.352 Y122.955 E.01228
G1 X131.122 Y129.186 E.27162
G1 X130.587 Y129.186 E.01649
G1 X137.159 Y122.613 E.28656
G1 X136.96 Y122.277 E.01203
G1 X136.914 Y122.323 E.00199
G1 X136.718 Y121.984 E.01207
G1 X136.752 Y121.95 E.0015
G1 X136.537 Y121.63 E.01188
G1 X136.51 Y121.657 E.00117
G1 X136.292 Y121.34 E.01187
G1 X136.319 Y121.313 E.00115
G2 X136.088 Y121.009 I-2.495 J1.653 E.01178
G1 X136.066 Y121.031 E.00096
G2 X135.814 Y120.748 I-1.371 J.966 E.01171
G1 X135.841 Y120.721 E.00116
G2 X135.575 Y120.452 I-1.045 J.766 E.0117
G1 X135.54 Y120.487 E.00152
G2 X135.226 Y120.266 I-.834 J.85 E.01189
G1 X135.286 Y120.206 E.00261
G1 X134.957 Y120 E.01197
G1 X134.884 Y120.073 E.00318
G2 X134.508 Y119.914 I-.745 J1.243 E.01263
G1 X134.585 Y119.837 E.00336
G2 X134.167 Y119.719 I-.59 J1.298 E.01343
G1 X134.083 Y119.804 E.0037
G2 X133.581 Y119.771 I-.45 J2.978 E.01552
G1 X133.688 Y119.664 E.00467
G2 X133.16 Y119.656 I-.31 J3.285 E.01628
G1 X133.046 Y119.771 E.00498
G1 X132.511 Y119.771 E.01649
G1 X132.625 Y119.656 E.00497
G1 X132.09 Y119.656 E.01649
G1 X131.976 Y119.77 E.00497
G1 X131.442 Y119.77 E.01649
G1 X131.555 Y119.656 E.00496
G1 X131.02 Y119.656 E.01649
G1 X130.907 Y119.77 E.00495
G1 X130.372 Y119.77 E.01649
G1 X130.485 Y119.656 E.00495
G1 X129.95 Y119.656 E.01649
G1 X129.837 Y119.77 E.00494
G1 X129.302 Y119.77 E.01649
G1 X129.415 Y119.656 E.00493
G1 X128.88 Y119.656 E.01649
G1 X128.767 Y119.77 E.00493
G1 X128.232 Y119.769 E.01649
G1 X128.345 Y119.656 E.00492
G1 X127.81 Y119.656 E.01649
G1 X127.697 Y119.769 E.00491
G1 X127.163 Y119.769 E.01649
G1 X127.275 Y119.656 E.00491
G1 X126.74 Y119.656 E.01649
G1 X126.628 Y119.769 E.0049
G1 X126.093 Y119.769 E.01649
G1 X126.205 Y119.656 E.00489
G1 X125.67 Y119.656 E.01649
G1 X125.558 Y119.769 E.00489
G1 X125.023 Y119.768 E.01649
G1 X125.135 Y119.656 E.00488
G1 X124.6 Y119.656 E.01649
G1 X124.488 Y119.768 E.00487
G1 X123.953 Y119.768 E.01649
G1 X124.065 Y119.656 E.00487
G1 X123.53 Y119.656 E.01649
G1 X123.419 Y119.768 E.00486
G1 X122.884 Y119.768 E.01649
G1 X122.995 Y119.656 E.00485
G1 X122.46 Y119.656 E.01649
G1 X122.349 Y119.768 E.00485
G1 X121.814 Y119.768 E.01649
G1 X121.925 Y119.656 E.00484
G1 X121.39 Y119.656 E.01649
G1 X121.279 Y119.767 E.00484
G1 X120.744 Y119.767 E.01649
G1 X120.855 Y119.656 E.00483
G1 X120.32 Y119.656 E.01649
G1 X120.209 Y119.767 E.00482
G1 X119.674 Y119.767 E.01649
G1 X119.785 Y119.656 E.00481
G1 X119.25 Y119.656 E.01649
G1 X119.14 Y119.767 E.00481
G1 X118.605 Y119.767 E.01649
G1 X118.715 Y119.656 E.0048
G1 X118.18 Y119.656 E.01649
G1 X118.07 Y119.766 E.0048
G1 X117.535 Y119.766 E.01649
G1 X117.645 Y119.656 E.00479
G1 X117.11 Y119.656 E.01649
G1 X117 Y119.766 E.00478
G1 X116.465 Y119.766 E.01649
G1 X116.575 Y119.656 E.00478
G1 X116.04 Y119.656 E.01649
G1 X115.93 Y119.766 E.00477
G1 X115.396 Y119.766 E.01649
G1 X115.505 Y119.656 E.00476
G1 X114.97 Y119.656 E.01649
G1 X114.861 Y119.766 E.00476
G1 X114.326 Y119.765 E.01649
G1 X114.435 Y119.656 E.00475
G1 X113.9 Y119.656 E.01649
G1 X113.791 Y119.765 E.00474
G1 X113.256 Y119.765 E.01649
G1 X113.365 Y119.656 E.00474
G1 X112.83 Y119.656 E.01649
G1 X112.721 Y119.765 E.00473
G1 X112.186 Y119.765 E.01649
G1 X112.295 Y119.656 E.00472
G1 X111.76 Y119.656 E.01649
G1 X111.652 Y119.765 E.00472
G1 X111.117 Y119.764 E.01649
G1 X111.225 Y119.656 E.00471
G1 X110.69 Y119.656 E.01649
G1 X110.582 Y119.764 E.0047
G1 X110.047 Y119.764 E.01649
G1 X110.155 Y119.656 E.0047
G1 X109.62 Y119.656 E.01649
G1 X109.512 Y119.764 E.00469
G1 X108.977 Y119.764 E.01649
G1 X109.085 Y119.656 E.00468
G1 X108.55 Y119.656 E.01649
G1 X108.442 Y119.764 E.00468
G1 X107.907 Y119.764 E.01649
G1 X108.015 Y119.656 E.00467
G1 X107.48 Y119.656 E.01649
G1 X107.373 Y119.763 E.00466
G1 X106.838 Y119.763 E.01649
G1 X106.945 Y119.656 E.00466
G1 X106.41 Y119.656 E.01649
G1 X106.303 Y119.763 E.00465
G1 X105.768 Y119.763 E.01649
G1 X105.874 Y119.656 E.00464
G1 X105.339 Y119.656 E.01649
G1 X105.233 Y119.763 E.00464
G1 X104.698 Y119.763 E.01649
G1 X104.974 Y119.487 E.01203
G1 X105.026 Y122.645 F30000
G1 F15000
G1 X104.209 Y123.462 E.03561
G1 X107.701 Y122.645 F30000
G1 F15000
G1 X105.213 Y125.133 E.10847
G1 X105.213 Y124.598 E.01649
G1 X106.997 Y122.814 E.07775
G1 X106.462 Y122.814 E.01649
G1 X105.509 Y123.767 E.04151
G1 X105.331 Y123.588 E.00778
G1 X105.153 Y123.588 E.00549
G1 X105.927 Y122.814 E.03373
G1 X105.392 Y122.814 E.01649
G1 X104.379 Y123.827 E.04414
G1 X104.401 Y124.875 E.03231
G1 X104.379 Y124.897 E.00097
G1 X104.379 Y125.432 E.01649
G1 X104.401 Y125.41 E.00097
G1 X104.401 Y125.71 E.00925
G1 X104.519 Y125.827 E.00512
G1 X104.379 Y125.967 E.00609
G1 X104.379 Y126.502 E.01649
G1 X108.067 Y122.814 E.16077
G1 X108.602 Y122.814 E.01649
G1 X105.17 Y126.247 E.14963
G1 X105.213 Y126.29 E.0019
G1 X105.213 Y126.738 E.0138
G1 X109.137 Y122.814 E.17105
G1 X109.672 Y122.814 E.01649
G1 X105.213 Y127.273 E.19437
G1 X105.225 Y127.6 E.01008
G1 X105.331 Y127.6 E.00328
G1 X105.376 Y127.645 E.00197
G1 X110.207 Y122.814 E.2106
G1 X110.742 Y122.814 E.01649
G1 X104.379 Y129.186 E.27758
G1 X104.906 Y129.186 E.01624
G1 X111.277 Y122.814 E.27776
G1 X111.812 Y122.814 E.01649
G1 X105.441 Y129.186 E.27776
G1 X105.976 Y129.186 E.01649
G1 X112.347 Y122.814 E.27776
G1 X112.882 Y122.814 E.01649
G1 X106.511 Y129.186 E.27776
G1 X107.046 Y129.186 E.01649
G1 X113.417 Y122.814 E.27776
G1 X113.952 Y122.814 E.01649
G1 X107.581 Y129.186 E.27776
G1 X108.116 Y129.186 E.01649
G1 X114.487 Y122.814 E.27776
G1 X115.022 Y122.814 E.01649
G1 X108.651 Y129.186 E.27776
G1 X109.186 Y129.186 E.01649
G1 X115.557 Y122.814 E.27776
G1 X116.092 Y122.814 E.01649
G1 X109.721 Y129.186 E.27776
G1 X110.256 Y129.186 E.01649
G1 X116.627 Y122.814 E.27776
G1 X117.162 Y122.814 E.01649
G1 X110.791 Y129.186 E.27776
G1 X111.326 Y129.186 E.01649
G1 X117.697 Y122.814 E.27776
G1 X118.232 Y122.814 E.01649
G1 X111.861 Y129.186 E.27776
G1 X112.396 Y129.186 E.01649
G1 X118.767 Y122.814 E.27776
G1 X119.302 Y122.814 E.01649
G1 X112.931 Y129.186 E.27776
G1 X113.466 Y129.186 E.01649
G1 X119.837 Y122.814 E.27776
G1 X120.372 Y122.814 E.01649
G1 X114.001 Y129.186 E.27776
G1 X114.536 Y129.186 E.01649
G1 X120.907 Y122.814 E.27776
G1 X121.442 Y122.814 E.01649
G1 X115.071 Y129.186 E.27776
G1 X115.606 Y129.186 E.01649
G1 X121.977 Y122.814 E.27776
G1 X122.512 Y122.814 E.01649
G1 X116.141 Y129.186 E.27776
G1 X116.676 Y129.186 E.01649
G1 X123.047 Y122.814 E.27776
G1 X123.582 Y122.814 E.01649
G1 X117.211 Y129.186 E.27776
G1 X117.746 Y129.186 E.01649
G1 X124.117 Y122.814 E.27776
G1 X124.652 Y122.814 E.01649
G1 X118.281 Y129.186 E.27776
G1 X118.816 Y129.186 E.01649
G1 X125.187 Y122.814 E.27776
G1 X125.722 Y122.814 E.01649
G1 X119.351 Y129.186 E.27776
G1 X119.886 Y129.186 E.01649
G1 X126.257 Y122.814 E.27776
G1 X126.792 Y122.814 E.01649
G1 X120.421 Y129.186 E.27776
G1 X120.956 Y129.186 E.01649
G1 X127.327 Y122.814 E.27776
G1 X127.862 Y122.814 E.01649
G1 X121.491 Y129.186 E.27776
G1 X122.026 Y129.186 E.01649
G1 X128.397 Y122.814 E.27776
G1 X128.932 Y122.814 E.01649
G1 X122.561 Y129.186 E.27776
G1 X123.096 Y129.186 E.01649
G1 X129.467 Y122.814 E.27776
G1 X130.002 Y122.814 E.01649
G1 X123.631 Y129.186 E.27776
G1 X124.166 Y129.186 E.01649
G1 X130.537 Y122.814 E.27776
G1 X131.072 Y122.814 E.01649
G1 X124.701 Y129.186 E.27776
G1 X125.236 Y129.186 E.01649
G1 X131.607 Y122.814 E.27776
G1 X132.142 Y122.814 E.01649
G1 X125.771 Y129.186 E.27776
G1 X126.306 Y129.186 E.01649
G1 X132.677 Y122.814 E.27776
G1 X133.212 Y122.814 E.01649
G1 X126.841 Y129.186 E.27776
G1 X127.376 Y129.186 E.01649
G1 X133.747 Y122.814 E.27776
G1 X134.282 Y122.814 E.01649
G1 X127.911 Y129.186 E.27776
G1 X128.446 Y129.186 E.01649
G1 X134.818 Y122.814 E.27776
G1 X135.353 Y122.814 E.01649
G1 X128.982 Y129.186 E.27776
G1 X129.517 Y129.186 E.01649
G1 X135.888 Y122.814 E.27776
G1 X136.423 Y122.814 E.01649
G1 X129.882 Y129.355 E.28516
G1 X135.579 Y121.066 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F15476.087
G2 X134.205 Y120.239 I-2.586 J2.744 E.05362
G1 X132.021 Y122.422 E.10242
G1 X132.542 Y122.422 E.01727
G1 X130.282 Y120.162 E.10604
G1 X126.607 Y120.161 E.12191
G1 X124.345 Y122.422 E.10609
G1 X124.866 Y122.422 E.01727
G1 X122.604 Y120.16 E.10614
G1 X118.933 Y120.159 E.12176
G1 X116.669 Y122.422 E.10619
G1 X117.19 Y122.422 E.01727
G1 X114.925 Y120.158 E.10624
G1 X111.259 Y120.157 E.12162
G1 X108.993 Y122.422 E.10629
G1 X109.514 Y122.422 E.01727
G1 X107.247 Y120.155 E.10635
G1 X105.619 Y120.155 E.05401
G1 X104.209 Y127.207 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.421234
G1 F15000
G1 X104.401 Y127.015 E.00837
G1 X104.379 Y128.107 E.03368
G1 X104.401 Y128.085 E.00097
G1 X104.401 Y128.209 E.00381
G1 X104.609 Y128.412 E.00897
G1 X104.209 Y128.812 E.01744
G1 X105.618 Y131.845 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X107.246 Y131.845 E.05401
G1 X109.514 Y129.578 E.10639
G1 X108.993 Y129.578 E.01727
G1 X111.261 Y131.845 E.10639
G1 X114.922 Y131.845 E.12144
G1 X117.19 Y129.578 E.10639
G1 X116.669 Y129.578 E.01727
G1 X118.937 Y131.845 E.10639
G1 X122.598 Y131.845 E.12144
G1 X124.866 Y129.578 E.10639
G1 X124.345 Y129.578 E.01727
G1 X126.613 Y131.845 E.10639
G1 X130.274 Y131.845 E.12144
G1 X132.542 Y129.578 E.10639
G1 X132.021 Y129.578 E.01727
G1 X134.205 Y131.761 E.10242
G2 X135.579 Y130.934 I-1.211 J-3.571 E.05362
; CHANGE_LAYER
; Z_HEIGHT: 3.4
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F15476.087
G1 X135.238 Y131.259 E-.17899
G1 X134.841 Y131.517 E-.17994
G1 X134.205 Y131.761 E-.25904
G1 X133.94 Y131.497 E-.14203
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 17/101
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L17
M991 S0 P16 ;notify layer change
G17
G3 Z3.6 I-.056 J-1.216 P1  F30000
G1 X104.046 Y132.868 Z3.6
G1 Z3.4
G1 E.8 F1800
; FEATURE: Inner wall
G1 F15476.087
G1 X104.046 Y119.132 E.45568
G1 X133.717 Y119.14 E.98424
G3 X135.948 Y120.107 I-.147 J3.398 E.08251
G3 X136.874 Y121.246 I-5.839 J5.695 E.04875
G3 X138.073 Y123.217 I-11.285 J8.211 E.07658
G1 X138.326 Y123.217 E.0084
G1 X141.955 Y123.217 E.12038
G1 X147.398 Y123.217 E.18057
G1 X152.842 Y123.217 E.18057
G1 X152.842 Y123.227 E.00036
G1 X152.842 Y123.819 E.01961
G2 X152.219 Y124.079 I.913 J3.06 E.02244
G1 X151.222 Y124.789 E.04058
G1 X150.781 Y125.426 E.02572
G1 X150.781 Y126.574 E.0381
G1 X151.222 Y127.211 E.02572
G1 X152.219 Y127.921 E.04058
G2 X152.842 Y128.181 I1.536 J-2.799 E.02244
G1 X152.842 Y128.773 E.01961
G1 X149.213 Y128.783 E.12038
G1 X143.769 Y128.783 E.18057
G1 X138.326 Y128.783 E.18057
G1 X138.073 Y128.783 E.0084
G3 X136.31 Y131.497 I-13.072 J-6.559 E.10755
G3 X134.115 Y132.828 I-2.878 J-2.271 E.08699
G1 X133.609 Y132.868 E.01684
G1 X104.106 Y132.868 E.97869
G1 X103.654 Y133.11 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
G1 X103.654 Y119.69 E.41235
G1 X103.654 Y119.29 E.01229
G1 F7127.265
G1 X103.654 Y118.89 E.01229
G1 F2160
G1 X103.654 Y118.739 E.00463
G1 X133.748 Y118.749 E.92472
G1 X134.178 Y118.784 E.01324
G1 F2280
G1 X134.716 Y118.914 E.01702
G1 F2400
G3 X136.222 Y119.826 I-1.414 J4.037 E.0545
G1 F2640
G3 X137.192 Y121.016 I-6.169 J6.016 E.04721
G1 F2520
G1 X137.449 Y121.383 E.01377
G1 F2400
G1 X137.721 Y121.792 E.01509
G1 F2160
G3 X138.314 Y122.824 I-6.855 J4.624 E.03663
G1 F3000
G1 X138.557 Y122.824 E.00745
; FEATURE: Overhang wall
; LINE_WIDTH: 0.45

G1 X153.234 Y122.824 E.48686
G1 X153.234 Y122.845 E.00068
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F8060.209
G1 X153.234 Y123.214 E.01134
G1 F12000
G1 X153.234 Y123.614 E.01229
G1 X153.234 Y127.986 E.13435
G1 X153.234 Y128.386 E.01229
G1 F8596.922
G1 X153.234 Y128.786 E.01229
G1 F3000
G1 X153.234 Y129.155 E.01134
; FEATURE: Overhang wall
; LINE_WIDTH: 0.45

G1 X153.234 Y129.176 E.00068
G1 X138.557 Y129.176 E.48686
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2160
G1 X138.314 Y129.176 E.00745
G3 X138.138 Y129.519 I-3.262 J-1.459 E.01187
G1 F2400
G1 X137.721 Y130.208 E.02475
G1 F2520
G1 X137.449 Y130.617 E.01509
G1 F2640
G3 X136.607 Y131.754 I-22.887 J-16.076 E.04348
G1 F2400
G3 X135.242 Y132.869 I-3.259 J-2.597 E.05457
G1 F2280
G1 X134.716 Y133.086 E.01747
G1 F2160
G3 X133.625 Y133.261 I-1.094 J-3.332 E.03409
G1 X103.654 Y133.261 E.92094
G1 F3033.699
G1 X103.654 Y133.17 E.00279
M204 S10000
; WIPE_START
G1 X103.654 Y131.17 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z3.8 I-.922 J.794 P1  F30000
G1 X104.975 Y132.705 Z3.8
G1 Z3.4
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.421804
G1 F15000
G1 X104.72 Y132.45 E.01114
G1 X105.256 Y132.45 E.01654
G1 X105.341 Y132.535 E.00373
G1 X105.877 Y132.535 E.01654
G1 X105.792 Y132.45 E.00373
G1 X106.328 Y132.45 E.01654
G1 X106.413 Y132.535 E.00373
G1 X106.949 Y132.535 E.01654
G1 X106.863 Y132.45 E.00373
G1 X107.399 Y132.45 E.01654
G1 X107.485 Y132.535 E.00373
G1 X108.021 Y132.535 E.01654
G1 X107.935 Y132.45 E.00373
G1 X108.471 Y132.45 E.01654
G1 X108.556 Y132.535 E.00373
G1 X109.092 Y132.535 E.01654
G1 X109.007 Y132.45 E.00373
G1 X109.543 Y132.45 E.01654
G1 X109.628 Y132.535 E.00373
G1 X110.164 Y132.535 E.01654
G1 X110.078 Y132.45 E.00373
G1 X110.614 Y132.45 E.01654
G1 X110.7 Y132.535 E.00373
G1 X111.236 Y132.535 E.01654
G1 X111.15 Y132.45 E.00373
G1 X111.686 Y132.45 E.01654
G1 X111.771 Y132.535 E.00373
G1 X112.307 Y132.535 E.01654
G1 X112.222 Y132.45 E.00373
G1 X112.758 Y132.45 E.01654
G1 X112.843 Y132.535 E.00373
G1 X113.379 Y132.535 E.01654
G1 X113.293 Y132.45 E.00373
G1 X113.829 Y132.45 E.01654
G1 X113.915 Y132.535 E.00373
G1 X114.45 Y132.535 E.01654
G1 X114.365 Y132.45 E.00373
G1 X114.901 Y132.45 E.01654
G1 X114.986 Y132.535 E.00373
G1 X115.522 Y132.535 E.01654
G1 X115.437 Y132.45 E.00373
G1 X115.972 Y132.45 E.01654
G1 X116.058 Y132.535 E.00373
G1 X116.594 Y132.535 E.01654
G1 X116.508 Y132.45 E.00373
G1 X117.044 Y132.45 E.01654
G1 X117.13 Y132.535 E.00373
M73 P46 R10
G1 X117.665 Y132.535 E.01654
G1 X117.58 Y132.45 E.00373
G1 X118.116 Y132.45 E.01654
G1 X118.201 Y132.535 E.00373
G1 X118.737 Y132.535 E.01654
G1 X118.652 Y132.45 E.00373
G1 X119.187 Y132.45 E.01654
G1 X119.273 Y132.535 E.00373
G1 X119.809 Y132.535 E.01654
G1 X119.723 Y132.45 E.00373
G1 X120.259 Y132.45 E.01654
G1 X120.345 Y132.535 E.00373
G1 X120.88 Y132.535 E.01654
G1 X120.795 Y132.45 E.00373
G1 X121.331 Y132.45 E.01654
G1 X121.416 Y132.535 E.00373
G1 X121.952 Y132.535 E.01654
G1 X121.867 Y132.45 E.00373
G1 X122.402 Y132.45 E.01654
G1 X122.488 Y132.535 E.00373
G1 X123.024 Y132.535 E.01654
G1 X122.938 Y132.45 E.00373
G1 X123.474 Y132.45 E.01654
G1 X123.559 Y132.535 E.00373
G1 X124.095 Y132.535 E.01654
G1 X124.01 Y132.45 E.00373
G1 X124.546 Y132.45 E.01654
G1 X124.631 Y132.535 E.00373
G1 X125.167 Y132.535 E.01654
G1 X125.081 Y132.45 E.00373
G1 X125.617 Y132.45 E.01654
G1 X125.703 Y132.535 E.00373
G1 X126.239 Y132.535 E.01654
G1 X126.153 Y132.45 E.00373
G1 X126.689 Y132.45 E.01654
G1 X126.774 Y132.535 E.00373
G1 X127.31 Y132.535 E.01654
G1 X127.225 Y132.45 E.00373
G1 X127.761 Y132.45 E.01654
G1 X127.846 Y132.535 E.00373
G1 X128.382 Y132.535 E.01654
G1 X128.296 Y132.45 E.00373
G1 X128.832 Y132.45 E.01654
G1 X128.918 Y132.535 E.00373
G1 X129.454 Y132.535 E.01654
G1 X129.368 Y132.45 E.00373
G1 X129.904 Y132.45 E.01654
G1 X129.989 Y132.535 E.00373
G1 X130.525 Y132.535 E.01654
G1 X130.44 Y132.45 E.00373
G1 X130.976 Y132.45 E.01654
G1 X131.061 Y132.535 E.00373
G1 X131.597 Y132.535 E.01654
G1 X131.511 Y132.45 E.00373
G1 X132.047 Y132.45 E.01654
G1 X132.133 Y132.535 E.00373
G1 X132.668 Y132.535 E.01654
G1 X132.583 Y132.45 E.00373
G1 X133.119 Y132.45 E.01654
G1 X133.204 Y132.535 E.00373
G2 X133.729 Y132.524 I.196 J-3.279 E.01623
G1 X133.651 Y132.446 E.00342
G2 X134.122 Y132.406 I-.012 J-2.933 E.01462
G1 X134.142 Y132.401 E.00063
G1 X134.204 Y132.463 E.00271
G2 X134.618 Y132.341 I-.189 J-1.405 E.01337
G1 X134.571 Y132.294 E.00206
G2 X134.941 Y132.129 I-.721 J-2.115 E.01254
G1 X134.988 Y132.176 E.00204
G1 X135.324 Y131.976 E.01207
G1 X135.277 Y131.929 E.00207
G2 X135.588 Y131.704 I-.705 J-1.304 E.01188
G1 X135.618 Y131.734 E.00131
G2 X135.885 Y131.465 I-.8 J-1.063 E.01174
G1 X135.875 Y131.455 E.00045
G2 X136.122 Y131.167 I-.868 J-.996 E.01177
G1 X136.257 Y131.301 E.00587
G1 X135.718 Y131.042 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F15476.087
G3 X134.382 Y131.938 I-2.46 J-2.223 E.0539
G1 X132.021 Y129.578 E.11075
G1 X132.542 Y129.578 E.01728
G1 X130.062 Y132.058 E.11634
G1 X126.825 Y132.058 E.10737
G1 X124.345 Y129.578 E.11634
G1 X124.866 Y129.578 E.01728
G1 X122.386 Y132.058 E.11634
G1 X119.149 Y132.058 E.10737
G1 X116.669 Y129.578 E.11634
G1 X117.19 Y129.578 E.01728
G1 X114.71 Y132.058 E.11634
G1 X111.473 Y132.058 E.10737
G1 X108.993 Y129.578 E.11634
G1 X109.514 Y129.578 E.01728
G1 X107.034 Y132.058 E.11634
G1 X105.406 Y132.058 E.05401
G1 X104.841 Y129.355 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.421804
G1 F15000
G1 X104.379 Y128.894 E.02015
G1 X104.379 Y128.358 E.01654
G1 X105.207 Y129.186 E.03614
G1 X105.743 Y129.186 E.01654
G1 X104.379 Y127.822 E.05953
G1 X104.379 Y127.286 E.01654
G1 X106.278 Y129.186 E.08293
G1 X106.814 Y129.186 E.01654
G1 X104.379 Y126.75 E.10632
G1 X104.379 Y126.215 E.01654
G1 X107.35 Y129.186 E.12972
G1 X107.886 Y129.186 E.01654
G1 X104.379 Y125.679 E.15312
G1 X104.379 Y125.143 E.01654
G1 X108.422 Y129.186 E.17651
G1 X108.958 Y129.186 E.01654
G1 X104.379 Y124.607 E.19991
G1 X104.379 Y124.071 E.01654
G1 X109.493 Y129.186 E.2233
G1 X110.029 Y129.186 E.01654
G1 X104.379 Y123.535 E.2467
G1 X104.379 Y123 E.01654
G1 X110.565 Y129.186 E.27009
G1 X111.101 Y129.186 E.01654
G1 X104.73 Y122.814 E.27818
G1 X105.266 Y122.814 E.01654
G1 X111.637 Y129.186 E.27818
G1 X112.172 Y129.186 E.01654
G1 X105.801 Y122.814 E.27818
G1 X106.337 Y122.814 E.01654
G1 X112.708 Y129.186 E.27818
G1 X113.244 Y129.186 E.01654
G1 X106.873 Y122.814 E.27818
G1 X107.409 Y122.814 E.01654
G1 X113.78 Y129.186 E.27818
G1 X114.316 Y129.186 E.01654
G1 X107.945 Y122.814 E.27818
G1 X108.481 Y122.814 E.01654
G1 X114.852 Y129.186 E.27818
G1 X115.387 Y129.186 E.01654
G1 X109.016 Y122.814 E.27818
G1 X109.552 Y122.814 E.01654
G1 X115.923 Y129.186 E.27818
G1 X116.459 Y129.186 E.01654
G1 X110.088 Y122.814 E.27818
G1 X110.624 Y122.814 E.01654
G1 X116.995 Y129.186 E.27818
G1 X117.531 Y129.186 E.01654
G1 X111.16 Y122.814 E.27818
G1 X111.695 Y122.814 E.01654
G1 X118.066 Y129.186 E.27818
G1 X118.602 Y129.186 E.01654
G1 X112.231 Y122.814 E.27818
G1 X112.767 Y122.814 E.01654
G1 X119.138 Y129.186 E.27818
G1 X119.674 Y129.186 E.01654
G1 X113.303 Y122.814 E.27818
G1 X113.839 Y122.814 E.01654
G1 X120.21 Y129.186 E.27818
G1 X120.746 Y129.186 E.01654
G1 X114.375 Y122.814 E.27818
G1 X114.91 Y122.814 E.01654
G1 X121.281 Y129.186 E.27818
G1 X121.817 Y129.186 E.01654
G1 X115.446 Y122.814 E.27818
G1 X115.982 Y122.814 E.01654
G1 X122.353 Y129.186 E.27818
G1 X122.889 Y129.186 E.01654
G1 X116.518 Y122.814 E.27818
G1 X117.054 Y122.814 E.01654
G1 X123.425 Y129.186 E.27818
G1 X123.961 Y129.186 E.01654
G1 X117.59 Y122.814 E.27818
G1 X118.125 Y122.814 E.01654
G1 X124.496 Y129.186 E.27818
G1 X125.032 Y129.186 E.01654
G1 X118.661 Y122.814 E.27818
G1 X119.197 Y122.814 E.01654
G1 X125.568 Y129.186 E.27818
G1 X126.104 Y129.186 E.01654
G1 X119.733 Y122.814 E.27818
G1 X120.269 Y122.814 E.01654
G1 X126.64 Y129.186 E.27818
G1 X127.175 Y129.186 E.01654
G1 X120.804 Y122.814 E.27818
G1 X121.34 Y122.814 E.01654
G1 X127.711 Y129.186 E.27818
G1 X128.247 Y129.186 E.01654
G1 X121.876 Y122.814 E.27818
G1 X122.412 Y122.814 E.01654
G1 X128.783 Y129.186 E.27818
G1 X129.319 Y129.186 E.01654
G1 X122.948 Y122.814 E.27818
G1 X123.484 Y122.814 E.01654
G1 X129.855 Y129.186 E.27818
G1 X130.39 Y129.186 E.01654
G1 X124.019 Y122.814 E.27818
G1 X124.555 Y122.814 E.01654
G1 X130.926 Y129.186 E.27818
G1 X131.462 Y129.186 E.01654
G1 X125.091 Y122.814 E.27818
G1 X125.627 Y122.814 E.01654
G1 X131.998 Y129.186 E.27818
G1 X132.534 Y129.186 E.01654
G1 X126.163 Y122.814 E.27818
G1 X126.699 Y122.814 E.01654
G1 X133.07 Y129.186 E.27818
G1 X133.605 Y129.186 E.01654
G1 X127.234 Y122.814 E.27818
G1 X127.77 Y122.814 E.01654
G1 X134.141 Y129.186 E.27818
G1 X134.677 Y129.186 E.01654
G1 X128.306 Y122.814 E.27818
G1 X128.842 Y122.814 E.01654
G1 X135.213 Y129.186 E.27818
G1 X135.749 Y129.186 E.01654
G1 X129.378 Y122.814 E.27818
G1 X129.913 Y122.814 E.01654
G1 X136.454 Y129.355 E.28558
G1 X136.454 Y130.427 F30000
G1 F15000
G1 X136.589 Y130.562 E.0059
G1 X136.816 Y130.253 E.01183
G1 X136.791 Y130.228 E.00111
G1 X136.998 Y129.899 E.012
G1 X137.033 Y129.934 E.00153
G2 X137.239 Y129.604 I-3.679 J-2.531 E.01201
G1 X130.449 Y122.814 E.29645
G1 X130.985 Y122.814 E.01654
G1 X137.441 Y129.27 E.28187
G2 X137.628 Y128.922 I-2.27 J-1.448 E.01222
G1 X131.521 Y122.814 E.26667
G1 X132.057 Y122.814 E.01654
G1 X137.809 Y128.567 E.25115
G1 X137.868 Y128.45 E.00403
G1 X138.228 Y128.45 E.01112
G1 X132.593 Y122.814 E.24607
G1 X133.128 Y122.814 E.01654
G1 X138.764 Y128.45 E.24607
G1 X139.3 Y128.45 E.01654
G1 X133.664 Y122.814 E.24607
G1 X134.2 Y122.814 E.01654
G1 X139.836 Y128.45 E.24607
G1 X140.372 Y128.45 E.01654
G1 X134.736 Y122.814 E.24607
G1 X135.272 Y122.814 E.01654
G1 X140.907 Y128.45 E.24607
G1 X141.443 Y128.45 E.01654
G1 X135.808 Y122.814 E.24607
G1 X136.343 Y122.814 E.01654
G1 X141.979 Y128.45 E.24607
G1 X142.515 Y128.45 E.01654
G1 X136.879 Y122.814 E.24607
G1 X137.012 Y122.814 E.00411
G1 X137.16 Y122.56 E.0091
G1 X137.576 Y122.976 E.01818
G1 X137.868 Y123.55 E.01987
G1 X138.15 Y123.55 E.00871
G1 X143.051 Y128.45 E.21397
G1 X143.587 Y128.45 E.01654
G1 X138.686 Y123.55 E.21397
G1 X139.222 Y123.55 E.01654
G1 X144.122 Y128.45 E.21397
G1 X144.658 Y128.45 E.01654
G1 X139.758 Y123.55 E.21397
G1 X140.294 Y123.55 E.01654
G1 X145.194 Y128.45 E.21397
G1 X145.73 Y128.45 E.01654
G1 X140.829 Y123.55 E.21397
G1 X141.365 Y123.55 E.01654
G1 X146.266 Y128.45 E.21397
G1 X146.801 Y128.45 E.01654
G1 X141.901 Y123.55 E.21397
G1 X142.437 Y123.55 E.01654
G1 X147.337 Y128.45 E.21397
G1 X147.873 Y128.45 E.01654
G1 X142.973 Y123.55 E.21397
G1 X143.509 Y123.55 E.01654
G1 X148.409 Y128.45 E.21397
G1 X148.945 Y128.45 E.01654
G1 X144.044 Y123.55 E.21397
G1 X144.58 Y123.55 E.01654
G1 X149.481 Y128.45 E.21397
G1 X150.016 Y128.45 E.01654
G1 X145.116 Y123.55 E.21397
G1 X145.652 Y123.55 E.01654
G1 X150.552 Y128.45 E.21397
G1 X151.088 Y128.45 E.01654
G1 X146.188 Y123.55 E.21397
G1 X146.723 Y123.55 E.01654
G1 X151.624 Y128.45 E.21397
G1 X152.16 Y128.45 E.01654
G1 X147.259 Y123.55 E.21397
G1 X147.795 Y123.55 E.01654
G1 X150.448 Y126.202 E.11581
G1 X150.448 Y125.666 E.01654
G1 X148.331 Y123.55 E.09242
G1 X148.867 Y123.55 E.01654
G1 X150.526 Y125.209 E.07244
G1 X150.745 Y124.892 E.01189
G1 X149.403 Y123.55 E.05862
G1 X149.938 Y123.55 E.01654
G1 X150.964 Y124.576 E.0448
G1 X151.27 Y124.346 E.01181
G1 X150.474 Y123.55 E.03474
G1 X151.01 Y123.55 E.01654
G1 X151.583 Y124.123 E.02501
G1 X151.896 Y123.9 E.01186
G1 X151.546 Y123.55 E.01528
G1 X152.082 Y123.55 E.01654
G1 X152.361 Y123.829 E.01218
G1 X153.026 Y124.719 F30000
M204 S2000
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F12000
G1 X152.498 Y124.191 E.02295
G1 X152.165 Y124.391
G1 X153.026 Y125.252 E.03745
G1 X153.026 Y125.786
G1 X151.853 Y124.612 E.05098
G1 X151.542 Y124.834
G1 X153.026 Y126.319 E.06452
G1 X153.026 Y126.852
G1 X151.276 Y125.102 E.07607
G1 X151.058 Y125.417
G1 X153.026 Y127.385 E.08555
G1 X153.026 Y127.919
G1 X151.003 Y125.896 E.08792
G1 X151.003 Y126.429
G1 X152.231 Y127.657 E.05336
M204 S10000
G1 X151.432 Y124.915 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.0913662
G1 F15000
G2 X151.349 Y125 I.202 J.281 E.00047
; WIPE_START
G1 X151.432 Y124.915 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z3.8 I-1.119 J.479 P1  F30000
G1 X152.715 Y127.908 Z3.8
G1 Z3.4
G1 E.8 F1800
; LINE_WIDTH: 0.157028
G1 F15000
G1 X152.543 Y127.786 E.00196
; LINE_WIDTH: 0.206881
G1 X152.371 Y127.664 E.00282
; LINE_WIDTH: 0.232519
G1 X152.292 Y127.596 E.00161
; WIPE_START
G1 X152.371 Y127.664 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X145.202 Y125.045 Z3.8 F30000
G1 X137.292 Y122.155 Z3.8
G1 Z3.4
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.421804
G1 F15000
G1 X134.916 Y119.782 E.10367
G2 X134.116 Y119.515 I-1.266 J2.468 E.02616
G1 X134.218 Y119.617 E.00446
G2 X134.094 Y119.589 I-.235 J.749 E.00391
G1 X133.616 Y119.551 E.01483
G1 X133.538 Y119.473 E.00338
G1 X133.002 Y119.473 E.01655
G1 X133.079 Y119.55 E.00337
G1 X132.543 Y119.55 E.01654
G1 X132.466 Y119.473 E.00337
G1 X131.93 Y119.473 E.01655
G1 X132.007 Y119.55 E.00338
G1 X131.472 Y119.55 E.01654
G1 X131.394 Y119.473 E.00339
G1 X130.858 Y119.473 E.01655
G1 X130.936 Y119.55 E.00339
G1 X130.4 Y119.55 E.01654
G1 X130.322 Y119.472 E.0034
G1 X129.786 Y119.472 E.01655
G1 X129.864 Y119.55 E.00341
G1 X129.328 Y119.55 E.01654
G1 X129.25 Y119.472 E.00341
G1 X128.714 Y119.472 E.01655
G1 X128.793 Y119.55 E.00342
G1 X128.257 Y119.55 E.01654
G1 X128.178 Y119.472 E.00343
G1 X127.642 Y119.472 E.01655
G1 X127.721 Y119.55 E.00343
G1 X127.185 Y119.55 E.01654
G1 X127.106 Y119.472 E.00344
G1 X126.57 Y119.471 E.01655
G1 X126.649 Y119.55 E.00345
G1 X126.113 Y119.55 E.01654
G1 X126.034 Y119.471 E.00345
G1 X125.498 Y119.471 E.01655
G1 X125.578 Y119.55 E.00346
G1 X125.042 Y119.55 E.01654
G1 X124.962 Y119.471 E.00347
G1 X124.426 Y119.471 E.01655
G1 X124.506 Y119.55 E.00347
G1 X123.97 Y119.55 E.01654
G1 X123.89 Y119.471 E.00348
G1 X123.354 Y119.47 E.01655
G1 X123.434 Y119.55 E.00349
G1 X122.899 Y119.55 E.01654
G1 X122.818 Y119.47 E.00349
G1 X122.282 Y119.47 E.01655
G1 X122.363 Y119.55 E.0035
G1 X121.827 Y119.55 E.01654
G1 X121.747 Y119.47 E.00351
G1 X121.211 Y119.47 E.01655
G1 X121.291 Y119.55 E.00351
G1 X120.755 Y119.55 E.01654
G1 X120.675 Y119.47 E.00352
G1 X120.139 Y119.469 E.01655
G1 X120.219 Y119.55 E.00353
G1 X119.684 Y119.55 E.01654
G1 X119.603 Y119.469 E.00353
G1 X119.067 Y119.469 E.01655
G1 X119.148 Y119.55 E.00354
G1 X118.612 Y119.55 E.01654
G1 X118.531 Y119.469 E.00355
G1 X117.995 Y119.469 E.01655
G1 X118.076 Y119.55 E.00356
G1 X117.54 Y119.55 E.01654
G1 X117.459 Y119.469 E.00356
G1 X116.923 Y119.469 E.01655
G1 X117.004 Y119.55 E.00357
G1 X116.469 Y119.55 E.01654
G1 X116.387 Y119.468 E.00358
G1 X115.851 Y119.468 E.01655
G1 X115.933 Y119.55 E.00358
G1 X115.397 Y119.55 E.01654
G1 X115.315 Y119.468 E.00359
G1 X114.779 Y119.468 E.01655
G1 X114.861 Y119.55 E.0036
G1 X114.325 Y119.55 E.01654
G1 X114.243 Y119.468 E.0036
G1 X113.707 Y119.468 E.01655
G1 X113.79 Y119.55 E.00361
G1 X113.254 Y119.55 E.01654
G1 X113.171 Y119.467 E.00362
G1 X112.635 Y119.467 E.01655
G1 X112.718 Y119.55 E.00362
G1 X112.182 Y119.55 E.01654
G1 X112.099 Y119.467 E.00363
G1 X111.563 Y119.467 E.01655
G1 X111.646 Y119.55 E.00364
G1 X111.11 Y119.55 E.01654
G1 X111.027 Y119.467 E.00364
G1 X110.491 Y119.467 E.01655
G1 X110.575 Y119.55 E.00365
G1 X110.039 Y119.55 E.01654
G1 X109.955 Y119.467 E.00366
G1 X109.419 Y119.466 E.01655
G1 X109.503 Y119.55 E.00366
G1 X108.967 Y119.55 E.01654
M73 P47 R10
G1 X108.883 Y119.466 E.00367
G1 X108.347 Y119.466 E.01655
G1 X108.431 Y119.55 E.00368
G1 X107.895 Y119.55 E.01654
G1 X107.811 Y119.466 E.00368
G1 X107.275 Y119.466 E.01655
G1 X107.36 Y119.55 E.00369
G1 X106.824 Y119.55 E.01654
G1 X106.739 Y119.466 E.0037
G1 X106.203 Y119.465 E.01655
G1 X106.288 Y119.55 E.0037
G1 X105.752 Y119.55 E.01654
G1 X105.667 Y119.465 E.00371
G1 X105.131 Y119.465 E.01655
G1 X105.216 Y119.55 E.00372
G1 X104.681 Y119.55 E.01654
G1 X104.425 Y119.295 E.01114
G1 X105.406 Y119.942 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X107.034 Y119.942 E.05401
G1 X109.514 Y122.422 E.11634
G1 X108.993 Y122.422 E.01728
G1 X111.473 Y119.942 E.11634
G1 X114.71 Y119.942 E.10737
G1 X117.19 Y122.422 E.11634
G1 X116.669 Y122.422 E.01728
G1 X119.149 Y119.942 E.11634
G1 X122.386 Y119.942 E.10737
G1 X124.866 Y122.422 E.11634
G1 X124.345 Y122.422 E.01728
G1 X126.825 Y119.942 E.11634
G1 X130.062 Y119.942 E.10737
G1 X132.542 Y122.422 E.11634
G1 X132.021 Y122.422 E.01728
G1 X134.382 Y120.062 E.11075
G3 X135.717 Y120.959 I-1.117 J3.105 E.0539
; CHANGE_LAYER
; Z_HEIGHT: 3.6
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F15476.087
G1 X135.247 Y120.519 E-.24468
G1 X134.841 Y120.256 E-.18371
G1 X134.382 Y120.062 E-.18942
G1 X134.118 Y120.326 E-.14218
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 18/101
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L18
M991 S0 P17 ;notify layer change
G17
G3 Z3.8 I-.535 J1.093 P1  F30000
G1 X149.945 Y128.065 Z3.8
G1 Z3.6
G1 E.8 F1800
; FEATURE: Inner wall
G1 F15476.087
G1 X150.239 Y128.206 E.01082
G2 X152.583 Y128.941 I6.154 J-15.529 E.08159
G1 X152.558 Y129.157 E.0072
G1 X138.104 Y129.157 E.47946
G3 X135.968 Y132.085 I-13.674 J-7.734 E.12049
G3 X134.12 Y133.013 I-2.525 J-2.725 E.0695
G1 X133.611 Y133.05 E.01694
G1 X104.046 Y133.05 E.98073
G1 X104.046 Y118.95 E.46775
G1 X133.611 Y118.95 E.98073
G1 X134.12 Y118.987 E.01694
G3 X135.968 Y119.915 I-.678 J3.653 E.0695
G3 X137.493 Y121.853 I-9.797 J9.278 E.08191
G1 X137.586 Y121.993 E.00559
G3 X138.104 Y122.843 I-9.493 J6.37 E.03303
G1 X152.558 Y122.843 E.47946
G1 X152.583 Y123.059 E.0072
G2 X149.195 Y124.297 I2.946 J13.313 E.12003
G1 X148.736 Y124.624 E.0187
G1 X147.783 Y126 E.05552
G1 X148.736 Y127.376 E.05552
G1 X149.195 Y127.703 E.0187
G1 X149.891 Y128.038 E.02563
; WIPE_START
G1 X150.239 Y128.206 E-.1468
G1 X151.383 Y128.616 E-.46206
G1 X151.765 Y128.728 E-.15114
; WIPE_END
G1 E-.04 F1800
G1 X151.649 Y126.303 Z4 F30000
G1 Z3.6
G1 E.8 F1800
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
G1 X151.849 Y126.593 E.01082
G1 X152.662 Y127.171 E.03067
G2 X153.234 Y127.4 I1.361 J-2.574 E.01895
G1 X153.234 Y128.017 E.01894
G1 X153.234 Y128.417 E.01229
G1 F10078.064
G1 X153.234 Y128.817 E.01229
G1 F3899.032
G1 X153.234 Y129.217 E.01229
G1 F600
G1 X153.234 Y129.549 E.01021
G1 X152.302 Y129.549 E.02863
G1 X151.37 Y129.549 E.02863
G1 X150.438 Y129.549 E.02863
G1 X149.507 Y129.549 E.02863
G1 X148.575 Y129.549 E.02863
G1 F720
G1 X147.643 Y129.549 E.02863
G1 F960
G1 X146.711 Y129.549 E.02863
G1 F1080
G1 X145.78 Y129.549 E.02863
G1 F1200
G1 X144.848 Y129.549 E.02863
G1 F1440
G1 X143.916 Y129.549 E.02863
G1 F1560
G1 X142.984 Y129.549 E.02863
G1 F1680
G1 X142.052 Y129.549 E.02863
G1 F1920
G1 X141.121 Y129.549 E.02863
G1 F2040
G1 X140.189 Y129.549 E.02863
G1 F2160
G1 X139.257 Y129.549 E.02863
G1 F2400
G1 X138.325 Y129.549 E.02863
G1 X137.965 Y130.145 E.0214
G1 F2520
G1 X137.817 Y130.368 E.00824
G1 F2640
G1 X137.438 Y130.909 E.02029
G1 F2760
G3 X136.303 Y132.304 I-10.26 J-7.185 E.05532
G1 F2640
G1 X136.229 Y132.378 E.00319
G1 F2520
G1 X135.748 Y132.76 E.01889
G1 F2400
G1 X135.242 Y133.061 E.0181
G1 F2280
G3 X133.626 Y133.443 I-1.693 J-3.555 E.0514
G1 X103.654 Y133.443 E.92095
G1 F3736.048
G1 X103.654 Y133.302 E.00433
G1 F9814.974
G1 X103.654 Y132.902 E.01229
G1 F12000
G1 X103.654 Y132.502 E.01229
G1 X103.654 Y119.498 E.39955
G1 X103.654 Y119.098 E.01229
G1 F7343.921
G1 X103.654 Y118.698 E.01229
G1 F2280
G1 X103.654 Y118.557 E.00433
G1 X133.626 Y118.557 E.92095
G1 X134.158 Y118.597 E.0164
G1 X134.717 Y118.723 E.01761
G1 F2400
G1 X135.242 Y118.939 E.01743
G1 F2520
G1 X135.748 Y119.24 E.0181
G1 F2640
G1 X136.229 Y119.622 E.01889
G1 F2760
G3 X136.922 Y120.406 I-13.704 J12.802 E.03214
G1 F2640
G1 X137.438 Y121.091 E.02635
G1 F2520
G1 X137.817 Y121.632 E.02029
G1 F2400
G3 X138.325 Y122.451 I-9.146 J6.248 E.02964
G1 F2160
G1 X139.257 Y122.451 E.02863
G1 F2040
G1 X140.189 Y122.451 E.02863
G1 F1920
G1 X141.121 Y122.451 E.02863
G1 F1680
G1 X142.052 Y122.451 E.02863
G1 F1560
G1 X142.984 Y122.451 E.02863
G1 F1440
G1 X143.916 Y122.451 E.02863
G1 F1200
G1 X144.848 Y122.451 E.02863
G1 F1080
G1 X145.78 Y122.451 E.02863
G1 F960
G1 X146.711 Y122.451 E.02863
G1 F720
G1 X147.643 Y122.451 E.02863
G1 F600
G1 X148.575 Y122.451 E.02863
G1 X149.507 Y122.451 E.02863
G1 X150.438 Y122.451 E.02863
G1 X151.37 Y122.451 E.02863
G1 X152.302 Y122.451 E.02863
G1 X153.234 Y122.451 E.02863
G1 F3137.286
G1 X153.234 Y122.783 E.01021
G1 F8828.259
G1 X153.234 Y123.183 E.01229
G1 F12000
G1 X153.234 Y123.583 E.01229
G1 X153.234 Y124.6 E.03124
G2 X152.662 Y124.829 I.789 J2.802 E.01895
G1 X151.849 Y125.407 E.03067
G1 X151.649 Y125.697 E.01082
G1 X151.649 Y126.243 E.01678
M204 S10000
; WIPE_START
G1 X151.849 Y126.593 E-.15316
G1 X152.662 Y127.171 E-.37926
G1 X152.854 Y127.264 E-.081
G1 X153.217 Y127.394 E-.14659
; WIPE_END
G1 E-.04 F1800
G17
G3 Z4 I-.692 J-1.001 P1  F30000
G1 X151.115 Y128.848 Z4
G1 Z3.6
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.215363
G1 F15000
G1 X151.296 Y128.879 E.00257
; LINE_WIDTH: 0.166581
G1 X151.475 Y128.905 E.00182
; LINE_WIDTH: 0.119945
G1 X151.649 Y128.93 E.00111
G1 X151.115 Y128.848 F30000
; LINE_WIDTH: 0.265261
G1 F15000
G1 X150.935 Y128.817 E.00332
; LINE_WIDTH: 0.315159
G1 X150.754 Y128.785 E.00406
; LINE_WIDTH: 0.365056
G1 X150.574 Y128.754 E.00481
; LINE_WIDTH: 0.414954
G1 X150.393 Y128.723 E.00555
; LINE_WIDTH: 0.464852
G1 F14931.334
G1 X150.213 Y128.691 E.0063
G1 X149.225 Y128.993 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.421886
G1 F15000
G1 X149.836 Y128.382 E.02668
G1 X149.475 Y128.208 E.01239
G1 X148.859 Y128.823 E.02689
G1 X148.323 Y128.823 E.01655
G1 X149.113 Y128.033 E.03451
G3 X148.788 Y127.822 I.456 J-1.057 E.01202
G1 X147.787 Y128.823 E.04372
G1 X147.251 Y128.823 E.01655
G1 X148.481 Y127.593 E.05372
G1 X148.262 Y127.277 E.01189
G1 X146.715 Y128.823 E.06754
G1 X146.179 Y128.823 E.01655
G1 X148.043 Y126.96 E.08137
G1 X147.823 Y126.644 E.01189
G1 X145.644 Y128.823 E.09519
G1 X145.108 Y128.823 E.01655
G1 X147.604 Y126.327 E.10902
G1 X147.384 Y126.011 E.01189
G1 X144.572 Y128.823 E.12284
G1 X144.036 Y128.823 E.01655
G1 X149.683 Y123.177 E.24661
G1 X149.852 Y123.177 E.00523
G1 X149.906 Y123.489 E.00979
G1 X149.358 Y124.037 E.02394
G1 X150.213 Y123.309 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.464851
G1 F14931.355
G1 X150.393 Y123.277 E.0063
; LINE_WIDTH: 0.414953
G1 F15000
G1 X150.574 Y123.246 E.00555
; LINE_WIDTH: 0.365055
G1 X150.754 Y123.215 E.00481
; LINE_WIDTH: 0.315156
G1 X150.935 Y123.183 E.00406
; LINE_WIDTH: 0.265258
G1 X151.115 Y123.152 E.00332
; LINE_WIDTH: 0.21536
G1 X151.296 Y123.121 E.00257
; LINE_WIDTH: 0.166579
G1 X151.475 Y123.095 E.00182
; LINE_WIDTH: 0.119945
G1 X151.649 Y123.07 E.00111
; WIPE_START
G1 X151.475 Y123.095 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z4 I-1.191 J.248 P1  F30000
G1 X152.646 Y128.728 Z4
G1 Z3.6
G1 E.8 F1800
M204 S2000
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F12000
G1 X153.026 Y128.347 E.01652
G1 X153.026 Y127.814
G1 X152.216 Y128.624 E.03519
G1 X151.801 Y128.506
G1 X152.831 Y127.476 E.04477
G1 X152.479 Y127.295
G1 X151.391 Y128.383 E.04726
G1 X150.998 Y128.242
G1 X152.167 Y127.074 E.05079
G1 X151.856 Y126.852
G1 X150.606 Y128.102 E.05431
G1 X150.223 Y127.952
G1 X151.591 Y126.584 E.05945
G1 X151.441 Y126.2
G1 X149.863 Y127.778 E.06859
G1 X149.503 Y127.604
G1 X151.441 Y125.666 E.08421
G1 X152.216 Y124.892
G1 X153.026 Y124.081 E.03522
G1 X153.026 Y123.548
G1 X149.166 Y127.409 E.16776
G1 X148.867 Y127.174
G1 X152.808 Y123.234 E.17125
G1 X152.102 Y123.406
G1 X148.649 Y126.859 E.15008
G1 X148.43 Y126.544
G1 X151.339 Y123.636 E.12638
G1 X150.508 Y123.933
G1 X148.212 Y126.229 E.09977
M204 S10000
G1 X149.985 Y124.163 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.112505
G1 F15000
G1 X149.863 Y124.25 E.00085
; LINE_WIDTH: 0.161177
G1 X149.74 Y124.337 E.00145
; LINE_WIDTH: 0.209848
G1 X149.618 Y124.424 E.00204
; LINE_WIDTH: 0.25852
G1 X149.495 Y124.511 E.00264
; LINE_WIDTH: 0.307192
G1 X149.373 Y124.598 E.00323
; LINE_WIDTH: 0.351006
G1 X149.194 Y124.749 E.00588
; LINE_WIDTH: 0.389966
G1 X149.015 Y124.9 E.00662
; LINE_WIDTH: 0.388053
G1 X148.856 Y125.091 E.00698
; LINE_WIDTH: 0.345269
G1 X148.697 Y125.281 E.00612
; LINE_WIDTH: 0.302485
G1 X148.538 Y125.472 E.00525
; LINE_WIDTH: 0.259702
G1 X148.379 Y125.663 E.00439
; LINE_WIDTH: 0.216918
G1 X148.22 Y125.853 E.00352
; LINE_WIDTH: 0.174134
G1 X148.06 Y126.044 E.00265
G1 X152.956 Y123.478 F30000
; LINE_WIDTH: 0.165528
G1 F15000
G1 X152.984 Y123.41 E.00073
G1 X152.984 Y123.172 E.00238
; WIPE_START
G1 X152.984 Y123.41 E-.58125
G1 X152.956 Y123.478 E-.17875
; WIPE_END
G1 E-.04 F1800
G17
G3 Z4 I-1.217 J0 P1  F30000
G1 X152.956 Y127.744 Z4
G1 Z3.6
G1 E.8 F1800
; LINE_WIDTH: 0.145289
G1 F15000
G2 X152.969 Y127.505 I-.177 J-.129 E.00211
; WIPE_START
G1 X152.998 Y127.576 E-.23007
G1 X152.998 Y127.643 E-.20117
G1 X152.956 Y127.744 E-.32877
; WIPE_END
G1 E-.04 F1800
G17
G3 Z4 I-.157 J-1.207 P1  F30000
G1 X143.33 Y128.993 Z4
G1 Z3.6
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.421886
G1 F15000
G1 X149.147 Y123.177 E.25402
G1 X148.611 Y123.177 E.01655
G1 X142.964 Y128.823 E.24661
G1 X142.428 Y128.823 E.01655
G1 X148.075 Y123.177 E.24661
G1 X147.539 Y123.177 E.01655
G1 X141.892 Y128.823 E.24661
G1 X141.356 Y128.823 E.01655
G1 X147.003 Y123.177 E.24661
G1 X146.467 Y123.177 E.01655
G1 X140.82 Y128.823 E.24661
G1 X140.284 Y128.823 E.01655
G1 X145.931 Y123.177 E.24661
G1 X145.395 Y123.177 E.01655
G1 X139.748 Y128.823 E.24661
G1 X139.212 Y128.823 E.01655
G1 X144.859 Y123.177 E.24661
G1 X144.323 Y123.177 E.01655
G1 X138.507 Y128.993 E.25402
G1 X137.145 Y130.355 F30000
G1 F15000
G1 X134.899 Y132.601 E.09809
G1 X134.119 Y132.845 F30000
G1 F15000
G1 X134.444 Y132.52 E.01419
G3 X133.802 Y132.626 I-.667 J-2.049 E.02016
G3 X133.599 Y132.717 I-.155 J-.072 E.0075
G1 X133.175 Y132.717 E.01309
G1 X133.251 Y132.641 E.00331
G1 X132.715 Y132.641 E.01655
G1 X132.639 Y132.717 E.00331
G1 X132.103 Y132.717 E.01655
G1 X132.179 Y132.641 E.00331
G1 X131.643 Y132.641 E.01655
G1 X131.567 Y132.717 E.00331
G1 X131.031 Y132.717 E.01655
G1 X131.107 Y132.641 E.00331
G1 X130.571 Y132.641 E.01655
G1 X130.495 Y132.717 E.00331
G1 X129.959 Y132.717 E.01655
G1 X130.035 Y132.641 E.00331
G1 X129.499 Y132.641 E.01655
G1 X129.423 Y132.717 E.00331
G1 X128.887 Y132.717 E.01655
G1 X128.963 Y132.641 E.00331
G1 X128.427 Y132.641 E.01655
G1 X128.351 Y132.717 E.00331
G1 X127.815 Y132.717 E.01655
G1 X127.891 Y132.641 E.00331
G1 X127.355 Y132.641 E.01655
G1 X127.279 Y132.717 E.00331
G1 X126.743 Y132.717 E.01655
G1 X126.819 Y132.641 E.00331
G1 X126.283 Y132.641 E.01655
G1 X126.208 Y132.717 E.00331
G1 X125.672 Y132.717 E.01655
G1 X125.747 Y132.641 E.00331
G1 X125.211 Y132.641 E.01655
G1 X125.136 Y132.717 E.00331
G1 X124.6 Y132.717 E.01655
G1 X124.676 Y132.641 E.00331
G1 X124.14 Y132.641 E.01655
G1 X124.064 Y132.717 E.00331
G1 X123.528 Y132.717 E.01655
G1 X123.604 Y132.641 E.00331
G1 X123.068 Y132.641 E.01655
G1 X122.992 Y132.717 E.00331
G1 X122.456 Y132.717 E.01655
G1 X122.532 Y132.641 E.00331
G1 X121.996 Y132.641 E.01655
G1 X121.92 Y132.717 E.00331
G1 X121.384 Y132.717 E.01655
G1 X121.46 Y132.641 E.00331
G1 X120.924 Y132.641 E.01655
G1 X120.848 Y132.717 E.00331
G1 X120.312 Y132.717 E.01655
G1 X120.388 Y132.641 E.00331
G1 X119.852 Y132.641 E.01655
G1 X119.776 Y132.717 E.00331
G1 X119.24 Y132.717 E.01655
G1 X119.316 Y132.641 E.00331
G1 X118.78 Y132.641 E.01655
G1 X118.704 Y132.717 E.00331
G1 X118.168 Y132.717 E.01655
G1 X118.244 Y132.641 E.00331
G1 X117.708 Y132.641 E.01655
G1 X117.633 Y132.717 E.00331
G1 X117.097 Y132.717 E.01655
G1 X117.172 Y132.641 E.00331
G1 X116.636 Y132.641 E.01655
G1 X116.561 Y132.717 E.00331
G1 X116.025 Y132.717 E.01655
G1 X116.1 Y132.641 E.00331
G1 X115.565 Y132.641 E.01655
G1 X115.489 Y132.717 E.00331
G1 X114.953 Y132.717 E.01655
G1 X115.029 Y132.641 E.00331
G1 X114.493 Y132.641 E.01655
G1 X114.417 Y132.717 E.00331
G1 X113.881 Y132.717 E.01655
G1 X113.957 Y132.641 E.00331
G1 X113.421 Y132.641 E.01655
G1 X113.345 Y132.717 E.00331
G1 X112.809 Y132.717 E.01655
G1 X112.885 Y132.641 E.00331
G1 X112.349 Y132.641 E.01655
G1 X112.273 Y132.717 E.00331
G1 X111.737 Y132.717 E.01655
G1 X111.813 Y132.641 E.00331
G1 X111.277 Y132.641 E.01655
G1 X111.201 Y132.717 E.00331
G1 X110.665 Y132.717 E.01655
G1 X110.741 Y132.641 E.00331
G1 X110.205 Y132.641 E.01655
G1 X110.129 Y132.717 E.00331
G1 X109.593 Y132.717 E.01655
G1 X109.669 Y132.641 E.00331
G1 X109.133 Y132.641 E.01655
G1 X109.058 Y132.717 E.00331
G1 X108.522 Y132.717 E.01655
G1 X108.597 Y132.641 E.00331
G1 X108.061 Y132.641 E.01655
G1 X107.986 Y132.717 E.00331
G1 X107.45 Y132.717 E.01655
G1 X107.525 Y132.641 E.00331
G1 X106.99 Y132.641 E.01655
G1 X106.914 Y132.717 E.00331
G1 X106.378 Y132.717 E.01655
G1 X106.454 Y132.641 E.00331
G1 X105.918 Y132.641 E.01655
G1 X105.842 Y132.717 E.00331
G1 X105.306 Y132.717 E.01655
G1 X105.382 Y132.641 E.00331
G1 X104.846 Y132.641 E.01655
G1 X104.6 Y132.887 E.01072
G1 X105.214 Y132.249 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X106.842 Y132.249 E.05401
G1 X109.478 Y129.613 E.12366
G1 X109.029 Y129.613 E.0149
G1 X111.665 Y132.249 E.12366
G1 X114.518 Y132.249 E.09465
G1 X117.154 Y129.613 E.12366
G1 X116.705 Y129.613 E.0149
G1 X119.341 Y132.249 E.12366
G1 X122.194 Y132.249 E.09465
G1 X124.83 Y129.613 E.12366
G1 X124.381 Y129.613 E.0149
G1 X127.017 Y132.249 E.12366
G1 X129.87 Y132.249 E.09465
G1 X132.506 Y129.613 E.12366
G1 X132.057 Y129.613 E.0149
G1 X134.528 Y132.085 E.11593
G2 X135.832 Y131.145 I-1.79 J-3.856 E.05364
G1 X136.892 Y130.072 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.421886
G1 F15000
G1 X143.787 Y123.177 E.30114
G1 X143.251 Y123.177 E.01655
G1 X137.2 Y129.228 E.26426
G1 X136.671 Y129.221 E.01636
G1 X142.715 Y123.177 E.26399
G1 X142.179 Y123.177 E.01655
G1 X136.135 Y129.221 E.26399
G1 X135.599 Y129.221 E.01655
G1 X141.643 Y123.177 E.26399
G1 X141.108 Y123.177 E.01655
G1 X135.063 Y129.221 E.26399
G1 X134.527 Y129.221 E.01655
G1 X140.572 Y123.177 E.26399
G1 X140.036 Y123.177 E.01655
G1 X133.991 Y129.221 E.26399
G1 X133.455 Y129.221 E.01655
G1 X139.5 Y123.177 E.26399
G1 X138.964 Y123.177 E.01655
G1 X132.919 Y129.221 E.26399
G1 X132.383 Y129.221 E.01655
G1 X138.428 Y123.177 E.26399
G1 X137.916 Y123.177 E.0158
G1 X137.907 Y123.161 E.00055
G1 X131.847 Y129.221 E.26465
G1 X131.311 Y129.221 E.01655
G1 X137.705 Y122.827 E.27924
G1 X137.503 Y122.493 E.01205
G1 X130.775 Y129.221 E.29382
G1 X130.239 Y129.221 E.01655
G1 X136.682 Y122.779 E.28136
G1 X136.146 Y122.779 E.01655
G1 X129.703 Y129.221 E.28136
G1 X129.167 Y129.221 E.01655
G1 X135.61 Y122.779 E.28136
G1 X135.074 Y122.779 E.01655
G1 X128.632 Y129.221 E.28136
G1 X128.096 Y129.221 E.01655
G1 X134.538 Y122.779 E.28136
G1 X134.002 Y122.779 E.01655
G1 X127.56 Y129.221 E.28136
G1 X127.024 Y129.221 E.01655
G1 X133.466 Y122.779 E.28136
G1 X132.93 Y122.779 E.01655
G1 X126.488 Y129.221 E.28136
G1 X125.952 Y129.221 E.01655
G1 X132.394 Y122.779 E.28136
G1 X131.859 Y122.779 E.01655
G1 X125.416 Y129.221 E.28136
G1 X124.88 Y129.221 E.01655
G1 X131.323 Y122.779 E.28136
G1 X130.787 Y122.779 E.01655
G1 X124.344 Y129.221 E.28136
G1 X123.808 Y129.221 E.01655
G1 X130.251 Y122.779 E.28136
G1 X129.715 Y122.779 E.01655
G1 X123.272 Y129.221 E.28136
G1 X122.736 Y129.221 E.01655
G1 X129.179 Y122.779 E.28136
G1 X128.643 Y122.779 E.01655
G1 X122.2 Y129.221 E.28136
G1 X121.664 Y129.221 E.01655
G1 X128.107 Y122.779 E.28136
G1 X127.571 Y122.779 E.01655
G1 X121.128 Y129.221 E.28136
G1 X120.592 Y129.221 E.01655
G1 X127.035 Y122.779 E.28136
G1 X126.499 Y122.779 E.01655
G1 X120.057 Y129.221 E.28136
G1 X119.521 Y129.221 E.01655
G1 X125.963 Y122.779 E.28136
G1 X125.427 Y122.779 E.01655
G1 X118.985 Y129.221 E.28136
G1 X118.449 Y129.221 E.01655
G1 X124.891 Y122.779 E.28136
G1 X124.355 Y122.779 E.01655
G1 X117.913 Y129.221 E.28136
G1 X117.377 Y129.221 E.01655
G1 X123.819 Y122.779 E.28136
G1 X123.283 Y122.779 E.01655
G1 X116.841 Y129.221 E.28136
G1 X116.305 Y129.221 E.01655
G1 X122.748 Y122.779 E.28136
G1 X122.212 Y122.779 E.01655
G1 X115.769 Y129.221 E.28136
G1 X115.233 Y129.221 E.01655
G1 X121.676 Y122.779 E.28136
G1 X121.14 Y122.779 E.01655
G1 X114.697 Y129.221 E.28136
G1 X114.161 Y129.221 E.01655
G1 X120.604 Y122.779 E.28136
G1 X120.068 Y122.779 E.01655
G1 X113.625 Y129.221 E.28136
G1 X113.089 Y129.221 E.01655
G1 X119.532 Y122.779 E.28136
G1 X118.996 Y122.779 E.01655
G1 X112.553 Y129.221 E.28136
G1 X112.017 Y129.221 E.01655
M73 P48 R10
G1 X118.46 Y122.779 E.28136
G1 X117.924 Y122.779 E.01655
G1 X111.481 Y129.221 E.28136
G1 X110.946 Y129.221 E.01655
G1 X117.388 Y122.779 E.28136
G1 X116.852 Y122.779 E.01655
G1 X110.41 Y129.221 E.28136
G1 X109.874 Y129.221 E.01655
G1 X116.316 Y122.779 E.28136
G1 X115.78 Y122.779 E.01655
G1 X109.338 Y129.221 E.28136
G1 X108.802 Y129.221 E.01655
G1 X115.244 Y122.779 E.28136
G1 X114.708 Y122.779 E.01655
G1 X108.266 Y129.221 E.28136
G1 X107.73 Y129.221 E.01655
G1 X114.173 Y122.779 E.28136
G1 X113.637 Y122.779 E.01655
G1 X107.194 Y129.221 E.28136
G1 X106.658 Y129.221 E.01655
G1 X113.101 Y122.779 E.28136
G1 X112.565 Y122.779 E.01655
G1 X106.122 Y129.221 E.28136
G1 X105.586 Y129.221 E.01655
G1 X112.029 Y122.779 E.28136
G1 X111.493 Y122.779 E.01655
G1 X105.05 Y129.221 E.28136
G2 X104.834 Y129.274 I-.044 J.287 E.00704
G1 X104.684 Y129.425 E.00658
G1 X104.379 Y129.425 E.00941
G1 X104.379 Y129.357 E.00211
G1 X110.957 Y122.779 E.28727
G1 X110.421 Y122.779 E.01655
G1 X104.379 Y128.821 E.26386
G1 X104.379 Y128.285 E.01655
G1 X109.885 Y122.779 E.24046
G1 X109.349 Y122.779 E.01655
G1 X104.379 Y127.749 E.21705
G1 X104.379 Y127.213 E.01655
G1 X108.813 Y122.779 E.19365
G1 X108.277 Y122.779 E.01655
G1 X104.379 Y126.677 E.17024
G1 X104.379 Y126.141 E.01655
G1 X107.741 Y122.779 E.14683
G1 X107.205 Y122.779 E.01655
G1 X104.379 Y125.605 E.12343
G1 X104.379 Y125.069 E.01655
G1 X106.669 Y122.779 E.10002
G1 X106.133 Y122.779 E.01655
G1 X104.379 Y124.533 E.07662
G1 X104.379 Y123.997 E.01655
G1 X105.598 Y122.779 E.05321
G1 X105.062 Y122.779 E.01655
G1 X104.379 Y123.461 E.02981
G1 X104.379 Y122.925 E.01655
G1 X104.826 Y122.478 E.01954
G1 X104.56 Y119.528 F30000
G1 F15000
G1 X104.806 Y119.283 E.01072
G1 X105.342 Y119.283 E.01655
G1 X105.266 Y119.359 E.00331
G1 X105.802 Y119.359 E.01655
G1 X105.878 Y119.283 E.00331
G1 X106.414 Y119.283 E.01655
G1 X106.338 Y119.359 E.00331
G1 X106.874 Y119.359 E.01655
G1 X106.95 Y119.283 E.00331
G1 X107.486 Y119.283 E.01655
G1 X107.41 Y119.359 E.00331
G1 X107.946 Y119.359 E.01655
G1 X108.021 Y119.283 E.00331
G1 X108.557 Y119.283 E.01655
G1 X108.482 Y119.359 E.00331
G1 X109.018 Y119.359 E.01655
G1 X109.093 Y119.283 E.00331
G1 X109.629 Y119.283 E.01655
G1 X109.554 Y119.359 E.00331
G1 X110.089 Y119.359 E.01655
G1 X110.165 Y119.283 E.00331
G1 X110.701 Y119.283 E.01655
G1 X110.625 Y119.359 E.00331
G1 X111.161 Y119.359 E.01655
G1 X111.237 Y119.283 E.00331
G1 X111.773 Y119.283 E.01655
G1 X111.697 Y119.359 E.00331
G1 X112.233 Y119.359 E.01655
G1 X112.309 Y119.283 E.00331
G1 X112.845 Y119.283 E.01655
G1 X112.769 Y119.359 E.00331
G1 X113.305 Y119.359 E.01655
G1 X113.381 Y119.283 E.00331
G1 X113.917 Y119.283 E.01655
G1 X113.841 Y119.359 E.00331
G1 X114.377 Y119.359 E.01655
G1 X114.453 Y119.283 E.00331
G1 X114.989 Y119.283 E.01655
G1 X114.913 Y119.359 E.00331
G1 X115.449 Y119.359 E.01655
G1 X115.525 Y119.283 E.00331
G1 X116.061 Y119.283 E.01655
G1 X115.985 Y119.359 E.00331
G1 X116.521 Y119.359 E.01655
G1 X116.597 Y119.283 E.00331
G1 X117.132 Y119.283 E.01655
G1 X117.057 Y119.359 E.00331
G1 X117.593 Y119.359 E.01655
G1 X117.668 Y119.283 E.00331
G1 X118.204 Y119.283 E.01655
G1 X118.129 Y119.359 E.00331
G1 X118.664 Y119.359 E.01655
G1 X118.74 Y119.283 E.00331
G1 X119.276 Y119.283 E.01655
G1 X119.2 Y119.359 E.00331
G1 X119.736 Y119.359 E.01655
G1 X119.812 Y119.283 E.00331
G1 X120.348 Y119.283 E.01655
G1 X120.272 Y119.359 E.00331
G1 X120.808 Y119.359 E.01655
G1 X120.884 Y119.283 E.00331
G1 X121.42 Y119.283 E.01655
G1 X121.344 Y119.359 E.00331
G1 X121.88 Y119.359 E.01655
G1 X121.956 Y119.283 E.00331
G1 X122.492 Y119.283 E.01655
G1 X122.416 Y119.359 E.00331
G1 X122.952 Y119.359 E.01655
G1 X123.028 Y119.283 E.00331
G1 X123.564 Y119.283 E.01655
G1 X123.488 Y119.359 E.00331
G1 X124.024 Y119.359 E.01655
G1 X124.1 Y119.283 E.00331
G1 X124.636 Y119.283 E.01655
G1 X124.56 Y119.359 E.00331
G1 X125.096 Y119.359 E.01655
G1 X125.172 Y119.283 E.00331
G1 X125.707 Y119.283 E.01655
G1 X125.632 Y119.359 E.00331
G1 X126.168 Y119.359 E.01655
G1 X126.243 Y119.283 E.00331
G1 X126.779 Y119.283 E.01655
G1 X126.704 Y119.359 E.00331
G1 X127.24 Y119.359 E.01655
G1 X127.315 Y119.283 E.00331
G1 X127.851 Y119.283 E.01655
G1 X127.775 Y119.359 E.00331
G1 X128.311 Y119.359 E.01655
G1 X128.387 Y119.283 E.00331
G1 X128.923 Y119.283 E.01655
G1 X128.847 Y119.359 E.00331
G1 X129.383 Y119.359 E.01655
G1 X129.459 Y119.283 E.00331
G1 X129.995 Y119.283 E.01655
G1 X129.919 Y119.359 E.00331
G1 X130.455 Y119.359 E.01655
G1 X130.531 Y119.283 E.00331
G1 X131.067 Y119.283 E.01655
G1 X130.991 Y119.359 E.00331
G1 X131.527 Y119.359 E.01655
G1 X131.603 Y119.283 E.00331
G1 X132.139 Y119.283 E.01655
G1 X132.063 Y119.359 E.00331
G1 X132.599 Y119.359 E.01655
G1 X132.675 Y119.283 E.00331
G1 X133.211 Y119.283 E.01655
G1 X133.135 Y119.359 E.00331
G3 X133.615 Y119.359 I.233 J6 E.01483
G1 X133.666 Y119.363 E.00159
G1 X133.736 Y119.293 E.00307
G3 X134.214 Y119.351 I.051 J1.575 E.01492
G1 X134.155 Y119.41 E.00256
G3 X134.586 Y119.516 I-.475 J2.863 E.01369
G1 X134.63 Y119.472 E.00192
G3 X134.999 Y119.639 I-.388 J1.348 E.01255
G1 X134.966 Y119.671 E.00143
G3 X135.306 Y119.867 I-.471 J1.216 E.01217
G1 X135.335 Y119.839 E.00125
G1 X135.634 Y120.076 E.01176
G1 X135.496 Y120.213 E.00602
G1 X135.832 Y120.855 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F15476.087
G2 X134.528 Y119.915 I-3.093 J2.916 E.05364
G1 X132.057 Y122.387 E.11593
G1 X132.506 Y122.387 E.0149
G1 X129.87 Y119.751 E.12366
G1 X127.017 Y119.751 E.09465
G1 X124.381 Y122.387 E.12366
G1 X124.83 Y122.387 E.0149
G1 X122.194 Y119.751 E.12366
G1 X119.341 Y119.751 E.09465
G1 X116.705 Y122.387 E.12366
G1 X117.154 Y122.387 E.0149
G1 X114.518 Y119.751 E.12366
G1 X111.665 Y119.751 E.09465
G1 X109.029 Y122.387 E.12366
G1 X109.478 Y122.387 E.0149
G1 X106.843 Y119.751 E.12366
G1 X105.214 Y119.751 E.05401
G1 X136.033 Y120.748 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.421886
G1 F15000
G1 X136.156 Y120.625 E.00538
G3 X136.397 Y120.92 I-1.672 J1.611 E.01178
G1 X136.628 Y121.225 E.01181
G3 X136.859 Y121.53 I-3.318 J2.747 E.01182
G1 X136.841 Y121.548 E.00081
G1 X137.056 Y121.868 E.01192
G1 X137.078 Y121.847 E.00095
G1 X137.297 Y122.164 E.0119
G1 X137.137 Y122.324 E.00699
; CHANGE_LAYER
; Z_HEIGHT: 3.8
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F15000
G1 X137.297 Y122.164 E-.08601
G1 X137.078 Y121.847 E-.1464
G1 X137.056 Y121.868 E-.01163
G1 X136.841 Y121.548 E-.14671
G1 X136.859 Y121.53 E-.00993
G1 X136.628 Y121.225 E-.14539
G1 X136.397 Y120.92 E-.14536
G1 X136.283 Y120.78 E-.06856
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 19/101
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L19
M991 S0 P18 ;notify layer change
G17
G3 Z4 I-.675 J1.013 P1  F30000
G1 X147.782 Y128.447 Z4
G1 Z3.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X148.29 Y128.447 E.01684
G2 X151.395 Y129.281 I10.345 J-32.311 E.10669
G1 X151.369 Y129.497 E.0072
G1 X138.11 Y129.497 E.43984
G3 X135.968 Y132.276 I-13.555 J-8.23 E.11664
G1 X135.525 Y132.628 E.01876
G3 X133.611 Y133.212 I-1.975 J-3.045 E.06724
G1 X104.046 Y133.212 E.98073
G1 X104.046 Y118.788 E.47846
G1 X133.611 Y118.788 E.98073
G1 X133.95 Y118.813 E.01127
G1 X134.122 Y118.826 E.00572
G3 X136.38 Y120.154 I-.612 J3.624 E.08887
G3 X138.11 Y122.503 I-16.273 J13.791 E.09683
G1 X151.369 Y122.503 E.43984
G1 X151.395 Y122.719 E.0072
G2 X148.29 Y123.553 I7.24 J33.146 E.10669
G1 X104.366 Y123.553 E1.45703
G1 X104.366 Y128.447 E.16235
G1 X147.722 Y128.447 E1.4382
; WIPE_START
G1 X148.29 Y128.447 E-.21575
G1 X149.665 Y128.848 E-.54425
; WIPE_END
G1 E-.04 F1800
G1 X148.917 Y126.113 Z4.2 F30000
G1 Z3.8
G1 E.8 F1800
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
G1 X149.363 Y126.757 E.02406
G1 X149.638 Y126.953 E.0104
G1 X150.574 Y127.405 E.03194
G2 X153.234 Y128.205 I6.265 J-15.997 E.08543
G1 X153.234 Y129.19 E.03025
G1 F3899.032
G1 X153.234 Y129.59 E.01229
G1 F600
G1 X153.234 Y129.889 E.00919
G1 X152.302 Y129.889 E.02863
G1 X151.37 Y129.889 E.02863
G1 X150.439 Y129.889 E.02863
G1 F720
G1 X149.507 Y129.889 E.02863
G1 F960
G1 X148.575 Y129.889 E.02863
G1 F1080
G1 X147.644 Y129.889 E.02863
G1 F1200
G1 X146.712 Y129.889 E.02863
G1 F1320
G1 X145.78 Y129.889 E.02863
G1 F1440
G1 X144.849 Y129.889 E.02863
G1 F1560
G1 X143.917 Y129.889 E.02863
G1 F1680
G1 X142.986 Y129.889 E.02863
G1 F1800
G1 X142.054 Y129.889 E.02863
G1 F1920
G1 X141.122 Y129.889 E.02863
G1 F2040
G1 X140.191 Y129.889 E.02863
G1 F2280
G1 X139.259 Y129.889 E.02863
G1 F2400
G1 X138.327 Y129.889 E.02863
G1 X138.182 Y130.121 E.00842
G1 F2640
G1 X137.684 Y130.833 E.0267
G1 F2760
G1 X137.32 Y131.315 E.01855
G1 F2880
G3 X136.48 Y132.319 I-14.565 J-11.343 E.04024
G1 F2760
G1 X136.229 Y132.569 E.01089
G1 F2520
G1 X135.748 Y132.952 E.01889
G3 X135.247 Y133.24 I-4.716 J-7.625 E.01776
G1 F2640
G1 X134.72 Y133.441 E.01733
G1 F2520
G3 X133.626 Y133.604 I-1.096 J-3.607 E.03412
G1 X103.654 Y133.604 E.92095
G1 F3798.281
G1 X103.654 Y133.484 E.0037
G1 F9915.683
G1 X103.654 Y133.084 E.01229
G1 F12000
G1 X103.654 Y132.684 E.01229
G1 X103.654 Y119.316 E.41073
G1 X103.654 Y118.916 E.01229
G1 F7769.882
G1 X103.654 Y118.516 E.01229
G1 F2520
G1 X103.654 Y118.396 E.0037
G1 X133.626 Y118.396 E.92095
G1 X133.979 Y118.422 E.01089
G1 X134.18 Y118.437 E.00619
G1 F2640
G1 X134.72 Y118.559 E.01701
G1 F2520
G1 X135.247 Y118.76 E.01733
G3 X135.748 Y119.048 I-4.214 J7.91 E.01776
G1 F2760
G1 X136.229 Y119.431 E.01889
G1 F2880
G3 X137.078 Y120.378 I-6.503 J6.679 E.03911
G1 F2760
G1 X137.32 Y120.685 E.01202
G1 F2640
G1 X137.684 Y121.167 E.01855
G1 F2400
G3 X138.327 Y122.111 I-8.489 J6.478 E.03513
G1 F2280
G1 X139.259 Y122.111 E.02863
G1 F2040
G1 X140.191 Y122.111 E.02863
G1 F1920
G1 X141.122 Y122.111 E.02863
G1 F1800
G1 X142.054 Y122.111 E.02863
G1 F1680
G1 X142.986 Y122.111 E.02863
G1 F1560
G1 X143.917 Y122.111 E.02863
G1 F1440
G1 X144.849 Y122.111 E.02863
G1 F1320
G1 X145.78 Y122.111 E.02863
G1 F1200
G1 X146.712 Y122.111 E.02863
G1 F1080
G1 X147.644 Y122.111 E.02863
G1 F960
G1 X148.575 Y122.111 E.02863
G1 F720
G1 X149.507 Y122.111 E.02863
G1 F600
G1 X150.439 Y122.111 E.02863
G1 X151.37 Y122.111 E.02863
G1 X152.302 Y122.111 E.02863
G1 X153.234 Y122.111 E.02863
G1 F2794.797
G1 X153.234 Y122.41 E.00919
G1 F8247.032
G1 X153.234 Y122.81 E.01229
G1 F12000
G1 X153.234 Y123.795 E.03025
G2 X150.574 Y124.595 I3.606 J16.797 E.08543
G1 X149.638 Y125.047 E.03194
G1 X149.363 Y125.243 E.0104
G1 X148.917 Y125.887 E.02406
G1 X148.917 Y126.053 E.00511
M204 S10000
; WIPE_START
G1 X149.363 Y126.757 E-.31655
G1 X149.638 Y126.953 E-.12862
G1 X150.385 Y127.313 E-.31483
; WIPE_END
G1 E-.04 F1800
G1 X148.554 Y129.02 Z4.2 F30000
G1 Z3.8
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.564428
G1 F12080.352
G1 X148.723 Y129.045 E.00727
; LINE_WIDTH: 0.516026
G1 F13316.266
G1 X148.892 Y129.069 E.0066
; LINE_WIDTH: 0.467624
G1 F14833.887
G1 X149.062 Y129.093 E.00592
; LINE_WIDTH: 0.419221
G1 F15000
G1 X149.231 Y129.117 E.00525
; LINE_WIDTH: 0.370819
G1 X149.4 Y129.141 E.00457
; LINE_WIDTH: 0.322416
G1 X149.57 Y129.166 E.0039
; LINE_WIDTH: 0.274014
G1 X149.739 Y129.19 E.00322
; LINE_WIDTH: 0.225612
G1 X149.908 Y129.214 E.00255
; LINE_WIDTH: 0.183599
G1 X150.066 Y129.233 E.00182
; LINE_WIDTH: 0.148675
G1 X150.221 Y129.251 E.00134
; LINE_WIDTH: 0.114172
G1 X150.375 Y129.269 E.0009
G1 X151.577 Y129.412 F30000
; LINE_WIDTH: 0.524155
G1 F13091.339
G1 X151.876 Y129.448 E.01184
; LINE_WIDTH: 0.482526
G1 F14331.013
G1 X152.176 Y129.483 E.01082
; LINE_WIDTH: 0.461013
G1 F15000
G2 X152.418 Y129.486 I.145 J-2.033 E.00824
G1 X152.479 Y129.464 E.00219
; LINE_WIDTH: 0.522336
G1 F13140.993
G1 X152.539 Y129.442 E.00252
; LINE_WIDTH: 0.566637
G1 F12029.398
G1 X152.599 Y129.42 E.00275
; LINE_WIDTH: 0.610939
G1 F11091.194
G1 X152.66 Y129.398 E.00298
; LINE_WIDTH: 0.65524
G1 F10288.749
G1 X152.72 Y129.376 E.00321
; LINE_WIDTH: 0.655505
G1 F10284.289
G1 X152.747 Y129.195 E.00909
; LINE_WIDTH: 0.612979
G1 F11051.503
G1 X152.772 Y129.02 E.00821
; LINE_WIDTH: 0.571079
G1 F11928.236
G1 X152.798 Y128.845 E.00761
; LINE_WIDTH: 0.529179
G1 F12956.057
G1 X152.824 Y128.67 E.00701
; LINE_WIDTH: 0.48728
G1 F14177.713
G1 X152.849 Y128.495 E.0064
; LINE_WIDTH: 0.44538
G1 F15000
G1 X152.875 Y128.32 E.0058
G1 X152.211 Y128.17 F30000
M204 S2000
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F12000
G1 X152.604 Y128.563 E.0171
G1 X152.482 Y128.974
G1 X151.445 Y127.937 E.04507
G1 X150.614 Y127.639
G1 X152.228 Y129.253 E.07013
G1 X151.525 Y129.084
G1 X149.612 Y127.17 E.08315
M204 S10000
; WIPE_START
G1 X151.026 Y128.585 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X152.58 Y123.739 Z4.2 F30000
G1 Z3.8
G1 E.8 F1800
M204 S2000
G1 F12000
G1 X151.712 Y122.871 E.03771
G1 X151.282 Y122.975
G1 X152.154 Y123.847 E.0379
G1 X151.741 Y123.967
G1 X150.852 Y123.078 E.03863
G1 X150.422 Y123.182
G1 X151.341 Y124.1 E.03992
G1 X150.948 Y124.241
G1 X149.995 Y123.287 E.04145
G1 X149.582 Y123.408
G1 X150.556 Y124.382 E.04232
G1 X150.191 Y124.55
G1 X149.169 Y123.528 E.04441
G1 X148.756 Y123.648
G1 X149.831 Y124.724 E.04672
G1 X149.48 Y124.905
G1 X148.343 Y123.769 E.04938
G1 X147.816 Y123.775
G1 X149.182 Y125.14 E.05933
G1 X148.963 Y125.455
G1 X147.283 Y123.775 E.07301
G1 X146.75 Y123.775
M73 P49 R10
G1 X148.745 Y125.77 E.0867
G1 X148.913 Y126.471
G1 X146.217 Y123.775 E.11716
G1 X145.683 Y123.775
G1 X150.823 Y128.915 E.22333
G1 X150.12 Y128.745
G1 X145.15 Y123.775 E.21598
G1 X144.617 Y123.775
G1 X149.373 Y128.532 E.20668
G1 X148.62 Y128.312
G1 X144.083 Y123.775 E.19714
G1 X143.55 Y123.775
G1 X148 Y128.225 E.19335
G1 X147.466 Y128.225
G1 X143.017 Y123.775 E.19335
G1 X142.484 Y123.775
G1 X146.933 Y128.225 E.19335
G1 X146.4 Y128.225
G1 X141.95 Y123.775 E.19335
G1 X141.417 Y123.775
G1 X145.867 Y128.225 E.19335
G1 X145.333 Y128.225
G1 X140.884 Y123.775 E.19335
G1 X140.351 Y123.775
G1 X144.8 Y128.225 E.19335
G1 X144.267 Y128.225
G1 X139.817 Y123.775 E.19335
G1 X139.284 Y123.775
G1 X143.734 Y128.225 E.19335
G1 X143.2 Y128.225
G1 X138.751 Y123.775 E.19335
G1 X138.217 Y123.775
G1 X142.667 Y128.225 E.19335
G1 X142.134 Y128.225
G1 X137.684 Y123.775 E.19335
G1 X137.151 Y123.775
G1 X141.6 Y128.225 E.19335
G1 X141.067 Y128.225
G1 X136.618 Y123.775 E.19335
G1 X136.084 Y123.775
G1 X140.534 Y128.225 E.19335
G1 X140.001 Y128.225
G1 X135.551 Y123.775 E.19335
G1 X135.018 Y123.775
G1 X139.467 Y128.225 E.19335
G1 X138.934 Y128.225
G1 X134.485 Y123.775 E.19335
G1 X133.951 Y123.775
G1 X138.401 Y128.225 E.19335
G1 X137.868 Y128.225
G1 X133.418 Y123.775 E.19335
G1 X132.885 Y123.775
G1 X137.334 Y128.225 E.19335
G1 X136.801 Y128.225
G1 X132.352 Y123.775 E.19335
G1 X131.818 Y123.775
G1 X136.268 Y128.225 E.19335
G1 X135.734 Y128.225
G1 X131.285 Y123.775 E.19335
G1 X130.752 Y123.775
G1 X135.201 Y128.225 E.19335
G1 X134.668 Y128.225
G1 X130.218 Y123.775 E.19335
G1 X129.685 Y123.775
G1 X134.135 Y128.225 E.19335
G1 X133.601 Y128.225
G1 X129.152 Y123.775 E.19335
G1 X128.619 Y123.775
G1 X133.068 Y128.225 E.19335
G1 X132.535 Y128.225
G1 X128.085 Y123.775 E.19335
G1 X127.552 Y123.775
G1 X132.002 Y128.225 E.19335
G1 X131.468 Y128.225
G1 X127.019 Y123.775 E.19335
G1 X126.486 Y123.775
G1 X130.935 Y128.225 E.19335
G1 X130.402 Y128.225
G1 X125.952 Y123.775 E.19335
G1 X125.419 Y123.775
G1 X129.869 Y128.225 E.19335
G1 X129.335 Y128.225
G1 X124.886 Y123.775 E.19335
G1 X124.352 Y123.775
G1 X128.802 Y128.225 E.19335
G1 X128.269 Y128.225
G1 X123.819 Y123.775 E.19335
G1 X123.286 Y123.775
G1 X127.735 Y128.225 E.19335
G1 X127.202 Y128.225
G1 X122.753 Y123.775 E.19335
G1 X122.219 Y123.775
G1 X126.669 Y128.225 E.19335
G1 X126.136 Y128.225
G1 X121.686 Y123.775 E.19335
G1 X121.153 Y123.775
G1 X125.602 Y128.225 E.19335
G1 X125.069 Y128.225
G1 X120.62 Y123.775 E.19335
G1 X120.086 Y123.775
G1 X124.536 Y128.225 E.19335
G1 X124.003 Y128.225
G1 X119.553 Y123.775 E.19335
G1 X119.02 Y123.775
G1 X123.469 Y128.225 E.19335
G1 X122.936 Y128.225
G1 X118.486 Y123.775 E.19335
G1 X117.953 Y123.775
G1 X122.403 Y128.225 E.19335
G1 X121.869 Y128.225
G1 X117.42 Y123.775 E.19335
G1 X116.887 Y123.775
G1 X121.336 Y128.225 E.19335
G1 X120.803 Y128.225
M73 P49 R9
G1 X116.353 Y123.775 E.19335
G1 X115.82 Y123.775
G1 X120.27 Y128.225 E.19335
G1 X119.736 Y128.225
G1 X115.287 Y123.775 E.19335
G1 X114.754 Y123.775
G1 X119.203 Y128.225 E.19335
G1 X118.67 Y128.225
G1 X114.22 Y123.775 E.19335
G1 X113.687 Y123.775
G1 X118.137 Y128.225 E.19335
G1 X117.603 Y128.225
G1 X113.154 Y123.775 E.19335
G1 X112.621 Y123.775
G1 X117.07 Y128.225 E.19335
G1 X116.537 Y128.225
G1 X112.087 Y123.775 E.19335
G1 X111.554 Y123.775
G1 X116.003 Y128.225 E.19335
G1 X115.47 Y128.225
G1 X111.021 Y123.775 E.19335
G1 X110.487 Y123.775
G1 X114.937 Y128.225 E.19335
G1 X114.404 Y128.225
G1 X109.954 Y123.775 E.19335
G1 X109.421 Y123.775
G1 X113.87 Y128.225 E.19335
G1 X113.337 Y128.225
G1 X108.888 Y123.775 E.19335
G1 X108.354 Y123.775
G1 X112.804 Y128.225 E.19335
G1 X112.271 Y128.225
G1 X107.821 Y123.775 E.19335
G1 X107.288 Y123.775
G1 X111.737 Y128.225 E.19335
G1 X111.204 Y128.225
G1 X106.755 Y123.775 E.19335
G1 X106.221 Y123.775
G1 X110.671 Y128.225 E.19335
G1 X110.138 Y128.225
G1 X105.688 Y123.775 E.19335
G1 X105.155 Y123.775
G1 X109.604 Y128.225 E.19335
G1 X109.071 Y128.225
G1 X104.621 Y123.775 E.19335
G1 X104.588 Y124.275
G1 X108.538 Y128.225 E.17162
G1 X108.004 Y128.225
G1 X104.588 Y124.809 E.14845
G1 X104.588 Y125.342
G1 X107.471 Y128.225 E.12527
G1 X106.938 Y128.225
G1 X104.588 Y125.875 E.1021
G1 X104.588 Y126.408
G1 X106.405 Y128.225 E.07893
G1 X105.871 Y128.225
G1 X104.588 Y126.942 E.05575
G1 X104.588 Y127.475
G1 X105.338 Y128.225 E.03258
M204 S10000
G1 X152.358 Y129.272 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.140423
G1 F15000
G1 X152.409 Y129.115 E.00132
; LINE_WIDTH: 0.124198
G1 X152.381 Y129.109 E.00019
; LINE_WIDTH: 0.0939264
G1 X152.353 Y129.103 E.00012
; WIPE_START
G1 X152.381 Y129.109 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z4.2 I.742 J-.965 P1  F30000
G1 X150.551 Y127.702 Z4.2
G1 Z3.8
G1 E.8 F1800
; LINE_WIDTH: 0.203483
G1 F15000
G1 X150.468 Y127.649 E.00129
; LINE_WIDTH: 0.180463
G1 X150.371 Y127.581 E.00132
; LINE_WIDTH: 0.143546
G1 X150.275 Y127.513 E.00097
; LINE_WIDTH: 0.106629
G1 X150.179 Y127.444 E.00061
G1 X149.62 Y127.162 F30000
; LINE_WIDTH: 0.187558
G1 F15000
G1 X149.478 Y127.179 E.00168
; LINE_WIDTH: 0.20391
G1 X149.336 Y127.058 E.00245
; LINE_WIDTH: 0.171354
G3 X149.179 Y126.924 I.697 J-.969 E.00216
; LINE_WIDTH: 0.173101
G1 X149.067 Y126.789 E.00186
; LINE_WIDTH: 0.214788
G1 X148.852 Y126.532 E.0047
; WIPE_START
G1 X149.067 Y126.789 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X148.554 Y129.02 Z4.2 F30000
G1 Z3.8
G1 E.8 F1800
; LINE_WIDTH: 0.612831
G1 F11054.369
G1 X148.384 Y128.996 E.00795
; LINE_WIDTH: 0.685028
G1 F9811.44
G1 X148.215 Y128.972 E.00895
G1 X138.197 Y128.972 E.52416
G1 X137.047 Y129.619 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.419751
G1 F15000
G1 X137.2 Y129.696 E.00524
G1 X137.297 Y129.889 E.00663
G1 X137.28 Y130.07 E.00558
G2 X137.805 Y129.244 I-34.909 J-22.763 E.03004
G1 X137.805 Y128.839 E.01244
G1 X104.438 Y128.839 E1.0246
G1 X104.438 Y129.822 E.03018
G1 X104.692 Y129.822 E.0078
G1 X104.967 Y129.622 E.01045
G1 X104.999 Y129.619 E.001
G1 X136.987 Y129.619 E.98225
G1 X104.839 Y129.24 F30000
; LINE_WIDTH: 0.445338
G1 F15000
G1 X137.047 Y129.229 E1.05618
; LINE_WIDTH: 0.459523
G1 X137.146 Y129.24 E.00337
; LINE_WIDTH: 0.488004
G1 F14154.648
G1 X137.244 Y129.251 E.0036
G1 X104.431 Y132.826 F30000
; LINE_WIDTH: 0.404374
G1 F15000
G1 X133.597 Y132.826 E.85904
G2 X135.893 Y131.842 I-.078 J-3.352 E.07541
G2 X137.246 Y130.119 I-10.605 J-9.723 E.06458
G1 X135.95 Y131.253 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F15476.087
G3 X134.664 Y132.22 I-3.316 J-3.069 E.05368
G1 X132.454 Y130.011 E.10366
G1 X132.109 Y130.011 E.01146
G1 X129.679 Y132.441 E.11401
G1 X127.209 Y132.441 E.08193
G1 X124.779 Y130.011 E.11401
G1 X124.433 Y130.011 E.01146
G1 X122.003 Y132.441 E.11401
G1 X119.533 Y132.441 E.08193
G1 X117.103 Y130.011 E.11401
G1 X116.757 Y130.011 E.01146
G1 X114.327 Y132.441 E.11401
G1 X111.857 Y132.441 E.08193
G1 X109.427 Y130.011 E.11401
G1 X109.081 Y130.011 E.01146
G1 X106.651 Y132.441 E.11401
G1 X105.022 Y132.441 E.05401
G1 X105.023 Y119.559 F30000
G1 F15476.087
G1 X106.652 Y119.56 E.05401
G1 X109.081 Y121.989 E.11397
G1 X109.427 Y121.989 E.01146
G1 X111.855 Y119.561 E.1139
G1 X114.33 Y119.562 E.08211
G1 X116.757 Y121.989 E.11387
G1 X117.103 Y121.989 E.01146
G1 X119.528 Y119.564 E.1138
G1 X122.008 Y119.564 E.08226
M73 P50 R9
G1 X124.433 Y121.989 E.11376
G1 X124.779 Y121.989 E.01146
G1 X127.202 Y119.566 E.11369
G1 X129.686 Y119.566 E.0824
G1 X132.109 Y121.989 E.11366
G1 X132.454 Y121.989 E.01146
G1 X134.664 Y119.78 E.10366
G3 X135.95 Y120.747 I-2.03 J4.036 E.05368
G1 X137.047 Y122.381 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.419788
G1 F15000
G1 X104.999 Y122.381 E.98419
G1 X104.877 Y122.336 E.00402
G1 X104.692 Y122.178 E.00747
G1 X104.438 Y122.178 E.0078
G1 X104.438 Y123.161 E.03019
G1 X137.805 Y123.161 E1.0247
G1 X137.805 Y122.846 E.00967
G1 X137.757 Y122.679 E.00532
G2 X137.294 Y121.952 I-59.415 J37.329 E.02648
G1 X137.296 Y122.111 E.00488
G1 X137.2 Y122.304 E.00663
G1 X137.101 Y122.354 E.0034
G1 X104.839 Y122.76 F30000
; LINE_WIDTH: 0.445338
G1 F15000
G1 X137.047 Y122.771 E1.05618
; LINE_WIDTH: 0.459523
G1 X137.146 Y122.76 E.00337
; LINE_WIDTH: 0.488004
G1 F14154.648
G1 X137.244 Y122.749 E.0036
G1 X104.431 Y119.174 F30000
; LINE_WIDTH: 0.408066
G1 F15000
G1 X133.597 Y119.178 E.86781
G3 X135.885 Y120.15 I-.06 J3.322 E.07582
G3 X137.26 Y121.902 I-10.314 J9.51 E.06637
G1 X138.197 Y123.028 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.685028
G1 F9811.44
G1 X148.215 Y123.028 E.52416
G1 X148.384 Y123.004 E.00895
; LINE_WIDTH: 0.61283
G1 F11054.375
G1 X148.553 Y122.98 E.00795
; LINE_WIDTH: 0.564428
G1 F12080.362
G1 X148.723 Y122.955 E.00727
; LINE_WIDTH: 0.516025
G1 F13316.285
G1 X148.892 Y122.931 E.0066
; LINE_WIDTH: 0.467623
G1 F14833.917
G1 X149.062 Y122.907 E.00592
; LINE_WIDTH: 0.41922
G1 F15000
G1 X149.231 Y122.883 E.00525
; LINE_WIDTH: 0.370818
G1 X149.4 Y122.859 E.00457
; LINE_WIDTH: 0.322415
G1 X149.57 Y122.834 E.0039
; LINE_WIDTH: 0.274012
G1 X149.739 Y122.81 E.00322
; LINE_WIDTH: 0.22561
G1 X149.908 Y122.786 E.00255
; LINE_WIDTH: 0.1836
G1 X150.066 Y122.767 E.00182
; LINE_WIDTH: 0.148676
G1 X150.221 Y122.749 E.00134
; LINE_WIDTH: 0.114173
G1 X150.375 Y122.731 E.0009
G1 X151.577 Y122.588 F30000
; LINE_WIDTH: 0.524154
G1 F13091.352
G1 X151.876 Y122.552 E.01184
; LINE_WIDTH: 0.482525
G1 F14331.043
G1 X152.176 Y122.517 E.01082
; LINE_WIDTH: 0.461013
G1 F15000
G3 X152.418 Y122.514 I.145 J2.033 E.00824
G1 X152.479 Y122.536 E.00219
; LINE_WIDTH: 0.522337
G1 F13140.957
G1 X152.539 Y122.558 E.00252
; LINE_WIDTH: 0.566638
G1 F12029.376
G1 X152.599 Y122.58 E.00275
; LINE_WIDTH: 0.610939
G1 F11091.185
G1 X152.66 Y122.602 E.00298
; LINE_WIDTH: 0.65524
G1 F10288.747
G1 X152.72 Y122.624 E.00321
; LINE_WIDTH: 0.655504
G1 F10284.313
G1 X152.747 Y122.805 E.00909
; LINE_WIDTH: 0.612977
G1 F11051.529
G1 X152.772 Y122.98 E.00821
; LINE_WIDTH: 0.571078
G1 F11928.263
G1 X152.798 Y123.155 E.00761
; LINE_WIDTH: 0.529178
G1 F12956.083
G1 X152.824 Y123.33 E.00701
; LINE_WIDTH: 0.487279
G1 F14177.738
G1 X152.849 Y123.505 E.0064
; LINE_WIDTH: 0.44538
G1 F15000
G1 X152.875 Y123.68 E.0058
; CHANGE_LAYER
; Z_HEIGHT: 4
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F15000
G1 X152.849 Y123.505 E-.76
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 20/101
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L20
M991 S0 P19 ;notify layer change
G17
G3 Z4.2 I-.001 J-1.217 P1  F30000
G1 X104.366 Y123.553 Z4.2
G1 Z4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X104.366 Y129.15 E.18567
G1 X148.331 Y129.15 E1.45842
G1 X149.868 Y129.474 E.05209
G1 X150.116 Y128.484 E.03385
G2 X152.842 Y129.091 I9.967 J-38.304 E.09265
G1 X152.842 Y129.787 E.02308
G1 X138.13 Y129.787 E.488
G3 X136.389 Y132.044 I-18.321 J-12.333 E.09464
G1 X135.967 Y132.468 E.01984
G3 X133.611 Y133.373 I-2.395 J-2.717 E.08552
G1 X104.046 Y133.373 E.98073
G1 X104.046 Y118.627 E.48918
G1 X133.771 Y118.639 E.98605
G3 X135.967 Y119.532 I-.176 J3.579 E.08014
G1 X136.389 Y119.956 E.01984
G3 X138.13 Y122.213 I-16.58 J14.591 E.09464
G1 X152.842 Y122.213 E.488
G1 X152.842 Y122.909 E.02308
G2 X150.116 Y123.516 I7.242 J38.912 E.09265
G1 X149.868 Y122.526 E.03385
G1 X148.331 Y122.85 E.05209
G1 X104.366 Y122.85 E1.45842
G1 X104.366 Y123.493 E.02133
; WIPE_START
G1 X104.366 Y125.493 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X105.234 Y124.421 Z4.4 F30000
G1 Z4
G1 E.8 F1800
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
G1 X105.234 Y127.579 E.09706
G1 X148.414 Y127.579 E1.3268
G1 X150.206 Y128.102 E.05738
G2 X153.234 Y128.765 I9.967 J-38.316 E.09525
G1 X153.234 Y129.53 E.02352
G1 F4479.636
G1 X153.234 Y129.93 E.01229
G1 F840
G1 X153.234 Y130.179 E.00767
G1 F960
G1 X152.303 Y130.179 E.02861
G1 F1080
G1 X151.371 Y130.179 E.02861
G1 F1200
G1 X150.44 Y130.179 E.02861
G1 F1320
G1 X149.509 Y130.179 E.02861
G1 F1440
G1 X148.578 Y130.179 E.02861
G1 F1560
G1 X147.647 Y130.179 E.02861
G1 F1680
G1 X146.715 Y130.179 E.02861
G1 F1800
G1 X144.853 Y130.179 E.05723
G1 F1920
G1 X143.922 Y130.179 E.02861
G1 F2040
G1 X142.99 Y130.179 E.02861
G1 F2160
G1 X142.059 Y130.179 E.02861
G1 F2280
G1 X141.128 Y130.179 E.02861
G1 F2400
G1 X140.197 Y130.179 E.02861
G1 F2520
G1 X139.266 Y130.179 E.02861
G1 F2640
G1 X138.334 Y130.179 E.02861
G1 X137.93 Y130.757 E.02168
G1 F2760
G1 X137.719 Y131.036 E.01074
G1 F2880
G3 X136.679 Y132.309 I-24.51 J-18.974 E.0505
G1 F2760
G1 X136.229 Y132.761 E.01961
G3 X135.247 Y133.401 I-3.133 J-3.735 E.0361
G1 F2640
G1 X134.72 Y133.603 E.01733
G1 F2520
G3 X133.626 Y133.765 I-1.096 J-3.607 E.03412
G1 X103.654 Y133.765 E.92095
G1 F3798.292
G1 X103.654 Y133.645 E.0037
G1 F9915.702
G1 X103.654 Y133.245 E.01229
G1 F12000
G1 X103.654 Y132.845 E.01229
G1 X103.654 Y119.155 E.42065
G1 X103.654 Y118.755 E.01229
G1 F7769.882
G1 X103.654 Y118.355 E.01229
G1 F2520
G1 X103.654 Y118.235 E.0037
G1 X133.626 Y118.235 E.92095
G1 X133.8 Y118.248 E.00539
G1 X134.18 Y118.276 E.0117
G1 F2640
G1 X134.72 Y118.397 E.01701
G1 F2760
G3 X136.229 Y119.239 I-1.46 J4.391 E.0534
G1 F2880
G1 X136.679 Y119.691 E.01961
G1 X137.326 Y120.466 E.03103
G1 F2760
G1 X137.719 Y120.964 E.01947
G1 F2640
G3 X138.334 Y121.821 I-12.152 J9.372 E.03243
G1 F2520
G1 X139.266 Y121.821 E.02861
G1 F2400
G1 X140.197 Y121.821 E.02861
G1 F2280
G1 X141.128 Y121.821 E.02861
G1 F2160
G1 X142.059 Y121.821 E.02861
G1 F2040
G1 X142.99 Y121.821 E.02861
G1 F1920
G1 X143.922 Y121.821 E.02861
G1 F1800
G1 X145.784 Y121.821 E.05723
G1 F1680
G1 X146.715 Y121.821 E.02861
G1 F1560
G1 X147.647 Y121.821 E.02861
G1 F1440
G1 X148.578 Y121.821 E.02861
G1 F1320
G1 X149.509 Y121.821 E.02861
G1 F1200
G1 X150.44 Y121.821 E.02861
G1 F1080
G1 X151.371 Y121.821 E.02861
G1 F960
G1 X152.303 Y121.821 E.02861
G1 F840
G1 X153.234 Y121.821 E.02861
G1 F2772.006
G1 X153.234 Y122.07 E.00767
G1 F8207.848
G1 X153.234 Y122.47 E.01229
G1 F12000
G1 X153.234 Y123.235 E.02352
G2 X150.206 Y123.898 I6.94 J38.978 E.09525
G1 X148.414 Y124.421 E.05738
G1 X105.294 Y124.421 E1.32496
M204 S10000
; WIPE_START
G1 X105.256 Y126.42 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X104.831 Y125.462 Z4.4 F30000
G1 Z4
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.508038
G1 F13544.95
G2 X104.829 Y125.563 I-.029 J.05 E.0091
G1 X104.421 Y119.002 F30000
; LINE_WIDTH: 0.384313
G1 F15000
G1 X133.6 Y119.008 E.81173
G3 X135.9 Y119.96 I-.056 J3.388 E.0709
G1 X136.461 Y120.585 E.02339
G1 X137.182 Y121.52 E.03284
G1 X136.997 Y122.444 F30000
; LINE_WIDTH: 0.462136
G1 F15000
G1 X137.295 Y122.43 E.01019
; LINE_WIDTH: 0.49504
G1 F13934.374
G3 X137.671 Y122.416 I.337 J3.977 E.01385
G1 X137.671 Y122.338 E.00286
; LINE_WIDTH: 0.490675
G1 F14070.193
G1 X137.494 Y122.047 E.01242
; LINE_WIDTH: 0.463459
G1 F14980.774
G1 X137.316 Y121.757 E.01167
; LINE_WIDTH: 0.433119
G1 F15000
G1 X137.268 Y121.662 E.00338
; LINE_WIDTH: 0.410531
G1 X137.219 Y121.568 E.00318
G1 X137.265 Y121.76 E.00592
; LINE_WIDTH: 0.463459
G1 F14980.774
G1 X137.206 Y121.885 E.00473
; LINE_WIDTH: 0.483048
G1 F14314.032
G1 X137.148 Y122.01 E.00495
G1 X136.997 Y122.039 E.0055
; LINE_WIDTH: 0.448086
G1 F15000
G1 X104.999 Y122.039 E1.05644
; LINE_WIDTH: 0.461255
G1 X104.925 Y122.024 E.00258
; LINE_WIDTH: 0.499817
G1 F13788.665
G1 X104.85 Y122.01 E.00282
G1 X104.677 Y121.861 E.0085
G1 X104.478 Y121.861 E.0074
G1 X104.478 Y122.417 E.0207
; LINE_WIDTH: 0.487592
G1 F14167.762
G1 X104.739 Y122.431 E.00945
; LINE_WIDTH: 0.448193
G1 F15000
G1 X104.999 Y122.444 E.00862
G1 X136.937 Y122.444 E1.05474
G1 X138.105 Y122.531 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.272474
G1 F15000
G1 X148.298 Y122.531 E.19067
G1 X148.516 Y122.509 E.0041
; LINE_WIDTH: 0.206932
G1 X148.734 Y122.486 E.00293
; LINE_WIDTH: 0.162927
G1 X148.952 Y122.463 E.00214
; LINE_WIDTH: 0.118923
G1 X149.17 Y122.441 E.00136
G1 X150.299 Y122.61 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.430647
G1 F15000
G1 X150.406 Y123.038 E.01392
G1 X151.013 Y122.891 E.01973
G1 X150.984 Y122.61 E.00893
G1 X150.359 Y122.61 E.01975
G1 X149.881 Y123.494 F30000
M204 S2000
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F12000
G1 X149.482 Y123.893 E.01736
G1 X148.729 Y124.113
G1 X149.774 Y123.067 E.04543
G1 X149.471 Y122.837
G1 X148.095 Y124.213 E.0598
G1 X147.562 Y124.213
G1 X148.796 Y122.979 E.05362
G1 X148.169 Y123.072
G1 X147.028 Y124.213 E.04958
G1 X146.495 Y124.213
G1 X147.636 Y123.072 E.04958
G1 X147.103 Y123.072
G1 X145.962 Y124.213 E.04958
G1 X145.429 Y124.213
G1 X146.57 Y123.072 E.04958
G1 X146.036 Y123.072
G1 X144.895 Y124.213 E.04958
G1 X144.362 Y124.213
G1 X145.503 Y123.072 E.04958
G1 X144.97 Y123.072
G1 X143.829 Y124.213 E.04958
G1 X143.296 Y124.213
G1 X144.437 Y123.072 E.04958
G1 X143.903 Y123.072
G1 X142.762 Y124.213 E.04958
G1 X142.229 Y124.213
G1 X143.37 Y123.072 E.04958
G1 X142.837 Y123.072
G1 X141.696 Y124.213 E.04958
G1 X141.162 Y124.213
G1 X142.303 Y123.072 E.04958
G1 X141.77 Y123.072
G1 X140.629 Y124.213 E.04958
G1 X140.096 Y124.213
G1 X141.237 Y123.072 E.04958
G1 X140.704 Y123.072
G1 X139.563 Y124.213 E.04958
G1 X139.029 Y124.213
G1 X140.17 Y123.072 E.04958
G1 X139.637 Y123.072
G1 X138.496 Y124.213 E.04958
G1 X137.963 Y124.213
G1 X139.104 Y123.072 E.04958
G1 X138.571 Y123.072
G1 X137.43 Y124.213 E.04958
G1 X136.896 Y124.213
G1 X138.037 Y123.072 E.04958
G1 X137.504 Y123.072
G1 X136.363 Y124.213 E.04958
G1 X135.83 Y124.213
G1 X136.971 Y123.072 E.04958
G1 X136.437 Y123.072
G1 X135.297 Y124.213 E.04958
G1 X134.763 Y124.213
G1 X135.904 Y123.072 E.04958
G1 X135.371 Y123.072
G1 X134.23 Y124.213 E.04958
G1 X133.697 Y124.213
G1 X134.838 Y123.072 E.04958
G1 X134.304 Y123.072
G1 X133.163 Y124.213 E.04958
G1 X132.63 Y124.213
G1 X133.771 Y123.072 E.04958
G1 X133.238 Y123.072
G1 X132.097 Y124.213 E.04958
G1 X131.564 Y124.213
G1 X132.705 Y123.072 E.04958
G1 X132.171 Y123.072
G1 X131.03 Y124.213 E.04958
G1 X130.497 Y124.213
G1 X131.638 Y123.072 E.04958
G1 X131.105 Y123.072
G1 X129.964 Y124.213 E.04958
G1 X129.431 Y124.213
G1 X130.571 Y123.072 E.04958
G1 X130.038 Y123.072
G1 X128.897 Y124.213 E.04958
G1 X128.364 Y124.213
G1 X129.505 Y123.072 E.04958
G1 X128.972 Y123.072
G1 X127.831 Y124.213 E.04958
G1 X127.297 Y124.213
G1 X128.438 Y123.072 E.04958
G1 X127.905 Y123.072
G1 X126.764 Y124.213 E.04958
G1 X126.231 Y124.213
G1 X127.372 Y123.072 E.04958
G1 X126.839 Y123.072
G1 X125.698 Y124.213 E.04958
G1 X125.164 Y124.213
G1 X126.305 Y123.072 E.04958
G1 X125.772 Y123.072
G1 X124.631 Y124.213 E.04958
G1 X124.098 Y124.213
G1 X125.239 Y123.072 E.04958
G1 X124.706 Y123.072
G1 X123.565 Y124.213 E.04958
G1 X123.031 Y124.213
G1 X124.172 Y123.072 E.04958
G1 X123.639 Y123.072
G1 X122.498 Y124.213 E.04958
G1 X121.965 Y124.213
G1 X123.106 Y123.072 E.04958
G1 X122.572 Y123.072
G1 X121.431 Y124.213 E.04958
G1 X120.898 Y124.213
G1 X122.039 Y123.072 E.04958
G1 X121.506 Y123.072
G1 X120.365 Y124.213 E.04958
G1 X119.832 Y124.213
G1 X120.973 Y123.072 E.04958
G1 X120.439 Y123.072
G1 X119.298 Y124.213 E.04958
G1 X118.765 Y124.213
G1 X119.906 Y123.072 E.04958
G1 X119.373 Y123.072
G1 X118.232 Y124.213 E.04958
G1 X117.699 Y124.213
G1 X118.84 Y123.072 E.04958
G1 X118.306 Y123.072
G1 X117.165 Y124.213 E.04958
G1 X116.632 Y124.213
G1 X117.773 Y123.072 E.04958
G1 X117.24 Y123.072
G1 X116.099 Y124.213 E.04958
G1 X115.566 Y124.213
G1 X116.706 Y123.072 E.04958
G1 X116.173 Y123.072
G1 X115.032 Y124.213 E.04958
G1 X114.499 Y124.213
G1 X115.64 Y123.072 E.04958
G1 X115.107 Y123.072
G1 X113.966 Y124.213 E.04958
G1 X113.432 Y124.213
G1 X114.573 Y123.072 E.04958
M73 P51 R9
G1 X114.04 Y123.072
G1 X112.899 Y124.213 E.04958
G1 X112.366 Y124.213
G1 X113.507 Y123.072 E.04958
G1 X112.974 Y123.072
G1 X111.833 Y124.213 E.04958
G1 X111.299 Y124.213
G1 X112.44 Y123.072 E.04958
G1 X111.907 Y123.072
G1 X110.766 Y124.213 E.04958
G1 X110.233 Y124.213
G1 X111.374 Y123.072 E.04958
G1 X110.84 Y123.072
G1 X109.7 Y124.213 E.04958
G1 X109.166 Y124.213
G1 X110.307 Y123.072 E.04958
G1 X109.774 Y123.072
G1 X108.633 Y124.213 E.04958
G1 X108.1 Y124.213
G1 X109.241 Y123.072 E.04958
G1 X108.707 Y123.072
G1 X107.566 Y124.213 E.04958
G1 X107.033 Y124.213
G1 X108.174 Y123.072 E.04958
G1 X107.641 Y123.072
G1 X106.5 Y124.213 E.04958
G1 X105.967 Y124.213
G1 X107.108 Y123.072 E.04958
G1 X106.574 Y123.072
G1 X105.433 Y124.213 E.04958
G1 X105.026 Y124.62
G1 X104.588 Y125.058 E.01903
G1 X104.588 Y124.525
G1 X106.041 Y123.072 E.06313
G1 X105.508 Y123.072
G1 X104.588 Y123.992 E.03995
G1 X104.588 Y123.458
G1 X104.975 Y123.072 E.01678
M204 S10000
G1 X105.045 Y125.164 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.10949
G1 F15000
G1 X104.746 Y125.215 E.00165
G3 X104.693 Y125.199 I-.009 J-.065 E.00031
G1 X104.57 Y125.101 E.00086
G1 X104.841 Y132.623 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X106.469 Y132.623 E.05401
G1 X108.724 Y130.368 E.10581
G1 X109.783 Y130.368 E.03513
G1 X112.039 Y132.623 E.10581
G1 X114.145 Y132.623 E.06986
G1 X116.4 Y130.368 E.10581
G1 X117.459 Y130.368 E.03513
G1 X119.715 Y132.623 E.10581
G1 X121.821 Y132.623 E.06986
G1 X124.076 Y130.368 E.10581
G1 X125.135 Y130.368 E.03513
G1 X127.391 Y132.623 E.10581
G1 X129.497 Y132.623 E.06986
G1 X131.752 Y130.368 E.10581
G1 X132.811 Y130.368 E.03513
G1 X134.8 Y132.356 E.09329
G2 X136.057 Y131.345 I-2.56 J-4.469 E.05372
G1 X138.105 Y129.469 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.272474
G1 F15000
G1 X148.298 Y129.469 E.19067
G1 X148.516 Y129.491 E.0041
; LINE_WIDTH: 0.20693
G1 X148.734 Y129.514 E.00293
; LINE_WIDTH: 0.162926
G1 X148.952 Y129.537 E.00214
; LINE_WIDTH: 0.118922
G1 X149.17 Y129.559 E.00136
G1 X149.091 Y129.083 F30000
M204 S2000
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F12000
G1 X149.935 Y128.239 E.03666
G1 X149.522 Y128.119
G1 X148.651 Y128.99 E.03786
G1 X148.18 Y128.928
G1 X149.109 Y127.998 E.04039
G1 X148.696 Y127.878
G1 X147.647 Y128.928 E.04562
G1 X147.113 Y128.928
G1 X148.254 Y127.787 E.04958
G1 X147.721 Y127.787
G1 X146.58 Y128.928 E.04958
G1 X146.047 Y128.928
G1 X147.188 Y127.787 E.04958
G1 X146.655 Y127.787
G1 X145.514 Y128.928 E.04958
G1 X144.98 Y128.928
G1 X146.121 Y127.787 E.04958
G1 X145.588 Y127.787
G1 X144.447 Y128.928 E.04958
G1 X143.914 Y128.928
G1 X145.055 Y127.787 E.04958
G1 X144.521 Y127.787
G1 X143.381 Y128.928 E.04958
G1 X142.847 Y128.928
G1 X143.988 Y127.787 E.04958
G1 X143.455 Y127.787
G1 X142.314 Y128.928 E.04958
G1 X141.781 Y128.928
G1 X142.922 Y127.787 E.04958
G1 X142.388 Y127.787
G1 X141.247 Y128.928 E.04958
G1 X140.714 Y128.928
G1 X141.855 Y127.787 E.04958
G1 X141.322 Y127.787
G1 X140.181 Y128.928 E.04958
G1 X139.648 Y128.928
G1 X140.789 Y127.787 E.04958
G1 X140.255 Y127.787
G1 X139.114 Y128.928 E.04958
G1 X138.581 Y128.928
G1 X139.722 Y127.787 E.04958
G1 X139.189 Y127.787
G1 X138.048 Y128.928 E.04958
G1 X137.515 Y128.928
G1 X138.655 Y127.787 E.04958
G1 X138.122 Y127.787
G1 X136.981 Y128.928 E.04958
G1 X136.448 Y128.928
G1 X137.589 Y127.787 E.04958
G1 X137.056 Y127.787
G1 X135.915 Y128.928 E.04958
G1 X135.381 Y128.928
G1 X136.522 Y127.787 E.04958
G1 X135.989 Y127.787
G1 X134.848 Y128.928 E.04958
G1 X134.315 Y128.928
G1 X135.456 Y127.787 E.04958
G1 X134.923 Y127.787
G1 X133.782 Y128.928 E.04958
G1 X133.248 Y128.928
G1 X134.389 Y127.787 E.04958
G1 X133.856 Y127.787
G1 X132.715 Y128.928 E.04958
G1 X132.182 Y128.928
G1 X133.323 Y127.787 E.04958
G1 X132.79 Y127.787
G1 X131.649 Y128.928 E.04958
G1 X131.115 Y128.928
G1 X132.256 Y127.787 E.04958
G1 X131.723 Y127.787
G1 X130.582 Y128.928 E.04958
G1 X130.049 Y128.928
G1 X131.19 Y127.787 E.04958
G1 X130.656 Y127.787
G1 X129.515 Y128.928 E.04958
G1 X128.982 Y128.928
G1 X130.123 Y127.787 E.04958
G1 X129.59 Y127.787
G1 X128.449 Y128.928 E.04958
G1 X127.916 Y128.928
G1 X129.057 Y127.787 E.04958
G1 X128.523 Y127.787
G1 X127.382 Y128.928 E.04958
G1 X126.849 Y128.928
G1 X127.99 Y127.787 E.04958
G1 X127.457 Y127.787
G1 X126.316 Y128.928 E.04958
G1 X125.783 Y128.928
G1 X126.924 Y127.787 E.04958
G1 X126.39 Y127.787
G1 X125.249 Y128.928 E.04958
G1 X124.716 Y128.928
G1 X125.857 Y127.787 E.04958
G1 X125.324 Y127.787
G1 X124.183 Y128.928 E.04958
G1 X123.65 Y128.928
G1 X124.79 Y127.787 E.04958
G1 X124.257 Y127.787
G1 X123.116 Y128.928 E.04958
G1 X122.583 Y128.928
G1 X123.724 Y127.787 E.04958
G1 X123.191 Y127.787
G1 X122.05 Y128.928 E.04958
G1 X121.516 Y128.928
G1 X122.657 Y127.787 E.04958
G1 X122.124 Y127.787
G1 X120.983 Y128.928 E.04958
G1 X120.45 Y128.928
G1 X121.591 Y127.787 E.04958
G1 X121.058 Y127.787
G1 X119.917 Y128.928 E.04958
G1 X119.383 Y128.928
G1 X120.524 Y127.787 E.04958
G1 X119.991 Y127.787
G1 X118.85 Y128.928 E.04958
G1 X118.317 Y128.928
G1 X119.458 Y127.787 E.04958
G1 X118.924 Y127.787
G1 X117.784 Y128.928 E.04958
G1 X117.25 Y128.928
G1 X118.391 Y127.787 E.04958
G1 X117.858 Y127.787
G1 X116.717 Y128.928 E.04958
G1 X116.184 Y128.928
G1 X117.325 Y127.787 E.04958
G1 X116.791 Y127.787
G1 X115.65 Y128.928 E.04958
G1 X115.117 Y128.928
G1 X116.258 Y127.787 E.04958
G1 X115.725 Y127.787
G1 X114.584 Y128.928 E.04958
G1 X114.051 Y128.928
G1 X115.192 Y127.787 E.04958
G1 X114.658 Y127.787
G1 X113.517 Y128.928 E.04958
G1 X112.984 Y128.928
G1 X114.125 Y127.787 E.04958
G1 X113.592 Y127.787
G1 X112.451 Y128.928 E.04958
G1 X111.918 Y128.928
G1 X113.059 Y127.787 E.04958
G1 X112.525 Y127.787
G1 X111.384 Y128.928 E.04958
G1 X110.851 Y128.928
G1 X111.992 Y127.787 E.04958
G1 X111.459 Y127.787
G1 X110.318 Y128.928 E.04958
G1 X109.784 Y128.928
G1 X110.925 Y127.787 E.04958
G1 X110.392 Y127.787
G1 X109.251 Y128.928 E.04958
G1 X108.718 Y128.928
G1 X109.859 Y127.787 E.04958
G1 X109.326 Y127.787
G1 X108.185 Y128.928 E.04958
G1 X107.651 Y128.928
G1 X108.792 Y127.787 E.04958
G1 X108.259 Y127.787
G1 X107.118 Y128.928 E.04958
G1 X106.585 Y128.928
G1 X107.726 Y127.787 E.04958
G1 X107.193 Y127.787
G1 X106.052 Y128.928 E.04958
G1 X105.518 Y128.928
G1 X106.659 Y127.787 E.04958
G1 X106.126 Y127.787
G1 X104.985 Y128.928 E.04958
G1 X104.588 Y128.791
G1 X105.593 Y127.787 E.04364
G1 X105.059 Y127.787
G1 X104.588 Y128.258 E.02047
G1 X104.588 Y127.725
G1 X105.026 Y127.287 E.01903
G1 X105.026 Y126.753
G1 X104.588 Y127.191 E.01903
M204 S10000
G1 X104.421 Y132.998 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.385954
G1 F15000
G1 X133.597 Y132.998 E.81556
G2 X135.91 Y132.03 I-.082 J-3.442 E.07172
G2 X137.198 Y130.46 I-14.258 J-13.011 E.05681
G1 X136.997 Y129.556 F30000
; LINE_WIDTH: 0.448086
G1 F15000
G1 X104.999 Y129.556 E1.05644
; LINE_WIDTH: 0.461255
G1 X104.739 Y129.569 E.00889
; LINE_WIDTH: 0.498007
G1 F13843.521
G1 X104.478 Y129.583 E.00967
G1 X104.478 Y130.139 E.02062
G1 X104.677 Y130.139 E.00737
G1 X104.853 Y129.988 E.0086
; LINE_WIDTH: 0.487592
G1 F14167.762
G1 X104.926 Y129.975 E.00269
; LINE_WIDTH: 0.448117
G1 F15000
G1 X104.999 Y129.961 E.00245
G1 X136.997 Y129.961 E1.05652
; LINE_WIDTH: 0.462136
G1 X137.073 Y129.975 E.00262
; LINE_WIDTH: 0.476995
G1 F14513.623
G1 X137.148 Y129.99 E.00271
G1 X137.261 Y130.242 E.00978
; LINE_WIDTH: 0.427497
G1 F15000
G1 X137.247 Y130.327 E.0027
; LINE_WIDTH: 0.397779
G1 X137.233 Y130.411 E.00249
; LINE_WIDTH: 0.403148
G1 X137.318 Y130.257 E.00518
; LINE_WIDTH: 0.443602
G1 X137.403 Y130.102 E.00576
; LINE_WIDTH: 0.498265
G1 F13835.662
G3 X137.671 Y129.662 I3.374 J1.751 E.01913
G1 X137.671 Y129.584 E.00288
; LINE_WIDTH: 0.490234
G1 F14084.073
G1 X137.364 Y129.572 E.01119
; LINE_WIDTH: 0.462136
G1 F15000
G1 X137.057 Y129.559 E.01049
; WIPE_START
G1 X137.364 Y129.572 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X136.257 Y122.02 Z4.4 F30000
G1 X136.057 Y120.655 Z4.4
G1 Z4
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F15476.087
G2 X134.8 Y119.644 I-3.817 J3.459 E.05372
G1 X132.811 Y121.632 E.09329
G1 X131.752 Y121.632 E.03513
G1 X129.497 Y119.377 E.10581
G1 X127.391 Y119.377 E.06986
G1 X125.135 Y121.632 E.10581
G1 X124.076 Y121.632 E.03513
G1 X121.821 Y119.377 E.10581
G1 X119.715 Y119.377 E.06986
G1 X117.459 Y121.632 E.10581
G1 X116.4 Y121.632 E.03513
G1 X114.145 Y119.377 E.10581
G1 X112.039 Y119.377 E.06986
G1 X109.783 Y121.632 E.10581
G1 X108.724 Y121.632 E.03513
G1 X106.469 Y119.377 E.10581
G1 X104.841 Y119.377 E.05401
; WIPE_START
G1 X106.469 Y119.377 E-.61876
G1 X106.732 Y119.64 E-.14124
; WIPE_END
G1 E-.04 F1800
G1 X114.18 Y121.307 Z4.4 F30000
G1 X150.299 Y129.39 Z4.4
G1 Z4
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.430647
G1 F15000
G1 X150.984 Y129.39 E.02165
G1 X151.013 Y129.109 E.00893
G1 X150.406 Y128.962 E.01973
G1 X150.313 Y129.332 E.01202
G1 X151.393 Y129.298 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.536685
G1 F12759.124
G1 X151.715 Y129.331 E.01302
; LINE_WIDTH: 0.487546
G1 F14169.217
G1 X152.037 Y129.365 E.01172
; LINE_WIDTH: 0.438408
G1 F15000
G1 X152.358 Y129.398 E.01043
; LINE_WIDTH: 0.404065
G1 X152.638 Y129.424 E.00827
; WIPE_START
G1 X152.358 Y129.398 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X152.037 Y122.635 Z4.4 F30000
G1 Z4
G1 E.8 F1800
; LINE_WIDTH: 0.438408
G1 F15000
G1 X152.358 Y122.602 E.01043
; LINE_WIDTH: 0.404065
G1 X152.638 Y122.576 E.00827
G1 X152.037 Y122.635 F30000
; LINE_WIDTH: 0.487547
G1 F14169.198
G1 X151.715 Y122.669 E.01172
; LINE_WIDTH: 0.536685
G1 F12759.111
G1 X151.393 Y122.702 E.01302
; CHANGE_LAYER
; Z_HEIGHT: 4.2
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F12759.111
G1 X151.715 Y122.669 E-.76
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 21/101
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L21
M991 S0 P20 ;notify layer change
G17
G3 Z4.4 I-.017 J-1.217 P1  F30000
G1 X104.842 Y123.326 Z4.4
G1 Z4.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X104.842 Y128.674 E.17743
G1 X148.381 Y128.674 E1.44428
G2 X152.842 Y129.549 I18.738 J-83.76 E.1508
G1 X152.842 Y130.062 E.01703
M73 P52 R9
G1 X138.135 Y130.062 E.48784
G3 X135.985 Y132.626 I-15.415 J-10.748 E.11115
G3 X133.611 Y133.535 I-2.468 J-2.891 E.08596
G1 X104.046 Y133.535 E.98073
G1 X104.046 Y118.465 E.49989
G1 X133.615 Y118.465 E.98086
G3 X136.398 Y119.785 I-.1 J3.806 E.10517
G3 X138.135 Y121.938 I-22.209 J19.701 E.09181
G1 X152.842 Y121.938 E.48784
G1 X152.842 Y122.451 E.01703
G2 X148.381 Y123.326 I14.278 J84.635 E.1508
G1 X104.902 Y123.326 E1.44229
G1 X105.234 Y123.718 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
G1 X105.234 Y128.282 E.14026
G1 X148.422 Y128.282 E1.32705
G2 X153.234 Y129.22 I28.117 J-131.508 E.15064
G1 X153.234 Y129.82 E.01845
G1 F5014.153
G1 X153.234 Y130.22 E.01229
G1 F1080
G1 X153.234 Y130.455 E.0072
G1 F1200
G1 X152.303 Y130.455 E.02861
G1 F1320
G1 X150.44 Y130.455 E.05722
G1 F1440
G1 X149.509 Y130.455 E.02861
G1 F1560
G1 X148.578 Y130.455 E.02861
G1 F1680
G1 X147.647 Y130.455 E.02861
G1 F1800
G1 X145.785 Y130.455 E.05722
G1 F1920
G1 X144.854 Y130.455 E.02861
G1 F2040
G1 X143.923 Y130.455 E.02861
G1 F2160
G1 X142.992 Y130.455 E.02861
G1 F2280
G1 X141.129 Y130.455 E.05722
G1 F2400
G1 X140.198 Y130.455 E.02861
G1 F2520
G1 X139.267 Y130.455 E.02861
G1 F2640
G1 X138.336 Y130.455 E.02861
G1 X138.117 Y130.76 E.01155
G1 F2880
G3 X137.047 Y132.077 I-25.38 J-19.509 E.05215
G1 F3000
G1 X136.893 Y132.254 E.0072
G1 F3900
G1 X136.328 Y132.843 E.02508
G1 F2880
G1 X135.754 Y133.283 E.02223
G1 F2760
G1 X135.247 Y133.563 E.01778
G1 F2640
G1 X134.72 Y133.764 E.01733
G1 F2520
G3 X133.626 Y133.927 I-1.096 J-3.607 E.03412
G1 X103.654 Y133.927 E.92095
G1 F3798.281
G1 X103.654 Y133.806 E.0037
G1 F9915.683
G1 X103.654 Y133.406 E.01229
G1 F12000
G1 X103.654 Y133.006 E.01229
G1 X103.654 Y118.994 E.43058
G1 X103.654 Y118.594 E.01229
G1 F7769.882
G1 X103.654 Y118.194 E.01229
G1 F2520
G1 X103.654 Y118.073 E.0037
G1 X133.63 Y118.073 E.92107
G1 X134.18 Y118.114 E.01696
G1 F2640
G1 X134.72 Y118.236 E.01701
G1 F2760
G1 X135.247 Y118.437 E.01733
G1 F2880
G3 X136.235 Y119.071 I-1.9 J4.049 E.03617
G1 F3900
G1 X136.682 Y119.514 E.01934
G1 F3000
G1 X136.893 Y119.746 E.00963
G1 F2880
G3 X137.575 Y120.555 I-17.655 J15.577 E.03249
G1 F2640
G3 X138.336 Y121.545 I-10.613 J8.948 E.03841
G1 F2520
G1 X139.267 Y121.545 E.02861
G1 F2400
G1 X140.198 Y121.545 E.02861
G1 F2280
G1 X142.061 Y121.545 E.05722
G1 F2160
G1 X142.992 Y121.545 E.02861
G1 F2040
G1 X143.923 Y121.545 E.02861
G1 F1920
G1 X144.854 Y121.545 E.02861
G1 F1800
G1 X146.716 Y121.545 E.05722
G1 F1680
G1 X147.647 Y121.545 E.02861
G1 F1560
G1 X148.578 Y121.545 E.02861
G1 F1440
G1 X149.509 Y121.545 E.02861
G1 F1320
G1 X151.372 Y121.545 E.05722
G1 F1200
G1 X152.303 Y121.545 E.02861
G1 F1080
G1 X153.234 Y121.545 E.02861
G1 F3034.778
G1 X153.234 Y121.78 E.0072
G1 F8655.726
G1 X153.234 Y122.18 E.01229
G1 F12000
G1 X153.234 Y122.78 E.01845
G1 X153.133 Y122.796 E.00313
G2 X148.422 Y123.718 I15.037 J89.393 E.14753
G1 X105.294 Y123.718 E1.32521
M204 S10000
; WIPE_START
G1 X105.267 Y125.717 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X104.444 Y123.122 Z4.6 F30000
G1 Z4.2
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.431684
G1 F15000
G1 X104.444 Y128.878 E.18234
G1 X104.421 Y133.16 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.385966
G1 F15000
G1 X133.597 Y133.16 E.81559
G2 X135.908 Y132.217 I-.077 J-3.491 E.07135
G2 X136.946 Y131.027 I-7.449 J-7.551 E.04417
G1 X137.153 Y130.762 E.00939
G1 X136.97 Y130.277 F30000
; LINE_WIDTH: 0.41041
G1 F15000
G1 X137.094 Y130.324 E.00399
G1 X137.208 Y130.566 E.008
G1 X137.19 Y130.715 E.0045
G3 X137.878 Y129.749 I36.892 J25.548 E.03552
; LINE_WIDTH: 0.439522
G1 X137.915 Y129.704 E.00186
; LINE_WIDTH: 0.478568
G1 F14461.216
G1 X137.952 Y129.66 E.00205
; LINE_WIDTH: 0.533385
G1 F12844.952
G3 X138.031 Y129.614 I.061 J.013 E.00414
G1 X149.76 Y129.614 E.46877
G1 X149.777 Y129.427 E.00749
G1 X148.334 Y129.123 E.05893
G1 X138.031 Y129.123 E.41179
; LINE_WIDTH: 0.514517
G1 F13358.877
G1 X137.864 Y129.104 E.00648
; LINE_WIDTH: 0.47671
G1 F14523.173
G1 X137.696 Y129.085 E.00596
; LINE_WIDTH: 0.420047
G1 F15000
G1 X137.529 Y129.066 E.00518
G1 X105.052 Y129.066 E.99805
G1 X104.989 Y129.222 E.00514
G1 X104.863 Y129.27 E.00415
G1 X104.438 Y129.27 E.01307
G1 X104.438 Y130.48 E.0372
G1 X104.692 Y130.48 E.00781
G1 X104.985 Y130.278 E.01094
G1 X136.91 Y130.277 E.98109
G1 X136.97 Y129.463 F30000
; LINE_WIDTH: 0.459605
G1 F15000
G1 X105.278 Y129.463 E1.07606
G1 X105.255 Y129.517 E.00199
; LINE_WIDTH: 0.435034
G1 X105.059 Y129.567 E.00646
; LINE_WIDTH: 0.367307
G3 X104.786 Y129.618 I-.234 J-.504 E.00742
G1 X104.786 Y130.002 E.01016
G1 X104.999 Y129.928 E.00598
; LINE_WIDTH: 0.388311
G1 X105.197 Y129.904 E.00559
; LINE_WIDTH: 0.459457
G1 X105.394 Y129.88 E.00674
G1 X136.97 Y129.88 E1.07176
; LINE_WIDTH: 0.468627
G1 F14798.939
G3 X137.233 Y129.955 I.044 J.347 E.00977
G1 X137.551 Y129.513 E.01887
G1 X137.621 Y129.469 E.00288
G1 X137.03 Y129.464 E.02053
G1 X136.16 Y131.44 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F15476.087
G3 X134.924 Y132.48 I-4.599 J-4.207 E.05375
G1 X133.113 Y130.669 E.08498
G1 X131.451 Y130.669 E.05513
G1 X129.335 Y132.784 E.09924
G1 X127.552 Y132.784 E.05915
G1 X125.437 Y130.669 E.09924
G1 X123.775 Y130.669 E.05513
G1 X121.659 Y132.784 E.09924
G1 X119.876 Y132.784 E.05915
G1 X117.761 Y130.669 E.09924
G1 X116.099 Y130.669 E.05513
G1 X113.983 Y132.784 E.09924
G1 X112.2 Y132.784 E.05915
G1 X110.085 Y130.669 E.09924
G1 X108.423 Y130.669 E.05513
G1 X106.307 Y132.784 E.09924
G1 X104.524 Y132.784 E.05915
G1 X104.394 Y132.654 E.00611
G1 X104.394 Y131.026 E.05401
G1 X104.394 Y120.974 F30000
G1 F15476.087
G1 X104.394 Y119.346 E.05401
G1 X104.524 Y119.216 E.00611
G1 X106.307 Y119.216 E.05915
G1 X108.423 Y121.331 E.09924
G1 X110.085 Y121.331 E.05513
G1 X112.2 Y119.216 E.09924
G1 X113.983 Y119.216 E.05915
G1 X116.099 Y121.331 E.09924
G1 X117.761 Y121.331 E.05513
G1 X119.876 Y119.216 E.09924
G1 X121.659 Y119.216 E.05915
G1 X123.775 Y121.331 E.09924
G1 X125.437 Y121.331 E.05513
G1 X127.552 Y119.216 E.09924
G1 X129.335 Y119.216 E.05915
G1 X131.451 Y121.331 E.09924
G1 X133.113 Y121.331 E.05513
G1 X134.924 Y119.52 E.08498
G3 X136.16 Y120.56 I-3.363 J5.248 E.05375
; WIPE_START
G1 X135.679 Y120.04 E-.26907
G1 X134.924 Y119.52 E-.34859
G1 X134.659 Y119.784 E-.14235
; WIPE_END
G1 E-.04 F1800
G17
G3 Z4.6 I-.204 J1.2 P1  F30000
G1 X150.215 Y122.431 Z4.6
G1 Z4.2
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.550544
G1 F12410.779
G1 X150.518 Y122.403 E.01258
; LINE_WIDTH: 0.50327
G1 F13685.245
G1 X150.821 Y122.376 E.01141
; LINE_WIDTH: 0.455997
G1 F15000
G1 X151.123 Y122.348 E.01024
; LINE_WIDTH: 0.408723
G1 X151.426 Y122.321 E.00907
; LINE_WIDTH: 0.36145
G1 X151.729 Y122.293 E.0079
; LINE_WIDTH: 0.314176
G1 X152.032 Y122.266 E.00672
; LINE_WIDTH: 0.266903
G1 X152.335 Y122.238 E.00555
; LINE_WIDTH: 0.219629
G1 X152.638 Y122.211 E.00438
; WIPE_START
G1 X152.335 Y122.238 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X152.032 Y129.734 Z4.6 F30000
G1 Z4.2
G1 E.8 F1800
; LINE_WIDTH: 0.266902
G1 F15000
G1 X152.335 Y129.762 E.00555
; LINE_WIDTH: 0.219629
G1 X152.638 Y129.789 E.00438
G1 X152.032 Y129.734 F30000
; LINE_WIDTH: 0.314176
G1 F15000
G1 X151.729 Y129.707 E.00672
; LINE_WIDTH: 0.361449
G1 X151.426 Y129.679 E.0079
; LINE_WIDTH: 0.408722
G1 X151.123 Y129.652 E.00907
; LINE_WIDTH: 0.455995
G1 X150.821 Y129.624 E.01024
; LINE_WIDTH: 0.503269
G1 F13685.288
G1 X150.518 Y129.597 E.01141
; LINE_WIDTH: 0.550542
G1 F12410.818
G1 X150.215 Y129.569 E.01258
; WIPE_START
G1 X150.518 Y129.597 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X143.085 Y127.862 Z4.6 F30000
G1 X104.421 Y118.84 Z4.6
G1 Z4.2
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.385953
G1 F15000
G1 X133.6 Y118.84 E.81563
G3 X135.9 Y119.776 I-.076 J3.484 E.07097
G3 X137.137 Y121.218 I-9.183 J9.129 E.05317
G1 X136.97 Y121.723 F30000
; LINE_WIDTH: 0.419999
G1 F15000
G1 X104.997 Y121.723 E.98242
G1 X104.877 Y121.678 E.00396
G1 X104.692 Y121.52 E.00747
G1 X104.438 Y121.52 E.00781
G1 X104.438 Y122.73 E.03719
G1 X104.9 Y122.734 E.0142
G1 X104.989 Y122.778 E.00307
G1 X105.067 Y122.934 E.00533
G1 X137.529 Y122.934 E.99746
; LINE_WIDTH: 0.438903
G1 X137.696 Y122.915 E.00544
; LINE_WIDTH: 0.47671
G1 F14523.173
G1 X137.864 Y122.896 E.00596
; LINE_WIDTH: 0.533287
G1 F12847.535
G1 X138.031 Y122.877 E.00674
G1 X148.334 Y122.877 E.4117
G1 X149.777 Y122.573 E.05891
G1 X149.76 Y122.386 E.00749
G1 X138.031 Y122.386 E.46867
; LINE_WIDTH: 0.514517
G1 F13358.877
G1 X137.98 Y122.341 E.00261
; LINE_WIDTH: 0.47671
G1 F14523.173
G1 X137.929 Y122.296 E.00241
; LINE_WIDTH: 0.421764
G1 F15000
G1 X137.878 Y122.251 E.0021
G1 X137.492 Y121.715 E.0204
; LINE_WIDTH: 0.403611
G1 X137.175 Y121.265 E.01618
G1 X137.209 Y121.435 E.0051
G1 X137.094 Y121.676 E.00785
G1 X137.026 Y121.702 E.00215
G1 X136.97 Y122.537 F30000
; LINE_WIDTH: 0.460033
G1 F15000
G3 X137.637 Y122.531 I.613 J31.202 E.02269
G1 X137.551 Y122.487 E.00329
G1 X137.233 Y122.045 E.01849
G3 X136.97 Y122.12 I-.236 J-.329 E.0095
G1 X105.394 Y122.12 E1.07324
; LINE_WIDTH: 0.435034
G1 X105.176 Y122.095 E.00702
; LINE_WIDTH: 0.367173
G3 X104.786 Y121.998 I-.025 J-.733 E.01075
G1 X104.786 Y122.382 E.01016
G1 X104.968 Y122.391 E.00482
; LINE_WIDTH: 0.388311
G1 X105.111 Y122.437 E.00424
; LINE_WIDTH: 0.459493
G1 X105.255 Y122.483 E.00511
G1 X105.278 Y122.537 E.00199
G1 X136.91 Y122.537 E1.07373
; CHANGE_LAYER
; Z_HEIGHT: 4.4
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F15000
G1 X134.91 Y122.537 E-.76
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 22/101
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L22
M991 S0 P21 ;notify layer change
G17
G3 Z4.6 I-.011 J-1.217 P1  F30000
G1 X104.842 Y122.814 Z4.6
G1 Z4.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X104.842 Y129.186 E.21137
G1 X148.381 Y129.186 E1.44428
G2 X148.764 Y129.26 I1.587 J-7.187 E.01293
G2 X152.842 Y129.913 I21.509 J-121.261 E.137
G1 X152.842 Y130.308 E.01311
G1 X138.152 Y130.308 E.48728
G3 X136.221 Y132.568 I-22.32 J-17.115 E.09866
G3 X133.612 Y133.671 I-2.639 J-2.607 E.09639
G1 X104.046 Y133.671 E.98078
G1 X104.046 Y118.329 E.5089
G1 X133.612 Y118.329 E.98078
G1 X134.022 Y118.358 E.01363
G1 X134.127 Y118.365 E.00349
G3 X136.221 Y119.432 I-.596 J3.759 E.07923
G3 X138.152 Y121.692 I-18.081 J17.404 E.09867
G1 X152.842 Y121.692 E.48728
G1 X152.842 Y122.087 E.01311
G2 X148.381 Y122.814 I26.245 J175.096 E.14992
G1 X104.902 Y122.814 E1.44229
G1 X105.234 Y123.206 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
G1 X105.234 Y128.794 E.17169
G1 X148.422 Y128.794 E1.32705
G2 X148.831 Y128.874 I1.71 J-7.686 E.01282
G2 X153.234 Y129.575 I23.11 J-130.912 E.13699
G1 X153.234 Y130.496 E.02829
G1 F1440
G1 X153.234 Y130.7 E.00629
G1 F1560
G1 X152.303 Y130.7 E.0286
G1 F1680
G1 X150.442 Y130.7 E.0572
G1 F1800
G1 X149.511 Y130.7 E.0286
G1 F1920
G1 X147.649 Y130.7 E.0572
G1 F2040
G1 X146.719 Y130.7 E.0286
G1 F2160
G1 X144.857 Y130.7 E.0572
G1 F2280
G1 X143.926 Y130.7 E.0286
G1 F2400
G1 X142.065 Y130.7 E.0572
G1 F2520
G1 X141.134 Y130.7 E.0286
G1 F2640
G1 X139.273 Y130.7 E.0572
G1 F2760
G1 X138.342 Y130.7 E.0286
G1 F2880
G3 X137.482 Y131.765 I-20.509 J-15.682 E.04206
G1 F3900
G1 X137.213 Y132.061 E.01229
G1 X136.763 Y132.554 E.02052
G1 X136.494 Y132.85 E.01229
G1 F3000
G1 X136.235 Y133.09 E.01084
G1 F2880
G1 X135.754 Y133.445 E.01835
G1 F2760
G1 X135.249 Y133.72 E.01768
G1 F2880
G3 X133.626 Y134.063 I-1.732 J-4.192 E.05126
G1 X103.654 Y134.063 E.92097
G1 F3925.563
G1 X103.654 Y133.968 E.00291
G1 F10120.691
G1 X103.654 Y133.568 E.01229
G1 F12000
G1 X103.654 Y133.168 E.01229
G1 X103.654 Y118.832 E.4405
G1 X103.654 Y118.432 E.01229
G1 F8392.935
G1 X103.654 Y118.032 E.01229
G1 F2880
G1 X103.654 Y117.937 E.00291
G1 X133.626 Y117.937 E.92097
G1 X134.05 Y117.967 E.01305
G1 X134.182 Y117.976 E.00407
G1 X134.724 Y118.091 E.01701
G1 F2760
G1 X135.249 Y118.28 E.01716
G1 F2880
G1 X135.754 Y118.555 E.01768
G1 F3000
G1 X136.235 Y118.91 E.01835
G1 F3900
G1 X136.682 Y119.34 E.01906
G1 X137.145 Y119.848 E.02112
G1 F2880
G3 X137.823 Y120.643 I-17.356 J15.5 E.03211
G1 F2760
G1 X138.342 Y121.3 E.02572
G1 F2640
G1 X140.204 Y121.3 E.0572
G1 F2520
G1 X141.134 Y121.3 E.0286
G1 F2400
G1 X142.996 Y121.3 E.0572
G1 F2280
G1 X143.926 Y121.3 E.0286
G1 F2160
G1 X145.788 Y121.3 E.0572
G1 F2040
G1 X146.719 Y121.3 E.0286
G1 F1920
G1 X148.58 Y121.3 E.0572
G1 F1800
G1 X149.511 Y121.3 E.0286
G1 F1680
M73 P53 R9
G1 X151.372 Y121.3 E.0572
G1 F1560
G1 X152.303 Y121.3 E.0286
G1 F1440
G1 X153.234 Y121.3 E.0286
G1 F3289.424
G1 X153.234 Y121.504 E.00629
G1 F12000
G1 X153.234 Y122.425 E.02829
G2 X148.422 Y123.206 I24.435 J165.754 E.1498
G1 X105.294 Y123.206 E1.32521
M204 S10000
; WIPE_START
G1 X105.272 Y125.206 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X104.444 Y122.611 Z4.8 F30000
G1 Z4.4
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.431684
G1 F15000
G1 X104.444 Y129.389 E.21475
G1 X104.834 Y130.178 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.481181
G1 F14375.004
G1 X104.962 Y130.15 E.00468
; LINE_WIDTH: 0.526123
G1 F13038.018
G1 X105.09 Y130.121 E.00516
; LINE_WIDTH: 0.571064
G1 F11928.57
G1 X105.218 Y130.093 E.00564
; LINE_WIDTH: 0.638384
G1 F10580
G1 X105.346 Y130.064 E.00636
G1 X136.939 Y130.064 E1.53296
; LINE_WIDTH: 0.660131
G1 F10207.207
G1 X137.121 Y130.081 E.00919
G1 X136.579 Y131.681 F30000
; LINE_WIDTH: 0.38292
G1 F15000
G2 X137.116 Y131.039 I-16.577 J-14.433 E.02318
G1 X137.18 Y129.578 F30000
; LINE_WIDTH: 0.414976
G1 F15000
G1 X105.052 Y129.578 E.97408
G1 X104.998 Y129.725 E.00473
G1 X104.834 Y129.782 E.00525
G1 X104.438 Y129.782 E.01202
G1 X104.438 Y130.754 E.02949
G1 X104.692 Y130.754 E.00771
G1 X104.961 Y130.555 E.01015
G1 X105.346 Y130.551 E.01168
G1 X136.939 Y130.551 E.95782
G1 X137.108 Y130.656 E.00605
G1 X137.181 Y130.866 E.00673
G1 X137.154 Y130.993 E.00394
G3 X137.908 Y129.989 I10.372 J7.003 E.03808
G1 X138.054 Y129.926 E.00483
G1 X148.595 Y129.93 E.31959
G1 X148.621 Y129.61 E.00973
G1 X148.334 Y129.568 E.00881
G1 X137.24 Y129.577 E.33633
G1 X136.276 Y132.006 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F15476.087
G3 X136.078 Y132.214 I-1.653 J-1.373 E.00954
G1 X135.882 Y131.99 E.00988
G3 X135.029 Y132.585 I-2.955 J-3.326 E.03458
G1 X133.386 Y130.943 E.07706
G1 X131.177 Y130.943 E.07329
G1 X129.174 Y132.946 E.09398
G1 X127.714 Y132.946 E.04843
G1 X125.71 Y130.943 E.09398
G1 X123.501 Y130.943 E.07329
G1 X121.498 Y132.946 E.09398
G1 X120.038 Y132.946 E.04843
G1 X118.035 Y130.943 E.09398
G1 X115.825 Y130.943 E.07329
G1 X113.822 Y132.946 E.09398
G1 X112.362 Y132.946 E.04843
G1 X110.359 Y130.943 E.09398
G1 X108.149 Y130.943 E.07329
G1 X106.146 Y132.946 E.09398
G1 X104.686 Y132.946 E.04843
G1 X104.394 Y132.654 E.01369
G1 X104.394 Y131.146 E.05002
G1 X104.514 Y131.146 E.00399
G1 X104.408 Y133.308 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.38292
G1 F15000
G1 X133.6 Y133.308 E.80877
G2 X135.064 Y132.971 I-.093 J-3.752 E.04192
G1 X135.794 Y132.486 E.02427
; WIPE_START
G1 X135.064 Y132.971 E-.33283
G1 X134.599 Y133.156 E-.19013
G1 X134.107 Y133.27 E-.19214
G1 X133.989 Y133.278 E-.0449
; WIPE_END
G1 E-.04 F1800
G1 X141.425 Y131.557 Z4.8 F30000
G1 X148.985 Y129.806 Z4.8
G1 Z4.4
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.570378
G1 F11944.077
G1 X149.323 Y129.834 E.01458
; LINE_WIDTH: 0.521072
G1 F13175.739
G1 X149.661 Y129.862 E.01321
; LINE_WIDTH: 0.471765
G1 F14690.619
G1 X149.999 Y129.889 E.01185
; LINE_WIDTH: 0.422459
G1 F15000
G1 X150.337 Y129.917 E.01049
; LINE_WIDTH: 0.373152
G1 X150.675 Y129.945 E.00913
; LINE_WIDTH: 0.323846
G1 X151.013 Y129.973 E.00776
; LINE_WIDTH: 0.27454
G1 X151.351 Y130.001 E.0064
; LINE_WIDTH: 0.230653
G1 X151.617 Y130.021 E.00408
; LINE_WIDTH: 0.192354
G1 X151.881 Y130.04 E.00323
; LINE_WIDTH: 0.154181
G1 X152.145 Y130.06 E.0024
; LINE_WIDTH: 0.116007
G1 X152.409 Y130.08 E.00158
; WIPE_START
G1 X152.145 Y130.06 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X151.896 Y122.432 Z4.8 F30000
G1 X151.881 Y121.96 Z4.8
G1 Z4.4
G1 E.8 F1800
; LINE_WIDTH: 0.15418
G1 F15000
G1 X152.145 Y121.94 E.0024
; LINE_WIDTH: 0.116007
G1 X152.409 Y121.92 E.00158
G1 X151.881 Y121.96 F30000
; LINE_WIDTH: 0.192354
G1 F15000
G1 X151.617 Y121.979 E.00323
; LINE_WIDTH: 0.230653
G1 X151.351 Y121.999 E.00408
; LINE_WIDTH: 0.274539
G1 X151.013 Y122.027 E.0064
; LINE_WIDTH: 0.323845
G1 X150.675 Y122.055 E.00776
; LINE_WIDTH: 0.373152
G1 X150.337 Y122.083 E.00913
; LINE_WIDTH: 0.422458
G1 X149.999 Y122.111 E.01049
; LINE_WIDTH: 0.471764
G1 F14690.656
G1 X149.661 Y122.138 E.01185
; LINE_WIDTH: 0.521071
G1 F13175.77
G1 X149.323 Y122.166 E.01321
; LINE_WIDTH: 0.570377
G1 F11944.106
G1 X148.985 Y122.194 E.01458
G1 X104.834 Y121.822 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.481181
G1 F14375.004
G1 X104.962 Y121.85 E.00468
; LINE_WIDTH: 0.526123
G1 F13038.018
G1 X105.09 Y121.879 E.00516
; LINE_WIDTH: 0.571064
G1 F11928.57
G1 X105.218 Y121.907 E.00564
; LINE_WIDTH: 0.638384
G1 F10580
G1 X105.346 Y121.936 E.00636
G1 X136.939 Y121.936 E1.53296
; LINE_WIDTH: 0.660131
G1 F10207.207
G1 X137.121 Y121.919 E.00919
G1 X136.578 Y120.32 F30000
; LINE_WIDTH: 0.38292
G1 F15000
G1 X137.102 Y120.944 E.02255
G1 X137.18 Y122.422 F30000
; LINE_WIDTH: 0.415061
G1 F15000
G3 X138.054 Y122.432 I.225 J18.9 E.02649
G1 X148.349 Y122.432 E.3122
G1 X148.621 Y122.39 E.00836
G1 X148.595 Y122.07 E.00973
G1 X138.054 Y122.074 E.31966
G1 X137.907 Y122.012 E.00485
G3 X137.14 Y120.99 I12.687 J-10.313 E.03875
G1 X137.177 Y121.157 E.00521
G1 X137.108 Y121.344 E.00602
G1 X136.971 Y121.447 E.00519
G1 X136.939 Y121.449 E.00099
G1 X104.999 Y121.449 E.96855
G1 X104.877 Y121.404 E.00397
G1 X104.692 Y121.246 E.00737
G1 X104.438 Y121.246 E.00771
G1 X104.438 Y122.218 E.02949
G1 X104.907 Y122.224 E.01424
G1 X104.998 Y122.275 E.00317
G1 X105.067 Y122.422 E.00491
G1 X137.12 Y122.422 E.97202
G1 X104.514 Y120.854 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X104.394 Y120.854 E.00399
G1 X104.394 Y119.346 E.05002
G1 X104.686 Y119.054 E.01367
G1 X106.147 Y119.055 E.04847
G1 X108.149 Y121.057 E.09394
G1 X110.359 Y121.057 E.07329
G1 X112.358 Y119.057 E.09382
G1 X113.826 Y119.058 E.04867
G1 X115.825 Y121.057 E.09379
G1 X118.035 Y121.057 E.07329
G1 X120.031 Y119.06 E.09368
G1 X121.505 Y119.061 E.04888
G1 X123.501 Y121.057 E.09365
G1 X125.71 Y121.057 E.07329
G1 X127.704 Y119.064 E.09353
G1 X129.184 Y119.064 E.04908
G1 X131.177 Y121.057 E.0935
G1 X133.386 Y121.057 E.07329
G1 X135.029 Y119.415 E.07706
G3 X135.914 Y120.027 I-1.651 J3.327 E.03582
G1 X136.101 Y119.808 E.00958
G3 X136.28 Y119.998 I-1.33 J1.429 E.00867
G1 X104.408 Y118.692 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.38292
G1 F15000
G1 X133.6 Y118.698 E.80877
G3 X135.816 Y119.529 I-.03 J3.452 E.06695
; CHANGE_LAYER
; Z_HEIGHT: 4.6
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F15000
G1 X135.498 Y119.281 E-.15306
G1 X135.055 Y119.024 E-.19473
G1 X134.591 Y118.842 E-.1893
G1 X134.116 Y118.732 E-.18544
G1 X134.017 Y118.726 E-.03747
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 23/101
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L23
M991 S0 P22 ;notify layer change
G17
G3 Z4.8 I-.153 J-1.207 P1  F30000
G1 X104.842 Y122.417 Z4.8
G1 Z4.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X104.842 Y129.583 E.23773
G1 X148.394 Y129.583 E1.44471
G2 X152.842 Y130.253 I25.274 J-152.649 E.14921
G1 X152.842 Y130.534 E.0093
G1 X138.152 Y130.534 E.48728
G3 X136.406 Y132.556 I-21.3 J-16.629 E.08868
G3 X133.612 Y133.806 I-2.865 J-2.657 E.10429
G1 X104.046 Y133.806 E.98078
G1 X104.046 Y118.194 E.51787
G1 X133.612 Y118.194 E.98078
G1 X133.856 Y118.211 E.00808
G3 X136.406 Y119.444 I-.29 J3.854 E.09619
G3 X138.152 Y121.466 I-19.553 J18.652 E.08868
G1 X152.842 Y121.466 E.48728
G1 X152.842 Y121.747 E.0093
G2 X148.394 Y122.417 I20.826 J153.319 E.14921
G1 X104.902 Y122.417 E1.44272
G1 X105.234 Y122.809 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
G1 X105.234 Y129.191 E.19611
G1 X148.426 Y129.191 E1.32719
G2 X153.234 Y129.907 I30.729 J-189.904 E.14935
G1 X153.234 Y130.741 E.02563
G1 F1680
G1 X153.234 Y130.926 E.00568
G1 F1800
G1 X152.303 Y130.926 E.0286
G1 F1920
G1 X150.442 Y130.926 E.0572
G1 F2040
G1 X148.58 Y130.926 E.0572
G1 F2160
G1 X147.649 Y130.926 E.0286
G1 F2280
G1 X145.788 Y130.926 E.0572
G1 F2400
G1 X143.926 Y130.926 E.0572
G1 F2520
G1 X142.065 Y130.926 E.0572
G1 F2640
G1 X141.134 Y130.926 E.0286
G1 F2760
G1 X139.273 Y130.926 E.0572
G1 F2880
G1 X138.342 Y130.926 E.0286
G3 X137.917 Y131.453 I-10.151 J-7.747 E.0208
G1 F3900
G1 X137.651 Y131.751 E.01229
G1 X136.951 Y132.534 E.03225
G1 X136.685 Y132.832 E.01229
G1 F3000
G3 X135.759 Y133.592 I-3.858 J-3.754 E.03689
G1 F3900
G1 X135.252 Y133.855 E.01755
G1 F3000
G1 X134.724 Y134.044 E.01724
G1 F2880
G3 X133.626 Y134.198 I-1.098 J-3.853 E.03416
G1 X103.654 Y134.198 E.92097
G1 F3918.766
G1 X103.654 Y134.104 E.00289
G1 F10109.775
G1 X103.654 Y133.704 E.01229
G1 F12000
G1 X103.654 Y133.304 E.01229
G1 X103.654 Y118.696 E.44885
G1 X103.654 Y118.296 E.01229
G1 F8392.935
G1 X103.654 Y117.896 E.01229
G1 F2880
G1 X103.654 Y117.802 E.00289
G1 X133.626 Y117.802 E.92097
G1 X133.883 Y117.82 E.00791
G1 X134.182 Y117.841 E.00921
G1 F3000
G1 X134.724 Y117.956 E.01701
G1 F3900
G1 X135.252 Y118.145 E.01724
G1 F3000
G1 X135.759 Y118.408 E.01755
G3 X136.235 Y118.748 I-5.491 J8.176 E.01798
G1 F3900
G1 X136.685 Y119.168 E.01891
G1 X137.127 Y119.655 E.0202
G1 X137.396 Y119.95 E.01229
G1 F2880
G3 X138.342 Y121.074 I-13.467 J12.297 E.04514
G1 F2760
G1 X140.204 Y121.074 E.0572
G1 F2640
G1 X141.134 Y121.074 E.0286
G1 F2520
G1 X142.996 Y121.074 E.0572
G1 F2400
G1 X144.857 Y121.074 E.0572
G1 F2280
G1 X146.719 Y121.074 E.0572
G1 F2160
G1 X147.649 Y121.074 E.0286
G1 F2040
G1 X149.511 Y121.074 E.0572
G1 F1920
G1 X151.372 Y121.074 E.0572
G1 F1800
G1 X152.303 Y121.074 E.0286
G1 F1680
G1 X153.234 Y121.074 E.0286
G1 F3424.018
G1 X153.234 Y121.259 E.00568
G1 F12000
G1 X153.234 Y122.093 E.02563
G2 X148.426 Y122.809 I25.922 J190.62 E.14935
G1 X105.294 Y122.809 E1.32535
M204 S10000
; WIPE_START
G1 X105.275 Y124.809 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X104.444 Y122.213 Z5 F30000
G1 Z4.6
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.431684
G1 F15000
G1 X104.444 Y129.787 E.23993
G1 X105.399 Y130.384 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.482348
G1 F14336.819
G1 X136.912 Y130.384 E1.12839
; LINE_WIDTH: 0.497728
G1 F13852.014
G1 X137.017 Y130.396 E.00394
; LINE_WIDTH: 0.528487
G1 F12974.536
G1 X137.123 Y130.408 E.00421
G1 X136.912 Y130.792 F30000
; LINE_WIDTH: 0.419452
G1 F15000
G1 X136.993 Y130.81 E.00256
G3 X137.119 Y131.237 I-.276 J.314 E.01438
G3 X137.876 Y130.251 I13.107 J9.284 E.03814
G1 X137.876 Y129.975 E.00846
G1 X105.399 Y129.975 E.99649
; LINE_WIDTH: 0.451075
G1 X105.072 Y129.999 E.0109
G1 X105.023 Y130.13 E.00466
; LINE_WIDTH: 0.487704
G1 F14164.186
G1 X104.977 Y130.182 E.0025
; LINE_WIDTH: 0.52745
G1 F13002.311
G1 X104.931 Y130.233 E.00272
; LINE_WIDTH: 0.560511
G1 F12171.777
G1 X104.51 Y130.251 E.01778
G1 X104.51 Y130.923 E.02835
G1 X104.697 Y130.896 E.00798
G1 X104.931 Y130.738 E.01192
; LINE_WIDTH: 0.527449
G1 F13002.33
G1 X105.122 Y130.753 E.00754
; LINE_WIDTH: 0.487704
G1 F14164.195
G1 X105.312 Y130.768 E.00692
; LINE_WIDTH: 0.420068
G1 F15000
G1 X105.399 Y130.792 E.00278
G1 X136.852 Y130.792 E.96662
G1 X136.963 Y131.421 F30000
; LINE_WIDTH: 0.38292
G1 F15000
G1 X137.081 Y131.282 E.00503
G1 X138.269 Y130.059 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.585709
G1 F11606.72
G1 X148.355 Y130.059 E.44612
G1 X148.642 Y130.082 E.01276
; LINE_WIDTH: 0.515171
G1 F13340.378
G1 X148.93 Y130.106 E.0111
; LINE_WIDTH: 0.467706
G1 F14831.015
G1 X149.217 Y130.13 E.00999
; LINE_WIDTH: 0.420241
G1 F15000
G1 X149.505 Y130.153 E.00887
; LINE_WIDTH: 0.396277
G1 X149.508 Y130.154 E.00009
; LINE_WIDTH: 0.371119
G1 X149.849 Y130.179 E.00914
; LINE_WIDTH: 0.321264
G1 X150.19 Y130.204 E.00775
; LINE_WIDTH: 0.27141
G1 X150.53 Y130.229 E.00636
; LINE_WIDTH: 0.221556
G1 X150.871 Y130.255 E.00498
; LINE_WIDTH: 0.171702
G1 X151.212 Y130.28 E.00359
; LINE_WIDTH: 0.121847
G1 X151.553 Y130.305 E.0022
; WIPE_START
G1 X151.212 Y130.28 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X150.908 Y122.654 Z5 F30000
G1 X150.871 Y121.745 Z5
G1 Z4.6
G1 E.8 F1800
; LINE_WIDTH: 0.171701
G1 F15000
G1 X151.212 Y121.72 E.00359
; LINE_WIDTH: 0.121847
G1 X151.553 Y121.695 E.0022
G1 X150.871 Y121.745 F30000
; LINE_WIDTH: 0.221555
G1 F15000
G1 X150.53 Y121.771 E.00498
; LINE_WIDTH: 0.271409
G1 X150.19 Y121.796 E.00636
; LINE_WIDTH: 0.321263
G1 X149.849 Y121.821 E.00775
; LINE_WIDTH: 0.371117
G1 X149.508 Y121.846 E.00914
; LINE_WIDTH: 0.396277
G1 X149.505 Y121.847 E.00009
; LINE_WIDTH: 0.420242
G1 X149.217 Y121.87 E.00887
; LINE_WIDTH: 0.467708
G1 F14830.957
G1 X148.93 Y121.894 E.00999
; LINE_WIDTH: 0.515173
G1 F13340.327
G1 X148.642 Y121.918 E.0111
; LINE_WIDTH: 0.585709
G1 F11606.72
G1 X148.355 Y121.941 E.01276
G1 X138.269 Y121.941 E.44612
G1 X133.579 Y118.893 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F15476.087
G3 X135.133 Y119.31 I-.03 J3.212 E.05395
G1 X133.628 Y120.816 E.07063
G1 X130.936 Y120.816 E.0893
G1 X129.013 Y118.893 E.09022
M73 P54 R9
G1 X127.875 Y118.893 E.03773
G1 X125.952 Y120.816 E.09022
G1 X123.26 Y120.816 E.0893
G1 X121.336 Y118.893 E.09023
G1 X120.199 Y118.893 E.03773
G1 X118.276 Y120.816 E.09023
G1 X115.584 Y120.816 E.0893
G1 X113.66 Y118.893 E.09023
G1 X112.523 Y118.893 E.03773
G1 X110.6 Y120.816 E.09023
G1 X107.908 Y120.816 E.0893
G1 X105.984 Y118.893 E.09023
G1 X104.847 Y118.893 E.03772
G1 X104.394 Y119.346 E.02126
G1 X104.394 Y120.613 E.04202
G1 X104.756 Y120.613 E.01199
G1 X105.399 Y121.616 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.482348
G1 F14336.819
G1 X136.912 Y121.616 E1.12839
; LINE_WIDTH: 0.497728
G1 F13852.014
G1 X137.017 Y121.604 E.00394
; LINE_WIDTH: 0.528487
G1 F12974.536
G1 X137.123 Y121.592 E.00421
G1 X136.858 Y120.45 F30000
; LINE_WIDTH: 0.38292
G1 F15000
G1 X137.071 Y120.702 E.00914
G1 X136.912 Y121.208 F30000
; LINE_WIDTH: 0.419999
G1 F15000
G1 X105.399 Y121.208 E.96829
; LINE_WIDTH: 0.440753
G1 X105.262 Y121.229 E.0045
; LINE_WIDTH: 0.48226
G1 F14339.692
G1 X105.124 Y121.249 E.00497
; LINE_WIDTH: 0.523768
G1 F13101.871
G1 X104.987 Y121.27 E.00544
; LINE_WIDTH: 0.561116
G1 F12157.571
G3 X104.623 Y121.077 I.159 J-.737 E.01761
G1 X104.51 Y121.077 E.00479
G1 X104.51 Y121.749 E.02838
G1 X104.931 Y121.767 E.0178
; LINE_WIDTH: 0.52745
G1 F13002.311
G1 X104.977 Y121.818 E.00272
; LINE_WIDTH: 0.474383
G1 F14601.48
G3 X105.072 Y122.001 I-.189 J.214 E.0074
; LINE_WIDTH: 0.42023
G1 F15000
G1 X105.399 Y122.025 E.01008
G1 X137.876 Y122.025 E.99855
G2 X137.832 Y121.693 I-.494 J-.102 E.01049
G1 X137.319 Y121.054 E.0252
; LINE_WIDTH: 0.404775
G1 X137.109 Y120.748 E.01092
G1 X137.147 Y120.91 E.00491
G1 X137.082 Y121.101 E.00593
G1 X136.966 Y121.189 E.00429
G1 X104.395 Y118.543 F30000
; LINE_WIDTH: 0.38292
G1 F15000
G1 X133.6 Y118.544 E.80915
G3 X135.791 Y119.349 I-.061 J3.549 E.06589
; WIPE_START
G1 X135.496 Y119.126 E-.14041
G1 X135.05 Y118.871 E-.19512
G1 X134.587 Y118.692 E-.1888
G1 X134.113 Y118.583 E-.18471
G1 X133.979 Y118.573 E-.05096
; WIPE_END
G1 E-.04 F1800
G1 X126.99 Y121.638 Z5 F30000
G1 X104.756 Y131.387 Z5
G1 Z4.6
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X104.394 Y131.387 E.01199
G1 X104.394 Y132.654 E.04202
G1 X104.847 Y133.107 E.02126
G1 X105.984 Y133.107 E.03772
G1 X107.908 Y131.184 E.09023
G1 X110.6 Y131.184 E.0893
G1 X112.523 Y133.107 E.09023
G1 X113.66 Y133.107 E.03772
G1 X115.584 Y131.184 E.09023
G1 X118.276 Y131.184 E.0893
G1 X120.199 Y133.107 E.09023
G1 X121.336 Y133.107 E.03772
G1 X123.26 Y131.184 E.09023
G1 X125.952 Y131.184 E.0893
G1 X127.875 Y133.107 E.09023
G1 X129.012 Y133.107 E.03772
G1 X130.936 Y131.184 E.09023
G1 X133.628 Y131.184 E.0893
G1 X135.133 Y132.69 E.07063
G3 X133.579 Y133.107 I-1.586 J-2.799 E.05395
G1 X104.395 Y133.457 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.38292
G1 F15000
G1 X133.6 Y133.457 E.80915
G2 X135.791 Y132.652 I-.063 J-3.555 E.06589
; CHANGE_LAYER
; Z_HEIGHT: 4.8
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F15000
G1 X135.505 Y132.868 E-.13641
G1 X135.06 Y133.124 E-.19483
G1 X134.595 Y133.306 E-.1898
G1 X134.106 Y133.418 E-.19085
G1 X133.98 Y133.428 E-.04812
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 24/101
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L24
M991 S0 P23 ;notify layer change
G17
G3 Z5 I.442 J-1.134 P1  F30000
G1 X104.842 Y122.06 Z5
G1 Z4.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X104.842 Y129.94 E.2614
G1 X148.402 Y129.94 E1.44498
G2 X152.769 Y130.524 I27.69 J-190.288 E.14614
G1 X152.754 Y130.753 E.00761
G1 X138.17 Y130.753 E.48378
G1 X137.463 Y131.562 E.03564
G3 X135.999 Y133.085 I-12.861 J-10.91 E.07012
G3 X133.612 Y133.941 I-2.464 J-3.113 E.0856
G1 X104.046 Y133.941 E.98078
G1 X104.046 Y118.059 E.52683
G1 X133.689 Y118.064 E.98331
G3 X136.411 Y119.299 I-.116 J3.877 E.1018
G3 X138.17 Y121.247 I-33.988 J32.455 E.08707
G1 X152.754 Y121.247 E.48378
G1 X152.769 Y121.476 E.00761
G2 X148.402 Y122.06 I23.323 J190.873 E.14614
G1 X104.902 Y122.06 E1.44299
G1 X105.234 Y122.452 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
G1 X105.234 Y129.548 E.21804
G1 X148.429 Y129.548 E1.32728
G2 X153.234 Y130.188 I30.345 J-209.369 E.14894
G1 X153.234 Y130.967 E.02393
G1 F1800
G1 X153.234 Y131.145 E.00548
G1 F1920
G1 X151.373 Y131.145 E.05717
G1 F2040
G1 X149.512 Y131.145 E.05717
G1 F2160
G1 X147.652 Y131.145 E.05717
G1 F2280
G1 X145.791 Y131.145 E.05717
G1 F2400
G1 X143.93 Y131.145 E.05717
G1 F2520
G1 X143 Y131.145 E.02859
G1 F2640
G1 X141.139 Y131.145 E.05717
G1 F2760
G1 X139.279 Y131.145 E.05717
G1 F2880
G1 X138.348 Y131.145 E.02859
G1 F3900
G1 X138.085 Y131.447 E.01229
G1 X137.648 Y131.947 E.02043
G1 F4800
G1 X137.076 Y132.576 E.02611
G1 F6600
G1 X136.687 Y132.981 E.01724
G1 F5700
G1 X136.315 Y133.329 E.01566
G1 F4800
G1 X135.759 Y133.728 E.02102
G1 F3900
G1 X135.252 Y133.99 E.01755
G1 F3000
G1 X134.724 Y134.18 E.01724
G1 F2880
G3 X133.626 Y134.333 I-1.098 J-3.853 E.03416
G1 X103.654 Y134.333 E.92097
G1 F3918.778
G1 X103.654 Y134.239 E.00289
G1 F10109.794
G1 X103.654 Y133.839 E.01229
G1 F12000
G1 X103.654 Y133.439 E.01229
G1 X103.654 Y118.561 E.45715
G1 X103.654 Y118.161 E.01229
G1 F8392.935
G1 X103.654 Y117.761 E.01229
G1 F2880
M73 P54 R8
G1 X103.654 Y117.667 E.00289
G1 X133.716 Y117.673 E.92373
G1 X134.182 Y117.706 E.01435
G1 F3000
G1 X134.724 Y117.82 E.01701
G1 F3900
G1 X135.252 Y118.01 E.01724
G1 F4800
G1 X135.759 Y118.273 E.01755
G3 X136.24 Y118.605 I-2.327 J3.875 E.01799
G1 F5700
G1 X136.315 Y118.671 E.00306
G1 F6600
G1 X136.687 Y119.019 E.01566
G1 F4800
G1 X137.076 Y119.424 E.01724
G1 F3900
G1 X137.648 Y120.053 E.02611
G1 F2880
G1 X138.348 Y120.855 E.03272
G1 F2760
G1 X140.209 Y120.855 E.05717
G1 F2640
G1 X142.07 Y120.855 E.05717
G1 F2520
G1 X143 Y120.855 E.02859
G1 F2400
G1 X144.861 Y120.855 E.05717
G1 F2280
G1 X146.721 Y120.855 E.05717
G1 F2160
G1 X148.582 Y120.855 E.05717
G1 F2040
G1 X150.443 Y120.855 E.05717
G1 F1920
G1 X152.303 Y120.855 E.05717
G1 F1800
G1 X153.234 Y120.855 E.02859
G1 F3523.714
G1 X153.234 Y121.033 E.00548
G1 F12000
G1 X153.234 Y121.812 E.02393
G2 X148.429 Y122.452 I25.541 J210.01 E.14894
G1 X105.294 Y122.452 E1.32543
M204 S10000
; WIPE_START
G1 X105.277 Y124.452 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X104.444 Y121.856 Z5.2 F30000
G1 Z4.8
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.431684
G1 F15000
G1 X104.444 Y130.144 E.26253
G1 X104.395 Y133.592 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.38292
G1 F15000
G1 X133.6 Y133.592 E.80916
G2 X134.589 Y133.44 I.009 J-3.237 E.02782
G1 X134.136 Y133.196 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X134.882 Y133.038 E.02529
G1 X134.958 Y133.308 E.00931
G2 X135.47 Y133.027 I-.837 J-2.13 E.01944
G1 X133.855 Y131.411 E.07578
G1 X130.708 Y131.411 E.10439
G1 X128.877 Y133.243 E.08593
G1 X128.011 Y133.243 E.02871
G1 X126.179 Y131.411 E.08593
G1 X123.032 Y131.411 E.10439
G1 X121.201 Y133.243 E.08593
G1 X120.335 Y133.243 E.02871
G1 X118.503 Y131.411 E.08593
G1 X115.356 Y131.411 E.10439
G1 X113.525 Y133.243 E.08593
G1 X112.659 Y133.243 E.02871
G1 X110.827 Y131.411 E.08593
G1 X107.68 Y131.411 E.10439
G1 X105.849 Y133.243 E.08593
G1 X104.983 Y133.243 E.02871
G1 X104.394 Y132.654 E.02763
G1 X104.394 Y131.615 E.03447
G1 X104.846 Y131.615 E.01499
G1 X104.943 Y131.518 E.00455
G1 X104.943 Y120.482 F30000
G1 F15476.087
G1 X104.846 Y120.385 E.00455
G1 X104.394 Y120.385 E.01499
G1 X104.394 Y119.346 E.03447
G1 X104.983 Y118.757 E.02763
G1 X105.849 Y118.757 E.02871
G1 X107.68 Y120.589 E.08593
G1 X110.827 Y120.589 E.10439
G1 X112.659 Y118.757 E.08593
G1 X113.525 Y118.757 E.02871
G1 X115.356 Y120.589 E.08593
G1 X118.503 Y120.589 E.10439
G1 X120.335 Y118.757 E.08593
G1 X121.201 Y118.757 E.02871
G1 X123.032 Y120.589 E.08593
G1 X126.179 Y120.589 E.10439
G1 X128.011 Y118.757 E.08593
G1 X128.877 Y118.757 E.02871
G1 X130.708 Y120.589 E.08593
G1 X133.855 Y120.589 E.10439
G1 X135.47 Y118.973 E.07578
G2 X134.958 Y118.692 I-1.349 J1.849 E.01944
G1 X134.882 Y118.962 E.00931
G1 X134.136 Y118.804 E.02529
G1 X137.206 Y120.981 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.419999
G1 F15000
G1 X105.598 Y120.981 E.97124
; LINE_WIDTH: 0.441542
G1 X105.466 Y121.002 E.00434
; LINE_WIDTH: 0.484627
G1 F14262.848
G1 X105.334 Y121.024 E.00481
; LINE_WIDTH: 0.522182
G1 F13145.23
G1 X105.202 Y121.045 E.00522
G1 X104.845 Y120.972 E.01421
G1 X104.674 Y120.826 E.00879
G1 X104.487 Y120.826 E.00732
G1 X104.487 Y121.416 E.02303
; LINE_WIDTH: 0.50373
G1 F13671.585
G1 X104.931 Y121.443 E.01673
G1 X105.06 Y121.499 E.00525
; LINE_WIDTH: 0.542447
G1 F12611.93
G1 X105.097 Y121.607 E.00465
; LINE_WIDTH: 0.522039
G1 F13149.134
G1 X105.264 Y121.627 E.00656
; LINE_WIDTH: 0.481223
G1 F14373.619
G1 X105.431 Y121.647 E.006
; LINE_WIDTH: 0.420102
G1 F15000
G1 X105.598 Y121.668 E.00517
G1 X137.863 Y121.668 E.9917
G2 X137.831 Y121.455 I-.296 J-.064 E.00677
G1 X137.353 Y120.917 E.02211
G1 X137.261 Y120.957 E.00308
G1 X105.598 Y121.324 F30000
; LINE_WIDTH: 0.353044
G1 F15000
G1 X137.193 Y121.324 E.79846
G1 X138.255 Y121.653 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.44841
G1 F15000
G1 X148.374 Y121.653 E.33436
G1 X148.697 Y121.631 E.01069
; LINE_WIDTH: 0.38306
G1 X149.02 Y121.609 E.00897
; LINE_WIDTH: 0.339038
G1 X149.342 Y121.587 E.00781
; LINE_WIDTH: 0.295017
G1 X149.665 Y121.564 E.00665
; LINE_WIDTH: 0.250995
G1 X149.988 Y121.542 E.00549
; LINE_WIDTH: 0.206974
G1 X150.311 Y121.52 E.00432
; LINE_WIDTH: 0.162952
G1 X150.633 Y121.498 E.00316
; LINE_WIDTH: 0.118931
G1 X150.956 Y121.475 E.002
G1 X153.007 Y121.643 F30000
; LINE_WIDTH: 0.12295
G1 F15000
G1 X152.988 Y121.051 E.00386
; WIPE_START
G1 X153.007 Y121.643 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X153.007 Y129.275 Z5.2 F30000
G1 X153.007 Y130.357 Z5.2
G1 Z4.8
G1 E.8 F1800
; LINE_WIDTH: 0.12295
G1 F15000
G1 X152.988 Y130.949 E.00386
G1 X150.956 Y130.525 F30000
; LINE_WIDTH: 0.118931
G1 F15000
G1 X150.633 Y130.502 E.002
; LINE_WIDTH: 0.162953
G1 X150.311 Y130.48 E.00316
; LINE_WIDTH: 0.206974
G1 X149.988 Y130.458 E.00432
; LINE_WIDTH: 0.250996
G1 X149.665 Y130.436 E.00549
; LINE_WIDTH: 0.295017
G1 X149.342 Y130.413 E.00665
; LINE_WIDTH: 0.339039
G1 X149.02 Y130.391 E.00781
; LINE_WIDTH: 0.38306
G1 X148.697 Y130.369 E.00897
; LINE_WIDTH: 0.44841
G1 X148.374 Y130.347 E.01069
G1 X138.255 Y130.347 E.33436
G1 X137.206 Y131.019 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.419999
G1 F15000
G1 X137.355 Y131.081 E.00495
G1 X137.863 Y130.509 E.02352
G1 X137.863 Y130.332 E.00543
G1 X105.598 Y130.332 E.99143
; LINE_WIDTH: 0.440407
G1 X105.431 Y130.353 E.00545
; LINE_WIDTH: 0.481223
G1 F14373.619
G1 X105.264 Y130.373 E.006
; LINE_WIDTH: 0.523991
G1 F13095.786
G1 X105.097 Y130.393 E.00659
G1 X105.032 Y130.524 E.00572
G3 X104.487 Y130.584 I-.427 J-1.373 E.02166
G1 X104.487 Y131.174 E.02312
G1 X104.674 Y131.174 E.00735
G1 X104.862 Y131.015 E.00965
G1 X105.282 Y130.958 E.01662
; LINE_WIDTH: 0.522039
G1 F13149.134
G1 X105.387 Y130.979 E.00419
; LINE_WIDTH: 0.481223
G1 F14373.619
G1 X105.492 Y130.999 E.00383
; LINE_WIDTH: 0.420069
G1 F15000
G1 X105.598 Y131.019 E.0033
G1 X137.146 Y131.019 E.96958
G1 X105.598 Y130.676 F30000
; LINE_WIDTH: 0.353044
G1 F15000
G1 X137.193 Y130.676 E.79846
; WIPE_START
G1 X135.193 Y130.676 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X128.102 Y127.851 Z5.2 F30000
G1 X104.395 Y118.408 Z5.2
G1 Z4.8
G1 E.8 F1800
; LINE_WIDTH: 0.38292
G1 F15000
G1 X133.602 Y118.411 E.80921
G3 X134.589 Y118.56 I.027 J3.162 E.02777
; CHANGE_LAYER
; Z_HEIGHT: 5
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F15000
G1 X134.12 Y118.449 E-.1831
G1 X133.602 Y118.411 E-.19739
G1 X132.603 Y118.41 E-.37951
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 25/101
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L25
M991 S0 P24 ;notify layer change
G17
G3 Z5.2 I-.146 J-1.208 P1  F30000
G1 X104.842 Y121.758 Z5.2
G1 Z5
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X104.842 Y130.242 E.2814
G1 X148.402 Y130.242 E1.44498
G2 X152.044 Y130.71 I32.153 J-235.768 E.1218
G1 X152.03 Y130.939 E.00763
G1 X138.17 Y130.939 E.45977
G3 X136.208 Y133.037 I-22.46 J-19.04 E.09533
G3 X133.614 Y134.066 I-2.615 J-2.808 E.09475
G1 X104.046 Y134.066 E.98082
G1 X104.046 Y117.934 E.53515
G1 X133.614 Y117.934 E.98082
G1 X134.119 Y117.967 E.01681
G1 X134.132 Y117.968 E.00041
G3 X136.413 Y119.155 I-.62 J3.978 E.08682
G3 X138.17 Y121.061 I-28.736 J28.259 E.08601
G1 X152.03 Y121.061 E.45977
G1 X152.044 Y121.29 E.00763
G2 X148.402 Y121.758 I28.511 J236.236 E.1218
G1 X104.902 Y121.758 E1.44299
G1 X105.234 Y122.151 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
G1 X105.234 Y129.849 E.23657
G1 X148.429 Y129.849 E1.32728
G2 X153.234 Y130.454 I45.395 J-341.287 E.14879
G1 X153.234 Y131.186 E.0225
G1 F2280
G1 X153.234 Y131.331 E.00446
G1 X152.303 Y131.331 E.02859
G1 F2400
G1 X150.443 Y131.331 E.05717
G1 F2520
G1 X148.582 Y131.331 E.05717
G1 F2640
G1 X146.721 Y131.331 E.05717
G1 F2760
G1 X144.861 Y131.331 E.05717
G1 F2880
G1 X143 Y131.331 E.05717
G1 F3000
G1 X141.139 Y131.331 E.05717
G1 F3900
G1 X140.739 Y131.331 E.01229
G1 X138.348 Y131.331 E.07347
G1 X137.899 Y131.845 E.02097
G1 F4800
G1 X137.554 Y132.226 E.0158
G1 F7500
G1 X137.15 Y132.651 E.01801
G1 F6600
G1 X136.471 Y133.328 E.02947
G1 F5700
G1 X136.24 Y133.53 E.00941
G1 F4800
G1 X135.759 Y133.863 E.01798
G1 F3900
G1 X135.252 Y134.125 E.01755
G1 F3000
G1 X134.725 Y134.313 E.01719
G1 F3900
G1 X134.183 Y134.422 E.01697
G3 X133.627 Y134.458 I-.557 J-4.174 E.01716
G1 X103.654 Y134.458 E.92098
G1 F4963.823
G1 X103.654 Y134.374 E.00259
G1 F11750.936
G1 X103.654 Y133.974 E.01229
G1 F12000
G1 X103.654 Y133.574 E.01229
G1 X103.654 Y118.426 E.46546
G1 X103.654 Y118.026 E.01229
G1 F10079.62
G1 X103.654 Y117.626 E.01229
G1 F3900
G1 X103.654 Y117.542 E.00259
G1 X133.627 Y117.542 E.92098
G1 X134.145 Y117.576 E.01597
G1 F3411.516
G1 X134.183 Y117.578 E.00118
G1 F3000
G1 X134.725 Y117.687 E.01697
G1 F3900
G1 X135.252 Y117.875 E.01719
G1 F4800
M73 P55 R8
G1 X135.759 Y118.137 E.01755
G1 F5700
G1 X136.24 Y118.47 E.01798
G1 F6600
G1 X136.687 Y118.875 E.01853
G1 F7500
G1 X137.15 Y119.349 E.02036
G1 F4800
G1 X137.554 Y119.774 E.01801
G1 F3900
G3 X138.348 Y120.669 I-22.16 J20.492 E.03677
G1 X139.809 Y120.669 E.04488
G1 X140.209 Y120.669 E.01229
G1 F3000
G1 X142.07 Y120.669 E.05717
G1 F2880
G1 X143.93 Y120.669 E.05717
G1 F2760
G1 X145.791 Y120.669 E.05717
G1 F2640
G1 X147.652 Y120.669 E.05717
G1 F2520
G1 X149.512 Y120.669 E.05717
G1 F2400
G1 X151.373 Y120.669 E.05717
G1 F2280
G1 X153.234 Y120.669 E.05717
G1 F3782.931
G1 X153.234 Y120.814 E.00446
G1 F12000
G1 X153.234 Y121.546 E.0225
G2 X148.429 Y122.151 I40.59 J341.892 E.14879
G1 X105.294 Y122.151 E1.32543
M204 S10000
; WIPE_START
G1 X105.278 Y124.15 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X104.444 Y121.555 Z5.4 F30000
G1 Z5
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.431684
G1 F15000
G1 X104.444 Y130.445 E.28163
G1 X105.094 Y131.606 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X104.846 Y131.81 E.01063
G1 X104.394 Y131.81 E.01499
G1 X104.394 Y132.654 E.02801
G1 X105.118 Y133.378 E.03397
G1 X105.713 Y133.378 E.01974
G1 X107.486 Y131.606 E.08314
G1 X111.022 Y131.606 E.11731
G1 X112.794 Y133.378 E.08314
G1 X113.389 Y133.378 E.01974
G1 X115.162 Y131.606 E.08314
G1 X118.698 Y131.606 E.11731
G1 X120.47 Y133.378 E.08314
G1 X121.065 Y133.378 E.01974
G1 X122.838 Y131.606 E.08314
G1 X126.374 Y131.606 E.11731
G1 X128.146 Y133.378 E.08314
G1 X128.741 Y133.378 E.01974
G1 X130.514 Y131.606 E.08314
G1 X134.05 Y131.606 E.11731
G1 X135.55 Y133.107 E.07039
G3 X134.95 Y133.447 I-2.952 J-4.514 E.02291
G1 X134.873 Y133.175 E.00936
G1 X134.233 Y133.311 E.02172
G1 X137.206 Y130.684 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.520377
G1 F13194.924
G1 X105.091 Y130.684 E1.24948
G1 X105.059 Y130.786 E.00415
G1 X104.689 Y130.869 E.01473
G1 X104.469 Y130.869 E.00856
G1 X104.469 Y131.386 E.02013
G1 X104.68 Y131.386 E.00821
; LINE_WIDTH: 0.489503
G1 F14107.146
G1 X104.86 Y131.24 E.00843
G1 X105.255 Y131.163 E.01464
; LINE_WIDTH: 0.521749
G1 F13157.102
G1 X137.206 Y131.163 E1.24669
G1 X137.333 Y131.214 E.00535
G1 X137.761 Y130.719 E.02551
G1 X137.727 Y130.685 E.00186
G1 X137.266 Y130.685 E.01799
G1 X138.205 Y130.59 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.333038
G1 F15000
G1 X148.378 Y130.59 E.24051
G1 X148.671 Y130.611 E.00695
; LINE_WIDTH: 0.272997
G1 X148.965 Y130.631 E.00551
; LINE_WIDTH: 0.232591
G1 X149.258 Y130.651 E.00454
; LINE_WIDTH: 0.193097
G1 X149.572 Y130.671 E.00385
; LINE_WIDTH: 0.15459
G1 X149.885 Y130.691 E.00286
; LINE_WIDTH: 0.116144
G1 X150.199 Y130.71 E.00187
; WIPE_START
G1 X149.885 Y130.691 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X149.63 Y123.063 Z5.4 F30000
G1 X149.572 Y121.329 Z5.4
G1 Z5
G1 E.8 F1800
; LINE_WIDTH: 0.15459
G1 F15000
G1 X149.885 Y121.309 E.00286
; LINE_WIDTH: 0.116144
G1 X150.199 Y121.29 E.00187
G1 X149.572 Y121.329 F30000
; LINE_WIDTH: 0.193097
G1 F15000
G1 X149.258 Y121.349 E.00385
; LINE_WIDTH: 0.232591
G1 X148.965 Y121.369 E.00454
; LINE_WIDTH: 0.272996
G1 X148.671 Y121.389 E.00551
; LINE_WIDTH: 0.333038
G1 X148.378 Y121.41 E.00695
G1 X138.205 Y121.41 E.24051
G1 X137.211 Y121.316 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.520465
G1 F13192.472
G1 X137.726 Y121.315 E.02005
G1 X137.761 Y121.28 E.00189
G1 X137.344 Y120.794 E.02493
G1 X137.211 Y120.837 E.00544
G1 X105.255 Y120.837 E1.24354
G1 X104.833 Y120.744 E.01682
G1 X104.68 Y120.614 E.0078
G1 X104.469 Y120.614 E.00821
G1 X104.469 Y121.131 E.02014
; LINE_WIDTH: 0.470297
G1 F14741.085
G1 X104.7 Y121.15 E.00807
; LINE_WIDTH: 0.444921
G1 F15000
G1 X104.931 Y121.169 E.00759
; LINE_WIDTH: 0.454597
G1 X104.995 Y121.191 E.00227
; LINE_WIDTH: 0.521642
G1 F13160.037
G1 X105.059 Y121.214 E.00264
G1 X105.091 Y121.316 E.00416
G1 X137.151 Y121.316 E1.25065
G1 X134.233 Y118.689 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X134.873 Y118.825 E.02172
G1 X134.95 Y118.553 E.00936
G3 X135.55 Y118.893 I-2.353 J4.856 E.02291
G1 X134.05 Y120.394 E.07039
G1 X130.514 Y120.394 E.11731
G1 X128.741 Y118.622 E.08314
G1 X128.146 Y118.622 E.01974
G1 X126.374 Y120.394 E.08314
G1 X122.838 Y120.394 E.11731
G1 X121.065 Y118.622 E.08314
G1 X120.47 Y118.622 E.01974
G1 X118.698 Y120.394 E.08314
G1 X115.162 Y120.394 E.11731
G1 X113.389 Y118.622 E.08314
G1 X112.794 Y118.622 E.01974
G1 X111.022 Y120.394 E.08314
G1 X107.486 Y120.394 E.11731
G1 X105.713 Y118.622 E.08314
G1 X105.118 Y118.622 E.01975
G1 X104.394 Y119.346 E.03397
G1 X104.394 Y120.19 E.02801
G1 X104.846 Y120.19 E.01499
G1 X105.094 Y120.394 E.01063
G1 X104.39 Y118.278 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.38292
G1 F15000
G1 X133.602 Y118.278 E.80935
G3 X134.58 Y118.424 I.002 J3.336 E.0275
; WIPE_START
G1 X134.119 Y118.318 E-.17983
G1 X133.602 Y118.278 E-.19704
G1 X132.594 Y118.278 E-.38313
; WIPE_END
G1 E-.04 F1800
G1 X125.899 Y121.944 Z5.4 F30000
G1 X104.39 Y133.722 Z5.4
G1 Z5
G1 E.8 F1800
G1 F15000
G1 X133.602 Y133.722 E.80935
G2 X134.58 Y133.577 I.019 J-3.232 E.02751
; CHANGE_LAYER
; Z_HEIGHT: 5.2
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F15000
G1 X134.112 Y133.685 E-.18277
G1 X133.602 Y133.722 E-.19412
G1 X132.594 Y133.722 E-.3831
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 26/101
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L26
M991 S0 P25 ;notify layer change
G17
G3 Z5.4 I.491 J-1.114 P1  F30000
G1 X104.842 Y121.485 Z5.4
G1 Z5.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X104.842 Y130.515 E.29956
G1 X148.408 Y130.515 E1.44517
G2 X151.605 Y130.895 I24.701 J-194.477 E.10679
G1 X151.592 Y131.125 E.00766
G1 X138.174 Y131.125 E.44511
G3 X136.364 Y133.037 I-50.639 J-46.137 E.08732
G3 X133.614 Y134.178 I-2.784 J-2.823 E.10126
G1 X104.046 Y134.178 E.98082
G1 X104.046 Y117.822 E.54256
G1 X133.614 Y117.822 E.98082
G1 X133.962 Y117.845 E.01157
G1 X134.132 Y117.856 E.00565
G3 X136.413 Y119.009 I-.588 J3.995 E.08627
G3 X138.174 Y120.875 I-31.764 J31.747 E.0851
G1 X151.592 Y120.875 E.44511
G1 X151.605 Y121.105 E.00766
G2 X148.408 Y121.485 I21.504 J194.856 E.10679
G1 X104.902 Y121.485 E1.44318
G1 X105.234 Y121.877 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
G1 X105.234 Y130.123 E.25339
G1 X148.431 Y130.123 E1.32734
G2 X153.234 Y130.682 I36.415 J-292.167 E.14856
G1 X153.234 Y131.372 E.02122
G1 F2280
G1 X153.234 Y131.517 E.00446
G1 X152.303 Y131.517 E.02858
G1 F2400
G1 X150.443 Y131.517 E.05717
G1 F2520
G1 X148.582 Y131.517 E.05717
G1 F2640
G1 X146.722 Y131.517 E.05717
G1 F2760
G1 X143.931 Y131.517 E.08575
G1 F2880
G1 X142.071 Y131.517 E.05717
G1 F3000
G1 X140.21 Y131.517 E.05717
G1 F3900
G1 X139.81 Y131.517 E.01229
G1 X138.35 Y131.517 E.04488
G1 F4800
G1 X138.031 Y131.876 E.01473
G1 F7500
G1 X137.406 Y132.534 E.02791
G1 F6600
G1 X136.907 Y133.042 E.02186
G1 X136.627 Y133.327 E.01229
G1 F5700
G1 X136.24 Y133.665 E.01577
G1 F4800
G1 X135.761 Y133.996 E.0179
G1 F5700
G1 X135.255 Y134.244 E.01731
G1 F6600
G1 X134.726 Y134.424 E.01717
G1 F5700
G3 X133.627 Y134.57 I-1.1 J-4.071 E.03419
G1 X103.654 Y134.57 E.92098
G1 F6758.171
G1 X103.654 Y134.499 E.00217
G1 F12000
G1 X103.654 Y134.099 E.01229
G1 X103.654 Y117.901 E.49775
G1 X103.654 Y117.501 E.01229
G1 F5700
G1 X103.654 Y117.43 E.00217
G1 X133.627 Y117.43 E.92098
G1 X133.988 Y117.454 E.01112
G1 X134.183 Y117.467 E.00603
G1 F6600
G1 X134.726 Y117.576 E.01701
G1 F5700
G1 X135.255 Y117.756 E.01717
G1 F4800
G1 X135.775 Y118.013 E.01781
G1 F5700
G1 X136.24 Y118.335 E.01739
G1 F6600
G1 X136.687 Y118.729 E.01832
G1 F7500
G1 X136.967 Y119.016 E.01229
G1 X137.406 Y119.466 E.01932
G1 F4800
G1 X138.031 Y120.124 E.02791
G1 F3900
G1 X138.35 Y120.483 E.01473
G1 X139.28 Y120.483 E.02858
G1 F3000
G1 X141.14 Y120.483 E.05717
G1 F2880
G1 X143.001 Y120.483 E.05717
G1 F2760
G1 X145.792 Y120.483 E.08575
G1 F2640
G1 X147.652 Y120.483 E.05717
G1 F2520
G1 X149.513 Y120.483 E.05717
G1 F2400
G1 X151.373 Y120.483 E.05717
G1 F2280
G1 X153.234 Y120.483 E.05717
G1 F3782.931
G1 X153.234 Y120.628 E.00446
G1 F12000
G1 X153.234 Y121.318 E.02122
G2 X148.431 Y121.877 I31.612 J292.725 E.14856
G1 X105.294 Y121.877 E1.32549
M204 S10000
; WIPE_START
G1 X105.279 Y123.877 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X104.444 Y121.281 Z5.6 F30000
G1 Z5.2
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.431684
G1 F15000
G1 X104.444 Y130.719 E.29897
G1 X105.288 Y120.199 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F15476.087
G3 X104.846 Y119.996 I-.119 J-.323 E.01794
G1 X104.394 Y119.996 E.01499
G1 X104.394 Y119.346 E.02155
G1 X105.57 Y118.17 E.05515
G1 X105.262 Y118.17 E.01021
G1 X107.291 Y120.199 E.09518
G1 X111.217 Y120.199 E.13023
G1 X113.246 Y118.17 E.09518
G1 X112.938 Y118.17 E.01021
G1 X114.967 Y120.199 E.09518
G1 X118.893 Y120.199 E.13023
G1 X120.922 Y118.17 E.09518
G1 X120.614 Y118.17 E.01021
G1 X122.643 Y120.199 E.09518
G1 X126.569 Y120.199 E.13023
G1 X128.598 Y118.17 E.09518
G1 X128.29 Y118.17 E.01021
G1 X130.319 Y120.199 E.09518
G1 X134.245 Y120.199 E.13023
G1 X135.63 Y118.813 E.065
G2 X134.134 Y118.212 I-2.466 J3.972 E.05375
G1 X137.191 Y121.062 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.482304
G1 F14338.26
G1 X137.733 Y121.06 E.01942
G1 X137.748 Y121.045 E.00074
G1 X137.323 Y120.584 E.02246
G1 X137.191 Y120.622 E.00491
G1 X105.234 Y120.622 E1.1442
; LINE_WIDTH: 0.468312
G1 F14809.869
G1 X105.054 Y120.585 E.00636
; LINE_WIDTH: 0.451052
G1 F15000
G1 X104.875 Y120.548 E.0061
G1 X104.623 Y120.407 E.00959
G1 X104.457 Y120.407 E.00554
G1 X104.457 Y120.87 E.01541
; LINE_WIDTH: 0.442132
G1 X104.694 Y120.893 E.00775
; LINE_WIDTH: 0.410179
G1 X104.931 Y120.916 E.00713
; LINE_WIDTH: 0.416207
G1 X104.99 Y120.938 E.0019
; LINE_WIDTH: 0.482177
G1 F14342.426
G1 X105.048 Y120.96 E.00224
G1 X105.078 Y121.062 E.00379
G1 X137.131 Y121.062 E1.14729
G1 X138.173 Y121.18 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.244929
G1 F15000
G1 X148.39 Y121.18 E.16818
G1 X148.815 Y121.154 E.00701
; LINE_WIDTH: 0.171422
G1 X149.24 Y121.129 E.00446
; LINE_WIDTH: 0.121754
G1 X149.665 Y121.104 E.00274
G1 X151.794 Y120.979 F30000
; LINE_WIDTH: 0.592499
G1 F11463.335
G1 X152.416 Y120.945 E.02789
; LINE_WIDTH: 0.552799
G1 F12355.873
G1 X153.038 Y120.91 E.02588
; WIPE_START
G1 X152.416 Y120.945 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X152.416 Y128.577 Z5.6 F30000
G1 X152.416 Y131.055 Z5.6
G1 Z5.2
G1 E.8 F1800
; LINE_WIDTH: 0.592498
G1 F11463.352
G1 X151.794 Y131.021 E.02789
G1 X152.416 Y131.055 F30000
; LINE_WIDTH: 0.552798
G1 F12355.902
G1 X153.038 Y131.09 E.02588
G1 X149.665 Y130.896 F30000
; LINE_WIDTH: 0.121754
G1 F15000
G1 X149.24 Y130.871 E.00274
; LINE_WIDTH: 0.171421
G1 X148.815 Y130.846 E.00446
; LINE_WIDTH: 0.244929
G1 X148.39 Y130.82 E.00701
G1 X138.173 Y130.82 E.16818
G1 X137.191 Y130.938 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.481431
G1 F14366.821
G1 X105.078 Y130.938 E1.14749
G1 X105.048 Y131.04 E.00379
G1 X104.665 Y131.13 E.01409
G1 X104.457 Y131.13 E.00742
G1 X104.457 Y131.593 E.01656
G1 X104.685 Y131.593 E.00815
; LINE_WIDTH: 0.449677
G1 F15000
G1 X104.875 Y131.452 E.00784
G1 X105.234 Y131.378 E.01216
; LINE_WIDTH: 0.482335
G1 F14337.257
G1 X137.191 Y131.378 E1.14428
G1 X137.325 Y131.43 E.00516
G1 X137.747 Y130.958 E.02269
G1 X137.251 Y130.941 E.01779
G1 X134.134 Y133.788 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F15476.087
G2 X135.63 Y133.186 I-.964 J-4.556 E.05375
G1 X134.245 Y131.801 E.06499
G1 X130.319 Y131.801 E.13023
G1 X128.29 Y133.83 E.09518
G1 X128.598 Y133.83 E.01021
G1 X126.569 Y131.801 E.09518
G1 X122.643 Y131.801 E.13023
G1 X120.614 Y133.83 E.09518
G1 X120.922 Y133.83 E.01021
G1 X118.893 Y131.801 E.09518
G1 X114.967 Y131.801 E.13023
G1 X112.938 Y133.83 E.09518
G1 X113.246 Y133.83 E.01021
G1 X111.217 Y131.801 E.09518
G1 X107.291 Y131.801 E.13023
G1 X105.262 Y133.83 E.09518
G1 X105.57 Y133.83 E.01021
G1 X104.394 Y132.654 E.05515
G1 X104.394 Y132.004 E.02155
G1 X104.846 Y132.004 E.01499
G3 X105.288 Y131.801 I.323 J.119 E.01794
; CHANGE_LAYER
; Z_HEIGHT: 5.4
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F15476.087
G1 X105.05 Y131.801 E-.09072
M73 P56 R8
G1 X104.846 Y132.004 E-.10938
G1 X104.394 Y132.004 E-.17175
G1 X104.394 Y132.654 E-.24691
G1 X104.657 Y132.917 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 27/101
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L27
M991 S0 P26 ;notify layer change
G17
G3 Z5.6 I1.217 J.019 P1  F30000
G1 X104.842 Y121.244 Z5.6
G1 Z5.4
G1 E.8 F1800
; FEATURE: Inner wall
G1 F15476.087
G1 X104.842 Y130.756 E.31556
G1 X148.408 Y130.756 E1.44517
G2 X151.101 Y131.065 I19.092 J-154.616 E.08994
G1 X151.089 Y131.296 E.00767
G1 X138.185 Y131.296 E.42804
G3 X136.425 Y133.109 I-43.763 J-40.712 E.08382
G3 X133.614 Y134.29 I-2.838 J-2.82 E.10379
G1 X104.046 Y134.29 E.98082
G1 X104.046 Y117.71 E.54998
G1 X133.614 Y117.71 E.98082
G1 X133.804 Y117.723 E.00633
G3 X136.425 Y118.891 I-.191 J3.955 E.09742
G3 X138.185 Y120.704 I-42.003 J42.525 E.08382
G1 X151.089 Y120.704 E.42804
G1 X151.101 Y120.935 E.00767
G2 X148.408 Y121.244 I16.398 J154.924 E.08994
G1 X104.902 Y121.244 E1.44318
G1 X105.234 Y121.636 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
G1 X105.234 Y130.364 E.26821
G1 X148.431 Y130.364 E1.32734
G2 X153.234 Y130.907 I33.601 J-275.634 E.14851
G1 X153.234 Y131.558 E.02
G1 F2400
G1 X153.234 Y131.688 E.00399
G1 F2520
G1 X151.374 Y131.688 E.05715
G1 F2640
G1 X149.514 Y131.688 E.05715
G1 F2760
G1 X147.654 Y131.688 E.05715
G1 F2880
G1 X144.864 Y131.688 E.08573
G1 F3000
G1 X143.004 Y131.688 E.05715
G1 F3900
G1 X142.604 Y131.688 E.01229
G1 X141.144 Y131.688 E.04486
G1 F4800
G1 X140.744 Y131.688 E.01229
G1 X139.284 Y131.688 E.04486
G1 F5700
G1 X138.353 Y131.688 E.02858
G1 F7500
G1 X138.076 Y131.976 E.01229
G1 X136.989 Y133.107 E.0482
G1 F8400
G1 X136.692 Y133.397 E.01275
G1 F7500
G3 X136.242 Y133.792 I-2.999 J-2.964 E.01841
G1 X135.763 Y134.106 E.0176
G1 F6600
G3 X135.255 Y134.356 I-2.189 J-3.816 E.0174
G1 X134.726 Y134.536 E.01717
G1 F5700
G3 X133.627 Y134.682 I-1.1 J-4.071 E.03419
G1 X103.654 Y134.682 E.92098
G1 F6758.187
G1 X103.654 Y134.611 E.00217
G1 F12000
G1 X103.654 Y134.211 E.01229
G1 X103.654 Y117.789 E.50461
G1 X103.654 Y117.389 E.01229
G1 F5700
G1 X103.654 Y117.318 E.00217
G1 X133.627 Y117.318 E.92098
G1 X133.83 Y117.332 E.00626
G1 X134.183 Y117.355 E.01089
G1 F6600
G1 X134.726 Y117.464 E.01701
G3 X135.255 Y117.644 I-1.11 J4.123 E.01718
G1 F7500
G1 X135.763 Y117.894 E.01739
G3 X136.242 Y118.208 I-2.262 J3.965 E.01761
G1 F8400
G1 X136.692 Y118.603 E.0184
G1 F7500
G1 X137.38 Y119.298 E.03006
G1 X137.661 Y119.582 E.01229
G1 F5700
G1 X138.078 Y120.022 E.01861
G1 X138.353 Y120.312 E.01229
G1 F4800
G1 X139.814 Y120.312 E.04486
G1 X140.214 Y120.312 E.01229
G1 F3900
G1 X141.674 Y120.312 E.04486
G1 X142.074 Y120.312 E.01229
G1 F3000
G1 X143.934 Y120.312 E.05715
G1 F2880
G1 X146.724 Y120.312 E.08573
G1 F2760
G1 X148.584 Y120.312 E.05715
G1 F2640
G1 X150.444 Y120.312 E.05715
G1 F2520
G1 X152.304 Y120.312 E.05715
G1 F2400
G1 X153.234 Y120.312 E.02858
G1 F3757.621
G1 X153.234 Y120.442 E.00399
G1 F12000
G1 X153.234 Y121.093 E.02
G2 X148.431 Y121.636 I28.798 J276.177 E.14851
G1 X105.294 Y121.636 E1.32549
M204 S10000
; WIPE_START
G1 X105.28 Y123.636 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X104.444 Y121.04 Z5.8 F30000
G1 Z5.4
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.431684
G1 F15000
G1 X104.444 Y130.96 E.31426
G1 X105.45 Y131.963 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X105.05 Y131.963 E.0133
G1 X104.846 Y132.167 E.00955
G1 X104.394 Y132.167 E.01499
G1 X104.394 Y132.654 E.01618
G1 X105.681 Y133.942 E.06039
G1 X105.15 Y133.942 E.01762
G1 X107.129 Y131.963 E.09282
G1 X111.379 Y131.963 E.14098
G1 X113.357 Y133.942 E.09282
G1 X112.826 Y133.942 E.01762
G1 X114.805 Y131.963 E.09282
G1 X119.055 Y131.963 E.14098
G1 X121.033 Y133.942 E.09282
G1 X120.502 Y133.942 E.01762
G1 X122.481 Y131.963 E.09282
G1 X126.731 Y131.963 E.14098
G1 X128.709 Y133.942 E.09282
G1 X128.178 Y133.942 E.01762
G1 X130.157 Y131.963 E.09282
G1 X134.407 Y131.963 E.14098
G1 X135.703 Y133.26 E.06083
G3 X134.215 Y133.883 I-2.642 J-4.217 E.05377
G1 X137.213 Y131.16 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.442359
G1 F15000
G1 X105.211 Y131.16 E1.04163
G1 X105.067 Y131.164 E.00471
G1 X105.037 Y131.262 E.00333
G1 X104.64 Y131.359 E.01332
G1 X104.444 Y131.359 E.00635
G1 X104.444 Y131.768 E.01332
G1 X104.69 Y131.768 E.00798
; LINE_WIDTH: 0.413996
G1 X104.81 Y131.693 E.0043
; LINE_WIDTH: 0.391626
G1 X104.931 Y131.618 E.00404
G1 X105.211 Y131.56 E.00813
; LINE_WIDTH: 0.442746
G1 X137.213 Y131.56 E1.04264
G1 X137.347 Y131.591 E.00449
G1 X137.754 Y131.162 E.01927
G1 X137.273 Y131.16 E.01568
G1 X138.16 Y131.026 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.174805
G1 F15000
G1 X148.392 Y131.026 E.10996
G1 X148.734 Y131.047 E.00369
; LINE_WIDTH: 0.116551
G1 X149.076 Y131.067 E.00206
G1 X151.291 Y131.192 F30000
; LINE_WIDTH: 0.589644
G1 F11523.198
G1 X151.873 Y131.224 E.02598
; LINE_WIDTH: 0.543673
G1 F12581.07
G1 X152.455 Y131.256 E.0238
; LINE_WIDTH: 0.497702
G1 F13852.807
G1 X153.038 Y131.288 E.02161
; WIPE_START
G1 X152.455 Y131.256 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X152.876 Y123.635 Z5.8 F30000
G1 X153.038 Y120.712 Z5.8
G1 Z5.4
G1 E.8 F1800
; LINE_WIDTH: 0.497701
G1 F13852.831
G1 X152.455 Y120.744 E.02161
; LINE_WIDTH: 0.543673
G1 F12581.069
G1 X151.873 Y120.776 E.0238
; LINE_WIDTH: 0.589644
G1 F11523.179
G1 X151.291 Y120.808 E.02598
G1 X149.076 Y120.933 F30000
; LINE_WIDTH: 0.116551
G1 F15000
G1 X148.734 Y120.953 E.00206
; LINE_WIDTH: 0.174805
G1 X148.392 Y120.974 E.00369
G1 X138.16 Y120.974 E.10996
G1 X137.212 Y120.84 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.442741
G1 F15000
G1 X137.753 Y120.839 E.01764
G1 X137.333 Y120.402 E.01974
G1 X137.212 Y120.44 E.00416
G1 X105.211 Y120.44 E1.04258
; LINE_WIDTH: 0.427399
G1 X105.05 Y120.405 E.00517
; LINE_WIDTH: 0.403658
G1 X104.889 Y120.369 E.00485
G1 X104.623 Y120.232 E.00879
; LINE_WIDTH: 0.433172
G1 X104.444 Y120.232 E.00569
G1 X104.444 Y120.641 E.01301
; LINE_WIDTH: 0.413996
G1 X104.688 Y120.668 E.0074
; LINE_WIDTH: 0.38326
G3 X105.037 Y120.738 I.051 J.652 E.01001
; LINE_WIDTH: 0.442657
G1 X105.067 Y120.836 E.00334
G1 X105.211 Y120.84 E.00472
G1 X137.152 Y120.84 E1.0404
G1 X134.215 Y118.117 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F15476.087
G3 X135.703 Y118.74 I-1.154 J4.84 E.05377
G1 X134.407 Y120.037 E.06083
G1 X130.157 Y120.037 E.14098
G1 X128.178 Y118.058 E.09282
G1 X128.709 Y118.058 E.01762
G1 X126.731 Y120.037 E.09282
G1 X122.481 Y120.037 E.14098
G1 X120.502 Y118.058 E.09282
G1 X121.033 Y118.058 E.01762
G1 X119.055 Y120.037 E.09282
G1 X114.805 Y120.037 E.14098
G1 X112.826 Y118.058 E.09282
G1 X113.357 Y118.058 E.01762
G1 X111.379 Y120.037 E.09282
G1 X107.129 Y120.037 E.14098
G1 X105.15 Y118.058 E.09282
G1 X105.681 Y118.058 E.01762
G1 X104.394 Y119.346 E.06039
G1 X104.394 Y119.833 E.01618
G1 X104.846 Y119.833 E.01499
G1 X105.05 Y120.037 E.00955
G1 X105.45 Y120.037 E.0133
; CHANGE_LAYER
; Z_HEIGHT: 5.6
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F15476.087
G1 X105.05 Y120.037 E-.15232
G1 X104.846 Y119.833 E-.10938
G1 X104.394 Y119.833 E-.17175
G1 X104.394 Y119.346 E-.18531
G1 X104.657 Y119.083 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 28/101
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L28
M991 S0 P27 ;notify layer change
G17
G3 Z5.8 I-1.211 J.116 P1  F30000
G1 X104.842 Y121.016 Z5.8
G1 Z5.6
G1 E.8 F1800
; FEATURE: Inner wall
G1 F15476.087
G1 X104.842 Y130.984 E.33065
G1 X148.412 Y130.984 E1.4453
G1 X150.605 Y131.218 E.07315
G1 X150.592 Y131.449 E.00768
G1 X138.185 Y131.449 E.41157
G3 X136.011 Y133.586 I-21.119 J-19.309 E.10119
G3 X133.614 Y134.402 I-2.463 J-3.31 E.08537
G1 X104.046 Y134.402 E.98082
G1 X104.046 Y117.598 E.55739
G1 X133.646 Y117.601 E.9819
G3 X136.426 Y118.772 I-.105 J4.133 E.10242
G3 X138.185 Y120.551 I-37.094 J38.432 E.08301
G1 X150.592 Y120.551 E.41157
G1 X150.605 Y120.782 E.00768
G1 X148.412 Y121.016 E.07315
G1 X104.902 Y121.016 E1.44331
G1 X105.234 Y121.408 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
G1 X105.234 Y130.592 E.28219
G1 X148.433 Y130.592 E1.32738
G2 X153.234 Y131.095 I43.888 J-395.987 E.14833
G1 X153.234 Y131.729 E.0195
G1 F2640
G1 X153.234 Y131.841 E.00344
G1 F2760
G1 X151.374 Y131.841 E.05715
G1 F2880
G1 X149.514 Y131.841 E.05715
G1 F3000
G1 X147.654 Y131.841 E.05715
G1 F3900
G1 X147.254 Y131.841 E.01229
G1 X144.864 Y131.841 E.07344
G1 F4800
G1 X144.464 Y131.841 E.01229
G1 X143.004 Y131.841 E.04486
G1 F5700
G1 X142.604 Y131.841 E.01229
G1 X141.144 Y131.841 E.04486
G1 F6600
G1 X140.744 Y131.841 E.01229
G1 X139.284 Y131.841 E.04486
G1 F7500
G1 X138.353 Y131.841 E.02858
G3 X137.518 Y132.71 I-31.179 J-29.138 E.03705
G1 F9300
G1 X137.232 Y132.99 E.01229
G1 X136.685 Y133.508 E.02317
G1 X136.244 Y133.902 E.01815
G1 F7500
G1 X135.763 Y134.218 E.01769
G1 F6600
G3 X135.255 Y134.467 I-2.189 J-3.817 E.0174
G1 X134.726 Y134.648 E.01717
G1 F5700
G3 X133.627 Y134.794 I-1.1 J-4.071 E.03419
G1 X103.654 Y134.794 E.92098
G1 F6758.171
G1 X103.654 Y134.723 E.00217
G1 F12000
G1 X103.654 Y134.323 E.01229
G1 X103.654 Y117.677 E.51148
G1 X103.654 Y117.277 E.01229
G1 F5700
G1 X103.654 Y117.206 E.00217
G1 X133.672 Y117.209 E.92238
G1 X134.183 Y117.243 E.01574
G1 F6600
G1 X134.726 Y117.352 E.01701
G3 X135.255 Y117.533 I-1.11 J4.123 E.01718
G1 F7500
G1 X135.763 Y117.782 E.01739
G1 F9300
G1 X136.242 Y118.101 E.01768
G3 X136.692 Y118.484 I-3.03 J4.024 E.01816
G1 X137.098 Y118.876 E.01735
G1 F7500
G1 X138.074 Y119.873 E.04287
G1 X138.353 Y120.159 E.01229
G1 F6600
G1 X139.814 Y120.159 E.04486
G1 X140.214 Y120.159 E.01229
G1 F5700
G1 X141.674 Y120.159 E.04486
G1 X142.074 Y120.159 E.01229
G1 F4800
G1 X143.534 Y120.159 E.04486
G1 X143.934 Y120.159 E.01229
G1 F3900
G1 X146.324 Y120.159 E.07344
G1 X146.724 Y120.159 E.01229
G1 F3000
G1 X148.584 Y120.159 E.05715
G1 F2880
G1 X150.444 Y120.159 E.05715
G1 F2760
G1 X152.304 Y120.159 E.05715
G1 F2640
G1 X153.234 Y120.159 E.02858
G1 F3842.743
G1 X153.234 Y120.271 E.00344
G1 F12000
G1 X153.234 Y120.905 E.0195
G2 X148.433 Y121.408 I39.087 J396.49 E.14833
G1 X105.294 Y121.408 E1.32554
M204 S10000
; WIPE_START
G1 X105.281 Y123.408 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X104.444 Y120.813 Z6 F30000
G1 Z5.6
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.431684
G1 F15000
G1 X104.444 Y131.187 E.32867
; WIPE_START
G1 X104.444 Y129.187 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X105.391 Y121.614 Z6 F30000
G1 X105.607 Y119.88 Z6
G1 Z5.6
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X105.05 Y119.88 E.01851
G1 X104.846 Y119.676 E.00955
G1 X104.394 Y119.676 E.01499
G1 X104.394 Y119.346 E.01097
G1 X105.793 Y117.947 E.06563
G1 X105.039 Y117.947 E.02503
G1 X106.972 Y119.88 E.09069
G1 X111.536 Y119.88 E.1514
G1 X113.468 Y117.947 E.09066
G1 X112.715 Y117.947 E.02499
G1 X114.648 Y119.88 E.09066
G1 X119.212 Y119.88 E.1514
G1 X121.144 Y117.948 E.09063
G1 X120.392 Y117.948 E.02495
G1 X122.324 Y119.88 E.09064
G1 X126.888 Y119.88 E.1514
G1 X128.819 Y117.949 E.09061
G1 X128.068 Y117.948 E.02491
G1 X130 Y119.88 E.09061
G1 X134.564 Y119.88 E.1514
G1 X135.771 Y118.673 E.05663
G2 X134.294 Y118.021 I-2.771 J4.276 E.05378
G1 X137.211 Y120.63 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.40754
G1 F15000
G1 X137.721 Y120.628 E.01517
G1 X137.333 Y120.224 E.01665
G1 X137.211 Y120.266 E.00385
G1 X105.19 Y120.266 E.95139
; LINE_WIDTH: 0.390967
G1 X105.046 Y120.231 E.0042
; LINE_WIDTH: 0.369142
G3 X104.627 Y120.062 I.168 J-1.02 E.01211
; LINE_WIDTH: 0.407429
G1 X104.432 Y120.062 E.0058
G1 X104.432 Y120.427 E.01083
; LINE_WIDTH: 0.384419
G1 X104.67 Y120.454 E.00668
; LINE_WIDTH: 0.346373
G3 X105.027 Y120.528 I.045 J.673 E.00912
; LINE_WIDTH: 0.407429
G1 X105.067 Y120.63 E.00325
G1 X137.151 Y120.63 E.95299
G1 X138.125 Y120.784 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.100779
G1 F15000
G1 X148.463 Y120.78 E.04874
G1 X150.794 Y120.656 F30000
; LINE_WIDTH: 0.597805
G1 F11353.71
G1 X151.263 Y120.631 E.02123
; LINE_WIDTH: 0.563163
G1 F12109.741
G1 X151.732 Y120.607 E.0199
; LINE_WIDTH: 0.527243
G1 F13007.861
G1 X152.168 Y120.585 E.01724
; LINE_WIDTH: 0.490165
G1 F14086.241
G1 X152.603 Y120.563 E.01586
; LINE_WIDTH: 0.453153
G1 F15000
G1 X153.038 Y120.541 E.01455
; WIPE_START
G1 X152.603 Y120.563 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X152.603 Y128.195 Z6 F30000
G1 X152.603 Y131.437 Z6
G1 Z5.6
G1 E.8 F1800
; LINE_WIDTH: 0.490165
G1 F14086.26
G1 X152.168 Y131.415 E.01586
; LINE_WIDTH: 0.527243
G1 F13007.854
G1 X151.732 Y131.393 E.01724
; LINE_WIDTH: 0.563163
G1 F12109.738
G1 X151.263 Y131.369 E.0199
; LINE_WIDTH: 0.597804
G1 F11353.733
G1 X150.794 Y131.344 E.02123
G1 X152.603 Y131.437 F30000
; LINE_WIDTH: 0.453151
G1 F15000
G1 X153.038 Y131.459 E.01455
G1 X148.463 Y131.22 F30000
; LINE_WIDTH: 0.100779
G1 F15000
G1 X138.125 Y131.216 E.04874
G1 X137.213 Y131.37 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.407429
G1 F15000
G1 X105.045 Y131.37 E.95547
G1 X105.027 Y131.472 E.00307
G1 X104.614 Y131.573 E.01263
G1 X104.432 Y131.573 E.00541
G1 X104.432 Y131.938 E.01083
G1 X104.694 Y131.938 E.0078
; LINE_WIDTH: 0.384419
G1 X104.824 Y131.863 E.00417
; LINE_WIDTH: 0.352622
G3 X105.19 Y131.734 I.392 J.529 E.00994
; LINE_WIDTH: 0.407529
G1 X137.213 Y131.734 E.95143
G1 X137.353 Y131.755 E.00422
G1 X137.722 Y131.372 E.0158
G1 X137.273 Y131.37 E.01333
G1 X134.294 Y133.979 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F15476.087
G2 X135.771 Y133.327 I-1.294 J-4.928 E.05378
G1 X134.564 Y132.12 E.05663
G1 X130 Y132.12 E.1514
G1 X128.066 Y134.053 E.09069
G1 X128.821 Y134.053 E.02503
M73 P57 R8
G1 X126.888 Y132.12 E.09069
G1 X122.324 Y132.12 E.1514
G1 X120.39 Y134.053 E.09069
G1 X121.145 Y134.053 E.02503
G1 X119.212 Y132.12 E.09069
G1 X114.648 Y132.12 E.1514
G1 X112.714 Y134.053 E.09069
G1 X113.469 Y134.053 E.02503
G1 X111.536 Y132.12 E.09069
G1 X106.972 Y132.12 E.1514
G1 X105.039 Y134.053 E.09069
G1 X105.793 Y134.053 E.02503
G1 X104.394 Y132.654 E.06563
G1 X104.394 Y132.324 E.01097
G1 X104.846 Y132.324 E.01499
G1 X105.05 Y132.12 E.00955
G1 X105.607 Y132.12 E.01851
; CHANGE_LAYER
; Z_HEIGHT: 5.8
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F15476.087
G1 X105.05 Y132.12 E-.21199
G1 X104.846 Y132.324 E-.10938
G1 X104.394 Y132.324 E-.17175
G1 X104.394 Y132.654 E-.12564
G1 X104.657 Y132.917 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 29/101
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L29
M991 S0 P28 ;notify layer change
G17
G3 Z6 I1.217 J.019 P1  F30000
G1 X104.842 Y120.821 Z6
G1 Z5.8
G1 E.8 F1800
; FEATURE: Inner wall
G1 F13990
G1 X104.842 Y131.179 E.34357
G1 X148.412 Y131.179 E1.4453
G1 X150.211 Y131.37 E.06003
G1 X150.199 Y131.602 E.00768
G1 X138.188 Y131.602 E.39844
G3 X136.313 Y133.447 I-49.003 J-47.897 E.08725
G3 X133.614 Y134.499 I-2.707 J-2.956 E.09832
G1 X104.046 Y134.499 E.98084
G1 X104.046 Y117.501 E.56386
G1 X133.614 Y117.501 E.98084
G1 X134.084 Y117.531 E.01561
G1 X134.135 Y117.534 E.00169
G3 X136.426 Y118.652 I-.587 J4.108 E.08595
G3 X138.188 Y120.398 I-40.711 J42.838 E.08229
G1 X150.199 Y120.398 E.39844
G1 X150.211 Y120.63 E.00768
G1 X148.412 Y120.821 E.06003
G1 X104.902 Y120.821 E1.44331
G1 X105.234 Y121.213 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
G1 X105.234 Y130.787 E.29416
G1 X148.433 Y130.787 E1.32738
G1 X152.836 Y131.239 E.13601
G1 X153.234 Y131.28 E.01229
G1 F11776.535
G1 X153.234 Y131.882 E.01851
G1 F2640
G1 X153.234 Y131.994 E.00344
G1 F2760
G1 X151.374 Y131.994 E.05715
G1 F2880
G1 X149.514 Y131.994 E.05715
G1 F3000
G1 X146.724 Y131.994 E.08573
G1 F3900
G1 X146.324 Y131.994 E.01229
G1 X144.864 Y131.994 E.04486
G1 F4800
G1 X144.464 Y131.994 E.01229
G1 X143.004 Y131.994 E.04486
G1 F5700
G1 X142.604 Y131.994 E.01229
G1 X141.144 Y131.994 E.04486
G1 F6600
G1 X140.744 Y131.994 E.01229
G1 X138.354 Y131.994 E.07343
G1 F7500
G1 X138.047 Y132.313 E.01363
G1 F10200
G1 X137.359 Y132.991 E.02968
G1 F9300
G3 X136.692 Y133.636 I-8.124 J-7.736 E.02851
G1 X136.244 Y134.014 E.018
G1 F7500
G1 X135.763 Y134.33 E.01769
G1 F6600
G1 X135.256 Y134.579 E.01735
G1 F7500
G1 X134.728 Y134.751 E.01707
G1 F8400
G1 X134.185 Y134.856 E.01702
G3 X133.627 Y134.891 I-.557 J-4.362 E.01718
G1 X103.654 Y134.891 E.92099
G1 F9411.54
G1 X103.654 Y134.835 E.00174
G1 F12000
G1 X103.654 Y134.435 E.01229
G1 X103.654 Y117.565 E.51834
G1 X103.654 Y117.165 E.01229
G1 F8400
G1 X103.654 Y117.109 E.00174
G1 X133.627 Y117.109 E.92099
G1 X134.109 Y117.139 E.01484
G1 X134.185 Y117.144 E.00233
G1 F7500
G1 X134.728 Y117.249 E.01702
G1 F6600
G1 X135.256 Y117.421 E.01707
G1 F7500
G1 X135.763 Y117.67 E.01734
G1 F9300
G1 X136.24 Y117.992 E.01768
G3 X136.692 Y118.364 I-3.66 J4.908 E.018
G1 F10200
G1 X137.359 Y119.009 E.0285
G1 F7500
G1 X138.047 Y119.687 E.02968
G1 F6600
G1 X138.354 Y120.006 E.01363
G1 X139.814 Y120.006 E.04486
G1 X140.214 Y120.006 E.01229
G1 F5700
G1 X141.674 Y120.006 E.04486
G1 X142.074 Y120.006 E.01229
G1 F4800
G1 X143.534 Y120.006 E.04486
G1 X143.934 Y120.006 E.01229
G1 F3900
G1 X145.394 Y120.006 E.04486
G1 X145.794 Y120.006 E.01229
G1 F3000
G1 X148.584 Y120.006 E.08573
G1 F2880
G1 X150.444 Y120.006 E.05715
G1 F2760
G1 X152.304 Y120.006 E.05715
G1 F2640
G1 X153.234 Y120.006 E.02858
G1 F3842.732
G1 X153.234 Y120.118 E.00344
G1 F12000
G1 X153.234 Y120.72 E.01851
G2 X148.433 Y121.213 I38.291 J396.477 E.1483
G1 X105.294 Y121.213 E1.32554
M204 S10000
; WIPE_START
G1 X105.281 Y123.213 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X104.444 Y120.618 Z6.2 F30000
G1 Z5.8
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.431684
G1 F13990
G1 X104.444 Y131.382 E.34101
G1 X105.758 Y132.271 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F13990
G1 X105.05 Y132.271 E.02351
G1 X104.846 Y132.474 E.00955
G1 X104.394 Y132.474 E.01499
G1 X104.394 Y132.654 E.00597
G1 X105.891 Y134.151 E.07021
G1 X104.941 Y134.151 E.0315
G1 X106.821 Y132.271 E.08819
G1 X111.687 Y132.271 E.1614
G1 X113.567 Y134.151 E.08819
G1 X112.617 Y134.151 E.0315
G1 X114.497 Y132.271 E.08819
G1 X119.363 Y132.271 E.1614
G1 X121.243 Y134.151 E.08819
G1 X120.293 Y134.151 E.0315
G1 X122.173 Y132.271 E.08819
G1 X127.039 Y132.271 E.1614
G1 X128.919 Y134.151 E.08819
G1 X127.969 Y134.151 E.0315
G1 X129.849 Y132.271 E.08819
G1 X134.715 Y132.271 E.1614
G1 X135.835 Y133.391 E.05255
G3 X134.37 Y134.066 I-2.231 J-2.912 E.05395
G1 X137.22 Y131.553 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.385487
G1 F13990
G1 X105.034 Y131.553 E.89846
G1 X105.02 Y131.655 E.00287
G1 X104.895 Y131.754 E.00443
G1 X104.421 Y131.757 E.01325
G1 X104.421 Y132.1 E.00956
G1 X104.698 Y132.1 E.00776
G1 X104.939 Y131.907 E.00859
G1 X105.176 Y131.896 E.00664
G1 X137.22 Y131.896 E.8945
G1 X137.355 Y131.914 E.0038
G2 X137.709 Y131.556 I-5.617 J-5.898 E.01406
G1 X137.28 Y131.554 E.01197
; WIPE_START
G1 F15000
G1 X137.709 Y131.556 E-.16291
G1 X137.355 Y131.914 E-.19133
G1 X137.22 Y131.896 E-.05176
G1 X136.289 Y131.896 E-.354
; WIPE_END
G1 E-.04 F1800
G1 X136.901 Y124.288 Z6.2 F30000
G1 X137.21 Y120.447 Z6.2
G1 Z5.8
G1 E.8 F1800
; LINE_WIDTH: 0.385492
G1 F13990
G1 X137.702 Y120.444 E.01374
G1 X137.348 Y120.084 E.01411
G1 X137.21 Y120.104 E.00389
G1 X104.999 Y120.104 E.89917
G1 X104.888 Y120.063 E.00332
G1 X104.698 Y119.9 E.00697
G1 X104.421 Y119.9 E.00776
G1 X104.421 Y120.243 E.00956
G1 X104.924 Y120.254 E.01405
G1 X105.02 Y120.345 E.00368
G1 X105.034 Y120.447 E.00287
G1 X137.15 Y120.447 E.89652
G1 X134.369 Y117.936 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F13990
G3 X135.835 Y118.609 I-.742 J3.548 E.05394
G1 X134.715 Y119.729 E.05255
G1 X129.849 Y119.729 E.1614
G1 X127.969 Y117.849 E.08819
G1 X128.919 Y117.849 E.0315
G1 X127.039 Y119.729 E.08819
G1 X122.173 Y119.729 E.1614
G1 X120.293 Y117.849 E.08819
G1 X121.243 Y117.849 E.0315
G1 X119.363 Y119.729 E.08819
G1 X114.497 Y119.729 E.1614
G1 X112.617 Y117.849 E.08819
G1 X113.567 Y117.849 E.0315
G1 X111.687 Y119.729 E.08819
G1 X106.821 Y119.729 E.1614
G1 X104.941 Y117.849 E.08819
G1 X105.891 Y117.849 E.0315
G1 X104.394 Y119.346 E.07021
G1 X104.394 Y119.526 E.00597
G1 X104.846 Y119.526 E.01499
G1 X105.05 Y119.729 E.00955
G1 X105.758 Y119.729 E.02351
G1 X153.038 Y120.372 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.422483
G1 F13990
G1 X152.51 Y120.399 E.01633
; LINE_WIDTH: 0.465976
G1 X151.983 Y120.425 E.0182
; LINE_WIDTH: 0.509468
G1 F13503.448
G1 X151.456 Y120.451 E.02007
; LINE_WIDTH: 0.55296
G1 F12351.981
G1 X150.928 Y120.478 E.02195
; LINE_WIDTH: 0.596452
G1 F11381.458
G1 X150.401 Y120.504 E.02382
; WIPE_START
G1 X150.928 Y120.478 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X150.563 Y128.102 Z6.2 F30000
G1 X150.401 Y131.496 Z6.2
G1 Z5.8
G1 E.8 F1800
G1 F11381.458
G1 X150.928 Y131.522 E.02382
; LINE_WIDTH: 0.55296
G1 F12351.986
G1 X151.456 Y131.549 E.02195
; LINE_WIDTH: 0.509467
G1 F13503.461
G1 X151.983 Y131.575 E.02007
; LINE_WIDTH: 0.465975
G1 F13990
G1 X152.51 Y131.601 E.0182
; LINE_WIDTH: 0.422483
G1 X153.038 Y131.628 E.01633
; CHANGE_LAYER
; Z_HEIGHT: 6
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F15000
G1 X152.51 Y131.601 E-.76
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 30/101
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L30
M991 S0 P29 ;notify layer change
G17
G3 Z6.2 I.273 J-1.186 P1  F30000
G1 X104.842 Y120.627 Z6.2
G1 Z6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F13876
G1 X104.842 Y131.373 E.35649
G1 X148.413 Y131.373 E1.44535
G2 X149.739 Y131.507 I14.834 J-140.761 E.04421
G1 X149.728 Y131.739 E.00772
G1 X138.197 Y131.739 E.3825
G3 X136.432 Y133.458 I-80.29 J-80.66 E.08173
G3 X133.614 Y134.589 I-2.827 J-2.967 E.10318
G1 X104.046 Y134.589 E.98084
G1 X104.046 Y117.411 E.56986
G1 X133.614 Y117.411 E.98084
G1 X133.934 Y117.431 E.01061
G3 X136.463 Y118.57 I-.345 J4.144 E.09383
G3 X138.197 Y120.261 I-83.118 J86.983 E.08033
G1 X149.728 Y120.261 E.3825
G1 X149.739 Y120.493 E.00772
G2 X148.413 Y120.627 I13.509 J140.894 E.04421
G1 X104.902 Y120.627 E1.44336
G1 X105.234 Y121.019 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
G1 X105.234 Y130.981 E.30613
G1 X148.433 Y130.981 E1.3274
G1 X152.836 Y131.41 E.13592
G1 X153.234 Y131.449 E.01229
G1 F11933.434
G1 X153.234 Y132.035 E.018
G1 F2880
G1 X153.234 Y132.131 E.00297
G1 X152.304 Y132.131 E.02857
G1 F3000
G1 X150.444 Y132.131 E.05714
G1 F3900
G1 X150.044 Y132.131 E.01229
G1 X148.585 Y132.131 E.04485
G1 F4800
G1 X148.185 Y132.131 E.01229
G1 X145.796 Y132.131 E.07342
G1 F5700
G1 X145.396 Y132.131 E.01229
G1 X143.936 Y132.131 E.04485
G1 F6600
G1 X143.536 Y132.131 E.01229
G1 X142.077 Y132.131 E.04485
G1 F7500
G1 X141.677 Y132.131 E.01229
G1 X139.287 Y132.131 E.07342
G1 F8400
G1 X138.358 Y132.131 E.02857
G1 F10200
G1 X138.071 Y132.41 E.01229
G1 X136.981 Y133.472 E.04675
G1 X136.694 Y133.75 E.01229
G1 F9300
G3 X135.766 Y134.43 I-3.104 J-3.269 E.03544
G1 F10200
G1 X135.258 Y134.669 E.01725
G1 X134.728 Y134.841 E.01712
G1 F9300
G3 X133.627 Y134.982 I-1.101 J-4.258 E.03421
G1 X103.654 Y134.982 E.92099
G1 F10225.996
G1 X103.654 Y134.932 E.00152
G1 F12000
G1 X103.654 Y134.532 E.01229
G1 X103.654 Y117.468 E.52434
G1 X103.654 Y117.068 E.01229
G1 F9300
G1 X103.654 Y117.018 E.00152
G1 X133.627 Y117.018 E.92099
G1 X133.958 Y117.04 E.01021
G1 X134.185 Y117.054 E.00696
G1 F10200
G1 X134.728 Y117.159 E.01702
G1 X135.258 Y117.331 E.01712
G1 F9300
G3 X136.244 Y117.874 I-2.315 J5.371 E.03463
G1 F10200
G1 X136.726 Y118.279 E.01933
G1 X137.332 Y118.864 E.02589
G1 X137.62 Y119.142 E.01229
G1 F8400
G1 X138.073 Y119.588 E.01954
G1 X138.358 Y119.869 E.01229
G1 F7500
G1 X140.747 Y119.869 E.07342
G1 X141.147 Y119.869 E.01229
G1 F6600
G1 X142.606 Y119.869 E.04485
G1 X143.006 Y119.869 E.01229
G1 F5700
G1 X144.466 Y119.869 E.04485
G1 X144.866 Y119.869 E.01229
G1 F4800
G1 X147.255 Y119.869 E.07342
G1 X147.655 Y119.869 E.01229
G1 F3900
G1 X149.115 Y119.869 E.04485
G1 X149.515 Y119.869 E.01229
G1 F3000
G1 X151.374 Y119.869 E.05714
G1 F2880
G1 X153.234 Y119.869 E.05714
G1 F3947.598
G1 X153.234 Y119.965 E.00297
G1 F12000
G1 X153.234 Y120.551 E.018
G2 X148.433 Y121.019 I73.87 J783.207 E.14821
G1 X105.294 Y121.019 E1.32555
M204 S10000
; WIPE_START
G1 X105.282 Y123.019 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X104.444 Y120.423 Z6.4 F30000
G1 Z6
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.431684
G1 F13876
G1 X104.444 Y131.577 E.35335
; WIPE_START
G1 F15000
G1 X104.444 Y129.577 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X105.534 Y122.023 Z6.4 F30000
G1 X105.883 Y119.604 Z6.4
G1 Z6
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F13876
G1 X105.05 Y119.604 E.02766
G1 X104.846 Y119.401 E.00955
G1 X104.394 Y119.401 E.01499
G1 X105.981 Y117.759 E.07574
G1 X104.851 Y117.759 E.0375
G1 X106.696 Y119.604 E.08657
G1 X111.812 Y119.604 E.1697
G1 X113.657 Y117.759 E.08657
G1 X112.527 Y117.759 E.0375
G1 X114.372 Y119.604 E.08657
G1 X119.488 Y119.604 E.1697
G1 X121.333 Y117.759 E.08657
G1 X120.203 Y117.759 E.0375
G1 X122.048 Y119.604 E.08657
G1 X127.164 Y119.604 E.1697
G1 X129.009 Y117.759 E.08657
G1 X127.879 Y117.759 E.0375
G1 X129.724 Y119.604 E.08657
G1 X134.84 Y119.604 E.1697
G1 X135.895 Y118.548 E.04952
G2 X134.438 Y117.856 I-2.319 J3.005 E.05394
G1 X137.237 Y120.269 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.350677
G1 F13876
G1 X137.689 Y120.267 E.01133
G1 X137.369 Y119.955 E.01122
G2 X137.237 Y119.961 I-.057 J.177 E.00337
G1 X104.999 Y119.961 E.80848
G1 X104.899 Y119.924 E.00268
G1 X104.705 Y119.758 E.00642
G1 X104.403 Y119.758 E.00756
G1 X104.403 Y120.066 E.00772
G1 X104.924 Y120.078 E.01306
G3 X105.017 Y120.269 I-.075 J.155 E.00574
G1 X137.177 Y120.269 E.80653
; WIPE_START
G1 F15000
G1 X135.177 Y120.269 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X136.528 Y127.781 Z6.4 F30000
G1 X137.237 Y131.731 Z6.4
G1 Z6
G1 E.8 F1800
; LINE_WIDTH: 0.350673
G1 F13876
G1 X105.017 Y131.731 E.80802
G1 X105.008 Y131.833 E.00256
G1 X104.899 Y131.93 E.00368
G1 X104.403 Y131.934 E.01242
G1 X104.403 Y132.242 E.00772
G1 X104.705 Y132.242 E.00756
G1 X104.939 Y132.051 E.00757
G1 X105.153 Y132.039 E.00538
G1 X137.368 Y132.045 E.8079
G1 X137.689 Y131.733 E.01122
G1 X137.297 Y131.731 E.00982
G1 X134.438 Y134.144 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F13876
G2 X135.896 Y133.452 I-.866 J-3.709 E.05394
G1 X134.84 Y132.396 E.04954
G1 X129.724 Y132.396 E.1697
G1 X127.879 Y134.241 E.08657
G1 X129.009 Y134.241 E.0375
G1 X127.164 Y132.396 E.08657
G1 X122.048 Y132.396 E.1697
G1 X120.203 Y134.241 E.08657
G1 X121.333 Y134.241 E.0375
G1 X119.488 Y132.396 E.08657
G1 X114.372 Y132.396 E.1697
G1 X112.527 Y134.241 E.08657
G1 X113.657 Y134.241 E.0375
G1 X111.812 Y132.396 E.08657
G1 X106.696 Y132.396 E.1697
G1 X104.851 Y134.241 E.08657
G1 X105.981 Y134.241 E.0375
G1 X104.394 Y132.599 E.07574
G1 X104.846 Y132.599 E.01499
G1 X105.05 Y132.396 E.00955
G1 X105.883 Y132.396 E.02766
G1 X149.929 Y131.633 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.597234
G1 F11365.412
G1 X150.471 Y131.659 E.0245
; LINE_WIDTH: 0.550434
G1 F12413.453
G1 X151.013 Y131.685 E.02243
; LINE_WIDTH: 0.503635
G1 F13674.41
G1 X151.555 Y131.711 E.02037
; LINE_WIDTH: 0.456836
G1 F13876
G1 X152.097 Y131.737 E.0183
; LINE_WIDTH: 0.410036
G1 X152.639 Y131.764 E.01623
; LINE_WIDTH: 0.375644
M73 P58 R8
G1 X153.038 Y131.782 E.01083
; WIPE_START
G1 F15000
G1 X152.639 Y131.764 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X152.56 Y124.131 Z6.4 F30000
G1 X152.52 Y120.243 Z6.4
G1 Z6
G1 E.8 F1800
; LINE_WIDTH: 0.429169
G1 F13876
G1 X152.002 Y120.268 E.01632
; LINE_WIDTH: 0.471753
G1 X151.484 Y120.293 E.01812
; LINE_WIDTH: 0.514336
G1 F13364.006
G1 X150.965 Y120.318 E.01992
; LINE_WIDTH: 0.556919
G1 F12256.835
G1 X150.447 Y120.343 E.02172
; LINE_WIDTH: 0.599503
G1 F11319.08
G1 X149.929 Y120.367 E.02352
G1 X152.52 Y120.243 F30000
; LINE_WIDTH: 0.386586
G1 F13876
G1 X153.038 Y120.218 E.01452
; CHANGE_LAYER
; Z_HEIGHT: 6.2
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F15000
G1 X152.52 Y120.243 E-.76
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 31/101
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L31
M991 S0 P30 ;notify layer change
G17
G3 Z6.4 I-.006 J-1.217 P1  F30000
G1 X104.842 Y120.464 Z6.4
G1 Z6.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F11042
G1 X104.842 Y131.536 E.36725
G1 X148.415 Y131.536 E1.4454
G1 X149.401 Y131.631 E.03286
G1 X149.39 Y131.864 E.00772
G1 X138.197 Y131.864 E.37128
G3 X136.436 Y133.552 I-40.962 J-40.969 E.08093
G3 X133.614 Y134.68 I-2.877 J-3.104 E.1031
G1 X104.046 Y134.68 E.98084
G1 X104.046 Y117.32 E.57585
G1 X133.783 Y117.331 E.98644
G3 X136.436 Y118.448 I-.203 J4.189 E.09747
G3 X138.197 Y120.136 I-39.2 J42.657 E.08093
G1 X149.39 Y120.136 E.37128
G1 X149.401 Y120.369 E.00772
G1 X148.415 Y120.464 E.03286
G1 X104.902 Y120.464 E1.44341
G1 X105.234 Y120.857 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F11042
G1 X105.234 Y131.143 E.31609
G1 X148.434 Y131.143 E1.32741
G2 X153.234 Y131.599 I52.624 J-528.923 E.14816
G1 X153.234 Y132.172 E.01762
G1 F3900
G1 X153.234 Y132.256 E.00256
G1 F4800
G1 X152.834 Y132.256 E.01229
G1 X150.444 Y132.256 E.07342
G1 F5700
G1 X150.044 Y132.256 E.01229
G1 X148.585 Y132.256 E.04485
G1 F6600
G1 X148.185 Y132.256 E.01229
G1 X145.796 Y132.256 E.07342
G1 F7500
G1 X145.396 Y132.256 E.01229
G1 X143.936 Y132.256 E.04485
G1 F8400
G1 X143.536 Y132.256 E.01229
G1 X141.147 Y132.256 E.07342
G1 F9300
G1 X140.747 Y132.256 E.01229
G1 X139.287 Y132.256 E.04485
G1 F10200
G1 X138.358 Y132.256 E.02857
G3 X137.353 Y133.236 I-53.241 J-53.574 E.04313
G1 F11042
G1 X136.695 Y133.846 E.02756
G1 X136.352 Y134.134 E.01376
G1 X136.247 Y134.217 E.00412
G1 X135.766 Y134.52 E.01747
G1 F10200
G3 X135.258 Y134.759 I-2.172 J-3.957 E.01727
G1 X134.728 Y134.932 E.01712
G1 F9300
G3 X133.627 Y135.072 I-1.101 J-4.258 E.03421
G1 X103.654 Y135.072 E.92099
G1 F10225.996
G1 X103.654 Y135.023 E.00152
G1 F11042
G1 X103.654 Y134.623 E.01229
G1 X103.654 Y117.377 E.52989
G1 X103.654 Y116.977 E.01229
G1 F9300
G1 X103.654 Y116.928 E.00152
G1 X133.808 Y116.94 E.92656
G1 X134.185 Y116.963 E.01159
G1 F10200
G1 X134.728 Y117.068 E.01702
G3 X135.258 Y117.241 I-1.106 J4.285 E.01713
G1 F11042
G1 X135.766 Y117.48 E.01726
G3 X136.247 Y117.783 I-2.223 J4.066 E.01748
G1 X136.695 Y118.154 E.01788
G1 F10200
G3 X137.351 Y118.766 I-37.692 J41.066 E.02756
G1 X138.071 Y119.465 E.03083
G1 X138.358 Y119.744 E.01229
G1 F9300
G1 X139.817 Y119.744 E.04485
G1 X140.217 Y119.744 E.01229
G1 F8400
G1 X142.606 Y119.744 E.07342
G1 X143.006 Y119.744 E.01229
G1 F7500
G1 X144.466 Y119.744 E.04485
G1 X144.866 Y119.744 E.01229
G1 F6600
G1 X147.255 Y119.744 E.07342
G1 X147.655 Y119.744 E.01229
G1 F5700
G1 X149.115 Y119.744 E.04485
G1 X149.515 Y119.744 E.01229
G1 F4800
G1 X151.904 Y119.744 E.07342
G1 X152.304 Y119.744 E.01229
G1 F3900
G1 X153.234 Y119.744 E.02857
G1 F4948.528
G1 X153.234 Y119.828 E.00256
G1 F11042
G1 X153.234 Y120.401 E.01762
G2 X148.434 Y120.857 I47.824 J529.379 E.14816
G1 X105.294 Y120.857 E1.32557
M204 S10000
G1 X105.139 Y119.972 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.621376
G1 F10891.076
G1 X137.253 Y119.971 E1.51373
G1 X134.501 Y117.778 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F11042
G3 X135.948 Y118.496 I-.985 J3.803 E.05395
G1 X134.965 Y119.479 E.04612
G1 X129.599 Y119.479 E.17801
G1 X127.797 Y117.677 E.08453
G1 X129.09 Y117.677 E.04291
G1 X127.289 Y119.479 E.08451
G1 X121.923 Y119.479 E.17801
G1 X120.118 Y117.674 E.08466
G1 X121.417 Y117.675 E.0431
G1 X119.613 Y119.479 E.08464
G1 X114.247 Y119.479 E.17801
G1 X112.439 Y117.671 E.08479
G1 X113.744 Y117.672 E.04328
G1 X111.937 Y119.479 E.08477
G1 X106.571 Y119.479 E.17801
G1 X104.76 Y117.669 E.08492
G1 X106.071 Y117.669 E.04346
G1 X104.464 Y119.275 E.07535
G1 X104.846 Y119.275 E.01266
G1 X105.05 Y119.479 E.00955
G1 X106.008 Y119.479 E.03181
G1 X104.444 Y120.261 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.431684
G1 F11042
G1 X104.444 Y131.739 E.36362
G1 X105.139 Y132.028 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.621376
G1 F10891.076
G1 X137.253 Y132.029 E1.51373
G1 X149.591 Y131.757 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.600691
G1 F11042
G1 X150.1 Y131.781 E.02315
; LINE_WIDTH: 0.560806
G1 X150.608 Y131.806 E.0215
; LINE_WIDTH: 0.520921
G1 X151.117 Y131.831 E.01984
; LINE_WIDTH: 0.48052
G1 X151.598 Y131.853 E.01717
; LINE_WIDTH: 0.439665
G1 X152.078 Y131.875 E.01553
; LINE_WIDTH: 0.398853
G1 X152.558 Y131.897 E.01393
; LINE_WIDTH: 0.358042
G1 X153.038 Y131.919 E.01233
; WIPE_START
G1 F15000
G1 X152.558 Y131.897 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X152.558 Y124.264 Z6.6 F30000
G1 X152.558 Y120.103 Z6.6
G1 Z6.2
G1 E.8 F1800
; LINE_WIDTH: 0.398852
G1 F11042
G1 X152.078 Y120.125 E.01393
; LINE_WIDTH: 0.439663
G1 X151.598 Y120.147 E.01553
; LINE_WIDTH: 0.480519
G1 X151.117 Y120.169 E.01717
; LINE_WIDTH: 0.520922
G1 X150.608 Y120.194 E.01984
; LINE_WIDTH: 0.560806
G1 X150.1 Y120.219 E.0215
; LINE_WIDTH: 0.60069
G1 X149.591 Y120.243 E.02315
G1 X152.558 Y120.103 F30000
; LINE_WIDTH: 0.358041
G1 F11042
G1 X153.038 Y120.081 E.01233
; WIPE_START
G1 F15000
G1 X152.558 Y120.103 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X145.183 Y122.07 Z6.6 F30000
G1 X106.008 Y132.521 Z6.6
G1 Z6.2
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F11042
G1 X105.05 Y132.521 E.03181
G1 X104.846 Y132.725 E.00955
G1 X104.464 Y132.725 E.01266
G1 X106.071 Y134.332 E.07539
G1 X104.76 Y134.332 E.0435
G1 X106.571 Y132.521 E.08494
G1 X111.937 Y132.521 E.17801
G1 X113.747 Y134.332 E.08494
G1 X112.436 Y134.332 E.0435
G1 X114.247 Y132.521 E.08494
G1 X119.613 Y132.521 E.17801
G1 X121.423 Y134.332 E.08494
G1 X120.112 Y134.332 E.0435
G1 X121.923 Y132.521 E.08494
G1 X127.289 Y132.521 E.17801
G1 X129.099 Y134.332 E.08494
G1 X127.788 Y134.332 E.0435
G1 X129.599 Y132.521 E.08494
G1 X134.965 Y132.521 E.17801
G1 X135.948 Y133.504 E.04612
G3 X134.501 Y134.222 I-2.432 J-3.086 E.05395
; CHANGE_LAYER
; Z_HEIGHT: 6.4
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F15476.087
G1 X135.41 Y133.869 E-.37049
G1 X135.948 Y133.504 E-.2469
G1 X135.683 Y133.239 E-.14261
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 32/101
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L32
M991 S0 P31 ;notify layer change
G17
G3 Z6.6 I.471 J-1.122 P1  F30000
G1 X104.842 Y120.307 Z6.6
G1 Z6.4
G1 E.8 F1800
; FEATURE: Inner wall
G1 F11501
G1 X104.842 Y131.693 E.37767
G1 X148.415 Y131.693 E1.4454
G1 X149.062 Y131.755 E.02159
G1 X149.051 Y131.988 E.00772
G1 X138.199 Y131.988 E.35999
G3 X136.244 Y133.809 I-40.711 J-41.739 E.08865
G3 X133.614 Y134.77 I-2.634 J-3.129 E.09477
G1 X104.046 Y134.77 E.98084
G1 X104.046 Y117.23 E.58185
G1 X133.652 Y117.232 E.98209
G3 X136.436 Y118.352 I-.096 J4.259 E.10173
G3 X138.199 Y120.012 I-32.686 J36.474 E.08034
G1 X149.051 Y120.012 E.35999
G1 X149.062 Y120.245 E.00772
G1 X148.415 Y120.307 E.02159
G1 X104.902 Y120.307 E1.44341
G1 X105.234 Y120.7 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F11501
G1 X105.234 Y131.3 E.32574
G1 X148.434 Y131.3 E1.32741
G2 X153.234 Y131.749 I51.867 J-529.006 E.14814
G1 X153.234 Y132.297 E.01682
G1 F3900
G1 X153.234 Y132.38 E.00256
G1 F4800
G1 X152.834 Y132.38 E.01229
G1 X150.445 Y132.38 E.07341
G1 F5700
G1 X150.045 Y132.38 E.01229
G1 X148.585 Y132.38 E.04484
G1 F6600
G1 X148.185 Y132.38 E.01229
G1 X145.796 Y132.38 E.07341
G1 F7500
G1 X145.396 Y132.38 E.01229
G1 X143.937 Y132.38 E.04484
G1 F8400
G1 X143.537 Y132.38 E.01229
G1 X141.147 Y132.38 E.07341
G1 F9300
G1 X140.747 Y132.38 E.01229
G1 X139.288 Y132.38 E.04484
G1 F10200
G1 X138.358 Y132.38 E.02857
G1 X137.945 Y132.783 E.01772
G1 F11100
G1 X137.32 Y133.362 E.02619
G1 F11501
G1 X137.024 Y133.631 E.01229
G1 X136.492 Y134.113 E.02207
G1 X136.247 Y134.307 E.00959
G1 F11100
G1 X135.766 Y134.61 E.01747
G1 F10200
G3 X135.258 Y134.849 I-2.172 J-3.957 E.01727
G1 X134.728 Y135.022 E.01712
G1 F9300
G3 X133.627 Y135.162 I-1.101 J-4.258 E.03421
G1 X103.654 Y135.162 E.92099
G1 F10225.977
G1 X103.654 Y135.113 E.00152
G1 F11501
G1 X103.654 Y134.713 E.01229
G1 X103.654 Y117.287 E.53545
G1 X103.654 Y116.887 E.01229
G1 F9300
G1 X103.654 Y116.838 E.00152
G1 X133.664 Y116.84 E.92214
G1 X134.185 Y116.873 E.01602
G1 F10200
G1 X134.728 Y116.978 E.01702
G3 X135.258 Y117.151 I-1.106 J4.285 E.01713
G1 F11100
G1 X135.766 Y117.39 E.01726
G1 F11501
G1 X136.247 Y117.693 E.01747
G1 X136.695 Y118.058 E.01776
G1 F11100
G1 X137.32 Y118.638 E.02619
G1 F10200
G1 X138.068 Y119.345 E.03162
G1 X138.358 Y119.62 E.01229
G1 F9300
G1 X139.818 Y119.62 E.04484
G1 X140.218 Y119.62 E.01229
G1 F8400
G1 X142.607 Y119.62 E.07341
G1 X143.007 Y119.62 E.01229
G1 F7500
G1 X144.466 Y119.62 E.04484
G1 X144.866 Y119.62 E.01229
G1 F6600
G1 X147.255 Y119.62 E.07341
G1 X147.655 Y119.62 E.01229
G1 F5700
G1 X149.115 Y119.62 E.04484
G1 X149.515 Y119.62 E.01229
G1 F4800
G1 X151.904 Y119.62 E.07341
G1 X152.304 Y119.62 E.01229
G1 F3900
G1 X153.234 Y119.62 E.02857
G1 F4948.528
G1 X153.234 Y119.703 E.00256
G1 F11501
G1 X153.234 Y120.251 E.01682
G2 X148.434 Y120.7 I47.067 J529.455 E.14814
G1 X105.294 Y120.7 E1.32557
M204 S10000
G1 X105.124 Y119.835 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.580571
G1 F11501
G1 X137.262 Y119.834 E1.40802
G1 X104.518 Y119.632 F30000
; LINE_WIDTH: 0.580567
G1 F11501
G1 X104.602 Y119.632 E.00369
G1 X104.444 Y120.104 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.431684
G1 F11501
G1 X104.444 Y131.896 E.37357
G1 X105.124 Y132.165 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.580571
G1 F11501
G1 X137.262 Y132.166 E1.40801
G1 X104.518 Y132.368 F30000
; LINE_WIDTH: 0.580567
G1 F11501
G1 X104.602 Y132.368 E.00369
G1 X104.394 Y117.717 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F11501
G1 X104.394 Y119.159 E.04782
G1 X104.581 Y119.159 E.00619
G1 X106.162 Y117.578 E.07417
G1 X104.67 Y117.578 E.04948
G1 X106.455 Y119.363 E.08372
G1 X112.053 Y119.363 E.18572
G1 X113.837 Y117.579 E.08369
G1 X112.346 Y117.579 E.04944
G1 X114.13 Y119.363 E.08369
G1 X119.729 Y119.363 E.18572
G1 X121.512 Y117.579 E.08366
G1 X120.023 Y117.579 E.0494
G1 X121.806 Y119.363 E.08366
G1 X127.405 Y119.363 E.18572
G1 X129.188 Y117.58 E.08363
G1 X127.7 Y117.58 E.04936
G1 X129.482 Y119.363 E.08364
G1 X135.081 Y119.363 E.18572
G1 X135.999 Y118.445 E.04306
G2 X134.564 Y117.703 I-3.169 J4.37 E.05379
; WIPE_START
G1 F15476.087
G1 X135.41 Y118.04 E-.34629
G1 X135.999 Y118.445 E-.27135
G1 X135.734 Y118.71 E-.14236
; WIPE_END
G1 E-.04 F1800
G1 X143.325 Y119.501 Z6.8 F30000
G1 X149.253 Y120.119 Z6.8
G1 Z6.4
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.599593
G1 F11317.237
G1 X149.793 Y120.094 E.02456
; LINE_WIDTH: 0.555139
G1 F11501
G1 X150.334 Y120.069 E.02259
; LINE_WIDTH: 0.510686
G1 X150.875 Y120.044 E.02063
; LINE_WIDTH: 0.466232
G1 X151.415 Y120.019 E.01867
; LINE_WIDTH: 0.421778
G1 X151.956 Y119.994 E.01671
; LINE_WIDTH: 0.377324
G1 X152.497 Y119.969 E.01475
; LINE_WIDTH: 0.33287
G1 X153.038 Y119.944 E.01279
; WIPE_START
G1 F15000
G1 X152.497 Y119.969 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X152.528 Y127.601 Z6.8 F30000
G1 X152.546 Y132.034 Z6.8
G1 Z6.4
G1 E.8 F1800
; LINE_WIDTH: 0.332346
G1 F11501
G1 X153.038 Y132.056 E.0116
G1 X152.546 Y132.034 F30000
; LINE_WIDTH: 0.375862
G1 F11501
G1 X152.055 Y132.011 E.01335
; LINE_WIDTH: 0.419378
G1 X151.563 Y131.988 E.01509
; LINE_WIDTH: 0.462894
G1 X151.072 Y131.966 E.01684
; LINE_WIDTH: 0.50641
G1 X150.58 Y131.943 E.01858
; LINE_WIDTH: 0.549926
G1 X150.089 Y131.92 E.02033
; LINE_WIDTH: 0.603554
G1 F11237.293
G1 X149.253 Y131.881 E.03825
; WIPE_START
G1 X150.089 Y131.92 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X142.544 Y133.075 Z6.8 F30000
G1 X134.564 Y134.297 Z6.8
G1 Z6.4
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F11501
G2 X135.999 Y133.555 I-1.734 J-5.112 E.05379
G1 X135.081 Y132.637 E.04306
G1 X129.482 Y132.637 E.18572
G1 X127.698 Y134.422 E.08373
G1 X129.19 Y134.422 E.0495
G1 X127.405 Y132.637 E.08372
G1 X121.806 Y132.637 E.18572
G1 X120.022 Y134.422 E.08373
G1 X121.514 Y134.422 E.0495
G1 X119.729 Y132.637 E.08372
G1 X114.13 Y132.637 E.18572
G1 X112.346 Y134.422 E.08373
G1 X113.838 Y134.422 E.0495
G1 X112.053 Y132.637 E.08372
G1 X106.455 Y132.637 E.18572
G1 X104.67 Y134.422 E.08373
G1 X106.162 Y134.422 E.0495
G1 X104.581 Y132.841 E.07418
G1 X104.394 Y132.841 E.00619
G1 X104.394 Y134.283 E.04782
; CHANGE_LAYER
; Z_HEIGHT: 6.6
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F15476.087
M73 P59 R8
G1 X104.394 Y132.841 E-.54785
G1 X104.581 Y132.841 E-.07091
G1 X104.844 Y133.104 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 33/101
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L33
M991 S0 P32 ;notify layer change
G17
G3 Z6.8 I1.217 J0 P1  F30000
G1 X104.842 Y120.157 Z6.8
G1 Z6.6
G1 E.8 F1800
; FEATURE: Inner wall
G1 F10831
G1 X104.842 Y131.843 E.38767
G1 X148.417 Y131.843 E1.44547
G1 X148.697 Y131.868 E.00933
G1 X148.687 Y132.102 E.00775
G1 X138.207 Y132.102 E.34764
G3 X136.441 Y133.739 I-159.706 J-170.393 E.07987
G3 X133.615 Y134.846 I-2.851 J-3.118 E.10299
G1 X104.046 Y134.846 E.98086
G1 X104.046 Y117.154 E.58687
G1 X133.615 Y117.154 E.98086
G1 X134.075 Y117.182 E.01527
G1 X134.137 Y117.186 E.00209
G3 X136.441 Y118.261 I-.575 J4.241 E.08562
G3 X138.207 Y119.898 I-157.935 J172.025 E.07987
G1 X148.687 Y119.898 E.34764
G1 X148.697 Y120.132 E.00775
G1 X148.417 Y120.157 E.00933
G1 X104.902 Y120.157 E1.44348
G1 X105.234 Y120.549 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F10831
G1 X105.234 Y131.451 E.335
G1 X148.434 Y131.451 E1.32743
G2 X153.234 Y131.879 I65.326 J-705.934 E.14806
G1 X153.234 Y132.421 E.01665
G1 F5700
G1 X153.234 Y132.494 E.00224
G1 X152.304 Y132.494 E.02856
G1 F6600
G1 X151.904 Y132.494 E.01229
G1 X149.516 Y132.494 E.0734
G1 F7500
G1 X149.116 Y132.494 E.01229
G1 X146.727 Y132.494 E.0734
G1 F8400
G1 X146.327 Y132.494 E.01229
G1 X143.938 Y132.494 E.0734
G1 F9300
G1 X143.538 Y132.494 E.01229
G1 X141.15 Y132.494 E.0734
G1 F10200
G1 X140.75 Y132.494 E.01229
G1 X138.361 Y132.494 E.0734
G1 F10831
G1 X138.068 Y132.766 E.01229
G1 X136.697 Y134.037 E.05743
G1 X136.247 Y134.398 E.01774
G3 X134.73 Y135.102 I-2.799 J-4.042 E.05165
G1 X134.185 Y135.204 E.01702
G3 X133.627 Y135.238 I-.557 J-4.514 E.0172
G1 X103.654 Y135.238 E.921
G1 X103.654 Y135.203 E.00106
G1 X103.654 Y116.797 E.56559
G1 X103.654 Y116.762 E.00106
G1 X118.24 Y116.762 E.44821
G1 X118.64 Y116.762 E.01229
G1 X133.627 Y116.762 E.4605
G1 X134.099 Y116.791 E.01452
G1 X134.185 Y116.796 E.00267
G3 X135.767 Y117.3 I-.704 J4.948 E.05123
G1 X136.247 Y117.602 E.01744
G1 X136.697 Y117.963 E.01774
G1 X137.232 Y118.456 E.02233
G1 X137.526 Y118.727 E.01229
G1 F10200
G1 X138.361 Y119.506 E.0351
G1 X139.82 Y119.506 E.04483
G1 X140.22 Y119.506 E.01229
G1 F9300
G1 X142.609 Y119.506 E.0734
G1 X143.009 Y119.506 E.01229
G1 F8400
G1 X145.397 Y119.506 E.0734
G1 X145.797 Y119.506 E.01229
G1 F7500
G1 X148.186 Y119.506 E.0734
G1 X148.586 Y119.506 E.01229
G1 F6600
G1 X150.975 Y119.506 E.0734
G1 X151.375 Y119.506 E.01229
G1 F5700
G1 X153.234 Y119.506 E.05712
G1 F6793.844
G1 X153.234 Y119.579 E.00224
G1 F10831
G1 X153.234 Y120.121 E.01665
G2 X148.434 Y120.549 I60.526 J706.362 E.14806
G1 X105.294 Y120.549 E1.32559
M204 S10000
; WIPE_START
G1 F12000
G1 X105.283 Y122.549 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X104.444 Y119.953 Z7 F30000
G1 Z6.6
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.431684
G1 F10831
G1 X104.444 Y132.047 E.38312
G1 X105.102 Y132.289 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.527061
G1 F10831
G1 X137.279 Y132.289 E1.26943
G1 X104.491 Y132.492 F30000
; LINE_WIDTH: 0.527059
G1 F10831
G1 X104.612 Y132.492 E.00477
G1 X104.394 Y134.283 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F10831
G1 X104.394 Y132.938 E.0446
G1 X104.678 Y132.938 E.00942
G1 X106.237 Y134.498 E.07316
G1 X104.594 Y134.498 E.05451
G1 X106.357 Y132.735 E.08271
G1 X112.15 Y132.735 E.19217
G1 X113.913 Y134.498 E.08271
G1 X112.27 Y134.498 E.05451
G1 X114.033 Y132.735 E.08271
G1 X119.826 Y132.735 E.19217
G1 X121.589 Y134.498 E.08271
G1 X119.946 Y134.498 E.05451
G1 X121.709 Y132.735 E.08271
G1 X127.502 Y132.735 E.19217
G1 X129.265 Y134.498 E.08271
G1 X127.622 Y134.498 E.05451
G1 X129.385 Y132.735 E.08271
G1 X135.178 Y132.735 E.19217
G1 X136.05 Y133.607 E.04091
G3 X134.622 Y134.36 I-3.105 J-4.154 E.05378
; WIPE_START
M73 P59 R7
G1 F15476.087
G1 X135.413 Y134.048 E-.32286
G1 X136.05 Y133.607 E-.29479
G1 X135.785 Y133.342 E-.14236
; WIPE_END
G1 E-.04 F1800
G1 X143.378 Y132.561 Z7 F30000
G1 X148.888 Y131.994 Z7
G1 Z6.6
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.601157
G1 F10831
G1 X149.463 Y132.02 E.02621
; LINE_WIDTH: 0.553956
G1 X150.039 Y132.045 E.02399
; LINE_WIDTH: 0.506755
G1 X150.614 Y132.071 E.02178
; LINE_WIDTH: 0.459554
G1 X151.19 Y132.097 E.01956
; LINE_WIDTH: 0.412354
G1 X151.765 Y132.123 E.01734
; LINE_WIDTH: 0.365153
G1 X152.341 Y132.149 E.01513
; LINE_WIDTH: 0.316903
G1 X153.038 Y132.179 E.01557
; WIPE_START
G1 F15000
G1 X152.341 Y132.149 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X152.405 Y124.516 Z7 F30000
G1 X152.445 Y119.848 Z7
G1 Z6.6
G1 E.8 F1800
; LINE_WIDTH: 0.363814
G1 F10831
G1 X151.852 Y119.874 E.01552
; LINE_WIDTH: 0.411288
G1 X151.259 Y119.901 E.01781
; LINE_WIDTH: 0.458762
G1 X150.666 Y119.927 E.02011
; LINE_WIDTH: 0.506236
G1 X150.073 Y119.953 E.02241
; LINE_WIDTH: 0.55371
G1 X149.48 Y119.98 E.0247
; LINE_WIDTH: 0.601183
G1 X148.888 Y120.006 E.027
G1 X152.445 Y119.848 F30000
; LINE_WIDTH: 0.316341
G1 F10831
G1 X153.038 Y119.821 E.01322
; WIPE_START
G1 F15000
G1 X152.445 Y119.848 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X144.87 Y118.909 Z7 F30000
G1 X134.622 Y117.64 Z7
G1 Z6.6
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F10831
G3 X136.05 Y118.393 I-1.677 J4.908 E.05378
G1 X135.178 Y119.265 E.04091
G1 X129.385 Y119.265 E.19217
G1 X127.622 Y117.502 E.08271
G1 X129.265 Y117.502 E.05451
G1 X127.502 Y119.265 E.08271
G1 X121.709 Y119.265 E.19217
G1 X119.946 Y117.502 E.08271
G1 X121.589 Y117.502 E.05451
G1 X119.826 Y119.265 E.08271
G1 X114.033 Y119.265 E.19217
G1 X112.27 Y117.502 E.08271
G1 X113.913 Y117.502 E.05451
G1 X112.15 Y119.265 E.08271
G1 X106.357 Y119.265 E.19217
G1 X104.594 Y117.502 E.08271
G1 X106.237 Y117.502 E.05451
G1 X104.678 Y119.062 E.07316
G1 X104.394 Y119.062 E.00942
G1 X104.394 Y117.717 E.0446
G1 X104.491 Y119.508 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.527061
G1 F10831
G1 X104.672 Y119.508 E.00713
G1 X105.102 Y119.711 E.01876
G1 X137.279 Y119.711 E1.26943
; CHANGE_LAYER
; Z_HEIGHT: 6.8
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F13012.754
G1 X135.279 Y119.711 E-.76
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 34/101
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L34
M991 S0 P33 ;notify layer change
G17
G3 Z7 I-.013 J-1.217 P1  F30000
G1 X104.842 Y120.032 Z7
G1 Z6.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F10207
G1 X104.842 Y131.968 E.39597
G1 X138.458 Y131.968 E1.11513
G3 X136.445 Y133.822 I-48.745 J-50.921 E.09077
G3 X133.615 Y134.917 I-2.827 J-3.102 E.103
G1 X104.046 Y134.917 E.98086
G1 X104.046 Y117.083 E.59155
G1 X133.615 Y117.083 E.98086
G1 X133.93 Y117.103 E.01046
G3 X136.445 Y118.178 I-.278 J4.131 E.09249
G3 X138.458 Y120.032 I-46.732 J52.774 E.09077
G1 X104.902 Y120.032 E1.11314
G1 X105.234 Y120.424 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F10207
G1 X105.234 Y131.576 E.34269
G1 X148.434 Y131.576 E1.32743
G2 X153.234 Y131.999 I64.565 J-705.724 E.14804
G1 X153.234 Y132.535 E.01646
G1 F8400
G1 X153.234 Y132.593 E.00178
G1 X151.375 Y132.593 E.05712
G1 F9300
G1 X150.975 Y132.593 E.01229
G1 X148.586 Y132.593 E.07339
G1 F10200
G1 X148.186 Y132.593 E.01229
G1 X145.798 Y132.593 E.07339
G1 F10207
G1 X145.398 Y132.593 E.01229
G1 X143.009 Y132.593 E.07339
G1 X142.609 Y132.593 E.01229
G1 X140.22 Y132.593 E.07339
G1 X138.361 Y132.593 E.05712
G1 X137.026 Y133.83 E.05595
G1 X136.699 Y134.121 E.01345
G1 X136.248 Y134.483 E.01775
G3 X134.73 Y135.173 I-2.891 J-4.345 E.05147
G3 X133.627 Y135.309 I-1.102 J-4.413 E.03423
G1 X103.654 Y135.309 E.921
G1 X103.654 Y135.279 E.00091
G1 X103.654 Y116.721 E.57023
G1 X103.654 Y116.691 E.00091
G1 X133.627 Y116.691 E.921
G1 X133.954 Y116.711 E.01006
G1 X134.185 Y116.726 E.00713
G3 X135.769 Y117.226 I-.738 J5.095 E.05125
G1 X136.248 Y117.517 E.01724
G1 X136.699 Y117.879 E.01775
G3 X138.361 Y119.407 I-38.539 J43.589 E.0694
G1 X139.291 Y119.407 E.02856
G1 X141.68 Y119.407 E.07339
G1 X142.08 Y119.407 E.01229
G1 X144.468 Y119.407 E.07339
G1 X144.868 Y119.407 E.01229
G1 F10200
G1 X147.257 Y119.407 E.07339
G1 X147.657 Y119.407 E.01229
G1 F9300
G1 X150.045 Y119.407 E.07339
G1 X150.445 Y119.407 E.01229
G1 F8400
G1 X153.234 Y119.407 E.08568
G1 F9436.682
G1 X153.234 Y119.465 E.00178
G1 F10207
G1 X153.234 Y120.001 E.01646
G2 X148.434 Y120.424 I59.765 J706.146 E.14804
G1 X105.294 Y120.424 E1.32559
M204 S10000
; WIPE_START
G1 F12000
G1 X105.283 Y122.424 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X104.444 Y119.828 Z7.2 F30000
G1 Z6.8
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.431684
G1 F10207
G1 X104.444 Y132.172 E.39105
G1 X105.09 Y132.4 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.499177
G1 F10207
G1 X137.282 Y132.4 E1.19687
G1 X104.477 Y132.604 F30000
; LINE_WIDTH: 0.499175
G1 F10207
G1 X104.617 Y132.604 E.0052
G1 X104.394 Y133.069 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F10207
G1 X104.394 Y134.568 E.04972
G1 X104.524 Y134.568 E.00429
G1 X106.26 Y132.832 E.08146
G1 X105.05 Y132.832 E.04015
G1 X104.846 Y133.035 E.00955
G1 X104.775 Y133.035 E.00235
G1 X106.308 Y134.568 E.07191
G1 X112.2 Y134.568 E.19543
G1 X113.936 Y132.832 E.08146
G1 X112.248 Y132.832 E.05601
G1 X113.984 Y134.568 E.08146
G1 X119.875 Y134.568 E.19543
G1 X121.612 Y132.832 E.08146
G1 X119.924 Y132.832 E.05601
G1 X121.66 Y134.568 E.08146
G1 X127.551 Y134.568 E.19543
G1 X129.288 Y132.832 E.08146
G1 X127.6 Y132.832 E.05601
G1 X129.336 Y134.568 E.08146
G1 X133.604 Y134.568 E.14159
G2 X136.098 Y133.654 I-.153 J-4.277 E.08958
G1 X135.276 Y132.832 E.03858
G1 X133.647 Y132.832 E.05401
G1 X138.622 Y132.085 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.666151
G1 F10108.619
G1 X148.412 Y132.085 E.49719
G1 X148.902 Y132.107 E.02493
; LINE_WIDTH: 0.601327
G1 F10207
G1 X149.392 Y132.128 E.02234
; LINE_WIDTH: 0.557412
G1 X149.883 Y132.15 E.02058
; LINE_WIDTH: 0.513498
G1 X150.373 Y132.172 E.01882
; LINE_WIDTH: 0.469584
G1 X150.864 Y132.194 E.01707
; LINE_WIDTH: 0.425416
G1 X151.408 Y132.218 E.01697
; LINE_WIDTH: 0.38103
G1 X151.951 Y132.241 E.01498
; LINE_WIDTH: 0.336672
G1 X152.494 Y132.265 E.01302
; LINE_WIDTH: 0.292313
G1 X153.038 Y132.288 E.01105
; WIPE_START
G1 F15000
G1 X152.494 Y132.265 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X152.494 Y124.632 Z7.2 F30000
G1 X152.494 Y119.735 Z7.2
G1 Z6.8
G1 E.8 F1800
; LINE_WIDTH: 0.336672
G1 F10207
G1 X151.951 Y119.759 E.01302
; LINE_WIDTH: 0.381029
G1 X151.408 Y119.782 E.01498
; LINE_WIDTH: 0.425416
G1 X150.864 Y119.806 E.01697
; LINE_WIDTH: 0.469585
G1 X150.373 Y119.828 E.01707
; LINE_WIDTH: 0.513499
G1 X149.883 Y119.85 E.01882
; LINE_WIDTH: 0.557414
G1 X149.392 Y119.872 E.02058
; LINE_WIDTH: 0.601329
G1 X148.902 Y119.893 E.02234
; LINE_WIDTH: 0.666151
G1 F10108.617
G1 X148.412 Y119.915 E.02493
G1 X138.622 Y119.915 E.49719
G1 X133.647 Y119.168 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F10207
G1 X135.276 Y119.168 E.05401
G1 X136.098 Y118.346 E.03858
G2 X133.604 Y117.432 I-2.515 J3.003 E.08988
G1 X129.336 Y117.432 E.14159
G1 X127.6 Y119.168 E.08146
G1 X129.288 Y119.168 E.05601
G1 X127.551 Y117.432 E.08146
G1 X121.66 Y117.432 E.19543
G1 X119.924 Y119.168 E.08146
G1 X121.612 Y119.168 E.05601
G1 X119.875 Y117.432 E.08146
G1 X113.984 Y117.432 E.19543
G1 X112.248 Y119.168 E.08146
G1 X113.936 Y119.168 E.05601
G1 X112.2 Y117.432 E.08146
G1 X106.308 Y117.432 E.19543
G1 X104.775 Y118.965 E.07191
G1 X104.846 Y118.965 E.00235
G1 X105.05 Y119.168 E.00955
G1 X106.26 Y119.168 E.04015
G1 X104.524 Y117.432 E.08146
G1 X104.394 Y117.432 E.00429
G1 X104.394 Y118.931 E.04972
G1 X104.477 Y119.396 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.499175
G1 F10207
G1 X104.677 Y119.396 E.00743
; LINE_WIDTH: 0.479799
G1 X104.785 Y119.442 E.00416
; LINE_WIDTH: 0.441047
G1 X104.892 Y119.489 E.00379
; LINE_WIDTH: 0.402296
G1 X104.999 Y119.535 E.00342
; LINE_WIDTH: 0.402297
G1 X105.03 Y119.557 E.00109
; LINE_WIDTH: 0.44105
G1 X105.06 Y119.578 E.00121
; LINE_WIDTH: 0.500154
G1 X105.09 Y119.6 E.00138
G1 X137.285 Y119.599 E1.19954
M73 P60 R7
G1 X152.494 Y119.735 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.292314
G1 F10207
G1 X153.038 Y119.712 E.01105
; CHANGE_LAYER
; Z_HEIGHT: 7
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F15000
G1 X152.494 Y119.735 E-.76
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 35/101
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L35
M991 S0 P34 ;notify layer change
G17
G3 Z7.2 I-.004 J-1.217 P1  F30000
G1 X104.842 Y119.906 Z7.2
G1 Z7
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F10275
G1 X104.842 Y132.094 E.40427
G1 X138.43 Y132.094 E1.11419
G3 X136.16 Y134.127 I-34.119 J-35.811 E.10111
G3 X133.615 Y134.987 I-2.539 J-3.317 E.09073
G1 X104.046 Y134.987 E.98086
G1 X104.046 Y117.013 E.59624
G1 X133.785 Y117.023 E.9865
G3 X136.445 Y118.103 I-.194 J4.295 E.0971
G3 X138.43 Y119.906 I-45.468 J52.033 E.08897
G1 X104.902 Y119.906 E1.1122
G1 X105.234 Y120.298 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F10275
G1 X105.234 Y131.702 E.35038
G1 X148.434 Y131.702 E1.32743
G2 X153.234 Y132.119 I63.823 J-705.727 E.14803
G1 X153.234 Y132.634 E.01581
G1 F8400
G1 X153.234 Y132.692 E.00178
G1 X151.375 Y132.692 E.05712
G1 F9300
G1 X150.975 Y132.692 E.01229
G1 X148.586 Y132.692 E.07339
G1 F10200
G1 X148.186 Y132.692 E.01229
G1 X145.798 Y132.692 E.07339
G1 F10275
G1 X145.398 Y132.692 E.01229
G1 X143.009 Y132.692 E.07339
G1 X142.609 Y132.692 E.01229
G1 X140.22 Y132.692 E.07339
G1 X138.361 Y132.692 E.05712
G1 X137.698 Y133.306 E.02779
G1 X136.699 Y134.196 E.04112
G1 X136.403 Y134.435 E.01167
G1 X136.25 Y134.553 E.00592
G1 X135.769 Y134.845 E.0173
G3 X134.73 Y135.244 I-2.159 J-4.074 E.03428
G3 X133.627 Y135.379 I-1.102 J-4.413 E.03423
G1 X103.654 Y135.379 E.921
G1 X103.654 Y135.35 E.00091
G1 X103.654 Y116.65 E.57457
G1 X103.654 Y116.621 E.00091
G1 X133.809 Y116.632 E.92659
G1 X134.185 Y116.655 E.01159
G3 X135.26 Y116.924 I-.559 J4.522 E.03413
G1 X135.769 Y117.155 E.01717
G1 X136.25 Y117.447 E.0173
G3 X136.699 Y117.804 I-8.495 J11.162 E.0176
G3 X138.361 Y119.308 I-37.931 J43.583 E.06891
G1 X139.291 Y119.308 E.02856
G1 X141.68 Y119.308 E.07339
G1 X142.08 Y119.308 E.01229
G1 X144.468 Y119.308 E.07339
G1 X144.868 Y119.308 E.01229
G1 F10200
G1 X147.257 Y119.308 E.07339
G1 X147.657 Y119.308 E.01229
G1 F9300
G1 X150.045 Y119.308 E.07339
G1 X150.445 Y119.308 E.01229
G1 F8400
G1 X153.234 Y119.308 E.08568
G1 F9436.682
G1 X153.234 Y119.366 E.00178
G1 F10275
G1 X153.234 Y119.881 E.01581
G2 X148.434 Y120.298 I59.023 J706.145 E.14803
G1 X105.294 Y120.298 E1.32559
M204 S10000
; WIPE_START
G1 F12000
G1 X105.283 Y122.298 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X104.444 Y119.703 Z7.4 F30000
G1 Z7
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.431684
G1 F10275
G1 X104.444 Y132.297 E.39898
G1 X105.074 Y132.508 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.464543
G1 F10275
G1 X137.295 Y132.51 E1.10702
G1 X104.46 Y132.711 F30000
; LINE_WIDTH: 0.464536
G1 F10275
G1 X104.624 Y132.711 E.00562
G1 X104.46 Y119.289 F30000
; LINE_WIDTH: 0.464535
G1 F10275
G1 X104.684 Y119.289 E.00768
; LINE_WIDTH: 0.444131
G1 X104.842 Y119.361 E.00567
; LINE_WIDTH: 0.410549
G3 X105.074 Y119.492 I-.149 J.534 E.00807
; LINE_WIDTH: 0.465541
G1 X137.296 Y119.49 E1.10969
G1 X138.607 Y119.803 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.639907
G1 F10275
G1 X148.412 Y119.803 E.47697
G1 X148.899 Y119.782 E.02372
; LINE_WIDTH: 0.57551
G1 X149.386 Y119.76 E.02116
; LINE_WIDTH: 0.531831
G1 X149.909 Y119.737 E.02083
; LINE_WIDTH: 0.488135
G1 X150.43 Y119.715 E.01894
; LINE_WIDTH: 0.444475
G1 X150.952 Y119.692 E.01708
; LINE_WIDTH: 0.400815
G1 X151.473 Y119.67 E.01522
; LINE_WIDTH: 0.357155
G1 X151.995 Y119.647 E.01337
; LINE_WIDTH: 0.313495
G1 X152.516 Y119.625 E.01151
; LINE_WIDTH: 0.269835
G1 X153.038 Y119.603 E.00965
; WIPE_START
G1 F15000
G1 X152.516 Y119.625 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X152.516 Y127.257 Z7.4 F30000
G1 X152.516 Y132.375 Z7.4
G1 Z7
G1 E.8 F1800
; LINE_WIDTH: 0.269836
G1 F10275
G1 X153.038 Y132.397 E.00965
G1 X152.516 Y132.375 F30000
; LINE_WIDTH: 0.313496
G1 F10275
G1 X151.995 Y132.353 E.01151
; LINE_WIDTH: 0.357155
G1 X151.473 Y132.33 E.01337
; LINE_WIDTH: 0.400815
G1 X150.952 Y132.308 E.01522
; LINE_WIDTH: 0.444475
G1 X150.43 Y132.285 E.01708
; LINE_WIDTH: 0.488134
G1 X149.909 Y132.263 E.01894
; LINE_WIDTH: 0.53183
G1 X149.386 Y132.24 E.02083
; LINE_WIDTH: 0.57551
G1 X148.899 Y132.218 E.02116
; LINE_WIDTH: 0.639907
G1 X148.412 Y132.197 E.02372
G1 X138.607 Y132.197 E.47697
G1 X133.738 Y132.922 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F10275
G1 X135.366 Y132.922 E.05401
G1 X136.139 Y133.695 E.03627
G3 X133.604 Y134.639 I-2.694 J-3.36 E.09127
G1 X129.407 Y134.639 E.13924
G1 X127.69 Y132.922 E.08053
G1 X129.197 Y132.922 E.05
G1 X127.481 Y134.639 E.08053
G1 X121.731 Y134.639 E.19074
G1 X120.014 Y132.922 E.08053
G1 X121.521 Y132.922 E.05
G1 X119.805 Y134.639 E.08053
G1 X114.055 Y134.639 E.19074
G1 X112.338 Y132.922 E.08053
G1 X113.845 Y132.922 E.05
G1 X112.129 Y134.639 E.08053
G1 X106.379 Y134.639 E.19074
G1 X104.856 Y133.116 E.07144
G1 X105.05 Y132.922 E.00909
G1 X106.17 Y132.922 E.03715
G1 X104.453 Y134.639 E.08053
G1 X104.394 Y134.639 E.00195
G1 X104.394 Y133.126 E.05019
G1 X104.451 Y133.126 E.00187
G1 X104.45 Y118.874 F30000
G1 F10275
G1 X104.394 Y118.874 E.00187
G1 X104.394 Y117.361 E.05019
G1 X104.453 Y117.361 E.00196
G1 X106.17 Y119.078 E.08052
G1 X105.05 Y119.078 E.03715
G1 X104.856 Y118.884 E.00909
G1 X106.378 Y117.362 E.0714
G1 X112.132 Y117.364 E.19086
G1 X113.845 Y119.078 E.0804
G1 X112.338 Y119.078 E.05
G1 X114.051 Y117.365 E.08037
G1 X119.81 Y117.367 E.19104
G1 X121.521 Y119.078 E.08027
G1 X120.014 Y119.078 E.05
G1 X121.725 Y117.367 E.08024
G1 X127.489 Y117.369 E.19122
G1 X129.197 Y119.078 E.08014
G1 X127.69 Y119.078 E.05
G1 X129.398 Y117.37 E.08011
G1 X133.774 Y117.372 E.14517
G3 X136.139 Y118.305 I-.324 J4.285 E.08562
G1 X135.366 Y119.078 E.03627
G1 X133.738 Y119.078 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 7.2
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F15476.087
G1 X135.366 Y119.078 E-.61876
G1 X135.629 Y118.815 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 36/101
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L36
M991 S0 P35 ;notify layer change
G17
G3 Z7.4 I-.039 J-1.216 P1  F30000
G1 X104.842 Y119.79 Z7.4
G1 Z7.2
G1 E.8 F1800
; FEATURE: Inner wall
G1 F10866
G1 X104.842 Y123.935 E.13749
G1 X104.046 Y123.935 E.0264
G1 X104.046 Y116.942 E.23197
G1 X133.64 Y116.944 E.9817
G3 X136.445 Y118.028 I-.074 J4.363 E.10184
G1 X138.424 Y119.79 E.08789
G1 X104.902 Y119.79 E1.11198
; WIPE_START
G1 F15476.087
G1 X104.873 Y121.79 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X104.046 Y128.065 Z7.6 F30000
G1 Z7.2
G1 E.8 F1800
G1 F10866
G1 X104.842 Y128.065 E.0264
G1 X104.842 Y132.21 E.13749
G1 X138.424 Y132.21 E1.11397
G1 X136.445 Y133.972 E.08789
G3 X133.615 Y135.058 I-2.884 J-3.286 E.10268
G1 X104.046 Y135.058 E.98086
G1 X104.046 Y128.125 E.22998
; WIPE_START
G1 F15476.087
G1 X104.842 Y128.065 E-.30328
G1 X104.842 Y129.267 E-.45672
; WIPE_END
G1 E-.04 F1800
G1 X105.171 Y121.642 Z7.6 F30000
G1 X105.234 Y120.182 Z7.6
G1 Z7.2
G1 E.8 F1800
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F10866
G1 X105.234 Y131.818 E.35753
G1 X148.435 Y131.818 E1.32745
G1 X153.234 Y132.22 E.14797
G1 X153.234 Y132.733 E.01575
G1 F8400
G1 X153.234 Y132.788 E.00171
G1 X152.304 Y132.788 E.02856
G1 F9300
G1 X151.904 Y132.788 E.01229
G1 X149.516 Y132.788 E.07338
G1 F10200
G1 X149.116 Y132.788 E.01229
G1 X146.728 Y132.788 E.07338
G1 F10866
G1 X146.328 Y132.788 E.01229
G1 X143.011 Y132.788 E.10194
G1 X142.611 Y132.788 E.01229
G1 X140.223 Y132.788 E.07338
G1 X138.364 Y132.788 E.05711
G1 X137.531 Y133.53 E.03426
G3 X136.536 Y134.403 I-9.239 J-9.533 E.04071
G1 X136.25 Y134.623 E.01108
G1 X135.769 Y134.916 E.0173
G3 X134.73 Y135.314 I-2.159 J-4.074 E.03428
G3 X133.627 Y135.45 I-1.102 J-4.413 E.03423
G1 X103.654 Y135.45 E.921
G1 X103.654 Y135.42 E.00091
G1 X103.654 Y116.58 E.57892
G1 X103.654 Y116.55 E.00091
G1 X133.664 Y116.552 E.92214
G1 X134.185 Y116.584 E.01605
G3 X135.26 Y116.853 I-.559 J4.522 E.03413
G1 X135.769 Y117.084 E.01717
G1 X136.25 Y117.377 E.0173
G3 X136.699 Y117.728 I-8.389 J11.162 E.01751
G1 X137.531 Y118.47 E.03426
G1 X138.364 Y119.212 E.03426
G1 X139.293 Y119.212 E.02856
G1 X141.681 Y119.212 E.07338
G1 X142.081 Y119.212 E.01229
G1 X145.399 Y119.212 E.10194
G1 X145.799 Y119.212 E.01229
G1 F10200
G1 X148.187 Y119.212 E.07338
G1 X148.587 Y119.212 E.01229
G1 F9300
G1 X150.975 Y119.212 E.07338
G1 X151.375 Y119.212 E.01229
G1 F8400
G1 X153.234 Y119.212 E.05711
G1 F9393.933
G1 X153.234 Y119.267 E.00171
G1 F10866
G1 X153.234 Y119.78 E.01575
G1 X148.435 Y120.182 E.14797
G1 X105.294 Y120.182 E1.32561
M204 S10000
; WIPE_START
G1 F12000
G1 X105.283 Y122.182 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X104.444 Y119.587 Z7.6 F30000
G1 Z7.2
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.431684
G1 F10866
G1 X104.444 Y123.731 E.13131
; WIPE_START
G1 F15000
G1 X104.444 Y121.731 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X104.47 Y127.843 Z7.6 F30000
G1 Z7.2
G1 E.8 F1800
M204 S2000
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F10866
G1 X105.026 Y127.287 E.02416
G1 X105.026 Y126.753
G1 X103.937 Y127.843 E.04733
G1 X103.861 Y127.385
G1 X105.026 Y126.22 E.05063
G1 X105.026 Y125.687
G1 X103.861 Y126.852 E.05063
G1 X103.861 Y126.319
G1 X105.026 Y125.154 E.05063
G1 X105.026 Y124.62
G1 X103.861 Y125.785 E.05063
G1 X103.861 Y125.252
G1 X104.956 Y124.157 E.04757
G1 X104.423 Y124.157
G1 X103.861 Y124.719 E.0244
M204 S10000
; WIPE_START
G1 F12000
G1 X104.423 Y124.157 E-.30175
G1 X104.956 Y124.157 E-.20264
G1 X104.48 Y124.633 E-.25561
; WIPE_END
G1 E-.04 F1800
G1 X104.444 Y128.269 Z7.6 F30000
G1 Z7.2
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.431684
G1 F10866
G1 X104.444 Y132.413 E.13131
G1 X105.052 Y132.602 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.420448
G1 F10866
G1 X137.322 Y132.602 E.99275
G1 X104.438 Y132.806 F30000
; LINE_WIDTH: 0.420448
G1 F10866
G1 X104.632 Y132.806 E.00596
G1 X106.011 Y134.71 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F10866
G1 X104.394 Y134.71 E.05362
G1 X106.097 Y132.994 E.08018
G1 X105.05 Y132.994 E.03476
G1 X104.892 Y133.152 E.0074
G1 X106.449 Y134.71 E.07307
G1 X112.058 Y134.71 E.18605
G1 X113.773 Y132.994 E.08046
G1 X112.41 Y132.994 E.04522
G1 X114.125 Y134.71 E.08046
G1 X119.734 Y134.71 E.18605
G1 X121.449 Y132.994 E.08046
G1 X120.086 Y132.994 E.04522
G1 X121.801 Y134.71 E.08046
G1 X127.41 Y134.71 E.18605
G1 X129.125 Y132.994 E.08046
G1 X127.762 Y132.994 E.04522
G1 X129.477 Y134.71 E.08046
G1 X133.604 Y134.71 E.1369
G2 X136.181 Y133.737 I-.166 J-4.338 E.09296
G1 X135.438 Y132.994 E.03484
G1 X133.81 Y132.994 E.05401
G1 X138.614 Y132.303 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.619966
G1 F10866
G1 X148.415 Y132.303 E.46086
G1 X148.993 Y132.327 E.0272
; LINE_WIDTH: 0.550286
G1 X149.57 Y132.351 E.02391
; LINE_WIDTH: 0.502954
G1 X150.148 Y132.376 E.02168
; LINE_WIDTH: 0.455622
G1 X150.726 Y132.4 E.01945
; LINE_WIDTH: 0.40829
G1 X151.304 Y132.424 E.01722
; LINE_WIDTH: 0.360958
G1 X151.882 Y132.448 E.01499
; LINE_WIDTH: 0.313626
G1 X152.46 Y132.472 E.01276
; LINE_WIDTH: 0.266294
G1 X153.038 Y132.496 E.01053
; WIPE_START
G1 F15000
G1 X152.46 Y132.472 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X152.46 Y124.84 Z7.6 F30000
G1 X152.46 Y119.528 Z7.6
G1 Z7.2
G1 E.8 F1800
; LINE_WIDTH: 0.313627
G1 F10866
G1 X151.882 Y119.552 E.01276
; LINE_WIDTH: 0.360959
G1 X151.304 Y119.576 E.01499
; LINE_WIDTH: 0.408291
G1 X150.726 Y119.6 E.01722
; LINE_WIDTH: 0.455623
G1 X150.148 Y119.624 E.01945
; LINE_WIDTH: 0.502955
G1 X149.57 Y119.649 E.02168
; LINE_WIDTH: 0.550286
G1 X148.993 Y119.673 E.02391
; LINE_WIDTH: 0.619966
G1 X148.415 Y119.697 E.0272
G1 X138.614 Y119.697 E.46086
G1 X133.81 Y119.006 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F10866
G1 X135.438 Y119.006 E.05401
G1 X136.181 Y118.263 E.03484
G2 X133.629 Y117.292 I-2.74 J3.361 E.09212
G1 X129.476 Y117.292 E.13778
G1 X127.762 Y119.006 E.0804
G1 X129.125 Y119.006 E.04522
G1 X127.411 Y117.292 E.0804
G1 X121.8 Y117.291 E.18612
G1 X120.086 Y119.006 E.08042
G1 X121.449 Y119.006 E.04522
G1 X119.735 Y117.291 E.08042
G1 X114.125 Y117.291 E.1861
G1 X112.41 Y119.006 E.08044
G1 X113.773 Y119.006 E.04522
G1 X112.059 Y117.291 E.08044
G1 X106.449 Y117.291 E.18607
G1 X104.892 Y118.848 E.07306
G1 X105.05 Y119.006 E.0074
G1 X106.097 Y119.006 E.03476
G1 X104.394 Y117.29 E.08018
G1 X106.011 Y117.291 E.05362
G1 X104.438 Y119.194 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.421279
G1 F10866
M73 P61 R7
G1 X104.692 Y119.194 E.00783
G1 X104.999 Y119.349 E.01062
G1 X105.052 Y119.398 E.0022
G1 X137.328 Y119.397 E.99511
G1 X152.46 Y119.528 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.266295
G1 F10866
G1 X153.038 Y119.504 E.01053
; CHANGE_LAYER
; Z_HEIGHT: 7.4
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F15000
G1 X152.46 Y119.528 E-.76
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 37/101
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L37
M991 S0 P36 ;notify layer change
G17
G3 Z7.6 I-.306 J-1.178 P1  F30000
G1 X104.842 Y131.915 Z7.6
G1 Z7.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F10759
G1 X104.842 Y132.307 E.01301
G1 X138.4 Y132.307 E1.11318
G1 X136.449 Y134.044 E.08662
G3 X133.615 Y135.116 I-2.844 J-3.235 E.10271
G1 X104.046 Y135.116 E.98088
G1 X104.046 Y127.589 E.24966
G1 X104.842 Y127.589 E.0264
G1 X104.842 Y131.855 E.1415
G1 X105.234 Y131.915 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F10759
G1 X148.435 Y131.915 E1.32745
G2 X153.234 Y132.314 I81.893 J-955.472 E.14796
G1 X153.234 Y132.829 E.01583
G1 X153.234 Y132.864 E.00107
G1 X152.304 Y132.864 E.02856
G1 X149.516 Y132.864 E.08567
G1 X146.728 Y132.864 E.08567
G1 X143.94 Y132.864 E.08567
G1 X141.152 Y132.864 E.08567
G1 X138.364 Y132.864 E.08567
G1 X136.7 Y134.345 E.06845
G1 X136.25 Y134.694 E.0175
G1 X135.77 Y134.986 E.01727
G3 X134.731 Y135.375 I-2.124 J-4.085 E.03416
G3 X133.627 Y135.508 I-1.103 J-4.534 E.03425
G1 X103.654 Y135.508 E.921
G1 X103.654 Y135.491 E.00051
G1 X103.654 Y127.197 E.25484
G1 X105.234 Y127.197 E.04855
G1 X105.234 Y131.855 E.14312
M204 S10000
; WIPE_START
G1 F12000
G1 X107.234 Y131.858 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X104.444 Y132.511 Z7.8 F30000
G1 Z7.4
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.431684
G1 F10759
G1 X104.444 Y127.793 E.14946
; WIPE_START
G1 F15000
G1 X104.444 Y129.793 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X112.017 Y130.743 Z7.8 F30000
G1 X136.223 Y133.779 Z7.8
G1 Z7.4
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F10759
G1 X135.51 Y133.067 E.03341
G1 X136.729 Y133.067 E.04043
G1 X135.531 Y134.265 E.05621
G3 X133.605 Y134.767 I-1.943 J-3.505 E.06672
G1 X129.535 Y134.767 E.13501
G1 X127.834 Y133.067 E.07978
G1 X129.053 Y133.067 E.04043
G1 X127.352 Y134.767 E.07978
G1 X121.859 Y134.767 E.18223
G1 X120.158 Y133.067 E.07978
G1 X121.377 Y133.067 E.04043
G1 X119.676 Y134.767 E.07978
G1 X114.183 Y134.767 E.18223
G1 X112.482 Y133.067 E.07978
G1 X113.701 Y133.067 E.04043
G1 X112.001 Y134.767 E.07978
G1 X106.507 Y134.767 E.18223
G1 X104.928 Y133.188 E.07408
G1 X105.05 Y133.067 E.0057
G1 X106.025 Y133.067 E.03236
G1 X104.394 Y134.698 E.07652
G1 X104.394 Y134.767 E.00231
G1 X105.953 Y134.767 E.05171
G1 X104.426 Y132.89 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.395242
G1 F10759
G1 X104.697 Y132.89 E.00778
G1 X104.934 Y132.786 E.00743
G1 X105.039 Y132.687 E.00417
G1 X137.342 Y132.687 E.92741
G1 X138.602 Y132.39 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.598877
G1 F10759
G1 X148.415 Y132.39 E.44456
G1 X148.91 Y132.41 E.02246
; LINE_WIDTH: 0.537288
G1 X149.406 Y132.431 E.01997
; LINE_WIDTH: 0.49556
G1 X149.901 Y132.452 E.01828
; LINE_WIDTH: 0.453832
G1 X150.396 Y132.473 E.0166
; LINE_WIDTH: 0.412104
G1 X150.891 Y132.494 E.01491
; LINE_WIDTH: 0.370218
G1 X151.428 Y132.516 E.01433
; LINE_WIDTH: 0.328196
G1 X151.965 Y132.538 E.01248
; LINE_WIDTH: 0.28619
G1 X152.501 Y132.56 E.01064
; LINE_WIDTH: 0.244185
G1 X153.038 Y132.582 E.00881
; WIPE_START
G1 F15000
G1 X152.501 Y132.56 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X145.133 Y130.57 Z7.8 F30000
G1 X104.842 Y119.693 Z7.8
G1 Z7.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F10759
G1 X104.842 Y124.411 E.1565
G1 X104.046 Y124.411 E.0264
G1 X104.046 Y116.884 E.24966
G1 X133.615 Y116.884 E.98088
G1 X134.084 Y116.913 E.01556
G1 X134.139 Y116.916 E.00184
G3 X136.449 Y117.956 I-.569 J4.349 E.08526
G1 X138.4 Y119.693 E.08662
G1 X104.902 Y119.693 E1.11119
G1 X105.234 Y120.085 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F10759
G1 X105.234 Y124.803 E.14497
G1 X103.654 Y124.803 E.04855
G1 X103.654 Y116.509 E.25484
G1 X103.654 Y116.492 E.00051
G1 X133.627 Y116.492 E.921
G1 X134.107 Y116.521 E.01478
G1 X134.186 Y116.526 E.00243
G3 X135.262 Y116.788 I-.556 J4.625 E.0341
G1 X135.77 Y117.014 E.01709
G1 X136.25 Y117.306 E.01727
G1 X136.7 Y117.655 E.0175
G1 X138.364 Y119.136 E.06845
G1 X140.223 Y119.136 E.05711
G1 X143.011 Y119.136 E.08567
G1 X145.799 Y119.136 E.08567
G1 X148.587 Y119.136 E.08567
G1 X151.375 Y119.136 E.08567
G1 X153.234 Y119.136 E.05711
G1 X153.234 Y119.171 E.00107
G1 X153.234 Y119.686 E.01583
G2 X148.435 Y120.085 I77.12 J956.186 E.14796
G1 X105.294 Y120.085 E1.32561
M204 S10000
; WIPE_START
G1 F12000
G1 X105.268 Y122.085 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X104.444 Y119.489 Z7.8 F30000
G1 Z7.4
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.431684
G1 F10759
G1 X104.444 Y124.207 E.14946
G1 X104.426 Y119.11 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.39631
G1 F10759
G1 X104.697 Y119.11 E.00781
G1 X104.938 Y119.217 E.00761
G1 X105.039 Y119.313 E.00402
G1 X137.324 Y119.312 E.9297
G1 X138.602 Y119.61 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.598877
G1 F10759
G1 X148.415 Y119.61 E.44456
G1 X148.91 Y119.59 E.02246
; LINE_WIDTH: 0.537289
G1 X149.406 Y119.569 E.01997
; LINE_WIDTH: 0.495561
G1 X149.901 Y119.548 E.01828
; LINE_WIDTH: 0.453834
G1 X150.396 Y119.527 E.0166
; LINE_WIDTH: 0.412106
G1 X150.891 Y119.506 E.01491
; LINE_WIDTH: 0.370219
G1 X151.428 Y119.484 E.01433
; LINE_WIDTH: 0.328196
G1 X151.965 Y119.462 E.01248
; LINE_WIDTH: 0.28619
G1 X152.501 Y119.44 E.01064
; LINE_WIDTH: 0.244184
G1 X153.038 Y119.418 E.00881
; WIPE_START
G1 F15000
G1 X152.501 Y119.44 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X144.877 Y119.079 Z7.8 F30000
G1 X105.953 Y117.233 Z7.8
G1 Z7.4
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F10759
G1 X104.394 Y117.233 E.05171
G1 X104.394 Y117.302 E.00231
G1 X106.025 Y118.933 E.07652
G1 X105.05 Y118.933 E.03237
G1 X104.928 Y118.812 E.0057
G1 X106.507 Y117.233 E.07408
G1 X112.001 Y117.233 E.18223
G1 X113.701 Y118.933 E.07978
G1 X112.482 Y118.933 E.04043
G1 X114.183 Y117.233 E.07978
G1 X119.676 Y117.233 E.18223
G1 X121.377 Y118.933 E.07978
G1 X120.158 Y118.933 E.04043
G1 X121.859 Y117.233 E.07978
G1 X127.352 Y117.233 E.18223
G1 X129.053 Y118.933 E.07978
G1 X127.834 Y118.933 E.04043
G1 X129.535 Y117.233 E.07978
G1 X133.605 Y117.233 E.13501
G3 X135.531 Y117.735 I-.017 J4.008 E.06672
G1 X136.729 Y118.933 E.05621
G1 X135.51 Y118.933 E.04043
G1 X136.223 Y118.221 E.03341
; CHANGE_LAYER
; Z_HEIGHT: 7.6
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F15476.087
G1 X135.51 Y118.933 E-.38275
G1 X136.503 Y118.933 E-.37725
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 38/101
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L38
M991 S0 P37 ;notify layer change
G17
G3 Z7.8 I-.481 J-1.118 P1  F30000
G1 X105.234 Y132.404 Z7.8
G1 Z7.6
G1 E.8 F1800
; FEATURE: Inner wall
G1 F10483
G1 X138.376 Y132.404 E1.09938
G3 X136.03 Y134.43 I-28.336 J-30.449 E.10283
G3 X133.615 Y135.168 I-2.459 J-3.728 E.0849
G1 X104.046 Y135.168 E.98088
G1 X104.046 Y128.042 E.23638
G1 X104.842 Y128.042 E.0264
G1 X104.842 Y132.404 E.14472
G1 X105.174 Y132.404 E.01102
G1 X105.234 Y132.012 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F10483
G1 X148.435 Y132.012 E1.32746
G1 X153.234 Y132.408 E.14795
G1 X153.234 Y132.905 E.01528
G1 X153.234 Y132.94 E.00107
G1 X152.304 Y132.94 E.02856
G1 X149.516 Y132.94 E.08567
G1 X146.728 Y132.94 E.08567
G1 X143.94 Y132.94 E.08567
G1 X141.152 Y132.94 E.08567
G1 X138.364 Y132.94 E.08567
G1 X137.262 Y133.921 E.04534
G1 X136.701 Y134.405 E.02275
G1 X136.251 Y134.754 E.01752
G3 X134.186 Y135.526 I-2.633 J-3.896 E.06837
G1 X133.627 Y135.56 E.0172
G1 X103.654 Y135.56 E.921
G1 X103.654 Y135.549 E.00034
G1 X103.654 Y127.65 E.24272
G1 X105.234 Y127.65 E.04855
G1 X105.234 Y131.952 E.13221
M204 S10000
; WIPE_START
G1 F12000
G1 X107.234 Y131.955 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X104.444 Y132.608 Z8 F30000
G1 Z7.6
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.431684
G1 F10483
G1 X104.444 Y128.245 E.13821
G1 X104.412 Y132.974 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.38292
G1 F10483
G1 X104.702 Y132.974 E.00802
G1 X104.939 Y132.863 E.00727
G1 X105.026 Y132.771 E.00351
G1 X137.347 Y132.771 E.89549
G1 X138.59 Y132.476 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.57718
G1 F10483
G1 X148.416 Y132.476 E.42778
G1 X148.994 Y132.5 E.02517
; LINE_WIDTH: 0.508441
G1 X149.571 Y132.524 E.02193
; LINE_WIDTH: 0.46175
G1 X150.149 Y132.547 E.01973
; LINE_WIDTH: 0.415058
G1 X150.727 Y132.571 E.01753
; LINE_WIDTH: 0.368367
G1 X151.305 Y132.595 E.01533
; LINE_WIDTH: 0.321675
G1 X151.882 Y132.619 E.01313
; LINE_WIDTH: 0.274984
G1 X152.46 Y132.642 E.01093
; LINE_WIDTH: 0.228292
G1 X153.038 Y132.666 E.00873
; WIPE_START
G1 F15000
G1 X152.46 Y132.642 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X144.836 Y132.999 Z8 F30000
G1 X105.901 Y134.819 Z8
G1 Z7.6
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F10483
G1 X104.394 Y134.819 E.04998
G1 X104.394 Y134.698 E.00403
G1 X105.955 Y133.137 E.07322
G1 X105.05 Y133.137 E.03003
G1 X104.963 Y133.223 E.00405
G1 X106.559 Y134.819 E.07487
G1 X111.948 Y134.819 E.17877
G1 X113.631 Y133.137 E.07893
G1 X112.553 Y133.137 E.03577
G1 X114.235 Y134.819 E.07893
G1 X119.624 Y134.819 E.17877
G1 X121.307 Y133.137 E.07893
G1 X120.229 Y133.137 E.03577
G1 X121.911 Y134.819 E.07893
G1 X127.3 Y134.819 E.17877
G1 X128.983 Y133.137 E.07893
G1 X127.905 Y133.137 E.03577
G1 X129.587 Y134.819 E.07893
G1 X133.605 Y134.819 E.13328
G2 X135.404 Y134.392 I-.285 J-5.196 E.06167
G1 X136.659 Y133.137 E.05886
G1 X135.581 Y133.137 E.03577
G1 X136.255 Y133.811 E.03164
; WIPE_START
G1 F15476.087
G1 X135.581 Y133.137 E-.36251
G1 X136.627 Y133.137 E-.39749
; WIPE_END
G1 E-.04 F1800
G1 X129.605 Y130.145 Z8 F30000
G1 X104.842 Y119.596 Z8
G1 Z7.6
G1 E.8 F1800
; FEATURE: Inner wall
G1 F10483
G1 X104.842 Y123.958 E.14472
G1 X104.046 Y123.958 E.0264
G1 X104.046 Y116.832 E.23638
G1 X133.615 Y116.832 E.98088
G1 X133.943 Y116.852 E.01089
G3 X136.453 Y117.898 I-.284 J4.214 E.09183
G3 X138.376 Y119.596 I-55.483 J64.801 E.08508
G1 X104.902 Y119.596 E1.1104
G1 X105.234 Y119.988 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F10483
G1 X105.234 Y124.35 E.13405
G1 X103.654 Y124.35 E.04855
G1 X103.654 Y116.451 E.24272
G1 X133.627 Y116.44 E.921
G1 X133.967 Y116.461 E.01045
G3 X135.771 Y116.961 I-.285 J4.531 E.05795
G1 X136.251 Y117.246 E.01714
G1 X136.701 Y117.595 E.01752
G3 X138.364 Y119.06 I-47.894 J56.024 E.06809
G1 X140.223 Y119.06 E.05711
G1 X143.011 Y119.06 E.08567
G1 X145.799 Y119.06 E.08567
G1 X148.587 Y119.06 E.08567
G1 X151.375 Y119.06 E.08567
G1 X153.234 Y119.06 E.05711
G1 X153.234 Y119.095 E.00107
G1 X153.234 Y119.592 E.01528
G1 X148.435 Y119.988 E.14795
G1 X105.294 Y119.988 E1.32561
M204 S10000
; WIPE_START
G1 F12000
G1 X105.266 Y121.988 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X104.444 Y119.392 Z8 F30000
G1 Z7.6
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.431684
G1 F10483
G1 X104.444 Y123.755 E.13821
; WIPE_START
G1 F15000
G1 X104.444 Y121.755 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X112.029 Y120.905 Z8 F30000
G1 X136.255 Y118.189 Z8
G1 Z7.6
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F10483
G1 X135.581 Y118.863 E.03164
G1 X136.659 Y118.863 E.03577
G1 X135.404 Y117.608 E.05887
G2 X133.605 Y117.181 I-1.848 J3.776 E.06184
G1 X129.587 Y117.181 E.13328
G1 X127.905 Y118.863 E.07893
G1 X128.983 Y118.863 E.03577
G1 X127.3 Y117.181 E.07893
G1 X121.911 Y117.181 E.17877
G1 X120.229 Y118.863 E.07893
G1 X121.307 Y118.863 E.03577
G1 X119.624 Y117.181 E.07893
G1 X114.235 Y117.181 E.17877
G1 X112.553 Y118.863 E.07893
G1 X113.631 Y118.863 E.03577
G1 X111.948 Y117.181 E.07893
G1 X106.559 Y117.181 E.17877
G1 X104.963 Y118.777 E.07487
G1 X105.05 Y118.863 E.00405
G1 X105.955 Y118.863 E.03003
G1 X104.394 Y117.302 E.07322
G1 X104.394 Y117.181 E.00403
G1 X105.901 Y117.181 E.04998
G1 X104.412 Y119.026 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.38292
G1 F10483
G1 X104.702 Y119.026 E.00802
G1 X104.939 Y119.137 E.00727
G1 X105.026 Y119.229 E.00351
G1 X137.347 Y119.229 E.89549
G1 X138.59 Y119.524 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.57718
G1 F10483
G1 X148.416 Y119.524 E.42778
G1 X148.994 Y119.5 E.02517
; LINE_WIDTH: 0.508439
G1 X149.571 Y119.476 E.02193
; LINE_WIDTH: 0.461748
G1 X150.149 Y119.453 E.01973
; LINE_WIDTH: 0.415056
G1 X150.727 Y119.429 E.01753
; LINE_WIDTH: 0.368365
G1 X151.305 Y119.405 E.01533
; LINE_WIDTH: 0.321673
G1 X151.882 Y119.381 E.01313
; LINE_WIDTH: 0.274982
M73 P62 R7
G1 X152.46 Y119.358 E.01093
; LINE_WIDTH: 0.22829
G1 X153.038 Y119.334 E.00873
; CHANGE_LAYER
; Z_HEIGHT: 7.8
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F15000
G1 X152.46 Y119.358 E-.76
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 39/101
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L39
M991 S0 P38 ;notify layer change
G17
G3 Z8 I-.326 J-1.172 P1  F30000
G1 X105.234 Y132.495 Z8
G1 Z7.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F10556
G1 X138.359 Y132.495 E1.09884
G3 X136.454 Y134.156 I-56.211 J-62.56 E.08386
G3 X133.615 Y135.22 I-2.837 J-3.25 E.10274
G1 X104.046 Y135.22 E.98088
G1 X104.046 Y128.354 E.22776
G1 X104.842 Y128.354 E.0264
G1 X104.842 Y132.495 E.13737
G1 X105.174 Y132.495 E.01102
G1 X105.234 Y132.103 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F10556
G1 X148.435 Y132.103 E1.32746
G1 X153.234 Y132.488 E.14791
G1 X153.234 Y132.981 E.01516
G1 X153.234 Y133.016 E.00107
G1 X152.304 Y133.016 E.02856
G1 X149.516 Y133.016 E.08567
G1 X146.728 Y133.016 E.08567
G1 X143.94 Y133.016 E.08567
G1 X141.152 Y133.016 E.08567
G1 X138.364 Y133.016 E.08567
G1 X138.038 Y133.305 E.01339
G1 X137.37 Y133.883 E.02713
G1 X136.702 Y134.46 E.02713
G3 X135.771 Y135.091 I-3.065 J-3.518 E.03463
G3 X134.186 Y135.578 I-2.316 J-4.712 E.05116
G1 X133.627 Y135.612 E.0172
G1 X103.654 Y135.612 E.921
G1 X103.654 Y135.601 E.00034
G1 X103.654 Y127.962 E.23473
G1 X105.234 Y127.962 E.04855
G1 X105.234 Y132.043 E.1254
M204 S10000
; WIPE_START
G1 F12000
G1 X107.234 Y132.046 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X104.444 Y132.698 Z8.2 F30000
G1 Z7.8
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.431684
G1 F10556
G1 X104.444 Y128.557 E.13119
; WIPE_START
G1 F15000
G1 X104.444 Y130.557 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X112.036 Y131.34 Z8.2 F30000
G1 X136.285 Y133.841 Z8.2
G1 Z7.8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F10556
G1 X135.629 Y133.186 E.03075
G1 X136.61 Y133.186 E.03252
G1 X135.311 Y134.485 E.06096
G3 X133.605 Y134.871 I-1.999 J-4.868 E.05828
G1 X129.639 Y134.871 E.13155
G1 X127.954 Y133.186 E.07908
G1 X128.934 Y133.186 E.03252
G1 X127.248 Y134.871 E.07908
G1 X121.963 Y134.871 E.17532
G1 X120.278 Y133.186 E.07908
G1 X121.258 Y133.186 E.03252
G1 X119.572 Y134.871 E.07908
G1 X114.287 Y134.871 E.17532
G1 X112.602 Y133.186 E.07908
G1 X113.582 Y133.186 E.03252
G1 X111.896 Y134.871 E.07908
G1 X106.611 Y134.871 E.17532
G1 X104.988 Y133.248 E.07617
G1 X105.05 Y133.186 E.00291
G1 X105.906 Y133.186 E.02841
G1 X104.394 Y134.698 E.07093
G1 X104.394 Y134.871 E.00576
G1 X105.849 Y134.871 E.04825
G1 X104.391 Y133.044 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.38292
G1 F10556
G1 X104.709 Y133.044 E.00881
G1 X104.921 Y132.95 E.00643
G1 X105.005 Y132.84 E.00382
G1 X137.377 Y132.84 E.89689
G1 X138.582 Y132.559 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.562566
G1 F10556
G1 X148.417 Y132.559 E.41647
G1 X148.995 Y132.582 E.02448
; LINE_WIDTH: 0.495643
G1 X149.572 Y132.605 E.02132
; LINE_WIDTH: 0.450188
G1 X150.15 Y132.629 E.01918
; LINE_WIDTH: 0.404733
G1 X150.727 Y132.652 E.01704
; LINE_WIDTH: 0.359278
G1 X151.305 Y132.675 E.0149
; LINE_WIDTH: 0.313823
G1 X151.883 Y132.698 E.01276
; LINE_WIDTH: 0.268367
G1 X152.46 Y132.721 E.01062
; LINE_WIDTH: 0.222912
G1 X153.038 Y132.744 E.00848
; WIPE_START
G1 F15000
G1 X152.46 Y132.721 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X145.106 Y130.68 Z8.2 F30000
G1 X104.842 Y119.505 Z8.2
G1 Z7.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F10556
G1 X104.842 Y123.646 E.13737
G1 X104.046 Y123.646 E.0264
G1 X104.046 Y116.78 E.22776
G1 X133.803 Y116.792 E.98709
G3 X136.454 Y117.844 I-.161 J4.271 E.09647
G3 X138.359 Y119.505 I-54.305 J64.221 E.08386
G1 X104.902 Y119.505 E1.10985
G1 X105.234 Y119.897 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F10556
G1 X105.234 Y124.038 E.12725
G1 X103.654 Y124.038 E.04855
G1 X103.654 Y116.399 E.23473
G1 X133.627 Y116.388 E.921
G1 X133.826 Y116.4 E.00612
G3 X135.262 Y116.684 I-.239 J4.989 E.04513
G3 X136.251 Y117.194 I-1.657 J4.428 E.03428
G1 X136.702 Y117.54 E.01746
G1 X137.37 Y118.117 E.02713
G3 X138.364 Y118.984 I-28.338 J33.489 E.04052
G1 X140.223 Y118.984 E.05711
G1 X143.011 Y118.984 E.08567
G1 X145.799 Y118.984 E.08567
G1 X148.587 Y118.984 E.08567
G1 X151.375 Y118.984 E.08567
G1 X153.234 Y118.984 E.05711
G1 X153.234 Y119.019 E.00107
G1 X153.234 Y119.512 E.01516
G1 X148.435 Y119.897 E.14791
G1 X105.294 Y119.897 E1.32562
M204 S10000
; WIPE_START
G1 F12000
G1 X105.265 Y121.897 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X104.444 Y119.302 Z8.2 F30000
G1 Z7.8
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.431684
G1 F10556
G1 X104.444 Y123.443 E.13119
G1 X104.391 Y118.956 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.38292
G1 F10556
G1 X104.709 Y118.956 E.00881
G1 X104.912 Y119.041 E.00609
G1 X105.005 Y119.16 E.00418
G1 X137.377 Y119.16 E.89689
G1 X138.582 Y119.441 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.562566
G1 F10556
G1 X148.417 Y119.441 E.41647
G1 X148.995 Y119.418 E.02448
; LINE_WIDTH: 0.495645
G1 X149.572 Y119.395 E.02132
; LINE_WIDTH: 0.450189
G1 X150.15 Y119.371 E.01918
; LINE_WIDTH: 0.404733
G1 X150.727 Y119.348 E.01704
; LINE_WIDTH: 0.359278
G1 X151.305 Y119.325 E.0149
; LINE_WIDTH: 0.313822
G1 X151.883 Y119.302 E.01276
; LINE_WIDTH: 0.268366
G1 X152.46 Y119.279 E.01062
; LINE_WIDTH: 0.222911
G1 X153.038 Y119.256 E.00848
; WIPE_START
G1 F15000
G1 X152.46 Y119.279 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X144.836 Y118.927 Z8.2 F30000
G1 X105.849 Y117.129 Z8.2
G1 Z7.8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F10556
G1 X104.394 Y117.129 E.04826
G1 X104.394 Y117.302 E.00576
G1 X105.906 Y118.814 E.07093
G1 X105.05 Y118.814 E.02841
G1 X104.988 Y118.752 E.00291
G1 X106.61 Y117.13 E.07612
G1 X111.899 Y117.132 E.17545
G1 X113.582 Y118.814 E.07894
G1 X112.602 Y118.814 E.03252
G1 X114.283 Y117.132 E.0789
G1 X119.578 Y117.134 E.17564
G1 X121.258 Y118.814 E.0788
G1 X120.278 Y118.814 E.03252
G1 X121.956 Y117.135 E.07876
G1 X127.257 Y117.137 E.17583
G1 X128.934 Y118.814 E.07867
G1 X127.954 Y118.814 E.03252
G1 X129.63 Y117.138 E.07863
G1 X133.792 Y117.14 E.13808
G3 X135.311 Y117.515 I-.518 J5.36 E.05206
G1 X136.61 Y118.814 E.06096
G1 X135.629 Y118.814 E.03252
G1 X136.285 Y118.159 E.03074
; CHANGE_LAYER
; Z_HEIGHT: 8
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F15476.087
G1 X135.629 Y118.814 E-.3522
G1 X136.61 Y118.814 E-.37257
G1 X136.544 Y118.749 E-.03523
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 40/101
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L40
M991 S0 P39 ;notify layer change
G17
G3 Z8.2 I-.475 J-1.121 P1  F30000
G1 X104.842 Y132.175 Z8.2
G1 Z8
G1 E.8 F1800
; FEATURE: Inner wall
G1 F9312
G1 X104.842 Y132.567 E.01301
G1 X138.357 Y132.567 E1.11176
G1 X136.455 Y134.21 E.08338
G3 X133.615 Y135.272 I-2.853 J-3.303 E.10269
G1 X104.046 Y135.272 E.98088
G1 X104.046 Y128.604 E.22119
G1 X104.842 Y128.604 E.0264
G1 X104.842 Y132.115 E.11647
G1 X105.234 Y132.175 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9312
G1 X148.435 Y132.175 E1.32747
G1 X153.234 Y132.557 E.14791
G1 X153.234 Y133.057 E.01535
G1 X153.234 Y133.078 E.00064
G1 X151.375 Y133.078 E.05711
G1 X147.658 Y133.078 E.11421
G1 X143.941 Y133.078 E.11421
G1 X140.224 Y133.078 E.11421
G1 X138.366 Y133.078 E.05711
G1 X137.534 Y133.796 E.03378
G1 X136.702 Y134.515 E.03378
G3 X135.771 Y135.143 I-3.148 J-3.662 E.03459
G3 X134.186 Y135.63 I-2.316 J-4.712 E.05116
G1 X133.627 Y135.664 E.0172
G1 X103.654 Y135.664 E.921
G1 X103.654 Y135.653 E.00034
G1 X103.654 Y128.212 E.22864
G1 X105.234 Y128.212 E.04855
G1 X105.234 Y132.115 E.11993
M204 S10000
; WIPE_START
G1 F12000
G1 X107.234 Y132.118 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X104.444 Y132.77 Z8.4 F30000
G1 Z8
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.431684
G1 F9312
G1 X104.444 Y128.807 E.12555
G1 X105.797 Y134.923 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9312
G1 X104.394 Y134.923 E.04653
G1 X104.394 Y134.698 E.00749
G1 X106.177 Y132.915 E.08362
G1 X105.008 Y132.915 E.03877
G1 X105.008 Y133.119 E.00675
G1 X104.859 Y133.119 E.00495
G1 X106.663 Y134.923 E.08466
G1 X111.844 Y134.923 E.17186
G1 X113.853 Y132.915 E.09421
G1 X112.331 Y132.915 E.05047
G1 X114.339 Y134.923 E.09421
G1 X119.52 Y134.923 E.17186
G1 X121.529 Y132.915 E.09421
G1 X120.007 Y132.915 E.05047
G1 X122.015 Y134.923 E.09421
G1 X127.196 Y134.923 E.17186
G1 X129.204 Y132.915 E.09421
G1 X127.683 Y132.915 E.05047
G1 X129.691 Y134.923 E.09421
G1 X133.605 Y134.923 E.12983
G2 X135.217 Y134.579 I-.321 J-5.441 E.05489
G1 X136.88 Y132.915 E.07804
G1 X135.359 Y132.915 E.05047
G1 X136.315 Y133.871 E.04484
G1 X138.588 Y132.626 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.552257
G1 F9312
G1 X148.417 Y132.626 E.40796
G1 X148.995 Y132.649 E.02399
; LINE_WIDTH: 0.485704
G1 X149.573 Y132.672 E.02085
; LINE_WIDTH: 0.4405
G1 X150.15 Y132.695 E.01873
; LINE_WIDTH: 0.395296
G1 X150.728 Y132.718 E.0166
; LINE_WIDTH: 0.350091
G1 X151.305 Y132.741 E.01447
; LINE_WIDTH: 0.304887
G1 X151.883 Y132.764 E.01234
; LINE_WIDTH: 0.259683
G1 X152.46 Y132.787 E.01021
; LINE_WIDTH: 0.214478
G1 X153.038 Y132.81 E.00808
; WIPE_START
G1 F15000
G1 X152.46 Y132.787 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X145.111 Y130.726 Z8.4 F30000
G1 X104.842 Y119.433 Z8.4
G1 Z8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9312
G1 X104.842 Y123.396 E.13147
G1 X104.046 Y123.396 E.0264
G1 X104.046 Y116.728 E.22119
G1 X133.662 Y116.731 E.98243
G3 X136.455 Y117.79 I-.053 J4.352 E.10112
G1 X138.357 Y119.433 E.08338
G1 X104.902 Y119.433 E1.10977
G1 X105.234 Y119.825 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9312
G1 X105.234 Y123.788 E.12178
G1 X103.654 Y123.788 E.04855
G1 X103.654 Y116.347 E.22864
G1 X133.627 Y116.336 E.921
G1 X133.686 Y116.34 E.0018
G3 X135.262 Y116.632 I-.137 J5.143 E.04946
G3 X136.252 Y117.142 I-1.657 J4.43 E.03429
G1 X136.702 Y117.485 E.0174
G1 X138.366 Y118.922 E.06755
G1 X142.083 Y118.922 E.11421
G1 X145.8 Y118.922 E.11421
G1 X149.517 Y118.922 E.11421
G1 X153.234 Y118.922 E.11421
G1 X153.234 Y118.943 E.00064
G1 X153.234 Y119.443 E.01535
G1 X148.435 Y119.825 E.14791
G1 X105.294 Y119.825 E1.32562
M204 S10000
; WIPE_START
G1 F12000
G1 X105.263 Y121.825 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X104.444 Y119.23 Z8.4 F30000
G1 Z8
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.431684
G1 F9312
G1 X104.444 Y123.193 E.12555
; WIPE_START
G1 F15000
G1 X104.444 Y121.193 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X112.041 Y120.462 Z8.4 F30000
G1 X136.315 Y118.129 Z8.4
G1 Z8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9312
G1 X135.359 Y119.085 E.04484
G1 X136.88 Y119.085 E.05047
G1 X135.217 Y117.421 E.07803
G2 X133.652 Y117.079 I-1.935 J5.103 E.05334
G1 X129.689 Y117.079 E.13145
G1 X127.683 Y119.085 E.0941
G1 X129.204 Y119.085 E.05047
G1 X127.198 Y117.079 E.09411
G1 X122.014 Y117.078 E.17199
G1 X120.007 Y119.085 E.09413
G1 X121.529 Y119.085 E.05047
G1 X119.522 Y117.078 E.09414
G1 X114.338 Y117.077 E.17194
G1 X112.331 Y119.085 E.09417
G1 X113.853 Y119.085 E.05047
G1 X111.845 Y117.077 E.09418
G1 X106.663 Y117.077 E.17189
G1 X104.859 Y118.881 E.08465
G1 X105.008 Y118.881 E.00495
G1 X105.008 Y119.085 E.00675
G1 X106.177 Y119.085 E.03877
G1 X104.394 Y117.302 E.08362
G1 X104.394 Y117.077 E.00749
G1 X105.797 Y117.077 E.04653
G1 X138.588 Y119.374 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.552255
G1 F9312
G1 X148.417 Y119.374 E.40796
G1 X148.995 Y119.351 E.02399
; LINE_WIDTH: 0.485706
G1 X149.573 Y119.328 E.02085
; LINE_WIDTH: 0.440501
G1 X150.15 Y119.305 E.01873
; LINE_WIDTH: 0.395297
G1 X150.728 Y119.282 E.0166
; LINE_WIDTH: 0.350093
G1 X151.305 Y119.259 E.01447
; LINE_WIDTH: 0.304888
G1 X151.883 Y119.236 E.01234
; LINE_WIDTH: 0.259684
G1 X152.46 Y119.213 E.01021
; LINE_WIDTH: 0.214479
M73 P63 R7
G1 X153.038 Y119.19 E.00808
; CHANGE_LAYER
; Z_HEIGHT: 8.2
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F15000
G1 X152.46 Y119.213 E-.76
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 41/101
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L41
M991 S0 P40 ;notify layer change
G17
G3 Z8.4 I-.333 J-1.171 P1  F30000
G1 X105.234 Y132.639 Z8.4
G1 Z8.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9292
G1 X138.336 Y132.639 E1.09807
G1 X136.456 Y134.265 E.08246
G3 X133.616 Y135.314 I-2.841 J-3.319 E.10256
G1 X104.046 Y135.314 E.98089
G1 X104.046 Y128.812 E.2157
G1 X104.842 Y128.812 E.0264
G1 X104.842 Y132.639 E.12697
G1 X105.174 Y132.639 E.01102
G1 X105.234 Y132.247 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9292
G1 X148.435 Y132.247 E1.32747
G1 X153.234 Y132.627 E.1479
G1 X153.234 Y133.119 E.01511
G1 X153.234 Y133.132 E.00041
G1 X151.375 Y133.132 E.05711
G1 X147.658 Y133.132 E.11421
G1 X143.941 Y133.132 E.11421
G1 X138.366 Y133.132 E.17132
G1 X136.702 Y134.57 E.06755
G3 X135.263 Y135.416 I-3.378 J-4.097 E.05152
G3 X133.627 Y135.706 I-1.736 J-5.032 E.05126
G1 X103.654 Y135.705 E.921
G1 X103.654 Y128.42 E.22386
G1 X105.234 Y128.42 E.04855
G1 X105.234 Y132.187 E.11576
M204 S10000
; WIPE_START
G1 F12000
G1 X107.234 Y132.19 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X104.444 Y132.843 Z8.6 F30000
G1 Z8.2
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.431684
G1 F9292
G1 X104.444 Y129.015 E.12125
; WIPE_START
G1 F15000
G1 X104.444 Y131.015 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X112.045 Y131.703 Z8.6 F30000
G1 X136.344 Y133.901 Z8.6
G1 Z8.2
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9292
G1 X135.431 Y132.987 E.04284
G1 X136.808 Y132.987 E.04569
G1 X135.128 Y134.667 E.07881
G3 X133.606 Y134.966 I-1.91 J-5.709 E.05162
G1 X129.734 Y134.966 E.12844
G1 X127.755 Y132.987 E.09282
G1 X129.132 Y132.987 E.04569
G1 X127.154 Y134.966 E.09282
G1 X122.058 Y134.966 E.16904
G1 X120.079 Y132.987 E.09282
G1 X121.456 Y132.987 E.04569
G1 X119.478 Y134.966 E.09282
G1 X114.382 Y134.966 E.16904
G1 X112.403 Y132.987 E.09282
G1 X113.78 Y132.987 E.04569
G1 X111.802 Y134.966 E.09282
G1 X106.706 Y134.966 E.16904
G1 X104.931 Y133.191 E.08327
G1 X105.008 Y133.191 E.00256
G1 X105.008 Y132.987 E.00675
G1 X106.104 Y132.987 E.03638
G1 X104.394 Y134.698 E.08024
G1 X104.394 Y134.966 E.0089
G1 X105.754 Y134.966 E.04512
G1 X138.578 Y132.689 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.534593
G1 F9292
G1 X148.418 Y132.689 E.39425
G1 X148.995 Y132.712 E.02315
; LINE_WIDTH: 0.468357
G1 X149.573 Y132.735 E.02004
; LINE_WIDTH: 0.423368
G1 X150.15 Y132.758 E.01792
; LINE_WIDTH: 0.378379
G1 X150.728 Y132.781 E.0158
; LINE_WIDTH: 0.33339
G1 X151.305 Y132.804 E.01368
; LINE_WIDTH: 0.288401
G1 X151.883 Y132.826 E.01156
; LINE_WIDTH: 0.243412
G1 X152.46 Y132.849 E.00944
; LINE_WIDTH: 0.198423
G1 X153.038 Y132.872 E.00732
; WIPE_START
G1 F15000
G1 X152.46 Y132.849 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X145.117 Y130.769 Z8.6 F30000
G1 X104.842 Y119.361 Z8.6
G1 Z8.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9292
G1 X104.842 Y123.188 E.12697
G1 X104.046 Y123.188 E.0264
G1 X104.046 Y116.686 E.2157
G1 X133.616 Y116.686 E.98089
G1 X134.106 Y116.715 E.0163
G1 X134.141 Y116.717 E.00114
G3 X136.456 Y117.735 I-.569 J4.434 E.08506
G1 X138.336 Y119.361 E.08246
G1 X104.902 Y119.361 E1.10909
G1 X105.234 Y119.753 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9292
G1 X105.234 Y123.58 E.11761
G1 X103.654 Y123.58 E.04855
G1 X103.654 Y116.295 E.22386
G1 X133.627 Y116.294 E.921
G1 X134.129 Y116.323 E.01545
G1 X134.732 Y116.424 E.01878
G3 X136.252 Y117.09 I-1.287 J5.001 E.05121
G3 X137.534 Y118.149 I-7.426 J10.293 E.05113
G1 X138.366 Y118.868 E.03378
G1 X142.083 Y118.868 E.11421
G1 X145.8 Y118.868 E.11421
G1 X149.517 Y118.868 E.11421
G1 X153.234 Y118.868 E.11421
G1 X153.234 Y118.881 E.00041
G1 X153.234 Y119.373 E.01511
G1 X148.435 Y119.753 E.1479
G1 X105.294 Y119.753 E1.32562
M204 S10000
; WIPE_START
G1 F12000
G1 X105.262 Y121.753 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X104.444 Y119.157 Z8.6 F30000
G1 Z8.2
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.431684
G1 F9292
G1 X104.444 Y122.985 E.12125
G1 X105.754 Y117.034 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9292
G1 X104.394 Y117.034 E.04512
G1 X104.394 Y117.302 E.0089
G1 X106.104 Y119.013 E.08024
G1 X105.008 Y119.013 E.03638
G1 X105.008 Y118.809 E.00675
G1 X104.931 Y118.809 E.00256
G1 X106.706 Y117.034 E.08327
G1 X111.802 Y117.034 E.16904
G1 X113.78 Y119.013 E.09282
G1 X112.403 Y119.013 E.04569
G1 X114.382 Y117.034 E.09282
G1 X119.478 Y117.034 E.16904
G1 X121.456 Y119.013 E.09282
G1 X120.079 Y119.013 E.04569
G1 X122.058 Y117.034 E.09282
G1 X127.154 Y117.034 E.16904
G1 X129.132 Y119.013 E.09282
G1 X127.755 Y119.013 E.04569
G1 X129.734 Y117.034 E.09282
G1 X133.606 Y117.034 E.12844
G3 X135.128 Y117.333 I-.456 J6.358 E.05161
G1 X136.808 Y119.013 E.07881
G1 X135.431 Y119.013 E.04569
G1 X136.344 Y118.099 E.04284
G1 X138.578 Y119.311 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.534593
G1 F9292
G1 X148.418 Y119.311 E.39425
G1 X148.995 Y119.288 E.02315
; LINE_WIDTH: 0.468357
G1 X149.573 Y119.265 E.02004
; LINE_WIDTH: 0.423368
G1 X150.15 Y119.242 E.01792
; LINE_WIDTH: 0.378379
G1 X150.728 Y119.219 E.0158
; LINE_WIDTH: 0.33339
G1 X151.305 Y119.196 E.01368
; LINE_WIDTH: 0.288401
G1 X151.883 Y119.174 E.01156
; LINE_WIDTH: 0.243412
G1 X152.46 Y119.151 E.00944
; LINE_WIDTH: 0.198423
G1 X153.038 Y119.128 E.00732
; CHANGE_LAYER
; Z_HEIGHT: 8.4
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F15000
G1 X152.46 Y119.151 E-.76
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 42/101
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L42
M991 S0 P41 ;notify layer change
G17
G3 Z8.6 I-.336 J-1.17 P1  F30000
G1 X105.234 Y132.709 Z8.6
G1 Z8.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9271
G1 X138.318 Y132.709 E1.09746
G3 X136.035 Y134.623 I-27.915 J-30.992 E.09883
G3 X133.616 Y135.349 I-2.461 J-3.807 E.0849
G1 X104.046 Y135.349 E.98089
G1 X104.046 Y128.972 E.21152
G1 X104.842 Y128.972 E.0264
G1 X104.842 Y132.709 E.12397
G1 X105.174 Y132.709 E.01102
G1 X105.234 Y132.317 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9271
G1 X148.436 Y132.317 E1.32747
G1 X153.234 Y132.69 E.14788
G1 X153.234 Y133.173 E.01485
G1 X153.234 Y133.186 E.00041
G1 X151.375 Y133.186 E.05711
G1 X147.658 Y133.186 E.11421
G1 X143.941 Y133.186 E.11421
G1 X138.366 Y133.186 E.17132
G3 X137.465 Y133.965 I-34.492 J-39.006 E.03658
G3 X136.253 Y134.95 I-9.877 J-10.92 E.04801
G3 X133.627 Y135.741 I-2.68 J-4.144 E.08537
G1 X103.654 Y135.741 E.921
G1 X103.654 Y128.58 E.22003
G1 X105.234 Y128.58 E.04855
G1 X105.234 Y132.257 E.11299
M204 S10000
; WIPE_START
G1 F12000
G1 X107.234 Y132.26 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X104.444 Y132.913 Z8.8 F30000
G1 Z8.4
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.431684
G1 F9271
G1 X104.444 Y129.176 E.1184
G1 X105.72 Y135 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9271
G1 X104.394 Y135 E.04398
G1 X104.394 Y134.698 E.01004
G1 X106.034 Y133.058 E.07694
G1 X105.008 Y133.058 E.03404
G1 X105.001 Y133.261 E.00676
G1 X106.74 Y135 E.08158
G1 X111.768 Y135 E.16677
G1 X113.71 Y133.058 E.09113
G1 X112.474 Y133.058 E.04102
G1 X114.416 Y135 E.09113
G1 X119.443 Y135 E.16677
G1 X121.386 Y133.058 E.09113
G1 X120.149 Y133.058 E.04102
G1 X122.092 Y135 E.09113
G1 X127.119 Y135 E.16677
G1 X129.062 Y133.058 E.09113
G1 X127.825 Y133.058 E.04102
G1 X129.768 Y135 E.09113
G1 X133.606 Y135 E.1273
G2 X135.068 Y134.728 I-.478 J-6.633 E.04943
G1 X136.738 Y133.058 E.07836
G1 X135.501 Y133.058 E.04102
G1 X136.366 Y133.922 E.04056
G1 X137.376 Y133.058 E.0441
G1 X137.077 Y133.058 E.00992
G1 X138.569 Y132.752 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.518739
G1 F9271
G1 X148.419 Y132.752 E.38193
G1 X148.996 Y132.774 E.0224
; LINE_WIDTH: 0.453723
G1 X149.574 Y132.797 E.01934
; LINE_WIDTH: 0.409563
G1 X150.151 Y132.819 E.01726
; LINE_WIDTH: 0.365403
G1 X150.728 Y132.841 E.01518
; LINE_WIDTH: 0.321244
G1 X151.306 Y132.864 E.0131
; LINE_WIDTH: 0.277084
G1 X151.883 Y132.886 E.01103
; LINE_WIDTH: 0.232924
G1 X152.46 Y132.909 E.00895
; LINE_WIDTH: 0.188764
G1 X153.038 Y132.931 E.00687
; WIPE_START
G1 F15000
G1 X152.46 Y132.909 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X145.122 Y130.81 Z8.8 F30000
G1 X104.842 Y119.291 Z8.8
G1 Z8.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9271
G1 X104.842 Y123.028 E.12397
G1 X104.046 Y123.028 E.0264
G1 X104.046 Y116.651 E.21152
G1 X133.616 Y116.651 E.98089
G1 X133.969 Y116.672 E.01173
G3 X136.458 Y117.698 I-.306 J4.276 E.09085
G3 X138.318 Y119.291 I-68.877 J82.319 E.08122
G1 X104.902 Y119.291 E1.10848
G1 X105.234 Y119.683 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9271
G1 X105.234 Y123.42 E.11484
G1 X103.654 Y123.42 E.04855
G1 X103.654 Y116.259 E.22003
G1 X133.627 Y116.259 E.921
G1 X133.992 Y116.281 E.01122
G1 X134.187 Y116.292 E.00599
G3 X136.703 Y117.392 I-.631 J4.875 E.08553
G1 X137.465 Y118.035 E.03063
G3 X138.366 Y118.814 I-33.591 J39.784 E.03658
G1 X142.083 Y118.814 E.11421
G1 X145.8 Y118.814 E.11421
G1 X149.517 Y118.814 E.11421
G1 X153.234 Y118.814 E.11421
G1 X153.234 Y118.827 E.00041
G1 X153.234 Y119.31 E.01485
G1 X148.436 Y119.683 E.14788
G1 X105.294 Y119.683 E1.32563
M204 S10000
; WIPE_START
G1 F12000
G1 X105.262 Y121.682 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X104.444 Y119.087 Z8.8 F30000
G1 Z8.4
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.431684
G1 F9271
G1 X104.444 Y122.824 E.1184
; WIPE_START
G1 F15000
G1 X104.444 Y120.824 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X112.064 Y120.385 Z8.8 F30000
G1 X137.077 Y118.942 Z8.8
G1 Z8.4
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9271
G1 X137.376 Y118.942 E.00992
G1 X136.366 Y118.078 E.04409
G1 X135.501 Y118.942 E.04056
G1 X136.738 Y118.942 E.04102
G1 X135.068 Y117.272 E.07836
G2 X133.606 Y117 I-1.518 J4.092 E.04957
G1 X129.768 Y117 E.1273
G1 X127.825 Y118.942 E.09113
G1 X129.062 Y118.942 E.04102
G1 X127.119 Y117 E.09113
G1 X122.092 Y117 E.16677
G1 X120.149 Y118.942 E.09113
G1 X121.386 Y118.942 E.04102
G1 X119.443 Y117 E.09113
G1 X114.416 Y117 E.16677
G1 X112.474 Y118.942 E.09113
G1 X113.71 Y118.942 E.04102
G1 X111.768 Y117 E.09113
G1 X106.74 Y117 E.16677
G1 X105.001 Y118.739 E.08158
G1 X105.008 Y118.942 E.00676
G1 X106.034 Y118.942 E.03404
G1 X104.394 Y117.302 E.07694
G1 X104.394 Y117 E.01003
G1 X105.72 Y117 E.04398
G1 X138.569 Y119.248 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.518739
G1 F9271
G1 X148.419 Y119.248 E.38193
G1 X148.996 Y119.226 E.0224
; LINE_WIDTH: 0.453722
G1 X149.574 Y119.203 E.01934
; LINE_WIDTH: 0.409563
G1 X150.151 Y119.181 E.01726
; LINE_WIDTH: 0.365403
G1 X150.728 Y119.159 E.01518
; LINE_WIDTH: 0.321243
G1 X151.306 Y119.136 E.0131
; LINE_WIDTH: 0.277083
G1 X151.883 Y119.114 E.01103
; LINE_WIDTH: 0.232923
G1 X152.46 Y119.091 E.00895
; LINE_WIDTH: 0.188763
G1 X153.038 Y119.069 E.00687
; CHANGE_LAYER
; Z_HEIGHT: 8.6
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F15000
G1 X152.46 Y119.091 E-.76
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 43/101
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L43
M991 S0 P42 ;notify layer change
G17
G3 Z8.8 I-.338 J-1.169 P1  F30000
M73 P64 R7
G1 X105.234 Y132.758 Z8.8
G1 Z8.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9218
G1 X138.328 Y132.758 E1.0978
G1 X136.459 Y134.338 E.08118
G3 X133.616 Y135.383 I-2.836 J-3.327 E.1026
G1 X104.046 Y135.383 E.98089
G1 X104.046 Y129.123 E.20764
G1 X104.842 Y129.123 E.0264
G1 X104.842 Y132.758 E.12058
G1 X105.174 Y132.758 E.01102
G1 X105.234 Y132.366 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9218
G1 X148.436 Y132.366 E1.32747
G1 X153.234 Y132.737 E.14787
G1 X153.234 Y133.227 E.01507
G1 X153.234 Y133.239 E.00035
G1 X149.517 Y133.239 E.1142
G1 X143.942 Y133.239 E.1713
G1 X138.368 Y133.239 E.1713
G1 X136.703 Y134.644 E.06693
G3 X133.627 Y135.775 I-3.074 J-3.615 E.10282
G1 X103.654 Y135.775 E.921
G1 X103.654 Y128.731 E.21643
G1 X105.234 Y128.731 E.04855
G1 X105.234 Y132.306 E.10985
M204 S10000
; WIPE_START
G1 F12000
G1 X107.234 Y132.309 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X104.444 Y132.962 Z9 F30000
G1 Z8.6
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.431684
G1 F9218
G1 X104.444 Y129.327 E.11515
; WIPE_START
G1 F15000
G1 X104.444 Y131.327 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X112.065 Y131.743 Z9 F30000
G1 X137.044 Y133.107 Z9
G1 Z8.6
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9218
G1 X137.376 Y133.107 E.01103
G1 X136.387 Y133.943 E.04298
G1 X135.55 Y133.107 E.03923
G1 X136.689 Y133.107 E.03778
G1 X135.007 Y134.789 E.07891
G3 X133.606 Y135.035 I-1.473 J-4.279 E.0474
G1 X129.802 Y135.035 E.12616
G1 X127.874 Y133.107 E.09045
G1 X129.013 Y133.107 E.03778
G1 X127.085 Y135.035 E.09045
G1 X122.126 Y135.035 E.16449
G1 X120.198 Y133.107 E.09045
G1 X121.337 Y133.107 E.03778
G1 X119.409 Y135.035 E.09045
G1 X114.45 Y135.035 E.16449
G1 X112.522 Y133.107 E.09045
G1 X113.661 Y133.107 E.03778
G1 X111.733 Y135.035 E.09045
G1 X106.774 Y135.035 E.16449
G1 X105.008 Y133.268 E.08287
G1 X105.008 Y133.107 E.00536
G1 X105.985 Y133.107 E.03242
G1 X104.394 Y134.698 E.07465
G1 X104.394 Y135.035 E.01117
G1 X105.686 Y135.035 E.04284
G1 X138.58 Y132.803 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.522271
G1 F9218
G1 X148.419 Y132.803 E.38433
G1 X148.996 Y132.825 E.02257
; LINE_WIDTH: 0.457569
G1 X149.574 Y132.847 E.01952
; LINE_WIDTH: 0.413623
G1 X150.151 Y132.869 E.01745
; LINE_WIDTH: 0.369677
G1 X150.728 Y132.892 E.01538
; LINE_WIDTH: 0.325731
G1 X151.306 Y132.914 E.01332
; LINE_WIDTH: 0.281785
G1 X151.883 Y132.936 E.01125
; LINE_WIDTH: 0.237839
G1 X152.46 Y132.959 E.00918
; LINE_WIDTH: 0.193893
G1 X153.038 Y132.981 E.00711
; WIPE_START
G1 F15000
G1 X152.46 Y132.959 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X145.126 Y130.846 Z9 F30000
G1 X104.842 Y119.242 Z9
G1 Z8.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9218
G1 X104.842 Y122.877 E.12058
G1 X104.046 Y122.877 E.0264
G1 X104.046 Y116.617 E.20764
G1 X133.616 Y116.617 E.98089
G1 X133.831 Y116.63 E.00716
G3 X136.459 Y117.662 I-.181 J4.32 E.09539
G1 X138.328 Y119.242 E.08118
G1 X104.902 Y119.242 E1.10882
G1 X105.234 Y119.634 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9218
G1 X105.234 Y123.269 E.11169
G1 X103.654 Y123.269 E.04855
G1 X103.654 Y116.225 E.21643
G1 X133.627 Y116.225 E.921
G1 X133.854 Y116.238 E.00699
G3 X136.703 Y117.356 I-.196 J4.69 E.09579
G1 X138.368 Y118.761 E.06693
G1 X142.084 Y118.761 E.1142
G1 X147.659 Y118.761 E.1713
G1 X151.375 Y118.761 E.1142
G1 X153.234 Y118.761 E.0571
G1 X153.234 Y118.773 E.00035
G1 X153.234 Y119.263 E.01507
G1 X148.436 Y119.634 E.14787
G1 X105.294 Y119.634 E1.32563
M204 S10000
; WIPE_START
G1 F12000
G1 X105.261 Y121.634 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X104.444 Y119.038 Z9 F30000
G1 Z8.6
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.431684
G1 F9218
G1 X104.444 Y122.673 E.11515
G1 X105.686 Y116.965 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9218
G1 X104.394 Y116.965 E.04284
G1 X104.394 Y117.302 E.01117
G1 X105.985 Y118.893 E.07465
G1 X105.008 Y118.893 E.03242
G1 X105.008 Y118.732 E.00536
G1 X106.774 Y116.965 E.08287
G1 X111.733 Y116.965 E.16449
G1 X113.661 Y118.893 E.09045
G1 X112.522 Y118.893 E.03778
G1 X114.45 Y116.965 E.09045
G1 X119.409 Y116.965 E.16449
G1 X121.337 Y118.893 E.09045
G1 X120.198 Y118.893 E.03778
G1 X122.126 Y116.965 E.09045
G1 X127.085 Y116.965 E.16449
G1 X129.013 Y118.893 E.09045
G1 X127.874 Y118.893 E.03778
G1 X129.802 Y116.965 E.09045
G1 X133.811 Y116.978 E.13297
G3 X135.007 Y117.211 I-.214 J4.269 E.04057
G1 X136.689 Y118.893 E.07891
G1 X135.55 Y118.893 E.03778
G1 X136.387 Y118.057 E.03923
G1 X137.376 Y118.893 E.04298
G1 X137.044 Y118.893 E.01103
G1 X138.58 Y119.197 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.522271
G1 F9218
G1 X148.419 Y119.197 E.38433
G1 X148.996 Y119.175 E.02257
; LINE_WIDTH: 0.457571
G1 X149.574 Y119.153 E.01952
; LINE_WIDTH: 0.413625
M73 P64 R6
G1 X150.151 Y119.131 E.01745
; LINE_WIDTH: 0.369679
G1 X150.728 Y119.108 E.01538
; LINE_WIDTH: 0.325733
G1 X151.306 Y119.086 E.01332
; LINE_WIDTH: 0.281787
G1 X151.883 Y119.064 E.01125
; LINE_WIDTH: 0.237841
G1 X152.46 Y119.041 E.00918
; LINE_WIDTH: 0.193895
G1 X153.038 Y119.019 E.00711
; CHANGE_LAYER
; Z_HEIGHT: 8.8
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F15000
G1 X152.46 Y119.041 E-.76
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 44/101
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L44
M991 S0 P43 ;notify layer change
G17
G3 Z9 I-.329 J-1.172 P1  F30000
G1 X104.842 Y132.415 Z9
G1 Z8.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9174
G1 X104.842 Y132.807 E.01301
G1 X138.31 Y132.807 E1.11022
G1 X136.459 Y134.374 E.08044
G3 X133.616 Y135.417 I-2.846 J-3.359 E.10257
G1 X104.046 Y135.417 E.98089
G1 X104.046 Y129.232 E.20517
G1 X104.842 Y129.232 E.0264
G1 X104.842 Y132.355 E.1036
G1 X105.234 Y132.415 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9174
G1 X148.436 Y132.415 E1.32747
G1 X153.234 Y132.784 E.14787
G1 X153.234 Y133.273 E.01501
G1 X138.367 Y133.273 E.45682
G1 X136.704 Y134.68 E.06695
G3 X133.627 Y135.809 I-3.083 J-3.647 E.10277
G1 X103.654 Y135.809 E.921
G1 X103.654 Y128.84 E.21414
G1 X105.234 Y128.84 E.04855
G1 X105.234 Y132.355 E.10801
M204 S10000
; WIPE_START
G1 F12000
G1 X107.234 Y132.358 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X104.444 Y133.011 Z9.2 F30000
G1 Z8.8
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.431684
G1 F9174
G1 X104.444 Y129.436 E.11326
G1 X105.651 Y135.069 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9174
G1 X104.394 Y135.069 E.0417
G1 X104.394 Y134.698 E.01231
G1 X105.936 Y133.155 E.07235
G1 X105.008 Y133.155 E.0308
G1 X105.008 Y133.268 E.00373
G1 X106.809 Y135.069 E.08448
G1 X111.699 Y135.069 E.16222
G1 X113.612 Y133.155 E.08976
G1 X112.571 Y133.155 E.03454
G1 X114.485 Y135.069 E.08976
G1 X119.375 Y135.069 E.16222
G1 X121.288 Y133.155 E.08976
G1 X120.247 Y133.155 E.03454
G1 X122.161 Y135.069 E.08976
G1 X127.051 Y135.069 E.16222
G1 X128.964 Y133.155 E.08976
G1 X127.923 Y133.155 E.03454
G1 X129.837 Y135.069 E.08976
G1 X133.606 Y135.069 E.12502
G2 X134.958 Y134.838 I-.064 J-4.449 E.04569
G1 X136.64 Y133.155 E.07892
G1 X135.599 Y133.155 E.03454
G1 X136.406 Y133.962 E.03785
G1 X137.36 Y133.155 E.04144
G1 X136.981 Y133.155 E.01258
G1 X138.57 Y132.844 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.507573
G1 F9174
G1 X148.419 Y132.844 E.37291
G1 X148.997 Y132.866 E.02188
; LINE_WIDTH: 0.443058
G1 X149.574 Y132.888 E.01884
; LINE_WIDTH: 0.399238
G1 X150.151 Y132.911 E.01677
; LINE_WIDTH: 0.355419
G1 X150.728 Y132.933 E.01471
; LINE_WIDTH: 0.3116
G1 X151.306 Y132.955 E.01265
; LINE_WIDTH: 0.26778
G1 X151.883 Y132.977 E.01059
; LINE_WIDTH: 0.223961
G1 X152.46 Y132.999 E.00852
; LINE_WIDTH: 0.180142
G1 X153.038 Y133.022 E.00646
; WIPE_START
G1 F15000
G1 X152.46 Y132.999 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X145.13 Y130.874 Z9.2 F30000
G1 X104.842 Y119.193 Z9.2
G1 Z8.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9174
G1 X104.842 Y122.768 E.11859
G1 X104.046 Y122.768 E.0264
G1 X104.046 Y116.583 E.20517
G1 X133.694 Y116.587 E.98348
G3 X136.459 Y117.626 I-.068 J4.381 E.09995
G1 X138.31 Y119.193 E.08044
G1 X104.902 Y119.193 E1.10823
G1 X105.234 Y119.585 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9174
G1 X105.234 Y123.16 E.10985
G1 X103.654 Y123.16 E.04855
G1 X103.654 Y116.191 E.21414
G1 X133.717 Y116.196 E.92375
G3 X136.704 Y117.32 I-.083 J4.752 E.1
G1 X138.367 Y118.727 E.06695
G1 X153.234 Y118.727 E.45682
G1 X153.234 Y119.216 E.01501
G1 X148.436 Y119.585 E.14787
G1 X105.294 Y119.585 E1.32563
M204 S10000
; WIPE_START
G1 F12000
G1 X105.26 Y121.585 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X104.444 Y118.989 Z9.2 F30000
G1 Z8.8
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.431684
G1 F9174
G1 X104.444 Y122.564 E.11326
; WIPE_START
G1 F15000
G1 X104.444 Y120.564 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X112.066 Y120.162 Z9.2 F30000
G1 X136.981 Y118.845 Z9.2
G1 Z8.8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9174
G1 X137.36 Y118.845 E.01258
G1 X136.406 Y118.038 E.04144
G1 X135.599 Y118.845 E.03785
G1 X136.64 Y118.845 E.03454
G1 X134.958 Y117.162 E.07892
G2 X133.683 Y116.936 I-1.385 J4.095 E.0431
G1 X129.833 Y116.935 E.12774
G1 X127.923 Y118.845 E.08958
G1 X128.964 Y118.845 E.03454
G1 X127.054 Y116.935 E.0896
G1 X122.158 Y116.934 E.16243
G1 X120.247 Y118.845 E.08963
G1 X121.288 Y118.845 E.03454
G1 X119.377 Y116.934 E.08965
G1 X114.483 Y116.933 E.16235
G1 X112.571 Y118.845 E.08969
G1 X113.612 Y118.845 E.03454
G1 X111.7 Y116.932 E.08971
G1 X106.808 Y116.932 E.16227
G1 X105.008 Y118.732 E.08446
G1 X105.008 Y118.845 E.00373
G1 X105.936 Y118.845 E.0308
G1 X104.394 Y117.302 E.07235
G1 X104.394 Y116.931 E.01231
G1 X105.651 Y116.931 E.04171
G1 X138.57 Y119.156 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.507573
G1 F9174
G1 X148.419 Y119.156 E.37291
G1 X148.997 Y119.134 E.02188
; LINE_WIDTH: 0.443059
G1 X149.574 Y119.112 E.01884
; LINE_WIDTH: 0.399239
G1 X150.151 Y119.089 E.01677
; LINE_WIDTH: 0.35542
G1 X150.728 Y119.067 E.01471
; LINE_WIDTH: 0.3116
G1 X151.306 Y119.045 E.01265
; LINE_WIDTH: 0.26778
G1 X151.883 Y119.023 E.01059
; LINE_WIDTH: 0.223961
G1 X152.46 Y119.001 E.00852
; LINE_WIDTH: 0.180141
G1 X153.038 Y118.978 E.00646
; CHANGE_LAYER
; Z_HEIGHT: 9
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F15000
G1 X152.46 Y119.001 E-.76
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 45/101
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L45
M991 S0 P44 ;notify layer change
G17
G3 Z9.2 I-.331 J-1.171 P1  F30000
G1 X104.842 Y132.464 Z9.2
G1 Z9
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9127
G1 X104.842 Y132.856 E.01301
G1 X138.293 Y132.856 E1.10963
G1 X136.46 Y134.41 E.07971
G3 X133.616 Y135.446 I-2.84 J-3.373 E.10248
G1 X104.046 Y135.446 E.9809
G1 X104.046 Y129.34 E.20254
G1 X104.842 Y129.34 E.0264
G1 X104.842 Y132.404 E.10162
G1 X105.234 Y132.464 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9127
G1 X148.436 Y132.464 E1.32748
G1 X153.234 Y132.832 E.14786
G1 X153.234 Y133.307 E.01461
G1 X138.367 Y133.307 E.45682
G1 X136.704 Y134.717 E.06698
G3 X133.627 Y135.838 I-3.078 J-3.664 E.10269
G1 X103.654 Y135.838 E.92101
G1 X103.654 Y128.948 E.21171
G1 X105.234 Y128.948 E.04855
M73 P65 R6
G1 X105.234 Y132.404 E.10618
M204 S10000
; WIPE_START
G1 F12000
G1 X107.234 Y132.407 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X104.444 Y133.06 Z9.4 F30000
G1 Z9
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.431684
G1 F9127
G1 X104.444 Y129.544 E.11137
; WIPE_START
G1 F15000
G1 X104.444 Y131.544 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X112.066 Y131.934 Z9.4 F30000
G1 X136.917 Y133.204 Z9.4
G1 Z9
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9127
G1 X137.343 Y133.204 E.01412
G1 X136.426 Y133.982 E.0399
G1 X135.648 Y133.204 E.03648
G1 X136.591 Y133.204 E.0313
G1 X134.912 Y134.883 E.07877
G3 X133.606 Y135.098 I-1.365 J-4.225 E.04408
G1 X129.866 Y135.098 E.12407
G1 X127.972 Y133.204 E.08883
G1 X128.915 Y133.204 E.0313
G1 X127.022 Y135.098 E.08883
G1 X122.19 Y135.098 E.16029
G1 X120.296 Y133.204 E.08883
G1 X121.239 Y133.204 E.0313
G1 X119.346 Y135.098 E.08883
G1 X114.514 Y135.098 E.16029
G1 X112.62 Y133.204 E.08883
G1 X113.564 Y133.204 E.0313
G1 X111.67 Y135.098 E.08883
G1 X106.838 Y135.098 E.16029
G1 X105.008 Y133.268 E.08584
G1 X105.008 Y133.204 E.00211
G1 X105.888 Y133.204 E.02918
G1 X104.394 Y134.698 E.07006
G1 X104.394 Y135.098 E.01327
G1 X105.622 Y135.098 E.04074
G1 X138.561 Y132.886 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.492518
G1 F9127
G1 X148.42 Y132.886 E.36118
G1 X149.079 Y132.911 E.02419
; LINE_WIDTH: 0.419183
G1 X149.739 Y132.936 E.02024
; LINE_WIDTH: 0.369249
G1 X150.399 Y132.961 E.01756
; LINE_WIDTH: 0.319315
G1 X151.059 Y132.987 E.01487
; LINE_WIDTH: 0.269381
G1 X151.718 Y133.012 E.01218
; LINE_WIDTH: 0.219447
G1 X152.378 Y133.037 E.0095
; LINE_WIDTH: 0.169513
G1 X153.038 Y133.062 E.00681
; WIPE_START
G1 F15000
G1 X152.378 Y133.037 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X145.052 Y130.896 Z9.4 F30000
G1 X104.842 Y119.144 Z9.4
G1 Z9
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9127
G1 X104.842 Y122.66 E.11662
G1 X104.046 Y122.66 E.0264
G1 X104.046 Y116.554 E.20254
G1 X133.616 Y116.554 E.9809
G1 X134.141 Y116.584 E.01745
G3 X136.46 Y117.59 I-.574 J4.496 E.08496
G1 X138.293 Y119.144 E.07971
G1 X104.902 Y119.144 E1.10764
G1 X105.234 Y119.536 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9127
G1 X105.234 Y123.052 E.10802
G1 X103.654 Y123.052 E.04855
G1 X103.654 Y116.162 E.21171
G1 X133.627 Y116.162 E.92101
G1 X134.16 Y116.193 E.01641
G1 X134.187 Y116.194 E.00081
G3 X136.704 Y117.283 I-.624 J4.894 E.08539
G1 X138.367 Y118.693 E.06698
G1 X153.234 Y118.693 E.45682
G1 X153.234 Y119.168 E.01461
G1 X148.436 Y119.536 E.14786
G1 X105.294 Y119.536 E1.32563
M204 S10000
; WIPE_START
G1 F12000
G1 X105.26 Y121.536 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X104.444 Y118.94 Z9.4 F30000
G1 Z9
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.431684
G1 F9127
G1 X104.444 Y122.456 E.11137
G1 X105.622 Y116.902 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9127
G1 X104.394 Y116.902 E.04074
G1 X104.394 Y117.302 E.01327
G1 X105.888 Y118.796 E.07006
G1 X105.008 Y118.796 E.02918
G1 X105.008 Y118.732 E.00211
G1 X106.838 Y116.902 E.08584
G1 X111.67 Y116.902 E.16029
G1 X113.564 Y118.796 E.08883
G1 X112.62 Y118.796 E.0313
G1 X114.514 Y116.902 E.08883
G1 X119.346 Y116.902 E.16029
G1 X121.239 Y118.796 E.08883
G1 X120.296 Y118.796 E.03129
G1 X122.19 Y116.902 E.08883
G1 X127.022 Y116.902 E.16029
G1 X128.915 Y118.796 E.08883
G1 X127.972 Y118.796 E.03129
G1 X129.866 Y116.902 E.08883
G1 X133.606 Y116.902 E.12407
G3 X134.912 Y117.117 I-.058 J4.44 E.04408
G1 X136.591 Y118.796 E.07877
G1 X135.648 Y118.796 E.03129
G1 X136.426 Y118.018 E.03648
G1 X137.343 Y118.796 E.03989
G1 X136.917 Y118.796 E.01412
G1 X138.561 Y119.114 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.492518
G1 F9127
G1 X148.42 Y119.114 E.36118
G1 X149.079 Y119.089 E.02419
; LINE_WIDTH: 0.419185
G1 X149.739 Y119.064 E.02024
; LINE_WIDTH: 0.36925
G1 X150.399 Y119.039 E.01756
; LINE_WIDTH: 0.319316
G1 X151.059 Y119.013 E.01487
; LINE_WIDTH: 0.269381
G1 X151.718 Y118.988 E.01218
; LINE_WIDTH: 0.219447
G1 X152.378 Y118.963 E.0095
; LINE_WIDTH: 0.169512
G1 X153.038 Y118.938 E.00681
; CHANGE_LAYER
; Z_HEIGHT: 9.2
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F15000
G1 X152.378 Y118.963 E-.76
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 46/101
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L46
M991 S0 P45 ;notify layer change
G17
G3 Z9.4 I-.333 J-1.17 P1  F30000
G1 X104.842 Y132.496 Z9.4
G1 Z9.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9096
G1 X104.842 Y132.888 E.01301
G1 X138.296 Y132.888 E1.10973
G3 X136.461 Y134.428 I-92.964 J-108.823 E.07946
G3 X133.616 Y135.463 I-2.838 J-3.374 E.10252
G1 X104.046 Y135.463 E.9809
G1 X104.046 Y129.412 E.20072
G1 X104.842 Y129.412 E.0264
G1 X104.842 Y132.436 E.10029
G1 X105.234 Y132.496 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9096
G1 X148.436 Y132.496 E1.32748
G1 X153.234 Y132.859 E.14785
G1 X153.234 Y133.341 E.01481
G1 X138.367 Y133.341 E.45682
G3 X136.704 Y134.736 I-84.179 J-98.643 E.06668
G3 X133.627 Y135.855 I-3.074 J-3.663 E.10268
G1 X103.654 Y135.855 E.92101
G1 X103.654 Y129.02 E.21002
G1 X105.234 Y129.02 E.04855
G1 X105.234 Y132.436 E.10495
M204 S10000
; WIPE_START
G1 F12000
G1 X107.234 Y132.438 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X104.444 Y133.091 Z9.6 F30000
G1 Z9.2
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.431684
G1 F9096
G1 X104.444 Y129.616 E.1101
G1 X105.605 Y135.115 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9096
G1 X104.394 Y135.115 E.04018
G1 X104.394 Y134.698 E.01384
G1 X105.856 Y133.236 E.06858
G1 X105.008 Y133.236 E.02813
G1 X106.855 Y135.115 E.0874
G1 X111.653 Y135.115 E.15916
G1 X113.532 Y133.236 E.08815
G1 X112.652 Y133.236 E.0292
G1 X114.531 Y135.115 E.08815
G1 X119.329 Y135.115 E.15916
G1 X121.208 Y133.236 E.08815
G1 X120.328 Y133.236 E.0292
G1 X122.207 Y135.115 E.08815
G1 X127.005 Y135.115 E.15916
G1 X128.884 Y133.236 E.08815
G1 X128.004 Y133.236 E.0292
G1 X129.883 Y135.115 E.08815
G1 X133.606 Y135.115 E.12351
G2 X134.888 Y134.908 I-.056 J-4.414 E.04324
G1 X136.56 Y133.236 E.07842
G1 X135.68 Y133.236 E.0292
G1 X136.437 Y133.994 E.03555
G1 X137.339 Y133.236 E.03908
G1 X136.889 Y133.236 E.01493
G1 X138.562 Y132.918 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.49508
G1 F9096
G1 X148.42 Y132.918 E.3632
G1 X149.079 Y132.943 E.02432
; LINE_WIDTH: 0.42259
G1 X149.739 Y132.968 E.02042
; LINE_WIDTH: 0.373231
G1 X150.399 Y132.993 E.01777
; LINE_WIDTH: 0.323872
G1 X151.059 Y133.018 E.01511
; LINE_WIDTH: 0.274513
G1 X151.718 Y133.043 E.01246
; LINE_WIDTH: 0.225155
G1 X152.378 Y133.068 E.0098
; LINE_WIDTH: 0.175796
G1 X153.038 Y133.093 E.00715
; WIPE_START
G1 F15000
G1 X152.378 Y133.068 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X145.055 Y130.918 Z9.6 F30000
G1 X104.842 Y119.112 Z9.6
G1 Z9.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9096
G1 X104.842 Y122.588 E.11529
G1 X104.046 Y122.588 E.0264
G1 X104.046 Y116.537 E.20072
G1 X133.616 Y116.537 E.9809
G1 X134.002 Y116.559 E.01283
G3 X136.461 Y117.572 I-.343 J4.326 E.08966
G3 X138.296 Y119.112 I-91.129 J110.364 E.07946
G1 X104.902 Y119.112 E1.10774
G1 X105.234 Y119.504 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9096
G1 X105.234 Y122.98 E.10679
G1 X103.654 Y122.98 E.04855
G1 X103.654 Y116.145 E.21002
G1 X133.627 Y116.145 E.92101
G1 X134.025 Y116.168 E.01223
G1 X134.187 Y116.177 E.00498
G3 X136.704 Y117.264 I-.629 J4.918 E.08537
G3 X138.367 Y118.659 I-82.516 J100.038 E.06668
G1 X153.234 Y118.659 E.45682
G1 X153.234 Y119.141 E.01481
G1 X148.436 Y119.504 E.14785
G1 X105.294 Y119.504 E1.32564
M204 S10000
; WIPE_START
G1 F12000
G1 X105.259 Y121.504 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X104.444 Y118.909 Z9.6 F30000
G1 Z9.2
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.431684
G1 F9096
G1 X104.444 Y122.384 E.1101
; WIPE_START
G1 F15000
G1 X104.444 Y120.384 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X112.067 Y120.004 Z9.6 F30000
G1 X136.889 Y118.764 Z9.6
G1 Z9.2
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9096
G1 X137.339 Y118.764 E.01493
G1 X136.437 Y118.006 E.03908
G1 X135.68 Y118.764 E.03554
G1 X136.56 Y118.764 E.0292
G1 X134.888 Y117.092 E.07842
G2 X133.606 Y116.885 I-1.453 J4.917 E.0432
G1 X129.883 Y116.885 E.12351
G1 X128.004 Y118.764 E.08815
G1 X128.884 Y118.764 E.0292
G1 X127.005 Y116.885 E.08815
G1 X122.207 Y116.885 E.15916
G1 X120.328 Y118.764 E.08815
G1 X121.208 Y118.764 E.0292
G1 X119.329 Y116.885 E.08815
G1 X114.531 Y116.885 E.15916
G1 X112.652 Y118.764 E.08815
G1 X113.532 Y118.764 E.0292
G1 X111.653 Y116.885 E.08815
G1 X106.855 Y116.885 E.15916
G1 X105.008 Y118.764 E.0874
G1 X105.856 Y118.764 E.02813
G1 X104.394 Y117.302 E.06858
G1 X104.394 Y116.885 E.01384
G1 X105.605 Y116.885 E.04018
G1 X138.562 Y119.082 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.49508
G1 F9096
G1 X148.42 Y119.082 E.3632
G1 X149.079 Y119.057 E.02432
; LINE_WIDTH: 0.422592
G1 X149.739 Y119.032 E.02042
; LINE_WIDTH: 0.373233
G1 X150.399 Y119.007 E.01777
; LINE_WIDTH: 0.323874
G1 X151.059 Y118.982 E.01511
; LINE_WIDTH: 0.274514
G1 X151.718 Y118.957 E.01246
; LINE_WIDTH: 0.225155
G1 X152.378 Y118.932 E.0098
; LINE_WIDTH: 0.175796
G1 X153.038 Y118.907 E.00715
; CHANGE_LAYER
; Z_HEIGHT: 9.4
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F15000
G1 X152.378 Y118.932 E-.76
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 47/101
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L47
M991 S0 P46 ;notify layer change
G17
G3 Z9.6 I-.335 J-1.17 P1  F30000
G1 X104.842 Y132.522 Z9.6
G1 Z9.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9069
G1 X104.842 Y132.914 E.01301
G1 X138.297 Y132.914 E1.10978
G1 X136.462 Y134.446 E.0793
G3 X133.616 Y135.48 I-2.838 J-3.378 E.10251
G1 X104.046 Y135.48 E.9809
G1 X104.046 Y129.484 E.1989
G1 X104.842 Y129.484 E.0264
G1 X104.842 Y132.462 E.09879
G1 X105.234 Y132.522 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9069
G1 X148.436 Y132.522 E1.32748
G1 X153.234 Y132.885 E.14785
G1 X153.234 Y133.366 E.01478
G1 X138.368 Y133.366 E.45679
G1 X136.704 Y134.754 E.06656
G3 X133.627 Y135.872 I-3.074 J-3.668 E.10267
G1 X103.654 Y135.872 E.92101
G1 X103.654 Y129.092 E.20834
G1 X105.234 Y129.092 E.04855
G1 X105.234 Y132.462 E.10356
M204 S10000
; WIPE_START
G1 F12000
G1 X107.234 Y132.465 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X104.444 Y133.118 Z9.8 F30000
G1 Z9.4
M73 P66 R6
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.431684
G1 F9069
G1 X104.444 Y129.688 E.10867
; WIPE_START
G1 F15000
G1 X104.444 Y131.688 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X112.067 Y132.058 Z9.8 F30000
G1 X136.865 Y133.263 Z9.8
G1 Z9.4
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9069
G1 X137.336 Y133.263 E.01563
G1 X136.448 Y134.004 E.03838
G1 X135.706 Y133.263 E.03478
G1 X136.533 Y133.263 E.02742
G1 X134.864 Y134.932 E.07831
G3 X133.606 Y135.132 I-1.312 J-4.193 E.0424
G1 X129.9 Y135.132 E.12294
G1 X128.03 Y133.263 E.08769
G1 X128.857 Y133.263 E.02742
G1 X126.988 Y135.132 E.08769
G1 X122.224 Y135.132 E.15803
G1 X120.354 Y133.263 E.08769
G1 X121.181 Y133.263 E.02742
G1 X119.312 Y135.132 E.08769
G1 X114.548 Y135.132 E.15803
G1 X112.678 Y133.263 E.08769
G1 X113.505 Y133.263 E.02742
G1 X111.636 Y135.132 E.08769
G1 X106.872 Y135.132 E.15803
G1 X105.008 Y133.263 E.08757
G1 X105.829 Y133.263 E.02724
G1 X104.394 Y134.698 E.06732
G1 X104.394 Y135.132 E.0144
G1 X105.588 Y135.132 E.03961
G1 X138.567 Y132.944 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.493224
G1 F9069
G1 X148.42 Y132.944 E.36153
G1 X149.08 Y132.969 E.02422
; LINE_WIDTH: 0.420896
G1 X149.739 Y132.994 E.02033
; LINE_WIDTH: 0.371648
G1 X150.399 Y133.019 E.01768
; LINE_WIDTH: 0.3224
G1 X151.059 Y133.044 E.01503
; LINE_WIDTH: 0.273152
G1 X151.718 Y133.069 E.01239
; LINE_WIDTH: 0.223904
G1 X152.378 Y133.094 E.00974
; LINE_WIDTH: 0.174656
G1 X153.038 Y133.119 E.00709
; WIPE_START
G1 F15000
G1 X152.378 Y133.094 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X145.057 Y130.936 Z9.8 F30000
G1 X104.842 Y119.086 Z9.8
G1 Z9.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9069
G1 X104.842 Y122.516 E.11379
G1 X104.046 Y122.516 E.0264
G1 X104.046 Y116.52 E.1989
G1 X133.616 Y116.52 E.9809
G1 X133.867 Y116.534 E.00832
G3 X136.462 Y117.554 I-.21 J4.347 E.09415
G1 X138.297 Y119.086 E.0793
G1 X104.902 Y119.086 E1.10779
G1 X105.234 Y119.478 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9069
G1 X105.234 Y122.908 E.1054
G1 X103.654 Y122.908 E.04855
G1 X103.654 Y116.128 E.20834
G1 X133.627 Y116.128 E.92101
G1 X133.889 Y116.143 E.00806
G3 X136.704 Y117.246 I-.225 J4.717 E.09457
G1 X138.368 Y118.634 E.06656
G1 X153.234 Y118.634 E.45679
G1 X153.234 Y119.115 E.01478
G1 X148.436 Y119.478 E.14785
G1 X105.294 Y119.478 E1.32564
M204 S10000
; WIPE_START
G1 F12000
G1 X105.259 Y121.477 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X104.444 Y118.882 Z9.8 F30000
G1 Z9.4
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.431684
G1 F9069
G1 X104.444 Y122.312 E.10867
G1 X105.588 Y116.868 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9069
G1 X104.394 Y116.868 E.03961
G1 X104.394 Y117.302 E.0144
G1 X105.829 Y118.737 E.06732
G1 X105.008 Y118.737 E.02724
G1 X106.872 Y116.868 E.08757
G1 X111.636 Y116.868 E.15803
G1 X113.505 Y118.737 E.08769
G1 X112.678 Y118.737 E.02742
G1 X114.548 Y116.868 E.08769
G1 X119.312 Y116.868 E.15803
G1 X121.181 Y118.737 E.08769
G1 X120.354 Y118.737 E.02742
G1 X122.224 Y116.868 E.08769
G1 X126.988 Y116.868 E.15803
G1 X128.857 Y118.737 E.08769
G1 X128.03 Y118.737 E.02742
G1 X129.9 Y116.868 E.08769
G1 X133.846 Y116.882 E.13092
G3 X134.864 Y117.068 I-.219 J4.074 E.0344
G1 X136.533 Y118.737 E.07831
G1 X135.706 Y118.737 E.02742
G1 X136.448 Y117.996 E.03478
G1 X137.336 Y118.737 E.03838
G1 X136.865 Y118.737 E.01563
G1 X138.567 Y119.056 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.493222
G1 F9069
G1 X148.42 Y119.056 E.36153
G1 X149.08 Y119.031 E.02422
; LINE_WIDTH: 0.420898
G1 X149.739 Y119.006 E.02033
; LINE_WIDTH: 0.37165
G1 X150.399 Y118.981 E.01768
; LINE_WIDTH: 0.322401
G1 X151.059 Y118.956 E.01503
; LINE_WIDTH: 0.273153
G1 X151.718 Y118.931 E.01239
; LINE_WIDTH: 0.223905
G1 X152.378 Y118.906 E.00974
; LINE_WIDTH: 0.174656
G1 X153.038 Y118.881 E.00709
; CHANGE_LAYER
; Z_HEIGHT: 9.6
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F15000
G1 X152.378 Y118.906 E-.76
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 48/101
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L48
M991 S0 P47 ;notify layer change
G17
G3 Z9.8 I-.336 J-1.17 P1  F30000
G1 X104.842 Y132.549 Z9.8
G1 Z9.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9044
G1 X104.842 Y132.941 E.01301
G1 X138.282 Y132.941 E1.10927
G1 X136.462 Y134.464 E.07873
G3 X133.616 Y135.497 I-2.839 J-3.384 E.1025
G1 X104.046 Y135.497 E.9809
G1 X104.046 Y129.528 E.19802
G1 X104.842 Y129.528 E.0264
G1 X104.842 Y132.489 E.09823
G1 X105.234 Y132.549 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9044
G1 X148.436 Y132.549 E1.32748
G1 X153.234 Y132.911 E.14785
G1 X153.234 Y133.381 E.01443
G1 X138.367 Y133.381 E.4568
G1 X136.704 Y134.772 E.06663
G3 X133.627 Y135.889 I-3.075 J-3.673 E.10265
G1 X103.654 Y135.889 E.92101
G1 X103.654 Y129.136 E.20752
G1 X105.234 Y129.136 E.04855
G1 X105.234 Y132.489 E.10304
M204 S10000
; WIPE_START
G1 F12000
G1 X107.234 Y132.492 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X104.444 Y133.145 Z10 F30000
G1 Z9.6
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.431684
G1 F9044
G1 X104.444 Y129.731 E.10813
G1 X105.571 Y135.149 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9044
G1 X104.394 Y135.149 E.03905
G1 X104.394 Y134.698 E.01497
G1 X105.802 Y133.289 E.06607
G1 X105.029 Y133.289 E.02564
G1 X106.889 Y135.149 E.08723
G1 X111.619 Y135.149 E.1569
G1 X113.478 Y133.289 E.08723
G1 X112.705 Y133.289 E.02564
G1 X114.565 Y135.149 E.08723
G1 X119.295 Y135.149 E.1569
G1 X121.154 Y133.289 E.08723
G1 X120.381 Y133.289 E.02564
G1 X122.241 Y135.149 E.08723
G1 X126.971 Y135.149 E.1569
G1 X128.83 Y133.289 E.08723
G1 X128.057 Y133.289 E.02564
G1 X129.917 Y135.149 E.08723
G1 X133.606 Y135.149 E.12238
G2 X134.84 Y134.956 I-.052 J-4.378 E.04156
G1 X136.506 Y133.289 E.07819
G1 X135.733 Y133.289 E.02564
G1 X136.457 Y134.014 E.03397
G1 X137.323 Y133.289 E.03743
G1 X136.823 Y133.289 E.01658
G1 X138.559 Y132.965 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.480969
G1 F9044
G1 X148.42 Y132.965 E.352
G1 X149.08 Y132.99 E.02356
; LINE_WIDTH: 0.408721
G1 X149.739 Y133.015 E.01968
; LINE_WIDTH: 0.359527
G1 X150.399 Y133.039 E.01703
; LINE_WIDTH: 0.310333
G1 X151.059 Y133.064 E.01438
; LINE_WIDTH: 0.261139
G1 X151.718 Y133.089 E.01174
; LINE_WIDTH: 0.211945
G1 X152.378 Y133.114 E.00909
; LINE_WIDTH: 0.162751
G1 X153.038 Y133.139 E.00645
; WIPE_START
G1 F15000
G1 X152.378 Y133.114 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X145.059 Y130.95 Z10 F30000
G1 X104.842 Y119.059 Z10
G1 Z9.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9044
G1 X104.842 Y122.472 E.11323
G1 X104.046 Y122.472 E.0264
G1 X104.046 Y116.503 E.19802
G1 X133.731 Y116.51 E.98471
G3 X136.462 Y117.536 I-.091 J4.387 E.09865
G1 X138.282 Y119.059 E.07873
G1 X104.902 Y119.059 E1.10728
G1 X105.234 Y119.451 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9044
G1 X105.234 Y122.864 E.10488
G1 X103.654 Y122.864 E.04855
G1 X103.654 Y116.111 E.20752
G1 X133.754 Y116.118 E.92489
G3 X136.704 Y117.228 I-.106 J4.758 E.09873
G1 X138.367 Y118.619 E.06663
G1 X153.234 Y118.619 E.4568
G1 X153.234 Y119.089 E.01443
G1 X148.436 Y119.451 E.14785
G1 X105.294 Y119.451 E1.32564
M204 S10000
; WIPE_START
G1 F12000
G1 X105.259 Y121.451 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X104.444 Y118.855 Z10 F30000
G1 Z9.6
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.431684
G1 F9044
G1 X104.444 Y122.269 E.10813
; WIPE_START
G1 F15000
G1 X104.444 Y120.269 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X112.067 Y119.902 Z10 F30000
G1 X136.823 Y118.711 Z10
G1 Z9.6
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9044
G1 X137.323 Y118.711 E.01658
G1 X136.457 Y117.986 E.03743
G1 X135.733 Y118.711 E.03397
G1 X136.506 Y118.711 E.02564
G1 X134.84 Y117.044 E.07819
G2 X133.721 Y116.858 I-1.239 J3.992 E.03774
G1 X129.911 Y116.857 E.12638
G1 X128.057 Y118.711 E.08696
G1 X128.83 Y118.711 E.02564
G1 X126.976 Y116.856 E.08699
G1 X122.237 Y116.855 E.15721
G1 X120.381 Y118.711 E.08704
G1 X121.154 Y118.711 E.02564
G1 X119.298 Y116.855 E.08707
G1 X114.562 Y116.853 E.1571
G1 X112.705 Y118.711 E.08712
G1 X113.478 Y118.711 E.02564
G1 X111.621 Y116.853 E.08715
G1 X106.888 Y116.852 E.15698
G1 X105.029 Y118.711 E.0872
G1 X105.802 Y118.711 E.02564
G1 X104.394 Y117.302 E.06607
G1 X104.394 Y116.851 E.01496
G1 X105.571 Y116.851 E.03905
G1 X138.559 Y119.035 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.480969
G1 F9044
G1 X148.42 Y119.035 E.352
G1 X149.08 Y119.01 E.02356
; LINE_WIDTH: 0.408722
G1 X149.739 Y118.985 E.01968
; LINE_WIDTH: 0.359528
G1 X150.399 Y118.961 E.01703
; LINE_WIDTH: 0.310334
G1 X151.059 Y118.936 E.01438
; LINE_WIDTH: 0.26114
G1 X151.718 Y118.911 E.01174
; LINE_WIDTH: 0.211947
G1 X152.378 Y118.886 E.00909
; LINE_WIDTH: 0.162753
G1 X153.038 Y118.861 E.00645
; CHANGE_LAYER
; Z_HEIGHT: 9.8
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F15000
G1 X152.378 Y118.886 E-.76
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 49/101
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L49
M991 S0 P48 ;notify layer change
G17
G3 Z10 I-.348 J-1.166 P1  F30000
G1 X105.234 Y132.959 Z10
G1 Z9.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9025
G1 X138.277 Y132.959 E1.09612
G1 X136.462 Y134.482 E.07862
G3 X133.616 Y135.514 I-2.843 J-3.4 E.10247
G1 X104.046 Y135.514 E.9809
G1 X104.046 Y129.567 E.19728
G1 X104.842 Y129.567 E.0264
G1 X104.842 Y132.959 E.11253
G1 X105.174 Y132.959 E.01102
G1 X105.234 Y132.567 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9025
G1 X148.436 Y132.567 E1.32748
G1 X153.234 Y132.927 E.14784
G1 X153.234 Y133.395 E.01438
G1 X138.367 Y133.395 E.4568
G1 X136.704 Y134.79 E.06669
G3 X133.627 Y135.906 I-3.079 J-3.69 E.10262
G1 X103.654 Y135.906 E.92101
G1 X103.654 Y129.175 E.20684
G1 X105.234 Y129.175 E.04855
G1 X105.234 Y132.507 E.1024
M204 S10000
; WIPE_START
G1 F12000
G1 X107.234 Y132.51 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X104.444 Y133.163 Z10.2 F30000
G1 Z9.8
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.431684
G1 F9025
G1 X104.444 Y129.77 E.10747
; WIPE_START
G1 F15000
G1 X104.444 Y131.77 E-.76
; WIPE_END
G1 E-.04 F1800
M73 P67 R6
G1 X112.068 Y132.132 Z10.2 F30000
G1 X136.806 Y133.307 Z10.2
G1 Z9.8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9025
G1 X137.32 Y133.307 E.01706
G1 X136.467 Y134.023 E.03695
G1 X135.751 Y133.307 E.03358
G1 X136.488 Y133.307 E.02446
G1 X134.815 Y134.98 E.07849
G3 X133.606 Y135.166 I-1.259 J-4.183 E.04072
G1 X129.933 Y135.166 E.12183
G1 X128.075 Y133.307 E.08718
G1 X128.812 Y133.307 E.02446
G1 X126.954 Y135.166 E.08718
G1 X122.257 Y135.166 E.1558
G1 X120.399 Y133.307 E.08718
G1 X121.136 Y133.307 E.02446
G1 X119.278 Y135.166 E.08718
G1 X114.581 Y135.166 E.1558
G1 X112.723 Y133.307 E.08718
G1 X113.461 Y133.307 E.02446
G1 X111.602 Y135.166 E.08718
G1 X106.905 Y135.166 E.1558
G1 X105.047 Y133.307 E.08718
G1 X105.785 Y133.307 E.02446
G1 X104.394 Y134.698 E.06523
G1 X104.394 Y135.166 E.01552
G1 X105.555 Y135.166 E.0385
G1 X138.556 Y132.981 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.477691
G1 F9025
G1 X148.42 Y132.981 E.34947
G1 X149.08 Y133.006 E.02339
; LINE_WIDTH: 0.405791
G1 X149.74 Y133.031 E.01952
; LINE_WIDTH: 0.356833
G1 X150.399 Y133.055 E.01688
; LINE_WIDTH: 0.307875
G1 X151.059 Y133.08 E.01425
; LINE_WIDTH: 0.258917
G1 X151.718 Y133.105 E.01162
; LINE_WIDTH: 0.209959
G1 X152.378 Y133.129 E.00898
; LINE_WIDTH: 0.161001
G1 X153.038 Y133.154 E.00635
; WIPE_START
G1 F15000
G1 X152.378 Y133.129 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X145.06 Y130.961 Z10.2 F30000
G1 X104.842 Y119.041 Z10.2
G1 Z9.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9025
G1 X104.842 Y122.433 E.11253
G1 X104.046 Y122.433 E.0264
G1 X104.046 Y116.486 E.19728
G1 X133.616 Y116.486 E.9809
G1 X134.139 Y116.517 E.01739
G3 X136.462 Y117.518 I-.582 J4.542 E.08499
G1 X138.277 Y119.041 E.07862
G1 X104.902 Y119.041 E1.10713
G1 X105.234 Y119.433 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9025
G1 X105.234 Y122.825 E.10424
G1 X103.654 Y122.825 E.04855
G1 X103.654 Y116.094 E.20684
G1 X133.627 Y116.094 E.92101
G1 X134.185 Y116.126 E.01715
G3 X136.704 Y117.21 I-.632 J4.941 E.08538
G1 X138.367 Y118.605 E.06669
G1 X153.234 Y118.605 E.4568
G1 X153.234 Y119.073 E.01438
G1 X148.436 Y119.433 E.14784
G1 X105.294 Y119.433 E1.32564
M204 S10000
; WIPE_START
G1 F12000
G1 X105.258 Y121.433 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X104.444 Y118.837 Z10.2 F30000
G1 Z9.8
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.431684
G1 F9025
G1 X104.444 Y122.23 E.10747
G1 X105.555 Y116.834 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9025
G1 X104.394 Y116.834 E.0385
G1 X104.394 Y117.302 E.01552
G1 X105.785 Y118.693 E.06523
G1 X105.047 Y118.693 E.02446
G1 X106.905 Y116.834 E.08718
G1 X111.602 Y116.834 E.1558
G1 X113.461 Y118.693 E.08718
G1 X112.723 Y118.693 E.02446
G1 X114.581 Y116.834 E.08718
G1 X119.278 Y116.834 E.1558
G1 X121.136 Y118.693 E.08718
G1 X120.399 Y118.693 E.02446
G1 X122.257 Y116.834 E.08718
G1 X126.954 Y116.834 E.1558
G1 X128.812 Y118.693 E.08718
G1 X128.075 Y118.693 E.02446
G1 X129.933 Y116.834 E.08718
G1 X133.606 Y116.834 E.12183
G3 X134.815 Y117.02 I-.052 J4.382 E.04071
G1 X136.488 Y118.693 E.07849
G1 X135.751 Y118.693 E.02446
G1 X136.467 Y117.977 E.03358
G1 X137.32 Y118.693 E.03695
G1 X136.806 Y118.693 E.01707
G1 X138.556 Y119.019 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.477693
G1 F9025
G1 X148.42 Y119.019 E.34947
G1 X149.08 Y118.994 E.02339
; LINE_WIDTH: 0.405789
G1 X149.74 Y118.969 E.01952
; LINE_WIDTH: 0.356832
G1 X150.399 Y118.945 E.01688
; LINE_WIDTH: 0.307874
G1 X151.059 Y118.92 E.01425
; LINE_WIDTH: 0.258916
G1 X151.718 Y118.895 E.01162
; LINE_WIDTH: 0.209958
G1 X152.378 Y118.871 E.00898
; LINE_WIDTH: 0.161
G1 X153.038 Y118.846 E.00635
; CHANGE_LAYER
; Z_HEIGHT: 10
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F15000
G1 X152.378 Y118.871 E-.76
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 50/101
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L50
M991 S0 P49 ;notify layer change
G17
G3 Z10.2 I-.349 J-1.166 P1  F30000
G1 X105.234 Y132.964 Z10.2
G1 Z10
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9018
G1 X138.291 Y132.964 E1.09655
G1 X136.462 Y134.483 E.07884
G3 X133.616 Y135.514 I-2.839 J-3.396 E.10249
G1 X104.046 Y135.514 E.9809
G1 X104.046 Y129.587 E.19661
G1 X104.842 Y129.587 E.0264
G1 X104.842 Y132.964 E.11204
G1 X105.174 Y132.964 E.01102
G1 X105.234 Y132.572 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9018
G1 X148.436 Y132.572 E1.32748
G1 X153.234 Y132.932 E.14784
G1 X153.234 Y133.41 E.01467
G1 X138.368 Y133.41 E.45679
G1 X136.705 Y134.792 E.06645
G3 X133.627 Y135.906 I-3.075 J-3.686 E.10262
G1 X103.654 Y135.906 E.92101
G1 X103.654 Y129.195 E.20621
G1 X105.234 Y129.195 E.04855
G1 X105.234 Y132.512 E.10194
M204 S10000
; WIPE_START
G1 F12000
G1 X107.234 Y132.515 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X104.444 Y133.168 Z10.4 F30000
G1 Z10
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.431684
G1 F9018
G1 X104.444 Y129.79 E.107
G1 X105.555 Y135.166 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9018
G1 X104.394 Y135.166 E.0385
G1 X104.394 Y134.698 E.01552
G1 X105.779 Y133.313 E.06498
G1 X105.052 Y133.313 E.02411
G1 X106.905 Y135.166 E.08693
G1 X111.602 Y135.166 E.1558
G1 X113.455 Y133.313 E.08693
G1 X112.728 Y133.313 E.02411
G1 X114.581 Y135.166 E.08693
G1 X119.278 Y135.166 E.1558
G1 X121.131 Y133.313 E.08693
G1 X120.404 Y133.313 E.02411
G1 X122.257 Y135.166 E.08693
G1 X126.954 Y135.166 E.1558
G1 X128.807 Y133.313 E.08693
G1 X128.08 Y133.313 E.02411
G1 X129.933 Y135.166 E.08693
G1 X133.606 Y135.166 E.12183
G2 X134.815 Y134.981 I-.052 J-4.388 E.04069
G1 X136.483 Y133.313 E.07827
G1 X135.756 Y133.313 E.02411
G1 X136.469 Y134.025 E.03343
G1 X137.327 Y133.313 E.03699
G1 X136.813 Y133.313 E.01703
G1 X138.565 Y132.991 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.486892
G1 F9018
G1 X148.42 Y132.991 E.35654
G1 X149.08 Y133.016 E.02388
; LINE_WIDTH: 0.415098
G1 X149.739 Y133.04 E.02002
; LINE_WIDTH: 0.366213
G1 X150.399 Y133.065 E.01739
; LINE_WIDTH: 0.317327
G1 X151.059 Y133.09 E.01476
; LINE_WIDTH: 0.268442
G1 X151.718 Y133.115 E.01213
; LINE_WIDTH: 0.219556
G1 X152.378 Y133.139 E.0095
; LINE_WIDTH: 0.170671
G1 X153.038 Y133.164 E.00687
; WIPE_START
G1 F15000
G1 X152.378 Y133.139 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X145.061 Y130.968 Z10.4 F30000
G1 X104.842 Y119.036 Z10.4
G1 Z10
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9018
G1 X104.842 Y122.413 E.11204
G1 X104.046 Y122.413 E.0264
G1 X104.046 Y116.486 E.19661
G1 X133.616 Y116.486 E.9809
G1 X134.039 Y116.511 E.01407
G1 X134.142 Y116.517 E.00339
G3 X136.462 Y117.517 I-.581 J4.541 E.08494
G1 X138.291 Y119.036 E.07884
G1 X104.902 Y119.036 E1.10757
G1 X105.234 Y119.428 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9018
G1 X105.234 Y122.805 E.10378
G1 X103.654 Y122.805 E.04855
G1 X103.654 Y116.094 E.20621
G1 X133.627 Y116.094 E.92101
G1 X134.062 Y116.119 E.01338
G1 X134.187 Y116.127 E.00384
G3 X136.705 Y117.208 I-.631 J4.939 E.0853
G1 X138.368 Y118.59 E.06645
G1 X153.234 Y118.59 E.45679
G1 X153.234 Y119.068 E.01467
G1 X148.436 Y119.428 E.14784
G1 X105.294 Y119.428 E1.32564
M204 S10000
; WIPE_START
G1 F12000
G1 X105.258 Y121.427 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X104.444 Y118.832 Z10.4 F30000
G1 Z10
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.431684
G1 F9018
G1 X104.444 Y122.21 E.107
; WIPE_START
G1 F15000
G1 X104.444 Y120.21 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X112.068 Y119.851 Z10.4 F30000
G1 X136.813 Y118.687 Z10.4
G1 Z10
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9018
G1 X137.326 Y118.687 E.01703
G1 X136.469 Y117.975 E.03699
G1 X135.756 Y118.687 E.03343
G1 X136.483 Y118.687 E.02411
G1 X134.815 Y117.019 E.07827
G2 X133.606 Y116.834 I-1.367 J4.902 E.04066
G1 X129.933 Y116.834 E.12183
G1 X128.08 Y118.687 E.08693
G1 X128.807 Y118.687 E.02411
G1 X126.954 Y116.834 E.08693
G1 X122.257 Y116.834 E.1558
G1 X120.404 Y118.687 E.08693
G1 X121.131 Y118.687 E.02411
G1 X119.278 Y116.834 E.08693
G1 X114.581 Y116.834 E.1558
G1 X112.728 Y118.687 E.08693
G1 X113.455 Y118.687 E.02411
G1 X111.602 Y116.834 E.08693
G1 X106.905 Y116.834 E.1558
G1 X105.052 Y118.687 E.08693
G1 X105.779 Y118.687 E.02411
G1 X104.394 Y117.302 E.06498
G1 X104.394 Y116.834 E.01552
G1 X105.555 Y116.834 E.0385
G1 X138.565 Y119.009 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.486892
G1 F9018
G1 X148.42 Y119.009 E.35654
G1 X149.08 Y118.984 E.02388
; LINE_WIDTH: 0.415098
G1 X149.739 Y118.96 E.02002
; LINE_WIDTH: 0.366212
G1 X150.399 Y118.935 E.01739
; LINE_WIDTH: 0.317327
G1 X151.059 Y118.91 E.01476
; LINE_WIDTH: 0.268441
G1 X151.718 Y118.885 E.01213
; LINE_WIDTH: 0.219556
G1 X152.378 Y118.861 E.0095
; LINE_WIDTH: 0.17067
G1 X153.038 Y118.836 E.00687
; CHANGE_LAYER
; Z_HEIGHT: 10.2
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F15000
G1 X152.378 Y118.861 E-.76
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 51/101
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L51
M991 S0 P50 ;notify layer change
G17
G3 Z10.4 I-.337 J-1.169 P1  F30000
G1 X104.842 Y132.578 Z10.4
G1 Z10.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9015
G1 X104.842 Y132.97 E.01301
G1 X138.283 Y132.97 E1.10931
G1 X136.462 Y134.483 E.07854
G3 X133.616 Y135.514 I-2.839 J-3.396 E.10248
G1 X104.046 Y135.514 E.9809
G1 X104.046 Y129.595 E.19635
G1 X104.842 Y129.595 E.0264
G1 X104.842 Y132.518 E.09696
G1 X105.234 Y132.578 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9015
G1 X148.436 Y132.578 E1.32748
G1 X153.234 Y132.937 E.14784
G1 X153.234 Y133.409 E.01449
G1 X138.368 Y133.409 E.45679
G1 X136.705 Y134.792 E.06646
G3 X133.627 Y135.906 I-3.075 J-3.686 E.10262
G1 X103.654 Y135.906 E.92101
G1 X103.654 Y129.202 E.20598
G1 X105.234 Y129.202 E.04855
G1 X105.234 Y132.518 E.10186
M204 S10000
; WIPE_START
G1 F12000
G1 X107.234 Y132.52 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X104.444 Y133.173 Z10.6 F30000
G1 Z10.2
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.431684
G1 F9015
G1 X104.444 Y129.798 E.10692
; WIPE_START
G1 F15000
G1 X104.444 Y131.798 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X112.068 Y132.156 Z10.6 F30000
G1 X136.797 Y133.318 Z10.6
G1 Z10.2
M73 P68 R6
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9015
G1 X137.319 Y133.318 E.01732
G1 X136.469 Y134.025 E.03669
G1 X135.762 Y133.318 E.03318
G1 X136.478 Y133.318 E.02376
G1 X134.815 Y134.981 E.07802
G3 X133.606 Y135.166 I-1.26 J-4.203 E.04069
G1 X129.933 Y135.166 E.12183
G1 X128.086 Y133.318 E.08668
G1 X128.802 Y133.318 E.02376
G1 X126.954 Y135.166 E.08668
G1 X122.257 Y135.166 E.1558
G1 X120.41 Y133.318 E.08668
G1 X121.126 Y133.318 E.02376
G1 X119.278 Y135.166 E.08668
G1 X114.581 Y135.166 E.1558
G1 X112.734 Y133.318 E.08668
G1 X113.45 Y133.318 E.02376
G1 X111.602 Y135.166 E.08668
G1 X106.905 Y135.166 E.1558
G1 X105.058 Y133.318 E.08668
G1 X105.774 Y133.318 E.02376
G1 X104.394 Y134.698 E.06473
G1 X104.394 Y135.166 E.01552
G1 X105.555 Y135.166 E.0385
G1 X138.561 Y132.993 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.480676
G1 F9015
G1 X148.42 Y132.993 E.35169
G1 X149.08 Y133.018 E.02355
; LINE_WIDTH: 0.408868
G1 X149.74 Y133.043 E.01968
; LINE_WIDTH: 0.359973
G1 X150.399 Y133.067 E.01705
; LINE_WIDTH: 0.311078
G1 X151.059 Y133.092 E.01442
; LINE_WIDTH: 0.262183
G1 X151.718 Y133.117 E.01179
; LINE_WIDTH: 0.213289
G1 X152.378 Y133.141 E.00916
; LINE_WIDTH: 0.164394
G1 X153.038 Y133.166 E.00653
; WIPE_START
G1 F15000
G1 X152.378 Y133.141 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X145.061 Y130.969 Z10.6 F30000
G1 X104.842 Y119.03 Z10.6
G1 Z10.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9015
G1 X104.842 Y122.405 E.11196
G1 X104.046 Y122.405 E.0264
G1 X104.046 Y116.486 E.19635
G1 X133.616 Y116.486 E.9809
G1 X133.905 Y116.503 E.00959
G3 X136.462 Y117.517 I-.247 J4.355 E.09285
G1 X138.283 Y119.03 E.07854
G1 X104.902 Y119.03 E1.10732
G1 X105.234 Y119.422 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9015
G1 X105.234 Y122.798 E.10371
G1 X103.654 Y122.798 E.04855
G1 X103.654 Y116.094 E.20598
G1 X133.627 Y116.094 E.92101
G1 X133.927 Y116.111 E.00924
G3 X136.705 Y117.208 I-.261 J4.725 E.09334
G1 X138.368 Y118.591 E.06646
G1 X153.234 Y118.591 E.45679
G1 X153.234 Y119.063 E.01449
G1 X148.436 Y119.422 E.14784
G1 X105.294 Y119.422 E1.32564
M204 S10000
; WIPE_START
G1 F12000
G1 X105.258 Y121.422 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X104.444 Y118.827 Z10.6 F30000
G1 Z10.2
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.431684
G1 F9015
G1 X104.444 Y122.202 E.10692
G1 X105.555 Y116.834 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9015
G1 X104.394 Y116.834 E.0385
G1 X104.394 Y117.302 E.01552
G1 X105.774 Y118.682 E.06473
G1 X105.058 Y118.682 E.02376
G1 X106.905 Y116.834 E.08668
G1 X111.602 Y116.834 E.1558
G1 X113.45 Y118.682 E.08668
G1 X112.734 Y118.682 E.02376
G1 X114.581 Y116.834 E.08668
G1 X119.278 Y116.834 E.1558
G1 X121.126 Y118.682 E.08668
G1 X120.41 Y118.682 E.02376
G1 X122.257 Y116.834 E.08668
G1 X126.954 Y116.834 E.1558
G1 X128.802 Y118.682 E.08668
G1 X128.086 Y118.682 E.02376
G1 X129.933 Y116.834 E.08668
G1 X133.885 Y116.851 E.13108
G3 X134.815 Y117.019 I-.253 J4.047 E.03142
G1 X136.478 Y118.682 E.07802
G1 X135.762 Y118.682 E.02375
G1 X136.469 Y117.975 E.03318
G1 X137.319 Y118.682 E.03669
G1 X136.797 Y118.682 E.01732
G1 X138.561 Y119.007 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.480676
G1 F9015
G1 X148.42 Y119.007 E.35169
G1 X149.08 Y118.982 E.02355
; LINE_WIDTH: 0.408868
G1 X149.74 Y118.957 E.01968
; LINE_WIDTH: 0.359973
G1 X150.399 Y118.933 E.01705
; LINE_WIDTH: 0.311078
G1 X151.059 Y118.908 E.01442
; LINE_WIDTH: 0.262184
G1 X151.718 Y118.883 E.01179
; LINE_WIDTH: 0.213289
G1 X152.378 Y118.859 E.00916
; LINE_WIDTH: 0.164394
G1 X153.038 Y118.834 E.00653
; CHANGE_LAYER
; Z_HEIGHT: 10.4
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F15000
G1 X152.378 Y118.859 E-.76
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 52/101
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L52
M991 S0 P51 ;notify layer change
G17
G3 Z10.6 I-.349 J-1.166 P1  F30000
G1 X105.234 Y132.974 Z10.6
G1 Z10.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9007
G1 X138.27 Y132.974 E1.09586
G3 X136.039 Y134.797 I-26.944 J-30.699 E.09557
G3 X133.616 Y135.514 I-2.463 J-3.871 E.08492
G1 X104.046 Y135.514 E.9809
G1 X104.046 Y129.593 E.19641
G1 X104.842 Y129.593 E.0264
G1 X104.842 Y132.974 E.11217
G1 X105.174 Y132.974 E.01102
G1 X105.234 Y132.582 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9007
G1 X148.436 Y132.582 E1.32748
G1 X153.234 Y132.942 E.14784
G1 X153.234 Y133.404 E.01418
G1 X138.367 Y133.404 E.4568
G3 X136.254 Y135.126 I-25.117 J-28.672 E.08378
G3 X133.627 Y135.906 I-2.679 J-4.209 E.08529
G1 X103.654 Y135.906 E.92101
G1 X103.654 Y129.201 E.20603
G1 X105.234 Y129.201 E.04855
G1 X105.234 Y132.522 E.10206
M204 S10000
; WIPE_START
G1 F12000
G1 X107.234 Y132.525 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X104.444 Y133.178 Z10.8 F30000
G1 Z10.4
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.431684
G1 F9007
G1 X104.444 Y129.796 E.10712
G1 X105.555 Y135.166 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9007
G1 X104.394 Y135.166 E.0385
G1 X104.394 Y134.698 E.01552
G1 X105.769 Y133.323 E.06451
G1 X105.063 Y133.323 E.02344
G1 X106.905 Y135.166 E.08645
G1 X111.602 Y135.166 E.1558
G1 X113.445 Y133.323 E.08645
G1 X112.738 Y133.323 E.02344
G1 X114.581 Y135.166 E.08645
G1 X119.278 Y135.166 E.1558
G1 X121.121 Y133.323 E.08645
G1 X120.414 Y133.323 E.02344
G1 X122.257 Y135.166 E.08645
G1 X126.954 Y135.166 E.1558
G1 X128.797 Y133.323 E.08645
G1 X128.09 Y133.323 E.02344
G1 X129.933 Y135.166 E.08645
G1 X133.606 Y135.166 E.12183
G2 X134.815 Y134.981 I-.051 J-4.388 E.04069
G1 X136.473 Y133.323 E.0778
G1 X135.766 Y133.323 E.02344
G1 X136.468 Y134.025 E.03293
G1 X137.309 Y133.323 E.03634
G1 X136.776 Y133.323 E.01768
G1 X138.553 Y132.993 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.47108
G1 F9007
G1 X148.42 Y132.993 E.34429
G1 X149.08 Y133.018 E.02303
; LINE_WIDTH: 0.399141
G1 X149.74 Y133.043 E.01916
; LINE_WIDTH: 0.350159
G1 X150.399 Y133.067 E.01653
; LINE_WIDTH: 0.301177
G1 X151.059 Y133.092 E.01389
; LINE_WIDTH: 0.252195
G1 X151.719 Y133.117 E.01126
; LINE_WIDTH: 0.203213
G1 X152.378 Y133.142 E.00862
; LINE_WIDTH: 0.154231
G1 X153.038 Y133.166 E.00599
; WIPE_START
G1 F15000
G1 X152.378 Y133.142 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X145.061 Y130.969 Z10.8 F30000
G1 X104.842 Y119.026 Z10.8
G1 Z10.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9007
G1 X104.842 Y122.407 E.11217
G1 X104.046 Y122.407 E.0264
G1 X104.046 Y116.486 E.19641
G1 X133.77 Y116.495 E.98601
G3 X136.463 Y117.517 I-.12 J4.374 E.09735
G3 X138.27 Y119.026 I-144.207 J174.552 E.07809
G1 X104.902 Y119.026 E1.10688
G1 X105.234 Y119.418 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9007
G1 X105.234 Y122.799 E.1039
G1 X103.654 Y122.799 E.04855
G1 X103.654 Y116.094 E.20603
G1 X133.793 Y116.104 E.92609
G3 X136.705 Y117.208 I-.134 J4.744 E.0975
G3 X138.367 Y118.596 I-132.648 J160.619 E.06654
G1 X153.234 Y118.596 E.4568
G1 X153.234 Y119.058 E.01418
G1 X148.436 Y119.418 E.14784
G1 X105.294 Y119.418 E1.32564
M204 S10000
; WIPE_START
G1 F12000
G1 X105.258 Y121.417 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X104.444 Y118.822 Z10.8 F30000
G1 Z10.4
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.431684
G1 F9007
G1 X104.444 Y122.204 E.10712
; WIPE_START
G1 F15000
G1 X104.444 Y120.204 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X112.068 Y119.844 Z10.8 F30000
G1 X136.776 Y118.677 Z10.8
G1 Z10.4
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9007
G1 X137.309 Y118.677 E.01768
G1 X136.468 Y117.975 E.03633
G1 X135.766 Y118.677 E.03293
G1 X136.473 Y118.677 E.02344
G1 X134.815 Y117.019 E.0778
G2 X133.76 Y116.843 I-1.2 J3.951 E.03557
G1 X129.926 Y116.842 E.1272
G1 X128.09 Y118.677 E.08609
G1 X128.797 Y118.677 E.02344
G1 X126.961 Y116.841 E.08613
G1 X122.252 Y116.84 E.15621
G1 X120.414 Y118.677 E.0862
G1 X121.121 Y118.677 E.02344
G1 X119.283 Y116.839 E.08624
G1 X114.578 Y116.838 E.15606
G1 X112.738 Y118.677 E.08631
G1 X113.445 Y118.677 E.02344
G1 X111.605 Y116.837 E.08635
G1 X106.905 Y116.835 E.15591
G1 X105.063 Y118.677 E.08641
G1 X105.769 Y118.677 E.02344
G1 X104.394 Y117.302 E.06451
G1 X104.394 Y116.835 E.01551
G1 X105.555 Y116.835 E.0385
G1 X138.553 Y119.007 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.47108
G1 F9007
G1 X148.42 Y119.007 E.34429
G1 X149.08 Y118.982 E.02303
; LINE_WIDTH: 0.399143
G1 X149.74 Y118.957 E.01916
; LINE_WIDTH: 0.350161
G1 X150.399 Y118.933 E.01653
; LINE_WIDTH: 0.301179
G1 X151.059 Y118.908 E.01389
; LINE_WIDTH: 0.252197
G1 X151.719 Y118.883 E.01126
; LINE_WIDTH: 0.203215
G1 X152.378 Y118.858 E.00862
; LINE_WIDTH: 0.154233
G1 X153.038 Y118.834 E.00599
; CHANGE_LAYER
; Z_HEIGHT: 10.6
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F15000
G1 X152.378 Y118.858 E-.76
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 53/101
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L53
M991 S0 P52 ;notify layer change
G17
G3 Z10.8 I-.337 J-1.169 P1  F30000
G1 X104.842 Y132.566 Z10.8
G1 Z10.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9028
G1 X104.842 Y132.958 E.01301
G1 X138.283 Y132.958 E1.10932
G1 X136.462 Y134.484 E.07882
G3 X133.616 Y135.514 I-2.838 J-3.396 E.10245
G1 X104.046 Y135.514 E.9809
G1 X104.046 Y129.57 E.19717
G1 X104.842 Y129.57 E.0264
G1 X104.842 Y132.506 E.09741
G1 X105.234 Y132.566 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9028
G1 X148.436 Y132.566 E1.32748
G1 X153.234 Y132.927 E.14784
G1 X153.234 Y133.399 E.01451
G1 X138.367 Y133.399 E.4568
G1 X136.704 Y134.792 E.06665
G3 X133.627 Y135.906 I-3.074 J-3.686 E.10261
G1 X103.654 Y135.906 E.92101
G1 X103.654 Y129.178 E.20674
G1 X105.234 Y129.178 E.04855
G1 X105.234 Y132.506 E.10228
M204 S10000
; WIPE_START
G1 F12000
G1 X107.234 Y132.509 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X104.444 Y133.162 Z11 F30000
G1 Z10.6
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.431684
G1 F9028
G1 X104.444 Y129.773 E.10735
; WIPE_START
G1 F15000
G1 X104.444 Y131.773 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X112.068 Y132.135 Z11 F30000
G1 X136.814 Y133.307 Z11
G1 Z10.6
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9028
G1 X137.325 Y133.307 E.01694
G1 X136.468 Y134.024 E.03708
G1 X135.75 Y133.307 E.03367
G1 X136.489 Y133.307 E.0245
M73 P69 R6
G1 X134.815 Y134.981 E.07855
G3 X133.606 Y135.166 I-1.26 J-4.203 E.04069
G1 X129.933 Y135.166 E.12183
G1 X128.074 Y133.307 E.0872
G1 X128.813 Y133.307 E.0245
G1 X126.954 Y135.166 E.0872
G1 X122.257 Y135.166 E.1558
G1 X120.398 Y133.307 E.0872
G1 X121.137 Y133.307 E.0245
G1 X119.278 Y135.166 E.0872
G1 X114.581 Y135.166 E.1558
G1 X112.722 Y133.307 E.0872
G1 X113.461 Y133.307 E.0245
G1 X111.602 Y135.166 E.0872
G1 X106.905 Y135.166 E.1558
G1 X105.047 Y133.307 E.0872
G1 X105.785 Y133.307 E.0245
G1 X104.394 Y134.698 E.06526
G1 X104.394 Y135.166 E.01552
G1 X105.555 Y135.166 E.0385
G1 X138.559 Y132.983 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.482253
G1 F9028
G1 X148.42 Y132.983 E.35302
G1 X149.08 Y133.008 E.02363
; LINE_WIDTH: 0.410299
G1 X149.74 Y133.032 E.01976
; LINE_WIDTH: 0.361305
G1 X150.399 Y133.057 E.01713
; LINE_WIDTH: 0.312311
G1 X151.059 Y133.082 E.01449
; LINE_WIDTH: 0.263317
G1 X151.718 Y133.107 E.01186
; LINE_WIDTH: 0.214323
G1 X152.378 Y133.131 E.00922
; LINE_WIDTH: 0.165329
G1 X153.038 Y133.156 E.00658
; WIPE_START
G1 F15000
G1 X152.378 Y133.131 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X145.06 Y130.962 Z11 F30000
G1 X104.842 Y119.042 Z11
G1 Z10.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9028
G1 X104.842 Y122.43 E.1124
G1 X104.046 Y122.43 E.0264
G1 X104.046 Y116.486 E.19717
G1 X133.653 Y116.488 E.98212
G3 X136.462 Y117.516 I-.018 J4.4 E.10123
G1 X138.283 Y119.042 E.07882
G1 X104.902 Y119.042 E1.10733
G1 X105.234 Y119.434 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9028
G1 X105.234 Y122.822 E.10412
G1 X103.654 Y122.822 E.04855
G1 X103.654 Y116.094 E.20674
G1 X133.664 Y116.096 E.92214
G3 X136.704 Y117.208 I-.023 J4.776 E.10147
G1 X138.367 Y118.601 E.06665
G1 X153.234 Y118.601 E.4568
G1 X153.234 Y119.073 E.01451
G1 X148.436 Y119.434 E.14784
G1 X105.294 Y119.434 E1.32564
M204 S10000
; WIPE_START
G1 F12000
G1 X105.258 Y121.433 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X104.444 Y118.838 Z11 F30000
G1 Z10.6
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.431684
G1 F9028
G1 X104.444 Y122.227 E.10735
G1 X105.555 Y116.835 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9028
G1 X104.394 Y116.835 E.0385
G1 X104.394 Y117.302 E.01552
G1 X105.785 Y118.693 E.06526
G1 X105.047 Y118.693 E.0245
G1 X106.905 Y116.835 E.08719
G1 X111.603 Y116.835 E.15583
G1 X113.461 Y118.693 E.08718
G1 X112.722 Y118.693 E.0245
G1 X114.581 Y116.835 E.08717
G1 X119.279 Y116.836 E.15587
G1 X121.137 Y118.693 E.08715
G1 X120.398 Y118.693 E.0245
G1 X122.256 Y116.836 E.08714
G1 X126.956 Y116.836 E.1559
G1 X128.813 Y118.693 E.08713
G1 X128.074 Y118.693 E.0245
G1 X129.931 Y116.836 E.08712
G1 X133.643 Y116.837 E.12311
G3 X134.815 Y117.019 I-.072 J4.316 E.03947
G1 X136.489 Y118.693 E.07855
G1 X135.75 Y118.693 E.0245
G1 X136.468 Y117.976 E.03367
G1 X137.325 Y118.693 E.03708
G1 X136.814 Y118.693 E.01694
G1 X138.559 Y119.017 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.482253
G1 F9028
G1 X148.42 Y119.017 E.35302
G1 X149.08 Y118.992 E.02363
; LINE_WIDTH: 0.410299
G1 X149.74 Y118.968 E.01976
; LINE_WIDTH: 0.361305
G1 X150.399 Y118.943 E.01713
; LINE_WIDTH: 0.312311
G1 X151.059 Y118.918 E.01449
; LINE_WIDTH: 0.263316
G1 X151.718 Y118.893 E.01186
; LINE_WIDTH: 0.214322
G1 X152.378 Y118.869 E.00922
; LINE_WIDTH: 0.165328
G1 X153.038 Y118.844 E.00658
; CHANGE_LAYER
; Z_HEIGHT: 10.8
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F15000
G1 X152.378 Y118.869 E-.76
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 54/101
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L54
M991 S0 P53 ;notify layer change
G17
G3 Z11 I-.348 J-1.166 P1  F30000
G1 X105.234 Y132.942 Z11
G1 Z10.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9039
G1 X138.295 Y132.942 E1.09672
G1 X136.462 Y134.468 E.07911
G3 X133.616 Y135.501 I-2.841 J-3.389 E.10252
G1 X104.046 Y135.501 E.9809
G1 X104.046 Y129.546 E.19755
G1 X104.842 Y129.546 E.0264
G1 X104.842 Y132.942 E.11266
G1 X105.174 Y132.942 E.01102
G1 X105.234 Y132.55 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9039
G1 X148.436 Y132.55 E1.32748
G1 X153.234 Y132.911 E.14784
G1 X153.234 Y133.392 E.01477
G1 X138.368 Y133.392 E.45679
G1 X136.705 Y134.776 E.06649
G3 X133.627 Y135.894 I-3.077 J-3.678 E.10266
G1 X103.654 Y135.894 E.92101
G1 X103.654 Y129.154 E.20708
G1 X105.234 Y129.154 E.04855
G1 X105.234 Y132.49 E.10251
M204 S10000
; WIPE_START
G1 F12000
G1 X107.234 Y132.493 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X104.444 Y133.146 Z11.2 F30000
G1 Z10.8
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.431684
G1 F9039
G1 X104.444 Y129.75 E.10759
G1 X105.567 Y135.153 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9039
G1 X104.394 Y135.153 E.03891
G1 X104.394 Y134.698 E.01511
G1 X105.801 Y133.291 E.06601
G1 X105.031 Y133.291 E.02556
G1 X106.893 Y135.153 E.08738
G1 X111.615 Y135.153 E.15662
G1 X113.477 Y133.291 E.08738
G1 X112.706 Y133.291 E.02556
G1 X114.569 Y135.153 E.08738
G1 X119.291 Y135.153 E.15662
G1 X121.153 Y133.291 E.08738
G1 X120.382 Y133.291 E.02556
G1 X122.245 Y135.153 E.08738
G1 X126.967 Y135.153 E.15662
G1 X128.829 Y133.291 E.08738
G1 X128.058 Y133.291 E.02556
G1 X129.921 Y135.153 E.08738
G1 X133.606 Y135.153 E.12224
G2 X134.833 Y134.962 I-.052 J-4.375 E.04135
G1 X136.505 Y133.291 E.07842
G1 X135.734 Y133.291 E.02556
M73 P69 R5
G1 X136.46 Y134.017 E.03405
G1 X137.332 Y133.291 E.03764
G1 X136.839 Y133.291 E.01637
G1 X138.567 Y132.971 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.491219
G1 F9039
G1 X148.42 Y132.971 E.35993
G1 X149.08 Y132.996 E.02412
; LINE_WIDTH: 0.419232
G1 X149.739 Y133.021 E.02024
; LINE_WIDTH: 0.370215
G1 X150.399 Y133.046 E.01761
; LINE_WIDTH: 0.321197
G1 X151.059 Y133.07 E.01497
; LINE_WIDTH: 0.27218
G1 X151.718 Y133.095 E.01233
; LINE_WIDTH: 0.223163
G1 X152.378 Y133.12 E.0097
; LINE_WIDTH: 0.174145
G1 X153.038 Y133.145 E.00706
; WIPE_START
G1 F15000
G1 X152.378 Y133.12 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X145.059 Y130.955 Z11.2 F30000
G1 X104.842 Y119.058 Z11.2
G1 Z10.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9039
G1 X104.842 Y122.454 E.11266
G1 X104.046 Y122.454 E.0264
G1 X104.046 Y116.499 E.19755
G1 X133.616 Y116.499 E.9809
G1 X134.077 Y116.525 E.01533
G1 X134.141 Y116.529 E.00212
G3 X136.462 Y117.532 I-.585 J4.541 E.08497
G1 X138.295 Y119.058 E.07911
G1 X104.902 Y119.058 E1.10773
G1 X105.234 Y119.45 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9039
G1 X105.234 Y122.846 E.10436
G1 X103.654 Y122.846 E.04855
G1 X103.654 Y116.106 E.20708
G1 X133.627 Y116.106 E.92101
G1 X134.1 Y116.134 E.01455
G1 X134.187 Y116.139 E.00267
G3 X136.705 Y117.224 I-.635 J4.939 E.08534
G1 X138.368 Y118.608 E.06649
G1 X153.234 Y118.608 E.45679
G1 X153.234 Y119.089 E.01477
G1 X148.436 Y119.45 E.14784
G1 X105.294 Y119.45 E1.32564
M204 S10000
; WIPE_START
G1 F12000
G1 X105.258 Y121.449 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X104.444 Y118.854 Z11.2 F30000
G1 Z10.8
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.431684
G1 F9039
G1 X104.444 Y122.25 E.10759
; WIPE_START
G1 F15000
G1 X104.444 Y120.25 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X112.068 Y119.888 Z11.2 F30000
G1 X136.839 Y118.709 Z11.2
G1 Z10.8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9039
G1 X137.332 Y118.709 E.01637
G1 X136.46 Y117.983 E.03764
G1 X135.734 Y118.709 E.03405
G1 X136.505 Y118.709 E.02556
G1 X134.833 Y117.038 E.07842
G2 X133.606 Y116.847 I-1.343 J4.59 E.04133
G1 X129.921 Y116.847 E.12224
G1 X128.058 Y118.709 E.08738
G1 X128.829 Y118.709 E.02556
G1 X126.967 Y116.847 E.08738
G1 X122.245 Y116.847 E.15662
G1 X120.382 Y118.709 E.08738
G1 X121.153 Y118.709 E.02556
G1 X119.291 Y116.847 E.08738
G1 X114.569 Y116.847 E.15662
G1 X112.706 Y118.709 E.08738
G1 X113.477 Y118.709 E.02556
G1 X111.615 Y116.847 E.08738
G1 X106.893 Y116.847 E.15662
G1 X105.031 Y118.709 E.08738
G1 X105.801 Y118.709 E.02556
G1 X104.394 Y117.302 E.06601
G1 X104.394 Y116.847 E.01511
G1 X105.567 Y116.847 E.03891
G1 X138.567 Y119.029 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.491219
G1 F9039
G1 X148.42 Y119.029 E.35993
G1 X149.08 Y119.004 E.02412
; LINE_WIDTH: 0.419232
G1 X149.739 Y118.979 E.02024
; LINE_WIDTH: 0.370215
G1 X150.399 Y118.954 E.01761
; LINE_WIDTH: 0.321197
G1 X151.059 Y118.93 E.01497
; LINE_WIDTH: 0.27218
G1 X151.718 Y118.905 E.01233
; LINE_WIDTH: 0.223162
G1 X152.378 Y118.88 E.0097
; LINE_WIDTH: 0.174145
G1 X153.038 Y118.855 E.00706
; CHANGE_LAYER
; Z_HEIGHT: 11
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F15000
G1 X152.378 Y118.88 E-.76
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 55/101
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L55
M991 S0 P54 ;notify layer change
G17
G3 Z11.2 I-.336 J-1.17 P1  F30000
G1 X104.842 Y132.534 Z11.2
G1 Z11
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9059
G1 X104.842 Y132.926 E.01301
G1 X138.282 Y132.926 E1.10928
G3 X136.462 Y134.45 I-102.935 J-121.103 E.07874
G3 X133.616 Y135.484 I-2.839 J-3.379 E.10253
G1 X104.046 Y135.484 E.9809
G1 X104.046 Y129.491 E.19881
G1 X104.842 Y129.491 E.0264
G1 X104.842 Y132.474 E.09895
G1 X105.234 Y132.534 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9059
G1 X148.436 Y132.534 E1.32748
G1 X153.234 Y132.896 E.14784
G1 X153.234 Y133.368 E.0145
G1 X138.367 Y133.368 E.45682
G3 X136.705 Y134.758 I-93.924 J-110.602 E.0666
G3 X133.627 Y135.876 I-3.075 J-3.669 E.10267
G1 X103.654 Y135.876 E.92101
G1 X103.654 Y129.113 E.20782
G1 X103.654 Y129.099 E.00043
G1 X105.234 Y129.099 E.04855
G1 X105.234 Y129.113 E.00043
G1 X105.234 Y132.474 E.10328
M204 S10000
; WIPE_START
G1 F12000
G1 X107.234 Y132.477 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X104.444 Y133.13 Z11.4 F30000
G1 Z11
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.431684
G1 F9059
G1 X104.444 Y129.695 E.10882
; WIPE_START
G1 F15000
G1 X104.444 Y131.695 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X112.067 Y132.067 Z11.4 F30000
G1 X136.835 Y133.275 Z11.4
G1 Z11
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9059
G1 X137.324 Y133.275 E.01621
G1 X136.45 Y134.006 E.0378
G1 X135.718 Y133.275 E.03432
G1 X136.521 Y133.275 E.02663
G1 X134.858 Y134.938 E.07803
M73 P70 R5
G3 X133.606 Y135.136 I-1.305 J-4.191 E.04219
G1 X129.904 Y135.136 E.1228
G1 X128.042 Y133.275 E.08733
G1 X128.845 Y133.275 E.02663
G1 X126.984 Y135.136 E.08733
G1 X122.228 Y135.136 E.15775
G1 X120.366 Y133.275 E.08733
G1 X121.169 Y133.275 E.02663
G1 X119.308 Y135.136 E.08733
G1 X114.552 Y135.136 E.15775
G1 X112.69 Y133.275 E.08733
G1 X113.493 Y133.275 E.02663
G1 X111.632 Y135.136 E.08733
G1 X106.876 Y135.136 E.15775
G1 X105.015 Y133.275 E.08733
G1 X105.817 Y133.275 E.02663
G1 X104.394 Y134.698 E.06676
G1 X104.394 Y135.136 E.01454
G1 X105.584 Y135.136 E.03947
G1 X138.557 Y132.951 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.482941
G1 F9059
G1 X148.42 Y132.951 E.35367
G1 X149.08 Y132.976 E.02367
; LINE_WIDTH: 0.410782
G1 X149.739 Y133.001 E.01979
; LINE_WIDTH: 0.361649
G1 X150.399 Y133.026 E.01714
; LINE_WIDTH: 0.312515
G1 X151.059 Y133.05 E.0145
; LINE_WIDTH: 0.263382
G1 X151.718 Y133.075 E.01186
; LINE_WIDTH: 0.214249
G1 X152.378 Y133.1 E.00922
; LINE_WIDTH: 0.165115
G1 X153.038 Y133.125 E.00657
; WIPE_START
G1 F15000
G1 X152.378 Y133.1 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X145.058 Y130.94 Z11.4 F30000
G1 X104.842 Y119.074 Z11.4
G1 Z11
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9059
G1 X104.842 Y122.509 E.11395
G1 X104.046 Y122.509 E.0264
G1 X104.046 Y116.516 E.19881
G1 X133.616 Y116.516 E.9809
G1 X133.943 Y116.535 E.01086
G3 X136.462 Y117.55 I-.288 J4.348 E.09163
G3 X138.282 Y119.074 I-101.114 J122.627 E.07874
G1 X104.902 Y119.074 E1.10729
G1 X105.234 Y119.466 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9059
G1 X105.234 Y122.887 E.10512
G1 X105.234 Y122.901 E.00043
G1 X103.654 Y122.901 E.04855
G1 X103.654 Y122.887 E.00043
G1 X103.654 Y116.124 E.20782
G1 X133.627 Y116.124 E.92101
G1 X133.965 Y116.143 E.01041
G3 X136.705 Y117.242 I-.302 J4.717 E.09222
G3 X138.367 Y118.632 I-92.261 J111.993 E.0666
G1 X153.234 Y118.632 E.45682
G1 X153.234 Y119.104 E.0145
G1 X148.436 Y119.466 E.14784
G1 X105.294 Y119.466 E1.32564
M204 S10000
; WIPE_START
G1 F12000
G1 X105.259 Y121.465 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X104.444 Y118.87 Z11.4 F30000
G1 Z11
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.431684
G1 F9059
G1 X104.444 Y122.305 E.10882
G1 X105.584 Y116.864 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9059
G1 X104.394 Y116.864 E.03947
G1 X104.394 Y117.302 E.01454
G1 X105.817 Y118.725 E.06676
G1 X105.015 Y118.725 E.02663
G1 X106.876 Y116.864 E.08733
G1 X111.632 Y116.864 E.15775
G1 X113.493 Y118.725 E.08733
G1 X112.69 Y118.725 E.02663
G1 X114.552 Y116.864 E.08733
G1 X119.308 Y116.864 E.15775
G1 X121.169 Y118.725 E.08733
G1 X120.366 Y118.725 E.02663
G1 X122.228 Y116.864 E.08733
G1 X126.984 Y116.864 E.15775
G1 X128.845 Y118.725 E.08733
G1 X128.042 Y118.725 E.02663
G1 X129.904 Y116.864 E.08733
G1 X133.923 Y116.882 E.13331
G3 X134.858 Y117.062 I-.302 J4.094 E.03166
G1 X136.521 Y118.725 E.07803
G1 X135.718 Y118.725 E.02663
G1 X136.45 Y117.994 E.03432
G1 X137.324 Y118.725 E.0378
G1 X136.835 Y118.725 E.01621
G1 X138.557 Y119.049 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.482941
G1 F9059
G1 X148.42 Y119.049 E.35367
G1 X149.08 Y119.024 E.02367
; LINE_WIDTH: 0.410782
G1 X149.739 Y118.999 E.01979
; LINE_WIDTH: 0.361649
G1 X150.399 Y118.974 E.01714
; LINE_WIDTH: 0.312516
G1 X151.059 Y118.95 E.0145
; LINE_WIDTH: 0.263382
G1 X151.718 Y118.925 E.01186
; LINE_WIDTH: 0.214249
G1 X152.378 Y118.9 E.00922
; LINE_WIDTH: 0.165116
G1 X153.038 Y118.875 E.00657
; CHANGE_LAYER
; Z_HEIGHT: 11.2
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F15000
G1 X152.378 Y118.9 E-.76
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 56/101
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L56
M991 S0 P55 ;notify layer change
G17
G3 Z11.4 I-.335 J-1.17 P1  F30000
G1 X104.842 Y132.504 Z11.4
G1 Z11.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9086
G1 X104.842 Y132.896 E.01301
G1 X138.289 Y132.896 E1.10951
G3 X136.462 Y134.432 I-103.767 J-121.581 E.07918
G3 X133.616 Y135.467 I-2.838 J-3.375 E.10253
G1 X104.046 Y135.467 E.9809
G1 X104.046 Y129.436 E.20006
G1 X104.842 Y129.436 E.0264
G1 X104.842 Y132.444 E.09978
G1 X105.234 Y132.504 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9086
G1 X148.436 Y132.504 E1.32748
G1 X153.234 Y132.869 E.14785
G1 X153.234 Y133.344 E.01458
G1 X138.367 Y133.344 E.45682
G3 X136.254 Y135.077 I-23.753 J-26.81 E.084
G3 X133.627 Y135.859 I-2.68 J-4.193 E.08531
G1 X103.654 Y135.859 E.92101
G1 X103.654 Y129.058 E.20899
G1 X103.654 Y129.044 E.00043
G1 X105.234 Y129.044 E.04855
G1 X105.234 Y129.058 E.00043
G1 X105.234 Y132.444 E.10405
M204 S10000
; WIPE_START
G1 F12000
G1 X107.234 Y132.447 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X104.444 Y133.1 Z11.6 F30000
G1 Z11.2
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.431684
G1 F9086
G1 X104.444 Y129.64 E.10961
G1 X105.601 Y135.119 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9086
G1 X104.394 Y135.119 E.04004
G1 X104.394 Y134.698 E.01398
G1 X105.847 Y133.245 E.06817
G1 X105.008 Y133.245 E.02784
G1 X106.859 Y135.119 E.08739
G1 X111.649 Y135.119 E.15888
G1 X113.523 Y133.245 E.08794
G1 X112.66 Y133.245 E.02862
G1 X114.535 Y135.119 E.08794
G1 X119.325 Y135.119 E.15888
G1 X121.199 Y133.245 E.08794
G1 X120.336 Y133.245 E.02862
G1 X122.211 Y135.119 E.08794
G1 X127.001 Y135.119 E.15888
G1 X128.875 Y133.245 E.08794
G1 X128.012 Y133.245 E.02862
G1 X129.887 Y135.119 E.08794
G1 X133.606 Y135.119 E.12337
G2 X134.882 Y134.914 I-.055 J-4.408 E.04303
G1 X136.551 Y133.245 E.0783
G1 X135.688 Y133.245 E.02862
G1 X136.44 Y133.996 E.03525
G1 X137.333 Y133.245 E.03873
G1 X136.873 Y133.245 E.01528
G1 X138.56 Y132.924 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.488636
G1 F9086
G1 X148.42 Y132.924 E.35811
G1 X149.08 Y132.949 E.02398
; LINE_WIDTH: 0.415894
G1 X149.739 Y132.974 E.02006
; LINE_WIDTH: 0.366363
G1 X150.399 Y132.999 E.0174
; LINE_WIDTH: 0.316831
G1 X151.059 Y133.024 E.01474
; LINE_WIDTH: 0.2673
G1 X151.718 Y133.049 E.01207
; LINE_WIDTH: 0.217769
G1 X152.378 Y133.074 E.00941
; LINE_WIDTH: 0.168238
G1 X153.038 Y133.099 E.00674
; WIPE_START
G1 F15000
G1 X152.378 Y133.074 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X145.055 Y130.922 Z11.6 F30000
G1 X104.842 Y119.104 Z11.6
G1 Z11.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9086
G1 X104.842 Y122.564 E.11478
G1 X104.046 Y122.564 E.0264
G1 X104.046 Y116.533 E.20006
G1 X133.808 Y116.544 E.98727
G3 X136.462 Y117.568 I-.151 J4.343 E.09612
G3 X138.289 Y119.104 I-101.94 J123.117 E.07918
G1 X104.902 Y119.104 E1.10752
G1 X105.234 Y119.496 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9086
G1 X105.234 Y122.942 E.10589
G1 X105.234 Y122.956 E.00043
G1 X103.654 Y122.956 E.04855
G1 X103.654 Y122.942 E.00043
G1 X103.654 Y116.141 E.20899
G1 X133.831 Y116.152 E.92726
G3 X136.704 Y117.259 I-.165 J4.712 E.09639
G3 X138.367 Y118.656 I-92.68 J111.994 E.06672
G1 X153.234 Y118.656 E.45682
G1 X153.234 Y119.131 E.01458
G1 X148.436 Y119.496 E.14785
G1 X105.294 Y119.496 E1.32563
M204 S10000
; WIPE_START
G1 F12000
G1 X105.259 Y121.495 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X104.444 Y118.9 Z11.6 F30000
G1 Z11.2
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.431684
G1 F9086
G1 X104.444 Y122.36 E.10961
; WIPE_START
G1 F15000
G1 X104.444 Y120.36 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X112.067 Y119.983 Z11.6 F30000
G1 X136.873 Y118.755 Z11.6
G1 Z11.2
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9086
G1 X137.333 Y118.755 E.01528
G1 X136.44 Y118.004 E.03873
G1 X135.688 Y118.755 E.03524
G1 X136.551 Y118.755 E.02862
G1 X134.882 Y117.086 E.0783
G2 X133.798 Y116.892 I-1.264 J3.93 E.03665
G1 X129.877 Y116.891 E.13005
G1 X128.012 Y118.755 E.08748
G1 X128.875 Y118.755 E.02862
G1 X127.009 Y116.889 E.08753
G1 X122.204 Y116.888 E.15939
G1 X120.336 Y118.755 E.08762
G1 X121.199 Y118.755 E.02862
G1 X119.33 Y116.887 E.08767
G1 X114.531 Y116.885 E.1592
G1 X112.66 Y118.755 E.08775
G1 X113.523 Y118.755 E.02862
G1 X111.651 Y116.884 E.0878
G1 X106.858 Y116.882 E.15901
G1 X105.008 Y118.755 E.08734
G1 X105.847 Y118.755 E.02784
G1 X104.394 Y117.302 E.06817
G1 X104.394 Y116.881 E.01397
G1 X105.601 Y116.881 E.04004
G1 X138.56 Y119.076 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.488636
G1 F9086
G1 X148.42 Y119.076 E.35811
G1 X149.08 Y119.051 E.02398
; LINE_WIDTH: 0.415894
G1 X149.739 Y119.026 E.02006
; LINE_WIDTH: 0.366362
G1 X150.399 Y119.001 E.0174
; LINE_WIDTH: 0.316831
G1 X151.059 Y118.976 E.01474
; LINE_WIDTH: 0.2673
G1 X151.718 Y118.951 E.01207
; LINE_WIDTH: 0.217769
G1 X152.378 Y118.926 E.00941
; LINE_WIDTH: 0.168238
G1 X153.038 Y118.901 E.00674
; CHANGE_LAYER
; Z_HEIGHT: 11.4
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F15000
G1 X152.378 Y118.926 E-.76
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 57/101
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L57
M991 S0 P56 ;notify layer change
G17
G3 Z11.6 I-.345 J-1.167 P1  F30000
G1 X105.234 Y132.859 Z11.6
G1 Z11.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9130
G1 X138.305 Y132.859 E1.09703
G1 X136.46 Y134.416 E.0801
G3 X133.616 Y135.45 I-2.836 J-3.371 E.10246
G1 X104.046 Y135.45 E.9809
G1 X104.046 Y129.353 E.20225
G1 X104.842 Y129.353 E.0264
G1 X104.842 Y132.859 E.11628
G1 X105.174 Y132.859 E.01102
G1 X105.234 Y132.467 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9130
G1 X148.436 Y132.467 E1.32748
G1 X153.234 Y132.833 E.14786
G1 X153.234 Y133.319 E.01496
G1 X138.367 Y133.319 E.45681
G1 X136.704 Y134.723 E.06688
G3 X133.627 Y135.842 I-3.073 J-3.659 E.10267
G1 X103.654 Y135.842 E.92101
G1 X103.654 Y129.403 E.19786
G1 X103.654 Y129.003 E.01229
G1 X103.654 Y128.961 E.00129
G1 X105.234 Y128.961 E.04855
G1 X105.234 Y129.003 E.00129
G1 X105.234 Y129.403 E.01229
G1 X105.234 Y132.407 E.09229
M204 S10000
; WIPE_START
G1 F12000
G1 X107.234 Y132.409 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X104.444 Y133.062 Z11.8 F30000
G1 Z11.4
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.431684
G1 F9130
G1 X104.444 Y129.557 E.11105
; WIPE_START
G1 F15000
G1 X104.444 Y131.557 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X112.066 Y131.944 Z11.8 F30000
G1 X136.932 Y133.207 Z11.8
G1 Z11.4
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9130
G1 X137.352 Y133.207 E.01396
G1 X136.429 Y133.986 E.04006
G1 X135.651 Y133.207 E.03654
G1 X136.589 Y133.207 E.03112
G1 X134.906 Y134.889 E.07893
G3 X133.606 Y135.102 I-1.358 J-4.22 E.04387
G1 X129.87 Y135.102 E.12393
G1 X127.975 Y133.207 E.08891
G1 X128.913 Y133.207 E.03112
G1 X127.018 Y135.102 E.08891
G1 X122.194 Y135.102 E.16001
G1 X120.299 Y133.207 E.08891
G1 X121.237 Y133.207 E.03112
G1 X119.342 Y135.102 E.08891
G1 X114.518 Y135.102 E.16001
M73 P71 R5
G1 X112.623 Y133.207 E.08891
G1 X113.561 Y133.207 E.03112
G1 X111.666 Y135.102 E.08891
G1 X106.842 Y135.102 E.16001
G1 X105.008 Y133.268 E.08604
G1 X105.008 Y133.207 E.00202
G1 X105.885 Y133.207 E.02909
G1 X104.394 Y134.698 E.06994
G1 X104.394 Y135.102 E.01341
G1 X105.618 Y135.102 E.0406
G1 X138.568 Y132.893 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.502058
G1 F9130
G1 X148.42 Y132.893 E.36857
G1 X149.079 Y132.918 E.0247
; LINE_WIDTH: 0.429172
G1 X149.739 Y132.943 E.02078
; LINE_WIDTH: 0.379542
G1 X150.399 Y132.968 E.01811
; LINE_WIDTH: 0.329912
G1 X151.058 Y132.993 E.01544
; LINE_WIDTH: 0.280283
G1 X151.718 Y133.019 E.01277
; LINE_WIDTH: 0.230653
G1 X152.378 Y133.044 E.0101
; LINE_WIDTH: 0.181023
G1 X153.038 Y133.069 E.00743
; WIPE_START
G1 F15000
G1 X152.378 Y133.044 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X145.052 Y130.901 Z11.8 F30000
G1 X104.842 Y119.141 Z11.8
G1 Z11.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9130
G1 X104.842 Y122.647 E.11628
G1 X104.046 Y122.647 E.0264
G1 X104.046 Y116.55 E.20225
G1 X133.673 Y116.553 E.9828
G3 X136.46 Y117.584 I-.03 J4.361 E.10056
G1 X138.305 Y119.141 E.0801
G1 X104.902 Y119.141 E1.10805
G1 X105.234 Y119.533 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9130
G1 X105.234 Y122.597 E.09413
G1 X105.234 Y122.997 E.01229
G1 X105.234 Y123.039 E.00129
G1 X103.654 Y123.039 E.04855
G1 X103.654 Y122.997 E.00129
G1 X103.654 Y122.597 E.01229
G1 X103.654 Y116.158 E.19786
G1 X133.696 Y116.162 E.92312
G3 X136.704 Y117.277 I-.046 J4.738 E.10055
G1 X138.367 Y118.681 E.06688
G1 X153.234 Y118.681 E.45681
G1 X153.234 Y119.167 E.01496
G1 X148.436 Y119.533 E.14786
G1 X105.294 Y119.533 E1.32563
M204 S10000
; WIPE_START
G1 F12000
G1 X105.255 Y121.533 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X104.444 Y118.938 Z11.8 F30000
G1 Z11.4
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.431684
G1 F9130
G1 X104.444 Y122.443 E.11105
G1 X105.618 Y116.898 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9130
G1 X104.394 Y116.898 E.0406
G1 X104.394 Y117.302 E.01341
G1 X105.885 Y118.793 E.06994
G1 X105.008 Y118.793 E.02909
G1 X105.008 Y118.732 E.00203
G1 X106.842 Y116.898 E.08603
G1 X111.667 Y116.899 E.16005
G1 X113.561 Y118.793 E.08887
G1 X112.623 Y118.793 E.03112
G1 X114.517 Y116.899 E.08885
G1 X119.343 Y116.9 E.16011
G1 X121.237 Y118.793 E.08883
G1 X120.299 Y118.793 E.03112
G1 X122.192 Y116.9 E.08881
G1 X127.02 Y116.9 E.16016
G1 X128.913 Y118.793 E.08879
G1 X127.975 Y118.793 E.03112
G1 X129.867 Y116.901 E.08877
G1 X133.663 Y116.901 E.12593
G3 X134.906 Y117.111 I-.09 J4.332 E.04196
G1 X136.589 Y118.793 E.07893
G1 X135.651 Y118.793 E.03112
G1 X136.429 Y118.014 E.03653
G1 X137.352 Y118.793 E.04006
G1 X136.932 Y118.793 E.01396
G1 X138.568 Y119.107 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.502058
G1 F9130
G1 X148.42 Y119.107 E.36857
G1 X149.079 Y119.082 E.0247
; LINE_WIDTH: 0.429172
G1 X149.739 Y119.057 E.02078
; LINE_WIDTH: 0.379543
G1 X150.399 Y119.032 E.01811
; LINE_WIDTH: 0.329913
G1 X151.058 Y119.007 E.01544
; LINE_WIDTH: 0.280284
G1 X151.718 Y118.981 E.01277
; LINE_WIDTH: 0.230654
G1 X152.378 Y118.956 E.0101
; LINE_WIDTH: 0.181025
G1 X153.038 Y118.931 E.00743
; CHANGE_LAYER
; Z_HEIGHT: 11.6
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F15000
G1 X152.378 Y118.956 E-.76
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 58/101
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L58
M991 S0 P57 ;notify layer change
G17
G3 Z11.8 I-.332 J-1.171 P1  F30000
G1 X104.842 Y132.429 Z11.8
G1 Z11.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9169
G1 X104.842 Y132.821 E.01301
G1 X138.31 Y132.821 E1.11021
G1 X136.46 Y134.382 E.08031
G3 X133.616 Y135.426 I-2.849 J-3.368 E.10257
G1 X104.046 Y135.426 E.98089
G1 X104.046 Y129.264 E.2044
G1 X104.842 Y129.264 E.0264
G1 X104.842 Y132.369 E.103
G1 X105.234 Y132.429 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9169
G1 X148.436 Y132.429 E1.32748
G1 X153.234 Y132.796 E.14786
G1 X153.234 Y133.286 E.01505
G1 X138.367 Y133.286 E.45681
G1 X136.704 Y134.689 E.06687
G3 X133.627 Y135.818 I-3.086 J-3.657 E.10277
G1 X103.654 Y135.818 E.921
G1 X103.654 Y129.32 E.19965
G1 X103.654 Y128.92 E.01229
G1 X103.654 Y128.872 E.0015
G1 X105.234 Y128.872 E.04855
G1 X105.234 Y128.92 E.0015
G1 X105.234 Y129.32 E.01229
G1 X105.234 Y132.369 E.09368
M204 S10000
; WIPE_START
G1 F12000
G1 X107.234 Y132.372 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X104.444 Y133.024 Z12 F30000
G1 Z11.6
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.431684
G1 F9169
G1 X104.444 Y129.467 E.11269
G1 X105.643 Y135.077 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9169
G1 X104.394 Y135.077 E.04142
G1 X104.394 Y134.698 E.01259
G1 X105.923 Y133.169 E.07171
G1 X105.008 Y133.169 E.03034
G1 X105.008 Y133.268 E.00328
G1 X106.817 Y135.077 E.08488
G1 X111.69 Y135.077 E.16165
G1 X113.599 Y133.169 E.08952
G1 X112.585 Y133.169 E.03362
G1 X114.493 Y135.077 E.08952
G1 X119.366 Y135.077 E.16165
G1 X121.275 Y133.169 E.08952
G1 X120.261 Y133.169 E.03362
G1 X122.169 Y135.077 E.08952
G1 X127.042 Y135.077 E.16165
G1 X128.95 Y133.169 E.08952
G1 X127.937 Y133.169 E.03362
G1 X129.845 Y135.077 E.08952
G1 X133.606 Y135.077 E.12474
G2 X134.946 Y134.85 I-.063 J-4.432 E.04527
G1 X136.626 Y133.169 E.07885
G1 X135.613 Y133.169 E.03362
G1 X136.411 Y133.967 E.03745
G1 X137.357 Y133.169 E.04106
G1 X136.967 Y133.169 E.01295
G1 X138.571 Y132.857 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.506391
G1 F9169
G1 X148.419 Y132.857 E.37195
G1 X149.079 Y132.883 E.02494
; LINE_WIDTH: 0.433288
G1 X149.739 Y132.908 E.021
; LINE_WIDTH: 0.383511
G1 X150.399 Y132.933 E.01832
; LINE_WIDTH: 0.333733
G1 X151.058 Y132.958 E.01565
; LINE_WIDTH: 0.283956
G1 X151.718 Y132.983 E.01297
; LINE_WIDTH: 0.234179
G1 X152.378 Y133.009 E.01029
; LINE_WIDTH: 0.184401
G1 X153.038 Y133.034 E.00761
; WIPE_START
G1 F15000
G1 X152.378 Y133.009 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X145.049 Y130.877 Z12 F30000
G1 X104.842 Y119.179 Z12
G1 Z11.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9169
G1 X104.842 Y122.736 E.118
G1 X104.046 Y122.736 E.0264
G1 X104.046 Y116.574 E.2044
G1 X133.616 Y116.574 E.98089
G1 X134.113 Y116.604 E.01651
G1 X134.141 Y116.605 E.00093
G3 X136.46 Y117.618 I-.592 J4.519 E.08506
G1 X138.31 Y119.179 E.08031
G1 X104.902 Y119.179 E1.10822
G1 X105.234 Y119.571 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9169
G1 X105.234 Y122.68 E.09552
G1 X105.234 Y123.08 E.01229
G1 X105.234 Y123.128 E.0015
G1 X103.654 Y123.128 E.04855
G1 X103.654 Y123.08 E.0015
G1 X103.654 Y122.68 E.01229
G1 X103.654 Y116.182 E.19965
G1 X133.627 Y116.182 E.921
G1 X134.136 Y116.212 E.01564
G1 X134.187 Y116.215 E.00157
G3 X136.704 Y117.311 I-.643 J4.917 E.08547
G1 X138.367 Y118.714 E.06687
G1 X153.234 Y118.714 E.45681
G1 X153.234 Y119.204 E.01505
G1 X148.436 Y119.571 E.14786
G1 X105.294 Y119.571 E1.32563
M204 S10000
; WIPE_START
G1 F12000
G1 X105.255 Y121.571 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X104.444 Y118.976 Z12 F30000
G1 Z11.6
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.431684
G1 F9169
G1 X104.444 Y122.533 E.11269
; WIPE_START
G1 F15000
G1 X104.444 Y120.533 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X112.066 Y120.134 Z12 F30000
G1 X136.967 Y118.831 Z12
G1 Z11.6
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9169
G1 X137.357 Y118.831 E.01295
G1 X136.411 Y118.033 E.04106
G1 X135.613 Y118.831 E.03745
G1 X136.626 Y118.831 E.03362
G1 X134.946 Y117.15 E.07885
G2 X133.606 Y116.923 I-1.427 J4.347 E.04525
G1 X129.845 Y116.923 E.12474
G1 X127.937 Y118.831 E.08952
G1 X128.95 Y118.831 E.03362
G1 X127.042 Y116.923 E.08952
G1 X122.169 Y116.923 E.16165
G1 X120.261 Y118.831 E.08952
G1 X121.275 Y118.831 E.03362
G1 X119.366 Y116.923 E.08952
G1 X114.493 Y116.923 E.16165
G1 X112.585 Y118.831 E.08952
G1 X113.599 Y118.831 E.03362
G1 X111.69 Y116.923 E.08952
G1 X106.817 Y116.923 E.16165
G1 X105.008 Y118.732 E.08488
G1 X105.008 Y118.831 E.00328
G1 X105.923 Y118.831 E.03034
G1 X104.394 Y117.302 E.07171
G1 X104.394 Y116.923 E.01259
G1 X105.643 Y116.923 E.04142
G1 X138.571 Y119.143 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.506391
G1 F9169
G1 X148.419 Y119.143 E.37195
G1 X149.079 Y119.117 E.02494
; LINE_WIDTH: 0.433288
G1 X149.739 Y119.092 E.021
; LINE_WIDTH: 0.383511
G1 X150.399 Y119.067 E.01832
; LINE_WIDTH: 0.333734
G1 X151.058 Y119.042 E.01565
; LINE_WIDTH: 0.283957
G1 X151.718 Y119.017 E.01297
; LINE_WIDTH: 0.234179
G1 X152.378 Y118.991 E.01029
; LINE_WIDTH: 0.184402
G1 X153.038 Y118.966 E.00761
; CHANGE_LAYER
; Z_HEIGHT: 11.8
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F15000
G1 X152.378 Y118.991 E-.76
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 59/101
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L59
M991 S0 P58 ;notify layer change
G17
G3 Z12 I-.33 J-1.171 P1  F30000
G1 X104.842 Y132.384 Z12
G1 Z11.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9270
G1 X104.842 Y132.776 E.01301
G1 X138.306 Y132.776 E1.11008
G3 X136.036 Y134.665 I-30.564 J-34.433 E.09799
G3 X133.616 Y135.391 I-2.462 J-3.807 E.08494
G1 X104.046 Y135.391 E.98089
G1 X104.046 Y129.146 E.20718
G1 X104.842 Y129.146 E.0264
G1 X104.842 Y132.324 E.10543
G1 X105.234 Y132.384 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9270
G1 X105.275 Y132.384 E.00126
G1 X137.645 Y132.384 E.99466
G1 X148.436 Y132.384 E.33155
G1 X151.646 Y132.633 E.09894
G1 X153.234 Y132.757 E.04894
G1 X153.234 Y133.242 E.01491
G1 X138.366 Y133.242 E.45685
G3 X136.704 Y134.653 I-70.452 J-81.294 E.06701
G3 X133.627 Y135.783 I-3.076 J-3.62 E.10282
G1 X103.654 Y135.783 E.921
G1 X103.654 Y129.631 E.18906
G1 X103.654 Y129.231 E.01229
G1 X103.654 Y128.831 E.01229
G1 F4800
G1 X103.654 Y128.754 E.00236
G1 X105.234 Y128.754 E.04855
G1 F5864.492
G1 X105.234 Y128.831 E.00236
G1 F9270
G1 X105.234 Y129.231 E.01229
G1 X105.234 Y132.324 E.09506
M204 S10000
; WIPE_START
G1 F12000
G1 X105.275 Y132.384 E-.02761
G1 X107.202 Y132.384 E-.73239
; WIPE_END
G1 E-.04 F1800
G1 X104.444 Y132.98 Z12.2 F30000
G1 Z11.8
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.431684
G1 F9270
G1 X104.444 Y129.349 E.11501
; WIPE_START
G1 F15000
G1 X104.444 Y131.349 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X112.065 Y131.765 Z12.2 F30000
G1 X137.001 Y133.124 Z12.2
G1 Z11.8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9270
G1 X137.359 Y133.124 E.01188
G1 X136.391 Y133.947 E.04214
G1 X135.568 Y133.124 E.0386
G1 X136.671 Y133.124 E.03659
G1 X134.995 Y134.801 E.07865
G3 X133.606 Y135.043 I-1.459 J-4.263 E.04697
G1 X129.811 Y135.043 E.12588
G1 X127.892 Y133.124 E.09001
G1 X128.995 Y133.124 E.03659
G1 X127.077 Y135.043 E.09001
G1 X122.135 Y135.043 E.16392
G1 X120.216 Y133.124 E.09001
G1 X121.319 Y133.124 E.03659
G1 X119.401 Y135.043 E.09001
G1 X114.459 Y135.043 E.16392
G1 X112.54 Y133.124 E.09001
G1 X113.643 Y133.124 E.03659
M73 P72 R5
G1 X111.725 Y135.043 E.09001
G1 X106.783 Y135.043 E.16392
G1 X105.008 Y133.268 E.08328
G1 X105.008 Y133.124 E.00476
G1 X105.967 Y133.124 E.03183
G1 X104.394 Y134.698 E.0738
G1 X104.394 Y135.043 E.01146
G1 X105.677 Y135.043 E.04256
G1 X138.564 Y132.813 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.507252
G1 F9270
G1 X148.419 Y132.813 E.37287
G1 X148.996 Y132.835 E.02186
; LINE_WIDTH: 0.442151
G1 X149.574 Y132.858 E.0188
; LINE_WIDTH: 0.397934
G1 X150.151 Y132.88 E.01671
; LINE_WIDTH: 0.353718
G1 X150.728 Y132.902 E.01463
; LINE_WIDTH: 0.309501
G1 X151.306 Y132.925 E.01255
; LINE_WIDTH: 0.265284
G1 X151.883 Y132.947 E.01047
; LINE_WIDTH: 0.221067
G1 X152.46 Y132.97 E.00839
; LINE_WIDTH: 0.176851
G1 X153.038 Y132.992 E.00631
; WIPE_START
G1 F15000
G1 X152.46 Y132.97 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X145.127 Y130.853 Z12.2 F30000
G1 X104.842 Y119.224 Z12.2
G1 Z11.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9270
G1 X104.842 Y122.854 E.12043
G1 X104.046 Y122.854 E.0264
G1 X104.046 Y116.609 E.20718
G1 X133.616 Y116.609 E.98089
G1 X133.977 Y116.63 E.012
G3 X136.459 Y117.654 I-.33 J4.322 E.09057
G3 X138.306 Y119.224 I-76.532 J91.896 E.08041
G1 X104.902 Y119.224 E1.10809
G1 X105.234 Y119.616 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9270
G1 X105.234 Y122.369 E.08461
G1 X105.234 Y122.769 E.01229
G1 X105.234 Y123.169 E.01229
G1 F4800
G1 X105.234 Y123.246 E.00236
G1 X103.654 Y123.246 E.04855
G1 F5864.492
G1 X103.654 Y123.169 E.00236
G1 F9270
G1 X103.654 Y122.769 E.01229
G1 X103.654 Y116.217 E.20135
G1 X133.627 Y116.217 E.921
G1 X134 Y116.238 E.01147
G1 X134.187 Y116.249 E.00574
G3 X136.704 Y117.347 I-.638 J4.898 E.0855
G3 X138.366 Y118.758 I-68.79 J82.706 E.06701
G1 X153.234 Y118.758 E.45685
G1 X153.234 Y119.243 E.01491
G1 X151.646 Y119.367 E.04894
G1 X149.238 Y119.554 E.0742
G1 X148.436 Y119.616 E.02473
G1 X105.294 Y119.616 E1.32563
M204 S10000
; WIPE_START
G1 F12000
G1 X105.25 Y121.615 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X104.444 Y119.02 Z12.2 F30000
G1 Z11.8
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.431684
G1 F9270
G1 X104.444 Y122.651 E.11501
G1 X105.677 Y116.957 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9270
G1 X104.394 Y116.957 E.04256
G1 X104.394 Y117.302 E.01146
G1 X105.967 Y118.876 E.0738
G1 X105.008 Y118.876 E.03183
G1 X105.008 Y118.732 E.00476
G1 X106.783 Y116.957 E.08328
G1 X111.725 Y116.957 E.16392
G1 X113.643 Y118.876 E.09001
G1 X112.54 Y118.876 E.03659
G1 X114.459 Y116.957 E.09001
G1 X119.401 Y116.957 E.16392
G1 X121.319 Y118.875 E.09001
G1 X120.216 Y118.875 E.03659
G1 X122.135 Y116.957 E.09001
G1 X127.077 Y116.957 E.16392
G1 X128.995 Y118.875 E.09001
G1 X127.892 Y118.875 E.03659
G1 X129.811 Y116.957 E.09001
G1 X133.956 Y116.978 E.13752
G3 X134.995 Y117.199 I-.384 J4.343 E.0353
G1 X136.671 Y118.875 E.07864
G1 X135.568 Y118.875 E.03659
G1 X136.391 Y118.053 E.0386
G1 X137.359 Y118.875 E.04214
G1 X137.001 Y118.875 E.01188
G1 X138.564 Y119.187 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.507252
G1 F9270
G1 X148.419 Y119.187 E.37287
G1 X148.996 Y119.165 E.02186
; LINE_WIDTH: 0.442151
G1 X149.574 Y119.142 E.0188
; LINE_WIDTH: 0.397934
G1 X150.151 Y119.12 E.01671
; LINE_WIDTH: 0.353718
G1 X150.728 Y119.098 E.01463
; LINE_WIDTH: 0.309501
G1 X151.306 Y119.075 E.01255
; LINE_WIDTH: 0.265284
G1 X151.883 Y119.053 E.01047
; LINE_WIDTH: 0.221067
G1 X152.46 Y119.03 E.00839
; LINE_WIDTH: 0.17685
G1 X153.038 Y119.008 E.00631
; CHANGE_LAYER
; Z_HEIGHT: 12
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F15000
G1 X152.46 Y119.03 E-.76
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 60/101
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L60
M991 S0 P59 ;notify layer change
G17
G3 Z12.2 I-.327 J-1.172 P1  F30000
G1 X104.842 Y132.324 Z12.2
G1 Z12
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9391
G1 X104.842 Y132.716 E.01301
G1 X138.325 Y132.716 E1.1107
G3 X136.035 Y134.631 I-29.449 J-32.885 E.09905
G3 X133.616 Y135.357 I-2.461 J-3.807 E.08491
G1 X104.046 Y135.357 E.98089
G1 X104.046 Y129.016 E.21034
G1 X104.842 Y129.016 E.0264
G1 X104.842 Y132.264 E.10773
G1 X105.234 Y132.324 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9391
G1 X105.275 Y132.324 E.00126
G1 X113.367 Y132.324 E.24866
G1 X121.46 Y132.324 E.24866
G1 X129.553 Y132.324 E.24866
G1 X137.645 Y132.324 E.24866
G1 X145.738 Y132.324 E.24866
G1 X148.436 Y132.324 E.08289
G1 X153.234 Y132.698 E.14788
G1 X153.234 Y132.716 E.00053
G1 X153.234 Y133.198 E.01481
G1 X138.366 Y133.198 E.45685
G3 X136.253 Y134.958 I-22.296 J-24.615 E.08454
G3 X133.627 Y135.749 I-2.681 J-4.144 E.08537
G1 X103.654 Y135.749 E.921
G1 X103.654 Y129.513 E.19163
G1 X103.654 Y129.113 E.01229
G1 F8596.922
G1 X103.654 Y128.713 E.01229
G1 F3000
G1 X103.654 Y128.624 E.00272
G1 X105.234 Y128.624 E.04855
G1 F3990.437
G1 X105.234 Y128.713 E.00272
G1 F9391
G1 X105.234 Y129.113 E.01229
G1 X105.234 Y129.513 E.01229
G1 X105.234 Y132.264 E.08454
M204 S10000
; WIPE_START
G1 F12000
G1 X105.275 Y132.324 E-.02761
G1 X107.202 Y132.324 E-.73239
; WIPE_END
G1 E-.04 F1800
G1 X104.444 Y132.919 Z12.4 F30000
G1 Z12
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.431684
G1 F9391
G1 X104.444 Y129.22 E.1172
G1 X105.711 Y135.009 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9391
G1 X104.394 Y135.009 E.04369
G1 X104.394 Y134.698 E.01032
G1 X106.028 Y133.064 E.07663
G1 X105.008 Y133.064 E.03383
G1 X105.008 Y133.268 E.00675
G1 X106.749 Y135.009 E.08168
G1 X111.759 Y135.009 E.1662
G1 X113.704 Y133.064 E.09123
G1 X112.48 Y133.064 E.04059
G1 X114.425 Y135.009 E.09123
G1 X119.435 Y135.009 E.1662
G1 X121.38 Y133.064 E.09123
G1 X120.156 Y133.064 E.04059
G1 X122.101 Y135.009 E.09123
G1 X127.111 Y135.009 E.1662
G1 X129.056 Y133.064 E.09123
G1 X127.832 Y133.064 E.04059
G1 X129.777 Y135.009 E.09123
G1 X133.606 Y135.009 E.12701
G2 X135.052 Y134.743 I-.511 J-6.861 E.04889
G1 X136.731 Y133.064 E.07877
G1 X135.508 Y133.064 E.04059
G1 X136.371 Y133.927 E.04049
G1 X137.381 Y133.064 E.04408
G1 X137.082 Y133.064 E.00994
G1 X138.574 Y132.761 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.523354
G1 F9391
G1 X148.419 Y132.761 E.38542
G1 X148.996 Y132.783 E.02262
; LINE_WIDTH: 0.458004
G1 X149.573 Y132.806 E.01954
; LINE_WIDTH: 0.413617
G1 X150.151 Y132.828 E.01745
; LINE_WIDTH: 0.369231
G1 X150.728 Y132.851 E.01536
; LINE_WIDTH: 0.324844
G1 X151.306 Y132.873 E.01327
; LINE_WIDTH: 0.280457
G1 X151.883 Y132.896 E.01118
; LINE_WIDTH: 0.23607
G1 X152.46 Y132.918 E.00909
; LINE_WIDTH: 0.191684
G1 X153.038 Y132.941 E.007
; WIPE_START
G1 F15000
G1 X152.46 Y132.918 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X145.123 Y130.817 Z12.4 F30000
G1 X104.842 Y119.284 Z12.4
G1 Z12
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9391
G1 X104.842 Y122.984 E.12273
G1 X104.046 Y122.984 E.0264
G1 X104.046 Y116.643 E.21034
G1 X133.616 Y116.643 E.98089
G1 X133.841 Y116.656 E.00749
G3 X136.459 Y117.689 I-.182 J4.294 E.0951
G3 X138.325 Y119.284 I-77.704 J92.831 E.08143
G1 X104.902 Y119.284 E1.10871
G1 X105.234 Y119.676 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9391
G1 X105.234 Y122.487 E.08638
G1 X105.234 Y122.887 E.01229
G1 F8596.922
G1 X105.234 Y123.287 E.01229
G1 F3000
G1 X105.234 Y123.376 E.00272
G1 X103.654 Y123.376 E.04855
G1 F3990.437
G1 X103.654 Y123.287 E.00272
G1 F9391
G1 X103.654 Y122.887 E.01229
G1 X103.654 Y122.487 E.01229
G1 X103.654 Y116.251 E.19163
G1 X133.627 Y116.251 E.921
G1 X133.864 Y116.265 E.00729
G3 X136.703 Y117.383 I-.199 J4.668 E.09551
G3 X138.366 Y118.802 I-69.174 J82.704 E.06717
G1 X153.234 Y118.802 E.45685
G1 X153.234 Y119.284 E.01481
G1 X153.234 Y119.302 E.00053
G1 X150.835 Y119.489 E.07394
G1 X148.436 Y119.676 E.07394
G1 X140.343 Y119.676 E.24866
G1 X132.25 Y119.676 E.24866
G1 X124.158 Y119.676 E.24866
G1 X116.065 Y119.676 E.24866
G1 X105.294 Y119.676 E.33097
M204 S10000
; WIPE_START
G1 F12000
G1 X105.251 Y121.676 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X104.444 Y119.081 Z12.4 F30000
G1 Z12
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.431684
G1 F9391
G1 X104.444 Y122.78 E.1172
; WIPE_START
G1 F15000
G1 X104.444 Y120.78 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X112.064 Y120.35 Z12.4 F30000
G1 X137.082 Y118.936 Z12.4
G1 Z12
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9391
G1 X137.381 Y118.936 E.00994
G1 X136.371 Y118.073 E.04408
G1 X135.508 Y118.936 E.04049
G1 X136.731 Y118.936 E.04059
G1 X135.052 Y117.257 E.07877
G2 X133.606 Y116.991 I-1.506 J4.132 E.04903
G1 X129.777 Y116.991 E.12701
G1 X127.832 Y118.936 E.09123
G1 X129.056 Y118.936 E.04059
G1 X127.111 Y116.991 E.09123
G1 X122.101 Y116.991 E.1662
G1 X120.156 Y118.936 E.09123
G1 X121.38 Y118.936 E.04059
G1 X119.435 Y116.991 E.09123
G1 X114.425 Y116.991 E.1662
G1 X112.48 Y118.936 E.09123
G1 X113.704 Y118.936 E.04059
G1 X111.759 Y116.991 E.09123
G1 X106.749 Y116.991 E.1662
G1 X105.008 Y118.732 E.08168
G1 X105.008 Y118.936 E.00675
G1 X106.028 Y118.936 E.03383
G1 X104.394 Y117.302 E.07663
G1 X104.394 Y116.991 E.01032
G1 X105.711 Y116.991 E.0437
G1 X138.574 Y119.239 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.523354
G1 F9391
G1 X148.419 Y119.239 E.38542
G1 X148.996 Y119.217 E.02262
; LINE_WIDTH: 0.458004
G1 X149.573 Y119.194 E.01954
; LINE_WIDTH: 0.413618
G1 X150.151 Y119.172 E.01745
; LINE_WIDTH: 0.369231
G1 X150.728 Y119.149 E.01536
; LINE_WIDTH: 0.324845
G1 X151.306 Y119.127 E.01327
; LINE_WIDTH: 0.280458
G1 X151.883 Y119.104 E.01118
; LINE_WIDTH: 0.236071
G1 X152.46 Y119.082 E.00909
; LINE_WIDTH: 0.191685
G1 X153.038 Y119.059 E.007
; CHANGE_LAYER
; Z_HEIGHT: 12.2
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F15000
G1 X152.46 Y119.082 E-.76
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 61/101
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L61
M991 S0 P60 ;notify layer change
G17
G3 Z12.4 I-.325 J-1.173 P1  F30000
G1 X104.842 Y132.264 Z12.4
G1 Z12.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9505
G1 X104.842 Y132.656 E.01301
G1 X138.344 Y132.656 E1.11133
G1 X136.456 Y134.276 E.08253
G3 X133.616 Y135.323 I-2.833 J-3.311 E.10255
G1 X104.046 Y135.323 E.98089
G1 X104.046 Y128.849 E.21476
G1 X104.842 Y128.849 E.0264
G1 X104.842 Y132.204 E.11129
G1 X105.234 Y132.264 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9505
G1 X105.275 Y132.264 E.00126
G1 X113.367 Y132.264 E.24866
G1 X121.46 Y132.264 E.24866
G1 X129.553 Y132.264 E.24866
G1 X137.645 Y132.264 E.24866
G1 X145.738 Y132.264 E.24866
G1 X148.436 Y132.264 E.08289
G1 X153.234 Y132.64 E.14789
G1 X153.234 Y132.657 E.00053
G1 X153.234 Y133.153 E.01524
G1 X138.366 Y133.153 E.45685
G1 X136.702 Y134.581 E.06737
G3 X133.627 Y135.715 I-3.073 J-3.598 E.10283
G1 X103.654 Y135.715 E.921
G1 X103.654 Y129.383 E.19456
G1 X103.654 Y128.983 E.01229
G1 F7769.882
G1 X103.654 Y128.583 E.01229
G1 F2520
G1 X103.654 Y128.457 E.00389
G1 X105.234 Y128.457 E.04855
G1 F3870.076
G1 X105.234 Y128.583 E.00389
G1 F9505
G1 X105.234 Y128.983 E.01229
G1 X105.234 Y129.383 E.01229
G1 X105.234 Y132.204 E.08666
M204 S10000
; WIPE_START
G1 F12000
G1 X105.275 Y132.264 E-.02761
G1 X107.202 Y132.264 E-.73239
; WIPE_END
G1 E-.04 F1800
G1 X104.444 Y132.859 Z12.6 F30000
G1 Z12.2
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.431684
G1 F9505
G1 X104.444 Y129.052 E.1206
; WIPE_START
G1 F15000
G1 X104.444 Y131.052 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X112.063 Y131.507 Z12.6 F30000
G1 X137.162 Y133.004 Z12.6
G1 Z12.2
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9505
G1 X137.404 Y133.004 E.008
G1 X136.351 Y133.907 E.04601
G1 X135.448 Y133.004 E.04238
G1 X136.792 Y133.004 E.04459
G1 X135.113 Y134.683 E.07875
G3 X133.606 Y134.975 I-1.914 J-5.844 E.05107
G1 X129.742 Y134.975 E.12815
G1 X127.772 Y133.004 E.09245
G1 X129.116 Y133.004 E.04459
G1 X127.145 Y134.975 E.09245
G1 X122.066 Y134.975 E.16847
G1 X120.096 Y133.004 E.09245
G1 X121.44 Y133.004 E.04459
G1 X119.469 Y134.975 E.09245
G1 X114.39 Y134.975 E.16847
G1 X112.42 Y133.004 E.09245
G1 X113.764 Y133.004 E.04459
G1 X111.793 Y134.975 E.09245
M73 P73 R5
G1 X106.714 Y134.975 E.16847
G1 X104.947 Y133.207 E.0829
G1 X105.008 Y133.207 E.00201
G1 X105.008 Y133.004 E.00675
G1 X106.088 Y133.004 E.03583
G1 X104.394 Y134.698 E.07946
G1 X104.394 Y134.975 E.00918
G1 X105.746 Y134.975 E.04483
G1 X138.583 Y132.708 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.539457
G1 F9505
G1 X148.418 Y132.708 E.39793
G1 X148.996 Y132.731 E.02338
; LINE_WIDTH: 0.473861
G1 X149.573 Y132.754 E.02029
; LINE_WIDTH: 0.429305
G1 X150.15 Y132.776 E.0182
; LINE_WIDTH: 0.384749
G1 X150.728 Y132.799 E.0161
; LINE_WIDTH: 0.340194
G1 X151.305 Y132.822 E.014
; LINE_WIDTH: 0.295638
G1 X151.883 Y132.844 E.0119
; LINE_WIDTH: 0.251082
G1 X152.46 Y132.867 E.0098
; LINE_WIDTH: 0.206526
G1 X153.038 Y132.889 E.0077
; WIPE_START
G1 F15000
G1 X152.46 Y132.867 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X145.118 Y130.782 Z12.6 F30000
G1 X104.842 Y119.344 Z12.6
G1 Z12.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9505
G1 X104.842 Y123.151 E.12628
G1 X104.046 Y123.151 E.0264
G1 X104.046 Y116.677 E.21476
G1 X133.705 Y116.682 E.98387
G3 X136.456 Y117.724 I-.058 J4.308 E.09956
G1 X138.344 Y119.344 E.08253
G1 X104.902 Y119.344 E1.10934
G1 X105.234 Y119.736 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9505
G1 X105.234 Y122.617 E.08851
G1 X105.234 Y123.017 E.01229
G1 F7769.882
G1 X105.234 Y123.417 E.01229
G1 F2520
G1 X105.234 Y123.543 E.00389
G1 X103.654 Y123.543 E.04855
G1 F3870.076
G1 X103.654 Y123.417 E.00389
G1 F9505
G1 X103.654 Y123.017 E.01229
G1 X103.654 Y122.617 E.01229
G1 X103.654 Y116.285 E.19456
G1 X133.728 Y116.291 E.92411
G3 X136.702 Y117.419 I-.073 J4.68 E.09971
G1 X138.366 Y118.847 E.06737
G1 X153.234 Y118.847 E.45685
G1 X153.234 Y119.343 E.01524
G1 X153.234 Y119.36 E.00053
G1 X150.835 Y119.548 E.07394
G1 X148.436 Y119.736 E.07394
G1 X140.343 Y119.736 E.24866
G1 X132.25 Y119.736 E.24866
G1 X124.158 Y119.736 E.24866
G1 X116.065 Y119.736 E.24866
G1 X105.294 Y119.736 E.33097
M204 S10000
; WIPE_START
G1 F12000
G1 X105.252 Y121.736 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X104.444 Y119.141 Z12.6 F30000
G1 Z12.2
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.431684
G1 F9505
G1 X104.444 Y122.948 E.1206
G1 X105.746 Y117.026 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9505
G1 X104.394 Y117.026 E.04483
G1 X104.394 Y117.302 E.00918
G1 X106.088 Y118.996 E.07946
G1 X105.008 Y118.996 E.03583
G1 X105.008 Y118.793 E.00675
G1 X104.947 Y118.793 E.00201
G1 X106.714 Y117.026 E.08288
G1 X111.795 Y117.027 E.16854
G1 X113.764 Y118.996 E.09238
G1 X112.42 Y118.996 E.04459
G1 X114.389 Y117.027 E.09236
G1 X119.472 Y117.028 E.16863
G1 X121.44 Y118.996 E.09232
G1 X120.096 Y118.996 E.04459
G1 X122.063 Y117.029 E.0923
G1 X127.149 Y117.03 E.16872
G1 X129.116 Y118.996 E.09225
G1 X127.772 Y118.996 E.04459
G1 X129.738 Y117.03 E.09223
G1 X133.695 Y117.031 E.13128
G3 X135.113 Y117.317 I-.517 J6.209 E.04809
G1 X136.792 Y118.996 E.07875
G1 X135.448 Y118.996 E.04459
G1 X136.351 Y118.093 E.04238
G1 X137.404 Y118.996 E.04601
G1 X137.162 Y118.996 E.008
G1 X138.583 Y119.292 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.539457
G1 F9505
G1 X148.418 Y119.292 E.39793
G1 X148.996 Y119.269 E.02338
; LINE_WIDTH: 0.473859
G1 X149.573 Y119.246 E.02029
; LINE_WIDTH: 0.429303
G1 X150.15 Y119.224 E.0182
; LINE_WIDTH: 0.384748
G1 X150.728 Y119.201 E.0161
; LINE_WIDTH: 0.340192
G1 X151.305 Y119.178 E.014
; LINE_WIDTH: 0.295636
G1 X151.883 Y119.156 E.0119
; LINE_WIDTH: 0.251081
G1 X152.46 Y119.133 E.0098
; LINE_WIDTH: 0.206525
G1 X153.038 Y119.111 E.0077
; CHANGE_LAYER
; Z_HEIGHT: 12.4
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F15000
G1 X152.46 Y119.133 E-.76
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 62/101
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L62
M991 S0 P61 ;notify layer change
G17
G3 Z12.6 I-.322 J-1.174 P1  F30000
G1 X104.842 Y132.202 Z12.6
G1 Z12.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9549
G1 X104.842 Y132.594 E.01301
G1 X138.336 Y132.594 E1.11106
G3 X136.456 Y134.223 I-62.275 J-69.951 E.08253
G3 X133.615 Y135.285 I-2.858 J-3.317 E.10271
G1 X104.046 Y135.285 E.98088
G1 X104.046 Y128.666 E.21955
G1 X104.842 Y128.666 E.0264
G1 X104.842 Y132.142 E.11529
G1 X105.234 Y132.202 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9549
G1 X105.275 Y132.202 E.00126
G1 X110.67 Y132.202 E.16578
G1 X118.762 Y132.202 E.24866
G1 X126.855 Y132.202 E.24866
G1 X134.948 Y132.202 E.24866
G1 X143.04 Y132.202 E.24866
G1 X148.435 Y132.202 E.16578
G1 X150.835 Y132.392 E.07395
G1 X153.234 Y132.582 E.07395
G1 X153.234 Y132.599 E.00053
G1 X153.234 Y133.091 E.01513
G1 X138.364 Y133.091 E.45689
G3 X136.702 Y134.528 I-54.917 J-61.839 E.06751
G3 X133.627 Y135.677 I-3.098 J-3.605 E.10299
G1 X103.654 Y135.677 E.921
G1 X103.654 Y129.216 E.19854
G1 X103.654 Y128.816 E.01229
G1 F7343.921
G1 X103.654 Y128.416 E.01229
G1 F2280
G1 X103.654 Y128.274 E.00435
G1 X105.234 Y128.274 E.04855
G1 F3742.824
G1 X105.234 Y128.416 E.00435
G1 F9549
G1 X105.234 Y128.816 E.01229
G1 X105.234 Y129.216 E.01229
G1 X105.234 Y132.142 E.08991
M204 S10000
; WIPE_START
G1 F12000
G1 X105.275 Y132.202 E-.02761
G1 X107.202 Y132.202 E-.73239
; WIPE_END
G1 E-.04 F1800
G1 X104.444 Y132.797 Z12.8 F30000
G1 Z12.4
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.431684
G1 F9549
G1 X104.444 Y128.87 E.12443
G1 X105.784 Y134.937 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9549
G1 X104.394 Y134.937 E.04609
G1 X104.394 Y134.698 E.00792
G1 X106.15 Y132.942 E.08236
G1 X105.008 Y132.942 E.03788
G1 X105.008 Y133.146 E.00675
G1 X104.885 Y133.146 E.00406
G1 X106.676 Y134.937 E.08401
G1 X111.831 Y134.937 E.171
G1 X113.826 Y132.942 E.09356
G1 X112.358 Y132.942 E.04869
G1 X114.352 Y134.937 E.09356
G1 X119.507 Y134.937 E.171
G1 X121.502 Y132.942 E.09356
G1 X120.034 Y132.942 E.04869
G1 X122.028 Y134.937 E.09356
G1 X127.183 Y134.937 E.171
G1 X129.178 Y132.942 E.09356
G1 X127.71 Y132.942 E.04869
G1 X129.704 Y134.937 E.09356
G1 X133.605 Y134.937 E.1294
G2 X135.194 Y134.602 I-.333 J-5.521 E.05405
G1 X136.854 Y132.942 E.07787
G1 X135.386 Y132.942 E.04869
G1 X136.322 Y133.878 E.04392
G1 X138.572 Y132.647 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.539181
G1 F9549
G1 X148.418 Y132.647 E.39814
G1 X148.995 Y132.669 E.02337
; LINE_WIDTH: 0.472957
G1 X149.573 Y132.692 E.02025
; LINE_WIDTH: 0.427975
G1 X150.15 Y132.715 E.01813
; LINE_WIDTH: 0.382994
G1 X150.728 Y132.738 E.01602
; LINE_WIDTH: 0.338013
G1 X151.305 Y132.761 E.0139
; LINE_WIDTH: 0.293032
G1 X151.883 Y132.784 E.01178
; LINE_WIDTH: 0.24805
G1 X152.46 Y132.806 E.00966
; LINE_WIDTH: 0.203069
G1 X153.038 Y132.829 E.00754
; WIPE_START
G1 F15000
G1 X152.46 Y132.806 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X145.113 Y130.739 Z12.8 F30000
G1 X104.842 Y119.406 Z12.8
G1 Z12.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9549
G1 X104.842 Y123.334 E.13029
G1 X104.046 Y123.334 E.0264
G1 X104.046 Y116.715 E.21955
G1 X133.615 Y116.715 E.98088
G1 X134.139 Y116.747 E.01741
G3 X136.456 Y117.777 I-.603 J4.475 E.08524
G3 X138.336 Y119.406 I-60.395 J71.581 E.08253
G1 X104.902 Y119.406 E1.10907
G1 X105.234 Y119.798 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9549
G1 X105.234 Y122.784 E.09176
G1 X105.234 Y123.184 E.01229
G1 F7343.921
G1 X105.234 Y123.584 E.01229
G1 F2280
G1 X105.234 Y123.726 E.00435
G1 X103.654 Y123.726 E.04855
G1 F3742.824
G1 X103.654 Y123.584 E.00435
G1 F9549
G1 X103.654 Y123.184 E.01229
G1 X103.654 Y122.784 E.01229
G1 X103.654 Y116.323 E.19854
G1 X133.627 Y116.323 E.921
G1 X134.165 Y116.355 E.01655
G1 X134.186 Y116.357 E.00065
G3 X136.702 Y117.472 I-.654 J4.873 E.08571
G3 X138.364 Y118.909 I-53.255 J63.276 E.06751
G1 X153.234 Y118.909 E.45689
G1 X153.234 Y119.401 E.01513
G1 X153.234 Y119.418 E.00053
G1 X148.435 Y119.798 E.1479
G1 X145.738 Y119.798 E.08289
G1 X137.645 Y119.798 E.24866
G1 X129.553 Y119.798 E.24866
G1 X121.46 Y119.798 E.24866
G1 X113.367 Y119.798 E.24866
G1 X105.294 Y119.798 E.24808
M204 S10000
; WIPE_START
G1 F12000
G1 X105.254 Y121.798 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X104.444 Y119.203 Z12.8 F30000
G1 Z12.4
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.431684
G1 F9549
G1 X104.444 Y123.13 E.12443
; WIPE_START
G1 F15000
G1 X104.444 Y121.13 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X112.042 Y120.413 Z12.8 F30000
G1 X136.322 Y118.122 Z12.8
G1 Z12.4
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9549
G1 X135.386 Y119.058 E.04392
G1 X136.854 Y119.058 E.04869
G1 X135.194 Y117.398 E.07787
G2 X133.605 Y117.063 I-1.921 J5.186 E.05405
G1 X129.704 Y117.063 E.1294
G1 X127.71 Y119.058 E.09356
G1 X129.178 Y119.058 E.04869
G1 X127.183 Y117.063 E.09356
G1 X122.028 Y117.063 E.171
G1 X120.034 Y119.058 E.09356
G1 X121.502 Y119.058 E.04869
G1 X119.507 Y117.063 E.09356
G1 X114.352 Y117.063 E.171
G1 X112.358 Y119.058 E.09356
G1 X113.826 Y119.058 E.04869
G1 X111.831 Y117.063 E.09356
G1 X106.676 Y117.063 E.171
G1 X104.885 Y118.854 E.08401
G1 X105.008 Y118.854 E.00406
G1 X105.008 Y119.058 E.00675
G1 X106.15 Y119.058 E.03788
G1 X104.394 Y117.302 E.08236
G1 X104.394 Y117.063 E.00792
G1 X105.784 Y117.063 E.04609
G1 X138.572 Y119.353 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.539181
G1 F9549
G1 X148.418 Y119.353 E.39814
G1 X148.995 Y119.331 E.02337
; LINE_WIDTH: 0.472957
G1 X149.573 Y119.308 E.02025
; LINE_WIDTH: 0.427975
G1 X150.15 Y119.285 E.01813
; LINE_WIDTH: 0.382994
G1 X150.728 Y119.262 E.01602
; LINE_WIDTH: 0.338013
G1 X151.305 Y119.239 E.0139
; LINE_WIDTH: 0.293032
G1 X151.883 Y119.216 E.01178
; LINE_WIDTH: 0.248051
G1 X152.46 Y119.194 E.00966
; LINE_WIDTH: 0.20307
G1 X153.038 Y119.171 E.00754
; CHANGE_LAYER
; Z_HEIGHT: 12.6
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F15000
G1 X152.46 Y119.194 E-.76
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 63/101
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L63
M991 S0 P62 ;notify layer change
G17
G3 Z12.8 I-.319 J-1.174 P1  F30000
G1 X104.842 Y132.117 Z12.8
G1 Z12.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9813
G1 X104.842 Y132.509 E.01301
G1 X138.358 Y132.509 E1.11179
G3 X136.031 Y134.494 I-27.926 J-30.382 E.10146
G3 X133.615 Y135.233 I-2.461 J-3.728 E.08496
G1 X104.046 Y135.233 E.98088
G1 X104.046 Y128.424 E.22587
G1 X104.842 Y128.424 E.0264
G1 X104.842 Y132.057 E.12054
G1 X105.234 Y132.117 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9813
G1 X105.275 Y132.117 E.00126
G1 X107.972 Y132.117 E.08289
G1 X112.019 Y132.117 E.12433
G1 X116.065 Y132.117 E.12433
G1 X120.111 Y132.117 E.12433
G1 X124.157 Y132.117 E.12433
G1 X128.204 Y132.117 E.12433
G1 X132.25 Y132.117 E.12433
G1 X134.948 Y132.117 E.08289
G1 X138.994 Y132.117 E.12433
G1 X142.64 Y132.117 E.11204
G1 X143.04 Y132.117 E.01229
G1 X146.687 Y132.117 E.11204
G1 X147.087 Y132.117 E.01229
G1 X148.435 Y132.117 E.04144
G1 X148.834 Y132.15 E.01229
G1 X152.034 Y132.408 E.09865
G1 X152.433 Y132.44 E.01229
G1 X153.234 Y132.505 E.02469
G1 X153.234 Y132.541 E.00109
G1 X153.234 Y133.026 E.01493
G1 X138.364 Y133.026 E.45689
G3 X136.251 Y134.819 I-25.287 J-27.659 E.08517
G3 X133.627 Y135.625 I-2.683 J-4.063 E.0855
G1 X103.654 Y135.625 E.921
G1 X103.654 Y129.033 E.20255
G1 X103.654 Y128.633 E.01229
G1 F5997.599
G1 X103.654 Y128.233 E.01229
G1 F1560
G1 X103.654 Y128.031 E.00619
G1 X105.234 Y128.031 E.04855
G1 F3435.616
G1 X105.234 Y128.233 E.00619
G1 F9324.116
G1 X105.234 Y128.633 E.01229
G1 F9813
G1 X105.234 Y129.033 E.01229
G1 X105.234 Y132.057 E.09293
M204 S10000
; WIPE_START
G1 F12000
G1 X105.275 Y132.117 E-.02761
G1 X107.202 Y132.117 E-.73239
; WIPE_END
G1 E-.04 F1800
G1 X104.444 Y132.713 Z13 F30000
G1 Z12.6
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.431684
G1 F9813
G1 X104.444 Y128.627 E.12944
; WIPE_START
G1 F15000
G1 X104.444 Y130.627 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X112.037 Y131.395 Z13 F30000
G1 X136.292 Y133.849 Z13
G1 Z12.6
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9813
G1 X135.301 Y132.858 E.04648
G1 X136.938 Y132.858 E.05429
G1 X135.287 Y134.509 E.07745
G3 X133.605 Y134.884 I-1.98 J-4.91 E.05743
G1 X129.652 Y134.884 E.13112
G1 X127.625 Y132.858 E.09508
G1 X129.262 Y132.858 E.05429
G1 X127.235 Y134.884 E.09508
G1 X121.976 Y134.884 E.17445
G1 X119.949 Y132.858 E.09508
G1 X121.586 Y132.858 E.05429
G1 X119.559 Y134.884 E.09508
G1 X114.3 Y134.884 E.17445
G1 X112.274 Y132.858 E.09508
M73 P74 R5
G1 X113.91 Y132.858 E.05429
G1 X111.883 Y134.884 E.09508
G1 X106.624 Y134.884 E.17445
G1 X104.801 Y133.061 E.08553
G1 X105.008 Y133.061 E.00686
G1 X105.008 Y132.858 E.00675
G1 X106.234 Y132.858 E.04068
G1 X104.394 Y134.698 E.08632
G1 X104.394 Y134.884 E.00619
G1 X105.836 Y134.884 E.04782
G1 X138.583 Y132.572 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.558578
G1 F9813
G1 X148.417 Y132.572 E.41321
G1 X148.995 Y132.595 E.02429
; LINE_WIDTH: 0.491103
G1 X149.572 Y132.618 E.02111
; LINE_WIDTH: 0.44527
G1 X150.15 Y132.642 E.01895
; LINE_WIDTH: 0.399438
G1 X150.727 Y132.665 E.01679
; LINE_WIDTH: 0.353605
G1 X151.305 Y132.688 E.01463
; LINE_WIDTH: 0.307772
G1 X151.883 Y132.712 E.01248
; LINE_WIDTH: 0.261939
G1 X152.46 Y132.735 E.01032
; LINE_WIDTH: 0.216107
G1 X153.038 Y132.758 E.00816
; WIPE_START
G1 F15000
G1 X152.46 Y132.735 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X145.107 Y130.69 Z13 F30000
G1 X104.842 Y119.491 Z13
G1 Z12.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9813
G1 X104.842 Y123.576 E.13554
G1 X104.046 Y123.576 E.0264
G1 X104.046 Y116.767 E.22587
G1 X133.615 Y116.767 E.98088
G1 X134.004 Y116.791 E.0129
G3 X136.455 Y117.831 I-.369 J4.276 E.08981
G3 X138.358 Y119.491 I-61.521 J72.469 E.08376
G1 X104.902 Y119.491 E1.1098
G1 X105.234 Y119.883 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9813
G1 X105.234 Y122.967 E.09477
G1 X105.234 Y123.367 E.01229
G1 F5997.599
G1 X105.234 Y123.767 E.01229
G1 F1560
G1 X105.234 Y123.969 E.00619
G1 X103.654 Y123.969 E.04855
G1 F3435.616
G1 X103.654 Y123.767 E.00619
G1 F9324.116
G1 X103.654 Y123.367 E.01229
G1 F9813
G1 X103.654 Y122.967 E.01229
G1 X103.654 Y116.375 E.20255
G1 X133.627 Y116.375 E.921
G1 X134.027 Y116.399 E.01231
G1 X134.186 Y116.409 E.00489
G3 X136.702 Y117.527 I-.646 J4.845 E.08576
G3 X138.364 Y118.974 I-53.64 J63.301 E.06772
G1 X153.234 Y118.974 E.45689
G1 X153.234 Y119.459 E.01493
G1 X153.234 Y119.495 E.00109
G1 X150.034 Y119.754 E.09865
G1 X149.635 Y119.786 E.01229
G1 X148.435 Y119.883 E.03698
G1 X148.035 Y119.883 E.01229
G1 X144.389 Y119.883 E.11204
G1 X143.989 Y119.883 E.01229
G1 X140.343 Y119.883 E.11204
G1 X136.296 Y119.883 E.12433
G1 X133.599 Y119.883 E.08289
G1 X129.553 Y119.883 E.12433
G1 X125.506 Y119.883 E.12433
G1 X121.46 Y119.883 E.12433
G1 X117.414 Y119.883 E.12433
G1 X113.367 Y119.883 E.12433
G1 X109.321 Y119.883 E.12433
G1 X105.294 Y119.883 E.12375
M204 S10000
; WIPE_START
G1 F12000
G1 X105.255 Y121.882 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X104.444 Y119.287 Z13 F30000
G1 Z12.6
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.431684
G1 F9813
G1 X104.444 Y123.373 E.12944
G1 X105.836 Y117.116 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9813
G1 X104.394 Y117.116 E.04782
G1 X104.394 Y117.302 E.00619
G1 X106.234 Y119.142 E.08632
G1 X105.008 Y119.142 E.04068
G1 X105.008 Y118.939 E.00675
G1 X104.801 Y118.939 E.00686
G1 X106.624 Y117.116 E.08553
G1 X111.883 Y117.116 E.17445
G1 X113.91 Y119.142 E.09508
G1 X112.274 Y119.142 E.05429
G1 X114.3 Y117.116 E.09508
G1 X119.559 Y117.116 E.17445
G1 X121.586 Y119.142 E.09508
G1 X119.949 Y119.142 E.05429
G1 X121.976 Y117.116 E.09508
G1 X127.235 Y117.116 E.17445
G1 X129.262 Y119.142 E.09508
G1 X127.625 Y119.142 E.05429
G1 X129.652 Y117.116 E.09508
G1 X133.983 Y117.138 E.14366
G3 X135.287 Y117.491 I-.997 J6.264 E.04491
G1 X136.938 Y119.142 E.07744
G1 X135.301 Y119.142 E.05429
G1 X136.292 Y118.151 E.04648
G1 X138.583 Y119.428 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.55858
G1 F9813
G1 X148.417 Y119.428 E.41321
G1 X148.995 Y119.405 E.02429
; LINE_WIDTH: 0.491102
G1 X149.572 Y119.382 E.02111
; LINE_WIDTH: 0.445269
G1 X150.15 Y119.358 E.01895
; LINE_WIDTH: 0.399436
G1 X150.727 Y119.335 E.01679
; LINE_WIDTH: 0.353604
G1 X151.305 Y119.312 E.01463
; LINE_WIDTH: 0.307771
G1 X151.883 Y119.288 E.01248
; LINE_WIDTH: 0.261939
G1 X152.46 Y119.265 E.01032
; LINE_WIDTH: 0.216106
G1 X153.038 Y119.242 E.00816
; CHANGE_LAYER
; Z_HEIGHT: 12.8
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F15000
G1 X152.46 Y119.265 E-.76
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 64/101
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L64
M991 S0 P63 ;notify layer change
G17
G3 Z13 I-.315 J-1.175 P1  F30000
G1 X104.842 Y132.033 Z13
G1 Z12.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F10497
G1 X104.842 Y132.425 E.01301
G1 X138.38 Y132.425 E1.11252
G3 X136.454 Y134.115 I-64.58 J-71.675 E.08499
G3 X133.615 Y135.181 I-2.833 J-3.23 E.10279
G1 X104.046 Y135.181 E.98088
G1 X104.046 Y128.124 E.23408
G1 X104.842 Y128.124 E.0264
G1 X104.842 Y131.973 E.12767
G1 X105.234 Y132.033 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F10497
G1 X105.275 Y132.033 E.00126
G1 X107.972 Y132.033 E.08289
G1 X112.019 Y132.033 E.12433
G1 X116.065 Y132.033 E.12433
G1 X120.111 Y132.033 E.12433
G1 X124.157 Y132.033 E.12433
G1 X128.204 Y132.033 E.12433
G1 X132.25 Y132.033 E.12433
G1 X134.948 Y132.033 E.08289
G1 X138.994 Y132.033 E.12433
G1 X142.64 Y132.033 E.11204
G1 X143.04 Y132.033 E.01229
G1 X146.686 Y132.033 E.11204
G1 X147.086 Y132.033 E.01229
G1 F10200
G1 X148.435 Y132.033 E.04144
G1 F10497
G1 X148.834 Y132.066 E.01229
G1 X149.906 Y132.154 E.03306
G2 X153.234 Y132.424 I65.026 J-781.242 E.10258
G1 X153.234 Y132.464 E.00123
G1 X153.234 Y132.961 E.01529
G1 X138.364 Y132.961 E.45689
G3 X136.251 Y134.767 I-23.946 J-25.881 E.08544
G3 X133.627 Y135.573 I-2.682 J-4.063 E.08549
G1 X103.654 Y135.573 E.921
G1 X103.654 Y129.19 E.19611
G1 X103.654 Y128.79 E.01229
G1 X103.654 Y128.39 E.01229
G1 F4196.468
G1 X103.654 Y127.99 E.01229
G1 F720
G1 X103.654 Y127.732 E.00794
G1 X105.234 Y127.732 E.04855
G1 F2636.717
G1 X105.234 Y127.99 E.00794
G1 F7973.83
G1 X105.234 Y128.39 E.01229
G1 F10497
G1 X105.234 Y128.79 E.01229
G1 X105.234 Y131.973 E.09779
M204 S10000
; WIPE_START
G1 F12000
G1 X105.275 Y132.033 E-.02761
G1 X107.202 Y132.033 E-.73239
; WIPE_END
G1 E-.04 F1800
G1 X104.444 Y132.629 Z13.2 F30000
G1 Z12.8
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.431684
G1 F10497
G1 X104.444 Y128.328 E.13625
G1 X105.888 Y134.832 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F10497
G1 X104.394 Y134.832 E.04955
G1 X104.394 Y134.698 E.00447
G1 X106.319 Y132.773 E.09028
G1 X105.008 Y132.773 E.04348
G1 X105.008 Y132.977 E.00675
G1 X104.717 Y132.977 E.00966
G1 X106.572 Y134.832 E.08705
G1 X111.935 Y134.832 E.17791
G1 X113.994 Y132.773 E.0966
G1 X112.189 Y132.773 E.05989
G1 X114.248 Y134.832 E.0966
G1 X119.611 Y134.832 E.17791
G1 X121.67 Y132.773 E.0966
G1 X119.865 Y132.773 E.05989
G1 X121.924 Y134.832 E.0966
G1 X127.287 Y134.832 E.17791
G1 X129.346 Y132.773 E.0966
G1 X127.541 Y132.773 E.05989
G1 X129.6 Y134.832 E.0966
G1 X133.605 Y134.832 E.13285
G2 X135.381 Y134.415 I-.286 J-5.202 E.06082
G1 X137.022 Y132.773 E.07702
G1 X135.217 Y132.773 E.05989
G1 X136.263 Y133.819 E.04905
G1 X138.594 Y132.497 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.577913
G1 F10497
G1 X148.416 Y132.497 E.42818
G1 X149.003 Y132.521 E.0256
; LINE_WIDTH: 0.506986
G1 X149.589 Y132.545 E.0222
; LINE_WIDTH: 0.458794
G1 X150.176 Y132.569 E.0199
; LINE_WIDTH: 0.410602
G1 X150.763 Y132.594 E.01759
; LINE_WIDTH: 0.36241
G1 X151.349 Y132.618 E.01529
; LINE_WIDTH: 0.316902
G1 X151.912 Y132.64 E.01258
; LINE_WIDTH: 0.274093
G1 X152.475 Y132.663 E.01061
; LINE_WIDTH: 0.231297
G1 X153.038 Y132.685 E.00864
; WIPE_START
G1 F15000
G1 X152.475 Y132.663 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X145.115 Y130.641 Z13.2 F30000
G1 X104.842 Y119.575 Z13.2
G1 Z12.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F10497
G1 X104.842 Y123.876 E.14267
G1 X104.046 Y123.876 E.0264
G1 X104.046 Y116.819 E.23408
G1 X133.615 Y116.819 E.98088
G1 X133.866 Y116.834 E.00833
G3 X136.454 Y117.885 I-.21 J4.227 E.09442
G3 X138.38 Y119.575 I-62.654 J73.364 E.08499
G1 X104.902 Y119.575 E1.11053
G1 X105.234 Y119.967 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F10497
G1 X105.234 Y122.81 E.08734
G1 X105.234 Y123.21 E.01229
G1 X105.234 Y123.61 E.01229
G1 F4196.468
G1 X105.234 Y124.01 E.01229
G1 F720
G1 X105.234 Y124.268 E.00794
G1 X103.654 Y124.268 E.04855
G1 F2636.717
G1 X103.654 Y124.01 E.00794
G1 F7973.83
G1 X103.654 Y123.61 E.01229
G1 F10497
G1 X103.654 Y123.21 E.01229
G1 X103.654 Y116.427 E.2084
G1 X133.627 Y116.427 E.921
G1 X133.889 Y116.443 E.00807
G3 X136.702 Y117.582 I-.228 J4.605 E.09499
G3 X138.364 Y119.039 I-54.026 J63.327 E.06793
G1 X153.234 Y119.039 E.45689
G1 X153.234 Y119.536 E.01529
G1 X153.234 Y119.576 E.00123
M73 P74 R4
G1 X150.305 Y119.814 E.09029
G1 X149.906 Y119.846 E.01229
G1 F10200
G1 X148.435 Y119.967 E.04536
G1 F10497
G1 X148.035 Y119.967 E.01229
G1 X144.389 Y119.967 E.11204
G1 X143.989 Y119.967 E.01229
G1 X140.343 Y119.967 E.11204
G1 X136.296 Y119.967 E.12433
G1 X133.599 Y119.967 E.08289
G1 X129.552 Y119.967 E.12433
G1 X125.506 Y119.967 E.12433
G1 X121.46 Y119.967 E.12433
G1 X117.414 Y119.967 E.12433
G1 X113.367 Y119.967 E.12433
G1 X109.321 Y119.967 E.12433
G1 X105.294 Y119.967 E.12375
M204 S10000
; WIPE_START
G1 F12000
G1 X105.252 Y121.967 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X104.444 Y119.371 Z13.2 F30000
G1 Z12.8
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.431684
G1 F10497
G1 X104.444 Y123.672 E.13625
; WIPE_START
G1 F15000
G1 X104.444 Y121.672 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X112.031 Y120.84 Z13.2 F30000
G1 X136.263 Y118.181 Z13.2
G1 Z12.8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F10497
G1 X135.217 Y119.227 E.04905
G1 X137.022 Y119.227 E.05989
G1 X135.381 Y117.585 E.07702
G2 X133.605 Y117.168 I-1.823 J3.771 E.06099
G1 X129.6 Y117.168 E.13285
G1 X127.541 Y119.227 E.0966
G1 X129.346 Y119.227 E.05989
G1 X127.287 Y117.168 E.0966
G1 X121.924 Y117.168 E.17791
G1 X119.865 Y119.227 E.0966
G1 X121.67 Y119.227 E.05989
G1 X119.611 Y117.168 E.0966
G1 X114.248 Y117.168 E.17791
G1 X112.189 Y119.227 E.0966
G1 X113.994 Y119.227 E.05989
G1 X111.935 Y117.168 E.0966
G1 X106.572 Y117.168 E.17791
G1 X104.717 Y119.023 E.08705
G1 X105.008 Y119.023 E.00966
G1 X105.008 Y119.227 E.00675
G1 X106.319 Y119.227 E.04348
G1 X104.394 Y117.302 E.09028
G1 X104.394 Y117.168 E.00447
G1 X105.888 Y117.168 E.04955
G1 X138.594 Y119.503 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.577991
G1 F10497
G1 X148.416 Y119.503 E.42825
G1 X148.994 Y119.479 E.02521
; LINE_WIDTH: 0.510035
G1 X149.572 Y119.456 E.02201
; LINE_WIDTH: 0.463877
G1 X150.149 Y119.432 E.01983
; LINE_WIDTH: 0.417719
G1 X150.727 Y119.409 E.01766
; LINE_WIDTH: 0.371561
G1 X151.305 Y119.385 E.01548
; LINE_WIDTH: 0.325402
G1 X151.882 Y119.362 E.01331
; LINE_WIDTH: 0.279244
G1 X152.46 Y119.338 E.01113
; LINE_WIDTH: 0.233086
G1 X153.038 Y119.315 E.00896
; CHANGE_LAYER
; Z_HEIGHT: 13
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F15000
G1 X152.46 Y119.338 E-.76
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 65/101
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L65
M991 S0 P64 ;notify layer change
G17
G3 Z13.2 I-.323 J-1.173 P1  F30000
G1 X105.234 Y132.341 Z13.2
G1 Z13
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F10833
G1 X138.38 Y132.341 E1.09953
G3 X136.451 Y134.061 I-51.616 J-55.94 E.08577
G3 X133.615 Y135.129 I-2.838 J-3.239 E.10269
G1 X104.046 Y135.129 E.98088
G1 X104.046 Y127.719 E.2458
G1 X104.842 Y127.719 E.0264
G1 X104.842 Y132.341 E.15332
G1 X105.174 Y132.341 E.01102
G1 X105.234 Y131.949 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F10833
G1 X105.275 Y131.949 E.00126
G1 X107.972 Y131.949 E.08289
G1 X112.019 Y131.949 E.12433
G1 X116.065 Y131.949 E.12433
G1 X120.111 Y131.949 E.12433
G1 X124.157 Y131.949 E.12433
G1 X128.204 Y131.949 E.12433
G1 X132.25 Y131.949 E.12433
G1 X134.948 Y131.949 E.08289
G1 X138.994 Y131.949 E.12433
G1 X142.64 Y131.949 E.11204
G1 X143.04 Y131.949 E.01229
G1 X146.686 Y131.949 E.11204
G1 X147.086 Y131.949 E.01229
G1 F10200
G1 X148.435 Y131.949 E.04144
G1 F10833
G1 X148.834 Y131.981 E.01229
G1 X153.234 Y132.342 E.13565
G1 X153.234 Y132.383 E.00125
G1 X153.234 Y132.889 E.01554
G1 X138.362 Y132.889 E.45696
G3 X136.701 Y134.364 I-44.261 J-48.182 E.06828
G3 X133.627 Y135.521 I-3.082 J-3.526 E.1031
G1 X103.654 Y135.521 E.921
G1 X103.654 Y128.491 E.216
G1 X103.654 Y128.091 E.01229
G1 F8596.922
G1 X103.654 Y127.691 E.01229
G1 F3000
G1 X103.654 Y127.327 E.0112
G1 X105.234 Y127.327 E.04855
G1 F7984.365
G1 X105.234 Y127.691 E.0112
G1 F10833
G1 X105.234 Y128.091 E.01229
G1 X105.234 Y131.889 E.11669
M204 S10000
; WIPE_START
G1 F12000
G1 X105.275 Y131.949 E-.02761
G1 X107.202 Y131.949 E-.73239
; WIPE_END
G1 E-.04 F1800
G1 X104.444 Y132.544 Z13.4 F30000
G1 Z13
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.431684
G1 F10833
G1 X104.444 Y127.922 E.14642
G1 X104.394 Y134.283 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F10833
G1 X104.394 Y132.892 E.04611
G1 X104.632 Y132.892 E.0079
G1 X106.176 Y134.436 E.07242
G1 X104.656 Y134.436 E.05043
G1 X106.403 Y132.689 E.08196
G1 X112.105 Y132.689 E.18914
G1 X113.852 Y134.436 E.08196
G1 X112.332 Y134.436 E.05043
G1 X114.079 Y132.689 E.08196
G1 X119.781 Y132.689 E.18914
G1 X121.528 Y134.436 E.08196
G1 X120.008 Y134.436 E.05043
G1 X121.755 Y132.689 E.08196
G1 X127.457 Y132.689 E.18914
G1 X129.204 Y134.436 E.08196
G1 X127.684 Y134.436 E.05043
G1 X129.431 Y132.689 E.08196
G1 X131.059 Y132.689 E.05401
G1 X136.233 Y133.789 F30000
G1 F10833
G1 X135.133 Y132.689 E.05161
G1 X137.107 Y132.689 E.06549
G1 X135.492 Y134.303 E.07574
G3 X135.402 Y134.354 I-.246 J-.337 E.00345
M73 P75 R4
G1 X135.299 Y134.081 E.00966
G3 X134.11 Y134.402 I-1.903 J-4.691 E.04094
G1 X138.585 Y132.419 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.589534
G1 F10833
G1 X148.416 Y132.419 E.43787
G1 X148.994 Y132.442 E.02575
; LINE_WIDTH: 0.521219
G1 X149.571 Y132.466 E.02254
; LINE_WIDTH: 0.474817
G1 X150.149 Y132.489 E.02035
; LINE_WIDTH: 0.428415
G1 X150.727 Y132.513 E.01816
; LINE_WIDTH: 0.382013
G1 X151.305 Y132.537 E.01598
; LINE_WIDTH: 0.335611
G1 X151.882 Y132.56 E.01379
; LINE_WIDTH: 0.289209
G1 X152.46 Y132.584 E.0116
; LINE_WIDTH: 0.242807
G1 X153.038 Y132.608 E.00942
; WIPE_START
G1 F15000
G1 X152.46 Y132.584 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X144.835 Y132.933 Z13.4 F30000
G1 X104.392 Y134.782 Z13.4
G1 Z13
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.38292
G1 F10833
G1 X133.605 Y134.782 E.80937
G2 X135.042 Y134.512 I-.079 J-4.378 E.04068
; WIPE_START
G1 F15000
G1 X134.626 Y134.651 E-.16627
G1 X134.124 Y134.749 E-.19472
G1 X133.605 Y134.782 E-.19742
G1 X133.075 Y134.782 E-.20159
; WIPE_END
G1 E-.04 F1800
G1 X126.347 Y131.178 Z13.4 F30000
G1 X104.842 Y119.659 Z13.4
G1 Z13
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F10833
G1 X104.842 Y124.281 E.15332
G1 X104.046 Y124.281 E.0264
G1 X104.046 Y116.871 E.2458
G1 X133.728 Y116.878 E.98462
G3 X136.451 Y117.939 I-.099 J4.278 E.0989
G3 X138.38 Y119.659 I-49.687 J57.66 E.08577
G1 X104.902 Y119.659 E1.11054
G1 X105.234 Y120.051 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F10833
G1 X105.234 Y123.509 E.10624
G1 X105.234 Y123.909 E.01229
G1 F8596.922
G1 X105.234 Y124.309 E.01229
G1 F3000
G1 X105.234 Y124.673 E.0112
G1 X103.654 Y124.673 E.04855
G1 F7984.365
G1 X103.654 Y124.309 E.0112
G1 F10833
G1 X103.654 Y123.909 E.01229
G1 X103.654 Y116.479 E.22829
G1 X133.752 Y116.487 E.92483
G3 X136.701 Y117.636 I-.115 J4.652 E.09923
G3 X138.362 Y119.111 I-42.599 J49.657 E.06828
G1 X153.234 Y119.111 E.45696
G1 X153.234 Y119.617 E.01554
G1 X153.234 Y119.658 E.00125
G1 X151.233 Y119.822 E.06168
G1 X150.834 Y119.855 E.01229
G1 F10200
G1 X148.435 Y120.051 E.07397
G1 F10833
G1 X148.035 Y120.051 E.01229
G1 X144.389 Y120.051 E.11204
G1 X143.989 Y120.051 E.01229
G1 X140.343 Y120.051 E.11204
G1 X136.296 Y120.051 E.12433
G1 X133.599 Y120.051 E.08289
G1 X129.552 Y120.051 E.12433
G1 X125.506 Y120.051 E.12433
G1 X121.46 Y120.051 E.12433
G1 X117.414 Y120.051 E.12433
G1 X113.367 Y120.051 E.12433
G1 X109.321 Y120.051 E.12433
G1 X105.294 Y120.051 E.12375
M204 S10000
; WIPE_START
G1 F12000
G1 X105.259 Y122.051 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X104.444 Y119.456 Z13.4 F30000
G1 Z13
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.431684
G1 F10833
G1 X104.444 Y124.078 E.14642
; WIPE_START
G1 F15000
G1 X104.444 Y122.078 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X112.035 Y121.289 Z13.4 F30000
G1 X131.059 Y119.311 Z13.4
G1 Z13
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F10833
G1 X129.431 Y119.311 E.05401
G1 X127.69 Y117.57 E.08168
G1 X129.197 Y117.57 E.05002
G1 X127.457 Y119.311 E.08166
G1 X121.755 Y119.311 E.18914
G1 X120.012 Y117.568 E.08177
G1 X121.523 Y117.568 E.05015
G1 X119.781 Y119.311 E.08176
G1 X114.079 Y119.311 E.18914
G1 X112.334 Y117.566 E.08187
G1 X113.849 Y117.566 E.05028
G1 X112.105 Y119.311 E.08185
G1 X106.403 Y119.311 E.18914
G1 X104.656 Y117.564 E.08196
G1 X106.175 Y117.564 E.0504
G1 X104.632 Y119.108 E.07239
G1 X104.394 Y119.108 E.0079
G1 X104.394 Y117.717 E.04611
G1 X104.392 Y117.218 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.38292
G1 F10833
G1 X133.718 Y117.225 E.81249
G3 X135.042 Y117.488 I-.141 J4.176 E.03755
G1 X134.11 Y117.598 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F10833
G3 X135.299 Y117.919 I-.714 J5.012 E.04094
G1 X135.402 Y117.646 E.00966
G3 X135.492 Y117.697 I-.156 J.387 E.00345
G1 X137.107 Y119.311 E.07574
G1 X135.133 Y119.311 E.06549
G1 X136.233 Y118.211 E.05161
G1 X138.585 Y119.581 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.589534
G1 F10833
G1 X148.416 Y119.581 E.43787
G1 X148.994 Y119.558 E.02575
; LINE_WIDTH: 0.521219
G1 X149.571 Y119.534 E.02254
; LINE_WIDTH: 0.474818
G1 X150.149 Y119.511 E.02035
; LINE_WIDTH: 0.428416
G1 X150.727 Y119.487 E.01816
; LINE_WIDTH: 0.382014
G1 X151.305 Y119.463 E.01598
; LINE_WIDTH: 0.335612
G1 X151.882 Y119.44 E.01379
; LINE_WIDTH: 0.28921
G1 X152.46 Y119.416 E.0116
; LINE_WIDTH: 0.242808
G1 X153.038 Y119.392 E.00942
; CHANGE_LAYER
; Z_HEIGHT: 13.2
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F15000
G1 X152.46 Y119.416 E-.76
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 66/101
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L66
M991 S0 P65 ;notify layer change
G17
G3 Z13.4 I-.319 J-1.174 P1  F30000
G1 X105.234 Y132.232 Z13.4
G1 Z13.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F12081
G1 X138.404 Y132.232 E1.10033
G3 X136.326 Y134.087 I-49.98 J-53.89 E.09242
G3 X133.615 Y135.076 I-2.711 J-3.222 E.0977
G1 X104.046 Y135.076 E.98086
G1 X104.046 Y128.499 E.21815
G1 X104.046 Y128.099 E.01327
G1 F10078.064
G1 X104.046 Y127.699 E.01327
G1 F3899.032
G1 X104.046 Y127.299 E.01327
G1 F600
G1 X104.046 Y126.928 E.01232
G1 X104.842 Y126.928 E.0264
G1 F3566.68
G1 X104.842 Y127.299 E.01232
G1 F9539.238
G1 X104.842 Y127.699 E.01327
G1 F12081
G1 X104.842 Y128.099 E.01327
G1 X104.842 Y132.232 E.13708
G1 X105.174 Y132.232 E.01102
G1 X105.234 Y131.839 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
G1 X105.275 Y131.839 E.00126
G1 X107.972 Y131.839 E.08289
G1 X110.67 Y131.839 E.08289
G1 X113.367 Y131.839 E.08289
G1 X116.065 Y131.839 E.08289
G1 X118.762 Y131.839 E.08289
G1 X121.46 Y131.839 E.08289
G1 X124.157 Y131.839 E.08289
G1 X126.855 Y131.839 E.08289
G1 X129.552 Y131.839 E.08289
G1 X131.85 Y131.839 E.0706
G1 X132.25 Y131.839 E.01229
G1 F11100
G1 X134.547 Y131.839 E.0706
G1 X134.947 Y131.839 E.01229
G1 F10200
G1 X137.245 Y131.839 E.0706
G1 X137.645 Y131.839 E.01229
G1 F9300
G1 X139.942 Y131.839 E.0706
G1 X140.342 Y131.839 E.01229
G1 F8400
G1 X142.64 Y131.839 E.0706
G1 X143.04 Y131.839 E.01229
G1 F7500
G1 X145.337 Y131.839 E.0706
G1 X145.737 Y131.839 E.01229
G1 F6600
G1 X148.435 Y131.839 E.08289
G1 F7500
G1 X148.833 Y131.874 E.01229
G1 X150.65 Y132.029 E.05602
G1 F8400
G1 X151.048 Y132.063 E.01229
G1 X153.234 Y132.246 E.06739
G1 F9380.881
G1 X153.234 Y132.301 E.00169
G1 F12000
G1 X153.234 Y132.801 E.01538
G1 X138.362 Y132.801 E.45696
G3 X136.569 Y134.395 I-45.889 J-49.841 E.07372
G3 X133.627 Y135.468 I-2.948 J-3.515 E.09819
G1 X103.654 Y135.468 E.921
G1 X103.654 Y128.086 E.22683
G1 X103.654 Y127.686 E.01229
G1 F8596.922
G1 X103.654 Y127.286 E.01229
G1 F3000
G1 X103.654 Y126.917 E.01134
; FEATURE: Overhang wall
; LINE_WIDTH: 0.45

G1 X103.654 Y126.536 E.01264
G1 X105.234 Y126.536 E.05241
G1 X105.234 Y126.917 E.01264
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F8060.209
G1 X105.234 Y127.286 E.01134
G1 F12000
G1 X105.234 Y127.686 E.01229
G1 X105.234 Y131.779 E.12579
M204 S10000
; WIPE_START
G1 X105.275 Y131.839 E-.02761
G1 X107.202 Y131.839 E-.73239
; WIPE_END
G1 E-.04 F1800
G1 X104.444 Y132.435 Z13.6 F30000
G1 Z13.2
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.431684
G1 F12081
G1 X104.444 Y127.131 E.16802
G1 X104.401 Y134.72 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.38292
G1 F12081
G1 X133.604 Y134.72 E.8091
G2 X135.894 Y133.979 I-.041 J-4.037 E.06771
G1 X135.588 Y132.58 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F12081
G1 X137.216 Y132.58 E.05401
G1 X136.144 Y133.651 E.05026
G1 X135.024 Y132.58 E.05144
G1 X129.54 Y132.58 E.1819
G1 X127.754 Y134.365 E.08377
G1 X129.133 Y134.365 E.04574
G1 X127.348 Y132.58 E.08377
G1 X121.864 Y132.58 E.1819
G1 X120.078 Y134.365 E.08377
G1 X121.457 Y134.365 E.04574
G1 X119.672 Y132.58 E.08377
G1 X114.188 Y132.58 E.1819
G1 X112.402 Y134.365 E.08377
G1 X113.781 Y134.365 E.04574
G1 X111.996 Y132.58 E.08377
G1 X106.512 Y132.58 E.1819
G1 X104.726 Y134.365 E.08377
G1 X106.105 Y134.365 E.04574
G1 X104.523 Y132.783 E.07422
G1 X105.008 Y132.783 E.01608
G1 X105.008 Y132.58 E.00675
G1 X105.948 Y132.58 E.03119
G1 X138.598 Y132.32 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.61195
G1 F11071.474
G1 X148.414 Y132.32 E.45517
G1 X148.86 Y132.34 E.0207
; LINE_WIDTH: 0.554788
G1 F12081
G1 X149.306 Y132.359 E.01862
; LINE_WIDTH: 0.51612
G1 X149.752 Y132.378 E.01721
; LINE_WIDTH: 0.474475
G1 X150.3 Y132.401 E.0193
; LINE_WIDTH: 0.429886
G1 X150.848 Y132.424 E.01728
; LINE_WIDTH: 0.385323
G1 X151.395 Y132.447 E.01529
; LINE_WIDTH: 0.340761
G1 X151.943 Y132.47 E.0133
; LINE_WIDTH: 0.296198
G1 X152.49 Y132.493 E.01131
; LINE_WIDTH: 0.251636
G1 X153.038 Y132.516 E.00932
; WIPE_START
G1 F15000
G1 X152.49 Y132.493 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X145.116 Y130.524 Z13.6 F30000
G1 X104.842 Y119.768 Z13.6
G1 Z13.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F12081
G1 X104.842 Y123.501 E.12381
G1 X104.842 Y123.901 E.01327
G1 F10078.064
G1 X104.842 Y124.301 E.01327
G1 F3899.032
G1 X104.842 Y124.701 E.01327
G1 F600
G1 X104.842 Y125.072 E.01232
G1 X104.046 Y125.072 E.0264
G1 F3566.68
G1 X104.046 Y124.701 E.01232
G1 F9539.238
G1 X104.046 Y124.301 E.01327
G1 F12081
G1 X104.046 Y123.901 E.01327
G1 X104.046 Y116.924 E.23142
G1 X133.615 Y116.924 E.98086
G1 X134.124 Y116.956 E.01692
G3 X136.446 Y118.01 I-.552 J4.3 E.08585
G3 X138.404 Y119.768 I-50.795 J58.523 E.08732
G1 X104.902 Y119.768 E1.11134
G1 X105.234 Y120.161 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
G1 X105.234 Y123.914 E.11535
G1 X105.234 Y124.314 E.01229
G1 F8596.922
G1 X105.234 Y124.714 E.01229
G1 F3000
G1 X105.234 Y125.083 E.01134
; FEATURE: Overhang wall
; LINE_WIDTH: 0.45

G1 X105.234 Y125.464 E.01264
G1 X103.654 Y125.464 E.05241
G1 X103.654 Y125.083 E.01264
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F8060.209
G1 X103.654 Y124.714 E.01134
G1 F12000
G1 X103.654 Y124.314 E.01229
G1 X103.654 Y116.532 E.23912
G1 X133.627 Y116.532 E.921
G1 X134.172 Y116.566 E.01677
G3 X136.699 Y117.71 I-.594 J4.675 E.08652
G3 X138.362 Y119.199 I-42.991 J49.705 E.06859
G1 X153.234 Y119.199 E.45696
G1 X153.234 Y119.699 E.01538
G1 F8400
G1 X153.234 Y119.754 E.00169
G1 X151.91 Y119.865 E.04083
G1 X151.511 Y119.898 E.01229
G1 F7500
G1 X150.187 Y120.01 E.04083
G1 X149.788 Y120.043 E.01229
G1 F6600
G1 X148.435 Y120.161 E.04174
G1 X147.086 Y120.161 E.04144
G1 F7500
G1 X146.686 Y120.161 E.01229
G1 X144.388 Y120.161 E.0706
G1 F8400
G1 X143.988 Y120.161 E.01229
G1 X141.691 Y120.161 E.0706
G1 F9300
G1 X141.291 Y120.161 E.01229
G1 X138.993 Y120.161 E.0706
G1 F10200
G1 X138.593 Y120.161 E.01229
G1 X136.296 Y120.161 E.0706
G1 F11100
G1 X135.896 Y120.161 E.01229
G1 X133.598 Y120.161 E.0706
G1 F12000
G1 X133.198 Y120.161 E.01229
G1 X130.901 Y120.161 E.0706
G1 X128.203 Y120.161 E.08289
G1 X125.506 Y120.161 E.08289
G1 X122.808 Y120.161 E.08289
G1 X120.111 Y120.161 E.08289
G1 X117.413 Y120.161 E.08289
G1 X114.716 Y120.161 E.08289
G1 X112.018 Y120.161 E.08289
G1 X109.321 Y120.161 E.08289
G1 X105.294 Y120.161 E.12375
M204 S10000
G1 X105.948 Y119.42 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F12081
G1 X105.008 Y119.42 E.03119
G1 X105.008 Y119.217 E.00675
G1 X104.523 Y119.217 E.01608
G1 X106.105 Y117.635 E.07422
G1 X104.726 Y117.635 E.04574
G1 X106.512 Y119.42 E.08377
G1 X111.996 Y119.42 E.1819
G1 X113.781 Y117.635 E.08377
G1 X112.402 Y117.635 E.04574
G1 X114.188 Y119.42 E.08377
G1 X119.672 Y119.42 E.1819
G1 X121.457 Y117.635 E.08377
G1 X120.078 Y117.635 E.04574
G1 X121.864 Y119.42 E.08377
G1 X127.348 Y119.42 E.1819
G1 X129.133 Y117.635 E.08377
G1 X127.754 Y117.635 E.04574
G1 X129.54 Y119.42 E.08377
G1 X135.024 Y119.42 E.1819
G1 X136.144 Y118.349 E.05144
G1 X137.216 Y119.42 E.05026
G1 X135.588 Y119.42 E.05401
G1 X138.598 Y119.68 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.61195
G1 F11071.473
G1 X148.414 Y119.68 E.45517
G1 X148.86 Y119.66 E.0207
; LINE_WIDTH: 0.554789
G1 F12081
G1 X149.306 Y119.641 E.01862
; LINE_WIDTH: 0.51612
G1 X149.752 Y119.622 E.01721
; LINE_WIDTH: 0.474474
G1 X150.3 Y119.599 E.01929
; LINE_WIDTH: 0.429885
G1 X150.848 Y119.576 E.01728
; LINE_WIDTH: 0.385323
G1 X151.395 Y119.553 E.01529
; LINE_WIDTH: 0.340761
G1 X151.943 Y119.53 E.0133
; LINE_WIDTH: 0.296198
G1 X152.49 Y119.507 E.01131
; LINE_WIDTH: 0.251636
G1 X153.038 Y119.484 E.00932
G1 X104.444 Y119.565 F30000
; LINE_WIDTH: 0.431684
G1 F12081
G1 X104.444 Y124.869 E.16802
G1 X104.401 Y117.28 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.38292
G1 F12081
G1 X133.605 Y117.28 E.80912
G3 X135.894 Y118.021 I-.041 J4.033 E.06769
; CHANGE_LAYER
; Z_HEIGHT: 13.4
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F15000
G1 X135.538 Y117.791 E-.16086
G1 X135.087 Y117.569 E-.19102
G1 X134.614 Y117.411 E-.18976
G1 X134.111 Y117.313 E-.1946
G1 X134.049 Y117.309 E-.02376
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 67/101
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L67
M991 S0 P66 ;notify layer change
G17
G3 Z13.6 I-.107 J-1.212 P1  F30000
G1 X104.842 Y119.879 Z13.6
G1 Z13.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F10410
G1 X104.842 Y124.692 E.15964
G1 X104.842 Y125.092 E.01327
G1 F8596.922
G1 X104.842 Y125.492 E.01327
G1 F3000
G1 X104.842 Y125.874 E.01269
M204 S5000
; FEATURE: Overhang wall

G1 X104.842 Y126.126 E.00833
M204 S10000
; FEATURE: Inner wall
G1 F8291.813
G1 X104.842 Y126.508 E.01269
G1 F10410
G1 X104.842 Y126.908 E.01327
G1 X104.842 Y132.121 E.17291
G1 X138.43 Y132.121 E1.11419
G3 X136.193 Y134.119 I-31.408 J-32.911 E.09951
G3 X133.615 Y135.005 I-2.573 J-3.292 E.09212
G1 X104.046 Y135.005 E.98086
G1 X104.046 Y127.308 E.25531
G1 X104.046 Y126.908 E.01327
G1 F8596.922
G1 X104.046 Y126.508 E.01327
G1 F3000
G1 X104.046 Y126.126 E.01269
M204 S5000
; FEATURE: Overhang wall

G1 X104.046 Y125.874 E.00833
M204 S10000
; FEATURE: Inner wall
G1 F8291.813
G1 X104.046 Y125.492 E.01269
G1 F10410
G1 X104.046 Y125.092 E.01327
G1 X104.046 Y116.995 E.26858
G1 X133.615 Y116.995 E.98086
G1 X134.019 Y117.02 E.01344
G1 X134.137 Y117.027 E.00392
G3 X136.446 Y118.085 I-.537 J4.221 E.08554
G3 X138.43 Y119.879 I-51.843 J59.312 E.08875
G1 X104.902 Y119.879 E1.1122
G1 X105.234 Y120.271 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F10410
G1 X105.234 Y124.705 E.13625
G1 X105.234 Y125.105 E.01229
G1 F8596.922
G1 X105.234 Y125.505 E.01229
G1 F3000
G1 X105.234 Y125.874 E.01134
; FEATURE: Overhang wall
; LINE_WIDTH: 0.45

G1 X105.234 Y126.126 E.00833
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F8060.209
G1 X105.234 Y126.495 E.01134
G1 F10410
G1 X105.234 Y126.895 E.01229
G1 X105.234 Y131.729 E.14854
G1 X105.275 Y131.729 E.00126
G1 X107.972 Y131.729 E.08289
G1 X110.67 Y131.729 E.08289
G1 X113.367 Y131.729 E.08289
G1 X116.065 Y131.729 E.08289
G1 X118.762 Y131.729 E.08289
G1 X121.46 Y131.729 E.08289
G1 X124.157 Y131.729 E.08289
G1 X126.855 Y131.729 E.08289
G1 X129.552 Y131.729 E.08289
G1 X131.85 Y131.729 E.0706
G1 X132.25 Y131.729 E.01229
G1 X134.547 Y131.729 E.0706
G1 X134.947 Y131.729 E.01229
G1 F10200
G1 X137.245 Y131.729 E.0706
G1 X137.645 Y131.729 E.01229
G1 F9300
G1 X139.942 Y131.729 E.0706
M73 P76 R4
G1 X140.342 Y131.729 E.01229
G1 F8400
G1 X142.64 Y131.729 E.0706
G1 X143.04 Y131.729 E.01229
G1 F7500
G1 X145.337 Y131.729 E.0706
G1 X145.737 Y131.729 E.01229
G1 F6600
G1 X148.435 Y131.729 E.08289
G1 X149.839 Y131.851 E.04332
G2 X153.234 Y132.14 I51.015 J-579.165 E.10468
G1 F7645.676
G1 X153.234 Y132.205 E.00201
G1 F10410
G1 X153.234 Y132.714 E.01565
G1 X138.362 Y132.714 E.45696
G3 X136.436 Y134.427 I-27.413 J-28.895 E.07921
G3 X133.627 Y135.397 I-2.808 J-3.579 E.09302
G1 X103.654 Y135.397 E.921
G1 X103.654 Y127.295 E.24896
G1 X103.654 Y126.895 E.01229
G1 F8596.922
G1 X103.654 Y126.495 E.01229
G1 F3000
G1 X103.654 Y126.126 E.01134
; FEATURE: Overhang wall
; LINE_WIDTH: 0.45

G1 X103.654 Y125.874 E.00833
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F8060.209
G1 X103.654 Y125.505 E.01134
G1 F10410
G1 X103.654 Y125.105 E.01229
G1 X103.654 Y116.603 E.26125
G1 X133.627 Y116.603 E.921
G1 X134.043 Y116.629 E.01282
G1 X134.185 Y116.637 E.00437
G3 X136.699 Y117.785 I-.579 J4.594 E.08622
G3 X138.362 Y119.286 I-43.349 J49.715 E.06884
G1 X153.234 Y119.286 E.45696
G1 X153.234 Y119.795 E.01565
G1 F6600
G1 X153.234 Y119.86 E.00201
G2 X148.435 Y120.271 I92.514 J1108.509 E.148
G1 X147.086 Y120.271 E.04144
G1 F7500
G1 X146.686 Y120.271 E.01229
G1 X144.388 Y120.271 E.0706
G1 F8400
G1 X143.988 Y120.271 E.01229
G1 X141.691 Y120.271 E.0706
G1 F9300
G1 X141.291 Y120.271 E.01229
G1 X138.993 Y120.271 E.0706
G1 F10200
G1 X138.593 Y120.271 E.01229
G1 X136.296 Y120.271 E.0706
G1 F10410
G1 X135.896 Y120.271 E.01229
G1 X133.598 Y120.271 E.0706
G1 X133.198 Y120.271 E.01229
G1 X130.901 Y120.271 E.0706
G1 X128.203 Y120.271 E.08289
G1 X125.506 Y120.271 E.08289
G1 X122.808 Y120.271 E.08289
G1 X120.111 Y120.271 E.08289
G1 X117.413 Y120.271 E.08289
G1 X114.716 Y120.271 E.08289
G1 X112.018 Y120.271 E.08289
G1 X109.321 Y120.271 E.08289
G1 X105.294 Y120.271 E.12375
M204 S10000
; WIPE_START
G1 F12000
G1 X105.267 Y122.271 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X104.444 Y119.676 Z13.8 F30000
G1 Z13.4
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.431684
G1 F10410
G1 X104.444 Y132.324 E.4007
G1 X105.837 Y132.469 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F10410
G1 X105.008 Y132.469 E.02751
G1 X105.008 Y132.673 E.00675
G1 X104.412 Y132.673 E.01975
G1 X106.015 Y134.275 E.07518
G1 X104.817 Y134.275 E.03974
G1 X106.623 Y132.469 E.08472
G1 X111.885 Y132.469 E.17455
G1 X113.691 Y134.275 E.08472
G1 X112.493 Y134.275 E.03974
G1 X114.299 Y132.469 E.08472
G1 X119.561 Y132.469 E.17455
G1 X121.367 Y134.275 E.08472
G1 X120.169 Y134.275 E.03974
G1 X121.975 Y132.469 E.08472
G1 X127.237 Y132.469 E.17455
G1 X129.043 Y134.275 E.08472
G1 X127.845 Y134.275 E.03974
G1 X129.651 Y132.469 E.08472
G1 X134.913 Y132.469 E.17455
G1 X135.904 Y133.461 E.04652
G3 X134.456 Y134.172 I-2.368 J-2.989 E.05395
G1 X138.61 Y132.221 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.635142
G1 F10410
G1 X148.413 Y132.221 E.47307
G1 X148.973 Y132.246 E.02704
; LINE_WIDTH: 0.563664
G1 X149.533 Y132.27 E.02377
; LINE_WIDTH: 0.515137
G1 X150.092 Y132.294 E.02156
; LINE_WIDTH: 0.466611
G1 X150.652 Y132.319 E.01934
; LINE_WIDTH: 0.418084
G1 X151.212 Y132.343 E.01713
; LINE_WIDTH: 0.369757
G1 X151.821 Y132.368 E.01623
; LINE_WIDTH: 0.321655
G1 X152.429 Y132.394 E.01383
; LINE_WIDTH: 0.273573
G1 X153.038 Y132.419 E.01145
; WIPE_START
G1 F15000
G1 X152.429 Y132.394 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X152.429 Y124.761 Z13.8 F30000
G1 X152.429 Y119.606 Z13.8
G1 Z13.4
G1 E.8 F1800
; LINE_WIDTH: 0.273572
G1 F10410
G1 X153.038 Y119.581 E.01145
G1 X152.429 Y119.606 F30000
; LINE_WIDTH: 0.321654
G1 F10410
G1 X151.821 Y119.632 E.01383
; LINE_WIDTH: 0.369756
G1 X151.212 Y119.657 E.01623
; LINE_WIDTH: 0.418082
G1 X150.652 Y119.681 E.01713
; LINE_WIDTH: 0.466609
G1 X150.092 Y119.706 E.01934
; LINE_WIDTH: 0.515136
G1 X149.533 Y119.73 E.02156
; LINE_WIDTH: 0.563662
G1 X148.973 Y119.754 E.02377
; LINE_WIDTH: 0.635142
G1 X148.413 Y119.779 E.02704
G1 X138.61 Y119.779 E.47307
G1 X134.455 Y117.83 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F10410
G3 X135.904 Y118.539 I-.889 J3.65 E.05394
G1 X134.913 Y119.531 E.04652
G1 X129.651 Y119.531 E.17455
G1 X127.845 Y117.725 E.08472
G1 X129.043 Y117.725 E.03974
G1 X127.237 Y119.531 E.08472
G1 X121.975 Y119.531 E.17455
G1 X120.169 Y117.725 E.08472
G1 X121.367 Y117.725 E.03974
G1 X119.561 Y119.531 E.08472
G1 X114.299 Y119.531 E.17455
G1 X112.493 Y117.725 E.08472
G1 X113.691 Y117.725 E.03974
G1 X111.885 Y119.531 E.08472
G1 X106.623 Y119.531 E.17455
G1 X104.817 Y117.725 E.08472
G1 X106.015 Y117.725 E.03974
G1 X104.412 Y119.327 E.07518
G1 X105.008 Y119.327 E.01975
G1 X105.008 Y119.531 E.00675
G1 X105.837 Y119.531 E.02751
G1 X104.411 Y117.36 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.38295
G1 F10410
G1 X133.599 Y117.36 E.80875
G1 X134.553 Y117.477 E.02664
G3 X136.378 Y118.484 I-1.076 J4.104 E.05834
G3 X137.4 Y119.444 I-9.152 J10.77 E.03886
; WIPE_START
G1 F15000
G1 X137.356 Y119.382 E-.02866
G1 X136.378 Y118.484 E-.50469
G1 X135.96 Y118.14 E-.20582
G1 X135.914 Y118.11 E-.02083
; WIPE_END
G1 E-.04 F1800
G1 X129.155 Y121.656 Z13.8 F30000
G1 X104.411 Y134.64 Z13.8
G1 Z13.4
G1 E.8 F1800
; LINE_WIDTH: 0.38295
G1 F10410
G1 X133.604 Y134.64 E.80888
G2 X136.386 Y133.507 I-.068 J-4.15 E.08519
G1 X137.346 Y132.618 E.03625
G1 X137.391 Y132.556 E.0021
; CHANGE_LAYER
; Z_HEIGHT: 13.6
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F15000
G1 X137.346 Y132.618 E-.02881
G1 X136.386 Y133.507 E-.49715
G1 X135.98 Y133.845 E-.2009
G1 X135.907 Y133.892 E-.03314
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 68/101
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L68
M991 S0 P67 ;notify layer change
G17
G3 Z13.8 I.497 J-1.111 P1  F30000
G1 X104.842 Y119.99 Z13.8
G1 Z13.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F10084
G1 X104.842 Y132.01 E.39872
G1 X138.456 Y132.01 E1.11505
G3 X136.447 Y133.84 I-54.882 J-58.251 E.09015
G3 X133.615 Y134.934 I-2.83 J-3.112 E.10303
G1 X104.046 Y134.934 E.98086
G1 X104.046 Y117.066 E.59273
G1 X133.615 Y117.066 E.98086
G1 X133.878 Y117.082 E.00876
G3 X136.447 Y118.16 I-.23 J4.144 E.09422
G3 X138.456 Y119.99 I-52.862 J60.069 E.09015
G1 X104.902 Y119.99 E1.11306
G1 X105.234 Y120.382 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F10084
G1 X105.234 Y131.618 E.34524
G1 X105.275 Y131.618 E.00126
G1 X107.972 Y131.618 E.08289
G1 X110.67 Y131.618 E.08289
G1 X113.367 Y131.618 E.08289
G1 X116.065 Y131.618 E.08289
G1 X118.762 Y131.618 E.08289
G1 X121.46 Y131.618 E.08289
G1 X124.157 Y131.618 E.08289
G1 X126.855 Y131.618 E.08289
G1 X129.552 Y131.618 E.08289
G1 X131.85 Y131.618 E.0706
G1 X132.25 Y131.618 E.01229
G1 X134.547 Y131.618 E.0706
G1 X134.947 Y131.618 E.01229
G1 X137.245 Y131.618 E.0706
G1 X137.645 Y131.618 E.01229
G1 F9300
G1 X139.942 Y131.618 E.0706
G1 X140.342 Y131.618 E.01229
G1 F8400
G1 X142.64 Y131.618 E.0706
G1 X143.04 Y131.618 E.01229
G1 F7500
G1 X145.337 Y131.618 E.0706
G1 X145.737 Y131.618 E.01229
G1 F6600
G1 X148.435 Y131.618 E.08289
G1 X153.234 Y132.033 E.14801
G1 F7653.741
G1 X153.234 Y132.099 E.00202
G1 F10084
G1 X153.234 Y132.627 E.01624
G1 X138.362 Y132.627 E.45696
G3 X136.699 Y134.14 I-45.362 J-48.203 E.06908
G3 X133.627 Y135.326 I-3.078 J-3.399 E.10351
G1 X103.654 Y135.326 E.921
G1 X103.654 Y116.674 E.57314
G1 X133.627 Y116.674 E.921
G1 X133.902 Y116.691 E.00848
G3 X136.699 Y117.86 I-.248 J4.521 E.09498
G3 X138.362 Y119.373 I-43.695 J49.711 E.06908
G1 X153.234 Y119.373 E.45696
G1 X153.234 Y119.902 E.01624
G1 F6600
G1 X153.234 Y119.967 E.00202
G1 X148.435 Y120.382 E.14801
G1 X147.086 Y120.382 E.04144
G1 F7500
G1 X146.686 Y120.382 E.01229
G1 X144.388 Y120.382 E.0706
G1 F8400
G1 X143.988 Y120.382 E.01229
G1 X141.691 Y120.382 E.0706
G1 F9300
G1 X141.291 Y120.382 E.01229
G1 X138.993 Y120.382 E.0706
G1 F10084
G1 X138.593 Y120.382 E.01229
G1 X136.296 Y120.382 E.0706
G1 X135.896 Y120.382 E.01229
G1 X133.598 Y120.382 E.0706
G1 X133.198 Y120.382 E.01229
G1 X130.901 Y120.382 E.0706
G1 X128.203 Y120.382 E.08289
G1 X125.506 Y120.382 E.08289
G1 X122.808 Y120.382 E.08289
G1 X120.111 Y120.382 E.08289
G1 X117.413 Y120.382 E.08289
G1 X114.716 Y120.382 E.08289
G1 X112.018 Y120.382 E.08289
G1 X109.321 Y120.382 E.08289
G1 X105.294 Y120.382 E.12375
M204 S10000
G1 X105.726 Y119.642 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F10084
G1 X105.008 Y119.642 E.02384
G1 X105.008 Y119.438 E.00675
G1 X104.394 Y119.438 E.02036
G1 X104.394 Y119.346 E.00307
G1 X105.924 Y117.815 E.07179
G1 X104.907 Y117.815 E.03374
G1 X106.734 Y119.642 E.08568
G1 X111.774 Y119.642 E.1672
G1 X113.6 Y117.815 E.08568
G1 X112.583 Y117.815 E.03374
G1 X114.41 Y119.642 E.08568
G1 X119.45 Y119.642 E.1672
G1 X121.276 Y117.815 E.08568
G1 X120.259 Y117.815 E.03374
G1 X122.086 Y119.642 E.08568
G1 X127.126 Y119.642 E.1672
G1 X128.952 Y117.815 E.08568
G1 X127.935 Y117.815 E.03374
G1 X129.761 Y119.642 E.08568
G1 X134.802 Y119.642 E.1672
G1 X135.852 Y118.591 E.04928
G2 X134.392 Y117.906 I-2.272 J2.941 E.05393
G1 X138.623 Y119.877 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.658759
G1 F10084
G1 X148.413 Y119.877 E.49127
G1 X148.991 Y119.853 E.02904
; LINE_WIDTH: 0.587148
G1 X149.569 Y119.828 E.02566
; LINE_WIDTH: 0.538504
G1 X150.147 Y119.803 E.02337
; LINE_WIDTH: 0.48986
G1 X150.725 Y119.778 E.02107
; LINE_WIDTH: 0.441215
G1 X151.303 Y119.753 E.01878
; LINE_WIDTH: 0.392571
G1 X151.882 Y119.728 E.01649
; LINE_WIDTH: 0.343927
G1 X152.46 Y119.703 E.01419
; LINE_WIDTH: 0.295283
G1 X153.038 Y119.678 E.0119
; WIPE_START
G1 F15000
G1 X152.46 Y119.703 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X152.46 Y127.335 Z14 F30000
G1 X152.46 Y132.297 Z14
G1 Z13.6
G1 E.8 F1800
; LINE_WIDTH: 0.295285
G1 F10084
G1 X153.038 Y132.322 E.0119
G1 X152.46 Y132.297 F30000
; LINE_WIDTH: 0.343929
G1 F10084
G1 X151.882 Y132.272 E.01419
; LINE_WIDTH: 0.392573
G1 X151.303 Y132.247 E.01649
; LINE_WIDTH: 0.441217
G1 X150.725 Y132.222 E.01878
; LINE_WIDTH: 0.489862
G1 X150.147 Y132.197 E.02107
; LINE_WIDTH: 0.538506
G1 X149.569 Y132.172 E.02337
; LINE_WIDTH: 0.58715
G1 X148.991 Y132.147 E.02566
; LINE_WIDTH: 0.658757
G1 X148.413 Y132.123 E.02904
G1 X138.623 Y132.123 E.49127
G1 X134.393 Y134.094 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F10084
G2 X135.853 Y133.41 I-.823 J-3.658 E.05394
G1 X134.802 Y132.358 E.04933
G1 X129.761 Y132.358 E.1672
G1 X127.935 Y134.185 E.08568
G1 X128.952 Y134.185 E.03374
G1 X127.126 Y132.358 E.08568
G1 X122.086 Y132.358 E.1672
G1 X120.259 Y134.185 E.08568
G1 X121.276 Y134.185 E.03374
G1 X119.45 Y132.358 E.08568
G1 X114.41 Y132.358 E.1672
G1 X112.583 Y134.185 E.08568
G1 X113.6 Y134.185 E.03374
G1 X111.774 Y132.358 E.08568
G1 X106.734 Y132.358 E.1672
G1 X104.907 Y134.185 E.08568
G1 X105.924 Y134.185 E.03374
G1 X104.394 Y132.654 E.07179
G1 X104.394 Y132.562 E.00307
G1 X105.008 Y132.562 E.02036
G1 X105.008 Y132.358 E.00675
G1 X105.726 Y132.358 E.02384
G1 X104.444 Y132.213 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.431684
G1 F10084
G1 X104.444 Y119.787 E.39368
G1 X104.421 Y117.441 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.385269
G1 F10084
G1 X133.603 Y117.441 E.81412
G1 X134.544 Y117.555 E.02643
G3 X135.954 Y118.22 I-1.11 J4.181 E.04373
G3 X137.402 Y119.546 I-12.384 J14.978 E.05477
; WIPE_START
G1 F15000
G1 X137.357 Y119.484 E-.0287
G1 X136.51 Y118.689 E-.44154
G1 X135.954 Y118.22 E-.27641
G1 X135.925 Y118.201 E-.01335
; WIPE_END
G1 E-.04 F1800
G1 X129.151 Y121.718 Z14 F30000
G1 X104.421 Y134.559 Z14
G1 Z13.6
G1 E.8 F1800
; LINE_WIDTH: 0.385242
G1 F10084
G1 X133.604 Y134.559 E.81405
G2 X136.391 Y133.416 I-.061 J-4.119 E.08605
G1 X137.355 Y132.515 E.0368
G1 X137.4 Y132.454 E.00211
; CHANGE_LAYER
; Z_HEIGHT: 13.8
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F15000
G1 X137.355 Y132.515 E-.02878
G1 X136.391 Y133.416 E-.5013
G1 X135.979 Y133.764 E-.20515
G1 X135.924 Y133.8 E-.02476
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 69/101
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L69
M991 S0 P68 ;notify layer change
G17
G3 Z14 I.49 J-1.114 P1  F30000
G1 X104.842 Y120.13 Z14
G1 Z13.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F11920
G1 X104.842 Y131.87 E.38947
G1 X148.416 Y131.87 E1.44543
G1 X148.642 Y131.891 E.00753
G1 X148.631 Y132.124 E.00773
G1 X138.202 Y132.124 E.34596
G3 X136.442 Y133.763 I-39.18 J-40.312 E.07975
G3 X133.615 Y134.864 I-2.844 J-3.124 E.10294
G1 X104.046 Y134.864 E.98086
G1 X104.046 Y117.136 E.58804
G1 X133.738 Y117.144 E.98493
G3 X136.442 Y118.237 I-.123 J4.197 E.09883
G3 X138.202 Y119.876 I-37.421 J41.951 E.07975
G1 X148.631 Y119.876 E.34596
G1 X148.642 Y120.109 E.00773
G1 X148.416 Y120.13 E.00753
G1 X104.902 Y120.13 E1.44344
G1 X105.234 Y120.522 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F11920
G1 X105.234 Y131.478 E.33667
G1 X105.275 Y131.478 E.00126
G1 X106.623 Y131.478 E.04144
G1 X109.321 Y131.478 E.08289
G1 X110.67 Y131.478 E.04144
G1 X113.367 Y131.478 E.08289
G1 X114.716 Y131.478 E.04144
G1 X117.413 Y131.478 E.08289
G1 X118.762 Y131.478 E.04144
G1 X121.459 Y131.478 E.08289
G1 X122.808 Y131.478 E.04144
G1 X125.106 Y131.478 E.07059
G1 X125.506 Y131.478 E.01229
G1 F11100
G1 X127.803 Y131.478 E.07059
G1 X128.203 Y131.478 E.01229
G1 F10200
G1 X129.152 Y131.478 E.02915
G1 X129.552 Y131.478 E.01229
G1 F9300
G1 X131.849 Y131.478 E.07059
G1 X132.249 Y131.478 E.01229
G1 F8400
G1 X133.198 Y131.478 E.02915
G1 X133.598 Y131.478 E.01229
G1 F7500
G1 X135.895 Y131.478 E.07059
G1 X136.295 Y131.478 E.01229
G1 F6600
G1 X137.244 Y131.478 E.02915
G1 X137.644 Y131.478 E.01229
G1 F5700
G1 X139.942 Y131.478 E.07059
G1 X140.342 Y131.478 E.01229
G1 F4800
G1 X141.29 Y131.478 E.02915
G1 X141.69 Y131.478 E.01229
G1 F3900
G1 X143.988 Y131.478 E.07059
G1 X144.388 Y131.478 E.01229
G1 F3000
G1 X145.737 Y131.478 E.04144
G1 F2880
G1 X148.434 Y131.478 E.08289
G1 F3000
G1 X149.869 Y131.612 E.04429
G1 F3900
G1 X150.268 Y131.647 E.01229
G1 X152.393 Y131.837 E.06556
G1 F4800
G1 X153.234 Y131.912 E.02595
G1 F5907.827
G1 X153.234 Y131.992 E.00246
G1 F11920
G1 X153.234 Y132.516 E.01613
G1 X138.359 Y132.516 E.45705
G3 X136.698 Y134.06 I-36.929 J-38.077 E.0697
G3 X133.627 Y135.256 I-3.094 J-3.408 E.10354
G1 X103.654 Y135.256 E.921
G1 X103.654 Y116.744 E.5688
G1 X133.762 Y116.753 E.92513
G3 X136.698 Y117.94 I-.141 J4.573 E.09936
G3 X138.359 Y119.484 I-35.267 J39.621 E.0697
G1 X153.234 Y119.484 E.45705
G1 X153.234 Y120.008 E.01613
G1 F4800
G1 X153.234 Y120.088 E.00246
G1 F3900
G1 X151.109 Y120.278 E.06556
M73 P77 R4
G1 X150.71 Y120.313 E.01229
G1 F3000
G1 X149.869 Y120.388 E.02595
G1 F2880
G1 X148.434 Y120.522 E.04429
G1 X147.085 Y120.522 E.04144
G1 F3000
G1 X145.737 Y120.522 E.04144
G1 F3900
G1 X145.337 Y120.522 E.01229
G1 X143.039 Y120.522 E.07059
G1 F4800
G1 X142.639 Y120.522 E.01229
G1 X141.69 Y120.522 E.02915
G1 F5700
G1 X141.29 Y120.522 E.01229
G1 X138.993 Y120.522 E.07059
G1 F6600
G1 X138.593 Y120.522 E.01229
G1 X137.644 Y120.522 E.02915
G1 F7500
G1 X137.244 Y120.522 E.01229
G1 X134.947 Y120.522 E.07059
G1 F8400
G1 X134.547 Y120.522 E.01229
G1 X133.598 Y120.522 E.02915
G1 F9300
G1 X133.198 Y120.522 E.01229
G1 X130.901 Y120.522 E.07059
G1 F10200
G1 X130.501 Y120.522 E.01229
G1 X129.552 Y120.522 E.02915
G1 F11100
G1 X129.152 Y120.522 E.01229
G1 X126.854 Y120.522 E.07059
G1 F11920
G1 X126.454 Y120.522 E.01229
G1 X124.157 Y120.522 E.07059
G1 X122.808 Y120.522 E.04144
G1 X120.111 Y120.522 E.08289
G1 X118.762 Y120.522 E.04144
G1 X116.065 Y120.522 E.08289
G1 X114.716 Y120.522 E.04144
G1 X112.018 Y120.522 E.08289
G1 X110.67 Y120.522 E.04144
G1 X107.972 Y120.522 E.08289
G1 X105.294 Y120.522 E.0823
M204 S10000
; WIPE_START
G1 F12000
G1 X105.283 Y122.522 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X104.444 Y119.926 Z14.2 F30000
G1 Z13.8
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.431684
G1 F11920
G1 X104.444 Y132.074 E.38484
G1 X105.587 Y132.219 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F11920
G1 X105.008 Y132.219 E.01921
G1 X105.008 Y132.422 E.00675
G1 X104.394 Y132.422 E.02036
G1 X104.394 Y132.654 E.0077
G1 X105.834 Y134.094 E.06755
G1 X104.998 Y134.094 E.02775
G1 X106.873 Y132.219 E.08798
G1 X111.635 Y132.219 E.15795
G1 X113.51 Y134.094 E.08798
G1 X112.674 Y134.094 E.02775
G1 X114.549 Y132.219 E.08798
G1 X119.31 Y132.219 E.15794
G1 X121.186 Y134.094 E.08798
G1 X120.35 Y134.094 E.02775
G1 X122.225 Y132.219 E.08798
G1 X126.986 Y132.219 E.15794
G1 X128.862 Y134.094 E.08798
G1 X128.026 Y134.094 E.02775
G1 X129.901 Y132.219 E.08798
G1 X134.662 Y132.219 E.15794
G1 X135.794 Y133.35 E.05307
G3 X134.326 Y134.017 I-2.172 J-2.833 E.05395
; WIPE_START
G1 F15476.087
G1 X134.951 Y133.839 E-.24701
G1 X135.794 Y133.35 E-.37026
G1 X135.528 Y133.084 E-.14273
; WIPE_END
G1 E-.04 F1800
G1 X143.136 Y132.474 Z14.2 F30000
G1 X148.832 Y132.017 Z14.2
G1 Z13.8
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.606464
G1 F11179.26
G1 X149.33 Y132.04 E.02288
; LINE_WIDTH: 0.573708
G1 F11869.148
G1 X149.828 Y132.063 E.02155
; LINE_WIDTH: 0.534392
G1 F11920
G1 X150.363 Y132.087 E.02148
; LINE_WIDTH: 0.488571
G1 X150.898 Y132.111 E.01944
; LINE_WIDTH: 0.442793
G1 X151.433 Y132.135 E.01745
; LINE_WIDTH: 0.397016
G1 X151.968 Y132.158 E.01545
; LINE_WIDTH: 0.351239
G1 X152.503 Y132.182 E.01345
; LINE_WIDTH: 0.305461
G1 X153.038 Y132.206 E.01145
; WIPE_START
G1 F15000
G1 X152.503 Y132.182 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X152.503 Y124.55 Z14.2 F30000
G1 X152.503 Y119.818 Z14.2
G1 Z13.8
G1 E.8 F1800
; LINE_WIDTH: 0.305459
G1 F11920
G1 X153.038 Y119.794 E.01145
G1 X152.503 Y119.818 F30000
; LINE_WIDTH: 0.351237
G1 F11920
G1 X151.968 Y119.842 E.01345
; LINE_WIDTH: 0.397015
G1 X151.433 Y119.865 E.01545
; LINE_WIDTH: 0.442793
G1 X150.898 Y119.889 E.01745
; LINE_WIDTH: 0.488571
G1 X150.363 Y119.913 E.01944
; LINE_WIDTH: 0.534393
G1 X149.828 Y119.937 E.02148
; LINE_WIDTH: 0.573707
G1 F11869.17
G1 X149.33 Y119.96 E.02155
; LINE_WIDTH: 0.606464
G1 F11179.259
G1 X148.832 Y119.983 E.02288
; WIPE_START
G1 X149.33 Y119.96 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X141.763 Y118.963 Z14.2 F30000
G1 X134.326 Y117.983 Z14.2
G1 Z13.8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F11920
G3 X135.794 Y118.65 I-.704 J3.5 E.05395
G1 X134.662 Y119.781 E.05307
G1 X129.901 Y119.781 E.15794
G1 X128.031 Y117.912 E.08771
G1 X128.856 Y117.912 E.02735
G1 X126.986 Y119.781 E.0877
G1 X122.225 Y119.781 E.15794
G1 X120.354 Y117.91 E.0878
G1 X121.182 Y117.91 E.02748
G1 X119.31 Y119.781 E.08779
G1 X114.549 Y119.781 E.15794
G1 X112.676 Y117.908 E.08789
G1 X113.508 Y117.908 E.0276
G1 X111.635 Y119.781 E.08788
G1 X106.873 Y119.781 E.15794
G1 X104.998 Y117.906 E.08797
G1 X105.834 Y117.906 E.02772
G1 X104.394 Y119.346 E.06753
G1 X104.394 Y119.578 E.0077
G1 X105.008 Y119.578 E.02036
G1 X105.008 Y119.781 E.00675
G1 X105.587 Y119.781 E.01921
G1 X104.43 Y117.521 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.402828
G1 F11920
G1 X133.719 Y117.529 E.85896
G3 X135.973 Y118.327 I-.123 J3.929 E.07125
G3 X136.383 Y118.674 I-4.27 J5.455 E.01578
G1 X137.348 Y119.589 E.03898
; LINE_WIDTH: 0.399528
G1 X137.377 Y119.631 E.0015
; LINE_WIDTH: 0.432744
G1 X137.406 Y119.674 E.00164
; WIPE_START
G1 F15000
G1 X137.377 Y119.631 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X130.419 Y122.767 Z14.2 F30000
G1 X104.43 Y134.479 Z14.2
G1 Z13.8
G1 E.8 F1800
; LINE_WIDTH: 0.403013
G1 F11920
G1 X133.603 Y134.479 E.85602
G2 X135.98 Y133.668 I-.034 J-3.986 E.07497
G2 X136.387 Y133.322 I-4.342 J-5.524 E.01568
G1 X137.348 Y132.411 E.03884
; LINE_WIDTH: 0.399526
G1 X137.377 Y132.369 E.0015
; LINE_WIDTH: 0.432738
G1 X137.406 Y132.326 E.00164
; CHANGE_LAYER
; Z_HEIGHT: 14
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F15000
G1 X137.377 Y132.369 E-.76
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 70/101
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L70
M991 S0 P69 ;notify layer change
G17
G3 Z14.2 I.424 J-1.141 P1  F30000
G1 X104.842 Y120.27 Z14.2
G1 Z14
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F14249
G1 X104.842 Y131.73 E.38015
G1 X148.416 Y131.73 E1.44543
G1 X148.956 Y131.78 E.01801
G1 X148.946 Y132.013 E.00773
G1 X138.202 Y132.013 E.3564
G3 X136.278 Y133.804 I-34.898 J-35.546 E.08719
G3 X133.614 Y134.793 I-2.674 J-3.121 E.09624
G1 X104.046 Y134.793 E.98084
G1 X104.046 Y117.207 E.58335
G1 X133.615 Y117.207 E.98085
G3 X136.437 Y118.329 I-.067 J4.281 E.10299
G3 X138.202 Y119.987 I-37.879 J42.084 E.08033
G1 X148.946 Y119.987 E.3564
G1 X148.956 Y120.22 E.00773
G1 X148.416 Y120.27 E.01801
G1 X104.902 Y120.27 E1.44344
G1 X105.234 Y120.662 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
G1 X105.234 Y131.338 E.32804
G1 X105.275 Y131.338 E.00126
G1 X106.623 Y131.338 E.04144
G1 X109.321 Y131.338 E.08289
G1 X110.67 Y131.338 E.04144
G1 X113.367 Y131.338 E.08289
G1 X114.716 Y131.338 E.04144
G1 X117.413 Y131.338 E.08289
G1 X118.762 Y131.338 E.04144
G1 X121.459 Y131.338 E.08289
G1 X122.808 Y131.338 E.04144
G1 X125.106 Y131.338 E.07059
G1 X125.506 Y131.338 E.01229
G1 F11100
G1 X126.454 Y131.338 E.02915
G1 X126.854 Y131.338 E.01229
G1 F10200
G1 X129.152 Y131.338 E.07059
G1 X129.552 Y131.338 E.01229
G1 F9300
G1 X131.849 Y131.338 E.07059
G1 X132.249 Y131.338 E.01229
G1 F8400
G1 X133.198 Y131.338 E.02915
G1 X133.598 Y131.338 E.01229
G1 F7500
G1 X135.895 Y131.338 E.07059
G1 X136.295 Y131.338 E.01229
G1 F6600
G1 X137.244 Y131.338 E.02915
G1 X137.644 Y131.338 E.01229
G1 F5700
G1 X139.942 Y131.338 E.07059
G1 X140.342 Y131.338 E.01229
G1 F4800
G1 X141.29 Y131.338 E.02915
G1 X141.69 Y131.338 E.01229
G1 F3900
G1 X143.988 Y131.338 E.07059
G1 X144.388 Y131.338 E.01229
G1 F3000
G1 X145.737 Y131.338 E.04144
G1 F2880
G1 X148.434 Y131.338 E.08289
G1 X149.898 Y131.474 E.04517
G2 X153.234 Y131.777 I40.207 J-424.18 E.10293
G1 F3909.637
G1 X153.234 Y131.87 E.00287
G1 F12000
G1 X153.234 Y132.405 E.01643
G1 X138.359 Y132.405 E.45705
G3 X136.527 Y134.108 I-33.424 J-34.142 E.07687
G3 X133.627 Y135.185 I-2.917 J-3.41 E.09704
G1 X103.654 Y135.185 E.92099
G1 X103.654 Y116.815 E.56446
G1 X133.627 Y116.815 E.92099
G3 X136.696 Y118.034 I-.08 J4.674 E.1037
G3 X138.359 Y119.595 I-35.652 J39.67 E.07009
G1 X152.834 Y119.595 E.44476
G1 X153.234 Y119.595 E.01229
G1 F10899.396
G1 X153.234 Y120.13 E.01643
G1 F2880
G1 X153.234 Y120.223 E.00287
G2 X148.434 Y120.662 I75.335 J849.764 E.1481
G1 X147.085 Y120.662 E.04144
G1 F3000
G1 X145.737 Y120.662 E.04144
G1 F3900
G1 X145.337 Y120.662 E.01229
G1 X143.039 Y120.662 E.07059
G1 F4800
G1 X142.639 Y120.662 E.01229
G1 X141.69 Y120.662 E.02915
G1 F5700
G1 X141.29 Y120.662 E.01229
G1 X138.993 Y120.662 E.07059
G1 F6600
G1 X138.593 Y120.662 E.01229
G1 X137.644 Y120.662 E.02915
G1 F7500
G1 X137.244 Y120.662 E.01229
G1 X134.947 Y120.662 E.07059
G1 F8400
G1 X134.547 Y120.662 E.01229
G1 X133.598 Y120.662 E.02915
G1 F9300
G1 X133.198 Y120.662 E.01229
G1 X130.901 Y120.662 E.07059
G1 F10200
G1 X130.501 Y120.662 E.01229
G1 X128.203 Y120.662 E.07059
G1 F11100
G1 X127.803 Y120.662 E.01229
G1 X126.854 Y120.662 E.02915
G1 F12000
G1 X126.454 Y120.662 E.01229
G1 X124.157 Y120.662 E.07059
G1 X122.808 Y120.662 E.04144
G1 X120.111 Y120.662 E.08289
G1 X118.762 Y120.662 E.04144
G1 X116.065 Y120.662 E.08289
G1 X114.716 Y120.662 E.04144
G1 X112.018 Y120.662 E.08289
G1 X110.67 Y120.662 E.04144
G1 X107.972 Y120.662 E.08289
G1 X105.294 Y120.662 E.0823
M204 S10000
; WIPE_START
G1 X105.283 Y122.662 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X104.444 Y120.067 Z14.4 F30000
G1 Z14
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.431684
G1 F14249
G1 X104.444 Y131.933 E.37594
G1 X104.4 Y132.287 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.38292
G1 F14249
G1 X104.706 Y132.287 E.0085
G1 X104.943 Y132.168 E.00735
G1 X105.013 Y132.084 E.00305
G1 X136.879 Y132.084 E.88287
; LINE_WIDTH: 0.40634
G1 X136.936 Y132.11 E.00185
; LINE_WIDTH: 0.453178
G1 X136.992 Y132.137 E.00209
; LINE_WIDTH: 0.500017
G1 F13782.642
G1 X137.049 Y132.164 E.00233
; LINE_WIDTH: 0.546856
G1 F12501.604
G1 X137.105 Y132.191 E.00257
; LINE_WIDTH: 0.593694
G1 F11438.449
G1 X137.162 Y132.217 E.0028
; LINE_WIDTH: 0.640533
G1 F10541.945
G1 X137.218 Y132.244 E.00304
; LINE_WIDTH: 0.641708
G1 F10521.262
G1 X137.196 Y132.297 E.00279
; LINE_WIDTH: 0.597219
G1 F11365.717
G1 X137.173 Y132.349 E.00259
; LINE_WIDTH: 0.55273
G1 F12357.558
G1 X137.15 Y132.402 E.00238
; LINE_WIDTH: 0.508241
G1 F13539.054
G1 X137.128 Y132.454 E.00217
; LINE_WIDTH: 0.463752
G1 F14249
G1 X137.105 Y132.507 E.00196
; LINE_WIDTH: 0.419263
G1 X137.082 Y132.559 E.00176
; LINE_WIDTH: 0.423616
G3 X135.988 Y133.558 I-11.693 J-11.708 E.04597
G3 X133.602 Y134.397 I-2.42 J-3.07 E.07991
G1 X104.501 Y134.397 E.90275
; WIPE_START
G1 F15000
G1 X106.501 Y134.397 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X106.205 Y126.771 Z14.4 F30000
G1 X105.925 Y119.563 Z14.4
G1 Z14
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F14249
G1 X105.05 Y119.563 E.02903
G1 X104.846 Y119.359 E.00955
G1 X104.394 Y119.359 E.01499
G1 X105.742 Y117.998 E.06354
G1 X105.09 Y117.998 E.02163
G1 X106.654 Y119.563 E.0734
G1 X111.853 Y119.563 E.17246
G1 X113.418 Y117.998 E.0734
G1 X112.766 Y117.998 E.02163
G1 X114.33 Y119.563 E.0734
G1 X119.529 Y119.563 E.17246
G1 X121.094 Y117.998 E.0734
G1 X120.442 Y117.998 E.02163
G1 X122.006 Y119.563 E.0734
G1 X127.205 Y119.563 E.17246
G1 X128.77 Y117.998 E.0734
G1 X128.118 Y117.998 E.02163
G1 X129.682 Y119.563 E.0734
G1 X134.881 Y119.563 E.17246
G1 X135.731 Y118.713 E.03985
G2 X134.253 Y118.065 I-2.688 J4.122 E.05378
; WIPE_START
G1 F15476.087
G1 X134.941 Y118.263 E-.27228
G1 X135.731 Y118.713 E-.34527
G1 X135.465 Y118.978 E-.14245
; WIPE_END
G1 E-.04 F1800
G1 X143.073 Y119.599 Z14.4 F30000
G1 X149.147 Y120.094 Z14.4
G1 Z14
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.600923
G1 F11290.266
G1 X149.691 Y120.069 E.02479
; LINE_WIDTH: 0.557085
G1 F12252.893
G1 X150.236 Y120.044 E.02284
; LINE_WIDTH: 0.513246
G1 F13394.971
G1 X150.781 Y120.018 E.02089
; LINE_WIDTH: 0.469408
G1 F14249
G1 X151.325 Y119.993 E.01895
; LINE_WIDTH: 0.42404
G1 X151.897 Y119.968 E.01776
; LINE_WIDTH: 0.377191
G1 X152.467 Y119.942 E.01556
; LINE_WIDTH: 0.330373
G1 X153.038 Y119.917 E.01338
; WIPE_START
G1 F15000
G1 X152.467 Y119.942 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X152.467 Y127.575 Z14.4 F30000
G1 X152.467 Y132.058 Z14.4
G1 Z14
G1 E.8 F1800
; LINE_WIDTH: 0.377192
G1 F14249
G1 X151.897 Y132.032 E.01556
; LINE_WIDTH: 0.424042
G1 X151.325 Y132.007 E.01776
; LINE_WIDTH: 0.469409
G1 X150.781 Y131.982 E.01895
; LINE_WIDTH: 0.513247
G1 F13394.937
G1 X150.236 Y131.956 E.02089
; LINE_WIDTH: 0.557085
G1 F12252.878
G1 X149.691 Y131.931 E.02284
; LINE_WIDTH: 0.600923
G1 F11290.264
G1 X149.147 Y131.906 E.02479
G1 X152.467 Y132.058 F30000
; LINE_WIDTH: 0.330375
G1 F14249
G1 X153.038 Y132.083 E.01338
; WIPE_START
G1 F15000
G1 X152.467 Y132.058 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X144.875 Y132.84 Z14.4 F30000
G1 X134.253 Y133.935 Z14.4
G1 Z14
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F14249
G2 X135.731 Y133.287 I-1.21 J-4.77 E.05378
G1 X134.881 Y132.437 E.03985
G1 X129.682 Y132.437 E.17246
G1 X128.118 Y134.002 E.0734
G1 X128.77 Y134.002 E.02163
G1 X127.205 Y132.437 E.0734
G1 X122.006 Y132.437 E.17246
G1 X120.442 Y134.002 E.0734
G1 X121.094 Y134.002 E.02163
G1 X119.529 Y132.437 E.0734
G1 X114.33 Y132.437 E.17246
G1 X112.766 Y134.002 E.0734
G1 X113.418 Y134.002 E.02163
G1 X111.853 Y132.437 E.0734
G1 X106.654 Y132.437 E.17246
G1 X105.09 Y134.002 E.0734
G1 X105.742 Y134.002 E.02163
G1 X104.394 Y132.641 E.06354
G1 X104.846 Y132.641 E.01499
G1 X105.05 Y132.437 E.00955
G1 X105.925 Y132.437 E.02903
; WIPE_START
G1 F15476.087
G1 X105.05 Y132.437 E-.3326
G1 X104.846 Y132.641 E-.10938
G1 X104.394 Y132.641 E-.17175
G1 X104.665 Y132.914 E-.14628
; WIPE_END
G1 E-.04 F1800
G1 X104.553 Y125.283 Z14.4 F30000
G1 X104.441 Y117.603 Z14.4
G1 Z14
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.423618
G1 F14249
G1 X133.602 Y117.603 E.90463
G3 X135.963 Y118.422 I-.065 J3.999 E.07886
G3 X137.039 Y119.399 I-9.755 J11.823 E.04508
; LINE_WIDTH: 0.417169
G1 X137.079 Y119.465 E.00237
; LINE_WIDTH: 0.457771
G1 X137.119 Y119.532 E.00262
; LINE_WIDTH: 0.498373
G1 F13832.382
G1 X137.159 Y119.598 E.00288
; LINE_WIDTH: 0.538975
G1 F12700.205
G1 X137.199 Y119.665 E.00314
; LINE_WIDTH: 0.576725
G1 F11802.078
G1 X137.205 Y119.695 E.00135
; LINE_WIDTH: 0.611621
G1 F11077.878
G1 X137.212 Y119.726 E.00144
; LINE_WIDTH: 0.646518
G1 F10437.416
G1 X137.218 Y119.756 E.00153
; LINE_WIDTH: 0.640546
G1 F10541.719
G1 X137.166 Y119.783 E.00285
; LINE_WIDTH: 0.593705
G1 F11438.23
G1 X137.114 Y119.809 E.00263
; LINE_WIDTH: 0.546864
G1 F12501.402
G1 X137.062 Y119.836 E.0024
; LINE_WIDTH: 0.500023
G1 F13782.465
G1 X137.01 Y119.862 E.00218
; LINE_WIDTH: 0.453182
G1 F14249
G1 X136.958 Y119.889 E.00196
; LINE_WIDTH: 0.382962
G3 X136.879 Y119.916 I-.07 J-.072 E.00237
G1 X105.013 Y119.916 E.88298
G1 X104.863 Y119.771 E.00579
G1 X104.706 Y119.713 E.00464
G1 X104.46 Y119.713 E.00683
; CHANGE_LAYER
; Z_HEIGHT: 14.2
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F15000
G1 X104.706 Y119.713 E-.09373
G1 X104.863 Y119.771 E-.06357
G1 X105.013 Y119.916 E-.07947
G1 X106.39 Y119.916 E-.52323
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 71/101
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L71
M991 S0 P70 ;notify layer change
G17
G3 Z14.4 I-.374 J-1.158 P1  F30000
G1 X104.842 Y120.417 Z14.4
G1 Z14.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F13304
G1 X104.842 Y131.583 E.37039
G1 X148.415 Y131.583 E1.4454
G1 X149.308 Y131.67 E.02977
G1 X149.297 Y131.902 E.00772
G1 X138.202 Y131.902 E.36804
G3 X136.02 Y133.919 I-25.494 J-25.378 E.09859
G3 X133.614 Y134.702 I-2.463 J-3.478 E.08521
G1 X104.046 Y134.702 E.98084
G1 X104.046 Y117.298 E.57735
G1 X133.614 Y117.298 E.98084
G1 X134.019 Y117.323 E.01344
G1 X134.135 Y117.331 E.00386
G3 X136.437 Y118.425 I-.624 J4.28 E.08583
G3 X138.202 Y120.098 I-38.223 J42.086 E.08066
G1 X149.297 Y120.098 E.36804
G1 X149.308 Y120.33 E.00772
G1 X148.415 Y120.417 E.02977
G1 X104.902 Y120.417 E1.4434
G1 X105.234 Y120.809 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
G1 X105.234 Y131.191 E.319
G1 X105.275 Y131.191 E.00126
G1 X106.623 Y131.191 E.04144
G1 X107.972 Y131.191 E.04144
G1 X110.67 Y131.191 E.08288
G1 X112.018 Y131.191 E.04144
G1 X114.716 Y131.191 E.08288
G1 X116.064 Y131.191 E.04144
G1 X118.762 Y131.191 E.08288
G1 X120.111 Y131.191 E.04144
G1 X122.808 Y131.191 E.08288
G1 X123.757 Y131.191 E.02915
G1 X124.157 Y131.191 E.01229
G1 F11100
G1 X126.454 Y131.191 E.07059
G1 X126.854 Y131.191 E.01229
G1 F10200
G1 X127.803 Y131.191 E.02915
G1 X128.203 Y131.191 E.01229
G1 F9300
G1 X130.5 Y131.191 E.07059
G1 X130.9 Y131.191 E.01229
G1 F8400
G1 X131.849 Y131.191 E.02915
M73 P78 R4
G1 X132.249 Y131.191 E.01229
G1 F7500
G1 X134.546 Y131.191 E.07059
G1 X134.946 Y131.191 E.01229
G1 F6600
G1 X135.895 Y131.191 E.02915
G1 X136.295 Y131.191 E.01229
G1 F5700
G1 X138.593 Y131.191 E.07059
G1 X138.993 Y131.191 E.01229
G1 F4800
G1 X139.941 Y131.191 E.02915
G1 X140.341 Y131.191 E.01229
G1 F3900
G1 X142.639 Y131.191 E.07059
G1 X143.039 Y131.191 E.01229
G1 F3000
G1 X144.387 Y131.191 E.04144
G1 F2880
G1 X147.085 Y131.191 E.08288
G1 F2760
G1 X148.434 Y131.191 E.04144
G1 X149.263 Y131.271 E.0256
G1 F2880
G2 X153.234 Y131.642 I80.445 J-840.415 E.12254
G1 F3917.079
G1 X153.234 Y131.736 E.00289
G1 F12000
G1 X153.234 Y132.294 E.01715
G1 X138.359 Y132.294 E.45705
G3 X136.247 Y134.24 I-22.278 J-22.062 E.08826
G3 X133.627 Y135.095 I-2.692 J-3.807 E.08599
G1 X103.654 Y135.095 E.92099
G1 X103.654 Y116.905 E.5589
G1 X133.627 Y116.905 E.92099
G1 X134.044 Y116.932 E.01283
G1 X134.185 Y116.941 E.00434
G3 X136.696 Y118.13 I-.68 J4.68 E.08666
G3 X138.359 Y119.706 I-35.998 J39.675 E.07041
G1 X152.834 Y119.706 E.44476
G1 X153.234 Y119.706 E.01229
G1 F11366.933
G1 X153.234 Y120.264 E.01715
G1 F2880
G1 X153.234 Y120.358 E.00289
G1 X150.092 Y120.648 E.09694
G1 F2760
G1 X148.434 Y120.809 E.0512
G1 F2880
G1 X145.736 Y120.809 E.08288
G1 F3000
G1 X144.387 Y120.809 E.04144
G1 F3900
G1 X143.987 Y120.809 E.01229
G1 X141.69 Y120.809 E.07059
G1 F4800
G1 X141.29 Y120.809 E.01229
G1 X140.341 Y120.809 E.02915
G1 F5700
G1 X139.941 Y120.809 E.01229
G1 X137.644 Y120.809 E.07059
G1 F6600
G1 X137.244 Y120.809 E.01229
G1 X136.295 Y120.809 E.02915
G1 F7500
G1 X135.895 Y120.809 E.01229
G1 X133.598 Y120.809 E.07059
G1 F8400
G1 X133.198 Y120.809 E.01229
G1 X132.249 Y120.809 E.02915
G1 F9300
G1 X131.849 Y120.809 E.01229
G1 X129.552 Y120.809 E.07059
G1 F10200
G1 X129.152 Y120.809 E.01229
G1 X128.203 Y120.809 E.02915
G1 F11100
G1 X127.803 Y120.809 E.01229
G1 X125.505 Y120.809 E.07059
G1 F12000
G1 X125.105 Y120.809 E.01229
G1 X124.157 Y120.809 E.02915
G1 X121.459 Y120.809 E.08288
G1 X120.111 Y120.809 E.04144
G1 X117.413 Y120.809 E.08288
G1 X116.064 Y120.809 E.04144
G1 X113.367 Y120.809 E.08288
G1 X112.018 Y120.809 E.04144
G1 X109.321 Y120.809 E.08288
G1 X107.972 Y120.809 E.04144
G1 X105.294 Y120.809 E.0823
M204 S10000
; WIPE_START
G1 X105.282 Y122.809 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X104.444 Y120.214 Z14.6 F30000
G1 Z14.2
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.431684
G1 F13304
G1 X104.444 Y131.786 E.36662
G1 X105.785 Y132.298 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F13304
G1 X105.05 Y132.298 E.02441
G1 X104.846 Y132.501 E.00955
G1 X104.394 Y132.501 E.01499
G1 X104.394 Y132.654 E.00507
G1 X105.63 Y133.89 E.05799
G1 X105.202 Y133.89 E.01422
G1 X106.794 Y132.298 E.0747
G1 X111.714 Y132.298 E.1632
G1 X113.306 Y133.89 E.0747
G1 X112.877 Y133.89 E.01422
G1 X114.47 Y132.298 E.0747
G1 X119.39 Y132.298 E.1632
G1 X120.982 Y133.89 E.0747
G1 X120.553 Y133.89 E.01422
G1 X122.146 Y132.298 E.0747
G1 X127.066 Y132.298 E.1632
G1 X128.658 Y133.89 E.0747
G1 X128.229 Y133.89 E.01422
G1 X129.822 Y132.298 E.0747
G1 X134.742 Y132.298 E.1632
G1 X135.663 Y133.219 E.04323
G3 X134.173 Y133.839 I-2.573 J-4.086 E.05377
; WIPE_START
G1 F15476.087
G1 X134.941 Y133.625 E-.30284
G1 X135.663 Y133.219 E-.31468
G1 X135.398 Y132.954 E-.14248
; WIPE_END
G1 E-.04 F1800
G1 X143.005 Y132.329 Z14.6 F30000
G1 X149.498 Y131.795 Z14.6
G1 Z14.2
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.607963
G1 F11149.61
G1 X150.047 Y131.822 E.02531
; LINE_WIDTH: 0.573447
G1 F11875.002
G1 X150.547 Y131.845 E.02162
; LINE_WIDTH: 0.529698
G1 F12942.262
G1 X151.045 Y131.868 E.01978
; LINE_WIDTH: 0.486005
G1 F13304
G1 X151.543 Y131.891 E.01801
; LINE_WIDTH: 0.442311
G1 X152.041 Y131.914 E.01623
; LINE_WIDTH: 0.398618
G1 X152.539 Y131.937 E.01446
; LINE_WIDTH: 0.354925
G1 X153.038 Y131.96 E.01268
; WIPE_START
G1 F15000
G1 X152.539 Y131.937 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X152.481 Y124.304 Z14.6 F30000
G1 X152.448 Y120.068 Z14.6
G1 Z14.2
G1 E.8 F1800
; LINE_WIDTH: 0.357222
G1 F13304
G1 X153.038 Y120.04 E.01513
G1 X152.448 Y120.068 F30000
; LINE_WIDTH: 0.405306
G1 F13304
G1 X151.858 Y120.095 E.01744
; LINE_WIDTH: 0.45339
G1 X151.268 Y120.123 E.01975
; LINE_WIDTH: 0.501474
G1 X150.678 Y120.15 E.02207
; LINE_WIDTH: 0.549558
G1 F12434.916
G1 X150.088 Y120.177 E.02438
; LINE_WIDTH: 0.597642
G1 F11357.041
G1 X149.498 Y120.205 E.0267
; WIPE_START
G1 X150.088 Y120.177 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X142.516 Y119.218 Z14.6 F30000
G1 X134.173 Y118.161 Z14.6
G1 Z14.2
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F13304
G3 X135.663 Y118.781 I-1.084 J4.706 E.05377
G1 X134.742 Y119.702 E.04323
G1 X129.822 Y119.702 E.1632
G1 X128.229 Y118.11 E.0747
G1 X128.658 Y118.11 E.01422
G1 X127.066 Y119.702 E.0747
G1 X122.146 Y119.702 E.1632
G1 X120.553 Y118.11 E.0747
G1 X120.982 Y118.11 E.01422
G1 X119.39 Y119.702 E.0747
G1 X114.47 Y119.702 E.1632
G1 X112.877 Y118.11 E.0747
G1 X113.306 Y118.11 E.01422
G1 X111.714 Y119.702 E.0747
G1 X106.794 Y119.702 E.1632
G1 X105.202 Y118.11 E.0747
G1 X105.63 Y118.11 E.01422
G1 X104.394 Y119.346 E.05799
G1 X104.394 Y119.499 E.00507
G1 X104.846 Y119.499 E.01499
G1 X105.05 Y119.702 E.00955
G1 X105.785 Y119.702 E.02441
G1 X104.403 Y119.856 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.38292
G1 F13304
G1 X104.705 Y119.856 E.00835
G1 X104.942 Y119.972 E.00732
G1 X105.017 Y120.06 E.00319
G1 X136.879 Y120.06 E.88274
; LINE_WIDTH: 0.40024
G1 X136.947 Y120.037 E.00209
; LINE_WIDTH: 0.434878
G1 X137.015 Y120.014 E.0023
; LINE_WIDTH: 0.469517
G1 X137.083 Y119.992 E.0025
; LINE_WIDTH: 0.511438
G1 X137.12 Y119.967 E.0017
; LINE_WIDTH: 0.560641
G1 F12168.728
G1 X137.157 Y119.942 E.00188
; LINE_WIDTH: 0.609844
G1 F11112.61
G1 X137.194 Y119.918 E.00205
; LINE_WIDTH: 0.659047
G1 F10225.173
G1 X137.231 Y119.893 E.00223
; LINE_WIDTH: 0.661683
G1 F10181.618
G1 X137.209 Y119.841 E.00287
; LINE_WIDTH: 0.617751
G1 F10959.753
G1 X137.186 Y119.789 E.00267
; LINE_WIDTH: 0.573819
G1 F11866.668
G1 X137.163 Y119.736 E.00247
; LINE_WIDTH: 0.529887
G1 F12937.218
G1 X137.14 Y119.684 E.00226
; LINE_WIDTH: 0.485956
G1 F13304
G1 X137.118 Y119.632 E.00206
; LINE_WIDTH: 0.442024
G1 X137.095 Y119.58 E.00185
; LINE_WIDTH: 0.444507
G2 X135.791 Y118.398 I-10.029 J9.753 E.05763
G1 X135.098 Y118.013 E.02592
G1 X134.624 Y117.845 E.01648
G2 X133.595 Y117.704 I-1.547 J7.451 E.034
G1 X104.512 Y117.704 E.95173
G1 X104.452 Y134.296 F30000
; LINE_WIDTH: 0.447192
G1 F13304
G1 X133.601 Y134.296 E.96027
G2 X135.559 Y133.751 I-.011 J-3.83 E.06776
; LINE_WIDTH: 0.399213
G2 X136.388 Y133.103 I-2.286 J-3.776 E.03063
G1 X137.085 Y132.421 E.02831
; LINE_WIDTH: 0.440356
G1 X137.108 Y132.369 E.00185
; LINE_WIDTH: 0.484686
G1 X137.131 Y132.316 E.00206
; LINE_WIDTH: 0.529016
G1 F12960.407
G1 X137.154 Y132.264 E.00227
; LINE_WIDTH: 0.573347
G1 F11877.241
G1 X137.177 Y132.212 E.00247
; LINE_WIDTH: 0.617677
G1 F10961.164
G1 X137.2 Y132.159 E.00268
; LINE_WIDTH: 0.662007
G1 F10176.279
G1 X137.223 Y132.107 E.00289
; LINE_WIDTH: 0.65961
G1 F10215.838
G1 X137.187 Y132.082 E.00223
; LINE_WIDTH: 0.610485
G1 F11100.06
G1 X137.15 Y132.058 E.00205
; LINE_WIDTH: 0.56136
G1 F12151.853
G1 X137.113 Y132.033 E.00187
; LINE_WIDTH: 0.512235
G1 F13304
G1 X137.076 Y132.009 E.00169
; LINE_WIDTH: 0.470214
G1 X137.008 Y131.986 E.00251
; LINE_WIDTH: 0.435296
G1 X136.939 Y131.963 E.00231
; LINE_WIDTH: 0.382959
G1 X136.871 Y131.94 E.002
G1 X105.017 Y131.94 E.88263
G3 X104.463 Y132.144 I-.443 J-.349 E.0172
; CHANGE_LAYER
; Z_HEIGHT: 14.4
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F15000
G1 X104.705 Y132.144 E-.09176
G1 X104.863 Y132.085 E-.06414
G1 X105.017 Y131.94 E-.08037
G1 X106.395 Y131.94 E-.52373
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 72/101
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L72
M991 S0 P71 ;notify layer change
G17
G3 Z14.6 I1.206 J-.165 P1  F30000
G1 X104.842 Y120.592 Z14.6
G1 Z14.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F15078
G1 X104.842 Y131.408 E.35878
G1 X148.413 Y131.408 E1.44535
G1 X149.702 Y131.538 E.04297
G1 X149.69 Y131.77 E.0077
G1 X138.191 Y131.77 E.38144
G3 X136.437 Y133.478 I-55.157 J-54.889 E.08122
G3 X133.614 Y134.612 I-2.829 J-2.964 E.10338
G1 X104.046 Y134.612 E.98084
G1 X104.046 Y117.388 E.57136
G1 X133.614 Y117.388 E.98084
G1 X133.874 Y117.404 E.00862
G3 X136.558 Y118.633 I-.294 J4.19 E.10008
G3 X138.191 Y120.23 I-28.091 J30.362 E.07577
G1 X149.69 Y120.23 E.38144
G1 X149.702 Y120.462 E.0077
G1 X148.413 Y120.592 E.04297
G1 X104.902 Y120.592 E1.44336
G1 X105.234 Y120.984 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
G1 X105.234 Y131.016 E.30824
G1 X105.275 Y131.016 E.00126
G1 X106.623 Y131.016 E.04144
G1 X107.972 Y131.016 E.04144
G1 X109.321 Y131.016 E.04144
G1 X112.018 Y131.016 E.08288
G1 X113.367 Y131.016 E.04144
G1 X114.716 Y131.016 E.04144
G1 X117.413 Y131.016 E.08288
G1 X118.762 Y131.016 E.04144
G1 X120.11 Y131.016 E.04144
G1 X122.408 Y131.016 E.07059
G1 X122.808 Y131.016 E.01229
G1 F11100
G1 X123.757 Y131.016 E.02915
G1 X124.157 Y131.016 E.01229
G1 F10200
G1 X125.105 Y131.016 E.02915
G1 X125.505 Y131.016 E.01229
G1 F9300
G1 X126.454 Y131.016 E.02915
G1 X126.854 Y131.016 E.01229
G1 F8400
G1 X129.151 Y131.016 E.07059
G1 X129.551 Y131.016 E.01229
G1 F7500
G1 X130.5 Y131.016 E.02915
G1 X130.9 Y131.016 E.01229
G1 F6600
G1 X131.849 Y131.016 E.02915
G1 X132.249 Y131.016 E.01229
G1 F5700
G1 X134.546 Y131.016 E.07059
G1 X134.946 Y131.016 E.01229
G1 F4800
G1 X135.895 Y131.016 E.02915
G1 X136.295 Y131.016 E.01229
G1 F3900
G1 X137.244 Y131.016 E.02915
G1 X137.644 Y131.016 E.01229
G1 F3000
G1 X140.341 Y131.016 E.08288
G1 F2880
G1 X141.69 Y131.016 E.04144
G1 F2760
G1 X143.038 Y131.016 E.04144
G1 F2640
G1 X145.736 Y131.016 E.08288
G1 F2520
G1 X147.084 Y131.016 E.04144
G1 F2400
G1 X148.433 Y131.016 E.04144
G1 X149.347 Y131.108 E.02822
G1 F2520
G1 X150.261 Y131.201 E.02822
G1 F2640
G1 X153.234 Y131.487 E.09178
G1 F3868.816
G1 X153.234 Y131.601 E.0035
G1 F12000
G1 X153.234 Y132.162 E.01726
G1 X138.356 Y132.162 E.45716
G3 X136.696 Y133.773 I-58.331 J-58.449 E.07107
G3 X133.627 Y135.004 I-3.083 J-3.246 E.10407
G1 X103.654 Y135.004 E.92099
G1 X103.654 Y116.996 E.55334
G1 X133.627 Y116.996 E.92099
G1 X133.898 Y117.013 E.00836
G3 X136.827 Y118.347 I-.318 J4.58 E.10103
G3 X138.356 Y119.838 I-26.213 J28.419 E.0656
G1 X152.834 Y119.838 E.44487
G1 X153.234 Y119.838 E.01229
G1 F10957.058
G1 X153.234 Y120.399 E.01726
G1 F2640
G1 X153.234 Y120.513 E.0035
G1 X151.747 Y120.656 E.04589
G1 F2520
G1 X150.261 Y120.799 E.04589
G1 F2400
G1 X148.433 Y120.984 E.05644
G1 F2520
G1 X147.084 Y120.984 E.04144
G1 F2640
G1 X144.387 Y120.984 E.08288
G1 F2760
G1 X143.038 Y120.984 E.04144
G1 F2880
G1 X141.69 Y120.984 E.04144
G1 F3000
G1 X138.992 Y120.984 E.08288
G1 F3900
G1 X138.592 Y120.984 E.01229
G1 X137.644 Y120.984 E.02915
G1 F4800
G1 X137.244 Y120.984 E.01229
G1 X136.295 Y120.984 E.02915
G1 F5700
G1 X135.895 Y120.984 E.01229
G1 X133.597 Y120.984 E.07059
G1 F6600
G1 X133.197 Y120.984 E.01229
G1 X132.249 Y120.984 E.02915
G1 F7500
G1 X131.849 Y120.984 E.01229
G1 X130.9 Y120.984 E.02915
G1 F8400
G1 X130.5 Y120.984 E.01229
G1 X128.203 Y120.984 E.07059
G1 F9300
G1 X127.803 Y120.984 E.01229
G1 X126.854 Y120.984 E.02915
G1 F10200
G1 X126.454 Y120.984 E.01229
G1 X125.505 Y120.984 E.02915
G1 F11100
G1 X125.105 Y120.984 E.01229
G1 X124.157 Y120.984 E.02915
G1 F12000
G1 X123.757 Y120.984 E.01229
G1 X121.459 Y120.984 E.07059
G1 X120.11 Y120.984 E.04144
G1 X118.762 Y120.984 E.04144
G1 X116.064 Y120.984 E.08288
G1 X114.716 Y120.984 E.04144
G1 X113.367 Y120.984 E.04144
G1 X110.67 Y120.984 E.08288
G1 X109.321 Y120.984 E.04144
G1 X107.972 Y120.984 E.04144
G1 X105.294 Y120.984 E.0823
M204 S10000
; WIPE_START
G1 X105.282 Y122.984 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X104.444 Y120.389 Z14.8 F30000
G1 Z14.4
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.431684
G1 F15000
G1 X104.444 Y131.611 E.35553
G1 X104.421 Y131.986 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.385395
G1 F15000
G1 X104.698 Y131.986 E.00775
G1 X104.936 Y131.88 E.00726
G1 X105.034 Y131.783 E.00386
G1 X136.816 Y131.783 E.88695
G1 X104.463 Y134.195 F30000
; LINE_WIDTH: 0.466397
G1 F14876.85
G1 X133.601 Y134.195 E1.00551
G2 X135.089 Y133.89 I-.092 J-4.226 E.05269
G1 X135.686 Y133.568 E.02342
G1 X136.171 Y133.182 E.02139
G1 X137.1 Y132.286 E.04452
; LINE_WIDTH: 0.46304
G1 F14995.739
G1 X137.12 Y132.239 E.00174
; LINE_WIDTH: 0.51027
G1 F13480.261
G1 X137.14 Y132.193 E.00193
; LINE_WIDTH: 0.557501
G1 F12242.979
G1 X137.16 Y132.146 E.00213
; LINE_WIDTH: 0.604732
G1 F11213.729
G1 X137.18 Y132.1 E.00232
; LINE_WIDTH: 0.651962
G1 F10344.115
G1 X137.2 Y132.053 E.00252
; LINE_WIDTH: 0.699193
G1 F9599.668
G1 X137.22 Y132.006 E.00271
G1 X134.094 Y133.743 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F15078
G2 X135.593 Y133.15 I-.536 J-3.545 E.05396
G1 X134.601 Y132.157 E.04654
G1 X129.962 Y132.157 E.15388
G1 X128.341 Y133.779 E.07605
G1 X128.546 Y133.779 E.00681
G1 X126.925 Y132.157 E.07605
G1 X122.286 Y132.157 E.15388
G1 X120.665 Y133.779 E.07605
G1 X120.87 Y133.779 E.00681
G1 X119.249 Y132.157 E.07605
G1 X114.61 Y132.157 E.15388
G1 X112.989 Y133.779 E.07605
G1 X113.194 Y133.779 E.00681
G1 X111.573 Y132.157 E.07605
G1 X106.934 Y132.157 E.15388
G1 X105.313 Y133.779 E.07605
G1 X105.518 Y133.779 E.00681
G1 X104.394 Y132.654 E.05275
G1 X104.394 Y132.361 E.00973
G1 X104.846 Y132.361 E.01499
G1 X105.05 Y132.157 E.00955
G1 X105.645 Y132.157 E.01975
; WIPE_START
G1 F15476.087
G1 X105.05 Y132.157 E-.22619
G1 X104.846 Y132.361 E-.10938
G1 X104.394 Y132.361 E-.17175
G1 X104.394 Y132.654 E-.11144
G1 X104.657 Y132.917 E-.14124
; WIPE_END
G1 E-.04 F1800
G1 X104.559 Y125.285 Z14.8 F30000
G1 X104.463 Y117.805 Z14.8
G1 Z14.4
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.468672
G1 F14797.35
G1 X133.601 Y117.805 E1.01092
G1 X134.526 Y117.921 E.03232
G3 X135.536 Y118.336 I-.915 J3.668 E.03802
; LINE_WIDTH: 0.42065
G1 F15000
G3 X136.384 Y119.003 I-2.633 J4.223 E.03328
G1 X137.1 Y119.714 E.03105
; LINE_WIDTH: 0.464072
G1 F14959
G1 X137.124 Y119.769 E.00209
; LINE_WIDTH: 0.511166
G1 F13454.481
G1 X137.148 Y119.825 E.00232
; LINE_WIDTH: 0.55826
G1 F12224.942
G1 X137.172 Y119.881 E.00255
; LINE_WIDTH: 0.605355
G1 F11201.31
G1 X137.196 Y119.937 E.00279
; LINE_WIDTH: 0.652449
G1 F10335.859
G1 X137.22 Y119.993 E.00302
; LINE_WIDTH: 0.699543
G1 F9594.55
G1 X137.244 Y120.049 E.00325
; LINE_WIDTH: 0.699156
G1 F9600.214
G1 X137.196 Y120.072 E.00288
; LINE_WIDTH: 0.651286
G1 F10355.61
G1 X137.148 Y120.096 E.00267
; LINE_WIDTH: 0.603417
G1 F11240.036
G1 X137.099 Y120.12 E.00246
; LINE_WIDTH: 0.555547
G1 F12289.638
G1 X137.051 Y120.144 E.00225
; LINE_WIDTH: 0.507678
G1 F13555.454
G1 X137.003 Y120.168 E.00204
; LINE_WIDTH: 0.459809
G1 F15000
G1 X136.955 Y120.192 E.00183
; LINE_WIDTH: 0.411939
G1 X136.906 Y120.216 E.00162
; LINE_WIDTH: 0.385396
G1 X105.034 Y120.217 E.88946
G2 X104.481 Y120.014 I-.464 J.408 E.01717
G1 X105.645 Y119.843 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F15078
G1 X105.05 Y119.843 E.01975
G1 X104.846 Y119.639 E.00955
G1 X104.394 Y119.639 E.01499
G1 X104.394 Y119.346 E.00973
G1 X105.518 Y118.221 E.05275
G1 X105.313 Y118.221 E.00681
G1 X106.934 Y119.843 E.07605
G1 X111.573 Y119.843 E.15388
G1 X113.194 Y118.221 E.07605
G1 X112.989 Y118.221 E.00681
G1 X114.61 Y119.843 E.07605
G1 X119.249 Y119.843 E.15388
G1 X120.87 Y118.221 E.07605
G1 X120.665 Y118.221 E.00681
G1 X122.286 Y119.843 E.07605
G1 X126.925 Y119.843 E.15388
G1 X128.546 Y118.221 E.07605
G1 X128.341 Y118.221 E.00681
G1 X129.962 Y119.843 E.07605
G1 X134.601 Y119.843 E.15388
G1 X135.592 Y118.852 E.04649
G2 X134.093 Y118.257 I-2.446 J3.977 E.05376
; WIPE_START
G1 F15476.087
G1 X134.941 Y118.487 E-.33381
G1 X135.592 Y118.852 E-.28358
G1 X135.327 Y119.117 E-.14261
; WIPE_END
G1 E-.04 F1800
G1 X142.945 Y119.576 Z14.8 F30000
G1 X153.038 Y120.184 Z14.8
G1 Z14.4
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.380826
G1 F15000
G1 X152.513 Y120.209 E.01445
; LINE_WIDTH: 0.424209
G1 X151.989 Y120.235 E.01631
; LINE_WIDTH: 0.467591
G1 F14835.037
G1 X151.465 Y120.26 E.01816
; LINE_WIDTH: 0.510973
G1 F13460.027
G1 X150.94 Y120.285 E.02002
; LINE_WIDTH: 0.554355
G1 F12318.288
G1 X150.416 Y120.31 E.02188
; LINE_WIDTH: 0.597737
G1 F11355.097
G1 X149.892 Y120.336 E.02373
; WIPE_START
G1 X150.416 Y120.31 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X150.064 Y127.935 Z14.8 F30000
G1 X149.892 Y131.664 Z14.8
G1 Z14.4
G1 E.8 F1800
; LINE_WIDTH: 0.602656
G1 F11255.307
G1 X150.685 Y131.703 E.0362
; LINE_WIDTH: 0.550675
G1 F12407.561
G1 X151.155 Y131.726 E.01949
; LINE_WIDTH: 0.508092
G1 F13543.388
G1 X151.626 Y131.748 E.01786
; LINE_WIDTH: 0.465509
G1 F14908.127
G1 X152.096 Y131.771 E.01622
; LINE_WIDTH: 0.422925
G1 F15000
G1 X152.567 Y131.793 E.01459
; LINE_WIDTH: 0.380342
G1 X153.038 Y131.816 E.01295
; CHANGE_LAYER
; Z_HEIGHT: 14.6
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F15000
G1 X152.567 Y131.793 E-.76
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 73/101
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L73
M991 S0 P72 ;notify layer change
G17
G3 Z14.8 I.274 J-1.186 P1  F30000
G1 X104.842 Y120.767 Z14.8
G1 Z14.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F15476.087
M73 P79 R4
G1 X104.842 Y131.233 E.34717
G1 X148.413 Y131.233 E1.44535
G1 X150.067 Y131.4 E.05512
G1 X150.055 Y131.632 E.0077
G1 X138.191 Y131.632 E.39354
G3 X136.35 Y133.444 I-41.303 J-40.123 E.0857
G3 X133.614 Y134.522 I-2.749 J-2.97 E.09982
G1 X104.046 Y134.522 E.98084
G1 X104.046 Y117.478 E.56536
G1 X133.728 Y117.486 E.98463
G3 X136.426 Y118.623 I-.13 J4.077 E.09932
G3 X138.191 Y120.368 I-31.867 J33.998 E.08235
G1 X150.055 Y120.368 E.39354
G1 X150.067 Y120.6 E.0077
G1 X148.413 Y120.767 E.05512
G1 X104.902 Y120.767 E1.44336
G1 X105.234 Y121.159 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
G1 X105.234 Y130.841 E.29749
G1 X105.275 Y130.841 E.00126
G1 X106.623 Y130.841 E.04144
G1 X107.972 Y130.841 E.04144
G1 X109.321 Y130.841 E.04144
G1 X112.018 Y130.841 E.08288
G1 X113.367 Y130.841 E.04144
G1 X114.716 Y130.841 E.04144
G1 X117.413 Y130.841 E.08288
G1 X118.762 Y130.841 E.04144
G1 X120.11 Y130.841 E.04144
G1 X122.408 Y130.841 E.07059
G1 X122.808 Y130.841 E.01229
G1 F11100
G1 X123.757 Y130.841 E.02915
G1 X124.157 Y130.841 E.01229
G1 F10200
G1 X125.105 Y130.841 E.02915
G1 X125.505 Y130.841 E.01229
G1 F9300
G1 X126.454 Y130.841 E.02915
G1 X126.854 Y130.841 E.01229
G1 F8400
G1 X129.151 Y130.841 E.07059
G1 X129.551 Y130.841 E.01229
G1 F7500
G1 X130.5 Y130.841 E.02915
G1 X130.9 Y130.841 E.01229
G1 F6600
G1 X131.849 Y130.841 E.02915
G1 X132.249 Y130.841 E.01229
G1 F5700
G1 X134.546 Y130.841 E.07059
G1 X134.946 Y130.841 E.01229
G1 F4800
G1 X135.895 Y130.841 E.02915
G1 X136.295 Y130.841 E.01229
G1 F3900
G1 X137.244 Y130.841 E.02915
G1 X137.644 Y130.841 E.01229
G1 F3000
G1 X140.341 Y130.841 E.08288
G1 F2880
G1 X141.69 Y130.841 E.04144
G1 F2760
G1 X143.038 Y130.841 E.04144
G1 F2640
G1 X145.736 Y130.841 E.08288
G1 F2520
G1 X147.084 Y130.841 E.04144
G1 F2400
G1 X148.433 Y130.841 E.04144
G1 X150.118 Y131.012 E.05204
G1 F2520
G2 X153.234 Y131.32 I30.989 J-297.338 E.0962
G1 F3858.977
G1 X153.234 Y131.445 E.00386
G1 F12000
G1 X153.234 Y132.024 E.01779
G1 X138.356 Y132.024 E.45716
G3 X136.605 Y133.742 I-39.803 J-38.808 E.07537
G3 X133.627 Y134.914 I-2.996 J-3.245 E.10063
G1 X103.654 Y134.914 E.92099
G1 X103.654 Y117.086 E.54779
G1 X133.753 Y117.094 E.92487
G3 X136.692 Y118.334 I-.154 J4.468 E.10022
G3 X138.356 Y119.976 I-29.967 J32.04 E.07182
G1 X152.834 Y119.976 E.44487
G1 X153.234 Y119.976 E.01229
G1 F11051.135
G1 X153.234 Y120.555 E.01779
G1 F2520
G1 X153.234 Y120.68 E.00386
G1 X151.803 Y120.818 E.04417
G1 F2400
G1 X148.433 Y121.159 E.10408
G1 F2520
G1 X147.084 Y121.159 E.04144
G1 F2640
G1 X144.387 Y121.159 E.08288
G1 F2760
G1 X143.038 Y121.159 E.04144
G1 F2880
G1 X141.69 Y121.159 E.04144
G1 F3000
G1 X138.992 Y121.159 E.08288
G1 F3900
G1 X138.592 Y121.159 E.01229
G1 X137.644 Y121.159 E.02915
G1 F4800
G1 X137.244 Y121.159 E.01229
G1 X136.295 Y121.159 E.02915
G1 F5700
G1 X135.895 Y121.159 E.01229
G1 X133.597 Y121.159 E.07059
G1 F6600
G1 X133.197 Y121.159 E.01229
G1 X132.249 Y121.159 E.02915
G1 F7500
G1 X131.849 Y121.159 E.01229
G1 X130.9 Y121.159 E.02915
G1 F8400
G1 X130.5 Y121.159 E.01229
G1 X128.203 Y121.159 E.07059
G1 F9300
G1 X127.803 Y121.159 E.01229
G1 X126.854 Y121.159 E.02915
G1 F10200
G1 X126.454 Y121.159 E.01229
G1 X125.505 Y121.159 E.02915
G1 F11100
G1 X125.105 Y121.159 E.01229
G1 X124.157 Y121.159 E.02915
G1 F12000
G1 X123.757 Y121.159 E.01229
G1 X121.459 Y121.159 E.07059
G1 X120.11 Y121.159 E.04144
G1 X118.762 Y121.159 E.04144
G1 X116.064 Y121.159 E.08288
G1 X114.716 Y121.159 E.04144
G1 X113.367 Y121.159 E.04144
G1 X110.67 Y121.159 E.08288
G1 X109.321 Y121.159 E.04144
G1 X107.972 Y121.159 E.04144
G1 X105.294 Y121.159 E.0823
M204 S10000
; WIPE_START
G1 X105.281 Y123.159 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X104.444 Y120.564 Z15 F30000
G1 Z14.6
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.431684
G1 F15000
G1 X104.444 Y131.436 E.34444
G1 X105.498 Y132.01 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X105.05 Y132.01 E.01487
G1 X104.846 Y132.214 E.00955
G1 X104.394 Y132.214 E.01499
G1 X104.394 Y132.654 E.01461
G1 X105.407 Y133.667 E.0475
G1 X107.081 Y132.01 E.07814
G1 X111.426 Y132.01 E.14412
G1 X113.083 Y133.667 E.07771
G1 X114.757 Y132.01 E.07814
G1 X119.102 Y132.01 E.14412
G1 X120.759 Y133.667 E.07771
G1 X122.433 Y132.01 E.07814
G1 X126.778 Y132.01 E.14412
G1 X128.435 Y133.667 E.07771
G1 X130.109 Y132.01 E.07814
G1 X134.454 Y132.01 E.14412
G1 X135.513 Y133.07 E.0497
G3 X134.008 Y133.64 I-1.889 J-2.715 E.05394
; WIPE_START
G1 X134.929 Y133.403 E-.36128
G1 X135.513 Y133.07 E-.25578
G1 X135.247 Y132.804 E-.14293
; WIPE_END
G1 E-.04 F1800
G1 X134.595 Y125.199 Z15 F30000
G1 X134.008 Y118.36 Z15
G1 Z14.6
G1 E.8 F1800
G1 F15476.087
G3 X135.513 Y118.93 I-.383 J3.285 E.05394
G1 X134.454 Y119.99 E.0497
G1 X130.109 Y119.99 E.14412
G1 X128.43 Y118.338 E.07814
G1 X126.778 Y119.99 E.0775
G1 X122.433 Y119.99 E.14412
G1 X120.756 Y118.336 E.07814
G1 X119.102 Y119.99 E.07757
G1 X114.757 Y119.99 E.14412
G1 X113.081 Y118.335 E.07814
G1 X111.426 Y119.99 E.07763
G1 X107.081 Y119.99 E.14412
G1 X105.406 Y118.333 E.07814
G1 X104.394 Y119.346 E.04749
G1 X104.394 Y119.786 E.01461
G1 X104.846 Y119.786 E.01499
G1 X105.05 Y119.99 E.00955
G1 X105.498 Y119.99 E.01487
G1 X104.473 Y117.906 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.48877
G1 F14130.324
G1 X133.684 Y117.912 E1.06128
G3 X135.549 Y118.459 I-.028 J3.546 E.0715
; LINE_WIDTH: 0.440869
G1 F15000
G3 X136.394 Y119.143 I-4.245 J6.11 E.0353
G1 X137.109 Y119.854 E.03268
; LINE_WIDTH: 0.482837
G1 F14320.882
G1 X137.141 Y119.92 E.00262
; LINE_WIDTH: 0.529123
G1 F12957.55
G1 X137.173 Y119.985 E.00289
; LINE_WIDTH: 0.575409
G1 F11831.23
G1 X137.205 Y120.051 E.00317
; LINE_WIDTH: 0.621695
G1 F10885.059
G1 X137.237 Y120.116 E.00344
; LINE_WIDTH: 0.662432
G1 F10169.3
G1 X137.243 Y120.148 E.0016
; LINE_WIDTH: 0.697619
G1 F9622.742
G1 X137.249 Y120.179 E.00169
; LINE_WIDTH: 0.732807
G1 F9131.939
G1 X137.255 Y120.21 E.00178
; LINE_WIDTH: 0.726524
G1 F9215.869
G1 X137.206 Y120.234 E.00305
; LINE_WIDTH: 0.678771
G1 F9907.993
G1 X137.156 Y120.258 E.00283
; LINE_WIDTH: 0.631017
G1 F10712.517
G1 X137.107 Y120.282 E.00262
; LINE_WIDTH: 0.583264
G1 F11659.239
G1 X137.058 Y120.305 E.00241
; LINE_WIDTH: 0.535511
G1 F12789.519
G1 X137.009 Y120.329 E.0022
; LINE_WIDTH: 0.487758
G1 F14162.468
G1 X136.96 Y120.353 E.00198
; LINE_WIDTH: 0.440005
G1 F15000
G1 X136.91 Y120.377 E.00177
; LINE_WIDTH: 0.41313
G1 X105.048 Y120.378 E.96119
G2 X104.495 Y120.175 I-.484 J.461 E.01843
G1 X104.473 Y134.094 F30000
; LINE_WIDTH: 0.489791
G1 F14098.044
G1 X133.601 Y134.094 E1.06066
G2 X135.539 Y133.547 I.005 J-3.689 E.0743
; LINE_WIDTH: 0.440899
G1 F15000
G2 X136.398 Y132.853 I-4.163 J-6.032 E.03582
G1 X137.109 Y132.146 E.03252
; LINE_WIDTH: 0.483922
G1 F14285.67
G1 X137.129 Y132.096 E.00194
; LINE_WIDTH: 0.532372
G1 F12871.538
G1 X137.15 Y132.046 E.00216
; LINE_WIDTH: 0.580823
G1 F11712.155
G1 X137.171 Y131.996 E.00237
; LINE_WIDTH: 0.629274
G1 F10744.376
G1 X137.191 Y131.946 E.00259
; LINE_WIDTH: 0.677724
G1 F9924.323
G1 X137.212 Y131.896 E.0028
; LINE_WIDTH: 0.726175
G1 F9220.574
G1 X137.232 Y131.846 E.00301
G1 X104.435 Y131.825 F30000
; LINE_WIDTH: 0.413321
G1 F15000
G1 X104.633 Y131.825 E.006
G1 X105.048 Y131.622 F30000
; LINE_WIDTH: 0.413322
G1 F15000
G1 X136.818 Y131.622 E.95891
G1 X150.256 Y131.526 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.59757
G1 F11358.513
G1 X150.758 Y131.552 E.02269
; LINE_WIDTH: 0.556549
G1 F12265.676
G1 X151.259 Y131.577 E.02102
; LINE_WIDTH: 0.515527
G1 F13330.319
G1 X151.761 Y131.602 E.01934
; LINE_WIDTH: 0.477337
G1 F14502.207
G1 X152.187 Y131.623 E.01511
; LINE_WIDTH: 0.442064
G1 F15000
G1 X152.613 Y131.643 E.01385
; LINE_WIDTH: 0.40684
G1 X153.038 Y131.664 E.01262
; WIPE_START
G1 X152.613 Y131.643 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X152.613 Y124.011 Z15 F30000
G1 X152.613 Y120.357 Z15
G1 Z14.6
G1 E.8 F1800
; LINE_WIDTH: 0.442064
G1 F15000
G1 X152.187 Y120.377 E.01385
; LINE_WIDTH: 0.477337
G1 F14502.193
G1 X151.761 Y120.398 E.01511
; LINE_WIDTH: 0.515527
G1 F13330.311
G1 X151.259 Y120.423 E.01934
; LINE_WIDTH: 0.556549
G1 F12265.679
G1 X150.758 Y120.448 E.02102
; LINE_WIDTH: 0.59757
G1 F11358.526
G1 X150.256 Y120.474 E.02269
G1 X152.613 Y120.357 F30000
; LINE_WIDTH: 0.40684
G1 F15000
G1 X153.038 Y120.336 E.01262
; CHANGE_LAYER
; Z_HEIGHT: 14.8
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F15000
G1 X152.613 Y120.357 E-.76
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 74/101
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L74
M991 S0 P73 ;notify layer change
G17
G3 Z15 I-.016 J-1.217 P1  F30000
G1 X104.842 Y120.969 Z15
G1 Z14.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X104.842 Y131.031 E.33379
G1 X148.41 Y131.031 E1.44524
G2 X150.542 Y131.263 I16.471 J-141.77 E.07115
G1 X150.53 Y131.494 E.00769
G1 X138.191 Y131.494 E.40931
G3 X136.011 Y133.614 I-22.565 J-21.029 E.10092
G3 X133.614 Y134.429 I-2.463 J-3.309 E.08537
G1 X104.046 Y134.429 E.98082
G1 X104.046 Y117.571 E.55924
G1 X133.614 Y117.571 E.98082
G1 X134.132 Y117.605 E.01722
G3 X136.426 Y118.742 I-.597 J4.088 E.08637
G3 X138.191 Y120.506 I-32.216 J34.008 E.08278
G1 X150.53 Y120.506 E.40931
G1 X150.542 Y120.737 E.00769
G2 X148.41 Y120.969 I14.339 J142.001 E.07115
G1 X104.902 Y120.969 E1.44325
G1 X105.234 Y121.361 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
G1 X105.234 Y130.639 E.2851
G1 X105.275 Y130.639 E.00126
G1 X106.623 Y130.639 E.04144
G1 X107.972 Y130.639 E.04144
G1 X109.321 Y130.639 E.04144
G1 X110.669 Y130.639 E.04144
G1 X112.018 Y130.639 E.04144
G1 X114.715 Y130.639 E.08288
G1 X116.064 Y130.639 E.04144
G1 X117.413 Y130.639 E.04144
G1 X118.761 Y130.639 E.04144
G1 X119.71 Y130.639 E.02915
G1 X120.11 Y130.639 E.01229
G1 F11100
G1 X121.059 Y130.639 E.02915
G1 X121.459 Y130.639 E.01229
G1 F10200
G1 X123.756 Y130.639 E.07059
G1 X124.156 Y130.639 E.01229
G1 F9300
G1 X125.105 Y130.639 E.02915
G1 X125.505 Y130.639 E.01229
G1 F8400
G1 X126.453 Y130.639 E.02915
G1 X126.853 Y130.639 E.01229
G1 F7500
G1 X127.802 Y130.639 E.02915
G1 X128.202 Y130.639 E.01229
G1 F6600
G1 X129.151 Y130.639 E.02915
G1 X129.551 Y130.639 E.01229
G1 F5700
G1 X130.499 Y130.639 E.02915
G1 X130.899 Y130.639 E.01229
G1 F4800
G1 X133.197 Y130.639 E.07059
G1 X133.597 Y130.639 E.01229
G1 F3900
G1 X134.545 Y130.639 E.02915
G1 X134.945 Y130.639 E.01229
G1 F3000
G1 X136.294 Y130.639 E.04144
G1 F2880
G1 X137.643 Y130.639 E.04144
G1 F2760
G1 X138.991 Y130.639 E.04144
G1 F2640
G1 X140.34 Y130.639 E.04144
G1 F2520
G1 X143.037 Y130.639 E.08288
G1 F2400
G1 X144.386 Y130.639 E.04144
G1 F2280
G1 X145.735 Y130.639 E.04144
G1 F2160
G1 X147.083 Y130.639 E.04144
G1 F2040
G1 X148.432 Y130.639 E.04144
G1 F2160
G1 X149.446 Y130.753 E.03134
G1 F2280
G1 X150.393 Y130.853 E.02926
G1 F2400
G1 X152.287 Y131.052 E.05852
G1 F2520
G1 X153.234 Y131.151 E.02926
G1 F3878.957
G1 X153.234 Y131.279 E.00391
G1 F12000
G1 X153.234 Y131.886 E.01867
G1 X138.356 Y131.886 E.45716
G3 X136.244 Y133.93 I-21.346 J-19.943 E.09033
G3 X133.627 Y134.822 I-2.698 J-3.633 E.08635
G1 X103.654 Y134.822 E.92098
G1 X103.654 Y117.178 E.54212
G1 X133.627 Y117.178 E.92098
G1 X134.173 Y117.215 E.01684
G1 X134.183 Y117.215 E.00031
G3 X136.692 Y118.454 I-.644 J4.464 E.0874
G3 X138.356 Y120.114 I-30.318 J32.052 E.07222
G1 X152.834 Y120.114 E.44487
G1 X153.234 Y120.114 E.01229
G1 F11632.982
G1 X153.234 Y120.721 E.01867
G1 F2520
G1 X153.234 Y120.849 E.00391
G1 F2400
G1 X151.34 Y121.048 E.05852
G1 F2280
G1 X150.393 Y121.147 E.02926
G1 F2160
G1 X149.446 Y121.247 E.02926
M73 P79 R3
G1 F2040
G1 X148.432 Y121.361 E.03134
G1 F2160
G1 X147.083 Y121.361 E.04144
G1 F2280
G1 X145.735 Y121.361 E.04144
G1 F2400
G1 X144.386 Y121.361 E.04144
G1 F2520
G1 X141.689 Y121.361 E.08288
G1 F2640
G1 X140.34 Y121.361 E.04144
G1 F2760
G1 X138.991 Y121.361 E.04144
G1 F2880
G1 X137.643 Y121.361 E.04144
G1 F3000
G1 X136.294 Y121.361 E.04144
G1 F3900
G1 X135.894 Y121.361 E.01229
G1 X134.945 Y121.361 E.02915
G1 F4800
G1 X134.545 Y121.361 E.01229
G1 X132.248 Y121.361 E.07059
G1 F5700
G1 X131.848 Y121.361 E.01229
G1 X130.899 Y121.361 E.02915
G1 F6600
G1 X130.499 Y121.361 E.01229
G1 X129.551 Y121.361 E.02915
G1 F7500
G1 X129.151 Y121.361 E.01229
G1 X128.202 Y121.361 E.02915
G1 F8400
G1 X127.802 Y121.361 E.01229
G1 X126.853 Y121.361 E.02915
G1 F9300
G1 X126.453 Y121.361 E.01229
G1 X125.505 Y121.361 E.02915
G1 F10200
G1 X125.105 Y121.361 E.01229
G1 X122.807 Y121.361 E.07059
G1 F11100
G1 X122.407 Y121.361 E.01229
G1 X121.459 Y121.361 E.02915
G1 F12000
G1 X121.059 Y121.361 E.01229
G1 X120.11 Y121.361 E.02915
G1 X118.761 Y121.361 E.04144
G1 X117.413 Y121.361 E.04144
G1 X116.064 Y121.361 E.04144
G1 X113.367 Y121.361 E.08288
G1 X112.018 Y121.361 E.04144
G1 X110.669 Y121.361 E.04144
G1 X109.321 Y121.361 E.04144
G1 X107.972 Y121.361 E.04144
G1 X105.294 Y121.361 E.0823
M204 S10000
; WIPE_START
G1 X105.281 Y123.361 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X104.444 Y120.765 Z15.2 F30000
G1 Z14.8
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.431684
G1 F15000
G1 X104.444 Y131.235 E.33167
G1 X104.487 Y133.988 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.516963
G1 F13289.945
G1 X133.599 Y133.988 E1.12455
G2 X135.544 Y133.42 I-.021 J-3.687 E.0793
; LINE_WIDTH: 0.461811
G1 F15000
G2 X136.756 Y132.358 I-4.296 J-6.126 E.05512
G1 X137.128 Y131.972 E.0183
; LINE_WIDTH: 0.504465
G1 F13649.807
G1 X137.154 Y131.915 E.00234
; LINE_WIDTH: 0.545103
G1 F12545.227
G1 X137.181 Y131.859 E.00255
; LINE_WIDTH: 0.585741
G1 F11606.036
G1 X137.208 Y131.803 E.00276
; LINE_WIDTH: 0.626379
G1 F10797.673
G1 X137.235 Y131.747 E.00296
; LINE_WIDTH: 0.667017
G1 F10094.585
G1 X137.262 Y131.69 E.00317
; LINE_WIDTH: 0.711545
G1 F9422.329
G1 X137.264 Y131.677 E.00071
; LINE_WIDTH: 0.759962
G1 F8786.102
G1 X137.266 Y131.664 E.00077
G1 X104.448 Y131.637 F30000
; LINE_WIDTH: 0.43989
G1 F15000
G1 X104.628 Y131.637 E.00584
G1 X105.062 Y131.433 F30000
G1 F15000
G1 X136.824 Y131.433 E1.02744
G1 X138.133 Y131.263 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.0988402
G1 F15000
G1 X148.441 Y131.265 E.04697
G1 X150.732 Y131.389 F30000
; LINE_WIDTH: 0.592048
G1 F11472.74
G1 X151.309 Y131.419 E.02583
; LINE_WIDTH: 0.544163
G1 F12568.762
G1 X151.885 Y131.449 E.02357
; LINE_WIDTH: 0.496278
G1 F13896.314
G1 X152.461 Y131.479 E.02132
; LINE_WIDTH: 0.448393
G1 F15000
G1 X153.038 Y131.51 E.01907
; WIPE_START
G1 X152.461 Y131.479 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X152.461 Y123.847 Z15.2 F30000
G1 X152.461 Y120.521 Z15.2
G1 Z14.8
G1 E.8 F1800
; LINE_WIDTH: 0.448392
G1 F15000
G1 X153.038 Y120.49 E.01907
G1 X152.461 Y120.521 F30000
; LINE_WIDTH: 0.496278
G1 F13896.325
G1 X151.885 Y120.551 E.02132
; LINE_WIDTH: 0.544164
G1 F12568.75
G1 X151.309 Y120.581 E.02357
; LINE_WIDTH: 0.592049
G1 F11472.713
G1 X150.732 Y120.611 E.02583
G1 X148.441 Y120.735 F30000
; LINE_WIDTH: 0.0988402
G1 F15000
G1 X138.133 Y120.737 E.04697
G1 X137.038 Y120.521 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.490409
G1 F14078.566
G1 X137.09 Y120.521 E.0019
; LINE_WIDTH: 0.516691
G1 F13297.585
G1 X137.142 Y120.522 E.00201
; LINE_WIDTH: 0.507798
G1 F13551.952
G1 X137.153 Y120.544 E.00093
; LINE_WIDTH: 0.463731
G1 F14971.096
G1 X137.164 Y120.566 E.00084
; LINE_WIDTH: 0.419665
G1 F15000
G1 X137.174 Y120.588 E.00075
; LINE_WIDTH: 0.375598
G1 X137.185 Y120.61 E.00066
; LINE_WIDTH: 0.375869
G1 X137.208 Y120.588 E.00087
; LINE_WIDTH: 0.420479
G1 X137.231 Y120.565 E.00099
; LINE_WIDTH: 0.465089
G1 F14922.933
G1 X137.254 Y120.543 E.0011
; LINE_WIDTH: 0.530875
G1 F12911.026
G1 X137.277 Y120.521 E.00127
G1 X137.578 Y120.521 E.01195
G1 X137.367 Y120.306 E.01195
; LINE_WIDTH: 0.507372
G1 F13564.395
G1 X137.364 Y120.271 E.00135
; LINE_WIDTH: 0.458106
G1 F15000
G1 X137.36 Y120.235 E.00121
; LINE_WIDTH: 0.408841
G1 X137.357 Y120.2 E.00106
; LINE_WIDTH: 0.359575
G1 X137.354 Y120.164 E.00092
; LINE_WIDTH: 0.357825
G1 X137.294 Y120.151 E.00157
; LINE_WIDTH: 0.403589
G1 X137.234 Y120.138 E.0018
; LINE_WIDTH: 0.449354
G1 X137.175 Y120.125 E.00202
G1 X137.152 Y120.159 E.00135
; LINE_WIDTH: 0.403589
G1 X137.128 Y120.192 E.0012
; LINE_WIDTH: 0.357825
G1 X137.105 Y120.226 E.00104
; LINE_WIDTH: 0.359575
G1 X137.119 Y120.255 E.00084
; LINE_WIDTH: 0.408841
G1 X137.134 Y120.285 E.00097
; LINE_WIDTH: 0.458106
G1 X137.148 Y120.314 E.0011
; LINE_WIDTH: 0.507372
G1 F13564.395
G1 X137.162 Y120.344 E.00124
; LINE_WIDTH: 0.509699
G1 F13496.752
G1 X137.132 Y120.356 E.00122
; LINE_WIDTH: 0.465089
G1 F14922.933
G1 X137.102 Y120.368 E.0011
; LINE_WIDTH: 0.420479
G1 F15000
G1 X137.073 Y120.38 E.00099
; LINE_WIDTH: 0.375869
G1 X137.043 Y120.392 E.00087
; LINE_WIDTH: 0.375598
G1 X137.059 Y120.41 E.00066
; LINE_WIDTH: 0.419665
G1 X137.075 Y120.429 E.00075
; LINE_WIDTH: 0.463731
G1 F14971.096
G1 X137.09 Y120.448 E.00084
; LINE_WIDTH: 0.50556
G1 F13617.502
G1 X137.106 Y120.467 E.00092
G1 X137.085 Y120.484 E.00103
G1 X104.448 Y120.363 F30000
; LINE_WIDTH: 0.439891
G1 F15000
G1 X104.688 Y120.363 E.00778
; LINE_WIDTH: 0.425648
G1 X104.844 Y120.438 E.00538
; LINE_WIDTH: 0.40176
G3 X105.062 Y120.567 I-.129 J.467 E.00748
; LINE_WIDTH: 0.43995
G1 X136.884 Y120.567 E1.02953
G1 X136.98 Y120.538 E.00327
G1 X104.487 Y118.012 F30000
; LINE_WIDTH: 0.516863
G1 F13292.75
G1 X133.599 Y118.012 E1.12431
G3 X135.554 Y118.586 I-.023 J3.693 E.07974
; LINE_WIDTH: 0.461913
G1 F15000
G1 X135.978 Y118.894 E.01789
G3 X137.13 Y120.031 I-10.566 J11.853 E.05529
G1 X137.149 Y120.071 E.00152
; WIPE_START
G1 X137.13 Y120.031 E-.01688
G1 X136.739 Y119.618 E-.21603
G1 X135.978 Y118.894 E-.39928
G1 X135.706 Y118.696 E-.12781
; WIPE_END
G1 E-.04 F1800
M73 P80 R3
G1 X134.791 Y126.274 Z15.2 F30000
G1 X133.915 Y133.525 Z15.2
G1 Z14.8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F15476.087
G2 X135.434 Y132.99 I-.338 J-3.38 E.05393
G1 X134.279 Y131.835 E.05416
G1 X130.284 Y131.835 E.13251
G1 X128.572 Y133.547 E.08031
G1 X128.315 Y133.547 E.00853
G1 X126.603 Y131.835 E.08031
G1 X122.608 Y131.835 E.13251
G1 X120.896 Y133.547 E.08031
G1 X120.639 Y133.547 E.00853
G1 X118.927 Y131.835 E.08031
G1 X114.932 Y131.835 E.13251
G1 X113.22 Y133.547 E.08031
G1 X112.963 Y133.547 E.00853
G1 X111.251 Y131.835 E.08031
G1 X107.256 Y131.835 E.13251
G1 X105.544 Y133.547 E.08031
G1 X105.287 Y133.547 E.00853
G1 X104.394 Y132.654 E.0419
G1 X104.394 Y132.039 E.02041
G1 X104.846 Y132.039 E.01499
G3 X105.323 Y131.835 I.34 J.137 E.0191
G1 X105.323 Y120.165 F30000
G1 F15476.087
G3 X104.846 Y119.961 I-.137 J-.34 E.0191
G1 X104.394 Y119.961 E.01499
G1 X104.394 Y119.346 E.02041
G1 X105.287 Y118.453 E.0419
G1 X105.544 Y118.453 E.00853
G1 X107.256 Y120.165 E.08031
G1 X111.251 Y120.165 E.13251
G1 X112.963 Y118.453 E.08031
G1 X113.22 Y118.453 E.00853
G1 X114.932 Y120.165 E.08031
G1 X118.927 Y120.165 E.13251
G1 X120.639 Y118.453 E.08031
G1 X120.896 Y118.453 E.00853
G1 X122.608 Y120.165 E.08031
G1 X126.603 Y120.165 E.13251
G1 X128.315 Y118.453 E.08031
G1 X128.572 Y118.453 E.00853
G1 X130.284 Y120.165 E.08031
G1 X134.279 Y120.165 E.13251
G1 X135.434 Y119.01 E.05416
G2 X133.915 Y118.475 I-1.856 J2.845 E.05394
; CHANGE_LAYER
; Z_HEIGHT: 15
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F15476.087
G1 X134.501 Y118.577 E-.22606
G1 X134.923 Y118.729 E-.17068
G1 X135.434 Y119.01 E-.22139
G1 X135.17 Y119.274 E-.14187
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 75/101
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L75
M991 S0 P74 ;notify layer change
G17
G3 Z15.2 I-.077 J-1.215 P1  F30000
G1 X104.842 Y121.185 Z15.2
G1 Z15
G1 E.8 F1800
; FEATURE: Inner wall
G1 F15476.087
G1 X104.842 Y130.815 E.31942
G1 X148.41 Y130.815 E1.44524
G1 X150.973 Y131.103 E.08557
G1 X150.96 Y131.334 E.00766
G1 X138.178 Y131.334 E.42401
G3 X136.011 Y133.503 I-20.327 J-18.15 E.10176
G3 X133.614 Y134.318 I-2.463 J-3.309 E.08537
G1 X104.046 Y134.318 E.98082
G1 X104.046 Y117.682 E.55183
G1 X133.614 Y117.682 E.98082
G1 X133.996 Y117.708 E.01273
G1 X134.132 Y117.717 E.0045
G3 X136.426 Y118.862 I-.576 J4.026 E.08653
G3 X138.178 Y120.666 I-35.271 J36.001 E.08345
G1 X150.96 Y120.666 E.42401
G1 X150.973 Y120.897 E.00766
G1 X148.41 Y121.185 E.08557
G1 X104.902 Y121.185 E1.44325
G1 X105.234 Y121.577 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
G1 X105.234 Y130.423 E.27178
G1 X105.275 Y130.423 E.00126
G1 X106.623 Y130.423 E.04144
G1 X107.972 Y130.423 E.04144
G1 X109.321 Y130.423 E.04144
G1 X110.669 Y130.423 E.04144
G1 X112.018 Y130.423 E.04144
G1 X113.367 Y130.423 E.04144
G1 X114.715 Y130.423 E.04144
G1 X116.064 Y130.423 E.04144
G1 X117.413 Y130.423 E.04144
G1 X119.71 Y130.423 E.07059
G1 X120.11 Y130.423 E.01229
G1 F11100
G1 X121.059 Y130.423 E.02915
G1 X121.459 Y130.423 E.01229
G1 F10200
G1 X122.407 Y130.423 E.02915
G1 X122.807 Y130.423 E.01229
G1 F9300
G1 X123.756 Y130.423 E.02915
G1 X124.156 Y130.423 E.01229
G1 F8400
G1 X125.105 Y130.423 E.02915
G1 X125.505 Y130.423 E.01229
G1 F7500
G1 X126.453 Y130.423 E.02915
G1 X126.853 Y130.423 E.01229
G1 F6600
G1 X127.802 Y130.423 E.02915
G1 X128.202 Y130.423 E.01229
G1 F5700
G1 X129.151 Y130.423 E.02915
G1 X129.551 Y130.423 E.01229
G1 F4800
G1 X130.499 Y130.423 E.02915
G1 X130.899 Y130.423 E.01229
G1 F3900
G1 X131.848 Y130.423 E.02915
G1 X132.248 Y130.423 E.01229
G1 F3000
G1 X134.945 Y130.423 E.08288
G1 F2880
G1 X136.294 Y130.423 E.04144
G1 F2760
G1 X137.643 Y130.423 E.04144
G1 F2640
G1 X138.991 Y130.423 E.04144
G1 F2520
G1 X140.34 Y130.423 E.04144
G1 F2400
G1 X141.689 Y130.423 E.04144
G1 F2280
G1 X143.037 Y130.423 E.04144
G1 F2160
G1 X144.386 Y130.423 E.04144
G1 F2040
G1 X145.735 Y130.423 E.04144
G1 F1920
G1 X147.083 Y130.423 E.04144
G1 F1800
G1 X148.432 Y130.423 E.04144
G1 F1920
G1 X149.742 Y130.57 E.0405
G1 F2040
G2 X153.234 Y130.948 I28.596 J-247.984 E.10793
G1 F3666.201
G1 X153.234 Y131.11 E.00498
G1 F12000
G1 X153.234 Y131.726 E.01893
G1 X138.351 Y131.726 E.4573
G3 X136.244 Y133.818 I-19.254 J-17.283 E.09129
G3 X133.627 Y134.71 I-2.698 J-3.633 E.08635
G1 X103.654 Y134.71 E.92098
G1 X103.654 Y117.29 E.53526
G1 X133.627 Y117.29 E.92098
G1 X134.022 Y117.316 E.01219
G1 X134.183 Y117.327 E.00496
G3 X136.692 Y118.573 I-.634 J4.425 E.08754
G3 X138.351 Y120.274 I-37.058 J37.812 E.07301
G1 X152.834 Y120.274 E.44501
G1 X153.234 Y120.274 E.01229
G1 F10733.556
G1 X153.234 Y120.89 E.01893
G1 F2040
G1 X153.234 Y121.052 E.00498
G1 X151.051 Y121.282 E.06743
G1 F1920
G1 X149.742 Y121.43 E.0405
G1 F1800
G1 X148.432 Y121.577 E.0405
G1 F1920
G1 X147.083 Y121.577 E.04144
G1 F2040
G1 X145.735 Y121.577 E.04144
G1 F2160
G1 X144.386 Y121.577 E.04144
G1 F2280
G1 X143.037 Y121.577 E.04144
G1 F2400
G1 X141.689 Y121.577 E.04144
G1 F2520
G1 X140.34 Y121.577 E.04144
G1 F2640
G1 X138.991 Y121.577 E.04144
G1 F2760
G1 X137.643 Y121.577 E.04144
G1 F2880
G1 X136.294 Y121.577 E.04144
G1 F3000
G1 X133.597 Y121.577 E.08288
G1 F3900
G1 X133.197 Y121.577 E.01229
G1 X132.248 Y121.577 E.02915
G1 F4800
G1 X131.848 Y121.577 E.01229
G1 X130.899 Y121.577 E.02915
G1 F5700
G1 X130.499 Y121.577 E.01229
G1 X129.551 Y121.577 E.02915
G1 F6600
G1 X129.151 Y121.577 E.01229
G1 X128.202 Y121.577 E.02915
G1 F7500
G1 X127.802 Y121.577 E.01229
G1 X126.853 Y121.577 E.02915
G1 F8400
G1 X126.453 Y121.577 E.01229
G1 X125.505 Y121.577 E.02915
G1 F9300
G1 X125.105 Y121.577 E.01229
G1 X124.156 Y121.577 E.02915
G1 F10200
G1 X123.756 Y121.577 E.01229
G1 X122.807 Y121.577 E.02915
G1 F11100
G1 X122.407 Y121.577 E.01229
G1 X121.459 Y121.577 E.02915
G1 F12000
G1 X121.059 Y121.577 E.01229
G1 X118.761 Y121.577 E.07059
G1 X117.413 Y121.577 E.04144
G1 X116.064 Y121.577 E.04144
G1 X114.715 Y121.577 E.04144
G1 X113.367 Y121.577 E.04144
G1 X112.018 Y121.577 E.04144
G1 X110.669 Y121.577 E.04144
G1 X109.321 Y121.577 E.04144
G1 X107.972 Y121.577 E.04144
G1 X105.294 Y121.577 E.0823
M204 S10000
; WIPE_START
G1 X105.28 Y123.577 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X104.444 Y120.982 Z15.4 F30000
G1 Z15
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.431684
G1 F15000
G1 X104.444 Y131.018 E.31794
G1 X105.148 Y131.66 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X105.05 Y131.66 E.00326
G1 X104.846 Y131.864 E.00955
G1 X104.394 Y131.864 E.01499
G1 X104.394 Y132.654 E.02622
G1 X105.152 Y133.412 E.03556
G1 X105.68 Y133.412 E.0175
G1 X107.431 Y131.66 E.08218
G1 X111.076 Y131.66 E.1209
G1 X112.828 Y133.412 E.08218
G1 X113.356 Y133.412 E.0175
G1 X115.107 Y131.66 E.08218
G1 X118.752 Y131.66 E.1209
G1 X120.504 Y133.412 E.08218
G1 X121.032 Y133.412 E.0175
G1 X122.783 Y131.66 E.08218
G1 X126.428 Y131.66 E.1209
G1 X128.18 Y133.412 E.08218
G1 X128.708 Y133.412 E.0175
G1 X130.459 Y131.66 E.08218
G1 X134.104 Y131.66 E.1209
G1 X135.354 Y132.91 E.05862
G3 X133.818 Y133.397 I-1.783 J-2.959 E.05394
G1 X104.499 Y133.865 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.540315
G1 F12666.005
G1 X133.599 Y133.865 E1.17946
G2 X135.548 Y133.294 I-.022 J-3.689 E.08343
; LINE_WIDTH: 0.480968
G1 F14382
G1 X136.137 Y132.831 E.02672
G2 X137.14 Y131.801 I-10.15 J-10.878 E.05134
; LINE_WIDTH: 0.526092
G1 F13038.84
G1 X137.167 Y131.742 E.00254
; LINE_WIDTH: 0.56898
G1 F11975.834
G1 X137.195 Y131.684 E.00277
; LINE_WIDTH: 0.611867
G1 F11073.087
G1 X137.223 Y131.625 E.003
; LINE_WIDTH: 0.654755
G1 F10296.9
G1 X137.25 Y131.567 E.00322
; LINE_WIDTH: 0.697643
G1 F9622.401
G1 X137.278 Y131.509 E.00345
; LINE_WIDTH: 0.737584
G1 F9069.142
G1 X137.28 Y131.496 E.00073
; LINE_WIDTH: 0.774578
G1 F8610.581
G1 X137.283 Y131.483 E.00076
; LINE_WIDTH: 0.811573
G1 F8196.159
G1 X137.285 Y131.471 E.0008
G1 X104.469 Y131.441 F30000
; LINE_WIDTH: 0.481535
G1 F14363.394
G1 X104.621 Y131.441 E.00543
G1 X105.082 Y131.237 F30000
; LINE_WIDTH: 0.481536
G1 F14363.361
G1 X136.825 Y131.237 E1.13457
G1 X138.14 Y131.074 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.154758
G1 F15000
G1 X148.395 Y131.074 E.09346
G1 X148.668 Y131.09 E.00249
; LINE_WIDTH: 0.111474
G1 X148.941 Y131.105 E.00153
G1 X151.163 Y131.229 F30000
; LINE_WIDTH: 0.59057
G1 F11503.709
G1 X151.788 Y131.262 E.02793
; LINE_WIDTH: 0.542304
G1 F12615.54
G1 X152.413 Y131.295 E.02547
; LINE_WIDTH: 0.494039
G1 F13965.283
G1 X153.038 Y131.328 E.02301
; WIPE_START
G1 X152.413 Y131.295 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X152.861 Y123.676 Z15.4 F30000
G1 X153.038 Y120.672 Z15.4
G1 Z15
G1 E.8 F1800
; LINE_WIDTH: 0.494038
G1 F13965.315
G1 X152.413 Y120.705 E.02301
; LINE_WIDTH: 0.542304
G1 F12615.559
G1 X151.788 Y120.738 E.02547
; LINE_WIDTH: 0.590569
G1 F11503.715
G1 X151.163 Y120.771 E.02793
G1 X148.941 Y120.895 F30000
; LINE_WIDTH: 0.111474
G1 F15000
G1 X148.668 Y120.91 E.00153
; LINE_WIDTH: 0.154758
G1 X148.395 Y120.926 E.00249
G1 X138.14 Y120.926 E.09346
G1 X136.924 Y120.761 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.453777
G1 F15000
G1 X137.735 Y120.781 E.02717
G1 X137.375 Y120.397 E.01761
; LINE_WIDTH: 0.464109
G1 F14957.684
G1 X137.258 Y120.298 E.00527
; LINE_WIDTH: 0.483927
G1 F14285.515
G1 X137.141 Y120.199 E.00552
G1 X137.155 Y120.437 E.00858
; LINE_WIDTH: 0.458524
G1 F15000
G1 X137.073 Y120.626 E.00698
G1 X136.969 Y120.721 E.00478
G1 X104.469 Y120.559 F30000
; LINE_WIDTH: 0.481535
G1 F14363.394
G1 X104.681 Y120.559 E.00758
; LINE_WIDTH: 0.456881
G1 F15000
G1 X104.84 Y120.63 E.00588
; LINE_WIDTH: 0.416752
G3 X105.082 Y120.763 I-.163 J.584 E.00848
; LINE_WIDTH: 0.481536
G1 F14363.361
G1 X136.864 Y120.763 E1.13595
G1 X104.499 Y118.135 F30000
; LINE_WIDTH: 0.541176
G1 F12644.113
G1 X133.599 Y118.135 E1.1815
G3 X135.079 Y118.455 I-.147 J4.268 E.06181
; LINE_WIDTH: 0.483135
G1 F14311.216
G3 X136.41 Y119.424 I-2.117 J4.304 E.05938
G3 X137.1 Y120.155 I-14.171 J14.069 E.03605
G1 X133.818 Y118.603 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X133.915 Y118.61 E.00322
G3 X135.353 Y119.09 I-.355 J3.46 E.05073
G1 X134.104 Y120.34 E.05861
G1 X130.459 Y120.34 E.1209
G1 X128.708 Y118.588 E.08218
G1 X128.18 Y118.588 E.0175
G1 X126.428 Y120.34 E.08218
G1 X122.783 Y120.34 E.1209
G1 X121.032 Y118.588 E.08218
G1 X120.504 Y118.588 E.0175
G1 X118.752 Y120.34 E.08218
G1 X115.107 Y120.34 E.1209
G1 X113.356 Y118.588 E.08218
G1 X112.828 Y118.588 E.0175
G1 X111.076 Y120.34 E.08218
G1 X107.431 Y120.34 E.1209
G1 X105.68 Y118.588 E.08218
G1 X105.152 Y118.588 E.0175
G1 X104.394 Y119.346 E.03556
G1 X104.394 Y120.136 E.02622
G1 X104.846 Y120.136 E.01499
G1 X105.05 Y120.34 E.00955
G1 X105.148 Y120.34 E.00326
; CHANGE_LAYER
; Z_HEIGHT: 15.2
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F15476.087
G1 X105.05 Y120.34 E-.03729
G1 X104.846 Y120.136 E-.10938
G1 X104.394 Y120.136 E-.17175
G1 X104.394 Y119.346 E-.30034
G1 X104.657 Y119.083 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 76/101
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L76
M991 S0 P75 ;notify layer change
G17
G3 Z15.4 I-1.213 J.096 P1  F30000
G1 X104.842 Y121.42 Z15.4
G1 Z15.2
G1 E.8 F1800
; FEATURE: Inner wall
G1 F15476.087
G1 X104.842 Y130.58 E.30387
G1 X148.405 Y130.58 E1.44509
G2 X151.399 Y130.935 I26.053 J-207.274 E.09999
G1 X151.386 Y131.165 E.00766
G1 X138.178 Y131.165 E.43812
G3 X136.42 Y133.02 I-29.02 J-25.754 E.08479
G3 X133.614 Y134.206 I-2.858 J-2.848 E.10364
G1 X104.046 Y134.206 E.98082
G1 X104.046 Y117.794 E.54442
G1 X133.614 Y117.794 E.98082
G1 X133.845 Y117.809 E.00771
G3 X136.42 Y118.98 I-.259 J3.985 E.0959
G3 X138.178 Y120.835 I-27.262 J27.609 E.08479
G1 X151.386 Y120.835 E.43812
G1 X151.399 Y121.065 E.00766
G2 X148.405 Y121.42 I23.059 J207.628 E.09999
G1 X104.902 Y121.42 E1.4431
G1 X105.234 Y121.812 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
G1 X105.234 Y130.188 E.25738
G1 X105.275 Y130.188 E.00126
G1 X106.623 Y130.188 E.04144
G1 X107.972 Y130.188 E.04144
G1 X109.321 Y130.188 E.04144
G1 X110.669 Y130.188 E.04144
G1 X112.018 Y130.188 E.04144
G1 X113.366 Y130.188 E.04144
G1 X114.715 Y130.188 E.04144
G1 X116.064 Y130.188 E.04144
G1 X117.412 Y130.188 E.04144
G1 X118.361 Y130.188 E.02915
G1 X118.761 Y130.188 E.01229
G1 F11100
G1 X119.709 Y130.188 E.02915
G1 X120.109 Y130.188 E.01229
G1 F10200
G1 X121.058 Y130.188 E.02915
G1 X121.458 Y130.188 E.01229
G1 F9300
G1 X122.407 Y130.188 E.02915
G1 X122.807 Y130.188 E.01229
G1 F8400
G1 X123.755 Y130.188 E.02915
G1 X124.155 Y130.188 E.01229
G1 F7500
G1 X125.104 Y130.188 E.02915
G1 X125.504 Y130.188 E.01229
G1 F6600
G1 X126.453 Y130.188 E.02915
G1 X126.853 Y130.188 E.01229
G1 F5700
G1 X127.801 Y130.188 E.02915
G1 X128.201 Y130.188 E.01229
G1 F4800
G1 X129.15 Y130.188 E.02915
G1 X129.55 Y130.188 E.01229
G1 F3900
G1 X130.498 Y130.188 E.02915
G1 X130.898 Y130.188 E.01229
G1 F3000
G1 X132.247 Y130.188 E.04144
G1 F2880
G1 X133.596 Y130.188 E.04144
G1 F2760
G1 X134.944 Y130.188 E.04144
G1 F2640
G1 X136.293 Y130.188 E.04144
G1 F2520
G1 X137.641 Y130.188 E.04144
G1 F2400
G1 X138.99 Y130.188 E.04144
G1 F2280
G1 X140.339 Y130.188 E.04144
G1 F2160
G1 X141.687 Y130.188 E.04144
G1 F2040
G1 X143.036 Y130.188 E.04144
G1 F1920
G1 X144.384 Y130.188 E.04144
G1 F1800
G1 X147.082 Y130.188 E.08288
G1 F1680
G1 X148.43 Y130.188 E.04144
G1 F1800
G2 X149.738 Y130.349 I8.961 J-67.653 E.04049
G1 F1920
G2 X151.574 Y130.56 I19.196 J-158.773 E.05679
G1 F2040
G2 X153.234 Y130.743 I13.822 J-117.84 E.0513
G1 F3687.393
G1 X153.234 Y130.907 E.00504
G1 F12000
G1 X153.234 Y131.557 E.01999
G1 X138.351 Y131.557 E.4573
G3 X136.69 Y133.304 I-27.343 J-24.335 E.0741
G3 X133.627 Y134.598 I-3.129 J-3.135 E.10474
G1 X103.654 Y134.598 E.92098
G1 X103.654 Y117.402 E.52839
G1 X133.627 Y117.402 E.92098
G1 X133.871 Y117.418 E.00754
G3 X136.69 Y118.696 I-.285 J4.377 E.09717
G3 X138.351 Y120.443 I-25.681 J26.082 E.0741
G1 X152.834 Y120.443 E.44501
G1 X153.234 Y120.443 E.01229
G1 F11425.223
G1 X153.234 Y121.093 E.01999
G1 F2040
G1 X153.234 Y121.257 E.00504
G1 X152.657 Y121.318 E.01782
G1 F1920
G1 X150.491 Y121.562 E.06697
G1 F1800
G1 X148.985 Y121.741 E.04662
G1 F1680
G1 X148.43 Y121.812 E.01718
G1 F1800
G1 X145.733 Y121.812 E.08288
G1 F1920
G1 X144.384 Y121.812 E.04144
G1 F2040
G1 X143.036 Y121.812 E.04144
G1 F2160
G1 X141.687 Y121.812 E.04144
G1 F2280
G1 X140.339 Y121.812 E.04144
G1 F2400
G1 X138.99 Y121.812 E.04144
G1 F2520
G1 X137.641 Y121.812 E.04144
G1 F2640
G1 X136.293 Y121.812 E.04144
G1 F2760
G1 X134.944 Y121.812 E.04144
G1 F2880
G1 X133.596 Y121.812 E.04144
G1 F3000
G1 X132.247 Y121.812 E.04144
G1 F3900
G1 X131.847 Y121.812 E.01229
G1 X130.898 Y121.812 E.02915
G1 F4800
G1 X130.498 Y121.812 E.01229
G1 X129.55 Y121.812 E.02915
G1 F5700
G1 X129.15 Y121.812 E.01229
G1 X128.201 Y121.812 E.02915
G1 F6600
G1 X127.801 Y121.812 E.01229
G1 X126.853 Y121.812 E.02915
G1 F7500
G1 X126.453 Y121.812 E.01229
G1 X125.504 Y121.812 E.02915
G1 F8400
G1 X125.104 Y121.812 E.01229
G1 X124.155 Y121.812 E.02915
G1 F9300
G1 X123.755 Y121.812 E.01229
G1 X122.807 Y121.812 E.02915
G1 F10200
G1 X122.407 Y121.812 E.01229
G1 X121.458 Y121.812 E.02915
G1 F11100
G1 X121.058 Y121.812 E.01229
G1 X120.109 Y121.812 E.02915
G1 F12000
G1 X119.709 Y121.812 E.01229
G1 X118.761 Y121.812 E.02915
G1 X117.412 Y121.812 E.04144
G1 X116.064 Y121.812 E.04144
G1 X114.715 Y121.812 E.04144
G1 X113.366 Y121.812 E.04144
G1 X112.018 Y121.812 E.04144
G1 X110.669 Y121.812 E.04144
G1 X109.321 Y121.812 E.04144
G1 X107.972 Y121.812 E.04144
G1 X105.294 Y121.812 E.08229
M204 S10000
; WIPE_START
G1 X105.279 Y123.812 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X104.444 Y121.216 Z15.6 F30000
G1 Z15.2
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.431684
G1 F15000
G1 X104.444 Y130.784 E.3031
G1 X104.976 Y120.468 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X104.846 Y120.338 E.00612
G1 X104.394 Y120.338 E.01499
G1 X104.394 Y119.346 E.0329
G1 X105.017 Y118.723 E.02921
G1 X105.815 Y118.723 E.02647
G1 X107.633 Y120.541 E.0853
G1 X110.875 Y120.541 E.10753
G1 X112.693 Y118.723 E.0853
G1 X113.491 Y118.723 E.02647
G1 X115.309 Y120.541 E.0853
G1 X118.551 Y120.541 E.10753
G1 X120.369 Y118.723 E.0853
G1 X121.167 Y118.723 E.02647
G1 X122.985 Y120.541 E.0853
M73 P81 R3
G1 X126.227 Y120.541 E.10753
G1 X128.045 Y118.723 E.0853
G1 X128.843 Y118.723 E.02647
G1 X130.661 Y120.541 E.0853
G1 X133.902 Y120.541 E.10753
G1 X135.263 Y119.181 E.06381
G2 X133.717 Y118.731 I-1.666 J2.844 E.05395
G1 X136.946 Y120.979 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.501135
G1 F13749.026
G1 X137.344 Y120.995 E.01487
; LINE_WIDTH: 0.46361
G1 F14975.419
G1 X137.742 Y121.012 E.01365
G1 X137.762 Y120.992 E.001
G1 X137.414 Y120.618 E.0175
; LINE_WIDTH: 0.487676
G1 F14165.087
G1 X137.306 Y120.524 E.00519
; LINE_WIDTH: 0.510265
G1 F13480.428
G1 X137.198 Y120.43 E.00545
G1 X137.184 Y120.653 E.00852
; LINE_WIDTH: 0.481504
G1 F14364.422
G3 X136.99 Y120.938 I-.451 J-.099 E.01263
G1 X104.485 Y120.777 F30000
; LINE_WIDTH: 0.514298
G1 F13365.07
G1 X104.675 Y120.777 E.00728
; LINE_WIDTH: 0.4924
G1 F14016.196
G1 X104.783 Y120.822 E.0043
; LINE_WIDTH: 0.448608
G1 F15000
G1 X104.891 Y120.868 E.00388
; LINE_WIDTH: 0.404816
G1 X104.999 Y120.913 E.00346
; LINE_WIDTH: 0.404817
G1 X105.032 Y120.936 E.00116
; LINE_WIDTH: 0.448609
G1 X105.064 Y120.958 E.0013
; LINE_WIDTH: 0.514271
G1 F13365.839
G1 X105.097 Y120.98 E.00151
G1 X136.886 Y120.98 E1.221
G1 X104.51 Y118.259 F30000
; LINE_WIDTH: 0.563662
G1 F12098.125
G1 X133.598 Y118.259 E1.23431
G3 X135.528 Y118.824 I-.002 J3.583 E.08651
; LINE_WIDTH: 0.505383
G1 F13622.718
G3 X136.405 Y119.576 I-4.352 J5.961 E.04356
G3 X137.159 Y120.385 I-14.141 J13.926 E.04168
G1 X138.17 Y121.127 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.220322
G1 F15000
G1 X148.387 Y121.127 E.1477
G1 X148.646 Y121.111 E.00375
; LINE_WIDTH: 0.171074
G1 X148.905 Y121.094 E.00271
; LINE_WIDTH: 0.140101
G1 X149.162 Y121.079 E.00204
; LINE_WIDTH: 0.111303
G1 X149.42 Y121.064 E.00144
G1 X151.588 Y120.939 F30000
; LINE_WIDTH: 0.595116
G1 F11408.991
G1 X152.071 Y120.912 E.02178
; LINE_WIDTH: 0.56084
G1 F12164.037
G1 X152.554 Y120.886 E.02043
; LINE_WIDTH: 0.526565
G1 F13026.105
G1 X153.038 Y120.859 E.01907
; WIPE_START
G1 X152.554 Y120.886 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X152.47 Y128.518 Z15.6 F30000
G1 X152.441 Y131.109 Z15.6
G1 Z15.2
G1 E.8 F1800
; LINE_WIDTH: 0.563796
G1 F12095.01
G1 X152.014 Y131.085 E.01813
; LINE_WIDTH: 0.595728
G1 F11396.362
G1 X151.588 Y131.061 E.01924
G1 X152.441 Y131.109 F30000
; LINE_WIDTH: 0.528268
G1 F12980.384
G1 X153.038 Y131.141 E.02365
G1 X149.42 Y130.936 F30000
; LINE_WIDTH: 0.111304
G1 F15000
G1 X149.162 Y130.921 E.00144
; LINE_WIDTH: 0.140102
G1 X148.905 Y130.906 E.00204
; LINE_WIDTH: 0.171073
G1 X148.646 Y130.889 E.00271
; LINE_WIDTH: 0.220322
G1 X148.387 Y130.873 E.00375
G1 X138.17 Y130.873 E.1477
G1 X136.905 Y131.02 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.477978
G1 F14480.832
G1 X137.096 Y131.166 E.00853
G1 X137.181 Y131.348 E.00714
; LINE_WIDTH: 0.481495
G1 F14364.728
G1 X137.18 Y131.472 E.0044
; LINE_WIDTH: 0.495071
G1 F13933.397
G1 X137.178 Y131.595 E.00454
G1 X137.757 Y131.022 E.02999
; LINE_WIDTH: 0.450921
G1 F15000
G1 X137.762 Y131.008 E.0005
G1 X137.326 Y130.988 E.01453
; LINE_WIDTH: 0.466766
G1 F14863.915
G1 X137.145 Y131.001 E.00625
; LINE_WIDTH: 0.498454
G1 F13829.93
G1 X136.965 Y131.015 E.00672
G1 X105.097 Y131.02 F30000
; LINE_WIDTH: 0.514298
G1 F13365.07
G1 X136.845 Y131.02 E1.21949
G1 X104.485 Y131.223 F30000
; LINE_WIDTH: 0.514297
G1 F13365.098
G1 X104.615 Y131.223 E.00498
G1 X104.51 Y133.741 F30000
; LINE_WIDTH: 0.56372
G1 F12096.787
G1 X133.598 Y133.741 E1.23444
G2 X135.539 Y133.169 I-.003 J-3.589 E.08704
; LINE_WIDTH: 0.50364
G1 F13674.25
G2 X136.393 Y132.437 I-2.75 J-4.07 E.04235
G2 X137.139 Y131.64 I-12.374 J-12.323 E.04098
G1 X133.717 Y133.269 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F15476.087
G2 X135.263 Y132.819 I-.388 J-4.216 E.05373
G1 X133.902 Y131.459 E.06381
G1 X130.661 Y131.459 E.10753
G1 X128.843 Y133.277 E.0853
G1 X128.045 Y133.277 E.02647
G1 X126.227 Y131.459 E.0853
G1 X122.985 Y131.459 E.10753
G1 X121.167 Y133.277 E.0853
G1 X120.369 Y133.277 E.02647
G1 X118.551 Y131.459 E.0853
G1 X115.309 Y131.459 E.10753
G1 X113.491 Y133.277 E.0853
G1 X112.693 Y133.277 E.02647
G1 X110.875 Y131.459 E.0853
G1 X107.633 Y131.459 E.10753
G1 X105.815 Y133.277 E.0853
G1 X105.017 Y133.277 E.02647
G1 X104.394 Y132.654 E.02921
G1 X104.394 Y131.662 E.0329
G1 X104.846 Y131.662 E.01499
G1 X104.976 Y131.532 E.00612
; CHANGE_LAYER
; Z_HEIGHT: 15.4
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F15476.087
G1 X104.846 Y131.662 E-.07008
G1 X104.394 Y131.662 E-.17175
G1 X104.394 Y132.654 E-.37694
G1 X104.657 Y132.917 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 77/101
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L77
M991 S0 P76 ;notify layer change
G17
G3 Z15.6 I1.217 J.02 P1  F30000
G1 X104.842 Y121.689 Z15.6
G1 Z15.4
G1 E.8 F1800
; FEATURE: Inner wall
G1 F15476.087
G1 X104.842 Y130.311 E.28601
G1 X148.405 Y130.311 E1.44509
G2 X152.066 Y130.767 I25.423 J-189.386 E.12238
G1 X152.053 Y130.996 E.00764
G1 X138.178 Y130.996 E.46024
G3 X136.247 Y133.037 I-26.781 J-23.412 E.09323
G3 X133.614 Y134.094 I-2.646 J-2.783 E.09641
G1 X104.046 Y134.094 E.98082
G1 X104.046 Y117.906 E.53701
G1 X133.694 Y117.911 E.9835
G3 X136.247 Y118.963 I-.081 J3.82 E.09369
G3 X138.178 Y121.004 I-24.85 J25.453 E.09323
G1 X152.053 Y121.004 E.46024
G1 X152.066 Y121.233 E.00764
G2 X148.405 Y121.689 I21.762 J189.842 E.12238
G1 X104.902 Y121.689 E1.4431
G1 X105.234 Y122.081 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
G1 X105.234 Y129.919 E.24084
G1 X105.275 Y129.919 E.00126
G1 X106.623 Y129.919 E.04144
G1 X107.972 Y129.919 E.04144
G1 X109.321 Y129.919 E.04144
G1 X110.669 Y129.919 E.04144
G1 X112.018 Y129.919 E.04144
G1 X113.366 Y129.919 E.04144
G1 X114.715 Y129.919 E.04144
G1 X116.064 Y129.919 E.04144
G1 X117.012 Y129.919 E.02915
G1 X117.412 Y129.919 E.01229
G1 F11100
G1 X118.361 Y129.919 E.02915
G1 X118.761 Y129.919 E.01229
G1 F10200
G1 X119.709 Y129.919 E.02915
G1 X120.109 Y129.919 E.01229
G1 F8400
G1 X121.058 Y129.919 E.02915
G1 X121.458 Y129.919 E.01229
G1 F7500
G1 X122.407 Y129.919 E.02915
G1 X122.807 Y129.919 E.01229
G1 F6600
G1 X123.755 Y129.919 E.02915
G1 X124.155 Y129.919 E.01229
G1 F5700
G1 X125.104 Y129.919 E.02915
G1 X125.504 Y129.919 E.01229
G1 F4800
G1 X126.453 Y129.919 E.02915
G1 X126.853 Y129.919 E.01229
G1 F3900
G1 X127.801 Y129.919 E.02915
G1 X128.201 Y129.919 E.01229
G1 F3000
G1 X129.55 Y129.919 E.04144
G1 F2880
G1 X130.898 Y129.919 E.04144
G1 F2760
G1 X132.247 Y129.919 E.04144
G1 F2640
G1 X133.596 Y129.919 E.04144
G1 F2520
G1 X134.944 Y129.919 E.04144
G1 F2400
G1 X136.293 Y129.919 E.04144
G1 F2160
G1 X137.641 Y129.919 E.04144
G1 F2040
G1 X138.99 Y129.919 E.04144
G1 F1920
G1 X140.339 Y129.919 E.04144
G1 F1800
G1 X141.687 Y129.919 E.04144
G1 F1680
G1 X143.036 Y129.919 E.04144
G1 F1560
G1 X144.384 Y129.919 E.04144
G1 F1440
G1 X145.733 Y129.919 E.04144
G1 F1320
G1 X147.082 Y129.919 E.04144
G1 F1200
G1 X148.43 Y129.919 E.04144
G1 F1320
G1 X149.55 Y130.063 E.03468
G1 F1440
G1 X150.669 Y130.206 E.03468
G1 F1560
G1 X151.951 Y130.358 E.03968
G1 F1680
G1 X153.234 Y130.51 E.03968
G1 F3497.102
G1 X153.234 Y130.701 E.00588
G1 F12000
G1 X153.234 Y131.389 E.02111
G1 X138.351 Y131.389 E.4573
G3 X136.51 Y133.328 I-25.614 J-22.472 E.0822
G3 X133.627 Y134.486 I-2.901 J-3.053 E.09779
G1 X103.654 Y134.486 E.92098
G1 X103.654 Y117.514 E.52153
G1 X133.72 Y117.52 E.92387
G3 X136.51 Y118.672 I-.097 J4.189 E.09486
G3 X138.351 Y120.611 I-23.773 J24.412 E.0822
G1 X152.834 Y120.611 E.44501
G1 X153.234 Y120.611 E.01229
G1 F11272.317
G1 X153.234 Y121.299 E.02111
G1 F1680
G1 X153.234 Y121.49 E.00588
G1 F1560
G1 X151.951 Y121.642 E.03968
G1 F1440
G1 X150.669 Y121.794 E.03968
G1 F1320
G1 X149.55 Y121.937 E.03468
G1 F1200
G1 X148.43 Y122.081 E.03468
G1 F1320
G1 X147.082 Y122.081 E.04144
G1 F1440
G1 X145.733 Y122.081 E.04144
G1 F1560
G1 X144.384 Y122.081 E.04144
G1 F1680
G1 X143.036 Y122.081 E.04144
G1 F1800
G1 X141.687 Y122.081 E.04144
G1 F1920
G1 X140.339 Y122.081 E.04144
G1 F2040
G1 X138.99 Y122.081 E.04144
G1 F2160
G1 X137.641 Y122.081 E.04144
G1 F2400
G1 X136.293 Y122.081 E.04144
G1 F2520
G1 X134.944 Y122.081 E.04144
G1 F2640
G1 X133.596 Y122.081 E.04144
G1 F2760
G1 X132.247 Y122.081 E.04144
G1 F2880
G1 X130.898 Y122.081 E.04144
G1 F3000
G1 X129.55 Y122.081 E.04144
G1 F3900
G1 X129.15 Y122.081 E.01229
G1 X128.201 Y122.081 E.02915
G1 F4800
G1 X127.801 Y122.081 E.01229
G1 X126.853 Y122.081 E.02915
G1 F5700
G1 X126.453 Y122.081 E.01229
G1 X125.504 Y122.081 E.02915
G1 F6600
G1 X125.104 Y122.081 E.01229
G1 X124.155 Y122.081 E.02915
G1 F7500
G1 X123.755 Y122.081 E.01229
G1 X122.807 Y122.081 E.02915
G1 F8400
G1 X122.407 Y122.081 E.01229
G1 X121.458 Y122.081 E.02915
G1 F10200
G1 X121.058 Y122.081 E.01229
G1 X120.109 Y122.081 E.02915
G1 F11100
G1 X119.709 Y122.081 E.01229
G1 X118.761 Y122.081 E.02915
G1 F12000
G1 X118.361 Y122.081 E.01229
G1 X117.412 Y122.081 E.02915
G1 X116.064 Y122.081 E.04144
G1 X114.715 Y122.081 E.04144
G1 X113.366 Y122.081 E.04144
G1 X112.018 Y122.081 E.04144
G1 X110.669 Y122.081 E.04144
G1 X109.321 Y122.081 E.04144
G1 X107.972 Y122.081 E.04144
G1 X106.623 Y122.081 E.04144
G1 X105.294 Y122.081 E.04086
M204 S10000
; WIPE_START
G1 X105.278 Y124.081 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X104.444 Y121.485 Z15.8 F30000
G1 Z15.4
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.431684
G1 F15000
G1 X104.444 Y130.515 E.28604
G1 X104.814 Y131.446 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X104.394 Y131.446 E.01392
G1 X104.394 Y132.654 E.04009
G1 X104.882 Y133.142 E.02287
G1 X105.95 Y133.142 E.03544
G1 X107.85 Y131.242 E.08912
G1 X110.658 Y131.242 E.09315
G1 X112.558 Y133.142 E.08912
G1 X113.626 Y133.142 E.03544
G1 X115.526 Y131.242 E.08912
G1 X118.334 Y131.242 E.09315
G1 X120.234 Y133.142 E.08912
G1 X121.302 Y133.142 E.03544
G1 X123.202 Y131.242 E.08912
G1 X126.01 Y131.242 E.09315
G1 X127.91 Y133.142 E.08912
G1 X128.978 Y133.142 E.03544
G1 X130.878 Y131.242 E.08912
G1 X133.686 Y131.242 E.09315
G1 X135.159 Y132.716 E.06912
G3 X133.608 Y133.141 I-1.832 J-3.639 E.05371
G1 X136.914 Y130.777 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.547644
G1 F12482.069
G1 X137.015 Y130.86 E.0054
; LINE_WIDTH: 0.49929
G1 F13804.594
G1 X137.116 Y130.944 E.00488
G1 X137.204 Y131.125 E.00749
; LINE_WIDTH: 0.512349
G1 F13420.56
G1 X137.211 Y131.243 E.00451
; LINE_WIDTH: 0.545859
G1 F12526.371
G1 X137.218 Y131.36 E.00483
; LINE_WIDTH: 0.541699
G1 F12630.851
G1 X137.501 Y131.082 E.01611
; LINE_WIDTH: 0.490079
G1 F14088.953
G1 X137.783 Y130.804 E.01444
G2 X137.794 Y130.733 I-.087 J-.05 E.0027
G1 X137.247 Y130.738 E.01995
; LINE_WIDTH: 0.509232
G1 F13510.268
G1 X137.11 Y130.754 E.00523
; LINE_WIDTH: 0.547644
G1 F12482.069
G1 X136.973 Y130.77 E.00566
G1 X105.118 Y130.777 F30000
; LINE_WIDTH: 0.56685
G1 F12024.507
G1 X136.854 Y130.777 E1.35488
G1 X104.511 Y130.98 F30000
G1 F12024.507
G1 X104.605 Y130.98 E.00399
G1 X104.522 Y133.618 F30000
; LINE_WIDTH: 0.587287
G1 F11573.074
G1 X133.598 Y133.618 E1.28977
G2 X135.545 Y133.018 I.002 J-3.455 E.09177
; LINE_WIDTH: 0.52806
G1 F12985.95
G2 X136.401 Y132.269 I-2.727 J-3.977 E.04507
G2 X137.179 Y131.406 I-24.736 J-23.108 E.04593
G1 X138.216 Y130.654 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.320434
G1 F15000
G1 X148.383 Y130.654 E.22993
G1 X148.74 Y130.677 E.00808
; LINE_WIDTH: 0.253912
G1 X149.096 Y130.699 E.00614
; LINE_WIDTH: 0.209057
G1 X149.453 Y130.722 E.00484
; LINE_WIDTH: 0.164203
G1 X149.809 Y130.745 E.00353
; LINE_WIDTH: 0.119348
G1 X150.166 Y130.768 E.00222
; WIPE_START
G1 X149.809 Y130.745 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z15.8 I1.216 J.046 P1  F30000
G1 X150.166 Y121.232 Z15.8
G1 Z15.4
G1 E.8 F1800
; LINE_WIDTH: 0.119348
G1 F15000
G1 X149.809 Y121.255 E.00222
; LINE_WIDTH: 0.164203
G1 X149.453 Y121.278 E.00353
; LINE_WIDTH: 0.209058
G1 X149.096 Y121.301 E.00484
; LINE_WIDTH: 0.253913
G1 X148.74 Y121.323 E.00614
; LINE_WIDTH: 0.320434
G1 X148.383 Y121.346 E.00808
G1 X138.216 Y121.346 E.22993
G1 X136.959 Y121.221 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.547855
G1 F12476.861
G1 X137.355 Y121.244 E.01632
; LINE_WIDTH: 0.490516
G1 F14075.192
G2 X137.794 Y121.267 I.417 J-3.773 E.01604
G1 X137.794 Y121.225 E.00156
G1 X137.448 Y120.836 E.01899
; LINE_WIDTH: 0.506114
G1 F13601.219
G1 X137.322 Y120.725 E.00632
; LINE_WIDTH: 0.530639
G1 F12917.295
G1 X137.197 Y120.614 E.00665
G1 X137.201 Y120.874 E.01032
; LINE_WIDTH: 0.494544
G1 F13949.657
G1 X137.121 Y121.058 E.00741
; LINE_WIDTH: 0.518151
G1 F13256.732
G1 X137.061 Y121.119 E.00328
; LINE_WIDTH: 0.553265
G1 F12344.597
G1 X137.001 Y121.179 E.00352
G1 X105.118 Y121.223 F30000
; LINE_WIDTH: 0.56685
G1 F12024.507
G1 X136.899 Y121.223 E1.35683
G1 X104.511 Y121.02 F30000
; LINE_WIDTH: 0.566851
G1 F12024.484
G1 X104.605 Y121.02 E.00399
G1 X104.522 Y118.382 F30000
; LINE_WIDTH: 0.585104
G1 F11619.673
G1 X133.617 Y118.385 E1.28545
G3 X135.536 Y118.976 I-.005 J3.427 E.09003
; LINE_WIDTH: 0.52731
G1 F13006.047
G1 X135.982 Y119.32 E.02222
G3 X137.158 Y120.569 I-10.266 J10.842 E.06774
G1 X133.608 Y118.859 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F15476.087
G3 X135.159 Y119.284 I-.029 J3.15 E.05395
G1 X133.686 Y120.758 E.06912
G1 X130.878 Y120.758 E.09315
G1 X128.979 Y118.859 E.08908
G1 X127.909 Y118.859 E.0355
G1 X126.01 Y120.758 E.08908
G1 X123.202 Y120.758 E.09315
G1 X121.303 Y118.859 E.08909
G1 X120.233 Y118.859 E.03548
G1 X118.334 Y120.758 E.08909
G1 X115.526 Y120.758 E.09315
G1 X113.626 Y118.859 E.0891
G1 X112.557 Y118.859 E.03546
G1 X110.658 Y120.758 E.0891
G1 X107.85 Y120.758 E.09315
G1 X105.95 Y118.858 E.08912
G1 X104.882 Y118.858 E.03544
G1 X104.394 Y119.346 E.02287
G1 X104.394 Y120.554 E.04009
G1 X104.814 Y120.554 E.01392
; CHANGE_LAYER
; Z_HEIGHT: 15.6
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F15476.087
G1 X104.394 Y120.554 E-.1595
G1 X104.394 Y119.346 E-.45926
G1 X104.657 Y119.083 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 78/101
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L78
M991 S0 P77 ;notify layer change
G17
G3 Z15.8 I-1.214 J.077 P1  F30000
G1 X104.842 Y121.98 Z15.8
G1 Z15.6
G1 E.8 F1800
; FEATURE: Inner wall
G1 F15476.087
G1 X104.842 Y130.02 E.2667
G1 X148.399 Y130.02 E1.44486
G2 X152.497 Y130.565 I49.037 J-353.038 E.13714
G1 X152.483 Y130.795 E.00764
G1 X138.162 Y130.795 E.47504
G3 X135.999 Y133.118 I-17.844 J-14.445 E.1054
G3 X133.612 Y133.975 I-2.464 J-3.113 E.0856
G1 X104.046 Y133.975 E.98078
G1 X104.046 Y118.025 E.52908
G1 X133.612 Y118.025 E.98078
G1 X134.103 Y118.059 E.0163
G1 X134.127 Y118.061 E.00082
G3 X136.413 Y119.264 I-.654 J4.015 E.08717
G3 X138.162 Y121.205 I-26.22 J25.385 E.08671
G1 X152.483 Y121.205 E.47504
G1 X152.497 Y121.435 E.00764
G2 X148.399 Y121.98 I44.939 J353.583 E.13714
G1 X104.902 Y121.98 E1.44287
G1 X105.234 Y122.372 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
G1 X105.234 Y129.628 E.22295
G1 X105.275 Y129.628 E.00126
G1 X106.623 Y129.628 E.04144
G1 X107.972 Y129.628 E.04144
G1 X109.32 Y129.628 E.04144
G1 X110.669 Y129.628 E.04144
G1 X112.017 Y129.628 E.04144
G1 X113.366 Y129.628 E.04144
G1 X114.715 Y129.628 E.04144
G1 X115.663 Y129.628 E.02915
G1 X116.063 Y129.628 E.01229
G1 F11100
G1 X117.012 Y129.628 E.02915
G1 X117.412 Y129.628 E.01229
G1 F10200
G1 X118.36 Y129.628 E.02915
G1 X118.76 Y129.628 E.01229
G1 F9300
G1 X119.709 Y129.628 E.02915
G1 X120.109 Y129.628 E.01229
G1 F8400
G1 X121.057 Y129.628 E.02915
G1 X121.457 Y129.628 E.01229
G1 F6600
G1 X122.406 Y129.628 E.02915
G1 X122.806 Y129.628 E.01229
G1 F5700
G1 X123.754 Y129.628 E.02915
G1 X124.154 Y129.628 E.01229
G1 F4800
G1 X125.103 Y129.628 E.02915
G1 X125.503 Y129.628 E.01229
G1 F3900
G1 X126.451 Y129.628 E.02915
G1 X126.851 Y129.628 E.01229
G1 F3000
G1 X128.2 Y129.628 E.04144
G1 F2880
G1 X129.548 Y129.628 E.04144
G1 F2640
G1 X130.897 Y129.628 E.04144
G1 F2520
G1 X132.246 Y129.628 E.04144
G1 F2400
G1 X133.594 Y129.628 E.04144
G1 F2280
G1 X134.943 Y129.628 E.04144
G1 F2160
G1 X136.291 Y129.628 E.04144
G1 F2040
G1 X137.64 Y129.628 E.04144
G1 F1800
G1 X138.988 Y129.628 E.04144
G1 F1680
G1 X140.337 Y129.628 E.04144
G1 F1560
G1 X141.685 Y129.628 E.04144
G1 F1440
G1 X143.034 Y129.628 E.04144
G1 F1320
G1 X144.382 Y129.628 E.04144
G1 F1200
G1 X145.731 Y129.628 E.04144
G1 F1080
G1 X147.079 Y129.628 E.04144
G1 F840
G1 X148.428 Y129.628 E.04144
G1 F1080
G1 X148.971 Y129.71 E.01687
G1 F1200
G1 X150.072 Y129.86 E.03416
G1 F1320
G1 X151.213 Y130.007 E.03533
G1 F1440
G2 X153.234 Y130.257 I13.992 J-104.545 E.06258
G1 F3364.367
G1 X153.234 Y130.469 E.0065
M73 P82 R3
G1 F12000
G1 X153.234 Y131.187 E.02206
G1 X138.346 Y131.187 E.45747
G3 X136.24 Y133.428 I-16.944 J-13.807 E.09457
G3 X133.626 Y134.367 I-2.707 J-3.431 E.08684
G1 X103.654 Y134.367 E.92097
G1 X103.654 Y117.633 E.51418
G1 X133.626 Y117.633 E.92097
G1 X134.13 Y117.668 E.01552
G1 X134.182 Y117.672 E.0016
G3 X136.687 Y118.984 I-.713 J4.411 E.08842
G3 X138.346 Y120.813 I-26.917 J26.063 E.07589
G1 X152.834 Y120.813 E.44518
G1 X153.234 Y120.813 E.01229
G1 F11249.236
G1 X153.234 Y121.531 E.02206
G1 F1440
G1 X153.234 Y121.743 E.0065
G1 X152.353 Y121.847 E.02724
G1 F1320
G1 X151.213 Y121.993 E.03533
G1 F1200
G1 X150.072 Y122.14 E.03533
G1 F1080
G1 X148.971 Y122.29 E.03416
G1 F840
G1 X148.428 Y122.372 E.01687
G1 F1080
G1 X147.079 Y122.372 E.04144
G1 F1200
G1 X145.731 Y122.372 E.04144
G1 F1320
G1 X144.382 Y122.372 E.04144
G1 F1440
G1 X143.034 Y122.372 E.04144
G1 F1560
G1 X141.685 Y122.372 E.04144
G1 F1680
G1 X140.337 Y122.372 E.04144
G1 F1800
G1 X138.988 Y122.372 E.04144
G1 F2040
G1 X137.64 Y122.372 E.04144
G1 F2160
G1 X136.291 Y122.372 E.04144
G1 F2280
G1 X134.943 Y122.372 E.04144
G1 F2400
G1 X133.594 Y122.372 E.04144
G1 F2520
G1 X132.246 Y122.372 E.04144
G1 F2640
G1 X130.897 Y122.372 E.04144
G1 F2880
G1 X129.548 Y122.372 E.04144
G1 F3000
G1 X128.2 Y122.372 E.04144
G1 F3900
G1 X127.8 Y122.372 E.01229
G1 X126.851 Y122.372 E.02915
G1 F4800
G1 X126.451 Y122.372 E.01229
G1 X125.503 Y122.372 E.02915
G1 F5700
G1 X125.103 Y122.372 E.01229
G1 X124.154 Y122.372 E.02915
G1 F6600
G1 X123.754 Y122.372 E.01229
G1 X122.806 Y122.372 E.02915
G1 F8400
G1 X122.406 Y122.372 E.01229
G1 X121.457 Y122.372 E.02915
G1 F9300
G1 X121.057 Y122.372 E.01229
G1 X120.109 Y122.372 E.02915
G1 F10200
G1 X119.709 Y122.372 E.01229
G1 X118.76 Y122.372 E.02915
G1 F11100
G1 X118.36 Y122.372 E.01229
G1 X117.412 Y122.372 E.02915
G1 F12000
G1 X117.012 Y122.372 E.01229
G1 X116.063 Y122.372 E.02915
G1 X114.715 Y122.372 E.04144
G1 X113.366 Y122.372 E.04144
G1 X112.017 Y122.372 E.04144
G1 X110.669 Y122.372 E.04144
G1 X109.32 Y122.372 E.04144
G1 X107.972 Y122.372 E.04144
G1 X106.623 Y122.372 E.04144
G1 X105.294 Y122.372 E.04085
M204 S10000
; WIPE_START
G1 X105.277 Y124.372 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X104.444 Y121.777 Z16 F30000
G1 Z15.6
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.431684
G1 F15000
G1 X104.444 Y130.223 E.26759
G1 X104.579 Y120.789 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X104.394 Y120.789 E.00615
G1 X104.394 Y119.346 E.04786
G1 X104.726 Y119.014 E.01558
G1 X106.105 Y119.014 E.04575
G1 X108.084 Y120.992 E.09282
G1 X110.424 Y120.992 E.07761
G1 X112.402 Y119.014 E.09282
G1 X113.781 Y119.014 E.04575
G1 X115.76 Y120.992 E.09282
G1 X118.1 Y120.992 E.07761
G1 X120.078 Y119.014 E.09282
G1 X121.457 Y119.014 E.04575
G1 X123.436 Y120.992 E.09282
G1 X125.776 Y120.992 E.07761
G1 X127.754 Y119.014 E.09282
G1 X129.133 Y119.014 E.04575
G1 X131.112 Y120.992 E.09282
G1 X133.451 Y120.992 E.07761
G1 X135.055 Y119.389 E.07523
G2 X133.49 Y119.014 I-1.551 J3.019 E.0539
G1 X136.986 Y121.484 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.607416
G1 F11160.408
G1 X137.12 Y121.505 E.00624
; LINE_WIDTH: 0.566039
G1 F12043.161
G1 X137.254 Y121.525 E.00579
; LINE_WIDTH: 0.507851
G1 F13550.411
G2 X137.787 Y121.546 I.333 J-1.717 E.02028
G1 X137.787 Y121.463 E.00315
G1 X137.487 Y121.079 E.01844
; LINE_WIDTH: 0.528834
G1 F12965.264
G1 X137.358 Y120.959 E.00698
; LINE_WIDTH: 0.567316
G1 F12013.822
G1 X137.229 Y120.84 E.00753
G1 X137.273 Y120.985 E.00651
; LINE_WIDTH: 0.53714
G1 F12747.371
G1 X137.153 Y121.298 E.01348
; LINE_WIDTH: 0.540439
G1 F12662.833
G1 X137.11 Y121.345 E.00257
; LINE_WIDTH: 0.575505
G1 F11829.097
G1 X137.068 Y121.392 E.00275
; LINE_WIDTH: 0.610571
G1 F11098.369
G1 X137.026 Y121.439 E.00293
G1 X105.14 Y121.486 F30000
; LINE_WIDTH: 0.623702
G1 F10847.444
G1 X136.926 Y121.486 E1.5043
G1 X104.54 Y118.519 F30000
; LINE_WIDTH: 0.623668
G1 F10848.08
G1 X133.595 Y118.519 E1.37499
G3 X135.079 Y118.863 I-.136 J3.963 E.07251
; LINE_WIDTH: 0.57381
G1 F11866.866
G1 X135.541 Y119.128 E.02305
; LINE_WIDTH: 0.536901
G1 F12753.546
G3 X136.431 Y119.924 I-2.779 J4 E.04817
; LINE_WIDTH: 0.545672
G1 F12531.029
G1 X136.81 Y120.359 E.02366
; LINE_WIDTH: 0.572064
G1 F11906.022
G1 X137.189 Y120.794 E.0249
G1 X138.221 Y121.593 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.410255
G1 F15000
G1 X148.37 Y121.593 E.30378
G1 X148.617 Y121.574 E.00742
; LINE_WIDTH: 0.35503
G1 X148.864 Y121.556 E.00631
; LINE_WIDTH: 0.31728
G1 X149.146 Y121.536 E.00631
; LINE_WIDTH: 0.27906
G1 X149.425 Y121.517 E.00539
; LINE_WIDTH: 0.240978
G1 X149.705 Y121.498 E.00452
; LINE_WIDTH: 0.202895
G1 X149.985 Y121.479 E.00365
; LINE_WIDTH: 0.162099
G1 X150.339 Y121.457 E.00344
; LINE_WIDTH: 0.118634
G1 X150.692 Y121.434 E.00218
; WIPE_START
G1 X150.339 Y121.457 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z16 I-1.216 J-.047 P1  F30000
G1 X149.985 Y130.521 Z16
G1 Z15.6
G1 E.8 F1800
; LINE_WIDTH: 0.162098
G1 F15000
G1 X150.339 Y130.543 E.00344
; LINE_WIDTH: 0.118634
G1 X150.692 Y130.566 E.00218
G1 X149.985 Y130.521 F30000
; LINE_WIDTH: 0.202896
G1 F15000
G1 X149.705 Y130.502 E.00365
; LINE_WIDTH: 0.240978
G1 X149.425 Y130.483 E.00452
; LINE_WIDTH: 0.279061
G1 X149.146 Y130.464 E.00539
; LINE_WIDTH: 0.317281
G1 X148.864 Y130.444 E.00631
; LINE_WIDTH: 0.355029
G1 X148.617 Y130.426 E.00631
; LINE_WIDTH: 0.410254
G1 X148.37 Y130.407 E.00742
G1 X138.221 Y130.407 E.30378
G1 X136.935 Y130.514 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.604369
G1 F11220.983
G1 X137.006 Y130.578 E.00434
; LINE_WIDTH: 0.565701
G1 F12050.948
G1 X137.076 Y130.642 E.00404
; LINE_WIDTH: 0.532825
G1 F12859.641
G1 X137.146 Y130.706 E.00379
G1 X137.278 Y131.016 E.01347
; LINE_WIDTH: 0.575123
G1 F11837.6
G1 X137.252 Y131.133 E.0052
; LINE_WIDTH: 0.567751
G1 F12003.87
G1 X137.51 Y130.861 E.01601
; LINE_WIDTH: 0.512813
G1 F13407.33
G1 X137.768 Y130.59 E.01433
G2 X137.787 Y130.454 I-.178 J-.095 E.00538
G1 X137.305 Y130.456 E.01847
; LINE_WIDTH: 0.527033
G1 F13013.495
G1 X137.201 Y130.472 E.00412
; LINE_WIDTH: 0.565701
G1 F12050.948
G1 X137.098 Y130.488 E.00445
; LINE_WIDTH: 0.604369
G1 F11220.983
G1 X136.995 Y130.505 E.00478
G1 X105.14 Y130.514 F30000
; LINE_WIDTH: 0.623702
G1 F10847.444
G1 X136.875 Y130.514 E1.50191
G1 X104.54 Y133.481 F30000
; LINE_WIDTH: 0.623663
G1 F10848.172
G1 X133.595 Y133.48 E1.37498
G2 X135.089 Y133.132 I-.103 J-3.816 E.0731
; LINE_WIDTH: 0.57328
G1 F11878.725
G1 X135.551 Y132.866 E.02302
; LINE_WIDTH: 0.53324
G1 F12848.751
G2 X136.447 Y132.059 I-5.553 J-7.068 E.04822
; LINE_WIDTH: 0.545076
G1 F12545.916
G1 X136.83 Y131.619 E.02388
; LINE_WIDTH: 0.571827
G1 F11911.368
G1 X137.213 Y131.179 E.02515
G1 X133.49 Y132.986 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F15476.087
G2 X135.055 Y132.611 I.055 J-3.225 E.05395
G1 X133.451 Y131.008 E.07523
G1 X131.112 Y131.008 E.07761
G1 X129.133 Y132.986 E.09282
G1 X127.754 Y132.986 E.04575
G1 X125.776 Y131.008 E.09282
G1 X123.436 Y131.008 E.07761
G1 X121.457 Y132.986 E.09282
G1 X120.078 Y132.986 E.04575
G1 X118.1 Y131.008 E.09282
G1 X115.76 Y131.008 E.07761
G1 X113.781 Y132.986 E.09282
G1 X112.402 Y132.986 E.04575
G1 X110.424 Y131.008 E.09282
G1 X108.084 Y131.008 E.07761
G1 X106.105 Y132.986 E.09282
G1 X104.726 Y132.986 E.04575
G1 X104.394 Y132.654 E.01558
G1 X104.394 Y131.211 E.04786
G1 X104.579 Y131.211 E.00615
; CHANGE_LAYER
; Z_HEIGHT: 15.8
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F15476.087
G1 X104.394 Y131.211 E-.07045
G1 X104.394 Y132.654 E-.54831
G1 X104.657 Y132.917 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 79/101
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L79
M991 S0 P78 ;notify layer change
G17
G3 Z16 I1.217 J.021 P1  F30000
G1 X104.842 Y122.32 Z16
G1 Z15.8
G1 E.8 F1800
; FEATURE: Inner wall
G1 F15476.087
G1 X104.842 Y129.68 E.24418
G1 X148.399 Y129.68 E1.44486
G2 X152.842 Y130.321 I25.493 J-161.171 E.14891
G1 X152.842 Y130.59 E.00893
G1 X138.162 Y130.59 E.48694
G3 X136.406 Y132.597 I-25.024 J-20.122 E.08851
G1 X135.984 Y132.99 E.0191
G3 X133.612 Y133.84 I-2.406 J-2.979 E.08516
G1 X104.046 Y133.84 E.98078
G1 X104.046 Y118.16 E.52011
G1 X133.612 Y118.16 E.98078
G1 X133.944 Y118.184 E.01104
G1 X134.127 Y118.196 E.00609
G3 X136.431 Y119.428 I-.622 J3.933 E.08827
G3 X138.162 Y121.41 I-23.5 J22.277 E.08733
G1 X152.842 Y121.41 E.48694
G1 X152.842 Y121.679 E.00893
G2 X148.399 Y122.32 I21.05 J161.811 E.14891
G1 X104.902 Y122.32 E1.44287
G1 X105.234 Y122.712 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
G1 X105.234 Y129.288 E.20209
G1 X105.275 Y129.288 E.00126
G1 X106.623 Y129.288 E.04144
G1 X107.972 Y129.288 E.04144
G1 X109.32 Y129.288 E.04144
G1 X110.669 Y129.288 E.04144
G1 X112.017 Y129.288 E.04144
G1 X113.366 Y129.288 E.04144
G1 X114.315 Y129.288 E.02915
G1 X114.715 Y129.288 E.01229
G1 F11100
G1 X115.663 Y129.288 E.02915
G1 X116.063 Y129.288 E.01229
G1 F10200
G1 X117.012 Y129.288 E.02915
G1 X117.412 Y129.288 E.01229
G1 F8400
G1 X118.36 Y129.288 E.02915
G1 X118.76 Y129.288 E.01229
G1 F7500
G1 X119.709 Y129.288 E.02915
G1 X120.109 Y129.288 E.01229
G1 F6600
G1 X121.057 Y129.288 E.02915
G1 X121.457 Y129.288 E.01229
G1 F4800
G1 X122.406 Y129.288 E.02915
G1 X122.806 Y129.288 E.01229
G1 F3900
G1 X123.754 Y129.288 E.02915
G1 X124.154 Y129.288 E.01229
G1 F3000
G1 X125.503 Y129.288 E.04144
G1 F2760
G1 X126.851 Y129.288 E.04144
G1 F2640
G1 X128.2 Y129.288 E.04144
G1 F2520
G1 X129.548 Y129.288 E.04144
G1 F2280
G1 X130.897 Y129.288 E.04144
G1 F2160
G1 X132.246 Y129.288 E.04144
G1 F2040
G1 X133.594 Y129.288 E.04144
G1 F1800
G1 X134.943 Y129.288 E.04144
G1 F1680
G1 X136.291 Y129.288 E.04144
G1 F1560
G1 X137.64 Y129.288 E.04144
G1 F1320
G1 X138.988 Y129.288 E.04144
G1 F1200
G1 X140.337 Y129.288 E.04144
G1 F1080
G1 X141.685 Y129.288 E.04144
G1 F840
G1 X143.034 Y129.288 E.04144
G1 F720
G1 X144.382 Y129.288 E.04144
G1 F600
G1 X145.731 Y129.288 E.04144
G1 X147.079 Y129.288 E.04144
G1 X148.428 Y129.288 E.04144
G1 X149.589 Y129.464 E.03608
G1 F720
G1 X150.75 Y129.639 E.03608
G1 F840
G1 X151.992 Y129.809 E.03851
G1 F1080
G1 X153.234 Y129.979 E.03851
G1 F3068.349
G1 X153.234 Y130.216 E.0073
G1 F12000
G1 X153.234 Y130.982 E.02353
G1 X138.346 Y130.982 E.45747
G3 X136.685 Y132.873 I-23.579 J-19.028 E.07736
G1 X136.235 Y133.292 E.01889
G3 X133.626 Y134.232 I-2.653 J-3.274 E.08682
G1 X103.654 Y134.232 E.92097
G1 X103.654 Y117.768 E.50587
G1 X133.626 Y117.768 E.92097
G1 X133.972 Y117.792 E.01064
G1 X134.182 Y117.807 E.00648
G3 X136.71 Y119.153 I-.682 J4.33 E.08965
G3 X138.346 Y121.018 I-22.113 J21.035 E.07625
G1 X152.834 Y121.018 E.44518
G1 X153.234 Y121.018 E.01229
G1 F11133.043
G1 X153.234 Y121.784 E.02353
G1 F1080
G1 X153.234 Y122.021 E.0073
G1 F840
G1 X151.992 Y122.191 E.03851
G1 F720
G1 X150.75 Y122.361 E.03851
G1 F600
G1 X149.589 Y122.536 E.03608
G1 X148.428 Y122.712 E.03608
G1 X147.079 Y122.712 E.04144
G1 X145.731 Y122.712 E.04144
G1 F720
G1 X144.382 Y122.712 E.04144
G1 F840
G1 X143.034 Y122.712 E.04144
G1 F1080
G1 X141.685 Y122.712 E.04144
G1 F1200
G1 X140.337 Y122.712 E.04144
G1 F1320
G1 X138.988 Y122.712 E.04144
G1 F1560
G1 X137.64 Y122.712 E.04144
G1 F1680
G1 X136.291 Y122.712 E.04144
G1 F1800
G1 X134.943 Y122.712 E.04144
G1 F2040
G1 X133.594 Y122.712 E.04144
G1 F2160
G1 X132.246 Y122.712 E.04144
G1 F2280
G1 X130.897 Y122.712 E.04144
G1 F2520
G1 X129.548 Y122.712 E.04144
G1 F2640
G1 X128.2 Y122.712 E.04144
G1 F2760
G1 X126.851 Y122.712 E.04144
G1 F3000
G1 X125.503 Y122.712 E.04144
G1 F3900
G1 X125.103 Y122.712 E.01229
G1 X124.154 Y122.712 E.02915
G1 F4800
G1 X123.754 Y122.712 E.01229
G1 X122.806 Y122.712 E.02915
G1 F6600
G1 X122.406 Y122.712 E.01229
G1 X121.457 Y122.712 E.02915
G1 F7500
G1 X121.057 Y122.712 E.01229
G1 X120.109 Y122.712 E.02915
G1 F8400
G1 X119.709 Y122.712 E.01229
G1 X118.76 Y122.712 E.02915
G1 F10200
G1 X118.36 Y122.712 E.01229
G1 X117.412 Y122.712 E.02915
G1 F11100
G1 X117.012 Y122.712 E.01229
G1 X116.063 Y122.712 E.02915
G1 F12000
G1 X115.663 Y122.712 E.01229
G1 X114.715 Y122.712 E.02915
G1 X113.366 Y122.712 E.04144
G1 X112.017 Y122.712 E.04144
G1 X110.669 Y122.712 E.04144
G1 X109.32 Y122.712 E.04144
G1 X107.972 Y122.712 E.04144
G1 X106.623 Y122.712 E.04144
G1 X105.294 Y122.712 E.04085
M204 S10000
; WIPE_START
G1 X105.275 Y124.712 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X104.444 Y122.116 Z16.2 F30000
G1 Z15.8
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.431684
G1 F15000
G1 X104.444 Y129.884 E.24609
G1 X104.394 Y131.026 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X104.394 Y132.654 E.05401
G1 X104.565 Y132.825 E.008
G1 X106.267 Y132.825 E.05647
G1 X108.353 Y130.739 E.09787
G1 X110.154 Y130.739 E.05975
G1 X112.241 Y132.825 E.09787
G1 X113.943 Y132.825 E.05647
G1 X116.029 Y130.739 E.09787
G1 X117.83 Y130.739 E.05975
G1 X119.917 Y132.825 E.09787
G1 X121.619 Y132.825 E.05647
G1 X123.705 Y130.739 E.09787
G1 X125.506 Y130.739 E.05975
G1 X127.593 Y132.825 E.09787
G1 X129.295 Y132.825 E.05647
G1 X131.381 Y130.739 E.09787
G1 X133.182 Y130.739 E.05975
G1 X134.951 Y132.507 E.08296
G2 X136.185 Y131.465 I-3.244 J-5.092 E.05374
G1 X138.277 Y130.135 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.54445
G1 F12561.571
G1 X148.364 Y130.135 E.41225
G1 X148.691 Y130.16 E.0134
; LINE_WIDTH: 0.471628
G1 F14695.313
M73 P83 R3
G1 X149.018 Y130.184 E.01146
; LINE_WIDTH: 0.422566
G1 F15000
G1 X149.345 Y130.209 E.01014
; LINE_WIDTH: 0.373503
G1 X149.672 Y130.233 E.00883
; LINE_WIDTH: 0.324441
G1 X149.999 Y130.258 E.00752
; LINE_WIDTH: 0.275378
G1 X150.326 Y130.282 E.00621
; LINE_WIDTH: 0.226316
G1 X150.653 Y130.307 E.0049
; LINE_WIDTH: 0.184249
G1 X150.92 Y130.325 E.00307
; LINE_WIDTH: 0.149274
G1 X151.185 Y130.343 E.0023
; LINE_WIDTH: 0.114372
G1 X151.45 Y130.361 E.00155
; WIPE_START
G1 X151.185 Y130.343 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z16.2 I1.216 J-.037 P1  F30000
G1 X150.92 Y121.675 Z16.2
G1 Z15.8
G1 E.8 F1800
; LINE_WIDTH: 0.149274
G1 F15000
G1 X151.185 Y121.657 E.0023
; LINE_WIDTH: 0.114372
G1 X151.45 Y121.639 E.00155
G1 X150.92 Y121.675 F30000
; LINE_WIDTH: 0.184247
G1 F15000
G1 X150.653 Y121.693 E.00307
; LINE_WIDTH: 0.226314
G1 X150.326 Y121.718 E.0049
; LINE_WIDTH: 0.275377
G1 X149.999 Y121.742 E.00621
; LINE_WIDTH: 0.32444
G1 X149.672 Y121.767 E.00752
; LINE_WIDTH: 0.373502
G1 X149.345 Y121.791 E.00883
; LINE_WIDTH: 0.422565
G1 X149.018 Y121.816 E.01014
; LINE_WIDTH: 0.471628
G1 F14695.324
G1 X148.691 Y121.84 E.01146
; LINE_WIDTH: 0.54445
G1 F12561.571
G1 X148.364 Y121.865 E.0134
G1 X138.277 Y121.865 E.41225
G1 X136.185 Y120.535 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F15476.087
G2 X134.951 Y119.493 I-4.478 J4.05 E.05374
G1 X133.182 Y121.261 E.08296
G1 X131.381 Y121.261 E.05975
G1 X129.295 Y119.175 E.09787
G1 X127.593 Y119.175 E.05647
G1 X125.506 Y121.261 E.09787
G1 X123.705 Y121.261 E.05975
G1 X121.619 Y119.175 E.09787
G1 X119.917 Y119.175 E.05647
G1 X117.83 Y121.261 E.09787
G1 X116.029 Y121.261 E.05975
G1 X113.943 Y119.175 E.09787
G1 X112.241 Y119.175 E.05647
G1 X110.154 Y121.261 E.09787
G1 X108.353 Y121.261 E.05975
G1 X106.267 Y119.175 E.09787
G1 X104.565 Y119.175 E.05647
G1 X104.394 Y119.346 E.008
G1 X104.394 Y120.974 E.05401
G1 X104.553 Y118.668 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.650774
G1 F10364.345
G1 X133.595 Y118.668 E1.43849
G3 X134.586 Y118.818 I-.164 J4.419 E.04974
; LINE_WIDTH: 0.60967
G1 F11116.014
G3 X135.526 Y119.27 I-1.03 J3.351 E.04838
; LINE_WIDTH: 0.56608
G1 F12042.204
G3 X136.399 Y120.076 I-2.914 J4.029 E.05075
; LINE_WIDTH: 0.568008
G1 F11997.989
G1 X136.704 Y120.433 E.0201
; LINE_WIDTH: 0.605371
G1 F11200.988
G3 X137.26 Y121.099 I-13.22 J11.606 E.03975
G1 X136.959 Y121.953 F30000
; LINE_WIDTH: 0.3894
G1 F15000
G1 X137.147 Y121.932 E.00534
; LINE_WIDTH: 0.431358
G1 X137.335 Y121.911 E.00599
; LINE_WIDTH: 0.473317
G1 F14637.674
G1 X137.523 Y121.89 E.00663
; LINE_WIDTH: 0.531143
G1 F12903.947
G3 X137.827 Y121.869 I.246 J1.352 E.01216
G1 X137.827 Y121.753 E.00462
G1 X137.621 Y121.464 E.01411
; LINE_WIDTH: 0.557871
G1 F12234.174
G1 X137.459 Y121.305 E.00953
; LINE_WIDTH: 0.592548
G1 F11462.314
G1 X137.298 Y121.145 E.01017
G1 X137.272 Y121.403 E.01159
; LINE_WIDTH: 0.533701
G1 F12836.689
G1 X137.216 Y121.484 E.00395
; LINE_WIDTH: 0.506407
G1 F13592.637
G1 X137.16 Y121.566 E.00373
; LINE_WIDTH: 0.472036
G1 F14681.351
G1 X137.093 Y121.586 E.00245
; LINE_WIDTH: 0.43059
G1 F15000
G1 X137.026 Y121.607 E.00222
; LINE_WIDTH: 0.368443
G1 X136.959 Y121.628 E.00186
G1 X104.999 Y121.628 E.84776
G1 X104.894 Y121.589 E.00299
G1 X104.702 Y121.424 E.0067
G1 X104.412 Y121.424 E.00768
G1 X104.412 Y121.75 E.00863
G1 X104.924 Y121.761 E.01358
G1 X105.014 Y121.851 E.00338
G1 X105.026 Y121.953 E.00272
G1 X136.899 Y121.953 E.84546
; WIPE_START
G1 X134.899 Y121.953 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z16.2 I-.427 J-1.139 P1  F30000
G1 X104.553 Y133.332 Z16.2
G1 Z15.8
G1 E.8 F1800
; LINE_WIDTH: 0.649917
G1 F10378.966
G1 X133.595 Y133.332 E1.43647
G2 X135.093 Y132.981 I-.104 J-3.819 E.07664
; LINE_WIDTH: 0.585771
G1 F11605.401
G1 X135.538 Y132.723 E.02277
G1 X135.982 Y132.357 E.02545
; LINE_WIDTH: 0.566129
G1 F12041.078
G2 X136.979 Y131.257 I-10.519 J-10.535 E.06333
; LINE_WIDTH: 0.605185
G1 F11204.682
G1 X137.239 Y130.93 E.01914
G1 X136.959 Y130.047 F30000
; LINE_WIDTH: 0.36842
G1 F15000
G1 X105.026 Y130.047 E.847
G1 X105.014 Y130.149 E.00272
G1 X104.897 Y130.247 E.00406
G1 X104.412 Y130.25 E.01286
G1 X104.412 Y130.576 E.00863
G1 X104.702 Y130.576 E.00768
G1 X104.939 Y130.384 E.00809
G1 X105.165 Y130.372 E.00601
G1 X136.959 Y130.372 E.84331
; LINE_WIDTH: 0.389144
G1 X137.026 Y130.393 E.00198
; LINE_WIDTH: 0.43059
G1 X137.093 Y130.414 E.00222
; LINE_WIDTH: 0.472036
G1 F14681.351
G1 X137.16 Y130.434 E.00245
; LINE_WIDTH: 0.516339
G1 F13307.45
G1 X137.269 Y130.599 E.00761
; LINE_WIDTH: 0.559631
G1 F12192.508
G1 X137.273 Y130.741 E.00598
; LINE_WIDTH: 0.580875
G1 F11711.03
G1 X137.277 Y130.883 E.00622
G1 X137.8 Y130.321 E.03364
; LINE_WIDTH: 0.520933
G1 F13179.562
G2 X137.827 Y130.131 I-.249 J-.133 E.00766
G1 X137.361 Y130.109 E.01816
; LINE_WIDTH: 0.472036
G1 F14681.351
G1 X137.247 Y130.091 E.00405
; LINE_WIDTH: 0.43059
G1 F15000
G1 X137.133 Y130.074 E.00366
; LINE_WIDTH: 0.389144
G1 X137.018 Y130.056 E.00326
; CHANGE_LAYER
; Z_HEIGHT: 16
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F15000
G1 X137.133 Y130.074 E-.76
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 80/101
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L80
M991 S0 P79 ;notify layer change
G17
G3 Z16.2 I.27 J-1.187 P1  F30000
G1 X104.842 Y122.719 Z16.2
G1 Z16
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X104.842 Y129.281 E.21769
G1 X148.388 Y129.281 E1.44452
G2 X152.842 Y130.006 I26.064 J-146.036 E.14968
G1 X152.842 Y130.37 E.01207
G1 X138.143 Y130.37 E.48759
G1 X137.867 Y130.737 E.01522
G3 X136.263 Y132.57 I-22.576 J-18.145 E.08085
G3 X133.612 Y133.704 I-2.669 J-2.572 E.09821
G1 X104.046 Y133.704 E.98078
G1 X104.046 Y118.296 E.51114
G1 X133.612 Y118.296 E.98078
G1 X133.786 Y118.308 E.00577
G3 X136.398 Y119.566 I-.205 J3.766 E.0987
G3 X138.143 Y121.63 I-21.225 J19.718 E.0897
G1 X152.842 Y121.63 E.48759
G1 X152.842 Y121.994 E.01207
G2 X148.388 Y122.719 I21.61 J146.761 E.14968
G1 X104.902 Y122.719 E1.44253
G1 X105.234 Y123.111 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
G1 X105.234 Y128.889 E.17755
G1 X105.275 Y128.889 E.00126
G1 X106.623 Y128.889 E.04143
G1 X107.972 Y128.889 E.04143
G1 X109.32 Y128.889 E.04143
G1 X110.668 Y128.889 E.04143
G1 X112.017 Y128.889 E.04143
G1 X112.965 Y128.889 E.02914
G1 X113.365 Y128.889 E.01229
G1 F11100
G1 X114.314 Y128.889 E.02914
G1 X114.714 Y128.889 E.01229
G1 F9300
G1 X115.662 Y128.889 E.02914
G1 X116.062 Y128.889 E.01229
G1 F8400
G1 X117.011 Y128.889 E.02914
G1 X117.411 Y128.889 E.01229
G1 F6600
G1 X118.359 Y128.889 E.02914
G1 X118.759 Y128.889 E.01229
G1 F5700
G1 X119.707 Y128.889 E.02914
G1 X120.107 Y128.889 E.01229
G1 F3900
G1 X121.056 Y128.889 E.02914
G1 X121.456 Y128.889 E.01229
G1 F3000
G1 X122.804 Y128.889 E.04143
G1 F2760
G1 X124.153 Y128.889 E.04143
G1 F2640
G1 X125.501 Y128.889 E.04143
G1 F2400
G1 X126.85 Y128.889 E.04143
G1 F2280
G1 X128.198 Y128.889 E.04143
G1 F2040
G1 X129.546 Y128.889 E.04143
G1 F1920
G1 X130.895 Y128.889 E.04143
G1 F1680
G1 X132.243 Y128.889 E.04143
G1 F1440
G1 X133.592 Y128.889 E.04143
G1 F1320
G1 X134.94 Y128.889 E.04143
G1 F1080
G1 X136.289 Y128.889 E.04143
G1 F960
G1 X137.637 Y128.889 E.04143
G1 F720
G1 X138.985 Y128.889 E.04143
G1 F600
G1 X140.334 Y128.889 E.04143
G1 X141.682 Y128.889 E.04143
G1 X143.031 Y128.889 E.04143
G1 X144.379 Y128.889 E.04143
G1 X145.728 Y128.889 E.04143
G1 X147.076 Y128.889 E.04143
G1 X148.424 Y128.889 E.04143
G1 X149.526 Y129.093 E.03442
G1 X150.326 Y129.225 E.02491
G1 X151.126 Y129.356 E.02491
G2 X153.234 Y129.664 I12.255 J-76.462 E.06546
G1 F2540.048
G1 X153.234 Y129.937 E.00839
G1 F12000
G1 X153.234 Y130.762 E.02535
G1 X138.339 Y130.762 E.45768
G1 X138.175 Y130.98 E.00839
G3 X136.535 Y132.852 I-22.739 J-18.268 E.07648
G3 X133.626 Y134.097 I-2.94 J-2.851 E.09982
G1 X103.654 Y134.097 E.92097
G1 X103.654 Y117.903 E.49757
G1 X133.626 Y117.903 E.92097
G1 X133.813 Y117.917 E.00577
G3 X135.252 Y118.247 I-.238 J4.338 E.04556
G3 X136.682 Y119.296 I-2.162 J4.447 E.05481
G3 X138.339 Y121.238 I-23.213 J21.483 E.07846
G1 X152.834 Y121.238 E.44539
G1 X153.234 Y121.238 E.01229
G1 F10556.954
G1 X153.234 Y122.063 E.02535
G1 F600
G1 X153.234 Y122.336 E.00839
G1 X152.529 Y122.432 E.02185
G1 X151.126 Y122.644 E.04361
G1 X150.326 Y122.775 E.02491
G1 X149.526 Y122.907 E.02491
G1 X148.424 Y123.111 E.03442
G1 X147.076 Y123.111 E.04143
G1 X145.728 Y123.111 E.04143
G1 X144.379 Y123.111 E.04143
G1 X143.031 Y123.111 E.04143
G1 X141.682 Y123.111 E.04143
G1 X140.334 Y123.111 E.04143
G1 F720
G1 X138.985 Y123.111 E.04143
G1 F960
G1 X137.637 Y123.111 E.04143
G1 F1080
G1 X136.289 Y123.111 E.04143
G1 F1320
G1 X134.94 Y123.111 E.04143
G1 F1440
G1 X133.592 Y123.111 E.04143
G1 F1680
G1 X132.243 Y123.111 E.04143
G1 F1920
G1 X130.895 Y123.111 E.04143
G1 F2040
G1 X129.546 Y123.111 E.04143
G1 F2280
G1 X128.198 Y123.111 E.04143
G1 F2400
G1 X126.85 Y123.111 E.04143
G1 F2640
G1 X125.501 Y123.111 E.04143
G1 F2760
G1 X124.153 Y123.111 E.04143
G1 F3000
G1 X122.804 Y123.111 E.04143
G1 F3900
G1 X122.404 Y123.111 E.01229
G1 X121.456 Y123.111 E.02914
G1 F5700
G1 X121.056 Y123.111 E.01229
G1 X120.107 Y123.111 E.02914
G1 F6600
G1 X119.707 Y123.111 E.01229
G1 X118.759 Y123.111 E.02914
G1 F8400
G1 X118.359 Y123.111 E.01229
G1 X117.411 Y123.111 E.02914
G1 F9300
G1 X117.011 Y123.111 E.01229
G1 X116.062 Y123.111 E.02914
G1 F11100
G1 X115.662 Y123.111 E.01229
G1 X114.714 Y123.111 E.02914
G1 F12000
G1 X114.314 Y123.111 E.01229
G1 X113.365 Y123.111 E.02914
G1 X112.017 Y123.111 E.04143
G1 X110.668 Y123.111 E.04143
G1 X109.32 Y123.111 E.04143
G1 X107.972 Y123.111 E.04143
G1 X106.623 Y123.111 E.04143
G1 X105.294 Y123.111 E.04085
M204 S10000
; WIPE_START
G1 X105.273 Y125.111 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X104.444 Y122.515 Z16.4 F30000
G1 Z16
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.431684
G1 F15000
G1 X104.444 Y129.485 E.22079
G1 X104.8 Y132.663 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X106.428 Y132.663 E.05401
G1 X108.644 Y130.447 E.10396
G1 X109.863 Y130.447 E.04043
G1 X112.079 Y132.663 E.10396
G1 X114.104 Y132.663 E.06718
G1 X116.32 Y130.447 E.10396
G1 X117.539 Y130.447 E.04043
G1 X119.755 Y132.663 E.10396
G1 X121.78 Y132.663 E.06718
G1 X123.996 Y130.447 E.10396
G1 X125.215 Y130.447 E.04043
G1 X127.431 Y132.663 E.10396
G1 X129.456 Y132.663 E.06718
G1 X131.672 Y130.447 E.10396
G1 X132.891 Y130.447 E.04043
G1 X134.834 Y132.39 E.09112
G2 X136.088 Y131.372 I-1.772 J-3.465 E.05396
G1 X137.499 Y129.987 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.362336
G1 F15000
G1 X137.439 Y130.022 E.0018
G1 X137.481 Y130.046 E.00128
G1 X136.99 Y129.675 F30000
; LINE_WIDTH: 0.422402
G1 F15000
G1 X105.053 Y129.675 E.98758
G1 X105.031 Y129.776 E.00322
G1 X104.627 Y129.877 E.01289
G1 X104.438 Y129.877 E.00584
G1 X104.438 Y130.259 E.0118
G1 X104.692 Y130.259 E.00785
; LINE_WIDTH: 0.397839
G1 X104.823 Y130.183 E.00436
; LINE_WIDTH: 0.367404
G1 X104.953 Y130.108 E.00399
G1 X105.199 Y130.054 E.00666
; LINE_WIDTH: 0.422456
G1 X136.99 Y130.054 E.98319
G1 X137.167 Y130.177 E.00668
; LINE_WIDTH: 0.439416
G1 X137.219 Y130.251 E.00292
; LINE_WIDTH: 0.47825
G1 F14471.797
G1 X137.271 Y130.325 E.00321
; LINE_WIDTH: 0.517084
G1 F13286.565
G1 X137.323 Y130.399 E.00349
; LINE_WIDTH: 0.556129
G1 F12275.717
G1 X137.33 Y130.457 E.00242
; LINE_WIDTH: 0.595385
G1 F11403.437
G1 X137.336 Y130.514 E.0026
; LINE_WIDTH: 0.634642
G1 F10646.897
G1 X137.342 Y130.571 E.00278
; LINE_WIDTH: 0.632776
G1 F10680.58
G1 X137.403 Y130.53 E.00351
; LINE_WIDTH: 0.589787
G1 F11520.172
G1 X137.463 Y130.489 E.00326
; LINE_WIDTH: 0.546798
G1 F12503.027
G1 X137.523 Y130.448 E.003
; LINE_WIDTH: 0.50381
G1 F13669.228
G1 X137.584 Y130.407 E.00274
; LINE_WIDTH: 0.460821
G1 F15000
G1 X137.644 Y130.365 E.00249
; LINE_WIDTH: 0.425175
G1 X137.894 Y130.056 E.01239
; LINE_WIDTH: 0.385077
G1 X138.041 Y129.996 E.00443
G1 X148.441 Y129.996 E.28996
G1 X148.47 Y129.677 E.00894
G1 X148.285 Y129.655 E.00519
G1 X138.041 Y129.655 E.28563
G3 X137.05 Y129.674 I-.819 J-16.702 E.02765
G1 X134.773 Y132.966 F30000
; LINE_WIDTH: 0.643195
G1 F10495.2
G2 X135.668 Y132.451 I-1.195 J-3.117 E.05074
; LINE_WIDTH: 0.589341
G1 F11529.586
G2 X136.693 Y131.393 I-5.748 J-6.593 E.06568
; LINE_WIDTH: 0.610121
G1 F11107.184
G1 X137 Y131.006 E.02281
; LINE_WIDTH: 0.63677
G1 F10608.749
G1 X137.306 Y130.619 E.02388
G1 X133.594 Y133.025 F30000
; LINE_WIDTH: 0.359957
G1 F15000
G1 X104.408 Y133.025 E.75402
G1 X104.408 Y133.342 E.00819
G1 X133.6 Y133.342 E.75416
G2 X134.423 Y133.237 I-.009 J-3.356 E.0215
; LINE_WIDTH: 0.378278
G1 X134.473 Y133.199 E.00173
; LINE_WIDTH: 0.421273
G1 X134.523 Y133.16 E.00195
; LINE_WIDTH: 0.464267
G1 F14952.07
G1 X134.573 Y133.121 E.00217
; LINE_WIDTH: 0.507261
G1 F13567.63
G1 X134.623 Y133.082 E.00239
; LINE_WIDTH: 0.550255
G1 F12417.839
G1 X134.673 Y133.044 E.00261
; LINE_WIDTH: 0.593249
G1 F11447.702
G1 X134.723 Y133.005 E.00283
; LINE_WIDTH: 0.636243
G1 F10618.164
G1 X134.773 Y132.966 E.00305
G1 X134.713 Y132.961 E.00289
; LINE_WIDTH: 0.593249
G1 F11447.702
G1 X134.654 Y132.956 E.00268
; LINE_WIDTH: 0.550255
G1 F12417.839
G1 X134.594 Y132.951 E.00247
; LINE_WIDTH: 0.507261
G1 F13567.63
G1 X134.535 Y132.946 E.00226
; LINE_WIDTH: 0.464267
G1 F14952.07
M73 P84 R3
G1 X134.475 Y132.941 E.00205
; LINE_WIDTH: 0.421273
G1 F15000
G1 X134.416 Y132.936 E.00184
; LINE_WIDTH: 0.359598
G1 X133.654 Y133.02 E.01977
; WIPE_START
G1 X134.416 Y132.936 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z16.4 I1.206 J.164 P1  F30000
G1 X136.088 Y120.628 Z16.4
G1 Z16
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F15476.087
G2 X134.834 Y119.61 I-3.026 J2.447 E.05396
G1 X132.891 Y121.553 E.09112
G1 X131.672 Y121.553 E.04043
G1 X129.461 Y119.341 E.10374
G1 X127.427 Y119.341 E.06748
G1 X125.215 Y121.553 E.10375
G1 X123.996 Y121.553 E.04043
G1 X121.784 Y119.34 E.1038
G1 X119.752 Y119.34 E.06739
G1 X117.539 Y121.553 E.10382
G1 X116.32 Y121.553 E.04043
G1 X114.106 Y119.339 E.10387
G1 X112.078 Y119.338 E.06729
G1 X109.863 Y121.553 E.10389
G1 X108.644 Y121.553 E.04043
G1 X106.429 Y119.337 E.10393
G1 X104.801 Y119.337 E.05401
G1 X104.627 Y121.934 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.777208
G1 F8579.74
G1 X104.672 Y121.95 E.00285
; LINE_WIDTH: 0.735688
G1 F9093.954
G1 X104.717 Y121.966 E.00269
; LINE_WIDTH: 0.694168
G1 F9673.735
G1 X104.762 Y121.982 E.00253
; LINE_WIDTH: 0.652648
G1 F10332.476
G1 X104.807 Y121.997 E.00237
G1 X133.594 Y118.979 F30000
; LINE_WIDTH: 0.358677
G1 F15000
G1 X134.095 Y119.012 E.01291
G1 X134.353 Y119.068 E.0068
; LINE_WIDTH: 0.378221
G1 X134.412 Y119.063 E.00163
; LINE_WIDTH: 0.421282
G1 X134.472 Y119.058 E.00184
; LINE_WIDTH: 0.464343
G1 F14949.356
G1 X134.531 Y119.053 E.00205
; LINE_WIDTH: 0.507404
G1 F13563.438
G1 X134.591 Y119.048 E.00226
; LINE_WIDTH: 0.550466
G1 F12412.688
G1 X134.65 Y119.043 E.00247
; LINE_WIDTH: 0.593527
G1 F11441.933
G1 X134.709 Y119.038 E.00268
; LINE_WIDTH: 0.636588
G1 F10612.002
G1 X134.769 Y119.033 E.00288
G1 X134.719 Y118.994 E.00306
; LINE_WIDTH: 0.593527
G1 F11441.933
G1 X134.669 Y118.955 E.00283
; LINE_WIDTH: 0.550466
G1 F12412.688
G1 X134.619 Y118.917 E.00261
; LINE_WIDTH: 0.507404
G1 F13563.438
G1 X134.569 Y118.878 E.00239
; LINE_WIDTH: 0.464343
G1 F14949.356
G1 X134.519 Y118.839 E.00217
; LINE_WIDTH: 0.421282
G1 F15000
G1 X134.47 Y118.801 E.00195
; LINE_WIDTH: 0.361289
G1 X134.42 Y118.762 E.00164
G1 X133.594 Y118.659 E.02158
G1 X104.408 Y118.658 E.75718
G1 X104.408 Y118.975 E.00822
G1 X133.534 Y118.979 E.75562
G1 X134.769 Y119.033 F30000
; LINE_WIDTH: 0.643623
G1 F10487.715
G3 X135.668 Y119.549 I-1.187 J3.109 E.05096
; LINE_WIDTH: 0.593592
G1 F11440.57
G1 X136.058 Y119.897 E.02346
G3 X136.693 Y120.607 I-10.95 J10.445 E.04275
; LINE_WIDTH: 0.610194
G1 F11105.754
G1 X136.988 Y120.979 E.02196
; LINE_WIDTH: 0.636793
G1 F10608.338
G1 X137.283 Y121.352 E.02299
G1 X136.99 Y122.325 F30000
; LINE_WIDTH: 0.385847
G1 F15000
G3 X138.041 Y122.345 I.294 J12.593 E.02939
G1 X148.354 Y122.345 E.28818
G1 X148.47 Y122.323 E.00331
G1 X148.441 Y122.004 E.00896
G1 X138.041 Y122.004 E.29061
G1 X137.892 Y121.945 E.00447
G1 X137.652 Y121.629 E.01111
; LINE_WIDTH: 0.443009
G1 X137.585 Y121.583 E.00263
; LINE_WIDTH: 0.489027
G1 F14122.176
G1 X137.519 Y121.537 E.00293
; LINE_WIDTH: 0.535046
G1 F12801.613
G1 X137.453 Y121.491 E.00324
; LINE_WIDTH: 0.581064
G1 F11706.901
G1 X137.387 Y121.445 E.00354
; LINE_WIDTH: 0.627083
G1 F10784.667
G1 X137.32 Y121.399 E.00384
; LINE_WIDTH: 0.627329
G1 F10780.137
G1 X137.317 Y121.466 E.00319
; LINE_WIDTH: 0.581801
G1 F11690.903
G1 X137.315 Y121.533 E.00294
; LINE_WIDTH: 0.536273
G1 F12769.766
G1 X137.312 Y121.6 E.00269
; LINE_WIDTH: 0.491467
G1 F14045.359
G1 X137.167 Y121.772 E.00822
; LINE_WIDTH: 0.422641
G1 F15000
G1 X137.023 Y121.944 E.00696
G1 X136.99 Y121.946 E.00102
G1 X105.257 Y121.946 E.98188
; LINE_WIDTH: 0.443407
G1 X105.178 Y121.96 E.00261
; LINE_WIDTH: 0.485292
G1 F14241.434
G1 X105.1 Y121.974 E.00289
; LINE_WIDTH: 0.527176
G1 F13009.647
G1 X105.021 Y121.989 E.00316
; LINE_WIDTH: 0.569061
G1 F11973.981
G1 X104.942 Y122.003 E.00343
; LINE_WIDTH: 0.610946
G1 F11091.049
G1 X104.863 Y122.017 E.00371
; LINE_WIDTH: 0.608907
G1 F11130.998
G1 X104.921 Y122.054 E.00316
; LINE_WIDTH: 0.562945
G1 F12114.802
G1 X104.978 Y122.091 E.0029
; LINE_WIDTH: 0.524296
G1 F13087.483
G1 X105.028 Y122.195 E.00449
; LINE_WIDTH: 0.49296
G1 F13998.755
G1 X105.077 Y122.298 E.0042
; LINE_WIDTH: 0.463585
G1 F14976.286
G1 X105.167 Y122.312 E.00312
; LINE_WIDTH: 0.422504
G1 F15000
G1 X105.257 Y122.325 E.00282
G1 X136.93 Y122.325 E.97967
G1 X137.499 Y121.944 F30000
; LINE_WIDTH: 0.362336
G1 F15000
G1 X137.439 Y121.978 E.0018
G1 X137.481 Y122.003 E.00128
G1 X148.828 Y122.129 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.572024
G1 F11906.94
G1 X149.103 Y122.104 E.01191
; LINE_WIDTH: 0.546222
G1 F12517.342
G1 X149.378 Y122.079 E.01133
; LINE_WIDTH: 0.510688
G1 F13468.237
G1 X149.655 Y122.056 E.0106
; LINE_WIDTH: 0.46594
G1 F14892.908
G1 X149.927 Y122.034 E.00941
; LINE_WIDTH: 0.42161
G1 F15000
G1 X150.199 Y122.012 E.00842
; LINE_WIDTH: 0.377279
G1 X150.471 Y121.99 E.00743
; LINE_WIDTH: 0.332949
G1 X150.743 Y121.967 E.00645
; LINE_WIDTH: 0.288618
G1 X151.015 Y121.945 E.00546
; LINE_WIDTH: 0.24517
G1 X151.305 Y121.923 E.0048
; LINE_WIDTH: 0.202738
G1 X151.594 Y121.902 E.00377
; LINE_WIDTH: 0.16041
G1 X151.883 Y121.88 E.00277
; LINE_WIDTH: 0.118083
G1 X152.172 Y121.858 E.00177
; WIPE_START
G1 X151.883 Y121.88 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z16.4 I-1.216 J-.043 P1  F30000
G1 X151.594 Y130.098 Z16.4
G1 Z16
G1 E.8 F1800
; LINE_WIDTH: 0.202738
G1 F15000
G1 X151.305 Y130.077 E.00377
; LINE_WIDTH: 0.24517
G1 X151.015 Y130.055 E.0048
; LINE_WIDTH: 0.28862
G1 X150.743 Y130.033 E.00546
; LINE_WIDTH: 0.33295
G1 X150.471 Y130.01 E.00645
; LINE_WIDTH: 0.37728
G1 X150.199 Y129.988 E.00743
; LINE_WIDTH: 0.421611
G1 X149.927 Y129.966 E.00842
; LINE_WIDTH: 0.465941
G1 F14892.88
G1 X149.655 Y129.944 E.00941
; LINE_WIDTH: 0.510688
G1 F13468.218
G1 X149.378 Y129.921 E.0106
; LINE_WIDTH: 0.546223
G1 F12517.322
G1 X149.103 Y129.896 E.01133
; LINE_WIDTH: 0.572024
G1 F11906.929
G1 X148.828 Y129.871 E.01191
G1 X151.594 Y130.098 F30000
; LINE_WIDTH: 0.160411
G1 F15000
G1 X151.883 Y130.12 E.00277
; LINE_WIDTH: 0.118084
G1 X152.172 Y130.142 E.00177
; CHANGE_LAYER
; Z_HEIGHT: 16.2
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F15000
G1 X151.883 Y130.12 E-.76
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 81/101
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L81
M991 S0 P80 ;notify layer change
G17
G3 Z16.4 I.177 J-1.204 P1  F30000
G1 X104.842 Y123.19 Z16.4
G1 Z16.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X104.842 Y128.81 E.1864
G1 X105.261 Y128.81 E.01392
G1 X107.956 Y128.81 E.08938
G1 X111.997 Y128.81 E.13407
G1 X114.692 Y128.81 E.08938
G1 X118.733 Y128.81 E.13407
G1 X121.428 Y128.81 E.08938
G1 X125.469 Y128.81 E.13407
G1 X129.511 Y128.81 E.13407
G1 X132.205 Y128.81 E.08938
G1 X136.247 Y128.81 E.13407
G1 X138.941 Y128.81 E.08938
G1 X142.983 Y128.81 E.13407
G1 F15000
G1 X145.277 Y128.81 E.07611
G1 X145.677 Y128.81 E.01327
G1 F13500
G1 X148.371 Y128.81 E.08938
G1 F15476.087
G1 X148.694 Y128.888 E.01101
G1 X149.089 Y128.97 E.01338
G1 X150.184 Y129.174 E.03695
G2 X152.842 Y129.635 I12.4 J-63.569 E.08949
G1 X152.842 Y130.121 E.01613
G1 X138.143 Y130.121 E.48759
G3 X135.985 Y132.667 I-16.267 J-11.604 E.11083
G3 X133.612 Y133.569 I-2.441 J-2.845 E.08589
G1 X104.046 Y133.569 E.98078
G1 X104.046 Y118.431 E.50217
G1 X133.628 Y118.432 E.98128
G3 X136.097 Y119.437 I-.071 J3.708 E.09046
G3 X136.735 Y120.112 I-7.227 J7.472 E.03082
G3 X138.143 Y121.879 I-16.657 J14.721 E.07498
G1 X152.842 Y121.879 E.48759
G1 X152.842 Y122.365 E.01613
G2 X150.184 Y122.826 I9.742 J64.03 E.08949
G1 X149.089 Y123.03 E.03695
G1 X148.694 Y123.112 E.01338
G1 F13500
G1 X148.371 Y123.19 E.01101
G1 X147.024 Y123.19 E.04469
G1 F15000
G1 X146.624 Y123.19 E.01327
G1 X144.33 Y123.19 E.07611
G1 F15476.087
G1 X140.288 Y123.19 E.13407
G1 X137.594 Y123.19 E.08938
G1 X133.552 Y123.19 E.13407
G1 X130.858 Y123.19 E.08938
G1 X126.816 Y123.19 E.13407
G1 X122.775 Y123.19 E.13407
G1 X120.08 Y123.19 E.08938
G1 X116.039 Y123.19 E.13407
G1 X113.344 Y123.19 E.08938
G1 X109.303 Y123.19 E.13407
G1 X105.261 Y123.19 E.13407
G1 X104.902 Y123.19 E.01193
G1 X105.234 Y123.583 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
G1 X105.234 Y127.617 E.12398
G1 X105.234 Y128.017 E.01229
G1 F9333.335
G1 X105.234 Y128.417 E.01229
G1 F3441.213
G1 X105.275 Y128.417 E.00126
G1 F3000
G1 X105.644 Y128.417 E.01134
; FEATURE: Overhang wall
; LINE_WIDTH: 0.45

G1 X148.418 Y128.417 E1.41892
G2 X150.704 Y128.871 I6.571 J-27.107 E.07731
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F600
G1 X151.419 Y129.004 E.02235
G1 X152.326 Y129.153 E.02826
G1 X153.234 Y129.302 E.02826
G1 F3019.461
G1 X153.234 Y129.623 E.00986
G1 F12000
G1 X153.234 Y130.513 E.02736
G1 X138.339 Y130.513 E.45768
G3 X136.235 Y132.969 I-15.468 J-11.121 E.09948
G3 X133.626 Y133.961 I-2.69 J-3.145 E.08748
G1 X103.654 Y133.961 E.92097
G1 X103.654 Y118.039 E.48926
G1 X133.655 Y118.041 E.92186
G3 X135.754 Y118.676 I-.042 J3.923 E.0683
G1 X136.235 Y119.031 E.01837
G3 X138.339 Y121.487 I-13.365 J13.577 E.09948
G1 X152.834 Y121.487 E.44539
G1 X153.234 Y121.487 E.01229
G1 F11870.6
G1 X153.234 Y122.377 E.02736
G1 F600
G1 X153.234 Y122.698 E.00986
G1 X152.326 Y122.847 E.02826
G1 X151.419 Y122.996 E.02826
G1 F3000
G1 X150.704 Y123.129 E.02235
; FEATURE: Overhang wall
; LINE_WIDTH: 0.45

G2 X148.418 Y123.583 I4.286 J27.561 E.07731
G1 X105.644 Y123.583 E1.41892
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F7739.807
G1 X105.294 Y123.583 E.01075
M204 S10000
; WIPE_START
G1 X105.264 Y125.582 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X104.444 Y122.987 Z16.6 F30000
G1 Z16.2
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.431684
G1 F15000
G1 X104.444 Y129.013 E.1909
G1 X104.975 Y119.511 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X106.603 Y119.511 E.05401
G1 X108.984 Y121.892 E.1117
G1 X109.524 Y121.892 E.01791
G1 X111.905 Y119.511 E.1117
G1 X114.279 Y119.511 E.07875
G1 X116.66 Y121.892 E.1117
G1 X117.2 Y121.892 E.01791
G1 X119.581 Y119.511 E.1117
G1 X121.955 Y119.511 E.07875
G1 X124.336 Y121.892 E.1117
G1 X124.876 Y121.892 E.01791
G1 X127.257 Y119.511 E.1117
G1 X129.631 Y119.511 E.07875
G1 X132.012 Y121.892 E.1117
G1 X132.552 Y121.892 E.01791
G1 X134.698 Y119.746 E.10069
G3 X135.98 Y120.721 I-2.116 J4.113 E.0537
G1 X133.597 Y119.14 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.366109
G1 F15000
G3 X135.468 Y119.76 I-.05 J3.277 E.05271
; LINE_WIDTH: 0.336609
G3 X136.306 Y120.57 I-2.554 J3.485 E.02798
G3 X137.262 Y121.855 I-11.007 J9.181 E.03835
; LINE_WIDTH: 0.393321
G1 X137.281 Y122.018 E.00468
; LINE_WIDTH: 0.418767
G1 X137.189 Y122.191 E.00601
; LINE_WIDTH: 0.437147
G1 X137.108 Y122.255 E.00332
; LINE_WIDTH: 0.487675
G1 F14165.109
G1 X137.027 Y122.318 E.00374
G1 X105.237 Y122.318 E1.15211
G1 X104.805 Y122.205 E.0162
G1 X104.684 Y122.102 E.00576
G1 X104.459 Y122.102 E.00817
G1 X104.459 Y122.574 E.01711
; LINE_WIDTH: 0.446671
G1 F15000
G1 X104.695 Y122.596 E.0078
; LINE_WIDTH: 0.415769
G1 X104.931 Y122.618 E.00721
; LINE_WIDTH: 0.422385
G1 X104.991 Y122.64 E.00196
; LINE_WIDTH: 0.488546
G1 F14137.434
G1 X105.05 Y122.662 E.0023
G1 X105.08 Y122.764 E.00385
G1 X137.027 Y122.764 E1.16006
; LINE_WIDTH: 0.471442
G1 F14701.712
G1 X137.282 Y122.781 E.00892
; LINE_WIDTH: 0.450713
G1 F15000
G2 X138.041 Y122.761 I.308 J-2.677 E.02534
; LINE_WIDTH: 0.495125
G1 F13931.751
G1 X148.324 Y122.761 E.3789
G3 X149.444 Y122.527 I3.743 J15.115 E.04217
G1 X149.423 Y122.309 E.00807
G1 X138.041 Y122.309 E.41943
; LINE_WIDTH: 0.476344
G1 F14535.436
G1 X137.943 Y122.222 E.00461
; LINE_WIDTH: 0.438781
G1 F15000
G1 X137.846 Y122.136 E.00421
; LINE_WIDTH: 0.407277
G1 X137.692 Y121.91 E.00813
; LINE_WIDTH: 0.36764
G2 X137.232 Y121.268 I-9.089 J6.019 E.0209
; LINE_WIDTH: 0.341587
G2 X136.152 Y119.982 I-13.196 J9.99 E.04089
G2 X135.355 Y119.318 I-2.778 J2.526 E.02531
G1 X134.701 Y119 E.0177
; LINE_WIDTH: 0.379234
G1 X134.137 Y118.85 E.01601
G2 X133.597 Y118.803 I-.723 J5.278 E.01484
G1 X104.418 Y118.803 E.79967
G1 X104.418 Y119.139 E.00923
G1 X133.537 Y119.14 E.79803
G1 X137.563 Y122.349 F30000
; LINE_WIDTH: 0.471724
G1 F14692.026
G2 X137.557 Y122.442 I-.027 J.045 E.00745
; WIPE_START
G1 X137.51 Y122.442 E-.17246
G1 X137.483 Y122.395 E-.19585
G1 X137.51 Y122.349 E-.19585
G1 X137.563 Y122.349 E-.19585
; WIPE_END
G1 E-.04 F1800
G17
G3 Z16.6 I-1.198 J-.212 P1  F30000
G1 X135.98 Y131.279 Z16.6
G1 Z16.2
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F15476.087
G3 X134.698 Y132.254 I-3.398 J-3.138 E.0537
G1 X132.552 Y130.108 E.10069
G1 X132.012 Y130.108 E.01791
G1 X129.631 Y132.489 E.1117
G1 X127.257 Y132.489 E.07875
G1 X124.876 Y130.108 E.1117
G1 X124.336 Y130.108 E.01791
G1 X121.955 Y132.489 E.1117
G1 X119.581 Y132.489 E.07875
G1 X117.2 Y130.108 E.1117
G1 X116.66 Y130.108 E.01791
G1 X114.279 Y132.489 E.1117
G1 X111.905 Y132.489 E.07875
G1 X109.524 Y130.108 E.1117
G1 X108.984 Y130.108 E.01791
G1 X106.603 Y132.489 E.1117
G1 X104.975 Y132.489 E.05401
G1 X133.594 Y132.861 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.379114
G1 F15000
G1 X104.418 Y132.861 E.79929
G1 X104.418 Y133.197 E.00922
G1 X133.599 Y133.197 E.79945
G2 X135.642 Y132.481 I-.066 J-3.458 E.06032
; LINE_WIDTH: 0.330075
G2 X136.53 Y131.597 I-7.224 J-8.147 E.02933
G1 X137.235 Y130.729 E.02618
; LINE_WIDTH: 0.368483
G1 X137.484 Y130.372 E.01153
; LINE_WIDTH: 0.402827
G1 X137.732 Y130.015 E.01275
; LINE_WIDTH: 0.439637
G1 X137.867 Y129.854 E.00679
; LINE_WIDTH: 0.494981
G1 F13936.171
G1 X138.002 Y129.693 E.00774
G1 X138.041 Y129.691 E.00145
G1 X149.423 Y129.691 E.41929
G1 X149.444 Y129.473 E.00807
G1 X148.299 Y129.239 E.04305
G1 X138.041 Y129.239 E.37786
; LINE_WIDTH: 0.476344
G1 F14535.436
G1 X137.789 Y129.22 E.00894
; LINE_WIDTH: 0.449156
G1 F15000
G1 X137.536 Y129.202 E.00838
G1 X137.027 Y129.236 E.01692
; LINE_WIDTH: 0.487714
G1 F14163.868
G1 X105.08 Y129.236 E1.1579
G1 X105.05 Y129.338 E.00385
G1 X104.669 Y129.426 E.0142
G1 X104.459 Y129.426 E.0076
G1 X104.459 Y129.898 E.01711
G1 X104.684 Y129.898 E.00817
; LINE_WIDTH: 0.456082
G1 F15000
G1 X104.872 Y129.756 E.00794
G1 X105.237 Y129.682 E.01254
; LINE_WIDTH: 0.488589
G1 F14136.052
G1 X137.027 Y129.682 E1.15447
; LINE_WIDTH: 0.471442
G1 F14701.712
G1 X137.11 Y129.748 E.00372
; LINE_WIDTH: 0.426176
M73 P84 R2
G1 F15000
G1 X137.193 Y129.815 E.00333
G1 X137.282 Y129.982 E.00591
; LINE_WIDTH: 0.40674
G1 X137.267 Y130.071 E.00269
; LINE_WIDTH: 0.362621
G1 X137.252 Y130.16 E.00236
G1 X136.993 Y130.537 E.01192
; LINE_WIDTH: 0.333269
G1 X136.311 Y131.424 E.02647
G3 X135.05 Y132.496 I-3.488 J-2.826 E.03937
; LINE_WIDTH: 0.370559
G3 X133.653 Y132.856 I-1.531 J-3.051 E.03881
G1 X137.563 Y129.558 F30000
; LINE_WIDTH: 0.471724
G1 F14692.026
G2 X137.557 Y129.651 I-.027 J.045 E.00745
G1 X149.861 Y129.622 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.563675
G1 F12097.817
G1 X150.146 Y129.648 E.01214
; LINE_WIDTH: 0.521181
G1 F13172.745
G1 X150.431 Y129.674 E.01115
; LINE_WIDTH: 0.478686
G1 F14457.325
G1 X150.716 Y129.7 E.01016
; LINE_WIDTH: 0.436191
G1 F15000
G1 X151.001 Y129.727 E.00917
; LINE_WIDTH: 0.393696
G1 X151.286 Y129.753 E.00818
; LINE_WIDTH: 0.351105
G1 X151.559 Y129.775 E.00688
; LINE_WIDTH: 0.308804
G1 X151.829 Y129.797 E.00586
; LINE_WIDTH: 0.266771
G1 X152.099 Y129.819 E.00494
; LINE_WIDTH: 0.224738
G1 X152.368 Y129.841 E.00401
; LINE_WIDTH: 0.182705
G1 X152.638 Y129.863 E.00308
; WIPE_START
G1 X152.368 Y129.841 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z16.6 I1.216 J-.043 P1  F30000
G1 X152.099 Y122.181 Z16.6
G1 Z16.2
G1 E.8 F1800
; LINE_WIDTH: 0.224738
G1 F15000
G1 X152.368 Y122.159 E.00401
; LINE_WIDTH: 0.182706
G1 X152.638 Y122.137 E.00308
G1 X152.099 Y122.181 F30000
; LINE_WIDTH: 0.266771
G1 F15000
G1 X151.829 Y122.203 E.00494
; LINE_WIDTH: 0.308803
G1 X151.559 Y122.225 E.00586
; LINE_WIDTH: 0.351104
G1 X151.286 Y122.247 E.00688
; LINE_WIDTH: 0.393695
G1 X151.001 Y122.273 E.00818
; LINE_WIDTH: 0.43619
G1 X150.716 Y122.3 E.00917
; LINE_WIDTH: 0.478686
G1 F14457.317
G1 X150.431 Y122.326 E.01016
; LINE_WIDTH: 0.521181
G1 F13172.726
G1 X150.146 Y122.352 E.01115
; LINE_WIDTH: 0.563677
G1 F12097.79
G1 X149.861 Y122.378 E.01214
; CHANGE_LAYER
; Z_HEIGHT: 16.4
; LAYER_HEIGHT: 0.199999
; WIPE_START
G1 F12097.79
G1 X150.146 Y122.352 E-.76
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 82/101
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L82
M991 S0 P81 ;notify layer change
G17
G3 Z16.6 I-.04 J-1.216 P1  F30000
G1 X104.842 Y123.834 Z16.6
G1 Z16.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X104.842 Y128.166 E.14367
G1 X105.261 Y128.166 E.01392
G1 X106.607 Y128.166 E.04465
G1 X107.954 Y128.166 E.04465
G1 X109.3 Y128.166 E.04465
G1 X110.646 Y128.166 E.04465
G1 X111.992 Y128.166 E.04465
G1 X113.338 Y128.166 E.04465
G1 X114.684 Y128.166 E.04465
G1 X116.03 Y128.166 E.04465
G1 X117.377 Y128.166 E.04465
G1 X118.723 Y128.166 E.04465
G1 F15000
G1 X119.669 Y128.166 E.03139
G1 X120.069 Y128.166 E.01327
G1 F13500
G1 X121.015 Y128.166 E.03139
G1 X121.415 Y128.166 E.01327
G1 F12000
G1 X122.361 Y128.166 E.03139
G1 X122.761 Y128.166 E.01327
G1 F10500
G1 X123.707 Y128.166 E.03139
G1 X124.107 Y128.166 E.01327
G1 F9000
G1 X125.053 Y128.166 E.03139
G1 X125.453 Y128.166 E.01327
G1 F7500
G1 X126.4 Y128.166 E.03139
G1 X126.8 Y128.166 E.01327
G1 F6000
G1 X127.746 Y128.166 E.03139
G1 X128.146 Y128.166 E.01327
G1 F4500
G1 X129.092 Y128.166 E.03139
G1 X129.492 Y128.166 E.01327
G1 F3000
G1 X130.838 Y128.166 E.04465
G1 F2880
G1 X132.184 Y128.166 E.04465
G1 F2760
G1 X133.53 Y128.166 E.04465
M73 P85 R2
G1 F2520
G1 X134.876 Y128.166 E.04465
G1 F2400
G1 X136.223 Y128.166 E.04465
G1 F2280
G1 X137.569 Y128.166 E.04465
G1 F2160
G1 X138.915 Y128.166 E.04465
G1 F2040
G1 X140.261 Y128.166 E.04465
G1 F1920
G1 X141.607 Y128.166 E.04465
G1 F1800
G1 X142.953 Y128.166 E.04465
G1 F1680
G1 X144.299 Y128.166 E.04465
G1 F1560
G1 X145.646 Y128.166 E.04465
G1 F1440
G1 X146.992 Y128.166 E.04465
G1 F1320
G1 X148.338 Y128.166 E.04465
G1 F1920
G1 X148.527 Y128.234 E.00667
G1 F2040
G1 X148.729 Y128.292 E.00696
G1 F2760
G1 X149.117 Y128.387 E.01327
G1 X149.725 Y128.536 E.02077
G1 F8187.179
G1 X150.114 Y128.631 E.01327
G1 F10500
G1 X150.722 Y128.779 E.02077
G1 F15476.087
G1 X151.666 Y128.975 E.03197
G1 X152.609 Y129.171 E.03197
G1 X152.842 Y129.22 E.00788
G1 X152.842 Y129.87 E.02158
G1 X138.144 Y129.87 E.48754
G3 X136.422 Y132.057 I-22.796 J-16.183 E.09236
G1 X135.967 Y132.517 E.02148
G3 X133.611 Y133.414 I-2.428 J-2.834 E.08529
G1 X104.046 Y133.414 E.98073
G1 X104.046 Y118.586 E.49186
G1 X133.611 Y118.586 E.98073
G1 X134.02 Y118.617 E.01361
G1 X134.122 Y118.624 E.00339
G3 X136.445 Y119.971 I-.706 J3.895 E.09088
G3 X138.144 Y122.13 I-20.857 J18.161 E.09116
G1 X152.842 Y122.13 E.48754
G1 X152.842 Y122.78 E.02158
G1 X152.609 Y122.829 E.00788
G1 X151.666 Y123.025 E.03197
G1 F10500
G1 X150.722 Y123.221 E.03197
G1 F2760
G1 X150.114 Y123.369 E.02077
G1 X149.725 Y123.464 E.01327
G1 F2040
G1 X148.729 Y123.708 E.03404
G1 F1920
G1 X148.527 Y123.766 E.00696
G1 F1320
G1 X148.338 Y123.834 E.00667
G1 F1440
G1 X146.992 Y123.834 E.04465
G1 F1560
G1 X145.646 Y123.834 E.04465
G1 F1680
G1 X144.299 Y123.834 E.04465
G1 F1800
G1 X142.953 Y123.834 E.04465
G1 F1920
G1 X141.607 Y123.834 E.04465
G1 F2040
G1 X140.261 Y123.834 E.04465
G1 F2160
G1 X138.915 Y123.834 E.04465
G1 F2280
G1 X137.569 Y123.834 E.04465
G1 F2400
G1 X136.223 Y123.834 E.04465
G1 F2520
G1 X134.876 Y123.834 E.04465
G1 F2760
G1 X133.53 Y123.834 E.04465
G1 F2880
G1 X132.184 Y123.834 E.04465
G1 F3000
G1 X130.838 Y123.834 E.04465
G1 F4500
G1 X130.438 Y123.834 E.01327
G1 X129.492 Y123.834 E.03139
G1 F6000
G1 X129.092 Y123.834 E.01327
G1 X128.146 Y123.834 E.03139
G1 F7500
G1 X127.746 Y123.834 E.01327
G1 X126.8 Y123.834 E.03139
G1 F9000
G1 X126.4 Y123.834 E.01327
G1 X125.453 Y123.834 E.03139
G1 F10500
G1 X125.053 Y123.834 E.01327
G1 X124.107 Y123.834 E.03139
G1 F12000
G1 X123.707 Y123.834 E.01327
G1 X122.761 Y123.834 E.03139
G1 F13500
G1 X122.361 Y123.834 E.01327
G1 X121.415 Y123.834 E.03139
G1 F15000
G1 X121.015 Y123.834 E.01327
G1 X120.069 Y123.834 E.03139
G1 F15476.087
G1 X118.723 Y123.834 E.04465
G1 X117.377 Y123.834 E.04465
G1 X116.03 Y123.834 E.04465
G1 X114.684 Y123.834 E.04465
G1 X113.338 Y123.834 E.04465
G1 X111.992 Y123.834 E.04465
G1 X110.646 Y123.834 E.04465
G1 X109.3 Y123.834 E.04465
G1 X107.954 Y123.834 E.04465
G1 X106.607 Y123.834 E.04465
G1 X105.261 Y123.834 E.04465
G1 X104.902 Y123.834 E.01193
G1 X105.234 Y124.226 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
G1 X105.234 Y126.974 E.08441
G1 X105.234 Y127.374 E.01229
G1 F9333.335
G1 X105.234 Y127.774 E.01229
G1 F3441.213
G1 X105.275 Y127.774 E.00126
G1 F3000
G1 X105.644 Y127.774 E.01134
; FEATURE: Overhang wall
; LINE_WIDTH: 0.45

G1 X148.407 Y127.774 E1.41853
G2 X148.829 Y127.913 I1.233 J-3.019 E.01477
G2 X152.903 Y128.832 I15.261 J-58.171 E.13855
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F600
G2 X153.234 Y128.9 I1.25 J-5.272 E.01038
G1 F3445.941
G1 X153.234 Y129.26 E.01108
G1 F9341.12
G1 X153.234 Y129.66 E.01229
G1 F12000
G1 X153.234 Y130.262 E.0185
G1 X138.34 Y130.262 E.45764
G3 X136.713 Y132.32 I-21.462 J-15.298 E.08066
G1 X136.229 Y132.809 E.02113
G3 X133.626 Y133.806 I-2.686 J-3.119 E.08737
G1 X103.654 Y133.806 E.92095
G1 X103.654 Y118.194 E.4797
G1 X133.626 Y118.194 E.92095
G1 X134.049 Y118.226 E.01306
G1 X134.18 Y118.235 E.00403
G3 X136.681 Y119.644 I-.698 J4.162 E.08998
G3 X138.34 Y121.738 I-28.033 J23.924 E.08211
G1 X153.234 Y121.738 E.45764
G1 X153.234 Y122.34 E.0185
G1 F3899.032
G1 X153.234 Y122.74 E.01229
G1 F600
G1 X153.234 Y123.1 E.01108
G1 X153.2 Y123.106 E.00106
G1 F2835.2
G1 X152.903 Y123.168 E.00931
; FEATURE: Overhang wall
; LINE_WIDTH: 0.45
G1 F3000
G2 X148.648 Y124.139 I14.133 J71.742 E.14479
G1 X148.407 Y124.226 E.00852
G1 X105.644 Y124.226 E1.41853
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F7739.807
G1 X105.294 Y124.226 E.01075
M204 S10000
; WIPE_START
G1 X105.25 Y126.226 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X104.444 Y123.631 Z16.8 F30000
G1 Z16.4
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.431684
G1 F15000
G1 X104.444 Y128.369 E.1501
G1 X105.166 Y132.297 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X106.795 Y132.297 E.05401
G1 X109.383 Y129.709 E.12143
G1 X109.125 Y129.709 E.00858
G1 X111.713 Y132.297 E.12143
G1 X114.471 Y132.297 E.09147
G1 X117.059 Y129.709 E.12143
G1 X116.8 Y129.709 E.00858
G1 X119.389 Y132.297 E.12143
G1 X122.147 Y132.297 E.09147
G1 X124.735 Y129.709 E.12143
G1 X124.476 Y129.709 E.00858
G1 X127.065 Y132.297 E.12143
G1 X129.822 Y132.297 E.09147
G1 X132.411 Y129.709 E.12143
G1 X132.152 Y129.709 E.00858
G1 X134.562 Y132.119 E.11306
G2 X135.861 Y131.172 I-.987 J-2.716 E.05402
G1 X133.59 Y132.678 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.397117
G1 F15000
G1 X104.427 Y132.678 E.84174
G1 X104.427 Y133.033 E.01024
G1 X133.597 Y133.033 E.84193
G1 X134.153 Y132.981 E.01613
G2 X135.634 Y132.316 I-.827 J-3.823 E.04718
; LINE_WIDTH: 0.343398
G2 X136.521 Y131.39 I-3.738 J-4.474 E.03146
G2 X136.971 Y130.834 I-22.816 J-18.925 E.01752
; LINE_WIDTH: 0.370584
G1 X137.604 Y129.964 E.02871
; LINE_WIDTH: 0.419859
G1 X137.892 Y129.554 E.01541
G1 X138.042 Y129.478 E.00518
G1 X150.743 Y129.478 E.39012
G1 X150.773 Y129.19 E.00889
G1 X150.632 Y129.161 E.00441
G3 X148.203 Y128.558 I12.675 J-56.227 E.07689
G1 X105.492 Y128.558 E1.3119
; LINE_WIDTH: 0.44305
G1 X105.289 Y128.581 E.00665
; LINE_WIDTH: 0.48915
G1 F14118.287
G1 X105.086 Y128.604 E.00742
; LINE_WIDTH: 0.536416
G1 F12766.07
G1 X104.982 Y128.785 E.00842
G1 X104.499 Y128.823 E.01947
G1 X104.499 Y129.459 E.02558
G1 X104.704 Y129.429 E.00833
G1 X104.931 Y129.277 E.01098
G1 X105.299 Y129.271 E.01478
; LINE_WIDTH: 0.48915
G1 F14118.287
G1 X105.395 Y129.294 E.00361
; LINE_WIDTH: 0.420071
G1 F15000
G1 X105.492 Y129.317 E.00305
G1 X137.089 Y129.317 E.97109
G1 X137.255 Y129.416 E.00594
G1 X137.345 Y129.582 E.00581
; LINE_WIDTH: 0.403469
G1 X137.323 Y129.766 E.00545
; LINE_WIDTH: 0.370584
G1 X136.717 Y130.655 E.02871
; LINE_WIDTH: 0.353378
G3 X135.498 Y132.025 I-6.319 J-4.395 E.0465
G3 X134.595 Y132.509 I-1.948 J-2.552 E.02602
; LINE_WIDTH: 0.391244
G3 X133.65 Y132.673 I-.959 J-2.716 E.02736
G1 X105.492 Y128.937 F30000
; LINE_WIDTH: 0.424778
G1 F15000
G1 X137.089 Y128.937 E.98321
; LINE_WIDTH: 0.448017
G1 X137.183 Y128.96 E.00319
; LINE_WIDTH: 0.494495
G1 F13951.17
G1 X137.277 Y128.984 E.00356
; LINE_WIDTH: 0.540973
G1 F12649.256
G1 X137.371 Y129.007 E.00392
; LINE_WIDTH: 0.587451
G1 F11569.59
G1 X137.465 Y129.03 E.00429
; LINE_WIDTH: 0.633929
G1 F10659.736
G1 X137.558 Y129.053 E.00465
; LINE_WIDTH: 0.680407
G1 F9882.554
G1 X137.652 Y129.077 E.00502
; LINE_WIDTH: 0.684097
G1 F9825.691
G1 X137.782 Y129.057 E.00687
; LINE_WIDTH: 0.644997
G1 F10463.778
G1 X137.912 Y129.037 E.00645
; LINE_WIDTH: 0.5866
G1 F11587.715
G1 X138.042 Y129.018 E.00583
G1 X148.143 Y129.018 E.44749
G1 X151.148 Y129.374 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.551364
G1 F12390.761
G1 X151.446 Y129.405 E.01241
; LINE_WIDTH: 0.507323
G1 F13565.802
G1 X151.744 Y129.436 E.01134
; LINE_WIDTH: 0.463283
G1 F14987.055
G1 X152.042 Y129.466 E.01026
; LINE_WIDTH: 0.419243
G1 F15000
G1 X152.34 Y129.497 E.00919
; LINE_WIDTH: 0.375203
G1 X152.638 Y129.528 E.00811
; WIPE_START
G1 X152.34 Y129.497 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z16.8 I1.216 J-.052 P1  F30000
G1 X152.042 Y122.534 Z16.8
G1 Z16.4
G1 E.8 F1800
; LINE_WIDTH: 0.463283
G1 F14987.066
G1 X151.744 Y122.564 E.01026
; LINE_WIDTH: 0.507323
G1 F13565.824
G1 X151.446 Y122.595 E.01134
; LINE_WIDTH: 0.551362
G1 F12390.791
G1 X151.148 Y122.626 E.01241
G1 X152.042 Y122.534 F30000
; LINE_WIDTH: 0.419243
G1 F15000
G1 X152.34 Y122.503 E.00919
; LINE_WIDTH: 0.375203
G1 X152.638 Y122.472 E.00811
; WIPE_START
G1 X152.34 Y122.503 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X144.747 Y121.731 Z16.8 F30000
G1 X135.861 Y120.828 Z16.8
G1 Z16.4
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F15476.087
G2 X134.562 Y119.881 I-2.285 J1.769 E.05402
G1 X132.152 Y122.291 E.11306
G1 X132.411 Y122.291 E.00858
G1 X129.822 Y119.703 E.12143
G1 X127.065 Y119.703 E.09147
G1 X124.476 Y122.291 E.12143
G1 X124.735 Y122.291 E.00858
G1 X122.147 Y119.703 E.12143
G1 X119.389 Y119.703 E.09147
G1 X116.8 Y122.291 E.12143
G1 X117.059 Y122.291 E.00858
G1 X114.471 Y119.703 E.12143
G1 X111.713 Y119.703 E.09147
G1 X109.125 Y122.291 E.12143
G1 X109.383 Y122.291 E.00858
G1 X106.795 Y119.703 E.12143
G1 X105.166 Y119.703 E.05401
G1 X133.59 Y119.322 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.384455
G1 F15000
G1 X134.411 Y119.443 E.0231
G1 X135.021 Y119.673 E.01813
G1 X135.447 Y119.936 E.01395
; LINE_WIDTH: 0.343476
G3 X136.294 Y120.795 I-2.758 J3.57 E.02963
G3 X136.717 Y121.345 I-7.58 J6.255 E.017
; LINE_WIDTH: 0.370621
G1 X137.323 Y122.234 E.02871
; LINE_WIDTH: 0.419904
G1 X137.345 Y122.418 E.0057
G1 X137.239 Y122.609 E.00672
G1 X137.089 Y122.683 E.00514
G1 X105.492 Y122.683 E.97066
; LINE_WIDTH: 0.441714
G1 X105.362 Y122.705 E.00429
; LINE_WIDTH: 0.485144
G1 F14246.191
G1 X105.231 Y122.727 E.00476
; LINE_WIDTH: 0.542063
G1 F12621.636
G1 X105.101 Y122.749 E.00537
G1 X104.837 Y122.685 E.01106
G1 X104.669 Y122.541 E.00897
G1 X104.499 Y122.541 E.00692
G1 X104.499 Y123.177 E.02588
G1 X104.982 Y123.215 E.0197
G1 X105.086 Y123.396 E.00851
; LINE_WIDTH: 0.48915
G1 F14118.287
G1 X105.289 Y123.419 E.00742
; LINE_WIDTH: 0.420079
G1 F15000
G1 X105.492 Y123.442 E.00627
G1 X148.276 Y123.442 E1.31491
G1 X148.628 Y123.329 E.01138
G1 X150.773 Y122.81 E.06782
G1 X150.743 Y122.522 E.00889
G1 X138.042 Y122.522 E.39035
G1 X137.892 Y122.446 E.00518
; LINE_WIDTH: 0.403468
G1 X137.604 Y122.036 E.01474
; LINE_WIDTH: 0.370621
G1 X136.971 Y121.166 E.02871
; LINE_WIDTH: 0.355214
G2 X136.137 Y120.154 I-26.918 J21.361 E.03338
G2 X134.708 Y119.172 I-2.81 J2.556 E.04452
; LINE_WIDTH: 0.397643
G1 X134.078 Y119.008 E.01881
G1 X133.59 Y118.967 E.01416
G1 X104.427 Y118.967 E.84299
G1 X104.427 Y119.322 E.01025
G1 X133.53 Y119.322 E.84125
G1 X105.492 Y123.063 F30000
; LINE_WIDTH: 0.424778
G1 F15000
G1 X137.089 Y123.063 E.98321
; LINE_WIDTH: 0.448017
G1 X137.183 Y123.04 E.00319
; LINE_WIDTH: 0.494495
G1 F13951.17
G1 X137.277 Y123.016 E.00356
; LINE_WIDTH: 0.540973
G1 F12649.256
G1 X137.371 Y122.993 E.00392
; LINE_WIDTH: 0.587451
G1 F11569.59
G1 X137.465 Y122.97 E.00429
; LINE_WIDTH: 0.633929
G1 F10659.736
G1 X137.558 Y122.947 E.00465
; LINE_WIDTH: 0.680407
G1 F9882.554
G1 X137.652 Y122.923 E.00502
; LINE_WIDTH: 0.684097
G1 F9825.691
G1 X137.782 Y122.943 E.00687
; LINE_WIDTH: 0.644997
G1 F10463.778
G1 X137.912 Y122.963 E.00645
; LINE_WIDTH: 0.5866
G1 F11587.715
G1 X138.042 Y122.982 E.00583
G1 X148.143 Y122.982 E.44749
; CHANGE_LAYER
; Z_HEIGHT: 16.6
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F11587.715
G1 X146.143 Y122.982 E-.76
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 83/101
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L83
M991 S0 P82 ;notify layer change
G17
G3 Z16.8 I-.776 J-.938 P1  F30000
G1 X138.189 Y129.565 Z16.8
G1 Z16.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X138.119 Y129.565 E.00231
G3 X135.968 Y132.324 I-14.056 J-8.741 E.11628
G1 X135.525 Y132.676 E.01877
G3 X133.611 Y133.252 I-1.996 J-3.163 E.06711
G1 X104.046 Y133.252 E.98073
G1 X104.046 Y118.748 E.48114
G1 X133.611 Y118.748 E.98073
G1 X133.852 Y118.766 E.00803
G3 X136.24 Y119.948 I-.266 J3.539 E.09061
G3 X138.119 Y122.435 I-12.907 J11.706 E.10353
G1 X152.842 Y122.435 E.48837
G1 X152.842 Y123.209 E.02567
G1 F2880
G1 X152.842 Y123.307 E.00327
G1 F2640
G1 X152.301 Y123.439 E.01845
G1 F1920
G1 X151.508 Y123.667 E.02737
G1 F1200
G1 X150.716 Y123.896 E.02737
G1 F3000
G1 X150.34 Y124.033 E.01327
G1 X149.469 Y124.353 E.03077
M204 S5000
; FEATURE: Overhang wall

G1 X149.101 Y124.528 E.01352
G1 X147.959 Y125.352 E.04672
G1 X147.959 Y126.648 E.04296
G1 X149.101 Y127.472 E.04672
G1 X149.469 Y127.647 E.01352
M204 S10000
; FEATURE: Inner wall
G1 F1483.564
G1 X149.506 Y127.665 E.00136
G1 F1200
G1 X150.716 Y128.104 E.04269
G1 F1920
G1 X151.508 Y128.333 E.02737
G1 F2640
G1 X152.301 Y128.561 E.02737
G1 F2880
G1 X152.842 Y128.693 E.01845
G1 F3972.05
G1 X152.842 Y128.791 E.00327
G1 F15476.087
G1 X152.842 Y129.565 E.02567
G1 X138.249 Y129.565 E.48407
G1 X138.331 Y129.957 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
G3 X136.676 Y132.156 I-18.425 J-12.144 E.08461
G3 X134.72 Y133.481 I-3.269 J-2.717 E.07357
G3 X133.626 Y133.644 I-1.096 J-3.607 E.03412
G1 X103.654 Y133.644 E.92095
G1 X103.654 Y118.356 E.46978
G1 X133.626 Y118.356 E.92095
G1 X133.882 Y118.375 E.00789
G1 X134.18 Y118.397 E.0092
G3 X136.524 Y119.678 I-.673 J4.017 E.08362
G3 X137.966 Y121.489 I-16.891 J14.923 E.07118
G1 X138.331 Y122.043 E.02037
G1 X153.234 Y122.043 E.45793
G1 X153.234 Y122.742 E.02148
G1 F8596.922
G1 X153.234 Y123.142 E.01229
G1 F3000
G1 X153.234 Y123.518 E.01155
; FEATURE: Overhang wall
; LINE_WIDTH: 0.45

G1 X153.234 Y123.63 E.00371
G2 X152.402 Y123.818 I2.3 J12.064 E.02829
G1 X150.837 Y124.269 E.05403
G1 X149.657 Y124.697 E.04163
G1 X149.302 Y124.866 E.01307
G1 X148.351 Y125.553 E.03889
G1 X148.351 Y126.447 E.02966
G1 X149.302 Y127.134 E.03889
G1 X149.657 Y127.303 E.01307
G1 X150.837 Y127.731 E.04163
G1 X152.402 Y128.182 E.05403
G2 X153.234 Y128.37 I3.132 J-11.875 E.02829
G1 X153.234 Y128.482 E.00371
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F8180.44
G1 X153.234 Y128.858 E.01155
G1 F12000
G1 X153.234 Y129.258 E.01229
G1 X153.234 Y129.957 E.02148
G1 X138.391 Y129.957 E.45609
M204 S10000
; WIPE_START
G1 X137.966 Y130.511 E-.26518
G1 X137.25 Y131.465 E-.45309
G1 X137.18 Y131.549 E-.04172
; WIPE_END
G1 E-.04 F1800
G1 X135.748 Y131.067 Z17 F30000
G1 Z16.6
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F15476.087
G3 X134.422 Y131.978 I-2.468 J-2.172 E.05392
G1 X131.681 Y129.237 E.12859
G1 X132.883 Y129.237 E.03987
G1 X130.014 Y132.106 E.13457
G1 X126.873 Y132.106 E.10419
G1 X124.005 Y129.237 E.13457
G1 X125.207 Y129.237 E.03987
G1 X122.338 Y132.106 E.13457
G1 X119.197 Y132.106 E.10419
G1 X116.329 Y129.237 E.13457
G1 X117.531 Y129.237 E.03987
G1 X114.662 Y132.106 E.13457
G1 X111.521 Y132.106 E.10419
G1 X108.653 Y129.237 E.13457
G1 X109.855 Y129.237 E.03987
G1 X106.986 Y132.106 E.13457
G1 X105.358 Y132.106 E.05401
G1 X104.565 Y128.896 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.603214
G1 F11244.097
G2 X104.57 Y129.009 I-.031 J.058 E.01262
G1 X133.59 Y132.494 F30000
; LINE_WIDTH: 0.412214
G1 F15000
G1 X104.434 Y132.494 E.87737
G1 X104.434 Y132.864 E.01113
G1 X133.597 Y132.864 E.87758
G1 X134.156 Y132.811 E.01691
G2 X135.655 Y132.102 I-.725 J-3.474 E.05036
; LINE_WIDTH: 0.362201
G1 X136.11 Y131.663 E.01644
G2 X137.303 Y130.116 I-11.528 J-10.124 E.05086
; LINE_WIDTH: 0.405567
G2 X137.849 Y129.256 I-32.491 J-21.227 E.03013
; LINE_WIDTH: 0.415361
G1 X137.975 Y129.167 E.00469
G1 X137.399 Y129.156 E.01751
G1 X137.396 Y129.281 E.0038
G1 X137.044 Y129.884 E.02118
; LINE_WIDTH: 0.365404
G3 X135.94 Y131.396 I-11.024 J-6.888 E.04925
G3 X135.039 Y132.121 I-2.872 J-2.645 E.03048
; LINE_WIDTH: 0.403054
G1 X134.571 Y132.333 E.01509
G1 X134.022 Y132.46 E.01653
G1 X133.65 Y132.489 E.01097
; WIPE_START
G1 X134.022 Y132.46 E-.19568
G1 X134.571 Y132.333 E-.29507
G1 X135.039 Y132.121 E-.26925
; WIPE_END
G1 E-.04 F1800
G1 X142.486 Y130.445 Z17 F30000
G1 X148.167 Y129.165 Z17
G1 Z16.6
G1 E.8 F1800
; LINE_WIDTH: 0.434911
G1 F15000
G1 X138.035 Y129.165 E.32364
G1 X150.87 Y129.152 F30000
; LINE_WIDTH: 0.46263
G1 F15000
G1 X152.428 Y129.152 E.05331
G1 X152.428 Y129.017 E.0046
G1 X151.43 Y128.74 E.03544
G1 X151.281 Y128.719 E.00515
G1 X150.976 Y129.083 E.01622
G1 X150.92 Y129.119 E.00229
G1 X150.814 Y128.924 F30000
; FEATURE: Bridge
; LINE_WIDTH: 0.424045
G1 F3000
G1 X142.918 Y123.219 E.30253
G1 X142.267 Y123.219 E.02021
M73 P86 R2
G1 X150.317 Y129.035 E.30841
G1 X150.074 Y129.127 E.00807
G3 X149.837 Y129.159 I-1.04 J-6.812 E.0074
G1 X141.617 Y123.219 E.31498
G1 X140.966 Y123.219 E.02021
G1 X148.933 Y128.976 E.30528
G1 X148.229 Y128.781 E.02269
G1 X148.013 Y128.781 E.00672
G1 X140.315 Y123.219 E.29495
G1 X139.664 Y123.219 E.02021
G1 X147.362 Y128.781 E.29495
G1 X146.711 Y128.781 E.02021
G1 X139.013 Y123.219 E.29495
G1 X138.363 Y123.219 E.02021
G1 X146.061 Y128.781 E.29495
G1 X145.41 Y128.781 E.02021
G1 X137.712 Y123.219 E.29495
G1 X137.061 Y123.219 E.02021
G1 X144.759 Y128.781 E.29495
G1 X144.108 Y128.781 E.02021
G1 X136.41 Y123.219 E.29495
G1 X135.76 Y123.219 E.02021
G1 X143.458 Y128.781 E.29495
G1 X142.807 Y128.781 E.02021
G1 X135.109 Y123.219 E.29495
G1 X134.458 Y123.219 E.02021
G1 X142.156 Y128.781 E.29495
G1 X141.505 Y128.781 E.02021
G1 X133.807 Y123.219 E.29495
G1 X133.156 Y123.219 E.02021
G1 X140.854 Y128.781 E.29495
G1 X140.204 Y128.781 E.02021
G1 X132.506 Y123.219 E.29495
G1 X131.855 Y123.219 E.02021
G1 X139.553 Y128.781 E.29495
G1 X138.902 Y128.781 E.02021
G1 X131.204 Y123.219 E.29495
G1 X130.553 Y123.219 E.02021
G1 X138.251 Y128.781 E.29495
G1 X137.6 Y128.781 E.02021
G1 X129.903 Y123.219 E.29495
G1 X129.252 Y123.219 E.02021
G1 X136.95 Y128.781 E.29495
G1 X136.299 Y128.781 E.02021
G1 X128.601 Y123.219 E.29495
G1 X127.95 Y123.219 E.02021
G1 X135.648 Y128.781 E.29495
G1 X134.997 Y128.781 E.02021
G1 X127.299 Y123.219 E.29495
G1 X126.649 Y123.219 E.02021
G1 X134.347 Y128.781 E.29495
G1 X133.696 Y128.781 E.02021
G1 X125.998 Y123.219 E.29495
G1 X125.347 Y123.219 E.02021
G1 X133.045 Y128.781 E.29495
G1 X132.394 Y128.781 E.02021
G1 X124.696 Y123.219 E.29495
G1 X124.045 Y123.219 E.02021
G1 X131.743 Y128.781 E.29495
G1 X131.093 Y128.781 E.02021
G1 X123.395 Y123.219 E.29495
G1 X122.744 Y123.219 E.02021
G1 X130.442 Y128.781 E.29495
G1 X129.791 Y128.781 E.02021
G1 X122.093 Y123.219 E.29495
G1 X121.442 Y123.219 E.02021
G1 X129.14 Y128.781 E.29495
G1 X128.49 Y128.781 E.02021
G1 X120.792 Y123.219 E.29495
G1 X120.141 Y123.219 E.02021
G1 X127.839 Y128.781 E.29495
G1 X127.188 Y128.781 E.02021
G1 X119.49 Y123.219 E.29495
G1 X118.839 Y123.219 E.02021
G1 X126.537 Y128.781 E.29495
G1 X125.886 Y128.781 E.02021
G1 X118.188 Y123.219 E.29495
G1 X117.538 Y123.219 E.02021
G1 X125.236 Y128.781 E.29495
G1 X124.585 Y128.781 E.02021
G1 X116.887 Y123.219 E.29495
G1 X116.236 Y123.219 E.02021
G1 X123.934 Y128.781 E.29495
G1 X123.283 Y128.781 E.02021
G1 X115.585 Y123.219 E.29495
G1 X114.935 Y123.219 E.02021
G1 X122.632 Y128.781 E.29495
G1 X121.982 Y128.781 E.02021
G1 X114.284 Y123.219 E.29495
G1 X113.633 Y123.219 E.02021
G1 X121.331 Y128.781 E.29495
G1 X120.68 Y128.781 E.02021
G1 X112.982 Y123.219 E.29495
G1 X112.331 Y123.219 E.02021
G1 X120.029 Y128.781 E.29495
G1 X119.379 Y128.781 E.02021
G1 X111.681 Y123.219 E.29495
G1 X111.03 Y123.219 E.02021
G1 X118.728 Y128.781 E.29495
G1 X118.077 Y128.781 E.02021
G1 X110.379 Y123.219 E.29495
G1 X109.728 Y123.219 E.02021
G1 X117.426 Y128.781 E.29495
G1 X116.775 Y128.781 E.02021
G1 X109.077 Y123.219 E.29495
G1 X108.427 Y123.219 E.02021
G1 X116.125 Y128.781 E.29495
G1 X115.474 Y128.781 E.02021
G1 X107.776 Y123.219 E.29495
G1 X107.125 Y123.219 E.02021
G1 X114.823 Y128.781 E.29495
G1 X114.172 Y128.781 E.02021
G1 X106.474 Y123.219 E.29495
G1 X105.824 Y123.219 E.02021
G1 X113.522 Y128.781 E.29495
G1 X112.871 Y128.781 E.02021
G1 X105.214 Y123.249 E.29339
G1 X105.078 Y123.288 E.00439
G1 X104.794 Y123.416 E.00966
G1 X112.22 Y128.781 E.28451
G1 X111.569 Y128.781 E.02021
G1 X104.499 Y123.673 E.27088
G1 X104.379 Y123.87 E.00717
G1 X104.379 Y124.056 E.00578
G1 X110.918 Y128.781 E.25055
G1 X110.268 Y128.781 E.02021
G1 X104.379 Y124.526 E.22562
G1 X104.379 Y124.997 E.0146
G1 X109.617 Y128.781 E.20068
G1 X108.966 Y128.781 E.02021
G1 X104.379 Y125.467 E.17575
G1 X104.379 Y125.937 E.0146
G1 X108.315 Y128.781 E.15081
G1 X107.664 Y128.781 E.02021
G1 X104.379 Y126.407 E.12588
G1 X104.379 Y126.877 E.0146
G1 X107.014 Y128.781 E.10095
G1 X106.363 Y128.781 E.02021
G1 X104.379 Y127.348 E.07601
G1 X104.379 Y127.818 E.0146
G1 X105.712 Y128.781 E.05108
G1 X105.395 Y128.78 E.00986
G1 X105.2 Y128.749 E.00614
G1 X104.89 Y128.634 E.01024
G1 X104.778 Y128.574 E.00395
G3 X104.21 Y128.166 I5.294 J-7.966 E.02175
G1 X104.565 Y122.983 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.603514
G1 F11238.079
G2 X104.57 Y123.095 I-.031 J.058 E.01263
G1 X133.59 Y119.512 F30000
; LINE_WIDTH: 0.397722
G1 F15000
G3 X135.501 Y120.196 I-.005 J3.025 E.05987
; LINE_WIDTH: 0.361803
G1 X135.882 Y120.541 E.01335
G3 X136.409 Y121.183 I-7.622 J6.789 E.0216
G1 X137.019 Y122.077 E.0281
; LINE_WIDTH: 0.411004
G1 X137.396 Y122.719 E.02234
G1 X137.399 Y122.845 E.00378
G1 X138.01 Y122.835 E.01832
G1 X137.85 Y122.744 E.00551
G2 X137.299 Y121.879 I-8.853 J5.033 E.03076
; LINE_WIDTH: 0.370544
G2 X136.136 Y120.366 I-12.858 J8.68 E.05097
G2 X134.72 Y119.346 I-2.793 J2.383 E.04705
; LINE_WIDTH: 0.414557
G1 X134.199 Y119.198 E.01641
G2 X133.59 Y119.138 I-.785 J4.857 E.01854
G1 X104.434 Y119.136 E.88293
G1 X104.434 Y119.506 E.0112
G1 X133.53 Y119.512 E.88111
; WIPE_START
G1 X131.53 Y119.511 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X139.014 Y121.006 Z17 F30000
G1 X148.167 Y122.835 Z17
G1 Z16.6
G1 E.8 F1800
; LINE_WIDTH: 0.435223
G1 F15000
G1 X138.07 Y122.835 E.32278
G1 X150.892 Y122.848 F30000
; LINE_WIDTH: 0.461265
G1 F15000
G1 X151.249 Y123.236 E.01799
G1 X151.281 Y123.304 E.00254
G3 X152.429 Y122.983 I4.595 J14.262 E.04064
G1 X152.429 Y122.848 E.00462
G1 X150.952 Y122.848 E.05035
G1 X151.146 Y123.521 F30000
; FEATURE: Bridge
; LINE_WIDTH: 0.424045
G1 F3000
G2 X150.235 Y122.924 I-3.361 J4.134 E.03389
G1 X150.074 Y122.873 E.00525
G2 X149.586 Y122.865 I-.262 J1.041 E.01527
G1 X150.587 Y123.588 E.03834
G1 X150.154 Y123.745 E.01431
G1 X149.1 Y122.984 E.04038
M73 P87 R2
G1 X148.614 Y123.102 E.01555
G1 X149.721 Y123.902 E.04242
G2 X149.296 Y124.066 I.638 J2.293 E.01415
G1 X148.124 Y123.219 E.04489
G1 X147.474 Y123.219 E.02021
G1 X148.908 Y124.256 E.05497
G1 X148.583 Y124.491 E.01247
G1 X146.823 Y123.219 E.06744
G1 X146.172 Y123.219 E.02021
G1 X148.258 Y124.726 E.0799
G1 X147.932 Y124.961 E.01247
G1 X145.521 Y123.219 E.09237
G1 X144.871 Y123.219 E.02021
G1 X147.626 Y125.21 E.10558
G1 X147.626 Y125.68 E.0146
G1 X144.22 Y123.219 E.13051
G1 X143.569 Y123.219 E.02021
G1 X147.796 Y126.273 E.16195
; WIPE_START
G1 X146.175 Y125.102 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z17 I-.713 J.986 P1  F30000
G1 X150.426 Y128.173 Z17
G1 Z16.6
G1 E.8 F1800
G1 F3000
G1 X151.065 Y128.635 E.0245
; WIPE_START
G1 X150.426 Y128.173 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z17 I.22 J-1.197 P1  F30000
G1 X105.359 Y119.895 Z17
G1 Z16.6
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X106.987 Y119.895 E.05401
G1 X109.855 Y122.763 E.13453
G1 X108.653 Y122.763 E.03987
G1 X111.519 Y119.896 E.13448
G1 X114.665 Y119.897 E.10435
G1 X117.531 Y122.763 E.13444
G1 X116.329 Y122.763 E.03987
G1 X119.193 Y119.898 E.13438
G1 X122.343 Y119.899 E.10448
G1 X125.207 Y122.763 E.13434
G1 X124.005 Y122.763 E.03987
G1 X126.867 Y119.9 E.13429
G1 X130.021 Y119.901 E.10461
G1 X132.883 Y122.763 E.13425
G1 X131.681 Y122.763 E.03987
G1 X134.422 Y120.022 E.12859
G3 X135.746 Y120.934 I-1.129 J3.056 E.0539
; CHANGE_LAYER
; Z_HEIGHT: 16.8
; LAYER_HEIGHT: 0.199999
; WIPE_START
G1 F15476.087
G1 X135.247 Y120.462 E-.26115
G1 X134.843 Y120.2 E-.18299
G1 X134.422 Y120.022 E-.1737
G1 X134.157 Y120.286 E-.14217
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 84/101
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L84
M991 S0 P83 ;notify layer change
G17
G3 Z17 I-1.11 J.499 P1  F30000
G1 X138.189 Y129.259 Z17
G1 Z16.8
G1 E.8 F1800
; FEATURE: Inner wall
G1 F15476.087
G1 X138.12 Y129.259 E.00231
G3 X136.38 Y131.689 I-20.132 J-12.574 E.09921
G3 X134.606 Y132.944 I-3.105 J-2.509 E.07299
G3 X133.611 Y133.091 I-.994 J-3.28 E.0335
G1 X104.046 Y133.091 E.98073
G1 X104.046 Y118.909 E.47043
G1 X133.685 Y118.915 E.98318
G3 X135.525 Y119.516 I-.031 J3.213 E.06523
G1 X135.968 Y119.868 E.01877
G3 X137.348 Y121.569 I-11.3 J10.577 E.07275
G1 X138.12 Y122.741 E.04654
G1 X152.442 Y122.741 E.47508
G1 X152.842 Y122.741 E.01327
G1 F14204.333
G1 X152.842 Y123.739 E.03311
G1 F600
G1 X152.842 Y124.048 E.01024
G1 X152.696 Y124.101 E.00513
G1 F3000
G1 X152.38 Y124.251 E.01161
M204 S5000
; FEATURE: Overhang wall

G1 X151.48 Y124.68 E.03309
G1 X151.01 Y125.019 E.0192
G1 X150.563 Y125.655 E.02579
G1 X150.563 Y126.345 E.0229
G1 X151.01 Y126.981 E.02579
G1 X151.48 Y127.32 E.0192
G1 X152.38 Y127.749 E.03309
M204 S10000
; FEATURE: Inner wall
G1 F600
G1 X152.696 Y127.899 E.01161
G1 X152.842 Y127.952 E.00513
G1 F2893.624
G1 X152.842 Y128.261 E.01024
G1 F15476.087
G1 X152.842 Y129.259 E.03311
G1 X138.249 Y129.259 E.48405
G1 X138.331 Y129.651 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
G3 X136.347 Y132.308 I-15.258 J-9.325 E.10204
G1 X136.229 Y132.426 E.00512
G3 X134.18 Y133.442 I-2.745 J-2.962 E.07125
G1 X133.626 Y133.483 E.01708
G1 X103.654 Y133.483 E.92095
G1 X103.654 Y118.517 E.45986
G1 X133.714 Y118.524 E.92366
G3 X135.748 Y119.192 I-.065 J3.628 E.06678
G1 X136.229 Y119.574 E.01889
G3 X137.669 Y121.344 I-11.44 J10.781 E.07016
G1 X138.331 Y122.349 E.03699
G1 X153.234 Y122.349 E.45791
G1 X153.234 Y123.272 E.02834
G1 F8596.922
G1 X153.234 Y123.672 E.01229
G1 F3000
G1 X153.234 Y124.048 E.01158
; FEATURE: Overhang wall
; LINE_WIDTH: 0.45

G1 X153.234 Y124.339 E.00962
G2 X152.848 Y124.463 I.717 J2.884 E.01346
G1 X151.68 Y125.019 E.04288
G1 X151.293 Y125.298 E.01584
G1 X150.955 Y125.779 E.0195
G1 X150.955 Y126.221 E.01467
G1 X151.293 Y126.702 E.0195
G1 X151.68 Y126.981 E.01584
G1 X152.848 Y127.537 E.04288
G2 X153.234 Y127.661 I1.103 J-2.76 E.01346
G1 X153.234 Y127.952 E.00962
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F8195.05
G1 X153.234 Y128.328 E.01158
G1 F12000
G1 X153.234 Y128.728 E.01229
G1 X153.234 Y129.651 E.02834
G1 X138.391 Y129.651 E.45607
M204 S10000
G1 X137.626 Y129.711 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.420838
G1 F15000
G1 X134.548 Y132.789 E.13406
G1 X133.897 Y132.905 F30000
G1 F15000
G1 X134.765 Y132.038 E.03777
G3 X134.009 Y132.259 I-1.257 J-2.899 E.02429
G1 X133.511 Y132.758 E.02171
G1 X132.976 Y132.758 E.01646
G1 X133.44 Y132.294 E.02017
G1 X132.905 Y132.294 E.01646
G1 X132.442 Y132.758 E.02017
G1 X131.907 Y132.758 E.01646
G1 X132.371 Y132.294 E.02017
G1 X131.836 Y132.294 E.01646
G1 X131.373 Y132.758 E.02017
G1 X130.839 Y132.758 E.01646
G1 X131.302 Y132.294 E.02017
G1 X130.767 Y132.294 E.01646
G1 X130.304 Y132.758 E.02017
G1 X129.77 Y132.758 E.01646
G1 X130.233 Y132.294 E.02017
G1 X129.698 Y132.294 E.01646
G1 X129.235 Y132.758 E.02017
G1 X128.701 Y132.758 E.01646
G1 X129.164 Y132.294 E.02017
G1 X128.629 Y132.294 E.01646
G1 X128.166 Y132.758 E.02017
G1 X127.632 Y132.758 E.01646
G1 X128.095 Y132.294 E.02017
G1 X127.561 Y132.294 E.01646
G1 X127.097 Y132.758 E.02017
G1 X126.563 Y132.758 E.01646
G1 X127.026 Y132.294 E.02017
G1 X126.492 Y132.294 E.01646
G1 X126.028 Y132.758 E.02017
G1 X125.494 Y132.758 E.01646
G1 X125.957 Y132.294 E.02017
G1 X125.423 Y132.294 E.01646
G1 X124.96 Y132.758 E.02017
G1 X124.425 Y132.758 E.01646
G1 X124.888 Y132.294 E.02017
G1 X124.354 Y132.294 E.01646
G1 X123.891 Y132.758 E.02017
G1 X123.356 Y132.758 E.01646
G1 X123.819 Y132.294 E.02017
G1 X123.285 Y132.294 E.01646
G1 X122.822 Y132.758 E.02017
G1 X122.287 Y132.758 E.01646
G1 X122.75 Y132.294 E.02017
G1 X122.216 Y132.294 E.01646
G1 X121.753 Y132.758 E.02017
G1 X121.218 Y132.758 E.01646
G1 X121.681 Y132.294 E.02017
G1 X121.147 Y132.294 E.01646
G1 X120.684 Y132.758 E.02017
G1 X120.149 Y132.758 E.01646
G1 X120.613 Y132.294 E.02017
G1 X120.078 Y132.294 E.01646
G1 X119.615 Y132.758 E.02017
G1 X119.08 Y132.758 E.01646
G1 X119.544 Y132.294 E.02017
G1 X119.009 Y132.294 E.01646
G1 X118.546 Y132.758 E.02017
G1 X118.012 Y132.758 E.01646
G1 X118.475 Y132.294 E.02017
G1 X117.94 Y132.294 E.01646
G1 X117.477 Y132.758 E.02017
G1 X116.943 Y132.758 E.01646
G1 X117.406 Y132.294 E.02017
G1 X116.871 Y132.294 E.01646
G1 X116.408 Y132.758 E.02017
G1 X115.874 Y132.758 E.01646
G1 X116.337 Y132.294 E.02017
G1 X115.802 Y132.294 E.01646
G1 X115.339 Y132.758 E.02017
G1 X114.805 Y132.758 E.01646
G1 X115.268 Y132.294 E.02017
G1 X114.734 Y132.294 E.01646
G1 X114.27 Y132.758 E.02017
G1 X113.736 Y132.758 E.01646
G1 X114.199 Y132.294 E.02017
G1 X113.665 Y132.294 E.01646
G1 X113.201 Y132.758 E.02017
G1 X112.667 Y132.758 E.01646
G1 X113.13 Y132.294 E.02017
G1 X112.596 Y132.294 E.01646
G1 X112.133 Y132.758 E.02017
G1 X111.598 Y132.758 E.01646
G1 X112.061 Y132.294 E.02017
G1 X111.527 Y132.294 E.01646
G1 X111.064 Y132.758 E.02017
G1 X110.529 Y132.758 E.01646
G1 X110.992 Y132.294 E.02017
G1 X110.458 Y132.294 E.01646
G1 X109.995 Y132.758 E.02017
G1 X109.46 Y132.758 E.01646
G1 X109.923 Y132.294 E.02017
G1 X109.389 Y132.294 E.01646
G1 X108.926 Y132.758 E.02017
G1 X108.391 Y132.758 E.01646
G1 X108.855 Y132.294 E.02017
G1 X108.32 Y132.294 E.01646
G1 X107.857 Y132.758 E.02017
G1 X107.322 Y132.758 E.01646
G1 X107.786 Y132.294 E.02017
G1 X107.251 Y132.294 E.01646
G1 X106.788 Y132.758 E.02017
G1 X106.254 Y132.758 E.01646
G1 X106.717 Y132.294 E.02017
G1 X106.182 Y132.294 E.01646
G1 X105.719 Y132.758 E.02017
G1 X105.185 Y132.758 E.01646
G1 X105.648 Y132.294 E.02017
G1 X105.113 Y132.294 E.01646
G1 X104.65 Y132.758 E.02017
G1 X104.379 Y132.758 E.00835
G1 X104.379 Y132.494 E.00811
G1 X104.749 Y132.125 E.01609
G1 X105.561 Y131.902 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X107.19 Y131.902 E.05401
G1 X110.499 Y128.593 E.15524
G1 X108.009 Y128.593 E.08259
G1 X111.318 Y131.902 E.15524
G1 X114.866 Y131.902 E.11767
G1 X118.175 Y128.593 E.15524
G1 X115.685 Y128.593 E.08259
G1 X118.994 Y131.902 E.15524
G1 X122.541 Y131.902 E.11767
G1 X125.851 Y128.593 E.15524
G1 X123.361 Y128.593 E.08259
G1 X126.67 Y131.902 E.15524
G1 X130.217 Y131.902 E.11767
G1 X133.527 Y128.593 E.15524
G1 X131.037 Y128.593 E.08259
G1 X134.25 Y131.806 E.15072
G2 X135.617 Y130.964 I-.861 J-2.93 E.05391
; WIPE_START
G1 X135.241 Y131.314 E-.1955
G1 X134.841 Y131.574 E-.18105
G1 X134.25 Y131.806 E-.2415
G1 X133.985 Y131.542 E-.14196
; WIPE_END
G1 E-.04 F1800
G1 X141.322 Y129.438 Z17.2 F30000
G1 X142.518 Y129.095 Z17.2
G1 Z16.8
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.420838
G1 F15000
G1 X148.538 Y123.075 E.26221
G1 X148.004 Y123.075 E.01646
G1 X142.153 Y128.925 E.25482
G1 X141.619 Y128.925 E.01646
G1 X147.47 Y123.075 E.25482
G1 X146.935 Y123.075 E.01646
G1 X141.084 Y128.925 E.25482
G1 X140.55 Y128.925 E.01646
G1 X146.401 Y123.075 E.25482
G1 X145.866 Y123.075 E.01646
G1 X140.015 Y128.925 E.25482
G1 X139.481 Y128.925 E.01646
G1 X145.332 Y123.075 E.25482
G1 X144.797 Y123.075 E.01646
G1 X138.946 Y128.925 E.25482
G1 X138.412 Y128.925 E.01646
G1 X144.263 Y123.075 E.25482
G1 X143.728 Y123.075 E.01646
G1 X136.757 Y130.046 E.30362
G1 X136.96 Y129.685 E.01276
G1 X136.944 Y129.474 E.00653
G1 X136.878 Y129.391 E.00327
G1 X143.194 Y123.075 E.27508
G1 X142.659 Y123.075 E.01646
G1 X137.533 Y128.201 E.22327
G1 X137.242 Y128.201 E.00895
G1 X137.053 Y128.352 E.00747
G1 X136.955 Y128.779 E.01349
G1 X136.861 Y128.873 E.0041
G1 X136.955 Y128.462 E.01298
G1 X136.858 Y128.341 E.00477
G1 X142.125 Y123.075 E.22937
G1 X141.59 Y123.075 E.01646
G1 X136.464 Y128.201 E.22326
G1 X135.93 Y128.201 E.01646
G1 X141.056 Y123.075 E.22326
G1 X140.522 Y123.075 E.01646
G1 X135.395 Y128.201 E.22326
G1 X134.861 Y128.201 E.01646
G1 X139.987 Y123.075 E.22326
G1 X139.453 Y123.075 E.01646
G1 X134.326 Y128.201 E.22326
G1 X133.792 Y128.201 E.01646
G1 X138.918 Y123.075 E.22326
G1 X138.384 Y123.075 E.01646
G1 X133.257 Y128.201 E.22326
G1 X132.723 Y128.201 E.01646
G1 X137.177 Y123.747 E.19398
G1 X137.242 Y123.799 E.00258
G1 X137.563 Y123.799 E.00987
G1 X137.768 Y123.481 E.01165
G1 X137.666 Y123.257 E.00757
G1 X137.904 Y123.02 E.01035
G1 X137.692 Y122.697 E.01188
G1 X132.188 Y128.201 E.23969
G1 X131.654 Y128.201 E.01646
G1 X136.056 Y123.799 E.19171
G1 X135.521 Y123.799 E.01646
G1 X131.119 Y128.201 E.19171
G1 X130.585 Y128.201 E.01646
G1 X134.987 Y123.799 E.19171
G1 X134.452 Y123.799 E.01646
G1 X130.051 Y128.201 E.19171
G1 X129.516 Y128.201 E.01646
G1 X133.918 Y123.799 E.19171
G1 X133.384 Y123.799 E.01646
G1 X128.982 Y128.201 E.19171
G1 X128.447 Y128.201 E.01646
G1 X132.849 Y123.799 E.19171
G1 X132.315 Y123.799 E.01646
G1 X127.913 Y128.201 E.19171
G1 X127.378 Y128.201 E.01646
G1 X131.78 Y123.799 E.19171
G1 X131.246 Y123.799 E.01646
G1 X126.844 Y128.201 E.19171
G1 X126.309 Y128.201 E.01646
G1 X130.711 Y123.799 E.19171
G1 X130.177 Y123.799 E.01646
G1 X125.775 Y128.201 E.19171
G1 X125.24 Y128.201 E.01646
G1 X129.642 Y123.799 E.19171
G1 X129.108 Y123.799 E.01646
G1 X124.706 Y128.201 E.19171
G1 X124.172 Y128.201 E.01646
G1 X128.573 Y123.799 E.19171
G1 X128.039 Y123.799 E.01646
G1 X123.637 Y128.201 E.19171
G1 X123.103 Y128.201 E.01646
G1 X127.505 Y123.799 E.19171
G1 X126.97 Y123.799 E.01646
G1 X122.568 Y128.201 E.19171
G1 X122.034 Y128.201 E.01646
G1 X126.436 Y123.799 E.19171
M73 P88 R2
G1 X125.901 Y123.799 E.01646
G1 X121.499 Y128.201 E.19171
G1 X120.965 Y128.201 E.01646
G1 X125.367 Y123.799 E.19171
G1 X124.832 Y123.799 E.01646
G1 X120.43 Y128.201 E.19171
G1 X119.896 Y128.201 E.01646
G1 X124.298 Y123.799 E.19171
G1 X123.763 Y123.799 E.01646
G1 X119.361 Y128.201 E.19171
G1 X118.827 Y128.201 E.01646
G1 X123.229 Y123.799 E.19171
G1 X122.694 Y123.799 E.01646
G1 X118.292 Y128.201 E.19171
G1 X117.758 Y128.201 E.01646
G1 X122.16 Y123.799 E.19171
G1 X121.626 Y123.799 E.01646
G1 X117.224 Y128.201 E.19171
G1 X116.689 Y128.201 E.01646
G1 X121.091 Y123.799 E.19171
G1 X120.557 Y123.799 E.01646
G1 X116.155 Y128.201 E.19171
G1 X115.62 Y128.201 E.01646
G1 X120.022 Y123.799 E.19171
G1 X119.488 Y123.799 E.01646
G1 X115.086 Y128.201 E.19171
G1 X114.551 Y128.201 E.01646
G1 X118.953 Y123.799 E.19171
G1 X118.419 Y123.799 E.01646
G1 X114.017 Y128.201 E.19171
G1 X113.482 Y128.201 E.01646
G1 X117.884 Y123.799 E.19171
G1 X117.35 Y123.799 E.01646
G1 X112.948 Y128.201 E.19171
G1 X112.413 Y128.201 E.01646
G1 X116.815 Y123.799 E.19171
G1 X116.281 Y123.799 E.01646
G1 X111.879 Y128.201 E.19171
G1 X111.345 Y128.201 E.01646
G1 X115.746 Y123.799 E.19171
G1 X115.212 Y123.799 E.01646
G1 X110.81 Y128.201 E.19171
G1 X110.276 Y128.201 E.01646
G1 X114.678 Y123.799 E.19171
G1 X114.143 Y123.799 E.01646
G1 X109.741 Y128.201 E.19171
G1 X109.207 Y128.201 E.01646
G1 X113.609 Y123.799 E.19171
G1 X113.074 Y123.799 E.01646
G1 X108.672 Y128.201 E.19171
G1 X108.138 Y128.201 E.01646
G1 X112.54 Y123.799 E.19171
G1 X112.005 Y123.799 E.01646
G1 X107.603 Y128.201 E.19171
G1 X107.069 Y128.201 E.01646
G1 X111.471 Y123.799 E.19171
G1 X110.936 Y123.799 E.01646
G1 X106.534 Y128.201 E.19171
G1 X106 Y128.201 E.01646
G1 X110.402 Y123.799 E.19171
G1 X109.867 Y123.799 E.01646
G1 X105.466 Y128.201 E.19171
G1 X104.962 Y128.201 E.01551
G1 X104.909 Y128.223 E.00175
G1 X109.333 Y123.799 E.19266
G1 X108.799 Y123.799 E.01646
G1 X104.379 Y128.218 E.19247
G1 X104.379 Y127.684 E.01646
G1 X108.264 Y123.799 E.1692
G1 X107.73 Y123.799 E.01646
G1 X104.379 Y127.15 E.14592
G1 X104.379 Y126.615 E.01646
G1 X107.195 Y123.799 E.12264
G1 X106.661 Y123.799 E.01646
G1 X104.379 Y126.081 E.09937
G1 X104.379 Y125.546 E.01646
G1 X106.126 Y123.799 E.07609
G1 X105.592 Y123.799 E.01646
G1 X104.379 Y125.012 E.05282
G1 X104.379 Y124.477 E.01646
G1 X105.057 Y123.799 E.02954
G3 X104.705 Y123.617 I-.015 J-.403 E.01277
G1 X104.209 Y124.113 E.02159
G1 X104.209 Y119.837 F30000
G1 F15000
G1 X104.804 Y119.243 E.02588
G1 X105.338 Y119.243 E.01646
G1 X104.875 Y119.706 E.02016
G1 X105.41 Y119.706 E.01646
G1 X105.872 Y119.243 E.02016
G1 X106.407 Y119.243 E.01646
G1 X105.944 Y119.706 E.02015
G1 X106.478 Y119.706 E.01646
G1 X106.941 Y119.243 E.02015
G1 X107.475 Y119.243 E.01646
G1 X107.013 Y119.706 E.02014
G1 X107.547 Y119.706 E.01646
G1 X108.01 Y119.243 E.02014
G1 X108.544 Y119.243 E.01646
G1 X108.082 Y119.706 E.02014
G1 X108.616 Y119.706 E.01646
G1 X109.079 Y119.243 E.02013
G1 X109.613 Y119.244 E.01646
G1 X109.151 Y119.706 E.02013
G1 X109.685 Y119.706 E.01646
G1 X110.147 Y119.244 E.02012
G1 X110.682 Y119.244 E.01646
G1 X110.22 Y119.706 E.02012
G1 X110.754 Y119.706 E.01646
G1 X111.216 Y119.244 E.02011
G1 X111.75 Y119.244 E.01646
G1 X111.289 Y119.706 E.02011
G1 X111.823 Y119.706 E.01646
G1 X112.285 Y119.244 E.02011
G1 X112.819 Y119.244 E.01646
G1 X112.357 Y119.706 E.0201
G1 X112.892 Y119.706 E.01646
G1 X113.353 Y119.244 E.0201
G1 X113.888 Y119.244 E.01646
G1 X113.426 Y119.706 E.02009
G1 X113.961 Y119.706 E.01646
G1 X114.422 Y119.244 E.02009
G1 X114.956 Y119.244 E.01646
G1 X114.495 Y119.706 E.02008
G1 X115.03 Y119.706 E.01646
G1 X115.491 Y119.245 E.02008
G1 X116.025 Y119.245 E.01646
G1 X115.564 Y119.706 E.02008
G1 X116.099 Y119.706 E.01646
G1 X116.56 Y119.245 E.02007
G1 X117.094 Y119.245 E.01646
G1 X116.633 Y119.706 E.02007
G1 X117.168 Y119.706 E.01646
G1 X117.628 Y119.245 E.02006
G1 X118.163 Y119.245 E.01646
G1 X117.702 Y119.706 E.02006
G1 X118.236 Y119.706 E.01646
G1 X118.697 Y119.245 E.02005
G1 X119.231 Y119.245 E.01646
G1 X118.771 Y119.706 E.02005
G1 X119.305 Y119.706 E.01646
G1 X119.766 Y119.245 E.02005
G1 X120.3 Y119.245 E.01646
G1 X119.84 Y119.706 E.02004
G1 X120.374 Y119.706 E.01646
G1 X120.834 Y119.246 E.02004
G1 X121.369 Y119.246 E.01646
G1 X120.909 Y119.706 E.02003
G1 X121.443 Y119.706 E.01646
G1 X121.903 Y119.246 E.02003
G1 X122.437 Y119.246 E.01646
G1 X121.978 Y119.706 E.02002
G1 X122.512 Y119.706 E.01646
G1 X122.972 Y119.246 E.02002
G1 X123.506 Y119.246 E.01646
G1 X123.047 Y119.706 E.02002
G1 X123.581 Y119.706 E.01646
G1 X124.041 Y119.246 E.02001
G1 X124.575 Y119.246 E.01646
G1 X124.116 Y119.706 E.02001
G1 X124.65 Y119.706 E.01646
G1 X125.109 Y119.246 E.02
G1 X125.644 Y119.246 E.01646
G1 X125.184 Y119.706 E.02
G1 X125.719 Y119.706 E.01646
G1 X126.178 Y119.247 E.01999
G1 X126.712 Y119.247 E.01646
G1 X126.253 Y119.706 E.01999
G1 X126.788 Y119.706 E.01646
G1 X127.247 Y119.247 E.01999
G1 X127.781 Y119.247 E.01646
G1 X127.322 Y119.706 E.01998
G1 X127.857 Y119.706 E.01646
G1 X128.315 Y119.247 E.01998
G1 X128.85 Y119.247 E.01646
G1 X128.391 Y119.706 E.01997
G1 X128.926 Y119.706 E.01646
G1 X129.384 Y119.247 E.01997
G1 X129.918 Y119.247 E.01646
G1 X129.46 Y119.706 E.01996
G1 X129.995 Y119.706 E.01646
G1 X130.453 Y119.247 E.01996
G1 X130.987 Y119.247 E.01646
G1 X130.529 Y119.706 E.01996
G1 X131.063 Y119.706 E.01646
G1 X131.522 Y119.248 E.01995
G1 X132.056 Y119.248 E.01646
G1 X131.598 Y119.706 E.01995
G1 X132.132 Y119.706 E.01646
G1 X132.59 Y119.248 E.01994
G1 X133.125 Y119.248 E.01646
G1 X132.667 Y119.706 E.01994
G1 X133.201 Y119.706 E.01646
G1 X133.659 Y119.248 E.01993
G3 X134.073 Y119.278 I.006 J2.801 E.01279
G1 X134.147 Y119.294 E.00234
G1 X133.725 Y119.716 E.01837
G3 X134.197 Y119.779 I.026 J1.604 E.0147
G1 X134.573 Y119.403 E.0164
G1 X134.949 Y119.561 E.01256
G1 X134.616 Y119.895 E.01452
G1 X134.984 Y120.061 E.01245
G1 X135.284 Y119.76 E.01307
G3 X135.588 Y119.991 I-.695 J1.229 E.01178
G1 X135.314 Y120.265 E.01194
G3 X135.62 Y120.494 I-.717 J1.28 E.01179
G1 X135.866 Y120.248 E.01073
G1 X136.124 Y120.525 E.01165
G1 X135.893 Y120.755 E.01005
G3 X136.131 Y121.052 I-2.139 J1.96 E.01172
G1 X136.367 Y120.816 E.01026
G3 X136.596 Y121.121 I-2.904 J2.421 E.01176
G1 X136.362 Y121.355 E.01019
G1 X136.575 Y121.677 E.01188
G1 X136.825 Y121.427 E.0109
G1 X137.054 Y121.732 E.01176
G1 X136.784 Y122.002 E.01176
G1 X136.96 Y122.315 E.01106
G1 X136.957 Y122.364 E.00151
G1 X137.268 Y122.053 E.01355
G1 X137.48 Y122.375 E.01188
G1 X136.694 Y123.161 E.03421
G1 X135.616 Y121.035 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F15476.087
G2 X134.247 Y120.196 I-2.397 J2.377 E.05376
G1 X131.037 Y123.407 E.15061
G1 X133.527 Y123.407 E.08259
G1 X130.217 Y120.098 E.15524
G1 X126.67 Y120.098 E.11767
G1 X123.361 Y123.407 E.15524
G1 X125.851 Y123.407 E.08259
G1 X122.541 Y120.098 E.15524
G1 X118.994 Y120.098 E.11767
G1 X115.685 Y123.407 E.15524
G1 X118.175 Y123.407 E.08259
G1 X114.866 Y120.098 E.15524
G1 X111.318 Y120.098 E.11767
G1 X108.009 Y123.407 E.15524
G1 X110.499 Y123.407 E.08259
G1 X107.19 Y120.098 E.15524
G1 X105.561 Y120.098 E.05401
G1 X147.927 Y124.407 F30000
; FEATURE: Bridge
; LINE_WIDTH: 0.42471
G1 F3000
G1 X149.284 Y123.762 E.04675
G1 X150.487 Y123.324 E.03984
G1 X151.344 Y123.075 E.02777
G1 X151.617 Y123.075 E.00848
G1 X147.528 Y125.02 E.14086
G1 X147.419 Y125.248 E.00787
G1 X147.354 Y125.526 E.00887
G1 X152.508 Y123.075 E.17756
G1 X152.508 Y123.496 E.01311
G1 X147.344 Y125.953 E.17793
G1 X147.345 Y126.376 E.01314
G1 X150.915 Y124.677 E.123
G1 X150.77 Y124.781 E.00555
G1 X150.361 Y125.363 E.02213
G1 X147.422 Y126.762 E.10125
G1 X147.494 Y126.924 E.00552
G1 X147.612 Y127.094 E.00645
G1 X150.23 Y125.848 E.09018
G1 X150.23 Y126.271 E.01315
G1 X147.913 Y127.374 E.07981
G1 X148.266 Y127.628 E.01354
G1 X150.358 Y126.633 E.07208
G1 X150.581 Y126.95 E.01205
G1 X148.619 Y127.883 E.0676
G1 X148.794 Y128.003 E.00659
G1 X149.02 Y128.115 E.00786
G1 X150.823 Y127.257 E.06213
G1 X151.176 Y127.512 E.01354
G1 X149.491 Y128.314 E.05808
G1 X149.995 Y128.497 E.01668
G1 X151.586 Y127.74 E.05483
G1 X152.03 Y127.951 E.01531
G1 X150.499 Y128.68 E.05278
G1 X151.05 Y128.841 E.01786
G1 X152.475 Y128.163 E.0491
G1 X152.508 Y128.179 E.00116
G1 X152.508 Y128.569 E.01216
G1 X151.404 Y129.095 E.03806
G1 X149.466 Y129.095 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.420838
G1 F15000
G1 X149.751 Y128.81 E.01242
G1 X149.359 Y128.668 E.01285
G1 X149.101 Y128.925 E.01124
G1 X148.566 Y128.925 E.01646
G1 X148.979 Y128.513 E.01795
G1 X148.62 Y128.338 E.0123
G1 X148.032 Y128.925 E.0256
G1 X147.498 Y128.925 E.01646
G1 X148.303 Y128.12 E.03507
G1 X147.993 Y127.896 E.01179
G1 X146.963 Y128.925 E.04484
G1 X146.429 Y128.925 E.01646
G1 X147.682 Y127.672 E.0546
G1 X147.397 Y127.422 E.01166
G1 X145.894 Y128.925 E.06546
G1 X145.36 Y128.925 E.01646
G1 X147.169 Y127.116 E.0788
G1 X147.089 Y126.948 E.00574
G1 X147.021 Y126.729 E.00704
G1 X144.825 Y128.925 E.09565
G1 X144.291 Y128.925 E.01646
G1 X146.967 Y126.249 E.11655
G1 X146.967 Y125.715 E.01646
G1 X143.756 Y128.925 E.13982
G1 X143.222 Y128.925 E.01646
G1 X149.073 Y123.075 E.25482
G1 X149.607 Y123.075 E.01646
G1 X149.033 Y123.649 E.02501
; CHANGE_LAYER
; Z_HEIGHT: 17
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F15000
G1 X149.607 Y123.075 E-.30864
G1 X149.073 Y123.075 E-.20309
G1 X148.611 Y123.536 E-.24827
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 85/101
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L85
M991 S0 P84 ;notify layer change
G17
G3 Z17.2 I-.554 J-1.084 P1  F30000
G1 X138.156 Y128.878 Z17.2
G1 Z17
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X138.091 Y128.878 E.00217
G3 X136.37 Y131.486 I-15.837 J-8.576 E.1038
G1 X135.948 Y131.95 E.02079
G3 X133.609 Y132.916 I-2.429 J-2.565 E.08584
G1 X104.046 Y132.916 E.98068
G1 X104.046 Y119.084 E.45886
G1 X133.609 Y119.084 E.98068
G1 X134.066 Y119.12 E.0152
G1 X134.115 Y119.124 E.00164
G3 X135.948 Y120.05 I-.749 J3.758 E.06895
G1 X136.37 Y120.514 E.02079
G3 X138.091 Y123.122 I-14.116 J11.184 E.1038
G1 X152.842 Y123.122 E.48932
G1 X152.842 Y124.096 E.03231
G1 F8596.922
G1 X152.842 Y124.496 E.01327
G1 F3000
G1 X152.842 Y124.92 E.01405
M204 S5000
; FEATURE: Overhang wall

G1 X152.842 Y127.08 E.07165
M204 S10000
; FEATURE: Inner wall
G1 F9017.077
G1 X152.842 Y127.504 E.01405
G1 F15476.087
G1 X152.842 Y127.904 E.01327
G1 X152.842 Y128.878 E.03231
G1 X138.216 Y128.878 E.48515
G1 X138.321 Y129.27 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
G1 X137.974 Y129.888 E.02178
G3 X136.672 Y131.737 I-16.002 J-9.891 E.06951
G1 X136.222 Y132.231 E.02054
G3 X133.625 Y133.308 I-2.7 J-2.839 E.08837
G1 X103.654 Y133.308 E.92094
G1 X103.654 Y118.692 E.44914
G1 X133.625 Y118.692 E.92094
G1 X134.097 Y118.729 E.01456
G1 X134.178 Y118.736 E.00248
G3 X136.222 Y119.769 I-.679 J3.884 E.07142
G1 X136.672 Y120.263 E.02054
G3 X138.321 Y122.73 I-14.207 J11.277 E.09126
G1 X153.234 Y122.73 E.45824
G1 X153.234 Y123.581 E.02615
G1 X153.234 Y123.981 E.01229
G1 F8596.922
G1 X153.234 Y124.381 E.01229
G1 F3000
G1 X153.234 Y124.765 E.0118
; FEATURE: Overhang wall
; LINE_WIDTH: 0.45

G1 X153.234 Y127.235 E.08192
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F8317.092
G1 X153.234 Y127.619 E.0118
G1 F12000
G1 X153.234 Y128.019 E.01229
G1 X153.234 Y129.27 E.03844
G1 X138.381 Y129.27 E.4564
M204 S10000
; WIPE_START
G1 X137.974 Y129.888 E-.28122
G1 X137.373 Y130.801 E-.41556
G1 X137.273 Y130.935 E-.06322
; WIPE_END
G1 E-.04 F1800
G1 X135.883 Y124.135 Z17.4 F30000
G1 Z17
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X134.255 Y124.135 E.05401
G1 X130.445 Y120.325 E.17873
G1 X133.839 Y120.347 E.11259
G3 X134.07 Y120.374 I.038 J.679 E.00776
G1 X130.309 Y124.135 E.17644
G1 X126.579 Y124.135 E.12374
G1 X122.769 Y120.325 E.17873
G1 X126.443 Y120.325 E.12188
G1 X122.633 Y124.135 E.17873
G1 X118.903 Y124.135 E.12374
G1 X115.093 Y120.325 E.17873
G1 X118.767 Y120.325 E.12188
G1 X114.957 Y124.135 E.17873
G1 X111.227 Y124.135 E.12374
G1 X107.417 Y120.325 E.17873
G1 X111.091 Y120.325 E.12188
G1 X107.281 Y124.135 E.17873
G1 X108.909 Y124.135 E.05401
G1 X107.007 Y126 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.349388
G1 F15000
G1 X136.63 Y126 E.73977
G1 X133.585 Y132.087 F30000
; LINE_WIDTH: 0.459706
G1 F15000
G1 X104.458 Y132.087 E.98922
G1 X104.458 Y132.504 E.01417
G1 X133.593 Y132.504 E.9895
G1 X134.16 Y132.444 E.01937
G1 X134.688 Y132.286 E.01872
G1 X135.195 Y132.031 E.01928
; LINE_WIDTH: 0.416529
G1 X135.665 Y131.683 E.0178
G1 X136.075 Y131.253 E.01808
G2 X137.118 Y129.77 I-9.462 J-7.769 E.05526
G1 X137.764 Y128.658 E.03916
G1 X137.901 Y128.499 E.00639
G1 X138.791 Y128.486 E.02708
G1 X151.621 Y128.486 E.39061
G1 X151.101 Y128.239 E.01753
G1 X150.509 Y127.843 E.02168
G1 X150.199 Y127.545 E.0131
G1 X149.857 Y127.066 E.0179
G1 X149.655 Y126.658 E.01387
G1 X149.571 Y126.152 E.01561
G1 X149.604 Y125.539 E.01868
G1 X149.78 Y125.062 E.01548
G1 X150.142 Y124.529 E.01963
G1 X150.509 Y124.157 E.01592
G1 X150.968 Y123.833 E.0171
G1 X151.624 Y123.514 E.02219
G1 X137.971 Y123.514 E.41565
G1 X137.855 Y123.474 E.00374
G2 X136.749 Y121.648 I-26.376 J14.731 E.06501
G1 X136.159 Y120.852 E.03017
G1 X135.716 Y120.367 E.02001
G1 X135.31 Y120.04 E.01587
; LINE_WIDTH: 0.459508
G2 X133.585 Y119.496 I-1.797 J2.69 E.06225
G1 X104.458 Y119.496 E.98875
G1 X104.458 Y119.913 E.01416
G1 X133.585 Y119.913 E.98875
G1 X134.364 Y120.037 E.02679
G3 X135.082 Y120.344 I-.685 J2.59 E.02662
; LINE_WIDTH: 0.418174
G3 X135.828 Y120.987 I-1.72 J2.754 E.03022
G1 X136.444 Y121.813 E.0315
G1 X136.804 Y122.422 E.02165
G1 X136.823 Y122.628 E.00634
G1 X136.776 Y122.759 E.00426
G1 X136.979 Y123.644 E.02776
G2 X136.965 Y124.282 I1.994 J.362 E.0196
G1 X136.781 Y124.503 E.00879
G1 X136.689 Y124.527 E.00291
G1 X105.546 Y124.527 E.95232
G1 X105.534 Y124.546 E.00069
G1 X105.534 Y127.462 E.08915
G1 X105.554 Y127.473 E.00069
G1 X136.69 Y127.473 E.95209
G1 X136.83 Y127.536 E.00471
G1 X136.971 Y127.747 E.00776
G1 X136.933 Y128.125 E.01161
G1 X136.979 Y128.355 E.0072
G1 X136.772 Y129.259 E.02833
G1 X136.823 Y129.376 E.00391
G1 X136.804 Y129.578 E.00621
G1 X136.454 Y130.173 E.02112
G1 X135.901 Y130.934 E.02876
G1 X135.468 Y131.373 E.01886
G1 X135.05 Y131.678 E.01582
; LINE_WIDTH: 0.443786
G3 X133.644 Y132.081 I-1.557 J-2.777 E.0482
G1 X136.689 Y124.904 F30000
; LINE_WIDTH: 0.419999
G1 F15000
G1 X105.911 Y124.904 E.94571
G1 X105.911 Y127.096 E.06735
G1 X136.69 Y127.096 E.94573
G1 X136.966 Y127.168 E.00878
G1 X137.208 Y127.394 E.01018
G1 X137.346 Y127.706 E.01048
G2 X137.347 Y128.44 I5.162 J.363 E.02257
G1 X137.272 Y128.765 E.01027
G1 X137.478 Y128.398 E.01294
G1 X137.631 Y128.222 E.00716
G1 X137.883 Y128.116 E.0084
G1 X150.24 Y128.109 E.37969
G1 X149.891 Y127.764 E.01505
G1 X149.55 Y127.285 E.01807
G1 X149.284 Y126.723 E.01911
G1 X149.195 Y126.132 E.01837
G1 X149.227 Y125.519 E.01886
G1 X149.429 Y124.925 E.01928
G1 X149.832 Y124.315 E.02247
G1 X150.241 Y123.891 E.0181
G1 X137.971 Y123.891 E.37702
M73 P89 R2
G3 X137.623 Y123.771 I0 J-.566 E.01154
G3 X137.272 Y123.235 I1.695 J-1.49 E.01976
G1 X137.359 Y123.639 E.0127
G2 X137.346 Y124.295 I1.69 J.362 E.02029
G1 X137.206 Y124.609 E.01059
G1 X136.966 Y124.832 E.01006
G1 X136.747 Y124.889 E.00694
G1 X136.689 Y125.281 F30000
G1 F15000
G1 X106.288 Y125.281 E.93413
G1 X106.288 Y126.719 E.04418
G1 X136.69 Y126.719 E.93414
G1 X137.15 Y126.839 E.01463
G1 X137.491 Y127.144 E.01407
G1 X137.693 Y127.519 E.01308
G1 X137.721 Y127.771 E.0078
G1 X137.971 Y127.731 E.0078
G1 X149.405 Y127.731 E.35133
G1 X149.172 Y127.387 E.01279
G1 X148.912 Y126.789 E.02003
G1 X148.818 Y126.112 E.021
G1 X148.851 Y125.499 E.01886
G1 X148.914 Y125.206 E.0092
G1 X149.18 Y124.596 E.02046
G1 X149.405 Y124.269 E.01222
G1 X137.971 Y124.269 E.35133
G1 X137.72 Y124.228 E.00781
G1 X137.693 Y124.481 E.00781
G1 X137.487 Y124.86 E.01326
G1 X137.15 Y125.161 E.01387
G1 X136.747 Y125.266 E.01279
G1 X136.689 Y125.658 F30000
G1 F15000
G1 X106.665 Y125.658 E.92255
G1 X106.665 Y126.342 E.021
G1 X136.69 Y126.342 E.92255
G1 X137.334 Y126.51 E.02048
G1 X137.768 Y126.888 E.01767
G1 X138.022 Y127.354 E.01632
G1 X148.731 Y127.354 E.32908
G1 X148.541 Y126.854 E.01645
G1 X148.441 Y126.092 E.02362
G1 X148.474 Y125.479 E.01886
G3 X148.723 Y124.649 I2.845 J.401 E.02671
G2 X138.022 Y124.646 I-5.87 J1517.519 E.32883
G1 X137.774 Y125.105 E.01603
G1 X137.334 Y125.49 E.01796
G1 X136.748 Y125.643 E.01863
G1 X136.69 Y126 F30000
; LINE_WIDTH: 0.367041
G1 F15000
G1 X137.104 Y126.09 E.01121
; LINE_WIDTH: 0.419694
G1 X137.519 Y126.181 E.01303
G1 X137.955 Y126.531 E.01719
G1 X138.057 Y126.646 E.00472
G1 X138.236 Y126.977 E.01156
G1 X148.189 Y126.977 E.30558
G3 X148.098 Y125.459 I4.133 J-1.011 E.04696
G1 X148.192 Y125.023 E.0137
G1 X138.236 Y125.023 E.30569
G1 X138.049 Y125.363 E.0119
G1 X137.519 Y125.819 E.02149
; LINE_WIDTH: 0.402347
G1 X137.133 Y125.903 E.01155
; LINE_WIDTH: 0.367041
G1 X136.748 Y125.987 E.01041
G1 X137.887 Y126 F30000
; LINE_WIDTH: 0.419999
G1 F15000
G1 X138.331 Y126.386 E.01807
G1 X138.45 Y126.6 E.00754
G1 X147.731 Y126.6 E.28517
G3 X147.73 Y125.4 I5.871 J-.605 E.03695
G1 X138.45 Y125.4 E.28515
G1 X138.236 Y125.719 E.01181
G1 X137.934 Y125.962 E.01192
G1 X138.532 Y126.019 F30000
; LINE_WIDTH: 0.454604
G1 F15000
G1 X138.674 Y126.206 E.00789
G1 X147.305 Y126.206 E.28955
G1 X147.307 Y125.794 E.01381
G1 X138.674 Y125.794 E.28963
G1 X138.564 Y125.968 E.00689
G1 X152.399 Y123.376 F30000
; LINE_WIDTH: 0.38292
G1 F15000
G1 X152.231 Y123.389 E.00468
G1 X149.969 Y125.145 F30000
; FEATURE: Bridge
; LINE_WIDTH: 0.462571
G1 F3000
G1 X149.978 Y126.417 E.04349
G1 X150.022 Y126.572 E.00551
G1 X150.111 Y126.76 E.00711
G1 X150.389 Y127.167 E.01685
G1 X150.389 Y124.833 E.0798
G1 X150.576 Y124.595 E.01036
G1 X150.808 Y124.406 E.01025
G1 X150.808 Y127.594 E.10904
G1 X151.228 Y127.881 E.01738
G1 X151.228 Y124.119 E.12864
G1 X151.648 Y123.918 E.01591
G1 X151.648 Y128.082 E.14236
G1 X152.067 Y128.281 E.01589
G1 X152.067 Y123.719 E.15602
G1 X152.259 Y123.635 E.00716
G1 X152.487 Y123.593 E.00792
G1 X152.487 Y128.573 E.17029
G1 X108.909 Y127.865 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X107.281 Y127.865 E.05401
G1 X111.091 Y131.675 E.17873
G1 X107.417 Y131.675 E.12188
G1 X111.227 Y127.865 E.17873
G1 X114.957 Y127.865 E.12374
G1 X118.767 Y131.675 E.17873
G1 X115.093 Y131.675 E.12188
G1 X118.903 Y127.865 E.17873
G1 X122.633 Y127.865 E.12374
G1 X126.443 Y131.675 E.17873
G1 X122.769 Y131.675 E.12188
G1 X126.579 Y127.865 E.17873
G1 X130.309 Y127.865 E.12374
G1 X134.07 Y131.626 E.17644
G3 X133.588 Y131.675 I-.381 J-1.362 E.01613
G1 X130.445 Y131.675 E.10428
G1 X134.255 Y127.865 E.17873
G1 X135.883 Y127.865 E.05401
G1 X104.394 Y123.35 F30000
G1 F15476.087
G1 X104.394 Y124.978 E.05401
G1 X105.142 Y125.726 E.03509
G1 X105.142 Y126.274 E.01816
G1 X104.394 Y127.022 E.03509
G1 X104.394 Y128.65 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 17.2
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F15476.087
G1 X104.394 Y127.022 E-.61876
G1 X104.657 Y126.759 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 86/101
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L86
M991 S0 P85 ;notify layer change
G17
G3 Z17.4 I-.081 J1.214 P1  F30000
G1 X137.823 Y128.976 Z17.4
G1 Z17.2
G1 E.8 F1800
; FEATURE: Inner wall
G1 F11768
G3 X135.948 Y131.722 I-11.947 J-6.142 E.11058
G1 X135.504 Y132.107 E.0195
G3 X133.609 Y132.725 I-1.986 J-2.88 E.06704
G1 X104.046 Y132.725 E.98068
G1 X104.046 Y119.275 E.44614
G1 X133.609 Y119.275 E.98068
G1 X133.886 Y119.298 E.00922
G1 X134.115 Y119.316 E.00762
G3 X136.169 Y120.518 I-.635 J3.438 E.08053
G3 X138.056 Y123.536 I-10.237 J8.503 E.11844
G1 X152.842 Y123.536 E.49046
G1 X152.842 Y128.464 E.16344
G1 X138.056 Y128.464 E.49046
G1 X137.848 Y128.921 E.01668
G1 X138.173 Y129.153 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F11768
G3 X136.222 Y132.003 I-12.277 J-6.31 E.10641
G1 X135.741 Y132.421 E.0196
G3 X133.625 Y133.117 I-2.148 J-2.97 E.06953
G1 X103.654 Y133.117 E.92094
G1 X103.654 Y118.883 E.43736
G1 X133.625 Y118.883 E.92094
G1 X133.918 Y118.907 E.00902
G1 X134.178 Y118.928 E.00802
G3 X136.465 Y120.261 I-.709 J3.844 E.08299
G3 X138.309 Y123.144 I-10.578 J8.796 E.10543
G1 X153.234 Y123.144 E.45861
G1 X153.234 Y128.856 E.17549
G1 X138.309 Y128.856 E.45861
G1 X138.198 Y129.099 E.0082
M204 S10000
; WIPE_START
G1 F12000
G1 X137.688 Y130.019 E-.39973
G1 X137.166 Y130.81 E-.36027
; WIPE_END
G1 E-.04 F1800
G1 X134.738 Y123.574 Z17.6 F30000
G1 X133.584 Y120.136 Z17.6
G1 Z17.2
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.466173
G1 F11768
G1 X134.112 Y120.182 E.01828
G1 X134.691 Y120.372 E.02104
G1 X135.027 Y120.55 E.01309
; LINE_WIDTH: 0.422215
G3 X135.8 Y121.23 I-1.883 J2.921 E.03195
; LINE_WIDTH: 0.415511
G1 X136.158 Y121.702 E.01799
G3 X136.788 Y122.793 I-9.466 J6.199 E.03825
G3 X136.975 Y123.744 I-6.849 J1.841 E.02947
G1 X136.943 Y123.963 E.00672
G1 X137.139 Y125.691 E.05279
G1 X137.139 Y126.313 E.0189
G3 X136.933 Y128.125 I-600.381 J-67.512 E.05536
G1 X136.979 Y128.355 E.00715
G1 X136.792 Y129.191 E.026
G1 X136.217 Y130.213 E.03561
G3 X135.472 Y131.108 I-3.613 J-2.251 E.03545
; LINE_WIDTH: 0.441045
G1 X135.03 Y131.449 E.01811
G1 X134.573 Y131.686 E.0167
; LINE_WIDTH: 0.477417
G1 X133.994 Y131.834 E.02115
G1 X133.584 Y131.869 E.01459
G1 X104.467 Y131.869 E1.03092
G1 X104.467 Y132.304 E.0154
G1 X133.593 Y132.304 E1.03122
G1 X134.164 Y132.243 E.02033
G1 X134.682 Y132.087 E.01915
G1 X135.198 Y131.819 E.02062
; LINE_WIDTH: 0.42384
G2 X136.059 Y131.013 I-2.13 J-3.14 E.03676
; LINE_WIDTH: 0.418558
G1 X136.441 Y130.507 E.01941
G2 X137.754 Y128.182 I-11.74 J-8.161 E.08184
G1 X137.925 Y128.071 E.00625
G1 X152.45 Y128.071 E.44458
G1 X152.45 Y123.929 E.12681
G1 X137.925 Y123.929 E.44458
G1 X137.754 Y123.818 E.00625
G2 X137.158 Y122.65 I-6.638 J2.651 E.04021
G1 X136.518 Y121.607 E.03744
G2 X135.744 Y120.637 I-5.682 J3.74 E.03803
; LINE_WIDTH: 0.442107
G1 X135.277 Y120.233 E.02009
G1 X134.734 Y119.934 E.02019
; LINE_WIDTH: 0.479261
G1 X134.22 Y119.77 E.01918
G2 X133.584 Y119.698 I-.856 J4.712 E.02278
G1 X104.467 Y119.696 E1.03528
G1 X104.467 Y120.131 E.01546
G1 X133.524 Y120.136 E1.03315
G1 X138.206 Y125.06 F30000
; LINE_WIDTH: 0.419999
G1 F11768
G3 X138.207 Y126.94 I-7.265 J.945 E.05794
G1 X151.318 Y126.94 E.40287
G1 X151.318 Y125.06 E.05778
G1 X138.266 Y125.06 E.40106
G1 X138.629 Y125.437 F30000
G1 F11768
G3 X138.63 Y126.563 I-9.869 J.576 E.03463
G1 X150.941 Y126.563 E.37829
G1 X150.941 Y125.437 E.03461
G1 X138.689 Y125.437 E.37649
G1 X139.024 Y126.187 F30000
; LINE_WIDTH: 0.417523
G1 F11768
G1 X150.565 Y126.187 E.35231
G1 X150.565 Y125.813 E.01143
G1 X139.025 Y125.813 E.35229
G1 X139.024 Y126.127 E.0096
G1 X137.801 Y127.177 F30000
; LINE_WIDTH: 0.419999
G1 F11768
G1 X137.773 Y127.415 E.00736
G1 X137.925 Y127.317 E.00556
G1 X151.695 Y127.317 E.42311
G1 X151.695 Y124.683 E.08095
G1 X137.925 Y124.683 E.42311
G1 X137.772 Y124.584 E.00559
G1 X137.889 Y125.605 E.03158
G1 X137.893 Y126.315 E.0218
G1 X137.807 Y127.118 E.02482
G1 X137.426 Y127.134 F30000
G1 F11768
G1 X137.317 Y128.087 E.02945
G1 X137.336 Y128.189 E.00321
G1 X137.411 Y128.026 E.00553
G1 X137.925 Y127.694 E.01881
G1 X152.073 Y127.694 E.4347
G1 X152.073 Y124.306 E.10413
G1 X137.925 Y124.306 E.4347
G1 X137.411 Y123.974 E.01881
G1 X137.336 Y123.81 E.00554
G1 X137.326 Y123.998 E.00577
G1 X137.514 Y125.648 E.05103
G3 X137.432 Y127.075 I-6.304 J.355 E.04401
G1 X106.016 Y131.448 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F11768
G1 X107.644 Y131.448 E.05401
G1 X118.536 Y120.555 E.51098
G1 X115.322 Y120.555 E.10661
G1 X126.216 Y131.448 E.51102
G1 X122.996 Y131.448 E.1068
G1 X133.867 Y120.577 E.50999
G1 X130.678 Y120.558 E.1058
G1 X136.714 Y126.594 E.28317
G2 X136.712 Y125.407 I-5.033 J-.587 E.03947
G1 X130.672 Y131.448 E.28337
G1 X133.867 Y131.423 E.10599
G1 X123 Y120.556 E.50979
G1 X126.211 Y120.557 E.1065
G1 X115.32 Y131.448 E.51091
G1 X118.54 Y131.448 E.1068
G1 X107.645 Y120.553 E.5111
G1 X110.862 Y120.554 E.10672
G1 X104.394 Y127.022 E.30343
G1 X104.394 Y124.978 E.06779
G1 X110.864 Y131.448 E.3035
G1 X112.492 Y131.448 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 17.4
; LAYER_HEIGHT: 0.199999
; WIPE_START
G1 F15476.087
G1 X110.864 Y131.448 E-.61876
G1 X110.601 Y131.185 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 87/101
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L87
M991 S0 P86 ;notify layer change
G17
G3 Z17.6 I.141 J1.209 P1  F30000
G1 X138.115 Y127.972 Z17.6
G1 Z17.4
G1 E.8 F1800
; FEATURE: Inner wall
G1 F10814
G1 X138.055 Y127.972 E.00199
G3 X136.361 Y130.997 I-13.522 J-5.587 E.11527
G3 X134.594 Y132.376 I-3.119 J-2.175 E.07546
G3 X133.609 Y132.533 I-.984 J-3.009 E.03322
G1 X104.046 Y132.533 E.98068
G1 X104.046 Y119.467 E.43342
G1 X133.707 Y119.475 E.9839
G3 X135.046 Y119.823 I-.082 J3.072 E.04632
G3 X136.361 Y121.003 I-1.917 J3.456 E.05909
G1 X137.068 Y122.057 E.04211
G3 X138.055 Y124.028 I-14.45 J8.466 E.07316
G1 X152.842 Y124.028 E.49051
G1 X152.842 Y127.972 E.13085
G1 X138.175 Y127.972 E.48653
G1 X138.308 Y128.364 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F10814
G3 X136.222 Y131.776 I-11.782 J-4.859 E.12338
G3 X135.235 Y132.523 I-3.155 J-3.148 E.03816
G3 X133.625 Y132.925 I-1.654 J-3.194 E.05145
G1 X103.654 Y132.925 E.92094
G1 X103.654 Y119.075 E.42558
G1 X133.738 Y119.084 E.9244
G1 X134.178 Y119.119 E.01356
G1 X134.716 Y119.25 E.01702
G3 X135.741 Y119.806 I-1.612 J4.194 E.03593
G1 X136.222 Y120.224 E.0196
G3 X137.897 Y122.732 I-10.007 J8.495 E.09286
G3 X138.308 Y123.636 I-23.812 J11.37 E.03052
G1 X153.234 Y123.636 E.45863
G1 X153.234 Y128.364 E.1453
G1 X138.368 Y128.364 E.45678
M204 S10000
; WIPE_START
G1 F12000
G1 X137.897 Y129.268 E-.38737
G1 X137.417 Y130.123 E-.37263
; WIPE_END
G1 E-.04 F1800
G1 X133.583 Y131.634 Z17.8 F30000
G1 Z17.4
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.505829
G1 F10814
G1 X104.481 Y131.635 E1.09775
G1 X104.481 Y132.098 E.01747
G1 X133.592 Y132.098 E1.0981
G1 X134.16 Y132.036 E.02156
G1 X134.701 Y131.863 E.02141
G1 X135.217 Y131.571 E.02238
; LINE_WIDTH: 0.453366
G1 X135.673 Y131.195 E.01977
; LINE_WIDTH: 0.421549
G1 X136.138 Y130.643 E.02226
G2 X137.475 Y128.271 I-11.716 J-8.164 E.08413
G1 X137.752 Y127.691 E.01984
M73 P89 R1
G1 X137.924 Y127.58 E.0063
G1 X152.45 Y127.58 E.44818
G1 X152.45 Y124.42 E.09751
G1 X137.924 Y124.42 E.44818
G1 X137.752 Y124.309 E.0063
G1 X137.468 Y123.709 E.02049
; LINE_WIDTH: 0.447895
G2 X136.76 Y122.311 I-16.415 J7.44 E.05173
; LINE_WIDTH: 0.417384
G2 X135.754 Y120.897 I-7.974 J4.609 E.05302
; LINE_WIDTH: 0.448243
G1 X135.286 Y120.479 E.02073
; LINE_WIDTH: 0.503642
G2 X133.59 Y119.908 I-1.688 J2.211 E.06842
G1 X104.481 Y119.902 E1.09282
G1 X104.481 Y120.365 E.01739
G1 X133.59 Y120.367 E1.09282
G1 X134.059 Y120.414 E.01771
G1 X134.56 Y120.561 E.0196
G1 X135.014 Y120.8 E.01926
; LINE_WIDTH: 0.440087
G1 X135.424 Y121.114 E.01674
G1 X135.844 Y121.603 E.02085
G1 X136.409 Y122.459 E.03317
G3 X136.959 Y123.648 I-22.205 J10.989 E.04242
G1 X136.941 Y123.854 E.0067
; LINE_WIDTH: 0.42352
G2 X137.139 Y125.691 I58.292 J-5.377 E.05728
G1 X137.139 Y126.313 E.0193
G2 X136.945 Y128.125 I48.311 J6.09 E.05651
; LINE_WIDTH: 0.46611
G1 X136.959 Y128.313 E.00652
G1 X136.811 Y128.723 E.01502
; LINE_WIDTH: 0.426111
G1 X136.414 Y129.531 E.0281
G1 X135.886 Y130.361 E.03072
G1 X135.452 Y130.857 E.02059
; LINE_WIDTH: 0.448181
G1 X135.035 Y131.184 E.01751
; LINE_WIDTH: 0.491017
G1 X134.583 Y131.429 E.01876
G1 X134.083 Y131.585 E.01913
G1 X133.642 Y131.628 E.01617
G1 X137.381 Y127.527 F30000
; LINE_WIDTH: 0.419999
G1 F10814
G1 X137.37 Y127.62 E.00285
M73 P90 R1
G1 X137.408 Y127.535 E.00285
G1 X137.924 Y127.203 E.01883
G1 X152.073 Y127.203 E.43476
G1 X152.073 Y124.797 E.07394
G1 X137.924 Y124.797 E.43476
G1 X137.408 Y124.465 E.01883
G1 X137.369 Y124.379 E.00289
G1 X137.514 Y125.648 E.03924
G1 X137.516 Y126.314 E.02046
G1 X137.387 Y127.468 E.03568
G1 X138.72 Y126 F30000
; LINE_WIDTH: 0.56386
G1 F10814
G1 X150.809 Y126 E.51318
G1 X138.262 Y125.551 F30000
; LINE_WIDTH: 0.419999
G1 F10814
G3 X138.263 Y126.449 I-6.461 J.454 E.02762
G1 X151.318 Y126.449 E.40116
G1 X151.318 Y125.551 E.02759
G1 X138.322 Y125.551 E.39934
G1 X137.833 Y125.116 F30000
G1 F10814
G3 X137.834 Y126.884 I-6.416 J.889 E.0545
G1 X137.924 Y126.826 E.00327
G1 X151.695 Y126.826 E.42317
G1 X151.695 Y125.174 E.05077
G1 X137.924 Y125.174 E.42317
G1 X137.883 Y125.148 E.00147
G1 X112.244 Y131.2 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F10814
G1 X110.615 Y131.2 E.05401
G1 X104.394 Y124.978 E.29185
G1 X104.394 Y127.022 E.06779
G1 X110.615 Y120.8 E.29185
G1 X107.892 Y120.8 E.09033
G1 X118.291 Y131.2 E.48784
G1 X115.568 Y131.2 E.09033
G1 X125.967 Y120.8 E.48784
G1 X123.244 Y120.8 E.09033
G1 X133.638 Y131.194 E.48759
G1 X130.92 Y131.2 E.09015
G1 X136.712 Y125.407 E.27173
G3 X136.714 Y126.594 I-5.028 J.6 E.03947
G1 X130.92 Y120.8 E.2718
G1 X133.638 Y120.806 E.09015
G1 X123.244 Y131.2 E.48759
G1 X125.967 Y131.2 E.09033
G1 X115.568 Y120.8 E.48784
G1 X118.291 Y120.8 E.09033
G1 X107.892 Y131.2 E.48784
G1 X106.264 Y131.2 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 17.6
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F15476.087
G1 X107.892 Y131.2 E-.61876
G1 X108.155 Y130.937 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 88/101
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L88
M991 S0 P87 ;notify layer change
G17
G3 Z17.8 I.173 J1.205 P1  F30000
G1 X137.385 Y126.745 Z17.8
G1 Z17.6
G1 E.8 F1800
; FEATURE: Inner wall
G1 F10670
G1 X136.813 Y129.238 E.08483
G1 X137.254 Y129.238 E.0146
G3 X135.926 Y131.262 I-10.293 J-5.302 E.08043
G3 X133.607 Y132.33 I-2.406 J-2.172 E.08705
G1 X104.046 Y132.33 E.9806
G1 X104.046 Y119.67 E.41994
G1 X133.607 Y119.67 E.9806
G1 X134.071 Y119.711 E.01546
G1 X134.107 Y119.714 E.00118
G3 X135.504 Y120.347 I-.778 J3.576 E.05127
G3 X136.339 Y121.257 I-2.978 J3.572 E.04108
G3 X137.254 Y122.762 I-13.296 J9.103 E.05845
G1 X136.813 Y122.762 E.0146
G1 X137.555 Y126 E.11019
G1 X137.398 Y126.687 E.02337
; WIPE_START
G1 F15476.087
G1 X136.951 Y128.636 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X138.294 Y127.71 Z18 F30000
G1 Z17.6
G1 E.8 F1800
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F10670
G3 X136.215 Y131.528 I-10.893 J-3.455 E.13441
G3 X134.175 Y132.674 I-2.831 J-2.654 E.07302
G1 X133.624 Y132.722 E.01698
G1 X103.654 Y132.722 E.92091
G1 X103.654 Y119.278 E.41308
G1 X133.624 Y119.278 E.92091
G1 X134.106 Y119.32 E.01485
G1 X134.175 Y119.326 E.00213
G3 X135.741 Y120.033 I-.865 J4.006 E.05318
G3 X136.662 Y121.033 I-3.216 J3.885 E.04191
G3 X138.294 Y124.29 I-9.251 J6.672 E.11241
G1 X153.234 Y124.29 E.45907
G1 X153.234 Y127.71 E.10509
G1 X138.354 Y127.71 E.45723
M204 S10000
; WIPE_START
G1 F12000
G1 X138.005 Y128.545 E-.34372
G1 X137.62 Y129.385 E-.35113
G1 X137.536 Y129.534 E-.06515
; WIPE_END
G1 E-.04 F1800
G1 X137.398 Y128.744 Z18 F30000
G1 Z17.6
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.520534
G1 F10670
G2 X137.398 Y128.847 I-.03 J.052 E.00971
G1 X136.529 Y128.781 F30000
; LINE_WIDTH: 0.3884
G1 F10670
G1 X136.7 Y128.201 E.01703
G1 X133.577 Y131.381 F30000
; LINE_WIDTH: 0.539564
G1 F10670
G1 X104.498 Y131.381 E1.17682
G1 X104.498 Y131.878 E.0201
G1 X133.587 Y131.878 E1.17726
G1 X134.171 Y131.806 E.02381
G1 X134.712 Y131.621 E.02314
; LINE_WIDTH: 0.490479
G1 X135.204 Y131.339 E.02067
G1 X135.607 Y130.988 E.01951
; LINE_WIDTH: 0.440387
G1 X136.009 Y130.514 E.02011
G1 X136.438 Y129.871 E.02504
G1 X136.558 Y129.635 E.00857
G1 X136.391 Y129.54 E.00623
G1 X136.369 Y129.398 E.00465
; LINE_WIDTH: 0.419346
G3 X136.529 Y128.781 I4.398 J.813 E.01956
G1 X136.27 Y129.363 E.01954
G1 X135.803 Y130.138 E.02775
; LINE_WIDTH: 0.439932
G1 X135.453 Y130.545 E.01735
; LINE_WIDTH: 0.467944
G1 X135.017 Y130.926 E.02006
; LINE_WIDTH: 0.5079
G1 X134.578 Y131.172 E.01906
G1 X134.085 Y131.328 E.01962
; LINE_WIDTH: 0.53507
G1 X133.636 Y131.375 E.01808
G1 X137.033 Y125.24 F30000
; LINE_WIDTH: 0.384071
G1 F10670
G1 X137.122 Y125.784 E.01533
; LINE_WIDTH: 0.398349
G1 X137.133 Y125.892 E.00314
; LINE_WIDTH: 0.412257
G1 X137.144 Y126 E.00327
G1 X137.045 Y126.686 E.02087
G1 X136.525 Y123.205 F30000
; LINE_WIDTH: 0.389657
G1 F10670
G1 X136.692 Y123.764 E.01649
G1 X133.577 Y120.619 F30000
; LINE_WIDTH: 0.52551
G1 F10670
G1 X134.105 Y120.677 E.02089
G1 X134.618 Y120.849 E.0213
; LINE_WIDTH: 0.497866
G1 X135.003 Y121.064 E.01632
; LINE_WIDTH: 0.47149
G1 X135.423 Y121.423 E.01931
; LINE_WIDTH: 0.436746
G1 X135.832 Y121.898 E.0201
G3 X136.278 Y122.633 I-15.966 J10.186 E.0276
; LINE_WIDTH: 0.423196
G1 X136.525 Y123.205 E.0193
G1 X136.367 Y122.602 E.0193
G1 X136.425 Y122.414 E.0061
G1 X136.564 Y122.353 E.0047
G1 X136.176 Y121.725 E.02287
; LINE_WIDTH: 0.438883
G1 X135.758 Y121.182 E.02209
; LINE_WIDTH: 0.469256
G1 X135.293 Y120.729 E.02256
; LINE_WIDTH: 0.509181
G1 X134.851 Y120.445 E.01996
G1 X134.24 Y120.213 E.02485
; LINE_WIDTH: 0.539628
G2 X133.577 Y120.122 I-.906 J4.158 E.02713
G1 X104.498 Y120.122 E1.17697
G1 X104.498 Y120.619 E.02011
G1 X133.517 Y120.619 E1.17455
G1 X137.39 Y123.148 F30000
; LINE_WIDTH: 0.507668
G1 F10670
G2 X137.388 Y123.248 I-.029 J.05 E.00908
; WIPE_START
G1 F13555.732
G1 X137.331 Y123.248 E-.18528
G1 X137.302 Y123.198 E-.19157
G1 X137.331 Y123.148 E-.19157
G1 X137.39 Y123.148 E-.19157
; WIPE_END
G1 E-.04 F1800
G1 X144.827 Y124.86 Z18 F30000
G1 X153.026 Y126.748 Z18
G1 Z17.6
G1 E.8 F1800
M204 S2000
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F10670
G1 X152.271 Y127.503 E.03281
G1 X151.738 Y127.503
G1 X153.026 Y126.214 E.05598
G1 X153.026 Y125.681
G1 X151.205 Y127.503 E.07915
G1 X150.672 Y127.503
G1 X153.026 Y125.148 E.10233
G1 X153.026 Y124.615
G1 X150.138 Y127.503 E.1255
G1 X149.605 Y127.503
G1 X152.61 Y124.497 E.1306
G1 X152.077 Y124.497
G1 X149.072 Y127.503 E.1306
G1 X148.538 Y127.503
G1 X151.544 Y124.497 E.1306
G1 X151.011 Y124.497
G1 X148.005 Y127.503 E.1306
G1 X147.472 Y127.503
G1 X150.477 Y124.497 E.1306
G1 X149.944 Y124.497
G1 X146.939 Y127.503 E.1306
G1 X146.405 Y127.503
G1 X149.411 Y124.497 E.1306
G1 X148.877 Y124.497
G1 X145.872 Y127.503 E.1306
G1 X145.339 Y127.503
G1 X148.344 Y124.497 E.1306
G1 X147.811 Y124.497
G1 X144.806 Y127.503 E.1306
G1 X144.272 Y127.503
G1 X147.278 Y124.497 E.1306
G1 X146.744 Y124.497
G1 X143.739 Y127.503 E.1306
G1 X143.206 Y127.503
G1 X146.211 Y124.497 E.1306
G1 X145.678 Y124.497
G1 X142.672 Y127.503 E.1306
G1 X142.139 Y127.503
G1 X145.145 Y124.497 E.1306
G1 X144.611 Y124.497
G1 X141.606 Y127.503 E.1306
G1 X141.073 Y127.503
G1 X144.078 Y124.497 E.1306
G1 X143.545 Y124.497
G1 X140.539 Y127.503 E.1306
G1 X140.006 Y127.503
G1 X143.011 Y124.497 E.1306
G1 X142.478 Y124.497
G1 X139.473 Y127.503 E.1306
G1 X138.94 Y127.503
G1 X141.945 Y124.497 E.1306
G1 X141.412 Y124.497
G1 X138.406 Y127.503 E.1306
G1 X138.01 Y127.899
G1 X137.408 Y128.501 E.02617
G1 X137.31 Y128.066
G1 X140.878 Y124.497 E.15506
G1 X140.345 Y124.497
G1 X137.469 Y127.374 E.12499
G1 X137.627 Y126.682
G1 X139.812 Y124.497 E.09493
G1 X139.279 Y124.497
G1 X137.782 Y125.994 E.06503
G1 X137.683 Y125.56
G1 X138.745 Y124.497 E.04618
G1 X138.212 Y124.497
G1 X137.583 Y125.126 E.02732
G1 X137.484 Y124.692
G1 X138.026 Y124.15 E.02358
G1 X137.891 Y123.752
G1 X137.384 Y124.258 E.022
G1 X137.285 Y123.825
G1 X137.74 Y123.37 E.01975
M204 S10000
G1 X137.865 Y128.342 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.154278
G1 F10670
G1 X137.773 Y128.476 E.00148
; LINE_WIDTH: 0.187113
G1 X137.68 Y128.61 E.00191
G1 X137.561 Y128.637 E.00144
G1 X106.534 Y130.929 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F10670
G1 X108.163 Y130.929 E.05401
G1 X118.021 Y121.071 E.46247
G1 X115.839 Y121.071 E.07239
G1 X125.697 Y130.929 E.46247
G1 X123.515 Y130.929 E.07239
G1 X133.373 Y121.071 E.46247
G1 X131.191 Y121.071 E.07239
G1 X136.714 Y126.594 E.25911
G2 X136.712 Y125.407 I-7.821 J-.584 E.03941
G1 X131.191 Y130.929 E.25904
G1 X133.373 Y130.929 E.07239
G1 X123.515 Y121.071 E.46247
G1 X125.697 Y121.071 E.07239
G1 X115.839 Y130.929 E.46247
G1 X118.021 Y130.929 E.07239
G1 X108.163 Y121.071 E.46247
G1 X110.345 Y121.071 E.07239
G1 X104.394 Y127.022 E.27917
G1 X104.394 Y124.978 E.06779
G1 X110.345 Y130.929 E.27917
G1 X111.973 Y130.929 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 17.8
; LAYER_HEIGHT: 0.199999
; WIPE_START
G1 F15476.087
G1 X110.345 Y130.929 E-.61876
G1 X110.082 Y130.666 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 89/101
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L89
M991 S0 P88 ;notify layer change
G17
G3 Z18 I.225 J1.196 P1  F30000
G1 X137.163 Y125.564 Z18
G1 Z17.8
G1 E.8 F1800
; FEATURE: Inner wall
G1 F8785
G1 X137.175 Y125.67 E.00352
G3 X137.175 Y126.33 I-29.274 J.33 E.02191
G1 X136.97 Y128.11 E.05943
G1 X137.514 Y128.11 E.01805
G3 X136.996 Y129.32 I-12.88 J-4.8 E.04368
G1 X136.495 Y130.205 E.03372
G3 X135.926 Y130.991 I-8.665 J-5.664 E.03222
G1 X135.48 Y131.422 E.02055
G3 X133.607 Y132.102 I-1.953 J-2.456 E.06728
G1 X104.046 Y132.102 E.9806
G1 X104.046 Y119.898 E.40486
G1 X133.607 Y119.898 E.9806
G1 X133.876 Y119.921 E.00896
G1 X134.107 Y119.941 E.00768
G3 X135.48 Y120.578 I-.591 J3.074 E.05073
G1 X135.926 Y121.009 E.02055
G3 X136.848 Y122.413 I-8.006 J6.254 E.05579
G3 X137.514 Y123.89 I-8.331 J4.648 E.0538
G1 X136.97 Y123.89 E.01805
G1 X137.156 Y125.505 E.05392
; WIPE_START
G1 F15476.087
G1 X137.175 Y125.67 E-.06309
G1 X137.175 Y126.33 E-.25094
G1 X137.041 Y127.496 E-.44597
; WIPE_END
G1 E-.04 F1800
G1 X138.257 Y126.582 Z18.2 F30000
G1 Z17.8
G1 E.8 F1800
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F8785
G3 X137.535 Y129.097 I-7.39 J-.76 E.08082
G1 X137.344 Y129.501 E.01372
G1 X136.83 Y130.409 E.03209
G3 X136.215 Y131.258 I-8.877 J-5.786 E.03221
G1 X135.732 Y131.723 E.02059
G3 X133.624 Y132.495 I-2.188 J-2.715 E.07023
G1 X103.654 Y132.495 E.92091
M73 P91 R1
G1 X103.654 Y119.505 E.39912
G1 X133.624 Y119.505 E.92091
G1 X133.91 Y119.531 E.00883
G1 X134.175 Y119.554 E.00815
G3 X135.732 Y120.277 I-.683 J3.509 E.05329
G1 X136.215 Y120.742 E.02059
G3 X137.189 Y122.221 I-8.277 J6.514 E.05449
G3 X138.199 Y124.922 I-7.704 J4.418 E.08901
G1 X138.257 Y125.418 E.01533
G1 X153.234 Y125.418 E.46019
G1 X153.234 Y126.582 E.03578
G1 X138.317 Y126.582 E.45835
M204 S10000
; WIPE_START
G1 F12000
G1 X138.199 Y127.078 E-.19356
G1 X138.02 Y127.841 E-.29797
G1 X137.787 Y128.508 E-.26847
; WIPE_END
G1 E-.04 F1800
G1 X137.453 Y127.658 Z18.2 F30000
G1 Z17.8
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.45191
G1 F8785
G2 X137.444 Y127.746 I-.026 J.042 E.00662
G1 X136.729 Y127.249 F30000
; LINE_WIDTH: 0.403829
G1 F8785
G1 X136.588 Y128.013 E.02287
G1 X133.576 Y131.121 F30000
; LINE_WIDTH: 0.560981
G1 F8785
G1 X104.509 Y131.121 E1.22707
G1 X104.509 Y131.64 E.02188
G1 X133.587 Y131.64 E1.22755
G1 X134.164 Y131.568 E.02456
G1 X134.712 Y131.376 E.02451
G1 X135.177 Y131.091 E.02303
; LINE_WIDTH: 0.502873
G1 X135.689 Y130.61 E.02633
; LINE_WIDTH: 0.460031
G1 X136.144 Y129.994 E.02602
G1 X136.626 Y129.142 E.03329
G3 X136.901 Y128.524 I50.699 J22.214 E.02299
G1 X136.665 Y128.509 E.00803
G1 X136.541 Y128.29 E.00855
; LINE_WIDTH: 0.451375
G1 X136.574 Y128.084 E.00694
G3 X136.264 Y128.943 I-6.708 J-1.937 E.03039
G1 X135.868 Y129.671 E.02759
G1 X135.455 Y130.222 E.02292
; LINE_WIDTH: 0.487027
G1 X135.019 Y130.614 E.02121
; LINE_WIDTH: 0.53622
G1 X134.575 Y130.892 E.02106
G1 X134.071 Y131.067 E.02145
; LINE_WIDTH: 0.557808
G1 X133.635 Y131.115 E.0184
G1 X136.728 Y124.745 F30000
; LINE_WIDTH: 0.404595
G1 F8785
G1 X136.587 Y123.986 E.02278
G1 X133.576 Y120.88 F30000
; LINE_WIDTH: 0.55205
G1 F8785
G1 X134.092 Y120.937 E.02155
G1 X134.576 Y121.11 E.02131
; LINE_WIDTH: 0.526123
G1 X135.008 Y121.377 E.02002
; LINE_WIDTH: 0.49124
G1 X135.403 Y121.722 E.01916
; LINE_WIDTH: 0.454627
G1 X135.819 Y122.255 E.02267
G1 X136.265 Y123.057 E.0308
G3 X136.572 Y123.907 I-8.664 J3.615 E.03034
G1 X136.541 Y123.709 E.00672
G1 X136.665 Y123.49 E.00848
G1 X136.906 Y123.475 E.00808
G2 X135.771 Y121.502 I-7.985 J3.28 E.07659
; LINE_WIDTH: 0.487677
G1 X135.317 Y121.028 E.02377
; LINE_WIDTH: 0.537219
G1 X134.841 Y120.687 E.02361
G1 X134.251 Y120.454 E.02555
; LINE_WIDTH: 0.5616
G2 X133.576 Y120.361 I-.908 J4.095 E.02886
G1 X104.509 Y120.36 E1.22854
G1 X104.509 Y120.879 E.02191
G1 X133.516 Y120.88 E1.226
G1 X137.437 Y124.243 F30000
; LINE_WIDTH: 0.42533
G1 F8785
G1 X137.365 Y124.285 E.00258
G1 X137.426 Y124.32 E.0022
; WIPE_START
G1 F15000
G1 X137.365 Y124.285 E-.34978
G1 X137.437 Y124.243 E-.41022
; WIPE_END
G1 E-.04 F1800
G1 X145.002 Y125.251 Z18.2 F30000
G1 X153.026 Y126.319 Z18.2
G1 Z17.8
G1 E.8 F1800
M204 S2000
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F8785
G1 X152.333 Y125.625 E.03014
G1 X151.799 Y125.625
G1 X152.549 Y126.375 E.03257
G1 X152.016 Y126.375
G1 X151.266 Y125.625 E.03257
G1 X150.733 Y125.625
G1 X151.482 Y126.375 E.03257
G1 X150.949 Y126.375
G1 X150.2 Y125.625 E.03257
G1 X149.666 Y125.625
G1 X150.416 Y126.375 E.03257
G1 X149.883 Y126.375
G1 X149.133 Y125.625 E.03257
G1 X148.6 Y125.625
G1 X149.349 Y126.375 E.03257
G1 X148.816 Y126.375
G1 X148.066 Y125.625 E.03257
G1 X147.533 Y125.625
G1 X148.283 Y126.375 E.03257
G1 X147.75 Y126.375
G1 X147 Y125.625 E.03257
G1 X146.467 Y125.625
G1 X147.216 Y126.375 E.03257
G1 X146.683 Y126.375
G1 X145.933 Y125.625 E.03257
G1 X145.4 Y125.625
G1 X146.15 Y126.375 E.03257
G1 X145.616 Y126.375
G1 X144.867 Y125.625 E.03257
G1 X144.334 Y125.625
G1 X145.083 Y126.375 E.03257
G1 X144.55 Y126.375
G1 X143.8 Y125.625 E.03257
G1 X143.267 Y125.625
G1 X144.017 Y126.375 E.03257
G1 X143.483 Y126.375
G1 X142.734 Y125.625 E.03257
G1 X142.201 Y125.625
G1 X142.95 Y126.375 E.03257
G1 X142.417 Y126.375
G1 X141.667 Y125.625 E.03257
G1 X141.134 Y125.625
G1 X141.884 Y126.375 E.03257
G1 X141.35 Y126.375
G1 X140.601 Y125.625 E.03257
G1 X140.067 Y125.625
G1 X140.817 Y126.375 E.03257
G1 X140.284 Y126.375
G1 X139.534 Y125.625 E.03257
G1 X139.001 Y125.625
G1 X139.751 Y126.375 E.03257
G1 X139.217 Y126.375
G1 X138.468 Y125.625 E.03257
G1 X138.02 Y125.177
G1 X137.394 Y124.552 E.02718
G1 X137.323 Y125.014
G1 X138.684 Y126.375 E.05914
G1 X138.151 Y126.375
G1 X137.392 Y125.617 E.03295
G1 X137.399 Y126.156
G1 X138.025 Y126.782 E.02719
G1 X137.949 Y127.239
G1 X137.361 Y126.652 E.02552
M204 S10000
G1 X104.394 Y123.35 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F8785
G1 X104.394 Y124.978 E.05401
G1 X110.075 Y130.659 E.26648
G1 X108.433 Y130.659 E.05445
G1 X117.75 Y121.342 E.43706
G1 X116.11 Y121.342 E.05441
G1 X125.426 Y130.659 E.43707
G1 X123.785 Y130.659 E.05445
G1 X133.101 Y121.343 E.43703
G1 X131.462 Y121.343 E.05436
G1 X136.785 Y126.666 E.24972
G2 X136.784 Y125.336 I-5.173 J-.659 E.04424
G1 X131.461 Y130.659 E.24971
G1 X133.102 Y130.659 E.05445
G1 X123.786 Y121.342 E.43705
G1 X125.425 Y121.342 E.05438
G1 X116.109 Y130.659 E.43705
G1 X117.75 Y130.659 E.05445
G1 X108.433 Y121.342 E.43708
G1 X110.074 Y121.342 E.05443
G1 X104.394 Y127.022 E.26647
G1 X104.394 Y128.65 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 18
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F15476.087
G1 X104.394 Y127.022 E-.61876
G1 X104.657 Y126.759 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 90/101
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L90
M991 S0 P89 ;notify layer change
G17
G3 Z18.2 I1.212 J-.112 P1  F30000
G1 X104.046 Y120.125 Z18.2
G1 Z18
G1 E.8 F1800
; FEATURE: Inner wall
G1 F8031
G1 X133.681 Y120.131 E.98305
G3 X135.024 Y120.52 I-.087 J2.816 E.04685
G3 X136.318 Y121.855 I-2.271 J3.494 E.06222
G3 X137.58 Y125.03 I-7.682 J4.893 E.11402
G3 X137.231 Y128.27 I-6.351 J.954 E.10928
G3 X136.251 Y130.251 I-10.541 J-3.98 E.07344
G1 X135.902 Y130.733 E.01972
G3 X134.567 Y131.709 I-2.887 J-2.546 E.0553
G3 X133.607 Y131.875 I-.957 J-2.673 E.03247
G1 X104.046 Y131.875 E.9806
G1 X104.046 Y120.185 E.38779
G1 X103.654 Y119.733 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F8031
G1 X133.715 Y119.741 E.92371
G1 X134.175 Y119.781 E.01417
G1 X134.698 Y119.92 E.01662
G1 X135.227 Y120.183 E.01816
G1 X135.732 Y120.547 E.01915
G3 X136.654 Y121.654 I-3.199 J3.601 E.04443
G3 X137.968 Y124.977 I-8.005 J5.088 E.11045
G3 X137.6 Y128.402 I-6.739 J1.007 E.10702
G3 X136.576 Y130.471 I-10.901 J-4.107 E.07105
G1 X136.206 Y130.981 E.01936
G3 X134.706 Y132.078 I-3.216 J-2.823 E.05756
G3 X133.624 Y132.267 I-1.085 J-3.013 E.03392
G1 X103.654 Y132.267 E.92091
G1 X103.654 Y119.793 E.38331
M204 S10000
; WIPE_START
G1 F12000
G1 X105.654 Y119.789 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X104.58 Y127.346 Z18.4 F30000
G1 X104.394 Y128.65 Z18.4
G1 Z18
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F8031
G1 X104.394 Y127.022 E.05401
G1 X109.753 Y121.662 E.25142
G1 X108.754 Y121.662 E.03314
G1 X117.429 Y130.338 E.40697
G1 X116.43 Y130.338 E.03314
G1 X125.105 Y121.662 E.40697
G1 X124.106 Y121.662 E.03314
G1 X132.781 Y130.338 E.40697
G1 X131.782 Y130.338 E.03314
G1 X136.266 Y125.853 E.21036
G3 X136.261 Y126.142 I-1.323 J.121 E.00958
G1 X131.782 Y121.662 E.21013
G1 X132.781 Y121.662 E.03314
G1 X124.106 Y130.338 E.40697
G1 X125.105 Y130.338 E.03314
G1 X116.43 Y121.662 E.40697
G1 X117.429 Y121.662 E.03314
G1 X108.754 Y130.338 E.40697
G1 X109.753 Y130.338 E.03314
G1 X104.394 Y124.978 E.25142
G1 X104.394 Y123.35 E.05401
G1 X133.574 Y130.729 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.419999
G1 F8031
G1 X104.438 Y130.73 E.89525
G1 X104.438 Y131.483 E.02315
G1 X133.59 Y131.483 E.89576
G1 X134.199 Y131.401 E.01889
G1 X134.533 Y131.288 E.01082
; LINE_WIDTH: 0.441565
G1 X134.745 Y131.129 E.00861
; LINE_WIDTH: 0.484695
G1 X134.957 Y130.971 E.00954
; LINE_WIDTH: 0.534589
G2 X135.545 Y130.46 I-1.989 J-2.885 E.03129
; LINE_WIDTH: 0.510925
G1 X135.883 Y130.027 E.02091
; LINE_WIDTH: 0.480539
G1 X136.175 Y129.552 E.01991
G1 X136.657 Y128.57 E.03902
G1 X136.97 Y127.654 E.03451
; LINE_WIDTH: 0.525664
G2 X136.993 Y124.417 I-5.941 J-1.662 E.12883
; LINE_WIDTH: 0.480091
G2 X135.791 Y121.847 I-7.901 J2.131 E.1016
; LINE_WIDTH: 0.513576
G1 X135.338 Y121.337 E.02615
; LINE_WIDTH: 0.549179
G1 X134.888 Y120.996 E.02329
; LINE_WIDTH: 0.542961
G1 X134.743 Y120.889 E.00735
; LINE_WIDTH: 0.493776
G1 X134.598 Y120.781 E.00663
; LINE_WIDTH: 0.420073
G1 X134.453 Y120.674 E.00554
G2 X133.584 Y120.523 I-.821 J2.154 E.02729
G1 X104.438 Y120.517 E.89574
G1 X104.438 Y121.27 E.02316
G1 X133.584 Y121.27 E.89574
G1 X134.083 Y121.328 E.01546
; LINE_WIDTH: 0.444592
G1 X134.258 Y121.365 E.00582
; LINE_WIDTH: 0.493776
G1 X134.432 Y121.401 E.00654
; LINE_WIDTH: 0.547461
G1 X134.606 Y121.438 E.00732
G1 X134.999 Y121.688 E.01916
; LINE_WIDTH: 0.515503
G1 X135.407 Y122.094 E.02218
; LINE_WIDTH: 0.483631
G3 X135.966 Y122.959 I-3.132 J2.636 E.03707
G1 X136.305 Y123.726 E.0301
G1 X136.519 Y124.432 E.02651
; LINE_WIDTH: 0.526849
G3 X136.539 Y127.488 I-6.519 J1.57 E.1216
; LINE_WIDTH: 0.484619
G1 X136.294 Y128.298 E.03046
G3 X135.822 Y129.321 I-12.448 J-5.128 E.04057
G1 X135.517 Y129.761 E.01923
; LINE_WIDTH: 0.512255
G1 X135.015 Y130.299 E.02816
; LINE_WIDTH: 0.544498
G1 X134.578 Y130.575 E.02111
; LINE_WIDTH: 0.53633
G1 X134.406 Y130.609 E.00705
; LINE_WIDTH: 0.489798
G1 X134.234 Y130.643 E.00639
; LINE_WIDTH: 0.426721
G3 X133.633 Y130.723 I-.758 J-3.399 E.01899
G1 X104.815 Y131.106 F30000
; LINE_WIDTH: 0.419328
G1 F8031
G1 X133.574 Y131.106 E.88211
G1 X134.104 Y131.044 E.01639
G1 X134.312 Y130.98 E.00667
G1 X104.815 Y120.894 F30000
; LINE_WIDTH: 0.415805
G1 F8031
G1 X133.584 Y120.897 E.87416
G1 X134.085 Y120.952 E.01533
G1 X134.316 Y121.023 E.00733
; CHANGE_LAYER
; Z_HEIGHT: 18.2
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F15000
G1 X134.085 Y120.952 E-.09169
G1 X133.584 Y120.897 E-.19172
G1 X132.329 Y120.897 E-.4766
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 91/101
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L91
M991 S0 P90 ;notify layer change
G17
G3 Z18.4 I.023 J-1.217 P1  F30000
G1 X104.046 Y120.373 Z18.4
G1 Z18.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F7830
G1 X133.604 Y120.373 E.98051
G1 X134.02 Y120.414 E.01386
G1 X134.096 Y120.421 E.00253
G3 X135.452 Y121.101 I-.815 J3.32 E.05076
G1 X135.902 Y121.592 E.02209
G3 X137.348 Y125.073 I-6.947 J4.926 E.12609
G3 X137.009 Y128.25 I-6.455 J.918 E.10706
G3 X135.902 Y130.408 I-7.873 J-2.675 E.08074
G1 X135.452 Y130.899 E.02209
G3 X133.604 Y131.627 I-1.948 J-2.237 E.06719
G1 X104.046 Y131.627 E.98051
G1 X104.046 Y120.433 E.37132
G1 X103.654 Y119.981 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F7830
G1 X133.623 Y119.981 E.92088
G1 X134.058 Y120.023 E.01342
G1 X134.171 Y120.034 E.00349
G1 X134.704 Y120.191 E.01707
G1 X135.227 Y120.453 E.01796
G3 X135.723 Y120.815 I-2.729 J4.259 E.01889
G1 X136.206 Y121.344 E.02202
G3 X137.736 Y125.02 I-7.246 J5.172 E.12338
G3 X137.378 Y128.382 I-6.846 J.971 E.10496
G3 X136.206 Y130.656 I-8.21 J-2.791 E.0789
G1 X135.723 Y131.185 E.02202
G3 X134.704 Y131.809 I-2.672 J-3.22 E.03684
G1 X134.171 Y131.966 E.01707
G1 X133.623 Y132.019 E.01691
G1 X103.654 Y132.019 E.92088
G1 X103.654 Y120.041 E.36805
M204 S10000
; WIPE_START
G1 F12000
M73 P92 R1
G1 X105.654 Y120.037 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X104.394 Y123.35 Z18.6 F30000
G1 Z18.2
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F7830
G1 X104.394 Y124.978 E.05401
G1 X109.429 Y130.013 E.23618
G1 X109.079 Y130.013 E.01159
G1 X117.102 Y121.989 E.37639
G1 X116.757 Y121.989 E.01145
G1 X124.781 Y130.013 E.37639
G1 X124.431 Y130.013 E.01159
G1 X132.452 Y121.992 E.37627
G1 X132.112 Y121.992 E.01128
G1 X136.029 Y125.909 E.18378
G3 X136.026 Y126.094 I-.894 J.076 E.00613
G1 X132.107 Y130.013 E.18384
G1 X132.456 Y130.013 E.01159
G1 X124.434 Y121.991 E.37633
G1 X124.777 Y121.991 E.01137
G1 X116.755 Y130.013 E.37633
G1 X117.105 Y130.013 E.01159
G1 X109.08 Y121.988 E.37645
G1 X109.428 Y121.988 E.01154
G1 X104.394 Y127.022 E.23614
G1 X104.394 Y128.65 E.05401
G1 X133.565 Y130.404 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.419999
G1 F7830
G1 X104.438 Y130.405 E.89499
G1 X104.438 Y131.235 E.02551
G1 X133.585 Y131.235 E.89561
G1 X134.059 Y131.181 E.01464
G1 X134.447 Y131.06 E.0125
G1 X134.935 Y130.79 E.01714
; LINE_WIDTH: 0.436558
G1 X135.063 Y130.672 E.00559
; LINE_WIDTH: 0.469675
G1 X135.191 Y130.553 E.00606
; LINE_WIDTH: 0.503754
G1 X135.283 Y130.419 E.00611
; LINE_WIDTH: 0.527991
G3 X135.754 Y129.834 I3.381 J2.239 E.02973
G1 X136.052 Y129.357 E.02221
; LINE_WIDTH: 0.514418
G1 X136.436 Y128.55 E.03435
G2 X136.964 Y125.784 I-6.283 J-2.631 E.10899
G2 X136.528 Y123.696 I-7.379 J.451 E.08225
; LINE_WIDTH: 0.492831
G1 X136.237 Y123.008 E.0274
G1 X135.794 Y122.238 E.03254
; LINE_WIDTH: 0.523388
G1 X135.579 Y121.965 E.01362
; LINE_WIDTH: 0.549697
G1 X135.364 Y121.691 E.01436
; LINE_WIDTH: 0.539043
G1 X135.259 Y121.558 E.00685
; LINE_WIDTH: 0.491425
G1 X135.154 Y121.426 E.00619
; LINE_WIDTH: 0.420065
G1 X135.049 Y121.293 E.0052
G1 X134.755 Y121.094 E.01092
G1 X134.202 Y120.861 E.01844
G2 X133.565 Y120.765 I-.882 J3.698 E.01982
G1 X104.438 Y120.765 E.89515
G1 X104.438 Y121.595 E.02551
G1 X133.628 Y121.6 E.89709
G1 X134.132 Y121.671 E.01564
G1 X134.495 Y121.808 E.01191
; LINE_WIDTH: 0.441384
G1 X134.647 Y121.882 E.00549
; LINE_WIDTH: 0.484153
G1 X134.799 Y121.956 E.00608
; LINE_WIDTH: 0.523325
G1 X134.951 Y122.03 E.00662
G1 X135.369 Y122.448 E.02314
G1 X135.661 Y122.893 E.02085
; LINE_WIDTH: 0.501145
G1 X135.833 Y123.184 E.0126
G3 X136.395 Y125.005 I-6.617 J3.039 E.07138
; LINE_WIDTH: 0.523839
G1 X136.473 Y125.794 E.03106
G3 X136.103 Y128.158 I-6.647 J.171 E.09426
; LINE_WIDTH: 0.493476
G1 X135.84 Y128.802 E.02555
G1 X135.414 Y129.495 E.02988
; LINE_WIDTH: 0.534801
G1 X135.003 Y129.933 E.02409
; LINE_WIDTH: 0.533597
G1 X134.839 Y130.016 E.00732
; LINE_WIDTH: 0.488158
G1 X134.676 Y130.099 E.00664
; LINE_WIDTH: 0.423767
G3 X134.06 Y130.351 I-1.421 J-2.594 E.0207
G1 X133.625 Y130.398 E.01359
G1 X104.853 Y130.82 F30000
; LINE_WIDTH: 0.495884
G1 F7830
G1 X133.565 Y130.82 E1.05979
G1 X134.106 Y130.75 E.02014
; LINE_WIDTH: 0.445225
G1 X134.608 Y130.556 E.01762
; LINE_WIDTH: 0.412151
G1 X134.766 Y130.455 E.00565
G1 X104.853 Y121.18 F30000
; LINE_WIDTH: 0.498185
G1 F7830
G1 X133.565 Y121.183 E1.06516
G1 X134.088 Y121.246 E.01956
; LINE_WIDTH: 0.445701
G1 X134.585 Y121.432 E.01742
; LINE_WIDTH: 0.412168
G1 X134.783 Y121.558 E.00705
; CHANGE_LAYER
; Z_HEIGHT: 18.4
; LAYER_HEIGHT: 0.199999
; WIPE_START
G1 F15000
G1 X134.585 Y121.432 E-.76
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 92/101
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L92
M991 S0 P91 ;notify layer change
G17
G3 Z18.6 I.031 J-1.217 P1  F30000
G1 X104.046 Y120.643 Z18.6
G1 Z18.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F7661
G1 X133.604 Y120.643 E.98051
G1 X133.805 Y120.663 E.00669
G1 X134.096 Y120.691 E.00969
G3 X135.452 Y121.426 I-.626 J2.778 E.05182
G3 X135.875 Y121.899 I-2.933 J3.046 E.02106
G3 X137.175 Y126.2 I-6.298 J4.251 E.15131
G3 X135.816 Y130.177 I-7.729 J-.421 E.14122
G3 X134.915 Y130.994 I-3.503 J-2.957 E.04044
G3 X133.604 Y131.357 I-1.404 J-2.524 E.04555
G1 X104.046 Y131.357 E.98051
G1 X104.046 Y120.703 E.35338
G1 X103.654 Y120.251 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F7661
G1 X133.623 Y120.251 E.92088
G1 X133.843 Y120.273 E.00678
G1 X134.171 Y120.305 E.01013
G1 X134.704 Y120.462 E.01707
G3 X135.216 Y120.726 I-2.273 J5.036 E.01773
G1 X135.723 Y121.14 E.02009
G3 X136.197 Y121.673 I-3.309 J3.419 E.02195
G3 X137.567 Y125.79 I-6.793 J4.548 E.13493
G3 X136.646 Y129.571 I-7.935 J.069 E.1208
G3 X135.723 Y130.86 I-4.331 J-2.127 E.04895
G1 X135.216 Y131.274 E.02009
G3 X134.171 Y131.695 I-1.909 J-3.227 E.03477
G1 X133.623 Y131.749 E.01691
G1 X103.654 Y131.749 E.92088
G1 X103.654 Y120.311 E.35144
M204 S10000
; WIPE_START
G1 F12000
G1 X105.654 Y120.307 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X104.514 Y127.854 Z18.8 F30000
G1 X104.394 Y128.65 Z18.8
G1 Z18.4
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F7661
G1 X104.394 Y127.022 E.05401
G1 X109.055 Y122.361 E.21865
G1 X109.453 Y122.361 E.01319
G1 X116.731 Y129.639 E.34144
G1 X117.129 Y129.639 E.01319
G1 X124.407 Y122.361 E.34144
G1 X124.805 Y122.361 E.01319
G1 X132.083 Y129.639 E.34144
G1 X132.481 Y129.639 E.01319
G1 X135.77 Y126.35 E.15431
G2 X135.77 Y125.65 I-2.89 J-.35 E.02326
G1 X132.481 Y122.361 E.15431
G1 X132.083 Y122.361 E.01319
G1 X124.805 Y129.639 E.34144
G1 X124.407 Y129.639 E.01319
G1 X117.129 Y122.361 E.34144
G1 X116.731 Y122.361 E.01319
G1 X109.453 Y129.639 E.34144
G1 X109.055 Y129.639 E.01319
G1 X104.394 Y124.978 E.21865
G1 X104.394 Y123.35 E.05401
G1 X133.563 Y130.031 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.42002
G1 F7661
G1 X104.438 Y130.031 E.89496
G1 X104.438 Y130.964 E.02868
G1 X133.585 Y130.964 E.89566
G1 X134.063 Y130.909 E.01479
G1 X134.456 Y130.784 E.01267
G1 X134.896 Y130.523 E.01572
G1 X135.356 Y130.099 E.01923
G1 X135.516 Y129.909 E.00764
; LINE_WIDTH: 0.452908
G1 X135.565 Y129.791 E.00426
; LINE_WIDTH: 0.498601
G1 X135.613 Y129.673 E.00473
; LINE_WIDTH: 0.531895
G1 X135.662 Y129.555 E.00508
G2 X136.707 Y126.486 I-5.653 J-3.637 E.13046
G2 X136.444 Y124.142 I-6.388 J-.471 E.09453
; LINE_WIDTH: 0.518894
G2 X135.946 Y122.915 I-7.373 J2.279 E.05143
; LINE_WIDTH: 0.549522
G1 X135.69 Y122.498 E.02019
; LINE_WIDTH: 0.542312
G1 X135.627 Y122.354 E.00638
; LINE_WIDTH: 0.493387
G1 X135.563 Y122.211 E.00576
; LINE_WIDTH: 0.42006
G1 X135.5 Y122.067 E.00482
G2 X134.372 Y121.181 I-2.249 J1.703 E.04458
G2 X133.563 Y121.036 I-.818 J2.223 E.02539
G1 X104.438 Y121.036 E.89506
G1 X104.438 Y121.969 E.02868
G1 X133.576 Y121.969 E.89546
G3 X134.496 Y122.205 I-.373 J3.363 E.02929
G1 X134.912 Y122.489 E.01549
; LINE_WIDTH: 0.444462
G1 X135.029 Y122.592 E.00511
; LINE_WIDTH: 0.493387
G1 X135.146 Y122.695 E.00573
; LINE_WIDTH: 0.547532
G1 X135.263 Y122.799 E.00642
G1 X135.506 Y123.129 E.01684
; LINE_WIDTH: 0.520631
G1 X135.839 Y123.817 E.02979
G3 X135.854 Y128.143 I-5.929 J2.183 E.17185
G1 X135.429 Y128.996 E.03711
; LINE_WIDTH: 0.553014
G1 X135.243 Y129.242 E.01281
; LINE_WIDTH: 0.542617
G1 X135.058 Y129.384 E.00952
; LINE_WIDTH: 0.49357
G1 X134.872 Y129.527 E.00859
; LINE_WIDTH: 0.424181
G3 X133.622 Y130.023 I-1.341 J-1.555 E.04258
G1 X104.905 Y130.498 F30000
; LINE_WIDTH: 0.599211
G1 F7661
G1 X133.563 Y130.498 E1.29908
G1 X134.1 Y130.423 E.02461
; LINE_WIDTH: 0.559174
G1 X134.537 Y130.251 E.01975
; LINE_WIDTH: 0.518222
G1 X134.719 Y130.117 E.00875
; LINE_WIDTH: 0.473398
G1 X134.901 Y129.983 E.00793
; LINE_WIDTH: 0.428574
G1 X135.083 Y129.849 E.0071
; LINE_WIDTH: 0.398286
G1 X135.145 Y129.788 E.00252
G1 X104.905 Y121.502 F30000
; LINE_WIDTH: 0.598998
G1 F7661
G1 X133.563 Y121.502 E1.29859
G1 X134.061 Y121.571 E.02279
; LINE_WIDTH: 0.56657
G1 X134.537 Y121.75 E.02168
; LINE_WIDTH: 0.523112
G1 X134.72 Y121.874 E.00868
; LINE_WIDTH: 0.482759
G1 X134.904 Y121.998 E.00795
; LINE_WIDTH: 0.443942
G1 X135.046 Y122.132 E.00637
; LINE_WIDTH: 0.406662
G1 X135.187 Y122.267 E.00578
; CHANGE_LAYER
; Z_HEIGHT: 18.6
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F15000
G1 X135.046 Y122.132 E-.76
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 93/101
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L93
M991 S0 P92 ;notify layer change
G17
G3 Z18.8 I.048 J-1.216 P1  F30000
G1 X104.046 Y120.914 Z18.8
G1 Z18.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8371
G1 X133.617 Y120.915 E.98093
G1 X134.083 Y120.964 E.01554
G1 X134.535 Y121.115 E.0158
G1 X134.994 Y121.376 E.01752
G1 X135.435 Y121.736 E.0189
G1 X135.875 Y122.296 E.02361
G3 X136.565 Y123.791 I-6.653 J3.974 E.05471
G3 X136.565 Y128.209 I-6.372 J2.209 E.14934
G3 X135.875 Y129.705 I-7.341 J-2.479 E.05472
G1 X135.443 Y130.255 E.02321
G1 X134.993 Y130.625 E.01931
G1 X134.535 Y130.885 E.01749
G1 X134.083 Y131.036 E.0158
G1 X133.602 Y131.086 E.01603
G1 X104.046 Y131.086 E.98044
G1 X104.046 Y120.974 E.33544
G1 X103.654 Y120.522 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F8371
G1 X133.637 Y120.523 E.92131
G1 X134.166 Y120.578 E.01635
G1 X134.695 Y120.755 E.01713
G1 X135.216 Y121.051 E.01842
G1 X135.717 Y121.46 E.01985
G1 X136.197 Y122.07 E.02387
G3 X136.663 Y122.934 I-5.285 J3.41 E.03019
G3 X137.329 Y126.156 I-7.497 J3.229 E.10178
G3 X136.197 Y129.93 I-7.746 J-.267 E.12242
G1 X135.725 Y130.531 E.02348
G1 X135.216 Y130.949 E.02024
G1 X134.695 Y131.245 E.01841
G1 X134.166 Y131.422 E.01713
G1 X133.623 Y131.478 E.0168
G1 X103.654 Y131.478 E.92086
G1 X103.654 Y120.582 E.33482
M204 S10000
; WIPE_START
G1 F12000
G1 X105.654 Y120.578 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X104.394 Y123.35 Z19 F30000
G1 Z18.6
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F8371
G1 X104.394 Y124.978 E.05401
G1 X108.658 Y129.242 E.20004
G1 X109.849 Y129.242 E.03951
G1 X116.333 Y122.759 E.30414
G1 X117.527 Y122.759 E.03963
G1 X124.01 Y129.242 E.30413
G1 X125.201 Y129.242 E.03951
G1 X131.682 Y122.761 E.30404
G1 X132.881 Y122.762 E.03977
G1 X135.484 Y125.364 E.12208
G3 X135.484 Y126.636 I-7.398 J.635 E.04225
G1 X132.877 Y129.242 E.12227
G1 X131.686 Y129.242 E.03951
G1 X125.204 Y122.761 E.30408
G1 X124.007 Y122.76 E.0397
G1 X117.525 Y129.242 E.30409
G1 X116.334 Y129.242 E.03951
G1 X109.85 Y122.758 E.30418
G1 X108.658 Y122.758 E.03956
G1 X104.394 Y127.022 E.20001
G1 X104.394 Y128.65 E.05401
G1 X133.569 Y122.01 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.401244
G1 F8371
G1 X133.854 Y122.028 E.00833
; LINE_WIDTH: 0.432695
G1 X134.138 Y122.047 E.00906
; LINE_WIDTH: 0.472269
G1 X134.21 Y122.051 E.00251
; LINE_WIDTH: 0.519967
G1 X134.282 Y122.055 E.00279
; LINE_WIDTH: 0.567665
G1 X134.354 Y122.059 E.00307
; LINE_WIDTH: 0.615363
G1 X134.425 Y122.063 E.00335
; LINE_WIDTH: 0.61649
G1 X134.373 Y122.012 E.00344
; LINE_WIDTH: 0.571044
G1 X134.32 Y121.961 E.00316
; LINE_WIDTH: 0.525599
G1 X134.267 Y121.909 E.00289
; LINE_WIDTH: 0.480154
G1 X134.215 Y121.858 E.00262
; LINE_WIDTH: 0.434708
G1 X134.162 Y121.807 E.00235
; LINE_WIDTH: 0.384755
G1 X134.109 Y121.755 E.00205
G1 X133.569 Y121.667 E.01525
G1 X104.797 Y121.665 E.80145
G1 X104.797 Y122.006 E.0095
G1 X133.509 Y122.01 E.79977
G1 X134.425 Y122.063 F30000
; LINE_WIDTH: 0.623179
G1 F8371
G1 X134.626 Y122.198 E.01145
; LINE_WIDTH: 0.591113
G1 X134.827 Y122.333 E.01081
; LINE_WIDTH: 0.556075
G1 X134.951 Y122.459 E.00737
; LINE_WIDTH: 0.518063
M73 P93 R1
G1 X135.074 Y122.585 E.00682
; LINE_WIDTH: 0.480052
G1 X135.197 Y122.71 E.00627
; LINE_WIDTH: 0.43967
G1 X135.409 Y123.056 E.0131
; LINE_WIDTH: 0.396918
G1 X135.622 Y123.401 E.01169
; LINE_WIDTH: 0.359005
G1 X135.773 Y123.763 E.0101
; LINE_WIDTH: 0.306962
G1 X135.924 Y124.125 E.00844
G3 X136.203 Y125.488 I-5.33 J1.803 E.03001
; LINE_WIDTH: 0.296509
G3 X136.113 Y127.171 I-7.293 J.452 E.03492
G1 X135.924 Y127.875 E.01506
; LINE_WIDTH: 0.331669
G1 X135.632 Y128.604 E.01846
; LINE_WIDTH: 0.378
G1 X135.433 Y128.921 E.01024
; LINE_WIDTH: 0.4273
G1 X135.234 Y129.239 E.01174
; LINE_WIDTH: 0.471956
G1 X135.101 Y129.38 E.00676
; LINE_WIDTH: 0.511968
G1 X134.968 Y129.52 E.00739
; LINE_WIDTH: 0.55198
G1 X134.835 Y129.661 E.00802
; LINE_WIDTH: 0.588986
G1 X134.645 Y129.788 E.0102
; LINE_WIDTH: 0.622986
G1 X134.454 Y129.915 E.01084
G1 X133.554 Y129.634 F30000
; LINE_WIDTH: 0.419999
G1 F8371
G1 X104.438 Y129.635 E.89467
G1 X104.438 Y130.694 E.03256
G1 X133.582 Y130.694 E.89551
G1 X134.055 Y130.632 E.01466
G1 X134.541 Y130.431 E.01618
G2 X135.546 Y129.489 I-1.432 J-2.535 E.0427
G1 X135.946 Y128.745 E.02596
G2 X136.522 Y126.538 I-7.569 J-3.156 E.07034
G1 X136.523 Y125.488 E.03226
G2 X136.058 Y123.559 I-7.619 J.815 E.06113
G1 X135.934 Y123.233 E.01071
G1 X135.546 Y122.511 E.02518
G1 X135.154 Y122.012 E.0195
G1 X134.736 Y121.68 E.0164
G1 X134.236 Y121.429 E.01719
G2 X133.569 Y121.307 I-.657 J1.72 E.02096
G1 X104.438 Y121.306 E.89511
G1 X104.438 Y122.365 E.03256
G1 X133.608 Y122.37 E.89632
G1 X134.064 Y122.434 E.01414
G1 X134.451 Y122.615 E.01311
G1 X134.873 Y122.949 E.01655
G1 X135.067 Y123.17 E.00906
G1 X135.473 Y123.841 E.02407
G1 X135.743 Y124.564 E.02371
G3 X135.748 Y127.417 I-6.382 J1.439 E.08838
G1 X135.492 Y128.119 E.02295
G1 X135.304 Y128.483 E.0126
G1 X134.918 Y129.006 E.01997
G1 X134.468 Y129.375 E.01789
G1 X134.035 Y129.574 E.01463
G1 X133.614 Y129.626 E.01305
G1 X133.554 Y129.993 F30000
; LINE_WIDTH: 0.384229
G1 F8371
G1 X104.797 Y129.994 E.79981
G1 X104.797 Y130.335 E.00949
G1 X133.563 Y130.335 E.80006
G1 X134.086 Y130.25 E.01472
; LINE_WIDTH: 0.392884
G1 X134.139 Y130.2 E.00208
; LINE_WIDTH: 0.437812
G1 X134.192 Y130.15 E.00235
; LINE_WIDTH: 0.48274
G1 X134.245 Y130.099 E.00262
; LINE_WIDTH: 0.527667
G1 X134.298 Y130.049 E.00289
; LINE_WIDTH: 0.572595
G1 X134.351 Y129.999 E.00315
; LINE_WIDTH: 0.617523
G1 X134.404 Y129.948 E.00342
; LINE_WIDTH: 0.618177
G1 X134.341 Y129.948 E.00297
; LINE_WIDTH: 0.574557
G1 X134.277 Y129.948 E.00275
; LINE_WIDTH: 0.530938
G1 X134.214 Y129.948 E.00252
; LINE_WIDTH: 0.487318
G1 X134.15 Y129.948 E.0023
; LINE_WIDTH: 0.443699
G1 X134.087 Y129.948 E.00207
; LINE_WIDTH: 0.40236
G1 X133.614 Y129.99 E.01389
; CHANGE_LAYER
; Z_HEIGHT: 18.8
; LAYER_HEIGHT: 0.199999
; WIPE_START
G1 F15000
G1 X134.087 Y129.948 E-.76
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 94/101
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L94
M991 S0 P93 ;notify layer change
G17
G3 Z19 I.339 J-1.169 P1  F30000
G1 X104.046 Y121.235 Z19
G1 Z18.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8257
G1 X133.6 Y121.235 E.98038
G1 X133.887 Y121.267 E.00955
G1 X134.081 Y121.288 E.0065
G1 X134.535 Y121.44 E.01586
G1 X134.974 Y121.689 E.01677
G1 X135.421 Y122.113 E.02043
G3 X136.348 Y123.828 I-3.962 J3.251 E.06506
G3 X135.848 Y129.305 I-6.633 J2.155 E.18755
G3 X134.974 Y130.311 I-3.683 J-2.317 E.04435
G1 X134.535 Y130.56 E.01677
G1 X134.081 Y130.712 E.01586
G1 X133.6 Y130.765 E.01605
G1 X104.046 Y130.765 E.98038
G1 X104.046 Y121.295 E.31414
G1 X103.654 Y120.843 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F8257
G1 X133.622 Y120.843 E.92084
G1 X133.93 Y120.877 E.00951
G1 X134.166 Y120.903 E.0073
G1 X134.695 Y121.08 E.01715
G1 X135.21 Y121.372 E.01818
G1 X135.712 Y121.849 E.02127
G3 X136.639 Y123.482 I-4.007 J3.354 E.05801
G1 X136.722 Y123.709 E.00745
G3 X136.187 Y129.502 I-7.018 J2.273 E.18376
G3 X135.21 Y130.628 I-4.089 J-2.564 E.046
G1 X134.695 Y130.92 E.01818
G1 X134.166 Y131.097 E.01715
G1 X133.622 Y131.157 E.01681
G1 X103.654 Y131.157 E.92084
G1 X103.654 Y120.903 E.31508
M204 S10000
; WIPE_START
G1 F12000
G1 X105.654 Y120.899 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X111.949 Y123.229 Z19.2 F30000
G1 Z18.8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F8257
G1 X110.321 Y123.229 E.05401
G1 X115.862 Y128.771 E.25995
G1 X117.997 Y128.771 E.07081
G1 X123.538 Y123.229 E.25995
G1 X125.673 Y123.229 E.07081
G1 X131.214 Y128.771 E.25995
G1 X133.349 Y128.771 E.07081
G1 X135.092 Y127.028 E.08176
G2 X135.092 Y124.972 I-3.741 J-1.028 E.06902
G1 X133.349 Y123.229 E.08176
G1 X131.214 Y123.229 E.07081
G1 X125.673 Y128.771 E.25995
G1 X123.538 Y128.771 E.07081
G1 X117.997 Y123.229 E.25995
G1 X115.862 Y123.229 E.07081
G1 X110.321 Y128.771 E.25995
G1 X108.186 Y128.771 E.07081
G1 X104.394 Y124.978 E.17791
G1 X104.394 Y127.022 E.06779
G1 X108.186 Y123.229 E.17791
G1 X106.558 Y123.229 E.05401
G1 X133.545 Y122.44 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.450791
G1 F8257
G1 X134.043 Y122.516 E.01672
; LINE_WIDTH: 0.425445
G1 X134.295 Y122.638 E.00872
; LINE_WIDTH: 0.392174
G1 X134.547 Y122.76 E.00796
; LINE_WIDTH: 0.399302
G1 X134.613 Y122.776 E.00197
; LINE_WIDTH: 0.44683
G1 X134.679 Y122.793 E.00224
; LINE_WIDTH: 0.494358
G1 X134.745 Y122.809 E.0025
; LINE_WIDTH: 0.536272
G1 X134.801 Y122.838 E.00254
; LINE_WIDTH: 0.572572
G1 X134.857 Y122.867 E.00273
; LINE_WIDTH: 0.608872
G1 X134.914 Y122.896 E.00292
; LINE_WIDTH: 0.606065
G1 X134.883 Y122.828 E.00342
; LINE_WIDTH: 0.564151
G1 X134.853 Y122.76 E.00316
; LINE_WIDTH: 0.522237
G1 X134.822 Y122.692 E.00291
; LINE_WIDTH: 0.480323
G1 X134.792 Y122.624 E.00265
; LINE_WIDTH: 0.438409
G1 X134.761 Y122.556 E.0024
; LINE_WIDTH: 0.399342
G1 X134.731 Y122.488 E.00216
G1 X134.367 Y122.231 E.01293
; LINE_WIDTH: 0.459355
G1 X133.889 Y122.061 E.01723
G1 X133.545 Y122.024 E.01171
G1 X104.835 Y122.024 E.97427
G1 X104.835 Y122.44 E.01414
G1 X133.485 Y122.44 E.97224
G1 X134.914 Y122.896 F30000
; LINE_WIDTH: 0.602087
G1 F8257
G1 X135.058 Y123.077 E.01056
; LINE_WIDTH: 0.552216
G1 X135.202 Y123.259 E.00961
; LINE_WIDTH: 0.505684
G1 X135.336 Y123.5 E.01042
; LINE_WIDTH: 0.462491
G1 X135.47 Y123.742 E.00945
; LINE_WIDTH: 0.425231
G1 X135.596 Y124.073 E.01105
; LINE_WIDTH: 0.376803
G1 X135.722 Y124.405 E.00965
G1 X135.9 Y125.201 E.02218
; LINE_WIDTH: 0.367685
G1 X135.959 Y125.92 E.0191
G1 X135.928 Y126.561 E.01698
G1 X135.793 Y127.337 E.02084
; LINE_WIDTH: 0.411106
G1 X135.609 Y127.929 E.01863
; LINE_WIDTH: 0.452362
G1 X135.471 Y128.229 E.011
; LINE_WIDTH: 0.486238
G1 X135.334 Y128.528 E.01191
; LINE_WIDTH: 0.521877
G1 X135.218 Y128.698 E.00804
; LINE_WIDTH: 0.559277
G1 X135.101 Y128.868 E.00866
; LINE_WIDTH: 0.596678
G1 X134.985 Y129.038 E.00929
; LINE_WIDTH: 0.627619
G1 X134.884 Y129.152 E.00724
G1 X133.545 Y129.162 F30000
; LINE_WIDTH: 0.419999
G1 F8257
G1 X104.438 Y129.163 E.89439
G1 X104.438 Y130.373 E.03719
G1 X133.579 Y130.373 E.89542
G1 X134.058 Y130.306 E.01487
G1 X134.515 Y130.121 E.01516
G1 X134.789 Y129.946 E.00999
G2 X135.4 Y129.27 I-1.942 J-2.366 E.0281
G1 X135.713 Y128.709 E.01974
G2 X136.278 Y126.596 I-6.58 J-2.893 E.06747
G2 X136.151 Y124.612 I-7.169 J-.536 E.06129
G1 X135.914 Y123.791 E.02625
G2 X135.48 Y122.855 I-11.075 J4.569 E.0317
G1 X135.128 Y122.376 E.01828
G1 X134.739 Y122.007 E.01648
G1 X134.259 Y121.761 E.01656
G2 X133.545 Y121.627 I-.721 J1.873 E.02245
G1 X104.438 Y121.627 E.89439
G1 X104.438 Y122.837 E.03719
G1 X133.564 Y122.837 E.89495
G1 X134.035 Y122.915 E.01467
G1 X134.45 Y123.117 E.01419
G1 X134.821 Y123.473 E.0158
G1 X135.118 Y123.903 E.01606
G1 X135.395 Y124.546 E.02151
G1 X135.561 Y125.276 E.02301
G1 X135.613 Y125.946 E.02064
G1 X135.577 Y126.535 E.01815
G1 X135.442 Y127.259 E.02262
G3 X135.102 Y128.125 I-6.202 J-1.93 E.02861
G1 X134.834 Y128.514 E.01452
G1 X134.479 Y128.862 E.01527
G1 X134.016 Y129.092 E.0159
G1 X133.605 Y129.153 E.01277
G1 X133.545 Y129.559 F30000
; LINE_WIDTH: 0.459479
G1 F8257
G1 X104.835 Y129.56 E.97456
G1 X104.835 Y129.976 E.01414
G1 X133.545 Y129.976 E.97456
G2 X134.53 Y129.673 I-.126 J-2.16 E.03531
; LINE_WIDTH: 0.437894
G1 X134.597 Y129.583 E.0036
; LINE_WIDTH: 0.476259
G1 X134.663 Y129.493 E.00395
; LINE_WIDTH: 0.514623
G1 X134.73 Y129.403 E.0043
; LINE_WIDTH: 0.552988
G1 X134.796 Y129.313 E.00465
; LINE_WIDTH: 0.589093
G1 X134.821 Y129.255 E.0028
; LINE_WIDTH: 0.622938
G1 X134.845 Y129.197 E.00298
; LINE_WIDTH: 0.617745
G1 X134.739 Y129.232 E.00522
; LINE_WIDTH: 0.573516
G1 X134.633 Y129.266 E.00482
; LINE_WIDTH: 0.529286
G1 X134.527 Y129.301 E.00442
; LINE_WIDTH: 0.485056
G1 X134.421 Y129.335 E.00402
; LINE_WIDTH: 0.442333
G2 X134.07 Y129.476 I.551 J1.873 E.01232
G1 X133.605 Y129.553 E.01535
; CHANGE_LAYER
; Z_HEIGHT: 19
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F15000
G1 X134.07 Y129.476 E-.42198
G1 X134.421 Y129.335 E-.33802
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 95/101
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L95
M991 S0 P94 ;notify layer change
G17
G3 Z19.2 I.302 J-1.179 P1  F30000
G1 X104.046 Y121.56 Z19.2
G1 Z19
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8062
G1 X133.645 Y121.565 E.98186
G1 X134.081 Y121.613 E.01456
G3 X134.959 Y122.07 I-.722 J2.457 E.03304
G1 X135.386 Y122.482 E.01966
G1 X135.833 Y123.169 E.02721
G3 X135.833 Y128.831 I-6.071 J2.831 E.1939
G1 X135.358 Y129.55 E.02859
G1 X134.959 Y129.93 E.01827
G1 X134.503 Y130.231 E.01815
G3 X133.6 Y130.44 I-.918 J-1.912 E.03097
G1 X104.046 Y130.44 E.98038
G1 X104.046 Y121.62 E.29259
G1 X103.654 Y121.168 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F8062
G1 X133.688 Y121.175 E.92287
G1 X134.166 Y121.228 E.01477
G3 X135.204 Y121.762 I-.837 J2.901 E.03612
G1 X135.699 Y122.245 E.02124
G1 X136.182 Y122.987 E.02721
G3 X136.182 Y129.013 I-6.436 J3.013 E.19119
G1 X135.642 Y129.821 E.02989
G1 X135.204 Y130.238 E.01856
G1 X134.684 Y130.582 E.01917
G3 X133.622 Y130.832 I-1.105 J-2.306 E.03379
G1 X103.654 Y130.832 E.92084
G1 X103.654 Y121.228 E.29512
M204 S10000
; WIPE_START
G1 F12000
G1 X105.654 Y121.224 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X104.408 Y127.246 Z19.4 F30000
G1 Z19
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.38292
G1 F8062
G1 X104.408 Y123.606 E.10086
G1 X133.54 Y129.087 F30000
; LINE_WIDTH: 0.557368
G1 F8062
G1 X104.883 Y129.088 E1.20131
G1 X104.883 Y129.603 E.02155
G1 X133.54 Y129.602 E1.20131
G1 X133.917 Y129.553 E.01592
; LINE_WIDTH: 0.546176
G1 X134.15 Y129.445 E.01055
; LINE_WIDTH: 0.518182
G1 X134.384 Y129.338 E.00996
; LINE_WIDTH: 0.480325
G1 X134.774 Y129.014 E.01808
; LINE_WIDTH: 0.438716
G1 X134.959 Y128.763 E.01004
; LINE_WIDTH: 0.403216
G1 X135.143 Y128.512 E.00914
; LINE_WIDTH: 0.408806
G1 X135.155 Y128.425 E.00264
; LINE_WIDTH: 0.455486
G1 X135.166 Y128.337 E.00297
; LINE_WIDTH: 0.502166
G1 X135.178 Y128.249 E.00331
; LINE_WIDTH: 0.548846
G1 X135.189 Y128.162 E.00365
; LINE_WIDTH: 0.595526
G1 X135.201 Y128.074 E.00398
G1 X135.135 Y128.121 E.00367
; LINE_WIDTH: 0.548846
G1 X135.068 Y128.168 E.00336
; LINE_WIDTH: 0.502166
G1 X135.001 Y128.215 E.00305
; LINE_WIDTH: 0.455486
G1 X134.935 Y128.262 E.00274
; LINE_WIDTH: 0.419364
G1 X134.868 Y128.308 E.0025
G1 X134.506 Y128.705 E.01646
; LINE_WIDTH: 0.474354
G1 X134.278 Y128.844 E.0094
; LINE_WIDTH: 0.510132
G1 X134.05 Y128.983 E.01018
; LINE_WIDTH: 0.542318
G1 X133.599 Y129.079 E.01875
G1 X133.54 Y128.641 F30000
; LINE_WIDTH: 0.419897
G1 F8062
G1 X104.438 Y128.643 E.89398
G1 X104.438 Y130.048 E.04317
G1 X133.579 Y130.048 E.89517
G1 X134.072 Y129.973 E.01531
G2 X135.163 Y129.141 I-.938 J-2.364 E.04268
G1 X135.483 Y128.649 E.01804
G2 X135.502 Y123.399 I-5.696 J-2.646 E.16639
G1 X135.158 Y122.852 E.01985
G1 X134.769 Y122.432 E.01759
G1 X134.321 Y122.119 E.01678
G1 X134.044 Y122.027 E.00898
G1 X133.545 Y121.957 E.01547
G1 X104.438 Y121.952 E.89414
G3 X104.408 Y123.546 I-18.004 J.465 E.04898
G1 X104.568 Y123.36 E.0075
G1 X133.548 Y123.357 E.89025
G1 X133.993 Y123.451 E.01395
G1 X134.418 Y123.715 E.01537
G1 X134.764 Y124.126 E.0165
G1 X135.001 Y124.6 E.0163
G1 X135.204 Y125.281 E.02182
G1 X135.267 Y125.979 E.02153
G1 X135.221 Y126.587 E.01873
G3 X134.764 Y127.874 I-5.171 J-1.112 E.04209
G1 X134.418 Y128.285 E.0165
G1 X133.961 Y128.561 E.01639
G1 X133.599 Y128.63 E.01132
G1 X135.214 Y123.953 F30000
; LINE_WIDTH: 0.596624
G1 F8062
G1 X135.318 Y124.214 E.01266
; LINE_WIDTH: 0.559764
G1 X135.421 Y124.475 E.01181
; LINE_WIDTH: 0.525797
G1 X135.507 Y124.82 E.01399
; LINE_WIDTH: 0.477348
G1 X135.594 Y125.165 E.01259
G1 X135.666 Y125.945 E.02776
G1 X135.628 Y126.619 E.02389
; LINE_WIDTH: 0.495375
G1 X135.561 Y126.948 E.01237
; LINE_WIDTH: 0.524292
G1 X135.494 Y127.277 E.01316
; LINE_WIDTH: 0.554712
G1 X135.389 Y127.584 E.01355
; LINE_WIDTH: 0.593882
G3 X135.226 Y128.019 I-2.385 J-.644 E.02088
G1 X133.545 Y122.913 F30000
; LINE_WIDTH: 0.544213
G1 F8062
G1 X134.015 Y123.002 E.01954
; LINE_WIDTH: 0.514658
G1 X134.261 Y123.15 E.01104
; LINE_WIDTH: 0.476156
G1 X134.508 Y123.297 E.01014
; LINE_WIDTH: 0.438741
G1 X134.694 Y123.502 E.00893
; LINE_WIDTH: 0.402414
G1 X134.88 Y123.707 E.00811
; LINE_WIDTH: 0.407331
G1 X134.947 Y123.756 E.00246
; LINE_WIDTH: 0.453492
G1 X135.014 Y123.805 E.00278
; LINE_WIDTH: 0.499652
G1 X135.081 Y123.855 E.00309
; LINE_WIDTH: 0.545813
G1 X135.147 Y123.904 E.0034
; LINE_WIDTH: 0.591974
G1 X135.214 Y123.953 E.00371
G1 X135.202 Y123.863 E.00406
; LINE_WIDTH: 0.545813
G1 X135.19 Y123.774 E.00372
; LINE_WIDTH: 0.499652
G1 X135.178 Y123.684 E.00338
; LINE_WIDTH: 0.453492
G1 X135.166 Y123.594 E.00303
; LINE_WIDTH: 0.411344
G1 X135.154 Y123.504 E.00272
G1 X134.834 Y123.063 E.01636
; LINE_WIDTH: 0.455305
G1 X134.65 Y122.891 E.00846
; LINE_WIDTH: 0.486369
G1 X134.465 Y122.72 E.0091
; LINE_WIDTH: 0.514725
G1 X134.244 Y122.599 E.00969
; LINE_WIDTH: 0.555641
G1 X134.023 Y122.479 E.01053
G1 X133.545 Y122.401 E.02023
G1 X104.883 Y122.398 E1.19748
G1 X104.883 Y122.912 E.02148
G1 X133.485 Y122.913 E1.19497
M73 P94 R1
G1 X132.323 Y123.749 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F8062
G1 X130.695 Y123.749 E.05401
G1 X126.193 Y128.251 E.21119
G1 X123.019 Y128.251 E.1053
G1 X118.517 Y123.749 E.21119
G1 X115.343 Y123.749 E.1053
G1 X110.841 Y128.251 E.21119
G1 X107.667 Y128.251 E.1053
G1 X104.771 Y125.355 E.13584
G1 X104.771 Y126.645 E.04277
G1 X107.667 Y123.749 E.13584
G1 X110.841 Y123.749 E.1053
G1 X115.343 Y128.251 E.21119
G1 X118.517 Y128.251 E.1053
G1 X123.019 Y123.749 E.21119
G1 X126.193 Y123.749 E.1053
G1 X130.695 Y128.251 E.21119
G1 X132.323 Y128.251 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 19.2
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F15476.087
G1 X130.695 Y128.251 E-.61876
G1 X130.432 Y127.988 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 96/101
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L96
M991 S0 P95 ;notify layer change
G17
G3 Z19.4 I.272 J-1.186 P1  F30000
G1 X104.046 Y121.933 Z19.4
G1 Z19.2
G1 E.8 F1800
; FEATURE: Inner wall
G1 F15476.087
G1 X133.595 Y121.933 E.9802
G1 X133.905 Y121.973 E.01038
G1 X134.061 Y121.993 E.00522
G1 X134.503 Y122.165 E.01571
G1 X134.913 Y122.437 E.01632
G1 X135.386 Y122.979 E.02387
G1 X135.484 Y123.131 E.00599
G1 X135.843 Y123.847 E.02657
G3 X136.046 Y127.452 I-6.212 J2.158 E.12135
G1 X135.843 Y128.153 E.02422
G1 X135.484 Y128.869 E.02657
G1 X135.386 Y129.021 E.00599
G1 X134.914 Y129.563 E.02385
G1 X134.503 Y129.835 E.01634
G1 X134.061 Y130.007 E.01571
G1 X133.595 Y130.067 E.0156
G1 X104.046 Y130.067 E.9802
G1 X104.046 Y121.993 E.2678
G1 X103.654 Y121.541 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
G1 X133.62 Y121.541 E.92078
G1 X133.955 Y121.584 E.01039
G1 X134.159 Y121.611 E.0063
G1 X134.684 Y121.815 E.01731
G3 X135.19 Y122.157 I-1.651 J2.988 E.01878
G1 X135.699 Y122.743 E.02386
G1 X135.824 Y122.934 E.00702
G1 X136.215 Y123.719 E.02693
G3 X136.565 Y126.777 I-6.567 J2.302 E.09537
G3 X136.178 Y128.372 I-8.97 J-1.333 E.05052
G1 X135.824 Y129.066 E.02392
G1 X135.699 Y129.257 E.00702
G1 X135.19 Y129.843 E.02386
G3 X134.159 Y130.389 I-1.876 J-2.294 E.03608
G1 X133.62 Y130.459 E.01669
G1 X103.654 Y130.459 E.92078
G1 X103.654 Y121.601 E.27216
M204 S10000
; WIPE_START
G1 X105.654 Y121.597 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X104.213 Y126.895 Z19.6 F30000
G1 Z19.2
G1 E.8 F1800
; FEATURE: Bridge
; LINE_WIDTH: 0.404167
; LAYER_HEIGHT: 0.4
G1 F3000
G1 X105.816 Y128.904 E.13436
G1 X106.397 Y128.904 E.03037
G1 X104.416 Y126.42 E.16608
G1 X104.416 Y125.692 E.03808
G1 X106.977 Y128.904 E.21478
G1 X107.558 Y128.904 E.03037
G1 X104.416 Y124.963 E.26349
G1 X104.416 Y124.235 E.03808
G1 X107.912 Y128.619 E.29313
G1 X107.872 Y128.339 E.01482
G1 X108.269 Y128.339 E.02075
G1 X104.416 Y123.507 E.32306
G1 X104.416 Y123.096 E.02149
G1 X104.669 Y123.096 E.01323
G1 X108.85 Y128.339 E.35054
G1 X109.431 Y128.339 E.03037
G1 X106.476 Y124.633 E.24774
G1 X106.509 Y124.663 E.00233
G1 X106.827 Y124.345 E.0235
G1 X110.012 Y128.339 E.26701
G1 X110.593 Y128.339 E.03037
G1 X107.15 Y124.022 E.28861
G3 X107.493 Y123.724 I1.371 J1.231 E.02382
G1 X111.082 Y128.223 E.30085
G2 X111.418 Y127.917 I-1.02 J-1.461 E.02385
G1 X108.024 Y123.661 E.28455
G1 X108.605 Y123.661 E.03037
G1 X111.742 Y127.594 E.26294
G1 X111.997 Y127.339 E.01889
G1 X112.421 Y127.718 E.02971
G1 X109.186 Y123.661 E.27119
G1 X109.767 Y123.661 E.03037
G1 X113.948 Y128.904 E.35054
G1 X114.529 Y128.904 E.03037
G1 X110.348 Y123.661 E.35054
G1 X110.633 Y123.661 E.0149
G1 X110.569 Y123.21 E.02385
G1 X115.11 Y128.904 E.38074
G1 X115.435 Y128.904 E.01698
G1 X115.379 Y128.514 E.02064
G1 X111.059 Y123.096 E.36224
G1 X111.639 Y123.096 E.03037
G1 X115.821 Y128.339 E.35054
G1 X116.402 Y128.339 E.03037
G1 X112.22 Y123.096 E.35054
G1 X112.801 Y123.096 E.03036
G1 X116.982 Y128.339 E.35054
G1 X117.563 Y128.339 E.03037
G1 X114.434 Y124.414 E.26238
G1 X114.757 Y124.091 E.02389
G1 X118.144 Y128.339 E.28399
G1 X118.45 Y128.339 E.016
G1 X118.661 Y128.259 E.0118
G1 X115.08 Y123.768 E.30026
G1 X115.134 Y123.714 E.00395
G1 X115.576 Y123.661 E.0233
G1 X119.025 Y127.986 E.28917
G1 X119.348 Y127.663 E.02389
G1 X116.157 Y123.661 E.26756
G1 X116.738 Y123.661 E.03037
G1 X120.209 Y128.014 E.29101
G1 X121.223 Y128.904 E.07055
G1 X121.5 Y128.904 E.01448
G1 X117.319 Y123.661 E.35054
G1 X117.788 Y123.661 E.02454
G1 X118.025 Y123.818 E.01484
G1 X122.081 Y128.904 E.34005
G1 X122.58 Y128.904 E.0261
G1 X122.629 Y128.863 E.00333
G1 X118.4 Y123.56 E.35455
G1 X118.745 Y123.265 E.02375
G1 X122.975 Y128.569 E.3546
G1 X123.321 Y128.274 E.02375
G1 X119.191 Y123.096 E.34624
G1 X119.772 Y123.096 E.03037
G1 X123.953 Y128.339 E.35054
G1 X124.534 Y128.339 E.03037
G1 X120.467 Y123.238 E.341
G1 X121.967 Y124.557 E.10441
G1 X122.041 Y124.483 E.00543
G1 X125.115 Y128.339 E.25776
G1 X125.696 Y128.339 E.03037
G1 X122.364 Y124.16 E.27937
G1 X122.687 Y123.837 E.02389
G1 X126.251 Y128.306 E.29879
G1 X126.398 Y128.289 E.00777
G1 X126.632 Y128.056 E.01727
G1 X123.128 Y123.661 E.29379
G1 X123.709 Y123.661 E.03037
G1 X126.955 Y127.732 E.27219
G1 X127.131 Y127.557 E.01298
G1 X127.976 Y128.284 E.0583
G1 X124.29 Y123.661 E.30908
G1 X124.87 Y123.661 E.03036
G1 X129.052 Y128.904 E.35054
G1 X129.633 Y128.904 E.03037
G1 X125.451 Y123.661 E.35054
G1 X126.032 Y123.661 E.03037
G1 X130.213 Y128.904 E.35054
G1 X130.794 Y128.904 E.03037
G1 X126.162 Y123.096 E.38837
G1 X126.743 Y123.096 E.03037
G1 X130.924 Y128.339 E.35054
G1 X131.505 Y128.339 E.03037
G1 X127.324 Y123.096 E.35054
G1 X127.779 Y123.096 E.02381
G1 X128.217 Y123.487 E.03071
G1 X132.086 Y128.339 E.32435
G1 X132.375 Y128.339 E.01512
G1 X133.022 Y128.784 E.04103
G1 X129.647 Y124.552 E.2829
G1 X129.971 Y124.229 E.02389
G1 X133.685 Y128.887 E.31141
G2 X134.12 Y128.783 I-.083 J-1.303 E.02349
G1 X134.162 Y128.757 E.00259
G1 X130.294 Y123.906 E.32434
G3 X130.597 Y123.661 I1.205 J1.183 E.02041
G1 X130.68 Y123.661 E.00431
G1 X134.552 Y128.517 E.32463
G2 X134.866 Y128.183 I-2.916 J-3.065 E.02399
G1 X131.26 Y123.661 E.30232
G1 X131.661 Y123.661 E.02094
G1 X131.795 Y123.603 E.00764
G1 X135.115 Y127.767 E.27836
G2 X135.31 Y127.283 I-1.484 J-.878 E.02739
G1 X132.096 Y123.253 E.26942
G1 X122.923 Y122.792 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.588483
; LAYER_HEIGHT: 0.2
G1 F11547.71
G1 X125.129 Y122.787 E.09808
G1 X122.923 Y122.792 F30000
; LINE_WIDTH: 0.563122
G1 F12110.682
G2 X121.236 Y122.771 I-1.145 J24.625 E.07153
G1 X121.929 Y123.38 E.0391
G3 X122.367 Y123.018 I1.084 J.864 E.02424
G1 X122.868 Y122.814 E.02292
G1 X115.13 Y122.81 F30000
; LINE_WIDTH: 0.591862
G1 F11476.626
G1 X115.554 Y122.787 E.01898
G1 X117.889 Y122.788 E.10448
G1 X115.13 Y122.81 F30000
; LINE_WIDTH: 0.612303
G1 F11064.613
G1 X115.064 Y122.792 E.00316
; LINE_WIDTH: 0.567033
G1 F12020.32
G1 X114.999 Y122.773 E.00291
; LINE_WIDTH: 0.521763
G1 F13156.736
G1 X114.933 Y122.755 E.00266
; LINE_WIDTH: 0.476492
G1 F14530.463
G1 X114.867 Y122.737 E.00241
; LINE_WIDTH: 0.431222
G1 F15000
G1 X114.802 Y122.718 E.00216
; LINE_WIDTH: 0.385952
G1 X114.736 Y122.7 E.00191
; LINE_WIDTH: 0.382114
G1 X114.638 Y122.712 E.00272
; LINE_WIDTH: 0.419711
G1 X114.541 Y122.725 E.00302
; LINE_WIDTH: 0.457307
G1 X114.443 Y122.737 E.00332
; LINE_WIDTH: 0.508419
G1 F13533.868
G1 X113.712 Y122.749 E.02775
G1 X114.358 Y123.306 E.03234
G1 X114.614 Y123.085 E.01282
; LINE_WIDTH: 0.447675
G1 F15000
G1 X114.677 Y123.061 E.00223
; LINE_WIDTH: 0.413931
G1 X114.74 Y123.037 E.00204
; LINE_WIDTH: 0.380188
G1 X114.803 Y123.013 E.00186
; LINE_WIDTH: 0.382391
G1 X114.841 Y122.983 E.00134
; LINE_WIDTH: 0.420541
G1 X114.879 Y122.952 E.0015
; LINE_WIDTH: 0.45869
G1 X114.917 Y122.922 E.00165
; LINE_WIDTH: 0.49684
G1 F13879.12
G1 X114.955 Y122.891 E.0018
; LINE_WIDTH: 0.535752
G1 F12783.278
G1 X114.995 Y122.873 E.00178
; LINE_WIDTH: 0.575426
G1 F11830.853
G1 X115.035 Y122.854 E.00193
; LINE_WIDTH: 0.615101
G1 F11010.508
G1 X115.076 Y122.835 E.00207
G1 X107.383 Y122.792 F30000
; LINE_WIDTH: 0.588484
G1 F11547.692
G1 X109.589 Y122.787 E.09808
G1 X107.383 Y122.792 F30000
; LINE_WIDTH: 0.579106
G1 F11749.671
G1 X107.299 Y122.773 E.00373
; LINE_WIDTH: 0.541164
G1 F12644.413
G1 X107.216 Y122.754 E.00347
; LINE_WIDTH: 0.503223
G1 F13686.659
G1 X107.133 Y122.735 E.00321
; LINE_WIDTH: 0.465281
G1 F14916.158
G1 X107.049 Y122.716 E.00294
; LINE_WIDTH: 0.425098
G1 F15000
G2 X105.503 Y122.703 I-1.054 J32.989 E.04816
G1 X106.479 Y123.575 E.04076
G1 X107.14 Y122.98 E.02771
; LINE_WIDTH: 0.465281
G1 F14916.158
G1 X107.189 Y122.942 E.00213
; LINE_WIDTH: 0.503223
G1 F13686.659
G1 X107.238 Y122.904 E.00232
; LINE_WIDTH: 0.541164
G1 F12644.413
G1 X107.287 Y122.866 E.00251
; LINE_WIDTH: 0.579106
G1 F11749.671
G1 X107.335 Y122.828 E.0027
G1 X106.487 Y123.031 F30000
; LINE_WIDTH: 0.400362
G1 F15000
G1 X106.42 Y123.07 E.00225
G1 X106.474 Y123.101 E.00181
G1 X104.948 Y129.138 F30000
; LINE_WIDTH: 0.615108
G1 F11010.367
G2 X104.954 Y129.252 I-.032 J.059 E.01321
M73 P94 R0
G1 X108.856 Y129.213 F30000
; LINE_WIDTH: 0.588348
G1 F11550.568
G1 X111.062 Y129.211 E.09806
G1 X112.064 Y128.892 F30000
; LINE_WIDTH: 0.399124
G1 F15000
G1 X111.997 Y128.931 E.00224
G1 X112.05 Y128.962 E.00179
G1 X113.002 Y129.297 F30000
; LINE_WIDTH: 0.425641
M73 P95 R0
G1 F15000
G1 X112.027 Y128.426 E.04075
G1 X111.363 Y129.022 E.02783
; LINE_WIDTH: 0.466588
G1 F14870.133
G1 X111.303 Y129.069 E.00263
; LINE_WIDTH: 0.504156
G1 F13658.952
G1 X111.243 Y129.115 E.00286
; LINE_WIDTH: 0.541724
G1 F12630.21
G1 X111.182 Y129.162 E.00309
; LINE_WIDTH: 0.579292
G1 F11745.58
G1 X111.122 Y129.208 E.00333
G1 X111.205 Y129.227 E.0037
; LINE_WIDTH: 0.541724
G1 F12630.21
G1 X111.287 Y129.246 E.00344
; LINE_WIDTH: 0.504156
G1 F13658.952
G1 X111.37 Y129.265 E.00318
; LINE_WIDTH: 0.466588
G1 F14870.133
G1 X111.452 Y129.284 E.00292
; LINE_WIDTH: 0.425277
G1 F15000
G2 X112.942 Y129.297 I1.027 J-30.271 E.04641
G1 X116.338 Y129.213 F30000
; LINE_WIDTH: 0.588349
G1 F11550.547
G1 X118.545 Y129.211 E.09806
G1 X120.293 Y129.23 F30000
; LINE_WIDTH: 0.561928
G1 F12138.549
G1 X119.602 Y128.623 E.03889
G3 X119.158 Y128.988 I-1.072 J-.851 E.02451
G1 X118.605 Y129.208 E.02518
G2 X120.233 Y129.23 I1.113 J-22.587 E.0689
G1 X123.577 Y129.21 F30000
; LINE_WIDTH: 0.591778
G1 F11478.384
G1 X125.974 Y129.213 E.10722
G1 X126.375 Y129.193 E.01796
G1 X127.174 Y128.697 F30000
; LINE_WIDTH: 0.486979
G1 F14187.304
G1 X126.917 Y128.919 E.01227
; LINE_WIDTH: 0.438616
G1 F15000
G1 X126.835 Y128.95 E.00284
; LINE_WIDTH: 0.391854
G1 X126.753 Y128.982 E.0025
; LINE_WIDTH: 0.390252
G1 X126.708 Y129.018 E.00164
; LINE_WIDTH: 0.433812
G1 X126.662 Y129.055 E.00184
; LINE_WIDTH: 0.477372
G1 F14501.027
G1 X126.617 Y129.091 E.00205
; LINE_WIDTH: 0.520932
G1 F13179.585
G1 X126.572 Y129.127 E.00225
; LINE_WIDTH: 0.566042
G1 F12043.08
G1 X126.504 Y129.158 E.00322
; LINE_WIDTH: 0.612702
G1 F11056.86
G1 X126.435 Y129.189 E.0035
; LINE_WIDTH: 0.613736
G1 F11036.845
G1 X126.5 Y129.207 E.00316
; LINE_WIDTH: 0.569142
G1 F11972.134
G1 X126.566 Y129.225 E.00291
; LINE_WIDTH: 0.524549
G1 F13080.617
G1 X126.632 Y129.243 E.00267
; LINE_WIDTH: 0.479956
G1 F14415.309
G1 X126.697 Y129.261 E.00242
; LINE_WIDTH: 0.435362
G1 F15000
G1 X126.763 Y129.279 E.00217
; LINE_WIDTH: 0.390769
G1 X126.828 Y129.297 E.00193
; LINE_WIDTH: 0.392387
G1 X126.947 Y129.282 E.00342
; LINE_WIDTH: 0.440217
G1 X127.066 Y129.267 E.00389
; LINE_WIDTH: 0.510099
G1 F13485.209
G1 X127.186 Y129.251 E.00457
G1 X127.818 Y129.251 E.02406
G1 X127.219 Y128.736 E.03006
G1 X127.152 Y128.121 F30000
; LINE_WIDTH: 0.416176
G1 F15000
G1 X126.635 Y128.637 E.02223
G1 X126.523 Y128.691 E.00379
G3 X125.974 Y128.752 I-.815 J-4.846 E.01681
G1 X123.672 Y128.752 E.07003
G1 X123.493 Y128.671 E.00596
G1 X122.784 Y129.272 E.02828
G1 X122.663 Y129.313 E.00389
G1 X121.138 Y129.313 E.04638
G1 X121.015 Y129.27 E.00397
G3 X119.582 Y128.014 I514.513 J-588.315 E.05794
G1 X119.067 Y128.53 E.02217
G1 X118.558 Y128.74 E.01674
G1 X115.831 Y128.752 E.08295
G1 X115.881 Y129.154 E.01231
G1 X115.694 Y129.313 E.00747
G1 X113.662 Y129.313 E.0618
G1 X113.538 Y129.269 E.00402
G3 X112.013 Y127.908 I619.982 J-695.87 E.06216
G1 X111.499 Y128.422 E.02212
G1 X111.042 Y128.749 E.0171
G1 X108.348 Y128.752 E.08191
G1 X108.399 Y129.154 E.01231
G1 X108.212 Y129.313 E.00747
G1 X105.705 Y129.313 E.07626
G1 X105.558 Y129.247 E.0049
G3 X104.438 Y127.843 I655.329 J-524.035 E.0546
G1 X104.438 Y129.675 E.05569
G3 X113.662 Y129.68 I3.802 J1458.786 E.28056
G2 X116.338 Y129.675 I1.016 J-168.258 E.0814
G2 X123.577 Y129.675 I3.619 J-1807.369 E.22015
G1 X126.62 Y129.675 E.09258
G2 X133.558 Y129.678 I4.354 J-1742.635 E.21102
G1 X133.985 Y129.617 E.01313
G1 X134.486 Y129.404 E.01656
G1 X134.683 Y129.266 E.0073
; LINE_WIDTH: 0.395104
G1 X134.735 Y129.166 E.00325
; LINE_WIDTH: 0.442274
G1 X134.788 Y129.065 E.00369
; LINE_WIDTH: 0.489445
G1 F14108.976
G1 X134.84 Y128.964 E.00413
; LINE_WIDTH: 0.536615
G1 F12760.921
G1 X134.892 Y128.864 E.00456
G1 X134.786 Y128.904 E.00455
; LINE_WIDTH: 0.489445
G1 F14108.976
G1 X134.681 Y128.943 E.00412
; LINE_WIDTH: 0.442274
G1 F15000
G1 X134.575 Y128.983 E.00368
; LINE_WIDTH: 0.412457
G2 X134.205 Y129.169 I.43 J1.311 E.01251
G1 X133.702 Y129.298 E.01565
G1 X133.13 Y129.313 E.01723
G1 X133.021 Y129.283 E.00339
G3 X132.247 Y128.752 I97.071 J-142.536 E.02828
G1 X131.371 Y128.752 E.02636
G1 X131.422 Y129.154 E.01219
G1 X131.235 Y129.313 E.00739
G1 X128.613 Y129.313 E.07893
G1 X128.491 Y129.271 E.00388
G3 X127.197 Y128.16 I405.797 J-473.758 E.05137
G1 X129.518 Y124.097 F30000
; LINE_WIDTH: 0.419999
G1 F15000
G1 X130.033 Y123.582 E.02235
G1 X130.486 Y123.251 E.01727
G1 X131.48 Y123.248 E.03055
G1 X131.663 Y123.21 E.00573
; LINE_WIDTH: 0.442473
G1 X131.934 Y123.069 E.00996
; LINE_WIDTH: 0.487419
G1 F14173.268
G1 X132.206 Y122.927 E.01108
; LINE_WIDTH: 0.527551
G1 F12999.581
G1 X132.298 Y122.89 E.00393
; LINE_WIDTH: 0.524342
G1 F13086.245
G1 X132.347 Y122.935 E.0026
; LINE_WIDTH: 0.482605
G1 F14328.456
G1 X132.396 Y122.979 E.00238
; LINE_WIDTH: 0.420266
G1 F15000
G1 X133.369 Y124.182 E.04756
G1 X133.764 Y124.215 E.01218
G1 X134.241 Y124.444 E.01628
G1 X134.713 Y125.066 E.02402
G1 X134.768 Y125.172 E.00366
G1 X134.921 Y125.952 E.02446
G1 X134.91 Y126.115 E.005
G1 X135.442 Y126.782 E.02624
; LINE_WIDTH: 0.417326
G1 X135.692 Y127.127 E.01299
G1 X135.714 Y127.259 E.00411
G2 X135.787 Y125.344 I-8.006 J-1.262 E.05861
G2 X135.495 Y124.053 I-6.601 J.814 E.04044
G2 X135.006 Y123.14 I-6.192 J2.73 E.03163
G1 X134.653 Y122.734 E.01642
G1 X134.232 Y122.481 E.01499
G2 X133.519 Y122.325 I-.746 J1.715 E.02239
G1 X132.782 Y122.325 E.02251
; LINE_WIDTH: 0.441502
G1 X132.591 Y122.347 E.00622
; LINE_WIDTH: 0.484508
G1 F14266.708
G1 X132.401 Y122.368 E.0069
; LINE_WIDTH: 0.527514
G1 F13000.597
G1 X132.211 Y122.39 E.00757
G1 X131.967 Y122.368 E.00965
; LINE_WIDTH: 0.484508
G1 F14266.708
G1 X131.724 Y122.347 E.00879
; LINE_WIDTH: 0.420916
G1 F15000
G1 X131.48 Y122.325 E.00753
G3 X128.146 Y122.324 I-.995 J-1526.752 E.10271
; LINE_WIDTH: 0.416641
G2 X125.189 Y122.325 I-1.354 J250.236 E.09003
G2 X117.949 Y122.325 I-3.62 J1809.467 E.22048
G1 X114.911 Y122.325 E.09254
G3 X104.616 Y122.32 I-4.223 J-1856.797 E.3135
G1 X104.433 Y122.32 E.00559
G1 X104.433 Y122.687 E.01117
G1 X104.843 Y122.687 E.01248
G1 X104.967 Y122.731 E.00403
G3 X106.493 Y124.094 I-621.048 J696.891 E.0623
G1 X107.007 Y123.58 E.02215
G1 X107.463 Y123.251 E.01712
G1 X110.156 Y123.248 E.08202
G1 X110.106 Y122.846 E.01233
G1 X110.293 Y122.687 E.00748
G1 X112.914 Y122.687 E.07982
G1 X113.036 Y122.729 E.00393
G3 X114.379 Y123.884 I-424.137 J494.7 E.05395
G1 X114.896 Y123.367 E.02225
G1 X115.006 Y123.313 E.00374
G3 X115.554 Y123.248 I.812 J4.469 E.0168
G1 X117.856 Y123.248 E.07011
G1 X118.034 Y123.328 E.00596
G1 X118.739 Y122.729 E.02819
G1 X118.861 Y122.687 E.0039
G1 X120.389 Y122.687 E.04655
G1 X120.513 Y122.73 E.00398
G3 X121.949 Y123.99 I-518.479 J592.384 E.05818
G1 X122.464 Y123.475 E.0222
G1 X122.968 Y123.261 E.01665
G1 X123.036 Y123.248 E.00213
G1 X125.697 Y123.248 E.08102
G1 X125.647 Y122.846 E.01233
G1 X125.834 Y122.687 E.00748
G1 X127.865 Y122.687 E.06187
G1 X127.99 Y122.731 E.00403
G3 X129.474 Y124.057 I-605.566 J679.238 E.06059
G1 X129.504 Y123.578 F30000
; LINE_WIDTH: 0.4318
G1 F15000
G1 X130.16 Y122.984 E.02806
; LINE_WIDTH: 0.46291
G1 X130.222 Y122.936 E.00267
; LINE_WIDTH: 0.501529
G1 F13737.207
G1 X130.283 Y122.888 E.00291
; LINE_WIDTH: 0.540148
G1 F12670.257
G1 X130.344 Y122.84 E.00316
; LINE_WIDTH: 0.578767
G1 F11757.099
G1 X130.406 Y122.792 E.0034
G1 X130.321 Y122.772 E.0038
; LINE_WIDTH: 0.540148
G1 F12670.257
G1 X130.236 Y122.753 E.00352
; LINE_WIDTH: 0.501529
G1 F13737.207
G1 X130.151 Y122.734 E.00325
; LINE_WIDTH: 0.46291
G1 F15000
G1 X130.066 Y122.714 E.00298
; LINE_WIDTH: 0.422343
G2 X128.526 Y122.703 I-1.048 J36.198 E.04764
G1 X129.459 Y123.538 E.03873
G1 X129.512 Y123.032 F30000
; LINE_WIDTH: 0.402606
G1 F15000
G1 X129.445 Y123.071 E.00228
G1 X129.499 Y123.102 E.00184
G1 X130.406 Y122.792 F30000
; LINE_WIDTH: 0.593153
G1 F11449.695
G1 X131.42 Y122.787 E.0455
G1 X132.561 Y122.703 F30000
; LINE_WIDTH: 0.419999
G1 F15000
G1 X132.74 Y122.789 E.00611
G1 X133.557 Y123.813 E.04025
G1 X133.89 Y123.859 E.01032
G1 X134.404 Y124.104 E.01751
; LINE_WIDTH: 0.437949
G1 X134.527 Y124.184 E.00472
; LINE_WIDTH: 0.473847
G1 F14619.655
G1 X134.649 Y124.265 E.00515
; LINE_WIDTH: 0.500802
G1 F13759.004
G1 X135.057 Y124.821 E.02573
; LINE_WIDTH: 0.531887
G1 F12884.315
G1 X135.12 Y124.907 E.00424
; LINE_WIDTH: 0.576044
G1 F11817.139
G1 X135.183 Y124.992 E.00462
; LINE_WIDTH: 0.620202
G1 F10913.224
G1 X135.247 Y125.078 E.005
G1 X135.248 Y124.961 E.00549
; LINE_WIDTH: 0.576044
G1 F11817.139
G1 X135.25 Y124.844 E.00507
; LINE_WIDTH: 0.531887
G1 F12884.315
G1 X135.251 Y124.728 E.00465
; LINE_WIDTH: 0.497086
G1 F13871.594
G1 X135.102 Y124.167 E.02146
; LINE_WIDTH: 0.468272
G1 F14811.261
G1 X134.982 Y123.899 E.0102
; LINE_WIDTH: 0.421627
G1 F15000
G2 X134.721 Y123.388 I-2.638 J1.021 E.01772
G1 X134.345 Y122.983 E.01704
G2 X133.519 Y122.703 I-.879 J1.231 E.02731
G1 X132.621 Y122.703 E.02773
G1 X133.419 Y123.062 F30000
; LINE_WIDTH: 0.385762
G1 F15000
G1 X133.737 Y123.461 E.01425
G1 X134.083 Y123.55 E.00997
G1 X134.524 Y123.762 E.01367
G1 X134.224 Y123.365 E.01391
G1 X133.964 Y123.167 E.00911
G2 X133.479 Y123.068 I-.429 J.857 E.01401
G1 X135.247 Y125.078 F30000
; LINE_WIDTH: 0.624431
G1 F10833.855
G1 X135.306 Y125.472 E.01887
; LINE_WIDTH: 0.586446
G1 F11590.983
G3 X135.369 Y125.915 I-3.377 J.708 E.01986
G1 X134.892 Y128.864 F30000
; LINE_WIDTH: 0.542375
G1 F12613.762
G1 X135.044 Y128.679 E.00971
; LINE_WIDTH: 0.506724
G1 F13583.338
G1 X135.195 Y128.495 E.00902
; LINE_WIDTH: 0.464238
G1 F14953.076
G1 X135.468 Y128.006 E.01921
; LINE_WIDTH: 0.425414
G1 F15000
G1 X135.578 Y127.687 E.01051
; LINE_WIDTH: 0.395182
G2 X135.701 Y127.318 I-1.669 J-.759 E.0112
G1 X131.879 Y129.213 F30000
; LINE_WIDTH: 0.588231
G1 F11553.041
G1 X132.043 Y129.213 E.0073
; CHANGE_LAYER
; Z_HEIGHT: 19.4
; LAYER_HEIGHT: 0.199999
; WIPE_START
G1 F11553.041
G1 X131.879 Y129.213 E-.76
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 97/101
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L97
M991 S0 P96 ;notify layer change
G17
G3 Z19.6 I.292 J-1.181 P1  F30000
G1 X104.046 Y122.33 Z19.6
G1 Z19.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F11450
G1 X133.628 Y122.334 E.98129
G1 X134.061 Y122.39 E.0145
G3 X134.461 Y122.575 I-1.151 J3.018 E.01461
G1 X134.917 Y122.939 E.01937
G3 X135.519 Y123.853 I-2.997 J2.629 E.03641
G1 X135.785 Y124.577 E.02561
G1 X135.907 Y125.276 E.02353
G3 X135.787 Y127.417 I-6.259 J.724 E.07149
G1 X135.519 Y128.148 E.0258
G3 X134.917 Y129.061 I-3.598 J-1.715 E.03641
G1 X134.461 Y129.425 E.01937
G3 X134.061 Y129.61 I-1.55 J-2.833 E.01461
G1 X133.595 Y129.67 E.0156
G1 X104.046 Y129.67 E.9802
G1 X104.046 Y122.39 E.24149
G1 X103.654 Y121.938 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F11450
G1 X133.678 Y121.945 E.92255
G1 X134.159 Y122.007 E.01491
G3 X134.669 Y122.239 I-1.444 J3.855 E.01724
G1 X135.19 Y122.655 E.02046
G3 X135.879 Y123.695 I-3.301 J2.935 E.03849
G1 X136.166 Y124.475 E.02553
G1 X136.297 Y125.231 E.02356
G3 X136.167 Y127.519 I-6.688 J.769 E.07077
G1 X135.879 Y128.305 E.02572
G3 X135.19 Y129.345 I-3.99 J-1.894 E.03848
G1 X134.669 Y129.761 E.02046
G3 X134.159 Y129.993 I-1.954 J-3.622 E.01724
G1 X133.62 Y130.062 E.01669
G1 X103.654 Y130.062 E.92078
G1 X103.654 Y121.998 E.24779
M204 S10000
; WIPE_START
G1 F12000
G1 X105.654 Y121.994 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X104.978 Y129.506 Z19.8 F30000
G1 Z19.4
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.423197
G1 F11450
G1 X104.379 Y128.907 E.02626
G1 X104.379 Y128.369 E.01667
G1 X105.346 Y129.337 E.04239
G1 X105.884 Y129.337 E.01667
G1 X104.379 Y127.832 E.06596
G1 X104.379 Y127.294 E.01667
G1 X106.422 Y129.337 E.08953
G1 X106.96 Y129.337 E.01667
G1 X104.379 Y126.756 E.1131
G1 X104.379 Y126.218 E.01667
G1 X107.498 Y129.337 E.13666
G1 X108.035 Y129.337 E.01667
G1 X104.379 Y125.68 E.16023
G1 X104.379 Y125.143 E.01667
G1 X108.573 Y129.337 E.1838
G1 X109.111 Y129.337 E.01667
G1 X104.379 Y124.605 E.20737
G1 X104.379 Y124.067 E.01667
G1 X109.649 Y129.337 E.23094
G1 X110.187 Y129.337 E.01667
G1 X104.379 Y123.529 E.2545
G1 X104.379 Y122.991 E.01667
G1 X110.724 Y129.337 E.27807
G1 X111.262 Y129.337 E.01667
G1 X104.589 Y122.663 E.29245
G1 X105.127 Y122.663 E.01667
G1 X111.8 Y129.337 E.29244
G1 X112.338 Y129.337 E.01666
G1 X105.665 Y122.664 E.29244
G1 X106.202 Y122.664 E.01667
G1 X112.876 Y129.337 E.29244
G1 X113.413 Y129.337 E.01667
G1 X106.74 Y122.664 E.29243
G1 X107.278 Y122.664 E.01667
G1 X113.951 Y129.337 E.29243
G1 X114.489 Y129.337 E.01667
G1 X107.816 Y122.664 E.29243
G1 X108.354 Y122.664 E.01667
G1 X115.027 Y129.337 E.29242
G1 X115.564 Y129.337 E.01667
G1 X108.892 Y122.664 E.29242
G1 X109.43 Y122.664 E.01667
G1 X116.102 Y129.337 E.29242
G1 X116.64 Y129.337 E.01667
G1 X109.968 Y122.664 E.29241
G1 X110.505 Y122.664 E.01667
G1 X117.178 Y129.337 E.29241
G1 X117.716 Y129.337 E.01667
G1 X111.043 Y122.664 E.29241
G1 X111.581 Y122.664 E.01667
G1 X118.253 Y129.337 E.2924
G1 X118.791 Y129.337 E.01667
G1 X112.119 Y122.664 E.2924
G1 X112.657 Y122.665 E.01667
G1 X119.329 Y129.337 E.2924
G1 X119.867 Y129.337 E.01667
G1 X113.195 Y122.665 E.29239
G1 X113.733 Y122.665 E.01667
G1 X120.405 Y129.337 E.29239
G1 X120.942 Y129.337 E.01667
G1 X114.27 Y122.665 E.29239
G1 X114.808 Y122.665 E.01667
G1 X121.48 Y129.337 E.29238
G1 X122.018 Y129.337 E.01666
G1 X115.346 Y122.665 E.29238
G1 X115.884 Y122.665 E.01667
G1 X122.556 Y129.337 E.29238
G1 X123.094 Y129.337 E.01667
G1 X116.422 Y122.665 E.29237
G1 X116.96 Y122.665 E.01667
G1 X123.631 Y129.337 E.29237
G1 X124.169 Y129.337 E.01667
G1 X117.498 Y122.665 E.29237
G1 X118.036 Y122.665 E.01667
G1 X124.707 Y129.337 E.29236
G1 X125.245 Y129.337 E.01667
G1 X118.573 Y122.665 E.29236
G1 X119.111 Y122.665 E.01667
G1 X125.783 Y129.337 E.29236
G1 X126.32 Y129.337 E.01667
G1 X119.649 Y122.666 E.29235
G1 X120.187 Y122.666 E.01667
G1 X126.858 Y129.337 E.29235
G1 X127.396 Y129.337 E.01667
G1 X120.725 Y122.666 E.29235
G1 X121.263 Y122.666 E.01667
G1 X127.934 Y129.337 E.29234
G1 X128.472 Y129.337 E.01667
G1 X121.801 Y122.666 E.29234
G1 X122.339 Y122.666 E.01667
G1 X129.009 Y129.337 E.29234
G1 X129.547 Y129.337 E.01667
G1 X122.876 Y122.666 E.29233
G1 X123.414 Y122.666 E.01667
G1 X130.085 Y129.337 E.29233
G1 X130.623 Y129.337 E.01667
G1 X123.952 Y122.666 E.29233
G1 X124.49 Y122.666 E.01667
G1 X131.16 Y129.337 E.29232
G1 X131.698 Y129.337 E.01666
G1 X125.028 Y122.666 E.29232
G1 X125.566 Y122.666 E.01667
G1 X132.236 Y129.337 E.29232
G1 X132.774 Y129.337 E.01667
G1 X126.104 Y122.666 E.29231
G1 X126.641 Y122.667 E.01667
G1 X133.312 Y129.337 E.29231
G2 X133.818 Y129.305 I.131 J-1.984 E.01576
G1 X127.179 Y122.667 E.29093
G1 X127.717 Y122.667 E.01667
G1 X134.22 Y129.17 E.28498
G1 X134.285 Y129.14 E.0022
G1 X134.531 Y128.943 E.00978
G1 X128.255 Y122.667 E.27504
G1 X128.793 Y122.667 E.01667
G1 X134.807 Y128.681 E.26354
G2 X135.026 Y128.362 I-1.249 J-1.097 E.01201
G1 X129.331 Y122.667 E.24959
G1 X129.869 Y122.667 E.01667
G1 X135.214 Y128.012 E.23424
G1 X135.358 Y127.619 E.01299
G1 X130.407 Y122.667 E.21699
G1 X130.944 Y122.667 E.01667
G1 X135.485 Y127.208 E.19898
G1 X135.564 Y126.749 E.01442
G1 X131.482 Y122.667 E.17888
G1 X132.02 Y122.667 E.01667
G1 X135.601 Y126.248 E.15691
G2 X135.598 Y125.708 I-2.325 J-.26 E.01677
G1 X132.558 Y122.667 E.13323
G1 X133.096 Y122.667 E.01667
G1 X135.54 Y125.111 E.1071
G1 X135.462 Y124.664 E.01407
G1 X135.365 Y124.398 E.00877
G1 X133.638 Y122.672 E.07567
G1 X133.968 Y122.714 E.01032
G1 X134.285 Y122.86 E.0108
G1 X134.679 Y123.175 E.01565
G1 X135.313 Y123.809 E.02778
; CHANGE_LAYER
; Z_HEIGHT: 19.6
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F15000
G1 X134.679 Y123.175 E-.34069
G1 X134.285 Y122.86 E-.19195
G1 X133.968 Y122.714 E-.13245
G1 X133.72 Y122.682 E-.09491
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 98/101
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L98
M991 S0 P97 ;notify layer change
G17
G3 Z19.8 I-.005 J-1.217 P1  F30000
G1 X104.046 Y122.802 Z19.8
G1 Z19.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F10108
G1 X133.587 Y122.802 E.97994
G1 X133.824 Y122.839 E.00794
G1 X134.033 Y122.871 E.00704
G1 X134.461 Y123.072 E.01567
G3 X135.439 Y124.562 I-2.031 J2.399 E.05994
G1 X135.6 Y125.29 E.02472
G1 X135.653 Y126 E.02362
G1 X135.6 Y126.71 E.02362
G1 X135.439 Y127.438 E.02472
G3 X134.461 Y128.928 I-3.009 J-.909 E.05994
G1 X134.033 Y129.129 E.01567
G1 X133.587 Y129.198 E.01498
G1 X104.046 Y129.198 E.97994
G1 X104.046 Y122.862 E.21018
G1 X103.654 Y122.41 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F10108
G1 X133.617 Y122.41 E.9207
G1 X133.884 Y122.451 E.00829
G1 X134.149 Y122.492 E.00825
G1 X134.669 Y122.737 E.01767
G3 X135.173 Y123.219 I-1.751 J2.331 E.02147
G3 X135.816 Y124.452 I-3.294 J2.503 E.04291
G1 X135.989 Y125.233 E.02458
G1 X136.046 Y126 E.02364
G1 X135.989 Y126.767 E.02364
G1 X135.816 Y127.548 E.02458
G3 X134.669 Y129.263 I-3.252 J-.934 E.06441
G1 X134.149 Y129.508 E.01766
G1 X133.617 Y129.59 E.01654
G1 X103.654 Y129.59 E.9207
G1 X103.654 Y122.47 E.21879
M204 S10000
; WIPE_START
G1 F12000
G1 X105.654 Y122.466 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X104.209 Y123.735 Z20 F30000
G1 Z19.6
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.423519
G1 F10108
G1 X104.809 Y123.135 E.02631
G1 X105.348 Y123.135 E.01669
G1 X104.379 Y124.104 E.04248
G1 X104.379 Y124.642 E.01669
G1 X105.886 Y123.135 E.06609
G1 X106.424 Y123.135 E.01669
G1 X104.379 Y125.18 E.0897
G1 X104.379 Y125.718 E.01669
G1 X106.962 Y123.135 E.1133
G1 X107.501 Y123.135 E.01669
G1 X104.379 Y126.257 E.13691
G1 X104.379 Y126.795 E.01669
G1 X108.039 Y123.135 E.16052
G1 X108.577 Y123.135 E.01669
G1 X104.379 Y127.333 E.18413
G1 X104.379 Y127.871 E.01669
G1 X109.115 Y123.135 E.20773
G1 X109.654 Y123.135 E.01669
G1 X104.379 Y128.41 E.23134
G1 X104.379 Y128.865 E.01412
G1 X104.462 Y128.865 E.00258
G1 X110.192 Y123.135 E.2513
G1 X110.73 Y123.135 E.01669
G1 X105 Y128.865 E.2513
G1 X105.539 Y128.865 E.01669
G1 X111.268 Y123.135 E.2513
G1 X111.807 Y123.135 E.01669
G1 X106.077 Y128.865 E.25131
G1 X106.615 Y128.865 E.01669
G1 X112.345 Y123.135 E.2513
G1 X112.883 Y123.135 E.01669
G1 X107.153 Y128.865 E.2513
G1 X107.692 Y128.865 E.01669
G1 X113.421 Y123.135 E.2513
G1 X113.96 Y123.135 E.01669
G1 X108.23 Y128.865 E.2513
G1 X108.768 Y128.865 E.01669
G1 X114.498 Y123.135 E.2513
G1 X115.036 Y123.135 E.01669
G1 X109.306 Y128.865 E.2513
G1 X109.845 Y128.865 E.01669
G1 X115.574 Y123.135 E.25131
G1 X116.113 Y123.135 E.01669
G1 X110.383 Y128.865 E.2513
G1 X110.921 Y128.865 E.01669
G1 X116.651 Y123.135 E.2513
G1 X117.189 Y123.135 E.01669
G1 X111.459 Y128.865 E.2513
G1 X111.998 Y128.865 E.01669
G1 X117.727 Y123.135 E.2513
G1 X118.266 Y123.135 E.01669
G1 X112.536 Y128.865 E.2513
G1 X113.074 Y128.865 E.01669
G1 X118.804 Y123.135 E.2513
G1 X119.342 Y123.135 E.01669
G1 X113.612 Y128.865 E.2513
G1 X114.151 Y128.865 E.01669
G1 X119.88 Y123.135 E.25131
G1 X120.419 Y123.135 E.01669
G1 X114.689 Y128.865 E.2513
G1 X115.227 Y128.865 E.01669
G1 X120.957 Y123.135 E.2513
G1 X121.495 Y123.135 E.01669
G1 X115.765 Y128.865 E.2513
G1 X116.304 Y128.865 E.01669
G1 X122.033 Y123.135 E.2513
G1 X122.572 Y123.135 E.01669
G1 X116.842 Y128.865 E.2513
G1 X117.38 Y128.865 E.01669
G1 X123.11 Y123.135 E.2513
G1 X123.648 Y123.135 E.01669
G1 X117.918 Y128.865 E.2513
G1 X118.457 Y128.865 E.01669
G1 X124.186 Y123.135 E.25131
G1 X124.725 Y123.135 E.01669
G1 X118.995 Y128.865 E.2513
G1 X119.533 Y128.865 E.01669
G1 X125.263 Y123.135 E.2513
G1 X125.801 Y123.135 E.01669
G1 X120.071 Y128.865 E.2513
G1 X120.61 Y128.865 E.01669
G1 X126.339 Y123.135 E.2513
G1 X126.878 Y123.135 E.01669
G1 X121.148 Y128.865 E.2513
G1 X121.686 Y128.865 E.01669
G1 X127.416 Y123.135 E.2513
G1 X127.954 Y123.135 E.01669
G1 X122.224 Y128.865 E.2513
G1 X122.763 Y128.865 E.01669
G1 X128.492 Y123.135 E.25131
G1 X129.031 Y123.135 E.01669
G1 X123.301 Y128.865 E.2513
G1 X123.839 Y128.865 E.01669
G1 X129.569 Y123.135 E.2513
G1 X130.107 Y123.135 E.01669
G1 X124.377 Y128.865 E.2513
M73 P96 R0
G1 X124.916 Y128.865 E.01669
G1 X130.645 Y123.135 E.2513
G1 X131.184 Y123.135 E.01669
G1 X125.454 Y128.865 E.2513
G1 X125.992 Y128.865 E.01669
G1 X131.722 Y123.135 E.2513
G1 X132.26 Y123.135 E.01669
G1 X126.53 Y128.865 E.2513
G1 X127.069 Y128.865 E.01669
G1 X132.798 Y123.135 E.25131
G1 X133.337 Y123.135 E.01669
G1 X127.607 Y128.865 E.2513
G1 X128.145 Y128.865 E.01669
G1 X133.833 Y123.177 E.24946
G1 X133.935 Y123.193 E.00321
G1 X134.221 Y123.328 E.0098
G1 X128.683 Y128.865 E.24287
G1 X129.222 Y128.865 E.01669
G1 X134.506 Y123.581 E.23175
G3 X134.745 Y123.879 I-.619 J.742 E.01195
G1 X129.76 Y128.865 E.21866
G1 X130.298 Y128.865 E.01669
G1 X134.942 Y124.221 E.20369
G3 X135.099 Y124.603 I-1.737 J.935 E.01282
G1 X130.836 Y128.865 E.18694
G1 X131.375 Y128.865 E.01669
G1 X135.203 Y125.037 E.1679
G3 X135.281 Y125.497 I-1.545 J.5 E.01451
G1 X131.913 Y128.865 E.14773
G1 X132.451 Y128.865 E.01669
G1 X135.318 Y125.998 E.12575
G1 X135.276 Y126.579 E.01806
G1 X132.989 Y128.865 E.10027
G1 X133.528 Y128.865 E.01669
G1 X135.138 Y127.254 E.07064
G3 X134.61 Y128.318 I-2.702 J-.678 E.03711
G3 X133.955 Y128.975 I-41.169 J-40.369 E.02878
; CHANGE_LAYER
; Z_HEIGHT: 19.8
; LAYER_HEIGHT: 0.199999
; WIPE_START
G1 F15000
G1 X134.61 Y128.318 E-.35264
G1 X134.849 Y127.969 E-.16082
G1 X135.006 Y127.649 E-.13543
G1 X135.099 Y127.371 E-.11111
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 99/101
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L99
M991 S0 P98 ;notify layer change
G17
G3 Z20 I.157 J-1.207 P1  F30000
G1 X104.046 Y123.322 Z20
G1 Z19.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8516
G1 X133.575 Y123.322 E.97952
G1 X133.992 Y123.404 E.01411
G1 X134.406 Y123.652 E.01601
G3 X135.033 Y124.578 I-1.625 J1.776 E.03744
G1 X135.247 Y125.301 E.02502
G3 X135.304 Y126 I-14.047 J1.494 E.02326
G3 X135.247 Y126.699 I-14.101 J-.795 E.02326
G1 X135.033 Y127.422 E.02502
G1 X134.816 Y127.862 E.01628
G3 X133.992 Y128.596 I-1.638 J-1.011 E.03713
G1 X133.575 Y128.678 E.01411
G1 X104.046 Y128.678 E.97952
G1 X104.046 Y123.382 E.1757
G1 X103.654 Y122.93 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F8516
G1 X133.613 Y122.93 E.92056
G1 X134.048 Y123.016 E.01363
G1 X134.135 Y123.033 E.00271
G1 X134.65 Y123.341 E.01846
G3 X135.399 Y124.435 I-1.926 J2.124 E.0411
G1 X135.634 Y125.226 E.02534
G3 X135.697 Y126 I-15.567 J1.665 E.02388
G3 X135.634 Y126.774 I-15.629 J-.891 E.02388
G1 X135.399 Y127.565 E.02534
G1 X135.155 Y128.063 E.01706
G3 X134.65 Y128.659 I-2.081 J-1.252 E.02407
G1 X134.135 Y128.967 E.01846
G1 X133.613 Y129.07 E.01634
G1 X103.654 Y129.07 E.92056
G1 X103.654 Y122.99 E.18685
M204 S10000
; WIPE_START
G1 F12000
G1 X105.654 Y122.986 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X106.724 Y126 Z20.2 F30000
G1 Z19.8
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.467569
G1 F8516
G1 X132.557 Y126 E.89391
G1 X132.96 Y125.599 F30000
; LINE_WIDTH: 0.419999
G1 F8516
G1 X106.323 Y125.599 E.81848
G1 X106.323 Y126.401 E.02463
G1 X132.96 Y126.401 E.81848
G1 X133.017 Y126.033 E.01142
G1 X132.968 Y125.659 E.01161
G1 X133.232 Y125.222 F30000
G1 F8516
G1 X105.946 Y125.222 E.83841
G1 X105.946 Y126.778 E.04781
G1 X133.232 Y126.778 E.83841
G1 X133.374 Y126.292 E.01556
G1 X133.392 Y126.064 E.00702
G1 X133.354 Y125.6 E.01432
G1 X133.25 Y125.279 E.01034
G1 X133.423 Y124.845 F30000
G1 F8516
G1 X105.569 Y124.845 E.85586
G1 X105.569 Y127.155 E.07098
G1 X133.423 Y127.155 E.85586
G1 X133.609 Y126.866 E.01058
G1 X133.75 Y126.322 E.01725
G2 X133.592 Y125.1 I-2.412 J-.31 E.03829
G1 X133.456 Y124.895 E.00756
G1 X132.848 Y124.468 F30000
G1 F8516
G1 X105.192 Y124.468 E.84979
G1 X105.192 Y127.532 E.09415
G1 X133.462 Y127.532 E.86866
G1 X133.66 Y127.458 E.00649
G1 X133.882 Y127.166 E.01127
G1 X134.077 Y126.614 E.01801
G1 X134.144 Y126.125 E.01516
G1 X134.114 Y125.513 E.01882
G1 X133.962 Y124.997 E.01654
G1 X133.794 Y124.7 E.01046
G1 X133.574 Y124.49 E.00936
G1 X132.908 Y124.47 E.02047
G1 X133.294 Y124.091 F30000
G1 F8516
G1 X104.815 Y124.091 E.87507
G1 X104.815 Y127.909 E.11733
G1 X133.499 Y127.909 E.88138
G1 X133.711 Y127.867 E.00664
G1 X133.98 Y127.664 E.01035
G1 X134.22 Y127.332 E.01258
G1 X134.439 Y126.721 E.01996
G1 X134.52 Y126.155 E.01756
G1 X134.501 Y125.615 E.01661
G2 X134.269 Y124.767 I-3.227 J.428 E.02709
G2 X133.908 Y124.25 I-1.786 J.863 E.01946
G1 X133.711 Y124.133 E.00703
G1 X133.353 Y124.097 E.01105
G1 X133.426 Y123.714 F30000
G1 F8516
G1 X104.438 Y123.714 E.89072
G1 X104.438 Y128.286 E.1405
G1 X133.536 Y128.286 E.89411
G1 X133.849 Y128.224 E.00979
G1 X134.155 Y128.041 E.01097
G1 X134.482 Y127.654 E.01556
G2 X134.86 Y126.625 I-3.816 J-1.987 E.03379
G2 X134.607 Y124.601 I-3.917 J-.538 E.06339
G1 X134.482 Y124.346 E.00873
G1 X134.155 Y123.959 E.01556
G1 X133.849 Y123.776 E.01097
G1 X133.485 Y123.722 E.01128
; CHANGE_LAYER
; Z_HEIGHT: 20
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F15000
G1 X133.849 Y123.776 E-.13956
G1 X134.155 Y123.959 E-.13572
G1 X134.482 Y124.346 E-.19243
G1 X134.607 Y124.601 E-.10794
G1 X134.762 Y125.06 E-.18435
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 100/101
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L100
M991 S0 P99 ;notify layer change
G17
G3 Z20.2 I-.011 J-1.217 P1  F30000
G1 X104.046 Y125.346 Z20.2
G1 Z20
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8436
G1 X133.43 Y125.346 E.97472
G1 X133.505 Y125.381 E.00275
G1 X133.672 Y125.611 E.00944
G1 X133.766 Y126 E.01327
G1 X133.672 Y126.389 E.01327
G1 X133.505 Y126.619 E.00944
G1 X133.43 Y126.654 E.00275
G1 X104.046 Y126.654 E.97472
G1 X104.046 Y125.406 E.04137
; WIPE_START
G1 F15476.087
G1 X106.046 Y125.402 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X103.654 Y123.583 Z20.4 F30000
G1 Z20
G1 E.8 F1800
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F8436
G1 X133.64 Y123.588 E.9214
G3 X134.112 Y123.69 I-.46 J3.275 E.01483
G1 X134.626 Y124.117 E.02054
G1 X134.845 Y124.427 E.01165
G1 X135.166 Y125.209 E.02597
G1 X135.244 Y126 E.02444
G1 X135.166 Y126.791 E.02444
G1 X134.845 Y127.573 E.02597
G1 X134.626 Y127.883 E.01165
G1 X134.112 Y128.31 E.02054
G3 X133.613 Y128.417 I-.982 J-3.357 E.01569
G1 X103.654 Y128.417 E.92056
G1 X103.654 Y123.643 E.14671
M204 S10000
; WIPE_START
G1 F12000
G1 X105.654 Y123.639 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X113.263 Y124.231 Z20.4 F30000
G1 X133.094 Y125.775 Z20.4
G1 Z20
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.492968
G1 F8436
G1 X104.474 Y125.775 E1.04957
G1 X104.474 Y126.225 E.0165
G1 X133.094 Y126.225 E1.04957
G1 X133.277 Y126.199 E.00679
G1 X133.313 Y126.053 E.00552
G1 X133.272 Y125.789 E.0098
G1 X133.154 Y125.78 E.00434
; WIPE_START
G1 F13998.506
G1 X133.272 Y125.789 E-.04498
G1 X133.313 Y126.053 E-.10154
G1 X133.277 Y126.199 E-.05722
G1 X133.094 Y126.225 E-.07033
G1 X131.815 Y126.225 E-.48593
; WIPE_END
G1 E-.04 F1800
G1 X133.433 Y128.21 Z20.4 F30000
G1 Z20
G1 E.8 F1800
M204 S2000
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F8436
G1 X134.969 Y126.674 E.06676
G1 X135.028 Y126.082
G1 X132.9 Y128.21 E.09248
G1 X132.366 Y128.21
G1 X134.994 Y125.582 E.11421
G1 X134.917 Y125.126
G1 X133.98 Y126.063 E.04074
G1 X133.901 Y125.609
G1 X134.758 Y124.752 E.03726
G1 X134.574 Y124.403
G1 X133.702 Y125.274 E.03785
G1 X133.319 Y125.124
G1 X134.315 Y124.129 E.04326
G1 X134.024 Y123.886
G1 X132.786 Y125.124 E.05378
G1 X132.253 Y125.124
G1 X133.587 Y123.79 E.05797
G1 X133.053 Y123.79
G1 X131.719 Y125.124 E.05797
G1 X131.186 Y125.124
G1 X132.52 Y123.79 E.05797
G1 X131.987 Y123.79
G1 X130.653 Y125.124 E.05797
G1 X130.12 Y125.124
G1 X131.454 Y123.79 E.05797
G1 X130.92 Y123.79
G1 X129.586 Y125.124 E.05797
G1 X129.053 Y125.124
G1 X130.387 Y123.79 E.05797
G1 X129.854 Y123.79
G1 X128.52 Y125.124 E.05797
G1 X127.986 Y125.124
G1 X129.32 Y123.79 E.05797
G1 X128.787 Y123.79
G1 X127.453 Y125.124 E.05797
G1 X126.92 Y125.124
G1 X128.254 Y123.79 E.05797
G1 X127.721 Y123.79
G1 X126.387 Y125.124 E.05797
G1 X125.853 Y125.124
G1 X127.187 Y123.79 E.05797
G1 X126.654 Y123.79
G1 X125.32 Y125.124 E.05797
G1 X124.787 Y125.124
G1 X126.121 Y123.79 E.05797
G1 X125.588 Y123.79
G1 X124.254 Y125.124 E.05797
G1 X123.72 Y125.124
G1 X125.054 Y123.79 E.05797
G1 X124.521 Y123.79
G1 X123.187 Y125.124 E.05797
G1 X122.654 Y125.124
G1 X123.988 Y123.79 E.05797
G1 X123.454 Y123.79
G1 X122.121 Y125.124 E.05797
G1 X121.587 Y125.124
G1 X122.921 Y123.79 E.05797
G1 X122.388 Y123.79
G1 X121.054 Y125.124 E.05797
G1 X120.521 Y125.124
G1 X121.855 Y123.79 E.05797
G1 X121.321 Y123.79
G1 X119.987 Y125.124 E.05797
G1 X119.454 Y125.124
G1 X120.788 Y123.79 E.05797
G1 X120.255 Y123.79
G1 X118.921 Y125.124 E.05797
G1 X118.388 Y125.124
G1 X119.722 Y123.79 E.05797
G1 X119.188 Y123.79
G1 X117.854 Y125.124 E.05797
G1 X117.321 Y125.124
G1 X118.655 Y123.79 E.05797
G1 X118.122 Y123.79
G1 X116.788 Y125.124 E.05797
G1 X116.255 Y125.124
G1 X117.589 Y123.79 E.05797
G1 X117.055 Y123.79
G1 X115.721 Y125.124 E.05797
G1 X115.188 Y125.124
G1 X116.522 Y123.79 E.05797
G1 X115.989 Y123.79
G1 X114.655 Y125.124 E.05797
G1 X114.121 Y125.124
G1 X115.455 Y123.79 E.05797
G1 X114.922 Y123.79
M73 P97 R0
G1 X113.588 Y125.124 E.05797
G1 X113.055 Y125.124
G1 X114.389 Y123.79 E.05797
G1 X113.856 Y123.79
G1 X112.522 Y125.124 E.05797
G1 X111.988 Y125.124
G1 X113.322 Y123.79 E.05797
G1 X112.789 Y123.79
G1 X111.455 Y125.124 E.05797
G1 X110.922 Y125.124
G1 X112.256 Y123.79 E.05797
G1 X111.723 Y123.79
G1 X110.389 Y125.124 E.05797
G1 X109.855 Y125.124
G1 X111.189 Y123.79 E.05797
G1 X110.656 Y123.79
G1 X109.322 Y125.124 E.05797
G1 X108.789 Y125.124
G1 X110.123 Y123.79 E.05797
G1 X109.589 Y123.79
G1 X108.255 Y125.124 E.05797
G1 X107.722 Y125.124
G1 X109.056 Y123.79 E.05797
G1 X108.523 Y123.79
G1 X107.189 Y125.124 E.05797
G1 X106.656 Y125.124
G1 X107.99 Y123.79 E.05797
G1 X107.456 Y123.79
G1 X106.122 Y125.124 E.05797
G1 X105.589 Y125.124
G1 X106.923 Y123.79 E.05797
G1 X106.39 Y123.79
G1 X105.056 Y125.124 E.05797
G1 X104.523 Y125.124
G1 X105.857 Y123.79 E.05797
G1 X105.323 Y123.79
G1 X103.989 Y125.124 E.05797
G1 X103.861 Y124.719
G1 X104.79 Y123.79 E.04036
G1 X104.257 Y123.79
G1 X103.861 Y124.186 E.01719
M204 S10000
; WIPE_START
G1 F12000
G1 X104.257 Y123.79 E-.2126
G1 X104.79 Y123.79 E-.20264
G1 X104.148 Y124.432 E-.34475
; WIPE_END
G1 E-.04 F1800
G1 X111.711 Y125.464 Z20.4 F30000
G1 X131.833 Y128.21 Z20.4
G1 Z20
G1 E.8 F1800
M204 S2000
G1 F8436
G1 X133.167 Y126.876 E.05797
G1 X132.634 Y126.876
G1 X131.3 Y128.21 E.05797
G1 X130.767 Y128.21
G1 X132.1 Y126.876 E.05797
G1 X131.567 Y126.876
G1 X130.233 Y128.21 E.05797
G1 X129.7 Y128.21
G1 X131.034 Y126.876 E.05797
G1 X130.501 Y126.876
G1 X129.167 Y128.21 E.05797
G1 X128.633 Y128.21
G1 X129.967 Y126.876 E.05797
G1 X129.434 Y126.876
G1 X128.1 Y128.21 E.05797
G1 X127.567 Y128.21
G1 X128.901 Y126.876 E.05797
G1 X128.368 Y126.876
G1 X127.034 Y128.21 E.05797
G1 X126.5 Y128.21
G1 X127.834 Y126.876 E.05797
G1 X127.301 Y126.876
G1 X125.967 Y128.21 E.05797
G1 X125.434 Y128.21
G1 X126.768 Y126.876 E.05797
G1 X126.235 Y126.876
G1 X124.901 Y128.21 E.05797
G1 X124.367 Y128.21
G1 X125.701 Y126.876 E.05797
G1 X125.168 Y126.876
G1 X123.834 Y128.21 E.05797
G1 X123.301 Y128.21
G1 X124.635 Y126.876 E.05797
G1 X124.101 Y126.876
G1 X122.767 Y128.21 E.05797
G1 X122.234 Y128.21
G1 X123.568 Y126.876 E.05797
G1 X123.035 Y126.876
G1 X121.701 Y128.21 E.05797
G1 X121.168 Y128.21
G1 X122.502 Y126.876 E.05797
G1 X121.968 Y126.876
G1 X120.634 Y128.21 E.05797
G1 X120.101 Y128.21
G1 X121.435 Y126.876 E.05797
G1 X120.902 Y126.876
G1 X119.568 Y128.21 E.05797
G1 X119.035 Y128.21
G1 X120.369 Y126.876 E.05797
G1 X119.835 Y126.876
G1 X118.501 Y128.21 E.05797
G1 X117.968 Y128.21
G1 X119.302 Y126.876 E.05797
G1 X118.769 Y126.876
G1 X117.435 Y128.21 E.05797
G1 X116.901 Y128.21
G1 X118.235 Y126.876 E.05797
G1 X117.702 Y126.876
G1 X116.368 Y128.21 E.05797
G1 X115.835 Y128.21
G1 X117.169 Y126.876 E.05797
G1 X116.636 Y126.876
G1 X115.302 Y128.21 E.05797
G1 X114.768 Y128.21
G1 X116.102 Y126.876 E.05797
G1 X115.569 Y126.876
G1 X114.235 Y128.21 E.05797
G1 X113.702 Y128.21
G1 X115.036 Y126.876 E.05797
G1 X114.503 Y126.876
G1 X113.169 Y128.21 E.05797
G1 X112.635 Y128.21
G1 X113.969 Y126.876 E.05797
G1 X113.436 Y126.876
G1 X112.102 Y128.21 E.05797
G1 X111.569 Y128.21
G1 X112.903 Y126.876 E.05797
G1 X112.369 Y126.876
G1 X111.036 Y128.21 E.05797
G1 X110.502 Y128.21
G1 X111.836 Y126.876 E.05797
G1 X111.303 Y126.876
G1 X109.969 Y128.21 E.05797
G1 X109.436 Y128.21
G1 X110.77 Y126.876 E.05797
G1 X110.236 Y126.876
G1 X108.902 Y128.21 E.05797
G1 X108.369 Y128.21
G1 X109.703 Y126.876 E.05797
G1 X109.17 Y126.876
G1 X107.836 Y128.21 E.05797
G1 X107.303 Y128.21
G1 X108.637 Y126.876 E.05797
G1 X108.103 Y126.876
G1 X106.769 Y128.21 E.05797
G1 X106.236 Y128.21
G1 X107.57 Y126.876 E.05797
G1 X107.037 Y126.876
G1 X105.703 Y128.21 E.05797
G1 X105.17 Y128.21
G1 X106.504 Y126.876 E.05797
G1 X105.97 Y126.876
G1 X104.636 Y128.21 E.05797
G1 X104.103 Y128.21
G1 X105.437 Y126.876 E.05797
G1 X104.904 Y126.876
G1 X103.861 Y127.919 E.0453
G1 X103.861 Y127.385
G1 X104.37 Y126.876 E.02213
M204 S10000
; WIPE_START
G1 F12000
G1 X103.861 Y127.385 E-.27369
G1 X103.861 Y127.919 E-.20264
G1 X104.389 Y127.391 E-.28367
; WIPE_END
G1 E-.04 F1800
G1 X112.021 Y127.324 Z20.4 F30000
G1 X134.812 Y127.124 Z20.4
G1 Z20
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.110609
G1 F8436
G1 X134.741 Y127.228 E.00069
; LINE_WIDTH: 0.155486
G1 X134.671 Y127.332 E.00115
; LINE_WIDTH: 0.200363
G1 X134.6 Y127.436 E.00161
; LINE_WIDTH: 0.235937
G1 X134.5 Y127.555 E.00244
; LINE_WIDTH: 0.251563
G1 X134.4 Y127.674 E.00264
G1 X133.846 Y128.179 E.01274
; CHANGE_LAYER
; Z_HEIGHT: 20.2
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F15000
G1 X134.4 Y127.674 E-.6295
G1 X134.5 Y127.555 E-.1305
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 101/101
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L101
M991 S0 P100 ;notify layer change
G17
G3 Z20.4 I.121 J-1.211 P1  F30000
G1 X103.654 Y124.479 Z20.4
G1 Z20.2
G1 E.8 F1800
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5269
G1 X133.638 Y124.488 E.92133
G1 X134.074 Y124.686 E.01471
G1 X134.475 Y125.241 E.02104
G3 X134.624 Y126 I-3.873 J1.155 E.02381
G3 X134.475 Y126.759 I-4.022 J-.395 E.02381
G1 X134.074 Y127.314 E.02104
G1 X133.605 Y127.521 E.01575
G1 X103.654 Y127.521 E.92032
G1 X103.654 Y124.539 E.09165
M204 S10000
; WIPE_START
G1 F12000
G1 X105.654 Y124.535 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X113.286 Y124.579 Z20.6 F30000
G1 X133.271 Y124.695 Z20.6
G1 Z20.2
G1 E.8 F1800
M204 S2000
; FEATURE: Top surface
G1 F5269
G1 X134.388 Y125.812 E.04853
G1 X134.367 Y126.324
G1 X132.738 Y124.695 E.07081
G1 X132.204 Y124.695
G1 X134.24 Y126.73 E.08847
G1 X134.016 Y127.04
G1 X131.671 Y124.694 E.10191
G1 X131.137 Y124.694
G1 X133.697 Y127.254 E.11122
G1 X133.224 Y127.314
G1 X130.604 Y124.694 E.11385
G1 X130.071 Y124.694
G1 X132.691 Y127.314 E.11385
G1 X132.157 Y127.314
G1 X129.537 Y124.694 E.11386
G1 X129.004 Y124.694
G1 X131.624 Y127.314 E.11387
G1 X131.091 Y127.314
G1 X128.47 Y124.693 E.11387
G1 X127.937 Y124.693
G1 X130.558 Y127.314 E.11388
G1 X130.024 Y127.314
G1 X127.403 Y124.693 E.11389
G1 X126.87 Y124.693
G1 X129.491 Y127.314 E.11389
G1 X128.958 Y127.314
G1 X126.337 Y124.693 E.1139
G1 X125.803 Y124.693
G1 X128.424 Y127.314 E.11391
G1 X127.891 Y127.314
G1 X125.27 Y124.693 E.11391
G1 X124.736 Y124.692
G1 X127.358 Y127.314 E.11392
G1 X126.825 Y127.314
G1 X124.203 Y124.692 E.11393
G1 X123.669 Y124.692
G1 X126.291 Y127.314 E.11394
G1 X125.758 Y127.314
G1 X123.136 Y124.692 E.11394
G1 X122.603 Y124.692
G1 X125.225 Y127.314 E.11395
G1 X124.692 Y127.314
G1 X122.069 Y124.692 E.11396
G1 X121.536 Y124.691
G1 X124.158 Y127.314 E.11396
M73 P98 R0
G1 X123.625 Y127.314
G1 X121.002 Y124.691 E.11397
G1 X120.469 Y124.691
G1 X123.092 Y127.314 E.11398
G1 X122.559 Y127.314
G1 X119.935 Y124.691 E.11398
G1 X119.402 Y124.691
G1 X122.025 Y127.314 E.11399
G1 X121.492 Y127.314
G1 X118.869 Y124.691 E.114
G1 X118.335 Y124.69
G1 X120.959 Y127.314 E.11401
G1 X120.425 Y127.314
G1 X117.802 Y124.69 E.11401
G1 X117.268 Y124.69
G1 X119.892 Y127.314 E.11402
G1 X119.359 Y127.314
G1 X116.735 Y124.69 E.11403
G1 X116.201 Y124.69
G1 X118.826 Y127.314 E.11403
G1 X118.292 Y127.314
G1 X115.668 Y124.69 E.11404
G1 X115.135 Y124.689
G1 X117.759 Y127.314 E.11405
G1 X117.226 Y127.314
G1 X114.601 Y124.689 E.11405
G1 X114.068 Y124.689
G1 X116.693 Y127.314 E.11406
G1 X116.159 Y127.314
G1 X113.534 Y124.689 E.11407
G1 X113.001 Y124.689
G1 X115.626 Y127.314 E.11408
G1 X115.093 Y127.314
G1 X112.467 Y124.689 E.11408
G1 X111.934 Y124.689
G1 X114.559 Y127.314 E.11409
G1 X114.026 Y127.314
G1 X111.401 Y124.688 E.1141
G1 X110.867 Y124.688
G1 X113.493 Y127.314 E.1141
G1 X112.96 Y127.314
G1 X110.334 Y124.688 E.11411
G1 X109.8 Y124.688
G1 X112.426 Y127.314 E.11412
G1 X111.893 Y127.314
G1 X109.267 Y124.688 E.11412
G1 X108.733 Y124.688
G1 X111.36 Y127.314 E.11413
G1 X110.827 Y127.314
G1 X108.2 Y124.687 E.11414
G1 X107.667 Y124.687
G1 X110.293 Y127.314 E.11415
G1 X109.76 Y127.314
G1 X107.133 Y124.687 E.11415
G1 X106.6 Y124.687
G1 X109.227 Y127.314 E.11416
G1 X108.693 Y127.314
G1 X106.066 Y124.687 E.11417
G1 X105.533 Y124.687
G1 X108.16 Y127.314 E.11417
G1 X107.627 Y127.314
G1 X104.999 Y124.686 E.11418
G1 X104.466 Y124.686
G1 X107.094 Y127.314 E.11419
G1 X106.56 Y127.314
G1 X103.933 Y124.686 E.11419
G1 X103.861 Y125.148
G1 X106.027 Y127.314 E.09412
G1 X105.494 Y127.314
G1 X103.861 Y125.681 E.07095
G1 X103.861 Y126.215
G1 X104.961 Y127.314 E.04778
G1 X104.427 Y127.314
G1 X103.861 Y126.748 E.0246
M204 S10000
; WIPE_START
G1 F12000
G1 X104.427 Y127.314 E-.30427
G1 X104.961 Y127.314 E-.20264
G1 X104.49 Y126.843 E-.25309
; WIPE_END
G1 E-.04 F1800
G1 X112.113 Y126.481 Z20.6 F30000
G1 X134.326 Y125.426 Z20.6
G1 Z20.2
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.164102
G1 F5269
G1 X134.107 Y125.169 E.00333
; LINE_WIDTH: 0.208783
G1 X133.889 Y124.912 E.00456
; LINE_WIDTH: 0.209624
G1 X133.775 Y124.834 E.00188
; LINE_WIDTH: 0.166627
G1 X133.661 Y124.755 E.00139
; LINE_WIDTH: 0.123631
G1 X133.548 Y124.676 E.00091
; close powerlost recovery
M1003 S0
; WIPE_START
G1 F15000
G1 X133.661 Y124.755 E-.76
; WIPE_END
G1 E-.04 F1800
M106 S0
M106 P2 S0
M981 S0 P20000 ; close spaghetti detector
; FEATURE: Custom
; filament end gcode 
M106 P3 S0
;===== date: 20240528 =====================
M400 ; wait for buffer to clear
G92 E0 ; zero the extruder
G1 E-0.8 F1800 ; retract
G1 Z20.7 F900 ; lower z a little
G1 X65 Y245 F12000 ; move to safe pos
G1 Y265 F3000

G1 X65 Y245 F12000
G1 Y265 F3000
M140 S0 ; turn off bed
M106 S0 ; turn off fan
M106 P2 S0 ; turn off remote part cooling fan
M106 P3 S0 ; turn off chamber cooling fan

G1 X100 F12000 ; wipe
; pull back filament to AMS
M620 S255
G1 X20 Y50 F12000
G1 Y-3
T255
G1 X65 F12000
G1 Y265
G1 X100 F12000 ; wipe
M621 S255
M104 S0 ; turn off hotend

M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
    M400 ; wait all motion done
    M991 S0 P-1 ;end smooth timelapse at safe pos
    M400 S3 ;wait for last picture to be taken
M623; end of "timelapse_record_flag"

M400 ; wait all motion done
M17 S
M17 Z0.4 ; lower z motor current to reduce impact if there is something in the bottom

    G1 Z120.2 F600
    G1 Z118.2

M400 P100
M17 R ; restore z current

M220 S100  ; Reset feedrate magnitude
M201.2 K1.0 ; Reset acc magnitude
M73.2   R1.0 ;Reset left time magnitude
M1002 set_gcode_claim_speed_level : 0
;=====printer finish  sound=========
M17
M400 S1
M1006 S1
M1006 A0 B20 L100 C37 D20 M40 E42 F20 N60
M1006 A0 B10 L100 C44 D10 M60 E44 F10 N60
M1006 A0 B10 L100 C46 D10 M80 E46 F10 N80
M1006 A44 B20 L100 C39 D20 M60 E48 F20 N60
M1006 A0 B10 L100 C44 D10 M60 E44 F10 N60
M1006 A0 B10 L100 C0 D10 M60 E0 F10 N60
M1006 A0 B10 L100 C39 D10 M60 E39 F10 N60
M1006 A0 B10 L100 C0 D10 M60 E0 F10 N60
M1006 A0 B10 L100 C44 D10 M60 E44 F10 N60
M1006 A0 B10 L100 C0 D10 M60 E0 F10 N60
M1006 A0 B10 L100 C39 D10 M60 E39 F10 N60
M1006 A0 B10 L100 C0 D10 M60 E0 F10 N60
M1006 A0 B10 L100 C48 D10 M60 E44 F10 N100
M1006 A0 B10 L100 C0 D10 M60 E0 F10  N100
M1006 A49 B20 L100 C44 D20 M100 E41 F20 N100
M1006 A0 B20 L100 C0 D20 M60 E0 F20 N100
M1006 A0 B20 L100 C37 D20 M30 E37 F20 N60
M1006 W

M17 X0.8 Y0.8 Z0.5 ; lower motor current to 45% power
M960 S5 P0 ; turn off logo lamp
M73 P100 R0
; EXECUTABLE_BLOCK_END

