; HEADER_BLOCK_START
; BambuStudio 01.10.01.50
; model printing time: 19m 41s; total estimated time: 26m 24s
; total layer number: 250
; total filament length [mm] : 2066.45
; total filament volume [cm^3] : 4970.41
; total filament weight [g] : 6.26
; filament_density: 1.26
; filament_diameter: 1.75
; max_z_height: 50.00
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
M73 P0 R26
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
M73 P16 R22
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
M73 P16 R21
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
M73 P17 R21
G1 E-0.5 F300

M73 P18 R21
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
M73 P19 R21
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
    G29 A X117.875 Y117.884 I20.25 J20.2318
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
M73 P20 R21
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
M73 P20 R20
    G1 X115.000 E0.31181 F6033.27
    G1 X120.000 E0.31181 F1508.32
    G1 X125.000 E0.31181 F6033.27
    G1 X130.000 E0.31181 F1508.32
    G1 X135.000 E0.31181 F6033.27
    G1 X140.000 E0.31181 F1508.32
    G1 X145.000 E0.31181 F6033.27
M73 P21 R20
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
    G1 X125.000 E0.31181 F6033.27
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
M73 P22 R20
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
; layer num/total_layer_count: 1/250
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
G1 X130.544 Y123.1 F30000
G1 Z.4
G1 Z.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.5
G1 F3000
G1 X130.568 Y123.119 E.00113
G3 X127.265 Y122.211 I-2.567 J2.875 E.76978
G1 X127.764 Y122.153 E.0187
G3 X129.579 Y122.478 I.26 J3.778 E.06937
G1 X130.098 Y122.76 E.02201
G1 X130.496 Y123.064 E.01865
G1 X130.254 Y123.454 F30000
; FEATURE: Outer wall
G1 F3000
G1 X130.26 Y123.464 E.00044
G3 X127.816 Y122.607 I-2.259 J2.533 E.69542
G3 X129.802 Y123.12 I.147 J3.534 E.07747
G1 X130.205 Y123.418 E.01871
; WIPE_START
G1 X130.26 Y123.464 E-.02707
G1 X130.624 Y123.836 E-.19777
G1 X130.924 Y124.262 E-.19787
G1 X131.155 Y124.729 E-.19787
G1 X131.265 Y125.078 E-.13942
; WIPE_END
G1 E-.04 F1800
M73 P23 R20
G1 X137.224 Y126.785 Z.6 F30000
G1 Z.2
G1 E.8 F1800
; FEATURE: Inner wall
G1 F3000
G3 X119.262 Y122.913 I-9.23 J-.781 E1.17218
G3 X128.002 Y116.741 I8.745 J3.11 E.42472
G3 X137.229 Y126.725 I-.008 J9.263 E.56851
G1 X137.68 Y126.824 F30000
; FEATURE: Outer wall
G1 F3000
G3 X118.589 Y123.55 I-9.686 J-.819 E1.19928
G3 X128.003 Y116.284 I9.399 J2.447 E.47664
G3 X137.685 Y126.764 I-.008 J9.72 E.5967
; WIPE_START
G1 X137.585 Y127.643 E-.33631
G1 X137.411 Y128.45 E-.31367
G1 X137.326 Y128.727 E-.11002
; WIPE_END
G1 E-.04 F1800
G1 X134.334 Y121.706 Z.6 F30000
G1 X132.911 Y118.365 Z.6
G1 Z.2
G1 E.8 F1800
; FEATURE: Bottom surface
; LINE_WIDTH: 0.509841
G1 F6300
G1 X134.46 Y119.914 E.08334
G3 X135.949 Y122.063 I-6.083 J5.805 E.09991
G1 X131.926 Y118.04 E.21647
G2 X130.811 Y117.586 I-3.229 J6.323 E.04588
G1 X136.417 Y123.191 E.30163
G3 X136.664 Y124.099 I-5.21 J1.908 E.03585
G1 X129.892 Y117.327 E.36442
G1 X129.096 Y117.191 E.03072
G1 X136.801 Y124.897 E.41463
G3 X136.862 Y125.618 I-4.205 J.717 E.02756
M73 P24 R19
G1 X128.375 Y117.13 E.45669
G1 X127.714 Y117.13 E.02514
G1 X136.866 Y126.282 E.49247
G3 X136.827 Y126.903 I-3.668 J.08 E.02371
G1 X127.098 Y117.174 E.52349
G2 X126.518 Y117.254 I.18 J3.449 E.02232
G1 X136.752 Y127.489 E.55068
G3 X136.636 Y128.033 I-3.253 J-.41 E.02119
G1 X125.967 Y117.363 E.57409
G1 X125.443 Y117.5 E.0206
G1 X136.495 Y128.552 E.59472
G3 X136.334 Y129.051 I-2.991 J-.694 E.01997
G1 X132.056 Y124.773 E.23019
G1 X132.137 Y125.032 E.01033
G1 X132.226 Y125.604 E.02201
G1 X136.144 Y129.522 E.21083
G3 X135.932 Y129.97 I-2.758 J-1.029 E.01889
G1 X132.237 Y126.275 E.19884
G1 X132.155 Y126.854 E.02224
G1 X135.705 Y130.404 E.19103
G1 X135.454 Y130.812 E.01826
G1 X132.011 Y127.369 E.18527
G3 X131.818 Y127.837 I-1.611 J-.389 E.01932
G1 X135.184 Y131.203 E.18113
G3 X134.903 Y131.583 I-2.371 J-1.464 E.01798
G1 X131.586 Y128.266 E.17848
G1 X131.314 Y128.653 E.01803
G1 X134.594 Y131.934 E.17652
M73 P25 R19
G3 X134.274 Y132.274 I-2.157 J-1.712 E.01779
G1 X130.996 Y128.996 E.17634
G3 X130.648 Y129.309 I-1.185 J-.971 E.01786
G1 X133.936 Y132.597 E.17693
G3 X133.577 Y132.898 I-1.947 J-1.961 E.01786
G1 X130.268 Y129.589 E.17803
G1 X129.841 Y129.822 E.01852
G1 X133.206 Y133.187 E.1811
G1 X132.812 Y133.453 E.0181
G1 X129.369 Y130.01 E.18528
G3 X128.849 Y130.151 I-.716 J-1.611 E.02056
G1 X132.401 Y133.702 E.19108
G3 X131.975 Y133.937 I-1.595 J-2.381 E.01851
G1 X128.268 Y130.23 E.19951
G3 X127.596 Y130.218 I-.299 J-2.18 E.02566
G1 X131.521 Y134.143 E.21118
G3 X131.048 Y134.331 I-1.339 J-2.682 E.01937
G1 X126.432 Y129.715 E.24838
; WIPE_START
G1 X127.846 Y131.129 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X129.296 Y123.636 Z.6 F30000
G1 X129.559 Y122.277 Z.6
G1 Z.2
G1 E.8 F1800
G1 F6300
G1 X124.952 Y117.669 E.24792
G2 X124.479 Y117.857 I.867 J2.87 E.01937
G1 X128.399 Y121.776 E.2109
G1 X127.728 Y121.766 E.02551
G1 X124.025 Y118.063 E.1993
G2 X123.599 Y118.298 I1.169 J2.615 E.01851
G1 X127.143 Y121.842 E.19069
G1 X126.625 Y121.984 E.02044
G1 X123.188 Y118.547 E.18496
G1 X122.794 Y118.813 E.0181
G1 X126.162 Y122.181 E.18124
G2 X125.738 Y122.417 I.553 J1.491 E.01854
G1 X122.423 Y119.102 E.17837
G2 X122.064 Y119.403 I1.588 J2.262 E.01786
G1 X125.348 Y122.688 E.17675
G1 X124.999 Y122.999 E.01779
G1 X121.726 Y119.726 E.17611
G2 X121.406 Y120.066 I1.836 J2.052 E.01779
G1 X124.692 Y123.352 E.17681
G2 X124.416 Y123.737 I1.108 J1.084 E.01808
G1 X121.097 Y120.417 E.17862
G2 X120.816 Y120.797 I2.087 J1.841 E.01798
G1 X124.175 Y124.156 E.18077
G1 X123.985 Y124.627 E.01931
G1 X120.546 Y121.188 E.18506
G1 X120.295 Y121.596 E.01826
G1 X123.848 Y125.149 E.19119
G2 X123.771 Y125.733 I1.852 J.54 E.02249
G1 X120.068 Y122.03 E.19927
G2 X119.856 Y122.478 I2.509 J1.463 E.01889
G1 X123.782 Y126.404 E.21126
G1 X123.801 Y126.653 E.00948
G1 X123.948 Y127.231 E.02272
G1 X119.666 Y122.949 E.23041
G2 X119.505 Y123.448 I2.849 J1.199 E.01997
G1 X130.557 Y134.5 E.59472
G1 X130.033 Y134.637 E.0206
G1 X119.364 Y123.967 E.57409
G2 X119.248 Y124.512 I3.138 J.955 E.02119
G1 X129.482 Y134.746 E.55068
G3 X128.902 Y134.826 I-.76 J-3.369 E.02232
G1 X119.173 Y125.097 E.52348
G2 X119.134 Y125.718 I3.629 J.541 E.02371
G1 X128.286 Y134.87 E.49247
G1 X127.626 Y134.87 E.02512
G1 X119.138 Y126.383 E.45671
G2 X119.199 Y127.104 I4.266 J.004 E.02756
G1 X126.904 Y134.809 E.41462
G1 X126.108 Y134.673 E.03072
G1 X119.336 Y127.901 E.3644
G2 X119.583 Y128.809 I5.42 J-.989 E.03583
G1 X125.189 Y134.414 E.30162
G3 X124.074 Y133.96 I2.114 J-6.778 E.04588
G1 X120.051 Y129.937 E.21646
G2 X121.541 Y132.087 I7.575 J-3.657 E.09994
G1 X123.089 Y133.635 E.08328
; CHANGE_LAYER
; Z_HEIGHT: 0.4
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F6300
G1 X121.675 Y132.221 E-.76
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 2/250
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
G1 X127.002 Y126.755 Z.6 F30000
G1 X130.376 Y123.293 Z.6
G1 Z.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F12196
G1 X130.392 Y123.316 E.00093
G3 X131.343 Y124.653 I-2.406 J2.717 E.05489
G3 X127.748 Y122.412 I-3.337 J1.349 E.59991
G3 X129.953 Y122.984 I.238 J3.622 E.07689
G1 X130.328 Y123.258 E.01538
G1 X130.133 Y123.606 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
G3 X130.477 Y123.957 I-2.152 J2.451 E.01511
G3 X127.793 Y122.801 I-2.471 J2.044 E.52583
G3 X130.088 Y123.567 I.189 J3.256 E.07617
M204 S10000
; WIPE_START
G1 X130.477 Y123.957 E-.20936
G1 X130.76 Y124.359 E-.18679
G1 X130.978 Y124.8 E-.18678
G1 X131.118 Y125.244 E-.17706
; WIPE_END
M73 P26 R19
G1 E-.04 F1800
G1 X137.481 Y126.807 Z.8 F30000
G1 Z.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F12196
G3 X126.79 Y116.555 I-9.485 J-.809 E1.42111
G3 X128.421 Y116.488 I1.202 J9.359 E.05419
G3 X137.486 Y126.747 I-.425 J9.51 E.50682
G1 X137.879 Y126.842 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
G1 X137.764 Y127.674 E.02581
G3 X126.741 Y116.165 I-9.769 J-1.677 E1.34471
G3 X128.438 Y116.096 I1.251 J9.743 E.05225
G3 X137.876 Y126.788 I-.442 J9.902 E.48914
M204 S10000
; WIPE_START
G1 X137.764 Y127.674 E-.33932
G1 X137.595 Y128.498 E-.31969
G1 X137.517 Y128.752 E-.10099
; WIPE_END
G1 E-.04 F1800
G1 X131.064 Y124.676 Z.8 F30000
G1 X123.814 Y120.095 Z.8
G1 Z.4
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.419999
G1 F12196
G2 X128.35 Y118.767 I4.19 J5.902 E1.24953
G2 X123.864 Y120.062 I-.354 J7.192 E.14612
G1 X134.564 Y120.222 F30000
G1 F12196
G2 X136.253 Y128.916 I-6.562 J5.785 E1.40369
G2 X136.534 Y124.092 I-8.352 J-2.908 E.15038
G1 X136.284 Y123.187 E.02886
G2 X134.602 Y120.269 I-8.477 J2.942 E.1041
G1 X134.281 Y120.472 F30000
G1 F12196
G2 X135.897 Y128.79 I-6.279 J5.536 E1.34316
G2 X134.319 Y120.518 I-7.936 J-2.773 E.27102
G1 X133.998 Y120.721 F30000
G1 F12196
G2 X135.74 Y128.015 I-5.996 J5.287 E1.30349
G2 X134.036 Y120.767 I-7.77 J-1.998 E.23791
G1 X133.715 Y120.97 F30000
G1 F12196
G2 X135.511 Y127.288 I-5.713 J5.038 E1.26184
G2 X133.753 Y121.016 I-7.55 J-1.267 E.20673
G1 X131.696 Y122.462 F30000
G1 F12196
G3 X132.686 Y123.934 I-3.815 J3.636 E.05478
G1 X132.966 Y124.734 E.02605
G1 X133.101 Y125.507 E.02411
G1 X133.117 Y126.291 E.02411
G3 X132.017 Y129.182 I-5.295 J-.359 E.09642
G1 X131.484 Y129.758 E.02411
G3 X128.688 Y131.079 I-3.566 J-3.931 E.09642
G1 X127.905 Y131.124 E.02411
G3 X124.974 Y130.136 I.156 J-5.305 E.09642
G1 X124.378 Y129.626 E.02411
G3 X122.952 Y126.882 I3.791 J-3.714 E.09642
G1 X122.876 Y126.101 E.02411
G3 X123.355 Y123.838 I5.566 J-.005 E.07159
G1 X123.751 Y123.135 E.0248
G1 X124.238 Y122.52 E.02411
G3 X126.142 Y121.226 I4.02 J3.867 E.07126
G1 X126.925 Y120.989 E.02513
G1 X127.703 Y120.884 E.02411
G3 X129.96 Y121.267 I.215 J5.567 E.07084
G1 X130.7 Y121.644 E.02554
G1 X131.334 Y122.108 E.02411
G1 X131.653 Y122.42 E.01373
G1 X131.638 Y123.59 F30000
G1 F12196
G1 X132.011 Y124.269 E.02377
G1 X132.247 Y124.962 E.0225
G1 X132.356 Y125.622 E.02057
G1 X132.362 Y126.291 E.02057
G1 X132.267 Y126.954 E.02057
G1 X132.094 Y127.523 E.01829
G1 X131.78 Y128.197 E.02283
G1 X131.4 Y128.748 E.02057
G1 X130.941 Y129.235 E.02057
G1 X130.413 Y129.646 E.02057
G1 X129.893 Y129.937 E.0183
G1 X129.2 Y130.204 E.02281
G1 X128.544 Y130.338 E.02057
G1 X127.876 Y130.37 E.02057
G1 X127.21 Y130.3 E.02057
G1 X126.661 Y130.156 E.01745
G1 X125.949 Y129.861 E.02366
G1 X125.384 Y129.503 E.02057
G1 X124.88 Y129.063 E.02057
G1 X124.449 Y128.551 E.02057
G3 X124.101 Y127.979 I3.551 J-2.551 E.02059
G1 X123.845 Y127.36 E.02057
G1 X123.686 Y126.71 E.02057
G1 X123.628 Y126.043 E.02057
G1 X123.673 Y125.375 E.02057
G1 X123.789 Y124.847 E.01662
G1 X124.054 Y124.12 E.02378
G1 X124.399 Y123.52 E.02126
G1 X124.82 Y123 E.02057
G1 X125.315 Y122.549 E.02057
G1 X125.766 Y122.249 E.01663
G1 X126.451 Y121.914 E.02344
G1 X127.125 Y121.716 E.02159
G1 X127.789 Y121.633 E.02057
G1 X128.458 Y121.652 E.02057
G1 X128.964 Y121.743 E.01578
G1 X129.705 Y121.977 E.02387
G1 X130.34 Y122.307 E.022
G1 X130.876 Y122.707 E.02057
G1 X131.345 Y123.185 E.02057
G1 X131.603 Y123.542 E.01352
G1 X133.494 Y126 F30000
G1 F12196
G3 X133.172 Y127.865 I-5.64 J-.013 E.05842
G1 X132.794 Y128.699 E.02814
G1 X132.326 Y129.399 E.02588
G3 X131.099 Y130.546 I-4.93 J-4.046 E.05176
G1 X130.433 Y130.93 E.02362
G1 X129.583 Y131.269 E.02813
G1 X128.76 Y131.449 E.02588
G3 X127.08 Y131.424 I-.746 J-6.353 E.05176
G3 X125.483 Y130.892 I1.123 J-6.036 E.05191
G1 X124.769 Y130.453 E.02574
G3 X123.129 Y128.557 I3.479 J-4.667 E.07764
G1 X122.796 Y127.783 E.02588
G1 X122.584 Y126.968 E.02588
G1 X122.5 Y126.13 E.02588
G3 X123.005 Y123.697 I5.898 J-.045 E.07692
G1 X123.427 Y122.942 E.02658
G1 X123.947 Y122.28 E.02588
G3 X125.988 Y120.881 I4.285 J4.066 E.07659
G1 X126.825 Y120.625 E.0269
G1 X127.66 Y120.509 E.02588
G3 X130.087 Y120.912 I.268 J5.894 E.07617
G1 X130.881 Y121.313 E.02731
G1 X131.562 Y121.808 E.02588
G3 X133.024 Y123.767 I-3.91 J4.443 E.07566
G1 X133.326 Y124.62 E.02782
G1 X133.474 Y125.449 E.02588
G1 X133.492 Y125.94 E.01508
G1 X137.113 Y125.6 F30000
G1 F12196
G2 X132.096 Y134.159 I-9.117 J.406 E1.43954
G2 X137.114 Y125.66 I-4.08 J-8.141 E.32054
G1 X132.239 Y130.061 F30000
G1 F12196
G3 X130.613 Y131.262 I-4.336 J-4.172 E.0624
G3 X129.7 Y131.627 I-2.7 J-5.419 E.03026
G1 X128.832 Y131.819 E.02732
G3 X127.037 Y131.799 I-.821 J-6.742 E.0553
G1 X126.261 Y131.611 E.02454
G3 X125.327 Y131.236 I1.655 J-5.47 E.03095
G1 X124.564 Y130.769 E.02748
G3 X122.805 Y128.749 I3.669 J-4.973 E.08297
G1 X122.446 Y127.924 E.02765
G1 X122.217 Y127.054 E.02765
G3 X122.151 Y125.496 I6.187 J-1.045 E.04802
G3 X122.35 Y124.379 I4.899 J.297 E.03497
G1 X122.655 Y123.556 E.02695
G1 X123.103 Y122.749 E.02835
G3 X124.124 Y121.59 I5.185 J3.54 E.04761
G3 X125.054 Y120.914 I3.341 J3.613 E.03539
G1 X125.834 Y120.537 E.02662
G1 X126.725 Y120.262 E.02867
G3 X128.266 Y120.135 I1.281 J6.15 E.04762
G3 X130.214 Y120.557 I-.289 J6.04 E.06154
G1 X131.061 Y120.982 E.02909
G3 X132.432 Y122.139 I-3.497 J5.535 E.05531
G3 X133.391 Y123.656 I-5.091 J4.277 E.05531
G1 X133.685 Y124.507 E.02765
G3 X133.871 Y126.291 I-6.363 J1.564 E.05531
G3 X133.509 Y128.049 I-6.679 J-.458 E.05531
G1 X133.132 Y128.866 E.02765
G1 X132.634 Y129.616 E.02765
G1 X132.279 Y130.016 E.01644
G1 X126.761 Y129.793 F30000
G1 F12196
G1 X126.104 Y129.517 E.02188
G3 X124.404 Y124.261 I1.935 J-3.529 E.18709
G1 X124.723 Y123.713 E.01949
G3 X127.225 Y122.08 I3.369 J2.428 E.0939
G3 X130.16 Y122.638 I.744 J4.085 E.0939
G3 X131.888 Y125.075 I-2.297 J3.459 E.0939
G3 X131.734 Y127.41 I-3.851 J.919 E.07297
G1 X131.442 Y128.03 E.02106
G3 X129.713 Y129.605 I-3.412 J-2.009 E.07298
G1 X129.073 Y129.849 E.02104
G3 X126.819 Y129.808 I-1.059 J-3.777 E.07027
G1 X124.3 Y128.963 F30000
G1 F12196
G3 X123.495 Y127.501 I3.925 J-3.115 E.05152
G1 X123.319 Y126.796 E.02234
G1 X123.252 Y126.072 E.02234
G1 X123.297 Y125.347 E.02234
G1 X123.422 Y124.761 E.01839
G1 X123.705 Y123.979 E.02555
G1 X124.075 Y123.327 E.02303
G1 X124.529 Y122.76 E.02234
G1 X125.064 Y122.268 E.02234
G1 X125.561 Y121.933 E.0184
G1 X126.297 Y121.57 E.02521
G1 X127.025 Y121.353 E.02336
G1 X127.746 Y121.258 E.02234
G1 X128.473 Y121.275 E.02234
G1 X129.036 Y121.373 E.01755
G1 X129.832 Y121.622 E.02564
G1 X130.52 Y121.976 E.02377
G1 X131.105 Y122.407 E.02234
G1 X131.617 Y122.923 E.02234
G3 X132.728 Y125.565 I-3.81 J3.158 E.08933
G1 X132.74 Y126.291 E.02234
G3 X131.709 Y128.965 I-4.934 J-.367 E.08933
G1 X131.213 Y129.497 E.02234
G3 X128.616 Y130.708 I-3.301 J-3.686 E.08933
G1 X127.89 Y130.747 E.02234
G3 X125.179 Y129.82 I.177 J-4.945 E.08933
G1 X124.629 Y129.344 E.02234
G1 X124.339 Y129.009 E.01363
G1 X123.823 Y130.727 F30000
; LINE_WIDTH: 0.537353
G1 F12196
G3 X122.771 Y129.542 I4.684 J-5.217 E.06398
G3 X122.042 Y128.087 I7.103 J-4.471 E.06566
G3 X124.243 Y131.076 I5.957 J-2.081 E1.44568
G1 X123.869 Y130.765 E.01959
G1 X123.486 Y131.092 F30000
; LINE_WIDTH: 0.537291
G1 F12196
G2 X122.699 Y130.267 I4.511 J-5.093 E1.67606
G2 X123.443 Y131.05 I4.517 J-3.543 E.04358
; CHANGE_LAYER
; Z_HEIGHT: 0.6
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F12743.485
G1 X123.078 Y130.703 E-.19133
G1 X122.699 Y130.267 E-.2196
G1 X122.33 Y129.764 E-.2369
G1 X122.177 Y129.512 E-.11217
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 3/250
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
G3 Z.8 I.73 J.973 P1  F30000
G1 X130.417 Y123.329 Z.8
G1 Z.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F11983
G1 X130.78 Y123.707 E.0174
G3 X127.314 Y122.462 I-2.78 J2.293 E.62289
G1 X127.702 Y122.417 E.01296
G1 X127.862 Y122.399 E.00534
G3 X130.373 Y123.288 I.138 J3.601 E.09052
G1 X130.136 Y123.603 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F11983
G3 X130.76 Y124.359 I-2.124 J2.388 E.03024
G3 X127.747 Y122.807 I-2.753 J1.643 E.50922
G3 X130.091 Y123.564 I.265 J3.185 E.07769
M204 S10000
; WIPE_START
G1 F12000
G1 X130.477 Y123.957 E-.20946
G1 X130.76 Y124.359 E-.18679
G1 X130.978 Y124.8 E-.18678
G1 X131.118 Y125.244 E-.17696
; WIPE_END
G1 E-.04 F1800
G1 X137.479 Y126.807 Z1 F30000
G1 Z.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F11983
G3 X125.994 Y116.691 I-9.483 J-.81 E1.39401
G3 X128.432 Y116.489 I2.091 J10.382 E.08133
G3 X137.483 Y126.747 I-.436 J9.508 E.50638
G1 X137.879 Y126.842 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F11983
G1 X137.762 Y127.674 E.02581
G3 X125.911 Y116.308 I-9.767 J-1.678 E1.31865
G3 X128.449 Y116.097 I2.178 J10.813 E.07842
G3 X137.873 Y126.79 I-.454 J9.9 E.4888
M204 S10000
; WIPE_START
G1 F12000
G1 X137.762 Y127.674 E-.3385
G1 X137.595 Y128.498 E-.31966
G1 X137.516 Y128.755 E-.10184
; WIPE_END
G1 E-.04 F1800
G1 X129.963 Y129.847 Z1 F30000
G1 X122.674 Y130.901 Z1
G1 Z.6
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.419999
G1 F11983
G2 X120.889 Y124.648 I5.324 J-4.901 E1.1899
G2 X122.635 Y130.855 I7.128 J1.344 E.20533
G1 X126.765 Y129.794 F30000
G1 F11983
G1 X126.104 Y129.517 E.02203
G3 X124.186 Y124.808 I1.944 J-3.537 E.16902
G3 X127.225 Y122.08 I3.871 J1.255 E.13146
G3 X130.16 Y122.638 I.744 J4.085 E.0939
G3 X131.888 Y125.075 I-2.297 J3.459 E.0939
G3 X131.734 Y127.41 I-3.851 J.919 E.07297
G1 X131.442 Y128.03 E.02106
G3 X129.725 Y129.598 I-3.407 J-2.005 E.07255
G1 X129.073 Y129.849 E.02147
G3 X126.823 Y129.809 I-1.058 J-3.776 E.07012
G1 X127.376 Y130.699 F30000
G1 F11983
G3 X125.795 Y130.206 I.686 J-4.976 E.0511
G1 X125.179 Y129.82 E.02234
G1 X124.629 Y129.344 E.02234
G3 X123.319 Y126.796 I3.557 J-3.44 E.08933
G1 X123.252 Y126.072 E.02234
G1 X123.297 Y125.347 E.02234
G1 X123.422 Y124.761 E.01839
G1 X123.713 Y123.958 E.02626
G1 X124.075 Y123.327 E.02234
G1 X124.529 Y122.76 E.02234
G1 X125.064 Y122.268 E.02234
G1 X125.569 Y121.928 E.0187
G1 X126.297 Y121.57 E.02492
G1 X127.025 Y121.353 E.02336
G1 X127.746 Y121.258 E.02234
G1 X128.473 Y121.275 E.02234
G1 X129.036 Y121.373 E.01755
G1 X129.832 Y121.622 E.02564
G1 X130.52 Y121.976 E.02377
G1 X131.105 Y122.407 E.02234
G1 X131.617 Y122.923 E.02234
G3 X132.728 Y125.565 I-3.81 J3.158 E.08933
G1 X132.74 Y126.291 E.02234
G3 X131.709 Y128.965 I-4.934 J-.367 E.08933
G1 X131.213 Y129.497 E.02234
G3 X128.616 Y130.708 I-3.301 J-3.686 E.08933
G1 X127.89 Y130.747 E.02234
G1 X127.435 Y130.705 E.01404
G1 X132.239 Y130.061 F30000
G1 F11983
G3 X129.7 Y131.627 I-4.287 J-4.11 E.09267
G1 X128.832 Y131.819 E.02733
G3 X127.037 Y131.799 I-.821 J-6.742 E.0553
G1 X126.266 Y131.612 E.02439
G3 X125.327 Y131.236 I1.753 J-5.729 E.0311
G1 X124.564 Y130.769 E.02749
G3 X123.285 Y129.51 I4.112 J-5.457 E.0553
G3 X122.446 Y127.924 I5.323 J-3.833 E.05531
G1 X122.217 Y127.054 E.02765
G3 X122.151 Y125.496 I6.187 J-1.045 E.04802
G3 X122.35 Y124.379 I4.899 J.297 E.03497
G1 X122.664 Y123.535 E.02765
G1 X123.103 Y122.749 E.02765
G3 X124.124 Y121.59 I5.185 J3.54 E.04761
G3 X125.054 Y120.914 I3.349 J3.625 E.03539
G1 X125.834 Y120.537 E.02662
G1 X126.725 Y120.262 E.02867
G3 X128.276 Y120.136 I1.282 J6.15 E.04791
G3 X130.214 Y120.557 I-.3 J6.044 E.06125
G1 X131.061 Y120.982 E.02909
G3 X132.432 Y122.139 I-3.666 J5.736 E.0553
G3 X133.391 Y123.656 I-5.091 J4.277 E.05531
G1 X133.685 Y124.507 E.02765
G3 X133.871 Y126.291 I-6.363 J1.564 E.05531
G3 X133.509 Y128.049 I-6.679 J-.458 E.05531
G1 X133.132 Y128.866 E.02765
G1 X132.634 Y129.616 E.02765
G1 X132.279 Y130.016 E.01644
G1 X137.113 Y125.6 F30000
G1 F11983
G2 X131.404 Y134.472 I-9.116 J.407 E1.41616
G2 X137.114 Y125.66 I-3.424 J-8.475 E.34369
G1 X133.494 Y126 F30000
G1 F11983
G3 X133.172 Y127.865 I-5.64 J-.013 E.05842
G1 X132.794 Y128.699 E.02814
G1 X132.326 Y129.399 E.02588
G3 X131.099 Y130.546 I-4.93 J-4.046 E.05176
G1 X130.445 Y130.924 E.02318
G1 X129.583 Y131.269 E.02856
G1 X128.76 Y131.449 E.02588
G3 X127.08 Y131.424 I-.746 J-6.352 E.05176
G3 X125.483 Y130.892 I1.163 J-6.157 E.0519
G1 X124.769 Y130.453 E.02574
G3 X123.576 Y129.27 I3.895 J-5.123 E.05176
G3 X122.796 Y127.783 I4.975 J-3.56 E.05177
G1 X122.584 Y126.968 E.02588
G1 X122.5 Y126.13 E.02588
G3 X123.014 Y123.676 I5.91 J-.044 E.07762
G1 X123.427 Y122.942 E.02588
G1 X123.947 Y122.28 E.02588
G3 X125.988 Y120.881 I4.285 J4.066 E.07659
M73 P27 R19
G1 X126.825 Y120.625 E.0269
G1 X127.66 Y120.509 E.02588
G3 X130.087 Y120.912 I.27 J5.884 E.07617
G1 X130.881 Y121.313 E.02731
G1 X131.562 Y121.808 E.02588
G3 X133.026 Y123.769 I-3.911 J4.444 E.07575
G1 X133.326 Y124.62 E.02773
G1 X133.474 Y125.449 E.02588
G1 X133.492 Y125.94 E.01508
G1 X131.638 Y123.59 F30000
G1 F11983
G1 X132.012 Y124.271 E.02387
G1 X132.247 Y124.962 E.02241
G1 X132.356 Y125.622 E.02057
G1 X132.362 Y126.291 E.02057
G1 X132.267 Y126.954 E.02057
G1 X132.094 Y127.523 E.01829
G1 X131.78 Y128.197 E.02283
G1 X131.4 Y128.748 E.02057
G1 X130.941 Y129.235 E.02057
G1 X130.413 Y129.646 E.02057
G1 X129.905 Y129.93 E.01787
G1 X129.2 Y130.204 E.02324
G1 X128.544 Y130.338 E.02057
G1 X127.876 Y130.37 E.02057
G1 X127.21 Y130.3 E.02057
G1 X126.665 Y130.157 E.0173
G1 X125.949 Y129.861 E.0238
G1 X125.384 Y129.503 E.02057
G1 X124.88 Y129.063 E.02057
G1 X124.449 Y128.551 E.02057
G1 X124.16 Y128.078 E.01703
G1 X123.847 Y127.366 E.02388
G1 X123.686 Y126.71 E.02076
G1 X123.628 Y126.043 E.02057
G1 X123.673 Y125.375 E.02057
G1 X123.789 Y124.847 E.01662
G1 X124.063 Y124.099 E.02448
G1 X124.399 Y123.52 E.02057
G1 X124.82 Y123 E.02057
G1 X125.315 Y122.549 E.02057
G1 X125.774 Y122.244 E.01693
G1 X126.451 Y121.914 E.02315
G1 X127.125 Y121.716 E.02159
G1 X127.789 Y121.633 E.02057
G1 X128.458 Y121.652 E.02057
G1 X128.964 Y121.743 E.01578
G1 X129.705 Y121.977 E.02387
G1 X130.34 Y122.307 E.022
G1 X130.876 Y122.707 E.02057
G1 X131.345 Y123.185 E.02057
G1 X131.603 Y123.542 E.01352
G1 X131.696 Y122.462 F30000
G1 F11983
G3 X132.688 Y123.937 I-3.817 J3.638 E.05487
G1 X132.966 Y124.734 E.02596
G1 X133.101 Y125.507 E.02411
G1 X133.117 Y126.291 E.02411
G3 X132.017 Y129.182 I-5.295 J-.359 E.09642
G1 X131.484 Y129.758 E.02411
G3 X128.688 Y131.078 I-3.566 J-3.931 E.09642
G1 X127.905 Y131.124 E.02411
G3 X124.974 Y130.136 I.156 J-5.305 E.09642
G1 X124.378 Y129.626 E.02411
G3 X122.952 Y126.882 I3.791 J-3.714 E.09642
G1 X122.876 Y126.101 E.02411
G3 X123.751 Y123.135 I5.307 J-.047 E.09642
G1 X124.238 Y122.52 E.02411
G3 X126.142 Y121.226 I4.02 J3.867 E.07126
G1 X126.925 Y120.989 E.02513
G1 X127.703 Y120.884 E.02411
G3 X129.96 Y121.267 I.217 J5.555 E.07084
G1 X130.7 Y121.644 E.02554
G1 X131.334 Y122.108 E.02411
G1 X131.653 Y122.42 E.01373
G1 X132.333 Y119.741 F30000
G1 F11983
G2 X135.516 Y124.757 I-4.329 J6.266 E1.28288
G2 X132.381 Y119.777 I-7.504 J1.248 E.18567
G1 X132.545 Y119.429 F30000
G1 F11983
G2 X135.978 Y125.531 I-4.546 J6.574 E1.32049
G2 X132.593 Y119.465 I-7.986 J.479 E.22079
G1 X134.281 Y120.471 F30000
G1 F11983
G2 X135.897 Y128.79 I-6.279 J5.536 E1.34315
G2 X134.319 Y120.518 I-7.936 J-2.773 E.27103
G1 X134.564 Y120.222 F30000
G1 F11983
G2 X136.253 Y128.916 I-6.562 J5.785 E1.40368
G2 X136.534 Y124.092 I-8.352 J-2.908 E.15038
G1 X136.28 Y123.173 E.0293
G2 X134.602 Y120.269 I-8.485 J2.964 E.10367
G1 X128.292 Y119.699 F30000
; LINE_WIDTH: 0.537365
G1 F11983
G3 X122.26 Y123.372 I-.296 J6.303 E1.29531
G1 X122.729 Y122.527 E.03894
G3 X128.232 Y119.698 I5.267 J3.477 E.26058
G1 X128.323 Y119.203 F30000
; LINE_WIDTH: 0.537308
G1 F11983
G2 X129.444 Y119.35 I-.317 J6.796 E1.67653
G2 X128.383 Y119.209 I-1.359 J6.176 E.04319
; CHANGE_LAYER
; Z_HEIGHT: 0.8
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F12743.034
G1 X128.944 Y119.261 E-.21409
G1 X129.444 Y119.35 E-.19313
G1 X130.023 Y119.502 E-.22741
G1 X130.333 Y119.614 E-.12537
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 4/250
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
G3 Z1 I-1.217 J.027 P1  F30000
G1 X130.417 Y123.329 Z1
G1 Z.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4481
G1 X130.78 Y123.707 E.0174
G3 X127.314 Y122.462 I-2.78 J2.293 E.62289
G1 X127.656 Y122.423 E.01144
G1 X127.862 Y122.399 E.00687
G3 X130.373 Y123.288 I.138 J3.601 E.09051
G1 X130.131 Y123.609 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4481
G3 X130.978 Y124.8 I-2.138 J2.416 E.0453
G3 X127.701 Y122.812 I-2.971 J1.204 E.49273
G3 X130.086 Y123.569 I.292 J3.212 E.07895
M204 S10000
; WIPE_START
G1 F12000
G1 X130.477 Y123.957 E-.2093
G1 X130.76 Y124.359 E-.18679
G1 X130.978 Y124.8 E-.18678
G1 X131.118 Y125.244 E-.17712
; WIPE_END
G1 E-.04 F1800
G1 X137.48 Y126.807 Z1.2 F30000
G1 Z.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4481
G3 X126.79 Y116.555 I-9.483 J-.811 E1.42081
G3 X128.418 Y116.487 I1.379 J13.627 E.05408
G3 X137.485 Y126.747 I-.422 J9.509 E.50688
G1 X137.879 Y126.842 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4481
G1 X137.764 Y127.674 E.02581
G3 X125.911 Y116.308 I-9.769 J-1.676 E1.31894
G3 X128.452 Y116.097 I2.079 J9.636 E.07855
G3 X137.875 Y126.789 I-.457 J9.901 E.48869
M204 S10000
; WIPE_START
G1 F12000
G1 X137.764 Y127.674 E-.33913
G1 X137.595 Y128.498 E-.31968
G1 X137.517 Y128.753 E-.10119
; WIPE_END
G1 E-.04 F1800
G1 X134.582 Y121.708 Z1.2 F30000
G1 X133.235 Y118.476 Z1.2
G1 Z.8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4481
G3 X134.482 Y119.518 I-5.464 J7.809 E.05399
G1 X130.788 Y123.212 E.17333
G3 X130.788 Y128.788 I-2.79 J2.788 E.20539
G1 X134.482 Y132.482 E.17333
G3 X133.235 Y133.524 I-6.711 J-6.766 E.05399
; WIPE_START
G1 F15476.087
G1 X134.482 Y132.482 E-.61768
G1 X134.218 Y132.218 E-.14232
; WIPE_END
G1 E-.04 F1800
G1 X128.182 Y127.546 Z1.2 F30000
G1 X124.329 Y124.563 Z1.2
G1 Z.8
G1 E.8 F1800
G1 F4481
G3 X125.208 Y123.208 I3.168 J1.092 E.0541
G1 X121.518 Y119.518 E.17314
G2 X118.937 Y124.613 I6.525 J6.505 E.19264
G1 X129.386 Y135.062 E.49016
G3 X126.614 Y135.062 I-1.386 J-9.194 E.09228
G1 X137.063 Y124.613 E.49016
G3 X137.063 Y127.387 I-12.295 J1.387 E.0922
G1 X126.614 Y116.938 E.49016
G3 X129.386 Y116.938 I1.386 J9.248 E.09227
G1 X118.937 Y127.387 E.49016
G2 X121.518 Y132.482 I9.106 J-1.41 E.19264
G1 X125.208 Y128.792 E.17314
G2 X126.562 Y129.675 I2.941 J-3.029 E.05395
; CHANGE_LAYER
; Z_HEIGHT: 1
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F15476.087
G1 X126.112 Y129.473 E-.18762
G1 X125.604 Y129.144 E-.22998
G1 X125.208 Y128.792 E-.20116
G1 X124.945 Y129.055 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 5/250
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
G3 Z1.2 I.88 J.841 P1  F30000
G1 X130.416 Y123.329 Z1.2
G1 Z1
G1 E.8 F1800
; FEATURE: Inner wall
G1 F5420
G1 X130.778 Y123.709 E.0174
G3 X127.314 Y122.462 I-2.779 J2.286 E.62181
G1 X127.611 Y122.428 E.00991
G1 X127.862 Y122.399 E.00839
G3 X130.372 Y123.289 I.137 J3.596 E.09049
G1 X130.135 Y123.604 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5420
G3 X127.389 Y122.848 I-2.136 J2.391 E.52825
G1 X127.656 Y122.817 E.00826
G1 X127.877 Y122.792 E.00685
G3 X130.09 Y123.565 I.122 J3.204 E.07374
M204 S10000
; WIPE_START
G1 F12000
G1 X130.477 Y123.957 E-.20944
G1 X130.76 Y124.359 E-.18679
G1 X130.978 Y124.8 E-.18678
G1 X131.118 Y125.244 E-.17699
; WIPE_END
G1 E-.04 F1800
G1 X137.478 Y126.807 Z1.4 F30000
G1 Z1
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5420
G3 X126.79 Y116.555 I-9.484 J-.81 E1.42106
G3 X128.43 Y116.488 I1.357 J13.238 E.05445
G3 X137.483 Y126.747 I-.436 J9.509 E.50642
G1 X137.879 Y126.842 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5420
G1 X137.764 Y127.674 E.02582
G3 X125.097 Y116.52 I-9.769 J-1.676 E1.2931
G3 X128.463 Y116.098 I2.973 J10.076 E.1047
G3 X137.875 Y126.789 I-.468 J9.901 E.48832
M204 S10000
; WIPE_START
G1 F12000
G1 X137.764 Y127.674 E-.33911
G1 X137.595 Y128.498 E-.31968
G1 X137.517 Y128.753 E-.10121
; WIPE_END
G1 E-.04 F1800
G1 X136.856 Y128.336 Z1.4 F30000
G1 Z1
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.38292
G1 F5420
G2 X137.115 Y126.809 I-7.79 J-2.109 E.04298
G1 X135.527 Y131.237 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F5420
G3 X134.482 Y132.482 I-8.143 J-5.766 E.05399
G1 X131.054 Y129.054 E.16082
G2 X131.054 Y122.946 I-3.057 J-3.054 E.22504
G1 X134.216 Y119.784 E.14831
G2 X129.055 Y117.27 I-6.252 J6.278 E.19395
G1 X119.274 Y127.05 E.45881
G3 X119.209 Y126.129 I5.379 J-.843 E.03067
G1 X118.917 Y126.053 E.01
G1 X118.834 Y126.189 E.00528
G3 X118.845 Y125.555 I3.728 J-.253 E.02105
G1 X119.224 Y125.52 E.01262
G3 X119.274 Y124.95 I3.373 J.01 E.019
G1 X129.054 Y134.73 E.45881
G1 X128.44 Y134.783 E.02046
G1 X128.385 Y135.166 E.01283
G1 X127.717 Y135.166 E.02215
G1 X127.844 Y135.087 E.00494
G1 X127.776 Y134.801 E.00975
G1 X126.945 Y134.73 E.02764
G1 X136.726 Y124.95 E.45881
G3 X136.787 Y125.782 I-4.854 J.776 E.02769
G1 X137.078 Y125.858 E.00997
G1 X137.162 Y125.722 E.00529
G3 X137.158 Y126.383 I-3.884 J.304 E.02195
G1 X136.778 Y126.441 E.01275
G3 X136.726 Y127.05 I-3.601 J0 E.02028
G1 X126.946 Y117.27 E.45881
G2 X125.353 Y117.608 I1.595 J11.432 E.05405
G1 X125.198 Y117.338 E.01032
G1 X125.304 Y117.232 E.00497
G2 X121.518 Y119.518 I3.289 J9.727 E.14788
G1 X124.941 Y122.941 E.16061
G2 X124.941 Y129.059 I3.086 J3.059 E.22513
G1 X121.784 Y132.216 E.1481
G3 X120.743 Y130.967 I6.933 J-6.841 E.05399
G1 X118.885 Y126.811 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.38292
G1 F5420
G2 X127.062 Y135.101 I9.112 J-.81 E.3497
G1 X128.758 Y135.12 F30000
G1 F5420
G1 X129.923 Y134.955 E.0326
G1 X130.285 Y134.861 E.01035
; WIPE_START
G1 F15000
G1 X129.923 Y134.955 E-.18315
G1 X128.758 Y135.12 E-.57685
; WIPE_END
G1 E-.04 F1800
G1 X125.951 Y128.022 Z1.4 F30000
G1 X124.451 Y124.229 Z1.4
G1 Z1
G1 E.8 F1800
G1 F5420
G2 X124.763 Y123.708 I3.544 J1.768 E.67266
G1 X124.481 Y124.178 E.01516
G1 X118.883 Y125.192 F30000
G1 F5420
G3 X119.064 Y124.032 I6.371 J.399 E.03258
G1 X125.976 Y117.072 F30000
; LINE_WIDTH: 0.384573
G1 F5420
G3 X127.122 Y116.896 I2.158 J10.184 E.0323
G1 X128.797 Y116.885 F30000
; LINE_WIDTH: 0.38292
G1 F5420
G1 X129.923 Y117.045 E.03151
G3 X137.101 Y125.053 I-1.942 J8.962 E.31838
; CHANGE_LAYER
; Z_HEIGHT: 1.2
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F15000
G1 X137.026 Y124.445 E-.2327
G1 X136.862 Y123.686 E-.29542
G1 X136.683 Y123.102 E-.23188
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 6/250
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
G3 Z1.4 I-.044 J-1.216 P1  F30000
G1 X130.416 Y123.329 Z1.4
G1 Z1.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X130.78 Y123.707 E.01741
G3 X127.314 Y122.462 I-2.78 J2.293 E.62289
G1 X127.565 Y122.433 E.00839
G1 X127.862 Y122.399 E.00991
G3 X130.373 Y123.288 I.138 J3.601 E.09051
G1 X130.136 Y123.603 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
G3 X127.389 Y122.848 I-2.136 J2.397 E.52914
G1 X127.61 Y122.823 E.00685
G1 X127.877 Y122.792 E.00826
G3 X130.091 Y123.564 I.123 J3.208 E.07375
M204 S10000
; WIPE_START
G1 X130.477 Y123.957 E-.20947
G1 X130.76 Y124.359 E-.18679
G1 X130.978 Y124.8 E-.18678
G1 X131.118 Y125.244 E-.17696
; WIPE_END
G1 E-.04 F1800
G1 X137.477 Y126.807 Z1.6 F30000
G1 Z1.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F15476.087
G3 X125.994 Y116.691 I-9.483 J-.81 E1.39405
G3 X128.441 Y116.489 I1.995 J9.243 E.08169
G3 X137.482 Y126.747 I-.447 J9.507 E.50601
G1 X137.879 Y126.842 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
G1 X137.762 Y127.674 E.02582
G3 X125.097 Y116.52 I-9.768 J-1.676 E1.29303
G3 X128.474 Y116.099 I2.968 J10.05 E.10505
G3 X137.873 Y126.791 I-.481 J9.899 E.48797
M204 S10000
; WIPE_START
G1 X137.762 Y127.674 E-.33827
G1 X137.595 Y128.498 E-.31966
G1 X137.516 Y128.755 E-.10208
; WIPE_END
G1 E-.04 F1800
G1 X133.852 Y131.852 Z1.6 F30000
G1 Z1.2
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X134.482 Y132.482 E.02958
G1 X129.943 Y135.15 F30000
; FEATURE: Bridge
; LINE_WIDTH: 0.406429
; LAYER_HEIGHT: 0.4
G1 F3000
G1 X136.876 Y128.217 E.51827
G1 X137.038 Y127.409 E.04353
G1 X129.412 Y135.035 E.57008
G3 X128.826 Y135.107 I-.712 J-3.405 E.03123
G1 X128.848 Y134.954 E.00818
G1 X136.954 Y126.848 E.60595
G1 X136.192 Y126.965 E.04078
G1 X128.956 Y134.2 E.54088
G1 X129.005 Y133.863 E.01799
G1 X128.066 Y134.445 E.05838
G1 X136.445 Y126.066 E.62638
G1 X137.093 Y125.019 E.06507
G1 X137.065 Y124.8 E.01167
G1 X126.795 Y135.071 E.76775
G1 X126.244 Y134.976 E.02955
G1 X136.976 Y124.244 E.80225
G1 X136.861 Y123.713 E.02871
G1 X125.719 Y134.855 E.83289
G3 X125.215 Y134.714 I.577 J-3.034 E.02772
G1 X136.711 Y123.218 E.85939
G2 X136.544 Y122.739 I-2.896 J.741 E.02683
G1 X131.577 Y127.706 E.37132
G1 X131.687 Y127.486 E.01301
G1 X131.87 Y126.906 E.03216
G1 X131.895 Y126.743 E.0087
G1 X136.359 Y122.279 E.33372
G2 X136.146 Y121.846 I-2.647 J1.035 E.02551
G1 X131.963 Y126.03 E.31272
G2 X131.921 Y125.426 I-1.975 J-.167 E.03212
G1 X135.922 Y121.425 E.29905
G1 X135.676 Y121.026 E.0248
G1 X131.807 Y124.895 E.28921
G1 X131.687 Y124.514 E.0211
G1 X131.639 Y124.418 E.0057
G1 X135.412 Y120.644 E.28208
G1 X135.138 Y120.273 E.0244
G1 X131.425 Y123.986 E.27754
G1 X131.16 Y123.605 E.02452
G1 X134.837 Y119.928 E.27485
G2 X134.528 Y119.591 I-2.133 J1.645 E.02418
G1 X130.862 Y123.258 E.27412
G2 X130.529 Y122.945 I-1.18 J.919 E.02423
G1 X134.199 Y119.275 E.27431
G2 X133.854 Y118.974 I-1.941 J1.873 E.02421
G1 X130.163 Y122.666 E.27595
G1 X129.745 Y122.438 E.02515
G1 X133.497 Y118.686 E.28048
G2 X133.115 Y118.422 I-1.81 J2.215 E.02456
G1 X129.287 Y122.251 E.28622
G2 X128.778 Y122.114 I-.698 J1.577 E.02794
G1 X132.726 Y118.166 E.29513
G1 X132.312 Y117.935 E.02508
G1 X128.205 Y122.042 E.30703
G2 X127.537 Y122.064 I-.262 J2.172 E.03545
G1 X131.882 Y117.72 E.32476
G1 X131.437 Y117.519 E.02579
G1 X126.712 Y122.244 E.35324
G1 X126.657 Y122.259 E.00303
G2 X125.59 Y122.839 I1.344 J3.741 E.06439
G1 X125.136 Y123.244 E.03217
G2 X124.248 Y124.708 I3.202 J2.944 E.09111
G1 X119.524 Y129.432 E.35312
G2 X119.718 Y129.884 I2.753 J-.91 E.02602
G1 X124.061 Y125.541 E.32466
G1 X124.047 Y125.72 E.00948
G2 X124.041 Y126.206 I1.571 J.262 E.0258
G1 X119.934 Y130.313 E.30703
G2 X120.17 Y130.723 I2.526 J-1.179 E.02502
G1 X124.112 Y126.78 E.29475
G1 X124.211 Y127.199 E.02276
G1 X124.247 Y127.29 E.0052
G1 X120.416 Y131.122 E.28645
G2 X120.69 Y131.494 I2.32 J-1.427 E.02443
G1 X124.433 Y127.751 E.27981
G1 X124.672 Y128.157 E.02492
G1 X120.973 Y131.856 E.27652
G1 X121.275 Y132.199 E.02418
G1 X124.947 Y128.527 E.27452
G2 X125.256 Y128.863 I1.243 J-.833 E.02424
G1 X121.594 Y132.526 E.27379
G1 X121.923 Y132.842 E.02413
G1 X125.599 Y129.166 E.27475
G1 X125.991 Y129.42 E.02467
G1 X122.278 Y133.133 E.27753
G2 X122.643 Y133.413 I1.906 J-2.103 E.02436
G1 X126.421 Y129.635 E.28241
G2 X126.895 Y129.806 I.791 J-1.45 E.02676
G1 X123.027 Y133.675 E.28917
G2 X123.427 Y133.92 I1.579 J-2.13 E.02485
G1 X127.424 Y129.923 E.29878
G2 X128.028 Y129.965 I.438 J-1.933 E.0321
G1 X123.842 Y134.151 E.31294
G2 X124.283 Y134.355 I1.418 J-2.493 E.02575
G1 X128.746 Y129.892 E.33361
G1 X129.053 Y129.833 E.01654
G1 X129.694 Y129.59 E.0362
G1 X124.579 Y134.704 E.38231
G1 X119.184 Y129.127 F30000
G1 F3000
G1 X130.962 Y117.348 E.88048
G2 X130.471 Y117.194 I-1.151 J2.809 E.02725
G1 X119.194 Y128.471 E.843
G3 X119.067 Y127.953 I2.984 J-1.004 E.02826
G1 X129.958 Y117.061 E.81419
G2 X129.41 Y116.964 I-.843 J3.174 E.02949
G1 X118.962 Y127.412 E.78101
G1 X118.897 Y126.906 E.02694
M73 P28 R19
G1 X119.016 Y126.713 E.01201
G1 X128.713 Y117.016 E.72488
G1 X127.048 Y118.035 E.10319
G1 X120.035 Y125.048 E.52426
G1 X120.056 Y125.013 E.00218
G1 X119.36 Y125.077 E.03694
G1 X127.079 Y117.358 E.577
G1 X127.119 Y116.898 E.02443
G1 X126.873 Y116.919 E.01302
G1 X118.927 Y124.865 E.59405
M73 P28 R18
G3 X119.058 Y124.089 I4.63 J.383 E.0417
G1 X126.346 Y116.801 E.5448
G1 X121.518 Y119.518 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
; LAYER_HEIGHT: 0.2
G1 F15476.087
G1 X122.268 Y120.268 E.0352
; CHANGE_LAYER
; Z_HEIGHT: 1.4
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F15476.087
G1 X121.518 Y119.518 E-.76
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 7/250
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
G3 Z1.6 I-.479 J1.119 P1  F30000
G1 X130.416 Y123.329 Z1.6
G1 Z1.4
G1 E.8 F1800
; FEATURE: Inner wall
G1 F9626
G1 X130.778 Y123.709 E.0174
G3 X127.314 Y122.462 I-2.779 J2.286 E.62181
G1 X127.519 Y122.438 E.00687
G1 X127.862 Y122.399 E.01144
G3 X130.372 Y123.289 I.137 J3.596 E.09049
G1 X130.135 Y123.604 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9626
G3 X127.389 Y122.848 I-2.136 J2.391 E.52825
G1 X127.564 Y122.828 E.00544
G1 X127.877 Y122.792 E.00967
G3 X130.09 Y123.565 I.122 J3.204 E.07374
M204 S10000
; WIPE_START
G1 F12000
G1 X130.477 Y123.957 E-.20944
G1 X130.76 Y124.359 E-.18679
G1 X130.978 Y124.8 E-.18678
G1 X131.118 Y125.244 E-.17699
; WIPE_END
G1 E-.04 F1800
G1 X137.477 Y126.807 Z1.8 F30000
G1 Z1.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9626
G3 X125.212 Y116.895 I-9.483 J-.81 E1.36721
G3 X128.452 Y116.49 I2.852 J9.659 E.10882
G3 X137.482 Y126.747 I-.458 J9.506 E.50561
G1 X137.879 Y126.842 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9626
G1 X137.763 Y127.674 E.02582
G3 X124.303 Y116.8 I-9.769 J-1.675 E1.26725
G3 X128.486 Y116.1 I3.685 J9.167 E.13133
G3 X137.874 Y126.79 I-.492 J9.899 E.4876
M204 S10000
; WIPE_START
G1 F12000
G1 X137.763 Y127.674 E-.33863
G1 X137.595 Y128.498 E-.31967
G1 X137.517 Y128.754 E-.1017
; WIPE_END
G1 E-.04 F1800
G1 X133.8 Y122.088 Z1.8 F30000
G1 X132.306 Y119.409 Z1.8
G1 Z1.4
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9626
G3 X133.566 Y120.434 I-4.455 J6.768 E.05397
G1 X134.482 Y119.518 E.04298
G3 X137.063 Y124.613 I-6.525 J6.505 E.19264
G1 X135.872 Y125.804 E.05586
G3 X135.872 Y126.196 I-1.942 J.196 E.01302
G1 X137.063 Y127.387 E.05586
G3 X134.482 Y132.482 I-9.106 J-1.41 E.19264
G1 X133.566 Y131.566 E.04298
G3 X132.306 Y132.591 I-5.715 J-5.743 E.05397
G1 X126.203 Y129.562 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.419999
G1 F9626
G1 X125.589 Y129.187 E.0221
G1 X125.16 Y128.807 E.01761
G1 X124.74 Y128.311 E.01997
G3 X124.168 Y124.885 I3.247 J-2.303 E.11044
G1 X124.413 Y124.24 E.02119
G3 X128.395 Y122.027 I3.613 J1.811 E.14873
G1 X129.045 Y122.143 E.02028
G3 X131.657 Y124.405 I-1.039 J3.839 E.10984
G1 X131.888 Y125.075 E.02179
G1 X131.98 Y125.661 E.01821
G1 X131.985 Y126.292 E.01938
G3 X130.235 Y129.308 I-3.973 J-.29 E.11091
G1 X129.648 Y129.64 E.02074
G3 X126.258 Y129.586 I-1.638 J-3.612 E.10765
; WIPE_START
G1 F15000
G1 X126.663 Y129.766 E-.16843
G1 X127.253 Y129.926 E-.23247
G1 X127.861 Y129.994 E-.23249
G1 X128.194 Y129.98 E-.12662
; WIPE_END
G1 E-.04 F1800
G1 X132.495 Y127.505 Z1.8 F30000
G1 Z1.4
G1 E.8 F1800
G1 F9626
G3 X131.788 Y128.852 I-4.582 J-1.544 E.04693
G1 X131.213 Y129.497 E.02656
G1 X130.692 Y129.907 E.02038
G1 X130.008 Y130.303 E.02428
G1 X129.328 Y130.559 E.02234
G1 X128.616 Y130.708 E.02234
G1 X127.89 Y130.747 E.02234
G3 X126.389 Y130.469 I.348 J-6.071 E.04704
G1 X125.894 Y130.25 E.01662
G1 X125.179 Y129.82 E.02565
G1 X124.658 Y129.37 E.02115
G1 X124.158 Y128.791 E.02351
G1 X123.777 Y128.171 E.02234
G1 X123.495 Y127.501 E.02234
G1 X123.319 Y126.796 E.02234
G3 X123.434 Y124.713 I4.999 J-.769 E.06457
G1 X123.713 Y123.958 E.02474
G1 X124.073 Y123.331 E.02221
G1 X124.529 Y122.76 E.02247
G1 X125.064 Y122.268 E.02234
G3 X126.347 Y121.547 I3.621 J4.945 E.04531
G1 X126.906 Y121.385 E.01789
G1 X127.746 Y121.258 E.0261
G1 X128.424 Y121.273 E.02084
G1 X129.189 Y121.403 E.02382
G1 X129.876 Y121.638 E.02234
G1 X130.52 Y121.976 E.02234
G1 X131.105 Y122.407 E.02234
G3 X132.333 Y124.07 I-3.387 J3.786 E.06397
G1 X132.607 Y124.848 E.02533
G1 X132.726 Y125.546 E.02175
G1 X132.74 Y126.292 E.02292
G1 X132.639 Y127.012 E.02234
G1 X132.512 Y127.447 E.01395
G1 X133.117 Y126.004 F30000
G1 F9626
G3 X126.798 Y130.976 I-5.12 J-.006 E.2841
G3 X125.29 Y130.341 I1.277 J-5.139 E.05048
G3 X124.059 Y129.263 I2.739 J-4.371 E.05048
G3 X125.748 Y121.403 I3.946 J-3.264 E.28409
G3 X127.314 Y120.929 I2.381 J5.043 E.05046
G3 X128.949 Y120.972 I.682 J5.137 E.05048
G3 X133.114 Y125.944 I-.942 J5.02 E.21594
G1 X133.521 Y126.004 F30000
; LINE_WIDTH: 0.471195
G1 F9626
G3 X126.691 Y131.365 I-5.527 J-.01 E.34851
G3 X127.267 Y120.527 I1.312 J-5.364 E.53351
G3 X133.518 Y125.944 I.732 J5.47 E.3263
G1 X134.504 Y127.711 F30000
; LINE_WIDTH: 0.419999
G1 F9626
G1 X134.687 Y126.773 E.02938
G2 X133.885 Y122.74 I-6.846 J-.734 E.1283
G1 X133.438 Y122.032 E.02573
G2 X130.836 Y119.901 I-5.606 J4.191 E.10436
G1 X130.001 Y119.573 E.02758
G2 X125.916 Y119.605 I-1.992 J6.433 E.12754
G1 X125.108 Y119.921 E.02664
G2 X122.855 Y121.659 I3.189 J6.464 E.08802
G1 X122.544 Y122.067 E.01576
G1 X122.07 Y122.817 E.02727
G2 X121.386 Y124.768 I6.485 J3.368 E.06373
G1 X121.281 Y125.584 E.02528
G2 X121.928 Y128.894 I6.965 J.356 E.10467
G1 X122.359 Y129.673 E.02735
G2 X125.537 Y132.26 I5.639 J-3.683 E.12793
G1 X126.346 Y132.525 E.02619
G2 X129.7 Y132.507 I1.641 J-6.669 E.10409
G1 X130.548 Y132.23 E.02742
G2 X133.678 Y129.605 I-2.558 J-6.23 E.12753
G1 X134.106 Y128.834 E.0271
G2 X134.485 Y127.769 I-6.751 J-3.005 E.03479
G1 X134.951 Y123.24 F30000
G1 F9626
G1 X134.554 Y122.393 E.02873
G1 X134.067 Y121.616 E.0282
G2 X129.393 Y118.641 I-6.18 J4.551 E.17415
G2 X135.344 Y124.561 I-1.396 J7.354 E1.17128
G1 X135.137 Y123.743 E.02591
G1 X134.971 Y123.296 E.01465
G1 X131.229 Y123.064 F30000
G1 F9626
G1 X131.736 Y123.729 E.02569
G1 X131.995 Y124.238 E.01755
G1 X132.247 Y124.962 E.02356
G1 X132.353 Y125.603 E.01998
G1 X132.362 Y126.292 E.02115
G1 X132.267 Y126.954 E.02057
G1 X132.071 Y127.594 E.02057
G1 X131.78 Y128.197 E.02057
G1 X131.48 Y128.635 E.01632
G1 X130.941 Y129.235 E.02478
G1 X130.464 Y129.607 E.01861
G1 X129.828 Y129.972 E.02251
G1 X129.2 Y130.204 E.02057
G1 X128.544 Y130.338 E.02057
G1 X127.876 Y130.37 E.02057
G1 X127.21 Y130.3 E.02057
G1 X126.563 Y130.129 E.02057
G1 X126.049 Y129.906 E.01723
G1 X125.384 Y129.503 E.02387
G1 X124.909 Y129.089 E.01938
G1 X124.449 Y128.551 E.02174
G1 X124.101 Y127.979 E.02057
G1 X123.845 Y127.36 E.02057
G1 X123.686 Y126.71 E.02057
G1 X123.64 Y126.196 E.01586
G1 X123.673 Y125.375 E.02524
G1 X123.801 Y124.799 E.01815
G1 X124.063 Y124.099 E.02297
G1 X124.397 Y123.524 E.02044
G1 X124.82 Y123 E.0207
G1 X125.315 Y122.549 E.02057
G1 X125.873 Y122.18 E.02057
G3 X126.493 Y121.895 I6.988 J14.383 E.02097
G1 X127.006 Y121.749 E.01638
G1 X127.789 Y121.633 E.02433
G1 X128.41 Y121.65 E.01907
G1 X129.117 Y121.773 E.02205
G1 X129.749 Y121.993 E.02057
G1 X130.34 Y122.307 E.02057
G1 X130.876 Y122.707 E.02057
G1 X131.187 Y123.021 E.01356
G1 X132.353 Y121.379 F30000
G1 F9626
G1 X131.683 Y120.821 E.02678
G2 X126.024 Y119.966 I-3.686 J5.236 E.18232
G1 X125.255 Y120.269 E.02541
G2 X123.593 Y121.421 I3.153 J6.319 E.06234
G2 X121.701 Y126.794 I4.459 J4.59 E.1814
G1 X121.859 Y127.636 E.02632
G2 X122.684 Y129.482 I6.779 J-1.921 E.06234
G2 X127.649 Y132.34 I5.338 J-3.532 E.18253
G1 X128.47 Y132.338 E.02521
G2 X133.364 Y129.397 I-.504 J-6.381 E.18186
G1 X133.771 Y128.66 E.02587
G2 X134.315 Y126.713 I-6.453 J-2.85 E.06234
G2 X133.55 Y122.914 I-6.461 J-.675 E.12091
G1 X133.123 Y122.24 E.0245
G2 X132.395 Y121.422 I-5.441 J4.113 E.0337
G1 X131.079 Y119.6 F30000
G1 F9626
G1 X130.129 Y119.218 E.03146
G2 X128.876 Y118.952 I-1.923 J5.975 E.03942
G1 X127.965 Y118.895 E.02807
G1 X127.134 Y118.945 E.02556
G2 X123.857 Y120.231 I.942 J7.216 E.10927
G1 X123.097 Y120.853 E.03016
G2 X122.242 Y121.842 I4.371 J4.646 E.04026
G1 X121.745 Y122.626 E.0285
G2 X121.018 Y124.688 I6.859 J3.579 E.06743
G1 X120.906 Y125.544 E.02651
G2 X121.551 Y128.975 I7.316 J.401 E.10834
G1 X122.034 Y129.864 E.03107
G2 X122.836 Y130.875 I5.302 J-3.382 E.03972
G1 X123.503 Y131.502 E.02812
G1 X124.164 Y131.984 E.02514
G2 X127.523 Y133.086 I3.872 J-6.132 E.10973
G1 X128.489 Y133.091 E.0297
G2 X129.789 Y132.874 I-.404 J-6.399 E.04056
G1 X130.676 Y132.585 E.02866
G1 X131.376 Y132.256 E.02377
G1 X131.815 Y131.99 E.01578
G1 X132.55 Y131.457 E.02788
G1 X133.17 Y130.879 E.02605
G2 X134.867 Y127.811 I-5.354 J-4.966 E.1088
G1 X135.059 Y126.833 E.03062
G2 X134.219 Y122.567 I-7.23 J-.792 E.13569
G1 X133.752 Y121.824 E.02696
G2 X131.131 Y119.629 I-5.884 J4.364 E.10602
G1 X126.14 Y120.349 F30000
; LINE_WIDTH: 0.470898
G1 F9626
G1 X125.411 Y120.64 E.02735
G2 X125.84 Y131.543 I2.593 J5.358 E.48133
G1 X126.572 Y131.778 E.02683
G2 X133.194 Y123.099 I1.42 J-5.782 E.48171
G1 X132.787 Y122.463 E.02632
G2 X126.197 Y120.334 I-4.781 J3.533 E.2578
G1 X130.964 Y117.326 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9626
G2 X129.386 Y116.938 I-3.028 J8.909 E.05398
G1 X128.193 Y118.131 E.05597
G1 X127.797 Y118.121 E.01313
G1 X126.614 Y116.938 E.05549
G2 X125.036 Y117.326 I1.45 J9.298 E.05399
G1 X121.403 Y130.31 F30000
G1 F9626
G1 X121.426 Y130.348 E.00147
G2 X122.43 Y131.57 I9.261 J-6.587 E.05251
G1 X121.518 Y132.482 E.04281
G3 X118.937 Y127.387 I6.525 J-6.505 E.19264
G1 X120.129 Y126.195 E.0559
G1 X120.129 Y125.805 E.01295
G1 X118.937 Y124.613 E.0559
G3 X121.518 Y119.518 I9.106 J1.41 E.19264
G1 X122.43 Y120.43 E.04279
G2 X121.403 Y121.69 I7.331 J7.018 E.05398
G1 X125.036 Y134.674 F30000
G1 F9626
G2 X126.614 Y135.062 I3.028 J-8.909 E.05399
G1 X127.797 Y133.879 E.05547
G1 X128.193 Y133.869 E.01315
G1 X129.386 Y135.062 E.05596
G2 X130.964 Y134.674 I-1.45 J-9.298 E.05399
; CHANGE_LAYER
; Z_HEIGHT: 1.6
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F15476.087
G1 X129.386 Y135.062 E-.61765
G1 X129.121 Y134.797 E-.14235
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 8/250
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
G3 Z1.8 I1.21 J.132 P1  F30000
G1 X130.376 Y123.293 Z1.8
G1 Z1.6
G1 E.8 F1800
; FEATURE: Inner wall
G1 F9489
G1 X130.397 Y123.311 E.00089
G3 X127.314 Y122.462 I-2.397 J2.684 E.64012
G1 X127.474 Y122.444 E.00534
G1 X127.862 Y122.399 E.01296
G3 X129.958 Y122.976 I.137 J3.596 E.07327
G1 X130.329 Y123.257 E.01542
G1 X130.136 Y123.603 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9489
G1 X130.135 Y123.604 E.00005
G3 X127.389 Y122.848 I-2.136 J2.391 E.52825
G1 X127.519 Y122.833 E.00402
G1 X127.877 Y122.792 E.01108
G3 X129.745 Y123.306 I.122 J3.204 E.06047
G1 X130.088 Y123.566 E.01324
M204 S10000
; WIPE_START
G1 F12000
G1 X130.135 Y123.604 E-.02297
G1 X130.477 Y123.957 E-.18674
G1 X130.76 Y124.359 E-.18679
G1 X130.978 Y124.8 E-.18679
G1 X131.118 Y125.243 E-.17671
; WIPE_END
G1 E-.04 F1800
G1 X137.477 Y126.807 Z2 F30000
G1 Z1.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9489
G3 X125.212 Y116.895 I-9.484 J-.809 E1.36739
G3 X128.464 Y116.491 I2.847 J9.634 E.10919
G3 X137.482 Y126.747 I-.471 J9.507 E.5052
G1 X137.879 Y126.842 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9489
G1 X137.763 Y127.674 E.02583
G3 X123.536 Y117.147 I-9.769 J-1.675 E1.24138
G3 X128.497 Y116.101 I4.505 J9.077 E.15745
G3 X137.874 Y126.79 I-.503 J9.899 E.48724
M204 S10000
; WIPE_START
G1 F12000
G1 X137.763 Y127.674 E-.33866
G1 X137.595 Y128.498 E-.31967
G1 X137.517 Y128.754 E-.10167
; WIPE_END
G1 E-.04 F1800
G1 X132.306 Y132.591 Z2 F30000
G1 Z1.6
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9489
G2 X133.566 Y131.566 I-4.455 J-6.768 E.05397
G1 X134.482 Y132.482 E.04298
G2 X137.063 Y127.387 I-6.525 J-6.505 E.19264
G1 X135.872 Y126.196 E.05586
G2 X135.872 Y125.804 I-1.942 J-.196 E.01302
G1 X137.063 Y124.613 E.05586
G2 X134.482 Y119.518 I-9.106 J1.41 E.19264
G1 X133.566 Y120.434 E.04298
G2 X132.306 Y119.409 I-5.716 J5.744 E.05397
G1 X126.14 Y120.349 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.470893
G1 F9489
G1 X125.411 Y120.64 E.02735
G2 X125.84 Y131.543 I2.593 J5.358 E.48132
G1 X126.572 Y131.778 E.02683
G2 X133.194 Y123.099 I1.42 J-5.782 E.4817
G1 X132.787 Y122.463 E.02632
G2 X126.198 Y120.334 I-4.781 J3.533 E.2578
G1 X131.079 Y119.6 F30000
; LINE_WIDTH: 0.419999
G1 F9489
G1 X130.129 Y119.218 E.03146
G2 X128.876 Y118.952 I-1.923 J5.975 E.03942
G1 X127.965 Y118.895 E.02807
G1 X127.134 Y118.945 E.02556
G2 X123.857 Y120.231 I.942 J7.216 E.10927
G1 X123.097 Y120.853 E.03016
G2 X122.242 Y121.842 I4.371 J4.646 E.04026
G1 X121.745 Y122.626 E.0285
G2 X121.018 Y124.688 I6.859 J3.579 E.06743
G1 X120.906 Y125.544 E.02651
G2 X121.551 Y128.975 I7.316 J.401 E.10834
G1 X122.034 Y129.864 E.03107
G2 X122.836 Y130.875 I5.302 J-3.382 E.03972
G1 X123.503 Y131.502 E.02812
G1 X124.164 Y131.984 E.02514
G2 X127.523 Y133.086 I3.872 J-6.132 E.10973
G1 X128.489 Y133.091 E.0297
G2 X129.789 Y132.874 I-.404 J-6.399 E.04056
G1 X130.676 Y132.585 E.02866
G1 X131.376 Y132.256 E.02377
G1 X131.815 Y131.99 E.01578
G1 X132.55 Y131.457 E.02788
G1 X133.17 Y130.879 E.02605
G2 X134.867 Y127.811 I-5.354 J-4.966 E.1088
G1 X135.059 Y126.833 E.03062
G2 X134.219 Y122.567 I-7.23 J-.792 E.13569
G1 X133.752 Y121.824 E.02696
G2 X131.131 Y119.629 I-5.884 J4.364 E.10602
G1 X132.353 Y121.379 F30000
G1 F9489
G1 X131.683 Y120.821 E.02678
G2 X126.024 Y119.966 I-3.686 J5.236 E.18232
G1 X125.255 Y120.269 E.02541
G2 X123.593 Y121.421 I3.153 J6.319 E.06234
G2 X121.701 Y126.794 I4.459 J4.59 E.1814
G1 X121.859 Y127.636 E.02632
G2 X122.684 Y129.482 I6.779 J-1.921 E.06234
G2 X127.649 Y132.34 I5.338 J-3.532 E.18253
G1 X128.47 Y132.338 E.02521
G2 X133.364 Y129.397 I-.504 J-6.381 E.18186
G1 X133.771 Y128.66 E.02587
G2 X134.315 Y126.713 I-6.453 J-2.85 E.06234
G2 X133.55 Y122.914 I-6.461 J-.675 E.12091
G1 X133.123 Y122.24 E.0245
G2 X132.395 Y121.422 I-5.441 J4.113 E.0337
G1 X131.229 Y123.064 F30000
G1 F9489
G1 X131.736 Y123.729 E.02569
G1 X131.995 Y124.238 E.01755
G1 X132.247 Y124.962 E.02356
G1 X132.353 Y125.603 E.01998
G1 X132.362 Y126.292 E.02115
G1 X132.267 Y126.954 E.02057
G1 X132.071 Y127.594 E.02057
G1 X131.78 Y128.197 E.02057
G1 X131.48 Y128.635 E.01632
G1 X130.941 Y129.235 E.02478
G1 X130.464 Y129.607 E.0186
G1 X129.828 Y129.972 E.02251
G1 X129.2 Y130.204 E.02057
G1 X128.544 Y130.338 E.02057
G1 X127.876 Y130.37 E.02057
G1 X127.21 Y130.3 E.02057
G3 X126.549 Y130.125 I3.54 J-14.711 E.02101
G1 X126.049 Y129.906 E.01679
G1 X125.384 Y129.503 E.02387
G1 X124.909 Y129.089 E.01938
M73 P29 R18
G1 X124.449 Y128.551 E.02174
G1 X124.101 Y127.979 E.02057
G1 X123.845 Y127.36 E.02057
G1 X123.686 Y126.71 E.02057
G1 X123.64 Y126.196 E.01586
G1 X123.673 Y125.375 E.02524
G1 X123.801 Y124.799 E.01815
G1 X124.063 Y124.099 E.02297
G1 X124.397 Y123.524 E.02044
G1 X124.82 Y123 E.02069
G1 X125.315 Y122.549 E.02057
G1 X125.873 Y122.18 E.02057
G1 X126.481 Y121.9 E.02057
G1 X127.006 Y121.749 E.01677
G1 X127.789 Y121.633 E.02433
G1 X128.41 Y121.65 E.01907
G1 X129.117 Y121.773 E.02205
G1 X129.749 Y121.993 E.02057
G1 X130.34 Y122.307 E.02057
G1 X130.876 Y122.707 E.02057
G1 X131.187 Y123.021 E.01356
G1 X131.657 Y124.405 F30000
G1 F9489
G1 X131.888 Y125.075 E.02179
G1 X131.98 Y125.661 E.01821
G1 X131.985 Y126.292 E.01938
G3 X130.235 Y129.308 I-3.973 J-.29 E.11091
G1 X129.648 Y129.64 E.02074
G3 X125.16 Y128.807 I-1.635 J-3.698 E.14905
G1 X124.74 Y128.311 E.01997
G3 X124.168 Y124.885 I3.247 J-2.303 E.11044
G1 X124.413 Y124.24 E.02119
G3 X128.395 Y122.027 I3.585 J1.761 E.14898
G1 X129.045 Y122.143 E.02028
G3 X131.63 Y124.351 I-1.035 J3.83 E.10797
G1 X132.495 Y127.505 F30000
G1 F9489
G3 X131.788 Y128.852 I-4.582 J-1.544 E.04693
G1 X131.213 Y129.497 E.02656
G1 X130.692 Y129.907 E.02038
G1 X130.008 Y130.303 E.02428
G1 X129.328 Y130.559 E.02234
G1 X128.616 Y130.708 E.02234
G1 X127.89 Y130.747 E.02234
G3 X125.894 Y130.25 I.211 J-5.102 E.06364
G1 X125.179 Y129.82 E.02565
G1 X124.658 Y129.37 E.02115
G1 X124.158 Y128.791 E.02351
G1 X123.777 Y128.171 E.02234
G1 X123.495 Y127.501 E.02234
G1 X123.319 Y126.796 E.02234
G3 X123.434 Y124.713 I4.999 J-.769 E.06457
G1 X123.713 Y123.958 E.02474
G1 X124.073 Y123.331 E.02221
G1 X124.529 Y122.76 E.02247
G1 X125.064 Y122.268 E.02234
G3 X126.393 Y121.529 I3.596 J4.906 E.04682
G1 X126.906 Y121.385 E.01639
G1 X127.746 Y121.258 E.0261
G1 X128.424 Y121.273 E.02084
G1 X129.189 Y121.403 E.02382
G1 X129.876 Y121.638 E.02234
G1 X130.52 Y121.976 E.02234
G1 X131.105 Y122.407 E.02234
G3 X132.333 Y124.07 I-3.387 J3.786 E.06397
G1 X132.607 Y124.848 E.02533
G1 X132.726 Y125.546 E.02175
G1 X132.74 Y126.292 E.02292
G1 X132.639 Y127.012 E.02234
G1 X132.512 Y127.447 E.01395
G1 X133.117 Y126.004 F30000
G1 F9489
G3 X126.798 Y130.976 I-5.12 J-.006 E.2841
G1 X126.331 Y130.847 E.0149
G3 X123.065 Y127.365 I1.74 J-4.906 E.1524
G3 X125.748 Y121.403 I4.957 J-1.354 E.21775
G3 X127.314 Y120.929 I2.31 J4.81 E.05048
G3 X128.949 Y120.972 I.682 J5.137 E.05048
G3 X133.114 Y125.944 I-.942 J5.02 E.21594
G1 X133.521 Y126.004 F30000
; LINE_WIDTH: 0.471162
G1 F9489
G3 X125.071 Y130.68 I-5.521 J-.004 E.41021
G3 X127.267 Y120.527 I2.934 J-4.679 E.47173
G3 X133.518 Y125.944 I.732 J5.47 E.32628
G1 X134.504 Y127.711 F30000
; LINE_WIDTH: 0.419999
G1 F9489
G1 X134.687 Y126.773 E.02938
G2 X133.885 Y122.74 I-6.846 J-.734 E.1283
G1 X133.438 Y122.032 E.02573
G2 X130.836 Y119.901 I-5.606 J4.191 E.10436
G1 X130.001 Y119.573 E.02758
G2 X125.916 Y119.605 I-1.992 J6.433 E.12754
G1 X125.108 Y119.921 E.02664
G2 X122.855 Y121.659 I3.189 J6.464 E.08802
G1 X122.544 Y122.067 E.01576
G1 X122.07 Y122.817 E.02727
G2 X121.386 Y124.768 I6.485 J3.368 E.06373
G1 X121.281 Y125.584 E.02528
G2 X121.928 Y128.894 I6.965 J.356 E.10467
G1 X122.359 Y129.673 E.02735
G2 X125.537 Y132.26 I5.639 J-3.683 E.12793
G1 X126.346 Y132.525 E.02619
G2 X129.7 Y132.507 I1.641 J-6.669 E.10409
G1 X130.548 Y132.23 E.02742
G2 X133.678 Y129.605 I-2.558 J-6.23 E.12753
G1 X134.106 Y128.834 E.0271
G2 X134.485 Y127.769 I-6.751 J-3.005 E.03479
G1 X134.951 Y123.24 F30000
G1 F9489
G1 X134.554 Y122.393 E.02873
G1 X134.067 Y121.616 E.0282
G2 X129.393 Y118.641 I-6.179 J4.551 E.17415
G2 X135.344 Y124.561 I-1.396 J7.354 E1.17128
G1 X135.137 Y123.743 E.02591
G1 X134.971 Y123.296 E.01465
G1 X125.036 Y117.326 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9489
G3 X126.614 Y116.938 I3.028 J8.909 E.05399
G1 X127.797 Y118.121 E.05549
G1 X128.193 Y118.131 E.01313
G1 X129.386 Y116.938 E.05597
G3 X130.964 Y117.326 I-1.45 J9.298 E.05399
G1 X121.403 Y121.69 F30000
G1 F9489
G1 X121.426 Y121.652 E.00147
G3 X122.43 Y120.43 I9.315 J6.627 E.05251
G1 X121.518 Y119.518 E.04279
G2 X118.937 Y124.613 I6.525 J6.505 E.19264
G1 X120.129 Y125.805 E.0559
G1 X120.129 Y126.195 E.01295
G1 X118.937 Y127.387 E.0559
G2 X121.518 Y132.482 I9.106 J-1.41 E.19264
G1 X122.43 Y131.57 E.04281
G3 X121.403 Y130.31 I7.287 J-6.986 E.05398
G1 X130.964 Y134.674 F30000
G1 F9489
G3 X129.386 Y135.062 I-3.028 J-8.909 E.05399
G1 X128.193 Y133.869 E.05596
G1 X127.797 Y133.879 E.01314
G1 X126.614 Y135.062 E.05547
G3 X125.036 Y134.674 I1.45 J-9.298 E.05399
; CHANGE_LAYER
; Z_HEIGHT: 1.8
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F15476.087
G1 X126.614 Y135.062 E-.61765
G1 X126.879 Y134.797 E-.14235
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 9/250
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
G3 Z2 I1.163 J.359 P1  F30000
G1 X130.416 Y123.329 Z2
G1 Z1.8
G1 E.8 F1800
; FEATURE: Inner wall
G1 F9501
G1 X130.779 Y123.708 E.01741
G3 X127.314 Y122.462 I-2.779 J2.287 E.62191
G1 X127.428 Y122.449 E.00382
G1 X127.862 Y122.399 E.01448
G3 X130.372 Y123.289 I.137 J3.596 E.09048
G1 X130.137 Y123.604 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9501
G1 X130.476 Y123.958 E.01506
G3 X127.389 Y122.848 I-2.476 J2.038 E.51333
G1 X127.473 Y122.838 E.00261
G1 X127.877 Y122.792 E.01249
G3 X130.092 Y123.566 I.123 J3.205 E.07379
M204 S10000
; WIPE_START
G1 F12000
G1 X130.476 Y123.958 E-.20875
G1 X130.797 Y124.436 E-.21871
G1 X130.978 Y124.8 E-.15448
G1 X131.119 Y125.247 E-.17807
; WIPE_END
G1 E-.04 F1800
G1 X137.478 Y126.807 Z2.2 F30000
G1 Z1.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9501
G3 X124.45 Y117.164 I-9.484 J-.808 E1.34068
G3 X128.475 Y116.492 I3.538 J8.801 E.13645
G3 X137.483 Y126.747 I-.482 J9.507 E.50484
G1 X137.879 Y126.84 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9501
G1 X137.868 Y126.84 E.00033
G3 X123.536 Y117.147 I-9.875 J-.841 E1.26718
G3 X128.508 Y116.102 I4.502 J9.069 E.1578
G3 X137.904 Y126 I-.515 J9.898 E.46255
G1 X137.881 Y126.78 E.02399
M204 S10000
; WIPE_START
G1 F12000
G1 X137.868 Y126.84 E-.02317
G1 X137.772 Y127.676 E-.31966
G1 X137.595 Y128.498 E-.3198
G1 X137.52 Y128.743 E-.09737
; WIPE_END
G1 E-.04 F1800
G1 X136.678 Y123.035 Z2.2 F30000
G1 Z1.8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9501
G3 X137.062 Y124.614 I-9.452 J3.135 E.05399
G1 X135.872 Y125.804 E.05581
G3 X135.872 Y126.196 I-1.942 J.196 E.01302
G1 X137.063 Y127.387 E.05586
G3 X134.482 Y132.482 I-9.104 J-1.409 E.19264
G1 X133.566 Y131.566 E.04298
G3 X132.306 Y132.591 I-5.715 J-5.743 E.05397
G1 X130.964 Y134.674 F30000
G1 F9501
G3 X129.386 Y135.062 I-3.028 J-8.909 E.05399
G1 X128.193 Y133.869 E.05596
G1 X127.797 Y133.879 E.01314
G1 X126.614 Y135.062 E.05547
G3 X121.518 Y132.482 I1.64 J-9.567 E.19233
G1 X122.43 Y131.57 E.04281
G3 X121.403 Y130.31 I7.287 J-6.986 E.05398
G1 X119.322 Y128.965 F30000
G1 F9501
G3 X118.938 Y127.386 I9.452 J-3.135 E.05399
G1 X120.129 Y126.195 E.05585
G1 X120.129 Y125.805 E.01295
G1 X118.937 Y124.613 E.0559
G3 X121.518 Y119.518 I9.106 J1.41 E.19264
G1 X122.43 Y120.43 E.04279
G2 X121.403 Y121.69 I7.331 J7.017 E.05398
G1 X126.203 Y129.562 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.419999
G1 F9501
G1 X125.589 Y129.187 E.0221
G1 X125.16 Y128.807 E.01761
G1 X124.74 Y128.311 E.01997
G3 X124.168 Y124.885 I3.247 J-2.303 E.11044
G1 X124.413 Y124.24 E.02119
G3 X128.395 Y122.027 I3.613 J1.811 E.14873
G1 X129.045 Y122.143 E.02028
G3 X131.657 Y124.405 I-1.039 J3.839 E.10984
G1 X131.888 Y125.075 E.02179
G1 X131.98 Y125.661 E.01821
G1 X131.985 Y126.291 E.01938
G3 X130.235 Y129.308 I-3.973 J-.29 E.11091
G1 X129.648 Y129.64 E.02074
G3 X126.258 Y129.586 I-1.638 J-3.612 E.10765
; WIPE_START
G1 F15000
G1 X126.663 Y129.766 E-.16843
G1 X127.253 Y129.926 E-.23247
G1 X127.861 Y129.994 E-.23248
G1 X128.194 Y129.98 E-.12662
; WIPE_END
G1 E-.04 F1800
G1 X132.495 Y127.505 Z2.2 F30000
G1 Z1.8
G1 E.8 F1800
G1 F9501
G3 X131.788 Y128.852 I-4.582 J-1.544 E.04693
G1 X131.213 Y129.497 E.02656
G1 X130.692 Y129.907 E.02038
G1 X130.008 Y130.303 E.02428
G1 X129.328 Y130.559 E.02234
G1 X128.616 Y130.708 E.02234
G1 X127.89 Y130.747 E.02234
G3 X126.389 Y130.469 I.348 J-6.071 E.04704
G1 X125.894 Y130.25 E.01662
G1 X125.179 Y129.82 E.02565
G1 X124.658 Y129.37 E.02115
G1 X124.158 Y128.791 E.02351
G1 X123.777 Y128.171 E.02234
G1 X123.495 Y127.501 E.02234
G1 X123.319 Y126.796 E.02234
G3 X123.434 Y124.713 I4.999 J-.769 E.06457
G1 X123.713 Y123.958 E.02474
G1 X124.073 Y123.331 E.02221
G1 X124.529 Y122.76 E.02247
G1 X125.064 Y122.268 E.02234
G3 X126.347 Y121.547 I3.621 J4.945 E.04531
G1 X126.906 Y121.385 E.01789
G1 X127.746 Y121.258 E.0261
G1 X128.424 Y121.273 E.02084
G1 X129.189 Y121.403 E.02382
G1 X129.876 Y121.638 E.02234
G1 X130.52 Y121.976 E.02234
G1 X131.105 Y122.407 E.02234
G3 X132.333 Y124.07 I-3.387 J3.786 E.06397
G1 X132.607 Y124.848 E.02533
G1 X132.726 Y125.546 E.02175
G1 X132.74 Y126.291 E.02292
G1 X132.639 Y127.012 E.02234
G1 X132.512 Y127.447 E.01395
G1 X133.117 Y126.004 F30000
G1 F9501
G3 X126.798 Y130.976 I-5.12 J-.006 E.2841
G3 X125.29 Y130.341 I1.277 J-5.139 E.05048
G3 X124.059 Y129.263 I2.739 J-4.371 E.05048
G3 X125.748 Y121.403 I3.946 J-3.264 E.28409
G3 X127.314 Y120.929 I2.381 J5.043 E.05046
G3 X128.949 Y120.972 I.682 J5.137 E.05048
G3 X133.114 Y125.944 I-.942 J5.02 E.21594
G1 X133.521 Y126.004 F30000
; LINE_WIDTH: 0.47119
G1 F9501
G3 X126.691 Y131.365 I-5.527 J-.01 E.3485
G3 X127.267 Y120.527 I1.312 J-5.364 E.53351
G3 X133.518 Y125.944 I.732 J5.47 E.3263
G1 X134.504 Y127.711 F30000
; LINE_WIDTH: 0.419999
G1 F9501
G1 X134.687 Y126.773 E.02938
G2 X133.885 Y122.74 I-6.846 J-.734 E.1283
G1 X133.438 Y122.032 E.02573
G2 X130.836 Y119.901 I-5.606 J4.191 E.10436
G1 X130.001 Y119.573 E.02758
G2 X125.916 Y119.605 I-1.992 J6.433 E.12754
G1 X125.108 Y119.921 E.02664
G2 X122.855 Y121.659 I3.189 J6.464 E.08802
G1 X122.544 Y122.067 E.01576
G1 X122.07 Y122.817 E.02727
G2 X121.386 Y124.768 I6.485 J3.368 E.06373
G1 X121.281 Y125.584 E.02528
G2 X121.928 Y128.894 I6.965 J.356 E.10467
G1 X122.359 Y129.673 E.02735
G2 X125.537 Y132.259 I5.639 J-3.683 E.12793
G1 X126.346 Y132.525 E.02619
G2 X129.7 Y132.507 I1.641 J-6.669 E.10409
G1 X130.548 Y132.23 E.02742
G2 X133.678 Y129.605 I-2.558 J-6.23 E.12753
G1 X134.106 Y128.834 E.0271
G2 X134.485 Y127.769 I-6.751 J-3.005 E.03479
G1 X134.951 Y123.24 F30000
G1 F9501
G1 X134.554 Y122.393 E.02873
G1 X134.067 Y121.616 E.0282
G2 X129.393 Y118.641 I-6.179 J4.551 E.17415
G2 X135.344 Y124.561 I-1.396 J7.354 E1.17128
G1 X135.137 Y123.743 E.02591
G1 X134.971 Y123.296 E.01465
G1 X131.229 Y123.064 F30000
G1 F9501
G1 X131.736 Y123.729 E.02569
G1 X131.995 Y124.238 E.01755
G1 X132.247 Y124.962 E.02356
G1 X132.353 Y125.603 E.01998
G1 X132.362 Y126.291 E.02115
G1 X132.267 Y126.954 E.02057
G1 X132.071 Y127.594 E.02057
G1 X131.78 Y128.197 E.02057
G1 X131.48 Y128.635 E.01632
G1 X130.941 Y129.235 E.02478
G1 X130.464 Y129.607 E.01861
G1 X129.828 Y129.972 E.02251
G1 X129.2 Y130.204 E.02057
G1 X128.544 Y130.338 E.02057
G1 X127.876 Y130.37 E.02057
G1 X127.21 Y130.3 E.02057
G1 X126.563 Y130.129 E.02057
G1 X126.049 Y129.906 E.01723
G1 X125.384 Y129.503 E.02387
G1 X124.909 Y129.089 E.01938
G1 X124.449 Y128.551 E.02174
G1 X124.101 Y127.979 E.02057
G1 X123.845 Y127.36 E.02057
G1 X123.686 Y126.71 E.02057
G1 X123.64 Y126.196 E.01586
G1 X123.673 Y125.375 E.02524
G1 X123.801 Y124.799 E.01815
G1 X124.063 Y124.099 E.02297
G1 X124.397 Y123.524 E.02044
G1 X124.82 Y123 E.0207
G1 X125.315 Y122.549 E.02057
G1 X125.873 Y122.18 E.02057
G3 X126.493 Y121.895 I6.988 J14.383 E.02097
G1 X127.006 Y121.749 E.01638
G1 X127.789 Y121.633 E.02433
G1 X128.41 Y121.65 E.01907
G1 X129.117 Y121.773 E.02205
G1 X129.749 Y121.993 E.02057
G1 X130.34 Y122.307 E.02057
G1 X130.876 Y122.707 E.02057
G1 X131.187 Y123.021 E.01356
G1 X132.353 Y121.379 F30000
G1 F9501
G1 X131.683 Y120.821 E.02678
G2 X126.024 Y119.966 I-3.686 J5.236 E.18232
G1 X125.255 Y120.269 E.02541
G2 X123.593 Y121.421 I3.153 J6.319 E.06234
G2 X121.701 Y126.794 I4.459 J4.59 E.1814
G1 X121.859 Y127.636 E.02632
G2 X122.684 Y129.482 I6.779 J-1.921 E.06234
G2 X127.649 Y132.34 I5.338 J-3.532 E.18253
G1 X128.47 Y132.338 E.02521
G2 X133.364 Y129.397 I-.504 J-6.381 E.18186
G1 X133.771 Y128.66 E.02587
G2 X134.315 Y126.713 I-6.453 J-2.85 E.06234
G2 X133.55 Y122.914 I-6.461 J-.675 E.12091
G1 X133.123 Y122.24 E.0245
G2 X132.395 Y121.422 I-5.441 J4.113 E.0337
G1 X131.079 Y119.6 F30000
G1 F9501
G1 X130.129 Y119.218 E.03146
G2 X128.876 Y118.952 I-1.923 J5.975 E.03942
G1 X127.965 Y118.895 E.02807
G1 X127.134 Y118.945 E.02556
G2 X123.857 Y120.231 I.942 J7.216 E.10927
G1 X123.097 Y120.853 E.03016
G2 X122.242 Y121.842 I4.371 J4.646 E.04026
G1 X121.745 Y122.626 E.0285
G2 X121.018 Y124.688 I6.859 J3.579 E.06743
G1 X120.906 Y125.544 E.02651
G2 X121.551 Y128.975 I7.316 J.401 E.10834
G1 X122.034 Y129.864 E.03107
G2 X122.836 Y130.875 I5.302 J-3.382 E.03972
G1 X123.503 Y131.502 E.02812
G1 X124.164 Y131.984 E.02514
G2 X127.523 Y133.086 I3.872 J-6.132 E.10973
G1 X128.489 Y133.091 E.0297
G2 X129.789 Y132.874 I-.404 J-6.399 E.04056
G1 X130.676 Y132.585 E.02866
G1 X131.376 Y132.256 E.02377
G1 X131.815 Y131.99 E.01578
G1 X132.55 Y131.457 E.02788
G1 X133.17 Y130.879 E.02605
G2 X134.867 Y127.811 I-5.354 J-4.966 E.1088
G1 X135.059 Y126.833 E.03062
G2 X134.219 Y122.567 I-7.23 J-.792 E.13569
G1 X133.752 Y121.824 E.02696
G2 X131.131 Y119.629 I-5.884 J4.364 E.10602
G1 X126.14 Y120.349 F30000
; LINE_WIDTH: 0.470893
G1 F9501
G1 X125.411 Y120.64 E.02735
G2 X125.84 Y131.543 I2.593 J5.358 E.48132
G1 X126.572 Y131.778 E.02683
G2 X133.194 Y123.099 I1.42 J-5.782 E.4817
G1 X132.787 Y122.463 E.02632
G2 X126.198 Y120.334 I-4.781 J3.533 E.2578
G1 X125.036 Y117.326 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9501
G3 X126.614 Y116.938 I3.028 J8.909 E.05399
G1 X127.797 Y118.121 E.05549
G1 X128.193 Y118.131 E.01313
G1 X129.386 Y116.938 E.05597
G3 X134.482 Y119.518 I-1.64 J9.567 E.19233
G1 X133.566 Y120.434 E.04298
G2 X132.306 Y119.409 I-5.716 J5.744 E.05397
; CHANGE_LAYER
; Z_HEIGHT: 2
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F15476.087
G1 X133.182 Y120.061 E-.41495
G1 X133.566 Y120.434 E-.20338
G1 X133.83 Y120.17 E-.14167
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 10/250
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
G3 Z2.2 I-1.183 J.287 P1  F30000
G1 X135.417 Y126.709 Z2.2
G1 Z2
G1 E.8 F1800
; FEATURE: Inner wall
G1 F13786
G1 X135.405 Y126.792 E.00276
G3 X127.011 Y118.612 I-7.408 J-.795 E1.10545
G1 X127.796 Y118.549 E.02615
G3 X135.448 Y126 I.201 J7.448 E.395
G1 X135.419 Y126.649 E.02156
; WIPE_START
G1 F15476.087
G1 X135.405 Y126.792 E-.05436
G1 X135.286 Y127.576 E-.3014
G1 X135.077 Y128.341 E-.30152
G1 X134.979 Y128.593 E-.10272
; WIPE_END
G1 E-.04 F1800
G1 X130.135 Y123.602 Z2.4 F30000
G1 Z2
G1 E.8 F1800
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
G1 X130.135 Y123.604 E.00007
G3 X127.389 Y122.848 I-2.136 J2.391 E.52825
G1 X127.428 Y122.844 E.0012
G1 X127.877 Y122.792 E.0139
G3 X129.745 Y123.306 I.122 J3.204 E.06047
G1 X130.087 Y123.566 E.0132
M204 S10000
; WIPE_START
G1 X130.135 Y123.604 E-.02348
G1 X130.477 Y123.957 E-.18674
G1 X130.76 Y124.359 E-.18678
G1 X130.978 Y124.8 E-.18679
G1 X131.118 Y125.242 E-.17621
; WIPE_END
G1 E-.04 F1800
G1 X137.478 Y126.807 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F13786
G3 X123.713 Y117.497 I-9.485 J-.807 E1.31391
G3 X128.486 Y116.493 I4.325 J8.712 E.16355
G3 X137.483 Y126.747 I-.493 J9.506 E.50446
G1 X137.879 Y126.84 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
G1 X137.875 Y126.841 E.00011
G3 X125.815 Y135.667 I-9.875 J-.841 E.52021
G3 X128.52 Y116.103 I2.185 J-9.667 E.90503
G3 X137.911 Y126 I-.52 J9.897 E.46239
G1 X137.881 Y126.78 E.024
M204 S10000
; WIPE_START
G1 X137.875 Y126.841 E-.02297
G1 X137.772 Y127.676 E-.31975
G1 X137.595 Y128.498 E-.3198
G1 X137.52 Y128.744 E-.09747
; WIPE_END
G1 E-.04 F1800
G1 X132.249 Y132.533 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F13786
G2 X133.51 Y131.51 I-4.369 J-6.678 E.05396
G1 X134.482 Y132.482 E.04561
G2 X137.063 Y127.387 I-6.525 J-6.505 E.19264
G1 X135.797 Y126.121 E.0594
G2 X135.797 Y125.879 I-1.129 J-.121 E.00802
G1 X137.063 Y124.613 E.0594
G2 X134.482 Y119.518 I-9.106 J1.41 E.19264
G1 X133.51 Y120.49 E.04561
G2 X132.249 Y119.467 I-5.631 J5.655 E.05396
G1 X125.036 Y117.326 F30000
G1 F13786
G3 X126.614 Y116.938 I3.028 J8.909 E.05398
G1 X127.878 Y118.202 E.05931
G1 X128.115 Y118.209 E.00786
G1 X129.386 Y116.938 E.05959
G3 X130.964 Y117.326 I-1.45 J9.298 E.05398
G1 X121.462 Y121.748 F30000
G1 F13786
G3 X122.486 Y120.486 I8.067 J5.501 E.05398
G1 X121.518 Y119.518 E.04542
G2 X118.937 Y124.613 I6.525 J6.505 E.19264
G1 X120.208 Y125.884 E.05962
G1 X120.208 Y126.116 E.0077
G1 X118.937 Y127.387 E.05962
G2 X121.518 Y132.482 I9.106 J-1.41 E.19264
G1 X122.486 Y131.514 E.04544
G3 X121.461 Y130.252 I7.001 J-6.733 E.05398
; WIPE_START
G1 F15476.087
G1 X121.993 Y130.981 E-.3427
G1 X122.486 Y131.514 E-.27592
G1 X122.223 Y131.777 E-.14138
; WIPE_END
G1 E-.04 F1800
G1 X129.851 Y132.047 Z2.4 F30000
G1 X131.751 Y132.115 Z2.4
G1 Z2
G1 E.8 F1800
M204 S2000
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F12000
G1 X134.13 Y129.736 E.10338
G1 X134.655 Y128.677
G1 X130.67 Y132.663 E.1732
G1 X129.872 Y132.927
G1 X134.924 Y127.875 E.21951
G1 X135.074 Y127.192
G1 X129.188 Y133.078 E.25578
G1 X128.572 Y133.16
G1 X135.152 Y126.58 E.28594
G1 X135.182 Y126.017
G1 X128.024 Y133.175 E.31106
G1 X127.509 Y133.157
G1 X135.157 Y125.509 E.33234
G1 X135.108 Y125.024
G1 X127.018 Y133.114 E.35156
G1 X126.569 Y133.03
G1 X135.034 Y124.565 E.36784
G1 X134.927 Y124.139
G1 X126.136 Y132.93 E.38203
G1 X125.726 Y132.806
G1 X129.431 Y129.102 E.16098
G1 X128.654 Y129.345
G1 X125.337 Y132.662 E.14413
G1 X124.962 Y132.504
G1 X128.057 Y129.409 E.13449
G1 X127.553 Y129.38
G1 X124.61 Y132.322 E.12788
G1 X124.267 Y132.132
G1 X127.109 Y129.29 E.12351
G1 X126.709 Y129.157
G1 X123.947 Y131.919 E.12003
G1 X123.634 Y131.699
G1 X126.344 Y128.989 E.11778
G1 X126.021 Y128.779
G1 X123.343 Y131.457 E.11635
G1 X123.059 Y131.208
G1 X125.727 Y128.54 E.11594
G1 X125.458 Y128.275
G1 X122.796 Y130.938 E.11569
G1 X122.54 Y130.66
G1 X125.217 Y127.983 E.11634
G1 X125.016 Y127.651
G1 X122.305 Y130.362 E.11782
G1 X122.077 Y130.056
G1 X124.844 Y127.289 E.12025
G1 X124.708 Y126.892
G1 X121.871 Y129.729 E.12327
G1 X121.674 Y129.393
G1 X124.616 Y126.451 E.12786
G1 X124.585 Y125.948
G1 X121.5 Y129.034 E.13409
G1 X121.333 Y128.667
G1 X124.652 Y125.349 E.14421
G1 X124.904 Y124.563
G1 X121.196 Y128.271 E.16114
M204 S10000
; WIPE_START
G1 X122.61 Y126.857 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X130.224 Y127.384 Z2.4 F30000
G1 X131.088 Y127.444 Z2.4
G1 Z2
G1 E.8 F1800
M204 S2000
G1 F12000
G1 X134.811 Y123.722 E.16177
G1 X134.661 Y123.338
G1 X131.348 Y126.651 E.14395
G1 X131.409 Y126.058
G1 X134.505 Y122.961 E.13454
G1 X134.322 Y122.61
G1 X131.38 Y125.553 E.12786
G1 X131.293 Y125.107
G1 X134.132 Y122.268 E.12338
G1 X133.919 Y121.947
G1 X131.162 Y124.704 E.11982
G1 X130.985 Y124.348
G1 X133.699 Y121.635 E.1179
G1 X133.457 Y121.343
G1 X130.777 Y124.023 E.11646
G1 X130.541 Y123.725
G1 X133.208 Y121.059 E.11586
G1 X132.937 Y120.796
G1 X130.28 Y123.453 E.11549
G1 X129.978 Y123.222
G1 X132.661 Y120.539 E.11657
G1 X132.362 Y120.305
G1 X129.65 Y123.017 E.11786
G1 X129.291 Y122.842
G1 X132.057 Y120.077 E.12017
G1 X131.729 Y119.872
G1 X128.898 Y122.702 E.123
G1 X128.451 Y122.615
G1 X131.393 Y119.674 E.12783
G1 X131.034 Y119.499
G1 X127.947 Y122.587 E.13417
G1 X127.357 Y122.643
G1 X130.665 Y119.336 E.14372
G1 X130.273 Y119.194
G1 X126.555 Y122.913 E.16157
M204 S10000
; WIPE_START
G1 X127.969 Y121.498 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X129.863 Y119.071 Z2.4 F30000
G1 Z2
G1 E.8 F1800
M204 S2000
G1 F12000
G1 X121.065 Y127.869 E.3823
G1 X120.97 Y127.43
G1 X129.434 Y118.966 E.3678
G1 X128.974 Y118.893
G1 X120.89 Y126.977 E.35127
G1 X120.839 Y126.495
G1 X128.496 Y118.838 E.33276
G1 X127.977 Y118.824
G1 X120.827 Y125.974 E.31069
G1 X120.848 Y125.419
G1 X127.417 Y118.851 E.28545
G1 X126.809 Y118.925
G1 X120.917 Y124.817 E.25605
G1 X121.064 Y124.137
G1 X126.129 Y119.072 E.22009
G1 X125.324 Y119.344
G1 X121.332 Y123.336 E.17348
G1 X121.883 Y122.251
G1 X124.266 Y119.868 E.10356
M204 S10000
; WIPE_START
G1 X122.852 Y121.282 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X128.139 Y126.787 Z2.4 F30000
G1 X130.022 Y128.747 Z2.4
G1 Z2
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.100596
G1 F13786
G1 X129.865 Y128.885 E.00098
; LINE_WIDTH: 0.131419
G1 X129.741 Y128.977 E.00112
; LINE_WIDTH: 0.167248
G1 X129.616 Y129.07 E.00157
; LINE_WIDTH: 0.203078
G1 X129.492 Y129.163 E.00202
; WIPE_START
G1 F15000
G1 X129.616 Y129.07 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X131.15 Y127.506 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.198929
G1 F13786
G1 X131.059 Y127.633 E.00199
; LINE_WIDTH: 0.161669
G1 X130.963 Y127.766 E.00159
; LINE_WIDTH: 0.128893
G1 X130.854 Y127.895 E.00118
; LINE_WIDTH: 0.101744
G1 X130.745 Y128.025 E.00081
; WIPE_START
G1 F15000
G1 X130.854 Y127.895 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X131.415 Y126.717 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.182554
G1 F13786
G3 X131.271 Y126.982 I-3.544 J-1.754 E.00342
; WIPE_START
M73 P30 R18
G1 F15000
G1 X131.415 Y126.717 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X131.459 Y125.632 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.103068
G1 F13786
G1 X131.395 Y125.805 E.0009
; WIPE_START
G1 F15000
G1 X131.459 Y125.632 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X128.427 Y122.614 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.0965201
G1 F13786
G2 X128.266 Y122.534 I-1.1 J2.03 E.00078
; WIPE_START
G1 F15000
G1 X128.427 Y122.614 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X126.493 Y122.851 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.19604
G1 F13786
G1 X126.339 Y122.957 E.00233
; LINE_WIDTH: 0.15542
G1 X126.165 Y123.098 E.00206
; LINE_WIDTH: 0.110587
G1 X125.99 Y123.239 E.00124
; WIPE_START
G1 F15000
G1 X126.165 Y123.098 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X125.213 Y124.015 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.108975
G1 F13786
G1 X125.106 Y124.153 E.00094
; LINE_WIDTH: 0.150586
G1 X124.999 Y124.291 E.00154
; LINE_WIDTH: 0.185385
G1 X124.891 Y124.43 E.00203
G2 X124.913 Y124.572 I1.921 J-.227 E.00167
; WIPE_START
G1 F15000
G1 X124.891 Y124.43 E-.34331
G1 X124.999 Y124.291 E-.41669
; WIPE_END
G1 E-.04 F1800
G1 X124.222 Y131.884 Z2.4 F30000
G1 X124.2 Y132.095 Z2.4
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.093691
G1 F13786
G1 X124.112 Y132.021 E.00047
; WIPE_START
G1 F15000
G1 X124.2 Y132.095 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X131.69 Y132.054 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.204559
G1 F13786
G1 X131.461 Y132.236 E.00386
; LINE_WIDTH: 0.158492
G1 X131.336 Y132.326 E.00145
; LINE_WIDTH: 0.111581
G1 X131.21 Y132.415 E.00086
; WIPE_START
G1 F15000
G1 X131.336 Y132.326 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X131.467 Y124.694 Z2.4 F30000
G1 X131.552 Y119.782 Z2.4
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.0973873
G1 F13786
G2 X131.445 Y119.699 I-.865 J1.011 E.0006
G1 X129.612 Y119.055 F30000
; LINE_WIDTH: 0.0914121
G1 F13786
G1 X129.462 Y118.971 E.00068
G1 X124.801 Y119.573 F30000
; LINE_WIDTH: 0.110438
G1 F13786
G1 X124.643 Y119.692 E.00109
; LINE_WIDTH: 0.154974
G1 X124.485 Y119.81 E.0018
; LINE_WIDTH: 0.199511
G1 X124.327 Y119.929 E.00252
; WIPE_START
G1 F15000
G1 X124.485 Y119.81 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X127.535 Y126.807 Z2.4 F30000
G1 X130.964 Y134.674 Z2.4
G1 Z2
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F13786
G3 X129.386 Y135.062 I-3.028 J-8.909 E.05399
G1 X128.116 Y133.792 E.05958
G1 X127.878 Y133.798 E.00789
G1 X126.614 Y135.062 E.05928
G3 X125.036 Y134.674 I1.449 J-9.297 E.05399
; CHANGE_LAYER
; Z_HEIGHT: 2.2
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F15476.087
G1 X126.614 Y135.062 E-.61765
G1 X126.879 Y134.797 E-.14235
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 11/250
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
G3 Z2.4 I1.099 J-.523 P1  F30000
G1 X121.494 Y123.482 Z2.4
G1 Z2.2
G1 E.8 F1800
; FEATURE: Inner wall
G1 F5036
G1 X121.499 Y123.463 E.00064
G3 X127.074 Y119.084 I6.498 J2.533 E.24669
G1 X127.809 Y119.025 E.02447
G3 X121.268 Y124.164 I.188 J6.972 E1.158
G1 X121.475 Y123.539 E.02185
G1 X121.867 Y123.603 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5036
G1 X122.156 Y122.963 E.02155
G3 X127.126 Y119.473 I5.841 J3.034 E.19396
G1 X127.82 Y119.417 E.02139
G3 X121.845 Y123.658 I.177 J6.58 E1.03204
M204 S10000
; WIPE_START
G1 F12000
G1 X122.156 Y122.963 E-.28929
G1 X122.512 Y122.36 E-.26641
G1 X122.833 Y121.928 E-.2043
; WIPE_END
G1 E-.04 F1800
G1 X130.074 Y124.34 Z2.6 F30000
G1 X137.477 Y126.807 Z2.6
G1 Z2.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5036
G3 X123.713 Y117.497 I-9.484 J-.807 E1.31388
G3 X128.498 Y116.494 I4.322 J8.704 E.16393
G3 X137.482 Y126.747 I-.505 J9.505 E.50404
G1 X137.879 Y126.84 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5036
G1 X137.875 Y126.84 E.00013
G3 X122.898 Y117.503 I-9.875 J-.84 E1.24453
G3 X128.531 Y116.104 I5.079 J8.404 E.18105
G3 X137.911 Y126 I-.531 J9.896 E.46203
G1 X137.881 Y126.78 E.024
M204 S10000
; WIPE_START
G1 F12000
G1 X137.875 Y126.84 E-.02294
G1 X137.772 Y127.676 E-.31975
G1 X137.595 Y128.498 E-.3198
G1 X137.52 Y128.744 E-.09751
; WIPE_END
G1 E-.04 F1800
G1 X133.798 Y122.08 Z2.6 F30000
G1 X132.306 Y119.409 Z2.6
G1 Z2.2
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F5036
G3 X133.566 Y120.434 I-4.455 J6.768 E.05397
G1 X134.482 Y119.518 E.04298
G3 X137.063 Y124.613 I-6.525 J6.505 E.19264
G1 X135.872 Y125.804 E.05586
G3 X135.872 Y126.196 I-1.942 J.196 E.01302
G1 X137.063 Y127.387 E.05586
G3 X134.482 Y132.482 I-9.106 J-1.41 E.19264
G1 X133.566 Y131.566 E.04298
G3 X132.306 Y132.591 I-5.715 J-5.743 E.05397
G1 X125.036 Y134.674 F30000
G1 F5036
G2 X126.614 Y135.062 I3.028 J-8.91 E.05398
G1 X127.797 Y133.879 E.05547
G1 X128.193 Y133.869 E.01314
G1 X129.386 Y135.062 E.05596
G2 X130.964 Y134.674 I-1.45 J-9.298 E.05399
G1 X121.403 Y130.31 F30000
G1 F5036
G1 X121.426 Y130.348 E.00147
G2 X122.43 Y131.57 I9.26 J-6.587 E.05251
G1 X121.518 Y132.482 E.04281
G3 X118.937 Y127.387 I6.525 J-6.505 E.19264
G1 X120.129 Y126.195 E.0559
G1 X120.129 Y125.805 E.01295
G1 X118.937 Y124.613 E.0559
G3 X121.518 Y119.518 I9.106 J1.41 E.19264
G1 X122.43 Y120.43 E.04279
G2 X121.403 Y121.69 I7.331 J7.017 E.05398
G1 X127.812 Y118.549 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.491211
G1 F5036
G2 X129.389 Y118.677 I.19 J7.448 E1.65218
G2 X127.872 Y118.551 I-1.345 J6.999 E.05568
G1 X130.964 Y117.326 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F5036
G2 X129.386 Y116.938 I-3.028 J8.909 E.05398
G1 X128.193 Y118.131 E.05597
G1 X127.797 Y118.121 E.01313
G1 X126.614 Y116.938 E.05549
G2 X125.036 Y117.326 I1.45 J9.297 E.05399
; CHANGE_LAYER
; Z_HEIGHT: 2.4
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F15476.087
G1 X126.614 Y116.938 E-.61765
G1 X126.879 Y117.203 E-.14235
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 12/250
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
G3 Z2.6 I-.924 J-.793 P1  F30000
G1 X121.495 Y123.477 Z2.6
G1 Z2.4
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4992
G1 X121.504 Y123.46 E.00064
G3 X127.074 Y119.084 I6.496 J2.535 E.24646
G3 X128.556 Y119.044 I.93 J7.059 E.04928
G3 X121.271 Y124.165 I-.556 J6.951 E1.13297
G1 X121.477 Y123.534 E.022
G1 X121.87 Y123.603 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4992
G3 X127.126 Y119.473 I6.13 J2.392 E.21545
G3 X128.525 Y119.436 I.878 J6.664 E.04309
G3 X121.848 Y123.659 I-.525 J6.56 E1.0101
M204 S10000
; WIPE_START
G1 F12000
G1 X122.157 Y122.964 E-.28906
G1 X122.512 Y122.36 E-.26637
G1 X122.833 Y121.928 E-.20457
; WIPE_END
G1 E-.04 F1800
G1 X130.075 Y124.34 Z2.8 F30000
G1 X137.478 Y126.807 Z2.8
G1 Z2.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4992
G3 X123.007 Y117.891 I-9.485 J-.807 E1.28711
G3 X128.509 Y116.495 I4.98 J8.087 E.19121
G3 X137.483 Y126.747 I-.516 J9.505 E.50367
G1 X137.879 Y126.84 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4992
G1 X137.875 Y126.84 E.00014
G3 X125.793 Y135.662 I-9.875 J-.84 E.52087
G3 X128.542 Y116.104 I2.212 J-9.661 E.9047
G3 X137.91 Y126 I-.542 J9.896 E.46166
G1 X137.881 Y126.781 E.024
M204 S10000
; WIPE_START
G1 F12000
G1 X137.875 Y126.84 E-.02291
G1 X137.772 Y127.676 E-.31974
G1 X137.595 Y128.498 E-.3198
G1 X137.52 Y128.744 E-.09754
; WIPE_END
G1 E-.04 F1800
G1 X132.306 Y132.591 Z2.8 F30000
G1 Z2.4
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4992
G2 X133.566 Y131.566 I-4.455 J-6.768 E.05397
G1 X134.482 Y132.482 E.04298
G2 X137.063 Y127.387 I-6.525 J-6.505 E.19264
G1 X135.872 Y126.196 E.05587
G2 X135.872 Y125.804 I-1.942 J-.196 E.01302
G1 X137.063 Y124.613 E.05586
G2 X134.482 Y119.518 I-9.106 J1.41 E.19264
G1 X133.566 Y120.434 E.04298
G2 X132.306 Y119.409 I-5.716 J5.744 E.05397
G1 X127.812 Y118.549 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.491211
G1 F4992
G2 X129.389 Y118.677 I.19 J7.448 E1.65218
G2 X127.872 Y118.551 I-1.345 J6.999 E.05568
G1 X125.036 Y117.326 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4992
G3 X126.614 Y116.938 I3.028 J8.909 E.05398
G1 X127.797 Y118.121 E.05549
G1 X128.193 Y118.131 E.01313
G1 X129.386 Y116.938 E.05597
G3 X130.964 Y117.326 I-1.45 J9.298 E.05399
G1 X121.403 Y121.69 F30000
G1 F4992
G1 X121.426 Y121.652 E.00147
G3 X122.43 Y120.43 I9.315 J6.627 E.05251
G1 X121.518 Y119.518 E.04279
G2 X118.937 Y124.613 I6.525 J6.505 E.19264
G1 X120.129 Y125.805 E.0559
G1 X120.129 Y126.195 E.01295
G1 X118.939 Y127.385 E.05582
G2 X119.322 Y128.965 I9.719 J-1.523 E.05399
G1 X121.403 Y130.31 F30000
G1 F4992
G1 X121.426 Y130.348 E.00147
G2 X122.43 Y131.57 I9.26 J-6.587 E.05251
G1 X121.518 Y132.482 E.04281
G2 X126.614 Y135.062 I6.737 J-6.988 E.19233
G1 X127.797 Y133.879 E.05547
G1 X128.193 Y133.869 E.01314
G1 X129.386 Y135.062 E.05596
G2 X130.964 Y134.674 I-1.45 J-9.298 E.05399
; CHANGE_LAYER
; Z_HEIGHT: 2.6
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F15476.087
G1 X129.386 Y135.062 E-.61765
G1 X129.121 Y134.797 E-.14235
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 13/250
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
G3 Z2.8 I1.009 J-.68 P1  F30000
G1 X121.495 Y123.477 Z2.8
G1 Z2.6
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4411
G1 X121.504 Y123.46 E.00064
G3 X127.074 Y119.084 I6.496 J2.535 E.24646
G3 X128.556 Y119.044 I.933 J7.154 E.04926
G3 X121.272 Y124.165 I-.556 J6.951 E1.13299
G1 X121.477 Y123.534 E.022
G1 X121.87 Y123.603 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4411
G3 X127.126 Y119.473 I6.13 J2.392 E.21545
G3 X128.525 Y119.436 I.88 J6.755 E.04308
G3 X121.848 Y123.659 I-.525 J6.56 E1.01011
M204 S10000
; WIPE_START
G1 F12000
G1 X122.157 Y122.964 E-.28906
G1 X122.512 Y122.36 E-.26637
G1 X122.833 Y121.928 E-.20457
; WIPE_END
G1 E-.04 F1800
G1 X130.075 Y124.34 Z3 F30000
G1 X137.481 Y126.807 Z3
G1 Z2.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4411
G3 X123.109 Y117.834 I-9.482 J-.809 E1.29029
G3 X128.52 Y116.496 I4.867 J8.069 E.18772
G3 X137.486 Y126.747 I-.521 J9.502 E.50343
G1 X137.879 Y126.841 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4411
G1 X137.867 Y126.84 E.00036
G3 X122.104 Y118.029 I-9.875 J-.84 E1.21544
G1 X122.918 Y117.492 E.02995
G3 X128.554 Y116.105 I5.055 J8.4 E.18105
G3 X137.903 Y126 I-.561 J9.895 E.46109
G1 X137.881 Y126.781 E.024
M204 S10000
; WIPE_START
G1 F12000
G1 X137.867 Y126.84 E-.02308
G1 X137.772 Y127.676 E-.31965
G1 X137.595 Y128.498 E-.3198
G1 X137.52 Y128.744 E-.09747
; WIPE_END
G1 E-.04 F1800
G1 X133.457 Y122.282 Z3 F30000
G1 X131.905 Y119.813 Z3
G1 Z2.6
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4411
G3 X133.174 Y120.826 I-3.937 J6.231 E.05397
G1 X134.482 Y119.518 E.06139
G3 X137.063 Y124.613 I-6.525 J6.505 E.19264
G1 X135.307 Y126.369 E.08237
G2 X135.307 Y125.631 I-3.451 J-.369 E.02452
G1 X137.063 Y127.387 E.08237
G3 X134.482 Y132.482 I-9.106 J-1.41 E.19264
G1 X133.174 Y131.174 E.06139
G3 X131.905 Y132.187 I-5.206 J-5.218 E.05397
G1 X130.964 Y134.674 F30000
G1 F4411
G3 X129.386 Y135.062 I-3.028 J-8.91 E.05399
G1 X127.634 Y133.31 E.08215
G2 X128.367 Y133.309 I.36 J-3.426 E.02434
G1 X126.614 Y135.062 E.08222
G3 X125.036 Y134.674 I1.45 J-9.298 E.05399
G1 X121.81 Y129.907 F30000
G1 F4411
G2 X122.822 Y131.178 I6.864 J-4.431 E.05397
G1 X121.518 Y132.482 E.06122
G3 X118.937 Y127.387 I6.525 J-6.505 E.19264
G1 X120.684 Y125.64 E.08193
G1 X120.684 Y126.36 E.02386
G1 X118.937 Y124.613 E.08193
G3 X121.518 Y119.518 I9.106 J1.41 E.19264
G1 X122.822 Y120.822 E.06122
G2 X121.81 Y122.093 I5.852 J5.701 E.05397
G1 X125.036 Y117.326 F30000
G1 F4411
G3 X126.614 Y116.938 I3.028 J8.909 E.05399
G1 X128.367 Y118.691 E.08224
G2 X127.634 Y118.69 I-.376 J3.548 E.02436
G1 X129.386 Y116.938 E.08215
G3 X130.964 Y117.326 I-1.45 J9.298 E.05399
; CHANGE_LAYER
; Z_HEIGHT: 2.8
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F15476.087
G1 X129.386 Y116.938 E-.61765
G1 X129.121 Y117.203 E-.14235
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 14/250
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
G3 Z3 I-.771 J-.941 P1  F30000
G1 X121.509 Y123.441 Z3
G1 Z2.8
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4410
G1 X121.817 Y122.787 E.02398
G3 X127.749 Y119.03 I6.19 J3.211 E.24411
G3 X131.381 Y119.896 I.263 J6.946 E.1254
G3 X121.497 Y123.499 I-3.375 J6.102 E1.058
G1 X121.874 Y123.605 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4410
G3 X127.781 Y119.421 I6.131 J2.394 E.23549
G3 X130.561 Y119.933 I.155 J6.956 E.08747
G3 X121.853 Y123.661 I-2.555 J6.066 E.94584
M204 S10000
; WIPE_START
G1 F12000
G1 X122.157 Y122.964 E-.28898
G1 X122.512 Y122.36 E-.26637
G1 X122.834 Y121.927 E-.20465
; WIPE_END
G1 E-.04 F1800
G1 X130.075 Y124.34 Z3.2 F30000
G1 X137.478 Y126.807 Z3.2
G1 Z2.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4410
G3 X122.338 Y118.344 I-9.485 J-.806 E1.26031
M73 P31 R18
G3 X128.532 Y116.497 I5.686 J7.758 E.21867
G3 X137.483 Y126.747 I-.539 J9.504 E.50289
G1 X137.879 Y126.841 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4410
G1 X137.87 Y126.84 E.00027
G3 X125.771 Y135.656 I-9.874 J-.841 E.5214
G3 X128.565 Y116.106 I2.223 J-9.657 E.9052
G3 X137.906 Y126 I-.569 J9.893 E.46082
G1 X137.881 Y126.781 E.024
M204 S10000
; WIPE_START
G1 F12000
G1 X137.87 Y126.84 E-.02294
G1 X137.772 Y127.676 E-.31968
G1 X137.595 Y128.498 E-.3198
G1 X137.52 Y128.744 E-.09757
; WIPE_END
G1 E-.04 F1800
G1 X131.905 Y132.187 Z3.2 F30000
G1 Z2.8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4410
G2 X133.174 Y131.174 I-3.937 J-6.231 E.05397
G1 X134.482 Y132.482 E.06139
G2 X137.063 Y127.387 I-6.525 J-6.505 E.19264
G1 X135.307 Y125.631 E.08237
G3 X135.307 Y126.369 I-3.451 J.369 E.02452
G1 X137.063 Y124.613 E.08237
G2 X134.482 Y119.518 I-9.106 J1.41 E.19264
G1 X133.174 Y120.826 E.06139
G2 X131.905 Y119.813 I-5.206 J5.218 E.05397
G1 X130.964 Y117.326 F30000
G1 F4410
G2 X129.386 Y116.938 I-3.028 J8.909 E.05399
G1 X127.634 Y118.69 E.08215
G3 X128.369 Y118.693 I.352 J3.739 E.02439
G1 X126.614 Y116.938 E.0823
G2 X125.036 Y117.326 I1.45 J9.298 E.05399
G1 X121.81 Y122.093 F30000
G1 F4410
G3 X122.822 Y120.822 I6.864 J4.43 E.05397
G1 X121.518 Y119.518 E.06122
G2 X118.937 Y124.613 I6.525 J6.505 E.19264
G1 X120.684 Y126.36 E.08193
G1 X120.684 Y125.64 E.02386
G1 X118.937 Y127.387 E.08193
G2 X121.518 Y132.482 I9.106 J-1.41 E.19264
G1 X122.822 Y131.178 E.06122
G3 X121.81 Y129.907 I5.852 J-5.701 E.05397
G1 X125.036 Y134.674 F30000
G1 F4410
G2 X126.614 Y135.062 I3.028 J-8.909 E.05399
G1 X128.367 Y133.309 E.08222
G3 X127.634 Y133.31 I-.372 J-3.425 E.02434
G1 X129.386 Y135.062 E.08215
G2 X130.964 Y134.674 I-1.45 J-9.298 E.05398
; CHANGE_LAYER
; Z_HEIGHT: 3
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F15476.087
G1 X129.386 Y135.062 E-.61765
G1 X129.121 Y134.797 E-.14235
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 15/250
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
G3 Z3.2 I1.009 J-.68 P1  F30000
G1 X121.495 Y123.477 Z3.2
G1 Z3
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4406
G1 X121.51 Y123.462 E.0007
G3 X127.74 Y119.031 I6.496 J2.537 E.26842
G3 X132.011 Y120.29 I.221 J7.121 E.15023
G3 X121.277 Y124.167 I-4.005 J5.709 E1.01017
G1 X121.477 Y123.534 E.02199
G1 X121.876 Y123.605 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4406
G3 X127.771 Y119.421 I6.131 J2.393 E.23516
G3 X130.561 Y119.933 I.169 J6.939 E.08776
G3 X121.854 Y123.661 I-2.554 J6.065 E.94575
M204 S10000
; WIPE_START
G1 F12000
G1 X122.157 Y122.964 E-.28896
G1 X122.512 Y122.36 E-.26637
G1 X122.834 Y121.927 E-.20467
; WIPE_END
G1 E-.04 F1800
G1 X130.075 Y124.34 Z3.4 F30000
G1 X137.477 Y126.807 Z3.4
G1 Z3
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4406
G3 X122.338 Y118.344 I-9.484 J-.806 E1.26024
G1 X123.129 Y117.823 E.03143
G3 X128.543 Y116.498 I4.844 J8.065 E.18771
G3 X137.481 Y126.747 I-.551 J9.502 E.50247
G1 X137.874 Y126.84 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4406
G3 X118.71 Y122.552 I-9.874 J-.84 E1.03894
G3 X128.576 Y116.107 I9.284 J3.438 E.38786
G3 X137.879 Y126.781 I-.576 J9.893 E.48458
M204 S10000
; WIPE_START
G1 F12000
G1 X137.772 Y127.676 E-.3425
G1 X137.595 Y128.498 E-.3198
G1 X137.52 Y128.744 E-.0977
; WIPE_END
G1 E-.04 F1800
G1 X133.458 Y122.282 Z3.4 F30000
G1 X131.905 Y119.813 Z3.4
G1 Z3
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4406
G3 X133.174 Y120.826 I-3.937 J6.231 E.05397
G1 X134.482 Y119.518 E.06139
G3 X137.063 Y124.613 I-6.525 J6.505 E.19264
G1 X135.307 Y126.369 E.08237
G2 X135.307 Y125.631 I-3.451 J-.369 E.02452
G1 X137.063 Y127.387 E.08237
G3 X134.482 Y132.482 I-9.106 J-1.41 E.19264
G1 X133.174 Y131.174 E.06139
G3 X131.905 Y132.187 I-5.206 J-5.218 E.05397
G1 X130.964 Y134.674 F30000
G1 F4406
G3 X129.386 Y135.062 I-3.028 J-8.91 E.05398
G1 X127.634 Y133.31 E.08215
G2 X128.367 Y133.309 I.36 J-3.426 E.02434
G1 X126.614 Y135.062 E.08222
G3 X121.518 Y132.482 I1.64 J-9.567 E.19233
G1 X122.822 Y131.178 E.06122
G3 X121.81 Y129.907 I5.852 J-5.701 E.05397
G1 X119.322 Y128.965 F30000
G1 F4406
G3 X118.939 Y127.385 I9.229 J-3.073 E.05399
G1 X120.684 Y125.64 E.08183
G1 X120.684 Y126.36 E.02386
G1 X118.937 Y124.613 E.08193
G3 X121.518 Y119.518 I9.106 J1.41 E.19264
G1 X122.822 Y120.822 E.06122
G2 X121.81 Y122.093 I5.852 J5.701 E.05397
G1 X125.036 Y117.326 F30000
G1 F4406
G3 X126.614 Y116.938 I3.028 J8.909 E.05399
G1 X128.369 Y118.693 E.08231
G2 X127.634 Y118.69 I-.384 J3.78 E.0244
G1 X129.386 Y116.938 E.08215
G3 X130.964 Y117.326 I-1.45 J9.298 E.05399
; CHANGE_LAYER
; Z_HEIGHT: 3.2
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F15476.087
G1 X129.386 Y116.938 E-.61765
G1 X129.121 Y117.203 E-.14235
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 16/250
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
G3 Z3.4 I-.773 J-.94 P1  F30000
G1 X121.495 Y123.477 Z3.4
G1 Z3.2
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4395
G1 X121.511 Y123.463 E.00072
G3 X127.73 Y119.031 I6.496 J2.536 E.26807
G3 X132.011 Y120.29 I.233 J7.116 E.15054
G3 X121.279 Y124.167 I-4.004 J5.709 E1.01004
G1 X121.477 Y123.534 E.02199
G1 X121.875 Y123.605 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4395
G3 X127.762 Y119.422 I6.131 J2.394 E.23487
G3 X131.191 Y120.239 I.25 J6.554 E.10967
G3 X121.854 Y123.661 I-3.185 J5.76 E.92434
M204 S10000
; WIPE_START
G1 F12000
G1 X122.157 Y122.964 E-.28897
G1 X122.512 Y122.36 E-.26637
G1 X122.834 Y121.927 E-.20466
; WIPE_END
G1 E-.04 F1800
G1 X130.075 Y124.34 Z3.6 F30000
G1 X137.478 Y126.807 Z3.6
G1 Z3.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4395
G3 X121.709 Y118.852 I-9.485 J-.805 E1.23352
G3 X128.555 Y116.499 I6.279 J7.133 E.24634
G3 X137.483 Y126.747 I-.561 J9.502 E.50211
G1 X137.87 Y126.84 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4395
G3 X125.749 Y135.65 I-9.873 J-.84 E.52209
G3 X128.588 Y116.108 I2.251 J-9.65 E.90484
G3 X137.875 Y126.78 I-.591 J9.891 E.48412
M204 S10000
; WIPE_START
G1 F12000
G1 X137.772 Y127.676 E-.34246
G1 X137.595 Y128.498 E-.3198
G1 X137.52 Y128.744 E-.09774
; WIPE_END
G1 E-.04 F1800
G1 X131.905 Y132.187 Z3.6 F30000
G1 Z3.2
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4395
G2 X133.174 Y131.174 I-3.937 J-6.231 E.05397
G1 X134.482 Y132.482 E.06139
G2 X137.063 Y127.387 I-6.525 J-6.505 E.19264
G1 X135.307 Y125.631 E.08237
G3 X135.307 Y126.369 I-3.451 J.369 E.02452
G1 X137.063 Y124.613 E.08237
G2 X134.482 Y119.518 I-9.106 J1.41 E.19264
G1 X133.174 Y120.826 E.06139
G2 X131.905 Y119.813 I-5.206 J5.218 E.05397
G1 X130.964 Y117.326 F30000
G1 F4395
G2 X129.386 Y116.938 I-3.028 J8.909 E.05398
G1 X127.634 Y118.69 E.08215
G3 X128.369 Y118.693 I.349 J3.829 E.0244
G1 X126.614 Y116.938 E.08232
G2 X125.036 Y117.326 I1.45 J9.297 E.05398
G1 X121.81 Y122.093 F30000
G1 F4395
G3 X122.822 Y120.822 I6.864 J4.431 E.05397
G1 X121.518 Y119.518 E.06122
G2 X118.937 Y124.613 I6.525 J6.505 E.19264
G1 X120.684 Y126.36 E.08193
G1 X120.684 Y125.64 E.02386
G1 X118.937 Y127.387 E.08193
G2 X121.518 Y132.482 I9.106 J-1.41 E.19264
G1 X122.822 Y131.178 E.06122
G3 X121.81 Y129.907 I5.852 J-5.701 E.05397
G1 X125.036 Y134.674 F30000
G1 F4395
G2 X126.614 Y135.062 I3.028 J-8.909 E.05398
G1 X128.367 Y133.309 E.08222
G3 X127.634 Y133.31 I-.372 J-3.425 E.02434
G1 X129.386 Y135.062 E.08215
G2 X130.964 Y134.674 I-1.45 J-9.298 E.05399
; CHANGE_LAYER
; Z_HEIGHT: 3.4
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F15476.087
G1 X129.386 Y135.062 E-.61765
G1 X129.121 Y134.797 E-.14235
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 17/250
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
G3 Z3.6 I1.009 J-.68 P1  F30000
G1 X121.495 Y123.477 Z3.6
G1 Z3.4
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4414
G1 X121.511 Y123.463 E.00071
G3 X127.721 Y119.032 I6.496 J2.537 E.26776
G3 X132.595 Y120.749 I.29 J6.954 E.17562
G3 X121.278 Y124.167 I-4.589 J5.251 E.98547
G1 X121.477 Y123.534 E.02199
G1 X121.877 Y123.606 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4414
G3 X127.752 Y119.423 I6.13 J2.393 E.23454
G3 X131.191 Y120.239 I.261 J6.55 E.10996
G3 X121.855 Y123.662 I-3.184 J5.759 E.92414
M204 S10000
; WIPE_START
G1 F12000
G1 X122.157 Y122.964 E-.28895
G1 X122.512 Y122.36 E-.26637
G1 X122.834 Y121.927 E-.20468
; WIPE_END
G1 E-.04 F1800
G1 X130.075 Y124.34 Z3.8 F30000
G1 X137.477 Y126.807 Z3.8
G1 Z3.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4414
G3 X121.709 Y118.852 I-9.484 J-.806 E1.23345
G3 X128.566 Y116.5 I6.278 J7.132 E.24672
G3 X137.482 Y126.747 I-.573 J9.501 E.5017
M73 P31 R17
G1 X137.87 Y126.84 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4414
G3 X125.738 Y135.647 I-9.873 J-.84 E.52243
G3 X128.599 Y116.109 I2.256 J-9.648 E.90517
G3 X137.875 Y126.78 I-.602 J9.89 E.48376
M204 S10000
; WIPE_START
G1 F12000
G1 X137.772 Y127.676 E-.34246
G1 X137.595 Y128.498 E-.3198
G1 X137.52 Y128.744 E-.09774
; WIPE_END
G1 E-.04 F1800
G1 X133.458 Y122.282 Z3.8 F30000
G1 X131.905 Y119.813 Z3.8
G1 Z3.4
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4414
G3 X133.174 Y120.826 I-3.937 J6.231 E.05397
G1 X134.482 Y119.518 E.06139
G3 X137.063 Y124.613 I-6.525 J6.505 E.19264
G1 X135.307 Y126.369 E.08237
G2 X135.307 Y125.631 I-3.451 J-.369 E.02452
G1 X137.063 Y127.387 E.08237
G3 X134.482 Y132.482 I-9.106 J-1.41 E.19264
G1 X133.174 Y131.174 E.06139
G3 X131.905 Y132.187 I-5.206 J-5.218 E.05397
M73 P32 R17
G1 X130.964 Y134.674 F30000
G1 F4414
G3 X129.386 Y135.062 I-3.028 J-8.909 E.05399
G1 X127.634 Y133.31 E.08215
G2 X128.367 Y133.309 I.36 J-3.426 E.02434
G1 X126.614 Y135.062 E.08222
G3 X125.036 Y134.674 I1.45 J-9.298 E.05398
G1 X121.81 Y129.907 F30000
G1 F4414
G2 X122.822 Y131.178 I6.864 J-4.43 E.05397
G1 X121.518 Y132.482 E.06122
G3 X118.937 Y127.387 I6.525 J-6.505 E.19264
G1 X120.684 Y125.64 E.08193
G1 X120.684 Y126.36 E.02386
G1 X118.937 Y124.613 E.08193
G3 X121.518 Y119.518 I9.106 J1.41 E.19264
G1 X122.822 Y120.822 E.06122
G2 X121.81 Y122.093 I5.852 J5.701 E.05397
G1 X125.036 Y117.326 F30000
G1 F4414
G3 X126.614 Y116.938 I3.028 J8.909 E.05398
G1 X128.369 Y118.693 E.08233
G2 X127.634 Y118.69 I-.387 J3.871 E.02441
G1 X129.386 Y116.938 E.08215
G3 X130.964 Y117.326 I-1.45 J9.298 E.05399
; CHANGE_LAYER
; Z_HEIGHT: 3.6
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F15476.087
G1 X129.386 Y116.938 E-.61765
G1 X129.121 Y117.203 E-.14235
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 18/250
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
G3 Z3.8 I-.773 J-.94 P1  F30000
G1 X121.495 Y123.477 Z3.8
G1 Z3.6
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4403
G1 X121.512 Y123.463 E.00072
G3 X127.711 Y119.033 I6.495 J2.537 E.26742
G3 X132.595 Y120.749 I.301 J6.952 E.17593
G3 X121.279 Y124.167 I-4.588 J5.251 E.98543
G1 X121.477 Y123.535 E.02199
G1 X121.876 Y123.605 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4403
G3 X127.743 Y119.424 I6.13 J2.394 E.23426
G3 X131.785 Y120.611 I.223 J6.714 E.13168
G3 X121.854 Y123.661 I-3.779 J5.388 E.90274
M204 S10000
; WIPE_START
G1 F12000
G1 X122.157 Y122.964 E-.28896
G1 X122.512 Y122.36 E-.26637
G1 X122.834 Y121.927 E-.20467
; WIPE_END
G1 E-.04 F1800
G1 X130.075 Y124.34 Z4 F30000
G1 X137.478 Y126.807 Z4
G1 Z3.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4403
G3 X121.125 Y119.411 I-9.484 J-.805 E1.20668
G3 X128.577 Y116.501 I6.89 J6.647 E.27378
G3 X137.482 Y126.747 I-.584 J9.501 E.50134
G1 X137.869 Y126.84 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4403
G3 X120.286 Y119.771 I-9.875 J-.838 E1.13794
G3 X128.61 Y116.11 I7.702 J6.218 E.29033
G3 X137.873 Y126.78 I-.617 J9.891 E.48332
M204 S10000
; WIPE_START
G1 F12000
G1 X137.772 Y127.676 E-.34245
G1 X137.595 Y128.498 E-.3198
G1 X137.52 Y128.744 E-.09775
; WIPE_END
G1 E-.04 F1800
G1 X131.905 Y132.187 Z4 F30000
G1 Z3.6
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4403
G2 X133.174 Y131.174 I-3.937 J-6.231 E.05397
G1 X134.482 Y132.482 E.06139
G2 X137.063 Y127.387 I-6.525 J-6.505 E.19264
G1 X135.307 Y125.631 E.08237
G3 X135.307 Y126.369 I-3.451 J.369 E.02452
G1 X137.063 Y124.613 E.08237
G2 X134.482 Y119.518 I-9.106 J1.41 E.19264
G1 X133.174 Y120.826 E.06139
G3 X134.189 Y122.094 I-5.326 J5.303 E.05397
G1 X130.964 Y117.326 F30000
G1 F4403
G2 X129.386 Y116.938 I-3.028 J8.91 E.05399
G1 X127.634 Y118.69 E.08215
G3 X128.369 Y118.693 I.347 J3.92 E.02442
G1 X126.614 Y116.938 E.08234
G2 X125.036 Y117.326 I1.45 J9.297 E.05398
G1 X121.81 Y122.093 F30000
G1 F4403
G3 X122.822 Y120.822 I6.864 J4.431 E.05397
G1 X121.518 Y119.518 E.06122
G2 X118.937 Y124.613 I6.525 J6.505 E.19264
G1 X120.684 Y126.36 E.08193
G1 X120.684 Y125.64 E.02386
G1 X118.937 Y127.387 E.08193
G2 X121.518 Y132.482 I9.106 J-1.41 E.19264
G1 X122.822 Y131.178 E.06122
G3 X121.81 Y129.907 I5.852 J-5.701 E.05397
G1 X125.036 Y134.674 F30000
G1 F4403
G2 X126.614 Y135.062 I3.028 J-8.909 E.05398
G1 X128.367 Y133.309 E.08222
G3 X127.634 Y133.31 I-.372 J-3.425 E.02434
G1 X129.386 Y135.062 E.08215
G2 X130.964 Y134.674 I-1.45 J-9.298 E.05399
; CHANGE_LAYER
; Z_HEIGHT: 3.8
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F15476.087
G1 X129.386 Y135.062 E-.61765
G1 X129.121 Y134.797 E-.14235
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 19/250
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
G3 Z4 I1.009 J-.68 P1  F30000
G1 X121.495 Y123.477 Z4
G1 Z3.8
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4406
G1 X121.511 Y123.463 E.00071
G3 X127.702 Y119.034 I6.495 J2.538 E.26711
G3 X133.127 Y121.267 I.274 J7.041 E.20073
G3 X121.278 Y124.167 I-5.121 J4.734 E.96086
G1 X121.477 Y123.534 E.02199
G1 X121.877 Y123.606 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4406
G3 X127.733 Y119.424 I6.13 J2.393 E.23394
G3 X131.785 Y120.611 I.235 J6.708 E.13197
G3 X121.856 Y123.662 I-3.778 J5.388 E.90263
M204 S10000
; WIPE_START
G1 F12000
G1 X122.157 Y122.964 E-.28895
G1 X122.512 Y122.36 E-.26637
G1 X122.834 Y121.927 E-.20468
; WIPE_END
G1 E-.04 F1800
G1 X130.075 Y124.34 Z4.2 F30000
G1 X137.477 Y126.807 Z4.2
G1 Z3.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4406
G3 X121.125 Y119.411 I-9.484 J-.805 E1.20667
G3 X128.589 Y116.502 I6.889 J6.646 E.27415
G3 X137.482 Y126.747 I-.596 J9.5 E.50094
G1 X137.873 Y126.84 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4406
G3 X118.727 Y122.51 I-9.873 J-.84 E1.04022
G3 X128.622 Y116.111 I9.255 J3.462 E.38793
G3 X137.878 Y126.78 I-.622 J9.889 E.48312
M204 S10000
; WIPE_START
G1 F12000
G1 X137.772 Y127.676 E-.34249
G1 X137.595 Y128.498 E-.3198
G1 X137.52 Y128.744 E-.09771
; WIPE_END
G1 E-.04 F1800
G1 X134.189 Y122.094 Z4.2 F30000
G1 Z3.8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4406
G2 X133.174 Y120.826 I-6.341 J4.035 E.05397
G1 X134.482 Y119.518 E.06139
G3 X137.063 Y124.613 I-6.525 J6.505 E.19264
G1 X135.307 Y126.369 E.08237
G2 X135.307 Y125.631 I-3.451 J-.369 E.02452
G1 X137.063 Y127.387 E.08237
G3 X134.482 Y132.482 I-9.106 J-1.41 E.19264
G1 X133.174 Y131.174 E.06139
G3 X131.905 Y132.187 I-5.206 J-5.218 E.05397
G1 X130.964 Y134.674 F30000
G1 F4406
G3 X129.386 Y135.062 I-3.028 J-8.909 E.05399
G1 X127.634 Y133.31 E.08215
G2 X128.367 Y133.309 I.36 J-3.426 E.02434
G1 X126.614 Y135.062 E.08222
G3 X125.036 Y134.674 I1.45 J-9.298 E.05399
G1 X121.81 Y129.907 F30000
G1 F4406
G2 X122.822 Y131.178 I6.864 J-4.431 E.05397
G1 X121.518 Y132.482 E.06122
G3 X118.937 Y127.387 I6.525 J-6.505 E.19264
G1 X120.684 Y125.64 E.08193
G1 X120.684 Y126.36 E.02386
G1 X118.937 Y124.613 E.08193
G3 X121.518 Y119.518 I9.106 J1.41 E.19264
G1 X122.822 Y120.822 E.06122
G2 X121.81 Y122.093 I5.852 J5.701 E.05397
G1 X125.036 Y117.326 F30000
G1 F4406
G3 X126.614 Y116.938 I3.028 J8.909 E.05398
G1 X128.37 Y118.694 E.08235
G2 X127.634 Y118.69 I-.39 J3.96 E.02442
G1 X129.386 Y116.938 E.08215
G3 X130.964 Y117.326 I-1.45 J9.298 E.05399
; CHANGE_LAYER
; Z_HEIGHT: 4
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F15476.087
G1 X129.386 Y116.938 E-.61765
G1 X129.121 Y117.203 E-.14235
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 20/250
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
G3 Z4.2 I-.773 J-.94 P1  F30000
G1 X121.495 Y123.477 Z4.2
G1 Z4
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4402
G1 X121.512 Y123.463 E.00072
G3 X127.693 Y119.034 I6.495 J2.537 E.26677
G3 X133.127 Y121.267 I.285 J7.038 E.20104
G3 X121.279 Y124.167 I-5.12 J4.734 E.96082
G1 X121.477 Y123.535 E.02199
G1 X121.876 Y123.606 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4402
G3 X127.724 Y119.425 I6.13 J2.395 E.23366
G3 X132.336 Y121.044 I.288 J6.56 E.15392
G3 X121.855 Y123.662 I-4.33 J4.956 E.88122
M204 S10000
; WIPE_START
G1 F12000
G1 X122.157 Y122.964 E-.28896
G1 X122.512 Y122.36 E-.26637
G1 X122.834 Y121.927 E-.20467
; WIPE_END
G1 E-.04 F1800
G1 X130.075 Y124.34 Z4.4 F30000
G1 X137.477 Y126.807 Z4.4
G1 Z4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4402
G3 X121.125 Y119.411 I-9.484 J-.805 E1.20666
G3 X128.6 Y116.503 I6.888 J6.644 E.27453
G3 X137.481 Y126.747 I-.607 J9.499 E.50054
G1 X137.87 Y126.84 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4402
G3 X125.705 Y135.639 I-9.872 J-.84 E.52347
G3 X128.633 Y116.112 I2.297 J-9.638 E.90462
G3 X137.875 Y126.78 I-.635 J9.888 E.4827
M204 S10000
; WIPE_START
G1 F12000
G1 X137.772 Y127.676 E-.34246
G1 X137.595 Y128.498 E-.3198
G1 X137.52 Y128.744 E-.09774
; WIPE_END
G1 E-.04 F1800
G1 X131.905 Y132.187 Z4.4 F30000
G1 Z4
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4402
G2 X133.174 Y131.174 I-3.937 J-6.231 E.05397
G1 X134.482 Y132.482 E.06139
G2 X137.063 Y127.387 I-6.525 J-6.505 E.19264
G1 X135.307 Y125.631 E.08237
G3 X135.307 Y126.369 I-3.451 J.369 E.02452
G1 X137.063 Y124.613 E.08237
G2 X134.482 Y119.518 I-9.106 J1.41 E.19264
G1 X133.174 Y120.826 E.06139
G3 X134.189 Y122.094 I-5.326 J5.303 E.05397
G1 X130.964 Y117.326 F30000
G1 F4402
G2 X129.386 Y116.938 I-3.028 J8.909 E.05399
G1 X127.634 Y118.69 E.08215
G3 X128.37 Y118.694 I.344 J4.01 E.02443
G1 X126.614 Y116.938 E.08236
G2 X125.036 Y117.326 I1.45 J9.298 E.05399
G1 X121.81 Y122.093 F30000
G1 F4402
G3 X122.822 Y120.822 I6.864 J4.43 E.05397
G1 X121.518 Y119.518 E.06122
G2 X118.937 Y124.613 I6.525 J6.505 E.19264
G1 X120.684 Y126.36 E.08193
G1 X120.684 Y125.64 E.02386
G1 X118.937 Y127.387 E.08193
G2 X121.518 Y132.482 I9.106 J-1.41 E.19264
G1 X122.822 Y131.178 E.06122
G3 X121.81 Y129.907 I5.852 J-5.701 E.05397
G1 X125.036 Y134.674 F30000
G1 F4402
G2 X126.614 Y135.062 I3.028 J-8.909 E.05398
G1 X128.367 Y133.309 E.08222
G3 X127.634 Y133.31 I-.372 J-3.425 E.02434
G1 X129.386 Y135.062 E.08215
G2 X130.964 Y134.674 I-1.45 J-9.298 E.05399
; CHANGE_LAYER
; Z_HEIGHT: 4.2
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F15476.087
G1 X129.386 Y135.062 E-.61765
G1 X129.121 Y134.797 E-.14235
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 21/250
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
G3 Z4.4 I1.011 J-.678 P1  F30000
G1 X121.509 Y123.441 Z4.4
G1 Z4.2
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4421
G1 X121.817 Y122.787 E.02398
G3 X127.683 Y119.035 I6.189 J3.214 E.24185
G3 X133.601 Y121.839 I.328 J6.956 E.22615
M73 P33 R17
G3 X121.497 Y123.499 I-5.595 J4.162 E.95959
G1 X121.877 Y123.606 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4421
G3 X127.714 Y119.426 I6.13 J2.395 E.23334
G3 X132.336 Y121.044 I.298 J6.558 E.1542
G3 X121.855 Y123.662 I-4.33 J4.956 E.88119
M204 S10000
; WIPE_START
G1 F12000
G1 X122.157 Y122.964 E-.28895
G1 X122.512 Y122.36 E-.26637
G1 X122.834 Y121.927 E-.20468
; WIPE_END
G1 E-.04 F1800
G1 X130.075 Y124.34 Z4.6 F30000
G1 X137.477 Y126.807 Z4.6
G1 Z4.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4421
G3 X120.591 Y120.018 I-9.484 J-.805 E1.17988
G3 X128.611 Y116.504 I7.396 J5.971 E.30185
G3 X137.482 Y126.747 I-.618 J9.498 E.50018
G1 X137.868 Y126.84 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4421
G3 X119.785 Y120.448 I-9.875 J-.838 E1.1121
G3 X128.645 Y116.113 I8.226 J5.591 E.31709
G3 X137.873 Y126.78 I-.651 J9.889 E.48225
M204 S10000
; WIPE_START
G1 F12000
G1 X137.772 Y127.676 E-.34244
G1 X137.595 Y128.498 E-.3198
G1 X137.52 Y128.744 E-.09775
; WIPE_END
G1 E-.04 F1800
G1 X134.189 Y122.094 Z4.6 F30000
G1 Z4.2
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4421
G2 X133.174 Y120.826 I-6.34 J4.035 E.05397
G1 X134.482 Y119.518 E.06139
G3 X137.063 Y124.613 I-6.525 J6.505 E.19264
G1 X135.307 Y126.369 E.08237
G2 X135.307 Y125.631 I-3.451 J-.369 E.02452
G1 X137.063 Y127.387 E.08237
G3 X134.482 Y132.482 I-9.106 J-1.41 E.19264
G1 X133.174 Y131.174 E.06139
G3 X131.905 Y132.187 I-5.206 J-5.218 E.05397
G1 X130.964 Y134.674 F30000
G1 F4421
G3 X129.386 Y135.062 I-3.028 J-8.91 E.05398
G1 X127.634 Y133.31 E.08215
G2 X128.367 Y133.309 I.36 J-3.426 E.02434
G1 X126.614 Y135.062 E.08222
G3 X125.036 Y134.674 I1.45 J-9.298 E.05398
G1 X121.81 Y129.907 F30000
G1 F4421
G2 X122.822 Y131.178 I6.864 J-4.431 E.05397
G1 X121.518 Y132.482 E.06122
G3 X118.937 Y127.387 I6.525 J-6.505 E.19264
G1 X120.684 Y125.64 E.08193
G1 X120.684 Y126.36 E.02386
G1 X118.937 Y124.613 E.08193
G3 X121.518 Y119.518 I9.106 J1.41 E.19264
G1 X122.822 Y120.822 E.06122
G2 X121.81 Y122.093 I5.852 J5.701 E.05397
G1 X125.036 Y117.326 F30000
G1 F4421
G3 X126.614 Y116.938 I3.028 J8.909 E.05399
G1 X128.37 Y118.694 E.08236
G2 X127.634 Y118.69 I-.393 J4.051 E.02443
G1 X129.386 Y116.938 E.08215
G3 X130.964 Y117.326 I-1.45 J9.298 E.05399
; CHANGE_LAYER
; Z_HEIGHT: 4.4
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F15476.087
G1 X129.386 Y116.938 E-.61766
G1 X129.121 Y117.203 E-.14235
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 22/250
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
G3 Z4.6 I-.773 J-.94 P1  F30000
G1 X121.495 Y123.477 Z4.6
G1 Z4.4
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4395
G1 X121.512 Y123.463 E.00072
G3 X127.674 Y119.036 I6.495 J2.538 E.26613
G3 X133.601 Y121.839 I.338 J6.954 E.22646
G3 X121.279 Y124.167 I-5.595 J4.162 E.93622
G1 X121.477 Y123.535 E.02199
G1 X121.876 Y123.606 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4395
G3 X127.705 Y119.427 I6.13 J2.395 E.23306
G3 X132.839 Y121.533 I.274 J6.641 E.17589
G3 X121.855 Y123.662 I-4.832 J4.468 E.85971
M204 S10000
; WIPE_START
G1 F12000
G1 X122.157 Y122.964 E-.28896
G1 X122.512 Y122.36 E-.26637
G1 X122.834 Y121.927 E-.20467
; WIPE_END
G1 E-.04 F1800
G1 X130.075 Y124.34 Z4.8 F30000
G1 X137.477 Y126.807 Z4.8
G1 Z4.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4395
G3 X120.591 Y120.018 I-9.484 J-.804 E1.17987
G3 X128.623 Y116.505 I7.396 J5.971 E.30222
G3 X137.482 Y126.747 I-.63 J9.497 E.49978
G1 X137.868 Y126.84 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4395
G3 X119.785 Y120.448 I-9.875 J-.837 E1.11209
G3 X128.656 Y116.114 I8.225 J5.59 E.31743
G3 X137.873 Y126.78 I-.663 J9.888 E.48188
M204 S10000
; WIPE_START
G1 F12000
G1 X137.772 Y127.676 E-.34244
G1 X137.595 Y128.498 E-.3198
G1 X137.52 Y128.744 E-.09776
; WIPE_END
G1 E-.04 F1800
G1 X131.905 Y132.187 Z4.8 F30000
G1 Z4.4
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4395
G2 X133.174 Y131.174 I-3.937 J-6.231 E.05397
G1 X134.482 Y132.482 E.06139
G2 X137.063 Y127.387 I-6.525 J-6.505 E.19264
G1 X135.307 Y125.631 E.08237
G3 X135.307 Y126.369 I-3.451 J.369 E.02452
G1 X137.063 Y124.613 E.08237
G2 X134.482 Y119.518 I-9.106 J1.41 E.19264
G1 X133.174 Y120.826 E.06139
G2 X131.905 Y119.813 I-5.206 J5.218 E.05397
G1 X130.964 Y117.326 F30000
G1 F4395
G2 X129.386 Y116.938 I-3.028 J8.91 E.05399
G1 X127.646 Y118.689 E.08186
G3 X128.367 Y118.691 I.35 J3.373 E.02396
G1 X126.614 Y116.938 E.08222
G2 X125.036 Y117.326 I1.45 J9.297 E.05398
G1 X121.81 Y122.093 F30000
G1 F4395
G3 X122.822 Y120.822 I6.864 J4.43 E.05397
G1 X121.518 Y119.518 E.06122
G2 X118.937 Y124.613 I6.525 J6.505 E.19264
G1 X120.684 Y126.36 E.08193
G1 X120.684 Y125.64 E.02386
G1 X118.937 Y127.387 E.08193
G2 X121.518 Y132.482 I9.106 J-1.41 E.19264
G1 X122.822 Y131.178 E.06122
G3 X121.81 Y129.907 I5.852 J-5.701 E.05397
G1 X125.036 Y134.674 F30000
G1 F4395
G2 X126.614 Y135.062 I3.028 J-8.909 E.05399
G1 X128.367 Y133.309 E.08222
G3 X127.634 Y133.31 I-.372 J-3.425 E.02434
G1 X129.386 Y135.062 E.08215
G2 X130.964 Y134.674 I-1.45 J-9.298 E.05399
; CHANGE_LAYER
; Z_HEIGHT: 4.6
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F15476.087
G1 X129.386 Y135.062 E-.61765
G1 X129.121 Y134.797 E-.14235
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 23/250
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
G3 Z4.8 I1.009 J-.68 P1  F30000
G1 X121.495 Y123.477 Z4.8
G1 Z4.6
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4413
G1 X121.511 Y123.463 E.00072
G3 X127.664 Y119.037 I6.495 J2.539 E.26582
G3 X133.505 Y121.723 I.36 J6.911 E.22179
G1 X133.601 Y121.839 E.00499
G1 X134.012 Y122.458 E.02464
G3 X121.278 Y124.167 I-6.006 J3.544 E.91164
G1 X121.477 Y123.534 E.02199
G1 X121.877 Y123.606 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4413
G3 X127.696 Y119.427 I6.13 J2.395 E.23275
G3 X132.839 Y121.533 I.285 J6.638 E.17618
G3 X121.855 Y123.662 I-4.832 J4.468 E.85968
M204 S10000
; WIPE_START
G1 F12000
G1 X122.157 Y122.964 E-.28895
G1 X122.512 Y122.36 E-.26637
G1 X122.834 Y121.927 E-.20468
; WIPE_END
G1 E-.04 F1800
G1 X130.075 Y124.34 Z5 F30000
G1 X137.477 Y126.807 Z5
G1 Z4.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4413
G3 X120.591 Y120.018 I-9.484 J-.804 E1.17987
G3 X128.634 Y116.506 I7.395 J5.97 E.3026
G3 X137.482 Y126.747 I-.641 J9.496 E.49939
G1 X137.868 Y126.84 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4413
G3 X119.785 Y120.448 I-9.875 J-.837 E1.11209
G3 X128.667 Y116.115 I8.224 J5.589 E.31778
G3 X137.873 Y126.78 I-.674 J9.887 E.48152
M204 S10000
; WIPE_START
G1 F12000
G1 X137.772 Y127.676 E-.34244
G1 X137.595 Y128.498 E-.3198
G1 X137.52 Y128.744 E-.09776
; WIPE_END
G1 E-.04 F1800
G1 X133.458 Y122.283 Z5 F30000
G1 X131.905 Y119.813 Z5
G1 Z4.6
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4413
G3 X133.174 Y120.826 I-3.937 J6.231 E.05397
G1 X134.482 Y119.518 E.06139
G3 X137.063 Y124.613 I-6.525 J6.505 E.19264
G1 X135.307 Y126.369 E.08237
G2 X135.307 Y125.631 I-3.451 J-.369 E.02452
G1 X137.063 Y127.387 E.08237
G3 X134.482 Y132.482 I-9.106 J-1.41 E.19264
G1 X133.174 Y131.174 E.06139
G3 X131.905 Y132.187 I-5.206 J-5.218 E.05397
G1 X130.964 Y134.674 F30000
G1 F4413
G3 X129.386 Y135.062 I-3.028 J-8.909 E.05399
G1 X127.634 Y133.31 E.08215
G2 X128.367 Y133.309 I.36 J-3.426 E.02434
G1 X126.614 Y135.062 E.08222
G3 X125.036 Y134.674 I1.45 J-9.298 E.05398
G1 X121.81 Y129.907 F30000
G1 F4413
G2 X122.822 Y131.178 I6.864 J-4.43 E.05397
G1 X121.518 Y132.482 E.06122
G3 X118.937 Y127.387 I6.525 J-6.505 E.19264
G1 X120.684 Y125.64 E.08193
G1 X120.684 Y126.36 E.02386
G1 X118.937 Y124.613 E.08193
G3 X121.518 Y119.518 I9.106 J1.41 E.19264
G1 X122.822 Y120.822 E.06122
G2 X121.81 Y122.093 I5.852 J5.701 E.05397
G1 X125.036 Y117.326 F30000
G1 F4413
G3 X126.614 Y116.938 I3.028 J8.909 E.05399
G1 X128.367 Y118.691 E.08222
G2 X127.634 Y118.69 I-.373 J3.943 E.02433
G1 X129.386 Y116.938 E.08215
G3 X130.964 Y117.326 I-1.45 J9.297 E.05398
; CHANGE_LAYER
; Z_HEIGHT: 4.8
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F15476.087
G1 X129.386 Y116.938 E-.61765
G1 X129.121 Y117.203 E-.14235
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 24/250
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
G3 Z5 I-.773 J-.94 P1  F30000
G1 X121.495 Y123.477 Z5
G1 Z4.8
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4395
G1 X121.512 Y123.463 E.00072
G3 X127.655 Y119.037 I6.495 J2.539 E.26549
G3 X134.012 Y122.458 I.33 J7.005 E.25154
G3 X121.279 Y124.167 I-6.005 J3.544 E.91162
G1 X121.477 Y123.535 E.02199
G1 X121.876 Y123.606 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4395
G3 X127.686 Y119.428 I6.13 J2.396 E.23246
G3 X133.286 Y122.073 I.325 J6.562 E.19815
G3 X121.855 Y123.662 I-5.28 J3.929 E.8382
M204 S10000
; WIPE_START
G1 F12000
G1 X122.157 Y122.964 E-.28895
G1 X122.512 Y122.36 E-.26637
G1 X122.834 Y121.927 E-.20468
; WIPE_END
G1 E-.04 F1800
G1 X130.075 Y124.34 Z5.2 F30000
G1 X137.478 Y126.807 Z5.2
G1 Z4.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4395
G3 X120.111 Y120.668 I-9.484 J-.804 E1.15309
G3 X128.645 Y116.507 I7.899 J5.368 E.32964
G3 X137.482 Y126.747 I-.652 J9.496 E.49903
G1 X137.869 Y126.84 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4395
G3 X119.344 Y121.165 I-9.875 J-.837 E1.08626
G3 X128.679 Y116.116 I8.644 J4.828 E.34414
G3 X137.874 Y126.78 I-.685 J9.887 E.48119
M204 S10000
; WIPE_START
G1 F12000
G1 X137.772 Y127.676 E-.34245
G1 X137.595 Y128.498 E-.3198
G1 X137.52 Y128.744 E-.09775
; WIPE_END
G1 E-.04 F1800
G1 X131.905 Y132.187 Z5.2 F30000
G1 Z4.8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4395
G2 X133.174 Y131.174 I-3.937 J-6.231 E.05397
G1 X134.482 Y132.482 E.06139
G2 X137.063 Y127.387 I-6.525 J-6.505 E.19264
G1 X135.307 Y125.631 E.08237
M73 P34 R17
G3 X135.307 Y126.369 I-3.451 J.369 E.02452
G1 X137.063 Y124.613 E.08237
G2 X134.482 Y119.518 I-9.106 J1.41 E.19264
G1 X133.174 Y120.826 E.06139
G2 X131.905 Y119.813 I-5.206 J5.218 E.05397
G1 X130.964 Y117.326 F30000
G1 F4395
G2 X129.386 Y116.938 I-3.028 J8.909 E.05398
G1 X127.634 Y118.69 E.08215
G3 X128.367 Y118.691 I.36 J3.426 E.02434
G1 X126.614 Y116.938 E.08222
G2 X125.036 Y117.326 I1.45 J9.297 E.05398
G1 X121.81 Y122.093 F30000
G1 F4395
G3 X122.822 Y120.822 I6.864 J4.43 E.05397
G1 X121.518 Y119.518 E.06122
G2 X118.937 Y124.613 I6.525 J6.505 E.19264
G1 X120.684 Y126.36 E.08193
G1 X120.684 Y125.64 E.02386
G1 X118.937 Y127.387 E.08193
G2 X121.518 Y132.482 I9.106 J-1.41 E.19264
G1 X122.822 Y131.178 E.06122
G3 X121.81 Y129.907 I5.852 J-5.701 E.05397
G1 X125.036 Y134.674 F30000
G1 F4395
G2 X126.614 Y135.062 I3.028 J-8.909 E.05398
G1 X128.367 Y133.309 E.08222
G3 X127.634 Y133.31 I-.372 J-3.425 E.02434
G1 X129.386 Y135.062 E.08215
G2 X130.964 Y134.674 I-1.45 J-9.298 E.05399
; CHANGE_LAYER
; Z_HEIGHT: 5
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F15476.087
G1 X129.386 Y135.062 E-.61765
G1 X129.121 Y134.797 E-.14235
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 25/250
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
G3 Z5.2 I1.011 J-.678 P1  F30000
G1 X121.509 Y123.441 Z5.2
G1 Z5
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4427
G1 X121.818 Y122.788 E.02398
G3 X127.645 Y119.038 I6.188 J3.214 E.24055
G3 X134.012 Y122.458 I.34 J7.003 E.25185
G3 X121.498 Y123.499 I-6.005 J3.544 E.93495
G1 X121.877 Y123.606 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4427
G3 X127.677 Y119.429 I6.13 J2.396 E.23216
G3 X133.286 Y122.073 I.335 J6.561 E.19844
G3 X121.855 Y123.662 I-5.28 J3.929 E.83818
M204 S10000
; WIPE_START
G1 F12000
G1 X122.157 Y122.964 E-.28895
G1 X122.512 Y122.36 E-.26637
G1 X122.834 Y121.927 E-.20468
; WIPE_END
G1 E-.04 F1800
G1 X130.075 Y124.34 Z5.4 F30000
G1 X137.477 Y126.807 Z5.4
G1 Z5
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4427
G3 X120.111 Y120.668 I-9.484 J-.804 E1.15308
G3 X128.657 Y116.508 I7.898 J5.367 E.33001
G3 X137.482 Y126.747 I-.664 J9.495 E.49864
G1 X137.868 Y126.84 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4427
G3 X119.344 Y121.165 I-9.875 J-.837 E1.08625
G3 X128.69 Y116.117 I8.643 J4.828 E.34449
G3 X137.873 Y126.78 I-.697 J9.886 E.48083
M204 S10000
; WIPE_START
G1 F12000
G1 X137.772 Y127.676 E-.34244
G1 X137.595 Y128.498 E-.3198
G1 X137.52 Y128.744 E-.09776
; WIPE_END
G1 E-.04 F1800
G1 X133.458 Y122.283 Z5.4 F30000
G1 X131.905 Y119.813 Z5.4
G1 Z5
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4427
G3 X133.174 Y120.826 I-3.937 J6.231 E.05397
G1 X134.482 Y119.518 E.06139
G3 X137.063 Y124.613 I-6.525 J6.505 E.19264
G1 X135.307 Y126.369 E.08237
G2 X135.307 Y125.631 I-3.451 J-.369 E.02452
G1 X137.063 Y127.387 E.08237
G3 X134.482 Y132.482 I-9.106 J-1.41 E.19264
G1 X133.174 Y131.174 E.06139
G3 X131.905 Y132.187 I-5.206 J-5.218 E.05397
G1 X130.964 Y134.674 F30000
G1 F4427
G3 X129.386 Y135.062 I-3.028 J-8.909 E.05399
G1 X127.634 Y133.31 E.08215
G2 X128.367 Y133.309 I.36 J-3.426 E.02434
G1 X126.614 Y135.062 E.08222
G3 X125.036 Y134.674 I1.45 J-9.298 E.05399
G1 X121.81 Y129.907 F30000
G1 F4427
G2 X122.822 Y131.178 I6.864 J-4.43 E.05397
G1 X121.518 Y132.482 E.06122
G3 X118.937 Y127.387 I6.525 J-6.505 E.19264
G1 X120.684 Y125.64 E.08193
G1 X120.684 Y126.36 E.02386
G1 X118.937 Y124.613 E.08193
G3 X121.518 Y119.518 I9.106 J1.41 E.19264
G1 X122.822 Y120.822 E.06122
G2 X121.81 Y122.093 I5.852 J5.701 E.05397
G1 X125.036 Y117.326 F30000
G1 F4427
G3 X126.614 Y116.938 I3.028 J8.909 E.05398
G1 X128.367 Y118.691 E.08222
G2 X127.634 Y118.69 I-.372 J3.424 E.02434
G1 X129.386 Y116.938 E.08215
G3 X130.964 Y117.326 I-1.45 J9.298 E.05399
; CHANGE_LAYER
; Z_HEIGHT: 5.2
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F15476.087
G1 X129.386 Y116.938 E-.61765
G1 X129.121 Y117.203 E-.14235
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 26/250
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
G3 Z5.4 I-.773 J-.94 P1  F30000
G1 X121.495 Y123.477 Z5.4
G1 Z5.2
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4395
G1 X121.511 Y123.463 E.00072
G3 X127.636 Y119.039 I6.495 J2.539 E.26485
G3 X134.354 Y123.117 I.375 J6.955 E.27699
G3 X121.279 Y124.167 I-6.348 J2.886 E.88701
G1 X121.477 Y123.535 E.02199
G1 X121.878 Y123.606 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4395
G3 X127.667 Y119.43 I6.129 J2.395 E.23185
G3 X133.286 Y122.073 I.345 J6.56 E.19873
G3 X121.856 Y123.662 I-5.279 J3.929 E.8381
M204 S10000
; WIPE_START
G1 F12000
G1 X122.157 Y122.964 E-.28894
G1 X122.512 Y122.36 E-.26637
G1 X122.834 Y121.927 E-.20469
; WIPE_END
G1 E-.04 F1800
G1 X130.075 Y124.34 Z5.6 F30000
G1 X137.477 Y126.807 Z5.6
G1 Z5.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4395
G3 X120.111 Y120.668 I-9.484 J-.804 E1.15308
G3 X128.668 Y116.509 I7.898 J5.367 E.33039
G3 X137.482 Y126.747 I-.675 J9.494 E.49825
G1 X137.868 Y126.84 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4395
G3 X119.344 Y121.165 I-9.875 J-.837 E1.08625
G3 X128.701 Y116.118 I8.643 J4.828 E.34484
G3 X137.873 Y126.78 I-.708 J9.885 E.48046
M204 S10000
; WIPE_START
G1 F12000
G1 X137.772 Y127.676 E-.34244
G1 X137.595 Y128.498 E-.3198
G1 X137.52 Y128.744 E-.09776
; WIPE_END
G1 E-.04 F1800
G1 X131.905 Y132.187 Z5.6 F30000
G1 Z5.2
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4395
G2 X133.174 Y131.174 I-3.937 J-6.231 E.05397
G1 X134.482 Y132.482 E.06139
G2 X137.063 Y127.387 I-6.525 J-6.505 E.19264
G1 X135.307 Y125.631 E.08237
G3 X135.307 Y126.369 I-3.451 J.369 E.02452
G1 X137.063 Y124.613 E.08237
G2 X134.482 Y119.518 I-9.106 J1.41 E.19264
G1 X133.174 Y120.826 E.06139
G2 X131.905 Y119.813 I-5.206 J5.218 E.05397
G1 X130.964 Y117.326 F30000
G1 F4395
G2 X129.386 Y116.938 I-3.028 J8.91 E.05399
G1 X127.634 Y118.69 E.08215
G3 X128.367 Y118.691 I.36 J3.426 E.02434
G1 X126.614 Y116.938 E.08222
G2 X125.036 Y117.326 I1.45 J9.297 E.05398
G1 X121.81 Y122.093 F30000
G1 F4395
G3 X122.822 Y120.822 I6.864 J4.43 E.05397
G1 X121.518 Y119.518 E.06122
G2 X118.937 Y124.613 I6.525 J6.505 E.19264
G1 X120.684 Y126.36 E.08193
G1 X120.684 Y125.64 E.02386
G1 X118.937 Y127.387 E.08193
G2 X121.518 Y132.482 I9.106 J-1.41 E.19264
G1 X122.822 Y131.178 E.06122
G3 X121.81 Y129.907 I5.852 J-5.701 E.05397
G1 X125.036 Y134.674 F30000
G1 F4395
G2 X126.614 Y135.062 I3.028 J-8.91 E.05399
G1 X128.367 Y133.309 E.08222
G3 X127.634 Y133.31 I-.372 J-3.425 E.02434
G1 X129.386 Y135.062 E.08215
G2 X130.964 Y134.674 I-1.45 J-9.298 E.05399
; CHANGE_LAYER
; Z_HEIGHT: 5.4
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F15476.087
G1 X129.386 Y135.062 E-.61765
G1 X129.121 Y134.797 E-.14235
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 27/250
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
G3 Z5.6 I1.009 J-.68 P1  F30000
G1 X121.495 Y123.477 Z5.6
G1 Z5.4
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4412
G1 X121.509 Y123.462 E.00069
G3 X127.627 Y119.04 I6.491 J2.537 E.2646
G3 X134.268 Y122.95 I.397 J6.921 E.27106
G3 X121.277 Y124.166 I-6.267 J3.049 E.8925
G1 X121.477 Y123.534 E.02199
G1 X121.877 Y123.606 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4412
G3 X127.658 Y119.43 I6.129 J2.397 E.23157
G3 X133.674 Y122.657 I.329 J6.608 E.22039
G3 X121.855 Y123.662 I-5.667 J3.346 E.81667
M204 S10000
; WIPE_START
G1 F12000
G1 X122.157 Y122.964 E-.28895
G1 X122.512 Y122.36 E-.26637
G1 X122.834 Y121.927 E-.20468
; WIPE_END
G1 E-.04 F1800
G1 X130.075 Y124.34 Z5.8 F30000
G1 X137.478 Y126.807 Z5.8
G1 Z5.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4412
G3 X119.687 Y121.356 I-9.484 J-.804 E1.12625
G3 X128.679 Y116.51 I8.301 J4.636 E.35773
G3 X137.482 Y126.747 I-.686 J9.493 E.49788
G1 X137.87 Y126.84 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4412
G3 X125.628 Y135.618 I-9.871 J-.84 E.52589
G3 X128.713 Y116.119 I2.363 J-9.62 E.9051
G3 X137.875 Y126.78 I-.713 J9.881 E.48022
M204 S10000
; WIPE_START
G1 F12000
G1 X137.772 Y127.676 E-.34246
G1 X137.595 Y128.498 E-.3198
G1 X137.52 Y128.744 E-.09774
; WIPE_END
G1 E-.04 F1800
G1 X133.458 Y122.282 Z5.8 F30000
G1 X131.905 Y119.813 Z5.8
G1 Z5.4
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4412
G3 X133.174 Y120.826 I-3.937 J6.231 E.05397
G1 X134.482 Y119.518 E.06139
G3 X137.063 Y124.613 I-6.525 J6.505 E.19264
G1 X135.307 Y126.369 E.08237
G2 X135.307 Y125.631 I-3.451 J-.369 E.02452
G1 X137.063 Y127.387 E.08237
G3 X134.482 Y132.482 I-9.106 J-1.41 E.19264
G1 X133.174 Y131.174 E.06139
G3 X131.905 Y132.187 I-5.206 J-5.218 E.05397
G1 X130.964 Y134.674 F30000
G1 F4412
G3 X129.386 Y135.062 I-3.028 J-8.909 E.05399
G1 X127.634 Y133.31 E.08215
G2 X128.367 Y133.309 I.36 J-3.426 E.02434
G1 X126.614 Y135.062 E.08222
G3 X125.036 Y134.674 I1.45 J-9.297 E.05398
G1 X121.81 Y129.907 F30000
G1 F4412
G2 X122.822 Y131.178 I6.864 J-4.431 E.05397
G1 X121.518 Y132.482 E.06122
G3 X118.937 Y127.387 I6.525 J-6.505 E.19264
G1 X120.684 Y125.64 E.08193
M73 P35 R17
G1 X120.684 Y126.36 E.02386
G1 X118.937 Y124.613 E.08193
G3 X121.518 Y119.518 I9.106 J1.41 E.19264
G1 X122.822 Y120.822 E.06122
G2 X121.81 Y122.093 I5.852 J5.701 E.05397
G1 X125.036 Y117.326 F30000
G1 F4412
G3 X126.614 Y116.938 I3.028 J8.909 E.05398
G1 X128.367 Y118.691 E.08222
G2 X127.634 Y118.69 I-.372 J3.425 E.02434
G1 X129.386 Y116.938 E.08215
G3 X130.964 Y117.326 I-1.45 J9.298 E.05399
; CHANGE_LAYER
; Z_HEIGHT: 5.6
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F15476.087
G1 X129.386 Y116.938 E-.61765
G1 X129.121 Y117.203 E-.14235
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 28/250
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
G3 Z5.8 I-.773 J-.94 P1  F30000
G1 X121.495 Y123.477 Z5.8
G1 Z5.6
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4394
G1 X121.512 Y123.463 E.00073
G3 X127.617 Y119.04 I6.494 J2.539 E.2642
G3 X134.354 Y123.117 I.395 J6.954 E.27761
G3 X121.279 Y124.167 I-6.348 J2.886 E.88699
G1 X121.477 Y123.535 E.02199
G1 X121.877 Y123.606 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4394
G3 X127.648 Y119.431 I6.129 J2.397 E.23127
G3 X133.674 Y122.657 I.339 J6.606 E.22068
G3 X121.856 Y123.662 I-5.667 J3.346 E.81666
M204 S10000
; WIPE_START
G1 F12000
G1 X122.157 Y122.964 E-.28895
G1 X122.512 Y122.36 E-.26637
G1 X122.834 Y121.927 E-.20468
; WIPE_END
G1 E-.04 F1800
G1 X130.075 Y124.34 Z6 F30000
G1 X137.477 Y126.807 Z6
G1 Z5.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4394
G3 X119.687 Y121.356 I-9.484 J-.804 E1.12625
G3 X128.691 Y116.511 I8.301 J4.636 E.35811
G3 X137.482 Y126.747 I-.697 J9.492 E.49749
G1 X137.87 Y126.84 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4394
G3 X119.102 Y121.644 I-9.871 J-.84 E1.06898
G3 X128.724 Y116.12 I8.9 J4.359 E.36183
G3 X137.875 Y126.78 I-.724 J9.88 E.47988
M204 S10000
; WIPE_START
G1 F12000
G1 X137.772 Y127.676 E-.34247
G1 X137.595 Y128.498 E-.3198
G1 X137.52 Y128.744 E-.09773
; WIPE_END
G1 E-.04 F1800
G1 X131.905 Y132.187 Z6 F30000
G1 Z5.6
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4394
G2 X133.174 Y131.174 I-3.937 J-6.231 E.05397
G1 X134.482 Y132.482 E.06139
G2 X137.063 Y127.387 I-6.525 J-6.505 E.19264
G1 X135.307 Y125.631 E.08237
G3 X135.307 Y126.369 I-3.451 J.369 E.02452
G1 X137.063 Y124.613 E.08237
G2 X134.482 Y119.518 I-9.106 J1.41 E.19264
G1 X133.174 Y120.826 E.06139
G2 X131.905 Y119.813 I-5.206 J5.218 E.05397
G1 X130.964 Y117.326 F30000
G1 F4394
G2 X129.386 Y116.938 I-3.028 J8.91 E.05399
G1 X127.634 Y118.69 E.08215
G3 X128.367 Y118.691 I.36 J3.426 E.02434
G1 X126.614 Y116.938 E.08222
G2 X125.036 Y117.326 I1.45 J9.298 E.05399
G1 X121.81 Y122.093 F30000
G1 F4394
G3 X122.822 Y120.822 I6.864 J4.43 E.05397
G1 X121.518 Y119.518 E.06122
G2 X118.937 Y124.613 I6.525 J6.505 E.19264
G1 X120.684 Y126.36 E.08193
G1 X120.684 Y125.64 E.02386
G1 X118.937 Y127.387 E.08193
G2 X121.518 Y132.482 I9.106 J-1.41 E.19264
G1 X122.822 Y131.178 E.06122
G3 X121.81 Y129.907 I5.852 J-5.701 E.05397
G1 X125.036 Y134.674 F30000
G1 F4394
G2 X126.614 Y135.062 I3.028 J-8.91 E.05399
G1 X128.367 Y133.309 E.08222
G3 X127.634 Y133.31 I-.372 J-3.425 E.02434
G1 X129.386 Y135.062 E.08215
G2 X130.964 Y134.674 I-1.45 J-9.298 E.05398
; CHANGE_LAYER
; Z_HEIGHT: 5.8
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F15476.087
G1 X129.386 Y135.062 E-.61765
G1 X129.121 Y134.797 E-.14235
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 29/250
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
G3 Z6 I1.009 J-.68 P1  F30000
G1 X121.495 Y123.477 Z6
G1 Z5.8
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4412
G1 X121.512 Y123.463 E.00072
G3 X127.608 Y119.041 I6.494 J2.54 E.26389
G3 X134.625 Y123.808 I.382 J6.985 E.30234
G3 X121.279 Y124.167 I-6.619 J2.195 E.8624
G1 X121.477 Y123.534 E.02199
G1 X121.878 Y123.606 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4412
G3 X127.639 Y119.432 I6.129 J2.396 E.23096
G3 X133.674 Y122.657 I.35 J6.605 E.22097
G3 X121.856 Y123.662 I-5.667 J3.345 E.81659
M204 S10000
; WIPE_START
G1 F12000
G1 X122.157 Y122.964 E-.28894
G1 X122.512 Y122.36 E-.26637
G1 X122.834 Y121.927 E-.20469
; WIPE_END
G1 E-.04 F1800
G1 X130.075 Y124.34 Z6.2 F30000
G1 X137.477 Y126.807 Z6.2
G1 Z5.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4412
G3 X119.687 Y121.356 I-9.484 J-.804 E1.12625
G3 X128.702 Y116.512 I8.301 J4.636 E.35848
G3 X137.482 Y126.747 I-.709 J9.492 E.49711
G1 X137.868 Y126.84 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4412
G3 X118.965 Y121.916 I-9.875 J-.837 E1.06037
G3 X128.735 Y116.121 I9.041 J4.109 E.37157
G3 X137.873 Y126.78 I-.742 J9.882 E.47941
M204 S10000
; WIPE_START
G1 F12000
G1 X137.772 Y127.676 E-.34244
G1 X137.595 Y128.498 E-.3198
G1 X137.52 Y128.744 E-.09776
; WIPE_END
G1 E-.04 F1800
G1 X133.458 Y122.283 Z6.2 F30000
G1 X131.905 Y119.813 Z6.2
G1 Z5.8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4412
G3 X133.174 Y120.826 I-3.937 J6.231 E.05397
G1 X134.482 Y119.518 E.06139
G3 X137.063 Y124.613 I-6.525 J6.505 E.19264
G1 X135.307 Y126.369 E.08237
G2 X135.307 Y125.631 I-3.451 J-.369 E.02452
G1 X137.063 Y127.387 E.08237
G3 X134.482 Y132.482 I-9.106 J-1.41 E.19264
G1 X133.174 Y131.174 E.06139
G3 X131.905 Y132.187 I-5.206 J-5.218 E.05397
G1 X130.964 Y134.674 F30000
G1 F4412
G3 X129.386 Y135.062 I-3.028 J-8.909 E.05399
G1 X127.634 Y133.31 E.08215
G2 X128.367 Y133.309 I.36 J-3.426 E.02434
G1 X126.614 Y135.062 E.08222
G3 X125.036 Y134.674 I1.45 J-9.298 E.05398
G1 X121.81 Y129.907 F30000
G1 F4412
G2 X122.822 Y131.178 I6.864 J-4.43 E.05397
G1 X121.518 Y132.482 E.06122
G3 X118.937 Y127.387 I7.008 J-6.75 E.1923
G1 X120.684 Y125.64 E.08193
G1 X120.684 Y126.36 E.02386
G1 X118.937 Y124.613 E.08193
G3 X121.518 Y119.518 I9.106 J1.41 E.19264
G1 X122.822 Y120.822 E.06122
G2 X121.81 Y122.093 I5.852 J5.701 E.05397
G1 X125.036 Y117.326 F30000
G1 F4412
G3 X126.614 Y116.938 I3.028 J8.909 E.05398
G1 X128.367 Y118.691 E.08222
G2 X127.634 Y118.69 I-.372 J3.425 E.02434
G1 X129.386 Y116.938 E.08215
G3 X130.964 Y117.326 I-1.45 J9.298 E.05399
; CHANGE_LAYER
; Z_HEIGHT: 6
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F15476.087
G1 X129.386 Y116.938 E-.61766
G1 X129.121 Y117.203 E-.14235
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 30/250
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
G3 Z6.2 I-.773 J-.94 P1  F30000
G1 X121.495 Y123.477 Z6.2
G1 Z6
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4395
G1 X121.512 Y123.463 E.00073
G3 X127.598 Y119.042 I6.494 J2.54 E.26357
G3 X134.625 Y123.808 I.392 J6.984 E.30266
G3 X121.279 Y124.167 I-6.619 J2.195 E.86239
G1 X121.477 Y123.535 E.02199
M73 P35 R16
G1 X121.877 Y123.606 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4395
G3 X127.629 Y119.433 I6.129 J2.397 E.23067
G3 X133.997 Y123.279 I.382 J6.561 E.24296
G3 X121.856 Y123.662 I-5.991 J2.724 E.7951
M204 S10000
; WIPE_START
G1 F12000
G1 X122.157 Y122.964 E-.28895
G1 X122.512 Y122.36 E-.26637
G1 X122.834 Y121.927 E-.20468
; WIPE_END
G1 E-.04 F1800
G1 X130.075 Y124.34 Z6.4 F30000
G1 X137.477 Y126.807 Z6.4
G1 Z6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4395
G3 X119.687 Y121.356 I-9.484 J-.803 E1.12629
G1 X120.111 Y120.668 E.02681
G1 X120.295 Y120.418 E.01029
G3 X128.713 Y116.513 I7.706 J5.585 E.32156
G3 X137.482 Y126.747 I-.72 J9.491 E.49673
G1 X137.869 Y126.84 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4395
G3 X118.965 Y121.916 I-9.875 J-.836 E1.06041
G3 X128.747 Y116.122 I9.022 J4.078 E.37209
G3 X137.873 Y126.78 I-.753 J9.882 E.47906
M204 S10000
; WIPE_START
G1 F12000
G1 X137.772 Y127.676 E-.34245
G1 X137.595 Y128.498 E-.3198
G1 X137.52 Y128.744 E-.09775
; WIPE_END
G1 E-.04 F1800
G1 X131.905 Y132.187 Z6.4 F30000
G1 Z6
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4395
G2 X133.174 Y131.174 I-3.937 J-6.231 E.05397
G1 X134.482 Y132.482 E.06139
G2 X137.063 Y127.387 I-6.525 J-6.505 E.19264
G1 X135.307 Y125.631 E.08237
G3 X135.307 Y126.369 I-3.451 J.369 E.02452
G1 X137.063 Y124.613 E.08237
G2 X134.482 Y119.518 I-9.106 J1.41 E.19264
G1 X133.174 Y120.826 E.06139
G2 X131.905 Y119.813 I-5.206 J5.218 E.05397
G1 X130.964 Y117.326 F30000
G1 F4395
G2 X129.386 Y116.938 I-3.028 J8.909 E.05398
G1 X127.634 Y118.69 E.08215
G3 X128.367 Y118.691 I.36 J3.426 E.02434
G1 X126.614 Y116.938 E.08222
G2 X125.036 Y117.326 I1.45 J9.298 E.05399
G1 X121.81 Y122.093 F30000
G1 F4395
G3 X122.822 Y120.822 I6.864 J4.43 E.05397
G1 X121.518 Y119.518 E.06122
G2 X118.937 Y124.613 I6.525 J6.505 E.19264
G1 X120.684 Y126.36 E.08193
G1 X120.684 Y125.64 E.02386
G1 X118.937 Y127.387 E.08193
G2 X121.518 Y132.482 I9.106 J-1.41 E.19264
G1 X122.822 Y131.178 E.06122
G3 X121.81 Y129.907 I5.852 J-5.701 E.05397
G1 X125.036 Y134.674 F30000
G1 F4395
G2 X126.614 Y135.062 I3.028 J-8.91 E.05399
G1 X128.367 Y133.309 E.08222
G3 X127.634 Y133.31 I-.372 J-3.425 E.02434
G1 X129.386 Y135.062 E.08215
G2 X130.964 Y134.674 I-1.45 J-9.298 E.05399
; CHANGE_LAYER
; Z_HEIGHT: 6.2
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F15476.087
G1 X129.386 Y135.062 E-.61765
G1 X129.121 Y134.797 E-.14235
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 31/250
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
G3 Z6.4 I1.009 J-.68 P1  F30000
G1 X121.495 Y123.477 Z6.4
G1 Z6.2
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4413
G1 X121.512 Y123.463 E.00073
G3 X127.589 Y119.043 I6.494 J2.54 E.26325
G3 X134.625 Y123.808 I.402 J6.983 E.30297
G3 X121.279 Y124.167 I-6.619 J2.195 E.86238
G1 X121.477 Y123.535 E.02199
G1 X121.877 Y123.606 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4413
G3 X127.62 Y119.433 I6.129 J2.397 E.23038
G3 X133.997 Y123.279 I.392 J6.561 E.24325
G3 X121.856 Y123.662 I-5.991 J2.724 E.79515
M204 S10000
; WIPE_START
G1 F12000
G1 X122.157 Y122.964 E-.28895
G1 X122.512 Y122.36 E-.26637
G1 X122.834 Y121.927 E-.20468
; WIPE_END
G1 E-.04 F1800
G1 X130.075 Y124.34 Z6.6 F30000
G1 X137.477 Y126.807 Z6.6
G1 Z6.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4413
G3 X119.687 Y121.356 I-9.484 J-.803 E1.12629
G3 X128.725 Y116.513 I8.3 J4.636 E.35923
G3 X137.482 Y126.747 I-.732 J9.49 E.49635
M73 P36 R16
G1 X137.868 Y126.84 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4413
G3 X118.965 Y121.916 I-9.875 J-.836 E1.06041
G3 X128.758 Y116.123 I9.041 J4.109 E.37227
G3 X137.873 Y126.78 I-.764 J9.881 E.47871
M204 S10000
; WIPE_START
G1 F12000
G1 X137.772 Y127.676 E-.34244
G1 X137.595 Y128.498 E-.3198
G1 X137.52 Y128.744 E-.09776
; WIPE_END
G1 E-.04 F1800
G1 X133.458 Y122.283 Z6.6 F30000
G1 X131.905 Y119.813 Z6.6
G1 Z6.2
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4413
G3 X133.174 Y120.826 I-3.937 J6.231 E.05397
G1 X134.482 Y119.518 E.06139
G3 X137.063 Y124.613 I-6.525 J6.505 E.19264
G1 X135.307 Y126.369 E.08237
G2 X135.307 Y125.631 I-3.451 J-.369 E.02452
G1 X137.063 Y127.387 E.08237
G3 X134.482 Y132.482 I-9.106 J-1.41 E.19264
G1 X133.174 Y131.174 E.06139
G3 X131.905 Y132.187 I-5.206 J-5.218 E.05397
G1 X130.964 Y134.674 F30000
G1 F4413
G3 X129.386 Y135.062 I-3.028 J-8.909 E.05399
G1 X127.634 Y133.31 E.08215
G2 X128.367 Y133.309 I.36 J-3.426 E.02434
G1 X126.614 Y135.062 E.08222
G3 X125.036 Y134.674 I1.45 J-9.297 E.05398
G1 X121.81 Y129.907 F30000
G1 F4413
G2 X122.822 Y131.178 I6.864 J-4.43 E.05397
G1 X121.518 Y132.482 E.06122
G3 X118.937 Y127.387 I6.525 J-6.505 E.19264
G1 X120.684 Y125.64 E.08193
G1 X120.684 Y126.36 E.02386
G1 X118.937 Y124.613 E.08193
G3 X121.518 Y119.518 I9.106 J1.41 E.19264
G1 X122.822 Y120.822 E.06122
G2 X121.81 Y122.093 I5.852 J5.701 E.05397
G1 X125.036 Y117.326 F30000
G1 F4413
G3 X126.614 Y116.938 I3.028 J8.909 E.05399
G1 X128.367 Y118.691 E.08222
G2 X127.634 Y118.69 I-.372 J3.425 E.02434
G1 X129.386 Y116.938 E.08215
G3 X130.964 Y117.326 I-1.45 J9.298 E.05399
; CHANGE_LAYER
; Z_HEIGHT: 6.4
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F15476.087
G1 X129.386 Y116.938 E-.61765
G1 X129.121 Y117.203 E-.14235
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 32/250
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
G3 Z6.6 I-.773 J-.94 P1  F30000
G1 X121.495 Y123.477 Z6.6
G1 Z6.4
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4395
G1 X121.511 Y123.463 E.00072
G3 X127.579 Y119.043 I6.494 J2.541 E.26294
G3 X134.82 Y124.525 I.431 J6.954 E.32814
G3 X121.278 Y124.167 I-6.815 J1.479 E.83779
G1 X121.477 Y123.534 E.02199
G1 X121.878 Y123.606 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4395
G3 X127.611 Y119.434 I6.129 J2.397 E.23007
G3 X133.997 Y123.279 I.401 J6.56 E.24354
G3 X121.856 Y123.662 I-5.99 J2.724 E.79508
M204 S10000
; WIPE_START
G1 F12000
G1 X122.157 Y122.964 E-.28894
G1 X122.512 Y122.36 E-.26637
G1 X122.834 Y121.927 E-.20469
; WIPE_END
G1 E-.04 F1800
G1 X130.075 Y124.339 Z6.8 F30000
G1 X137.486 Y126.807 Z6.8
G1 Z6.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4395
G3 X119.473 Y121.78 I-9.484 J-.803 E1.11036
G3 X128.736 Y116.514 I8.528 J4.221 E.37515
G3 X137.491 Y126.748 I-.734 J9.49 E.49627
G1 X137.869 Y126.84 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4395
G3 X118.652 Y122.697 I-9.875 J-.836 E1.03454
G1 X118.965 Y121.916 E.02586
G1 X119.123 Y121.604 E.01075
G3 X128.769 Y116.124 I8.878 J4.398 E.36182
G3 X137.874 Y126.78 I-.775 J9.88 E.47837
M204 S10000
; WIPE_START
G1 F12000
G1 X137.772 Y127.676 E-.34245
G1 X137.595 Y128.498 E-.3198
G1 X137.52 Y128.744 E-.09775
; WIPE_END
G1 E-.04 F1800
G1 X131.905 Y132.187 Z6.8 F30000
G1 Z6.4
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4395
G2 X133.174 Y131.174 I-3.937 J-6.231 E.05397
G1 X134.482 Y132.482 E.06139
G2 X137.063 Y127.387 I-6.525 J-6.505 E.19264
G1 X135.307 Y125.631 E.08237
G3 X135.307 Y126.369 I-3.451 J.369 E.02452
G1 X137.063 Y124.613 E.08237
G2 X134.482 Y119.518 I-9.106 J1.41 E.19264
G1 X133.174 Y120.826 E.06139
G2 X131.905 Y119.813 I-5.206 J5.218 E.05397
G1 X130.964 Y117.326 F30000
G1 F4395
G2 X129.386 Y116.938 I-3.028 J8.91 E.05399
G1 X127.634 Y118.69 E.08215
G3 X128.367 Y118.691 I.36 J3.426 E.02434
G1 X126.614 Y116.938 E.08222
G2 X125.036 Y117.326 I1.45 J9.297 E.05398
G1 X121.81 Y122.093 F30000
G1 F4395
G3 X122.822 Y120.822 I6.864 J4.431 E.05397
G1 X121.518 Y119.518 E.06122
G2 X118.937 Y124.613 I6.525 J6.505 E.19264
G1 X120.684 Y126.36 E.08193
G1 X120.684 Y125.64 E.02386
G1 X118.937 Y127.387 E.08193
G2 X121.518 Y132.482 I9.106 J-1.41 E.19264
G1 X122.822 Y131.178 E.06122
G3 X121.81 Y129.907 I5.852 J-5.701 E.05397
G1 X125.036 Y134.674 F30000
G1 F4395
G2 X126.614 Y135.062 I3.028 J-8.909 E.05398
G1 X128.367 Y133.309 E.08222
G3 X127.634 Y133.31 I-.372 J-3.425 E.02434
G1 X129.386 Y135.062 E.08215
G2 X130.964 Y134.674 I-1.45 J-9.298 E.05399
; CHANGE_LAYER
; Z_HEIGHT: 6.6
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F15476.087
G1 X129.386 Y135.062 E-.61765
G1 X129.121 Y134.797 E-.14235
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 33/250
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
G3 Z6.8 I1.009 J-.68 P1  F30000
G1 X121.495 Y123.477 Z6.8
G1 Z6.6
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4413
G1 X121.512 Y123.463 E.00072
G3 X127.57 Y119.044 I6.494 J2.541 E.26262
G3 X134.82 Y124.525 I.441 J6.953 E.32845
G3 X121.279 Y124.167 I-6.815 J1.479 E.83778
G1 X121.477 Y123.535 E.02199
G1 X121.878 Y123.606 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4413
G3 X127.601 Y119.435 I6.129 J2.397 E.22977
G3 X133.997 Y123.279 I.411 J6.559 E.24383
G3 X121.856 Y123.662 I-5.99 J2.724 E.79507
M204 S10000
; WIPE_START
G1 F12000
G1 X122.157 Y122.964 E-.28894
G1 X122.512 Y122.36 E-.26637
G1 X122.834 Y121.927 E-.20469
; WIPE_END
G1 E-.04 F1800
G1 X130.075 Y124.34 Z7 F30000
G1 X137.478 Y126.807 Z7
G1 Z6.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4413
G3 X119.323 Y122.078 I-9.484 J-.803 E1.09946
G3 X128.747 Y116.515 I8.683 J3.946 E.38663
G3 X137.483 Y126.747 I-.754 J9.488 E.4956
G1 X137.879 Y126.841 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4413
G1 X137.762 Y127.674 E.02584
G3 X118.652 Y122.697 I-9.769 J-1.67 E1.00869
G3 X128.781 Y116.125 I9.337 J3.298 E.39899
G3 X137.873 Y126.79 I-.787 J9.879 E.47833
M204 S10000
; WIPE_START
G1 F12000
G1 X137.762 Y127.674 E-.33835
G1 X137.595 Y128.498 E-.31966
G1 X137.516 Y128.755 E-.10199
; WIPE_END
G1 E-.04 F1800
G1 X133.459 Y122.29 Z7 F30000
G1 X131.905 Y119.813 Z7
G1 Z6.6
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4413
G3 X133.174 Y120.826 I-3.937 J6.231 E.05397
G1 X134.482 Y119.518 E.06139
G3 X137.063 Y124.613 I-6.525 J6.505 E.19264
G1 X135.307 Y126.369 E.08237
G2 X135.307 Y125.631 I-3.451 J-.369 E.02452
G1 X137.063 Y127.387 E.08237
G3 X134.482 Y132.482 I-9.106 J-1.41 E.19264
G1 X133.174 Y131.174 E.06139
G3 X131.905 Y132.187 I-5.206 J-5.218 E.05397
G1 X130.964 Y134.674 F30000
G1 F4413
G3 X129.386 Y135.062 I-3.028 J-8.909 E.05399
G1 X127.634 Y133.31 E.08215
G2 X128.367 Y133.309 I.36 J-3.426 E.02434
G1 X126.614 Y135.062 E.08222
G3 X125.036 Y134.674 I1.45 J-9.298 E.05399
G1 X121.81 Y129.907 F30000
G1 F4413
G2 X122.822 Y131.178 I6.864 J-4.43 E.05397
G1 X121.518 Y132.482 E.06122
G3 X118.937 Y127.387 I6.525 J-6.505 E.19264
G1 X120.684 Y125.64 E.08193
G1 X120.684 Y126.36 E.02386
G1 X118.937 Y124.613 E.08193
G3 X121.518 Y119.518 I9.106 J1.41 E.19264
G1 X122.822 Y120.822 E.06122
G2 X121.81 Y122.093 I5.852 J5.701 E.05397
G1 X125.036 Y117.326 F30000
G1 F4413
G3 X126.614 Y116.938 I3.028 J8.909 E.05398
G1 X128.367 Y118.691 E.08222
G2 X127.634 Y118.69 I-.372 J3.425 E.02434
G1 X129.386 Y116.938 E.08215
G3 X130.964 Y117.326 I-1.45 J9.298 E.05399
; CHANGE_LAYER
; Z_HEIGHT: 6.8
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F15476.087
G1 X129.386 Y116.938 E-.61765
G1 X129.121 Y117.203 E-.14235
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 34/250
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
G3 Z7 I-.773 J-.94 P1  F30000
G1 X121.495 Y123.477 Z7
G1 Z6.8
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4394
G1 X121.512 Y123.463 E.00073
G3 X127.56 Y119.045 I6.494 J2.541 E.2623
G3 X134.82 Y124.525 I.45 J6.952 E.32876
G3 X121.279 Y124.167 I-6.815 J1.479 E.83777
G1 X121.477 Y123.535 E.02199
G1 X121.877 Y123.606 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4394
G3 X127.592 Y119.436 I6.129 J2.397 E.22949
G3 X134.252 Y123.932 I.401 J6.588 E.26547
G3 X121.856 Y123.662 I-6.246 J2.072 E.77358
M204 S10000
; WIPE_START
G1 F12000
G1 X122.157 Y122.964 E-.28895
G1 X122.512 Y122.36 E-.26637
G1 X122.834 Y121.927 E-.20468
; WIPE_END
G1 E-.04 F1800
G1 X130.075 Y124.339 Z7.2 F30000
G1 X137.486 Y126.807 Z7.2
G1 Z6.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4394
G3 X119.483 Y121.76 I-9.484 J-.803 E1.11111
G3 X128.759 Y116.516 I8.517 J4.241 E.37515
G3 X137.491 Y126.748 I-.756 J9.488 E.4955
G1 X137.879 Y126.841 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4394
G1 X137.763 Y127.674 E.02584
G3 X125.551 Y135.598 I-9.763 J-1.674 E.50248
G3 X128.792 Y116.126 I2.44 J-9.6 E.90508
G3 X137.874 Y126.789 I-.792 J9.874 E.47803
M204 S10000
; WIPE_START
G1 F12000
G1 X137.763 Y127.674 E-.33891
G1 X137.595 Y128.498 E-.31967
G1 X137.517 Y128.754 E-.10142
; WIPE_END
G1 E-.04 F1800
G1 X131.905 Y132.187 Z7.2 F30000
G1 Z6.8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4394
G2 X133.174 Y131.174 I-3.937 J-6.231 E.05397
G1 X134.482 Y132.482 E.06139
G2 X137.063 Y127.387 I-6.525 J-6.505 E.19264
G1 X135.307 Y125.631 E.08237
G3 X135.307 Y126.369 I-3.451 J.369 E.02452
G1 X137.063 Y124.613 E.08237
G2 X134.482 Y119.518 I-9.106 J1.41 E.19264
G1 X133.174 Y120.826 E.06139
M73 P37 R16
G2 X131.905 Y119.813 I-5.206 J5.218 E.05397
G1 X130.964 Y117.326 F30000
G1 F4394
G2 X129.386 Y116.938 I-3.028 J8.909 E.05399
G1 X127.634 Y118.69 E.08215
G3 X128.367 Y118.691 I.36 J3.426 E.02434
G1 X126.614 Y116.938 E.08222
G2 X125.036 Y117.326 I1.45 J9.297 E.05398
G1 X121.81 Y122.093 F30000
G1 F4394
G3 X122.822 Y120.822 I6.864 J4.43 E.05397
G1 X121.518 Y119.518 E.06122
G2 X118.937 Y124.613 I6.525 J6.505 E.19264
G1 X120.684 Y126.36 E.08193
G1 X120.684 Y125.64 E.02386
G1 X118.937 Y127.387 E.08193
G2 X121.518 Y132.482 I9.106 J-1.41 E.19264
G1 X122.822 Y131.178 E.06122
G3 X121.81 Y129.907 I5.852 J-5.701 E.05397
G1 X125.036 Y134.674 F30000
G1 F4394
G2 X126.614 Y135.062 I3.028 J-8.91 E.05399
G1 X128.367 Y133.309 E.08222
G3 X127.634 Y133.31 I-.372 J-3.425 E.02434
G1 X129.386 Y135.062 E.08215
G2 X130.964 Y134.674 I-1.45 J-9.298 E.05399
; CHANGE_LAYER
; Z_HEIGHT: 7
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F15476.087
G1 X129.386 Y135.062 E-.61765
G1 X129.121 Y134.797 E-.14235
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 35/250
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
G3 Z7.2 I1.009 J-.68 P1  F30000
G1 X121.495 Y123.477 Z7.2
G1 Z7
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4413
G1 X121.501 Y123.459 E.00064
G3 X127.074 Y119.084 I6.499 J2.541 E.2465
G1 X127.551 Y119.046 E.01588
G1 X127.814 Y119.025 E.00876
G3 X121.268 Y124.164 I.186 J6.975 E1.15854
G1 X121.476 Y123.534 E.02201
G1 X121.877 Y123.606 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4413
G3 X127.582 Y119.436 I6.128 J2.397 E.2292
G3 X134.252 Y123.932 I.41 J6.587 E.26576
G3 X121.856 Y123.662 I-6.246 J2.072 E.77358
M204 S10000
; WIPE_START
G1 F12000
G1 X122.157 Y122.964 E-.28895
G1 X122.512 Y122.36 E-.26637
G1 X122.834 Y121.927 E-.20469
; WIPE_END
G1 E-.04 F1800
G1 X130.075 Y124.34 Z7.4 F30000
G1 X137.48 Y126.807 Z7.4
G1 Z7
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4413
G3 X119.488 Y121.75 I-9.48 J-.807 E1.11082
G3 X128.77 Y116.517 I8.512 J4.251 E.37515
G3 X137.484 Y126.747 I-.77 J9.483 E.49496
G1 X137.879 Y126.841 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4413
G1 X137.762 Y127.674 E.02584
G3 X118.652 Y122.697 I-9.769 J-1.67 E1.00869
G1 X118.965 Y121.916 E.02586
G1 X119.138 Y121.573 E.0118
G3 X128.803 Y116.127 I8.862 J4.427 E.36182
G3 X137.873 Y126.791 I-.81 J9.877 E.47763
M204 S10000
; WIPE_START
G1 F12000
G1 X137.762 Y127.674 E-.33831
G1 X137.595 Y128.498 E-.31966
G1 X137.516 Y128.755 E-.10203
; WIPE_END
G1 E-.04 F1800
G1 X133.459 Y122.29 Z7.4 F30000
G1 X131.905 Y119.813 Z7.4
G1 Z7
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4413
G3 X133.174 Y120.826 I-3.937 J6.231 E.05397
G1 X134.482 Y119.518 E.06139
G3 X137.063 Y124.613 I-6.525 J6.505 E.19264
G1 X135.307 Y126.369 E.08237
G2 X135.307 Y125.631 I-3.451 J-.369 E.02452
G1 X137.063 Y127.387 E.08237
G3 X134.482 Y132.482 I-9.106 J-1.41 E.19264
G1 X133.174 Y131.174 E.06139
G3 X131.905 Y132.187 I-5.206 J-5.218 E.05397
G1 X130.964 Y134.674 F30000
G1 F4413
G3 X129.386 Y135.062 I-3.028 J-8.909 E.05399
G1 X127.634 Y133.31 E.08215
G2 X128.367 Y133.309 I.36 J-3.426 E.02434
G1 X126.614 Y135.062 E.08222
G3 X125.036 Y134.674 I1.45 J-9.297 E.05398
G1 X121.81 Y129.907 F30000
G1 F4413
G2 X122.822 Y131.178 I6.864 J-4.43 E.05397
G1 X121.518 Y132.482 E.06122
G3 X118.937 Y127.387 I6.525 J-6.505 E.19264
G1 X120.684 Y125.64 E.08193
G1 X120.684 Y126.36 E.02386
G1 X118.937 Y124.613 E.08193
G3 X121.518 Y119.518 I9.106 J1.41 E.19264
G1 X122.822 Y120.822 E.06122
G2 X121.81 Y122.093 I5.852 J5.701 E.05397
G1 X125.036 Y117.326 F30000
G1 F4413
G3 X126.614 Y116.938 I3.028 J8.909 E.05398
G1 X128.367 Y118.691 E.08222
G2 X127.634 Y118.69 I-.372 J3.425 E.02434
G1 X129.386 Y116.938 E.08215
G3 X130.964 Y117.326 I-1.45 J9.298 E.05399
; CHANGE_LAYER
; Z_HEIGHT: 7.2
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F15476.087
G1 X129.386 Y116.938 E-.61765
G1 X129.121 Y117.203 E-.14235
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 36/250
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
G3 Z7.4 I-.773 J-.94 P1  F30000
G1 X121.495 Y123.477 Z7.4
G1 Z7.2
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4394
G1 X121.501 Y123.459 E.00064
G3 X127.074 Y119.084 I6.499 J2.541 E.2465
G1 X127.542 Y119.046 E.01556
G1 X127.814 Y119.025 E.00907
G3 X121.268 Y124.164 I.186 J6.975 E1.15855
G1 X121.476 Y123.534 E.02201
G1 X121.878 Y123.606 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4394
G3 X127.573 Y119.437 I6.128 J2.397 E.2289
G3 X134.252 Y123.932 I.42 J6.586 E.26605
G3 X121.856 Y123.662 I-6.246 J2.072 E.77357
M204 S10000
; WIPE_START
G1 F12000
G1 X122.157 Y122.964 E-.28894
G1 X122.512 Y122.36 E-.26637
G1 X122.834 Y121.927 E-.20469
; WIPE_END
G1 E-.04 F1800
G1 X130.075 Y124.34 Z7.6 F30000
G1 X137.478 Y126.807 Z7.6
G1 Z7.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4394
G3 X119.323 Y122.078 I-9.484 J-.803 E1.09946
G3 X128.781 Y116.518 I8.682 J3.946 E.38776
G3 X137.482 Y126.747 I-.788 J9.485 E.49446
G1 X137.879 Y126.841 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4394
G1 X137.763 Y127.674 E.02584
G3 X118.799 Y122.33 I-9.763 J-1.674 E1.02007
G3 X128.815 Y116.128 I9.177 J3.631 E.3879
G3 X137.874 Y126.789 I-.815 J9.872 E.47733
M204 S10000
; WIPE_START
G1 F12000
G1 X137.763 Y127.674 E-.33891
G1 X137.595 Y128.498 E-.31967
G1 X137.517 Y128.754 E-.10142
; WIPE_END
G1 E-.04 F1800
G1 X131.905 Y132.187 Z7.6 F30000
G1 Z7.2
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4394
G2 X133.174 Y131.174 I-3.937 J-6.231 E.05397
G1 X134.482 Y132.482 E.06139
G2 X137.063 Y127.387 I-6.525 J-6.505 E.19264
G1 X135.307 Y125.631 E.08237
G3 X135.307 Y126.369 I-3.451 J.369 E.02452
G1 X137.063 Y124.613 E.08237
G2 X134.482 Y119.518 I-9.106 J1.41 E.19264
G1 X133.174 Y120.826 E.06139
G2 X131.905 Y119.813 I-5.206 J5.218 E.05397
G1 X130.964 Y117.326 F30000
G1 F4394
G2 X129.386 Y116.938 I-3.028 J8.91 E.05399
G1 X127.634 Y118.69 E.08215
G3 X128.367 Y118.691 I.36 J3.426 E.02434
G1 X126.614 Y116.938 E.08222
G2 X125.036 Y117.326 I1.45 J9.297 E.05398
G1 X121.81 Y122.093 F30000
G1 F4394
G3 X122.822 Y120.822 I6.864 J4.43 E.05397
G1 X121.518 Y119.518 E.06122
G2 X118.937 Y124.613 I6.525 J6.505 E.19264
G1 X120.684 Y126.36 E.08193
G1 X120.684 Y125.64 E.02386
G1 X118.937 Y127.387 E.08193
G2 X121.518 Y132.482 I9.106 J-1.41 E.19264
G1 X122.822 Y131.178 E.06122
G3 X121.81 Y129.907 I5.852 J-5.701 E.05397
G1 X125.036 Y134.674 F30000
G1 F4394
G2 X126.614 Y135.062 I3.028 J-8.91 E.05399
G1 X128.367 Y133.309 E.08222
G3 X127.634 Y133.31 I-.372 J-3.425 E.02434
G1 X129.386 Y135.062 E.08215
G2 X130.964 Y134.674 I-1.45 J-9.298 E.05399
; CHANGE_LAYER
; Z_HEIGHT: 7.4
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F15476.087
G1 X129.386 Y135.062 E-.61765
G1 X129.121 Y134.797 E-.14235
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 37/250
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
G3 Z7.6 I1.009 J-.68 P1  F30000
G1 X121.495 Y123.477 Z7.6
G1 Z7.4
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4413
G1 X121.506 Y123.461 E.00065
G3 X127.074 Y119.084 I6.496 J2.534 E.24643
G1 X127.532 Y119.047 E.01525
G3 X133.127 Y121.267 I.459 J7.004 E.20636
G1 X133.601 Y121.839 E.02464
G3 X121.273 Y124.165 I-5.599 J4.157 E.93584
G1 X121.477 Y123.534 E.022
G1 X121.878 Y123.606 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4413
G3 X127.563 Y119.438 I6.128 J2.397 E.2286
G3 X134.252 Y123.932 I.448 J6.558 E.26652
G3 X121.856 Y123.662 I-6.246 J2.072 E.77357
M204 S10000
; WIPE_START
G1 F12000
G1 X122.157 Y122.964 E-.28894
G1 X122.512 Y122.36 E-.26637
G1 X122.834 Y121.927 E-.20469
; WIPE_END
G1 E-.04 F1800
G1 X130.075 Y124.34 Z7.8 F30000
G1 X137.478 Y126.807 Z7.8
G1 Z7.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4413
G3 X119.323 Y122.078 I-9.484 J-.803 E1.09946
G3 X128.793 Y116.519 I8.682 J3.946 E.38814
G3 X137.482 Y126.747 I-.799 J9.484 E.49408
G1 X137.879 Y126.841 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4413
G1 X137.762 Y127.674 E.02583
G3 X118.652 Y122.697 I-9.768 J-1.67 E1.00869
G3 X128.826 Y116.129 I9.337 J3.298 E.40039
G3 X137.873 Y126.791 I-.832 J9.875 E.47693
M204 S10000
; WIPE_START
G1 F12000
G1 X137.762 Y127.674 E-.33828
G1 X137.595 Y128.498 E-.31966
G1 X137.516 Y128.755 E-.10206
; WIPE_END
G1 E-.04 F1800
G1 X133.459 Y122.29 Z7.8 F30000
G1 X131.905 Y119.813 Z7.8
G1 Z7.4
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4413
G3 X133.174 Y120.826 I-3.937 J6.231 E.05397
G1 X134.482 Y119.518 E.06139
G3 X137.063 Y124.613 I-6.525 J6.505 E.19264
G1 X135.307 Y126.369 E.08237
G2 X135.307 Y125.631 I-3.451 J-.369 E.02452
G1 X137.063 Y127.387 E.08237
G3 X134.482 Y132.482 I-9.106 J-1.41 E.19264
G1 X133.174 Y131.174 E.06139
G3 X131.905 Y132.187 I-5.206 J-5.218 E.05397
G1 X130.964 Y134.674 F30000
G1 F4413
G3 X129.386 Y135.062 I-3.028 J-8.91 E.05398
G1 X127.634 Y133.31 E.08215
G2 X128.367 Y133.309 I.36 J-3.426 E.02434
G1 X126.614 Y135.062 E.08222
G3 X125.036 Y134.674 I1.45 J-9.298 E.05399
G1 X121.81 Y129.907 F30000
G1 F4413
G2 X122.822 Y131.178 I6.864 J-4.43 E.05397
G1 X121.518 Y132.482 E.06122
G3 X118.937 Y127.387 I6.525 J-6.505 E.19264
G1 X120.684 Y125.64 E.08193
G1 X120.684 Y126.36 E.02386
G1 X118.937 Y124.613 E.08193
G3 X121.518 Y119.518 I9.106 J1.41 E.19264
G1 X122.822 Y120.822 E.06122
G2 X121.81 Y122.093 I5.852 J5.701 E.05397
G1 X125.036 Y117.326 F30000
G1 F4413
G3 X126.614 Y116.938 I3.028 J8.909 E.05399
G1 X128.367 Y118.691 E.08222
G2 X127.634 Y118.69 I-.372 J3.425 E.02434
G1 X129.386 Y116.938 E.08215
G3 X130.964 Y117.326 I-1.45 J9.298 E.05399
; CHANGE_LAYER
; Z_HEIGHT: 7.6
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F15476.087
G1 X129.386 Y116.938 E-.61765
G1 X129.121 Y117.203 E-.14235
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 38/250
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
G3 Z7.8 I-.773 J-.94 P1  F30000
G1 X121.495 Y123.477 Z7.8
G1 Z7.6
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4395
G1 X121.501 Y123.459 E.00064
G3 X127.074 Y119.084 I6.499 J2.541 E.2465
M73 P38 R16
G1 X127.523 Y119.048 E.01494
G1 X127.814 Y119.025 E.0097
G3 X121.268 Y124.164 I.186 J6.975 E1.15854
G1 X121.476 Y123.534 E.02201
G1 X121.878 Y123.606 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4395
G3 X127.554 Y119.439 I6.128 J2.397 E.22831
G3 X134.252 Y123.932 I.44 J6.584 E.26663
G3 X121.856 Y123.662 I-6.246 J2.072 E.77356
M204 S10000
; WIPE_START
G1 F12000
G1 X122.157 Y122.964 E-.28894
G1 X122.512 Y122.36 E-.26637
G1 X122.834 Y121.927 E-.20469
; WIPE_END
G1 E-.04 F1800
G1 X130.075 Y124.34 Z8 F30000
G1 X137.478 Y126.807 Z8
G1 Z7.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4395
G3 X119.323 Y122.078 I-9.484 J-.803 E1.09946
G3 X128.804 Y116.52 I8.682 J3.946 E.38852
G3 X137.482 Y126.747 I-.811 J9.483 E.4937
G1 X137.879 Y126.841 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4395
G1 X137.772 Y127.676 E.02584
G3 X125.507 Y135.587 I-9.764 J-1.674 E.50417
G3 X128.837 Y116.13 I2.493 J-9.587 E.90455
G3 X137.884 Y126.782 I-.829 J9.872 E.47664
M204 S10000
; WIPE_START
G1 F12000
G1 X137.772 Y127.676 E-.34235
G1 X137.595 Y128.498 E-.3198
G1 X137.519 Y128.745 E-.09785
; WIPE_END
G1 E-.04 F1800
G1 X131.905 Y132.187 Z8 F30000
G1 Z7.6
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4395
G2 X133.174 Y131.174 I-3.937 J-6.231 E.05397
G1 X134.482 Y132.482 E.06139
G2 X137.063 Y127.387 I-6.525 J-6.505 E.19264
G1 X135.307 Y125.631 E.08237
G3 X135.307 Y126.369 I-3.451 J.369 E.02452
G1 X137.063 Y124.613 E.08237
G2 X134.482 Y119.518 I-9.106 J1.41 E.19264
G1 X133.174 Y120.826 E.06139
G2 X131.905 Y119.813 I-5.206 J5.218 E.05397
G1 X130.964 Y117.326 F30000
G1 F4395
G2 X129.386 Y116.938 I-3.028 J8.91 E.05399
G1 X127.634 Y118.69 E.08215
G3 X128.367 Y118.691 I.36 J3.426 E.02434
G1 X126.614 Y116.938 E.08222
G2 X125.036 Y117.326 I1.45 J9.297 E.05398
G1 X121.81 Y122.093 F30000
G1 F4395
G3 X122.822 Y120.822 I6.864 J4.43 E.05397
G1 X121.518 Y119.518 E.06122
G2 X118.937 Y124.613 I6.525 J6.505 E.19264
G1 X120.684 Y126.36 E.08193
G1 X120.684 Y125.64 E.02386
G1 X118.937 Y127.387 E.08193
G2 X121.518 Y132.482 I9.106 J-1.41 E.19264
G1 X122.822 Y131.178 E.06122
G3 X121.81 Y129.907 I5.852 J-5.701 E.05397
G1 X125.036 Y134.674 F30000
G1 F4395
G2 X126.614 Y135.062 I3.028 J-8.91 E.05398
G1 X128.367 Y133.309 E.08222
G3 X127.634 Y133.31 I-.372 J-3.425 E.02434
G1 X129.386 Y135.062 E.08215
G2 X130.964 Y134.674 I-1.45 J-9.298 E.05399
; CHANGE_LAYER
; Z_HEIGHT: 7.8
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F15476.087
G1 X129.386 Y135.062 E-.61765
G1 X129.121 Y134.797 E-.14235
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 39/250
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
G3 Z8 I1.009 J-.68 P1  F30000
G1 X121.495 Y123.477 Z8
G1 Z7.8
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4412
G1 X121.506 Y123.461 E.00065
G3 X127.074 Y119.084 I6.496 J2.534 E.24643
G1 X127.513 Y119.049 E.01462
G3 X133.127 Y121.267 I.479 J7.001 E.20699
G1 X133.601 Y121.839 E.02464
G3 X121.273 Y124.165 I-5.599 J4.157 E.93584
G1 X121.477 Y123.534 E.022
G1 X121.877 Y123.606 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4412
G3 X127.545 Y119.439 I6.128 J2.398 E.22803
G3 X134.436 Y124.608 I.449 J6.581 E.28843
G3 X121.856 Y123.662 I-6.431 J1.396 E.75207
M204 S10000
; WIPE_START
G1 F12000
G1 X122.157 Y122.964 E-.28895
G1 X122.512 Y122.36 E-.26637
G1 X122.834 Y121.927 E-.20468
; WIPE_END
G1 E-.04 F1800
G1 X130.075 Y124.34 Z8.2 F30000
G1 X137.478 Y126.807 Z8.2
G1 Z7.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4412
G3 X119.323 Y122.078 I-9.484 J-.803 E1.09946
G3 X128.815 Y116.521 I8.682 J3.946 E.3889
G3 X137.482 Y126.747 I-.822 J9.482 E.49332
G1 X137.879 Y126.841 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4412
G1 X137.763 Y127.674 E.02583
G3 X118.812 Y122.298 I-9.763 J-1.674 E1.02112
G3 X128.849 Y116.131 I9.164 J3.662 E.3879
G3 X137.874 Y126.789 I-.849 J9.869 E.47628
M204 S10000
; WIPE_START
G1 F12000
G1 X137.763 Y127.674 E-.3389
G1 X137.595 Y128.498 E-.31967
G1 X137.517 Y128.754 E-.10142
; WIPE_END
G1 E-.04 F1800
G1 X133.459 Y122.289 Z8.2 F30000
G1 X131.905 Y119.813 Z8.2
G1 Z7.8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4412
G3 X133.174 Y120.826 I-3.937 J6.231 E.05397
G1 X134.482 Y119.518 E.06139
G3 X137.063 Y124.613 I-6.525 J6.505 E.19264
G1 X135.307 Y126.369 E.08237
G2 X135.307 Y125.631 I-3.451 J-.369 E.02452
G1 X137.063 Y127.387 E.08237
G3 X134.482 Y132.482 I-9.106 J-1.41 E.19264
G1 X133.174 Y131.174 E.06139
G3 X131.905 Y132.187 I-5.206 J-5.218 E.05397
G1 X130.964 Y134.674 F30000
G1 F4412
G3 X129.386 Y135.062 I-3.028 J-8.909 E.05399
G1 X127.634 Y133.31 E.08215
G2 X128.367 Y133.309 I.36 J-3.426 E.02434
G1 X126.614 Y135.062 E.08222
G3 X125.036 Y134.674 I1.45 J-9.298 E.05399
G1 X121.81 Y129.907 F30000
G1 F4412
G2 X122.822 Y131.178 I6.864 J-4.43 E.05397
G1 X121.518 Y132.482 E.06122
G3 X118.937 Y127.387 I6.525 J-6.505 E.19264
G1 X120.684 Y125.64 E.08193
G1 X120.684 Y126.36 E.02386
G1 X118.937 Y124.613 E.08193
G3 X121.518 Y119.518 I9.106 J1.41 E.19264
G1 X122.822 Y120.822 E.06122
G2 X121.81 Y122.093 I5.852 J5.701 E.05397
G1 X125.036 Y117.326 F30000
G1 F4412
G3 X126.614 Y116.938 I3.028 J8.909 E.05398
G1 X128.367 Y118.691 E.08222
G2 X127.634 Y118.69 I-.372 J3.425 E.02434
G1 X129.386 Y116.938 E.08215
G3 X130.964 Y117.326 I-1.45 J9.298 E.05399
; CHANGE_LAYER
; Z_HEIGHT: 8
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F15476.087
G1 X129.386 Y116.938 E-.61766
G1 X129.121 Y117.203 E-.14235
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 40/250
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
G3 Z8.2 I-.773 J-.94 P1  F30000
G1 X121.495 Y123.477 Z8.2
G1 Z8
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4394
G1 X121.501 Y123.459 E.00064
G3 X127.074 Y119.084 I6.499 J2.541 E.2465
G1 X127.504 Y119.049 E.01431
G3 X133.127 Y121.267 I.489 J7 E.2073
G1 X133.601 Y121.839 E.02464
G3 X121.268 Y124.164 I-5.601 J4.161 E.93671
G1 X121.476 Y123.534 E.02201
G1 X121.877 Y123.606 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4394
G3 X127.535 Y119.44 I6.128 J2.398 E.22773
G3 X134.436 Y124.608 I.458 J6.58 E.28872
G3 X121.856 Y123.662 I-6.431 J1.396 E.75207
M204 S10000
; WIPE_START
G1 F12000
G1 X122.157 Y122.964 E-.28894
G1 X122.512 Y122.36 E-.26637
G1 X122.834 Y121.927 E-.20469
; WIPE_END
G1 E-.04 F1800
G1 X130.075 Y124.34 Z8.4 F30000
G1 X137.478 Y126.807 Z8.4
G1 Z8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4394
G3 X119.323 Y122.078 I-9.484 J-.803 E1.09946
G3 X128.827 Y116.522 I8.682 J3.946 E.38927
G3 X137.482 Y126.747 I-.833 J9.481 E.49295
G1 X137.879 Y126.841 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4394
G1 X137.767 Y127.675 E.02583
G3 X128.421 Y116.094 I-9.767 J-1.679 E1.39608
G1 X128.86 Y116.132 E.01355
G1 X129.259 Y116.165 E.01231
G3 X137.879 Y126.785 I-1.259 J9.83 E.46383
M204 S10000
; WIPE_START
G1 F12000
G1 X137.767 Y127.675 E-.34073
G1 X137.595 Y128.498 E-.31973
G1 X137.518 Y128.749 E-.09954
; WIPE_END
G1 E-.04 F1800
G1 X131.905 Y132.187 Z8.4 F30000
G1 Z8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4394
G2 X133.174 Y131.174 I-3.937 J-6.231 E.05397
G1 X134.482 Y132.482 E.06139
G2 X137.063 Y127.387 I-6.525 J-6.505 E.19264
G1 X135.307 Y125.631 E.08237
G3 X135.307 Y126.369 I-3.451 J.369 E.02452
G1 X137.063 Y124.613 E.08237
G2 X134.482 Y119.518 I-9.106 J1.41 E.19264
G1 X133.174 Y120.826 E.06139
G2 X131.905 Y119.813 I-5.206 J5.218 E.05397
G1 X130.964 Y117.326 F30000
G1 F4394
G2 X129.386 Y116.938 I-3.028 J8.909 E.05399
G1 X127.634 Y118.69 E.08215
G3 X128.367 Y118.691 I.36 J3.426 E.02434
G1 X126.614 Y116.938 E.08222
G2 X125.036 Y117.326 I1.45 J9.297 E.05398
G1 X121.81 Y122.093 F30000
G1 F4394
G3 X122.822 Y120.822 I6.864 J4.431 E.05397
G1 X121.518 Y119.518 E.06122
G2 X118.937 Y124.613 I6.525 J6.505 E.19264
G1 X120.684 Y126.36 E.08193
G1 X120.684 Y125.64 E.02386
G1 X118.937 Y127.387 E.08193
G2 X121.518 Y132.482 I9.106 J-1.41 E.19264
G1 X122.822 Y131.178 E.06122
G3 X121.81 Y129.907 I5.852 J-5.701 E.05397
G1 X125.036 Y134.674 F30000
G1 F4394
G2 X126.614 Y135.062 I3.028 J-8.909 E.05399
G1 X128.367 Y133.309 E.08222
G3 X127.634 Y133.31 I-.372 J-3.425 E.02434
G1 X129.386 Y135.062 E.08215
G2 X130.964 Y134.674 I-1.45 J-9.298 E.05399
; CHANGE_LAYER
; Z_HEIGHT: 8.2
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F15476.087
G1 X129.386 Y135.062 E-.61765
G1 X129.121 Y134.797 E-.14235
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 41/250
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
G3 Z8.4 I1.009 J-.68 P1  F30000
G1 X121.495 Y123.477 Z8.4
G1 Z8.2
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4412
G1 X121.501 Y123.459 E.00064
G3 X127.074 Y119.084 I6.499 J2.541 E.2465
G1 X127.494 Y119.05 E.01399
G3 X133.127 Y121.267 I.498 J6.999 E.20761
G1 X133.601 Y121.839 E.02464
G3 X121.268 Y124.164 I-5.601 J4.161 E.93671
G1 X121.476 Y123.534 E.02201
G1 X121.877 Y123.606 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4412
G3 X127.526 Y119.441 I6.128 J2.398 E.22744
G3 X134.436 Y124.608 I.468 J6.579 E.28901
G3 X121.856 Y123.662 I-6.431 J1.396 E.75206
M204 S10000
; WIPE_START
G1 F12000
G1 X122.157 Y122.964 E-.28895
G1 X122.512 Y122.36 E-.26637
G1 X122.834 Y121.927 E-.20468
; WIPE_END
G1 E-.04 F1800
G1 X130.075 Y124.34 Z8.6 F30000
G1 X137.48 Y126.807 Z8.6
G1 Z8.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4412
G3 X119.519 Y121.689 I-9.48 J-.807 E1.11308
G3 X128.838 Y116.523 I8.481 J4.312 E.37515
G3 X137.484 Y126.747 I-.838 J9.477 E.4927
G1 X137.879 Y126.841 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4412
G1 X137.765 Y127.674 E.02583
G3 X118.965 Y121.916 I-9.768 J-1.679 E1.03408
G1 X119.344 Y121.165 E.02586
G3 X128.871 Y116.132 I8.642 J4.827 E.35008
G1 X129.259 Y116.165 E.01196
G3 X137.877 Y126.787 I-1.262 J9.83 E.46383
M204 S10000
; WIPE_START
G1 F12000
G1 X137.765 Y127.674 E-.33979
G1 X137.595 Y128.498 E-.3197
G1 X137.517 Y128.751 E-.10051
; WIPE_END
G1 E-.04 F1800
G1 X133.459 Y122.287 Z8.6 F30000
G1 X131.905 Y119.813 Z8.6
M73 P39 R16
G1 Z8.2
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4412
G3 X133.174 Y120.826 I-3.937 J6.231 E.05397
G1 X134.482 Y119.518 E.06139
G3 X137.063 Y124.613 I-6.525 J6.505 E.19264
G1 X135.307 Y126.369 E.08237
G2 X135.307 Y125.631 I-3.451 J-.369 E.02452
G1 X137.063 Y127.387 E.08237
G3 X134.482 Y132.482 I-9.106 J-1.41 E.19264
G1 X133.174 Y131.174 E.06139
G3 X131.905 Y132.187 I-5.206 J-5.218 E.05397
G1 X130.964 Y134.674 F30000
G1 F4412
G3 X129.386 Y135.062 I-3.028 J-8.909 E.05399
G1 X127.634 Y133.31 E.08215
G2 X128.367 Y133.309 I.36 J-3.426 E.02434
G1 X126.614 Y135.062 E.08222
G3 X125.036 Y134.674 I1.45 J-9.298 E.05399
G1 X121.81 Y129.907 F30000
G1 F4412
G2 X122.822 Y131.178 I6.864 J-4.43 E.05397
G1 X121.518 Y132.482 E.06122
G3 X118.937 Y127.387 I6.525 J-6.505 E.19264
G1 X120.684 Y125.64 E.08193
G1 X120.684 Y126.36 E.02386
G1 X118.937 Y124.613 E.08193
G3 X121.518 Y119.518 I9.106 J1.41 E.19264
G1 X122.822 Y120.822 E.06122
G2 X121.81 Y122.093 I5.852 J5.701 E.05397
G1 X125.036 Y117.326 F30000
G1 F4412
G3 X126.614 Y116.938 I3.028 J8.909 E.05398
G1 X128.367 Y118.691 E.08222
G2 X127.634 Y118.69 I-.372 J3.425 E.02434
G1 X129.386 Y116.938 E.08215
G3 X130.964 Y117.326 I-1.45 J9.298 E.05399
; CHANGE_LAYER
; Z_HEIGHT: 8.4
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F15476.087
G1 X129.386 Y116.938 E-.61765
G1 X129.121 Y117.203 E-.14235
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 42/250
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
G3 Z8.6 I-.773 J-.94 P1  F30000
G1 X121.495 Y123.477 Z8.6
G1 Z8.4
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4395
G1 X121.501 Y123.459 E.00064
G3 X127.074 Y119.084 I6.499 J2.541 E.2465
G1 X127.485 Y119.051 E.01368
G1 X127.814 Y119.025 E.01096
G3 X121.268 Y124.164 I.186 J6.975 E1.15855
G1 X121.476 Y123.534 E.02201
G1 X121.877 Y123.606 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4395
G3 X127.516 Y119.442 I6.128 J2.398 E.22715
G3 X134.436 Y124.608 I.495 J6.555 E.28951
G3 X121.856 Y123.662 I-6.431 J1.396 E.75206
M204 S10000
; WIPE_START
G1 F12000
G1 X122.157 Y122.964 E-.28895
G1 X122.512 Y122.36 E-.26637
G1 X122.834 Y121.927 E-.20468
; WIPE_END
G1 E-.04 F1800
G1 X130.075 Y124.34 Z8.8 F30000
G1 X137.478 Y126.807 Z8.8
G1 Z8.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4395
G3 X119.323 Y122.078 I-9.484 J-.803 E1.09946
G3 X128.85 Y116.524 I8.682 J3.946 E.39003
G3 X137.483 Y126.747 I-.856 J9.479 E.4922
G1 X137.879 Y126.841 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4395
G1 X137.764 Y127.674 E.02583
G3 X130.089 Y135.692 I-9.774 J-1.674 E.36196
G3 X128.883 Y116.133 I-2.088 J-9.688 E1.04848
G1 X129.259 Y116.165 E.01161
G3 X137.874 Y126.789 I-1.27 J9.835 E.46376
M204 S10000
; WIPE_START
G1 F12000
G1 X137.764 Y127.674 E-.33894
G1 X137.595 Y128.498 E-.31968
G1 X137.517 Y128.753 E-.10138
; WIPE_END
G1 E-.04 F1800
G1 X131.905 Y132.187 Z8.8 F30000
G1 Z8.4
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4395
G2 X133.174 Y131.174 I-3.937 J-6.231 E.05397
G1 X134.482 Y132.482 E.06139
G2 X137.063 Y127.387 I-6.525 J-6.505 E.19264
G1 X135.307 Y125.631 E.08237
G3 X135.307 Y126.369 I-3.451 J.369 E.02452
G1 X137.063 Y124.613 E.08237
G2 X134.482 Y119.518 I-9.106 J1.41 E.19264
G1 X133.174 Y120.826 E.06139
G2 X131.905 Y119.813 I-5.206 J5.218 E.05397
G1 X130.964 Y117.326 F30000
G1 F4395
G2 X129.386 Y116.938 I-3.028 J8.91 E.05399
G1 X127.634 Y118.69 E.08215
G3 X128.367 Y118.691 I.36 J3.426 E.02434
G1 X126.614 Y116.938 E.08222
G2 X125.036 Y117.326 I1.45 J9.297 E.05398
G1 X121.81 Y122.093 F30000
G1 F4395
G3 X122.822 Y120.822 I6.864 J4.43 E.05397
G1 X121.518 Y119.518 E.06122
G2 X118.937 Y124.613 I6.525 J6.505 E.19264
G1 X120.684 Y126.36 E.08193
G1 X120.684 Y125.64 E.02386
G1 X118.937 Y127.387 E.08193
G2 X121.518 Y132.482 I9.106 J-1.41 E.19264
G1 X122.822 Y131.178 E.06122
G3 X121.81 Y129.907 I5.852 J-5.701 E.05397
G1 X125.036 Y134.674 F30000
G1 F4395
G2 X126.614 Y135.062 I3.028 J-8.91 E.05399
G1 X128.367 Y133.309 E.08222
M73 P39 R15
G3 X127.634 Y133.31 I-.372 J-3.425 E.02434
G1 X129.386 Y135.062 E.08215
G2 X130.964 Y134.674 I-1.45 J-9.298 E.05399
; CHANGE_LAYER
; Z_HEIGHT: 8.6
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F15476.087
G1 X129.386 Y135.062 E-.61765
G1 X129.121 Y134.797 E-.14235
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 43/250
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
G3 Z8.8 I1.009 J-.68 P1  F30000
G1 X121.495 Y123.477 Z8.8
G1 Z8.6
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4412
G1 X121.506 Y123.461 E.00065
G3 X127.074 Y119.084 I6.496 J2.534 E.24643
G1 X127.476 Y119.052 E.01337
G3 X133.127 Y121.267 I.518 J6.996 E.20824
G1 X133.601 Y121.839 E.02464
G3 X121.273 Y124.165 I-5.599 J4.157 E.93584
G1 X121.477 Y123.534 E.022
G1 X121.871 Y123.604 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4412
G3 X127.126 Y119.473 I6.131 J2.392 E.21542
G1 X127.507 Y119.442 E.01174
G3 X132.839 Y121.533 I.487 J6.603 E.18199
G1 X133.286 Y122.073 E.02154
G3 X121.849 Y123.659 I-5.284 J3.923 E.83778
M204 S10000
; WIPE_START
G1 F12000
G1 X122.157 Y122.964 E-.28904
G1 X122.512 Y122.36 E-.26637
G1 X122.833 Y121.927 E-.20459
; WIPE_END
G1 E-.04 F1800
G1 X130.075 Y124.34 Z9 F30000
G1 X137.478 Y126.807 Z9
G1 Z8.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4412
G3 X119.323 Y122.078 I-9.484 J-.803 E1.09946
G3 X128.861 Y116.525 I8.682 J3.946 E.39041
G3 X137.483 Y126.747 I-.867 J9.478 E.49183
G1 X137.879 Y126.841 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4412
G1 X137.763 Y127.674 E.02583
G3 X130.089 Y135.692 I-9.774 J-1.674 E.36195
G3 X128.894 Y116.134 I-2.085 J-9.688 E1.04854
G1 X129.259 Y116.165 E.01126
G3 X137.874 Y126.79 I-1.271 J9.835 E.46376
M204 S10000
; WIPE_START
G1 F12000
G1 X137.763 Y127.674 E-.33875
G1 X137.595 Y128.498 E-.31967
G1 X137.517 Y128.754 E-.10158
; WIPE_END
G1 E-.04 F1800
G1 X133.459 Y122.289 Z9 F30000
G1 X131.905 Y119.813 Z9
G1 Z8.6
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4412
G3 X133.174 Y120.826 I-3.937 J6.231 E.05397
G1 X134.482 Y119.518 E.06139
G3 X137.063 Y124.613 I-6.525 J6.505 E.19264
G1 X135.307 Y126.369 E.08237
G2 X135.307 Y125.631 I-3.451 J-.369 E.02452
G1 X137.063 Y127.387 E.08237
G3 X134.482 Y132.482 I-9.106 J-1.41 E.19264
G1 X133.174 Y131.174 E.06139
G3 X131.905 Y132.187 I-5.206 J-5.218 E.05397
G1 X130.964 Y134.674 F30000
G1 F4412
G3 X129.386 Y135.062 I-3.028 J-8.909 E.05399
G1 X127.634 Y133.31 E.08215
G2 X128.367 Y133.309 I.36 J-3.426 E.02434
G1 X126.614 Y135.062 E.08222
G3 X125.036 Y134.674 I1.45 J-9.298 E.05399
G1 X121.81 Y129.907 F30000
G1 F4412
G2 X122.822 Y131.178 I6.864 J-4.43 E.05397
G1 X121.518 Y132.482 E.06122
G3 X118.937 Y127.387 I6.525 J-6.505 E.19264
G1 X120.684 Y125.64 E.08193
G1 X120.684 Y126.36 E.02386
G1 X118.937 Y124.613 E.08193
G3 X121.518 Y119.518 I9.106 J1.41 E.19264
G1 X122.822 Y120.822 E.06122
G2 X121.81 Y122.093 I5.852 J5.701 E.05397
G1 X125.036 Y117.326 F30000
G1 F4412
G3 X126.614 Y116.938 I3.028 J8.909 E.05398
G1 X128.367 Y118.691 E.08222
G2 X127.634 Y118.69 I-.372 J3.425 E.02434
G1 X129.386 Y116.938 E.08215
G3 X130.964 Y117.326 I-1.45 J9.298 E.05399
; CHANGE_LAYER
; Z_HEIGHT: 8.8
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F15476.087
G1 X129.386 Y116.938 E-.61766
G1 X129.121 Y117.203 E-.14235
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 44/250
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
G3 Z9 I-.773 J-.94 P1  F30000
G1 X121.495 Y123.477 Z9
G1 Z8.8
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4394
G1 X121.506 Y123.461 E.00065
G3 X127.074 Y119.084 I6.496 J2.534 E.24643
G1 X127.466 Y119.052 E.01305
G3 X133.127 Y121.267 I.527 J6.995 E.20855
G1 X133.601 Y121.839 E.02464
G3 X121.273 Y124.165 I-5.599 J4.157 E.93584
G1 X121.477 Y123.534 E.022
G1 X121.871 Y123.604 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4394
G3 X127.126 Y119.473 I6.131 J2.392 E.21542
G1 X127.497 Y119.443 E.01145
G3 X132.839 Y121.533 I.496 J6.602 E.18228
G1 X133.286 Y122.073 E.02154
G3 X121.849 Y123.659 I-5.284 J3.923 E.83778
M204 S10000
; WIPE_START
G1 F12000
G1 X122.157 Y122.964 E-.28903
G1 X122.512 Y122.36 E-.26637
G1 X122.833 Y121.927 E-.2046
; WIPE_END
G1 E-.04 F1800
G1 X130.075 Y124.34 Z9.2 F30000
G1 X137.479 Y126.807 Z9.2
G1 Z8.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4394
G3 X130.006 Y135.309 I-9.49 J-.806 E.40207
G3 X128.872 Y116.526 I-2.002 J-9.305 E1.08761
G1 X129.21 Y116.555 E.01123
G3 X137.484 Y126.747 I-1.221 J9.446 E.48046
G1 X137.879 Y126.841 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4394
G1 X137.763 Y127.674 E.02583
G3 X130.089 Y135.692 I-9.775 J-1.674 E.36194
G3 X128.905 Y116.135 I-2.085 J-9.688 E1.04889
G1 X129.259 Y116.165 E.01091
G3 X137.874 Y126.79 I-1.271 J9.835 E.46376
M204 S10000
; WIPE_START
G1 F12000
G1 X137.763 Y127.674 E-.33862
G1 X137.595 Y128.498 E-.31967
G1 X137.517 Y128.754 E-.10171
; WIPE_END
G1 E-.04 F1800
G1 X131.905 Y132.187 Z9.2 F30000
G1 Z8.8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4394
G2 X133.174 Y131.174 I-3.937 J-6.231 E.05397
G1 X134.482 Y132.482 E.06139
G2 X137.063 Y127.387 I-6.525 J-6.505 E.19264
G1 X135.307 Y125.631 E.08237
G3 X135.307 Y126.369 I-3.451 J.369 E.02452
G1 X137.063 Y124.613 E.08237
G2 X134.482 Y119.518 I-9.106 J1.41 E.19264
G1 X133.174 Y120.826 E.06139
G2 X131.905 Y119.813 I-5.206 J5.218 E.05397
G1 X130.964 Y117.326 F30000
G1 F4394
G2 X129.386 Y116.938 I-3.028 J8.91 E.05399
G1 X127.634 Y118.69 E.08215
G3 X128.367 Y118.691 I.36 J3.426 E.02434
G1 X126.614 Y116.938 E.08222
G2 X125.036 Y117.326 I1.45 J9.298 E.05399
G1 X121.81 Y122.093 F30000
M73 P40 R15
G1 F4394
G3 X122.822 Y120.822 I6.864 J4.43 E.05397
G1 X121.518 Y119.518 E.06122
G2 X118.937 Y124.613 I6.525 J6.505 E.19264
G1 X120.684 Y126.36 E.08193
G1 X120.684 Y125.64 E.02386
G1 X118.937 Y127.387 E.08193
G2 X121.518 Y132.482 I9.106 J-1.41 E.19264
G1 X122.822 Y131.178 E.06122
G3 X121.81 Y129.907 I5.852 J-5.701 E.05397
G1 X125.036 Y134.674 F30000
G1 F4394
G2 X126.614 Y135.062 I3.028 J-8.91 E.05399
G1 X128.367 Y133.309 E.08222
G3 X127.634 Y133.31 I-.372 J-3.425 E.02434
G1 X129.386 Y135.062 E.08215
G2 X130.964 Y134.674 I-1.45 J-9.298 E.05398
; CHANGE_LAYER
; Z_HEIGHT: 9
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F15476.087
G1 X129.386 Y135.062 E-.61765
G1 X129.121 Y134.797 E-.14235
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 45/250
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
G3 Z9.2 I1.009 J-.68 P1  F30000
G1 X121.495 Y123.477 Z9.2
G1 Z9
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4415
G1 X121.501 Y123.459 E.00064
G3 X127.074 Y119.084 I6.499 J2.541 E.2465
G1 X127.457 Y119.053 E.01274
G1 X127.814 Y119.025 E.0119
G3 X121.268 Y124.164 I.186 J6.975 E1.15853
G1 X121.476 Y123.534 E.02201
G1 X121.867 Y123.602 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4415
G3 X127.126 Y119.473 I6.133 J2.398 E.21549
G1 X127.488 Y119.444 E.01116
G1 X127.825 Y119.417 E.01038
G3 X121.845 Y123.658 I.175 J6.583 E1.03249
M204 S10000
; WIPE_START
G1 F12000
G1 X122.157 Y122.964 E-.28911
G1 X122.512 Y122.36 E-.26637
G1 X122.833 Y121.928 E-.20453
; WIPE_END
G1 E-.04 F1800
G1 X130.075 Y124.339 Z9.4 F30000
G1 X137.484 Y126.807 Z9.4
G1 Z9
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4415
G3 X128.404 Y116.486 I-9.484 J-.811 E1.47432
G1 X128.884 Y116.527 E.01596
G1 X129.21 Y116.555 E.01085
G3 X137.489 Y126.747 I-1.209 J9.441 E.4807
G1 X137.879 Y126.841 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4415
G1 X137.768 Y127.675 E.02584
G3 X128.421 Y116.094 I-9.767 J-1.679 E1.39609
G1 X128.917 Y116.136 E.0153
G1 X129.259 Y116.165 E.01056
G3 X137.879 Y126.785 I-1.259 J9.83 E.46383
M204 S10000
; WIPE_START
G1 F12000
G1 X137.768 Y127.675 E-.34076
G1 X137.595 Y128.498 E-.31973
G1 X137.518 Y128.749 E-.09951
; WIPE_END
G1 E-.04 F1800
G1 X133.458 Y122.286 Z9.4 F30000
G1 X131.905 Y119.813 Z9.4
G1 Z9
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4415
G3 X133.174 Y120.826 I-3.937 J6.231 E.05397
G1 X134.482 Y119.518 E.06139
G3 X137.063 Y124.613 I-6.525 J6.505 E.19264
G1 X135.307 Y126.369 E.08237
G2 X135.307 Y125.631 I-3.451 J-.369 E.02452
G1 X137.063 Y127.387 E.08237
G3 X134.482 Y132.482 I-9.106 J-1.41 E.19264
G1 X133.174 Y131.174 E.06139
G3 X131.905 Y132.187 I-5.206 J-5.218 E.05397
G1 X130.964 Y134.674 F30000
G1 F4415
G3 X129.386 Y135.062 I-3.028 J-8.909 E.05399
G1 X127.634 Y133.31 E.08215
G2 X128.367 Y133.309 I.36 J-3.426 E.02434
G1 X126.614 Y135.062 E.08222
G3 X125.036 Y134.674 I1.45 J-9.297 E.05398
G1 X121.81 Y129.907 F30000
G1 F4415
G2 X122.822 Y131.178 I6.864 J-4.43 E.05397
G1 X121.518 Y132.482 E.06122
G3 X118.937 Y127.387 I6.525 J-6.505 E.19264
G1 X120.684 Y125.64 E.08193
G1 X120.684 Y126.36 E.02386
G1 X118.937 Y124.613 E.08193
G3 X121.518 Y119.518 I9.106 J1.41 E.19264
G1 X122.822 Y120.822 E.06122
G2 X121.81 Y122.093 I5.852 J5.701 E.05397
G1 X125.036 Y117.326 F30000
G1 F4415
G3 X126.614 Y116.938 I3.028 J8.909 E.05398
G1 X128.367 Y118.691 E.08222
G2 X127.634 Y118.69 I-.372 J3.425 E.02434
G1 X129.386 Y116.938 E.08215
G3 X130.964 Y117.326 I-1.45 J9.298 E.05399
; CHANGE_LAYER
; Z_HEIGHT: 9.2
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F15476.087
G1 X129.386 Y116.938 E-.61766
G1 X129.121 Y117.203 E-.14235
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 46/250
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
G3 Z9.4 I-.773 J-.94 P1  F30000
G1 X121.495 Y123.477 Z9.4
G1 Z9.2
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4394
G1 X121.506 Y123.461 E.00065
G3 X127.074 Y119.084 I6.497 J2.534 E.24642
G1 X127.447 Y119.054 E.01242
G3 X134.012 Y122.458 I.547 J6.978 E.25843
G1 X134.354 Y123.117 E.02464
G3 X121.273 Y124.166 I-6.352 J2.879 E.88657
G1 X121.477 Y123.534 E.022
G1 X121.871 Y123.604 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4394
G3 X127.126 Y119.473 I6.131 J2.392 E.21542
G1 X127.478 Y119.445 E.01087
G3 X133.674 Y122.657 I.516 J6.585 E.22591
G1 X133.997 Y123.279 E.02154
G3 X121.85 Y123.66 I-5.994 J2.717 E.79471
M204 S10000
; WIPE_START
G1 F12000
G1 X122.157 Y122.964 E-.28903
G1 X122.512 Y122.36 E-.26637
G1 X122.833 Y121.927 E-.2046
; WIPE_END
G1 E-.04 F1800
G1 X130.075 Y124.34 Z9.6 F30000
G1 X137.48 Y126.807 Z9.6
G1 Z9.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4394
G3 X130.006 Y135.309 I-9.49 J-.806 E.40208
G3 X128.895 Y116.528 I-2.006 J-9.305 E1.08867
G1 X129.21 Y116.555 E.01047
G3 X137.484 Y126.747 I-1.22 J9.446 E.48048
G1 X137.879 Y126.841 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4394
G1 X137.764 Y127.674 E.02584
G3 X130.089 Y135.692 I-9.774 J-1.674 E.36196
G3 X128.928 Y116.137 I-2.088 J-9.688 E1.04988
G1 X129.259 Y116.165 E.01021
G3 X137.874 Y126.789 I-1.27 J9.835 E.46376
M204 S10000
; WIPE_START
G1 F12000
G1 X137.764 Y127.674 E-.33894
G1 X137.595 Y128.498 E-.31968
G1 X137.517 Y128.753 E-.10138
; WIPE_END
G1 E-.04 F1800
G1 X131.905 Y132.187 Z9.6 F30000
G1 Z9.2
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4394
G2 X133.174 Y131.174 I-3.937 J-6.231 E.05397
G1 X134.482 Y132.482 E.06139
G2 X137.063 Y127.387 I-6.525 J-6.505 E.19264
G1 X135.307 Y125.631 E.08237
G3 X135.307 Y126.369 I-3.451 J.369 E.02452
G1 X137.063 Y124.613 E.08237
G2 X134.482 Y119.518 I-9.106 J1.41 E.19264
G1 X133.174 Y120.826 E.06139
G2 X131.905 Y119.813 I-5.206 J5.218 E.05397
G1 X130.964 Y117.326 F30000
G1 F4394
G2 X129.386 Y116.938 I-3.028 J8.91 E.05399
G1 X127.634 Y118.69 E.08215
G3 X128.367 Y118.691 I.36 J3.426 E.02434
G1 X126.614 Y116.938 E.08222
G2 X125.036 Y117.326 I1.45 J9.297 E.05398
G1 X121.81 Y122.093 F30000
G1 F4394
G3 X122.822 Y120.822 I6.864 J4.431 E.05397
G1 X121.518 Y119.518 E.06122
G2 X118.937 Y124.613 I6.525 J6.505 E.19264
G1 X120.684 Y126.36 E.08193
G1 X120.684 Y125.64 E.02386
G1 X118.937 Y127.387 E.08193
G2 X121.518 Y132.482 I9.106 J-1.41 E.19264
G1 X122.822 Y131.178 E.06122
G3 X121.81 Y129.907 I5.852 J-5.701 E.05397
G1 X125.036 Y134.674 F30000
G1 F4394
G2 X126.614 Y135.062 I3.028 J-8.909 E.05399
G1 X128.367 Y133.309 E.08222
G3 X127.634 Y133.31 I-.372 J-3.425 E.02434
G1 X129.386 Y135.062 E.08215
G2 X130.964 Y134.674 I-1.45 J-9.298 E.05399
; CHANGE_LAYER
; Z_HEIGHT: 9.4
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F15476.087
G1 X129.386 Y135.062 E-.61765
G1 X129.121 Y134.797 E-.14235
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 47/250
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
G3 Z9.6 I1.009 J-.68 P1  F30000
G1 X121.495 Y123.477 Z9.6
G1 Z9.4
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4413
G1 X121.504 Y123.46 E.00064
G3 X127.074 Y119.084 I6.495 J2.534 E.24646
G1 X127.438 Y119.055 E.01211
G1 X127.814 Y119.025 E.01253
G3 X121.272 Y124.165 I.185 J6.97 E1.15741
G1 X121.477 Y123.534 E.022
G1 X121.87 Y123.603 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4413
G3 X127.126 Y119.473 I6.13 J2.392 E.21545
G1 X127.469 Y119.446 E.01058
G1 X127.825 Y119.417 E.01096
G3 X121.848 Y123.659 I.175 J6.577 E1.03149
M204 S10000
; WIPE_START
G1 F12000
G1 X122.157 Y122.964 E-.28906
G1 X122.512 Y122.36 E-.26637
G1 X122.833 Y121.928 E-.20458
; WIPE_END
G1 E-.04 F1800
G1 X130.075 Y124.339 Z9.8 F30000
G1 X137.484 Y126.807 Z9.8
G1 Z9.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4413
G3 X128.404 Y116.486 I-9.483 J-.811 E1.4743
G1 X128.906 Y116.529 E.01672
G1 X129.21 Y116.555 E.0101
G3 X137.489 Y126.747 I-1.209 J9.441 E.48069
G1 X137.879 Y126.841 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4413
G1 X137.764 Y127.674 E.02584
G3 X130.089 Y135.692 I-9.774 J-1.674 E.36196
G3 X128.94 Y116.138 I-2.085 J-9.688 E1.04995
G1 X129.259 Y116.165 E.00986
G3 X137.874 Y126.789 I-1.27 J9.835 E.46376
M204 S10000
; WIPE_START
G1 F12000
G1 X137.764 Y127.674 E-.33894
G1 X137.595 Y128.498 E-.31968
G1 X137.517 Y128.753 E-.10138
; WIPE_END
G1 E-.04 F1800
G1 X133.459 Y122.289 Z9.8 F30000
G1 X131.905 Y119.813 Z9.8
G1 Z9.4
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4413
G3 X133.174 Y120.826 I-3.937 J6.231 E.05397
G1 X134.482 Y119.518 E.06139
G3 X137.063 Y124.613 I-6.525 J6.505 E.19264
G1 X135.307 Y126.369 E.08237
G2 X135.307 Y125.631 I-3.451 J-.369 E.02452
G1 X137.063 Y127.387 E.08237
G3 X134.482 Y132.482 I-9.106 J-1.41 E.19264
G1 X133.174 Y131.174 E.06139
G3 X131.905 Y132.187 I-5.206 J-5.218 E.05397
G1 X130.964 Y134.674 F30000
G1 F4413
G3 X129.386 Y135.062 I-3.028 J-8.909 E.05399
G1 X127.634 Y133.31 E.08215
G2 X128.367 Y133.309 I.36 J-3.426 E.02434
G1 X126.614 Y135.062 E.08222
G3 X125.036 Y134.674 I1.45 J-9.298 E.05399
G1 X121.81 Y129.907 F30000
G1 F4413
G2 X122.822 Y131.178 I6.864 J-4.431 E.05397
G1 X121.518 Y132.482 E.06122
G3 X118.937 Y127.387 I6.525 J-6.505 E.19264
G1 X120.684 Y125.64 E.08193
G1 X120.684 Y126.36 E.02386
G1 X118.937 Y124.613 E.08193
G3 X121.518 Y119.518 I9.106 J1.41 E.19264
G1 X122.822 Y120.822 E.06122
G2 X121.81 Y122.093 I5.852 J5.701 E.05397
G1 X125.036 Y117.326 F30000
G1 F4413
G3 X126.614 Y116.938 I3.028 J8.909 E.05398
G1 X128.367 Y118.691 E.08222
G2 X127.634 Y118.69 I-.372 J3.425 E.02434
G1 X129.386 Y116.938 E.08215
G3 X130.964 Y117.326 I-1.45 J9.298 E.05399
; CHANGE_LAYER
; Z_HEIGHT: 9.6
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F15476.087
G1 X129.386 Y116.938 E-.61766
G1 X129.121 Y117.203 E-.14235
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 48/250
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
G3 Z9.8 I-.773 J-.94 P1  F30000
G1 X121.495 Y123.477 Z9.8
G1 Z9.6
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4393
G1 X121.506 Y123.461 E.00065
G3 X127.074 Y119.084 I6.496 J2.534 E.24643
G1 X127.428 Y119.055 E.0118
G3 X133.127 Y121.267 I.565 J6.992 E.20981
G1 X133.601 Y121.839 E.02464
G3 X121.273 Y124.165 I-5.599 J4.157 E.93584
G1 X121.477 Y123.534 E.022
G1 X121.871 Y123.604 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4393
G3 X127.126 Y119.473 I6.131 J2.392 E.21542
G1 X127.46 Y119.446 E.01028
G3 X132.839 Y121.533 I.534 J6.599 E.18344
G1 X133.286 Y122.073 E.02154
G3 X121.849 Y123.659 I-5.284 J3.923 E.83778
M204 S10000
; WIPE_START
G1 F12000
G1 X122.157 Y122.964 E-.28904
G1 X122.512 Y122.36 E-.26637
G1 X122.833 Y121.927 E-.20459
; WIPE_END
G1 E-.04 F1800
G1 X130.075 Y124.339 Z10 F30000
M73 P41 R15
G1 X137.488 Y126.808 Z10
G1 Z9.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4393
G3 X128.404 Y116.486 I-9.488 J-.808 E1.47504
G1 X128.918 Y116.53 E.01709
G1 X129.21 Y116.555 E.00972
G3 X137.493 Y126.748 I-1.209 J9.445 E.48077
G1 X137.879 Y126.841 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4393
G1 X137.879 Y126.841 E.00001
G3 X128.421 Y116.094 I-9.879 J-.841 E1.42267
G1 X128.951 Y116.139 E.01635
G1 X129.259 Y116.165 E.00951
G3 X137.915 Y126 I-1.259 J9.834 E.43975
G1 X137.882 Y126.781 E.02401
M204 S10000
; WIPE_START
G1 F12000
G1 X137.879 Y126.841 E-.02285
G1 X137.772 Y127.676 E-.31981
G1 X137.595 Y128.498 E-.3198
G1 X137.52 Y128.744 E-.09755
; WIPE_END
G1 E-.04 F1800
G1 X131.905 Y132.187 Z10 F30000
G1 Z9.6
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4393
G2 X133.174 Y131.174 I-3.937 J-6.231 E.05397
G1 X134.482 Y132.482 E.06139
G2 X137.063 Y127.387 I-6.525 J-6.505 E.19264
G1 X135.307 Y125.631 E.08237
G3 X135.307 Y126.369 I-3.451 J.369 E.02452
G1 X137.063 Y124.613 E.08237
G2 X134.482 Y119.518 I-9.106 J1.41 E.19264
G1 X133.174 Y120.826 E.06139
G2 X131.905 Y119.813 I-5.206 J5.218 E.05397
G1 X130.964 Y117.326 F30000
G1 F4393
G2 X129.386 Y116.938 I-3.028 J8.91 E.05399
G1 X127.634 Y118.69 E.08215
G3 X128.367 Y118.691 I.36 J3.426 E.02434
G1 X126.614 Y116.938 E.08222
G2 X125.036 Y117.326 I1.45 J9.297 E.05398
G1 X121.81 Y122.093 F30000
G1 F4393
G3 X122.822 Y120.822 I6.864 J4.43 E.05397
G1 X121.518 Y119.518 E.06122
G2 X118.937 Y124.613 I6.525 J6.505 E.19264
G1 X120.684 Y126.36 E.08193
G1 X120.684 Y125.64 E.02386
G1 X118.937 Y127.387 E.08193
G2 X121.518 Y132.482 I9.106 J-1.41 E.19264
G1 X122.822 Y131.178 E.06122
G3 X121.81 Y129.907 I5.852 J-5.701 E.05397
G1 X125.036 Y134.674 F30000
G1 F4393
G2 X126.614 Y135.062 I3.028 J-8.909 E.05398
G1 X128.367 Y133.309 E.08222
G3 X127.634 Y133.31 I-.372 J-3.425 E.02434
G1 X129.386 Y135.062 E.08215
G2 X130.964 Y134.674 I-1.45 J-9.298 E.05399
; CHANGE_LAYER
; Z_HEIGHT: 9.8
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F15476.087
G1 X129.386 Y135.062 E-.61765
G1 X129.121 Y134.797 E-.14235
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 49/250
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
G3 Z10 I1.009 J-.68 P1  F30000
G1 X121.495 Y123.477 Z10
G1 Z9.8
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4414
G1 X121.501 Y123.459 E.00064
G3 X127.074 Y119.084 I6.499 J2.541 E.2465
G1 X127.419 Y119.056 E.01148
G1 X127.814 Y119.025 E.01316
G3 X121.268 Y124.164 I.186 J6.975 E1.15853
G1 X121.476 Y123.534 E.02201
G1 X121.867 Y123.602 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4414
G3 X127.126 Y119.473 I6.133 J2.398 E.21549
G1 X127.45 Y119.447 E.00999
G1 X127.825 Y119.417 E.01155
G3 X121.845 Y123.658 I.175 J6.583 E1.03249
M204 S10000
; WIPE_START
G1 F12000
G1 X122.157 Y122.964 E-.28911
G1 X122.512 Y122.36 E-.26637
G1 X122.833 Y121.928 E-.20452
; WIPE_END
G1 E-.04 F1800
G1 X130.075 Y124.34 Z10.2 F30000
G1 X137.48 Y126.807 Z10.2
G1 Z9.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4414
G3 X130.006 Y135.309 I-9.49 J-.806 E.40209
G3 X128.929 Y116.531 I-2.006 J-9.305 E1.08981
G1 X129.21 Y116.555 E.00934
G3 X137.485 Y126.747 I-1.22 J9.446 E.48049
G1 X137.87 Y126.84 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4414
G3 X130.089 Y135.692 I-9.881 J-.84 E.38781
G3 X128.962 Y116.14 I-2.088 J-9.688 E1.05094
G1 X129.259 Y116.165 E.00916
G3 X137.875 Y126.78 I-1.27 J9.835 E.4635
M204 S10000
; WIPE_START
G1 F12000
G1 X137.772 Y127.676 E-.34247
G1 X137.595 Y128.498 E-.3198
G1 X137.52 Y128.744 E-.09773
; WIPE_END
G1 E-.04 F1800
G1 X133.458 Y122.282 Z10.2 F30000
G1 X131.905 Y119.813 Z10.2
G1 Z9.8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4414
G3 X133.174 Y120.826 I-3.937 J6.231 E.05397
G1 X134.482 Y119.518 E.06139
G3 X137.063 Y124.613 I-6.525 J6.505 E.19264
G1 X135.307 Y126.369 E.08237
G2 X135.307 Y125.631 I-3.451 J-.369 E.02452
G1 X137.063 Y127.387 E.08237
G3 X134.482 Y132.482 I-9.106 J-1.41 E.19264
G1 X133.174 Y131.174 E.06139
G3 X131.905 Y132.187 I-5.206 J-5.218 E.05397
G1 X130.964 Y134.674 F30000
G1 F4414
G3 X129.386 Y135.062 I-3.028 J-8.909 E.05399
G1 X127.634 Y133.31 E.08215
G2 X128.367 Y133.309 I.36 J-3.426 E.02434
G1 X126.614 Y135.062 E.08222
G3 X125.036 Y134.674 I1.45 J-9.298 E.05398
G1 X121.81 Y129.907 F30000
G1 F4414
G2 X122.822 Y131.178 I6.864 J-4.43 E.05397
G1 X121.518 Y132.482 E.06122
G3 X118.937 Y127.387 I6.525 J-6.505 E.19264
G1 X120.684 Y125.64 E.08193
G1 X120.684 Y126.36 E.02386
G1 X118.937 Y124.613 E.08193
G3 X121.518 Y119.518 I9.106 J1.41 E.19264
G1 X122.822 Y120.822 E.06122
G2 X121.81 Y122.093 I5.852 J5.701 E.05397
G1 X125.036 Y117.326 F30000
G1 F4414
G3 X126.614 Y116.938 I3.028 J8.909 E.05398
G1 X128.367 Y118.691 E.08222
G2 X127.634 Y118.69 I-.372 J3.425 E.02434
G1 X129.386 Y116.938 E.08215
G3 X130.964 Y117.326 I-1.45 J9.298 E.05399
; CHANGE_LAYER
; Z_HEIGHT: 10
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F15476.087
G1 X129.386 Y116.938 E-.61766
G1 X129.121 Y117.203 E-.14235
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 50/250
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
G3 Z10.2 I-.773 J-.94 P1  F30000
G1 X121.495 Y123.477 Z10.2
G1 Z10
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4396
G1 X121.501 Y123.459 E.00064
G3 X127.074 Y119.084 I6.499 J2.541 E.2465
G1 X127.409 Y119.057 E.01117
G1 X127.814 Y119.025 E.01347
G3 X121.268 Y124.164 I.186 J6.975 E1.15853
G1 X121.476 Y123.534 E.02201
G1 X121.867 Y123.602 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4396
G3 X127.126 Y119.473 I6.133 J2.398 E.21549
G1 X127.441 Y119.448 E.0097
G1 X127.825 Y119.417 E.01184
G3 X121.845 Y123.658 I.175 J6.583 E1.0325
M204 S10000
; WIPE_START
G1 F12000
G1 X122.157 Y122.964 E-.28911
G1 X122.512 Y122.36 E-.26637
G1 X122.833 Y121.928 E-.20452
; WIPE_END
G1 E-.04 F1800
G1 X130.075 Y124.34 Z10.4 F30000
G1 X137.48 Y126.807 Z10.4
G1 Z10
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4396
G3 X130.006 Y135.309 I-9.49 J-.806 E.40209
G3 X128.94 Y116.532 I-2.002 J-9.305 E1.08989
G1 X129.21 Y116.555 E.00896
G3 X137.485 Y126.747 I-1.22 J9.446 E.48049
G1 X137.87 Y126.84 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4396
G3 X130.089 Y135.692 I-9.881 J-.84 E.3878
G3 X128.974 Y116.141 I-2.088 J-9.688 E1.0513
G1 X129.259 Y116.165 E.00881
G3 X137.875 Y126.78 I-1.27 J9.835 E.46349
M204 S10000
; WIPE_START
G1 F12000
G1 X137.772 Y127.676 E-.34246
G1 X137.595 Y128.498 E-.3198
G1 X137.52 Y128.744 E-.09773
; WIPE_END
G1 E-.04 F1800
G1 X131.905 Y132.187 Z10.4 F30000
G1 Z10
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4396
G2 X133.174 Y131.174 I-3.937 J-6.231 E.05397
G1 X134.482 Y132.482 E.06139
G2 X137.063 Y127.387 I-6.525 J-6.505 E.19264
G1 X135.307 Y125.631 E.08237
G3 X135.307 Y126.369 I-3.451 J.369 E.02452
G1 X137.063 Y124.613 E.08237
G2 X134.482 Y119.518 I-9.106 J1.41 E.19264
G1 X133.174 Y120.826 E.06139
G2 X131.905 Y119.813 I-5.206 J5.218 E.05397
G1 X130.964 Y117.326 F30000
G1 F4396
G2 X129.386 Y116.938 I-3.028 J8.91 E.05399
G1 X127.634 Y118.69 E.08215
G3 X128.367 Y118.691 I.36 J3.426 E.02434
G1 X126.614 Y116.938 E.08222
G2 X125.036 Y117.326 I1.45 J9.297 E.05398
G1 X121.81 Y122.093 F30000
G1 F4396
G3 X122.822 Y120.822 I6.864 J4.43 E.05397
G1 X121.518 Y119.518 E.06122
G2 X118.937 Y124.613 I6.525 J6.505 E.19264
G1 X120.684 Y126.36 E.08193
G1 X120.684 Y125.64 E.02386
G1 X118.937 Y127.387 E.08193
G2 X121.518 Y132.482 I9.106 J-1.41 E.19264
G1 X122.822 Y131.178 E.06122
G3 X121.81 Y129.907 I5.852 J-5.701 E.05397
G1 X125.036 Y134.674 F30000
G1 F4396
G2 X126.614 Y135.062 I3.028 J-8.91 E.05399
G1 X128.367 Y133.309 E.08222
G3 X127.634 Y133.31 I-.372 J-3.425 E.02434
G1 X129.386 Y135.062 E.08215
G2 X130.964 Y134.674 I-1.45 J-9.298 E.05399
; CHANGE_LAYER
; Z_HEIGHT: 10.2
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F15476.087
G1 X129.386 Y135.062 E-.61765
G1 X129.121 Y134.797 E-.14235
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 51/250
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
G3 Z10.4 I1.009 J-.68 P1  F30000
G1 X121.495 Y123.477 Z10.4
G1 Z10.2
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4414
G1 X121.501 Y123.459 E.00064
G3 X127.074 Y119.084 I6.499 J2.541 E.2465
G1 X127.4 Y119.058 E.01085
G1 X127.814 Y119.025 E.01379
G3 X121.268 Y124.164 I.186 J6.975 E1.15855
G1 X121.476 Y123.534 E.02201
G1 X121.867 Y123.602 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4414
G3 X127.126 Y119.473 I6.133 J2.398 E.21549
G1 X127.431 Y119.449 E.00941
G1 X127.825 Y119.417 E.01213
G3 X121.845 Y123.658 I.175 J6.583 E1.0325
M204 S10000
; WIPE_START
G1 F12000
G1 X122.157 Y122.964 E-.28911
G1 X122.512 Y122.36 E-.26637
G1 X122.833 Y121.928 E-.20452
; WIPE_END
G1 E-.04 F1800
G1 X130.075 Y124.34 Z10.6 F30000
G1 X137.48 Y126.807 Z10.6
G1 Z10.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4414
G3 X130.006 Y135.309 I-9.49 J-.806 E.4021
G3 X128.952 Y116.533 I-2.002 J-9.305 E1.09027
G1 X129.21 Y116.555 E.00858
G3 X137.485 Y126.747 I-1.219 J9.446 E.4805
G1 X137.871 Y126.84 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4414
G3 X130.089 Y135.692 I-9.881 J-.84 E.38781
G3 X128.985 Y116.142 I-2.084 J-9.689 E1.05136
G1 X129.259 Y116.165 E.00846
G3 X137.876 Y126.78 I-1.269 J9.835 E.46351
M204 S10000
; WIPE_START
G1 F12000
G1 X137.772 Y127.676 E-.34247
G1 X137.595 Y128.498 E-.3198
G1 X137.52 Y128.744 E-.09773
; WIPE_END
G1 E-.04 F1800
G1 X133.458 Y122.282 Z10.6 F30000
G1 X131.905 Y119.813 Z10.6
G1 Z10.2
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4414
G3 X133.174 Y120.826 I-3.937 J6.231 E.05397
G1 X134.482 Y119.518 E.06139
G3 X137.063 Y124.613 I-6.525 J6.505 E.19264
G1 X135.307 Y126.369 E.08237
G2 X135.307 Y125.631 I-3.451 J-.369 E.02452
M73 P42 R15
G1 X137.063 Y127.387 E.08237
G3 X134.482 Y132.482 I-9.106 J-1.41 E.19264
G1 X133.174 Y131.174 E.06139
G3 X131.905 Y132.187 I-5.206 J-5.218 E.05397
G1 X130.964 Y134.674 F30000
G1 F4414
G3 X129.386 Y135.062 I-3.028 J-8.909 E.05399
G1 X127.634 Y133.31 E.08215
G2 X128.367 Y133.309 I.36 J-3.426 E.02434
G1 X126.614 Y135.062 E.08222
G3 X125.036 Y134.674 I1.45 J-9.298 E.05399
G1 X121.81 Y129.907 F30000
G1 F4414
G2 X122.822 Y131.178 I6.864 J-4.43 E.05397
G1 X121.518 Y132.482 E.06122
G3 X118.937 Y127.387 I6.525 J-6.505 E.19264
G1 X120.684 Y125.64 E.08193
G1 X120.684 Y126.36 E.02386
G1 X118.937 Y124.613 E.08193
G3 X121.518 Y119.518 I9.106 J1.41 E.19264
G1 X122.822 Y120.822 E.06122
G2 X121.81 Y122.093 I5.852 J5.701 E.05397
G1 X125.036 Y117.326 F30000
G1 F4414
G3 X126.614 Y116.938 I3.028 J8.909 E.05398
G1 X128.367 Y118.691 E.08222
G2 X127.634 Y118.69 I-.372 J3.425 E.02434
G1 X129.386 Y116.938 E.08215
G3 X130.964 Y117.326 I-1.45 J9.298 E.05399
; CHANGE_LAYER
; Z_HEIGHT: 10.4
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F15476.087
G1 X129.386 Y116.938 E-.61765
G1 X129.121 Y117.203 E-.14235
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 52/250
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
G3 Z10.6 I-.773 J-.94 P1  F30000
G1 X121.495 Y123.477 Z10.6
G1 Z10.4
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4394
G1 X121.506 Y123.461 E.00065
G3 X127.074 Y119.084 I6.496 J2.534 E.24643
G1 X127.391 Y119.058 E.01054
G3 X133.127 Y121.267 I.603 J6.99 E.21107
G1 X133.601 Y121.839 E.02464
G3 X121.273 Y124.165 I-5.599 J4.156 E.93583
G1 X121.477 Y123.534 E.022
G1 X121.871 Y123.604 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4394
G3 X127.126 Y119.473 I6.131 J2.392 E.21542
G1 X127.422 Y119.449 E.00912
G3 X132.839 Y121.533 I.572 J6.596 E.1846
G1 X133.286 Y122.073 E.02154
G3 X121.85 Y123.659 I-5.284 J3.923 E.83778
M204 S10000
; WIPE_START
G1 F12000
G1 X122.157 Y122.964 E-.28903
G1 X122.512 Y122.36 E-.26637
G1 X122.833 Y121.927 E-.2046
; WIPE_END
G1 E-.04 F1800
G1 X130.075 Y124.34 Z10.8 F30000
G1 X137.48 Y126.807 Z10.8
G1 Z10.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4394
G3 X130.006 Y135.309 I-9.49 J-.806 E.4021
G3 X128.963 Y116.534 I-2.006 J-9.305 E1.09097
G1 X129.21 Y116.555 E.00821
G3 X137.485 Y126.747 I-1.219 J9.446 E.4805
G1 X137.871 Y126.84 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4394
G3 X130.089 Y135.692 I-9.881 J-.84 E.38781
G3 X128.996 Y116.143 I-2.088 J-9.688 E1.05201
G1 X129.259 Y116.165 E.00811
G3 X137.876 Y126.78 I-1.27 J9.835 E.4635
M204 S10000
; WIPE_START
G1 F12000
G1 X137.772 Y127.676 E-.34247
G1 X137.595 Y128.498 E-.3198
G1 X137.52 Y128.744 E-.09773
; WIPE_END
G1 E-.04 F1800
G1 X131.905 Y132.187 Z10.8 F30000
G1 Z10.4
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4394
G2 X133.174 Y131.174 I-3.937 J-6.231 E.05397
G1 X134.482 Y132.482 E.06139
G2 X137.063 Y127.387 I-6.525 J-6.505 E.19264
G1 X135.307 Y125.631 E.08237
G3 X135.307 Y126.369 I-3.451 J.369 E.02452
G1 X137.063 Y124.613 E.08237
G2 X134.482 Y119.518 I-9.106 J1.41 E.19264
G1 X133.174 Y120.826 E.06139
G2 X131.905 Y119.813 I-5.206 J5.218 E.05397
G1 X130.964 Y117.326 F30000
G1 F4394
G2 X129.386 Y116.938 I-3.028 J8.91 E.05399
G1 X127.634 Y118.69 E.08215
G3 X128.367 Y118.691 I.36 J3.426 E.02434
G1 X126.614 Y116.938 E.08222
G2 X125.036 Y117.326 I1.45 J9.297 E.05398
G1 X121.81 Y122.093 F30000
G1 F4394
G3 X122.822 Y120.822 I6.864 J4.43 E.05397
G1 X121.518 Y119.518 E.06122
G2 X118.937 Y124.613 I6.525 J6.505 E.19264
G1 X120.684 Y126.36 E.08193
G1 X120.684 Y125.64 E.02386
G1 X118.937 Y127.387 E.08193
G2 X121.518 Y132.482 I9.106 J-1.41 E.19264
G1 X122.822 Y131.178 E.06122
G3 X121.81 Y129.907 I5.852 J-5.701 E.05397
G1 X125.036 Y134.674 F30000
G1 F4394
G2 X126.614 Y135.062 I3.028 J-8.909 E.05399
G1 X128.367 Y133.309 E.08222
G3 X127.634 Y133.31 I-.372 J-3.425 E.02434
G1 X129.386 Y135.062 E.08215
G2 X130.964 Y134.674 I-1.45 J-9.298 E.05399
; CHANGE_LAYER
; Z_HEIGHT: 10.6
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F15476.087
G1 X129.386 Y135.062 E-.61765
G1 X129.121 Y134.797 E-.14235
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 53/250
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
G3 Z10.8 I1.009 J-.68 P1  F30000
G1 X121.495 Y123.477 Z10.8
G1 Z10.6
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4414
G1 X121.504 Y123.46 E.00064
G3 X127.074 Y119.084 I6.496 J2.535 E.24647
G1 X127.381 Y119.059 E.01023
G1 X127.814 Y119.025 E.01441
G3 X121.358 Y123.869 I.185 J6.971 E1.16781
G1 X121.475 Y123.534 E.01179
G1 X121.869 Y123.603 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4414
G3 X127.126 Y119.473 I6.13 J2.393 E.21546
G1 X127.412 Y119.45 E.00883
G1 X127.825 Y119.417 E.01271
G3 X121.848 Y123.659 I.175 J6.578 E1.03164
M204 S10000
; WIPE_START
G1 F12000
G1 X122.157 Y122.964 E-.28907
G1 X122.512 Y122.36 E-.26637
G1 X122.833 Y121.928 E-.20457
; WIPE_END
G1 E-.04 F1800
G1 X130.075 Y124.339 Z11 F30000
G1 X137.484 Y126.807 Z11
G1 Z10.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4414
G3 X128.404 Y116.486 I-9.484 J-.811 E1.47443
G1 X128.974 Y116.535 E.01898
G1 X129.21 Y116.555 E.00783
G3 X137.489 Y126.747 I-1.209 J9.442 E.48071
G1 X137.875 Y126.841 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4414
G3 X128.421 Y116.094 I-9.875 J-.844 E1.42205
G1 X129.008 Y116.144 E.0181
G1 X129.259 Y116.165 E.00776
G3 X137.88 Y126.781 I-1.259 J9.831 E.46371
M204 S10000
; WIPE_START
G1 F12000
G1 X137.772 Y127.676 E-.34252
G1 X137.595 Y128.498 E-.3198
G1 X137.52 Y128.744 E-.09768
; WIPE_END
G1 E-.04 F1800
G1 X133.458 Y122.282 Z11 F30000
G1 X131.905 Y119.813 Z11
G1 Z10.6
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4414
G3 X133.174 Y120.826 I-3.937 J6.231 E.05397
G1 X134.482 Y119.518 E.06139
G3 X137.063 Y124.613 I-6.525 J6.505 E.19264
G1 X135.307 Y126.369 E.08237
G2 X135.307 Y125.631 I-3.451 J-.369 E.02452
G1 X137.063 Y127.387 E.08237
G3 X134.482 Y132.482 I-9.106 J-1.41 E.19264
G1 X133.174 Y131.174 E.06139
G3 X131.905 Y132.187 I-5.206 J-5.218 E.05397
G1 X130.964 Y134.674 F30000
G1 F4414
G3 X129.386 Y135.062 I-3.028 J-8.909 E.05399
G1 X127.634 Y133.31 E.08215
G2 X128.367 Y133.309 I.36 J-3.426 E.02434
G1 X126.614 Y135.062 E.08222
G3 X125.036 Y134.674 I1.45 J-9.298 E.05399
G1 X121.81 Y129.907 F30000
G1 F4414
G2 X122.822 Y131.178 I6.864 J-4.43 E.05397
G1 X121.518 Y132.482 E.06122
G3 X118.937 Y127.387 I6.525 J-6.505 E.19264
G1 X120.684 Y125.64 E.08193
G1 X120.684 Y126.36 E.02386
G1 X118.937 Y124.613 E.08193
G3 X121.518 Y119.518 I9.106 J1.41 E.19264
G1 X122.822 Y120.822 E.06122
G2 X121.81 Y122.093 I5.852 J5.701 E.05397
G1 X125.036 Y117.326 F30000
G1 F4414
G3 X126.614 Y116.938 I3.028 J8.909 E.05398
G1 X128.367 Y118.691 E.08222
G2 X127.634 Y118.69 I-.372 J3.425 E.02434
G1 X129.386 Y116.938 E.08215
G3 X130.964 Y117.326 I-1.45 J9.298 E.05399
; CHANGE_LAYER
; Z_HEIGHT: 10.8
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F15476.087
G1 X129.386 Y116.938 E-.61765
G1 X129.121 Y117.203 E-.14235
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 54/250
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
G3 Z11 I-.773 J-.94 P1  F30000
G1 X121.495 Y123.477 Z11
G1 Z10.8
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4395
G1 X121.504 Y123.46 E.00064
G3 X127.074 Y119.084 I6.496 J2.535 E.24647
G1 X127.372 Y119.06 E.00991
G1 X127.814 Y119.025 E.01473
G3 X121.356 Y123.878 I.185 J6.971 E1.16749
G1 X121.475 Y123.534 E.0121
G1 X121.869 Y123.603 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4395
G3 X127.126 Y119.473 I6.13 J2.392 E.21546
G1 X127.403 Y119.451 E.00854
G1 X127.825 Y119.417 E.013
G3 X121.848 Y123.659 I.175 J6.578 E1.03164
M204 S10000
; WIPE_START
G1 F12000
G1 X122.157 Y122.964 E-.28907
G1 X122.512 Y122.36 E-.26637
G1 X122.833 Y121.928 E-.20457
; WIPE_END
G1 E-.04 F1800
G1 X130.075 Y124.34 Z11.2 F30000
G1 X137.48 Y126.807 Z11.2
G1 Z10.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4395
G3 X130.006 Y135.309 I-9.49 J-.806 E.40208
G3 X128.986 Y116.536 I-2.006 J-9.305 E1.09175
G1 X129.21 Y116.555 E.00745
G3 X137.485 Y126.747 I-1.22 J9.446 E.48048
G1 X137.874 Y126.84 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4395
G3 X128.421 Y116.094 I-9.873 J-.846 E1.42174
G1 X129.019 Y116.145 E.01845
G1 X129.259 Y116.165 E.00741
G3 X137.878 Y126.781 I-1.259 J9.829 E.46368
M204 S10000
; WIPE_START
G1 F12000
G1 X137.772 Y127.676 E-.3425
G1 X137.595 Y128.498 E-.3198
G1 X137.52 Y128.744 E-.0977
; WIPE_END
G1 E-.04 F1800
G1 X131.905 Y132.187 Z11.2 F30000
G1 Z10.8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4395
G2 X133.174 Y131.174 I-3.937 J-6.231 E.05397
G1 X134.482 Y132.482 E.06139
G2 X137.063 Y127.387 I-6.525 J-6.505 E.19264
G1 X135.307 Y125.631 E.08237
G3 X135.307 Y126.369 I-3.451 J.369 E.02452
G1 X137.063 Y124.613 E.08237
G2 X134.482 Y119.518 I-9.106 J1.41 E.19264
G1 X133.174 Y120.826 E.06139
G2 X131.905 Y119.813 I-5.206 J5.218 E.05397
G1 X130.964 Y117.326 F30000
G1 F4395
G2 X129.386 Y116.938 I-3.028 J8.91 E.05399
G1 X127.634 Y118.69 E.08215
G3 X128.367 Y118.691 I.36 J3.426 E.02434
G1 X126.614 Y116.938 E.08222
G2 X125.036 Y117.326 I1.45 J9.298 E.05399
G1 X121.81 Y122.093 F30000
G1 F4395
G3 X122.822 Y120.822 I6.864 J4.43 E.05397
G1 X121.518 Y119.518 E.06122
G2 X118.937 Y124.613 I6.525 J6.505 E.19264
G1 X120.684 Y126.36 E.08193
G1 X120.684 Y125.64 E.02386
G1 X118.937 Y127.387 E.08193
G2 X121.518 Y132.482 I9.106 J-1.41 E.19264
G1 X122.822 Y131.178 E.06122
G3 X121.81 Y129.907 I5.852 J-5.701 E.05397
G1 X125.036 Y134.674 F30000
G1 F4395
G2 X126.614 Y135.062 I3.028 J-8.909 E.05399
G1 X128.367 Y133.309 E.08222
G3 X127.634 Y133.31 I-.372 J-3.425 E.02434
G1 X129.386 Y135.062 E.08215
G2 X130.964 Y134.674 I-1.45 J-9.298 E.05399
; CHANGE_LAYER
; Z_HEIGHT: 11
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F15476.087
G1 X129.386 Y135.062 E-.61765
G1 X129.121 Y134.797 E-.14235
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 55/250
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
G3 Z11.2 I1.009 J-.68 P1  F30000
G1 X121.495 Y123.477 Z11.2
G1 Z11
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4414
G1 X121.501 Y123.459 E.00064
G3 X127.074 Y119.084 I6.499 J2.541 E.2465
G1 X127.362 Y119.061 E.0096
G1 X127.814 Y119.025 E.01504
G3 X121.268 Y124.164 I.186 J6.975 E1.15855
M73 P43 R15
G1 X121.476 Y123.534 E.02201
G1 X121.867 Y123.602 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4414
G3 X127.126 Y119.473 I6.133 J2.398 E.21549
G1 X127.394 Y119.452 E.00825
G1 X127.825 Y119.417 E.01329
G3 X121.845 Y123.658 I.175 J6.583 E1.0325
M204 S10000
; WIPE_START
G1 F12000
G1 X122.157 Y122.964 E-.28911
G1 X122.512 Y122.36 E-.26637
G1 X122.833 Y121.928 E-.20452
; WIPE_END
G1 E-.04 F1800
G1 X130.075 Y124.34 Z11.4 F30000
G1 X137.481 Y126.807 Z11.4
G1 Z11
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4414
G3 X130.006 Y135.309 I-9.49 J-.807 E.40212
G3 X128.997 Y116.537 I-2.001 J-9.306 E1.0918
G1 X129.21 Y116.555 E.00707
G3 X137.486 Y126.747 I-1.218 J9.446 E.48053
G1 X137.872 Y126.84 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4414
G3 X130.089 Y135.692 I-9.881 J-.84 E.38783
G3 X129.03 Y116.146 I-2.084 J-9.689 E1.05277
G1 X129.259 Y116.165 E.00706
G3 X137.877 Y126.78 I-1.268 J9.835 E.46353
M204 S10000
; WIPE_START
G1 F12000
G1 X137.772 Y127.676 E-.34248
G1 X137.595 Y128.498 E-.3198
G1 X137.52 Y128.744 E-.09772
; WIPE_END
G1 E-.04 F1800
G1 X133.458 Y122.282 Z11.4 F30000
G1 X131.905 Y119.813 Z11.4
G1 Z11
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4414
G3 X133.174 Y120.826 I-3.937 J6.231 E.05397
G1 X134.482 Y119.518 E.06139
G3 X137.063 Y124.613 I-6.525 J6.505 E.19264
G1 X135.307 Y126.369 E.08237
G2 X135.307 Y125.631 I-3.451 J-.369 E.02452
G1 X137.063 Y127.387 E.08237
G3 X134.482 Y132.482 I-9.106 J-1.41 E.19264
G1 X133.174 Y131.174 E.06139
G3 X131.905 Y132.187 I-5.206 J-5.218 E.05397
G1 X130.964 Y134.674 F30000
G1 F4414
G3 X129.386 Y135.062 I-3.028 J-8.909 E.05399
G1 X127.634 Y133.31 E.08215
G2 X128.367 Y133.309 I.36 J-3.426 E.02434
M73 P43 R14
G1 X126.614 Y135.062 E.08222
G3 X125.036 Y134.674 I1.45 J-9.297 E.05398
G1 X121.81 Y129.907 F30000
G1 F4414
G2 X122.822 Y131.178 I6.864 J-4.43 E.05397
G1 X121.518 Y132.482 E.06122
G3 X118.937 Y127.387 I6.525 J-6.505 E.19264
G1 X120.684 Y125.64 E.08193
G1 X120.684 Y126.36 E.02386
G1 X118.937 Y124.613 E.08193
G3 X121.518 Y119.518 I9.106 J1.41 E.19264
G1 X122.822 Y120.822 E.06122
G2 X121.81 Y122.093 I5.852 J5.701 E.05397
G1 X125.036 Y117.326 F30000
G1 F4414
G3 X126.614 Y116.938 I3.028 J8.909 E.05398
G1 X128.367 Y118.691 E.08222
G2 X127.634 Y118.69 I-.372 J3.425 E.02434
G1 X129.386 Y116.938 E.08215
G3 X130.964 Y117.326 I-1.45 J9.298 E.05399
; CHANGE_LAYER
; Z_HEIGHT: 11.2
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F15476.087
G1 X129.386 Y116.938 E-.61765
G1 X129.121 Y117.203 E-.14235
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 56/250
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
G3 Z11.4 I-.773 J-.94 P1  F30000
G1 X121.495 Y123.477 Z11.4
G1 Z11.2
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4395
G1 X121.501 Y123.459 E.00064
G3 X127.074 Y119.084 I6.499 J2.541 E.2465
G1 X127.353 Y119.061 E.00928
G3 X134.012 Y122.458 I.64 J6.972 E.26157
G1 X134.354 Y123.117 E.02464
G3 X121.268 Y124.164 I-6.354 J2.883 E.88741
G1 X121.476 Y123.534 E.02201
G1 X121.867 Y123.602 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4395
G3 X127.126 Y119.473 I6.133 J2.398 E.21549
G1 X127.384 Y119.452 E.00796
G3 X133.674 Y122.657 I.609 J6.579 E.22882
G1 X133.997 Y123.279 E.02154
G3 X121.845 Y123.658 I-5.997 J2.721 E.79547
M204 S10000
; WIPE_START
G1 F12000
G1 X122.157 Y122.964 E-.28911
G1 X122.512 Y122.36 E-.26637
G1 X122.833 Y121.928 E-.20452
; WIPE_END
G1 E-.04 F1800
G1 X130.075 Y124.34 Z11.6 F30000
G1 X137.481 Y126.807 Z11.6
G1 Z11.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4395
G3 X130.006 Y135.309 I-9.49 J-.807 E.40213
G3 X129.008 Y116.538 I-2.004 J-9.305 E1.09243
G1 X129.21 Y116.555 E.0067
G3 X137.486 Y126.747 I-1.218 J9.446 E.48054
G1 X137.872 Y126.84 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4395
G3 X130.089 Y135.692 I-9.881 J-.84 E.38784
G3 X129.042 Y116.147 I-2.087 J-9.689 E1.05335
G1 X129.259 Y116.165 E.00671
G3 X137.877 Y126.78 I-1.268 J9.835 E.46354
M204 S10000
; WIPE_START
G1 F12000
G1 X137.772 Y127.676 E-.34248
G1 X137.595 Y128.498 E-.3198
G1 X137.52 Y128.744 E-.09772
; WIPE_END
G1 E-.04 F1800
G1 X131.905 Y132.187 Z11.6 F30000
G1 Z11.2
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4395
G2 X133.174 Y131.174 I-3.937 J-6.231 E.05397
G1 X134.482 Y132.482 E.06139
G2 X137.063 Y127.387 I-6.525 J-6.505 E.19264
G1 X135.307 Y125.631 E.08237
G3 X135.307 Y126.369 I-3.451 J.369 E.02452
G1 X137.063 Y124.613 E.08237
G2 X134.482 Y119.518 I-9.106 J1.41 E.19264
G1 X133.174 Y120.826 E.06139
G2 X131.905 Y119.813 I-5.206 J5.218 E.05397
G1 X130.964 Y117.326 F30000
G1 F4395
G2 X129.386 Y116.938 I-3.028 J8.91 E.05399
G1 X127.634 Y118.69 E.08215
G3 X128.367 Y118.691 I.36 J3.426 E.02434
G1 X126.614 Y116.938 E.08222
G2 X125.036 Y117.326 I1.45 J9.297 E.05398
G1 X121.81 Y122.093 F30000
G1 F4395
G3 X122.822 Y120.822 I6.864 J4.43 E.05397
G1 X121.518 Y119.518 E.06122
G2 X118.937 Y124.613 I6.525 J6.505 E.19264
G1 X120.684 Y126.36 E.08193
G1 X120.684 Y125.64 E.02386
G1 X118.937 Y127.387 E.08193
G2 X121.518 Y132.482 I9.106 J-1.41 E.19264
G1 X122.822 Y131.178 E.06122
G3 X121.81 Y129.907 I5.852 J-5.701 E.05397
G1 X125.036 Y134.674 F30000
G1 F4395
G2 X126.614 Y135.062 I3.028 J-8.909 E.05399
G1 X128.367 Y133.309 E.08222
G3 X127.634 Y133.31 I-.372 J-3.425 E.02434
G1 X129.386 Y135.062 E.08215
G2 X130.964 Y134.674 I-1.45 J-9.298 E.05399
; CHANGE_LAYER
; Z_HEIGHT: 11.4
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F15476.087
G1 X129.386 Y135.062 E-.61765
G1 X129.121 Y134.797 E-.14235
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 57/250
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
G3 Z11.6 I1.009 J-.68 P1  F30000
G1 X121.495 Y123.477 Z11.6
G1 Z11.4
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4412
G1 X121.506 Y123.461 E.00065
G3 X127.074 Y119.084 I6.497 J2.534 E.24642
G1 X127.343 Y119.062 E.00897
G3 X134.012 Y122.458 I.649 J6.971 E.26188
G1 X134.354 Y123.117 E.02464
G3 X121.273 Y124.166 I-6.352 J2.879 E.88657
G1 X121.477 Y123.534 E.022
G1 X121.871 Y123.604 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4412
G3 X127.126 Y119.473 I6.131 J2.392 E.21542
G1 X127.375 Y119.453 E.00767
G3 X133.674 Y122.657 I.618 J6.579 E.22911
G1 X133.997 Y123.279 E.02154
G3 X121.85 Y123.66 I-5.994 J2.717 E.79471
M204 S10000
; WIPE_START
G1 F12000
G1 X122.157 Y122.964 E-.28903
G1 X122.512 Y122.36 E-.26637
G1 X122.833 Y121.927 E-.2046
; WIPE_END
G1 E-.04 F1800
G1 X130.075 Y124.339 Z11.8 F30000
G1 X137.485 Y126.807 Z11.8
G1 Z11.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4412
G3 X128.404 Y116.486 I-9.485 J-.81 E1.47452
G1 X129.02 Y116.539 E.02049
G1 X129.21 Y116.555 E.00632
G3 X137.49 Y126.748 I-1.209 J9.442 E.48072
G1 X137.876 Y126.841 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4412
G3 X128.421 Y116.094 I-9.875 J-.844 E1.42212
G1 X129.053 Y116.148 E.01949
G1 X129.259 Y116.165 E.00636
G3 X137.881 Y126.781 I-1.259 J9.831 E.46371
M204 S10000
; WIPE_START
G1 F12000
G1 X137.772 Y127.676 E-.34253
G1 X137.595 Y128.498 E-.3198
G1 X137.52 Y128.744 E-.09767
; WIPE_END
G1 E-.04 F1800
G1 X133.458 Y122.282 Z11.8 F30000
G1 X131.905 Y119.813 Z11.8
G1 Z11.4
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4412
G3 X133.174 Y120.826 I-3.937 J6.231 E.05397
G1 X134.482 Y119.518 E.06139
G3 X137.063 Y124.613 I-6.525 J6.505 E.19264
G1 X135.307 Y126.369 E.08237
G2 X135.307 Y125.631 I-3.451 J-.369 E.02452
G1 X137.063 Y127.387 E.08237
G3 X134.482 Y132.482 I-9.106 J-1.41 E.19264
G1 X133.174 Y131.174 E.06139
G3 X131.905 Y132.187 I-5.206 J-5.218 E.05397
G1 X130.964 Y134.674 F30000
G1 F4412
G3 X129.386 Y135.062 I-3.028 J-8.909 E.05399
G1 X127.634 Y133.31 E.08215
G2 X128.367 Y133.309 I.36 J-3.426 E.02434
G1 X126.614 Y135.062 E.08222
G3 X125.036 Y134.674 I1.45 J-9.298 E.05399
G1 X121.81 Y129.907 F30000
G1 F4412
G2 X122.822 Y131.178 I6.864 J-4.43 E.05397
G1 X121.518 Y132.482 E.06122
G3 X118.937 Y127.387 I6.525 J-6.505 E.19264
G1 X120.684 Y125.64 E.08193
G1 X120.684 Y126.36 E.02386
G1 X118.937 Y124.613 E.08193
G3 X121.518 Y119.518 I9.106 J1.41 E.19264
G1 X122.822 Y120.822 E.06122
G2 X121.81 Y122.093 I5.852 J5.701 E.05397
G1 X125.036 Y117.326 F30000
G1 F4412
G3 X126.614 Y116.938 I3.028 J8.909 E.05398
G1 X128.367 Y118.691 E.08222
G2 X127.634 Y118.69 I-.372 J3.425 E.02434
G1 X129.386 Y116.938 E.08215
G3 X130.964 Y117.326 I-1.45 J9.298 E.05399
; CHANGE_LAYER
; Z_HEIGHT: 11.6
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F15476.087
G1 X129.386 Y116.938 E-.61765
G1 X129.121 Y117.203 E-.14235
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 58/250
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
G3 Z11.8 I-.773 J-.94 P1  F30000
G1 X121.495 Y123.477 Z11.8
G1 Z11.6
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4394
G1 X121.506 Y123.461 E.00065
G3 X127.074 Y119.084 I6.497 J2.535 E.24643
G1 X127.334 Y119.063 E.00865
G3 X134.012 Y122.458 I.658 J6.971 E.2622
G1 X134.354 Y123.117 E.02464
G3 X121.273 Y124.165 I-6.352 J2.879 E.88664
G1 X121.477 Y123.534 E.022
G1 X121.871 Y123.603 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4394
G3 X127.126 Y119.473 I6.131 J2.392 E.21542
G1 X127.365 Y119.454 E.00737
G3 X133.674 Y122.657 I.627 J6.578 E.2294
G1 X133.997 Y123.279 E.02154
G3 X121.849 Y123.659 I-5.995 J2.717 E.79478
M204 S10000
; WIPE_START
G1 F12000
G1 X122.157 Y122.964 E-.28904
G1 X122.512 Y122.36 E-.26637
G1 X122.833 Y121.927 E-.2046
; WIPE_END
G1 E-.04 F1800
G1 X130.075 Y124.34 Z12 F30000
G1 X137.48 Y126.807 Z12
G1 Z11.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4394
G3 X130.006 Y135.309 I-9.49 J-.806 E.40208
G3 X129.031 Y116.54 I-2.004 J-9.306 E1.09322
G1 X129.21 Y116.555 E.00594
G3 X137.485 Y126.747 I-1.22 J9.446 E.48048
G1 X137.874 Y126.84 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4394
G3 X128.421 Y116.094 I-9.874 J-.845 E1.42186
G1 X129.064 Y116.149 E.01984
G1 X129.259 Y116.165 E.00601
G3 X137.879 Y126.781 I-1.259 J9.83 E.46369
M204 S10000
; WIPE_START
G1 F12000
G1 X137.772 Y127.676 E-.34251
G1 X137.595 Y128.498 E-.3198
G1 X137.52 Y128.744 E-.09769
; WIPE_END
G1 E-.04 F1800
M73 P44 R14
G1 X131.905 Y132.187 Z12 F30000
G1 Z11.6
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4394
G2 X133.174 Y131.174 I-3.937 J-6.231 E.05397
G1 X134.482 Y132.482 E.06139
G2 X137.063 Y127.387 I-6.525 J-6.505 E.19264
G1 X135.307 Y125.631 E.08237
G3 X135.307 Y126.369 I-3.451 J.369 E.02452
G1 X137.063 Y124.613 E.08237
G2 X134.482 Y119.518 I-9.106 J1.41 E.19264
G1 X133.174 Y120.826 E.06139
G2 X131.905 Y119.813 I-5.206 J5.218 E.05397
G1 X130.964 Y117.326 F30000
G1 F4394
G2 X129.386 Y116.938 I-3.028 J8.91 E.05399
G1 X127.634 Y118.69 E.08215
G3 X128.367 Y118.691 I.36 J3.426 E.02434
G1 X126.614 Y116.938 E.08222
G2 X125.036 Y117.326 I1.45 J9.297 E.05398
G1 X121.81 Y122.093 F30000
G1 F4394
G3 X122.822 Y120.822 I6.864 J4.431 E.05397
G1 X121.518 Y119.518 E.06122
G2 X118.937 Y124.613 I6.525 J6.505 E.19264
G1 X120.684 Y126.36 E.08193
G1 X120.684 Y125.64 E.02386
G1 X118.937 Y127.387 E.08193
G2 X121.518 Y132.482 I9.106 J-1.41 E.19264
G1 X122.822 Y131.178 E.06122
G3 X121.81 Y129.907 I5.852 J-5.701 E.05397
G1 X125.036 Y134.674 F30000
G1 F4394
G2 X126.614 Y135.062 I3.028 J-8.909 E.05398
G1 X128.367 Y133.309 E.08222
G3 X127.634 Y133.31 I-.372 J-3.425 E.02434
G1 X129.386 Y135.062 E.08215
G2 X130.964 Y134.674 I-1.45 J-9.298 E.05399
; CHANGE_LAYER
; Z_HEIGHT: 11.8
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F15476.087
G1 X129.386 Y135.062 E-.61765
G1 X129.121 Y134.797 E-.14235
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 59/250
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
G3 Z12 I1.009 J-.68 P1  F30000
G1 X121.495 Y123.477 Z12
G1 Z11.8
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4414
G1 X121.501 Y123.459 E.00064
G3 X127.074 Y119.084 I6.499 J2.541 E.2465
G1 X127.324 Y119.064 E.00834
G1 X127.814 Y119.025 E.0163
G3 X121.268 Y124.164 I.186 J6.975 E1.15855
G1 X121.476 Y123.534 E.02201
G1 X121.867 Y123.602 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4414
G3 X127.126 Y119.473 I6.133 J2.398 E.21549
G1 X127.356 Y119.455 E.00708
G1 X127.825 Y119.417 E.01445
G3 X121.845 Y123.658 I.175 J6.583 E1.03249
M204 S10000
; WIPE_START
G1 F12000
G1 X122.157 Y122.964 E-.28911
G1 X122.512 Y122.36 E-.26637
G1 X122.833 Y121.928 E-.20452
; WIPE_END
G1 E-.04 F1800
G1 X130.075 Y124.34 Z12.2 F30000
G1 X137.48 Y126.807 Z12.2
G1 Z11.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4414
G3 X130.006 Y135.309 I-9.49 J-.806 E.40208
G3 X129.042 Y116.541 I-2.001 J-9.306 E1.09333
G1 X129.21 Y116.555 E.00556
G3 X137.485 Y126.747 I-1.22 J9.446 E.48048
G1 X137.87 Y126.84 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4414
G3 X130.089 Y135.692 I-9.881 J-.84 E.3878
G3 X129.076 Y116.15 I-2.084 J-9.689 E1.05419
G1 X129.259 Y116.165 E.00566
G3 X137.875 Y126.78 I-1.27 J9.835 E.46349
M204 S10000
; WIPE_START
G1 F12000
G1 X137.772 Y127.676 E-.34246
G1 X137.595 Y128.498 E-.3198
G1 X137.52 Y128.744 E-.09774
; WIPE_END
G1 E-.04 F1800
G1 X133.458 Y122.282 Z12.2 F30000
G1 X131.905 Y119.813 Z12.2
G1 Z11.8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4414
G3 X133.174 Y120.826 I-3.937 J6.231 E.05397
G1 X134.482 Y119.518 E.06139
G3 X137.063 Y124.613 I-6.525 J6.505 E.19264
G1 X135.307 Y126.369 E.08237
G2 X135.307 Y125.631 I-3.451 J-.369 E.02452
G1 X137.063 Y127.387 E.08237
G3 X134.482 Y132.482 I-9.106 J-1.41 E.19264
G1 X133.174 Y131.174 E.06139
G3 X131.905 Y132.187 I-5.206 J-5.218 E.05397
G1 X130.964 Y134.674 F30000
G1 F4414
G3 X129.386 Y135.062 I-3.028 J-8.909 E.05399
G1 X127.634 Y133.31 E.08215
G2 X128.367 Y133.309 I.36 J-3.426 E.02434
G1 X126.614 Y135.062 E.08222
G3 X125.036 Y134.674 I1.45 J-9.298 E.05399
G1 X121.81 Y129.907 F30000
G1 F4414
G2 X122.822 Y131.178 I6.864 J-4.43 E.05397
G1 X121.518 Y132.482 E.06122
G3 X118.937 Y127.387 I6.525 J-6.505 E.19264
G1 X120.684 Y125.64 E.08193
G1 X120.684 Y126.36 E.02386
G1 X118.937 Y124.613 E.08193
G3 X121.518 Y119.518 I9.106 J1.41 E.19264
G1 X122.822 Y120.822 E.06122
G2 X121.81 Y122.093 I5.852 J5.701 E.05397
G1 X125.036 Y117.326 F30000
G1 F4414
G3 X126.614 Y116.938 I3.028 J8.909 E.05398
G1 X128.367 Y118.691 E.08222
G2 X127.634 Y118.69 I-.372 J3.425 E.02434
G1 X129.378 Y116.946 E.08181
G3 X130.958 Y117.324 I-1.195 J8.469 E.05398
; CHANGE_LAYER
; Z_HEIGHT: 12
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F15476.087
G1 X129.935 Y117.033 E-.40433
G1 X129.378 Y116.946 E-.21415
G1 X129.115 Y117.209 E-.14153
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 60/250
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
G3 Z12.2 I-.773 J-.94 P1  F30000
G1 X121.495 Y123.477 Z12.2
G1 Z12
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4396
G1 X121.504 Y123.46 E.00064
G3 X127.074 Y119.084 I6.496 J2.535 E.24647
G1 X127.315 Y119.064 E.00803
G1 X127.814 Y119.025 E.01661
G3 X121.271 Y124.165 I.185 J6.971 E1.15759
G1 X121.477 Y123.534 E.022
G1 X121.869 Y123.603 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4396
G3 X127.126 Y119.473 I6.13 J2.392 E.21546
G1 X127.346 Y119.455 E.00679
G1 X127.825 Y119.417 E.01475
G3 X121.848 Y123.659 I.175 J6.578 E1.03164
M204 S10000
; WIPE_START
G1 F12000
G1 X122.157 Y122.964 E-.28906
G1 X122.512 Y122.36 E-.26637
G1 X122.833 Y121.928 E-.20457
; WIPE_END
G1 E-.04 F1800
G1 X130.075 Y124.339 Z12.4 F30000
G1 X137.488 Y126.808 Z12.4
G1 Z12
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4396
G3 X128.404 Y116.486 I-9.488 J-.808 E1.47505
G1 X129.054 Y116.541 E.02163
G1 X129.21 Y116.555 E.00519
G3 X137.493 Y126.748 I-1.209 J9.445 E.48077
G1 X137.879 Y126.841 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4396
G3 X128.421 Y116.094 I-9.879 J-.841 E1.42267
G1 X129.087 Y116.151 E.02054
G1 X129.259 Y116.165 E.00532
G3 X137.884 Y126.781 I-1.259 J9.834 E.46377
M204 S10000
; WIPE_START
G1 F12000
G1 X137.772 Y127.676 E-.34257
G1 X137.595 Y128.498 E-.3198
G1 X137.52 Y128.744 E-.09763
; WIPE_END
G1 E-.04 F1800
G1 X131.905 Y132.187 Z12.4 F30000
G1 Z12
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4396
G2 X133.174 Y131.174 I-3.937 J-6.231 E.05397
G1 X134.482 Y132.482 E.06139
G2 X137.063 Y127.387 I-6.525 J-6.505 E.19264
G1 X135.307 Y125.631 E.08237
G3 X135.307 Y126.369 I-3.451 J.369 E.02452
G1 X137.063 Y124.613 E.08237
G2 X134.48 Y119.52 I-9.077 J1.401 E.19263
G1 X133.174 Y120.826 E.06129
G2 X131.905 Y119.813 I-5.206 J5.218 E.05397
G1 X130.959 Y117.325 F30000
G1 F4396
G2 X129.379 Y116.945 I-2.788 J8.132 E.05398
G1 X127.634 Y118.69 E.08183
G3 X128.367 Y118.691 I.36 J3.426 E.02434
G1 X126.614 Y116.938 E.08222
G2 X125.036 Y117.326 I1.45 J9.297 E.05398
G1 X121.81 Y122.093 F30000
G1 F4396
G3 X122.822 Y120.822 I6.864 J4.431 E.05397
G1 X121.518 Y119.518 E.06122
G2 X118.937 Y124.613 I6.525 J6.505 E.19264
G1 X120.684 Y126.36 E.08193
G1 X120.684 Y125.64 E.02386
G1 X118.937 Y127.387 E.08193
G2 X121.518 Y132.482 I9.106 J-1.41 E.19264
G1 X122.822 Y131.178 E.06122
G3 X121.81 Y129.907 I5.852 J-5.701 E.05397
G1 X125.036 Y134.674 F30000
G1 F4396
G2 X126.614 Y135.062 I3.028 J-8.909 E.05399
G1 X128.367 Y133.309 E.08222
G3 X127.634 Y133.31 I-.372 J-3.425 E.02434
G1 X129.386 Y135.062 E.08215
G2 X130.964 Y134.674 I-1.45 J-9.298 E.05399
; CHANGE_LAYER
; Z_HEIGHT: 12.2
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F15476.087
G1 X129.386 Y135.062 E-.61765
G1 X129.121 Y134.797 E-.14235
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 61/250
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
G3 Z12.4 I1.009 J-.68 P1  F30000
G1 X121.495 Y123.477 Z12.4
G1 Z12.2
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4413
G1 X121.504 Y123.46 E.00064
G3 X127.074 Y119.084 I6.496 J2.535 E.24647
G1 X127.306 Y119.065 E.00771
G1 X127.814 Y119.025 E.01693
G3 X121.336 Y123.942 I.185 J6.971 E1.16529
G1 X121.476 Y123.534 E.0143
G1 X121.869 Y123.603 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4413
G3 X127.126 Y119.473 I6.13 J2.393 E.21546
G1 X127.337 Y119.456 E.0065
G1 X127.825 Y119.417 E.01504
G3 X121.848 Y123.659 I.175 J6.578 E1.03164
M204 S10000
; WIPE_START
G1 F12000
G1 X122.157 Y122.964 E-.28907
G1 X122.512 Y122.36 E-.26637
G1 X122.833 Y121.928 E-.20457
; WIPE_END
G1 E-.04 F1800
G1 X130.075 Y124.339 Z12.6 F30000
G1 X137.484 Y126.807 Z12.6
G1 Z12.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4413
G3 X128.404 Y116.486 I-9.483 J-.811 E1.4743
G1 X129.065 Y116.542 E.022
G1 X129.21 Y116.555 E.00481
G3 X137.489 Y126.747 I-1.209 J9.441 E.48069
G1 X137.875 Y126.84 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4413
G3 X128.421 Y116.094 I-9.874 J-.845 E1.42193
G1 X129.098 Y116.152 E.02089
G1 X129.259 Y116.165 E.00497
G3 X137.88 Y126.781 I-1.259 J9.83 E.4637
M204 S10000
; WIPE_START
G1 F12000
G1 X137.772 Y127.676 E-.34252
G1 X137.595 Y128.498 E-.3198
G1 X137.52 Y128.744 E-.09768
; WIPE_END
G1 E-.04 F1800
G1 X133.458 Y122.282 Z12.6 F30000
G1 X131.905 Y119.813 Z12.6
G1 Z12.2
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4413
G3 X133.174 Y120.826 I-3.937 J6.231 E.05397
G1 X134.481 Y119.519 E.0613
G3 X137.063 Y124.613 I-6.497 J6.495 E.19263
G1 X135.307 Y126.369 E.08237
G2 X135.307 Y125.631 I-3.451 J-.369 E.02452
G1 X137.063 Y127.387 E.08237
G3 X134.482 Y132.482 I-9.106 J-1.41 E.19264
G1 X133.174 Y131.174 E.06139
G3 X131.905 Y132.187 I-5.206 J-5.218 E.05397
G1 X130.964 Y134.674 F30000
G1 F4413
G3 X129.386 Y135.062 I-3.028 J-8.909 E.05399
G1 X127.634 Y133.31 E.08215
G2 X128.367 Y133.309 I.36 J-3.426 E.02434
G1 X126.614 Y135.062 E.08222
G3 X125.036 Y134.674 I1.45 J-9.297 E.05399
G1 X121.81 Y129.907 F30000
G1 F4413
G2 X122.822 Y131.178 I6.864 J-4.43 E.05397
G1 X121.518 Y132.482 E.06122
G3 X118.937 Y127.387 I6.525 J-6.505 E.19264
G1 X120.684 Y125.64 E.08193
M73 P45 R14
G1 X120.684 Y126.36 E.02386
G1 X118.937 Y124.613 E.08193
G3 X121.518 Y119.518 I9.106 J1.41 E.19264
G1 X122.822 Y120.822 E.06122
G2 X121.81 Y122.093 I5.852 J5.701 E.05397
G1 X125.036 Y117.326 F30000
G1 F4413
G3 X126.614 Y116.938 I3.028 J8.909 E.05398
G1 X128.367 Y118.691 E.08222
G2 X127.634 Y118.69 I-.372 J3.425 E.02434
G1 X129.379 Y116.945 E.08185
G3 X130.959 Y117.325 I-1.222 J8.557 E.05398
; CHANGE_LAYER
; Z_HEIGHT: 12.4
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F15476.087
G1 X129.935 Y117.033 E-.40471
G1 X129.379 Y116.945 E-.21377
G1 X129.116 Y117.208 E-.14153
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 62/250
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
G3 Z12.6 I-.773 J-.94 P1  F30000
G1 X121.495 Y123.477 Z12.6
G1 Z12.4
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4394
G1 X121.504 Y123.46 E.00064
G3 X127.074 Y119.084 I6.496 J2.535 E.24647
G1 X127.296 Y119.066 E.0074
G1 X127.814 Y119.025 E.01724
G3 X121.333 Y123.951 I.185 J6.971 E1.16498
G1 X121.476 Y123.534 E.01461
G1 X121.869 Y123.603 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4394
G3 X127.126 Y119.473 I6.13 J2.393 E.21546
G1 X127.327 Y119.457 E.00621
G1 X127.825 Y119.417 E.01533
G3 X121.848 Y123.659 I.175 J6.578 E1.03164
M204 S10000
; WIPE_START
G1 F12000
G1 X122.157 Y122.964 E-.28906
G1 X122.512 Y122.36 E-.26637
G1 X122.833 Y121.928 E-.20457
; WIPE_END
G1 E-.04 F1800
G1 X130.075 Y124.34 Z12.8 F30000
G1 X137.48 Y126.807 Z12.8
G1 Z12.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4394
G3 X130.006 Y135.309 I-9.49 J-.806 E.40208
G3 X129.076 Y116.543 I-2.001 J-9.307 E1.09448
G1 X129.21 Y116.555 E.00443
G3 X137.485 Y126.747 I-1.22 J9.446 E.48048
G1 X137.877 Y126.841 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4394
G3 X128.421 Y116.094 I-9.876 J-.843 E1.42224
G1 X129.11 Y116.153 E.02124
G1 X129.259 Y116.165 E.00462
G3 X134.434 Y118.463 I-1.33 J9.97 E.17634
G1 X134.55 Y118.557 E.00462
G3 X137.882 Y126.781 I-6.549 J7.44 E.28268
M204 S10000
; WIPE_START
G1 F12000
G1 X137.772 Y127.676 E-.34255
G1 X137.595 Y128.498 E-.3198
G1 X137.52 Y128.744 E-.09765
; WIPE_END
G1 E-.04 F1800
G1 X131.905 Y132.187 Z12.8 F30000
G1 Z12.4
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4394
G2 X133.174 Y131.174 I-3.937 J-6.231 E.05397
G1 X134.482 Y132.482 E.06139
G2 X137.063 Y127.387 I-6.525 J-6.505 E.19264
G1 X135.307 Y125.631 E.08237
G3 X135.307 Y126.369 I-3.451 J.369 E.02452
G1 X137.063 Y124.613 E.08237
G2 X134.481 Y119.519 I-9.081 J1.402 E.19263
G1 X133.174 Y120.826 E.0613
G2 X131.905 Y119.813 I-5.206 J5.218 E.05397
G1 X130.959 Y117.325 F30000
G1 F4394
G2 X129.38 Y116.944 I-2.816 J8.223 E.05398
G1 X127.634 Y118.69 E.08187
G3 X128.367 Y118.691 I.36 J3.426 E.02434
G1 X126.614 Y116.938 E.08222
G2 X125.036 Y117.326 I1.45 J9.297 E.05398
G1 X121.81 Y122.093 F30000
G1 F4394
G3 X122.822 Y120.822 I6.864 J4.43 E.05397
G1 X121.518 Y119.518 E.06122
G2 X118.937 Y124.613 I6.525 J6.505 E.19264
G1 X120.684 Y126.36 E.08193
G1 X120.684 Y125.64 E.02386
G1 X118.937 Y127.387 E.08193
G2 X121.518 Y132.482 I9.106 J-1.41 E.19264
G1 X122.822 Y131.178 E.06122
G3 X121.81 Y129.907 I5.852 J-5.701 E.05397
G1 X125.036 Y134.674 F30000
G1 F4394
G2 X126.614 Y135.062 I3.028 J-8.91 E.05399
G1 X128.367 Y133.309 E.08222
G3 X127.634 Y133.31 I-.372 J-3.425 E.02434
G1 X129.386 Y135.062 E.08215
G2 X130.964 Y134.674 I-1.45 J-9.298 E.05399
; CHANGE_LAYER
; Z_HEIGHT: 12.6
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F15476.087
G1 X129.386 Y135.062 E-.61765
G1 X129.121 Y134.797 E-.14235
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 63/250
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
G3 Z12.8 I1.009 J-.68 P1  F30000
G1 X121.495 Y123.477 Z12.8
G1 Z12.6
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4414
G1 X121.504 Y123.46 E.00064
G3 X127.074 Y119.084 I6.496 J2.535 E.24647
G1 X127.287 Y119.067 E.00708
G1 X127.814 Y119.025 E.01755
G3 X121.271 Y124.165 I.185 J6.971 E1.15759
G1 X121.477 Y123.534 E.022
G1 X121.869 Y123.603 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4414
G3 X127.126 Y119.473 I6.13 J2.392 E.21546
G1 X127.318 Y119.458 E.00592
G1 X127.825 Y119.417 E.01562
G3 X121.848 Y123.659 I.175 J6.578 E1.03164
M204 S10000
; WIPE_START
G1 F12000
G1 X122.157 Y122.964 E-.28907
G1 X122.512 Y122.36 E-.26637
G1 X122.833 Y121.928 E-.20457
; WIPE_END
G1 E-.04 F1800
G1 X130.075 Y124.34 Z13 F30000
G1 X137.483 Y126.807 Z13
G1 Z12.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4414
G3 X130.006 Y135.309 I-9.489 J-.807 E.40218
G3 X129.088 Y116.544 I-2.005 J-9.306 E1.09523
G1 X129.21 Y116.555 E.00405
G3 X137.488 Y126.747 I-1.216 J9.446 E.4806
G1 X137.874 Y126.84 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4414
G3 X130.089 Y135.692 I-9.88 J-.84 E.38788
G3 X129.121 Y116.154 I-2.087 J-9.69 E1.05595
G1 X129.259 Y116.165 E.00427
G3 X137.878 Y126.781 I-1.266 J9.835 E.4636
M204 S10000
; WIPE_START
G1 F12000
G1 X137.772 Y127.676 E-.3425
G1 X137.595 Y128.498 E-.3198
G1 X137.52 Y128.744 E-.0977
; WIPE_END
G1 E-.04 F1800
G1 X133.458 Y122.282 Z13 F30000
G1 X131.905 Y119.813 Z13
G1 Z12.6
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4414
G3 X133.174 Y120.826 I-3.937 J6.231 E.05397
G1 X134.481 Y119.519 E.06131
G3 X137.063 Y124.613 I-6.497 J6.494 E.19264
G1 X135.307 Y126.369 E.08237
G2 X135.307 Y125.631 I-3.451 J-.369 E.02452
G1 X137.063 Y127.387 E.08237
G3 X134.482 Y132.482 I-9.106 J-1.41 E.19264
G1 X133.174 Y131.174 E.06139
G3 X131.905 Y132.187 I-5.206 J-5.218 E.05397
G1 X130.964 Y134.674 F30000
G1 F4414
G3 X129.386 Y135.062 I-3.028 J-8.909 E.05399
G1 X127.634 Y133.31 E.08215
G2 X128.367 Y133.309 I.36 J-3.426 E.02434
G1 X126.614 Y135.062 E.08222
G3 X125.036 Y134.674 I1.45 J-9.298 E.05399
G1 X121.81 Y129.907 F30000
G1 F4414
G2 X122.822 Y131.178 I6.864 J-4.43 E.05397
G1 X121.518 Y132.482 E.06122
G3 X118.937 Y127.387 I6.525 J-6.505 E.19264
G1 X120.684 Y125.64 E.08193
G1 X120.684 Y126.36 E.02386
G1 X118.937 Y124.613 E.08193
G3 X121.518 Y119.518 I9.106 J1.41 E.19264
G1 X122.822 Y120.822 E.06122
G2 X121.81 Y122.093 I5.852 J5.701 E.05397
G1 X125.036 Y117.326 F30000
G1 F4414
G3 X126.614 Y116.938 I3.028 J8.909 E.05398
G1 X128.367 Y118.691 E.08222
G2 X127.634 Y118.69 I-.372 J3.425 E.02434
G1 X129.38 Y116.944 E.08189
G3 X130.96 Y117.325 I-1.251 J8.651 E.05398
; CHANGE_LAYER
; Z_HEIGHT: 12.8
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F15476.087
G1 X129.935 Y117.033 E-.4051
G1 X129.38 Y116.944 E-.21337
G1 X129.117 Y117.207 E-.14153
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 64/250
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
G3 Z13 I-.773 J-.94 P1  F30000
G1 X121.495 Y123.477 Z13
G1 Z12.8
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4397
G1 X121.501 Y123.459 E.00064
G3 X127.074 Y119.084 I6.499 J2.541 E.2465
G1 X127.277 Y119.068 E.00677
G1 X127.814 Y119.025 E.01787
G3 X121.268 Y124.164 I.186 J6.975 E1.15855
G1 X121.476 Y123.534 E.02201
G1 X121.867 Y123.602 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4397
G3 X127.126 Y119.473 I6.133 J2.398 E.21549
G1 X127.309 Y119.458 E.00563
G1 X127.825 Y119.417 E.01591
G3 X121.845 Y123.658 I.175 J6.583 E1.0325
M204 S10000
; WIPE_START
G1 F12000
G1 X122.157 Y122.964 E-.28911
G1 X122.512 Y122.36 E-.26637
G1 X122.833 Y121.928 E-.20452
; WIPE_END
G1 E-.04 F1800
G1 X130.075 Y124.339 Z13.2 F30000
G1 X137.488 Y126.808 Z13.2
G1 Z12.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4397
G3 X128.404 Y116.486 I-9.488 J-.808 E1.47504
G1 X129.099 Y116.545 E.02314
G1 X129.21 Y116.555 E.00367
G3 X137.493 Y126.748 I-1.209 J9.445 E.48077
G1 X137.879 Y126.841 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4397
G3 X128.421 Y116.094 I-9.879 J-.841 E1.42267
G1 X129.132 Y116.155 E.02194
G1 X129.259 Y116.165 E.00392
G3 X137.884 Y126.781 I-1.259 J9.834 E.46377
M204 S10000
; WIPE_START
G1 F12000
G1 X137.772 Y127.676 E-.34257
G1 X137.595 Y128.498 E-.3198
G1 X137.52 Y128.744 E-.09763
; WIPE_END
G1 E-.04 F1800
G1 X131.905 Y132.187 Z13.2 F30000
G1 Z12.8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4397
G2 X133.174 Y131.174 I-3.937 J-6.231 E.05397
G1 X134.482 Y132.482 E.06139
G2 X137.063 Y127.387 I-6.525 J-6.505 E.19264
G1 X135.307 Y125.631 E.08237
G3 X135.307 Y126.369 I-3.451 J.369 E.02452
G1 X137.063 Y124.613 E.08237
G2 X134.481 Y119.519 I-9.085 J1.403 E.19263
G1 X133.174 Y120.826 E.06132
G2 X131.905 Y119.813 I-5.206 J5.218 E.05397
G1 X130.96 Y117.325 F30000
G1 F4397
G2 X129.381 Y116.943 I-2.846 J8.319 E.05398
G1 X127.634 Y118.69 E.08191
G3 X128.367 Y118.691 I.36 J3.426 E.02434
G1 X126.614 Y116.938 E.08222
G2 X125.036 Y117.326 I1.45 J9.297 E.05398
G1 X121.81 Y122.093 F30000
G1 F4397
G3 X122.822 Y120.822 I6.864 J4.43 E.05397
G1 X121.518 Y119.518 E.06122
G2 X118.937 Y124.613 I6.525 J6.505 E.19264
G1 X120.684 Y126.36 E.08193
G1 X120.684 Y125.64 E.02386
G1 X118.937 Y127.387 E.08193
G2 X121.518 Y132.482 I9.106 J-1.41 E.19264
G1 X122.822 Y131.178 E.06122
G3 X121.81 Y129.907 I5.852 J-5.701 E.05397
G1 X125.036 Y134.674 F30000
G1 F4397
G2 X126.614 Y135.062 I3.028 J-8.909 E.05398
G1 X128.367 Y133.309 E.08222
G3 X127.634 Y133.31 I-.372 J-3.425 E.02434
G1 X129.386 Y135.062 E.08215
G2 X130.964 Y134.674 I-1.45 J-9.298 E.05399
; CHANGE_LAYER
; Z_HEIGHT: 13
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F15476.087
G1 X129.386 Y135.062 E-.61765
G1 X129.121 Y134.797 E-.14235
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 65/250
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
G3 Z13.2 I1.009 J-.68 P1  F30000
G1 X121.495 Y123.477 Z13.2
G1 Z13
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4414
G1 X121.504 Y123.46 E.00064
G3 X127.074 Y119.084 I6.496 J2.536 E.24647
G1 X127.268 Y119.068 E.00646
G1 X127.814 Y119.025 E.01818
G3 X121.324 Y123.978 I.185 J6.971 E1.16414
G1 X121.476 Y123.534 E.01556
G1 X121.869 Y123.603 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4414
G3 X127.126 Y119.473 I6.13 J2.392 E.21546
G1 X127.299 Y119.459 E.00534
G1 X127.825 Y119.417 E.0162
G3 X121.848 Y123.659 I.175 J6.578 E1.03164
M204 S10000
; WIPE_START
G1 F12000
G1 X122.157 Y122.964 E-.28906
G1 X122.512 Y122.36 E-.26637
G1 X122.833 Y121.928 E-.20457
; WIPE_END
G1 E-.04 F1800
G1 X130.075 Y124.339 Z13.4 F30000
G1 X137.488 Y126.808 Z13.4
G1 Z13
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4414
G3 X128.404 Y116.486 I-9.488 J-.808 E1.47505
G1 X129.11 Y116.546 E.02352
G1 X129.21 Y116.555 E.0033
G3 X137.493 Y126.748 I-1.209 J9.445 E.48077
M73 P46 R14
G1 X137.879 Y126.841 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4414
G3 X128.421 Y116.094 I-9.879 J-.841 E1.42267
G1 X129.144 Y116.156 E.02229
G1 X129.259 Y116.165 E.00357
G3 X137.884 Y126.781 I-1.259 J9.834 E.46377
M204 S10000
; WIPE_START
G1 F12000
G1 X137.772 Y127.676 E-.34257
G1 X137.595 Y128.498 E-.3198
G1 X137.52 Y128.744 E-.09763
; WIPE_END
G1 E-.04 F1800
G1 X133.458 Y122.282 Z13.4 F30000
G1 X131.905 Y119.813 Z13.4
G1 Z13
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4414
G3 X133.174 Y120.826 I-3.937 J6.231 E.05397
G1 X134.481 Y119.519 E.06132
G3 X137.063 Y124.613 I-6.505 J6.498 E.19263
G1 X135.307 Y126.369 E.08237
G2 X135.307 Y125.631 I-3.451 J-.369 E.02452
G1 X137.063 Y127.387 E.08237
G3 X134.482 Y132.482 I-9.106 J-1.41 E.19264
G1 X133.174 Y131.174 E.06139
G3 X131.905 Y132.187 I-5.206 J-5.218 E.05397
G1 X130.964 Y134.674 F30000
G1 F4414
G3 X129.386 Y135.062 I-3.028 J-8.909 E.05399
G1 X127.634 Y133.31 E.08215
G2 X128.367 Y133.309 I.36 J-3.426 E.02434
G1 X126.614 Y135.062 E.08222
G3 X125.036 Y134.674 I1.45 J-9.298 E.05399
G1 X121.81 Y129.907 F30000
G1 F4414
G2 X122.822 Y131.178 I6.864 J-4.43 E.05397
G1 X121.518 Y132.482 E.06122
G3 X118.937 Y127.387 I6.525 J-6.505 E.19264
G1 X120.684 Y125.64 E.08193
G1 X120.684 Y126.36 E.02386
G1 X118.937 Y124.613 E.08193
G3 X121.518 Y119.518 I9.106 J1.41 E.19264
G1 X122.822 Y120.822 E.06122
G2 X121.81 Y122.093 I5.852 J5.701 E.05397
G1 X125.036 Y117.326 F30000
G1 F4414
G3 X126.614 Y116.938 I3.028 J8.909 E.05398
G1 X128.367 Y118.691 E.08222
G2 X127.634 Y118.69 I-.372 J3.425 E.02434
G1 X129.381 Y116.943 E.08194
G3 X130.961 Y117.325 I-1.282 J8.753 E.05398
; CHANGE_LAYER
; Z_HEIGHT: 13.2
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F15476.087
G1 X129.934 Y117.033 E-.40552
G1 X129.381 Y116.943 E-.21295
G1 X129.118 Y117.206 E-.14153
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 66/250
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
G3 Z13.4 I-.773 J-.94 P1  F30000
G1 X121.495 Y123.477 Z13.4
G1 Z13.2
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4396
G1 X121.503 Y123.46 E.00064
G3 X127.074 Y119.084 I6.496 J2.536 E.24647
G1 X127.258 Y119.069 E.00614
G1 X127.814 Y119.025 E.0185
G3 X121.322 Y123.987 I.185 J6.971 E1.16385
G1 X121.476 Y123.534 E.01587
G1 X121.869 Y123.603 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4396
G3 X127.126 Y119.473 I6.131 J2.393 E.21546
G1 X127.29 Y119.46 E.00505
G1 X127.825 Y119.417 E.01649
G3 X121.847 Y123.659 I.175 J6.579 E1.03178
M204 S10000
; WIPE_START
G1 F12000
G1 X122.157 Y122.964 E-.28907
G1 X122.512 Y122.36 E-.26637
G1 X122.833 Y121.928 E-.20456
; WIPE_END
G1 E-.04 F1800
G1 X130.075 Y124.34 Z13.6 F30000
G1 X137.48 Y126.807 Z13.6
G1 Z13.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4396
G3 X130.006 Y135.309 I-9.49 J-.806 E.40208
G3 X129.122 Y116.547 I-2.005 J-9.307 E1.09646
G1 X129.21 Y116.555 E.00292
G3 X137.484 Y126.747 I-1.22 J9.446 E.48048
G1 X137.87 Y126.84 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4396
G3 X130.089 Y135.692 I-9.881 J-.84 E.3878
G3 X129.155 Y116.157 I-2.088 J-9.69 E1.05708
G1 X129.259 Y116.165 E.00322
G3 X137.875 Y126.78 I-1.27 J9.835 E.46349
M204 S10000
; WIPE_START
G1 F12000
G1 X137.772 Y127.676 E-.34246
G1 X137.595 Y128.498 E-.3198
G1 X137.52 Y128.744 E-.09774
; WIPE_END
G1 E-.04 F1800
G1 X131.905 Y132.187 Z13.6 F30000
G1 Z13.2
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4396
G2 X133.174 Y131.174 I-3.937 J-6.231 E.05397
G1 X134.482 Y132.482 E.06139
G2 X137.063 Y127.387 I-6.525 J-6.505 E.19264
G1 X135.307 Y125.631 E.08237
G3 X135.307 Y126.369 I-3.451 J.369 E.02452
G1 X137.063 Y124.613 E.08237
G2 X134.481 Y119.519 I-9.089 J1.404 E.19263
G1 X133.174 Y120.826 E.06133
G2 X131.905 Y119.813 I-5.206 J5.218 E.05397
G1 X130.961 Y117.325 F30000
G1 F4396
G2 X129.382 Y116.942 I-2.878 J8.423 E.05398
G1 X127.634 Y118.69 E.08196
G3 X128.367 Y118.691 I.36 J3.426 E.02434
G1 X126.614 Y116.938 E.08222
G2 X125.036 Y117.326 I1.45 J9.297 E.05398
G1 X121.81 Y122.093 F30000
G1 F4396
G3 X122.822 Y120.822 I6.864 J4.431 E.05397
G1 X121.518 Y119.518 E.06122
G2 X118.937 Y124.613 I6.525 J6.505 E.19264
G1 X120.684 Y126.36 E.08193
G1 X120.684 Y125.64 E.02386
G1 X118.937 Y127.387 E.08193
G2 X121.518 Y132.482 I9.106 J-1.41 E.19264
G1 X122.822 Y131.178 E.06122
G3 X121.81 Y129.907 I5.852 J-5.701 E.05397
G1 X125.036 Y134.674 F30000
G1 F4396
G2 X126.614 Y135.062 I3.028 J-8.909 E.05399
G1 X128.367 Y133.309 E.08222
G3 X127.634 Y133.31 I-.372 J-3.425 E.02434
G1 X129.386 Y135.062 E.08215
G2 X130.964 Y134.674 I-1.45 J-9.298 E.05399
; CHANGE_LAYER
; Z_HEIGHT: 13.4
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F15476.087
G1 X129.386 Y135.062 E-.61765
G1 X129.121 Y134.797 E-.14235
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 67/250
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
G3 Z13.6 I1.009 J-.68 P1  F30000
G1 X121.495 Y123.477 Z13.6
G1 Z13.4
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4414
G1 X121.504 Y123.46 E.00064
G3 X127.074 Y119.084 I6.496 J2.535 E.24647
G1 X127.249 Y119.07 E.00583
G1 X127.814 Y119.025 E.01881
G3 X121.319 Y123.996 I.185 J6.971 E1.16341
G1 X121.476 Y123.534 E.01618
G1 X121.869 Y123.603 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4414
G3 X127.126 Y119.473 I6.13 J2.392 E.21546
G1 X127.28 Y119.461 E.00476
G1 X127.825 Y119.417 E.01678
G3 X121.848 Y123.659 I.175 J6.578 E1.03164
M204 S10000
; WIPE_START
G1 F12000
G1 X122.157 Y122.964 E-.28906
G1 X122.512 Y122.36 E-.26637
G1 X122.833 Y121.928 E-.20457
; WIPE_END
G1 E-.04 F1800
G1 X130.075 Y124.339 Z13.8 F30000
G1 X137.483 Y126.807 Z13.8
G1 Z13.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4414
G3 X130.006 Y135.309 I-9.489 J-.807 E.40218
G3 X129.133 Y116.548 I-2.005 J-9.307 E1.09686
G1 X129.21 Y116.555 E.00254
G3 X137.488 Y126.747 I-1.215 J9.445 E.48061
G1 X137.873 Y126.84 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4414
G3 X130.089 Y135.692 I-9.88 J-.84 E.38788
G3 X129.166 Y116.158 I-2.088 J-9.691 E1.05745
G1 X129.259 Y116.165 E.00287
G3 X137.878 Y126.781 I-1.266 J9.835 E.46359
M204 S10000
; WIPE_START
G1 F12000
G1 X137.772 Y127.676 E-.3425
G1 X137.595 Y128.498 E-.3198
G1 X137.52 Y128.744 E-.0977
; WIPE_END
G1 E-.04 F1800
G1 X133.458 Y122.282 Z13.8 F30000
G1 X131.905 Y119.813 Z13.8
G1 Z13.4
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4414
G3 X133.174 Y120.826 I-3.937 J6.231 E.05397
G1 X134.482 Y119.518 E.06139
G3 X137.063 Y124.613 I-6.524 J6.505 E.19264
G1 X135.307 Y126.369 E.08237
G2 X135.307 Y125.631 I-3.451 J-.369 E.02452
G1 X137.063 Y127.387 E.08237
G3 X134.482 Y132.482 I-9.106 J-1.41 E.19264
G1 X133.174 Y131.174 E.06139
G3 X131.905 Y132.187 I-5.206 J-5.218 E.05397
G1 X130.964 Y134.674 F30000
G1 F4414
G3 X129.386 Y135.062 I-3.028 J-8.909 E.05399
G1 X127.634 Y133.31 E.08215
G2 X128.367 Y133.309 I.36 J-3.426 E.02434
G1 X126.614 Y135.062 E.08222
G3 X125.036 Y134.674 I1.45 J-9.298 E.05399
G1 X121.81 Y129.907 F30000
G1 F4414
G2 X122.822 Y131.178 I6.864 J-4.43 E.05397
G1 X121.518 Y132.482 E.06122
G3 X118.937 Y127.387 I6.525 J-6.505 E.19264
G1 X120.684 Y125.64 E.08193
G1 X120.684 Y126.36 E.02386
G1 X118.937 Y124.613 E.08193
G3 X121.518 Y119.518 I9.164 J1.439 E.1926
G1 X122.822 Y120.822 E.06122
G2 X121.81 Y122.093 I5.852 J5.701 E.05397
G1 X125.036 Y117.326 F30000
G1 F4414
G3 X126.614 Y116.938 I3.028 J8.909 E.05398
G1 X128.367 Y118.691 E.08222
G2 X127.634 Y118.69 I-.372 J3.425 E.02434
G1 X129.382 Y116.942 E.08198
G3 X130.961 Y117.325 I-1.316 J8.862 E.05398
; CHANGE_LAYER
; Z_HEIGHT: 13.6
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F15476.087
G1 X129.934 Y117.032 E-.40595
G1 X129.382 Y116.942 E-.21252
G1 X129.119 Y117.205 E-.14153
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 68/250
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
G3 Z13.8 I-.773 J-.94 P1  F30000
G1 X121.495 Y123.477 Z13.8
G1 Z13.6
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4395
G1 X121.504 Y123.46 E.00064
G3 X127.074 Y119.084 I6.496 J2.535 E.24647
G1 X127.24 Y119.071 E.00551
G1 X127.814 Y119.025 E.01912
G3 X121.317 Y124.005 I.185 J6.971 E1.16309
G1 X121.476 Y123.534 E.0165
G1 X121.869 Y123.603 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4395
G3 X127.126 Y119.473 I6.13 J2.392 E.21546
G1 X127.271 Y119.461 E.00447
G1 X127.825 Y119.417 E.01707
G3 X121.848 Y123.659 I.175 J6.578 E1.03164
M204 S10000
; WIPE_START
G1 F12000
G1 X122.157 Y122.964 E-.28907
G1 X122.512 Y122.36 E-.26637
G1 X122.833 Y121.928 E-.20457
; WIPE_END
G1 E-.04 F1800
G1 X130.075 Y124.339 Z14 F30000
G1 X137.484 Y126.807 Z14
G1 Z13.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4395
G3 X128.404 Y116.486 I-9.484 J-.811 E1.4744
G1 X129.145 Y116.549 E.02465
G1 X129.21 Y116.555 E.00216
G3 X137.489 Y126.747 I-1.209 J9.441 E.4807
G1 X137.874 Y126.84 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4395
G3 X128.421 Y116.094 I-9.874 J-.845 E1.4219
G1 X129.178 Y116.159 E.02334
G1 X129.259 Y116.165 E.00252
G3 X137.879 Y126.781 I-1.259 J9.83 E.46369
M204 S10000
; WIPE_START
G1 F12000
G1 X137.772 Y127.676 E-.34251
G1 X137.595 Y128.498 E-.3198
G1 X137.52 Y128.744 E-.09769
; WIPE_END
G1 E-.04 F1800
G1 X131.905 Y132.187 Z14 F30000
G1 Z13.6
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4395
G2 X133.174 Y131.174 I-3.937 J-6.231 E.05397
G1 X134.482 Y132.482 E.06139
G2 X137.063 Y127.387 I-6.525 J-6.505 E.19264
G1 X135.307 Y125.631 E.08237
M73 P47 R13
G3 X135.307 Y126.369 I-3.451 J.369 E.02452
G1 X137.063 Y124.613 E.08237
G2 X134.482 Y119.518 I-9.106 J1.41 E.19264
G1 X133.174 Y120.826 E.06139
G2 X131.905 Y119.813 I-5.206 J5.218 E.05397
G1 X130.962 Y117.326 F30000
G1 F4395
G2 X129.383 Y116.941 I-2.913 J8.535 E.05398
G1 X127.634 Y118.69 E.08201
G3 X128.367 Y118.691 I.36 J3.426 E.02434
G1 X126.614 Y116.938 E.08222
G2 X125.036 Y117.326 I1.45 J9.297 E.05398
G1 X121.81 Y122.093 F30000
G1 F4395
G3 X122.822 Y120.822 I6.864 J4.43 E.05397
G1 X121.518 Y119.518 E.06122
G2 X118.937 Y124.613 I6.525 J6.505 E.19264
G1 X120.684 Y126.36 E.08193
G1 X120.684 Y125.64 E.02386
G1 X118.937 Y127.387 E.08193
G2 X121.518 Y132.482 I9.106 J-1.41 E.19264
G1 X122.822 Y131.178 E.06122
G3 X121.81 Y129.907 I5.852 J-5.701 E.05397
G1 X125.036 Y134.674 F30000
G1 F4395
G2 X126.614 Y135.062 I3.028 J-8.909 E.05398
G1 X128.367 Y133.309 E.08222
G3 X127.634 Y133.31 I-.372 J-3.425 E.02434
G1 X129.386 Y135.062 E.08215
G2 X130.964 Y134.674 I-1.45 J-9.298 E.05399
; CHANGE_LAYER
; Z_HEIGHT: 13.8
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F15476.087
G1 X129.386 Y135.062 E-.61765
G1 X129.121 Y134.797 E-.14235
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 69/250
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
G3 Z14 I1.009 J-.68 P1  F30000
G1 X121.495 Y123.477 Z14
G1 Z13.8
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4414
G1 X121.504 Y123.46 E.00064
G3 X127.074 Y119.084 I6.496 J2.535 E.24647
G1 X127.23 Y119.071 E.0052
G1 X127.814 Y119.025 E.01944
G3 X121.314 Y124.014 I.185 J6.97 E1.16276
G1 X121.476 Y123.534 E.01681
G1 X121.869 Y123.603 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4414
G3 X127.126 Y119.473 I6.13 J2.393 E.21546
G1 X127.261 Y119.462 E.00417
G1 X127.825 Y119.417 E.01736
G3 X121.848 Y123.659 I.175 J6.579 E1.03168
M204 S10000
; WIPE_START
G1 F12000
G1 X122.157 Y122.964 E-.28907
G1 X122.512 Y122.36 E-.26636
G1 X122.833 Y121.928 E-.20457
; WIPE_END
G1 E-.04 F1800
G1 X130.075 Y124.339 Z14.2 F30000
G1 X137.485 Y126.807 Z14.2
G1 Z13.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4414
G3 X119.303 Y122.128 I-9.485 J-.81 E1.09733
G1 X119.323 Y122.078 E.00179
G3 X129.156 Y116.55 I8.694 J3.957 E.40027
G1 X129.21 Y116.555 E.00179
G3 X137.49 Y126.748 I-1.209 J9.442 E.48073
G1 X137.875 Y126.84 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4414
G3 X128.421 Y116.094 I-9.874 J-.845 E1.42193
G1 X129.189 Y116.16 E.02369
G1 X129.259 Y116.165 E.00217
G3 X137.88 Y126.781 I-1.259 J9.83 E.4637
M204 S10000
; WIPE_START
G1 F12000
G1 X137.772 Y127.676 E-.34252
G1 X137.595 Y128.498 E-.3198
G1 X137.52 Y128.744 E-.09768
; WIPE_END
G1 E-.04 F1800
G1 X133.458 Y122.282 Z14.2 F30000
G1 X131.905 Y119.813 Z14.2
G1 Z13.8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4414
G3 X133.174 Y120.826 I-3.937 J6.231 E.05397
G1 X134.482 Y119.518 E.06135
G3 X137.063 Y124.613 I-6.514 J6.501 E.19264
G1 X135.307 Y126.369 E.08237
G2 X135.307 Y125.631 I-3.451 J-.369 E.02452
G1 X137.063 Y127.387 E.08237
G3 X134.482 Y132.482 I-9.106 J-1.41 E.19264
G1 X133.174 Y131.174 E.06139
G3 X131.905 Y132.187 I-5.206 J-5.218 E.05397
G1 X130.964 Y134.674 F30000
G1 F4414
G3 X129.386 Y135.062 I-3.028 J-8.909 E.05399
G1 X127.634 Y133.31 E.08215
G2 X128.367 Y133.309 I.36 J-3.426 E.02434
G1 X126.614 Y135.062 E.08222
G3 X125.036 Y134.674 I1.45 J-9.298 E.05399
G1 X121.81 Y129.907 F30000
G1 F4414
G2 X122.822 Y131.178 I6.864 J-4.43 E.05397
G1 X121.518 Y132.482 E.06122
G3 X118.937 Y127.387 I6.525 J-6.505 E.19264
G1 X120.684 Y125.64 E.08193
G1 X120.684 Y126.36 E.02386
G1 X118.937 Y124.613 E.08193
G3 X121.518 Y119.518 I9.106 J1.41 E.19264
G1 X122.822 Y120.822 E.06122
G2 X121.81 Y122.093 I5.852 J5.701 E.05397
G1 X125.036 Y117.326 F30000
G1 F4414
G3 X126.614 Y116.938 I3.028 J8.909 E.05398
G1 X128.367 Y118.691 E.08222
G2 X127.634 Y118.69 I-.372 J3.425 E.02434
G1 X129.383 Y116.941 E.08203
G3 X130.962 Y117.326 I-1.352 J8.979 E.05398
; CHANGE_LAYER
; Z_HEIGHT: 14
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F15476.087
G1 X129.934 Y117.032 E-.4064
G1 X129.383 Y116.941 E-.21207
G1 X129.12 Y117.204 E-.14153
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 70/250
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
G3 Z14.2 I-.773 J-.94 P1  F30000
G1 X121.495 Y123.477 Z14.2
G1 Z14
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4396
G1 X121.504 Y123.46 E.00064
G3 X127.074 Y119.084 I6.496 J2.535 E.24647
G1 X127.221 Y119.072 E.00489
G1 X127.814 Y119.025 E.01975
G3 X121.271 Y124.165 I.185 J6.971 E1.15759
G1 X121.477 Y123.534 E.022
G1 X121.869 Y123.603 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4396
G3 X127.126 Y119.473 I6.13 J2.392 E.21546
G1 X127.252 Y119.463 E.00388
G1 X127.825 Y119.417 E.01766
G3 X121.848 Y123.659 I.175 J6.578 E1.03164
M204 S10000
; WIPE_START
G1 F12000
G1 X122.157 Y122.964 E-.28907
G1 X122.512 Y122.36 E-.26637
G1 X122.833 Y121.928 E-.20457
; WIPE_END
G1 E-.04 F1800
G1 X130.075 Y124.34 Z14.4 F30000
G1 X137.48 Y126.807 Z14.4
G1 Z14
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4396
G3 X130.006 Y135.309 I-9.49 J-.806 E.40208
G3 X129.167 Y116.551 I-2.006 J-9.308 E1.09809
G1 X129.21 Y116.555 E.00141
G3 X137.484 Y126.747 I-1.22 J9.446 E.48048
G1 X137.879 Y126.841 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4396
G1 X137.767 Y127.675 E.02584
G3 X128.421 Y116.094 I-9.767 J-1.679 E1.39608
G1 X129.2 Y116.16 E.02404
G1 X129.259 Y116.165 E.00182
G3 X137.879 Y126.785 I-1.259 J9.83 E.46383
M204 S10000
; WIPE_START
G1 F12000
G1 X137.767 Y127.675 E-.34073
G1 X137.595 Y128.498 E-.31973
G1 X137.518 Y128.749 E-.09954
; WIPE_END
G1 E-.04 F1800
G1 X131.905 Y132.187 Z14.4 F30000
G1 Z14
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4396
G2 X133.174 Y131.174 I-3.937 J-6.231 E.05397
G1 X134.482 Y132.482 E.06139
G2 X137.063 Y127.387 I-6.525 J-6.505 E.19264
G1 X135.307 Y125.631 E.08237
G3 X135.307 Y126.369 I-3.451 J.369 E.02452
G1 X137.063 Y124.613 E.08237
G2 X134.482 Y119.518 I-9.097 J1.407 E.19264
G1 X133.174 Y120.826 E.06136
G2 X131.905 Y119.813 I-5.206 J5.218 E.05397
G1 X130.962 Y117.326 F30000
G1 F4396
G2 X129.384 Y116.94 I-2.95 J8.656 E.05398
G1 X127.634 Y118.69 E.08206
G3 X128.367 Y118.691 I.36 J3.426 E.02434
G1 X126.614 Y116.938 E.08222
G2 X125.036 Y117.326 I1.45 J9.298 E.05399
G1 X121.81 Y122.093 F30000
G1 F4396
G3 X122.822 Y120.822 I6.864 J4.431 E.05397
G1 X121.518 Y119.518 E.06122
G2 X118.937 Y124.613 I6.525 J6.505 E.19264
G1 X120.684 Y126.36 E.08193
G1 X120.684 Y125.64 E.02386
G1 X118.937 Y127.387 E.08193
G2 X121.518 Y132.482 I9.106 J-1.41 E.19264
G1 X122.822 Y131.178 E.06122
G3 X121.81 Y129.907 I5.852 J-5.701 E.05397
G1 X125.036 Y134.674 F30000
G1 F4396
G2 X126.614 Y135.062 I3.028 J-8.909 E.05399
G1 X128.367 Y133.309 E.08222
G3 X127.634 Y133.31 I-.372 J-3.425 E.02434
G1 X129.386 Y135.062 E.08215
G2 X130.964 Y134.674 I-1.45 J-9.298 E.05399
; CHANGE_LAYER
; Z_HEIGHT: 14.2
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F15476.087
G1 X129.386 Y135.062 E-.61765
G1 X129.121 Y134.797 E-.14235
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 71/250
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
G3 Z14.4 I1.009 J-.68 P1  F30000
G1 X121.495 Y123.477 Z14.4
G1 Z14.2
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4414
G1 X121.503 Y123.46 E.00064
G3 X127.074 Y119.084 I6.497 J2.537 E.24648
G1 X127.211 Y119.073 E.00457
G1 X127.814 Y119.025 E.02007
G3 X121.308 Y124.032 I.185 J6.972 E1.16245
G1 X121.476 Y123.534 E.01744
G1 X121.868 Y123.603 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4414
G3 X127.126 Y119.473 I6.131 J2.394 E.21547
G1 X127.243 Y119.464 E.00359
G1 X127.825 Y119.417 E.01795
G3 X121.847 Y123.658 I.175 J6.58 E1.03195
M204 S10000
; WIPE_START
G1 F12000
G1 X122.157 Y122.964 E-.28908
G1 X122.512 Y122.36 E-.26636
G1 X122.833 Y121.928 E-.20455
; WIPE_END
G1 E-.04 F1800
G1 X130.075 Y124.339 Z14.6 F30000
G1 X137.486 Y126.807 Z14.6
G1 Z14.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4414
G3 X130.006 Y135.309 I-9.489 J-.807 E.40225
G3 X129.179 Y116.552 I-1.999 J-9.308 E1.09795
G1 X129.21 Y116.555 E.00103
G3 X137.491 Y126.748 I-1.212 J9.445 E.48071
G1 X137.879 Y126.841 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4414
G1 X137.764 Y127.674 E.02583
G3 X130.089 Y135.692 I-9.774 J-1.674 E.36196
G3 X129.212 Y116.161 I-2.086 J-9.691 E1.05881
G1 X129.259 Y116.165 E.00147
G3 X137.874 Y126.789 I-1.27 J9.835 E.46376
M204 S10000
; WIPE_START
G1 F12000
G1 X137.764 Y127.674 E-.33894
G1 X137.595 Y128.498 E-.31968
G1 X137.517 Y128.753 E-.10138
; WIPE_END
G1 E-.04 F1800
G1 X133.459 Y122.289 Z14.6 F30000
G1 X131.905 Y119.813 Z14.6
G1 Z14.2
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4414
G3 X133.174 Y120.826 I-3.937 J6.231 E.05397
G1 X134.482 Y119.518 E.06137
G3 X137.063 Y124.613 I-6.519 J6.503 E.19264
G1 X135.307 Y126.369 E.08237
G2 X135.307 Y125.631 I-3.451 J-.369 E.02452
G1 X137.063 Y127.387 E.08237
G3 X134.482 Y132.482 I-9.106 J-1.41 E.19264
G1 X133.174 Y131.174 E.06139
G3 X131.905 Y132.187 I-5.206 J-5.218 E.05397
G1 X130.964 Y134.674 F30000
G1 F4414
G3 X129.386 Y135.062 I-3.028 J-8.91 E.05399
G1 X127.634 Y133.31 E.08215
G2 X128.367 Y133.309 I.36 J-3.426 E.02434
G1 X126.614 Y135.062 E.08222
G3 X125.036 Y134.674 I1.45 J-9.297 E.05398
G1 X121.81 Y129.907 F30000
G1 F4414
G2 X122.822 Y131.178 I6.864 J-4.431 E.05397
G1 X121.518 Y132.482 E.06122
G3 X118.937 Y127.387 I6.525 J-6.505 E.19264
G1 X120.684 Y125.64 E.08193
G1 X120.684 Y126.36 E.02386
G1 X118.937 Y124.613 E.08193
G3 X121.518 Y119.518 I9.106 J1.41 E.19264
G1 X122.822 Y120.822 E.06122
G2 X121.81 Y122.093 I5.852 J5.701 E.05397
G1 X125.036 Y117.326 F30000
G1 F4414
G3 X126.614 Y116.938 I3.028 J8.909 E.05398
G1 X128.367 Y118.691 E.08222
G2 X127.634 Y118.69 I-.372 J3.425 E.02434
G1 X129.384 Y116.94 E.08208
G3 X130.963 Y117.326 I-1.391 J9.106 E.05398
; CHANGE_LAYER
; Z_HEIGHT: 14.4
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F15476.087
G1 X129.933 Y117.032 E-.40688
G1 X129.384 Y116.94 E-.21159
G1 X129.121 Y117.203 E-.14153
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 72/250
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
G3 Z14.6 I-.771 J-.941 P1  F30000
G1 X121.509 Y123.441 Z14.6
G1 Z14.4
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4414
G1 X121.809 Y122.783 E.02399
G3 X127.074 Y119.084 I6.19 J3.213 E.22184
G1 X127.202 Y119.074 E.00426
G1 X127.814 Y119.025 E.02038
G3 X121.488 Y123.497 I.186 J6.972 E1.18121
G1 X121.868 Y123.602 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4414
M73 P48 R13
G3 X127.126 Y119.473 I6.131 J2.395 E.21547
G1 X127.233 Y119.464 E.0033
G1 X127.825 Y119.417 E.01824
G3 X121.847 Y123.658 I.175 J6.58 E1.03198
M204 S10000
; WIPE_START
G1 F12000
G1 X122.157 Y122.964 E-.28908
G1 X122.512 Y122.36 E-.26637
G1 X122.833 Y121.928 E-.20455
; WIPE_END
G1 E-.04 F1800
G1 X130.075 Y124.339 Z14.8 F30000
G1 X137.484 Y126.807 Z14.8
G1 Z14.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4414
G3 X128.404 Y116.486 I-9.484 J-.811 E1.47432
G1 X129.19 Y116.553 E.02616
G1 X129.21 Y116.555 E.00065
G3 X137.489 Y126.747 I-1.209 J9.441 E.4807
G1 X137.879 Y126.842 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4414
G1 X137.769 Y127.675 E.02583
G3 X128.421 Y116.094 I-9.769 J-1.678 E1.39641
G1 X129.223 Y116.162 E.02474
G1 X129.259 Y116.165 E.00112
G3 X137.881 Y126.783 I-1.259 J9.832 E.46381
M204 S10000
; WIPE_START
G1 F12000
G1 X137.769 Y127.675 E-.3415
G1 X137.595 Y128.498 E-.31976
G1 X137.519 Y128.747 E-.09874
; WIPE_END
G1 E-.04 F1800
G1 X131.905 Y132.187 Z14.8 F30000
G1 Z14.4
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4414
G2 X133.174 Y131.174 I-3.937 J-6.231 E.05397
G1 X134.482 Y132.482 E.06139
G2 X137.063 Y127.387 I-6.525 J-6.505 E.19264
G1 X135.307 Y125.631 E.08237
G3 X135.307 Y126.369 I-3.451 J.369 E.02452
G1 X137.063 Y124.613 E.08237
G2 X134.482 Y119.518 I-9.102 J1.408 E.19264
G1 X133.174 Y120.826 E.06138
G2 X131.905 Y119.813 I-5.206 J5.218 E.05397
G1 X130.963 Y117.326 F30000
G1 F4414
G2 X129.385 Y116.939 I-2.99 J8.787 E.05398
G1 X127.634 Y118.69 E.08211
G3 X128.367 Y118.691 I.36 J3.426 E.02434
G1 X126.614 Y116.938 E.08222
G2 X125.036 Y117.326 I1.45 J9.297 E.05398
G1 X121.81 Y122.093 F30000
G1 F4414
G3 X122.822 Y120.822 I6.864 J4.43 E.05397
G1 X121.518 Y119.518 E.06122
G2 X118.937 Y124.613 I6.525 J6.505 E.19264
G1 X120.684 Y126.36 E.08193
G1 X120.684 Y125.64 E.02386
G1 X118.937 Y127.387 E.08193
G2 X121.518 Y132.482 I9.106 J-1.41 E.19264
G1 X122.822 Y131.178 E.06122
G3 X121.81 Y129.907 I5.852 J-5.701 E.05397
G1 X125.036 Y134.674 F30000
G1 F4414
G2 X126.614 Y135.062 I3.028 J-8.909 E.05399
G1 X128.367 Y133.309 E.08222
G3 X127.634 Y133.31 I-.372 J-3.425 E.02434
G1 X129.386 Y135.062 E.08215
G2 X130.964 Y134.674 I-1.45 J-9.298 E.05399
; CHANGE_LAYER
; Z_HEIGHT: 14.6
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F15476.087
G1 X129.386 Y135.062 E-.61765
G1 X129.121 Y134.797 E-.14235
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 73/250
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
G3 Z14.8 I1.009 J-.68 P1  F30000
G1 X121.495 Y123.477 Z14.8
G1 Z14.6
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4414
G1 X121.504 Y123.46 E.00064
G3 X127.074 Y119.084 I6.496 J2.535 E.24647
G1 X127.192 Y119.074 E.00394
G1 X127.814 Y119.025 E.0207
G3 X121.271 Y124.165 I.185 J6.971 E1.15759
G1 X121.477 Y123.534 E.022
G1 X121.869 Y123.603 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4414
G3 X127.126 Y119.473 I6.13 J2.392 E.21546
G1 X127.224 Y119.465 E.00301
G1 X127.825 Y119.417 E.01853
G3 X121.848 Y123.659 I.175 J6.578 E1.03164
M204 S10000
; WIPE_START
G1 F12000
G1 X122.157 Y122.964 E-.28906
G1 X122.512 Y122.36 E-.26637
G1 X122.833 Y121.928 E-.20457
; WIPE_END
G1 E-.04 F1800
G1 X130.075 Y124.34 Z15 F30000
G1 X137.48 Y126.807 Z15
G1 Z14.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4414
G3 X129.21 Y135.445 I-9.489 J-.807 E.42889
G3 X129.201 Y116.554 I-1.21 J-9.445 E1.07252
G1 X129.21 Y116.555 E.00028
G3 X137.484 Y126.747 I-1.219 J9.445 E.48049
G1 X137.879 Y126.842 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4414
G1 X137.767 Y127.675 E.02582
G3 X128.421 Y116.094 I-9.767 J-1.679 E1.39608
G1 X129.235 Y116.163 E.02509
G1 X129.259 Y116.165 E.00077
G3 X137.879 Y126.785 I-1.259 J9.83 E.46383
M204 S10000
; WIPE_START
G1 F12000
G1 X137.767 Y127.675 E-.3407
G1 X137.595 Y128.498 E-.31973
G1 X137.518 Y128.749 E-.09957
; WIPE_END
G1 E-.04 F1800
G1 X133.458 Y122.286 Z15 F30000
G1 X131.905 Y119.813 Z15
G1 Z14.6
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4414
G3 X133.174 Y120.826 I-3.937 J6.231 E.05397
G1 X134.482 Y119.518 E.06139
G3 X137.063 Y124.613 I-6.525 J6.505 E.19264
G1 X135.307 Y126.369 E.08237
G2 X135.307 Y125.631 I-3.451 J-.369 E.02452
G1 X137.063 Y127.387 E.08237
G3 X134.482 Y132.482 I-9.106 J-1.41 E.19264
G1 X133.174 Y131.174 E.06139
G3 X131.905 Y132.187 I-5.206 J-5.218 E.05397
G1 X130.964 Y134.674 F30000
G1 F4414
G3 X129.386 Y135.062 I-3.028 J-8.909 E.05398
G1 X127.634 Y133.31 E.08215
G2 X128.367 Y133.309 I.36 J-3.426 E.02434
G1 X126.614 Y135.062 E.08222
G3 X125.036 Y134.674 I1.45 J-9.298 E.05399
G1 X121.81 Y129.907 F30000
G1 F4414
G2 X122.822 Y131.178 I6.864 J-4.43 E.05397
G1 X121.518 Y132.482 E.06122
G3 X118.937 Y127.387 I6.525 J-6.505 E.19264
G1 X120.684 Y125.64 E.08193
G1 X120.684 Y126.36 E.02386
G1 X118.937 Y124.613 E.08193
G3 X121.518 Y119.518 I9.106 J1.41 E.19264
G1 X122.822 Y120.822 E.06122
G2 X121.81 Y122.093 I5.852 J5.701 E.05397
G1 X125.036 Y117.326 F30000
G1 F4414
G3 X126.614 Y116.938 I3.028 J8.909 E.05398
G1 X128.367 Y118.691 E.08222
G2 X127.634 Y118.69 I-.372 J3.425 E.02434
G1 X129.385 Y116.939 E.08213
G3 X130.964 Y117.326 I-1.433 J9.244 E.05398
; CHANGE_LAYER
; Z_HEIGHT: 14.8
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F15476.087
G1 X129.385 Y116.939 E-.61764
G1 X129.12 Y117.204 E-.14236
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 74/250
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
G3 Z15 I-.773 J-.94 P1  F30000
G1 X121.495 Y123.477 Z15
G1 Z14.8
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4396
G1 X121.503 Y123.46 E.00064
G3 X127.074 Y119.084 I6.496 J2.537 E.24648
G1 X127.183 Y119.075 E.00363
G1 X127.814 Y119.025 E.02101
G3 X121.27 Y124.165 I.185 J6.972 E1.15781
G1 X121.476 Y123.534 E.022
G1 X121.869 Y123.603 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4396
G3 X127.126 Y119.473 I6.131 J2.394 E.21547
G1 X127.214 Y119.466 E.00272
G1 X127.825 Y119.417 E.01882
G3 X121.847 Y123.658 I.175 J6.58 E1.03192
M204 S10000
; WIPE_START
G1 F12000
G1 X122.157 Y122.964 E-.28908
G1 X122.512 Y122.36 E-.26637
G1 X122.833 Y121.928 E-.20455
; WIPE_END
G1 E-.04 F1800
G1 X130.075 Y124.34 Z15.2 F30000
G1 X137.478 Y126.807 Z15.2
G1 Z14.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4396
G3 X127.596 Y116.486 I-9.484 J-.811 E1.44773
G3 X129.188 Y116.553 I.404 J9.385 E.05292
G3 X137.483 Y126.747 I-1.193 J9.443 E.48122
G1 X137.879 Y126.842 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4396
G1 X137.761 Y127.674 E.02581
G3 X127.579 Y116.094 I-9.767 J-1.678 E1.37035
G3 X129.237 Y116.164 I.421 J9.775 E.05105
G3 X137.873 Y126.791 I-1.242 J9.832 E.4645
M204 S10000
; WIPE_START
G1 F12000
G1 X137.761 Y127.674 E-.33822
G1 X137.595 Y128.498 E-.31966
G1 X137.516 Y128.755 E-.10213
; WIPE_END
G1 E-.04 F1800
G1 X131.905 Y132.187 Z15.2 F30000
G1 Z14.8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4396
G2 X133.174 Y131.174 I-3.937 J-6.231 E.05397
G1 X134.482 Y132.482 E.06139
G2 X137.063 Y127.387 I-6.543 J-6.514 E.19263
G1 X135.307 Y125.631 E.08237
G3 X135.307 Y126.369 I-3.451 J.369 E.02452
G1 X137.063 Y124.613 E.08237
G2 X134.482 Y119.518 I-9.106 J1.41 E.19264
G1 X133.174 Y120.826 E.06139
G2 X131.905 Y119.813 I-5.206 J5.218 E.05397
G1 X130.963 Y117.326 F30000
G1 F4396
G2 X129.385 Y116.939 I-2.986 J8.772 E.05398
G1 X127.634 Y118.69 E.0821
G3 X128.367 Y118.691 I.36 J3.426 E.02434
G1 X126.614 Y116.938 E.08222
G2 X125.036 Y117.326 I1.45 J9.297 E.05398
G1 X121.81 Y122.093 F30000
G1 F4396
G3 X122.822 Y120.822 I6.864 J4.43 E.05397
G1 X121.518 Y119.518 E.06122
G2 X118.937 Y124.613 I6.543 J6.514 E.19263
G1 X120.684 Y126.36 E.08193
G1 X120.684 Y125.64 E.02386
G1 X118.937 Y127.387 E.08193
G2 X121.518 Y132.482 I9.106 J-1.41 E.19264
G1 X122.822 Y131.178 E.06122
G3 X121.81 Y129.907 I5.852 J-5.701 E.05397
G1 X125.036 Y134.674 F30000
G1 F4396
G2 X126.614 Y135.062 I3.028 J-8.909 E.05399
G1 X128.367 Y133.309 E.08222
G3 X127.634 Y133.31 I-.372 J-3.425 E.02434
G1 X129.386 Y135.062 E.08215
G2 X130.964 Y134.674 I-1.45 J-9.297 E.05398
; CHANGE_LAYER
; Z_HEIGHT: 15
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F15476.087
G1 X129.386 Y135.062 E-.61765
G1 X129.121 Y134.797 E-.14235
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 75/250
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
G3 Z15.2 I1.011 J-.678 P1  F30000
G1 X121.509 Y123.441 Z15.2
G1 Z15
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4433
G1 X121.809 Y122.783 E.024
G3 X127.074 Y119.084 I6.191 J3.214 E.22184
G1 X127.173 Y119.076 E.00332
G1 X127.814 Y119.025 E.02132
G3 X121.488 Y123.497 I.186 J6.973 E1.18133
G1 X121.868 Y123.602 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4433
G3 X127.126 Y119.473 I6.132 J2.396 E.21547
G1 X127.205 Y119.467 E.00243
G1 X127.825 Y119.417 E.01911
G3 X121.846 Y123.658 I.175 J6.581 E1.03211
M204 S10000
; WIPE_START
G1 F12000
G1 X122.157 Y122.964 E-.28909
G1 X122.512 Y122.36 E-.26637
G1 X122.833 Y121.928 E-.20454
; WIPE_END
G1 E-.04 F1800
G1 X130.075 Y124.34 Z15.4 F30000
G1 X137.478 Y126.807 Z15.4
G1 Z15
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4433
G3 X128.404 Y116.486 I-9.483 J-.811 E1.47447
G1 X129.199 Y116.554 E.02646
G3 X137.483 Y126.747 I-1.204 J9.442 E.48086
G1 X137.879 Y126.842 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4433
G1 X137.762 Y127.674 E.0258
G3 X128.421 Y116.094 I-9.767 J-1.679 E1.39625
G1 X129.248 Y116.165 E.02552
G3 X137.873 Y126.79 I-1.254 J9.831 E.46417
M204 S10000
; WIPE_START
G1 F12000
G1 X137.762 Y127.674 E-.33841
G1 X137.595 Y128.498 E-.31966
G1 X137.516 Y128.755 E-.10193
; WIPE_END
G1 E-.04 F1800
G1 X133.459 Y122.29 Z15.4 F30000
G1 X131.905 Y119.813 Z15.4
G1 Z15
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4433
G3 X133.174 Y120.826 I-3.937 J6.231 E.05397
M73 P49 R13
G1 X134.482 Y119.518 E.06139
G3 X137.063 Y124.613 I-6.525 J6.505 E.19264
G1 X135.307 Y126.369 E.08237
G2 X135.307 Y125.631 I-3.451 J-.369 E.02452
G1 X137.063 Y127.387 E.08237
G3 X134.482 Y132.482 I-9.114 J-1.414 E.19263
G1 X133.174 Y131.174 E.06139
G3 X131.905 Y132.187 I-5.206 J-5.218 E.05397
G1 X130.964 Y134.674 F30000
G1 F4433
G3 X129.386 Y135.062 I-3.028 J-8.909 E.05398
G1 X127.634 Y133.31 E.08215
G2 X128.367 Y133.309 I.36 J-3.426 E.02434
G1 X126.614 Y135.062 E.08222
G3 X125.036 Y134.674 I1.45 J-9.298 E.05398
G1 X121.81 Y129.907 F30000
G1 F4433
G2 X122.822 Y131.178 I6.864 J-4.43 E.05397
G1 X121.518 Y132.482 E.06122
G3 X118.937 Y127.387 I6.525 J-6.505 E.19264
G1 X120.684 Y125.64 E.08193
G1 X120.684 Y126.36 E.02386
G1 X118.937 Y124.613 E.08193
G3 X121.518 Y119.518 I9.106 J1.41 E.19264
G1 X122.822 Y120.822 E.06122
G2 X121.81 Y122.093 I5.852 J5.701 E.05397
G1 X125.036 Y117.326 F30000
G1 F4433
G3 X126.614 Y116.938 I3.028 J8.909 E.05398
G1 X128.367 Y118.691 E.08222
G2 X127.634 Y118.69 I-.372 J3.425 E.02434
G1 X129.385 Y116.939 E.08213
G3 X130.964 Y117.326 I-1.428 J9.228 E.05398
; CHANGE_LAYER
; Z_HEIGHT: 15.2
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F15476.087
G1 X129.385 Y116.939 E-.61764
G1 X129.12 Y117.204 E-.14236
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 76/250
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
G3 Z15.4 I-.773 J-.94 P1  F30000
G1 X121.495 Y123.477 Z15.4
G1 Z15.2
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4397
G1 X121.502 Y123.459 E.00064
G3 X127.074 Y119.084 I6.497 J2.538 E.24649
G1 X127.164 Y119.077 E.003
G1 X127.814 Y119.025 E.02164
G3 X121.269 Y124.165 I.186 J6.973 E1.15808
G1 X121.476 Y123.534 E.022
G1 X121.868 Y123.602 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4397
G3 X127.126 Y119.473 I6.132 J2.396 E.21548
G1 X127.195 Y119.467 E.00214
G1 X127.825 Y119.417 E.0194
G3 X121.846 Y123.658 I.175 J6.581 E1.03215
M204 S10000
; WIPE_START
G1 F12000
G1 X122.157 Y122.964 E-.28909
G1 X122.512 Y122.36 E-.26636
G1 X122.833 Y121.928 E-.20454
; WIPE_END
G1 E-.04 F1800
G1 X130.075 Y124.34 Z15.6 F30000
G1 X137.483 Y126.807 Z15.6
G1 Z15.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4397
G3 X127.596 Y116.486 I-9.483 J-.811 E1.4475
G1 X128.404 Y116.486 E.02682
G3 X137.488 Y126.747 I-.405 J9.509 E.50749
G1 X137.879 Y126.842 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4397
G1 X137.767 Y127.675 E.0258
G3 X127.579 Y116.094 I-9.767 J-1.679 E1.37023
G1 X128.421 Y116.094 E.02587
G3 X137.879 Y126.786 I-.421 J9.901 E.4897
M204 S10000
; WIPE_START
G1 F12000
G1 X137.767 Y127.675 E-.34044
G1 X137.595 Y128.498 E-.31973
G1 X137.518 Y128.75 E-.09984
; WIPE_END
G1 E-.04 F1800
G1 X131.905 Y132.187 Z15.6 F30000
G1 Z15.2
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4397
G2 X133.174 Y131.174 I-3.937 J-6.231 E.05397
G1 X134.482 Y132.482 E.06139
G2 X137.063 Y127.387 I-6.525 J-6.505 E.19264
G1 X135.307 Y125.631 E.08237
G3 X135.307 Y126.369 I-3.451 J.369 E.02452
G1 X137.063 Y124.613 E.08237
G2 X134.482 Y119.518 I-9.106 J1.41 E.19264
G1 X133.174 Y120.826 E.06139
G2 X131.905 Y119.813 I-5.206 J5.218 E.05397
G1 X130.964 Y117.326 F30000
G1 F4397
G2 X129.386 Y116.938 I-3.028 J8.91 E.05399
G1 X127.634 Y118.69 E.08215
G3 X128.367 Y118.691 I.36 J3.426 E.02434
G1 X126.614 Y116.938 E.08222
G2 X125.036 Y117.326 I1.45 J9.298 E.05399
G1 X121.81 Y122.093 F30000
G1 F4397
G3 X122.822 Y120.822 I6.865 J4.431 E.05397
G1 X121.518 Y119.518 E.06122
G2 X118.937 Y124.613 I6.525 J6.505 E.19264
G1 X120.684 Y126.36 E.08193
G1 X120.684 Y125.64 E.02386
G1 X118.937 Y127.387 E.08193
G2 X121.518 Y132.482 I9.105 J-1.41 E.19264
G1 X122.822 Y131.178 E.06122
G3 X121.81 Y129.907 I5.852 J-5.701 E.05397
G1 X125.036 Y134.674 F30000
G1 F4397
G2 X126.614 Y135.062 I3.028 J-8.91 E.05399
G1 X128.367 Y133.309 E.08222
G3 X127.634 Y133.31 I-.372 J-3.425 E.02434
G1 X129.386 Y135.062 E.08215
G2 X130.964 Y134.674 I-1.45 J-9.298 E.05399
; CHANGE_LAYER
; Z_HEIGHT: 15.4
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F15476.087
G1 X129.386 Y135.062 E-.61765
G1 X129.121 Y134.797 E-.14235
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 77/250
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
G3 Z15.6 I1.009 J-.68 P1  F30000
G1 X121.495 Y123.477 Z15.6
G1 Z15.4
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4414
G1 X121.504 Y123.46 E.00064
G3 X127.074 Y119.084 I6.496 J2.535 E.24647
G1 X127.155 Y119.077 E.00269
G1 X127.814 Y119.025 E.02195
G3 X121.271 Y124.165 I.185 J6.971 E1.15759
G1 X121.477 Y123.534 E.022
G1 X121.869 Y123.603 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4414
G3 X127.126 Y119.473 I6.13 J2.392 E.21546
G1 X127.186 Y119.468 E.00185
G1 X127.825 Y119.417 E.01969
G3 X121.848 Y123.659 I.175 J6.578 E1.03164
M204 S10000
; WIPE_START
G1 F12000
G1 X122.157 Y122.964 E-.28907
G1 X122.512 Y122.36 E-.26636
G1 X122.833 Y121.928 E-.20457
; WIPE_END
G1 E-.04 F1800
G1 X130.075 Y124.34 Z15.8 F30000
G1 X137.478 Y126.807 Z15.8
G1 Z15.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4414
G3 X127.596 Y116.486 I-9.483 J-.811 E1.44766
G1 X128.415 Y116.487 E.0272
G3 X137.483 Y126.747 I-.421 J9.509 E.50692
G1 X137.879 Y126.843 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4414
G1 X137.762 Y127.674 E.02579
G3 X127.579 Y116.094 I-9.767 J-1.678 E1.37041
G1 X128.432 Y116.095 E.02622
G3 X137.873 Y126.791 I-.438 J9.901 E.48933
M204 S10000
; WIPE_START
G1 F12000
G1 X137.762 Y127.674 E-.33822
G1 X137.595 Y128.498 E-.31965
G1 X137.516 Y128.755 E-.10212
; WIPE_END
G1 E-.04 F1800
G1 X133.46 Y122.29 Z15.8 F30000
G1 X131.905 Y119.813 Z15.8
G1 Z15.4
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4414
G3 X133.174 Y120.826 I-3.937 J6.231 E.05397
G1 X134.482 Y119.518 E.06139
G3 X137.063 Y124.613 I-6.525 J6.505 E.19264
G1 X135.307 Y126.369 E.08237
G2 X135.307 Y125.631 I-3.451 J-.369 E.02452
G1 X137.063 Y127.387 E.08237
G3 X134.482 Y132.482 I-9.106 J-1.41 E.19264
G1 X133.174 Y131.174 E.06139
G3 X131.905 Y132.187 I-5.206 J-5.218 E.05397
G1 X130.964 Y134.674 F30000
G1 F4414
G3 X129.386 Y135.062 I-3.028 J-8.909 E.05398
G1 X127.634 Y133.31 E.08215
G2 X128.367 Y133.309 I.36 J-3.426 E.02434
G1 X126.615 Y135.061 E.0822
G3 X125.036 Y134.674 I1.439 J-9.264 E.05399
G1 X121.81 Y129.907 F30000
G1 F4414
G2 X122.822 Y131.178 I6.864 J-4.431 E.05397
G1 X121.518 Y132.482 E.06122
G3 X118.937 Y127.387 I6.523 J-6.504 E.19265
G1 X120.684 Y125.64 E.08192
G1 X120.684 Y126.36 E.02386
G1 X118.937 Y124.613 E.08193
G3 X121.518 Y119.518 I9.106 J1.41 E.19264
G1 X122.822 Y120.822 E.06122
G2 X121.81 Y122.093 I5.852 J5.701 E.05397
G1 X125.036 Y117.326 F30000
G1 F4414
G3 X126.614 Y116.938 I3.028 J8.909 E.05398
G1 X128.367 Y118.691 E.08222
G2 X127.634 Y118.69 I-.372 J3.425 E.02434
G1 X129.386 Y116.938 E.08215
G3 X130.964 Y117.326 I-1.449 J9.297 E.05399
; CHANGE_LAYER
; Z_HEIGHT: 15.6
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F15476.087
G1 X129.386 Y116.938 E-.61765
G1 X129.121 Y117.203 E-.14235
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 78/250
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
G3 Z15.8 I-.773 J-.94 P1  F30000
G1 X121.495 Y123.477 Z15.8
G1 Z15.6
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4397
G1 X121.502 Y123.459 E.00064
G3 X127.074 Y119.084 I6.498 J2.539 E.24649
G1 X127.145 Y119.078 E.00237
G1 X127.814 Y119.025 E.02227
G3 X121.269 Y124.164 I.186 J6.973 E1.15817
G1 X121.476 Y123.534 E.02201
G1 X121.869 Y123.603 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4397
G3 X127.126 Y119.473 I6.131 J2.394 E.21546
G1 X127.176 Y119.469 E.00156
G1 X127.825 Y119.417 E.01998
G3 X121.847 Y123.659 I.175 J6.579 E1.03179
M204 S10000
; WIPE_START
G1 F12000
G1 X122.157 Y122.964 E-.28907
G1 X122.512 Y122.36 E-.26637
G1 X122.833 Y121.928 E-.20456
; WIPE_END
G1 E-.04 F1800
G1 X130.075 Y124.34 Z16 F30000
G1 X137.478 Y126.807 Z16
G1 Z15.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4397
G3 X126.79 Y116.555 I-9.484 J-.81 E1.42094
G3 X128.426 Y116.488 I1.2 J9.332 E.05438
G3 X137.483 Y126.747 I-.432 J9.508 E.50654
G1 X137.879 Y126.843 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4397
G1 X137.761 Y127.674 E.02579
G3 X126.741 Y116.165 I-9.767 J-1.678 E1.34451
G3 X128.444 Y116.096 I1.249 J9.713 E.05244
G3 X137.872 Y126.791 I-.449 J9.9 E.48897
M204 S10000
; WIPE_START
G1 F12000
G1 X137.761 Y127.674 E-.33807
G1 X137.595 Y128.498 E-.31965
G1 X137.516 Y128.756 E-.10228
; WIPE_END
G1 E-.04 F1800
G1 X131.905 Y132.187 Z16 F30000
G1 Z15.6
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4397
G2 X133.174 Y131.174 I-3.937 J-6.231 E.05397
G1 X134.482 Y132.482 E.06139
G2 X137.063 Y127.387 I-6.525 J-6.505 E.19264
G1 X135.307 Y125.631 E.08237
G3 X135.307 Y126.369 I-3.451 J.369 E.02452
G1 X137.063 Y124.613 E.08237
G2 X134.482 Y119.518 I-9.106 J1.41 E.19264
G1 X133.174 Y120.826 E.06139
G2 X131.905 Y119.813 I-5.206 J5.218 E.05397
G1 X130.964 Y117.326 F30000
G1 F4397
G2 X129.386 Y116.938 I-3.028 J8.909 E.05398
G1 X127.634 Y118.69 E.08215
G3 X128.367 Y118.691 I.36 J3.426 E.02434
G1 X126.614 Y116.938 E.08222
G2 X125.036 Y117.326 I1.45 J9.298 E.05399
G1 X121.81 Y122.093 F30000
G1 F4397
G3 X122.822 Y120.822 I6.864 J4.43 E.05397
G1 X121.518 Y119.518 E.06122
G2 X118.937 Y124.613 I6.525 J6.505 E.19264
G1 X120.684 Y126.36 E.08193
G1 X120.684 Y125.64 E.02386
G1 X118.937 Y127.387 E.08193
G2 X121.519 Y132.481 I9.092 J-1.405 E.19264
M73 P50 R13
G1 X122.822 Y131.178 E.06117
G3 X121.81 Y129.907 I5.852 J-5.701 E.05397
G1 X125.036 Y134.673 F30000
G1 F4397
G2 X126.614 Y135.062 I3.094 J-9.176 E.05398
G1 X128.367 Y133.309 E.08222
G3 X127.634 Y133.31 I-.372 J-3.425 E.02434
G1 X129.386 Y135.062 E.08215
G2 X130.964 Y134.674 I-1.45 J-9.298 E.05399
; CHANGE_LAYER
; Z_HEIGHT: 15.8
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F15476.087
G1 X129.386 Y135.062 E-.61765
G1 X129.121 Y134.797 E-.14235
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 79/250
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
G3 Z16 I1.009 J-.68 P1  F30000
G1 X121.495 Y123.477 Z16
G1 Z15.8
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4415
G1 X121.502 Y123.459 E.00064
G3 X127.074 Y119.084 I6.497 J2.538 E.24649
G1 X127.136 Y119.079 E.00206
G1 X127.814 Y119.025 E.02258
G3 X121.286 Y124.105 I.186 J6.973 E1.16016
G1 X121.476 Y123.534 E.01995
G1 X121.869 Y123.603 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4415
G3 X127.126 Y119.473 I6.131 J2.394 E.21547
G1 X127.167 Y119.47 E.00127
G1 X127.825 Y119.417 E.02027
G3 X121.847 Y123.658 I.175 J6.58 E1.03192
M204 S10000
; WIPE_START
G1 F12000
G1 X122.157 Y122.964 E-.28908
G1 X122.512 Y122.36 E-.26637
G1 X122.833 Y121.928 E-.20455
; WIPE_END
G1 E-.04 F1800
G1 X130.075 Y124.34 Z16.2 F30000
G1 X137.481 Y126.807 Z16.2
G1 Z15.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4415
G3 X127.596 Y116.486 I-9.485 J-.81 E1.44792
G1 X128.413 Y116.487 E.0271
G3 X137.486 Y126.747 I-.417 J9.51 E.50708
G1 X137.879 Y126.843 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4415
G1 X137.763 Y127.674 E.02579
G3 X125.886 Y135.686 I-9.771 J-1.675 E.49197
G3 X128.446 Y116.096 I2.114 J-9.686 E.90527
G3 X137.874 Y126.789 I-.453 J9.903 E.48884
M204 S10000
; WIPE_START
G1 F12000
G1 X137.763 Y127.674 E-.33885
G1 X137.595 Y128.498 E-.31967
G1 X137.517 Y128.754 E-.10147
; WIPE_END
G1 E-.04 F1800
G1 X133.459 Y122.289 Z16.2 F30000
G1 X131.905 Y119.813 Z16.2
G1 Z15.8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4415
G3 X133.174 Y120.826 I-3.937 J6.231 E.05397
G1 X134.482 Y119.518 E.06139
G3 X137.063 Y124.613 I-6.525 J6.505 E.19264
G1 X135.307 Y126.369 E.08237
G2 X135.307 Y125.631 I-3.451 J-.369 E.02452
G1 X137.063 Y127.387 E.08237
G3 X134.482 Y132.482 I-9.106 J-1.41 E.19264
G1 X133.174 Y131.174 E.06139
G3 X131.905 Y132.187 I-5.206 J-5.218 E.05397
G1 X130.964 Y134.674 F30000
G1 F4415
G3 X129.386 Y135.062 I-3.028 J-8.909 E.05399
G1 X127.634 Y133.31 E.08215
G2 X128.367 Y133.309 I.36 J-3.426 E.02434
G1 X126.614 Y135.062 E.08222
G3 X125.036 Y134.674 I1.45 J-9.298 E.05399
G1 X121.81 Y129.907 F30000
G1 F4415
G2 X122.822 Y131.178 I6.864 J-4.431 E.05397
G1 X121.518 Y132.482 E.06122
G3 X118.937 Y127.387 I6.525 J-6.505 E.19264
G1 X120.684 Y125.64 E.08193
G1 X120.684 Y126.36 E.02386
G1 X118.937 Y124.613 E.08193
G3 X121.518 Y119.518 I9.106 J1.41 E.19264
G1 X122.822 Y120.822 E.06122
G2 X121.81 Y122.093 I5.852 J5.701 E.05397
G1 X125.036 Y117.326 F30000
G1 F4415
G3 X126.614 Y116.938 I3.028 J8.91 E.05399
G1 X128.367 Y118.691 E.08222
G2 X127.634 Y118.69 I-.372 J3.425 E.02434
G1 X129.386 Y116.938 E.08215
G3 X130.964 Y117.326 I-1.45 J9.298 E.05398
; CHANGE_LAYER
; Z_HEIGHT: 16
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F15476.087
G1 X129.386 Y116.938 E-.61765
G1 X129.121 Y117.203 E-.14235
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 80/250
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
G3 Z16.2 I-.773 J-.94 P1  F30000
G1 X121.495 Y123.477 Z16.2
G1 Z16
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4396
G1 X121.509 Y123.462 E.00068
G3 X127.095 Y119.082 I6.497 J2.534 E.24706
G3 X128.557 Y119.044 I.907 J6.817 E.04859
G3 X121.282 Y124.146 I-.552 J6.951 E1.13385
G1 X121.477 Y123.534 E.02128
G1 X121.874 Y123.605 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4396
G3 X127.147 Y119.471 I6.131 J2.391 E.21598
G3 X128.525 Y119.436 I.856 J6.431 E.04246
G3 X121.853 Y123.661 I-.52 J6.56 E1.01016
M204 S10000
; WIPE_START
G1 F12000
G1 X122.157 Y122.964 E-.28898
G1 X122.512 Y122.36 E-.26637
G1 X122.834 Y121.927 E-.20465
; WIPE_END
G1 E-.04 F1800
G1 X130.075 Y124.34 Z16.4 F30000
G1 X137.478 Y126.807 Z16.4
G1 Z16
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4396
G3 X126.79 Y116.555 I-9.483 J-.811 E1.42082
G3 X128.424 Y116.488 I1.367 J13.415 E.05428
G3 X137.483 Y126.747 I-.429 J9.508 E.50662
G1 X137.879 Y126.843 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4396
G1 X137.763 Y127.674 E.02579
G3 X125.911 Y116.308 I-9.769 J-1.676 E1.31894
G3 X128.458 Y116.097 I2.078 J9.626 E.07873
G3 X137.874 Y126.79 I-.464 J9.901 E.4885
M204 S10000
; WIPE_START
G1 F12000
G1 X137.763 Y127.674 E-.33861
G1 X137.595 Y128.498 E-.31967
G1 X137.517 Y128.754 E-.10172
; WIPE_END
G1 E-.04 F1800
G1 X131.905 Y132.187 Z16.4 F30000
G1 Z16
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4396
G2 X133.174 Y131.174 I-3.937 J-6.231 E.05397
G1 X134.482 Y132.482 E.06139
G2 X137.063 Y127.387 I-6.525 J-6.505 E.19264
G1 X135.307 Y125.631 E.08237
G3 X135.307 Y126.369 I-3.451 J.369 E.02452
G1 X137.063 Y124.613 E.08237
G2 X134.482 Y119.518 I-9.106 J1.41 E.19264
G1 X133.174 Y120.826 E.06139
G2 X131.905 Y119.813 I-5.206 J5.218 E.05397
G1 X130.964 Y117.326 F30000
G1 F4396
G2 X129.386 Y116.938 I-3.028 J8.91 E.05399
G1 X127.634 Y118.69 E.08215
G3 X128.367 Y118.691 I.36 J3.426 E.02434
G1 X126.614 Y116.938 E.08222
G2 X125.036 Y117.326 I1.45 J9.298 E.05399
G1 X121.81 Y122.093 F30000
G1 F4396
G3 X122.822 Y120.822 I6.864 J4.431 E.05397
G1 X121.518 Y119.518 E.06122
G2 X118.937 Y124.613 I6.525 J6.505 E.19264
G1 X120.684 Y126.36 E.08193
G1 X120.684 Y125.64 E.02386
G1 X118.937 Y127.387 E.08193
G2 X121.518 Y132.482 I9.106 J-1.41 E.19264
G1 X122.822 Y131.178 E.06122
G3 X121.811 Y129.907 I5.813 J-5.667 E.05397
G1 X125.036 Y134.674 F30000
G1 F4396
G2 X126.614 Y135.062 I3.028 J-8.91 E.05399
G1 X128.367 Y133.309 E.08222
G3 X127.634 Y133.31 I-.372 J-3.425 E.02434
G1 X129.386 Y135.062 E.08215
G2 X130.964 Y134.674 I-1.45 J-9.298 E.05399
; CHANGE_LAYER
; Z_HEIGHT: 16.2
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F15476.087
G1 X129.386 Y135.062 E-.61765
G1 X129.121 Y134.797 E-.14235
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 81/250
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
G3 Z16.4 I1.009 J-.68 P1  F30000
G1 X121.495 Y123.477 Z16.4
G1 Z16.2
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4415
G1 X121.507 Y123.461 E.00066
G3 X127.085 Y119.083 I6.496 J2.534 E.24678
G3 X128.557 Y119.044 I.916 J6.863 E.04892
G3 X121.277 Y124.155 I-.554 J6.951 E1.13337
G1 X121.477 Y123.534 E.02161
G1 X121.874 Y123.605 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4415
G3 X127.137 Y119.472 I6.131 J2.391 E.2157
G1 X127.825 Y119.417 E.02119
G3 X121.852 Y123.661 I.181 J6.579 E1.03182
M204 S10000
; WIPE_START
G1 F12000
G1 X122.157 Y122.964 E-.28899
G1 X122.512 Y122.36 E-.26637
G1 X122.834 Y121.927 E-.20464
; WIPE_END
G1 E-.04 F1800
G1 X130.075 Y124.34 Z16.6 F30000
G1 X137.48 Y126.807 Z16.6
G1 Z16.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4415
G3 X125.994 Y116.691 I-9.485 J-.809 E1.39429
G3 X128.436 Y116.489 I1.996 J9.252 E.08151
G3 X137.485 Y126.747 I-.441 J9.509 E.50626
G1 X137.879 Y126.843 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4415
G1 X137.763 Y127.674 E.02579
G3 X125.097 Y116.52 I-9.769 J-1.676 E1.29311
G3 X128.469 Y116.098 I2.97 J10.062 E.10489
G3 X137.874 Y126.79 I-.475 J9.9 E.48814
M204 S10000
; WIPE_START
G1 F12000
G1 X137.763 Y127.674 E-.33875
G1 X137.595 Y128.498 E-.31967
G1 X137.517 Y128.754 E-.10158
; WIPE_END
G1 E-.04 F1800
G1 X133.459 Y122.289 Z16.6 F30000
G1 X131.905 Y119.813 Z16.6
G1 Z16.2
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4415
G3 X133.174 Y120.826 I-3.937 J6.231 E.05397
G1 X134.482 Y119.518 E.06139
G3 X137.063 Y124.613 I-6.525 J6.505 E.19264
G1 X135.307 Y126.369 E.08237
G2 X135.307 Y125.631 I-3.451 J-.369 E.02452
G1 X137.063 Y127.387 E.08237
G3 X134.482 Y132.482 I-9.106 J-1.41 E.19264
M73 P50 R12
G1 X133.174 Y131.174 E.06139
G3 X131.905 Y132.187 I-5.206 J-5.218 E.05397
G1 X130.964 Y134.674 F30000
G1 F4415
G3 X129.386 Y135.062 I-3.028 J-8.909 E.05399
G1 X127.634 Y133.31 E.08215
G2 X128.367 Y133.309 I.36 J-3.426 E.02434
G1 X126.614 Y135.062 E.08222
G3 X125.036 Y134.674 I1.449 J-9.297 E.05399
G1 X121.81 Y129.907 F30000
G1 F4415
G2 X122.822 Y131.178 I6.842 J-4.412 E.05397
G1 X121.518 Y132.482 E.06122
G3 X118.937 Y127.387 I6.525 J-6.505 E.19264
G1 X120.684 Y125.64 E.08193
G1 X120.684 Y126.36 E.02386
G1 X118.937 Y124.613 E.08193
G3 X121.518 Y119.518 I9.105 J1.41 E.19264
G1 X122.822 Y120.822 E.06122
G2 X121.81 Y122.093 I5.852 J5.701 E.05397
G1 X125.036 Y117.326 F30000
G1 F4415
G3 X126.614 Y116.938 I3.028 J8.909 E.05399
G1 X128.367 Y118.691 E.08222
G2 X127.634 Y118.69 I-.372 J3.425 E.02434
G1 X129.386 Y116.938 E.08215
G3 X130.964 Y117.326 I-1.45 J9.298 E.05399
; CHANGE_LAYER
; Z_HEIGHT: 16.4
; LAYER_HEIGHT: 0.199999
; WIPE_START
G1 F15476.087
G1 X129.386 Y116.938 E-.61766
G1 X129.121 Y117.203 E-.14235
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 82/250
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
G3 Z16.6 I-.773 J-.94 P1  F30000
G1 X121.495 Y123.477 Z16.6
G1 Z16.4
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4397
G1 X121.501 Y123.459 E.00064
G3 X127.074 Y119.084 I6.499 J2.541 E.2465
G1 X127.814 Y119.025 E.02464
G3 X121.268 Y124.164 I.186 J6.975 E1.15855
G1 X121.476 Y123.534 E.02201
G1 X121.867 Y123.602 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4397
G3 X127.126 Y119.473 I6.133 J2.398 E.21549
G1 X127.825 Y119.417 E.02154
G3 X121.845 Y123.658 I.175 J6.583 E1.03251
M204 S10000
; WIPE_START
G1 F12000
G1 X122.157 Y122.964 E-.28911
G1 X122.512 Y122.36 E-.26637
G1 X122.833 Y121.928 E-.20452
; WIPE_END
G1 E-.04 F1800
G1 X130.074 Y124.34 Z16.8 F30000
G1 X137.477 Y126.807 Z16.8
G1 Z16.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4397
G3 X125.994 Y116.691 I-9.484 J-.809 E1.39417
G3 X128.447 Y116.49 I1.993 J9.233 E.08188
G3 X137.482 Y126.747 I-.454 J9.507 E.50578
G1 X137.879 Y126.843 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4397
G1 X137.77 Y127.675 E.0258
G3 X122.854 Y117.528 I-9.77 J-1.675 E1.21732
G3 X128.48 Y116.099 I5.133 J8.419 E.18106
G3 X137.881 Y126.784 I-.48 J9.901 E.48778
M204 S10000
; WIPE_START
M73 P51 R12
G1 F12000
G1 X137.77 Y127.675 E-.34135
G1 X137.595 Y128.498 E-.31976
G1 X137.519 Y128.747 E-.09889
; WIPE_END
G1 E-.04 F1800
G1 X131.905 Y132.187 Z16.8 F30000
G1 Z16.4
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4397
G2 X133.174 Y131.174 I-3.937 J-6.231 E.05397
G1 X134.482 Y132.482 E.06139
G2 X137.063 Y127.387 I-6.525 J-6.505 E.19264
G1 X135.307 Y125.631 E.08237
G3 X135.307 Y126.369 I-3.451 J.369 E.02452
G1 X137.063 Y124.613 E.08237
G2 X134.482 Y119.518 I-9.106 J1.41 E.19264
G1 X133.174 Y120.826 E.06139
G2 X131.905 Y119.813 I-5.206 J5.218 E.05397
G1 X130.964 Y117.326 F30000
G1 F4397
G2 X129.386 Y116.938 I-3.028 J8.91 E.05399
G1 X127.634 Y118.69 E.08215
G3 X128.367 Y118.691 I.36 J3.426 E.02434
G1 X126.614 Y116.938 E.08222
G2 X125.036 Y117.326 I1.45 J9.298 E.05399
G1 X121.81 Y122.093 F30000
G1 F4397
G3 X122.822 Y120.822 I6.864 J4.431 E.05397
G1 X121.518 Y119.518 E.06122
G2 X118.937 Y124.613 I6.525 J6.505 E.19264
G1 X120.684 Y126.36 E.08193
G1 X120.684 Y125.64 E.02386
G1 X118.937 Y127.387 E.08193
G2 X121.518 Y132.482 I9.106 J-1.41 E.19264
G1 X122.822 Y131.178 E.06122
G3 X121.81 Y129.907 I5.852 J-5.701 E.05397
G1 X125.036 Y134.674 F30000
G1 F4397
G2 X126.615 Y135.061 I2.993 J-8.794 E.05399
G1 X128.367 Y133.309 E.08217
G3 X127.634 Y133.31 I-.372 J-3.425 E.02434
G1 X129.386 Y135.062 E.08215
G2 X130.964 Y134.674 I-1.45 J-9.298 E.05399
; CHANGE_LAYER
; Z_HEIGHT: 16.6
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F15476.087
G1 X129.386 Y135.062 E-.61765
G1 X129.121 Y134.797 E-.14235
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 83/250
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
G3 Z16.8 I1.011 J-.678 P1  F30000
G1 X121.506 Y123.449 Z16.8
G1 Z16.6
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4433
G1 X121.807 Y122.782 E.02427
G3 X127.074 Y119.084 I6.189 J3.215 E.2219
G1 X127.806 Y119.025 E.02436
G3 X121.482 Y123.504 I.19 J6.972 E1.18103
G1 X121.868 Y123.602 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4433
G1 X122.155 Y122.963 E.02154
G3 X127.126 Y119.473 I5.841 J3.034 E.19398
G1 X127.817 Y119.418 E.02129
G3 X121.844 Y123.657 I.179 J6.58 E1.03207
M204 S10000
; WIPE_START
G1 F12000
G1 X122.155 Y122.963 E-.28909
G1 X122.512 Y122.36 E-.26645
G1 X122.833 Y121.928 E-.20446
; WIPE_END
G1 E-.04 F1800
G1 X130.074 Y124.34 Z17 F30000
G1 X137.478 Y126.807 Z17
G1 Z16.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4433
G3 X125.212 Y116.895 I-9.485 J-.808 E1.36753
G3 X128.458 Y116.491 I2.849 J9.646 E.10902
G3 X137.483 Y126.747 I-.465 J9.508 E.50543
G1 X137.879 Y126.843 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4433
G1 X137.762 Y127.674 E.02579
G3 X124.303 Y116.8 I-9.768 J-1.675 E1.26718
G3 X128.492 Y116.1 I3.684 J9.165 E.13151
G3 X137.872 Y126.791 I-.498 J9.898 E.48742
M204 S10000
; WIPE_START
G1 F12000
G1 X137.762 Y127.674 E-.33811
G1 X137.595 Y128.498 E-.31965
G1 X137.516 Y128.756 E-.10223
; WIPE_END
G1 E-.04 F1800
G1 X133.46 Y122.29 Z17 F30000
G1 X131.905 Y119.813 Z17
G1 Z16.6
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4433
G3 X133.174 Y120.826 I-3.937 J6.231 E.05397
G1 X134.482 Y119.518 E.06139
G3 X137.063 Y124.613 I-6.525 J6.505 E.19264
G1 X135.307 Y126.369 E.08237
G2 X135.307 Y125.631 I-3.451 J-.369 E.02452
G1 X137.063 Y127.387 E.08237
G3 X134.482 Y132.482 I-9.105 J-1.409 E.19264
G1 X133.174 Y131.174 E.06139
G3 X131.905 Y132.187 I-5.206 J-5.218 E.05397
G1 X130.964 Y134.674 F30000
G1 F4433
G3 X129.386 Y135.062 I-3.028 J-8.91 E.05399
G1 X127.634 Y133.31 E.08215
G2 X128.367 Y133.309 I.36 J-3.426 E.02434
G1 X126.614 Y135.062 E.08222
G3 X125.036 Y134.674 I1.45 J-9.298 E.05398
G1 X121.81 Y129.907 F30000
G1 F4433
G2 X122.823 Y131.177 I6.816 J-4.397 E.05397
G1 X121.518 Y132.482 E.06124
G3 X118.937 Y127.387 I6.525 J-6.505 E.19264
G1 X120.684 Y125.64 E.08193
G1 X120.684 Y126.36 E.02386
G1 X118.937 Y124.613 E.08193
G3 X121.518 Y119.518 I9.106 J1.41 E.19264
G1 X122.822 Y120.822 E.06122
G2 X121.81 Y122.093 I5.852 J5.701 E.05397
G1 X125.036 Y117.326 F30000
G1 F4433
G3 X126.614 Y116.938 I3.028 J8.91 E.05399
G1 X128.367 Y118.691 E.08223
G2 X127.634 Y118.69 I-.374 J3.466 E.02435
G1 X129.386 Y116.938 E.08215
G3 X130.964 Y117.326 I-1.45 J9.298 E.05399
; CHANGE_LAYER
; Z_HEIGHT: 16.8
; LAYER_HEIGHT: 0.199999
; WIPE_START
G1 F15476.087
G1 X129.386 Y116.938 E-.61765
G1 X129.121 Y117.203 E-.14235
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 84/250
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
G3 Z17 I-.774 J-.939 P1  F30000
G1 X121.49 Y123.494 Z17
G1 Z16.8
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4396
G1 X121.498 Y123.477 E.00063
G3 X127.074 Y119.084 I6.502 J2.518 E.24706
G3 X128.556 Y119.044 I.931 J7.091 E.04927
G3 X121.271 Y124.165 I-.556 J6.951 E1.13297
G1 X121.471 Y123.551 E.02141
G1 X121.868 Y123.603 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4396
G1 X122.159 Y122.965 E.02153
G3 X127.126 Y119.473 I5.841 J3.03 E.19392
G3 X128.525 Y119.436 I.879 J6.694 E.04309
G3 X121.848 Y123.659 I-.525 J6.56 E1.0101
M204 S10000
; WIPE_START
G1 F12000
G1 X122.159 Y122.965 E-.28901
G1 X122.512 Y122.36 E-.26643
G1 X122.833 Y121.928 E-.20456
; WIPE_END
G1 E-.04 F1800
G1 X130.074 Y124.34 Z17.2 F30000
G1 X137.477 Y126.807 Z17.2
G1 Z16.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4396
G3 X124.45 Y117.164 I-9.483 J-.809 E1.34043
G3 X128.47 Y116.492 I3.539 J8.803 E.13627
G3 X137.481 Y126.747 I-.476 J9.506 E.505
G1 X137.879 Y126.843 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4396
G1 X137.769 Y127.675 E.0258
G3 X125.831 Y135.671 I-9.769 J-1.675 E.49386
G3 X128.503 Y116.101 I2.175 J-9.671 E.90474
G3 X137.881 Y126.784 I-.503 J9.899 E.48706
M204 S10000
; WIPE_START
G1 F12000
G1 X137.769 Y127.675 E-.34113
G1 X137.595 Y128.498 E-.31975
G1 X137.519 Y128.748 E-.09912
; WIPE_END
G1 E-.04 F1800
G1 X131.905 Y132.187 Z17.2 F30000
G1 Z16.8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4396
G2 X133.174 Y131.174 I-3.937 J-6.231 E.05397
G1 X134.482 Y132.482 E.06139
G2 X137.063 Y127.387 I-6.525 J-6.505 E.19264
G1 X135.307 Y125.631 E.08237
G3 X135.307 Y126.369 I-3.451 J.369 E.02452
G1 X137.063 Y124.613 E.08237
G2 X134.482 Y119.518 I-9.106 J1.41 E.19264
G1 X133.174 Y120.826 E.06139
G2 X131.905 Y119.813 I-5.206 J5.218 E.05397
G1 X130.964 Y117.326 F30000
G1 F4396
G2 X129.386 Y116.938 I-3.028 J8.909 E.05398
G1 X127.634 Y118.69 E.08215
G3 X128.367 Y118.691 I.358 J3.517 E.02435
G1 X126.614 Y116.938 E.08224
G2 X125.036 Y117.326 I1.45 J9.297 E.05398
G1 X121.81 Y122.093 F30000
G1 F4396
G3 X122.822 Y120.822 I6.864 J4.431 E.05397
G1 X121.518 Y119.518 E.06122
G2 X118.937 Y124.613 I6.525 J6.505 E.19264
G1 X120.684 Y126.36 E.08193
G1 X120.684 Y125.64 E.02386
G1 X118.937 Y127.387 E.08193
G2 X121.518 Y132.482 I9.106 J-1.41 E.19264
G1 X122.822 Y131.178 E.06122
G3 X121.81 Y129.907 I5.852 J-5.701 E.05397
G1 X125.036 Y134.674 F30000
G1 F4396
G2 X126.614 Y135.062 I3.028 J-8.909 E.05399
G1 X128.367 Y133.309 E.08222
G3 X127.634 Y133.31 I-.372 J-3.425 E.02434
G1 X129.386 Y135.062 E.08215
G2 X130.964 Y134.674 I-1.45 J-9.298 E.05399
; CHANGE_LAYER
; Z_HEIGHT: 17
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F15476.087
G1 X129.386 Y135.062 E-.61765
G1 X129.121 Y134.797 E-.14235
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 85/250
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
G3 Z17.2 I1.009 J-.68 P1  F30000
G1 X121.495 Y123.477 Z17.2
G1 Z17
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4414
G1 X121.51 Y123.462 E.00069
G3 X127.756 Y119.029 I6.496 J2.537 E.26896
G3 X131.381 Y119.896 I.255 J6.948 E.12519
G3 X121.277 Y124.167 I-3.375 J6.103 E1.03479
G1 X121.477 Y123.534 E.02199
G1 X121.875 Y123.605 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4414
G3 X127.787 Y119.42 I6.131 J2.392 E.23567
G3 X129.901 Y119.695 I.226 J6.528 E.06581
G3 X121.854 Y123.661 I-1.895 J6.302 E.96727
M204 S10000
; WIPE_START
G1 F12000
G1 X122.157 Y122.964 E-.28897
G1 X122.512 Y122.36 E-.26637
G1 X122.834 Y121.927 E-.20466
; WIPE_END
G1 E-.04 F1800
G1 X130.075 Y124.34 Z17.4 F30000
G1 X137.477 Y126.807 Z17.4
G1 Z17
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4414
G3 X124.45 Y117.164 I-9.484 J-.808 E1.3406
G3 X128.481 Y116.493 I3.537 J8.798 E.13665
G3 X137.482 Y126.747 I-.488 J9.506 E.5046
G1 X137.879 Y126.842 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4414
G1 X137.769 Y127.675 E.02581
G3 X137.313 Y129.39 I-9.769 J-1.675 E.0546
G3 X125.82 Y135.669 I-9.324 J-3.409 E.43944
G3 X128.514 Y116.102 I2.18 J-9.669 E.90504
G3 X137.88 Y126.785 I-.514 J9.898 E.4867
M204 S10000
; WIPE_START
G1 F12000
G1 X137.769 Y127.675 E-.34103
G1 X137.595 Y128.498 E-.31975
G1 X137.516 Y128.747 E-.09923
; WIPE_END
G1 E-.04 F1800
G1 X133.457 Y122.284 Z17.4 F30000
G1 X131.905 Y119.813 Z17.4
G1 Z17
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4414
G3 X133.174 Y120.826 I-3.937 J6.231 E.05397
G1 X134.482 Y119.518 E.06139
G3 X137.063 Y124.613 I-6.525 J6.505 E.19264
G1 X135.307 Y126.369 E.08237
G2 X135.307 Y125.631 I-3.451 J-.369 E.02452
G1 X137.063 Y127.387 E.08237
G3 X134.482 Y132.482 I-9.106 J-1.41 E.19264
G1 X133.174 Y131.174 E.06139
M73 P52 R12
G3 X131.905 Y132.187 I-5.206 J-5.218 E.05397
G1 X130.964 Y134.674 F30000
G1 F4414
G3 X129.386 Y135.062 I-3.028 J-8.91 E.05399
G1 X127.634 Y133.31 E.08215
G2 X128.367 Y133.309 I.36 J-3.426 E.02434
G1 X126.614 Y135.062 E.08222
G3 X125.036 Y134.674 I1.449 J-9.297 E.05399
G1 X121.81 Y129.907 F30000
G1 F4414
G2 X122.822 Y131.178 I6.864 J-4.431 E.05397
G1 X121.518 Y132.482 E.06122
G3 X118.937 Y127.387 I6.525 J-6.505 E.19264
G1 X120.684 Y125.64 E.08193
G1 X120.684 Y126.36 E.02386
G1 X118.937 Y124.613 E.08193
G3 X121.518 Y119.518 I9.106 J1.41 E.19264
G1 X122.822 Y120.822 E.06122
G2 X121.81 Y122.093 I5.852 J5.701 E.05397
G1 X125.036 Y117.326 F30000
G1 F4414
G3 X126.614 Y116.938 I3.028 J8.909 E.05399
G1 X128.368 Y118.692 E.08229
G2 X127.634 Y118.69 I-.382 J3.705 E.02439
G1 X129.386 Y116.938 E.08215
G3 X130.964 Y117.326 I-1.45 J9.298 E.05398
; CHANGE_LAYER
; Z_HEIGHT: 17.2
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F15476.087
G1 X129.386 Y116.938 E-.61765
G1 X129.121 Y117.203 E-.14235
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 86/250
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
G3 Z17.4 I-.773 J-.94 P1  F30000
G1 X121.495 Y123.477 Z17.4
G1 Z17.2
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4396
G1 X121.509 Y123.462 E.00069
G3 X127.746 Y119.03 I6.496 J2.537 E.26865
G3 X132.011 Y120.29 I.214 J7.125 E.15002
G3 X121.277 Y124.166 I-4.005 J5.709 E1.0102
G1 X121.477 Y123.534 E.02199
G1 X121.875 Y123.605 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4396
G3 X127.777 Y119.421 I6.131 J2.394 E.23538
G3 X130.561 Y119.933 I.16 J6.95 E.08757
G3 X121.853 Y123.661 I-2.555 J6.066 E.94587
M204 S10000
; WIPE_START
G1 F12000
G1 X122.157 Y122.964 E-.28898
G1 X122.512 Y122.36 E-.26637
G1 X122.834 Y121.927 E-.20465
; WIPE_END
G1 E-.04 F1800
G1 X130.075 Y124.34 Z17.6 F30000
G1 X137.478 Y126.807 Z17.6
G1 Z17.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4396
G3 X123.713 Y117.497 I-9.485 J-.807 E1.31389
G3 X128.492 Y116.494 I4.323 J8.708 E.16375
G3 X137.483 Y126.747 I-.499 J9.506 E.50424
G1 X137.879 Y126.842 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4396
G1 X137.768 Y127.675 E.02582
G3 X122.893 Y117.506 I-9.768 J-1.675 E1.21853
G3 X128.526 Y116.103 I5.084 J8.405 E.18105
G3 X137.88 Y126.785 I-.526 J9.897 E.48634
M204 S10000
; WIPE_START
G1 F12000
G1 X137.768 Y127.675 E-.34091
G1 X137.595 Y128.498 E-.31974
G1 X137.518 Y128.748 E-.09935
; WIPE_END
G1 E-.04 F1800
G1 X131.905 Y132.187 Z17.6 F30000
G1 Z17.2
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4396
G2 X133.174 Y131.174 I-3.937 J-6.231 E.05397
G1 X134.482 Y132.482 E.06139
G2 X137.063 Y127.387 I-6.525 J-6.505 E.19264
G1 X135.307 Y125.631 E.08237
G3 X135.307 Y126.369 I-3.451 J.369 E.02452
G1 X137.063 Y124.613 E.08237
G2 X134.482 Y119.518 I-9.106 J1.41 E.19264
G1 X133.174 Y120.826 E.06139
G2 X131.905 Y119.813 I-5.206 J5.218 E.05397
G1 X130.964 Y117.326 F30000
G1 F4396
G2 X129.386 Y116.938 I-3.028 J8.91 E.05399
G1 X127.634 Y118.69 E.08215
G3 X128.369 Y118.693 I.351 J3.753 E.02439
G1 X126.614 Y116.938 E.0823
G2 X125.036 Y117.326 I1.45 J9.298 E.05399
G1 X121.81 Y122.093 F30000
G1 F4396
G3 X122.822 Y120.822 I6.864 J4.431 E.05397
G1 X121.518 Y119.518 E.06122
G2 X118.937 Y124.613 I6.525 J6.505 E.19264
G1 X120.684 Y126.36 E.08193
G1 X120.684 Y125.64 E.02386
G1 X118.937 Y127.387 E.08193
G2 X121.518 Y132.482 I9.106 J-1.41 E.19264
G1 X122.822 Y131.178 E.06122
G3 X121.81 Y129.907 I5.852 J-5.701 E.05397
G1 X125.036 Y134.674 F30000
G1 F4396
G2 X126.614 Y135.062 I3.028 J-8.91 E.05399
G1 X128.367 Y133.309 E.08222
G3 X127.634 Y133.31 I-.372 J-3.425 E.02434
G1 X129.386 Y135.062 E.08215
G2 X130.964 Y134.674 I-1.45 J-9.298 E.05398
; CHANGE_LAYER
; Z_HEIGHT: 17.4
; LAYER_HEIGHT: 0.199999
; WIPE_START
G1 F15476.087
G1 X129.386 Y135.062 E-.61765
G1 X129.121 Y134.797 E-.14235
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 87/250
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
G3 Z17.6 I1.009 J-.68 P1  F30000
G1 X121.495 Y123.477 Z17.6
G1 Z17.4
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4414
G1 X121.511 Y123.463 E.00071
G3 X127.737 Y119.031 I6.496 J2.536 E.2683
G3 X132.011 Y120.29 I.225 J7.119 E.15033
G3 X121.278 Y124.167 I-4.004 J5.709 E1.01008
G1 X121.477 Y123.534 E.02199
G1 X121.876 Y123.605 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4414
G3 X127.768 Y119.422 I6.13 J2.392 E.23506
G3 X131.191 Y120.239 I.243 J6.557 E.10948
G3 X121.854 Y123.661 I-3.185 J5.758 E.92402
M204 S10000
; WIPE_START
G1 F12000
G1 X122.157 Y122.964 E-.28896
G1 X122.512 Y122.36 E-.26637
G1 X122.834 Y121.927 E-.20467
; WIPE_END
G1 E-.04 F1800
G1 X130.075 Y124.34 Z17.8 F30000
G1 X137.476 Y126.807 Z17.8
G1 Z17.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4414
G3 X123.713 Y117.497 I-9.484 J-.808 E1.3138
G3 X128.504 Y116.495 I4.321 J8.7 E.16413
G3 X137.481 Y126.747 I-.511 J9.504 E.50381
G1 X137.879 Y126.842 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4414
G1 X137.762 Y127.674 E.02582
G3 X122.104 Y118.029 I-9.769 J-1.674 E1.18968
G1 X122.903 Y117.5 E.02943
G3 X128.537 Y116.104 I5.073 J8.403 E.18105
G3 X137.873 Y126.79 I-.543 J9.896 E.48597
M204 S10000
; WIPE_START
G1 F12000
G1 X137.762 Y127.674 E-.33843
G1 X137.595 Y128.498 E-.31966
G1 X137.516 Y128.755 E-.1019
; WIPE_END
G1 E-.04 F1800
G1 X133.459 Y122.29 Z17.8 F30000
G1 X131.905 Y119.813 Z17.8
G1 Z17.4
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4414
G3 X133.174 Y120.826 I-3.937 J6.231 E.05397
G1 X134.482 Y119.518 E.06139
G3 X137.063 Y124.613 I-6.525 J6.505 E.19264
G1 X135.307 Y126.369 E.08237
G2 X135.307 Y125.631 I-3.451 J-.369 E.02452
G1 X137.063 Y127.387 E.08237
G3 X134.482 Y132.482 I-9.106 J-1.41 E.19264
G1 X133.174 Y131.174 E.06139
G3 X131.905 Y132.187 I-5.206 J-5.218 E.05397
G1 X130.964 Y134.674 F30000
G1 F4414
G3 X129.386 Y135.062 I-3.028 J-8.909 E.05399
G1 X127.634 Y133.31 E.08215
G2 X128.367 Y133.309 I.36 J-3.426 E.02434
G1 X126.614 Y135.062 E.08222
G3 X125.036 Y134.674 I1.45 J-9.298 E.05399
G1 X121.81 Y129.907 F30000
G1 F4414
G2 X122.822 Y131.178 I6.864 J-4.431 E.05397
G1 X121.518 Y132.482 E.06122
G3 X118.937 Y127.387 I6.525 J-6.505 E.19264
G1 X120.684 Y125.64 E.08193
G1 X120.684 Y126.36 E.02386
G1 X118.937 Y124.613 E.08193
G3 X121.518 Y119.518 I9.106 J1.41 E.19264
G1 X122.822 Y120.822 E.06122
G2 X121.81 Y122.093 I5.852 J5.701 E.05397
G1 X125.036 Y117.326 F30000
G1 F4414
G3 X126.614 Y116.938 I3.028 J8.909 E.05398
G1 X128.369 Y118.693 E.08231
G2 X127.634 Y118.69 I-.384 J3.795 E.0244
G1 X129.386 Y116.938 E.08215
G3 X130.964 Y117.326 I-1.45 J9.298 E.05399
; CHANGE_LAYER
; Z_HEIGHT: 17.6
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F15476.087
G1 X129.386 Y116.938 E-.61765
G1 X129.121 Y117.203 E-.14235
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 88/250
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
G3 Z17.8 I-.771 J-.941 P1  F30000
G1 X121.509 Y123.441 Z17.8
G1 Z17.6
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4419
G1 X121.816 Y122.787 E.02398
G3 X127.727 Y119.032 I6.19 J3.213 E.24337
G3 X132.595 Y120.749 I.283 J6.955 E.17542
G3 X121.496 Y123.499 I-4.589 J5.251 E1.00889
G1 X121.876 Y123.605 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4419
G3 X127.758 Y119.422 I6.131 J2.394 E.23476
G3 X131.191 Y120.239 I.254 J6.553 E.10977
G3 X121.854 Y123.661 I-3.185 J5.76 E.92426
M204 S10000
; WIPE_START
G1 F12000
G1 X122.157 Y122.964 E-.28897
G1 X122.512 Y122.36 E-.26637
G1 X122.834 Y121.927 E-.20466
; WIPE_END
G1 E-.04 F1800
G1 X130.075 Y124.34 Z18 F30000
G1 X137.477 Y126.807 Z18
G1 Z17.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4419
G3 X123.007 Y117.891 I-9.484 J-.807 E1.28709
G3 X128.515 Y116.496 I4.98 J8.086 E.19141
G3 X137.482 Y126.747 I-.522 J9.504 E.50345
G1 X137.879 Y126.841 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4419
G1 X137.768 Y127.675 E.02584
G3 X125.787 Y135.66 I-9.768 J-1.675 E.49519
G3 X128.548 Y116.105 I2.217 J-9.659 E.90469
G3 X137.879 Y126.785 I-.548 J9.895 E.48562
M204 S10000
; WIPE_START
G1 F12000
G1 X137.768 Y127.675 E-.34068
G1 X137.595 Y128.498 E-.31973
G1 X137.518 Y128.749 E-.09959
; WIPE_END
G1 E-.04 F1800
G1 X131.905 Y132.187 Z18 F30000
G1 Z17.6
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4419
G2 X133.174 Y131.174 I-3.937 J-6.231 E.05397
G1 X134.482 Y132.482 E.06139
G2 X137.063 Y127.387 I-6.525 J-6.505 E.19264
G1 X135.307 Y125.631 E.08237
G3 X135.307 Y126.369 I-3.451 J.369 E.02452
G1 X137.063 Y124.613 E.08237
G2 X134.482 Y119.518 I-9.106 J1.41 E.19264
G1 X133.174 Y120.826 E.06139
G3 X134.189 Y122.094 I-5.326 J5.303 E.05397
G1 X130.964 Y117.326 F30000
G1 F4419
G2 X129.386 Y116.938 I-3.028 J8.909 E.05399
G1 X127.634 Y118.69 E.08215
G3 X128.369 Y118.693 I.349 J3.844 E.0244
G1 X126.614 Y116.938 E.08232
G2 X125.036 Y117.326 I1.45 J9.298 E.05399
G1 X121.81 Y122.093 F30000
G1 F4419
G3 X122.822 Y120.822 I6.864 J4.431 E.05397
G1 X121.518 Y119.518 E.06122
G2 X118.937 Y124.613 I6.525 J6.505 E.19264
G1 X120.684 Y126.36 E.08193
G1 X120.684 Y125.64 E.02386
G1 X118.937 Y127.387 E.08193
G2 X121.518 Y132.482 I9.106 J-1.41 E.19264
G1 X122.822 Y131.178 E.06122
G3 X121.81 Y129.907 I5.852 J-5.701 E.05397
G1 X125.036 Y134.674 F30000
G1 F4419
G2 X126.614 Y135.062 I3.028 J-8.909 E.05399
G1 X128.367 Y133.309 E.08222
G3 X127.634 Y133.31 I-.372 J-3.425 E.02434
G1 X129.386 Y135.062 E.08215
G2 X130.964 Y134.674 I-1.45 J-9.298 E.05399
; CHANGE_LAYER
; Z_HEIGHT: 17.8
; LAYER_HEIGHT: 0.199999
; WIPE_START
G1 F15476.087
G1 X129.386 Y135.062 E-.61765
G1 X129.121 Y134.797 E-.14235
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 89/250
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
G3 Z18 I1.009 J-.68 P1  F30000
G1 X121.495 Y123.477 Z18
G1 Z17.8
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4406
G1 X121.511 Y123.463 E.00071
G3 X127.718 Y119.032 I6.496 J2.537 E.26764
G3 X132.595 Y120.749 I.294 J6.953 E.17573
G3 X121.278 Y124.167 I-4.589 J5.251 E.98546
G1 X121.477 Y123.534 E.02199
G1 X121.875 Y123.605 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4406
G3 X127.749 Y119.423 I6.131 J2.394 E.23447
G3 X131.785 Y120.611 I.216 J6.717 E.13149
G3 X121.854 Y123.661 I-3.779 J5.388 E.90278
M204 S10000
; WIPE_START
G1 F12000
G1 X122.157 Y122.964 E-.28897
G1 X122.512 Y122.36 E-.26637
G1 X122.834 Y121.927 E-.20466
; WIPE_END
G1 E-.04 F1800
G1 X130.075 Y124.34 Z18.2 F30000
G1 X137.478 Y126.807 Z18.2
G1 Z17.8
M73 P53 R12
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4406
G3 X122.338 Y118.344 I-9.485 J-.806 E1.26032
G3 X128.526 Y116.497 I5.686 J7.759 E.21849
G3 X137.483 Y126.747 I-.533 J9.504 E.50308
G1 X137.879 Y126.841 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4406
G1 X137.767 Y127.675 E.02585
G3 X125.776 Y135.657 I-9.767 J-1.675 E.49552
G3 X128.56 Y116.106 I2.224 J-9.657 E.90491
G3 X137.879 Y126.786 I-.56 J9.894 E.48527
M204 S10000
; WIPE_START
G1 F12000
G1 X137.767 Y127.675 E-.34055
G1 X137.595 Y128.498 E-.31973
G1 X137.518 Y128.749 E-.09973
; WIPE_END
G1 E-.04 F1800
G1 X134.189 Y122.094 Z18.2 F30000
G1 Z17.8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4406
G2 X133.174 Y120.826 I-6.341 J4.035 E.05397
G1 X134.482 Y119.518 E.06139
G3 X137.063 Y124.613 I-6.525 J6.505 E.19264
G1 X135.307 Y126.369 E.08237
G2 X135.307 Y125.631 I-3.451 J-.369 E.02452
G1 X137.063 Y127.387 E.08237
G3 X134.482 Y132.482 I-9.106 J-1.41 E.19264
G1 X133.174 Y131.174 E.06139
G3 X131.905 Y132.187 I-5.206 J-5.218 E.05397
G1 X130.964 Y134.674 F30000
G1 F4406
G3 X129.386 Y135.062 I-3.028 J-8.91 E.05398
G1 X127.634 Y133.31 E.08215
G2 X128.367 Y133.309 I.36 J-3.426 E.02434
G1 X126.614 Y135.062 E.08222
G3 X125.036 Y134.674 I1.45 J-9.297 E.05398
G1 X121.81 Y129.907 F30000
G1 F4406
G2 X122.822 Y131.178 I6.864 J-4.43 E.05397
G1 X121.518 Y132.482 E.06122
G3 X118.937 Y127.387 I6.525 J-6.505 E.19264
G1 X120.684 Y125.64 E.08193
G1 X120.684 Y126.36 E.02386
G1 X118.937 Y124.613 E.08193
G3 X121.518 Y119.518 I9.106 J1.41 E.19264
G1 X122.822 Y120.822 E.06122
G2 X121.81 Y122.093 I5.852 J5.701 E.05397
G1 X125.036 Y117.326 F30000
G1 F4406
G3 X126.614 Y116.938 I3.028 J8.909 E.05399
G1 X128.369 Y118.693 E.08233
G2 X127.634 Y118.69 I-.387 J3.886 E.02441
G1 X129.386 Y116.938 E.08215
G3 X130.964 Y117.326 I-1.45 J9.298 E.05399
; CHANGE_LAYER
; Z_HEIGHT: 18
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F15476.087
G1 X129.386 Y116.938 E-.61765
G1 X129.121 Y117.203 E-.14235
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 90/250
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
G3 Z18.2 I-.773 J-.94 P1  F30000
G1 X121.495 Y123.477 Z18.2
G1 Z18
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4402
G1 X121.51 Y123.462 E.0007
G3 X127.708 Y119.033 I6.496 J2.538 E.26734
G3 X133.127 Y121.267 I.267 J7.043 E.20052
G3 X121.277 Y124.167 I-5.121 J4.734 E.96094
G1 X121.477 Y123.534 E.02199
G1 X121.876 Y123.606 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4402
G3 X127.74 Y119.424 I6.13 J2.394 E.23415
G3 X131.785 Y120.611 I.227 J6.712 E.13178
G3 X121.855 Y123.662 I-3.779 J5.388 E.90273
M204 S10000
; WIPE_START
G1 F12000
G1 X122.157 Y122.964 E-.28896
G1 X122.512 Y122.36 E-.26637
G1 X122.834 Y121.927 E-.20467
; WIPE_END
G1 E-.04 F1800
G1 X130.075 Y124.34 Z18.4 F30000
G1 X137.477 Y126.807 Z18.4
G1 Z18
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4402
G3 X122.338 Y118.344 I-9.484 J-.806 E1.2603
G3 X128.538 Y116.498 I5.685 J7.756 E.21886
G3 X137.482 Y126.747 I-.545 J9.503 E.50267
G1 X137.871 Y126.84 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4402
G3 X118.708 Y122.557 I-9.872 J-.842 E1.03853
G3 X128.571 Y116.107 I9.277 J3.42 E.38795
G3 X137.876 Y126.78 I-.572 J9.891 E.48468
M204 S10000
; WIPE_START
G1 F12000
G1 X137.772 Y127.676 E-.34247
G1 X137.595 Y128.498 E-.3198
G1 X137.52 Y128.744 E-.09773
; WIPE_END
G1 E-.04 F1800
G1 X131.905 Y132.187 Z18.4 F30000
G1 Z18
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4402
G2 X133.174 Y131.174 I-3.937 J-6.231 E.05397
G1 X134.482 Y132.482 E.06139
G2 X137.063 Y127.387 I-6.525 J-6.505 E.19264
G1 X135.307 Y125.631 E.08237
G3 X135.307 Y126.369 I-3.451 J.369 E.02452
G1 X137.063 Y124.613 E.08237
G2 X134.482 Y119.518 I-9.106 J1.41 E.19264
G1 X133.174 Y120.826 E.06139
G3 X134.189 Y122.094 I-5.326 J5.303 E.05397
G1 X130.964 Y117.326 F30000
G1 F4402
G2 X129.386 Y116.938 I-3.028 J8.91 E.05399
G1 X127.634 Y118.69 E.08215
G3 X128.369 Y118.694 I.346 J3.934 E.02442
G1 X126.614 Y116.938 E.08234
G2 X125.036 Y117.326 I1.45 J9.297 E.05399
G1 X121.81 Y122.093 F30000
G1 F4402
G3 X122.822 Y120.822 I6.864 J4.43 E.05397
G1 X121.518 Y119.518 E.06122
G2 X118.937 Y124.613 I6.525 J6.505 E.19264
G1 X120.684 Y126.36 E.08193
G1 X120.684 Y125.64 E.02386
G1 X118.937 Y127.387 E.08193
G2 X121.518 Y132.482 I9.106 J-1.41 E.19264
G1 X122.822 Y131.178 E.06122
G3 X121.81 Y129.907 I5.852 J-5.701 E.05397
G1 X125.036 Y134.674 F30000
G1 F4402
G2 X126.614 Y135.062 I3.028 J-8.909 E.05398
G1 X128.367 Y133.309 E.08222
G3 X127.634 Y133.31 I-.372 J-3.425 E.02434
G1 X129.386 Y135.062 E.08215
G2 X130.964 Y134.674 I-1.45 J-9.298 E.05399
; CHANGE_LAYER
; Z_HEIGHT: 18.2
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F15476.087
G1 X129.386 Y135.062 E-.61765
G1 X129.121 Y134.797 E-.14235
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 91/250
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
G3 Z18.4 I1.011 J-.678 P1  F30000
G1 X121.517 Y123.45 Z18.4
G1 Z18.2
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4398
G1 X121.817 Y122.787 E.02415
G3 X127.699 Y119.034 I6.189 J3.213 E.24238
G3 X133.127 Y121.267 I.277 J7.04 E.20083
G3 X121.47 Y123.571 I-5.121 J4.734 E.98163
G1 X121.495 Y123.506 E.0023
G1 X121.876 Y123.605 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4398
G3 X127.73 Y119.425 I6.13 J2.395 E.23386
G3 X132.336 Y121.044 I.281 J6.561 E.15372
G3 X121.854 Y123.661 I-4.33 J4.956 E.88125
M204 S10000
; WIPE_START
G1 F12000
G1 X122.157 Y122.964 E-.28896
G1 X122.512 Y122.36 E-.26637
G1 X122.834 Y121.927 E-.20467
; WIPE_END
G1 E-.04 F1800
G1 X130.075 Y124.34 Z18.6 F30000
G1 X137.476 Y126.807 Z18.6
G1 Z18.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4398
G3 X122.338 Y118.344 I-9.484 J-.806 E1.26023
G3 X128.549 Y116.499 I5.683 J7.753 E.21924
G3 X137.481 Y126.747 I-.557 J9.502 E.50226
G1 X137.869 Y126.84 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4398
G3 X120.842 Y119.14 I-9.876 J-.839 E1.16383
G3 X128.582 Y116.108 I7.176 J6.924 E.26348
G3 X137.874 Y126.78 I-.589 J9.894 E.48422
M204 S10000
; WIPE_START
G1 F12000
G1 X137.772 Y127.676 E-.34245
G1 X137.595 Y128.498 E-.3198
G1 X137.52 Y128.744 E-.09775
; WIPE_END
G1 E-.04 F1800
G1 X134.189 Y122.094 Z18.6 F30000
G1 Z18.2
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4398
G2 X133.174 Y120.826 I-6.34 J4.035 E.05397
G1 X134.482 Y119.518 E.06139
G3 X137.063 Y124.613 I-6.525 J6.505 E.19264
G1 X135.307 Y126.369 E.08237
G2 X135.307 Y125.631 I-3.451 J-.369 E.02452
G1 X137.063 Y127.387 E.08237
G3 X134.482 Y132.482 I-9.106 J-1.41 E.19264
G1 X133.174 Y131.174 E.06139
G3 X131.905 Y132.187 I-5.206 J-5.218 E.05397
G1 X130.964 Y134.674 F30000
G1 F4398
G3 X129.386 Y135.062 I-3.028 J-8.91 E.05399
G1 X127.634 Y133.31 E.08215
G2 X128.367 Y133.309 I.36 J-3.426 E.02434
G1 X126.614 Y135.062 E.08222
G3 X121.518 Y132.482 I1.64 J-9.567 E.19233
G1 X122.822 Y131.178 E.06122
G3 X121.81 Y129.907 I5.852 J-5.701 E.05397
G1 X119.322 Y128.965 F30000
G1 F4398
G3 X118.939 Y127.385 I9.212 J-3.069 E.05399
G1 X120.684 Y125.64 E.08183
G1 X120.684 Y126.36 E.02386
G1 X118.937 Y124.613 E.08193
G3 X121.518 Y119.518 I9.106 J1.41 E.19264
G1 X122.822 Y120.822 E.06122
G2 X121.81 Y122.093 I5.852 J5.701 E.05397
G1 X125.036 Y117.326 F30000
G1 F4398
G3 X126.614 Y116.938 I3.028 J8.91 E.05399
G1 X128.37 Y118.694 E.08235
G2 X127.634 Y118.69 I-.39 J3.976 E.02442
G1 X129.386 Y116.938 E.08215
G3 X130.964 Y117.326 I-1.45 J9.297 E.05399
; CHANGE_LAYER
; Z_HEIGHT: 18.4
; LAYER_HEIGHT: 0.199999
; WIPE_START
G1 F15476.087
G1 X129.386 Y116.938 E-.61765
G1 X129.121 Y117.203 E-.14235
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 92/250
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
G3 Z18.6 I-.773 J-.94 P1  F30000
G1 X121.495 Y123.477 Z18.6
G1 Z18.4
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4402
G1 X121.512 Y123.463 E.00073
G3 X127.689 Y119.035 I6.495 J2.537 E.26666
G3 X133.127 Y121.267 I.288 J7.037 E.20114
G3 X121.279 Y124.167 I-5.12 J4.734 E.96081
G1 X121.477 Y123.535 E.02199
G1 X121.877 Y123.606 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4402
G3 X127.721 Y119.425 I6.13 J2.395 E.23355
G3 X132.336 Y121.044 I.291 J6.559 E.15401
G3 X121.855 Y123.662 I-4.33 J4.956 E.88121
M204 S10000
; WIPE_START
G1 F12000
G1 X122.157 Y122.964 E-.28896
G1 X122.512 Y122.36 E-.26637
G1 X122.834 Y121.927 E-.20468
; WIPE_END
G1 E-.04 F1800
G1 X130.075 Y124.34 Z18.8 F30000
G1 X137.477 Y126.807 Z18.8
G1 Z18.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4402
G3 X121.709 Y118.852 I-9.484 J-.805 E1.23351
G3 X128.56 Y116.5 I6.278 J7.132 E.24654
G3 X137.482 Y126.747 I-.568 J9.502 E.5019
G1 X137.873 Y126.84 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4402
G3 X125.743 Y135.649 I-9.873 J-.84 E.52238
G3 X128.594 Y116.109 I2.257 J-9.649 E.90483
G3 X137.878 Y126.781 I-.594 J9.891 E.48402
M204 S10000
; WIPE_START
G1 F12000
G1 X137.772 Y127.676 E-.3425
G1 X137.595 Y128.498 E-.3198
G1 X137.52 Y128.744 E-.0977
; WIPE_END
G1 E-.04 F1800
G1 X131.905 Y132.187 Z18.8 F30000
G1 Z18.4
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4402
G2 X133.174 Y131.174 I-3.937 J-6.231 E.05397
G1 X134.482 Y132.482 E.06139
G2 X137.063 Y127.387 I-6.525 J-6.505 E.19264
G1 X135.307 Y125.631 E.08237
G3 X135.307 Y126.369 I-3.451 J.369 E.02452
M73 P54 R12
G1 X137.063 Y124.613 E.08237
G2 X134.482 Y119.518 I-9.106 J1.41 E.19264
G1 X133.174 Y120.826 E.06139
G3 X134.189 Y122.094 I-5.326 J5.303 E.05397
G1 X130.964 Y117.326 F30000
G1 F4402
G2 X129.386 Y116.938 I-3.028 J8.91 E.05399
G1 X127.634 Y118.69 E.08215
G3 X128.37 Y118.694 I.344 J4.024 E.02443
G1 X126.614 Y116.938 E.08236
G2 X125.036 Y117.326 I1.45 J9.297 E.05398
G1 X121.81 Y122.093 F30000
G1 F4402
G3 X122.822 Y120.822 I6.864 J4.43 E.05397
G1 X121.518 Y119.518 E.06122
G2 X118.937 Y124.613 I6.525 J6.505 E.19264
G1 X120.684 Y126.36 E.08193
G1 X120.684 Y125.64 E.02386
G1 X118.937 Y127.387 E.08193
G2 X121.518 Y132.482 I9.106 J-1.41 E.19264
G1 X122.822 Y131.178 E.06122
G3 X121.81 Y129.907 I5.852 J-5.701 E.05397
G1 X125.036 Y134.674 F30000
G1 F4402
G2 X126.614 Y135.062 I3.028 J-8.909 E.05399
G1 X128.367 Y133.309 E.08222
G3 X127.634 Y133.31 I-.372 J-3.425 E.02434
G1 X129.386 Y135.062 E.08215
G2 X130.964 Y134.674 I-1.45 J-9.298 E.05399
; CHANGE_LAYER
; Z_HEIGHT: 18.6
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F15476.087
G1 X129.386 Y135.062 E-.61765
G1 X129.121 Y134.797 E-.14235
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 93/250
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
G3 Z18.8 I1.009 J-.68 P1  F30000
G1 X121.495 Y123.477 Z18.8
G1 Z18.6
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4413
G1 X121.509 Y123.462 E.00068
G3 X127.68 Y119.035 I6.492 J2.536 E.26643
G3 X133.515 Y121.735 I.342 J6.917 E.22179
G3 X121.276 Y124.166 I-5.514 J4.263 E.94003
G1 X121.477 Y123.534 E.02199
G1 X121.878 Y123.606 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4413
G3 X127.711 Y119.426 I6.13 J2.394 E.23324
G3 X132.336 Y121.044 I.302 J6.557 E.1543
G3 X121.856 Y123.662 I-4.329 J4.956 E.88111
M204 S10000
; WIPE_START
G1 F12000
G1 X122.157 Y122.964 E-.28894
G1 X122.512 Y122.36 E-.26637
G1 X122.834 Y121.927 E-.20469
; WIPE_END
G1 E-.04 F1800
G1 X130.075 Y124.34 Z19 F30000
G1 X137.476 Y126.807 Z19
G1 Z18.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4413
G3 X121.709 Y118.852 I-9.484 J-.806 E1.23344
G3 X128.572 Y116.5 I6.278 J7.131 E.24692
G3 X137.481 Y126.747 I-.579 J9.5 E.50149
G1 X137.868 Y126.84 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4413
G3 X120.842 Y119.14 I-9.875 J-.839 E1.16376
G3 X128.605 Y116.11 I7.174 J6.92 E.26418
G3 X137.872 Y126.78 I-.612 J9.891 E.48346
M204 S10000
; WIPE_START
G1 F12000
G1 X137.772 Y127.676 E-.34244
G1 X137.595 Y128.498 E-.3198
G1 X137.52 Y128.744 E-.09776
; WIPE_END
G1 E-.04 F1800
G1 X133.458 Y122.283 Z19 F30000
G1 X131.905 Y119.813 Z19
G1 Z18.6
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4413
G3 X133.174 Y120.826 I-3.937 J6.231 E.05397
G1 X134.482 Y119.518 E.06139
G3 X137.063 Y124.613 I-6.65 J6.569 E.19255
G1 X135.307 Y126.369 E.08237
G2 X135.307 Y125.631 I-3.451 J-.369 E.02452
G1 X137.063 Y127.387 E.08237
G3 X134.482 Y132.482 I-9.106 J-1.41 E.19264
G1 X133.174 Y131.174 E.06139
G3 X131.905 Y132.187 I-5.206 J-5.218 E.05397
G1 X130.964 Y134.674 F30000
G1 F4413
G3 X129.386 Y135.062 I-3.028 J-8.91 E.05398
G1 X127.634 Y133.31 E.08215
G2 X128.367 Y133.309 I.36 J-3.426 E.02434
G1 X126.617 Y135.059 E.08207
G3 X125.038 Y134.674 I1.321 J-8.863 E.054
G1 X121.81 Y129.907 F30000
G1 F4413
G2 X122.822 Y131.178 I6.864 J-4.43 E.05397
G1 X121.518 Y132.482 E.06122
G3 X118.937 Y127.387 I6.525 J-6.505 E.19264
G1 X120.684 Y125.64 E.08193
G1 X120.684 Y126.36 E.02386
G1 X118.937 Y124.613 E.08193
G3 X121.518 Y119.518 I9.106 J1.41 E.19264
G1 X122.822 Y120.822 E.06122
G2 X121.81 Y122.093 I5.852 J5.701 E.05397
G1 X125.036 Y117.326 F30000
G1 F4413
G3 X126.614 Y116.938 I3.028 J8.909 E.05399
G1 X128.367 Y118.691 E.08222
G2 X127.634 Y118.69 I-.373 J3.895 E.02433
G1 X129.386 Y116.938 E.08215
G3 X130.964 Y117.326 I-1.45 J9.298 E.05399
; CHANGE_LAYER
; Z_HEIGHT: 18.8
; LAYER_HEIGHT: 0.199999
; WIPE_START
G1 F15476.087
G1 X129.386 Y116.938 E-.61765
G1 X129.121 Y117.203 E-.14235
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 94/250
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
G3 Z19 I-.773 J-.94 P1  F30000
G1 X121.495 Y123.477 Z19
G1 Z18.8
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4395
G1 X121.512 Y123.463 E.00073
G3 X127.671 Y119.036 I6.495 J2.538 E.26602
G3 X133.601 Y121.839 I.341 J6.954 E.22657
G3 X121.279 Y124.167 I-5.595 J4.162 E.93621
G1 X121.477 Y123.535 E.02199
G1 X121.877 Y123.606 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4395
G3 X127.702 Y119.427 I6.13 J2.395 E.23295
G3 X132.839 Y121.533 I.278 J6.64 E.17599
G3 X121.855 Y123.662 I-4.832 J4.468 E.8597
M204 S10000
; WIPE_START
G1 F12000
G1 X122.157 Y122.964 E-.28896
G1 X122.512 Y122.36 E-.26637
G1 X122.834 Y121.927 E-.20468
; WIPE_END
G1 E-.04 F1800
G1 X130.075 Y124.34 Z19.2 F30000
G1 X137.478 Y126.807 Z19.2
G1 Z18.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4395
G3 X121.125 Y119.411 I-9.485 J-.805 E1.20672
G3 X128.583 Y116.501 I6.89 J6.646 E.27397
G3 X137.483 Y126.747 I-.59 J9.5 E.50114
G1 X137.868 Y126.84 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4395
G3 X120.286 Y119.771 I-9.875 J-.838 E1.13794
G3 X128.616 Y116.111 I7.702 J6.218 E.29051
G3 X137.873 Y126.78 I-.623 J9.891 E.48313
M204 S10000
; WIPE_START
G1 F12000
G1 X137.772 Y127.676 E-.34244
G1 X137.595 Y128.498 E-.3198
G1 X137.52 Y128.744 E-.09776
; WIPE_END
G1 E-.04 F1800
G1 X131.905 Y132.187 Z19.2 F30000
G1 Z18.8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4395
G2 X133.174 Y131.174 I-3.937 J-6.231 E.05397
G1 X134.482 Y132.482 E.06139
G2 X137.063 Y127.387 I-6.525 J-6.505 E.19264
G1 X135.307 Y125.631 E.08237
M73 P54 R11
G3 X135.307 Y126.369 I-3.451 J.369 E.02452
G1 X137.063 Y124.613 E.08237
G2 X134.482 Y119.518 I-9.106 J1.41 E.19264
G1 X133.174 Y120.826 E.06139
G2 X131.905 Y119.813 I-5.206 J5.218 E.05397
G1 X130.964 Y117.326 F30000
G1 F4395
G2 X129.386 Y116.938 I-3.028 J8.91 E.05399
G1 X127.643 Y118.689 E.08194
G3 X128.367 Y118.691 I.353 J3.387 E.02406
G1 X126.614 Y116.938 E.08222
G2 X125.036 Y117.326 I1.45 J9.297 E.05398
G1 X121.81 Y122.093 F30000
G1 F4395
G3 X122.822 Y120.822 I6.864 J4.43 E.05397
G1 X121.518 Y119.518 E.06122
G2 X118.937 Y124.613 I6.525 J6.505 E.19264
G1 X120.684 Y126.36 E.08193
G1 X120.684 Y125.64 E.02386
G1 X118.937 Y127.387 E.08193
G2 X121.518 Y132.482 I9.106 J-1.41 E.19264
G1 X122.822 Y131.178 E.06122
G3 X121.81 Y129.907 I5.852 J-5.701 E.05397
G1 X125.036 Y134.674 F30000
G1 F4395
G2 X126.614 Y135.062 I3.028 J-8.909 E.05399
G1 X128.367 Y133.309 E.08222
G3 X127.634 Y133.31 I-.372 J-3.425 E.02434
G1 X129.386 Y135.062 E.08215
G2 X130.964 Y134.674 I-1.45 J-9.298 E.05399
; CHANGE_LAYER
; Z_HEIGHT: 19
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F15476.087
G1 X129.386 Y135.062 E-.61765
G1 X129.121 Y134.797 E-.14235
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 95/250
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
G3 Z19.2 I1.011 J-.678 P1  F30000
G1 X121.509 Y123.441 Z19.2
G1 Z19
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4422
G1 X121.818 Y122.787 E.02398
G3 X127.661 Y119.037 I6.189 J3.214 E.2411
G3 X134.012 Y122.458 I.323 J7.006 E.25133
G3 X121.497 Y123.499 I-6.006 J3.544 E.93497
G1 X121.866 Y123.604 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4422
G1 X121.877 Y123.606 E.00034
G3 X127.692 Y119.428 I6.13 J2.395 E.23265
G3 X132.839 Y121.533 I.288 J6.637 E.17628
G3 X121.658 Y124.27 I-4.832 J4.468 E.84001
G1 X121.848 Y123.661 E.01962
M204 S10000
; WIPE_START
G1 F12000
G1 X121.877 Y123.606 E-.02359
G1 X122.157 Y122.964 E-.26618
G1 X122.512 Y122.36 E-.26637
G1 X122.832 Y121.929 E-.20387
; WIPE_END
G1 E-.04 F1800
G1 X130.074 Y124.341 Z19.4 F30000
G1 X137.477 Y126.807 Z19.4
G1 Z19
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4422
G3 X121.125 Y119.411 I-9.484 J-.805 E1.20666
G3 X128.595 Y116.502 I6.889 J6.645 E.27435
G3 X137.482 Y126.747 I-.602 J9.499 E.50073
G1 X137.872 Y126.84 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4422
G3 X125.71 Y135.64 I-9.872 J-.84 E.52338
G3 X128.628 Y116.112 I2.292 J-9.64 E.90462
G3 X137.877 Y126.78 I-.628 J9.888 E.48293
M204 S10000
; WIPE_START
G1 F12000
G1 X137.772 Y127.676 E-.34249
G1 X137.595 Y128.498 E-.3198
G1 X137.52 Y128.744 E-.09771
; WIPE_END
G1 E-.04 F1800
G1 X133.458 Y122.282 Z19.4 F30000
G1 X131.905 Y119.813 Z19.4
G1 Z19
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4422
G3 X133.174 Y120.826 I-3.937 J6.231 E.05397
G1 X134.482 Y119.518 E.06139
G3 X137.063 Y124.613 I-6.525 J6.505 E.19264
G1 X135.307 Y126.369 E.08237
G2 X135.307 Y125.631 I-3.451 J-.369 E.02452
G1 X137.063 Y127.387 E.08237
G3 X134.482 Y132.482 I-9.106 J-1.41 E.19264
G1 X133.174 Y131.174 E.06139
G3 X131.905 Y132.187 I-5.206 J-5.218 E.05397
G1 X130.964 Y134.674 F30000
G1 F4422
G3 X129.386 Y135.062 I-3.028 J-8.909 E.05399
G1 X127.634 Y133.31 E.08215
G2 X128.367 Y133.309 I.36 J-3.426 E.02434
G1 X126.614 Y135.062 E.08222
G3 X125.036 Y134.674 I1.45 J-9.298 E.05399
G1 X121.81 Y129.907 F30000
G1 F4422
G2 X122.822 Y131.178 I6.864 J-4.43 E.05397
G1 X121.518 Y132.482 E.06122
G3 X118.937 Y127.387 I6.525 J-6.505 E.19264
G1 X120.684 Y125.64 E.08193
G1 X120.684 Y126.36 E.02386
G1 X118.937 Y124.613 E.08193
G3 X121.518 Y119.518 I9.588 J1.654 E.1923
G1 X122.822 Y120.822 E.06122
G2 X121.81 Y122.093 I5.852 J5.701 E.05397
G1 X125.036 Y117.326 F30000
G1 F4422
G3 X126.614 Y116.938 I3.028 J8.909 E.05398
G1 X128.367 Y118.691 E.08222
M73 P55 R11
G2 X127.634 Y118.69 I-.372 J3.424 E.02434
G1 X129.386 Y116.938 E.08215
G3 X130.964 Y117.326 I-1.45 J9.298 E.05399
; CHANGE_LAYER
; Z_HEIGHT: 19.2
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F15476.087
G1 X129.386 Y116.938 E-.61765
G1 X129.121 Y117.203 E-.14235
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 96/250
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
G3 Z19.4 I-.773 J-.94 P1  F30000
G1 X121.495 Y123.477 Z19.4
G1 Z19.2
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4390
G1 X121.512 Y123.463 E.00073
G3 X127.652 Y119.038 I6.495 J2.539 E.26538
G3 X133.497 Y121.713 I.374 J6.907 E.22179
G1 X133.601 Y121.839 E.00541
G1 X134.012 Y122.458 E.02464
G3 X121.279 Y124.167 I-6.005 J3.544 E.91161
G1 X121.477 Y123.535 E.02199
G1 X121.866 Y123.604 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4390
G1 X121.874 Y123.605 E.00024
G3 X127.683 Y119.428 I6.127 J2.394 E.23243
G3 X133.195 Y121.963 I.34 J6.522 E.19388
G3 X121.654 Y124.269 I-5.195 J4.035 E.8222
G1 X121.848 Y123.661 E.01961
M204 S10000
; WIPE_START
G1 F12000
G1 X121.874 Y123.605 E-.02366
G1 X122.157 Y122.964 E-.26622
G1 X122.512 Y122.36 E-.26637
G1 X122.832 Y121.929 E-.20375
; WIPE_END
G1 E-.04 F1800
G1 X130.074 Y124.341 Z19.6 F30000
G1 X137.478 Y126.807 Z19.6
G1 Z19.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4390
G3 X120.591 Y120.018 I-9.484 J-.805 E1.17988
G3 X128.606 Y116.503 I7.422 J6.03 E.30152
G3 X137.483 Y126.747 I-.613 J9.499 E.50037
G1 X137.869 Y126.84 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4390
G3 X119.785 Y120.448 I-9.875 J-.838 E1.1121
G3 X128.639 Y116.113 I8.222 J5.583 E.31695
G3 X137.874 Y126.78 I-.646 J9.89 E.48242
M204 S10000
; WIPE_START
G1 F12000
G1 X137.772 Y127.676 E-.34245
G1 X137.595 Y128.498 E-.3198
G1 X137.52 Y128.744 E-.09775
; WIPE_END
G1 E-.04 F1800
G1 X131.905 Y132.187 Z19.6 F30000
G1 Z19.2
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4390
G2 X133.174 Y131.174 I-3.937 J-6.231 E.05397
G1 X134.482 Y132.482 E.06139
G2 X137.063 Y127.387 I-6.525 J-6.505 E.19264
G1 X135.307 Y125.631 E.08237
G3 X135.307 Y126.369 I-3.451 J.369 E.02452
G1 X137.063 Y124.613 E.08237
G2 X134.482 Y119.518 I-9.106 J1.41 E.19264
G1 X133.174 Y120.826 E.06139
G2 X131.905 Y119.813 I-5.206 J5.218 E.05397
G1 X130.964 Y117.326 F30000
G1 F4390
G2 X129.386 Y116.938 I-3.028 J8.909 E.05399
G1 X127.634 Y118.69 E.08215
G3 X128.367 Y118.691 I.36 J3.426 E.02434
G1 X126.614 Y116.938 E.08222
G2 X125.036 Y117.326 I1.45 J9.298 E.05399
G1 X121.81 Y122.093 F30000
G1 F4390
G3 X122.822 Y120.822 I6.864 J4.43 E.05397
G1 X121.518 Y119.518 E.06122
G2 X118.937 Y124.613 I6.525 J6.505 E.19264
G1 X120.684 Y126.36 E.08193
G1 X120.684 Y125.64 E.02386
G1 X118.937 Y127.387 E.08193
G2 X121.518 Y132.482 I9.106 J-1.41 E.19264
G1 X122.822 Y131.178 E.06122
G3 X121.81 Y129.907 I5.852 J-5.701 E.05397
G1 X125.036 Y134.674 F30000
G1 F4390
G2 X126.614 Y135.062 I3.028 J-8.909 E.05398
G1 X128.367 Y133.309 E.08222
G3 X127.634 Y133.31 I-.372 J-3.425 E.02434
G1 X129.386 Y135.062 E.08215
G2 X130.964 Y134.674 I-1.45 J-9.298 E.05398
; CHANGE_LAYER
; Z_HEIGHT: 19.4
; LAYER_HEIGHT: 0.199999
; WIPE_START
G1 F15476.087
G1 X129.386 Y135.062 E-.61765
G1 X129.121 Y134.797 E-.14235
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 97/250
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
G3 Z19.6 I1.009 J-.68 P1  F30000
G1 X121.495 Y123.477 Z19.6
G1 Z19.4
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4408
G1 X121.511 Y123.463 E.00072
G3 X127.642 Y119.038 I6.495 J2.539 E.26507
G3 X134.354 Y123.117 I.344 J6.997 E.27657
G3 X121.278 Y124.167 I-6.348 J2.886 E.88702
G1 X121.477 Y123.534 E.02199
G1 X121.866 Y123.604 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4408
G1 X121.874 Y123.605 E.00025
G3 X127.674 Y119.429 I6.126 J2.394 E.23213
G3 X133.189 Y121.956 I.35 J6.519 E.19388
G3 X121.654 Y124.269 I-5.189 J4.043 E.82248
G1 X121.848 Y123.662 E.0196
M204 S10000
; WIPE_START
G1 F12000
G1 X121.874 Y123.605 E-.02384
G1 X122.157 Y122.964 E-.26622
G1 X122.512 Y122.36 E-.26637
G1 X122.832 Y121.93 E-.20357
; WIPE_END
G1 E-.04 F1800
G1 X130.073 Y124.341 Z19.8 F30000
G1 X137.477 Y126.807 Z19.8
G1 Z19.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4408
G3 X120.591 Y120.018 I-9.484 J-.804 E1.17988
G3 X128.617 Y116.504 I7.396 J5.971 E.30205
G3 X137.482 Y126.747 I-.624 J9.498 E.49997
G1 X137.868 Y126.84 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4408
G3 X119.785 Y120.448 I-9.875 J-.838 E1.1121
G3 X128.65 Y116.114 I8.225 J5.59 E.31727
G3 X137.873 Y126.78 I-.657 J9.889 E.48206
M204 S10000
; WIPE_START
G1 F12000
G1 X137.772 Y127.676 E-.34244
G1 X137.595 Y128.498 E-.3198
G1 X137.52 Y128.744 E-.09776
; WIPE_END
G1 E-.04 F1800
G1 X133.458 Y122.283 Z19.8 F30000
G1 X131.905 Y119.813 Z19.8
G1 Z19.4
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4408
G3 X133.174 Y120.826 I-3.937 J6.231 E.05397
G1 X134.482 Y119.518 E.06139
G3 X137.063 Y124.613 I-6.672 J6.579 E.19253
G1 X135.307 Y126.369 E.08237
G2 X135.307 Y125.631 I-3.451 J-.369 E.02452
G1 X137.063 Y127.387 E.08237
G3 X134.482 Y132.482 I-9.106 J-1.41 E.19264
G1 X133.174 Y131.174 E.06139
G3 X131.905 Y132.187 I-5.206 J-5.218 E.05397
G1 X130.964 Y134.674 F30000
G1 F4408
G3 X129.386 Y135.062 I-3.028 J-8.909 E.05399
G1 X127.634 Y133.31 E.08215
G2 X128.367 Y133.309 I.36 J-3.426 E.02434
G1 X126.614 Y135.062 E.08222
G3 X125.036 Y134.674 I1.45 J-9.298 E.05399
G1 X121.81 Y129.907 F30000
G1 F4408
G2 X122.822 Y131.178 I6.864 J-4.43 E.05397
G1 X121.518 Y132.482 E.06122
G3 X118.937 Y127.387 I6.525 J-6.505 E.19264
G1 X120.684 Y125.64 E.08193
G1 X120.684 Y126.36 E.02386
G1 X118.937 Y124.613 E.08193
G3 X121.518 Y119.518 I9.106 J1.41 E.19264
G1 X122.822 Y120.822 E.06122
G2 X121.81 Y122.093 I5.852 J5.701 E.05397
G1 X125.036 Y117.326 F30000
G1 F4408
G3 X126.614 Y116.938 I3.028 J8.909 E.05398
G1 X128.367 Y118.691 E.08222
G2 X127.634 Y118.69 I-.372 J3.424 E.02434
G1 X129.386 Y116.938 E.08215
G3 X130.964 Y117.326 I-1.45 J9.298 E.05399
; CHANGE_LAYER
; Z_HEIGHT: 19.6
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F15476.087
G1 X129.386 Y116.938 E-.61765
G1 X129.121 Y117.203 E-.14235
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 98/250
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
G3 Z19.8 I-.773 J-.94 P1  F30000
G1 X121.495 Y123.477 Z19.8
G1 Z19.6
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4390
G1 X121.512 Y123.463 E.00072
G3 X127.633 Y119.039 I6.495 J2.539 E.26474
G3 X134.354 Y123.117 I.378 J6.955 E.27709
G3 X121.279 Y124.167 I-6.348 J2.886 E.88701
G1 X121.477 Y123.535 E.02199
G1 X121.866 Y123.605 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4390
G1 X121.878 Y123.606 E.00037
G3 X127.664 Y119.43 I6.129 J2.395 E.23174
G3 X133.286 Y122.073 I.349 J6.56 E.19883
G3 X121.658 Y124.271 I-5.279 J3.929 E.81843
G1 X121.848 Y123.662 E.01958
M204 S10000
; WIPE_START
G1 F12000
G1 X121.878 Y123.606 E-.02416
G1 X122.157 Y122.964 E-.26616
G1 X122.512 Y122.36 E-.26637
G1 X122.831 Y121.93 E-.20331
; WIPE_END
G1 E-.04 F1800
G1 X130.073 Y124.341 Z20 F30000
G1 X137.477 Y126.807 Z20
G1 Z19.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4390
G3 X120.591 Y120.018 I-9.484 J-.804 E1.17987
G3 X128.629 Y116.505 I7.421 J6.028 E.30227
G3 X137.482 Y126.747 I-.636 J9.497 E.49958
G1 X137.872 Y126.84 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4390
G3 X118.742 Y122.473 I-9.872 J-.84 E1.04137
G3 X128.662 Y116.115 I9.25 J3.515 E.3878
G3 X137.877 Y126.78 I-.662 J9.885 E.48185
M204 S10000
; WIPE_START
G1 F12000
G1 X137.772 Y127.676 E-.34248
G1 X137.595 Y128.498 E-.3198
G1 X137.52 Y128.744 E-.09772
; WIPE_END
G1 E-.04 F1800
G1 X131.905 Y132.187 Z20 F30000
G1 Z19.6
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4390
G2 X133.174 Y131.174 I-3.937 J-6.231 E.05397
G1 X134.482 Y132.482 E.06139
G2 X137.063 Y127.387 I-6.525 J-6.505 E.19264
G1 X135.307 Y125.631 E.08237
G3 X135.307 Y126.369 I-3.451 J.369 E.02452
G1 X137.063 Y124.613 E.08237
G2 X134.482 Y119.518 I-9.106 J1.41 E.19264
G1 X133.174 Y120.826 E.06139
G2 X131.905 Y119.813 I-5.206 J5.218 E.05397
G1 X130.964 Y117.326 F30000
G1 F4390
G2 X129.386 Y116.938 I-3.028 J8.909 E.05398
G1 X127.634 Y118.69 E.08215
G3 X128.367 Y118.691 I.36 J3.426 E.02434
G1 X126.614 Y116.938 E.08222
G2 X125.036 Y117.326 I1.45 J9.298 E.05399
G1 X121.81 Y122.093 F30000
G1 F4390
G3 X122.822 Y120.822 I6.864 J4.43 E.05397
G1 X121.518 Y119.518 E.06122
G2 X118.937 Y124.613 I6.525 J6.505 E.19264
G1 X120.684 Y126.36 E.08193
G1 X120.684 Y125.64 E.02386
G1 X118.937 Y127.387 E.08193
G2 X121.518 Y132.482 I9.106 J-1.41 E.19264
G1 X122.822 Y131.178 E.06122
G3 X121.81 Y129.907 I5.852 J-5.701 E.05397
G1 X125.036 Y134.674 F30000
G1 F4390
G2 X126.614 Y135.062 I3.028 J-8.91 E.05398
G1 X128.367 Y133.309 E.08222
G3 X127.634 Y133.31 I-.372 J-3.425 E.02434
G1 X129.386 Y135.062 E.08215
G2 X130.964 Y134.674 I-1.45 J-9.298 E.05399
; CHANGE_LAYER
; Z_HEIGHT: 19.8
; LAYER_HEIGHT: 0.199999
; WIPE_START
G1 F15476.087
G1 X129.386 Y135.062 E-.61765
G1 X129.121 Y134.797 E-.14235
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 99/250
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
G3 Z20 I1.009 J-.68 P1  F30000
G1 X121.495 Y123.477 Z20
G1 Z19.8
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4408
G1 X121.512 Y123.463 E.00073
G3 X127.623 Y119.04 I6.494 J2.539 E.26442
G3 X134.354 Y123.117 I.388 J6.954 E.27741
G3 X121.279 Y124.167 I-6.348 J2.886 E.887
G1 X121.477 Y123.535 E.02199
G1 X121.866 Y123.606 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4408
G1 X121.877 Y123.606 E.00035
G3 X127.655 Y119.431 I6.129 J2.397 E.23147
G3 X133.674 Y122.657 I.333 J6.607 E.22049
G3 X121.657 Y124.27 I-5.667 J3.346 E.797
G1 X121.848 Y123.663 E.01956
M204 S10000
; WIPE_START
G1 F12000
G1 X121.877 Y123.606 E-.02435
G1 X122.157 Y122.964 E-.26618
G1 X122.512 Y122.36 E-.26637
G1 X122.831 Y121.931 E-.20311
; WIPE_END
G1 E-.04 F1800
G1 X130.073 Y124.341 Z20.2 F30000
G1 X137.478 Y126.807 Z20.2
G1 Z19.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4408
G3 X120.111 Y120.668 I-9.484 J-.804 E1.15309
G3 X128.64 Y116.506 I7.899 J5.368 E.32946
G3 X137.483 Y126.747 I-.647 J9.496 E.49922
G1 X137.869 Y126.84 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4408
G3 X119.344 Y121.165 I-9.875 J-.837 E1.08626
M73 P56 R11
G3 X128.673 Y116.116 I8.644 J4.828 E.34397
G3 X137.874 Y126.78 I-.68 J9.887 E.48136
M204 S10000
; WIPE_START
G1 F12000
G1 X137.772 Y127.676 E-.34245
G1 X137.595 Y128.498 E-.3198
G1 X137.52 Y128.744 E-.09775
; WIPE_END
G1 E-.04 F1800
G1 X133.458 Y122.283 Z20.2 F30000
G1 X131.905 Y119.813 Z20.2
G1 Z19.8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4408
G3 X133.174 Y120.826 I-3.937 J6.231 E.05397
G1 X134.482 Y119.518 E.06139
G3 X137.063 Y124.613 I-6.525 J6.505 E.19264
G1 X135.307 Y126.369 E.08237
G2 X135.307 Y125.631 I-3.451 J-.369 E.02452
G1 X137.063 Y127.387 E.08237
G3 X134.482 Y132.482 I-9.106 J-1.41 E.19264
G1 X133.174 Y131.174 E.06139
G3 X131.905 Y132.187 I-5.206 J-5.218 E.05397
G1 X130.964 Y134.674 F30000
G1 F4408
G3 X129.386 Y135.062 I-3.028 J-8.909 E.05399
G1 X127.634 Y133.31 E.08215
G2 X128.367 Y133.309 I.36 J-3.426 E.02434
G1 X126.614 Y135.062 E.08222
G3 X125.036 Y134.674 I1.45 J-9.297 E.05398
G1 X121.81 Y129.907 F30000
G1 F4408
G2 X122.822 Y131.178 I6.864 J-4.43 E.05397
G1 X121.518 Y132.482 E.06122
G3 X118.937 Y127.387 I6.525 J-6.505 E.19264
G1 X120.684 Y125.64 E.08193
G1 X120.684 Y126.36 E.02386
G1 X118.937 Y124.613 E.08193
G3 X121.518 Y119.518 I9.106 J1.41 E.19264
G1 X122.822 Y120.822 E.06122
G2 X121.81 Y122.093 I5.852 J5.701 E.05397
G1 X125.036 Y117.326 F30000
G1 F4408
G3 X126.614 Y116.938 I3.028 J8.909 E.05398
G1 X128.367 Y118.691 E.08222
G2 X127.634 Y118.69 I-.372 J3.425 E.02434
G1 X129.386 Y116.938 E.08215
G3 X130.964 Y117.326 I-1.45 J9.298 E.05399
; CHANGE_LAYER
; Z_HEIGHT: 20
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F15476.087
G1 X129.386 Y116.938 E-.61766
G1 X129.121 Y117.203 E-.14235
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 100/250
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
G3 Z20.2 I-.773 J-.94 P1  F30000
G1 X121.495 Y123.477 Z20.2
G1 Z20
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4390
G1 X121.511 Y123.463 E.00072
G3 X127.614 Y119.041 I6.494 J2.54 E.26411
G3 X134.625 Y123.808 I.397 J6.955 E.30236
G3 X121.278 Y124.167 I-6.619 J2.195 E.86241
G1 X121.477 Y123.534 E.02199
G1 X121.865 Y123.606 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4390
G1 X121.877 Y123.606 E.00036
G3 X127.645 Y119.431 I6.129 J2.397 E.23116
G3 X133.171 Y121.934 I.381 J6.51 E.19388
G1 X133.286 Y122.073 E.00553
G1 X133.674 Y122.657 E.02154
G3 X121.657 Y124.27 I-5.667 J3.346 E.79699
G1 X121.848 Y123.663 E.01954
M204 S10000
; WIPE_START
G1 F12000
G1 X121.877 Y123.606 E-.0246
G1 X122.157 Y122.964 E-.26618
G1 X122.512 Y122.36 E-.26637
G1 X122.831 Y121.931 E-.20285
; WIPE_END
G1 E-.04 F1800
G1 X130.073 Y124.342 Z20.4 F30000
G1 X137.477 Y126.807 Z20.4
G1 Z20
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4390
G3 X120.111 Y120.668 I-9.484 J-.804 E1.15309
G3 X128.651 Y116.507 I7.898 J5.367 E.32983
G3 X137.482 Y126.747 I-.658 J9.496 E.49882
G1 X137.869 Y126.84 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4390
G3 X119.344 Y121.165 I-9.875 J-.837 E1.08625
G3 X128.685 Y116.117 I8.644 J4.828 E.34432
G3 X137.873 Y126.78 I-.691 J9.886 E.481
M204 S10000
; WIPE_START
G1 F12000
G1 X137.772 Y127.676 E-.34245
G1 X137.595 Y128.498 E-.3198
G1 X137.52 Y128.744 E-.09775
; WIPE_END
G1 E-.04 F1800
G1 X131.905 Y132.187 Z20.4 F30000
G1 Z20
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4390
G2 X133.174 Y131.174 I-3.937 J-6.231 E.05397
G1 X134.482 Y132.482 E.06139
G2 X137.063 Y127.387 I-6.525 J-6.505 E.19264
G1 X135.307 Y125.631 E.08237
G3 X135.307 Y126.369 I-3.451 J.369 E.02452
G1 X137.063 Y124.613 E.08237
G2 X134.482 Y119.518 I-9.106 J1.41 E.19264
G1 X133.174 Y120.826 E.06139
G2 X131.905 Y119.813 I-5.206 J5.218 E.05397
G1 X130.964 Y117.326 F30000
G1 F4390
G2 X129.386 Y116.938 I-3.028 J8.91 E.05399
G1 X127.634 Y118.69 E.08215
G3 X128.367 Y118.691 I.36 J3.426 E.02434
G1 X126.614 Y116.938 E.08222
G2 X125.036 Y117.326 I1.45 J9.297 E.05398
G1 X121.81 Y122.093 F30000
G1 F4390
G3 X122.822 Y120.822 I6.864 J4.43 E.05397
G1 X121.518 Y119.518 E.06122
G2 X118.937 Y124.613 I6.525 J6.505 E.19264
G1 X120.684 Y126.36 E.08193
G1 X120.684 Y125.64 E.02386
G1 X118.937 Y127.387 E.08193
G2 X121.518 Y132.482 I9.106 J-1.41 E.19264
G1 X122.822 Y131.178 E.06122
G3 X121.81 Y129.907 I5.852 J-5.701 E.05397
G1 X125.036 Y134.674 F30000
G1 F4390
G2 X126.614 Y135.062 I3.028 J-8.909 E.05398
G1 X128.367 Y133.309 E.08222
G3 X127.634 Y133.31 I-.372 J-3.425 E.02434
G1 X129.386 Y135.062 E.08215
G2 X130.964 Y134.674 I-1.45 J-9.298 E.05399
; CHANGE_LAYER
; Z_HEIGHT: 20.2
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F15476.087
G1 X129.386 Y135.062 E-.61765
G1 X129.121 Y134.797 E-.14235
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 101/250
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
G3 Z20.4 I1.009 J-.68 P1  F30000
G1 X121.495 Y123.477 Z20.4
G1 Z20.2
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4408
G1 X121.512 Y123.463 E.00072
G3 X127.605 Y119.041 I6.494 J2.54 E.26379
G3 X134.625 Y123.808 I.386 J6.985 E.30245
G3 X121.279 Y124.167 I-6.619 J2.195 E.8624
G1 X121.477 Y123.535 E.02199
G1 X121.865 Y123.607 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4408
G1 X121.878 Y123.606 E.00039
G3 X127.636 Y119.432 I6.129 J2.396 E.23086
G3 X133.674 Y122.657 I.353 J6.604 E.22107
G3 X121.658 Y124.271 I-5.667 J3.345 E.79692
G1 X121.847 Y123.664 E.01952
M204 S10000
; WIPE_START
G1 F12000
G1 X121.878 Y123.606 E-.0249
G1 X122.157 Y122.964 E-.26616
G1 X122.512 Y122.36 E-.26637
G1 X122.83 Y121.932 E-.20257
; WIPE_END
G1 E-.04 F1800
G1 X130.073 Y124.341 Z20.6 F30000
G1 X137.486 Y126.807 Z20.6
G1 Z20.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4408
G3 X120.265 Y120.459 I-9.484 J-.804 E1.16157
G3 X128.663 Y116.508 I7.739 J5.549 E.32157
G3 X137.491 Y126.748 I-.661 J9.495 E.49873
G1 X137.868 Y126.84 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4408
G3 X119.344 Y121.165 I-9.875 J-.837 E1.08625
G1 X119.785 Y120.448 E.02586
G1 X119.95 Y120.226 E.00848
G3 X128.696 Y116.118 I8.054 J5.782 E.31014
G3 X137.873 Y126.78 I-.703 J9.885 E.48064
M204 S10000
; WIPE_START
G1 F12000
G1 X137.772 Y127.676 E-.34244
G1 X137.595 Y128.498 E-.3198
G1 X137.52 Y128.744 E-.09776
; WIPE_END
G1 E-.04 F1800
G1 X133.458 Y122.283 Z20.6 F30000
G1 X131.905 Y119.813 Z20.6
G1 Z20.2
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4408
G3 X133.174 Y120.826 I-3.937 J6.231 E.05397
G1 X134.482 Y119.518 E.06139
G3 X137.063 Y124.613 I-6.525 J6.505 E.19264
G1 X135.307 Y126.369 E.08237
G2 X135.307 Y125.631 I-3.451 J-.369 E.02452
G1 X137.063 Y127.387 E.08237
G3 X134.482 Y132.482 I-9.106 J-1.41 E.19264
G1 X133.174 Y131.174 E.06139
G3 X131.905 Y132.187 I-5.206 J-5.218 E.05397
G1 X130.964 Y134.674 F30000
G1 F4408
G3 X129.386 Y135.062 I-3.028 J-8.909 E.05399
G1 X127.634 Y133.31 E.08215
G2 X128.367 Y133.309 I.36 J-3.426 E.02434
G1 X126.614 Y135.062 E.08222
G3 X125.036 Y134.674 I1.45 J-9.298 E.05399
G1 X121.81 Y129.907 F30000
G1 F4408
G2 X122.822 Y131.178 I6.864 J-4.43 E.05397
G1 X121.518 Y132.482 E.06122
G3 X118.937 Y127.387 I6.525 J-6.505 E.19264
G1 X120.684 Y125.64 E.08193
G1 X120.684 Y126.36 E.02386
G1 X118.937 Y124.613 E.08193
G3 X121.518 Y119.518 I9.588 J1.654 E.1923
G1 X122.822 Y120.822 E.06122
G2 X121.81 Y122.093 I5.852 J5.701 E.05397
G1 X125.036 Y117.326 F30000
G1 F4408
G3 X126.614 Y116.938 I3.028 J8.909 E.05398
G1 X128.367 Y118.691 E.08222
G2 X127.634 Y118.69 I-.372 J3.425 E.02434
G1 X129.386 Y116.938 E.08215
G3 X130.964 Y117.326 I-1.45 J9.298 E.05399
; CHANGE_LAYER
; Z_HEIGHT: 20.4
; LAYER_HEIGHT: 0.199999
; WIPE_START
G1 F15476.087
G1 X129.386 Y116.938 E-.61766
G1 X129.121 Y117.203 E-.14235
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 102/250
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L102
M991 S0 P101 ;notify layer change
G17
G3 Z20.6 I-.773 J-.94 P1  F30000
G1 X121.495 Y123.477 Z20.6
G1 Z20.4
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4390
G1 X121.512 Y123.463 E.00073
G3 X127.595 Y119.042 I6.494 J2.54 E.26346
G3 X134.625 Y123.808 I.395 J6.984 E.30276
G3 X121.279 Y124.167 I-6.619 J2.195 E.86239
G1 X121.477 Y123.535 E.02199
G1 X121.865 Y123.608 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4390
G1 X121.877 Y123.606 E.00038
G3 X127.626 Y119.433 I6.129 J2.397 E.23057
G3 X133.997 Y123.279 I.385 J6.561 E.24306
G3 X121.657 Y124.27 I-5.991 J2.724 E.77543
G1 X121.847 Y123.665 E.0195
M204 S10000
; WIPE_START
G1 F12000
G1 X121.877 Y123.606 E-.02515
G1 X122.157 Y122.964 E-.26618
G1 X122.512 Y122.36 E-.26637
G1 X122.83 Y121.932 E-.20231
; WIPE_END
G1 E-.04 F1800
G1 X130.072 Y124.342 Z20.8 F30000
G1 X137.477 Y126.807 Z20.8
G1 Z20.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4390
G3 X120.111 Y120.668 I-9.484 J-.804 E1.15308
G3 X128.674 Y116.509 I7.897 J5.366 E.33059
G3 X137.482 Y126.747 I-.681 J9.494 E.49804
G1 X137.87 Y126.84 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4390
G3 X125.633 Y135.62 I-9.871 J-.84 E.52573
G3 X128.707 Y116.118 I2.358 J-9.621 E.9051
G3 X137.875 Y126.78 I-.708 J9.881 E.48039
M204 S10000
; WIPE_START
G1 F12000
G1 X137.772 Y127.676 E-.34246
G1 X137.595 Y128.498 E-.3198
G1 X137.52 Y128.744 E-.09774
; WIPE_END
G1 E-.04 F1800
G1 X131.905 Y132.187 Z20.8 F30000
G1 Z20.4
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4390
G2 X133.174 Y131.174 I-3.937 J-6.231 E.05397
G1 X134.482 Y132.482 E.06139
G2 X137.063 Y127.387 I-6.525 J-6.505 E.19264
G1 X135.307 Y125.631 E.08237
G3 X135.307 Y126.369 I-3.451 J.369 E.02452
G1 X137.063 Y124.613 E.08237
G2 X134.482 Y119.518 I-9.106 J1.41 E.19264
M73 P57 R11
G1 X133.174 Y120.826 E.06139
G2 X131.905 Y119.813 I-5.206 J5.218 E.05397
G1 X130.964 Y117.326 F30000
G1 F4390
G2 X129.386 Y116.938 I-3.028 J8.909 E.05399
G1 X127.634 Y118.69 E.08215
G3 X128.367 Y118.691 I.36 J3.426 E.02434
G1 X126.614 Y116.938 E.08222
G2 X125.036 Y117.326 I1.45 J9.297 E.05398
G1 X121.81 Y122.093 F30000
G1 F4390
G3 X122.822 Y120.822 I6.864 J4.43 E.05397
G1 X121.518 Y119.518 E.06122
G2 X118.937 Y124.613 I6.525 J6.505 E.19264
G1 X120.684 Y126.36 E.08193
G1 X120.684 Y125.64 E.02386
G1 X118.937 Y127.387 E.08193
G2 X121.518 Y132.482 I9.106 J-1.41 E.19264
G1 X122.822 Y131.178 E.06122
G3 X121.81 Y129.907 I5.852 J-5.701 E.05397
G1 X125.036 Y134.674 F30000
G1 F4390
G2 X126.614 Y135.062 I3.028 J-8.909 E.05398
G1 X128.367 Y133.309 E.08222
G3 X127.634 Y133.31 I-.372 J-3.425 E.02434
G1 X129.386 Y135.062 E.08215
G2 X130.964 Y134.674 I-1.45 J-9.298 E.05399
; CHANGE_LAYER
; Z_HEIGHT: 20.6
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F15476.087
G1 X129.386 Y135.062 E-.61765
G1 X129.121 Y134.797 E-.14235
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 103/250
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L103
M991 S0 P102 ;notify layer change
G17
G3 Z20.8 I1.009 J-.68 P1  F30000
G1 X121.495 Y123.477 Z20.8
G1 Z20.6
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4408
G1 X121.512 Y123.463 E.00072
G3 X127.586 Y119.043 I6.494 J2.54 E.26315
G3 X134.82 Y124.525 I.425 J6.954 E.32793
G3 X121.279 Y124.167 I-6.815 J1.478 E.83774
G1 X121.477 Y123.535 E.02199
G1 X121.865 Y123.608 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4408
G1 X121.877 Y123.606 E.00039
G3 X127.617 Y119.434 I6.129 J2.397 E.23028
G3 X133.997 Y123.279 I.395 J6.56 E.24335
G3 X121.657 Y124.27 I-5.991 J2.724 E.77547
G1 X121.847 Y123.666 E.01947
M204 S10000
; WIPE_START
G1 F12000
G1 X121.877 Y123.606 E-.02544
G1 X122.157 Y122.964 E-.26618
G1 X122.512 Y122.36 E-.26637
G1 X122.829 Y121.933 E-.20202
; WIPE_END
G1 E-.04 F1800
G1 X130.072 Y124.342 Z21 F30000
G1 X137.478 Y126.807 Z21
G1 Z20.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4408
G3 X119.687 Y121.356 I-9.484 J-.803 E1.1263
G3 X128.685 Y116.51 I8.301 J4.636 E.35793
G3 X137.483 Y126.747 I-.692 J9.493 E.49769
G1 X137.87 Y126.84 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4408
G3 X119.1 Y121.649 I-9.871 J-.84 E1.06882
G3 X128.719 Y116.119 I8.902 J4.355 E.36183
G3 X137.875 Y126.78 I-.719 J9.88 E.48005
M204 S10000
; WIPE_START
G1 F12000
G1 X137.772 Y127.676 E-.34247
G1 X137.595 Y128.498 E-.3198
G1 X137.52 Y128.744 E-.09773
; WIPE_END
G1 E-.04 F1800
G1 X133.458 Y122.282 Z21 F30000
G1 X131.905 Y119.813 Z21
G1 Z20.6
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4408
G3 X133.174 Y120.826 I-3.937 J6.231 E.05397
G1 X134.482 Y119.518 E.06139
G3 X137.063 Y124.613 I-6.525 J6.505 E.19264
G1 X135.307 Y126.369 E.08237
G2 X135.307 Y125.631 I-3.451 J-.369 E.02452
G1 X137.063 Y127.387 E.08237
G3 X134.482 Y132.482 I-9.106 J-1.41 E.19264
G1 X133.174 Y131.174 E.06139
G3 X131.905 Y132.187 I-5.206 J-5.218 E.05397
G1 X130.964 Y134.674 F30000
G1 F4408
G3 X129.386 Y135.062 I-3.028 J-8.909 E.05399
G1 X127.634 Y133.31 E.08215
G2 X128.367 Y133.309 I.36 J-3.426 E.02434
G1 X126.614 Y135.062 E.08222
G3 X125.036 Y134.674 I1.449 J-9.297 E.05398
G1 X121.81 Y129.907 F30000
G1 F4408
G2 X122.822 Y131.178 I6.864 J-4.43 E.05397
G1 X121.518 Y132.482 E.06122
G3 X118.937 Y127.387 I6.525 J-6.505 E.19264
G1 X120.684 Y125.64 E.08193
G1 X120.684 Y126.36 E.02386
G1 X118.937 Y124.613 E.08193
G3 X121.518 Y119.518 I9.106 J1.41 E.19264
G1 X122.822 Y120.822 E.06122
G2 X121.81 Y122.093 I5.852 J5.701 E.05397
G1 X125.036 Y117.326 F30000
G1 F4408
G3 X126.614 Y116.938 I3.028 J8.909 E.05398
G1 X128.367 Y118.691 E.08222
G2 X127.634 Y118.69 I-.372 J3.425 E.02434
G1 X129.386 Y116.938 E.08215
G3 X130.964 Y117.326 I-1.45 J9.298 E.05399
; CHANGE_LAYER
; Z_HEIGHT: 20.8
; LAYER_HEIGHT: 0.199999
; WIPE_START
G1 F15476.087
G1 X129.386 Y116.938 E-.61765
G1 X129.121 Y117.203 E-.14235
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 104/250
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L104
M991 S0 P103 ;notify layer change
G17
G3 Z21 I-.773 J-.94 P1  F30000
G1 X121.495 Y123.477 Z21
G1 Z20.8
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4390
G1 X121.512 Y123.463 E.00072
G3 X127.576 Y119.044 I6.494 J2.541 E.26284
G3 X134.82 Y124.525 I.415 J6.979 E.328
G3 X121.278 Y124.167 I-6.815 J1.479 E.83778
G1 X121.477 Y123.534 E.02199
G1 X121.865 Y123.609 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4390
G1 X121.878 Y123.606 E.00042
G3 X127.607 Y119.434 I6.129 J2.397 E.22997
G3 X133.997 Y123.279 I.383 J6.596 E.24345
G3 X121.658 Y124.27 I-5.99 J2.724 E.77541
G1 X121.847 Y123.666 E.01945
M204 S10000
; WIPE_START
G1 F12000
G1 X121.878 Y123.606 E-.02576
G1 X122.157 Y122.964 E-.26616
G1 X122.512 Y122.36 E-.26637
G1 X122.829 Y121.934 E-.20171
; WIPE_END
G1 E-.04 F1800
G1 X130.071 Y124.343 Z21.2 F30000
G1 X137.477 Y126.807 Z21.2
G1 Z20.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4390
G3 X119.687 Y121.356 I-9.484 J-.804 E1.12625
G3 X128.697 Y116.511 I8.301 J4.636 E.3583
G3 X137.482 Y126.747 I-.703 J9.492 E.49729
G1 X137.868 Y126.84 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4390
G3 X118.965 Y121.916 I-9.875 J-.837 E1.06037
G3 X128.73 Y116.12 I9.041 J4.11 E.37141
G3 X137.873 Y126.78 I-.736 J9.883 E.47958
M204 S10000
; WIPE_START
G1 F12000
G1 X137.772 Y127.676 E-.34244
G1 X137.595 Y128.498 E-.3198
G1 X137.52 Y128.744 E-.09776
; WIPE_END
G1 E-.04 F1800
G1 X131.905 Y132.187 Z21.2 F30000
G1 Z20.8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4390
G2 X133.174 Y131.174 I-3.937 J-6.231 E.05397
G1 X134.482 Y132.482 E.06139
G2 X137.063 Y127.387 I-6.525 J-6.505 E.19264
G1 X135.307 Y125.631 E.08237
G3 X135.307 Y126.369 I-3.451 J.369 E.02452
G1 X137.063 Y124.613 E.08237
G2 X134.482 Y119.518 I-9.106 J1.41 E.19264
G1 X133.174 Y120.826 E.06139
G2 X131.905 Y119.813 I-5.206 J5.218 E.05397
G1 X130.964 Y117.326 F30000
G1 F4390
G2 X129.386 Y116.938 I-3.028 J8.91 E.05399
G1 X127.634 Y118.69 E.08215
G3 X128.367 Y118.691 I.36 J3.426 E.02434
G1 X126.614 Y116.938 E.08222
G2 X125.036 Y117.326 I1.45 J9.297 E.05398
G1 X121.81 Y122.093 F30000
G1 F4390
G3 X122.822 Y120.822 I6.864 J4.431 E.05397
G1 X121.518 Y119.518 E.06122
G2 X118.937 Y124.613 I6.525 J6.505 E.19264
G1 X120.684 Y126.36 E.08193
G1 X120.684 Y125.64 E.02386
G1 X118.937 Y127.387 E.08193
G2 X121.518 Y132.482 I9.106 J-1.41 E.19264
G1 X122.822 Y131.178 E.06122
G3 X121.81 Y129.907 I5.852 J-5.701 E.05397
G1 X125.036 Y134.674 F30000
G1 F4390
G2 X126.614 Y135.062 I3.028 J-8.91 E.05398
G1 X128.367 Y133.309 E.08222
G3 X127.634 Y133.31 I-.372 J-3.425 E.02434
G1 X129.386 Y135.062 E.08215
G2 X130.964 Y134.674 I-1.45 J-9.298 E.05399
; CHANGE_LAYER
; Z_HEIGHT: 21
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F15476.087
G1 X129.386 Y135.062 E-.61765
G1 X129.121 Y134.797 E-.14235
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 105/250
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L105
M991 S0 P104 ;notify layer change
G17
G3 Z21.2 I1.009 J-.68 P1  F30000
G1 X121.495 Y123.477 Z21.2
G1 Z21
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4408
G1 X121.512 Y123.463 E.00073
G3 X127.567 Y119.044 I6.494 J2.541 E.26251
G3 X134.82 Y124.525 I.444 J6.953 E.32855
G3 X121.279 Y124.167 I-6.815 J1.479 E.83778
G1 X121.477 Y123.535 E.02199
G1 X121.864 Y123.61 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4408
G1 X121.877 Y123.606 E.00041
G3 X127.598 Y119.435 I6.129 J2.397 E.22969
G3 X134.252 Y123.932 I.394 J6.589 E.26528
G3 X121.657 Y124.27 I-6.246 J2.072 E.75392
G1 X121.846 Y123.667 E.01942
M204 S10000
; WIPE_START
G1 F12000
G1 X121.877 Y123.606 E-.02604
G1 X122.157 Y122.964 E-.26617
G1 X122.512 Y122.36 E-.26637
G1 X122.828 Y121.934 E-.20142
; WIPE_END
G1 E-.04 F1800
G1 X130.071 Y124.343 Z21.4 F30000
G1 X137.478 Y126.807 Z21.4
G1 Z21
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4408
G3 X119.687 Y121.356 I-9.484 J-.803 E1.12629
G3 X128.708 Y116.512 I8.3 J4.636 E.35868
G3 X137.482 Y126.747 I-.715 J9.491 E.49691
G1 X137.877 Y126.841 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4408
G3 X119.11 Y121.629 I-9.875 J-.837 E1.07015
G3 X128.741 Y116.121 I8.891 J4.374 E.36183
G3 X137.882 Y126.781 I-.739 J9.883 E.4795
M204 S10000
; WIPE_START
G1 F12000
G1 X137.772 Y127.676 E-.34255
G1 X137.595 Y128.498 E-.3198
G1 X137.52 Y128.744 E-.09765
; WIPE_END
G1 E-.04 F1800
G1 X133.458 Y122.282 Z21.4 F30000
G1 X131.905 Y119.813 Z21.4
G1 Z21
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4408
G3 X133.174 Y120.826 I-3.937 J6.231 E.05397
G1 X134.482 Y119.518 E.06139
G3 X137.063 Y124.613 I-6.525 J6.505 E.19264
G1 X135.307 Y126.369 E.08237
G2 X135.307 Y125.631 I-3.451 J-.369 E.02452
G1 X137.063 Y127.387 E.08237
G3 X134.482 Y132.482 I-9.106 J-1.41 E.19264
G1 X133.174 Y131.174 E.06139
G3 X131.905 Y132.187 I-5.206 J-5.218 E.05397
G1 X130.964 Y134.674 F30000
G1 F4408
G3 X129.386 Y135.062 I-3.028 J-8.91 E.05398
G1 X127.634 Y133.31 E.08215
G2 X128.367 Y133.309 I.36 J-3.426 E.02434
G1 X126.614 Y135.062 E.08222
G3 X125.036 Y134.674 I1.45 J-9.298 E.05399
G1 X121.81 Y129.907 F30000
G1 F4408
G2 X122.822 Y131.178 I6.864 J-4.43 E.05397
G1 X121.518 Y132.482 E.06122
G3 X118.937 Y127.387 I6.525 J-6.505 E.19264
G1 X120.684 Y125.64 E.08193
G1 X120.684 Y126.36 E.02386
G1 X118.937 Y124.613 E.08193
G3 X121.518 Y119.518 I9.106 J1.41 E.19264
G1 X122.822 Y120.822 E.06122
G2 X121.81 Y122.093 I5.852 J5.701 E.05397
G1 X125.036 Y117.326 F30000
G1 F4408
G3 X126.614 Y116.938 I3.028 J8.909 E.05399
G1 X128.367 Y118.691 E.08222
G2 X127.634 Y118.69 I-.372 J3.425 E.02434
G1 X129.386 Y116.938 E.08215
G3 X130.964 Y117.326 I-1.45 J9.297 E.05398
; CHANGE_LAYER
; Z_HEIGHT: 21.2
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F15476.087
G1 X129.386 Y116.938 E-.61765
G1 X129.121 Y117.203 E-.14235
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 106/250
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L106
M991 S0 P105 ;notify layer change
G17
G3 Z21.4 I-.773 J-.94 P1  F30000
G1 X121.495 Y123.477 Z21.4
G1 Z21.2
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4390
G1 X121.512 Y123.463 E.00073
G3 X127.557 Y119.045 I6.494 J2.541 E.26219
G3 X134.82 Y124.525 I.454 J6.952 E.32886
G3 X121.279 Y124.167 I-6.815 J1.479 E.83777
G1 X121.477 Y123.535 E.02199
G1 X121.864 Y123.611 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4390
G1 X121.877 Y123.606 E.00043
G3 X127.589 Y119.436 I6.129 J2.397 E.22939
G3 X134.252 Y123.932 I.404 J6.588 E.26557
G3 X121.657 Y124.27 I-6.246 J2.072 E.75391
G1 X121.846 Y123.668 E.0194
M204 S10000
; WIPE_START
G1 F12000
G1 X121.877 Y123.606 E-.02634
G1 X122.157 Y122.964 E-.26617
G1 X122.512 Y122.36 E-.26637
M73 P58 R11
G1 X122.828 Y121.935 E-.20112
; WIPE_END
G1 E-.04 F1800
G1 X130.07 Y124.343 Z21.6 F30000
G1 X137.477 Y126.807 Z21.6
G1 Z21.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4390
G3 X119.687 Y121.356 I-9.484 J-.803 E1.12629
G3 X128.719 Y116.513 I8.3 J4.636 E.35906
G3 X137.482 Y126.747 I-.726 J9.49 E.49653
G1 X137.869 Y126.84 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4390
G3 X118.965 Y121.916 I-9.875 J-.836 E1.06041
G3 X128.753 Y116.122 I9.041 J4.109 E.37211
G3 X137.873 Y126.78 I-.759 J9.881 E.47887
M204 S10000
; WIPE_START
G1 F12000
G1 X137.772 Y127.676 E-.34245
G1 X137.595 Y128.498 E-.3198
G1 X137.52 Y128.744 E-.09775
; WIPE_END
G1 E-.04 F1800
G1 X131.905 Y132.187 Z21.6 F30000
G1 Z21.2
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4390
G2 X133.174 Y131.174 I-3.937 J-6.231 E.05397
G1 X134.482 Y132.482 E.06139
G2 X137.063 Y127.387 I-6.525 J-6.505 E.19264
G1 X135.307 Y125.631 E.08237
G3 X135.307 Y126.369 I-3.451 J.369 E.02452
G1 X137.063 Y124.613 E.08237
G2 X134.482 Y119.518 I-9.106 J1.41 E.19264
G1 X133.174 Y120.826 E.06139
G2 X131.905 Y119.813 I-5.206 J5.218 E.05397
G1 X130.964 Y117.326 F30000
G1 F4390
G2 X129.386 Y116.938 I-3.028 J8.91 E.05399
G1 X127.634 Y118.69 E.08215
G3 X128.367 Y118.691 I.36 J3.426 E.02434
G1 X126.614 Y116.938 E.08222
G2 X125.036 Y117.326 I1.45 J9.298 E.05399
G1 X121.81 Y122.093 F30000
G1 F4390
G3 X122.822 Y120.822 I6.864 J4.43 E.05397
G1 X121.518 Y119.518 E.06122
G2 X118.937 Y124.613 I6.525 J6.505 E.19264
G1 X120.684 Y126.36 E.08193
G1 X120.684 Y125.64 E.02386
G1 X118.937 Y127.387 E.08193
G2 X121.518 Y132.482 I9.106 J-1.41 E.19264
G1 X122.822 Y131.178 E.06122
G3 X121.81 Y129.907 I5.852 J-5.701 E.05397
G1 X125.036 Y134.674 F30000
G1 F4390
G2 X126.614 Y135.062 I3.028 J-8.91 E.05399
G1 X128.367 Y133.309 E.08222
G3 X127.634 Y133.31 I-.372 J-3.425 E.02434
G1 X129.386 Y135.062 E.08215
G2 X130.964 Y134.674 I-1.45 J-9.298 E.05399
; CHANGE_LAYER
; Z_HEIGHT: 21.4
; LAYER_HEIGHT: 0.199999
; WIPE_START
G1 F15476.087
G1 X129.386 Y135.062 E-.61765
G1 X129.121 Y134.797 E-.14235
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 107/250
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L107
M991 S0 P106 ;notify layer change
G17
G3 Z21.6 I1.009 J-.68 P1  F30000
G1 X121.495 Y123.477 Z21.6
G1 Z21.4
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4408
G1 X121.501 Y123.459 E.00064
G3 X127.074 Y119.084 I6.499 J2.541 E.2465
G1 X127.548 Y119.046 E.01577
G1 X127.814 Y119.025 E.00886
G3 X121.268 Y124.164 I.186 J6.975 E1.15854
G1 X121.476 Y123.534 E.02201
G1 X121.864 Y123.611 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4408
G1 X121.878 Y123.606 E.00045
G3 X127.579 Y119.437 I6.128 J2.397 E.2291
G3 X134.252 Y123.932 I.414 J6.587 E.26586
G3 X121.658 Y124.27 I-6.246 J2.072 E.75391
G1 X121.846 Y123.669 E.01937
M204 S10000
; WIPE_START
G1 F12000
G1 X121.878 Y123.606 E-.02664
G1 X122.157 Y122.964 E-.26617
G1 X122.512 Y122.36 E-.26637
G1 X122.828 Y121.935 E-.20082
; WIPE_END
G1 E-.04 F1800
G1 X130.07 Y124.344 Z21.8 F30000
G1 X137.477 Y126.807 Z21.8
G1 Z21.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4408
G3 X119.687 Y121.356 I-9.484 J-.803 E1.12629
G3 X128.731 Y116.514 I8.3 J4.636 E.35943
G3 X137.482 Y126.747 I-.738 J9.489 E.49615
G1 X137.87 Y126.84 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4408
G3 X119.12 Y121.609 I-9.87 J-.84 E1.0702
G3 X128.764 Y116.123 I8.88 J4.393 E.36182
G3 X137.875 Y126.78 I-.764 J9.877 E.47863
M204 S10000
; WIPE_START
G1 F12000
G1 X137.772 Y127.676 E-.34246
G1 X137.595 Y128.498 E-.3198
M73 P58 R10
G1 X137.52 Y128.744 E-.09774
; WIPE_END
G1 E-.04 F1800
G1 X133.458 Y122.282 Z21.8 F30000
G1 X131.905 Y119.813 Z21.8
G1 Z21.4
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4408
G3 X133.174 Y120.826 I-3.937 J6.231 E.05397
G1 X134.482 Y119.518 E.06139
G3 X137.063 Y124.613 I-6.525 J6.505 E.19264
G1 X135.307 Y126.369 E.08237
G2 X135.307 Y125.631 I-3.451 J-.369 E.02452
G1 X137.063 Y127.387 E.08237
G3 X134.482 Y132.482 I-9.106 J-1.41 E.19264
G1 X133.174 Y131.174 E.06139
G3 X131.905 Y132.187 I-5.206 J-5.218 E.05397
G1 X130.964 Y134.674 F30000
G1 F4408
G3 X129.386 Y135.062 I-3.028 J-8.909 E.05399
G1 X127.634 Y133.31 E.08215
G2 X128.367 Y133.309 I.36 J-3.426 E.02434
G1 X126.614 Y135.062 E.08222
G3 X125.036 Y134.674 I1.45 J-9.298 E.05399
G1 X121.81 Y129.907 F30000
G1 F4408
G2 X122.822 Y131.178 I6.864 J-4.43 E.05397
G1 X121.518 Y132.482 E.06122
G3 X118.937 Y127.387 I6.525 J-6.505 E.19264
G1 X120.684 Y125.64 E.08193
G1 X120.684 Y126.36 E.02386
G1 X118.937 Y124.613 E.08193
G3 X121.518 Y119.518 I9.106 J1.41 E.19264
G1 X122.822 Y120.822 E.06122
G2 X121.81 Y122.093 I5.852 J5.701 E.05397
G1 X125.036 Y117.326 F30000
G1 F4408
G3 X126.614 Y116.938 I3.028 J8.909 E.05398
G1 X128.367 Y118.691 E.08222
G2 X127.634 Y118.69 I-.372 J3.425 E.02434
G1 X129.386 Y116.938 E.08215
G3 X130.964 Y117.326 I-1.45 J9.298 E.05399
; CHANGE_LAYER
; Z_HEIGHT: 21.6
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F15476.087
G1 X129.386 Y116.938 E-.61766
G1 X129.121 Y117.203 E-.14235
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 108/250
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L108
M991 S0 P107 ;notify layer change
G17
G3 Z21.8 I-.773 J-.94 P1  F30000
G1 X121.495 Y123.477 Z21.8
G1 Z21.6
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4390
G1 X121.506 Y123.461 E.00065
G3 X127.074 Y119.084 I6.496 J2.534 E.24643
G1 X127.538 Y119.047 E.01546
G3 X133.127 Y121.267 I.453 J7.005 E.20615
G1 X133.601 Y121.839 E.02464
G3 X121.273 Y124.165 I-5.599 J4.157 E.93584
G1 X121.477 Y123.534 E.022
G1 X121.864 Y123.612 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4390
G1 X121.878 Y123.606 E.00047
G3 X127.57 Y119.437 I6.128 J2.397 E.2288
G3 X134.252 Y123.932 I.442 J6.558 E.26633
G3 X121.658 Y124.27 I-6.246 J2.072 E.7539
G1 X121.846 Y123.669 E.01935
M204 S10000
; WIPE_START
G1 F12000
G1 X121.878 Y123.606 E-.02693
G1 X122.157 Y122.964 E-.26617
G1 X122.512 Y122.36 E-.26637
G1 X122.827 Y121.936 E-.20053
; WIPE_END
G1 E-.04 F1800
G1 X130.07 Y124.343 Z22 F30000
G1 X137.486 Y126.807 Z22
G1 Z21.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4390
G3 X119.476 Y121.775 I-9.484 J-.803 E1.11056
G3 X128.742 Y116.515 I8.525 J4.226 E.37515
G3 X137.491 Y126.748 I-.74 J9.489 E.49607
G1 X137.869 Y126.84 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4390
G3 X118.652 Y122.697 I-9.875 J-.836 E1.03454
G1 X118.965 Y121.916 E.02586
G1 X119.126 Y121.598 E.01093
G3 X128.775 Y116.124 I8.875 J4.403 E.36182
G3 X137.874 Y126.78 I-.781 J9.879 E.47818
M204 S10000
; WIPE_START
G1 F12000
G1 X137.772 Y127.676 E-.34245
G1 X137.595 Y128.498 E-.3198
G1 X137.52 Y128.744 E-.09775
; WIPE_END
G1 E-.04 F1800
G1 X131.905 Y132.187 Z22 F30000
G1 Z21.6
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4390
G2 X133.174 Y131.174 I-3.937 J-6.231 E.05397
G1 X134.482 Y132.482 E.06139
G2 X137.063 Y127.387 I-6.525 J-6.505 E.19264
G1 X135.307 Y125.631 E.08237
G3 X135.307 Y126.369 I-3.451 J.369 E.02452
G1 X137.063 Y124.613 E.08237
G2 X134.482 Y119.518 I-9.106 J1.41 E.19264
G1 X133.174 Y120.826 E.06139
G2 X131.905 Y119.813 I-5.206 J5.218 E.05397
G1 X130.964 Y117.326 F30000
G1 F4390
G2 X129.386 Y116.938 I-3.028 J8.91 E.05399
G1 X127.634 Y118.69 E.08215
G3 X128.367 Y118.691 I.36 J3.426 E.02434
G1 X126.614 Y116.938 E.08222
G2 X125.036 Y117.326 I1.45 J9.297 E.05398
G1 X121.81 Y122.093 F30000
G1 F4390
G3 X122.822 Y120.822 I6.864 J4.43 E.05397
G1 X121.518 Y119.518 E.06122
G2 X118.937 Y124.613 I6.525 J6.505 E.19264
G1 X120.684 Y126.36 E.08193
G1 X120.684 Y125.64 E.02386
G1 X118.937 Y127.387 E.08193
G2 X121.518 Y132.482 I9.588 J-1.654 E.1923
G1 X122.822 Y131.178 E.06122
G3 X121.81 Y129.907 I5.852 J-5.701 E.05397
G1 X125.036 Y134.674 F30000
G1 F4390
G2 X126.614 Y135.062 I3.028 J-8.91 E.05399
G1 X128.367 Y133.309 E.08222
G3 X127.634 Y133.31 I-.372 J-3.425 E.02434
G1 X129.386 Y135.062 E.08215
G2 X130.964 Y134.674 I-1.45 J-9.298 E.05399
; CHANGE_LAYER
; Z_HEIGHT: 21.8
; LAYER_HEIGHT: 0.199999
; WIPE_START
G1 F15476.087
G1 X129.386 Y135.062 E-.61765
G1 X129.121 Y134.797 E-.14235
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 109/250
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L109
M991 S0 P108 ;notify layer change
G17
G3 Z22 I1.009 J-.68 P1  F30000
G1 X121.495 Y123.477 Z22
G1 Z21.8
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4409
G1 X121.501 Y123.459 E.00064
G3 X127.074 Y119.084 I6.499 J2.541 E.2465
G1 X127.529 Y119.047 E.01515
G1 X127.814 Y119.025 E.00949
G3 X121.268 Y124.164 I.186 J6.975 E1.15854
G1 X121.476 Y123.534 E.02201
G1 X121.863 Y123.613 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4409
G1 X121.878 Y123.606 E.00049
G3 X127.56 Y119.438 I6.128 J2.397 E.2285
G3 X134.252 Y123.932 I.433 J6.585 E.26644
G3 X121.658 Y124.27 I-6.246 J2.072 E.7539
G1 X121.845 Y123.67 E.01933
M204 S10000
; WIPE_START
G1 F12000
G1 X121.878 Y123.606 E-.02721
G1 X122.157 Y122.964 E-.26617
G1 X122.512 Y122.36 E-.26637
G1 X122.827 Y121.937 E-.20025
; WIPE_END
G1 E-.04 F1800
G1 X130.069 Y124.344 Z22.2 F30000
G1 X137.478 Y126.807 Z22.2
G1 Z21.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4409
G3 X119.323 Y122.078 I-9.484 J-.803 E1.09946
G3 X128.753 Y116.516 I8.682 J3.946 E.38683
G3 X137.483 Y126.747 I-.76 J9.488 E.4954
G1 X137.877 Y126.841 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4409
G3 X118.788 Y122.356 I-9.875 J-.837 E1.04568
G3 X128.787 Y116.125 I9.188 J3.605 E.3879
G3 X137.882 Y126.781 I-.784 J9.879 E.47809
M204 S10000
; WIPE_START
G1 F12000
G1 X137.772 Y127.676 E-.34255
G1 X137.595 Y128.498 E-.3198
G1 X137.52 Y128.744 E-.09765
; WIPE_END
G1 E-.04 F1800
G1 X133.458 Y122.282 Z22.2 F30000
G1 X131.905 Y119.813 Z22.2
G1 Z21.8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
M73 P59 R10
G1 F4409
G3 X133.174 Y120.826 I-3.937 J6.231 E.05397
G1 X134.482 Y119.518 E.06139
G3 X137.063 Y124.613 I-6.525 J6.505 E.19264
G1 X135.307 Y126.369 E.08237
G2 X135.307 Y125.631 I-3.451 J-.369 E.02452
G1 X137.063 Y127.387 E.08237
G3 X134.482 Y132.482 I-9.106 J-1.41 E.19264
G1 X133.174 Y131.174 E.06139
G3 X131.905 Y132.187 I-5.206 J-5.218 E.05397
G1 X130.964 Y134.674 F30000
G1 F4409
G3 X129.386 Y135.062 I-3.028 J-8.909 E.05399
G1 X127.634 Y133.31 E.08215
G2 X128.367 Y133.309 I.36 J-3.426 E.02434
G1 X126.614 Y135.062 E.08222
G3 X125.036 Y134.674 I1.45 J-9.298 E.05399
G1 X121.81 Y129.907 F30000
G1 F4409
G2 X122.822 Y131.178 I6.864 J-4.43 E.05397
G1 X121.518 Y132.482 E.06122
G3 X118.937 Y127.387 I6.525 J-6.505 E.19264
G1 X120.684 Y125.64 E.08193
G1 X120.684 Y126.36 E.02386
G1 X118.937 Y124.613 E.08193
G3 X121.518 Y119.518 I9.106 J1.41 E.19264
G1 X122.822 Y120.822 E.06122
G2 X121.81 Y122.093 I5.852 J5.701 E.05397
G1 X125.036 Y117.326 F30000
G1 F4409
G3 X126.614 Y116.938 I3.028 J8.909 E.05398
G1 X128.367 Y118.691 E.08222
G2 X127.634 Y118.69 I-.372 J3.425 E.02434
G1 X129.386 Y116.938 E.08215
G3 X130.964 Y117.326 I-1.45 J9.297 E.05399
; CHANGE_LAYER
; Z_HEIGHT: 22
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F15476.087
G1 X129.386 Y116.938 E-.61765
G1 X129.121 Y117.203 E-.14235
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 110/250
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L110
M991 S0 P109 ;notify layer change
G17
G3 Z22.2 I-.771 J-.941 P1  F30000
G1 X121.509 Y123.441 Z22.2
G1 Z22
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4408
G1 X121.81 Y122.784 E.02399
G3 X127.074 Y119.084 I6.189 J3.211 E.22183
G1 X127.52 Y119.048 E.01483
G1 X127.814 Y119.025 E.00981
G3 X121.489 Y123.498 I.185 J6.971 E1.18088
G1 X121.863 Y123.613 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4408
G1 X121.877 Y123.606 E.00049
G3 X127.551 Y119.439 I6.128 J2.398 E.22823
G3 X134.436 Y124.608 I.46 J6.558 E.28845
G3 X121.657 Y124.27 I-6.431 J1.396 E.7324
G1 X121.845 Y123.671 E.01931
M204 S10000
; WIPE_START
G1 F12000
G1 X121.877 Y123.606 E-.02745
G1 X122.157 Y122.964 E-.26618
G1 X122.512 Y122.36 E-.26637
G1 X122.826 Y121.937 E-.2
; WIPE_END
G1 E-.04 F1800
G1 X130.069 Y124.344 Z22.4 F30000
G1 X137.478 Y126.807 Z22.4
G1 Z22
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4408
G3 X119.323 Y122.078 I-9.484 J-.803 E1.09946
G3 X128.765 Y116.517 I8.682 J3.946 E.38721
G3 X137.482 Y126.747 I-.771 J9.487 E.49502
G1 X137.879 Y126.841 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4408
G3 X125.545 Y135.597 I-9.871 J-.839 E.52882
G3 X128.798 Y116.126 I2.455 J-9.597 E.90455
G3 X137.884 Y126.781 I-.79 J9.875 E.47784
M204 S10000
; WIPE_START
G1 F12000
G1 X137.772 Y127.676 E-.34257
G1 X137.595 Y128.498 E-.3198
G1 X137.52 Y128.744 E-.09763
; WIPE_END
G1 E-.04 F1800
G1 X131.905 Y132.187 Z22.4 F30000
G1 Z22
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4408
G2 X133.174 Y131.174 I-3.937 J-6.231 E.05397
G1 X134.482 Y132.482 E.06139
G2 X137.063 Y127.387 I-6.525 J-6.505 E.19264
G1 X135.307 Y125.631 E.08237
G3 X135.307 Y126.369 I-3.451 J.369 E.02452
G1 X137.063 Y124.613 E.08237
G2 X134.482 Y119.518 I-9.106 J1.41 E.19264
G1 X133.174 Y120.826 E.06139
G2 X131.905 Y119.813 I-5.206 J5.218 E.05397
G1 X130.964 Y117.326 F30000
G1 F4408
G2 X129.386 Y116.938 I-3.028 J8.91 E.05399
G1 X127.634 Y118.69 E.08215
G3 X128.367 Y118.691 I.36 J3.426 E.02434
G1 X126.614 Y116.938 E.08222
G2 X125.036 Y117.326 I1.45 J9.297 E.05398
G1 X121.81 Y122.093 F30000
G1 F4408
G3 X122.822 Y120.822 I6.864 J4.43 E.05397
G1 X121.518 Y119.518 E.06122
G2 X118.937 Y124.613 I6.525 J6.505 E.19264
G1 X120.684 Y126.36 E.08193
G1 X120.684 Y125.64 E.02386
G1 X118.937 Y127.387 E.08193
G2 X121.518 Y132.482 I9.106 J-1.41 E.19264
G1 X122.822 Y131.178 E.06122
G3 X121.81 Y129.907 I5.852 J-5.701 E.05397
G1 X125.036 Y134.674 F30000
G1 F4408
G2 X126.614 Y135.062 I3.028 J-8.909 E.05398
G1 X128.367 Y133.309 E.08222
G3 X127.634 Y133.31 I-.372 J-3.425 E.02434
G1 X129.386 Y135.062 E.08215
G2 X130.964 Y134.674 I-1.45 J-9.298 E.05399
; CHANGE_LAYER
; Z_HEIGHT: 22.2
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F15476.087
G1 X129.386 Y135.062 E-.61765
G1 X129.121 Y134.797 E-.14235
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 111/250
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L111
M991 S0 P110 ;notify layer change
G17
G3 Z22.4 I1.011 J-.678 P1  F30000
G1 X121.509 Y123.441 Z22.4
G1 Z22.2
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4422
G1 X121.808 Y122.783 E.024
G3 X127.074 Y119.084 I6.192 J3.217 E.22185
G1 X127.51 Y119.049 E.01452
G3 X134.012 Y122.458 I.483 J6.984 E.25633
G1 X134.354 Y123.117 E.02464
G3 X121.487 Y123.497 I-6.354 J2.883 E.91072
G1 X121.863 Y123.614 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4422
G1 X121.877 Y123.606 E.00051
G3 X127.541 Y119.44 I6.128 J2.398 E.22793
G3 X134.436 Y124.608 I.452 J6.581 E.28853
G3 X121.657 Y124.27 I-6.431 J1.396 E.7324
G1 X121.845 Y123.671 E.01929
M204 S10000
; WIPE_START
G1 F12000
G1 X121.877 Y123.606 E-.0277
G1 X122.157 Y122.964 E-.26617
G1 X122.512 Y122.36 E-.26637
G1 X122.826 Y121.938 E-.19976
; WIPE_END
G1 E-.04 F1800
G1 X130.069 Y124.345 Z22.6 F30000
G1 X137.478 Y126.807 Z22.6
G1 Z22.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4422
G3 X119.323 Y122.078 I-9.484 J-.803 E1.09946
G3 X128.776 Y116.518 I8.682 J3.946 E.38758
G3 X137.482 Y126.747 I-.783 J9.486 E.49464
G1 X137.879 Y126.842 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4422
G1 X137.763 Y127.674 E.02582
G3 X118.797 Y122.335 I-9.763 J-1.674 E1.0199
G3 X128.809 Y116.127 I9.179 J3.626 E.3879
G3 X137.874 Y126.789 I-.809 J9.873 E.4775
M204 S10000
; WIPE_START
G1 F12000
G1 X137.763 Y127.674 E-.3389
G1 X137.595 Y128.498 E-.31967
G1 X137.517 Y128.754 E-.10142
; WIPE_END
G1 E-.04 F1800
G1 X133.459 Y122.289 Z22.6 F30000
G1 X131.905 Y119.813 Z22.6
G1 Z22.2
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4422
G3 X133.174 Y120.826 I-3.937 J6.231 E.05397
G1 X134.482 Y119.518 E.06139
G3 X137.063 Y124.613 I-6.525 J6.505 E.19264
G1 X135.307 Y126.369 E.08237
G2 X135.307 Y125.631 I-3.451 J-.369 E.02452
G1 X137.063 Y127.387 E.08237
G3 X134.482 Y132.482 I-9.106 J-1.41 E.19264
G1 X133.174 Y131.174 E.06139
G3 X131.905 Y132.187 I-5.206 J-5.218 E.05397
G1 X130.964 Y134.674 F30000
G1 F4422
G3 X129.386 Y135.062 I-3.028 J-8.909 E.05399
G1 X127.634 Y133.31 E.08215
G2 X128.367 Y133.309 I.36 J-3.426 E.02434
G1 X126.614 Y135.062 E.08222
G3 X125.036 Y134.674 I1.45 J-9.298 E.05399
G1 X121.81 Y129.907 F30000
G1 F4422
G2 X122.822 Y131.178 I6.864 J-4.43 E.05397
G1 X121.518 Y132.482 E.06122
G3 X118.937 Y127.387 I6.525 J-6.505 E.19264
G1 X120.684 Y125.64 E.08193
G1 X120.684 Y126.36 E.02386
G1 X118.937 Y124.613 E.08193
G3 X121.518 Y119.518 I9.106 J1.41 E.19264
G1 X122.822 Y120.822 E.06122
G2 X121.81 Y122.093 I5.852 J5.701 E.05397
G1 X125.036 Y117.326 F30000
G1 F4422
G3 X126.614 Y116.938 I3.028 J8.909 E.05398
G1 X128.367 Y118.691 E.08222
G2 X127.634 Y118.69 I-.372 J3.425 E.02434
G1 X129.386 Y116.938 E.08215
G3 X130.964 Y117.326 I-1.45 J9.298 E.05399
; CHANGE_LAYER
; Z_HEIGHT: 22.4
; LAYER_HEIGHT: 0.199999
; WIPE_START
G1 F15476.087
G1 X129.386 Y116.938 E-.61766
G1 X129.121 Y117.203 E-.14235
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 112/250
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L112
M991 S0 P111 ;notify layer change
G17
G3 Z22.6 I-.773 J-.94 P1  F30000
G1 X121.495 Y123.477 Z22.6
G1 Z22.4
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4390
G1 X121.506 Y123.461 E.00065
G3 X127.074 Y119.084 I6.497 J2.534 E.24642
G1 X127.501 Y119.05 E.0142
G3 X134.012 Y122.458 I.493 J6.983 E.25665
G1 X134.354 Y123.117 E.02464
G3 X121.273 Y124.166 I-6.352 J2.879 E.88657
G1 X121.477 Y123.534 E.022
G1 X121.863 Y123.615 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4390
G1 X121.877 Y123.606 E.00052
G3 X127.532 Y119.44 I6.128 J2.398 E.22764
G3 X134.436 Y124.608 I.461 J6.58 E.28882
G3 X121.657 Y124.27 I-6.431 J1.396 E.73239
G1 X121.845 Y123.672 E.01927
M204 S10000
; WIPE_START
G1 F12000
G1 X121.877 Y123.606 E-.02792
G1 X122.157 Y122.964 E-.26617
G1 X122.512 Y122.36 E-.26637
G1 X122.826 Y121.938 E-.19954
; WIPE_END
G1 E-.04 F1800
G1 X130.069 Y124.345 Z22.8 F30000
G1 X137.48 Y126.807 Z22.8
G1 Z22.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4390
G3 X119.496 Y121.734 I-9.48 J-.807 E1.11139
G3 X128.787 Y116.519 I8.504 J4.266 E.37515
G3 X137.484 Y126.747 I-.787 J9.481 E.49438
G1 X137.879 Y126.843 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4390
G1 X137.762 Y127.674 E.0258
G3 X118.652 Y122.697 I-9.768 J-1.67 E1.00869
G1 X118.965 Y121.916 E.02586
G1 X119.146 Y121.558 E.01233
G3 X128.821 Y116.128 I8.854 J4.442 E.36182
G3 X137.873 Y126.791 I-.827 J9.876 E.47709
M204 S10000
; WIPE_START
G1 F12000
G1 X137.762 Y127.674 E-.33826
G1 X137.595 Y128.498 E-.31966
G1 X137.516 Y128.755 E-.10208
; WIPE_END
G1 E-.04 F1800
G1 X131.905 Y132.187 Z22.8 F30000
G1 Z22.4
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4390
G2 X133.174 Y131.174 I-3.937 J-6.231 E.05397
G1 X134.482 Y132.482 E.06139
G2 X137.063 Y127.387 I-6.525 J-6.505 E.19264
G1 X135.307 Y125.631 E.08237
G3 X135.307 Y126.369 I-3.451 J.369 E.02452
G1 X137.063 Y124.613 E.08237
G2 X134.482 Y119.518 I-9.106 J1.41 E.19264
G1 X133.174 Y120.826 E.06139
G2 X131.905 Y119.813 I-5.206 J5.218 E.05397
G1 X130.964 Y117.326 F30000
G1 F4390
G2 X129.386 Y116.938 I-3.028 J8.91 E.05399
G1 X127.634 Y118.69 E.08215
G3 X128.367 Y118.691 I.36 J3.426 E.02434
G1 X126.614 Y116.938 E.08222
G2 X125.036 Y117.326 I1.45 J9.298 E.05399
G1 X121.81 Y122.093 F30000
G1 F4390
G3 X122.822 Y120.822 I6.864 J4.431 E.05397
G1 X121.518 Y119.518 E.06122
G2 X118.937 Y124.613 I6.525 J6.505 E.19264
G1 X120.684 Y126.36 E.08193
G1 X120.684 Y125.64 E.02386
G1 X118.937 Y127.387 E.08193
G2 X121.518 Y132.482 I9.106 J-1.41 E.19264
G1 X122.822 Y131.178 E.06122
G3 X121.81 Y129.907 I5.852 J-5.701 E.05397
G1 X125.036 Y134.674 F30000
M73 P60 R10
G1 F4390
G2 X126.614 Y135.062 I3.028 J-8.91 E.05399
G1 X128.367 Y133.309 E.08222
G3 X127.634 Y133.31 I-.372 J-3.425 E.02434
G1 X129.386 Y135.062 E.08215
G2 X130.964 Y134.674 I-1.45 J-9.298 E.05398
; CHANGE_LAYER
; Z_HEIGHT: 22.6
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F15476.087
G1 X129.386 Y135.062 E-.61765
G1 X129.121 Y134.797 E-.14235
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 113/250
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L113
M991 S0 P112 ;notify layer change
G17
G3 Z22.8 I1.009 J-.68 P1  F30000
G1 X121.495 Y123.477 Z22.8
G1 Z22.6
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4408
G1 X121.504 Y123.46 E.00064
G3 X127.074 Y119.084 I6.496 J2.535 E.24647
G1 X127.491 Y119.05 E.01389
G1 X127.814 Y119.025 E.01075
G3 X121.393 Y123.764 I.185 J6.971 E1.17148
G1 X121.475 Y123.534 E.00812
G1 X121.863 Y123.615 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4408
G1 X121.877 Y123.606 E.00054
G3 X127.523 Y119.441 I6.128 J2.398 E.22734
G3 X134.436 Y124.608 I.488 J6.556 E.28932
G3 X121.657 Y124.27 I-6.431 J1.396 E.73239
G1 X121.845 Y123.672 E.01925
M204 S10000
; WIPE_START
G1 F12000
G1 X121.877 Y123.606 E-.02811
G1 X122.157 Y122.964 E-.26617
G1 X122.512 Y122.36 E-.26637
G1 X122.825 Y121.939 E-.19935
; WIPE_END
G1 E-.04 F1800
G1 X130.068 Y124.345 Z23 F30000
G1 X137.478 Y126.807 Z23
G1 Z22.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4408
G3 X119.323 Y122.078 I-9.484 J-.803 E1.09946
G3 X128.799 Y116.52 I8.682 J3.946 E.38834
G3 X137.482 Y126.747 I-.805 J9.484 E.49388
G1 X137.879 Y126.843 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4408
G1 X137.772 Y127.676 E.02578
G3 X125.512 Y135.588 I-9.764 J-1.674 E.504
G3 X128.832 Y116.129 I2.479 J-9.59 E.90507
G3 X137.884 Y126.784 I-.824 J9.872 E.47687
M204 S10000
; WIPE_START
G1 F12000
G1 X137.772 Y127.676 E-.34161
G1 X137.595 Y128.498 E-.3198
G1 X137.519 Y128.746 E-.09858
; WIPE_END
G1 E-.04 F1800
G1 X133.458 Y122.284 Z23 F30000
G1 X131.905 Y119.813 Z23
G1 Z22.6
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4408
G3 X133.174 Y120.826 I-3.937 J6.231 E.05397
G1 X134.482 Y119.518 E.06139
G3 X137.063 Y124.613 I-6.525 J6.505 E.19264
G1 X135.307 Y126.369 E.08237
G2 X135.307 Y125.631 I-3.451 J-.369 E.02452
G1 X137.063 Y127.387 E.08237
G3 X134.482 Y132.482 I-9.106 J-1.41 E.19264
G1 X133.174 Y131.174 E.06139
G3 X131.905 Y132.187 I-5.206 J-5.218 E.05397
G1 X130.964 Y134.674 F30000
G1 F4408
G3 X129.386 Y135.062 I-3.028 J-8.909 E.05399
G1 X127.634 Y133.31 E.08215
G2 X128.367 Y133.309 I.36 J-3.426 E.02434
G1 X126.614 Y135.062 E.08222
G3 X125.036 Y134.674 I1.45 J-9.298 E.05399
G1 X121.81 Y129.907 F30000
G1 F4408
G2 X122.822 Y131.178 I6.864 J-4.43 E.05397
G1 X121.518 Y132.482 E.06122
G3 X118.937 Y127.387 I6.525 J-6.505 E.19264
G1 X120.684 Y125.64 E.08193
G1 X120.684 Y126.36 E.02386
G1 X118.937 Y124.613 E.08193
G3 X121.518 Y119.518 I9.106 J1.41 E.19264
G1 X122.822 Y120.822 E.06122
G2 X121.81 Y122.093 I5.852 J5.701 E.05397
G1 X125.036 Y117.326 F30000
G1 F4408
G3 X126.614 Y116.938 I3.028 J8.909 E.05398
G1 X128.367 Y118.691 E.08222
G2 X127.634 Y118.69 I-.372 J3.425 E.02434
G1 X129.386 Y116.938 E.08215
G3 X130.964 Y117.326 I-1.45 J9.298 E.05399
; CHANGE_LAYER
; Z_HEIGHT: 22.8
; LAYER_HEIGHT: 0.199999
; WIPE_START
G1 F15476.087
G1 X129.386 Y116.938 E-.61765
G1 X129.121 Y117.203 E-.14235
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 114/250
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L114
M991 S0 P113 ;notify layer change
G17
G3 Z23 I-.789 J-.927 P1  F30000
G1 X121.396 Y123.776 Z23
G1 Z22.8
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4409
G1 X121.504 Y123.46 E.01106
G3 X127.074 Y119.084 I6.496 J2.535 E.24647
G1 X127.482 Y119.051 E.01358
G1 X127.814 Y119.025 E.01106
G3 X121.373 Y123.824 I.185 J6.971 E1.1694
G1 X121.862 Y123.616 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4409
G1 X121.869 Y123.603 E.00047
G3 X127.126 Y119.473 I6.13 J2.392 E.21546
G1 X127.513 Y119.442 E.01193
G1 X127.825 Y119.417 E.00961
G3 X121.763 Y123.897 I.175 J6.578 E1.02388
G1 X121.842 Y123.673 E.00729
M204 S10000
; WIPE_START
G1 F12000
G1 X121.869 Y123.603 E-.02859
G1 X122.157 Y122.964 E-.26631
G1 X122.512 Y122.36 E-.26637
G1 X122.824 Y121.94 E-.19873
; WIPE_END
G1 E-.04 F1800
G1 X130.068 Y124.345 Z23.2 F30000
G1 X137.486 Y126.807 Z23.2
G1 Z22.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4409
G3 X119.506 Y121.714 I-9.484 J-.803 E1.11282
G3 X128.81 Y116.521 I8.494 J4.286 E.37515
G3 X137.491 Y126.748 I-.808 J9.483 E.49379
G1 X137.879 Y126.844 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4409
G1 X137.763 Y127.674 E.02575
G3 X118.652 Y122.697 I-9.769 J-1.67 E1.00873
G3 X128.843 Y116.13 I9.354 J3.326 E.40074
G3 X137.873 Y126.791 I-.849 J9.874 E.4764
M204 S10000
; WIPE_START
G1 F12000
G1 X137.763 Y127.674 E-.33831
G1 X137.595 Y128.498 E-.31966
G1 X137.516 Y128.755 E-.10203
; WIPE_END
G1 E-.04 F1800
G1 X131.905 Y132.187 Z23.2 F30000
G1 Z22.8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4409
G2 X133.174 Y131.174 I-3.937 J-6.231 E.05397
G1 X134.482 Y132.482 E.06139
G2 X137.063 Y127.387 I-6.525 J-6.505 E.19264
G1 X135.307 Y125.631 E.08237
G3 X135.307 Y126.369 I-3.451 J.369 E.02452
G1 X137.063 Y124.613 E.08237
G2 X134.482 Y119.518 I-9.106 J1.41 E.19264
G1 X133.174 Y120.826 E.06139
G2 X131.905 Y119.813 I-5.206 J5.218 E.05397
G1 X130.964 Y117.326 F30000
G1 F4409
G2 X129.386 Y116.938 I-3.028 J8.91 E.05399
G1 X127.634 Y118.69 E.08215
G3 X128.367 Y118.691 I.36 J3.426 E.02434
G1 X126.614 Y116.938 E.08222
G2 X125.036 Y117.326 I1.45 J9.297 E.05398
G1 X121.81 Y122.093 F30000
G1 F4409
G3 X122.822 Y120.822 I6.864 J4.43 E.05397
G1 X121.518 Y119.518 E.06122
G2 X118.937 Y124.613 I6.525 J6.505 E.19264
G1 X120.684 Y126.36 E.08193
G1 X120.684 Y125.64 E.02386
G1 X118.937 Y127.387 E.08193
G2 X121.518 Y132.482 I9.106 J-1.41 E.19264
G1 X122.822 Y131.178 E.06122
G3 X121.81 Y129.907 I5.852 J-5.701 E.05397
G1 X125.036 Y134.674 F30000
G1 F4409
G2 X126.614 Y135.062 I3.028 J-8.91 E.05399
G1 X128.367 Y133.309 E.08222
G3 X127.634 Y133.31 I-.372 J-3.425 E.02434
G1 X129.386 Y135.062 E.08215
G2 X130.964 Y134.674 I-1.45 J-9.298 E.05399
; CHANGE_LAYER
; Z_HEIGHT: 23
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F15476.087
G1 X129.386 Y135.062 E-.61765
G1 X129.121 Y134.797 E-.14235
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 115/250
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L115
M991 S0 P114 ;notify layer change
G17
G3 Z23.2 I1.011 J-.678 P1  F30000
G1 X121.509 Y123.441 Z23.2
G1 Z23
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4427
G1 X121.808 Y122.783 E.024
G3 X127.074 Y119.084 I6.192 J3.217 E.22185
G1 X127.472 Y119.052 E.01326
G1 X127.814 Y119.025 E.01138
G3 X121.487 Y123.497 I.186 J6.975 E1.18185
G1 X121.862 Y123.616 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4427
G1 X121.867 Y123.602 E.00045
G3 X127.126 Y119.473 I6.133 J2.398 E.21549
G1 X127.504 Y119.443 E.01164
G1 X127.825 Y119.417 E.0099
G3 X121.647 Y124.267 I.175 J6.583 E1.01279
G1 X121.843 Y123.673 E.01924
M204 S10000
; WIPE_START
G1 F12000
G1 X121.867 Y123.602 E-.02836
G1 X122.157 Y122.964 E-.26637
G1 X122.512 Y122.36 E-.26637
G1 X122.825 Y121.939 E-.1989
; WIPE_END
G1 E-.04 F1800
G1 X130.068 Y124.345 Z23.4 F30000
G1 X137.478 Y126.807 Z23.4
G1 Z23
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4427
G3 X119.323 Y122.078 I-9.484 J-.803 E1.09946
G3 X128.821 Y116.522 I8.682 J3.946 E.38909
G3 X137.482 Y126.747 I-.828 J9.482 E.49313
G1 X137.879 Y126.845 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4427
G1 X137.763 Y127.674 E.02572
G3 X130.089 Y135.692 I-9.775 J-1.674 E.36194
G3 X128.855 Y116.131 I-2.088 J-9.688 E1.04759
G1 X129.259 Y116.165 E.01248
G3 X137.874 Y126.79 I-1.271 J9.835 E.46378
M204 S10000
; WIPE_START
G1 F12000
G1 X137.763 Y127.674 E-.33842
G1 X137.595 Y128.498 E-.31967
G1 X137.516 Y128.755 E-.10191
; WIPE_END
G1 E-.04 F1800
G1 X133.459 Y122.29 Z23.4 F30000
G1 X131.905 Y119.813 Z23.4
G1 Z23
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4427
G3 X133.174 Y120.826 I-3.937 J6.231 E.05397
G1 X134.482 Y119.518 E.06139
G3 X137.063 Y124.613 I-6.525 J6.505 E.19264
G1 X135.307 Y126.369 E.08237
G2 X135.307 Y125.631 I-3.451 J-.369 E.02452
G1 X137.063 Y127.387 E.08237
G3 X134.482 Y132.482 I-9.106 J-1.41 E.19264
G1 X133.174 Y131.174 E.06139
G3 X131.905 Y132.187 I-5.206 J-5.218 E.05397
G1 X130.964 Y134.674 F30000
G1 F4427
G3 X129.386 Y135.062 I-3.028 J-8.909 E.05399
G1 X127.634 Y133.31 E.08215
G2 X128.367 Y133.309 I.36 J-3.426 E.02434
G1 X126.614 Y135.062 E.08222
G3 X125.036 Y134.674 I1.45 J-9.298 E.05399
G1 X121.81 Y129.907 F30000
G1 F4427
G2 X122.822 Y131.178 I6.864 J-4.43 E.05397
G1 X121.518 Y132.482 E.06122
G3 X118.937 Y127.387 I6.525 J-6.505 E.19264
G1 X120.684 Y125.64 E.08193
G1 X120.684 Y126.36 E.02386
G1 X118.937 Y124.613 E.08193
G3 X121.518 Y119.518 I9.106 J1.41 E.19264
G1 X122.822 Y120.822 E.06122
G2 X121.81 Y122.093 I5.852 J5.701 E.05397
G1 X125.036 Y117.326 F30000
G1 F4427
G3 X126.614 Y116.938 I3.028 J8.909 E.05398
G1 X128.367 Y118.691 E.08222
G2 X127.634 Y118.69 I-.372 J3.425 E.02434
G1 X129.386 Y116.938 E.08215
G3 X130.964 Y117.326 I-1.45 J9.297 E.05399
; CHANGE_LAYER
; Z_HEIGHT: 23.2
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F15476.087
G1 X129.386 Y116.938 E-.61765
G1 X129.121 Y117.203 E-.14235
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 116/250
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L116
M991 S0 P115 ;notify layer change
G17
G3 Z23.4 I-.771 J-.941 P1  F30000
G1 X121.509 Y123.441 Z23.4
G1 Z23.2
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4408
G1 X121.81 Y122.784 E.02399
G3 X127.074 Y119.084 I6.189 J3.211 E.22183
G1 X127.463 Y119.053 E.01295
G1 X127.814 Y119.025 E.01169
G3 X121.489 Y123.498 I.185 J6.971 E1.18088
G1 X121.862 Y123.616 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4408
G1 X121.869 Y123.603 E.00046
G3 X127.126 Y119.473 I6.13 J2.392 E.21546
G1 X127.494 Y119.443 E.01135
G1 X127.825 Y119.417 E.01019
G3 X121.65 Y124.268 I.175 J6.578 E1.01194
G1 X121.844 Y123.673 E.01923
M204 S10000
; WIPE_START
G1 F12000
G1 X121.869 Y123.603 E-.02842
G1 X122.157 Y122.964 E-.26632
G1 X122.512 Y122.36 E-.26637
G1 X122.825 Y121.939 E-.1989
; WIPE_END
G1 E-.04 F1800
G1 X130.068 Y124.345 Z23.6 F30000
G1 X137.478 Y126.807 Z23.6
G1 Z23.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4408
G3 X119.323 Y122.078 I-9.484 J-.803 E1.09946
G3 X128.833 Y116.523 I8.682 J3.946 E.38947
M73 P61 R10
G3 X137.482 Y126.747 I-.839 J9.481 E.49275
G1 X137.878 Y126.846 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4408
G1 X137.763 Y127.674 E.0257
G3 X130.089 Y135.692 I-9.775 J-1.674 E.36194
G3 X128.866 Y116.132 I-2.085 J-9.688 E1.04768
G1 X129.259 Y116.165 E.01213
G3 X137.874 Y126.791 I-1.271 J9.835 E.46379
M204 S10000
; WIPE_START
G1 F12000
G1 X137.763 Y127.674 E-.33832
G1 X137.595 Y128.498 E-.31967
G1 X137.516 Y128.755 E-.10201
; WIPE_END
G1 E-.04 F1800
G1 X131.905 Y132.187 Z23.6 F30000
G1 Z23.2
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4408
G2 X133.174 Y131.174 I-3.937 J-6.231 E.05397
G1 X134.482 Y132.482 E.06139
G2 X137.063 Y127.387 I-6.525 J-6.505 E.19264
G1 X135.307 Y125.631 E.08237
G3 X135.307 Y126.369 I-3.451 J.369 E.02452
G1 X137.063 Y124.613 E.08237
G2 X134.482 Y119.518 I-9.106 J1.41 E.19264
G1 X133.174 Y120.826 E.06139
G2 X131.905 Y119.813 I-5.206 J5.218 E.05397
G1 X130.964 Y117.326 F30000
G1 F4408
G2 X129.386 Y116.938 I-3.028 J8.91 E.05399
G1 X127.634 Y118.69 E.08215
G3 X128.367 Y118.691 I.36 J3.426 E.02434
G1 X126.614 Y116.938 E.08222
G2 X125.036 Y117.326 I1.45 J9.297 E.05398
G1 X121.81 Y122.093 F30000
G1 F4408
G3 X122.822 Y120.822 I6.864 J4.43 E.05397
G1 X121.518 Y119.518 E.06122
G2 X118.937 Y124.613 I6.525 J6.505 E.19264
G1 X120.684 Y126.36 E.08193
G1 X120.684 Y125.64 E.02386
G1 X118.937 Y127.387 E.08193
G2 X121.518 Y132.482 I9.106 J-1.41 E.19264
G1 X122.822 Y131.178 E.06122
G3 X121.81 Y129.907 I5.852 J-5.701 E.05397
G1 X125.036 Y134.674 F30000
G1 F4408
G2 X126.614 Y135.062 I3.028 J-8.909 E.05399
G1 X128.367 Y133.309 E.08222
G3 X127.634 Y133.31 I-.372 J-3.425 E.02434
G1 X129.386 Y135.062 E.08215
G2 X130.964 Y134.674 I-1.45 J-9.298 E.05399
; CHANGE_LAYER
; Z_HEIGHT: 23.4
; LAYER_HEIGHT: 0.199999
; WIPE_START
G1 F15476.087
G1 X129.386 Y135.062 E-.61765
G1 X129.121 Y134.797 E-.14235
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 117/250
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L117
M991 S0 P116 ;notify layer change
G17
G3 Z23.6 I1.009 J-.68 P1  F30000
G1 X121.495 Y123.477 Z23.6
G1 Z23.4
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4409
G1 X121.501 Y123.459 E.00064
G3 X127.074 Y119.084 I6.499 J2.541 E.2465
G1 X127.453 Y119.053 E.01263
G1 X127.814 Y119.025 E.01201
G3 X121.268 Y124.164 I.186 J6.975 E1.15855
G1 X121.476 Y123.534 E.02201
G1 X121.862 Y123.616 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4409
G1 X121.867 Y123.602 E.00046
G3 X127.126 Y119.473 I6.133 J2.398 E.21549
G1 X127.485 Y119.444 E.01106
G1 X127.825 Y119.417 E.01048
G3 X121.647 Y124.267 I.175 J6.583 E1.0128
G1 X121.843 Y123.673 E.01923
M204 S10000
; WIPE_START
G1 F12000
G1 X121.867 Y123.602 E-.02851
G1 X122.157 Y122.964 E-.26636
G1 X122.512 Y122.36 E-.26637
G1 X122.824 Y121.94 E-.19876
; WIPE_END
G1 E-.04 F1800
G1 X130.068 Y124.346 Z23.8 F30000
G1 X137.478 Y126.807 Z23.8
G1 Z23.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4409
G3 X119.323 Y122.078 I-9.484 J-.803 E1.09946
G3 X128.844 Y116.524 I8.682 J3.946 E.38985
G3 X137.483 Y126.747 I-.851 J9.48 E.49238
G1 X137.878 Y126.846 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4409
G1 X137.763 Y127.674 E.02568
G3 X130.089 Y135.692 I-9.775 J-1.673 E.36194
G3 X128.877 Y116.133 I-2.085 J-9.688 E1.04803
G1 X129.259 Y116.165 E.01178
G3 X137.873 Y126.791 I-1.271 J9.835 E.4638
M204 S10000
; WIPE_START
G1 F12000
G1 X137.763 Y127.674 E-.33808
G1 X137.595 Y128.498 E-.31966
G1 X137.516 Y128.756 E-.10225
; WIPE_END
G1 E-.04 F1800
G1 X133.46 Y122.29 Z23.8 F30000
G1 X131.905 Y119.813 Z23.8
G1 Z23.4
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4409
G3 X133.174 Y120.826 I-3.937 J6.231 E.05397
G1 X134.482 Y119.518 E.06139
G3 X137.063 Y124.613 I-6.525 J6.505 E.19264
G1 X135.307 Y126.369 E.08237
G2 X135.307 Y125.631 I-3.451 J-.369 E.02452
G1 X137.063 Y127.387 E.08237
G3 X134.482 Y132.482 I-9.106 J-1.41 E.19264
G1 X133.174 Y131.174 E.06139
G3 X131.905 Y132.187 I-5.206 J-5.218 E.05397
G1 X130.964 Y134.674 F30000
G1 F4409
G3 X129.386 Y135.062 I-3.028 J-8.909 E.05399
G1 X127.634 Y133.31 E.08215
G2 X128.367 Y133.309 I.36 J-3.426 E.02434
G1 X126.614 Y135.062 E.08222
G3 X125.036 Y134.674 I1.45 J-9.298 E.05399
G1 X121.81 Y129.907 F30000
G1 F4409
G2 X122.822 Y131.178 I6.864 J-4.43 E.05397
G1 X121.518 Y132.482 E.06122
G3 X118.937 Y127.387 I6.525 J-6.505 E.19264
G1 X120.684 Y125.64 E.08193
G1 X120.684 Y126.36 E.02386
G1 X118.937 Y124.613 E.08193
G3 X121.518 Y119.518 I9.106 J1.41 E.19264
G1 X122.822 Y120.822 E.06122
G2 X121.81 Y122.093 I5.852 J5.701 E.05397
G1 X125.036 Y117.326 F30000
G1 F4409
G3 X126.614 Y116.938 I3.028 J8.909 E.05398
G1 X128.367 Y118.691 E.08222
G2 X127.634 Y118.69 I-.372 J3.425 E.02434
G1 X129.386 Y116.938 E.08215
G3 X130.964 Y117.326 I-1.45 J9.298 E.05399
; CHANGE_LAYER
; Z_HEIGHT: 23.6
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F15476.087
G1 X129.386 Y116.938 E-.61766
G1 X129.121 Y117.203 E-.14235
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 118/250
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L118
M991 S0 P117 ;notify layer change
G17
G3 Z23.8 I-.773 J-.94 P1  F30000
G1 X121.495 Y123.477 Z23.8
G1 Z23.6
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4391
G1 X121.501 Y123.459 E.00064
G3 X127.074 Y119.084 I6.499 J2.541 E.2465
G1 X127.444 Y119.054 E.01232
G1 X127.814 Y119.025 E.01232
G3 X121.268 Y124.164 I.186 J6.975 E1.15853
G1 X121.476 Y123.534 E.02201
G1 X121.862 Y123.616 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4391
G1 X121.867 Y123.602 E.00046
G3 X127.126 Y119.473 I6.133 J2.398 E.21549
G1 X127.475 Y119.445 E.01077
G1 X127.825 Y119.417 E.01077
G3 X121.647 Y124.267 I.175 J6.583 E1.01279
G1 X121.843 Y123.673 E.01923
M204 S10000
; WIPE_START
G1 F12000
G1 X121.867 Y123.602 E-.02852
G1 X122.157 Y122.964 E-.26637
G1 X122.512 Y122.36 E-.26637
G1 X122.824 Y121.94 E-.19875
; WIPE_END
G1 E-.04 F1800
G1 X130.068 Y124.345 Z24 F30000
G1 X137.486 Y126.807 Z24
G1 Z23.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4391
G3 X119.527 Y121.673 I-9.484 J-.803 E1.11434
G3 X128.855 Y116.525 I8.473 J4.327 E.37515
G3 X137.491 Y126.748 I-.853 J9.479 E.49228
G1 X137.878 Y126.847 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4391
G1 X137.763 Y127.674 E.02566
G3 X130.089 Y135.692 I-9.774 J-1.674 E.36195
G3 X128.889 Y116.134 I-2.088 J-9.688 E1.04866
G1 X129.259 Y116.165 E.01143
G3 X137.874 Y126.791 I-1.271 J9.835 E.46381
M204 S10000
; WIPE_START
G1 F12000
G1 X137.763 Y127.674 E-.33814
G1 X137.595 Y128.498 E-.31967
G1 X137.516 Y128.755 E-.10219
; WIPE_END
G1 E-.04 F1800
G1 X131.905 Y132.187 Z24 F30000
G1 Z23.6
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4391
G2 X133.174 Y131.174 I-3.937 J-6.231 E.05397
G1 X134.482 Y132.482 E.06139
G2 X137.063 Y127.387 I-6.525 J-6.505 E.19264
G1 X135.307 Y125.631 E.08237
G3 X135.307 Y126.369 I-3.451 J.369 E.02452
G1 X137.063 Y124.613 E.08237
G2 X134.482 Y119.518 I-9.106 J1.41 E.19264
G1 X133.174 Y120.826 E.06139
G2 X131.905 Y119.813 I-5.206 J5.218 E.05397
G1 X130.964 Y117.326 F30000
G1 F4391
G2 X129.386 Y116.938 I-3.028 J8.91 E.05399
G1 X127.634 Y118.69 E.08215
G3 X128.367 Y118.691 I.36 J3.426 E.02434
G1 X126.614 Y116.938 E.08222
G2 X125.036 Y117.326 I1.45 J9.297 E.05398
G1 X121.81 Y122.093 F30000
G1 F4391
G3 X122.822 Y120.822 I6.864 J4.43 E.05397
G1 X121.518 Y119.518 E.06122
G2 X118.937 Y124.613 I6.525 J6.505 E.19264
G1 X120.684 Y126.36 E.08193
G1 X120.684 Y125.64 E.02386
G1 X118.937 Y127.387 E.08193
G2 X121.518 Y132.482 I9.106 J-1.41 E.19264
G1 X122.822 Y131.178 E.06122
G3 X121.81 Y129.907 I5.852 J-5.701 E.05397
G1 X125.036 Y134.674 F30000
G1 F4391
G2 X126.614 Y135.062 I3.028 J-8.909 E.05399
G1 X128.367 Y133.309 E.08222
G3 X127.634 Y133.31 I-.372 J-3.425 E.02434
G1 X129.386 Y135.062 E.08215
G2 X130.964 Y134.674 I-1.45 J-9.298 E.05399
; CHANGE_LAYER
; Z_HEIGHT: 23.8
; LAYER_HEIGHT: 0.199999
; WIPE_START
G1 F15476.087
G1 X129.386 Y135.062 E-.61765
G1 X129.121 Y134.797 E-.14235
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 119/250
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L119
M991 S0 P118 ;notify layer change
G17
G3 Z24 I1.011 J-.678 P1  F30000
G1 X121.509 Y123.441 Z24
G1 Z23.8
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4427
G1 X121.808 Y122.783 E.024
G3 X127.074 Y119.084 I6.192 J3.217 E.22185
G1 X127.435 Y119.055 E.01201
G1 X127.814 Y119.025 E.01263
G3 X121.487 Y123.497 I.186 J6.975 E1.18185
G1 X121.862 Y123.616 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4427
G1 X121.867 Y123.602 E.00046
G3 X127.126 Y119.473 I6.133 J2.398 E.21549
G1 X127.466 Y119.446 E.01048
G1 X127.825 Y119.417 E.01106
G3 X121.647 Y124.267 I.175 J6.583 E1.0128
G1 X121.843 Y123.673 E.01924
M204 S10000
; WIPE_START
G1 F12000
G1 X121.867 Y123.602 E-.02848
G1 X122.157 Y122.964 E-.26636
G1 X122.512 Y122.36 E-.26637
G1 X122.824 Y121.94 E-.19879
; WIPE_END
G1 E-.04 F1800
G1 X130.068 Y124.345 Z24.2 F30000
G1 X137.484 Y126.807 Z24.2
G1 Z23.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4427
G3 X128.404 Y116.486 I-9.483 J-.811 E1.47431
G1 X128.867 Y116.526 E.0154
G1 X129.21 Y116.555 E.01141
G3 X137.489 Y126.747 I-1.209 J9.441 E.48069
G1 X137.878 Y126.847 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4427
G1 X137.767 Y127.675 E.02565
G3 X128.421 Y116.094 I-9.767 J-1.679 E1.39608
G1 X128.9 Y116.135 E.01478
G1 X129.259 Y116.165 E.01108
G3 X137.879 Y126.788 I-1.259 J9.83 E.46393
M204 S10000
; WIPE_START
G1 F12000
G1 X137.767 Y127.675 E-.3395
G1 X137.595 Y128.498 E-.31973
G1 X137.517 Y128.752 E-.10078
; WIPE_END
G1 E-.04 F1800
G1 X133.459 Y122.288 Z24.2 F30000
G1 X131.905 Y119.813 Z24.2
G1 Z23.8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4427
G3 X133.174 Y120.826 I-3.937 J6.231 E.05397
G1 X134.482 Y119.518 E.06139
G3 X137.063 Y124.613 I-6.525 J6.505 E.19264
G1 X135.307 Y126.369 E.08237
M73 P62 R10
G2 X135.307 Y125.631 I-3.451 J-.369 E.02452
G1 X137.063 Y127.387 E.08237
G3 X134.482 Y132.482 I-9.106 J-1.41 E.19264
G1 X133.174 Y131.174 E.06139
G3 X131.905 Y132.187 I-5.206 J-5.218 E.05397
G1 X130.964 Y134.674 F30000
G1 F4427
G3 X129.386 Y135.062 I-3.028 J-8.91 E.05398
G1 X127.634 Y133.31 E.08215
G2 X128.367 Y133.309 I.36 J-3.426 E.02434
G1 X126.614 Y135.062 E.08222
G3 X125.036 Y134.674 I1.45 J-9.298 E.05399
G1 X121.81 Y129.907 F30000
G1 F4427
G2 X122.822 Y131.178 I6.864 J-4.43 E.05397
G1 X121.518 Y132.482 E.06122
G3 X118.937 Y127.387 I6.525 J-6.505 E.19264
G1 X120.684 Y125.64 E.08193
G1 X120.684 Y126.36 E.02386
G1 X118.937 Y124.613 E.08193
G3 X121.518 Y119.518 I9.106 J1.41 E.19264
G1 X122.822 Y120.822 E.06122
G2 X121.81 Y122.093 I5.852 J5.701 E.05397
G1 X125.036 Y117.326 F30000
G1 F4427
G3 X126.614 Y116.938 I3.028 J8.909 E.05399
G1 X128.367 Y118.691 E.08222
G2 X127.634 Y118.69 I-.372 J3.425 E.02434
G1 X129.386 Y116.938 E.08215
G3 X130.964 Y117.326 I-1.45 J9.298 E.05399
; CHANGE_LAYER
; Z_HEIGHT: 24
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F15476.087
G1 X129.386 Y116.938 E-.61765
G1 X129.121 Y117.203 E-.14235
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 120/250
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L120
M991 S0 P119 ;notify layer change
G17
G3 Z24.2 I-.771 J-.941 P1  F30000
G1 X121.509 Y123.441 Z24.2
G1 Z24
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4409
G1 X121.808 Y122.783 E.024
G3 X127.074 Y119.084 I6.192 J3.217 E.22185
G1 X127.425 Y119.056 E.01169
G1 X127.814 Y119.025 E.01295
G3 X121.487 Y123.497 I.186 J6.975 E1.18183
G1 X121.862 Y123.616 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4409
G1 X121.867 Y123.602 E.00045
G3 X127.126 Y119.473 I6.133 J2.398 E.21549
G1 X127.456 Y119.447 E.01019
G1 X127.825 Y119.417 E.01135
G3 X121.647 Y124.267 I.175 J6.583 E1.01278
G1 X121.843 Y123.673 E.01924
M204 S10000
; WIPE_START
G1 F12000
G1 X121.867 Y123.602 E-.02838
G1 X122.157 Y122.964 E-.26636
G1 X122.512 Y122.36 E-.26637
G1 X122.825 Y121.94 E-.19888
; WIPE_END
G1 E-.04 F1800
G1 X130.068 Y124.345 Z24.4 F30000
G1 X137.484 Y126.807 Z24.4
G1 Z24
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4409
G3 X128.404 Y116.486 I-9.483 J-.811 E1.4743
M73 P62 R9
G1 X128.878 Y116.527 E.01578
G1 X129.21 Y116.555 E.01103
G3 X137.489 Y126.747 I-1.209 J9.441 E.48069
G1 X137.878 Y126.848 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4409
G1 X137.772 Y127.676 E.02565
G3 X118.965 Y121.916 I-9.772 J-1.676 E1.0347
G1 X119.344 Y121.165 E.02586
G3 X128.911 Y116.136 I8.642 J4.827 E.35131
G1 X129.259 Y116.165 E.01073
G3 X137.883 Y126.788 I-1.259 J9.834 E.46398
M204 S10000
; WIPE_START
G1 F12000
G1 X137.772 Y127.676 E-.33997
G1 X137.595 Y128.498 E-.3198
G1 X137.518 Y128.751 E-.10023
; WIPE_END
G1 E-.04 F1800
G1 X131.905 Y132.187 Z24.4 F30000
G1 Z24
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4409
G2 X133.174 Y131.174 I-3.937 J-6.231 E.05397
G1 X134.482 Y132.482 E.06139
G2 X137.063 Y127.387 I-6.525 J-6.505 E.19264
G1 X135.307 Y125.631 E.08237
G3 X135.307 Y126.369 I-3.451 J.369 E.02452
G1 X137.063 Y124.613 E.08237
G2 X134.482 Y119.518 I-9.106 J1.41 E.19264
G1 X133.174 Y120.826 E.06139
G2 X131.905 Y119.813 I-5.206 J5.218 E.05397
G1 X130.964 Y117.326 F30000
G1 F4409
G2 X129.386 Y116.938 I-3.028 J8.91 E.05399
G1 X127.634 Y118.69 E.08215
G3 X128.367 Y118.691 I.36 J3.426 E.02434
G1 X126.614 Y116.938 E.08222
G2 X125.036 Y117.326 I1.45 J9.297 E.05398
G1 X121.81 Y122.093 F30000
G1 F4409
G3 X122.822 Y120.822 I6.864 J4.43 E.05397
G1 X121.518 Y119.518 E.06122
G2 X118.937 Y124.613 I6.525 J6.505 E.19264
G1 X120.684 Y126.36 E.08193
G1 X120.684 Y125.64 E.02386
G1 X118.937 Y127.387 E.08193
G2 X121.518 Y132.482 I9.106 J-1.41 E.19264
G1 X122.822 Y131.178 E.06122
G3 X121.81 Y129.907 I5.852 J-5.701 E.05397
G1 X125.036 Y134.674 F30000
G1 F4409
G2 X126.614 Y135.062 I3.028 J-8.909 E.05399
G1 X128.367 Y133.309 E.08222
G3 X127.634 Y133.31 I-.372 J-3.425 E.02434
G1 X129.386 Y135.062 E.08215
G2 X130.964 Y134.674 I-1.45 J-9.298 E.05399
; CHANGE_LAYER
; Z_HEIGHT: 24.2
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F15476.087
G1 X129.386 Y135.062 E-.61765
G1 X129.121 Y134.797 E-.14235
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 121/250
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L121
M991 S0 P120 ;notify layer change
G17
G3 Z24.4 I1.009 J-.68 P1  F30000
G1 X121.495 Y123.477 Z24.4
G1 Z24.2
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4407
G1 X121.506 Y123.461 E.00065
G3 X127.074 Y119.084 I6.496 J2.534 E.24643
G1 X127.416 Y119.056 E.01138
G3 X133.127 Y121.267 I.578 J6.991 E.21023
G1 X133.601 Y121.839 E.02464
G3 X121.371 Y123.837 I-5.599 J4.156 E.94721
G1 X121.476 Y123.534 E.01063
G1 X121.862 Y123.615 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4407
G1 X121.871 Y123.604 E.00045
G3 X127.126 Y119.473 I6.131 J2.392 E.21542
G1 X127.447 Y119.447 E.0099
G3 X132.839 Y121.533 I.547 J6.598 E.18383
G1 X133.286 Y122.073 E.02154
G3 X121.744 Y123.96 I-5.284 J3.923 E.82798
G1 X121.843 Y123.672 E.00936
M204 S10000
; WIPE_START
G1 F12000
G1 X121.871 Y123.604 E-.02822
G1 X122.157 Y122.964 E-.26628
G1 X122.512 Y122.36 E-.26637
G1 X122.825 Y121.939 E-.19913
; WIPE_END
G1 E-.04 F1800
G1 X130.068 Y124.345 Z24.6 F30000
G1 X137.48 Y126.807 Z24.6
G1 Z24.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4407
G3 X130.006 Y135.309 I-9.49 J-.806 E.40208
G3 X128.89 Y116.528 I-2.002 J-9.305 E1.08819
G1 X129.21 Y116.555 E.01065
G3 X137.485 Y126.747 I-1.22 J9.446 E.48048
G1 X137.878 Y126.848 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4407
G1 X137.764 Y127.674 E.02563
G3 X130.089 Y135.692 I-9.774 J-1.674 E.36196
G3 X128.923 Y116.137 I-2.085 J-9.688 E1.04943
G1 X129.259 Y116.165 E.01038
G3 X137.874 Y126.791 I-1.27 J9.835 E.46383
M204 S10000
; WIPE_START
G1 F12000
G1 X137.764 Y127.674 E-.33809
G1 X137.595 Y128.498 E-.31968
G1 X137.516 Y128.756 E-.10223
; WIPE_END
G1 E-.04 F1800
G1 X133.46 Y122.29 Z24.6 F30000
G1 X131.905 Y119.813 Z24.6
G1 Z24.2
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4407
G3 X133.174 Y120.826 I-3.937 J6.231 E.05397
G1 X134.482 Y119.518 E.06139
G3 X137.063 Y124.613 I-6.525 J6.505 E.19264
G1 X135.307 Y126.369 E.08237
G2 X135.307 Y125.631 I-3.451 J-.369 E.02452
G1 X137.063 Y127.387 E.08237
G3 X134.482 Y132.482 I-9.106 J-1.41 E.19264
G1 X133.174 Y131.174 E.06139
G3 X131.905 Y132.187 I-5.206 J-5.218 E.05397
G1 X130.964 Y134.674 F30000
G1 F4407
G3 X129.386 Y135.062 I-3.028 J-8.909 E.05399
G1 X127.634 Y133.31 E.08215
G2 X128.367 Y133.309 I.36 J-3.426 E.02434
G1 X126.614 Y135.062 E.08222
G3 X125.036 Y134.674 I1.45 J-9.298 E.05398
G1 X121.81 Y129.907 F30000
G1 F4407
G2 X122.822 Y131.178 I6.864 J-4.43 E.05397
G1 X121.518 Y132.482 E.06122
G3 X118.937 Y127.387 I6.525 J-6.505 E.19264
G1 X120.684 Y125.64 E.08193
G1 X120.684 Y126.36 E.02386
G1 X118.937 Y124.613 E.08193
G3 X121.518 Y119.518 I9.106 J1.41 E.19264
G1 X122.822 Y120.822 E.06122
G2 X121.81 Y122.093 I5.852 J5.701 E.05397
G1 X125.036 Y117.326 F30000
G1 F4407
G3 X126.614 Y116.938 I3.028 J8.909 E.05399
G1 X128.367 Y118.691 E.08222
G2 X127.634 Y118.69 I-.372 J3.425 E.02434
G1 X129.386 Y116.938 E.08215
G3 X130.964 Y117.326 I-1.45 J9.298 E.05399
; CHANGE_LAYER
; Z_HEIGHT: 24.4
; LAYER_HEIGHT: 0.199999
; WIPE_START
G1 F15476.087
G1 X129.386 Y116.938 E-.61766
G1 X129.121 Y117.203 E-.14235
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 122/250
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L122
M991 S0 P121 ;notify layer change
G17
G3 Z24.6 I-.773 J-.94 P1  F30000
G1 X121.495 Y123.477 Z24.6
G1 Z24.4
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4389
G1 X121.506 Y123.461 E.00065
G3 X127.074 Y119.084 I6.496 J2.534 E.24643
G1 X127.406 Y119.057 E.01106
G3 X133.127 Y121.267 I.587 J6.991 E.21054
G1 X133.601 Y121.839 E.02464
G3 X121.273 Y124.165 I-5.599 J4.157 E.93584
G1 X121.477 Y123.534 E.022
G1 X121.863 Y123.615 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4389
G1 X121.871 Y123.604 E.00044
G3 X127.126 Y119.473 I6.131 J2.392 E.21542
G1 X127.438 Y119.448 E.00961
G3 X132.839 Y121.533 I.556 J6.597 E.18412
G1 X133.286 Y122.073 E.02154
G3 X121.652 Y124.269 I-5.284 J3.923 E.81809
G1 X121.844 Y123.672 E.01926
M204 S10000
; WIPE_START
G1 F12000
G1 X121.871 Y123.604 E-.028
G1 X122.157 Y122.964 E-.26628
G1 X122.512 Y122.36 E-.26637
G1 X122.825 Y121.939 E-.19935
; WIPE_END
G1 E-.04 F1800
G1 X130.068 Y124.345 Z24.8 F30000
G1 X137.48 Y126.807 Z24.8
G1 Z24.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4389
G3 X130.006 Y135.309 I-9.49 J-.806 E.40208
G3 X128.901 Y116.528 I-2.006 J-9.305 E1.08887
G1 X129.21 Y116.555 E.01028
G3 X137.484 Y126.747 I-1.22 J9.446 E.48048
G1 X137.878 Y126.848 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4389
G1 X137.763 Y127.674 E.02563
G3 X130.089 Y135.692 I-9.774 J-1.674 E.36195
G3 X128.934 Y116.138 I-2.088 J-9.688 E1.05007
G1 X129.259 Y116.165 E.01003
G3 X137.874 Y126.791 I-1.27 J9.835 E.46383
M204 S10000
; WIPE_START
G1 F12000
G1 X137.763 Y127.674 E-.33803
G1 X137.595 Y128.498 E-.31967
G1 X137.516 Y128.756 E-.1023
; WIPE_END
G1 E-.04 F1800
G1 X131.905 Y132.187 Z24.8 F30000
G1 Z24.4
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4389
G2 X133.174 Y131.174 I-3.937 J-6.231 E.05397
G1 X134.482 Y132.482 E.06139
G2 X137.063 Y127.387 I-6.525 J-6.505 E.19264
G1 X135.307 Y125.631 E.08237
G3 X135.307 Y126.369 I-3.451 J.369 E.02452
G1 X137.063 Y124.613 E.08237
G2 X134.482 Y119.518 I-9.106 J1.41 E.19264
G1 X133.174 Y120.826 E.06139
G2 X131.905 Y119.813 I-5.206 J5.218 E.05397
G1 X130.964 Y117.326 F30000
G1 F4389
G2 X129.386 Y116.938 I-3.028 J8.91 E.05399
G1 X127.634 Y118.69 E.08215
G3 X128.367 Y118.691 I.36 J3.426 E.02434
G1 X126.614 Y116.938 E.08222
G2 X125.036 Y117.326 I1.45 J9.297 E.05398
G1 X121.81 Y122.093 F30000
G1 F4389
G3 X122.822 Y120.822 I6.864 J4.43 E.05397
G1 X121.518 Y119.518 E.06122
G2 X118.937 Y124.613 I6.525 J6.505 E.19264
G1 X120.684 Y126.36 E.08193
G1 X120.684 Y125.64 E.02386
G1 X118.937 Y127.387 E.08193
G2 X121.518 Y132.482 I9.106 J-1.41 E.19264
G1 X122.822 Y131.178 E.06122
G3 X121.81 Y129.907 I5.852 J-5.701 E.05397
G1 X125.036 Y134.674 F30000
G1 F4389
G2 X126.614 Y135.062 I3.028 J-8.91 E.05399
G1 X128.367 Y133.309 E.08222
G3 X127.634 Y133.31 I-.372 J-3.425 E.02434
G1 X129.386 Y135.062 E.08215
G2 X130.964 Y134.674 I-1.45 J-9.298 E.05399
; CHANGE_LAYER
; Z_HEIGHT: 24.6
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F15476.087
G1 X129.386 Y135.062 E-.61765
G1 X129.121 Y134.797 E-.14235
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 123/250
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L123
M991 S0 P122 ;notify layer change
G17
G3 Z24.8 I1.009 J-.68 P1  F30000
G1 X121.495 Y123.477 Z24.8
G1 Z24.6
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4409
G1 X121.501 Y123.459 E.00064
G3 X127.074 Y119.084 I6.499 J2.541 E.2465
G1 X127.397 Y119.058 E.01075
G1 X127.814 Y119.025 E.01389
G3 X121.268 Y124.164 I.186 J6.975 E1.15855
G1 X121.476 Y123.534 E.02201
G1 X121.863 Y123.614 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4409
G1 X121.867 Y123.602 E.0004
G3 X127.126 Y119.473 I6.133 J2.398 E.21549
G1 X127.428 Y119.449 E.00931
G1 X127.825 Y119.417 E.01222
G3 X121.647 Y124.267 I.175 J6.583 E1.0128
G1 X121.844 Y123.671 E.01929
M204 S10000
; WIPE_START
G1 F12000
M73 P63 R9
G1 X121.867 Y123.602 E-.02781
G1 X122.157 Y122.964 E-.26637
G1 X122.512 Y122.36 E-.26637
G1 X122.825 Y121.938 E-.19946
; WIPE_END
G1 E-.04 F1800
G1 X130.069 Y124.344 Z25 F30000
G1 X137.484 Y126.807 Z25
G1 Z24.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4409
G3 X128.404 Y116.486 I-9.483 J-.811 E1.4743
G1 X128.912 Y116.529 E.01691
G1 X129.21 Y116.555 E.0099
G3 X137.489 Y126.747 I-1.209 J9.441 E.48069
G1 X137.878 Y126.848 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4409
G1 X137.767 Y127.675 E.02564
G3 X128.421 Y116.094 I-9.767 J-1.679 E1.39608
G1 X128.945 Y116.139 E.01618
G1 X129.259 Y116.165 E.00968
G3 X137.879 Y126.789 I-1.259 J9.83 E.46395
M204 S10000
; WIPE_START
G1 F12000
G1 X137.767 Y127.675 E-.33933
G1 X137.595 Y128.498 E-.31973
G1 X137.517 Y128.752 E-.10094
; WIPE_END
G1 E-.04 F1800
G1 X133.459 Y122.288 Z25 F30000
G1 X131.905 Y119.813 Z25
G1 Z24.6
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4409
G3 X133.174 Y120.826 I-3.937 J6.231 E.05397
G1 X134.482 Y119.518 E.06139
G3 X137.063 Y124.613 I-6.525 J6.505 E.19264
G1 X135.307 Y126.369 E.08237
G2 X135.307 Y125.631 I-3.451 J-.369 E.02452
G1 X137.063 Y127.387 E.08237
G3 X134.482 Y132.482 I-9.106 J-1.41 E.19264
G1 X133.174 Y131.174 E.06139
G3 X131.905 Y132.187 I-5.206 J-5.218 E.05397
G1 X130.964 Y134.674 F30000
G1 F4409
G3 X129.386 Y135.062 I-3.028 J-8.909 E.05399
G1 X127.634 Y133.31 E.08215
G2 X128.367 Y133.309 I.36 J-3.426 E.02434
G1 X126.614 Y135.062 E.08222
G3 X125.036 Y134.674 I1.45 J-9.297 E.05398
G1 X121.81 Y129.907 F30000
G1 F4409
G2 X122.822 Y131.178 I6.864 J-4.43 E.05397
G1 X121.518 Y132.482 E.06122
G3 X118.937 Y127.387 I6.525 J-6.505 E.19264
G1 X120.684 Y125.64 E.08193
G1 X120.684 Y126.36 E.02386
G1 X118.937 Y124.613 E.08193
G3 X121.518 Y119.518 I9.106 J1.41 E.19264
G1 X122.822 Y120.822 E.06122
G2 X121.81 Y122.093 I5.852 J5.701 E.05397
G1 X125.036 Y117.326 F30000
G1 F4409
G3 X126.614 Y116.938 I3.028 J8.909 E.05398
G1 X128.367 Y118.691 E.08222
G2 X127.634 Y118.69 I-.372 J3.425 E.02434
G1 X129.386 Y116.938 E.08215
G3 X130.964 Y117.326 I-1.45 J9.298 E.05399
; CHANGE_LAYER
; Z_HEIGHT: 24.8
; LAYER_HEIGHT: 0.199999
; WIPE_START
G1 F15476.087
G1 X129.386 Y116.938 E-.61766
G1 X129.121 Y117.203 E-.14235
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 124/250
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L124
M991 S0 P123 ;notify layer change
G17
G3 Z25 I-.771 J-.941 P1  F30000
G1 X121.509 Y123.441 Z25
G1 Z24.8
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4404
G1 X121.812 Y122.784 E.02399
G3 X127.074 Y119.084 I6.19 J3.211 E.22179
G1 X127.387 Y119.059 E.01043
G3 X133.127 Y121.267 I.606 J6.989 E.21117
G1 X133.601 Y121.839 E.02464
G3 X121.491 Y123.498 I-5.599 J4.157 E.95913
G1 X121.863 Y123.614 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4404
G1 X121.871 Y123.604 E.0004
G3 X127.126 Y119.473 I6.131 J2.392 E.21542
G1 X127.419 Y119.45 E.00902
G3 X132.839 Y121.533 I.575 J6.596 E.1847
G1 X133.286 Y122.073 E.02154
G3 X121.652 Y124.269 I-5.284 J3.923 E.81809
G1 X121.845 Y123.671 E.0193
M204 S10000
; WIPE_START
G1 F12000
G1 X121.871 Y123.604 E-.02748
G1 X122.157 Y122.964 E-.26628
G1 X122.512 Y122.36 E-.26637
G1 X122.826 Y121.937 E-.19987
; WIPE_END
G1 E-.04 F1800
G1 X130.069 Y124.344 Z25.2 F30000
G1 X137.484 Y126.807 Z25.2
G1 Z24.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4404
G3 X128.404 Y116.486 I-9.483 J-.811 E1.4743
G1 X128.924 Y116.53 E.01729
G1 X129.21 Y116.555 E.00952
G3 X137.489 Y126.747 I-1.209 J9.441 E.48069
G1 X137.878 Y126.848 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4404
G1 X137.767 Y127.675 E.02565
G3 X128.421 Y116.094 I-9.767 J-1.679 E1.39608
G1 X128.957 Y116.14 E.01653
G1 X129.259 Y116.165 E.00933
G3 X137.879 Y126.789 I-1.259 J9.83 E.46394
M204 S10000
; WIPE_START
G1 F12000
G1 X137.767 Y127.675 E-.33942
G1 X137.595 Y128.498 E-.31973
G1 X137.517 Y128.752 E-.10085
; WIPE_END
G1 E-.04 F1800
G1 X131.905 Y132.187 Z25.2 F30000
G1 Z24.8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4404
G2 X133.174 Y131.174 I-3.937 J-6.231 E.05397
G1 X134.482 Y132.482 E.06139
G2 X137.063 Y127.387 I-6.525 J-6.505 E.19264
G1 X135.307 Y125.631 E.08237
G3 X135.307 Y126.369 I-3.451 J.369 E.02452
G1 X137.063 Y124.613 E.08237
G2 X134.482 Y119.518 I-9.106 J1.41 E.19264
G1 X133.174 Y120.826 E.06139
G2 X131.905 Y119.813 I-5.206 J5.218 E.05397
G1 X130.964 Y117.326 F30000
G1 F4404
G2 X129.386 Y116.938 I-3.028 J8.91 E.05399
G1 X127.634 Y118.69 E.08215
G3 X128.367 Y118.691 I.36 J3.426 E.02434
G1 X126.614 Y116.938 E.08222
G2 X125.036 Y117.326 I1.45 J9.297 E.05398
G1 X121.81 Y122.093 F30000
G1 F4404
G3 X122.822 Y120.822 I6.864 J4.43 E.05397
G1 X121.518 Y119.518 E.06122
G2 X118.937 Y124.613 I6.525 J6.505 E.19264
G1 X120.684 Y126.36 E.08193
G1 X120.684 Y125.64 E.02386
G1 X118.937 Y127.387 E.08193
G2 X121.518 Y132.482 I9.106 J-1.41 E.19264
G1 X122.822 Y131.178 E.06122
G3 X121.81 Y129.907 I5.852 J-5.701 E.05397
G1 X125.036 Y134.674 F30000
G1 F4404
G2 X126.614 Y135.062 I3.028 J-8.909 E.05399
G1 X128.367 Y133.309 E.08222
G3 X127.634 Y133.31 I-.372 J-3.425 E.02434
G1 X129.386 Y135.062 E.08215
G2 X130.964 Y134.674 I-1.45 J-9.298 E.05399
; CHANGE_LAYER
; Z_HEIGHT: 25
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F15476.087
G1 X129.386 Y135.062 E-.61765
G1 X129.121 Y134.797 E-.14235
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 125/250
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L125
M991 S0 P124 ;notify layer change
G17
G3 Z25.2 I1.009 J-.68 P1  F30000
G1 X121.495 Y123.477 Z25.2
G1 Z25
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4407
G1 X121.506 Y123.461 E.00066
G3 X127.074 Y119.084 I6.497 J2.534 E.24641
G1 X127.378 Y119.059 E.01012
G3 X134.625 Y123.808 I.616 J6.964 E.30997
G1 X134.82 Y124.525 E.02464
G3 X121.274 Y124.166 I-6.817 J1.47 E.8373
G1 X121.477 Y123.534 E.022
G1 X121.863 Y123.613 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4407
G1 X121.869 Y123.603 E.00036
G3 X127.126 Y119.473 I6.13 J2.392 E.21546
G1 X127.409 Y119.45 E.00873
G1 X127.825 Y119.417 E.01281
G3 X121.65 Y124.268 I.175 J6.578 E1.01194
G1 X121.845 Y123.67 E.01933
M204 S10000
; WIPE_START
G1 F12000
G1 X121.869 Y123.603 E-.02718
G1 X122.157 Y122.964 E-.26631
G1 X122.512 Y122.36 E-.26637
G1 X122.826 Y121.937 E-.20013
; WIPE_END
G1 E-.04 F1800
G1 X130.069 Y124.344 Z25.4 F30000
G1 X137.48 Y126.807 Z25.4
G1 Z25
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4407
G3 X130.006 Y135.309 I-9.49 J-.806 E.40208
G3 X128.935 Y116.531 I-2.002 J-9.305 E1.08971
G1 X129.21 Y116.555 E.00914
G3 X137.485 Y126.747 I-1.22 J9.446 E.48048
G1 X137.878 Y126.847 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4407
G1 X137.767 Y127.675 E.02566
G3 X128.421 Y116.094 I-9.767 J-1.679 E1.39608
G1 X128.968 Y116.141 E.01688
G1 X129.259 Y116.165 E.00898
G3 X137.879 Y126.788 I-1.259 J9.83 E.46393
M204 S10000
; WIPE_START
G1 F12000
G1 X137.767 Y127.675 E-.33957
G1 X137.595 Y128.498 E-.31973
G1 X137.517 Y128.752 E-.1007
; WIPE_END
G1 E-.04 F1800
G1 X133.459 Y122.288 Z25.4 F30000
G1 X131.905 Y119.813 Z25.4
G1 Z25
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4407
G3 X133.174 Y120.826 I-3.937 J6.231 E.05397
G1 X134.482 Y119.518 E.06139
G3 X137.063 Y124.613 I-6.525 J6.505 E.19264
G1 X135.307 Y126.369 E.08237
G2 X135.307 Y125.631 I-3.451 J-.369 E.02452
G1 X137.063 Y127.387 E.08237
G3 X134.482 Y132.482 I-9.106 J-1.41 E.19264
G1 X133.174 Y131.174 E.06139
G3 X131.905 Y132.187 I-5.206 J-5.218 E.05397
G1 X130.964 Y134.674 F30000
G1 F4407
G3 X129.386 Y135.062 I-3.028 J-8.909 E.05399
G1 X127.634 Y133.31 E.08215
G2 X128.367 Y133.309 I.36 J-3.426 E.02434
G1 X126.614 Y135.062 E.08222
G3 X125.036 Y134.674 I1.45 J-9.298 E.05399
G1 X121.81 Y129.907 F30000
G1 F4407
G2 X122.822 Y131.178 I6.864 J-4.43 E.05397
G1 X121.518 Y132.482 E.06122
G3 X118.937 Y127.387 I6.525 J-6.505 E.19264
G1 X120.684 Y125.64 E.08193
G1 X120.684 Y126.36 E.02386
G1 X118.937 Y124.613 E.08193
G3 X121.518 Y119.518 I9.106 J1.41 E.19264
G1 X122.822 Y120.822 E.06122
G2 X121.81 Y122.093 I5.852 J5.701 E.05397
G1 X125.036 Y117.326 F30000
G1 F4407
G3 X126.614 Y116.938 I3.028 J8.909 E.05398
G1 X128.367 Y118.691 E.08222
G2 X127.634 Y118.69 I-.372 J3.425 E.02434
G1 X129.386 Y116.938 E.08215
G3 X130.964 Y117.326 I-1.45 J9.298 E.05399
; CHANGE_LAYER
; Z_HEIGHT: 25.2
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F15476.087
G1 X129.386 Y116.938 E-.61765
G1 X129.121 Y117.203 E-.14235
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 126/250
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L126
M991 S0 P125 ;notify layer change
G17
G3 Z25.4 I-.773 J-.94 P1  F30000
G1 X121.495 Y123.477 Z25.4
G1 Z25.2
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4391
G1 X121.501 Y123.459 E.00064
G3 X127.074 Y119.084 I6.499 J2.541 E.2465
G1 X127.369 Y119.06 E.00981
G1 X127.814 Y119.025 E.01483
G3 X121.268 Y124.164 I.186 J6.975 E1.15853
G1 X121.476 Y123.534 E.02201
G1 X121.864 Y123.612 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4391
G1 X121.867 Y123.602 E.00033
G3 X127.126 Y119.473 I6.133 J2.398 E.21549
G1 X127.4 Y119.451 E.00844
G1 X127.825 Y119.417 E.0131
G3 X121.647 Y124.267 I.175 J6.583 E1.01279
G1 X121.845 Y123.669 E.01937
M204 S10000
; WIPE_START
G1 F12000
G1 X121.867 Y123.602 E-.02688
G1 X122.157 Y122.964 E-.26636
G1 X122.512 Y122.36 E-.26637
G1 X122.827 Y121.936 E-.20038
; WIPE_END
G1 E-.04 F1800
G1 X130.07 Y124.344 Z25.6 F30000
G1 X137.48 Y126.807 Z25.6
G1 Z25.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4391
G3 X130.006 Y135.309 I-9.49 J-.806 E.4021
G3 X128.946 Y116.532 I-2.006 J-9.305 E1.0904
G1 X129.21 Y116.555 E.00876
G3 X137.485 Y126.747 I-1.219 J9.446 E.4805
G1 X137.878 Y126.846 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4391
G1 X137.764 Y127.674 E.02568
G3 X130.089 Y135.692 I-9.774 J-1.674 E.36197
G3 X128.98 Y116.142 I-2.088 J-9.688 E1.05148
G1 X129.259 Y116.165 E.00863
G3 X137.875 Y126.79 I-1.27 J9.835 E.46381
M204 S10000
; WIPE_START
G1 F12000
G1 X137.764 Y127.674 E-.33857
G1 X137.595 Y128.498 E-.31968
G1 X137.516 Y128.754 E-.10175
; WIPE_END
G1 E-.04 F1800
M73 P64 R9
G1 X131.905 Y132.187 Z25.6 F30000
G1 Z25.2
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4391
G2 X133.174 Y131.174 I-3.937 J-6.231 E.05397
G1 X134.482 Y132.482 E.06139
G2 X137.063 Y127.387 I-6.525 J-6.505 E.19264
G1 X135.307 Y125.631 E.08237
G3 X135.307 Y126.369 I-3.451 J.369 E.02452
G1 X137.063 Y124.613 E.08237
G2 X134.482 Y119.518 I-9.106 J1.41 E.19264
G1 X133.174 Y120.826 E.06139
G2 X131.905 Y119.813 I-5.206 J5.218 E.05397
G1 X130.964 Y117.326 F30000
G1 F4391
G2 X129.386 Y116.938 I-3.028 J8.91 E.05399
G1 X127.634 Y118.69 E.08215
G3 X128.367 Y118.691 I.36 J3.426 E.02434
G1 X126.614 Y116.938 E.08222
G2 X125.036 Y117.326 I1.45 J9.297 E.05398
G1 X121.81 Y122.093 F30000
G1 F4391
G3 X122.822 Y120.822 I6.864 J4.43 E.05397
G1 X121.518 Y119.518 E.06122
G2 X118.937 Y124.613 I6.525 J6.505 E.19264
G1 X120.684 Y126.36 E.08193
G1 X120.684 Y125.64 E.02386
G1 X118.937 Y127.387 E.08193
G2 X121.518 Y132.482 I9.106 J-1.41 E.19264
G1 X122.822 Y131.178 E.06122
G3 X121.81 Y129.907 I5.852 J-5.701 E.05397
G1 X125.036 Y134.674 F30000
G1 F4391
G2 X126.614 Y135.062 I3.028 J-8.909 E.05398
G1 X128.367 Y133.309 E.08222
G3 X127.634 Y133.31 I-.372 J-3.425 E.02434
G1 X129.386 Y135.062 E.08215
G2 X130.964 Y134.674 I-1.45 J-9.298 E.05399
; CHANGE_LAYER
; Z_HEIGHT: 25.4
; LAYER_HEIGHT: 0.199999
; WIPE_START
G1 F15476.087
G1 X129.386 Y135.062 E-.61765
G1 X129.121 Y134.797 E-.14235
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 127/250
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L127
M991 S0 P126 ;notify layer change
G17
G3 Z25.6 I1.009 J-.68 P1  F30000
G1 X121.495 Y123.477 Z25.6
G1 Z25.4
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4409
G1 X121.501 Y123.459 E.00064
G3 X127.074 Y119.084 I6.499 J2.541 E.2465
G1 X127.359 Y119.061 E.00949
G1 X127.814 Y119.025 E.01515
G3 X121.268 Y124.164 I.186 J6.975 E1.15851
G1 X121.476 Y123.534 E.02201
G1 X121.864 Y123.611 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4409
G1 X121.867 Y123.602 E.0003
G3 X127.126 Y119.473 I6.133 J2.398 E.21549
G1 X127.39 Y119.452 E.00815
G1 X127.825 Y119.417 E.01339
G3 X121.647 Y124.267 I.175 J6.583 E1.01278
G1 X121.845 Y123.668 E.01939
M204 S10000
; WIPE_START
G1 F12000
G1 X121.867 Y123.602 E-.02652
G1 X122.157 Y122.964 E-.26636
G1 X122.512 Y122.36 E-.26637
G1 X122.827 Y121.936 E-.20075
; WIPE_END
G1 E-.04 F1800
G1 X130.07 Y124.343 Z25.8 F30000
G1 X137.484 Y126.807 Z25.8
G1 Z25.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4409
G3 X128.404 Y116.486 I-9.483 J-.811 E1.4743
G1 X128.958 Y116.533 E.01843
G1 X129.21 Y116.555 E.00839
G3 X137.489 Y126.747 I-1.209 J9.441 E.48069
G1 X137.879 Y126.845 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4409
G1 X137.767 Y127.675 E.02571
G3 X128.421 Y116.094 I-9.767 J-1.679 E1.39608
G1 X128.991 Y116.143 E.01758
G1 X129.259 Y116.165 E.00828
G3 X137.879 Y126.787 I-1.259 J9.83 E.46389
M204 S10000
; WIPE_START
G1 F12000
G1 X137.767 Y127.675 E-.34004
G1 X137.595 Y128.498 E-.31973
G1 X137.518 Y128.751 E-.10023
; WIPE_END
G1 E-.04 F1800
G1 X133.459 Y122.287 Z25.8 F30000
G1 X131.905 Y119.813 Z25.8
G1 Z25.4
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4409
G3 X133.174 Y120.826 I-3.937 J6.231 E.05397
G1 X134.482 Y119.518 E.06139
G3 X137.063 Y124.613 I-6.525 J6.505 E.19264
G1 X135.307 Y126.369 E.08237
G2 X135.307 Y125.631 I-3.451 J-.369 E.02452
G1 X137.063 Y127.387 E.08237
G3 X134.482 Y132.482 I-9.106 J-1.41 E.19264
G1 X133.174 Y131.174 E.06139
G3 X131.905 Y132.187 I-5.206 J-5.218 E.05397
G1 X130.964 Y134.674 F30000
G1 F4409
G3 X129.386 Y135.062 I-3.028 J-8.909 E.05399
G1 X127.634 Y133.31 E.08215
G2 X128.367 Y133.309 I.36 J-3.426 E.02434
G1 X126.614 Y135.062 E.08222
G3 X125.036 Y134.674 I1.45 J-9.298 E.05399
G1 X121.81 Y129.907 F30000
G1 F4409
G2 X122.822 Y131.178 I6.864 J-4.43 E.05397
G1 X121.518 Y132.482 E.06122
G3 X118.937 Y127.387 I6.525 J-6.505 E.19264
G1 X120.684 Y125.64 E.08193
G1 X120.684 Y126.36 E.02386
G1 X118.937 Y124.613 E.08193
G3 X121.518 Y119.518 I9.106 J1.41 E.19264
G1 X122.822 Y120.822 E.06122
G2 X121.81 Y122.093 I5.852 J5.701 E.05397
G1 X125.036 Y117.326 F30000
G1 F4409
G3 X126.614 Y116.938 I3.028 J8.909 E.05398
G1 X128.367 Y118.691 E.08222
G2 X127.634 Y118.69 I-.372 J3.425 E.02434
G1 X129.386 Y116.938 E.08215
G3 X130.964 Y117.326 I-1.45 J9.298 E.05399
; CHANGE_LAYER
; Z_HEIGHT: 25.6
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F15476.087
G1 X129.386 Y116.938 E-.61766
G1 X129.121 Y117.203 E-.14235
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 128/250
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L128
M991 S0 P127 ;notify layer change
G17
G3 Z25.8 I-.773 J-.94 P1  F30000
G1 X121.495 Y123.477 Z25.8
G1 Z25.6
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4389
G1 X121.504 Y123.46 E.00064
G3 X127.074 Y119.084 I6.495 J2.534 E.24646
G1 X127.35 Y119.062 E.00918
G1 X127.814 Y119.025 E.01546
G3 X121.349 Y123.9 I.185 J6.97 E1.16665
G1 X121.476 Y123.534 E.01283
G1 X121.864 Y123.61 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4389
G1 X121.87 Y123.603 E.00028
G3 X127.126 Y119.473 I6.13 J2.392 E.21545
G1 X127.381 Y119.453 E.00786
G1 X127.825 Y119.417 E.01368
G3 X121.722 Y124.023 I.175 J6.578 E1.01971
G1 X121.845 Y123.667 E.01157
M204 S10000
; WIPE_START
G1 F12000
G1 X121.87 Y123.603 E-.02611
G1 X122.157 Y122.964 E-.26631
G1 X122.512 Y122.36 E-.26637
G1 X122.828 Y121.935 E-.20121
; WIPE_END
G1 E-.04 F1800
G1 X130.071 Y124.343 Z26 F30000
G1 X137.484 Y126.807 Z26
G1 Z25.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4389
G3 X128.404 Y116.486 I-9.483 J-.811 E1.4743
G1 X128.969 Y116.534 E.0188
G1 X129.21 Y116.555 E.00801
G3 X137.489 Y126.747 I-1.209 J9.441 E.48069
G1 X137.879 Y126.844 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4389
G1 X137.767 Y127.675 E.02575
G3 X128.421 Y116.094 I-9.767 J-1.679 E1.39608
G1 X129.002 Y116.144 E.01793
G1 X129.259 Y116.165 E.00793
G3 X137.879 Y126.786 I-1.259 J9.83 E.46387
M204 S10000
; WIPE_START
G1 F12000
G1 X137.767 Y127.675 E-.34032
G1 X137.595 Y128.498 E-.31973
G1 X137.518 Y128.75 E-.09996
; WIPE_END
G1 E-.04 F1800
G1 X131.905 Y132.187 Z26 F30000
G1 Z25.6
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4389
G2 X133.174 Y131.174 I-3.937 J-6.231 E.05397
G1 X134.482 Y132.482 E.06139
G2 X137.063 Y127.387 I-6.525 J-6.505 E.19264
G1 X135.307 Y125.631 E.08237
G3 X135.307 Y126.369 I-3.451 J.369 E.02452
G1 X137.063 Y124.613 E.08237
G2 X134.482 Y119.518 I-9.106 J1.41 E.19264
G1 X133.174 Y120.826 E.06139
G2 X131.905 Y119.813 I-5.206 J5.218 E.05397
G1 X130.964 Y117.326 F30000
G1 F4389
G2 X129.386 Y116.938 I-3.028 J8.91 E.05399
G1 X127.634 Y118.69 E.08215
G3 X128.367 Y118.691 I.36 J3.426 E.02434
G1 X126.614 Y116.938 E.08222
G2 X125.036 Y117.326 I1.45 J9.298 E.05399
G1 X121.81 Y122.093 F30000
G1 F4389
G3 X122.822 Y120.822 I6.864 J4.43 E.05397
G1 X121.518 Y119.518 E.06122
G2 X118.937 Y124.613 I6.525 J6.505 E.19264
G1 X120.684 Y126.36 E.08193
G1 X120.684 Y125.64 E.02386
G1 X118.937 Y127.387 E.08193
G2 X121.518 Y132.482 I9.106 J-1.41 E.19264
G1 X122.822 Y131.178 E.06122
G3 X121.81 Y129.907 I5.852 J-5.701 E.05397
G1 X125.036 Y134.674 F30000
G1 F4389
G2 X126.614 Y135.062 I3.028 J-8.909 E.05399
G1 X128.367 Y133.309 E.08222
G3 X127.634 Y133.31 I-.372 J-3.425 E.02434
G1 X129.386 Y135.062 E.08215
G2 X130.964 Y134.674 I-1.45 J-9.298 E.05398
; CHANGE_LAYER
; Z_HEIGHT: 25.8
; LAYER_HEIGHT: 0.199999
; WIPE_START
G1 F15476.087
G1 X129.386 Y135.062 E-.61765
G1 X129.121 Y134.797 E-.14235
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 129/250
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L129
M991 S0 P128 ;notify layer change
G17
G3 Z26 I1.011 J-.678 P1  F30000
G1 X121.509 Y123.441 Z26
G1 Z25.8
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4412
G1 X121.812 Y122.785 E.02399
G3 X127.074 Y119.084 I6.191 J3.211 E.22178
G1 X127.34 Y119.062 E.00886
G3 X123.691 Y131.489 I.658 J6.942 E.90258
G1 X123.49 Y131.313 E.00886
G3 X121.492 Y123.498 I4.514 J-5.317 E.28529
G1 X121.864 Y123.609 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4412
G1 X121.869 Y123.603 E.00025
G3 X127.126 Y119.473 I6.13 J2.392 E.21546
G1 X127.372 Y119.453 E.00757
G1 X127.825 Y119.417 E.01397
G3 X121.719 Y124.032 I.175 J6.578 E1.01945
G1 X121.845 Y123.666 E.01189
M204 S10000
; WIPE_START
G1 F12000
G1 X121.869 Y123.603 E-.02571
G1 X122.157 Y122.964 E-.26631
G1 X122.512 Y122.36 E-.26636
G1 X122.829 Y121.934 E-.20161
; WIPE_END
G1 E-.04 F1800
G1 X130.071 Y124.343 Z26.2 F30000
G1 X137.48 Y126.807 Z26.2
G1 Z25.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4412
G3 X130.006 Y135.309 I-9.49 J-.806 E.40211
G3 X128.98 Y116.535 I-2.002 J-9.305 E1.09124
G1 X129.21 Y116.555 E.00763
G3 X137.485 Y126.747 I-1.219 J9.446 E.48051
G1 X137.879 Y126.843 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4412
G1 X137.764 Y127.674 E.02578
G3 X130.089 Y135.692 I-9.774 J-1.674 E.36196
G3 X129.014 Y116.145 I-2.088 J-9.689 E1.05257
G1 X129.259 Y116.165 E.00758
G3 X137.874 Y126.789 I-1.27 J9.835 E.46377
M204 S10000
; WIPE_START
G1 F12000
G1 X137.764 Y127.674 E-.33887
G1 X137.595 Y128.498 E-.31968
G1 X137.517 Y128.754 E-.10146
; WIPE_END
G1 E-.04 F1800
G1 X133.459 Y122.289 Z26.2 F30000
G1 X131.905 Y119.813 Z26.2
G1 Z25.8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4412
G3 X133.174 Y120.826 I-3.937 J6.231 E.05397
G1 X134.482 Y119.518 E.06139
G3 X137.063 Y124.613 I-6.525 J6.505 E.19264
G1 X135.307 Y126.369 E.08237
G2 X135.307 Y125.631 I-3.451 J-.369 E.02452
G1 X137.063 Y127.387 E.08237
G3 X134.482 Y132.482 I-9.106 J-1.41 E.19264
G1 X133.174 Y131.174 E.06139
G3 X131.905 Y132.187 I-5.206 J-5.218 E.05397
G1 X130.964 Y134.674 F30000
G1 F4412
G3 X129.386 Y135.062 I-3.028 J-8.909 E.05399
G1 X127.634 Y133.31 E.08215
G2 X128.367 Y133.309 I.36 J-3.426 E.02434
G1 X126.614 Y135.062 E.08222
G3 X125.036 Y134.674 I1.45 J-9.298 E.05399
G1 X121.81 Y129.907 F30000
G1 F4412
G2 X122.822 Y131.178 I6.864 J-4.43 E.05397
G1 X121.518 Y132.482 E.06122
G3 X118.937 Y127.387 I6.525 J-6.505 E.19264
G1 X120.684 Y125.64 E.08193
G1 X120.684 Y126.36 E.02386
G1 X118.937 Y124.613 E.08193
G3 X121.518 Y119.518 I9.106 J1.41 E.19264
G1 X122.822 Y120.822 E.06122
G2 X121.81 Y122.093 I5.852 J5.701 E.05397
G1 X125.036 Y117.326 F30000
G1 F4412
G3 X126.614 Y116.938 I3.028 J8.909 E.05398
G1 X128.367 Y118.691 E.08222
G2 X127.634 Y118.69 I-.372 J3.425 E.02434
G1 X129.386 Y116.938 E.08215
M73 P65 R9
G3 X130.964 Y117.326 I-1.45 J9.298 E.05399
; CHANGE_LAYER
; Z_HEIGHT: 26
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F15476.087
G1 X129.386 Y116.938 E-.61765
G1 X129.121 Y117.203 E-.14235
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 130/250
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L130
M991 S0 P129 ;notify layer change
G17
G3 Z26.2 I-.773 J-.94 P1  F30000
G1 X121.495 Y123.477 Z26.2
G1 Z26
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4391
G1 X121.501 Y123.459 E.00064
G3 X127.074 Y119.084 I6.499 J2.541 E.2465
G1 X127.331 Y119.063 E.00855
G1 X127.814 Y119.025 E.01609
G3 X121.268 Y124.164 I.186 J6.975 E1.15855
G1 X121.476 Y123.534 E.02201
G1 X121.865 Y123.608 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4391
G1 X121.867 Y123.602 E.0002
G3 X127.126 Y119.473 I6.133 J2.398 E.21549
G1 X127.362 Y119.454 E.00728
G1 X127.825 Y119.417 E.01426
G3 X121.647 Y124.267 I.175 J6.583 E1.0128
G1 X121.846 Y123.665 E.01949
M204 S10000
; WIPE_START
G1 F12000
G1 X121.867 Y123.602 E-.02532
G1 X122.157 Y122.964 E-.26637
G1 X122.512 Y122.36 E-.26637
G1 X122.829 Y121.933 E-.20194
; WIPE_END
G1 E-.04 F1800
G1 X130.072 Y124.341 Z26.4 F30000
G1 X137.488 Y126.808 Z26.4
G1 Z26
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4391
G3 X128.404 Y116.486 I-9.488 J-.808 E1.47503
G1 X128.992 Y116.536 E.01956
G1 X129.21 Y116.555 E.00725
G3 X137.493 Y126.748 I-1.209 J9.445 E.48077
G1 X137.879 Y126.842 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4391
G1 X137.772 Y127.676 E.02583
G3 X128.421 Y116.094 I-9.772 J-1.676 E1.3968
G1 X129.025 Y116.146 E.01863
G1 X129.259 Y116.165 E.00723
G3 X137.884 Y126.782 I-1.259 J9.834 E.4638
M204 S10000
; WIPE_START
G1 F12000
G1 X137.772 Y127.676 E-.34221
G1 X137.595 Y128.498 E-.31979
G1 X137.519 Y128.745 E-.098
; WIPE_END
G1 E-.04 F1800
G1 X131.905 Y132.187 Z26.4 F30000
G1 Z26
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4391
G2 X133.174 Y131.174 I-3.937 J-6.231 E.05397
G1 X134.482 Y132.482 E.06139
G2 X137.063 Y127.387 I-6.525 J-6.505 E.19264
G1 X135.307 Y125.631 E.08237
G3 X135.307 Y126.369 I-3.451 J.369 E.02452
G1 X137.063 Y124.613 E.08237
G2 X134.482 Y119.518 I-9.106 J1.41 E.19264
G1 X133.174 Y120.826 E.06139
G2 X131.905 Y119.813 I-5.206 J5.218 E.05397
G1 X130.964 Y117.326 F30000
G1 F4391
G2 X129.386 Y116.938 I-3.028 J8.91 E.05399
G1 X127.634 Y118.69 E.08215
G3 X128.367 Y118.691 I.36 J3.426 E.02434
G1 X126.614 Y116.938 E.08222
G2 X125.036 Y117.326 I1.45 J9.297 E.05398
G1 X121.81 Y122.093 F30000
G1 F4391
G3 X122.822 Y120.822 I6.864 J4.43 E.05397
G1 X121.518 Y119.518 E.06122
G2 X118.937 Y124.613 I6.525 J6.505 E.19264
G1 X120.684 Y126.36 E.08193
G1 X120.684 Y125.64 E.02386
G1 X118.937 Y127.387 E.08193
G2 X121.518 Y132.482 I9.106 J-1.41 E.19264
G1 X122.822 Y131.178 E.06122
G3 X121.81 Y129.907 I5.852 J-5.701 E.05397
G1 X125.036 Y134.674 F30000
G1 F4391
G2 X126.614 Y135.062 I3.028 J-8.91 E.05399
G1 X128.367 Y133.309 E.08222
G3 X127.634 Y133.31 I-.372 J-3.425 E.02434
G1 X129.386 Y135.062 E.08215
G2 X130.964 Y134.674 I-1.45 J-9.298 E.05399
; CHANGE_LAYER
; Z_HEIGHT: 26.2
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F15476.087
G1 X129.386 Y135.062 E-.61765
G1 X129.121 Y134.797 E-.14235
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 131/250
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L131
M991 S0 P130 ;notify layer change
G17
G3 Z26.4 I1.009 J-.68 P1  F30000
G1 X121.495 Y123.477 Z26.4
G1 Z26.2
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4409
G1 X121.501 Y123.459 E.00064
G3 X127.074 Y119.084 I6.499 J2.541 E.2465
G1 X127.321 Y119.064 E.00824
G1 X127.814 Y119.025 E.0164
G3 X121.268 Y124.164 I.186 J6.975 E1.15855
G1 X121.476 Y123.534 E.02201
G1 X121.865 Y123.607 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4409
G1 X121.867 Y123.602 E.00017
G3 X127.126 Y119.473 I6.133 J2.398 E.21549
G1 X127.353 Y119.455 E.00699
G1 X127.825 Y119.417 E.01455
G3 X121.647 Y124.267 I.175 J6.583 E1.01278
G1 X121.846 Y123.664 E.01952
M204 S10000
; WIPE_START
G1 F12000
G1 X121.867 Y123.602 E-.02491
G1 X122.157 Y122.964 E-.26637
G1 X122.512 Y122.36 E-.26637
G1 X122.83 Y121.932 E-.20236
; WIPE_END
G1 E-.04 F1800
G1 X130.072 Y124.341 Z26.6 F30000
G1 X137.484 Y126.807 Z26.6
G1 Z26.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4409
G3 X128.404 Y116.486 I-9.483 J-.811 E1.4743
G1 X129.003 Y116.537 E.01994
G1 X129.21 Y116.555 E.00688
G3 X137.489 Y126.747 I-1.209 J9.441 E.48069
G1 X137.875 Y126.84 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4409
G3 X128.421 Y116.094 I-9.874 J-.845 E1.42193
G1 X129.036 Y116.147 E.01898
G1 X129.259 Y116.165 E.00688
G3 X137.88 Y126.781 I-1.259 J9.83 E.4637
M204 S10000
; WIPE_START
G1 F12000
G1 X137.772 Y127.676 E-.34252
G1 X137.595 Y128.498 E-.3198
G1 X137.52 Y128.744 E-.09768
; WIPE_END
G1 E-.04 F1800
G1 X133.458 Y122.282 Z26.6 F30000
G1 X131.905 Y119.813 Z26.6
G1 Z26.2
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4409
G3 X133.174 Y120.826 I-3.937 J6.231 E.05397
G1 X134.482 Y119.518 E.06139
G3 X137.063 Y124.613 I-6.525 J6.505 E.19264
G1 X135.307 Y126.369 E.08237
G2 X135.307 Y125.631 I-3.451 J-.369 E.02452
G1 X137.063 Y127.387 E.08237
G3 X134.482 Y132.482 I-9.106 J-1.41 E.19264
G1 X133.174 Y131.174 E.06139
G3 X131.905 Y132.187 I-5.206 J-5.218 E.05397
G1 X130.964 Y134.674 F30000
G1 F4409
G3 X129.386 Y135.062 I-3.028 J-8.909 E.05399
G1 X127.634 Y133.31 E.08215
G2 X128.367 Y133.309 I.36 J-3.426 E.02434
G1 X126.614 Y135.062 E.08222
G3 X125.036 Y134.674 I1.45 J-9.298 E.05399
G1 X121.81 Y129.907 F30000
G1 F4409
G2 X122.822 Y131.178 I6.864 J-4.43 E.05397
G1 X121.518 Y132.482 E.06122
G3 X118.937 Y127.387 I6.525 J-6.505 E.19264
G1 X120.684 Y125.64 E.08193
G1 X120.684 Y126.36 E.02386
G1 X118.937 Y124.613 E.08193
G3 X121.518 Y119.518 I9.106 J1.41 E.19264
G1 X122.822 Y120.822 E.06122
G2 X121.81 Y122.093 I5.852 J5.701 E.05397
G1 X125.036 Y117.326 F30000
G1 F4409
G3 X126.614 Y116.938 I3.028 J8.909 E.05398
G1 X128.367 Y118.691 E.08222
G2 X127.634 Y118.69 I-.372 J3.425 E.02434
G1 X129.386 Y116.938 E.08215
G3 X130.964 Y117.326 I-1.45 J9.298 E.05399
; CHANGE_LAYER
; Z_HEIGHT: 26.4
; LAYER_HEIGHT: 0.199999
; WIPE_START
G1 F15476.087
G1 X129.386 Y116.938 E-.61765
G1 X129.121 Y117.203 E-.14235
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 132/250
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L132
M991 S0 P131 ;notify layer change
G17
G3 Z26.6 I-.773 J-.94 P1  F30000
G1 X121.495 Y123.477 Z26.6
G1 Z26.4
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4390
G1 X121.501 Y123.459 E.00064
G3 X127.074 Y119.084 I6.499 J2.541 E.2465
G1 X127.312 Y119.065 E.00792
G1 X127.814 Y119.025 E.01672
G3 X121.268 Y124.164 I.186 J6.975 E1.15855
G1 X121.476 Y123.534 E.02201
G1 X121.865 Y123.606 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4390
G1 X121.867 Y123.602 E.00014
G3 X127.126 Y119.473 I6.133 J2.398 E.21549
G1 X127.343 Y119.456 E.0067
G1 X127.825 Y119.417 E.01484
G3 X121.647 Y124.267 I.175 J6.583 E1.0128
G1 X121.847 Y123.663 E.01956
M204 S10000
; WIPE_START
G1 F12000
G1 X121.867 Y123.602 E-.02449
G1 X122.157 Y122.964 E-.26636
G1 X122.512 Y122.36 E-.26637
G1 X122.831 Y121.931 E-.20277
; WIPE_END
G1 E-.04 F1800
G1 X130.073 Y124.341 Z26.8 F30000
G1 X137.484 Y126.807 Z26.8
G1 Z26.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4390
G3 X128.404 Y116.486 I-9.483 J-.812 E1.47428
G1 X129.014 Y116.538 E.02031
G1 X129.21 Y116.555 E.0065
G3 X137.489 Y126.747 I-1.209 J9.441 E.48069
G1 X137.874 Y126.84 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4390
G3 X128.421 Y116.094 I-9.874 J-.845 E1.42189
G1 X129.048 Y116.147 E.01933
G1 X129.259 Y116.165 E.00653
G3 X137.879 Y126.781 I-1.259 J9.83 E.46369
M204 S10000
; WIPE_START
G1 F12000
G1 X137.772 Y127.676 E-.34251
G1 X137.595 Y128.498 E-.3198
G1 X137.52 Y128.744 E-.09769
; WIPE_END
G1 E-.04 F1800
G1 X131.905 Y132.187 Z26.8 F30000
G1 Z26.4
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4390
G2 X133.174 Y131.174 I-3.937 J-6.231 E.05397
G1 X134.482 Y132.482 E.06139
G2 X137.063 Y127.387 I-6.525 J-6.505 E.19264
G1 X135.307 Y125.631 E.08237
G3 X135.307 Y126.369 I-3.451 J.369 E.02452
G1 X137.063 Y124.613 E.08237
G2 X134.482 Y119.518 I-9.106 J1.41 E.19264
G1 X133.174 Y120.826 E.06139
G2 X131.905 Y119.813 I-5.206 J5.218 E.05397
G1 X130.964 Y117.326 F30000
G1 F4390
G2 X129.386 Y116.938 I-3.028 J8.91 E.05399
G1 X127.634 Y118.69 E.08215
G3 X128.367 Y118.691 I.36 J3.426 E.02434
G1 X126.614 Y116.938 E.08222
G2 X125.036 Y117.326 I1.45 J9.297 E.05398
G1 X121.81 Y122.093 F30000
G1 F4390
G3 X122.822 Y120.822 I6.864 J4.431 E.05397
G1 X121.518 Y119.518 E.06122
G2 X118.937 Y124.613 I6.525 J6.505 E.19264
G1 X120.684 Y126.36 E.08193
G1 X120.684 Y125.64 E.02386
G1 X118.937 Y127.387 E.08193
G2 X121.518 Y132.482 I9.106 J-1.41 E.19264
G1 X122.822 Y131.178 E.06122
G3 X121.81 Y129.907 I5.852 J-5.701 E.05397
G1 X125.036 Y134.674 F30000
G1 F4390
G2 X126.614 Y135.062 I3.028 J-8.909 E.05398
G1 X128.367 Y133.309 E.08222
G3 X127.634 Y133.31 I-.372 J-3.425 E.02434
G1 X129.386 Y135.062 E.08215
G2 X130.964 Y134.674 I-1.45 J-9.298 E.05399
; CHANGE_LAYER
; Z_HEIGHT: 26.6
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F15476.087
G1 X129.386 Y135.062 E-.61765
G1 X129.121 Y134.797 E-.14235
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 133/250
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L133
M991 S0 P132 ;notify layer change
G17
G3 Z26.8 I1.009 J-.68 P1  F30000
G1 X121.495 Y123.477 Z26.8
G1 Z26.6
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4408
G1 X121.506 Y123.461 E.00065
G3 X127.074 Y119.084 I6.496 J2.534 E.24643
G1 X127.302 Y119.066 E.00761
G3 X133.127 Y121.267 I.688 J6.987 E.214
G1 X133.601 Y121.839 E.02464
G3 X121.273 Y124.165 I-5.599 J4.157 E.93584
G1 X121.477 Y123.534 E.022
G1 X121.866 Y123.605 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4408
G1 X121.871 Y123.604 E.00017
G3 X127.126 Y119.473 I6.131 J2.392 E.21542
G1 X127.334 Y119.456 E.00641
G3 X132.839 Y121.533 I.657 J6.594 E.18732
G1 X133.286 Y122.073 E.02154
G3 X121.652 Y124.269 I-5.284 J3.923 E.81809
G1 X121.847 Y123.662 E.01958
M204 S10000
; WIPE_START
G1 F12000
G1 X121.871 Y123.604 E-.02404
G1 X122.157 Y122.964 E-.26628
M73 P65 R8
G1 X122.512 Y122.36 E-.26637
G1 X122.831 Y121.93 E-.20331
; WIPE_END
G1 E-.04 F1800
G1 X130.073 Y124.34 Z27 F30000
G1 X137.485 Y126.807 Z27
G1 Z26.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4408
G3 X128.404 Y116.486 I-9.485 J-.81 E1.47451
M73 P66 R8
G1 X129.026 Y116.539 E.02069
G1 X129.21 Y116.555 E.00612
G3 X137.49 Y126.748 I-1.209 J9.442 E.48072
G1 X137.876 Y126.841 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4408
G3 X128.421 Y116.094 I-9.875 J-.844 E1.42212
G1 X129.059 Y116.148 E.01968
G1 X129.259 Y116.165 E.00618
G3 X137.881 Y126.781 I-1.259 J9.831 E.46371
M204 S10000
; WIPE_START
G1 F12000
G1 X137.772 Y127.676 E-.34253
G1 X137.595 Y128.498 E-.3198
G1 X137.52 Y128.744 E-.09767
; WIPE_END
G1 E-.04 F1800
G1 X133.458 Y122.282 Z27 F30000
G1 X131.905 Y119.813 Z27
G1 Z26.6
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4408
G3 X133.174 Y120.826 I-3.937 J6.231 E.05397
G1 X134.482 Y119.518 E.06139
G3 X137.063 Y124.613 I-6.525 J6.505 E.19264
G1 X135.307 Y126.369 E.08237
G2 X135.307 Y125.631 I-3.451 J-.369 E.02452
G1 X137.063 Y127.387 E.08237
G3 X134.482 Y132.482 I-9.106 J-1.41 E.19264
G1 X133.174 Y131.174 E.06139
G3 X131.905 Y132.187 I-5.206 J-5.218 E.05397
G1 X130.964 Y134.674 F30000
G1 F4408
G3 X129.386 Y135.062 I-3.028 J-8.909 E.05399
G1 X127.634 Y133.31 E.08215
G2 X128.367 Y133.309 I.36 J-3.426 E.02434
G1 X126.614 Y135.062 E.08222
G3 X125.036 Y134.674 I1.45 J-9.298 E.05399
G1 X121.81 Y129.907 F30000
G1 F4408
G2 X122.822 Y131.178 I6.864 J-4.43 E.05397
G1 X121.518 Y132.482 E.06122
G3 X118.937 Y127.387 I6.525 J-6.505 E.19264
G1 X120.684 Y125.64 E.08193
G1 X120.684 Y126.36 E.02386
G1 X118.937 Y124.613 E.08193
G3 X121.518 Y119.518 I9.106 J1.41 E.19264
G1 X122.822 Y120.822 E.06122
G2 X121.81 Y122.093 I5.852 J5.701 E.05397
G1 X125.036 Y117.326 F30000
G1 F4408
G3 X126.614 Y116.938 I3.028 J8.909 E.05398
G1 X128.367 Y118.691 E.08222
G2 X127.634 Y118.69 I-.372 J3.425 E.02434
G1 X129.386 Y116.938 E.08215
G3 X130.964 Y117.326 I-1.45 J9.298 E.05399
; CHANGE_LAYER
; Z_HEIGHT: 26.8
; LAYER_HEIGHT: 0.199999
; WIPE_START
G1 F15476.087
G1 X129.386 Y116.938 E-.61765
G1 X129.121 Y117.203 E-.14235
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 134/250
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L134
M991 S0 P133 ;notify layer change
G17
G3 Z27 I-.771 J-.941 P1  F30000
G1 X121.509 Y123.441 Z27
G1 Z26.8
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4404
G1 X121.812 Y122.785 E.02399
G3 X127.074 Y119.084 I6.19 J3.211 E.22179
G1 X127.293 Y119.066 E.00729
G3 X134.012 Y122.458 I.698 J6.969 E.26356
G1 X134.354 Y123.117 E.02464
G3 X121.491 Y123.498 I-6.352 J2.879 E.90986
G1 X121.866 Y123.604 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4404
G1 X121.869 Y123.603 E.0001
G3 X127.126 Y119.473 I6.13 J2.393 E.21546
G1 X127.324 Y119.457 E.00611
G1 X127.825 Y119.417 E.01542
G3 X121.705 Y124.077 I.175 J6.578 E1.01805
G1 X121.847 Y123.661 E.01351
M204 S10000
; WIPE_START
G1 F12000
G1 X121.869 Y123.603 E-.02365
G1 X122.157 Y122.964 E-.26631
G1 X122.512 Y122.36 E-.26637
G1 X122.832 Y121.929 E-.20367
; WIPE_END
G1 E-.04 F1800
G1 X130.074 Y124.34 Z27.2 F30000
G1 X137.488 Y126.808 Z27.2
G1 Z26.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4404
G3 X128.404 Y116.486 I-9.488 J-.808 E1.47504
G1 X129.037 Y116.54 E.02107
G1 X129.21 Y116.555 E.00574
G3 X137.493 Y126.748 I-1.209 J9.445 E.48077
G1 X137.879 Y126.841 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4404
G3 X128.421 Y116.094 I-9.879 J-.841 E1.42267
G1 X129.07 Y116.149 E.02003
G1 X129.259 Y116.165 E.00583
G3 X137.884 Y126.781 I-1.259 J9.834 E.46377
M204 S10000
; WIPE_START
G1 F12000
G1 X137.772 Y127.676 E-.34257
G1 X137.595 Y128.498 E-.3198
G1 X137.52 Y128.744 E-.09763
; WIPE_END
G1 E-.04 F1800
G1 X131.905 Y132.187 Z27.2 F30000
G1 Z26.8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4404
G2 X133.174 Y131.174 I-3.937 J-6.231 E.05397
G1 X134.482 Y132.482 E.06139
G2 X137.063 Y127.387 I-6.525 J-6.505 E.19264
G1 X135.307 Y125.631 E.08237
G3 X135.307 Y126.369 I-3.451 J.369 E.02452
G1 X137.063 Y124.613 E.08237
G2 X134.482 Y119.518 I-9.106 J1.41 E.19264
G1 X133.174 Y120.826 E.06139
G2 X131.905 Y119.813 I-5.206 J5.218 E.05397
G1 X130.964 Y117.326 F30000
G1 F4404
G2 X129.386 Y116.938 I-3.028 J8.91 E.05399
G1 X127.634 Y118.69 E.08215
G3 X128.367 Y118.691 I.36 J3.426 E.02434
G1 X126.614 Y116.938 E.08222
G2 X125.036 Y117.326 I1.45 J9.297 E.05398
G1 X121.81 Y122.093 F30000
G1 F4404
G3 X122.822 Y120.822 I6.864 J4.431 E.05397
G1 X121.518 Y119.518 E.06122
G2 X118.937 Y124.613 I6.525 J6.505 E.19264
G1 X120.684 Y126.36 E.08193
G1 X120.684 Y125.64 E.02386
G1 X118.937 Y127.387 E.08193
G2 X121.518 Y132.482 I9.106 J-1.41 E.19264
G1 X122.822 Y131.178 E.06122
G3 X121.81 Y129.907 I5.852 J-5.701 E.05397
G1 X125.036 Y134.674 F30000
G1 F4404
G2 X126.614 Y135.062 I3.028 J-8.909 E.05399
G1 X128.367 Y133.309 E.08222
G3 X127.634 Y133.31 I-.372 J-3.425 E.02434
G1 X129.386 Y135.062 E.08215
G2 X130.964 Y134.674 I-1.45 J-9.298 E.05399
; CHANGE_LAYER
; Z_HEIGHT: 27
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F15476.087
G1 X129.386 Y135.062 E-.61765
G1 X129.121 Y134.797 E-.14235
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 135/250
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L135
M991 S0 P134 ;notify layer change
G17
G3 Z27.2 I1.009 J-.68 P1  F30000
G1 X121.495 Y123.477 Z27.2
G1 Z27
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4414
G1 X121.504 Y123.46 E.00064
G3 X127.074 Y119.084 I6.496 J2.535 E.24647
G1 X127.284 Y119.067 E.00698
G1 X127.814 Y119.025 E.01766
G3 X121.271 Y124.165 I.185 J6.971 E1.15759
G1 X121.477 Y123.534 E.022
G1 X121.869 Y123.603 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4414
G3 X127.126 Y119.473 I6.13 J2.392 E.21546
G1 X127.315 Y119.458 E.00582
G1 X127.825 Y119.417 E.01572
G3 X121.848 Y123.659 I.175 J6.578 E1.03164
M204 S10000
; WIPE_START
G1 F12000
G1 X122.157 Y122.964 E-.28906
G1 X122.512 Y122.36 E-.26636
G1 X122.833 Y121.928 E-.20457
; WIPE_END
G1 E-.04 F1800
G1 X130.075 Y124.339 Z27.4 F30000
G1 X137.485 Y126.807 Z27.4
G1 Z27
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4414
G3 X128.404 Y116.486 I-9.485 J-.81 E1.47458
G1 X129.048 Y116.541 E.02145
G1 X129.21 Y116.555 E.00536
G3 X137.49 Y126.748 I-1.209 J9.442 E.48072
G1 X137.876 Y126.841 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4414
G3 X128.421 Y116.094 I-9.876 J-.844 E1.42218
G1 X129.082 Y116.15 E.02038
G1 X129.259 Y116.165 E.00548
G3 X137.881 Y126.781 I-1.259 J9.831 E.46372
M204 S10000
; WIPE_START
G1 F12000
G1 X137.772 Y127.676 E-.34253
G1 X137.595 Y128.498 E-.3198
G1 X137.52 Y128.744 E-.09767
; WIPE_END
G1 E-.04 F1800
G1 X133.458 Y122.282 Z27.4 F30000
G1 X131.905 Y119.813 Z27.4
G1 Z27
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4414
G3 X133.174 Y120.826 I-3.937 J6.231 E.05397
G1 X134.482 Y119.518 E.06139
G3 X137.063 Y124.613 I-6.525 J6.505 E.19264
G1 X135.307 Y126.369 E.08237
G2 X135.307 Y125.631 I-3.451 J-.369 E.02452
G1 X137.063 Y127.387 E.08237
G3 X134.482 Y132.482 I-9.106 J-1.41 E.19264
G1 X133.174 Y131.174 E.06139
G3 X131.905 Y132.187 I-5.206 J-5.218 E.05397
G1 X130.964 Y134.674 F30000
G1 F4414
G3 X129.386 Y135.062 I-3.028 J-8.91 E.05398
G1 X127.634 Y133.31 E.08215
G2 X128.367 Y133.309 I.36 J-3.426 E.02434
G1 X126.614 Y135.062 E.08222
G3 X125.036 Y134.674 I1.45 J-9.298 E.05399
G1 X121.81 Y129.907 F30000
G1 F4414
G2 X122.822 Y131.178 I6.864 J-4.431 E.05397
G1 X121.518 Y132.482 E.06122
G3 X118.937 Y127.387 I6.525 J-6.505 E.19264
G1 X120.684 Y125.64 E.08193
G1 X120.684 Y126.36 E.02386
G1 X118.937 Y124.613 E.08193
G3 X121.518 Y119.518 I9.106 J1.41 E.19264
G1 X122.822 Y120.822 E.06122
G2 X121.81 Y122.093 I5.852 J5.701 E.05397
G1 X125.036 Y117.326 F30000
G1 F4414
G3 X126.614 Y116.938 I3.028 J8.909 E.05399
G1 X128.367 Y118.691 E.08222
G2 X127.634 Y118.69 I-.372 J3.425 E.02434
G1 X129.379 Y116.945 E.08182
G3 X130.959 Y117.325 I-1.202 J8.491 E.05398
; CHANGE_LAYER
; Z_HEIGHT: 27.2
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F15476.087
G1 X129.935 Y117.033 E-.40442
G1 X129.379 Y116.945 E-.21405
G1 X129.115 Y117.209 E-.14153
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 136/250
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L136
M991 S0 P135 ;notify layer change
G17
G3 Z27.4 I-.773 J-.94 P1  F30000
G1 X121.495 Y123.477 Z27.4
G1 Z27.2
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4395
G1 X121.504 Y123.46 E.00064
G3 X127.074 Y119.084 I6.496 J2.535 E.24647
G1 X127.274 Y119.068 E.00667
G1 X127.814 Y119.025 E.01797
G3 X121.327 Y123.972 I.185 J6.971 E1.16425
G1 X121.476 Y123.534 E.01535
G1 X121.869 Y123.603 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4395
G3 X127.126 Y119.473 I6.13 J2.393 E.21546
G1 X127.305 Y119.459 E.00553
G1 X127.825 Y119.417 E.01601
G3 X121.848 Y123.659 I.175 J6.578 E1.03164
M204 S10000
; WIPE_START
G1 F12000
G1 X122.157 Y122.964 E-.28907
G1 X122.512 Y122.36 E-.26636
G1 X122.833 Y121.928 E-.20457
; WIPE_END
G1 E-.04 F1800
G1 X130.075 Y124.339 Z27.6 F30000
G1 X137.484 Y126.807 Z27.6
G1 Z27.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4395
G3 X128.404 Y116.486 I-9.483 J-.811 E1.4743
G1 X129.06 Y116.542 E.02183
G1 X129.21 Y116.555 E.00499
G3 X137.489 Y126.747 I-1.209 J9.441 E.48069
G1 X137.875 Y126.84 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4395
G3 X128.421 Y116.094 I-9.874 J-.845 E1.42193
G1 X129.093 Y116.151 E.02073
G1 X129.259 Y116.165 E.00513
G3 X137.88 Y126.781 I-1.259 J9.83 E.4637
M204 S10000
; WIPE_START
G1 F12000
G1 X137.772 Y127.676 E-.34252
G1 X137.595 Y128.498 E-.3198
G1 X137.52 Y128.744 E-.09768
; WIPE_END
G1 E-.04 F1800
G1 X131.905 Y132.187 Z27.6 F30000
G1 Z27.2
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4395
G2 X133.174 Y131.174 I-3.937 J-6.231 E.05397
G1 X134.482 Y132.482 E.06139
G2 X137.063 Y127.387 I-6.525 J-6.505 E.19264
G1 X135.307 Y125.631 E.08237
G3 X135.307 Y126.369 I-3.451 J.369 E.02452
G1 X137.063 Y124.613 E.08237
G2 X134.48 Y119.52 I-9.072 J1.398 E.19264
G1 X133.174 Y120.826 E.0613
M73 P67 R8
G2 X131.905 Y119.813 I-5.206 J5.218 E.05397
G1 X130.959 Y117.325 F30000
G1 F4395
G2 X129.379 Y116.945 I-2.796 J8.156 E.05398
G1 X127.634 Y118.69 E.08184
G3 X128.367 Y118.691 I.36 J3.426 E.02434
G1 X126.614 Y116.938 E.08222
G2 X125.036 Y117.326 I1.45 J9.297 E.05398
G1 X121.81 Y122.093 F30000
G1 F4395
G3 X122.822 Y120.822 I6.864 J4.43 E.05397
G1 X121.518 Y119.518 E.06122
G2 X118.937 Y124.613 I6.525 J6.505 E.19264
G1 X120.684 Y126.36 E.08193
G1 X120.684 Y125.64 E.02386
G1 X118.937 Y127.387 E.08193
G2 X121.518 Y132.482 I9.106 J-1.41 E.19264
G1 X122.822 Y131.178 E.06122
G3 X121.81 Y129.907 I5.852 J-5.701 E.05397
G1 X125.036 Y134.674 F30000
G1 F4395
G2 X126.614 Y135.062 I3.028 J-8.909 E.05398
G1 X128.367 Y133.309 E.08222
G3 X127.634 Y133.31 I-.372 J-3.425 E.02434
G1 X129.386 Y135.062 E.08215
G2 X130.964 Y134.674 I-1.45 J-9.298 E.05399
; CHANGE_LAYER
; Z_HEIGHT: 27.4
; LAYER_HEIGHT: 0.199999
; WIPE_START
G1 F15476.087
G1 X129.386 Y135.062 E-.61765
G1 X129.121 Y134.797 E-.14235
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 137/250
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L137
M991 S0 P136 ;notify layer change
G17
G3 Z27.6 I1.009 J-.68 P1  F30000
G1 X121.495 Y123.477 Z27.6
G1 Z27.4
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4414
G1 X121.501 Y123.459 E.00064
G3 X127.074 Y119.084 I6.499 J2.541 E.2465
G1 X127.265 Y119.069 E.00635
G1 X127.814 Y119.025 E.01829
G3 X121.268 Y124.164 I.186 J6.975 E1.15852
G1 X121.476 Y123.534 E.02201
G1 X121.867 Y123.602 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4414
G3 X127.126 Y119.473 I6.133 J2.398 E.21549
G1 X127.296 Y119.459 E.00524
G1 X127.825 Y119.417 E.0163
G3 X121.845 Y123.658 I.175 J6.583 E1.0325
M204 S10000
; WIPE_START
G1 F12000
G1 X122.157 Y122.964 E-.28911
G1 X122.512 Y122.36 E-.26636
G1 X122.833 Y121.928 E-.20453
; WIPE_END
G1 E-.04 F1800
G1 X130.075 Y124.34 Z27.8 F30000
G1 X137.483 Y126.807 Z27.8
G1 Z27.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4414
G3 X130.006 Y135.309 I-9.489 J-.807 E.40216
G3 X129.071 Y116.543 I-2.001 J-9.306 E1.0943
G1 X129.21 Y116.555 E.00461
G3 X137.487 Y126.747 I-1.216 J9.446 E.48059
G1 X137.873 Y126.84 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4414
G3 X130.089 Y135.692 I-9.88 J-.84 E.38788
G3 X129.104 Y116.152 I-2.083 J-9.69 E1.05509
G1 X129.259 Y116.165 E.00478
G3 X137.878 Y126.781 I-1.266 J9.835 E.46359
M204 S10000
; WIPE_START
G1 F12000
G1 X137.772 Y127.676 E-.3425
G1 X137.595 Y128.498 E-.3198
G1 X137.52 Y128.744 E-.0977
; WIPE_END
G1 E-.04 F1800
G1 X133.458 Y122.282 Z27.8 F30000
G1 X131.905 Y119.813 Z27.8
G1 Z27.4
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4414
G3 X133.174 Y120.826 I-3.937 J6.231 E.05397
G1 X134.482 Y119.518 E.06139
G3 X137.063 Y124.613 I-6.525 J6.505 E.19264
G1 X135.307 Y126.369 E.08237
G2 X135.307 Y125.631 I-3.451 J-.369 E.02452
G1 X137.063 Y127.387 E.08237
G3 X134.482 Y132.482 I-9.106 J-1.41 E.19264
G1 X133.174 Y131.174 E.06139
G3 X131.905 Y132.187 I-5.206 J-5.218 E.05397
G1 X130.964 Y134.674 F30000
G1 F4414
G3 X129.386 Y135.062 I-3.028 J-8.909 E.05399
G1 X127.634 Y133.31 E.08215
G2 X128.367 Y133.309 I.36 J-3.426 E.02434
G1 X126.614 Y135.062 E.08222
G3 X125.036 Y134.674 I1.45 J-9.298 E.05399
G1 X121.81 Y129.907 F30000
G1 F4414
G2 X122.822 Y131.178 I6.864 J-4.43 E.05397
G1 X121.518 Y132.482 E.06122
G3 X118.937 Y127.387 I6.525 J-6.505 E.19264
G1 X120.684 Y125.64 E.08193
G1 X120.684 Y126.36 E.02386
G1 X118.937 Y124.613 E.08193
G3 X121.518 Y119.518 I9.106 J1.41 E.19264
G1 X122.822 Y120.822 E.06122
G2 X121.81 Y122.093 I5.852 J5.701 E.05397
G1 X125.036 Y117.326 F30000
G1 F4414
G3 X126.614 Y116.938 I3.028 J8.909 E.05398
G1 X128.367 Y118.691 E.08222
G2 X127.634 Y118.69 I-.372 J3.425 E.02434
G1 X129.38 Y116.945 E.08186
G3 X130.959 Y117.325 I-1.23 J8.581 E.05398
; CHANGE_LAYER
; Z_HEIGHT: 27.6
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F15476.087
G1 X129.935 Y117.033 E-.40481
G1 X129.38 Y116.945 E-.21367
G1 X129.116 Y117.208 E-.14153
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 138/250
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L138
M991 S0 P137 ;notify layer change
G17
G3 Z27.8 I-.773 J-.94 P1  F30000
G1 X121.495 Y123.477 Z27.8
G1 Z27.6
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4396
G1 X121.501 Y123.459 E.00064
G3 X127.074 Y119.084 I6.499 J2.541 E.2465
G1 X127.255 Y119.069 E.00604
G1 X127.814 Y119.025 E.0186
G3 X121.268 Y124.164 I.186 J6.975 E1.15854
G1 X121.476 Y123.534 E.02201
G1 X121.868 Y123.6 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4396
G1 X122.157 Y122.964 E.02149
G3 X127.126 Y119.473 I5.843 J3.036 E.19394
G1 X127.287 Y119.46 E.00495
G1 X127.825 Y119.417 E.01659
G3 X121.846 Y123.656 I.175 J6.583 E1.03254
M204 S10000
; WIPE_START
G1 F12000
G1 X122.157 Y122.964 E-.28852
G1 X122.512 Y122.36 E-.26637
G1 X122.834 Y121.926 E-.20511
; WIPE_END
G1 E-.04 F1800
G1 X130.075 Y124.339 Z28 F30000
G1 X137.48 Y126.807 Z28
G1 Z27.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4396
G3 X130.006 Y135.309 I-9.49 J-.806 E.40208
G3 X129.082 Y116.544 I-2.005 J-9.306 E1.09504
G1 X129.21 Y116.555 E.00423
G3 X137.484 Y126.747 I-1.22 J9.446 E.48048
G1 X137.87 Y126.84 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4396
G3 X130.089 Y135.692 I-9.881 J-.84 E.3878
G3 X129.116 Y116.153 I-2.087 J-9.69 E1.05577
G1 X129.259 Y116.165 E.00443
G3 X137.875 Y126.78 I-1.27 J9.835 E.46349
M204 S10000
; WIPE_START
G1 F12000
G1 X137.772 Y127.676 E-.34246
G1 X137.595 Y128.498 E-.3198
G1 X137.52 Y128.744 E-.09774
; WIPE_END
G1 E-.04 F1800
G1 X131.905 Y132.187 Z28 F30000
G1 Z27.6
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4396
G2 X133.174 Y131.174 I-3.937 J-6.231 E.05397
G1 X134.482 Y132.482 E.06139
G2 X137.063 Y127.387 I-6.525 J-6.505 E.19264
G1 X135.307 Y125.631 E.08237
G3 X135.307 Y126.369 I-3.451 J.369 E.02452
G1 X137.063 Y124.613 E.08237
G2 X134.482 Y119.518 I-9.106 J1.41 E.19264
G1 X133.174 Y120.826 E.06139
G2 X131.905 Y119.813 I-5.206 J5.218 E.05397
G1 X130.96 Y117.325 F30000
G1 F4396
G2 X129.38 Y116.944 I-2.824 J8.248 E.05398
G1 X127.634 Y118.69 E.08188
G3 X128.367 Y118.691 I.36 J3.426 E.02434
G1 X126.614 Y116.938 E.08222
G2 X125.036 Y117.326 I1.45 J9.297 E.05398
G1 X121.81 Y122.093 F30000
G1 F4396
G3 X122.822 Y120.822 I6.864 J4.43 E.05397
G1 X121.518 Y119.518 E.06122
G2 X118.937 Y124.613 I6.525 J6.505 E.19264
G1 X120.684 Y126.36 E.08193
G1 X120.684 Y125.64 E.02386
G1 X118.937 Y127.387 E.08193
G2 X121.518 Y132.482 I9.106 J-1.41 E.19264
G1 X122.822 Y131.178 E.06122
G3 X121.81 Y129.907 I5.852 J-5.701 E.05397
G1 X125.036 Y134.674 F30000
G1 F4396
G2 X126.614 Y135.062 I3.028 J-8.91 E.05399
G1 X128.367 Y133.309 E.08222
G3 X127.634 Y133.31 I-.372 J-3.425 E.02434
G1 X129.386 Y135.062 E.08215
G2 X130.964 Y134.674 I-1.45 J-9.298 E.05399
; CHANGE_LAYER
; Z_HEIGHT: 27.8
; LAYER_HEIGHT: 0.199999
; WIPE_START
G1 F15476.087
G1 X129.386 Y135.062 E-.61765
G1 X129.121 Y134.797 E-.14235
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 139/250
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L139
M991 S0 P138 ;notify layer change
G17
G3 Z28 I1.009 J-.68 P1  F30000
G1 X121.495 Y123.477 Z28
G1 Z27.8
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4413
G1 X121.504 Y123.46 E.00064
G3 X127.074 Y119.084 I6.496 J2.535 E.24647
G1 X127.246 Y119.07 E.00572
G1 X127.814 Y119.025 E.01892
G3 X121.318 Y123.999 I.185 J6.971 E1.1633
G1 X121.476 Y123.534 E.01629
G1 X121.868 Y123.6 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4413
G1 X122.158 Y122.965 E.02146
G3 X127.126 Y119.473 I5.841 J3.031 E.19392
G1 X127.277 Y119.461 E.00466
G1 X127.825 Y119.417 E.01688
G3 X121.849 Y123.656 I.175 J6.578 E1.03174
M204 S10000
; WIPE_START
G1 F12000
G1 X122.158 Y122.965 E-.28772
G1 X122.512 Y122.36 E-.26633
G1 X122.836 Y121.925 E-.20595
; WIPE_END
G1 E-.04 F1800
G1 X130.076 Y124.338 Z28.2 F30000
G1 X137.484 Y126.807 Z28.2
G1 Z27.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4413
G3 X128.404 Y116.486 I-9.483 J-.811 E1.4743
G1 X129.094 Y116.545 E.02296
G1 X129.21 Y116.555 E.00385
G3 X137.489 Y126.747 I-1.209 J9.441 E.48069
G1 X137.875 Y126.84 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4413
G3 X128.421 Y116.094 I-9.874 J-.845 E1.42193
G1 X129.127 Y116.154 E.02178
G1 X129.259 Y116.165 E.00408
G3 X137.88 Y126.781 I-1.259 J9.83 E.4637
M204 S10000
; WIPE_START
G1 F12000
G1 X137.772 Y127.676 E-.34252
G1 X137.595 Y128.498 E-.3198
G1 X137.52 Y128.744 E-.09768
; WIPE_END
G1 E-.04 F1800
G1 X133.458 Y122.282 Z28.2 F30000
G1 X131.905 Y119.813 Z28.2
G1 Z27.8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4413
G3 X133.174 Y120.826 I-3.937 J6.231 E.05397
G1 X134.482 Y119.518 E.06139
G3 X137.063 Y124.613 I-6.525 J6.505 E.19264
G1 X135.307 Y126.369 E.08237
G2 X135.307 Y125.631 I-3.451 J-.369 E.02452
G1 X137.063 Y127.387 E.08237
G3 X134.482 Y132.482 I-9.106 J-1.41 E.19264
G1 X133.174 Y131.174 E.06139
G3 X131.905 Y132.187 I-5.206 J-5.218 E.05397
G1 X130.964 Y134.674 F30000
G1 F4413
G3 X129.386 Y135.062 I-3.028 J-8.909 E.05399
G1 X127.634 Y133.31 E.08215
G2 X128.367 Y133.309 I.36 J-3.426 E.02434
G1 X126.614 Y135.062 E.08222
G3 X125.036 Y134.674 I1.45 J-9.297 E.05398
G1 X121.81 Y129.907 F30000
G1 F4413
G2 X122.822 Y131.178 I6.864 J-4.43 E.05397
G1 X121.518 Y132.482 E.06122
G3 X118.937 Y127.387 I6.525 J-6.505 E.19264
G1 X120.684 Y125.64 E.08193
G1 X120.684 Y126.36 E.02386
G1 X118.937 Y124.613 E.08193
G3 X121.518 Y119.518 I9.106 J1.41 E.19264
G1 X122.822 Y120.822 E.06122
G2 X121.81 Y122.093 I5.852 J5.701 E.05397
G1 X125.036 Y117.326 F30000
G1 F4413
G3 X126.614 Y116.938 I3.028 J8.909 E.05398
G1 X128.367 Y118.691 E.08222
G2 X127.634 Y118.69 I-.372 J3.425 E.02434
G1 X129.38 Y116.944 E.0819
G3 X130.96 Y117.325 I-1.259 J8.677 E.05398
; CHANGE_LAYER
; Z_HEIGHT: 28
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F15476.087
G1 X129.935 Y117.033 E-.40521
G1 X129.38 Y116.944 E-.21326
G1 X129.117 Y117.207 E-.14153
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 140/250
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L140
M991 S0 P139 ;notify layer change
G17
G3 Z28.2 I-.773 J-.94 P1  F30000
G1 X121.495 Y123.477 Z28.2
G1 Z28
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4395
G1 X121.504 Y123.46 E.00064
G3 X127.074 Y119.084 I6.496 J2.535 E.24647
G1 X127.236 Y119.071 E.00541
G1 X127.814 Y119.025 E.01923
G3 X121.271 Y124.165 I.185 J6.971 E1.15759
G1 X121.477 Y123.534 E.022
G1 X121.868 Y123.599 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4395
G1 X122.158 Y122.965 E.02144
G3 X127.126 Y119.473 I5.841 J3.031 E.19392
G1 X127.268 Y119.462 E.00437
G1 X127.825 Y119.417 E.01717
G3 X121.849 Y123.655 I.175 J6.578 E1.03176
M204 S10000
; WIPE_START
G1 F12000
G1 X122.158 Y122.965 E-.28755
G1 X122.512 Y122.36 E-.26633
G1 X122.836 Y121.924 E-.20613
; WIPE_END
G1 E-.04 F1800
G1 X130.077 Y124.338 Z28.4 F30000
M73 P68 R8
G1 X137.484 Y126.807 Z28.4
G1 Z28
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4395
G3 X128.404 Y116.486 I-9.483 J-.811 E1.4743
G1 X129.105 Y116.546 E.02334
G1 X129.21 Y116.555 E.00348
G3 X137.489 Y126.747 I-1.209 J9.441 E.48069
G1 X137.875 Y126.84 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4395
G3 X128.421 Y116.094 I-9.874 J-.845 E1.42193
G1 X129.138 Y116.155 E.02213
G1 X129.259 Y116.165 E.00373
G3 X137.88 Y126.781 I-1.259 J9.83 E.4637
M204 S10000
; WIPE_START
G1 F12000
G1 X137.772 Y127.676 E-.34252
G1 X137.595 Y128.498 E-.3198
G1 X137.52 Y128.744 E-.09768
; WIPE_END
G1 E-.04 F1800
G1 X131.905 Y132.187 Z28.4 F30000
G1 Z28
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4395
G2 X133.174 Y131.174 I-3.937 J-6.231 E.05397
G1 X134.482 Y132.482 E.06139
G2 X137.063 Y127.387 I-6.525 J-6.505 E.19264
G1 X135.307 Y125.631 E.08237
G3 X135.307 Y126.369 I-3.451 J.369 E.02452
G1 X137.063 Y124.613 E.08237
G2 X134.482 Y119.518 I-9.106 J1.41 E.19264
G1 X133.174 Y120.826 E.06139
G2 X131.905 Y119.813 I-5.206 J5.218 E.05397
G1 X130.96 Y117.325 F30000
G1 F4395
G2 X129.381 Y116.943 I-2.854 J8.346 E.05398
G1 X127.634 Y118.69 E.08193
G3 X128.367 Y118.691 I.36 J3.426 E.02434
G1 X126.614 Y116.938 E.08222
G2 X125.036 Y117.326 I1.45 J9.297 E.05398
G1 X121.81 Y122.093 F30000
G1 F4395
G3 X122.822 Y120.822 I6.864 J4.43 E.05397
G1 X121.518 Y119.518 E.06122
G2 X118.937 Y124.613 I6.525 J6.505 E.19264
G1 X120.684 Y126.36 E.08193
G1 X120.684 Y125.64 E.02386
G1 X118.937 Y127.387 E.08193
G2 X121.518 Y132.482 I9.106 J-1.41 E.19264
G1 X122.822 Y131.178 E.06122
G3 X121.81 Y129.907 I5.852 J-5.701 E.05397
G1 X125.036 Y134.674 F30000
G1 F4395
G2 X126.614 Y135.062 I3.028 J-8.909 E.05399
G1 X128.367 Y133.309 E.08222
G3 X127.634 Y133.31 I-.372 J-3.425 E.02434
G1 X129.386 Y135.062 E.08215
G2 X130.964 Y134.674 I-1.45 J-9.298 E.05399
; CHANGE_LAYER
; Z_HEIGHT: 28.2
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F15476.087
G1 X129.386 Y135.062 E-.61765
G1 X129.121 Y134.797 E-.14235
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 141/250
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L141
M991 S0 P140 ;notify layer change
G17
G3 Z28.4 I1.009 J-.68 P1  F30000
G1 X121.495 Y123.477 Z28.4
G1 Z28.2
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4413
G1 X121.504 Y123.46 E.00064
G3 X127.074 Y119.084 I6.496 J2.535 E.24647
G1 X127.227 Y119.072 E.0051
G1 X127.814 Y119.025 E.01954
G3 X121.313 Y124.017 I.185 J6.971 E1.16268
G1 X121.476 Y123.534 E.01692
G1 X121.868 Y123.599 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4413
G1 X122.158 Y122.965 E.02143
G3 X127.126 Y119.473 I5.841 J3.031 E.19392
G1 X127.258 Y119.462 E.00408
G1 X127.825 Y119.417 E.01746
G3 X121.849 Y123.655 I.175 J6.578 E1.03177
M204 S10000
; WIPE_START
G1 F12000
G1 X122.158 Y122.965 E-.28739
G1 X122.512 Y122.36 E-.26633
G1 X122.836 Y121.924 E-.20629
; WIPE_END
G1 E-.04 F1800
G1 X130.077 Y124.338 Z28.6 F30000
G1 X137.484 Y126.807 Z28.6
G1 Z28.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4413
G3 X128.404 Y116.486 I-9.483 J-.811 E1.4743
G1 X129.116 Y116.547 E.02371
G1 X129.21 Y116.555 E.0031
G3 X137.489 Y126.747 I-1.209 J9.441 E.48069
G1 X137.875 Y126.84 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4413
G3 X128.421 Y116.094 I-9.874 J-.845 E1.42193
G1 X129.15 Y116.156 E.02248
G1 X129.259 Y116.165 E.00338
G3 X137.88 Y126.781 I-1.259 J9.83 E.4637
M204 S10000
; WIPE_START
G1 F12000
G1 X137.772 Y127.676 E-.34252
G1 X137.595 Y128.498 E-.3198
G1 X137.52 Y128.744 E-.09768
; WIPE_END
G1 E-.04 F1800
G1 X133.458 Y122.282 Z28.6 F30000
G1 X131.905 Y119.813 Z28.6
G1 Z28.2
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4413
G3 X133.174 Y120.826 I-3.937 J6.231 E.05397
G1 X134.481 Y119.519 E.06133
G3 X137.063 Y124.613 I-6.506 J6.498 E.19263
G1 X135.307 Y126.369 E.08237
G2 X135.307 Y125.631 I-3.451 J-.369 E.02452
G1 X137.063 Y127.387 E.08237
G3 X134.482 Y132.482 I-9.106 J-1.41 E.19264
G1 X133.174 Y131.174 E.06139
G3 X131.905 Y132.187 I-5.206 J-5.218 E.05397
G1 X130.964 Y134.674 F30000
G1 F4413
G3 X129.386 Y135.062 I-3.028 J-8.909 E.05399
G1 X127.634 Y133.31 E.08215
G2 X128.367 Y133.309 I.36 J-3.426 E.02434
G1 X126.614 Y135.062 E.08222
G3 X125.036 Y134.674 I1.45 J-9.298 E.05399
G1 X121.81 Y129.907 F30000
G1 F4413
G2 X122.822 Y131.178 I6.864 J-4.43 E.05397
G1 X121.518 Y132.482 E.06122
G3 X118.937 Y127.387 I6.525 J-6.505 E.19264
G1 X120.684 Y125.64 E.08193
G1 X120.684 Y126.36 E.02386
G1 X118.937 Y124.613 E.08193
G3 X121.518 Y119.518 I9.106 J1.41 E.19264
G1 X122.822 Y120.822 E.06122
G2 X121.81 Y122.093 I5.852 J5.701 E.05397
G1 X125.036 Y117.326 F30000
G1 F4413
G3 X126.614 Y116.938 I3.028 J8.909 E.05398
G1 X128.367 Y118.691 E.08222
G2 X127.634 Y118.69 I-.372 J3.425 E.02434
G1 X129.381 Y116.943 E.08195
G3 X130.961 Y117.325 I-1.291 J8.78 E.05398
; CHANGE_LAYER
; Z_HEIGHT: 28.4
; LAYER_HEIGHT: 0.199999
; WIPE_START
G1 F15476.087
G1 X129.934 Y117.032 E-.40563
G1 X129.381 Y116.943 E-.21285
G1 X129.118 Y117.206 E-.14153
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 142/250
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L142
M991 S0 P141 ;notify layer change
G17
G3 Z28.6 I-.771 J-.941 P1  F30000
G1 X121.509 Y123.441 Z28.6
G1 Z28.4
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4414
G1 X121.81 Y122.784 E.02399
G3 X127.074 Y119.084 I6.189 J3.211 E.22183
G1 X127.218 Y119.072 E.00478
G1 X127.814 Y119.025 E.01986
G3 X121.489 Y123.498 I.185 J6.971 E1.18088
G1 X121.869 Y123.598 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4414
G1 X122.158 Y122.965 E.02141
G3 X127.126 Y119.473 I5.841 J3.031 E.19392
G1 X127.249 Y119.463 E.00379
G1 X127.825 Y119.417 E.01775
G3 X121.849 Y123.654 I.175 J6.578 E1.03178
M204 S10000
; WIPE_START
G1 F12000
G1 X122.158 Y122.965 E-.28725
G1 X122.512 Y122.36 E-.26632
G1 X122.836 Y121.924 E-.20642
; WIPE_END
G1 E-.04 F1800
G1 X130.077 Y124.338 Z28.8 F30000
G1 X137.483 Y126.807 Z28.8
G1 Z28.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4414
G3 X130.006 Y135.309 I-9.489 J-.807 E.40218
G3 X129.128 Y116.548 I-2.005 J-9.307 E1.09666
G1 X129.21 Y116.555 E.00272
G3 X137.488 Y126.747 I-1.216 J9.446 E.4806
G1 X137.873 Y126.84 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4414
G3 X130.089 Y135.692 I-9.88 J-.84 E.38787
G3 X129.161 Y116.157 I-2.088 J-9.69 E1.05727
G1 X129.259 Y116.165 E.00303
G3 X137.878 Y126.781 I-1.267 J9.835 E.46359
M204 S10000
; WIPE_START
G1 F12000
G1 X137.772 Y127.676 E-.3425
G1 X137.595 Y128.498 E-.3198
G1 X137.52 Y128.744 E-.0977
; WIPE_END
G1 E-.04 F1800
G1 X131.905 Y132.187 Z28.8 F30000
G1 Z28.4
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4414
G2 X133.174 Y131.174 I-3.937 J-6.231 E.05397
G1 X134.482 Y132.482 E.06139
G2 X137.063 Y127.387 I-6.525 J-6.505 E.19264
G1 X135.307 Y125.631 E.08237
G3 X135.307 Y126.369 I-3.451 J.369 E.02452
G1 X137.063 Y124.613 E.08237
G2 X134.482 Y119.518 I-9.106 J1.41 E.19264
G1 X133.174 Y120.826 E.06139
G2 X131.905 Y119.813 I-5.206 J5.218 E.05397
G1 X130.961 Y117.325 F30000
G1 F4414
G2 X129.382 Y116.942 I-2.887 J8.452 E.05398
G1 X127.634 Y118.69 E.08197
G3 X128.367 Y118.691 I.36 J3.426 E.02434
G1 X126.614 Y116.938 E.08222
G2 X125.036 Y117.326 I1.45 J9.297 E.05398
G1 X121.81 Y122.093 F30000
G1 F4414
G3 X122.822 Y120.822 I6.864 J4.431 E.05397
G1 X121.518 Y119.518 E.06122
G2 X118.937 Y124.613 I6.587 J6.537 E.19259
G1 X120.684 Y126.36 E.08193
G1 X120.684 Y125.64 E.02386
G1 X118.937 Y127.387 E.08193
G2 X121.518 Y132.482 I9.106 J-1.41 E.19264
G1 X122.822 Y131.178 E.06122
G3 X121.81 Y129.907 I5.852 J-5.701 E.05397
G1 X125.036 Y134.674 F30000
G1 F4414
G2 X126.614 Y135.062 I3.028 J-8.909 E.05398
G1 X128.367 Y133.309 E.08222
G3 X127.634 Y133.31 I-.372 J-3.425 E.02434
G1 X129.386 Y135.062 E.08215
G2 X130.964 Y134.674 I-1.45 J-9.298 E.05399
; CHANGE_LAYER
; Z_HEIGHT: 28.6
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F15476.087
G1 X129.386 Y135.062 E-.61765
G1 X129.121 Y134.797 E-.14235
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 143/250
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L143
M991 S0 P142 ;notify layer change
G17
G3 Z28.8 I1.009 J-.68 P1  F30000
G1 X121.495 Y123.477 Z28.8
G1 Z28.6
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4411
G1 X121.504 Y123.46 E.00064
G3 X127.074 Y119.084 I6.496 J2.535 E.24647
G1 X127.208 Y119.073 E.00447
G1 X127.814 Y119.025 E.02017
G3 X121.308 Y124.035 I.185 J6.971 E1.16205
G1 X121.476 Y123.534 E.01754
G1 X121.869 Y123.598 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4411
G1 X122.158 Y122.965 E.0214
G3 X127.126 Y119.473 I5.841 J3.031 E.19392
G1 X127.239 Y119.464 E.0035
G1 X127.825 Y119.417 E.01804
G3 X121.85 Y123.654 I.175 J6.578 E1.03179
M204 S10000
; WIPE_START
G1 F12000
G1 X122.158 Y122.965 E-.28715
G1 X122.512 Y122.36 E-.26632
G1 X122.837 Y121.923 E-.20653
; WIPE_END
G1 E-.04 F1800
G1 X130.077 Y124.337 Z29 F30000
G1 X137.485 Y126.807 Z29
G1 Z28.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4411
G3 X130.006 Y135.309 I-9.489 J-.807 E.40223
G3 X129.139 Y116.549 I-2 J-9.308 E1.09661
G1 X129.21 Y116.555 E.00234
G3 X137.49 Y126.748 I-1.213 J9.445 E.48068
G1 X137.879 Y126.841 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4411
G3 X129.172 Y116.158 I-9.874 J-.842 E1.44501
G1 X129.259 Y116.165 E.00268
G3 X137.316 Y122.616 I-1.293 J9.871 E.33338
G1 X137.348 Y122.697 E.00268
G3 X137.884 Y126.781 I-9.344 J3.302 E.12749
M204 S10000
; WIPE_START
G1 F12000
G1 X137.772 Y127.676 E-.34257
G1 X137.595 Y128.498 E-.3198
G1 X137.52 Y128.744 E-.09763
; WIPE_END
G1 E-.04 F1800
G1 X133.458 Y122.282 Z29 F30000
G1 X131.905 Y119.813 Z29
G1 Z28.6
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
M73 P69 R8
G1 F4411
G3 X133.174 Y120.826 I-3.937 J6.231 E.05397
G1 X134.482 Y119.518 E.06139
G3 X137.063 Y124.613 I-6.525 J6.505 E.19264
G1 X135.307 Y126.369 E.08237
G2 X135.307 Y125.631 I-3.451 J-.369 E.02452
G1 X137.063 Y127.387 E.08237
G3 X134.482 Y132.482 I-9.106 J-1.41 E.19264
G1 X133.174 Y131.174 E.06139
G3 X131.905 Y132.187 I-5.206 J-5.218 E.05397
G1 X130.964 Y134.674 F30000
G1 F4411
G3 X129.386 Y135.062 I-3.028 J-8.909 E.05399
G1 X127.634 Y133.31 E.08215
G2 X128.367 Y133.309 I.36 J-3.426 E.02434
G1 X126.614 Y135.062 E.08222
G3 X125.036 Y134.674 I1.45 J-9.298 E.05399
G1 X121.81 Y129.907 F30000
G1 F4411
G2 X122.822 Y131.178 I6.864 J-4.43 E.05397
G1 X121.518 Y132.482 E.06122
G3 X118.937 Y127.387 I6.525 J-6.505 E.19264
G1 X120.684 Y125.64 E.08193
G1 X120.684 Y126.36 E.02386
G1 X118.937 Y124.613 E.08193
G3 X121.518 Y119.518 I9.106 J1.41 E.19264
G1 X122.822 Y120.822 E.06122
G2 X121.81 Y122.093 I5.852 J5.701 E.05397
G1 X125.036 Y117.326 F30000
G1 F4411
G3 X126.614 Y116.938 I3.028 J8.909 E.05398
G1 X128.367 Y118.691 E.08222
G2 X127.634 Y118.69 I-.372 J3.425 E.02434
G1 X129.382 Y116.942 E.082
G3 X130.961 Y117.326 I-1.325 J8.892 E.05398
; CHANGE_LAYER
; Z_HEIGHT: 28.8
; LAYER_HEIGHT: 0.199999
; WIPE_START
G1 F15476.087
G1 X129.934 Y117.032 E-.40607
G1 X129.382 Y116.942 E-.2124
G1 X129.119 Y117.205 E-.14153
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 144/250
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L144
M991 S0 P143 ;notify layer change
G17
G3 Z29 I-.773 J-.94 P1  F30000
G1 X121.495 Y123.477 Z29
G1 Z28.8
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4396
G1 X121.503 Y123.46 E.00064
G3 X127.074 Y119.084 I6.497 J2.537 E.24648
G1 X127.199 Y119.074 E.00415
G1 X127.814 Y119.025 E.02049
G3 X121.304 Y124.044 I.186 J6.972 E1.16208
G1 X121.476 Y123.534 E.01786
G1 X121.869 Y123.598 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4396
G1 X122.158 Y122.964 E.0214
G3 X127.126 Y119.473 I5.842 J3.033 E.19393
G1 X127.23 Y119.465 E.0032
G1 X127.825 Y119.417 E.01833
G3 X121.848 Y123.654 I.175 J6.58 E1.03214
M204 S10000
; WIPE_START
G1 F12000
G1 X122.158 Y122.964 E-.28727
G1 X122.512 Y122.36 E-.26634
G1 X122.836 Y121.924 E-.20639
; WIPE_END
G1 E-.04 F1800
G1 X130.077 Y124.338 Z29.2 F30000
G1 X137.483 Y126.807 Z29.2
G1 Z28.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4396
G3 X119.301 Y122.133 I-9.483 J-.812 E1.09687
G1 X119.323 Y122.078 E.00197
G3 X129.15 Y116.55 I8.694 J3.957 E.40009
G1 X129.21 Y116.555 E.00197
G3 X137.488 Y126.747 I-1.21 J9.441 E.48067
G1 X137.877 Y126.841 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4396
G3 X128.421 Y116.094 I-9.877 J-.843 E1.42235
G1 X129.184 Y116.159 E.02353
G1 X129.259 Y116.165 E.00233
G3 X137.882 Y126.781 I-1.259 J9.832 E.46374
M204 S10000
; WIPE_START
G1 F12000
G1 X137.772 Y127.676 E-.34255
G1 X137.595 Y128.498 E-.3198
G1 X137.52 Y128.744 E-.09765
; WIPE_END
G1 E-.04 F1800
G1 X131.905 Y132.187 Z29.2 F30000
G1 Z28.8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4396
G2 X133.174 Y131.174 I-3.937 J-6.231 E.05397
G1 X134.482 Y132.482 E.06139
G2 X137.063 Y127.387 I-6.525 J-6.505 E.19264
G1 X135.307 Y125.631 E.08237
G3 X135.307 Y126.369 I-3.451 J.369 E.02452
G1 X137.063 Y124.613 E.08237
G2 X134.482 Y119.518 I-9.106 J1.41 E.19264
G1 X133.174 Y120.826 E.06139
G2 X131.905 Y119.813 I-5.206 J5.218 E.05397
G1 X130.962 Y117.326 F30000
G1 F4396
G2 X129.383 Y116.941 I-2.922 J8.566 E.05398
G1 X127.634 Y118.69 E.08202
G3 X128.367 Y118.691 I.36 J3.426 E.02434
G1 X126.614 Y116.938 E.08222
G2 X125.036 Y117.326 I1.45 J9.297 E.05398
G1 X121.81 Y122.093 F30000
G1 F4396
G3 X122.822 Y120.822 I6.864 J4.431 E.05397
G1 X121.518 Y119.518 E.06122
G2 X118.937 Y124.613 I6.525 J6.505 E.19264
G1 X120.684 Y126.36 E.08193
G1 X120.684 Y125.64 E.02386
G1 X118.937 Y127.387 E.08193
G2 X121.518 Y132.482 I9.106 J-1.41 E.19264
G1 X122.822 Y131.178 E.06122
G3 X121.81 Y129.907 I5.852 J-5.701 E.05397
G1 X125.036 Y134.674 F30000
G1 F4396
G2 X126.614 Y135.062 I3.028 J-8.909 E.05399
G1 X128.367 Y133.309 E.08222
G3 X127.634 Y133.31 I-.372 J-3.425 E.02434
G1 X129.386 Y135.062 E.08215
G2 X130.964 Y134.674 I-1.45 J-9.298 E.05399
; CHANGE_LAYER
; Z_HEIGHT: 29
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F15476.087
G1 X129.386 Y135.062 E-.61765
G1 X129.121 Y134.797 E-.14235
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 145/250
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L145
M991 S0 P144 ;notify layer change
G17
G3 Z29.2 I1.009 J-.68 P1  F30000
G1 X121.495 Y123.477 Z29.2
G1 Z29
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4414
G1 X121.503 Y123.46 E.00064
G3 X127.074 Y119.084 I6.497 J2.537 E.24648
G1 X127.189 Y119.075 E.00384
G1 X127.814 Y119.025 E.0208
G3 X121.301 Y124.053 I.186 J6.972 E1.1618
G1 X121.476 Y123.534 E.01817
G1 X121.869 Y123.598 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4414
G1 X122.158 Y122.964 E.02139
G3 X127.126 Y119.473 I5.842 J3.033 E.19393
G1 X127.22 Y119.465 E.00291
G1 X127.825 Y119.417 E.01862
G3 X121.848 Y123.654 I.175 J6.58 E1.03218
M204 S10000
; WIPE_START
G1 F12000
G1 X122.158 Y122.964 E-.28725
G1 X122.512 Y122.36 E-.26634
G1 X122.836 Y121.924 E-.20641
; WIPE_END
G1 E-.04 F1800
G1 X130.077 Y124.338 Z29.4 F30000
G1 X137.485 Y126.807 Z29.4
G1 Z29
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4414
G3 X128.404 Y116.486 I-9.485 J-.81 E1.4745
G1 X129.162 Y116.551 E.02522
G1 X129.21 Y116.555 E.00159
G3 X137.49 Y126.748 I-1.209 J9.442 E.48071
G1 X137.877 Y126.841 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4414
G3 X128.421 Y116.094 I-9.877 J-.843 E1.42238
G1 X129.195 Y116.16 E.02388
G1 X129.259 Y116.165 E.00198
G3 X137.882 Y126.781 I-1.259 J9.833 E.46374
M204 S10000
; WIPE_START
G1 F12000
G1 X137.772 Y127.676 E-.34255
G1 X137.595 Y128.498 E-.3198
G1 X137.52 Y128.744 E-.09765
; WIPE_END
G1 E-.04 F1800
G1 X133.458 Y122.282 Z29.4 F30000
G1 X131.905 Y119.813 Z29.4
G1 Z29
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4414
G3 X133.174 Y120.826 I-3.937 J6.231 E.05397
G1 X134.482 Y119.518 E.06139
G3 X137.063 Y124.613 I-6.525 J6.505 E.19264
G1 X135.307 Y126.369 E.08237
G2 X135.307 Y125.631 I-3.451 J-.369 E.02452
G1 X137.063 Y127.387 E.08237
G3 X134.482 Y132.482 I-9.106 J-1.41 E.19264
G1 X133.174 Y131.174 E.06139
G3 X131.905 Y132.187 I-5.206 J-5.218 E.05397
G1 X130.964 Y134.674 F30000
G1 F4414
G3 X129.386 Y135.062 I-3.028 J-8.909 E.05399
G1 X127.634 Y133.31 E.08215
G2 X128.367 Y133.309 I.36 J-3.426 E.02434
G1 X126.614 Y135.062 E.08222
G3 X125.036 Y134.674 I1.45 J-9.297 E.05398
G1 X121.81 Y129.907 F30000
G1 F4414
G2 X122.822 Y131.178 I6.864 J-4.43 E.05397
G1 X121.518 Y132.482 E.06122
G3 X118.937 Y127.387 I6.525 J-6.505 E.19264
G1 X120.684 Y125.64 E.08193
G1 X120.684 Y126.36 E.02386
G1 X118.937 Y124.613 E.08193
G3 X121.518 Y119.518 I9.106 J1.41 E.19264
G1 X122.822 Y120.822 E.06122
G2 X121.81 Y122.093 I5.852 J5.701 E.05397
G1 X125.036 Y117.326 F30000
G1 F4414
G3 X126.614 Y116.938 I3.028 J8.909 E.05398
G1 X128.367 Y118.691 E.08222
G2 X127.634 Y118.69 I-.372 J3.425 E.02434
G1 X129.383 Y116.941 E.08204
G3 X130.962 Y117.326 I-1.362 J9.011 E.05398
; CHANGE_LAYER
; Z_HEIGHT: 29.2
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F15476.087
G1 X129.934 Y117.032 E-.40653
G1 X129.383 Y116.941 E-.21194
G1 X129.12 Y117.204 E-.14153
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 146/250
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L146
M991 S0 P145 ;notify layer change
G17
G3 Z29.4 I-.773 J-.94 P1  F30000
G1 X121.495 Y123.477 Z29.4
G1 Z29.2
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4396
G1 X121.504 Y123.46 E.00064
G3 X127.074 Y119.084 I6.496 J2.535 E.24647
G1 X127.18 Y119.075 E.00352
G1 X127.814 Y119.025 E.02111
G3 X121.271 Y124.165 I.185 J6.971 E1.15759
G1 X121.477 Y123.534 E.022
G1 X121.869 Y123.598 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4396
G1 X122.158 Y122.965 E.02139
G3 X127.126 Y119.473 I5.841 J3.031 E.19392
M73 P69 R7
G1 X127.211 Y119.466 E.00262
G1 X127.825 Y119.417 E.01892
G3 X121.85 Y123.654 I.175 J6.578 E1.0318
M204 S10000
; WIPE_START
G1 F12000
G1 X122.158 Y122.965 E-.28704
G1 X122.512 Y122.36 E-.26632
G1 X122.837 Y121.923 E-.20664
; WIPE_END
G1 E-.04 F1800
G1 X130.077 Y124.337 Z29.6 F30000
G1 X137.486 Y126.807 Z29.6
G1 Z29.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4396
G3 X130.006 Y135.309 I-9.489 J-.807 E.40224
G3 X129.173 Y116.552 I-2.006 J-9.308 E1.0983
G1 X129.21 Y116.555 E.00121
G3 X137.491 Y126.748 I-1.212 J9.445 E.48069
G1 X137.876 Y126.841 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4396
G3 X130.089 Y135.692 I-9.88 J-.84 E.38793
G3 X129.206 Y116.161 I-2.088 J-9.691 E1.05878
G1 X129.259 Y116.165 E.00163
G3 X137.881 Y126.781 I-1.263 J9.835 E.46367
M204 S10000
; WIPE_START
G1 F12000
G1 X137.772 Y127.676 E-.34253
G1 X137.595 Y128.498 E-.3198
G1 X137.52 Y128.744 E-.09767
; WIPE_END
G1 E-.04 F1800
G1 X131.905 Y132.187 Z29.6 F30000
G1 Z29.2
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4396
G2 X133.174 Y131.174 I-3.937 J-6.231 E.05397
G1 X134.482 Y132.482 E.06139
G2 X137.063 Y127.387 I-6.525 J-6.505 E.19264
G1 X135.307 Y125.631 E.08237
G3 X135.307 Y126.369 I-3.451 J.369 E.02452
G1 X137.063 Y124.613 E.08237
G2 X134.482 Y119.518 I-9.106 J1.41 E.19264
G1 X133.174 Y120.826 E.06139
G2 X131.905 Y119.813 I-5.206 J5.218 E.05397
G1 X130.963 Y117.326 F30000
G1 F4396
G2 X129.384 Y116.94 I-2.96 J8.69 E.05398
G1 X127.634 Y118.69 E.08207
G3 X128.367 Y118.691 I.36 J3.426 E.02434
G1 X126.614 Y116.938 E.08222
G2 X125.036 Y117.326 I1.45 J9.297 E.05398
G1 X121.81 Y122.093 F30000
G1 F4396
G3 X122.822 Y120.822 I6.864 J4.431 E.05397
G1 X121.518 Y119.518 E.06122
G2 X118.937 Y124.613 I6.525 J6.505 E.19264
G1 X120.684 Y126.36 E.08193
G1 X120.684 Y125.64 E.02386
G1 X118.937 Y127.387 E.08193
G2 X121.518 Y132.482 I9.106 J-1.41 E.19264
G1 X122.822 Y131.178 E.06122
G3 X121.81 Y129.907 I5.852 J-5.701 E.05397
G1 X125.036 Y134.674 F30000
G1 F4396
G2 X126.614 Y135.062 I3.028 J-8.909 E.05398
G1 X128.367 Y133.309 E.08222
G3 X127.634 Y133.31 I-.372 J-3.425 E.02434
G1 X129.386 Y135.062 E.08215
G2 X130.964 Y134.674 I-1.45 J-9.298 E.05399
; CHANGE_LAYER
; Z_HEIGHT: 29.4
; LAYER_HEIGHT: 0.199999
; WIPE_START
G1 F15476.087
G1 X129.386 Y135.062 E-.61765
G1 X129.121 Y134.797 E-.14235
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 147/250
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L147
M991 S0 P146 ;notify layer change
G17
G3 Z29.6 I1.009 J-.68 P1  F30000
M73 P70 R7
G1 X121.495 Y123.477 Z29.6
G1 Z29.4
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4414
G1 X121.504 Y123.46 E.00064
G3 X127.074 Y119.084 I6.496 J2.535 E.24647
G1 X127.17 Y119.076 E.00321
G1 X127.814 Y119.025 E.02143
G3 X121.271 Y124.165 I.185 J6.971 E1.15758
G1 X121.477 Y123.534 E.022
G1 X121.869 Y123.598 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4414
G1 X122.158 Y122.965 E.0214
G3 X127.126 Y119.473 I5.841 J3.031 E.19392
G1 X127.202 Y119.467 E.00233
G1 X127.825 Y119.417 E.01921
G3 X121.85 Y123.654 I.175 J6.578 E1.0318
M204 S10000
; WIPE_START
G1 F12000
G1 X122.158 Y122.965 E-.28707
G1 X122.512 Y122.36 E-.26633
G1 X122.837 Y121.923 E-.20661
; WIPE_END
G1 E-.04 F1800
G1 X130.077 Y124.338 Z29.8 F30000
G1 X137.484 Y126.807 Z29.8
G1 Z29.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4414
G3 X128.404 Y116.486 I-9.483 J-.811 E1.4743
G1 X129.185 Y116.553 E.02598
G1 X129.21 Y116.555 E.00083
G3 X137.489 Y126.747 I-1.209 J9.441 E.48069
G1 X137.875 Y126.84 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4414
G3 X128.421 Y116.094 I-9.874 J-.845 E1.42193
G1 X129.218 Y116.162 E.02458
G1 X129.259 Y116.165 E.00128
G3 X137.88 Y126.781 I-1.259 J9.83 E.4637
M204 S10000
; WIPE_START
G1 F12000
G1 X137.772 Y127.676 E-.34252
G1 X137.595 Y128.498 E-.3198
G1 X137.52 Y128.744 E-.09768
; WIPE_END
G1 E-.04 F1800
G1 X133.458 Y122.282 Z29.8 F30000
G1 X131.905 Y119.813 Z29.8
G1 Z29.4
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4414
G3 X133.174 Y120.826 I-3.937 J6.231 E.05397
G1 X134.482 Y119.518 E.06139
G3 X137.063 Y124.613 I-6.525 J6.505 E.19264
G1 X135.307 Y126.369 E.08237
G2 X135.307 Y125.631 I-3.451 J-.369 E.02452
G1 X137.063 Y127.387 E.08237
G3 X134.482 Y132.482 I-9.106 J-1.41 E.19264
G1 X133.174 Y131.174 E.06139
G3 X131.905 Y132.187 I-5.206 J-5.218 E.05397
G1 X130.964 Y134.674 F30000
G1 F4414
G3 X129.386 Y135.062 I-3.028 J-8.909 E.05399
G1 X127.634 Y133.31 E.08215
G2 X128.367 Y133.309 I.36 J-3.426 E.02434
G1 X126.614 Y135.062 E.08222
G3 X125.036 Y134.674 I1.45 J-9.298 E.05399
G1 X121.81 Y129.907 F30000
G1 F4414
G2 X122.822 Y131.178 I6.864 J-4.431 E.05397
G1 X121.518 Y132.482 E.06122
G3 X118.937 Y127.387 I6.525 J-6.505 E.19264
G1 X120.684 Y125.64 E.08193
G1 X120.684 Y126.36 E.02386
G1 X118.937 Y124.613 E.08193
G3 X121.518 Y119.518 I9.106 J1.41 E.19264
G1 X122.822 Y120.822 E.06122
G2 X121.81 Y122.093 I5.852 J5.701 E.05397
G1 X125.036 Y117.326 F30000
G1 F4414
G3 X126.614 Y116.938 I3.028 J8.909 E.05398
G1 X128.367 Y118.691 E.08222
G2 X127.634 Y118.69 I-.372 J3.425 E.02434
G1 X129.384 Y116.94 E.08209
G3 X130.963 Y117.326 I-1.402 J9.141 E.05398
; CHANGE_LAYER
; Z_HEIGHT: 29.6
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F15476.087
G1 X129.933 Y117.032 E-.40701
G1 X129.384 Y116.94 E-.21146
G1 X129.121 Y117.203 E-.14153
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 148/250
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L148
M991 S0 P147 ;notify layer change
G17
G3 Z29.8 I-.773 J-.94 P1  F30000
G1 X121.495 Y123.477 Z29.8
G1 Z29.6
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4394
G1 X121.502 Y123.459 E.00064
G3 X127.074 Y119.084 I6.497 J2.538 E.24649
G1 X127.161 Y119.077 E.0029
G1 X127.814 Y119.025 E.02174
G3 X121.269 Y124.165 I.186 J6.973 E1.15808
G1 X121.476 Y123.534 E.022
G1 X121.869 Y123.598 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4394
G1 X122.158 Y122.964 E.0214
G3 X127.126 Y119.473 I5.841 J3.031 E.19392
G1 X127.192 Y119.468 E.00204
G1 X127.825 Y119.417 E.0195
G3 X121.849 Y123.654 I.175 J6.579 E1.03189
M204 S10000
; WIPE_START
G1 F12000
G1 X122.158 Y122.964 E-.28718
G1 X122.512 Y122.36 E-.26633
G1 X122.836 Y121.923 E-.20649
; WIPE_END
G1 E-.04 F1800
G1 X130.077 Y124.338 Z30 F30000
G1 X137.48 Y126.807 Z30
G1 Z29.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4394
G3 X130.006 Y135.309 I-9.49 J-.806 E.40208
G3 X129.196 Y116.554 I-2.006 J-9.308 E1.09913
G1 X129.21 Y116.555 E.00045
G3 X137.485 Y126.747 I-1.22 J9.446 E.48048
G1 X137.879 Y126.84 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4394
G1 X137.877 Y126.841 E.00006
G3 X128.421 Y116.094 I-9.877 J-.843 E1.42239
G1 X129.229 Y116.163 E.02493
G1 X129.259 Y116.165 E.00093
G3 X137.913 Y126 I-1.259 J9.833 E.43972
G1 X137.882 Y126.78 E.02398
M204 S10000
; WIPE_START
G1 F12000
G1 X137.877 Y126.841 E-.02317
G1 X137.772 Y127.676 E-.31978
G1 X137.595 Y128.498 E-.3198
G1 X137.52 Y128.743 E-.09725
; WIPE_END
G1 E-.04 F1800
G1 X131.905 Y132.187 Z30 F30000
G1 Z29.6
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4394
G2 X133.174 Y131.174 I-3.937 J-6.231 E.05397
G1 X134.482 Y132.482 E.06139
G2 X137.063 Y127.387 I-6.525 J-6.505 E.19264
G1 X135.307 Y125.631 E.08237
G3 X135.307 Y126.369 I-3.451 J.369 E.02452
G1 X137.063 Y124.613 E.08237
G2 X134.482 Y119.518 I-9.106 J1.41 E.19264
G1 X133.174 Y120.826 E.06139
G2 X131.905 Y119.813 I-5.206 J5.218 E.05397
G1 X130.964 Y117.326 F30000
G1 F4394
G2 X129.385 Y116.939 I-3.001 J8.823 E.05398
G1 X127.634 Y118.69 E.08212
G3 X128.367 Y118.691 I.36 J3.426 E.02434
G1 X126.614 Y116.938 E.08222
G2 X125.036 Y117.326 I1.449 J9.297 E.05398
G1 X121.81 Y122.093 F30000
G1 F4394
G3 X122.822 Y120.822 I6.864 J4.43 E.05397
G1 X121.518 Y119.518 E.06122
G2 X118.937 Y124.613 I6.536 J6.511 E.19263
G1 X120.684 Y126.36 E.08193
G1 X120.684 Y125.64 E.02386
G1 X118.937 Y127.387 E.08193
G2 X121.518 Y132.482 I9.106 J-1.41 E.19264
G1 X122.822 Y131.178 E.06122
G3 X121.81 Y129.907 I5.852 J-5.701 E.05397
G1 X125.036 Y134.674 F30000
G1 F4394
G2 X126.614 Y135.062 I3.028 J-8.909 E.05399
G1 X128.367 Y133.309 E.08222
G3 X127.634 Y133.31 I-.372 J-3.425 E.02434
G1 X129.386 Y135.062 E.08215
G2 X130.964 Y134.674 I-1.449 J-9.297 E.05398
; CHANGE_LAYER
; Z_HEIGHT: 29.8
; LAYER_HEIGHT: 0.199999
; WIPE_START
G1 F15476.087
G1 X129.386 Y135.062 E-.61765
G1 X129.121 Y134.797 E-.14235
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 149/250
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L149
M991 S0 P148 ;notify layer change
G17
G3 Z30 I1.011 J-.678 P1  F30000
G1 X121.509 Y123.441 Z30
G1 Z29.8
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4430
G1 X121.81 Y122.784 E.02399
G3 X127.074 Y119.084 I6.189 J3.211 E.22183
G1 X127.151 Y119.078 E.00258
G1 X127.814 Y119.025 E.02206
G3 X121.489 Y123.498 I.185 J6.971 E1.18088
G1 X121.869 Y123.598 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4430
G1 X122.158 Y122.965 E.02141
G3 X127.126 Y119.473 I5.841 J3.031 E.19392
G1 X127.183 Y119.468 E.00175
G1 X127.825 Y119.417 E.01979
G3 X121.849 Y123.654 I.175 J6.578 E1.03179
M204 S10000
; WIPE_START
G1 F12000
G1 X122.158 Y122.965 E-.28719
G1 X122.512 Y122.36 E-.26632
G1 X122.836 Y121.923 E-.20649
; WIPE_END
G1 E-.04 F1800
G1 X130.077 Y124.338 Z30.2 F30000
G1 X137.479 Y126.807 Z30.2
G1 Z29.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4430
G3 X126.79 Y116.555 I-9.483 J-.811 E1.4208
G3 X129.183 Y116.552 I1.206 J10.578 E.07952
G3 X137.484 Y126.747 I-1.187 J9.444 E.4814
G1 X137.879 Y126.839 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4430
G1 X137.87 Y126.84 E.0003
G3 X126.741 Y116.165 I-9.874 J-.844 E1.37033
G3 X129.232 Y116.163 I1.256 J11.015 E.07671
G3 X137.906 Y126 I-1.236 J9.833 E.44036
G1 X137.881 Y126.779 E.02395
M204 S10000
; WIPE_START
G1 F12000
G1 X137.87 Y126.84 E-.02352
G1 X137.772 Y127.676 E-.31968
G1 X137.595 Y128.498 E-.3198
G1 X137.52 Y128.742 E-.097
; WIPE_END
G1 E-.04 F1800
G1 X133.457 Y122.281 Z30.2 F30000
G1 X131.905 Y119.813 Z30.2
G1 Z29.8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4430
G3 X133.174 Y120.826 I-3.937 J6.231 E.05397
G1 X134.482 Y119.518 E.06137
G3 X137.063 Y124.613 I-6.519 J6.503 E.19264
G1 X135.307 Y126.369 E.08237
G2 X135.307 Y125.631 I-3.451 J-.369 E.02452
G1 X137.063 Y127.387 E.08237
G3 X134.482 Y132.482 I-9.127 J-1.421 E.19262
G1 X133.174 Y131.174 E.06139
G3 X131.905 Y132.187 I-5.205 J-5.218 E.05397
G1 X130.964 Y134.674 F30000
G1 F4430
G3 X129.386 Y135.062 I-3.028 J-8.91 E.05399
G1 X127.634 Y133.31 E.08215
G2 X128.367 Y133.309 I.36 J-3.426 E.02434
G1 X126.614 Y135.062 E.08222
G3 X125.036 Y134.674 I1.45 J-9.297 E.05399
G1 X121.81 Y129.907 F30000
G1 F4430
G2 X122.822 Y131.178 I6.864 J-4.431 E.05397
G1 X121.518 Y132.482 E.06122
G3 X118.937 Y127.387 I6.525 J-6.505 E.19264
G1 X120.684 Y125.64 E.08193
G1 X120.684 Y126.36 E.02386
G1 X118.937 Y124.613 E.08193
G3 X121.518 Y119.518 I9.106 J1.41 E.19264
G1 X122.822 Y120.822 E.06122
G2 X121.81 Y122.093 I5.852 J5.701 E.05397
G1 X125.036 Y117.326 F30000
G1 F4430
G3 X126.614 Y116.938 I3.028 J8.91 E.05399
G1 X128.367 Y118.691 E.08222
G2 X127.634 Y118.69 I-.372 J3.425 E.02434
G1 X129.384 Y116.94 E.08209
G3 X130.963 Y117.326 I-1.397 J9.128 E.05398
; CHANGE_LAYER
; Z_HEIGHT: 30
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F15476.087
G1 X129.934 Y117.032 E-.40666
G1 X129.384 Y116.94 E-.2118
G1 X129.121 Y117.203 E-.14153
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 150/250
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L150
M991 S0 P149 ;notify layer change
G17
G3 Z30.2 I-.773 J-.94 P1  F30000
G1 X121.495 Y123.477 Z30.2
G1 Z30
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4393
G1 X121.507 Y123.461 E.00067
G3 X127.074 Y119.084 I6.498 J2.534 E.24639
G1 X127.142 Y119.078 E.00227
G3 X132.595 Y131.251 I.859 J6.923 E.58923
G1 X132.541 Y131.294 E.00227
G3 X121.275 Y124.166 I-4.536 J-5.298 E.58866
G1 X121.477 Y123.534 E.022
G1 X121.868 Y123.598 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4393
G1 X122.158 Y122.965 E.02142
G3 X127.126 Y119.473 I5.841 J3.031 E.19392
G1 X127.173 Y119.469 E.00146
G1 X127.825 Y119.417 E.02008
G3 X121.849 Y123.655 I.175 J6.578 E1.03178
M204 S10000
; WIPE_START
G1 F12000
G1 X122.158 Y122.965 E-.28728
G1 X122.512 Y122.36 E-.26632
G1 X122.836 Y121.924 E-.2064
; WIPE_END
G1 E-.04 F1800
G1 X130.077 Y124.338 Z30.4 F30000
G1 X137.481 Y126.807 Z30.4
G1 Z30
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4393
G3 X127.596 Y116.486 I-9.485 J-.81 E1.44786
G3 X129.194 Y116.553 I.404 J9.419 E.05311
G3 X137.486 Y126.748 I-1.197 J9.444 E.48111
G1 X137.879 Y126.838 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4393
G1 X137.872 Y126.84 E.00023
G3 X127.579 Y116.094 I-9.876 J-.843 E1.39645
G3 X129.243 Y116.164 I.421 J9.809 E.05123
G3 X137.908 Y125.984 I-1.247 J9.833 E.43957
M73 P71 R7
G1 X137.881 Y126.779 E.02444
M204 S10000
; WIPE_START
G1 F12000
G1 X137.872 Y126.84 E-.02378
G1 X137.772 Y127.676 E-.31964
G1 X137.595 Y128.498 E-.31981
G1 X137.52 Y128.742 E-.09678
; WIPE_END
G1 E-.04 F1800
G1 X131.905 Y132.187 Z30.4 F30000
G1 Z30
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4393
G2 X133.174 Y131.174 I-3.937 J-6.231 E.05397
G1 X134.482 Y132.482 E.06139
G2 X137.063 Y127.387 I-6.538 J-6.512 E.19263
G1 X135.307 Y125.631 E.08237
G3 X135.307 Y126.369 I-3.451 J.369 E.02452
G1 X137.063 Y124.613 E.08237
G2 X134.482 Y119.518 I-9.102 J1.409 E.19264
G1 X133.174 Y120.826 E.06138
G2 X131.905 Y119.813 I-5.206 J5.218 E.05397
G1 X130.963 Y117.326 F30000
G1 F4393
G2 X129.385 Y116.939 I-2.997 J8.808 E.05398
G1 X127.634 Y118.69 E.08212
G3 X128.367 Y118.691 I.36 J3.426 E.02434
G1 X126.614 Y116.938 E.08222
G2 X125.036 Y117.326 I1.45 J9.297 E.05398
G1 X121.81 Y122.093 F30000
G1 F4393
G3 X122.822 Y120.822 I6.864 J4.43 E.05397
G1 X121.518 Y119.518 E.06122
G2 X118.937 Y124.613 I6.538 J6.512 E.19263
G1 X120.684 Y126.36 E.08193
G1 X120.684 Y125.64 E.02386
G1 X118.937 Y127.387 E.08193
G2 X121.518 Y132.482 I9.106 J-1.41 E.19264
G1 X122.822 Y131.178 E.06122
G3 X121.81 Y129.907 I5.852 J-5.701 E.05397
G1 X125.036 Y134.674 F30000
G1 F4393
G2 X126.614 Y135.062 I3.028 J-8.91 E.05399
G1 X128.367 Y133.309 E.08222
G3 X127.634 Y133.31 I-.372 J-3.425 E.02434
G1 X129.385 Y135.061 E.08214
G2 X130.964 Y134.674 I-1.435 J-9.25 E.05399
; CHANGE_LAYER
; Z_HEIGHT: 30.2
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F15476.087
G1 X129.385 Y135.061 E-.61766
G1 X129.12 Y134.796 E-.14234
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 151/250
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L151
M991 S0 P150 ;notify layer change
G17
G3 Z30.4 I1.011 J-.678 P1  F30000
G1 X121.509 Y123.441 Z30.4
G1 Z30.2
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4430
G1 X121.81 Y122.783 E.02399
G3 X127.074 Y119.084 I6.19 J3.212 E.22183
G1 X127.133 Y119.079 E.00196
G1 X127.814 Y119.025 E.02268
G3 X121.489 Y123.498 I.185 J6.971 E1.18098
G1 X121.868 Y123.599 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4430
G1 X122.158 Y122.964 E.02143
G3 X127.126 Y119.473 I5.842 J3.033 E.19393
G1 X127.164 Y119.47 E.00117
G1 X127.825 Y119.417 E.02037
G3 X121.848 Y123.655 I.175 J6.58 E1.03208
M204 S10000
; WIPE_START
G1 F12000
G1 X122.158 Y122.964 E-.2876
G1 X122.512 Y122.36 E-.26634
G1 X122.836 Y121.924 E-.20606
; WIPE_END
G1 E-.04 F1800
G1 X130.076 Y124.338 Z30.6 F30000
G1 X137.481 Y126.807 Z30.6
G1 Z30.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4430
G3 X128.404 Y116.486 I-9.483 J-.811 E1.47438
G1 X129.205 Y116.554 E.02665
G3 X137.486 Y126.747 I-1.207 J9.441 E.48077
G1 X137.879 Y126.838 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4430
G1 X137.872 Y126.84 E.00023
G3 X128.421 Y116.094 I-9.874 J-.845 E1.42201
G1 X129.254 Y116.165 E.0257
G3 X137.908 Y126 I-1.256 J9.83 E.43976
G1 X137.881 Y126.778 E.02391
M204 S10000
; WIPE_START
G1 F12000
G1 X137.872 Y126.84 E-.02401
G1 X137.772 Y127.676 E-.31971
G1 X137.595 Y128.498 E-.31981
G1 X137.521 Y128.741 E-.09648
; WIPE_END
G1 E-.04 F1800
G1 X133.457 Y122.28 Z30.6 F30000
G1 X131.905 Y119.813 Z30.6
G1 Z30.2
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4430
G3 X133.174 Y120.826 I-3.937 J6.231 E.05397
G1 X134.482 Y119.518 E.06139
G3 X137.063 Y124.613 I-6.525 J6.505 E.19264
G1 X135.307 Y126.369 E.08237
G2 X135.307 Y125.631 I-3.451 J-.369 E.02452
G1 X137.063 Y127.387 E.08237
G3 X134.482 Y132.482 I-9.106 J-1.41 E.19264
G1 X133.174 Y131.174 E.06139
G3 X131.905 Y132.187 I-5.205 J-5.218 E.05397
G1 X130.964 Y134.674 F30000
G1 F4430
G3 X129.386 Y135.062 I-3.028 J-8.909 E.05398
G1 X127.634 Y133.31 E.08215
G2 X128.367 Y133.309 I.36 J-3.426 E.02434
G1 X126.614 Y135.062 E.08222
G3 X125.036 Y134.674 I1.449 J-9.297 E.05398
G1 X121.81 Y129.907 F30000
G1 F4430
G2 X122.822 Y131.178 I6.864 J-4.431 E.05397
G1 X121.518 Y132.482 E.06122
G3 X118.937 Y127.387 I6.525 J-6.505 E.19264
G1 X120.684 Y125.64 E.08193
G1 X120.684 Y126.36 E.02386
G1 X118.937 Y124.613 E.08193
G3 X121.518 Y119.518 I9.106 J1.41 E.19264
G1 X122.822 Y120.822 E.06122
G2 X121.81 Y122.093 I5.852 J5.701 E.05397
G1 X125.036 Y117.326 F30000
G1 F4430
G3 X126.614 Y116.938 I3.028 J8.909 E.05398
G1 X128.367 Y118.691 E.08222
G2 X127.634 Y118.69 I-.372 J3.425 E.02434
G1 X129.385 Y116.939 E.08214
G3 X130.964 Y117.326 I-1.439 J9.264 E.05398
; CHANGE_LAYER
; Z_HEIGHT: 30.4
; LAYER_HEIGHT: 0.199999
; WIPE_START
G1 F15476.087
G1 X129.385 Y116.939 E-.61765
G1 X129.121 Y117.203 E-.14235
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 152/250
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L152
M991 S0 P151 ;notify layer change
G17
G3 Z30.6 I-.773 J-.94 P1  F30000
G1 X121.495 Y123.477 Z30.6
G1 Z30.4
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4391
G1 X121.508 Y123.462 E.00068
G3 X127.092 Y119.082 I6.496 J2.534 E.24696
G3 X128.557 Y119.044 I.91 J6.832 E.0487
G3 X121.281 Y124.149 I-.552 J6.951 E1.13362
G1 X121.477 Y123.534 E.02139
G1 X121.868 Y123.599 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4391
G1 X122.162 Y122.967 E.02143
G3 X127.144 Y119.472 I5.842 J3.029 E.19437
G3 X128.525 Y119.436 I.859 J6.446 E.04256
G3 X121.855 Y123.653 I-.521 J6.56 E1.01038
M204 S10000
; WIPE_START
G1 F12000
G1 X122.162 Y122.967 E-.28593
G1 X122.512 Y122.36 E-.26625
G1 X122.839 Y121.921 E-.20783
; WIPE_END
G1 E-.04 F1800
G1 X130.078 Y124.338 Z30.8 F30000
G1 X137.47 Y126.806 Z30.8
G1 Z30.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4391
G3 X122.341 Y118.349 I-9.478 J-.806 E1.2594
G3 X128.541 Y116.504 I5.68 J7.75 E.21884
G3 X137.475 Y126.746 I-.549 J9.496 E.50219
G1 X137.873 Y126.837 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4391
G1 X137.861 Y126.839 E.00037
G3 X121.454 Y118.562 I-9.869 J-.839 E1.18884
G3 X128.575 Y116.114 I6.533 J7.422 E.23737
G3 X137.897 Y126 I-.582 J9.887 E.46013
G1 X137.875 Y126.777 E.02387
M204 S10000
; WIPE_START
G1 F12000
G1 X137.861 Y126.839 E-.02435
G1 X137.766 Y127.675 E-.31945
G1 X137.589 Y128.497 E-.31959
G1 X137.514 Y128.74 E-.0966
; WIPE_END
G1 E-.04 F1800
G1 X131.905 Y132.187 Z30.8 F30000
G1 Z30.4
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4391
G2 X133.174 Y131.174 I-3.937 J-6.231 E.05397
G1 X134.478 Y132.478 E.06118
G2 X137.057 Y127.381 I-6.52 J-6.5 E.19266
G1 X135.307 Y125.631 E.0821
G3 X135.307 Y126.369 I-3.451 J.369 E.02452
G1 X137.057 Y124.619 E.0821
G2 X134.478 Y119.522 I-9.099 J1.403 E.19266
G1 X133.174 Y120.826 E.06118
G2 X131.905 Y119.813 I-5.206 J5.218 E.05397
G1 X130.959 Y117.331 F30000
G1 F4391
G2 X129.38 Y116.944 I-3.026 J8.919 E.05399
G1 X127.634 Y118.69 E.08189
G3 X128.367 Y118.691 I.36 J3.426 E.02434
G1 X126.62 Y116.944 E.08196
G2 X125.041 Y117.331 I1.448 J9.306 E.05399
G1 X121.81 Y122.093 F30000
G1 F4391
G3 X122.822 Y120.822 I6.864 J4.431 E.05397
G1 X121.522 Y119.522 E.06101
G2 X118.943 Y124.619 I6.52 J6.5 E.19266
G1 X120.684 Y126.36 E.08166
G1 X120.684 Y125.64 E.02386
G1 X118.943 Y127.381 E.08166
G2 X121.522 Y132.478 I9.099 J-1.403 E.19266
G1 X122.822 Y131.178 E.06101
G3 X121.81 Y129.907 I5.818 J-5.672 E.05397
G1 X125.043 Y134.669 F30000
G1 F4391
G2 X126.622 Y135.054 I2.923 J-8.57 E.054
G1 X128.367 Y133.309 E.08184
G3 X127.634 Y133.31 I-.372 J-3.425 E.02434
G1 X129.38 Y135.056 E.08189
G2 X130.959 Y134.669 I-1.448 J-9.306 E.05399
; CHANGE_LAYER
; Z_HEIGHT: 30.6
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F15476.087
G1 X129.38 Y135.056 E-.61766
G1 X129.115 Y134.791 E-.14234
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 153/250
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L153
M991 S0 P152 ;notify layer change
G17
G3 Z30.8 I1.009 J-.68 P1  F30000
G1 X121.495 Y123.477 Z30.8
G1 Z30.6
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4406
G1 X121.507 Y123.461 E.00066
G3 X127.082 Y119.083 I6.497 J2.535 E.24667
G1 X127.814 Y119.025 E.02436
G3 X121.276 Y124.158 I.19 J6.972 E1.15818
G1 X121.477 Y123.534 E.02172
G1 X121.868 Y123.599 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4406
G1 X122.161 Y122.966 E.02145
G3 X127.134 Y119.472 I5.843 J3.031 E.19411
G1 X127.825 Y119.417 E.02129
G3 X121.853 Y123.654 I.179 J6.58 E1.03214
M204 S10000
; WIPE_START
G1 F12000
G1 X122.161 Y122.966 E-.28659
G1 X122.512 Y122.36 E-.26627
G1 X122.837 Y121.922 E-.20714
; WIPE_END
G1 E-.04 F1800
G1 X130.077 Y124.34 Z31 F30000
G1 X137.46 Y126.805 Z31
G1 Z30.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4406
G3 X119.339 Y122.085 I-9.466 J-.802 E1.09738
G3 X128.836 Y116.541 I8.666 J3.938 E.3889
G3 X137.465 Y126.745 I-.843 J9.463 E.49165
G1 X137.86 Y126.845 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4406
G1 X137.75 Y127.672 E.02564
G3 X128.42 Y116.112 I-9.749 J-1.676 E1.39354
G1 X128.87 Y116.15 E.01386
G1 X129.257 Y116.183 E.01195
G3 X137.861 Y126.786 I-1.257 J9.812 E.46306
M204 S10000
; WIPE_START
G1 F12000
G1 X137.75 Y127.672 E-.33925
G1 X137.577 Y128.494 E-.31915
G1 X137.499 Y128.749 E-.1016
; WIPE_END
G1 E-.04 F1800
G1 X133.449 Y122.28 Z31 F30000
G1 X131.905 Y119.813 Z31
G1 Z30.6
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4406
G3 X133.174 Y120.826 I-3.937 J6.231 E.05397
G1 X134.47 Y119.53 E.06079
G3 X137.047 Y124.629 I-6.51 J6.491 E.19271
G1 X135.307 Y126.369 E.08161
G2 X135.307 Y125.631 I-3.451 J-.369 E.02452
G1 X137.047 Y127.371 E.08161
G3 X134.47 Y132.47 I-9.087 J-1.392 E.19271
G1 X133.174 Y131.174 E.06079
G3 X131.905 Y132.187 I-5.206 J-5.218 E.05397
G1 X130.949 Y134.66 F30000
G1 F4406
G3 X129.37 Y135.046 I-3.024 J-8.937 E.05399
G1 X127.634 Y133.31 E.08142
G2 X128.367 Y133.309 I.36 J-3.426 E.02434
G1 X126.63 Y135.046 E.08149
M73 P72 R7
G3 X125.051 Y134.66 I1.445 J-9.323 E.05399
G1 X121.81 Y129.907 F30000
G1 F4406
G2 X122.822 Y131.178 I6.864 J-4.431 E.05397
G1 X121.53 Y132.47 E.06062
G3 X118.953 Y127.371 I6.799 J-6.637 E.1925
G1 X120.684 Y125.64 E.08118
G1 X120.684 Y126.36 E.02386
G1 X118.953 Y124.629 E.08118
G3 X121.53 Y119.53 I9.087 J1.392 E.19271
G1 X122.822 Y120.822 E.06062
G2 X121.81 Y122.093 I5.852 J5.701 E.05397
G1 X125.051 Y117.34 F30000
G1 F4406
G3 X126.63 Y116.954 I3.024 J8.937 E.05399
G1 X128.367 Y118.691 E.08149
G2 X127.634 Y118.69 I-.372 J3.425 E.02434
G1 X129.37 Y116.954 E.08142
G3 X130.949 Y117.34 I-1.445 J9.324 E.05399
; CHANGE_LAYER
; Z_HEIGHT: 30.8
; LAYER_HEIGHT: 0.199999
; WIPE_START
G1 F15476.087
G1 X129.37 Y116.954 E-.61766
G1 X129.105 Y117.219 E-.14234
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 154/250
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L154
M991 S0 P153 ;notify layer change
G17
G3 Z31 I-.773 J-.94 P1  F30000
G1 X121.495 Y123.477 Z31
G1 Z30.8
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4357
G1 X121.501 Y123.459 E.00064
G3 X127.074 Y119.084 I6.499 J2.541 E.2465
G1 X127.814 Y119.025 E.02464
G3 X121.268 Y124.164 I.186 J6.975 E1.15856
G1 X121.476 Y123.534 E.02201
G1 X121.868 Y123.6 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4357
G1 X122.157 Y122.964 E.02147
G3 X127.126 Y119.473 I5.843 J3.036 E.19394
G1 X127.825 Y119.417 E.02154
G3 X121.846 Y123.656 I.175 J6.583 E1.03257
M204 S10000
; WIPE_START
G1 F12000
G1 X122.157 Y122.964 E-.28823
G1 X122.512 Y122.36 E-.26637
G1 X122.835 Y121.926 E-.2054
; WIPE_END
G1 E-.04 F1800
G1 X130.075 Y124.342 Z31.2 F30000
G1 X137.457 Y126.805 Z31.2
G1 Z30.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4357
G3 X128.403 Y116.516 I-9.457 J-.806 E1.47024
G1 X129.131 Y116.578 E.02425
G1 X129.206 Y116.584 E.00248
G3 X137.462 Y126.745 I-1.206 J9.414 E.47925
G1 X137.849 Y126.847 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4357
G1 X137.735 Y127.669 E.0255
G3 X130.895 Y135.452 I-9.746 J-1.668 E.3351
G3 X129.165 Y116.187 I-2.894 J-9.45 E1.08018
G1 X129.256 Y116.195 E.00281
G3 X137.845 Y126.79 I-1.267 J9.806 E.46247
M204 S10000
; WIPE_START
G1 F12000
G1 X137.735 Y127.669 E-.33672
G1 X137.566 Y128.491 E-.31872
G1 X137.486 Y128.754 E-.10455
; WIPE_END
G1 E-.04 F1800
G1 X136.654 Y128.941 Z31.2 F30000
G1 Z30.8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4357
G2 X137.036 Y127.36 I-9.518 J-3.138 E.05399
G1 X135.307 Y125.631 E.08113
G3 X135.307 Y126.369 I-3.451 J.369 E.02452
G1 X137.036 Y124.64 E.08113
G2 X134.462 Y119.538 I-9.075 J1.38 E.19275
G1 X133.174 Y120.826 E.06041
G2 X131.905 Y119.813 I-5.205 J5.218 E.05397
G1 X130.936 Y117.348 F30000
G1 F4357
G2 X129.356 Y116.968 I-2.889 J8.526 E.05398
G1 X127.634 Y118.69 E.08078
G3 X128.367 Y118.691 I.36 J3.426 E.02434
G1 X126.64 Y116.964 E.08102
G2 X121.538 Y119.538 I1.614 J9.54 E.19242
G1 X122.822 Y120.822 E.06024
G2 X121.81 Y122.093 I5.852 J5.701 E.05397
G1 X119.346 Y123.059 F30000
G1 F4357
G2 X118.964 Y124.64 I9.518 J3.138 E.05399
G1 X120.684 Y126.36 E.08069
G1 X120.684 Y125.64 E.02386
G1 X118.964 Y127.36 E.08069
G2 X119.346 Y128.941 I9.9 J-1.558 E.05399
G1 X121.81 Y129.907 F30000
G1 F4357
G2 X122.822 Y131.178 I6.864 J-4.431 E.05397
G1 X121.538 Y132.462 E.06024
G2 X126.64 Y135.036 I6.716 J-6.966 E.19242
G1 X128.367 Y133.309 E.08102
G3 X127.634 Y133.31 I-.372 J-3.425 E.02434
G1 X129.36 Y135.036 E.08095
G2 X134.462 Y132.462 I-1.614 J-9.54 E.19242
G1 X133.174 Y131.174 E.06041
G3 X131.905 Y132.187 I-5.206 J-5.218 E.05397
; CHANGE_LAYER
; Z_HEIGHT: 31
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F15476.087
G1 X132.825 Y131.514 E-.43304
G1 X133.174 Y131.174 E-.18519
G1 X133.438 Y131.438 E-.14177
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 155/250
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L155
M991 S0 P154 ;notify layer change
G17
G3 Z31.2 I.675 J-1.013 P1  F30000
G1 X121.495 Y123.477 Z31.2
G1 Z31
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4373
G1 X121.504 Y123.46 E.00064
G3 X127.074 Y119.084 I6.496 J2.535 E.24646
G3 X128.556 Y119.044 I.929 J7.027 E.04928
G3 X121.271 Y124.165 I-.556 J6.951 E1.13296
G1 X121.477 Y123.534 E.022
G1 X121.868 Y123.6 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4373
G1 X122.154 Y122.962 E.02149
G3 X127.126 Y119.473 I5.84 J3.034 E.19399
G1 X127.814 Y119.418 E.02119
G3 X121.844 Y123.654 I.181 J6.579 E1.03208
M204 S10000
; WIPE_START
G1 F12000
G1 X122.154 Y122.962 E-.28799
G1 X122.512 Y122.36 E-.26642
G1 X122.835 Y121.925 E-.20558
; WIPE_END
G1 E-.04 F1800
G1 X130.074 Y124.346 Z31.4 F30000
G1 X137.42 Y126.802 Z31.4
G1 Z31
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4373
G3 X121.746 Y118.894 I-9.427 J-.801 E1.22609
G3 X128.573 Y116.557 I6.24 J7.089 E.24559
G3 X137.425 Y126.742 I-.58 J9.444 E.49833
G1 X137.821 Y126.848 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4373
G1 X137.705 Y127.664 E.02533
G3 X120.883 Y119.179 I-9.712 J-1.663 E1.13141
G3 X128.606 Y116.167 I7.132 J6.88 E.2628
G3 X137.814 Y126.792 I-.614 J9.834 E.48104
M204 S10000
; WIPE_START
G1 F12000
G1 X137.705 Y127.664 E-.33415
G1 X137.54 Y128.484 E-.31781
G1 X137.457 Y128.756 E-.10804
; WIPE_END
G1 E-.04 F1800
G1 X136.633 Y123.083 Z31.4 F30000
G1 Z31
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4373
G3 X137.012 Y124.664 I-9.347 J3.077 E.05399
G1 X135.307 Y126.369 E.07999
G2 X135.307 Y125.631 I-3.451 J-.369 E.02452
G1 X137.012 Y127.336 E.07999
G3 X136.633 Y128.917 I-9.726 J-1.496 E.05399
G1 X131.905 Y132.187 F30000
G1 F4373
G2 X133.174 Y131.174 I-3.937 J-6.231 E.05397
G1 X134.442 Y132.442 E.05951
G3 X129.337 Y135.013 I-6.696 J-6.945 E.19251
G1 X127.634 Y133.31 E.07985
G2 X128.367 Y133.309 I.36 J-3.426 E.02434
G1 X126.663 Y135.013 E.07991
G3 X121.558 Y132.442 I1.59 J-9.516 E.19251
G1 X122.823 Y131.177 E.05937
G3 X121.81 Y129.907 I5.784 J-5.653 E.05397
G1 X119.367 Y128.917 F30000
G1 F4373
G3 X118.988 Y127.336 I9.347 J-3.077 E.05399
G1 X120.684 Y125.64 E.07955
G1 X120.684 Y126.36 E.02386
G1 X118.988 Y124.664 E.07955
G3 X119.367 Y123.083 I9.726 J1.496 E.05399
G1 X121.81 Y122.093 F30000
G1 F4373
G3 X122.822 Y120.822 I6.864 J4.43 E.05397
G1 X121.558 Y119.558 E.05934
G3 X126.663 Y116.987 I6.696 J6.945 E.19251
G1 X128.367 Y118.691 E.07993
G2 X127.634 Y118.69 I-.374 J3.482 E.02435
G1 X129.337 Y116.987 E.07985
G3 X134.442 Y119.558 I-1.59 J9.516 E.19251
G1 X133.174 Y120.826 E.05951
G2 X131.905 Y119.813 I-5.206 J5.218 E.05397
; CHANGE_LAYER
; Z_HEIGHT: 31.2
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F15476.087
G1 X132.825 Y120.486 E-.43304
G1 X133.174 Y120.826 E-.18519
G1 X133.438 Y120.562 E-.14177
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 156/250
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L156
M991 S0 P155 ;notify layer change
G17
G3 Z31.4 I-.289 J-1.182 P1  F30000
G1 X121.495 Y123.477 Z31.4
G1 Z31.2
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4342
G1 X121.504 Y123.46 E.00064
G3 X127.074 Y119.084 I6.496 J2.535 E.24646
G3 X128.556 Y119.044 I.932 J7.122 E.04926
G3 X121.271 Y124.165 I-.556 J6.951 E1.13298
G1 X121.477 Y123.534 E.022
G1 X121.867 Y123.601 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4342
G1 X122.159 Y122.965 E.02149
G3 X127.126 Y119.473 I5.841 J3.031 E.19391
G3 X128.525 Y119.436 I.879 J6.724 E.04308
G3 X121.849 Y123.656 I-.525 J6.56 E1.0102
M204 S10000
; WIPE_START
G1 F12000
G1 X122.159 Y122.965 E-.28781
G1 X122.512 Y122.36 E-.26632
G1 X122.835 Y121.925 E-.20587
; WIPE_END
G1 E-.04 F1800
G1 X130.073 Y124.349 Z31.6 F30000
G1 X137.388 Y126.799 Z31.6
G1 Z31.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4342
G3 X129.987 Y135.219 I-9.398 J-.799 E.39821
G3 X128.868 Y116.618 I-1.983 J-9.215 E1.07723
G1 X129.198 Y116.646 E.01098
G3 X137.393 Y126.739 I-1.208 J9.355 E.47583
G1 X137.786 Y126.848 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4342
G1 X137.673 Y127.659 E.02515
G3 X130.07 Y135.603 I-9.684 J-1.658 E.35861
G3 X125.46 Y135.48 I-2.054 J-9.51 E.14304
G1 X125.124 Y135.392 E.01069
G3 X128.901 Y116.227 I2.875 J-9.388 E.88594
G1 X129.248 Y116.257 E.01069
G3 X137.783 Y126.79 I-1.258 J9.744 E.45971
M204 S10000
; WIPE_START
G1 F12000
G1 X137.673 Y127.659 E-.33287
G1 X137.506 Y128.475 E-.31671
G1 X137.421 Y128.753 E-.11042
; WIPE_END
G1 E-.04 F1800
G1 X136.606 Y128.887 Z31.6 F30000
G1 Z31.2
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4342
G2 X136.981 Y127.305 I-9.157 J-3.006 E.05399
G1 X135.307 Y125.631 E.07852
G3 X135.307 Y126.369 I-3.451 J.369 E.02452
G1 X136.981 Y124.695 E.07852
G2 X136.606 Y123.113 I-9.532 J1.425 E.05399
G1 X131.905 Y119.813 F30000
G1 F4342
G3 X133.174 Y120.826 I-3.937 J6.231 E.05397
G1 X134.418 Y119.582 E.05834
G2 X129.306 Y117.018 I-6.441 J6.461 E.19295
G1 X127.634 Y118.69 E.07843
G3 X128.367 Y118.691 I.358 J3.533 E.02435
G1 X126.694 Y117.018 E.07851
G2 X121.582 Y119.582 I1.56 J9.485 E.19261
G1 X122.822 Y120.822 E.05817
G2 X121.81 Y122.093 I5.852 J5.701 E.05397
G1 X119.394 Y123.113 F30000
G1 F4342
G2 X119.019 Y124.695 I9.157 J3.006 E.05399
G1 X120.684 Y126.36 E.07808
G1 X120.684 Y125.64 E.02386
G1 X119.019 Y127.305 E.07808
G2 X119.394 Y128.887 I9.532 J-1.425 E.05399
G1 X121.81 Y129.907 F30000
G1 F4342
G2 X122.822 Y131.178 I6.864 J-4.43 E.05397
G1 X121.582 Y132.418 E.05817
G2 X126.694 Y134.982 I6.442 J-6.463 E.19295
G1 X128.367 Y133.309 E.07849
G3 X127.634 Y133.31 I-.372 J-3.425 E.02434
G1 X129.306 Y134.982 E.07843
G2 X134.418 Y132.418 I-1.329 J-9.025 E.19295
G1 X133.174 Y131.174 E.05834
G3 X131.905 Y132.187 I-5.206 J-5.218 E.05397
; CHANGE_LAYER
; Z_HEIGHT: 31.4
; LAYER_HEIGHT: 0.199999
; WIPE_START
G1 F15476.087
G1 X132.825 Y131.514 E-.43304
G1 X133.174 Y131.174 E-.18519
G1 X133.438 Y131.438 E-.14177
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 157/250
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L157
M991 S0 P156 ;notify layer change
G17
G3 Z31.6 I.675 J-1.013 P1  F30000
G1 X121.495 Y123.477 Z31.6
G1 Z31.4
G1 E.8 F1800
; FEATURE: Inner wall
G1 F5176
G1 X121.51 Y123.462 E.0007
G3 X127.752 Y119.029 I6.496 J2.536 E.26884
G3 X131.381 Y119.896 I.259 J6.947 E.12529
G3 X121.278 Y124.167 I-3.375 J6.102 E1.03469
G1 X121.477 Y123.534 E.02199
G1 X121.875 Y123.605 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5176
G3 X127.784 Y119.42 I6.13 J2.392 E.23557
G3 X130.561 Y119.933 I.151 J6.962 E.08737
G3 X121.854 Y123.661 I-2.555 J6.064 E.94554
M204 S10000
; WIPE_START
G1 F12000
G1 X122.157 Y122.964 E-.28897
G1 X122.512 Y122.36 E-.26637
G1 X122.834 Y121.927 E-.20466
; WIPE_END
G1 E-.04 F1800
G1 X130.07 Y124.354 Z31.8 F30000
G1 X137.361 Y126.799 Z31.8
G1 Z31.4
M73 P73 R7
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5176
G1 X137.256 Y127.587 E.02639
G3 X128.399 Y116.613 I-9.255 J-1.591 E1.4282
G1 X129.163 Y116.678 E.02544
G1 X129.193 Y116.681 E.00101
G3 X137.362 Y126.741 I-1.193 J9.315 E.47441
G1 X137.75 Y126.848 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5176
G1 X137.639 Y127.653 E.02495
G3 X130.062 Y135.568 I-9.649 J-1.652 E.35732
G3 X120.357 Y119.889 I-2.052 J-9.574 E.73865
G1 X120.385 Y119.851 E.00145
G3 X129.196 Y116.287 I7.612 J6.146 E.30497
G1 X129.243 Y116.291 E.00145
G3 X137.747 Y126.79 I-1.254 J9.709 E.45815
M204 S10000
; WIPE_START
G1 F12000
G1 X137.639 Y127.653 E-.33059
G1 X137.472 Y128.466 E-.31558
G1 X137.384 Y128.753 E-.11383
; WIPE_END
G1 E-.04 F1800
G1 X136.313 Y123.44 Z31.8 F30000
G1 Z31.4
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F5176
G3 X136.646 Y125.03 I-8.426 J2.59 E.05399
G1 X135.307 Y126.369 E.0628
G2 X135.307 Y125.631 I-3.451 J-.369 E.02452
G1 X136.646 Y126.97 E.0628
G3 X136.313 Y128.56 I-8.758 J-.999 E.05399
G1 X133.379 Y133.277 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.38292
G1 F5176
G2 X131.372 Y134.399 I-5.382 J-7.273 E1.51116
G2 X133.33 Y133.311 I-3.828 J-9.19 E.06218
G1 X131.905 Y132.187 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F5176
G2 X133.174 Y131.174 I-3.937 J-6.231 E.05397
G1 X134.152 Y132.152 E.0459
G3 X128.972 Y134.648 I-6.174 J-6.194 E.19436
G1 X127.634 Y133.31 E.06272
G2 X128.367 Y133.309 I.36 J-3.426 E.02434
G1 X127.028 Y134.648 E.06279
G3 X121.848 Y132.152 I.994 J-8.689 E.19436
G1 X122.822 Y131.178 E.04573
G3 X121.81 Y129.907 I5.852 J-5.701 E.05397
G1 X119.687 Y128.56 F30000
G1 F5176
G3 X119.354 Y126.97 I8.426 J-2.59 E.05399
G1 X120.684 Y125.64 E.06236
G1 X120.684 Y126.36 E.02386
G1 X119.354 Y125.03 E.06236
G3 X119.687 Y123.44 I8.758 J.999 E.05399
G1 X121.81 Y122.093 F30000
G1 F5176
G3 X122.822 Y120.822 I6.864 J4.43 E.05397
G1 X121.848 Y119.848 E.04573
G3 X127.028 Y117.352 I6.174 J6.194 E.19436
G1 X128.368 Y118.693 E.06286
G2 X127.634 Y118.69 I-.382 J3.72 E.02439
G1 X128.972 Y117.352 E.06272
G3 X134.152 Y119.848 I-1.186 J9.089 E.19402
G1 X133.174 Y120.826 E.0459
G2 X131.905 Y119.813 I-5.206 J5.218 E.05397
; CHANGE_LAYER
; Z_HEIGHT: 31.6
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F15476.087
G1 X132.825 Y120.486 E-.43304
G1 X133.174 Y120.826 E-.18519
G1 X133.438 Y120.562 E-.14177
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 158/250
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L158
M991 S0 P157 ;notify layer change
G17
G3 Z31.8 I-.289 J-1.182 P1  F30000
G1 X121.495 Y123.477 Z31.8
G1 Z31.6
G1 E.8 F1800
; FEATURE: Inner wall
G1 F5151
G1 X121.51 Y123.462 E.00069
G3 X127.743 Y119.03 I6.496 J2.537 E.26853
G3 X132.011 Y120.29 I.217 J7.123 E.15012
G3 X121.277 Y124.167 I-4.005 J5.709 E1.01018
G1 X121.477 Y123.534 E.02199
G1 X121.875 Y123.605 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5151
G3 X127.774 Y119.421 I6.131 J2.393 E.23527
G3 X130.561 Y119.933 I.165 J6.945 E.08766
G3 X121.854 Y123.661 I-2.554 J6.065 E.94578
M204 S10000
; WIPE_START
G1 F12000
G1 X122.157 Y122.964 E-.28897
G1 X122.512 Y122.36 E-.26637
G1 X122.834 Y121.927 E-.20466
; WIPE_END
G1 E-.04 F1800
G1 X130.068 Y124.361 Z32 F30000
G1 X137.306 Y126.797 Z32
G1 Z31.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5151
G1 X137.196 Y127.577 E.02614
G3 X120.733 Y120.132 I-9.203 J-1.574 E1.1311
G3 X128.615 Y116.687 I7.279 J5.913 E.29644
G3 X137.3 Y126.743 I-.622 J9.316 E.49044
G1 X137.695 Y126.846 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5151
G1 X137.583 Y127.643 E.02472
G3 X119.936 Y120.55 I-9.59 J-1.64 E1.06636
G3 X128.648 Y116.296 I8.051 J5.441 E.31188
G3 X137.69 Y126.788 I-.655 J9.707 E.4736
M204 S10000
; WIPE_START
G1 F12000
G1 X137.583 Y127.643 E-.32754
G1 X137.419 Y128.452 E-.31379
G1 X137.327 Y128.751 E-.11867
; WIPE_END
G1 E-.04 F1800
G1 X131.905 Y132.187 Z32 F30000
G1 Z31.6
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F5151
G2 X133.174 Y131.174 I-3.937 J-6.231 E.05397
G1 X134.092 Y132.092 E.04306
G2 X136.569 Y126.893 I-6.125 J-6.108 E.19474
G1 X135.307 Y125.631 E.0592
G3 X135.307 Y126.369 I-3.451 J.369 E.02452
G1 X136.569 Y125.107 E.0592
G2 X134.092 Y119.908 I-8.603 J.91 E.19474
G1 X133.174 Y120.826 E.04306
G2 X131.905 Y119.813 I-5.206 J5.218 E.05397
G1 X129.14 Y117.098 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.38292
G1 F5151
G2 X134.989 Y120.361 I-1.133 J8.905 E1.37244
G2 X129.199 Y117.108 I-7.01 J5.697 E.18842
G1 X130.487 Y117.747 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F5151
G2 X128.892 Y117.432 I-3.181 J11.887 E.05398
G1 X127.634 Y118.69 E.059
G3 X128.369 Y118.693 I.351 J3.768 E.02439
G1 X127.108 Y117.432 E.05915
G2 X125.513 Y117.747 I1.035 J9.416 E.05399
G1 X121.81 Y122.093 F30000
G1 F5151
G3 X122.822 Y120.822 I6.864 J4.431 E.05397
G1 X121.908 Y119.908 E.04289
G2 X119.431 Y125.107 I6.125 J6.108 E.19474
G1 X120.684 Y126.36 E.05877
G1 X120.684 Y125.64 E.02386
G1 X119.431 Y126.893 E.05877
G2 X121.908 Y132.092 I8.603 J-.91 E.19474
G1 X122.822 Y131.178 E.04289
G3 X121.81 Y129.907 I5.852 J-5.701 E.05397
G1 X125.513 Y134.253 F30000
G1 F5151
G2 X127.108 Y134.568 I2.629 J-9.1 E.05399
G1 X128.367 Y133.309 E.05907
G3 X127.634 Y133.31 I-.372 J-3.425 E.02434
G1 X128.892 Y134.568 E.059
G2 X130.487 Y134.253 I-1.035 J-9.416 E.05399
; CHANGE_LAYER
; Z_HEIGHT: 31.8
; LAYER_HEIGHT: 0.199999
; WIPE_START
G1 F15476.087
M73 P73 R6
G1 X129.816 Y134.427 E-.26338
G1 X128.892 Y134.568 E-.35516
G1 X128.629 Y134.305 E-.14146
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 159/250
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L159
M991 S0 P158 ;notify layer change
G17
G3 Z32 I1.016 J-.67 P1  F30000
G1 X121.495 Y123.477 Z32
G1 Z31.8
G1 E.8 F1800
; FEATURE: Inner wall
G1 F5114
G1 X121.511 Y123.463 E.00071
G3 X127.733 Y119.031 I6.496 J2.536 E.26818
G3 X132.011 Y120.29 I.229 J7.117 E.15043
G3 X121.278 Y124.167 I-4.004 J5.709 E1.01006
G1 X121.477 Y123.535 E.02199
G1 X121.875 Y123.605 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5114
G3 X127.765 Y119.422 I6.131 J2.394 E.23497
G3 X131.191 Y120.239 I.246 J6.555 E.10958
G3 X121.853 Y123.661 I-3.185 J5.76 E.9243
M204 S10000
; WIPE_START
G1 F12000
G1 X122.157 Y122.964 E-.28898
G1 X122.512 Y122.36 E-.26637
G1 X122.834 Y121.927 E-.20465
; WIPE_END
G1 E-.04 F1800
G1 X130.065 Y124.369 Z32.2 F30000
G1 X137.246 Y126.794 Z32.2
G1 Z31.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5114
G1 X137.139 Y127.567 E.02587
G3 X129.955 Y135.073 I-9.149 J-1.567 E.36577
G3 X128.912 Y116.772 I-1.951 J-9.069 E1.06208
G1 X129.179 Y116.794 E.00889
G3 X137.243 Y126.737 I-1.189 J9.206 E.46861
G1 X137.635 Y126.844 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5114
G1 X137.526 Y127.633 E.02448
G3 X130.038 Y135.456 I-9.536 J-1.633 E.35314
G3 X128.945 Y116.381 I-2.033 J-9.452 E1.02524
G1 X129.229 Y116.405 E.00874
G3 X137.633 Y126.785 I-1.239 J9.595 E.45293
M204 S10000
; WIPE_START
G1 F12000
G1 X137.526 Y127.633 E-.32492
G1 X137.361 Y128.437 E-.31189
G1 X137.266 Y128.747 E-.12319
; WIPE_END
G1 E-.04 F1800
G1 X133.339 Y122.203 Z32.2 F30000
G1 X131.905 Y119.813 Z32.2
G1 Z31.8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F5114
G3 X133.174 Y120.826 I-3.937 J6.231 E.05397
G1 X134.023 Y119.977 E.03985
G3 X136.483 Y125.193 I-6.07 J6.05 E.19512
G1 X135.307 Y126.369 E.05514
G2 X135.307 Y125.631 I-3.451 J-.369 E.02452
G1 X136.483 Y126.807 E.05514
G3 X134.023 Y132.023 I-8.529 J-.833 E.19512
G1 X133.174 Y131.174 E.03985
G3 X131.905 Y132.187 I-5.206 J-5.218 E.05397
G1 X131.227 Y134.293 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.392402
G1 F5114
G2 X126.865 Y134.829 I-3.234 J-8.291 E1.46587
G2 X131.17 Y134.313 I1.13 J-8.778 E.12475
G1 X130.4 Y134.175 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F5114
G3 X128.803 Y134.479 I-2.463 J-8.611 E.05399
G1 X127.634 Y133.31 E.05481
G2 X128.367 Y133.309 I.36 J-3.426 E.02434
G1 X127.197 Y134.479 E.05487
G3 X125.6 Y134.175 I.866 J-8.914 E.05399
G1 X121.81 Y129.907 F30000
G1 F5114
G2 X122.822 Y131.178 I6.864 J-4.431 E.05397
G1 X121.977 Y132.023 E.03967
G3 X119.517 Y126.807 I6.07 J-6.05 E.19512
G1 X120.684 Y125.64 E.05471
G1 X120.684 Y126.36 E.02386
G1 X119.517 Y125.193 E.05471
G3 X121.977 Y119.977 I8.529 J.833 E.19512
G1 X122.822 Y120.822 E.03967
G2 X121.81 Y122.093 I5.852 J5.701 E.05397
G1 X125.6 Y117.825 F30000
G1 F5114
G3 X127.197 Y117.521 I2.463 J8.611 E.05399
G1 X128.369 Y118.693 E.05497
G2 X127.634 Y118.69 I-.385 J3.81 E.0244
G1 X128.803 Y117.521 E.05481
G3 X130.4 Y117.825 I-.866 J8.914 E.05399
; CHANGE_LAYER
; Z_HEIGHT: 32
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F15476.087
G1 X129.796 Y117.667 E-.23706
G1 X128.803 Y117.521 E-.38142
G1 X128.539 Y117.785 E-.14152
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 160/250
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L160
M991 S0 P159 ;notify layer change
G17
G3 Z32.2 I-.765 J-.947 P1  F30000
G1 X121.495 Y123.477 Z32.2
G1 Z32
G1 E.8 F1800
; FEATURE: Inner wall
G1 F5057
G1 X121.51 Y123.462 E.0007
G3 X127.724 Y119.032 I6.496 J2.538 E.26787
G3 X132.595 Y120.749 I.287 J6.954 E.17552
G3 X121.277 Y124.167 I-4.589 J5.251 E.98555
G1 X121.477 Y123.534 E.02199
G1 X121.876 Y123.606 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5057
G3 X127.755 Y119.423 I6.13 J2.393 E.23465
G3 X131.191 Y120.239 I.257 J6.552 E.10986
G3 X121.855 Y123.661 I-3.184 J5.76 E.92424
M204 S10000
; WIPE_START
G1 F12000
G1 X122.157 Y122.964 E-.28896
G1 X122.512 Y122.36 E-.26637
G1 X122.834 Y121.927 E-.20467
; WIPE_END
G1 E-.04 F1800
G1 X130.062 Y124.378 Z32.4 F30000
G1 X137.186 Y126.792 Z32.4
G1 Z32
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5057
G1 X137.077 Y127.556 E.0256
G3 X127.608 Y116.788 I-9.083 J-1.56 E1.3758
G1 X128.403 Y116.789 E.02637
G3 X137.181 Y126.736 I-.409 J9.207 E.4912
G1 X137.575 Y126.842 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5057
G1 X137.464 Y127.623 E.02422
G3 X127.592 Y116.396 I-9.469 J-1.627 E1.32866
G1 X128.42 Y116.397 E.02545
G3 X137.57 Y126.783 I-.426 J9.599 E.47488
M204 S10000
; WIPE_START
G1 F12000
G1 X137.464 Y127.623 E-.32155
G1 X137.303 Y128.422 E-.30991
G1 X137.203 Y128.746 E-.12854
; WIPE_END
G1 E-.04 F1800
G1 X131.905 Y132.187 Z32.4 F30000
G1 Z32
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F5057
G2 X133.174 Y131.174 I-3.937 J-6.231 E.05397
G1 X133.942 Y131.942 E.03604
M73 P74 R6
G2 X136.379 Y126.703 I-6.368 J-6.149 E.19524
G1 X135.307 Y125.631 E.0503
G3 X135.307 Y126.369 I-3.451 J.369 E.02452
G1 X136.379 Y125.297 E.0503
G2 X133.942 Y120.058 I-8.805 J.91 E.19524
G1 X133.174 Y120.826 E.03604
G3 X134.189 Y122.094 I-5.326 J5.303 E.05397
G1 X130.296 Y117.916 F30000
G1 F5057
G2 X128.697 Y117.627 I-3.121 J12.711 E.05394
G1 X127.634 Y118.69 E.04983
G3 X128.369 Y118.693 I.348 J3.859 E.02441
G1 X127.303 Y117.627 E.05
G2 X125.704 Y117.916 I.723 J8.574 E.05399
G1 X121.81 Y122.093 F30000
G1 F5057
G3 X122.822 Y120.822 I6.864 J4.43 E.05397
G1 X122.058 Y120.058 E.03587
G2 X119.621 Y125.297 I6.368 J6.149 E.19524
G1 X120.684 Y126.36 E.04986
G1 X120.684 Y125.64 E.02386
G1 X119.621 Y126.703 E.04986
G2 X122.058 Y131.942 I8.805 J-.91 E.19524
G1 X122.822 Y131.178 E.03587
G3 X121.81 Y129.907 I5.852 J-5.701 E.05397
G1 X125.704 Y134.084 F30000
G1 F5057
G2 X127.303 Y134.373 I2.322 J-8.286 E.05399
G1 X128.367 Y133.309 E.04989
G3 X127.634 Y133.31 I-.372 J-3.425 E.02434
G1 X128.697 Y134.373 E.04983
G2 X130.296 Y134.084 I-.722 J-8.574 E.05399
G1 X131.958 Y133.876 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.446509
G1 F5057
G2 X131.282 Y134.181 I-3.959 J-7.872 E1.7964
G1 X131.903 Y133.9 E.02241
; CHANGE_LAYER
; Z_HEIGHT: 32.2
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F15000
G1 X131.282 Y134.181 E-.25898
G1 X130.576 Y134.429 E-.28429
G1 X130.024 Y134.573 E-.21673
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 161/250
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L161
M991 S0 P160 ;notify layer change
G17
G3 Z32.4 I.965 J-.742 P1  F30000
G1 X121.495 Y123.477 Z32.4
G1 Z32.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5015
G1 X121.511 Y123.463 E.00072
G3 X127.715 Y119.033 I6.495 J2.537 E.26753
G3 X132.595 Y120.749 I.297 J6.952 E.17583
G3 X121.279 Y124.167 I-4.588 J5.251 E.98544
G1 X121.477 Y123.535 E.02199
G1 X121.876 Y123.605 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5015
G3 X127.746 Y119.423 I6.13 J2.394 E.23436
G3 X131.785 Y120.611 I.219 J6.715 E.13159
G3 X121.854 Y123.661 I-3.779 J5.388 E.90276
M204 S10000
; WIPE_START
G1 F12000
G1 X122.157 Y122.964 E-.28897
G1 X122.512 Y122.36 E-.26637
G1 X122.834 Y121.927 E-.20466
; WIPE_END
G1 E-.04 F1800
G1 X130.058 Y124.389 Z32.6 F30000
G1 X137.1 Y126.787 Z32.6
G1 Z32.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5015
G1 X136.993 Y127.542 E.02528
G3 X120.432 Y120.885 I-9 J-1.539 E1.08044
G3 X128.68 Y116.899 I7.555 J5.105 E.31837
G3 X137.094 Y126.73 I-.687 J9.105 E.47709
G1 X137.489 Y126.837 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5015
G1 X137.381 Y127.609 E.02393
G3 X130.49 Y135.187 I-9.382 J-1.609 E.33235
G3 X128.713 Y116.508 I-2.489 J-9.187 E1.01817
G3 X137.486 Y126.778 I-.714 J9.492 E.46141
M204 S10000
; WIPE_START
G1 F12000
G1 X137.381 Y127.609 E-.31828
G1 X137.219 Y128.401 E-.30717
G1 X137.116 Y128.739 E-.13455
; WIPE_END
G1 E-.04 F1800
G1 X133.268 Y122.148 Z32.6 F30000
G1 X131.905 Y119.813 Z32.6
G1 Z32.2
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F5015
G3 X133.174 Y120.826 I-3.937 J6.231 E.05397
G1 X133.861 Y120.139 E.03224
G3 X136.269 Y125.407 I-6.24 J6.037 E.19589
G1 X135.307 Y126.369 E.04513
G2 X135.307 Y125.631 I-3.451 J-.369 E.02452
G1 X136.269 Y126.593 E.04513
G3 X133.861 Y131.861 I-8.648 J-.769 E.19589
G1 X133.174 Y131.174 E.03224
G3 X131.905 Y132.187 I-5.206 J-5.218 E.05397
G1 X130.192 Y133.992 F30000
G1 F5015
G3 X128.591 Y134.267 I-2.219 J-8.145 E.05399
G1 X127.634 Y133.31 E.04485
G2 X128.367 Y133.309 I.36 J-3.426 E.02434
G1 X127.409 Y134.267 E.04491
G3 X125.808 Y133.992 I.617 J-8.419 E.05399
G1 X121.81 Y129.907 F30000
G1 F5015
G2 X122.822 Y131.178 I6.864 J-4.43 E.05397
G1 X122.139 Y131.861 E.03206
G3 X119.731 Y126.593 I6.24 J-6.037 E.19589
G1 X120.684 Y125.64 E.0447
G1 X120.684 Y126.36 E.02386
G1 X119.731 Y125.407 E.0447
G3 X122.139 Y120.139 I8.648 J.769 E.19589
G1 X122.822 Y120.822 E.03206
G2 X121.81 Y122.093 I5.852 J5.701 E.05397
G1 X124.077 Y118.219 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.475514
G1 F5015
G2 X124.756 Y117.912 I3.926 J7.776 E1.90315
G1 X124.132 Y118.195 E.02416
G1 X125.808 Y118.008 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F5015
G3 X127.409 Y117.733 I2.219 J8.145 E.05399
G1 X128.369 Y118.693 E.04503
G2 X127.634 Y118.69 I-.388 J3.901 E.02441
G1 X128.591 Y117.733 E.04485
G3 X130.192 Y118.008 I-.642 J8.563 E.05399
; CHANGE_LAYER
; Z_HEIGHT: 32.4
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F15476.087
G1 X128.591 Y117.733 E-.61752
G1 X128.325 Y117.999 E-.14248
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 162/250
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L162
M991 S0 P161 ;notify layer change
G17
G3 Z32.6 I-.761 J-.949 P1  F30000
G1 X121.495 Y123.477 Z32.6
G1 Z32.4
G1 E.8 F1800
; FEATURE: Inner wall
G1 F5002
G1 X121.511 Y123.463 E.00071
G3 X127.705 Y119.033 I6.496 J2.538 E.26722
G3 X133.127 Y121.267 I.27 J7.042 E.20062
G3 X121.278 Y124.167 I-5.121 J4.734 E.96093
G1 X121.477 Y123.534 E.02199
G1 X121.877 Y123.606 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5002
G3 X127.736 Y119.424 I6.13 J2.394 E.23405
G3 X131.785 Y120.611 I.231 J6.71 E.13188
G3 X121.855 Y123.662 I-3.778 J5.388 E.90271
M204 S10000
; WIPE_START
G1 F12000
G1 X122.157 Y122.964 E-.28896
G1 X122.512 Y122.36 E-.26637
G1 X122.834 Y121.927 E-.20468
; WIPE_END
G1 E-.04 F1800
G1 X130.055 Y124.4 Z32.8 F30000
G1 X137.014 Y126.783 Z32.8
G1 Z32.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5002
G1 X136.911 Y127.528 E.02496
G3 X129.906 Y134.846 I-8.92 J-1.527 E.35662
G3 X128.982 Y117.01 I-1.906 J-8.843 E1.039
G1 X129.149 Y117.025 E.00558
G3 X137.012 Y126.724 I-1.159 J8.976 E.45704
G1 X137.403 Y126.832 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5002
G1 X137.297 Y127.594 E.02363
G3 X129.989 Y135.229 I-9.307 J-1.594 E.34466
G3 X129.015 Y116.62 I-1.989 J-9.226 E1.00387
G1 X129.199 Y116.635 E.00568
G3 X137.401 Y126.773 I-1.209 J9.365 E.44226
M204 S10000
; WIPE_START
G1 F12000
G1 X137.297 Y127.594 E-.31463
G1 X137.136 Y128.379 E-.3044
G1 X137.028 Y128.734 E-.14097
; WIPE_END
G1 E-.04 F1800
G1 X135.884 Y128.061 Z32.8 F30000
G1 Z32.4
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F5002
G2 X136.131 Y126.455 I-8.5 J-2.129 E.05399
G1 X135.307 Y125.631 E.03865
G3 X135.307 Y126.369 I-3.451 J.369 E.02452
G1 X136.131 Y125.545 E.03865
G2 X135.884 Y123.939 I-8.746 J.522 E.05399
G1 X134.189 Y122.094 F30000
G1 F5002
G2 X133.174 Y120.826 I-6.34 J4.035 E.05397
G1 X133.762 Y120.238 E.02757
G2 X128.458 Y117.866 I-5.943 J6.172 E.19662
G1 X127.634 Y118.69 E.03864
G3 X128.37 Y118.694 I.346 J3.95 E.02442
G1 X127.542 Y117.866 E.03882
G2 X122.239 Y120.239 I.485 J8.195 E.19699
G1 X122.822 Y120.822 E.02737
G2 X121.81 Y122.093 I5.852 J5.701 E.05397
G1 X120.116 Y123.939 F30000
G1 F5002
G2 X119.869 Y125.545 I8.499 J2.129 E.05399
G1 X120.684 Y126.36 E.03821
G1 X120.684 Y125.64 E.02386
G1 X119.869 Y126.455 E.03821
G2 X120.116 Y128.061 I8.746 J-.522 E.05399
G1 X121.81 Y129.907 F30000
G1 F5002
G2 X122.822 Y131.178 I6.864 J-4.431 E.05397
G1 X122.238 Y131.762 E.0274
G2 X127.542 Y134.134 I5.79 J-5.831 E.19699
G1 X128.367 Y133.309 E.03869
G3 X127.634 Y133.31 I-.372 J-3.425 E.02434
G1 X128.458 Y134.134 E.03863
G2 X133.762 Y131.762 I-.638 J-8.542 E.19663
G1 X133.174 Y131.174 E.02757
G3 X131.905 Y132.187 I-5.206 J-5.218 E.05397
; WIPE_START
G1 F15476.087
G1 X132.825 Y131.514 E-.43304
G1 X133.174 Y131.174 E-.18519
G1 X133.438 Y131.438 E-.14177
; WIPE_END
G1 E-.04 F1800
G1 X128.225 Y125.862 Z32.8 F30000
G1 X122.326 Y119.553 Z32.8
G1 Z32.4
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.534823
G1 F5002
G2 X134.201 Y131.943 I5.674 J6.447 E1.11076
G2 X122.372 Y119.515 I-6.199 J-5.943 E1.04988
; CHANGE_LAYER
; Z_HEIGHT: 32.6
; LAYER_HEIGHT: 0.199997
; WIPE_START
G1 F12807.423
G1 X122.888 Y119.088 E-.25438
G1 X123.492 Y118.679 E-.2773
G1 X124.017 Y118.386 E-.22832
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 163/250
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L163
M991 S0 P162 ;notify layer change
G17
G3 Z32.8 I-1.091 J-.54 P1  F30000
G1 X121.495 Y123.477 Z32.8
G1 Z32.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4819
G1 X121.511 Y123.463 E.00072
G3 X127.696 Y119.034 I6.495 J2.537 E.26688
G3 X133.127 Y121.267 I.281 J7.039 E.20093
G3 X121.279 Y124.167 I-5.121 J4.734 E.96084
G1 X121.477 Y123.535 E.02199
G1 X121.866 Y123.603 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4819
G1 X121.876 Y123.605 E.0003
G3 X127.727 Y119.425 I6.13 J2.395 E.23376
G3 X132.336 Y121.044 I.285 J6.56 E.15382
G3 X121.656 Y124.27 I-4.33 J4.956 E.86156
G1 X121.848 Y123.661 E.01963
M204 S10000
; WIPE_START
G1 F12000
G1 X121.876 Y123.605 E-.02344
G1 X122.157 Y122.964 E-.26619
G1 X122.512 Y122.36 E-.26637
G1 X122.833 Y121.929 E-.204
; WIPE_END
G1 E-.04 F1800
G1 X130.049 Y124.413 Z33 F30000
G1 X136.917 Y126.776 Z33
G1 Z32.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4819
G1 X136.813 Y127.511 E.02461
G3 X123.97 Y118.007 I-8.82 J-1.511 E1.21005
G3 X128.474 Y117.064 I4.062 J8.178 E.15432
G3 X136.913 Y126.718 I-.481 J8.936 E.47416
G1 X137.306 Y126.826 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4819
G1 X137.206 Y127.578 E.02332
G3 X123.198 Y117.989 I-9.206 J-1.578 E1.14873
G3 X128.508 Y116.674 I4.779 J7.919 E.17063
G3 X137.309 Y126.766 I-.508 J9.326 E.45879
M204 S10000
; WIPE_START
G1 F12000
G1 X137.206 Y127.578 E-.31107
G1 X137.043 Y128.355 E-.30133
G1 X136.929 Y128.726 E-.1476
; WIPE_END
G1 E-.04 F1800
G1 X134.679 Y130.393 Z33 F30000
G1 Z32.6
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4819
G3 X133.652 Y131.652 I-6.615 J-4.351 E.05398
G1 X133.174 Y131.174 E.02242
G2 X135.307 Y126.369 I-5.028 J-5.108 E.17856
G1 X135.989 Y125.687 E.03198
G3 X135.989 Y126.313 I-3.512 J.313 E.02078
G1 X135.307 Y125.631 E.03198
G2 X135.046 Y124.029 I-7.322 J.371 E.05397
G1 X132.397 Y119.316 F30000
G1 F4819
G3 X133.652 Y120.348 I-4.671 J6.955 E.05399
G1 X133.174 Y120.826 E.02242
G2 X128.37 Y118.694 I-5.107 J5.029 E.17852
G1 X127.682 Y118.006 E.03227
G1 X128.31 Y118.014 E.02085
G1 X127.634 Y118.69 E.0317
G2 X122.822 Y120.822 I.325 J7.227 E.1787
G1 X122.345 Y120.345 E.0224
G2 X121.321 Y121.607 I5.904 J5.838 E.05399
G1 X120.943 Y124.036 F30000
G1 F4819
G2 X120.684 Y125.64 I4.754 J1.593 E.05415
G1 X120.011 Y126.313 E.03154
G3 X120.011 Y125.687 I3.512 J-.313 E.02078
G1 X120.684 Y126.36 E.03154
G2 X120.943 Y127.964 I5.014 J.011 E.05415
G1 X121.884 Y131.861 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.58705
G1 F4819
G2 X128.511 Y117.543 I6.112 J-5.864 E1.45977
G2 X121.844 Y131.817 I-.51 J8.456 E.89697
G1 X121.321 Y130.393 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4819
G2 X122.348 Y131.652 I6.615 J-4.351 E.05398
G1 X122.822 Y131.178 E.02225
G2 X127.634 Y133.31 I5.137 J-5.094 E.1787
G1 X128.319 Y133.995 E.0321
G1 X127.681 Y133.995 E.02115
G1 X128.367 Y133.309 E.03216
G2 X129.97 Y133.05 I-.439 J-7.812 E.05397
; CHANGE_LAYER
; Z_HEIGHT: 32.8
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F15476.087
G1 X129.358 Y133.2 E-.23964
G1 X128.367 Y133.309 E-.37876
G1 X128.103 Y133.573 E-.14161
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 164/250
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L164
M991 S0 P163 ;notify layer change
G17
G3 Z33 I1.018 J-.667 P1  F30000
G1 X121.495 Y123.477 Z33
G1 Z32.8
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4738
M73 P75 R6
G1 X121.511 Y123.463 E.00071
G3 X127.686 Y119.035 I6.495 J2.539 E.26658
G3 X133.601 Y121.839 I.325 J6.956 E.22605
G3 X121.278 Y124.167 I-5.595 J4.163 E.93631
G1 X121.477 Y123.534 E.02199
G1 X121.866 Y123.604 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4738
G1 X121.877 Y123.606 E.00033
G3 X127.718 Y119.426 I6.13 J2.395 E.23345
G3 X132.336 Y121.044 I.295 J6.558 E.15411
G3 X121.657 Y124.27 I-4.33 J4.956 E.86153
G1 X121.848 Y123.661 E.01962
M204 S10000
; WIPE_START
G1 F12000
G1 X121.877 Y123.606 E-.02358
G1 X122.157 Y122.964 E-.26618
G1 X122.512 Y122.36 E-.26637
G1 X122.832 Y121.929 E-.20388
; WIPE_END
G1 E-.04 F1800
G1 X130.044 Y124.427 Z33.2 F30000
G1 X136.803 Y126.768 Z33.2
G1 Z32.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4738
G1 X136.7 Y127.492 E.02424
G3 X120.678 Y121.052 I-8.707 J-1.488 E1.04525
G3 X128.783 Y117.206 I7.327 J4.977 E.31204
G3 X136.797 Y126.71 I-.79 J8.797 E.45748
G1 X137.192 Y126.818 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4738
G1 X137.086 Y127.558 E.02296
G3 X119.943 Y121.499 I-9.093 J-1.555 E.98713
G3 X128.816 Y116.815 I8.045 J4.493 E.32604
G3 X137.187 Y126.759 I-.823 J9.188 E.44317
M204 S10000
; WIPE_START
G1 F12000
G1 X137.086 Y127.558 E-.30614
G1 X136.932 Y128.326 E-.29755
G1 X136.811 Y128.719 E-.15632
; WIPE_END
G1 E-.04 F1800
G1 X135.046 Y124.029 Z33.2 F30000
G1 Z32.8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4738
G3 X135.307 Y125.631 I-7.061 J1.973 E.05397
G1 X135.837 Y126.161 E.02487
G2 X135.837 Y125.839 I-1.789 J-.161 E.01071
G1 X135.307 Y126.369 E.02487
G3 X133.174 Y131.174 I-7.161 J-.303 E.17856
G1 X133.542 Y131.542 E.01727
G3 X132.283 Y132.569 I-13.829 J-15.664 E.05391
G1 X134.018 Y131.768 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.631022
G1 F4738
G2 X127.603 Y134.33 I-6.021 J-5.763 E2.16818
G2 X133.975 Y131.81 I.394 J-8.317 E.33843
G1 X129.97 Y133.05 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4738
G3 X128.367 Y133.309 I-2.043 J-7.553 E.05397
G1 X127.84 Y133.836 E.02472
G1 X128.161 Y133.837 E.01064
G1 X127.634 Y133.31 E.02468
G3 X122.822 Y131.178 I.325 J-7.227 E.1787
G1 X122.458 Y131.542 E.01712
G2 X123.717 Y132.57 I15.927 J-18.234 E.05392
G1 X120.943 Y127.964 F30000
G1 F4738
G3 X120.684 Y126.36 I4.754 J-1.593 E.05415
G1 X120.164 Y125.84 E.02439
G2 X120.162 Y126.162 I1.846 J.17 E.01069
G1 X120.684 Y125.64 E.02446
G3 X120.943 Y124.036 I5.014 J-.011 E.05415
G1 X123.717 Y119.43 F30000
G1 F4738
G2 X122.458 Y120.458 I14.636 J19.223 E.05392
G1 X122.822 Y120.822 E.01712
G3 X127.634 Y118.69 I5.137 J5.094 E.1787
G1 X128.159 Y118.165 E.02463
G1 X127.84 Y118.164 E.01058
G1 X128.37 Y118.694 E.02484
G3 X133.174 Y120.826 I-.303 J7.16 E.17851
G1 X133.543 Y120.457 E.0173
G2 X132.283 Y119.431 I-15.354 J17.559 E.05391
; CHANGE_LAYER
; Z_HEIGHT: 33
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F15476.087
G1 X132.901 Y119.875 E-.28907
G1 X133.543 Y120.457 E-.32941
G1 X133.279 Y120.721 E-.14152
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 165/250
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L165
M991 S0 P164 ;notify layer change
G17
G3 Z33.2 I-.277 J-1.185 P1  F30000
G1 X121.495 Y123.477 Z33.2
G1 Z33
G1 E.8 F1800
; FEATURE: Inner wall
G1 F5457
G1 X121.512 Y123.463 E.00072
G3 X127.677 Y119.036 I6.495 J2.538 E.26624
G3 X133.601 Y121.839 I.335 J6.955 E.22636
G3 X121.279 Y124.167 I-5.595 J4.162 E.93623
G1 X121.477 Y123.535 E.02199
G1 X121.866 Y123.604 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5457
G1 X121.876 Y123.606 E.00031
G3 X127.708 Y119.426 I6.13 J2.395 E.23316
G3 X132.839 Y121.533 I.271 J6.642 E.1758
G3 X121.657 Y124.27 I-4.832 J4.468 E.84004
G1 X121.848 Y123.661 E.01962
M204 S10000
; WIPE_START
G1 F12000
G1 X121.876 Y123.606 E-.02365
G1 X122.157 Y122.964 E-.26619
G1 X122.512 Y122.36 E-.26637
G1 X122.832 Y121.929 E-.2038
; WIPE_END
G1 E-.04 F1800
G1 X130.039 Y124.442 Z33.4 F30000
G1 X136.688 Y126.76 Z33.4
G1 Z33
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5457
G1 X136.592 Y127.473 E.02386
G3 X128.37 Y117.286 I-8.592 J-1.477 E1.32586
G1 X129.092 Y117.347 E.02404
G1 X129.108 Y117.348 E.00052
G3 X136.69 Y126.701 I-1.108 J8.648 E.44083
G1 X137.077 Y126.81 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5457
G1 X136.982 Y127.54 E.02262
G3 X124.632 Y134.468 I-8.983 J-1.541 E.4983
G1 X124.602 Y134.457 E.001
G3 X123.868 Y117.877 I3.411 J-8.457 E.64067
G1 X123.897 Y117.861 E.001
G3 X129.125 Y116.956 I4.131 J8.314 E.16536
G1 X129.158 Y116.959 E.001
G3 X137.083 Y126.751 I-1.158 J9.04 E.42732
M204 S10000
; WIPE_START
G1 F12000
G1 X136.982 Y127.54 E-.30248
G1 X136.821 Y128.297 E-.29398
G1 X136.694 Y128.708 E-.16354
; WIPE_END
G1 E-.04 F1800
G1 X134.444 Y130.16 Z33.4 F30000
G1 Z33
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F5457
G3 X133.425 Y131.425 I-6.422 J-4.129 E.054
G1 X133.174 Y131.174 E.01179
G2 X135.307 Y126.369 I-5.028 J-5.108 E.17856
G1 X135.678 Y126 E.01735
G1 X135.307 Y125.631 E.01735
G2 X133.174 Y120.826 I-7.161 J.303 E.17856
G1 X133.425 Y120.575 E.01179
G3 X134.444 Y121.84 I-5.403 J5.394 E.054
G1 X129.97 Y118.95 F30000
G1 F5457
G2 X128.367 Y118.691 I-2.043 J7.554 E.05397
G1 X127.99 Y118.334 E.01722
G1 X127.634 Y118.69 E.01667
G2 X122.822 Y120.822 I.325 J7.227 E.1787
G1 X122.577 Y120.577 E.0115
G2 X121.555 Y121.84 I5.353 J5.376 E.054
G1 X120.891 Y121.616 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.362842
G1 F5457
G2 X129.975 Y117.884 I7.11 J4.384 E1.09456
G1 X129.119 Y117.719 E.02272
G2 X120.924 Y121.566 I-1.105 J8.3 E.24936
G1 X120.682 Y122.69 F30000
; LINE_WIDTH: 0.362751
G1 F5457
G3 X120.986 Y129.921 I7.317 J3.314 E1.11969
G3 X120.66 Y122.745 I7.002 J-3.914 E.19411
G1 X120.943 Y127.964 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F5457
G3 X120.684 Y126.36 I4.754 J-1.593 E.05415
G1 X120.325 Y126.001 E.01681
G1 X120.684 Y125.64 E.01687
G3 X120.943 Y124.036 I5.014 J-.011 E.05415
G1 X121.556 Y130.16 F30000
G1 F5457
G2 X122.576 Y131.424 I6.58 J-4.262 E.05398
G1 X122.822 Y131.178 E.01158
G2 X127.634 Y133.31 I5.137 J-5.094 E.1787
G1 X128.006 Y133.67 E.01715
G1 X128.367 Y133.309 E.01692
G2 X129.97 Y133.05 I-.439 J-7.813 E.05397
; CHANGE_LAYER
; Z_HEIGHT: 33.2
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F15476.087
G1 X129.358 Y133.2 E-.23963
G1 X128.367 Y133.309 E-.37876
G1 X128.103 Y133.573 E-.14161
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 166/250
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L166
M991 S0 P165 ;notify layer change
G17
G3 Z33.4 I1.018 J-.667 P1  F30000
G1 X121.495 Y123.477 Z33.4
G1 Z33.2
G1 E.8 F1800
; FEATURE: Inner wall
G1 F5570
G1 X121.512 Y123.463 E.00073
G3 X127.667 Y119.036 I6.495 J2.538 E.26591
G3 X133.601 Y121.839 I.345 J6.954 E.22667
G3 X121.279 Y124.167 I-5.594 J4.163 E.9362
G1 X121.477 Y123.535 E.02199
G1 X121.866 Y123.604 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5570
G1 X121.877 Y123.606 E.00033
G3 X127.699 Y119.427 I6.13 J2.395 E.23285
G3 X132.839 Y121.533 I.281 J6.639 E.17609
G3 X121.657 Y124.27 I-4.832 J4.468 E.84002
G1 X121.848 Y123.661 E.01961
M204 S10000
; WIPE_START
G1 F12000
G1 X121.877 Y123.606 E-.02373
G1 X122.157 Y122.964 E-.26618
G1 X122.512 Y122.36 E-.26637
G1 X122.832 Y121.929 E-.20372
; WIPE_END
G1 E-.04 F1800
G1 X130.033 Y124.46 Z33.6 F30000
G1 X136.545 Y126.748 Z33.6
G1 Z33.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5570
G1 X136.441 Y127.478 E.02445
G3 X123.033 Y119.009 I-8.447 J-1.476 E1.11567
G3 X128.837 Y117.469 I4.966 J7.012 E.20347
G3 X136.541 Y126.693 I-.843 J8.533 E.44172
G1 X136.934 Y126.799 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5570
G1 X136.828 Y127.546 E.02317
G3 X122.194 Y119.164 I-8.833 J-1.543 E1.05693
G3 X128.871 Y117.079 I5.798 J6.831 E.22081
G3 X136.931 Y126.74 I-.877 J8.924 E.42851
M204 S10000
; WIPE_START
G1 F12000
G1 X136.828 Y127.546 E-.30867
G1 X136.669 Y128.307 E-.29553
G1 X136.546 Y128.699 E-.15581
; WIPE_END
G1 E-.04 F1800
G1 X129.021 Y127.422 Z33.6 F30000
G1 X120.64 Y126 Z33.6
G1 Z33.2
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.419999
G1 F5570
G3 X121.864 Y121.917 I7.497 J.023 E.13279
G3 X123.234 Y120.391 I6.54 J4.489 E.0632
G1 X124.082 Y119.757 E.03254
G3 X128.327 Y118.646 I3.937 J6.374 E.13682
G3 X135.25 Y124.725 I-.326 J7.353 E.30588
G1 X135.329 Y125.227 E.01561
G3 X128.326 Y133.354 I-7.34 J.756 E.36908
G1 X127.814 Y133.368 E.01574
G3 X123.055 Y131.453 I.236 J-7.459 E.1609
G1 X122.333 Y130.712 E.0318
G3 X120.665 Y126.629 I5.757 J-4.733 E.13756
G1 X120.642 Y126.06 E.0175
; WIPE_START
G1 F15000
G1 X120.665 Y126.629 E-.21647
G1 X120.741 Y127.255 E-.23942
G1 X120.892 Y127.949 E-.26996
G1 X120.921 Y128.034 E-.03415
; WIPE_END
G1 E-.04 F1800
G1 X128.201 Y130.326 Z33.6 F30000
G1 X133.091 Y131.866 Z33.6
G1 Z33.2
G1 E.8 F1800
; LINE_WIDTH: 0.484177
G1 F5570
G2 X133.984 Y121.04 I-5.081 J-5.869 E.43258
G1 X133.217 Y120.236 E.03994
G2 X123.228 Y119.871 I-5.212 J5.763 E.39045
G2 X122.558 Y131.544 I4.78 J6.13 E.47585
G2 X133.045 Y131.904 I5.44 J-5.544 E.41424
G1 X133.353 Y132.164 F30000
; LINE_WIDTH: 0.419999
G1 F5570
G2 X135.104 Y130.067 I-4.966 J-5.923 E.08439
G2 X134.312 Y120.791 I-7.133 J-4.062 E.30415
G1 X133.513 Y119.953 E.03556
G2 X123.7 Y119.039 I-5.515 J6.072 E.32484
G2 X121.732 Y120.739 I5.391 J8.229 E.08015
G2 X121.162 Y130.487 I6.285 J5.259 E.32145
G1 X121.67 Y131.185 E.02651
G2 X123.615 Y132.911 I7.428 J-6.413 E.08015
G2 X128.337 Y134.178 I4.424 J-7.053 E.15246
G2 X132.931 Y132.531 I-.429 J-8.428 E.15214
G1 X133.308 Y132.204 E.01535
; CHANGE_LAYER
; Z_HEIGHT: 33.4
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F15000
G1 X132.931 Y132.531 E-.18983
G1 X132.355 Y132.93 E-.26627
G1 X131.739 Y133.281 E-.26935
G1 X131.656 Y133.319 E-.03455
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 167/250
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L167
M991 S0 P166 ;notify layer change
G17
G3 Z33.6 I.849 J-.872 P1  F30000
G1 X121.509 Y123.441 Z33.6
G1 Z33.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4648
G1 X121.818 Y122.788 E.02398
G3 X127.658 Y119.037 I6.188 J3.214 E.24099
G3 X134.012 Y122.458 I.327 J7.005 E.25143
G3 X121.498 Y123.499 I-6.006 J3.544 E.93497
G1 X121.866 Y123.604 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4648
G1 X121.878 Y123.606 E.00036
G3 X127.689 Y119.428 I6.129 J2.395 E.23254
G3 X132.839 Y121.533 I.292 J6.636 E.17638
G3 X121.658 Y124.27 I-4.832 J4.468 E.83994
G1 X121.848 Y123.661 E.0196
M204 S10000
; WIPE_START
G1 F12000
G1 X121.878 Y123.606 E-.02382
G1 X122.157 Y122.964 E-.26617
G1 X122.512 Y122.36 E-.26637
G1 X122.832 Y121.929 E-.20365
; WIPE_END
G1 E-.04 F1800
M73 P76 R6
G1 X130.024 Y124.485 Z33.8 F30000
G1 X136.39 Y126.747 Z33.8
G1 Z33.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4648
G3 X124.601 Y118.288 I-8.394 J-.746 E1.17665
G3 X128.502 Y117.589 I3.429 J7.9 E.13266
G3 X136.395 Y126.687 I-.506 J8.412 E.44512
G1 X136.787 Y126.788 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4648
G1 X136.677 Y127.557 E.02388
G3 X123.733 Y118.28 I-8.681 J-1.556 E1.09225
G3 X128.536 Y117.198 I4.295 J7.864 E.15325
G3 X136.785 Y126.731 I-.54 J8.803 E.43154
M204 S10000
; WIPE_START
G1 F12000
G1 X136.677 Y127.557 E-.31655
G1 X136.512 Y128.322 E-.29745
G1 X136.394 Y128.688 E-.146
; WIPE_END
G1 E-.04 F1800
G1 X130.451 Y133.478 Z33.8 F30000
G1 X130.267 Y133.627 Z33.8
G1 Z33.4
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.566824
G1 F4648
G1 X131.061 Y133.352 E.03589
G2 X135.46 Y128.784 I-3.135 J-7.421 E.27824
G2 X131.888 Y119.053 I-7.481 J-2.775 E.48169
G2 X123.114 Y119.717 I-3.886 J6.954 E.39796
G2 X120.068 Y126.694 I4.939 J6.31 E.33868
G2 X127.635 Y133.955 I7.963 J-.725 E.4883
G2 X130.209 Y133.642 I.355 J-7.825 E.1112
G1 X132.598 Y131.843 F30000
; LINE_WIDTH: 0.5668
G1 F4648
G3 X125.722 Y118.921 I-4.598 J-5.843 E1.11002
G3 X132.644 Y131.804 I2.276 J7.078 E.88158
; CHANGE_LAYER
; Z_HEIGHT: 33.6
; LAYER_HEIGHT: 0.199997
; WIPE_START
G1 F12025.665
G1 X133.094 Y131.417 E-.22552
G1 X133.632 Y130.855 E-.29553
G1 X134.024 Y130.363 E-.23895
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 168/250
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L168
M991 S0 P167 ;notify layer change
G17
G3 Z33.8 I.586 J-1.066 P1  F30000
G1 X121.495 Y123.477 Z33.8
G1 Z33.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4649
G1 X121.512 Y123.463 E.00073
G3 X127.649 Y119.038 I6.495 J2.539 E.26527
G3 X134.012 Y122.458 I.337 J7.003 E.25174
G3 X121.279 Y124.167 I-6.005 J3.544 E.91161
G1 X121.477 Y123.535 E.02199
G1 X121.866 Y123.604 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4649
G1 X121.877 Y123.606 E.00033
G3 X127.68 Y119.429 I6.13 J2.396 E.23226
G3 X133.286 Y122.073 I.332 J6.562 E.19835
G3 X121.657 Y124.27 I-5.28 J3.929 E.81851
G1 X121.848 Y123.662 E.0196
M204 S10000
; WIPE_START
G1 F12000
G1 X121.877 Y123.606 E-.02382
G1 X122.157 Y122.964 E-.26618
G1 X122.512 Y122.36 E-.26637
G1 X122.832 Y121.929 E-.20363
; WIPE_END
G1 E-.04 F1800
G1 X130.015 Y124.51 Z34 F30000
G1 X136.231 Y126.743 Z34
G1 Z33.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4649
G3 X127.616 Y117.737 I-8.234 J-.747 E1.25501
G1 X128.389 Y117.737 E.02564
G3 X136.236 Y126.683 I-.392 J8.259 E.44064
G1 X136.63 Y126.771 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4649
G1 X136.622 Y126.779 E.00036
G3 X126.82 Y117.416 I-8.626 J-.781 E1.19392
G3 X128.42 Y117.347 I1.32 J11.889 E.04927
G3 X136.657 Y126 I-.425 J8.651 E.40508
G1 X136.632 Y126.711 E.02185
M204 S10000
; WIPE_START
G1 F12000
G1 X136.622 Y126.779 E-.02628
G1 X136.524 Y127.554 E-.29678
G1 X136.35 Y128.315 E-.29676
G1 X136.235 Y128.666 E-.14017
; WIPE_END
G1 E-.04 F1800
G1 X133.754 Y131.327 Z34 F30000
G1 Z33.6
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.488048
G1 F4649
G2 X131.826 Y119.155 I-5.766 J-5.326 E.51403
G2 X120.707 Y123.116 I-3.82 J6.864 E.48443
G2 X130.236 Y133.516 I7.294 J2.883 E.63616
G2 X133.712 Y131.37 I-2.169 J-7.398 E.14995
; WIPE_START
G1 F14153.258
G1 X133.403 Y131.687 E-.16824
G1 X132.893 Y132.13 E-.25667
G1 X132.321 Y132.547 E-.2691
G1 X132.172 Y132.636 E-.066
; WIPE_END
G1 E-.04 F1800
G1 X125.109 Y132.807 Z34 F30000
G1 Z33.6
G1 E.8 F1800
; LINE_WIDTH: 0.488456
G1 F4649
G3 X125.732 Y118.96 I2.893 J-6.808 E.65198
G3 X128.327 Y133.389 I2.266 J7.041 E.91527
G3 X125.165 Y132.828 I-.305 J-7.469 E.11749
; CHANGE_LAYER
; Z_HEIGHT: 33.8
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F14140.288
G1 X125.732 Y133.04 E-.2299
G1 X126.326 Y133.209 E-.23445
G1 X127.029 Y133.339 E-.27192
G1 X127.091 Y133.343 E-.02374
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 169/250
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L169
M991 S0 P168 ;notify layer change
G17
G3 Z34 I1.059 J-.6 P1  F30000
G1 X121.495 Y123.477 Z34
G1 Z33.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4538
G1 X121.504 Y123.46 E.00064
G3 X127.639 Y119.039 I6.494 J2.543 E.26512
G3 X134.273 Y122.961 I.383 J6.924 E.27106
G3 X121.271 Y124.165 I-6.275 J3.043 E.89294
G1 X121.477 Y123.534 E.022
G1 X121.866 Y123.604 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4538
G1 X121.877 Y123.606 E.00035
G3 X127.67 Y119.429 I6.129 J2.396 E.23195
G3 X133.286 Y122.073 I.342 J6.56 E.19863
G3 X121.658 Y124.27 I-5.279 J3.929 E.8185
G1 X121.848 Y123.662 E.0196
M204 S10000
; WIPE_START
G1 F12000
G1 X121.877 Y123.606 E-.02385
G1 X122.157 Y122.964 E-.26618
G1 X122.512 Y122.36 E-.26637
G1 X122.832 Y121.93 E-.20361
; WIPE_END
G1 E-.04 F1800
G1 X130.006 Y124.535 Z34.2 F30000
G1 X136.065 Y126.735 Z34.2
G1 Z33.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4538
G3 X125.55 Y118.274 I-8.07 J-.735 E1.15995
G3 X128.453 Y117.91 I2.499 J8.16 E.09753
G3 X136.07 Y126.676 I-.458 J8.091 E.42947
G1 X136.463 Y126.763 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4538
G1 X136.455 Y126.771 E.00035
G3 X125.437 Y117.899 I-8.461 J-.77 E1.12664
G3 X128.485 Y117.519 I2.613 J8.547 E.09483
G3 X136.49 Y126 I-.49 J8.482 E.39497
G1 X136.465 Y126.703 E.02161
M204 S10000
; WIPE_START
G1 F12000
G1 X136.455 Y126.771 E-.02609
G1 X136.358 Y127.537 E-.29338
G1 X136.184 Y128.29 E-.29367
G1 X136.063 Y128.657 E-.14686
; WIPE_END
G1 E-.04 F1800
G1 X132.883 Y121.718 Z34.2 F30000
G1 X131.758 Y119.264 Z34.2
G1 Z33.8
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.404379
G1 F4538
G2 X123.255 Y119.917 I-3.759 J6.73 E.26616
G1 X122.687 Y120.399 E.02194
G2 X132.831 Y132.02 I5.321 J5.594 E.6949
G2 X131.809 Y119.296 I-4.836 J-6.015 E.44274
G1 X129.733 Y118.854 F30000
; LINE_WIDTH: 0.405088
G1 F4538
G3 X128.306 Y133.348 I-1.734 J7.147 E.62112
G3 X125.776 Y118.99 I-.304 J-7.348 E.62415
G3 X129.674 Y118.843 I2.21 J6.871 E.11656
; CHANGE_LAYER
; Z_HEIGHT: 34
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F15000
G1 X128.965 Y118.71 E-.27417
G1 X128.421 Y118.656 E-.20785
G1 X127.689 Y118.652 E-.27797
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 170/250
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L170
M991 S0 P169 ;notify layer change
G17
G3 Z34.2 I-.745 J-.962 P1  F30000
G1 X121.509 Y123.441 Z34.2
G1 Z34
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3675
G1 X121.818 Y122.788 E.02398
G3 X127.63 Y119.039 I6.188 J3.215 E.24003
G3 X134.354 Y123.117 I.382 J6.955 E.2772
G3 X121.498 Y123.499 I-6.348 J2.886 E.91035
G1 X121.866 Y123.604 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3675
G1 X121.877 Y123.606 E.00033
G3 X127.661 Y119.43 I6.129 J2.397 E.23167
G3 X133.674 Y122.657 I.326 J6.608 E.2203
G3 X121.657 Y124.27 I-5.668 J3.346 E.797
G1 X121.848 Y123.662 E.0196
M204 S10000
; WIPE_START
G1 F12000
G1 X121.877 Y123.606 E-.02383
G1 X122.157 Y122.964 E-.26618
G1 X122.512 Y122.36 E-.26637
G1 X122.832 Y121.93 E-.20361
; WIPE_END
G1 E-.04 F1800
G1 X129.997 Y124.56 Z34.4 F30000
G1 X135.898 Y126.726 Z34.4
G1 Z34
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3675
G3 X129.034 Y133.871 I-7.904 J-.724 E.35493
G3 X128.517 Y118.082 I-1.027 J-7.869 E.87813
G3 X135.903 Y126.667 I-.524 J7.92 E.41826
G1 X136.297 Y126.755 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3675
G1 X136.288 Y126.762 E.00034
G3 X129.086 Y134.26 I-8.295 J-.76 E.345
G3 X128.549 Y117.691 I-1.078 J-8.258 E.85383
G3 X136.323 Y126 I-.556 J8.311 E.38488
G1 X136.299 Y126.695 E.02138
M204 S10000
G1 X135.423 Y126.647 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.598732
G1 F3675
G1 X135.412 Y126.778 E.00593
G3 X120.556 Y125.589 I-7.413 J-.777 E1.04406
G3 X121.006 Y123.418 I7.598 J.444 E.10074
G3 X135.452 Y126 I6.992 J2.583 E.94113
G1 X135.425 Y126.587 E.02662
; CHANGE_LAYER
; Z_HEIGHT: 34.2
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F11334.765
G1 X135.412 Y126.778 E-.07257
G1 X135.29 Y127.562 E-.30151
G1 X135.074 Y128.355 E-.31264
G1 X135.003 Y128.535 E-.07328
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 171/250
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L171
M991 S0 P170 ;notify layer change
G17
G3 Z34.4 I.43 J-1.139 P1  F30000
G1 X121.509 Y123.441 Z34.4
G1 Z34.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3648
G1 X121.818 Y122.788 E.02398
G3 X127.62 Y119.04 I6.188 J3.215 E.2397
G3 X134.354 Y123.117 I.367 J6.994 E.2773
G3 X121.498 Y123.499 I-6.348 J2.886 E.91034
G1 X121.866 Y123.604 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3648
G1 X121.877 Y123.606 E.00034
G3 X127.652 Y119.431 I6.129 J2.397 E.23137
G3 X133.175 Y121.939 I.375 J6.512 E.19388
G1 X133.286 Y122.073 E.00534
G1 X133.674 Y122.657 E.02154
G3 X121.657 Y124.27 I-5.667 J3.346 E.79699
G1 X121.848 Y123.662 E.0196
M204 S10000
; WIPE_START
G1 F12000
G1 X121.877 Y123.606 E-.02384
G1 X122.157 Y122.964 E-.26618
G1 X122.512 Y122.36 E-.26637
G1 X122.832 Y121.93 E-.20362
; WIPE_END
G1 E-.04 F1800
G1 X129.987 Y124.585 Z34.6 F30000
G1 X135.731 Y126.717 Z34.6
G1 Z34.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3648
G3 X128.999 Y133.708 I-7.737 J-.715 E.34772
G3 X128.581 Y118.255 I-.992 J-7.705 E.8617
G3 X135.736 Y126.658 I-.587 J7.748 E.40712
G1 X136.13 Y126.747 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3648
G1 X136.122 Y126.754 E.00032
G3 X129.05 Y134.097 I-8.128 J-.751 E.33831
G3 X128.613 Y117.864 I-1.043 J-8.094 E.8386
G3 X136.156 Y126 I-.619 J8.139 E.37483
G1 X136.132 Y126.688 E.02114
M204 S10000
G1 X135.343 Y126.648 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.432328
M73 P77 R6
G1 F3648
G1 X135.335 Y126.681 E.00105
G3 X120.638 Y125.597 I-7.339 J-.674 E.72621
G3 X121.34 Y122.842 I7.251 J.381 E.09082
G3 X135.366 Y126 I6.656 J3.164 E.6307
G1 X135.345 Y126.588 E.01868
; CHANGE_LAYER
; Z_HEIGHT: 34.4
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F15000
G1 X135.335 Y126.681 E-.03521
G1 X135.245 Y127.36 E-.26036
G1 X135.158 Y127.749 E-.15139
G1 X134.996 Y128.325 E-.22759
G1 X134.915 Y128.535 E-.08545
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 172/250
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L172
M991 S0 P171 ;notify layer change
G17
G3 Z34.6 I.429 J-1.139 P1  F30000
G1 X121.495 Y123.477 Z34.6
G1 Z34.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3591
G1 X121.511 Y123.463 E.00072
G3 X127.611 Y119.041 I6.494 J2.54 E.264
G3 X134.625 Y123.808 I.379 J6.986 E.30224
G3 X121.278 Y124.167 I-6.619 J2.195 E.8624
G1 X121.477 Y123.534 E.02199
G1 X121.866 Y123.604 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3591
G1 X121.878 Y123.606 E.00036
G3 X127.642 Y119.432 I6.129 J2.396 E.23106
G3 X133.674 Y122.657 I.346 J6.605 E.22088
G3 X121.658 Y124.27 I-5.667 J3.345 E.79693
G1 X121.848 Y123.662 E.0196
M204 S10000
; WIPE_START
G1 F12000
G1 X121.878 Y123.606 E-.02384
G1 X122.157 Y122.964 E-.26616
G1 X122.512 Y122.36 E-.26637
G1 X122.832 Y121.93 E-.20362
; WIPE_END
G1 E-.04 F1800
G1 X129.978 Y124.611 Z34.8 F30000
G1 X135.565 Y126.708 Z34.8
G1 Z34.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3591
G3 X128.964 Y133.544 I-7.571 J-.706 E.34049
G3 X128.645 Y118.427 I-.957 J-7.542 E.8453
G3 X135.57 Y126.649 I-.652 J7.576 E.396
G1 X135.963 Y126.74 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3591
G1 X135.955 Y126.745 E.00031
G3 X129.015 Y133.933 I-7.961 J-.742 E.33162
G3 X128.677 Y118.036 I-1.008 J-7.931 E.8234
G3 X135.989 Y126 I-.684 J7.967 E.36481
G1 X135.966 Y126.68 E.0209
M204 S10000
G1 X135.26 Y126.645 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.265743
M73 P77 R5
G1 F3591
G1 X135.257 Y126.68 E.00064
G3 X120.72 Y125.618 I-7.258 J-.674 E.41059
G1 X120.72 Y125.606 E.00021
G3 X121.531 Y122.645 I7.249 J.392 E.05617
G3 X135.288 Y126 I6.468 J3.361 E.35226
G1 X135.262 Y126.585 E.01062
; CHANGE_LAYER
; Z_HEIGHT: 34.6
; LAYER_HEIGHT: 0.199997
; WIPE_START
G1 F15000
G1 X135.257 Y126.68 E-.03613
G1 X135.161 Y127.357 E-.26012
G1 X135.002 Y128.017 E-.25774
G1 X134.828 Y128.53 E-.206
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 173/250
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L173
M991 S0 P172 ;notify layer change
G17
G3 Z34.8 I.431 J-1.138 P1  F30000
G1 X121.495 Y123.477 Z34.8
G1 Z34.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3419
G1 X121.512 Y123.463 E.00073
G3 X127.601 Y119.042 I6.494 J2.54 E.26368
G3 X134.625 Y123.808 I.41 J6.954 E.30277
G3 X121.279 Y124.167 I-6.619 J2.195 E.86239
G1 X121.477 Y123.534 E.02199
G1 X121.866 Y123.604 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3419
G1 X121.877 Y123.606 E.00034
G3 X127.633 Y119.432 I6.129 J2.397 E.23077
G3 X133.997 Y123.279 I.356 J6.599 E.24268
G3 X121.657 Y124.27 I-5.991 J2.724 E.77543
G1 X121.848 Y123.661 E.01961
M204 S10000
; WIPE_START
G1 F12000
G1 X121.877 Y123.606 E-.02378
G1 X122.157 Y122.964 E-.26617
G1 X122.512 Y122.36 E-.26637
G1 X122.832 Y121.929 E-.20367
; WIPE_END
G1 E-.04 F1800
G1 X129.968 Y124.638 Z35 F30000
G1 X135.398 Y126.699 Z35
G1 Z34.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3419
G3 X128.929 Y133.381 I-7.405 J-.697 E.33327
G3 X128.71 Y118.6 I-.922 J-7.379 E.82894
G3 X135.403 Y126.64 I-.716 J7.403 E.3849
G1 X135.797 Y126.732 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3419
G1 X135.788 Y126.736 E.00029
G3 X128.98 Y133.77 I-7.795 J-.734 E.32492
G3 X128.741 Y118.209 I-.973 J-7.767 E.80824
G3 X135.823 Y126 I-.748 J7.794 E.3548
G1 X135.799 Y126.672 E.02066
M204 S10000
G1 X135.168 Y126.744 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.0986361
G1 F3419
G2 X135.204 Y126.085 I-6.95 J-.712 E.003
G1 X135.204 Y125.915 F30000
; LINE_WIDTH: 0.0986353
G1 F3419
G2 X135.168 Y125.256 I-6.986 J.054 E.003
G1 X135.134 Y125.024 F30000
; LINE_WIDTH: 0.100152
G1 F3419
G2 X135.052 Y124.52 I-6.112 J.734 E.00238
G1 X135.01 Y124.346 F30000
; LINE_WIDTH: 0.101159
G1 F3419
G2 X134.858 Y123.79 I-7.732 J1.815 E.00273
G1 X134.798 Y123.62 F30000
; LINE_WIDTH: 0.101636
G1 F3419
G2 X134.588 Y123.084 I-8.896 J3.176 E.00275
G1 X134.515 Y122.928 F30000
; LINE_WIDTH: 0.102052
G1 F3419
G2 X134.25 Y122.418 I-8.387 J4.036 E.00277
G1 X134.164 Y122.271 F30000
; LINE_WIDTH: 0.102077
G1 F3419
G2 X133.842 Y121.786 I-8.055 J4.991 E.00281
G1 X133.748 Y121.656 F30000
; LINE_WIDTH: 0.10172
G1 F3419
G2 X133.366 Y121.194 I-7.893 J6.145 E.00287
G1 X133.272 Y121.088 F30000
; LINE_WIDTH: 0.100907
G1 F3419
G2 X132.816 Y120.643 I-7.129 J6.85 E.00301
G1 X132.718 Y120.553 F30000
; LINE_WIDTH: 0.100368
G1 F3419
G2 X132.189 Y120.137 I-14.033 J17.318 E.00315
G1 X132.127 Y120.092 F30000
; LINE_WIDTH: 0.0997355
G1 F3419
G2 X131.521 Y119.712 I-14.568 J22.562 E.00331
G1 X131.504 Y119.701 F30000
; LINE_WIDTH: 0.098245
G1 F3419
G2 X130.813 Y119.365 I-17.436 J34.987 E.00346
G1 X130.612 Y119.29 F30000
; LINE_WIDTH: 0.0998489
G1 F3419
G2 X130.13 Y119.117 I-2.071 J5.016 E.00238
G1 X129.884 Y119.05 F30000
; LINE_WIDTH: 0.100965
G1 F3419
G2 X129.427 Y118.939 I-1.404 J4.782 E.00223
G1 X129.159 Y118.893 F30000
; LINE_WIDTH: 0.101373
G1 F3419
G2 X128.659 Y118.826 I-1.298 J7.831 E.0024
G1 X128.455 Y118.812 F30000
; LINE_WIDTH: 0.10153
G1 F3419
G2 X127.908 Y118.797 I-.453 J6.782 E.00261
G1 X127.719 Y118.802 F30000
; LINE_WIDTH: 0.101948
G1 F3419
G2 X127.153 Y118.847 I.457 J9.311 E.00273
G1 X126.986 Y118.867 F30000
; LINE_WIDTH: 0.101641
G1 F3419
G2 X126.395 Y118.978 I1.589 J10.094 E.00288
G1 X126.262 Y119.006 F30000
; LINE_WIDTH: 0.100971
G1 F3419
G2 X125.628 Y119.197 I3.149 J11.636 E.00313
G1 X125.534 Y119.228 F30000
; LINE_WIDTH: 0.0999192
G1 F3419
G2 X124.875 Y119.506 I4.674 J11.99 E.00332
G1 X124.829 Y119.528 F30000
; LINE_WIDTH: 0.100311
G1 F3419
G2 X124.202 Y119.875 I11.313 J21.186 E.00335
G1 X124.179 Y119.888 F30000
; LINE_WIDTH: 0.0998021
G1 F3419
G2 X123.55 Y120.33 I23.262 J33.768 E.00356
G1 X123.465 Y120.403 F30000
; LINE_WIDTH: 0.0994923
G1 F3419
G2 X123.005 Y120.807 I4.104 J5.142 E.00283
G1 X122.828 Y120.99 F30000
; LINE_WIDTH: 0.100722
G1 F3419
G2 X122.508 Y121.339 I3.529 J3.571 E.00223
G1 X122.341 Y121.547 F30000
; LINE_WIDTH: 0.101483
G1 F3419
G2 X122.066 Y121.917 I3.785 J3.096 E.0022
G1 X121.917 Y122.145 F30000
; LINE_WIDTH: 0.101661
G1 F3419
G2 X121.685 Y122.538 I4.043 J2.647 E.00218
G1 X121.557 Y122.781 F30000
; LINE_WIDTH: 0.101306
G1 F3419
G2 X121.341 Y123.255 I5.176 J2.638 E.00248
G1 X121.266 Y123.438 F30000
; LINE_WIDTH: 0.101402
G1 F3419
G2 X121.085 Y123.986 I9.448 J3.439 E.00275
G1 X121.04 Y124.134 F30000
; LINE_WIDTH: 0.100776
G1 F3419
G2 X120.9 Y124.776 I12.038 J2.955 E.0031
G1 X120.884 Y124.851 F30000
; LINE_WIDTH: 0.0994291
G1 F3419
G2 X120.803 Y125.605 I15.587 J2.055 E.0035
G1 X120.802 Y125.641 F30000
; LINE_WIDTH: 0.100503
G1 F3419
M73 P78 R5
G2 X120.802 Y126.359 I23.209 J.359 E.00336
G1 X120.803 Y126.395 F30000
; LINE_WIDTH: 0.0994295
G1 F3419
G2 X120.884 Y127.149 I15.657 J-1.299 E.0035
G1 X120.9 Y127.224 F30000
; LINE_WIDTH: 0.100776
G1 F3419
G2 X121.04 Y127.866 I12.179 J-2.313 E.0031
G1 X121.085 Y128.014 F30000
; LINE_WIDTH: 0.101402
G1 F3419
G2 X121.266 Y128.562 I9.627 J-2.89 E.00275
G1 X121.341 Y128.745 F30000
; LINE_WIDTH: 0.101307
G1 F3419
G2 X121.557 Y129.219 I5.391 J-2.164 E.00248
G1 X121.685 Y129.462 F30000
; LINE_WIDTH: 0.101661
G1 F3419
G2 X121.917 Y129.855 I4.275 J-2.255 E.00218
G1 X122.066 Y130.083 F30000
; LINE_WIDTH: 0.101483
G1 F3419
G2 X122.341 Y130.453 I4.06 J-2.725 E.0022
G1 X122.508 Y130.661 F30000
; LINE_WIDTH: 0.100722
G1 F3419
G2 X122.828 Y131.01 I3.85 J-3.223 E.00223
G1 X123.005 Y131.193 F30000
; LINE_WIDTH: 0.0994923
G1 F3419
G2 X123.465 Y131.597 I4.565 J-4.737 E.00283
G1 X123.55 Y131.67 F30000
; LINE_WIDTH: 0.0998019
G1 F3419
G2 X124.179 Y132.112 I23.876 J-33.305 E.00356
G1 X124.202 Y132.125 F30000
; LINE_WIDTH: 0.100312
G1 F3419
G2 X124.829 Y132.472 I11.943 J-20.843 E.00335
G1 X124.875 Y132.494 F30000
; LINE_WIDTH: 0.0999192
G1 F3419
G2 X125.534 Y132.772 I5.334 J-11.712 E.00332
G1 X125.628 Y132.803 F30000
; LINE_WIDTH: 0.100972
G1 F3419
G2 X126.262 Y132.994 I3.783 J-11.445 E.00313
G1 X126.395 Y133.022 F30000
; LINE_WIDTH: 0.10164
G1 F3419
G2 X126.986 Y133.133 I2.18 J-9.983 E.00288
G1 X127.153 Y133.153 F30000
; LINE_WIDTH: 0.101947
G1 F3419
G2 X127.719 Y133.198 I1.023 J-9.267 E.00273
G1 X127.908 Y133.203 F30000
; LINE_WIDTH: 0.10153
G1 F3419
G2 X128.455 Y133.188 I.093 J-6.796 E.00261
G1 X128.659 Y133.174 F30000
; LINE_WIDTH: 0.101497
G1 F3419
G2 X129.159 Y133.107 I-.533 J-5.902 E.00241
G1 X129.427 Y133.061 F30000
; LINE_WIDTH: 0.100965
G1 F3419
G2 X129.884 Y132.95 I-.948 J-4.894 E.00223
G1 X130.13 Y132.883 F30000
; LINE_WIDTH: 0.0998489
G1 F3419
G2 X130.612 Y132.71 I-1.589 J-5.189 E.00238
G1 X130.813 Y132.635 F30000
; LINE_WIDTH: 0.0982457
G1 F3419
G2 X131.504 Y132.299 I-16.74 J-35.313 E.00346
G1 X131.521 Y132.288 F30000
; LINE_WIDTH: 0.0988707
G1 F3419
G2 X132.127 Y131.908 I-4.638 J-8.07 E.00326
G1 X132.189 Y131.863 F30000
; LINE_WIDTH: 0.10011
G1 F3419
G2 X132.718 Y131.447 I-5.869 J-8.016 E.00314
G1 X132.816 Y131.357 F30000
; LINE_WIDTH: 0.100907
G1 F3419
G2 X133.272 Y130.912 I-6.673 J-7.294 E.00301
G1 X133.366 Y130.806 F30000
; LINE_WIDTH: 0.10172
G1 F3419
G2 X133.748 Y130.344 I-7.511 J-6.608 E.00287
G1 X133.842 Y130.214 F30000
; LINE_WIDTH: 0.102077
G1 F3419
G2 X134.164 Y129.729 I-7.732 J-5.476 E.00281
G1 X134.25 Y129.582 F30000
; LINE_WIDTH: 0.102051
G1 F3419
G2 X134.515 Y129.072 I-8.121 J-4.546 E.00277
G1 X134.588 Y128.916 F30000
; LINE_WIDTH: 0.101387
G1 F3419
G2 X134.798 Y128.38 I-7.199 J-3.129 E.00274
G1 X134.858 Y128.21 F30000
; LINE_WIDTH: 0.101159
G1 F3419
G2 X135.01 Y127.654 I-7.582 J-2.371 E.00273
G1 X135.052 Y127.48 F30000
; LINE_WIDTH: 0.100153
G1 F3419
G2 X135.134 Y126.976 I-6.03 J-1.237 E.00238
; CHANGE_LAYER
; Z_HEIGHT: 34.8
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F15000
G1 X135.052 Y127.48 E-.76
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 174/250
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L174
M991 S0 P173 ;notify layer change
G17
G3 Z35 I.345 J-1.167 P1  F30000
G1 X121.495 Y123.477 Z35
G1 Z34.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F2807
G1 X121.512 Y123.463 E.00073
G3 X127.592 Y119.042 I6.494 J2.54 E.26336
G3 X134.625 Y123.808 I.419 J6.953 E.30308
G3 X121.279 Y124.167 I-6.619 J2.195 E.86238
G1 X121.477 Y123.535 E.02199
G1 X121.866 Y123.604 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2807
G1 X121.877 Y123.606 E.00035
G3 X127.623 Y119.433 I6.129 J2.397 E.23047
G3 X133.997 Y123.279 I.366 J6.598 E.24297
G3 X121.658 Y124.27 I-5.991 J2.724 E.77543
G1 X121.848 Y123.661 E.01961
M204 S10000
; WIPE_START
G1 F12000
G1 X121.877 Y123.606 E-.02375
G1 X122.157 Y122.964 E-.26617
G1 X122.512 Y122.36 E-.26637
G1 X122.832 Y121.929 E-.20371
; WIPE_END
G1 E-.04 F1800
G1 X129.958 Y124.664 Z35.2 F30000
G1 X135.237 Y126.691 Z35.2
G1 Z34.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F2807
G3 X126.821 Y118.824 I-7.236 J-.694 E1.07389
G3 X128.774 Y118.772 I1.186 J7.802 E.06496
G1 X128.894 Y118.783 E.00399
G3 X135.242 Y126.631 I-.892 J7.214 E.37015
G1 X135.63 Y126.724 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2807
G1 X135.628 Y126.728 E.00014
G3 X126.763 Y118.436 I-7.626 J-.732 E1.04856
G3 X128.806 Y118.381 I1.244 J8.198 E.06296
G1 X128.945 Y118.394 E.00429
G3 X135.663 Y126 I-.943 J7.603 E.34083
G1 X135.633 Y126.664 E.02043
M204 S10000
; CHANGE_LAYER
; Z_HEIGHT: 35
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F12000
G1 X135.628 Y126.728 E-.02444
G1 X135.526 Y127.45 E-.27713
G1 X135.354 Y128.161 E-.27793
G1 X135.198 Y128.61 E-.18051
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 175/250
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L175
M991 S0 P174 ;notify layer change
G17
G3 Z35.2 I.428 J-1.139 P1  F30000
G1 X121.866 Y123.604 Z35.2
G1 Z35
G1 E.8 F1800
M204 S5000
G1 F2087
G1 X121.877 Y123.606 E.00035
G3 X127.614 Y119.434 I6.129 J2.397 E.23018
G3 X133.997 Y123.279 I.398 J6.56 E.24344
G3 X121.657 Y124.27 I-5.991 J2.724 E.77547
G1 X121.848 Y123.661 E.01962
M204 S10000
; WIPE_START
G1 F12000
G1 X121.877 Y123.606 E-.02369
G1 X122.157 Y122.964 E-.26617
G1 X122.512 Y122.36 E-.26637
G1 X122.832 Y121.929 E-.20377
; WIPE_END
G1 E-.04 F1800
G1 X129.969 Y124.634 Z35.4 F30000
G1 X135.464 Y126.716 Z35.4
G1 Z35
G1 E.8 F1800
M204 S5000
G1 F2087
G1 X135.461 Y126.72 E.00014
G3 X128.193 Y118.504 I-7.459 J-.724 E1.06872
G1 X128.87 Y118.554 E.02087
G1 X128.91 Y118.557 E.00122
G3 X135.496 Y126 I-.908 J7.439 E.33386
G1 X135.466 Y126.656 E.02019
M204 S10000
G1 X135.01 Y126.633 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.563433
G1 F2087
G1 X135.003 Y126.676 E.00181
G3 X120.968 Y126.362 I-7.006 J-.67 E.8942
G1 X120.968 Y125.638 E.03074
G3 X122.128 Y122.121 I7.197 J.425 E.15884
G3 X135.035 Y126 I5.869 J3.884 E.76303
G1 X135.012 Y126.573 E.02434
; CHANGE_LAYER
; Z_HEIGHT: 35.2
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F12103.458
G1 X135.003 Y126.676 E-.03895
G1 X134.909 Y127.345 E-.25704
G1 X134.747 Y128.002 E-.25708
G1 X134.566 Y128.516 E-.20693
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 176/250
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L176
M991 S0 P175 ;notify layer change
G17
G3 Z35.4 I.439 J-1.135 P1  F30000
G1 X121.866 Y123.604 Z35.4
G1 Z35.2
G1 E.8 F1800
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2074
G1 X121.878 Y123.606 E.00037
G3 X127.604 Y119.435 I6.129 J2.397 E.22987
G3 X133.997 Y123.279 I.408 J6.559 E.24373
G3 X121.658 Y124.27 I-5.99 J2.724 E.77541
G1 X121.848 Y123.661 E.01962
M204 S10000
; WIPE_START
G1 F12000
G1 X121.878 Y123.606 E-.02364
G1 X122.157 Y122.964 E-.26617
G1 X122.512 Y122.36 E-.26637
G1 X122.832 Y121.929 E-.20382
; WIPE_END
G1 E-.04 F1800
G1 X129.964 Y124.648 Z35.6 F30000
G1 X135.38 Y126.713 Z35.6
G1 Z35.2
G1 E.8 F1800
M204 S5000
G1 F2074
G1 X135.38 Y126.716 E.00009
G3 X128.184 Y118.588 I-7.377 J-.718 E1.05671
G1 X128.894 Y118.639 E.02187
G3 X135.415 Y126 I-.891 J7.358 E.33037
G1 X135.383 Y126.653 E.02008
M204 S10000
G1 X134.966 Y126.63 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.480397
G1 F2074
G1 X134.955 Y126.732 E.00365
G3 X121.01 Y125.639 I-6.958 J-.726 E.77069
G1 X121.012 Y125.616 E.00083
G3 X122.164 Y122.142 I7.277 J.486 E.13188
G3 X134.993 Y126 I5.833 J3.864 E.6374
G1 X134.968 Y126.57 E.02034
; CHANGE_LAYER
; Z_HEIGHT: 35.4
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F14400.778
G1 X134.955 Y126.732 E-.06171
G1 X134.842 Y127.468 E-.28297
G1 X134.646 Y128.187 E-.28304
G1 X134.525 Y128.513 E-.13228
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 177/250
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L177
M991 S0 P176 ;notify layer change
G17
G3 Z35.6 I.44 J-1.135 P1  F30000
G1 X121.866 Y123.604 Z35.6
G1 Z35.4
G1 E.8 F1800
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2073
G1 X121.877 Y123.606 E.00034
G3 X127.595 Y119.435 I6.129 J2.397 E.22959
G3 X134.252 Y123.932 I.416 J6.56 E.26556
G3 X121.657 Y124.27 I-6.246 J2.072 E.75392
G1 X121.848 Y123.661 E.01963
M204 S10000
; WIPE_START
G1 F12000
G1 X121.877 Y123.606 E-.02354
G1 X122.157 Y122.964 E-.26618
G1 X122.512 Y122.36 E-.26637
G1 X122.832 Y121.929 E-.20391
; WIPE_END
G1 E-.04 F1800
G1 X129.964 Y124.648 Z35.8 F30000
G1 X135.38 Y126.713 Z35.8
G1 Z35.4
G1 E.8 F1800
M204 S5000
G1 F2073
G1 X135.372 Y126.715 E.00027
G3 X129.6 Y133.24 I-7.382 J-.714 E.2861
G3 X128.894 Y118.639 I-1.593 J-7.24 E.79227
G3 X135.406 Y126 I-.904 J7.361 E.3301
G1 X135.382 Y126.653 E.02008
M204 S10000
G1 X134.966 Y126.63 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.480389
G1 F2073
G1 X134.955 Y126.732 E.00364
G3 X121.01 Y125.639 I-6.958 J-.726 E.77068
G1 X121.012 Y125.616 E.00083
G3 X122.164 Y122.142 I7.277 J.486 E.13187
G3 X134.993 Y126 I5.833 J3.864 E.63739
G1 X134.968 Y126.57 E.02036
; CHANGE_LAYER
; Z_HEIGHT: 35.6
; LAYER_HEIGHT: 0.199997
; WIPE_START
G1 F14401.017
G1 X134.955 Y126.732 E-.06154
G1 X134.842 Y127.468 E-.28297
G1 X134.646 Y128.187 E-.28304
G1 X134.525 Y128.513 E-.13245
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 178/250
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L178
M991 S0 P177 ;notify layer change
G17
G3 Z35.8 I.44 J-1.135 P1  F30000
G1 X121.866 Y123.603 Z35.8
G1 Z35.6
G1 E.8 F1800
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2074
G1 X121.877 Y123.606 E.00035
G3 X127.585 Y119.436 I6.129 J2.397 E.2293
G3 X134.252 Y123.932 I.426 J6.559 E.26585
G3 X121.658 Y124.27 I-6.246 J2.072 E.75391
G1 X121.848 Y123.661 E.01963
M204 S10000
; WIPE_START
G1 F12000
G1 X121.877 Y123.606 E-.02347
G1 X122.157 Y122.964 E-.26617
G1 X122.512 Y122.36 E-.26637
G1 X122.833 Y121.929 E-.20399
; WIPE_END
G1 E-.04 F1800
G1 X129.964 Y124.648 Z36 F30000
G1 X135.38 Y126.714 Z36
G1 Z35.6
G1 E.8 F1800
M204 S5000
G1 F2074
G1 X135.372 Y126.715 E.00027
G3 X129.6 Y133.24 I-7.382 J-.714 E.2861
G3 X128.894 Y118.639 I-1.6 J-7.24 E.79284
G3 X135.406 Y126 I-.904 J7.361 E.3301
G1 X135.382 Y126.654 E.0201
M204 S10000
G1 X134.966 Y126.631 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.480382
G1 F2074
G1 X134.955 Y126.732 E.00362
G3 X121.01 Y125.639 I-6.958 J-.726 E.77067
G1 X121.012 Y125.616 E.00083
G3 X122.164 Y122.142 I7.277 J.486 E.13187
G3 X134.993 Y126 I5.833 J3.864 E.63738
G1 X134.968 Y126.571 E.02037
; CHANGE_LAYER
; Z_HEIGHT: 35.8
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F14401.263
G1 X134.955 Y126.732 E-.06136
G1 X134.842 Y127.468 E-.28297
G1 X134.646 Y128.187 E-.28304
G1 X134.525 Y128.514 E-.13262
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 179/250
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L179
M991 S0 P178 ;notify layer change
G17
G3 Z36 I.44 J-1.135 P1  F30000
G1 X121.866 Y123.603 Z36
G1 Z35.8
G1 E.8 F1800
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2073
G1 X121.878 Y123.606 E.00035
G3 X127.576 Y119.437 I6.128 J2.397 E.229
G3 X134.252 Y123.932 I.417 J6.586 E.26595
G3 X121.658 Y124.27 I-6.246 J2.072 E.7539
G1 X121.849 Y123.66 E.01964
M204 S10000
; WIPE_START
G1 F12000
G1 X121.878 Y123.606 E-.02339
G1 X122.157 Y122.964 E-.26617
G1 X122.512 Y122.36 E-.26637
G1 X122.833 Y121.929 E-.20407
; WIPE_END
G1 E-.04 F1800
G1 X129.964 Y124.648 Z36.2 F30000
G1 X135.38 Y126.714 Z36.2
G1 Z35.8
G1 E.8 F1800
M204 S5000
G1 F2073
G1 X135.369 Y126.715 E.00034
G3 X126.752 Y118.691 I-7.375 J-.718 E1.01252
G3 X128.203 Y118.589 I1.447 J10.218 E.04475
G3 X135.404 Y126 I-.209 J7.407 E.35134
G1 X135.382 Y126.654 E.02011
M204 S10000
G1 X134.966 Y126.631 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.48039
G1 F2073
M73 P79 R5
G1 X134.955 Y126.732 E.0036
G3 X121.01 Y125.639 I-6.958 J-.726 E.77068
G1 X121.012 Y125.616 E.00083
G3 X122.164 Y122.142 I7.277 J.486 E.13187
G3 X134.993 Y126 I5.833 J3.864 E.63739
G1 X134.968 Y126.571 E.02039
; CHANGE_LAYER
; Z_HEIGHT: 36
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F14401.014
G1 X134.955 Y126.732 E-.06119
G1 X134.842 Y127.468 E-.28297
G1 X134.646 Y128.187 E-.28304
G1 X134.525 Y128.514 E-.1328
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 180/250
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L180
M991 S0 P179 ;notify layer change
G17
G3 Z36.2 I.44 J-1.135 P1  F30000
G1 X121.867 Y123.603 Z36.2
G1 Z36
G1 E.8 F1800
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2073
G1 X121.878 Y123.606 E.00036
G3 X127.567 Y119.438 I6.128 J2.397 E.2287
G3 X134.252 Y123.932 I.427 J6.585 E.26624
G3 X121.658 Y124.27 I-6.246 J2.072 E.7539
G1 X121.849 Y123.66 E.01965
M204 S10000
; WIPE_START
G1 F12000
G1 X121.878 Y123.606 E-.0233
G1 X122.157 Y122.964 E-.26617
G1 X122.512 Y122.36 E-.26637
G1 X122.833 Y121.928 E-.20416
; WIPE_END
G1 E-.04 F1800
G1 X129.964 Y124.649 Z36.4 F30000
G1 X135.38 Y126.714 Z36.4
G1 Z36
G1 E.8 F1800
M204 S5000
G1 F2073
G1 X135.371 Y126.715 E.00027
G3 X126.052 Y118.846 I-7.377 J-.716 E.99077
G3 X128.213 Y118.59 I1.936 J7.102 E.06711
G3 X135.406 Y126 I-.219 J7.408 E.35106
G1 X135.382 Y126.654 E.02012
M204 S10000
G1 X134.966 Y126.632 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.480382
G1 F2073
G1 X134.955 Y126.732 E.00359
G3 X121.01 Y125.639 I-6.958 J-.726 E.77067
G1 X121.012 Y125.616 E.00083
G3 X122.164 Y122.142 I7.277 J.486 E.13187
G3 X134.993 Y126 I5.833 J3.864 E.63738
G1 X134.968 Y126.572 E.0204
; CHANGE_LAYER
; Z_HEIGHT: 36.2
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F14401.26
G1 X134.955 Y126.732 E-.06101
G1 X134.842 Y127.468 E-.28297
G1 X134.646 Y128.187 E-.28304
G1 X134.525 Y128.515 E-.13297
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 181/250
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L181
M991 S0 P180 ;notify layer change
G17
G3 Z36.4 I.44 J-1.135 P1  F30000
G1 X121.867 Y123.603 Z36.4
G1 Z36.2
G1 E.8 F1800
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2073
G1 X121.878 Y123.606 E.00036
G3 X127.557 Y119.438 I6.128 J2.397 E.22841
G3 X134.252 Y123.932 I.436 J6.584 E.26653
G3 X121.658 Y124.27 I-6.246 J2.072 E.7539
G1 X121.849 Y123.66 E.01966
M204 S10000
; WIPE_START
G1 F12000
G1 X121.878 Y123.606 E-.02321
G1 X122.157 Y122.964 E-.26617
G1 X122.512 Y122.36 E-.26637
G1 X122.833 Y121.928 E-.20426
; WIPE_END
G1 E-.04 F1800
G1 X129.964 Y124.649 Z36.6 F30000
G1 X135.38 Y126.715 Z36.6
G1 Z36.2
G1 E.8 F1800
M204 S5000
G1 F2073
G1 X135.369 Y126.715 E.00035
G3 X126.052 Y118.846 I-7.376 J-.717 E.99062
G3 X128.223 Y118.591 I1.933 J7.089 E.06741
G3 X135.403 Y126 I-.23 J7.407 E.35068
G1 X135.382 Y126.655 E.02013
M204 S10000
G1 X134.966 Y126.632 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.4804
G1 F2073
G1 X134.955 Y126.732 E.00357
G3 X121.01 Y125.639 I-6.958 J-.726 E.7707
G1 X121.012 Y125.616 E.00083
G3 X122.164 Y122.142 I7.277 J.486 E.13188
G3 X134.993 Y126 I5.833 J3.864 E.63741
G1 X134.968 Y126.572 E.02042
; CHANGE_LAYER
; Z_HEIGHT: 36.4
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F14400.657
G1 X134.955 Y126.732 E-.06084
G1 X134.842 Y127.468 E-.28297
G1 X134.646 Y128.187 E-.28304
G1 X134.524 Y128.515 E-.13315
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 182/250
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L182
M991 S0 P181 ;notify layer change
G17
G3 Z36.6 I.44 J-1.135 P1  F30000
G1 X121.867 Y123.602 Z36.6
G1 Z36.4
G1 E.8 F1800
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2079
G1 X121.877 Y123.606 E.00034
G3 X127.548 Y119.439 I6.128 J2.398 E.22813
G3 X134.436 Y124.608 I.445 J6.581 E.28834
G3 X121.657 Y124.27 I-6.431 J1.396 E.7324
G1 X121.849 Y123.66 E.01967
M204 S10000
; WIPE_START
G1 F12000
G1 X121.877 Y123.606 E-.02307
G1 X122.157 Y122.964 E-.26618
G1 X122.512 Y122.36 E-.26637
G1 X122.833 Y121.928 E-.20438
; WIPE_END
G1 E-.04 F1800
G1 X129.964 Y124.65 Z36.8 F30000
G1 X135.371 Y126.715 Z36.8
G1 Z36.4
G1 E.8 F1800
M204 S5000
G1 F2079
G3 X125.371 Y119.067 I-7.377 J-.716 E.96879
G3 X128.233 Y118.591 I2.691 J7.342 E.08967
G3 X135.376 Y126.655 I-.239 J7.408 E.37056
M204 S10000
G1 X134.966 Y126.633 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.4804
G1 F2079
G1 X134.955 Y126.732 E.00356
G3 X121.01 Y125.639 I-6.958 J-.726 E.7707
G1 X121.012 Y125.616 E.00083
G3 X122.164 Y122.142 I7.277 J.486 E.13188
G3 X134.993 Y126 I5.833 J3.864 E.63741
G1 X134.968 Y126.573 E.02043
; CHANGE_LAYER
; Z_HEIGHT: 36.6
; LAYER_HEIGHT: 0.199997
; WIPE_START
G1 F14400.655
G1 X134.955 Y126.732 E-.0607
G1 X134.842 Y127.468 E-.28297
G1 X134.646 Y128.187 E-.28304
G1 X134.524 Y128.516 E-.13329
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 183/250
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L183
M991 S0 P182 ;notify layer change
G17
G3 Z36.8 I.44 J-1.134 P1  F30000
G1 X121.877 Y123.606 Z36.8
G1 Z36.6
G1 E.8 F1800
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2081
G3 X127.538 Y119.44 I6.128 J2.398 E.22783
G3 X134.436 Y124.608 I.473 J6.557 E.28883
G3 X121.856 Y123.662 I-6.431 J1.396 E.75207
M204 S10000
; WIPE_START
G1 F12000
G1 X122.157 Y122.964 E-.28895
G1 X122.512 Y122.36 E-.26637
G1 X122.834 Y121.927 E-.20468
; WIPE_END
G1 E-.04 F1800
M73 P80 R5
G1 X129.964 Y124.65 Z37 F30000
G1 X135.371 Y126.715 Z37
G1 Z36.6
G1 E.8 F1800
M204 S5000
G1 F2081
G3 X124.714 Y119.353 I-7.377 J-.715 E.94676
G3 X128.243 Y118.592 I3.275 J6.62 E.11206
G3 X135.377 Y126.655 I-.249 J7.407 E.37026
M204 S10000
G1 X134.966 Y126.633 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.4804
G1 F2081
G1 X134.955 Y126.732 E.00356
G3 X121.01 Y125.639 I-6.958 J-.726 E.7707
G1 X121.012 Y125.616 E.00083
G3 X122.164 Y122.142 I7.277 J.486 E.13188
G3 X134.993 Y126 I5.833 J3.864 E.63741
G1 X134.968 Y126.573 E.02044
; CHANGE_LAYER
; Z_HEIGHT: 36.8
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F14400.66
G1 X134.955 Y126.732 E-.06069
G1 X134.842 Y127.468 E-.28297
G1 X134.646 Y128.187 E-.28304
G1 X134.524 Y128.516 E-.13329
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 184/250
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L184
M991 S0 P183 ;notify layer change
G17
G3 Z37 I.44 J-1.134 P1  F30000
G1 X121.877 Y123.606 Z37
G1 Z36.8
G1 E.8 F1800
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2081
G3 X127.529 Y119.441 I6.128 J2.398 E.22754
G3 X134.436 Y124.608 I.482 J6.556 E.28912
G3 X121.856 Y123.662 I-6.431 J1.396 E.75206
M204 S10000
; WIPE_START
G1 F12000
G1 X122.157 Y122.964 E-.28894
G1 X122.512 Y122.36 E-.26637
G1 X122.834 Y121.927 E-.20469
; WIPE_END
G1 E-.04 F1800
G1 X129.964 Y124.65 Z37.2 F30000
G1 X135.38 Y126.719 Z37.2
G1 Z36.8
G1 E.8 F1800
M204 S5000
G1 F2081
G1 X135.266 Y127.423 E.02191
G3 X124.714 Y119.353 I-7.273 J-1.423 E.92474
G3 X128.252 Y118.593 I3.273 J6.617 E.11236
G3 X135.374 Y126.666 I-.259 J7.407 E.37024
M204 S10000
G1 X134.965 Y126.643 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.4804
G1 F2081
G1 X134.955 Y126.732 E.00318
G3 X121.01 Y125.639 I-6.958 J-.726 E.7707
G1 X121.012 Y125.616 E.00083
G3 X122.164 Y122.142 I7.277 J.486 E.13188
G3 X134.993 Y126 I5.833 J3.864 E.63741
G1 X134.968 Y126.583 E.02082
; CHANGE_LAYER
; Z_HEIGHT: 37
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F14400.661
G1 X134.955 Y126.732 E-.05663
G1 X134.842 Y127.468 E-.28297
G1 X134.646 Y128.187 E-.28304
G1 X134.521 Y128.526 E-.13736
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 185/250
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L185
M991 S0 P184 ;notify layer change
G17
G3 Z37.2 I.441 J-1.134 P1  F30000
G1 X121.877 Y123.606 Z37.2
G1 Z37
G1 E.8 F1800
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2081
G3 X127.519 Y119.441 I6.128 J2.398 E.22724
G3 X134.436 Y124.608 I.474 J6.579 E.28921
G3 X121.856 Y123.662 I-6.431 J1.396 E.75206
M204 S10000
; WIPE_START
G1 F12000
G1 X122.157 Y122.964 E-.28894
G1 X122.512 Y122.36 E-.26637
G1 X122.834 Y121.927 E-.20469
; WIPE_END
G1 E-.04 F1800
G1 X129.963 Y124.653 Z37.4 F30000
G1 X135.379 Y126.723 Z37.4
G1 Z37
G1 E.8 F1800
M204 S5000
G1 F2081
G1 X135.267 Y127.423 E.02176
G3 X124.088 Y119.701 I-7.274 J-1.423 E.90276
G3 X128.262 Y118.593 I3.947 J6.454 E.13458
G3 X135.375 Y126.667 I-.268 J7.407 E.36999
M204 S10000
G1 X134.965 Y126.645 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.4804
G1 F2081
G1 X134.955 Y126.732 E.00313
G3 X121.01 Y125.639 I-6.958 J-.726 E.7707
G1 X121.012 Y125.616 E.00083
G3 X122.164 Y122.142 I7.277 J.486 E.13188
G3 X134.993 Y126 I5.833 J3.864 E.63741
G1 X134.967 Y126.585 E.02087
; CHANGE_LAYER
; Z_HEIGHT: 37.2
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F14400.661
G1 X134.955 Y126.732 E-.05611
G1 X134.842 Y127.468 E-.28297
G1 X134.646 Y128.187 E-.28304
G1 X134.52 Y128.527 E-.13788
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 186/250
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L186
M991 S0 P185 ;notify layer change
G17
G3 Z37.4 I.441 J-1.134 P1  F30000
G1 X121.867 Y123.602 Z37.4
G1 Z37.2
G1 E.8 F1800
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2082
G3 X127.126 Y119.473 I6.133 J2.398 E.21549
G1 X127.51 Y119.442 E.01184
G1 X127.825 Y119.417 E.0097
G3 X121.845 Y123.658 I.175 J6.583 E1.0325
M204 S10000
; WIPE_START
G1 F12000
G1 X122.157 Y122.964 E-.28911
G1 X122.512 Y122.36 E-.26637
G1 X122.833 Y121.928 E-.20452
; WIPE_END
G1 E-.04 F1800
G1 X129.962 Y124.655 Z37.6 F30000
G1 X135.378 Y126.727 Z37.6
G1 Z37.2
G1 E.8 F1800
M204 S5000
G1 F2082
G1 X135.266 Y127.423 E.02164
G3 X124.088 Y119.701 I-7.273 J-1.423 E.90274
G3 X128.272 Y118.594 I3.945 J6.449 E.13488
G3 X135.374 Y126.67 I-.279 J7.406 E.36976
M204 S10000
G1 X134.965 Y126.648 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.4804
G1 F2082
G1 X134.955 Y126.732 E.00301
G3 X121.01 Y125.639 I-6.958 J-.726 E.7707
G1 X121.012 Y125.616 E.00083
G3 X122.164 Y122.142 I7.277 J.486 E.13188
G3 X134.993 Y126 I5.833 J3.864 E.63741
G1 X134.967 Y126.588 E.02099
; CHANGE_LAYER
; Z_HEIGHT: 37.4
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F14400.657
G1 X134.955 Y126.732 E-.05483
G1 X134.842 Y127.468 E-.28297
G1 X134.646 Y128.187 E-.28304
G1 X134.519 Y128.53 E-.13916
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 187/250
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L187
M991 S0 P186 ;notify layer change
G17
G3 Z37.6 I.442 J-1.134 P1  F30000
G1 X121.867 Y123.602 Z37.6
G1 Z37.4
G1 E.8 F1800
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2082
G3 X127.126 Y119.473 I6.133 J2.398 E.21549
G1 X127.5 Y119.443 E.01155
G1 X127.825 Y119.417 E.00999
G3 X121.845 Y123.658 I.175 J6.583 E1.03251
M204 S10000
; WIPE_START
G1 F12000
G1 X122.157 Y122.964 E-.28911
G1 X122.512 Y122.36 E-.26637
M73 P81 R5
G1 X122.833 Y121.928 E-.20452
; WIPE_END
G1 E-.04 F1800
G1 X129.961 Y124.657 Z37.8 F30000
G1 X135.378 Y126.731 Z37.8
G1 Z37.4
G1 E.8 F1800
M204 S5000
G1 F2082
G1 X135.265 Y127.422 E.02153
M73 P81 R4
G3 X124.088 Y119.701 I-7.273 J-1.423 E.90266
G3 X128.282 Y118.595 I3.943 J6.444 E.13518
G3 X135.372 Y126.674 I-.289 J7.405 E.36952
M204 S10000
G1 X134.964 Y126.651 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.4804
G1 F2082
G1 X134.955 Y126.732 E.00289
G3 X121.01 Y125.639 I-6.958 J-.726 E.7707
G1 X121.012 Y125.616 E.00083
G3 X122.164 Y122.142 I7.277 J.486 E.13188
G3 X134.993 Y126 I5.833 J3.864 E.63741
G1 X134.967 Y126.591 E.02111
; CHANGE_LAYER
; Z_HEIGHT: 37.6
; LAYER_HEIGHT: 0.199997
; WIPE_START
G1 F14400.661
G1 X134.955 Y126.732 E-.05355
G1 X134.842 Y127.468 E-.28297
G1 X134.646 Y128.187 E-.28304
G1 X134.518 Y128.533 E-.14044
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 188/250
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L188
M991 S0 P187 ;notify layer change
G17
G3 Z37.8 I.442 J-1.134 P1  F30000
G1 X121.869 Y123.603 Z37.8
G1 Z37.6
G1 E.8 F1800
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2081
G3 X127.126 Y119.473 I6.13 J2.392 E.21546
G1 X127.491 Y119.444 E.01125
G1 X127.825 Y119.417 E.01028
G3 X121.848 Y123.659 I.175 J6.578 E1.03164
M204 S10000
; WIPE_START
G1 F12000
G1 X122.157 Y122.964 E-.28907
G1 X122.512 Y122.36 E-.26637
G1 X122.833 Y121.928 E-.20457
; WIPE_END
G1 E-.04 F1800
G1 X129.961 Y124.658 Z38 F30000
G1 X135.378 Y126.733 Z38
G1 Z37.6
G1 E.8 F1800
M204 S5000
G1 F2081
G1 X135.267 Y127.423 E.02145
G3 X123.498 Y120.108 I-7.273 J-1.422 E.88075
G3 X128.292 Y118.596 I4.489 J5.873 E.15759
G3 X135.373 Y126.675 I-.298 J7.405 E.36929
M204 S10000
G1 X134.964 Y126.653 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.4804
G1 F2081
G1 X134.955 Y126.732 E.00284
G3 X121.01 Y125.639 I-6.958 J-.726 E.7707
G1 X121.012 Y125.616 E.00083
G3 X122.164 Y122.142 I7.073 J.418 E.13196
G3 X134.993 Y126 I5.833 J3.864 E.63741
G1 X134.967 Y126.593 E.02116
; CHANGE_LAYER
; Z_HEIGHT: 37.8
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F14400.657
G1 X134.955 Y126.732 E-.05299
G1 X134.842 Y127.468 E-.28297
G1 X134.646 Y128.187 E-.28304
G1 X134.517 Y128.535 E-.14099
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 189/250
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L189
M991 S0 P188 ;notify layer change
G17
G3 Z38 I.442 J-1.134 P1  F30000
G1 X121.867 Y123.601 Z38
G1 Z37.8
G1 E.8 F1800
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2081
G1 X122.16 Y122.965 E.02149
G3 X127.126 Y119.473 I5.842 J3.03 E.19389
G1 X127.482 Y119.444 E.01096
G3 X132.839 Y121.533 I.512 J6.6 E.18276
G1 X133.286 Y122.073 E.02154
G3 X121.851 Y123.655 I-5.284 J3.923 E.83793
M204 S10000
; WIPE_START
G1 F12000
G1 X122.16 Y122.965 E-.28719
G1 X122.512 Y122.36 E-.26629
G1 X122.836 Y121.923 E-.20651
; WIPE_END
G1 E-.04 F1800
G1 X129.962 Y124.658 Z38.2 F30000
G1 X135.377 Y126.735 Z38.2
G1 Z37.8
G1 E.8 F1800
M204 S5000
G1 F2081
G1 X135.265 Y127.422 E.02139
G3 X123.498 Y120.108 I-7.273 J-1.422 E.88068
G3 X128.301 Y118.596 I4.488 J5.871 E.15789
G3 X135.372 Y126.677 I-.309 J7.404 E.36902
M204 S10000
G1 X134.964 Y126.655 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.4804
G1 F2081
G1 X134.955 Y126.732 E.00276
G3 X121.01 Y125.639 I-6.958 J-.726 E.7707
G1 X121.012 Y125.616 E.00083
G3 X122.164 Y122.142 I7.277 J.486 E.13188
G3 X134.993 Y126 I5.833 J3.864 E.63741
G1 X134.967 Y126.595 E.02124
; CHANGE_LAYER
; Z_HEIGHT: 38
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F14400.661
G1 X134.955 Y126.732 E-.05216
G1 X134.842 Y127.468 E-.28297
G1 X134.646 Y128.187 E-.28304
G1 X134.516 Y128.537 E-.14182
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 190/250
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L190
M991 S0 P189 ;notify layer change
G17
G3 Z38.2 I.442 J-1.134 P1  F30000
G1 X121.868 Y123.6 Z38.2
G1 Z38
G1 E.8 F1800
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2082
G1 X122.157 Y122.964 E.02149
G3 X127.126 Y119.473 I5.843 J3.036 E.19394
G1 X127.472 Y119.445 E.01067
G1 X127.825 Y119.417 E.01087
G3 X121.846 Y123.656 I.175 J6.583 E1.03255
M204 S10000
; WIPE_START
G1 F12000
G1 X122.157 Y122.964 E-.28846
G1 X122.512 Y122.36 E-.26637
G1 X122.834 Y121.926 E-.20517
; WIPE_END
G1 E-.04 F1800
G1 X129.961 Y124.659 Z38.4 F30000
G1 X135.377 Y126.737 Z38.4
G1 Z38
G1 E.8 F1800
M204 S5000
G1 F2082
G1 X135.267 Y127.423 E.02135
G3 X122.95 Y120.57 I-7.274 J-1.421 E.85876
G3 X128.311 Y118.597 I5.07 J5.504 E.18009
G3 X135.373 Y126.678 I-.318 J7.404 E.36876
M204 S10000
G1 X134.964 Y126.656 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.4804
G1 F2082
G1 X134.955 Y126.732 E.00274
G3 X121.01 Y125.639 I-6.958 J-.726 E.7707
G1 X121.012 Y125.616 E.00083
G3 X122.164 Y122.142 I7.277 J.486 E.13188
G3 X134.993 Y126 I5.833 J3.864 E.63741
G1 X134.967 Y126.596 E.02126
; CHANGE_LAYER
; Z_HEIGHT: 38.2
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F14400.66
G1 X134.955 Y126.732 E-.05195
M73 P82 R4
G1 X134.842 Y127.468 E-.28297
G1 X134.646 Y128.187 E-.28304
G1 X134.516 Y128.537 E-.14204
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 191/250
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L191
M991 S0 P190 ;notify layer change
G17
G3 Z38.4 I.442 J-1.134 P1  F30000
G1 X121.868 Y123.6 Z38.4
G1 Z38.2
G1 E.8 F1800
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2081
G1 X122.158 Y122.965 E.02148
G3 X127.126 Y119.473 I5.841 J3.031 E.19392
G1 X127.463 Y119.446 E.01038
G1 X127.825 Y119.417 E.01116
G3 X121.849 Y123.656 I.175 J6.578 E1.03174
M204 S10000
; WIPE_START
G1 F12000
G1 X122.158 Y122.965 E-.28782
G1 X122.512 Y122.36 E-.26632
G1 X122.835 Y121.925 E-.20585
; WIPE_END
G1 E-.04 F1800
G1 X129.961 Y124.659 Z38.6 F30000
G1 X135.377 Y126.737 Z38.6
G1 Z38.2
G1 E.8 F1800
M204 S5000
G1 F2081
G1 X135.266 Y127.422 E.02133
G3 X122.95 Y120.57 I-7.273 J-1.421 E.8587
G3 X128.321 Y118.598 I5.068 J5.502 E.18039
G3 X135.372 Y126.679 I-.328 J7.403 E.36845
M204 S10000
G1 X134.964 Y126.657 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.480401
G1 F2081
G1 X134.955 Y126.732 E.0027
G3 X121.01 Y125.639 I-6.958 J-.726 E.7707
G1 X121.012 Y125.616 E.00083
G3 X122.164 Y122.142 I7.277 J.486 E.13188
G3 X134.993 Y126 I5.833 J3.864 E.63741
G1 X134.967 Y126.597 E.02129
; CHANGE_LAYER
; Z_HEIGHT: 38.4
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F14400.651
G1 X134.955 Y126.732 E-.05158
G1 X134.842 Y127.468 E-.28297
G1 X134.646 Y128.187 E-.28304
G1 X134.516 Y128.538 E-.1424
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 192/250
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L192
M991 S0 P191 ;notify layer change
G17
G3 Z38.6 I.443 J-1.134 P1  F30000
G1 X121.868 Y123.6 Z38.6
G1 Z38.4
G1 E.8 F1800
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2082
G1 X122.157 Y122.964 E.02148
G3 X127.126 Y119.473 I5.843 J3.036 E.19394
G1 X127.453 Y119.447 E.01009
G1 X127.825 Y119.417 E.01145
G3 X121.846 Y123.656 I.175 J6.583 E1.03255
M204 S10000
; WIPE_START
G1 F12000
G1 X122.157 Y122.964 E-.28833
G1 X122.512 Y122.36 E-.26637
G1 X122.835 Y121.926 E-.2053
; WIPE_END
G1 E-.04 F1800
G1 X129.961 Y124.66 Z38.8 F30000
G1 X135.377 Y126.737 Z38.8
G1 Z38.4
G1 E.8 F1800
M204 S5000
G1 F2082
G1 X135.265 Y127.422 E.02133
G3 X122.95 Y120.57 I-7.273 J-1.421 E.85868
G3 X128.331 Y118.598 I5.067 J5.5 E.1807
G3 X135.372 Y126.679 I-.338 J7.403 E.36814
M204 S10000
G1 X134.964 Y126.657 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.4804
G1 F2082
G1 X134.955 Y126.732 E.00269
G3 X121.01 Y125.639 I-6.958 J-.726 E.7707
G1 X121.012 Y125.616 E.00083
G3 X122.164 Y122.142 I7.277 J.486 E.13188
G3 X134.993 Y126 I5.833 J3.864 E.63741
G1 X134.967 Y126.597 E.0213
; CHANGE_LAYER
; Z_HEIGHT: 38.6
; LAYER_HEIGHT: 0.199997
; WIPE_START
G1 F14400.657
G1 X134.955 Y126.732 E-.05147
G1 X134.842 Y127.468 E-.28297
G1 X134.646 Y128.187 E-.28304
G1 X134.516 Y128.538 E-.14252
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 193/250
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L193
M991 S0 P192 ;notify layer change
G17
G3 Z38.8 I.443 J-1.134 P1  F30000
G1 X121.868 Y123.6 Z38.8
G1 Z38.6
G1 E.8 F1800
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2081
G1 X122.158 Y122.965 E.02147
G3 X127.126 Y119.473 I5.841 J3.031 E.19392
G1 X127.444 Y119.448 E.0098
G1 X127.825 Y119.417 E.01174
G3 X121.849 Y123.656 I.175 J6.578 E1.03174
M204 S10000
; WIPE_START
G1 F12000
G1 X122.158 Y122.965 E-.28775
G1 X122.512 Y122.36 E-.26632
G1 X122.836 Y121.925 E-.20592
; WIPE_END
G1 E-.04 F1800
G1 X129.961 Y124.659 Z39 F30000
G1 X135.377 Y126.737 Z39
G1 Z38.6
G1 E.8 F1800
M204 S5000
G1 F2081
G1 X135.267 Y127.423 E.02134
G3 X122.45 Y121.083 I-7.274 J-1.421 E.83676
G3 X128.341 Y118.599 I5.537 J4.904 E.20313
G3 X135.373 Y126.678 I-.347 J7.403 E.36783
M204 S10000
G1 X134.964 Y126.656 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.4804
G1 F2081
G1 X134.955 Y126.732 E.00273
G3 X121.01 Y125.639 I-6.958 J-.726 E.7707
G1 X121.012 Y125.616 E.00083
G3 X122.164 Y122.142 I7.277 J.486 E.13188
G3 X134.993 Y126 I5.833 J3.864 E.63741
G1 X134.967 Y126.596 E.02127
; CHANGE_LAYER
; Z_HEIGHT: 38.8
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F14400.657
G1 X134.955 Y126.732 E-.05182
G1 X134.842 Y127.468 E-.28297
G1 X134.646 Y128.187 E-.28304
G1 X134.516 Y128.537 E-.14216
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 194/250
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L194
M991 S0 P193 ;notify layer change
G17
G3 Z39 I.443 J-1.134 P1  F30000
G1 X121.868 Y123.6 Z39
G1 Z38.8
G1 E.8 F1800
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2082
G1 X122.157 Y122.964 E.02147
G3 X127.126 Y119.473 I5.843 J3.036 E.19394
G1 X127.434 Y119.448 E.00951
G1 X127.825 Y119.417 E.01203
G3 X121.846 Y123.656 I.175 J6.583 E1.03257
M204 S10000
; WIPE_START
G1 F12000
G1 X122.157 Y122.964 E-.28824
G1 X122.512 Y122.36 E-.26637
G1 X122.835 Y121.926 E-.20539
; WIPE_END
G1 E-.04 F1800
G1 X129.961 Y124.659 Z39.2 F30000
G1 X135.377 Y126.736 Z39.2
G1 Z38.8
M73 P83 R4
G1 E.8 F1800
M204 S5000
G1 F2082
G1 X135.266 Y127.422 E.02137
G3 X122.45 Y121.083 I-7.273 J-1.421 E.8367
G3 X128.35 Y118.6 I5.537 J4.904 E.20343
G3 X135.372 Y126.678 I-.357 J7.402 E.36749
M204 S10000
G1 X134.964 Y126.656 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.4804
G1 F2082
G1 X134.955 Y126.732 E.00274
G3 X121.01 Y125.639 I-6.958 J-.726 E.7707
G1 X121.012 Y125.616 E.00083
G3 X122.164 Y122.142 I7.277 J.486 E.13188
G3 X134.993 Y126 I5.833 J3.864 E.63741
G1 X134.967 Y126.596 E.02125
; CHANGE_LAYER
; Z_HEIGHT: 39
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F14400.657
G1 X134.955 Y126.732 E-.05199
G1 X134.842 Y127.468 E-.28297
G1 X134.646 Y128.187 E-.28304
G1 X134.516 Y128.537 E-.142
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 195/250
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L195
M991 S0 P194 ;notify layer change
G17
G3 Z39.2 I.443 J-1.134 P1  F30000
G1 X121.868 Y123.6 Z39.2
G1 Z39
G1 E.8 F1800
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2082
G1 X122.157 Y122.964 E.02147
G3 X127.126 Y119.473 I5.843 J3.036 E.19394
G1 X127.425 Y119.449 E.00922
G1 X127.825 Y119.417 E.01232
G3 X121.846 Y123.656 I.175 J6.583 E1.03256
M204 S10000
; WIPE_START
G1 F12000
G1 X122.157 Y122.964 E-.28822
G1 X122.512 Y122.36 E-.26637
G1 X122.835 Y121.926 E-.20541
; WIPE_END
G1 E-.04 F1800
G1 X129.961 Y124.658 Z39.4 F30000
G1 X135.377 Y126.735 Z39.4
G1 Z39
G1 E.8 F1800
M204 S5000
G1 F2082
G1 X135.267 Y127.423 E.02141
G3 X122.001 Y121.642 I-7.273 J-1.42 E.81472
G3 X128.36 Y118.601 I6.011 J4.4 E.2256
G3 X135.374 Y126.676 I-.367 J7.402 E.36716
M204 S10000
G1 X134.964 Y126.654 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.4804
G1 F2082
G1 X134.955 Y126.732 E.00279
G3 X121.01 Y125.639 I-6.958 J-.726 E.7707
G1 X121.012 Y125.616 E.00083
G3 X122.164 Y122.142 I7.277 J.486 E.13188
G3 X134.993 Y126 I5.833 J3.864 E.63741
G1 X134.967 Y126.594 E.0212
; CHANGE_LAYER
; Z_HEIGHT: 39.2
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F14400.655
G1 X134.955 Y126.732 E-.05256
G1 X134.842 Y127.468 E-.28297
G1 X134.646 Y128.187 E-.28304
G1 X134.517 Y128.536 E-.14143
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 196/250
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L196
M991 S0 P195 ;notify layer change
G17
G3 Z39.4 I.442 J-1.134 P1  F30000
G1 X121.868 Y123.6 Z39.4
G1 Z39.2
G1 E.8 F1800
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2082
G1 X122.157 Y122.964 E.02147
G3 X127.126 Y119.473 I5.843 J3.036 E.19394
G1 X127.416 Y119.45 E.00893
G1 X127.825 Y119.417 E.01261
G3 X121.846 Y123.656 I.175 J6.583 E1.03258
M204 S10000
; WIPE_START
G1 F12000
G1 X122.157 Y122.964 E-.28821
G1 X122.512 Y122.36 E-.26637
G1 X122.835 Y121.926 E-.20542
; WIPE_END
G1 E-.04 F1800
G1 X129.962 Y124.657 Z39.6 F30000
G1 X135.378 Y126.733 Z39.6
G1 Z39.2
G1 E.8 F1800
M204 S5000
G1 F2082
G1 X135.267 Y127.423 E.02146
G3 X122.001 Y121.642 I-7.273 J-1.42 E.81472
G3 X128.37 Y118.601 I6.01 J4.399 E.2259
G3 X135.373 Y126.675 I-.377 J7.401 E.3668
M204 S10000
G1 X134.964 Y126.653 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.4804
G1 F2082
G1 X134.955 Y126.732 E.00284
G3 X121.01 Y125.639 I-6.958 J-.726 E.7707
G1 X121.012 Y125.616 E.00083
G3 X122.164 Y122.142 I7.277 J.486 E.13188
G3 X134.993 Y126 I5.833 J3.864 E.63741
G1 X134.967 Y126.593 E.02115
; CHANGE_LAYER
; Z_HEIGHT: 39.4
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F14400.655
G1 X134.955 Y126.732 E-.05304
G1 X134.842 Y127.468 E-.28297
G1 X134.646 Y128.187 E-.28304
G1 X134.517 Y128.534 E-.14095
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 197/250
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L197
M991 S0 P196 ;notify layer change
G17
G3 Z39.6 I.442 J-1.134 P1  F30000
G1 X121.868 Y123.6 Z39.6
G1 Z39.4
G1 E.8 F1800
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2082
G1 X122.157 Y122.964 E.02147
G3 X127.126 Y119.473 I5.843 J3.036 E.19394
G1 X127.406 Y119.451 E.00864
G1 X127.825 Y119.417 E.0129
G3 X121.846 Y123.656 I.175 J6.583 E1.03256
M204 S10000
; WIPE_START
G1 F12000
G1 X122.157 Y122.964 E-.28822
G1 X122.512 Y122.36 E-.26637
G1 X122.835 Y121.926 E-.20541
; WIPE_END
G1 E-.04 F1800
G1 X129.962 Y124.656 Z39.8 F30000
G1 X135.378 Y126.731 Z39.8
G1 Z39.4
G1 E.8 F1800
M204 S5000
G1 F2082
G1 X135.266 Y127.423 E.02152
G3 X122.001 Y121.642 I-7.273 J-1.42 E.81471
G3 X128.38 Y118.602 I6.01 J4.398 E.22621
G3 X135.373 Y126.674 I-.387 J7.4 E.36644
M204 S10000
G1 X134.964 Y126.651 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.4804
G1 F2082
G1 X134.955 Y126.732 E.00289
G3 X121.01 Y125.639 I-6.958 J-.726 E.7707
G1 X121.012 Y125.616 E.00083
G3 X122.164 Y122.142 I7.277 J.486 E.13188
G3 X134.993 Y126 I5.833 J3.864 E.63741
G1 X134.967 Y126.591 E.0211
; CHANGE_LAYER
; Z_HEIGHT: 39.6
; LAYER_HEIGHT: 0.199997
; WIPE_START
G1 F14400.66
G1 X134.955 Y126.732 E-.05359
G1 X134.842 Y127.468 E-.28297
G1 X134.646 Y128.187 E-.28304
G1 X134.518 Y128.533 E-.14039
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 198/250
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L198
M991 S0 P197 ;notify layer change
G17
G3 Z39.8 I.442 J-1.134 P1  F30000
G1 X121.868 Y123.6 Z39.8
G1 Z39.6
G1 E.8 F1800
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2081
G1 X122.158 Y122.965 E.02147
G3 X127.126 Y119.473 I5.841 J3.031 E.19392
G1 X127.397 Y119.451 E.00834
G1 X127.825 Y119.417 E.01319
G3 X121.849 Y123.656 I.175 J6.578 E1.03174
M204 S10000
; WIPE_START
G1 F12000
G1 X122.158 Y122.965 E-.28774
G1 X122.512 Y122.36 E-.26633
G1 X122.836 Y121.925 E-.20594
; WIPE_END
G1 E-.04 F1800
M73 P84 R4
G1 X129.963 Y124.655 Z40 F30000
G1 X135.378 Y126.729 Z40
G1 Z39.6
G1 E.8 F1800
M204 S5000
G1 F2081
G1 X135.266 Y127.423 E.02158
G3 X122.001 Y121.642 I-7.273 J-1.42 E.81471
G3 X128.389 Y118.603 I6.009 J4.398 E.22651
G3 X135.373 Y126.672 I-.397 J7.4 E.36608
M204 S10000
G1 X134.965 Y126.65 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.4804
G1 F2081
G1 X134.955 Y126.732 E.00295
G3 X121.01 Y125.639 I-6.958 J-.726 E.7707
G1 X121.012 Y125.616 E.00083
G3 X122.164 Y122.142 I7.277 J.486 E.13188
G3 X134.993 Y126 I5.833 J3.864 E.63741
G1 X134.967 Y126.59 E.02105
; CHANGE_LAYER
; Z_HEIGHT: 39.8
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F14400.655
G1 X134.955 Y126.732 E-.05418
G1 X134.842 Y127.468 E-.28297
G1 X134.646 Y128.187 E-.28304
G1 X134.518 Y128.532 E-.13981
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 199/250
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L199
M991 S0 P198 ;notify layer change
G17
G3 Z40 I.442 J-1.134 P1  F30000
G1 X121.868 Y123.6 Z40
G1 Z39.8
G1 E.8 F1800
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2082
G1 X122.157 Y122.964 E.02147
G3 X127.126 Y119.473 I5.843 J3.036 E.19394
G1 X127.387 Y119.452 E.00805
G1 X127.825 Y119.417 E.01348
G3 X121.846 Y123.656 I.175 J6.583 E1.03256
M204 S10000
; WIPE_START
G1 F12000
G1 X122.157 Y122.964 E-.28829
G1 X122.512 Y122.36 E-.26637
G1 X122.835 Y121.926 E-.20534
; WIPE_END
G1 E-.04 F1800
G1 X129.963 Y124.654 Z40.2 F30000
G1 X135.379 Y126.727 Z40.2
G1 Z39.8
G1 E.8 F1800
M204 S5000
G1 F2082
G1 X135.267 Y127.423 E.02165
G3 X121.609 Y122.241 I-7.273 J-1.42 E.79272
G3 X128.399 Y118.603 I6.379 J3.751 E.24896
G3 X135.374 Y126.67 I-.406 J7.4 E.36573
M204 S10000
G1 X134.965 Y126.647 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.4804
G1 F2082
G1 X134.955 Y126.732 E.00303
G3 X121.01 Y125.639 I-6.958 J-.726 E.7707
G1 X121.012 Y125.616 E.00083
G3 X122.164 Y122.142 I7.277 J.486 E.13188
G3 X134.993 Y126 I5.833 J3.864 E.63741
G1 X134.967 Y126.587 E.02096
; CHANGE_LAYER
; Z_HEIGHT: 40
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F14400.657
G1 X134.955 Y126.732 E-.05507
G1 X134.842 Y127.468 E-.28297
G1 X134.646 Y128.187 E-.28304
G1 X134.519 Y128.529 E-.13892
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 200/250
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L200
M991 S0 P199 ;notify layer change
G17
G3 Z40.2 I.442 J-1.134 P1  F30000
G1 X121.868 Y123.6 Z40.2
G1 Z40
G1 E.8 F1800
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2081
G1 X122.157 Y122.964 E.02148
G3 X127.126 Y119.473 I5.843 J3.036 E.19394
G1 X127.378 Y119.453 E.00776
G3 X132.839 Y121.533 I.615 J6.595 E.18596
G1 X133.286 Y122.073 E.02154
G3 X121.846 Y123.656 I-5.286 J3.927 E.83863
M204 S10000
; WIPE_START
G1 F12000
G1 X122.157 Y122.964 E-.28836
G1 X122.512 Y122.36 E-.26637
G1 X122.835 Y121.926 E-.20527
; WIPE_END
G1 E-.04 F1800
G1 X129.963 Y124.653 Z40.4 F30000
G1 X135.379 Y126.724 Z40.4
G1 Z40
G1 E.8 F1800
M204 S5000
G1 F2081
G1 X135.267 Y127.423 E.02173
G3 X121.609 Y122.241 I-7.273 J-1.42 E.79272
G3 X128.409 Y118.604 I6.379 J3.751 E.24926
G3 X135.374 Y126.668 I-.416 J7.399 E.36537
M204 S10000
G1 X134.965 Y126.646 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.4804
G1 F2081
G1 X134.955 Y126.732 E.00308
G3 X121.01 Y125.639 I-6.958 J-.726 E.7707
G1 X121.012 Y125.616 E.00083
G3 X122.164 Y122.142 I7.277 J.486 E.13188
G3 X134.993 Y126 I5.833 J3.864 E.63741
G1 X134.967 Y126.586 E.02091
; CHANGE_LAYER
; Z_HEIGHT: 40.2
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F14400.657
G1 X134.955 Y126.732 E-.05565
G1 X134.842 Y127.468 E-.28297
G1 X134.646 Y128.187 E-.28304
G1 X134.52 Y128.528 E-.13833
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 201/250
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L201
M991 S0 P200 ;notify layer change
G17
G3 Z40.4 I.442 J-1.134 P1  F30000
G1 X121.868 Y123.6 Z40.4
G1 Z40.2
G1 E.8 F1800
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2081
G1 X122.158 Y122.965 E.02148
G3 X127.126 Y119.473 I5.841 J3.031 E.19392
G1 X127.368 Y119.454 E.00747
G1 X127.825 Y119.417 E.01407
G3 X121.849 Y123.656 I.175 J6.578 E1.03173
M204 S10000
; WIPE_START
G1 F12000
G1 X122.158 Y122.965 E-.28785
G1 X122.512 Y122.36 E-.26632
G1 X122.835 Y121.925 E-.20583
; WIPE_END
G1 E-.04 F1800
G1 X129.964 Y124.651 Z40.6 F30000
G1 X135.379 Y126.722 Z40.6
G1 Z40.2
G1 E.8 F1800
M204 S5000
G1 F2081
G1 X135.267 Y127.423 E.02181
G3 X121.609 Y122.241 I-7.273 J-1.419 E.79272
G3 X128.419 Y118.605 I6.378 J3.751 E.24956
M73 P84 R3
G3 X135.374 Y126.667 I-.426 J7.398 E.36502
M204 S10000
G1 X134.965 Y126.645 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.480401
G1 F2081
G1 X134.955 Y126.732 E.00313
G3 X121.01 Y125.639 I-6.958 J-.726 E.7707
G1 X121.012 Y125.616 E.00083
G3 X122.164 Y122.142 I7.111 J.431 E.13195
G3 X134.993 Y126 I5.833 J3.864 E.63741
G1 X134.967 Y126.585 E.02086
; CHANGE_LAYER
; Z_HEIGHT: 40.4
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F14400.654
G1 X134.955 Y126.732 E-.05613
G1 X134.842 Y127.468 E-.28297
G1 X134.646 Y128.187 E-.28304
G1 X134.52 Y128.527 E-.13786
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 202/250
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L202
M991 S0 P201 ;notify layer change
G17
G3 Z40.6 I.442 J-1.134 P1  F30000
G1 X121.867 Y123.601 Z40.6
G1 Z40.4
G1 E.8 F1800
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2081
G1 X122.159 Y122.965 E.02149
G3 X127.126 Y119.473 I5.841 J3.031 E.19392
G1 X127.359 Y119.454 E.00718
M73 P85 R3
G1 X127.825 Y119.417 E.01436
G3 X121.849 Y123.656 I.175 J6.578 E1.0317
M204 S10000
; WIPE_START
G1 F12000
G1 X122.159 Y122.965 E-.28787
G1 X122.512 Y122.36 E-.26632
G1 X122.835 Y121.925 E-.20581
; WIPE_END
G1 E-.04 F1800
G1 X129.965 Y124.65 Z40.8 F30000
G1 X135.38 Y126.719 Z40.8
G1 Z40.4
G1 E.8 F1800
M204 S5000
G1 F2081
G1 X135.266 Y127.423 E.02189
G3 X121.609 Y122.241 I-7.273 J-1.419 E.79271
G3 X128.429 Y118.606 I6.378 J3.75 E.24986
G3 X135.374 Y126.666 I-.436 J7.398 E.36468
M204 S10000
G1 X134.965 Y126.644 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.4804
G1 F2081
G1 X134.955 Y126.732 E.00316
G3 X121.01 Y125.639 I-6.958 J-.726 E.7707
G1 X121.012 Y125.616 E.00083
G3 X122.164 Y122.142 I7.113 J.432 E.13195
G3 X134.993 Y126 I5.833 J3.864 E.63741
G1 X134.967 Y126.584 E.02083
; CHANGE_LAYER
; Z_HEIGHT: 40.6
; LAYER_HEIGHT: 0.199997
; WIPE_START
G1 F14400.655
G1 X134.955 Y126.732 E-.05644
G1 X134.842 Y127.468 E-.28297
G1 X134.646 Y128.187 E-.28304
G1 X134.52 Y128.526 E-.13754
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 203/250
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L203
M991 S0 P202 ;notify layer change
G17
G3 Z40.8 I.441 J-1.134 P1  F30000
G1 X121.867 Y123.601 Z40.8
G1 Z40.6
G1 E.8 F1800
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2081
G1 X122.159 Y122.965 E.0215
G3 X127.126 Y119.473 I5.841 J3.031 E.19392
G1 X127.349 Y119.455 E.00689
G1 X127.825 Y119.417 E.01465
G3 X121.849 Y123.656 I.175 J6.578 E1.03171
M204 S10000
; WIPE_START
G1 F12000
G1 X122.159 Y122.965 E-.28794
G1 X122.512 Y122.36 E-.26632
G1 X122.835 Y121.925 E-.20574
; WIPE_END
G1 E-.04 F1800
G1 X129.965 Y124.649 Z41 F30000
G1 X135.38 Y126.717 Z41
G1 Z40.6
G1 E.8 F1800
M204 S5000
G1 F2081
G1 X135.267 Y127.423 E.02197
G3 X121.276 Y122.875 I-7.273 J-1.419 E.77068
G3 X128.438 Y118.606 I6.731 J3.15 E.27202
G3 X135.375 Y126.665 I-.445 J7.397 E.36436
M204 S10000
G1 X134.965 Y126.643 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.4804
G1 F2081
G1 X134.955 Y126.732 E.00319
G3 X121.01 Y125.639 I-6.958 J-.726 E.7707
G1 X121.012 Y125.616 E.00083
G3 X122.164 Y122.142 I7.115 J.432 E.13195
G3 X134.993 Y126 I5.833 J3.864 E.63741
G1 X134.968 Y126.583 E.0208
; CHANGE_LAYER
; Z_HEIGHT: 40.8
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F14400.655
G1 X134.955 Y126.732 E-.0568
G1 X134.842 Y127.468 E-.28297
G1 X134.646 Y128.187 E-.28304
G1 X134.521 Y128.525 E-.13719
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 204/250
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L204
M991 S0 P203 ;notify layer change
G17
G3 Z41 I.441 J-1.134 P1  F30000
G1 X121.867 Y123.601 Z41
G1 Z40.8
G1 E.8 F1800
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2076
G1 X122.157 Y122.964 E.02152
G3 X127.126 Y119.473 I5.843 J3.036 E.19394
G1 X127.34 Y119.456 E.0066
G1 X127.825 Y119.417 E.01494
G3 X121.846 Y123.657 I.175 J6.583 E1.03252
M204 S10000
; WIPE_START
G1 F12000
G1 X122.157 Y122.964 E-.28884
G1 X122.512 Y122.36 E-.26637
G1 X122.834 Y121.927 E-.20479
; WIPE_END
G1 E-.04 F1800
G1 X129.965 Y124.649 Z41.2 F30000
G1 X135.38 Y126.715 Z41.2
G1 Z40.8
G1 E.8 F1800
M204 S5000
G1 F2076
G1 X135.37 Y126.715 E.00031
G3 X121.276 Y122.875 I-7.376 J-.711 E.79272
G3 X128.448 Y118.607 I6.731 J3.15 E.27232
G3 X135.404 Y126 I-.455 J7.397 E.3436
G1 X135.382 Y126.656 E.02015
M204 S10000
G1 X134.965 Y126.633 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.4804
G1 F2076
G1 X134.955 Y126.732 E.00355
G3 X121.01 Y125.639 I-6.958 J-.726 E.7707
G1 X121.012 Y125.616 E.00083
G3 X122.164 Y122.142 I7.277 J.486 E.13188
G3 X134.993 Y126 I5.833 J3.864 E.63741
G1 X134.968 Y126.573 E.02044
; CHANGE_LAYER
; Z_HEIGHT: 41
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F14400.657
G1 X134.955 Y126.732 E-.06062
G1 X134.842 Y127.468 E-.28297
G1 X134.646 Y128.187 E-.28304
G1 X134.524 Y128.516 E-.13337
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 205/250
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L205
M991 S0 P204 ;notify layer change
G17
G3 Z41.2 I.44 J-1.134 P1  F30000
G1 X121.867 Y123.602 Z41.2
G1 Z41
G1 E.8 F1800
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2076
G1 X122.157 Y122.964 E.02153
G3 X127.126 Y119.473 I5.843 J3.036 E.19394
G1 X127.331 Y119.457 E.00631
G1 X127.825 Y119.417 E.01523
G3 X121.845 Y123.658 I.175 J6.583 E1.0325
M204 S10000
; WIPE_START
G1 F12000
G1 X122.157 Y122.964 E-.28903
G1 X122.512 Y122.36 E-.26637
G1 X122.833 Y121.927 E-.2046
; WIPE_END
G1 E-.04 F1800
G1 X129.964 Y124.649 Z41.4 F30000
G1 X135.38 Y126.715 Z41.4
G1 Z41
G1 E.8 F1800
M204 S5000
G1 F2076
G1 X135.37 Y126.715 E.00031
G3 X121.276 Y122.875 I-7.376 J-.711 E.79272
G3 X128.458 Y118.608 I6.731 J3.15 E.27262
G3 X135.404 Y126 I-.464 J7.396 E.34329
G1 X135.382 Y126.655 E.02015
M204 S10000
G1 X134.966 Y126.633 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.4804
G1 F2076
G1 X134.955 Y126.732 E.00356
G3 X121.01 Y125.639 I-6.958 J-.726 E.7707
G1 X121.012 Y125.616 E.00083
G3 X122.164 Y122.142 I7.277 J.486 E.13188
G3 X134.993 Y126 I5.833 J3.864 E.63741
G1 X134.968 Y126.573 E.02044
; CHANGE_LAYER
; Z_HEIGHT: 41.2
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F14400.655
M73 P86 R3
G1 X134.955 Y126.732 E-.06069
G1 X134.842 Y127.468 E-.28297
G1 X134.646 Y128.187 E-.28304
G1 X134.524 Y128.516 E-.13329
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 206/250
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L206
M991 S0 P205 ;notify layer change
G17
G3 Z41.4 I.44 J-1.134 P1  F30000
G1 X121.869 Y123.603 Z41.4
G1 Z41.2
G1 E.8 F1800
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2076
G3 X127.126 Y119.473 I6.13 J2.392 E.21546
G1 X127.321 Y119.457 E.00602
G1 X127.825 Y119.417 E.01552
G3 X121.848 Y123.659 I.175 J6.578 E1.03164
M204 S10000
; WIPE_START
G1 F12000
G1 X122.157 Y122.964 E-.28907
G1 X122.512 Y122.36 E-.26637
G1 X122.833 Y121.928 E-.20456
; WIPE_END
G1 E-.04 F1800
G1 X129.964 Y124.649 Z41.6 F30000
G1 X135.38 Y126.715 Z41.6
G1 Z41.2
G1 E.8 F1800
M204 S5000
G1 F2076
G1 X135.37 Y126.715 E.00031
G3 X121.276 Y122.875 I-7.376 J-.711 E.79272
G3 X128.468 Y118.608 I6.73 J3.15 E.27292
G3 X135.404 Y126 I-.474 J7.395 E.34298
G1 X135.382 Y126.655 E.02014
M204 S10000
G1 X134.966 Y126.632 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.4804
G1 F2076
G1 X134.955 Y126.732 E.00356
G3 X121.01 Y125.639 I-6.958 J-.726 E.7707
G1 X121.012 Y125.616 E.00083
G3 X122.164 Y122.142 I7.277 J.486 E.13188
G3 X134.993 Y126 I5.833 J3.864 E.63741
G1 X134.968 Y126.573 E.02043
; CHANGE_LAYER
; Z_HEIGHT: 41.4
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F14400.657
G1 X134.955 Y126.732 E-.06076
G1 X134.842 Y127.468 E-.28297
G1 X134.646 Y128.187 E-.28304
G1 X134.524 Y128.515 E-.13322
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 207/250
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L207
M991 S0 P206 ;notify layer change
G17
G3 Z41.6 I.44 J-1.134 P1  F30000
G1 X121.869 Y123.603 Z41.6
G1 Z41.4
G1 E.8 F1800
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2076
G3 X127.126 Y119.473 I6.13 J2.392 E.21546
G1 X127.312 Y119.458 E.00573
G1 X127.825 Y119.417 E.01581
G3 X121.848 Y123.659 I.175 J6.578 E1.03164
M204 S10000
; WIPE_START
G1 F12000
G1 X122.157 Y122.964 E-.28906
G1 X122.512 Y122.36 E-.26637
G1 X122.833 Y121.928 E-.20457
; WIPE_END
G1 E-.04 F1800
G1 X129.964 Y124.648 Z41.8 F30000
G1 X135.38 Y126.715 Z41.8
G1 Z41.4
G1 E.8 F1800
M204 S5000
G1 F2076
G1 X135.37 Y126.715 E.00032
G3 X121.276 Y122.875 I-7.376 J-.711 E.79272
G3 X128.478 Y118.609 I6.73 J3.149 E.27322
G3 X135.404 Y126 I-.484 J7.395 E.34268
G1 X135.382 Y126.655 E.02014
M204 S10000
G1 X134.966 Y126.632 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.4804
G1 F2076
G1 X134.955 Y126.732 E.00357
G3 X121.01 Y125.639 I-6.958 J-.726 E.7707
G1 X121.012 Y125.616 E.00083
G3 X122.164 Y122.142 I7.277 J.486 E.13188
G3 X134.993 Y126 I5.833 J3.864 E.63741
G1 X134.968 Y126.572 E.02042
; CHANGE_LAYER
; Z_HEIGHT: 41.6
; LAYER_HEIGHT: 0.199997
; WIPE_START
G1 F14400.657
G1 X134.955 Y126.732 E-.06082
G1 X134.842 Y127.468 E-.28297
G1 X134.646 Y128.187 E-.28304
G1 X134.524 Y128.515 E-.13316
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 208/250
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L208
M991 S0 P207 ;notify layer change
G17
G3 Z41.8 I.44 J-1.135 P1  F30000
G1 X121.866 Y123.604 Z41.8
G1 Z41.6
G1 E.8 F1800
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2074
G1 X121.867 Y123.602 E.00006
G3 X127.126 Y119.473 I6.133 J2.398 E.21549
G1 X127.302 Y119.459 E.00544
G1 X127.825 Y119.417 E.0161
G3 X121.647 Y124.267 I.175 J6.583 E1.01278
G1 X121.847 Y123.661 E.01964
M204 S10000
; WIPE_START
G1 F12000
G1 X121.867 Y123.602 E-.02349
G1 X122.157 Y122.964 E-.26636
G1 X122.512 Y122.36 E-.26637
G1 X122.832 Y121.929 E-.20377
; WIPE_END
G1 E-.04 F1800
G1 X129.964 Y124.649 Z42 F30000
G1 X135.38 Y126.715 Z42
G1 Z41.6
G1 E.8 F1800
M204 S5000
G1 F2074
G1 X135.37 Y126.715 E.00032
G3 X121.276 Y122.875 I-7.376 J-.711 E.79272
G3 X128.487 Y118.61 I6.73 J3.149 E.27352
G3 X135.404 Y126 I-.494 J7.394 E.34237
G1 X135.382 Y126.655 E.02013
M204 S10000
G1 X134.966 Y126.632 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.4804
G1 F2074
G1 X134.955 Y126.732 E.00357
G3 X121.01 Y125.639 I-6.958 J-.726 E.7707
G1 X121.012 Y125.616 E.00083
G3 X122.164 Y122.142 I7.277 J.486 E.13188
G3 X134.993 Y126 I5.833 J3.864 E.63741
G1 X134.968 Y126.572 E.02042
; CHANGE_LAYER
; Z_HEIGHT: 41.8
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F14400.657
G1 X134.955 Y126.732 E-.06087
G1 X134.842 Y127.468 E-.28297
G1 X134.646 Y128.187 E-.28304
G1 X134.524 Y128.515 E-.13311
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 209/250
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L209
M991 S0 P208 ;notify layer change
G17
G3 Z42 I.44 J-1.135 P1  F30000
G1 X121.866 Y123.604 Z42
G1 Z41.8
G1 E.8 F1800
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2073
G1 X121.869 Y123.603 E.0001
G3 X127.126 Y119.473 I6.131 J2.393 E.21546
G1 X127.293 Y119.46 E.00514
G1 X127.825 Y119.417 E.01639
G3 X121.695 Y124.107 I.175 J6.579 E1.01721
G1 X121.847 Y123.661 E.01447
M204 S10000
; WIPE_START
G1 F12000
G1 X121.869 Y123.603 E-.02379
G1 X122.157 Y122.964 E-.26632
G1 X122.512 Y122.36 E-.26637
M73 P87 R3
G1 X122.832 Y121.93 E-.20352
; WIPE_END
G1 E-.04 F1800
G1 X129.963 Y124.649 Z42.2 F30000
G1 X135.38 Y126.715 Z42.2
G1 Z41.8
G1 E.8 F1800
M204 S5000
G1 F2073
G1 X135.37 Y126.715 E.00032
G3 X121.276 Y122.875 I-7.376 J-.711 E.79272
G3 X128.497 Y118.611 I6.73 J3.149 E.27382
G3 X135.404 Y126 I-.504 J7.393 E.34207
G1 X135.382 Y126.655 E.02013
M204 S10000
G1 X134.966 Y126.632 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.4804
G1 F2073
G1 X134.955 Y126.732 E.00358
G3 X121.01 Y125.639 I-6.958 J-.726 E.7707
G1 X121.012 Y125.616 E.00083
G3 X122.164 Y122.142 I7.126 J.436 E.13194
G3 X134.993 Y126 I5.833 J3.864 E.63741
G1 X134.968 Y126.572 E.02041
; CHANGE_LAYER
; Z_HEIGHT: 42
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F14400.655
G1 X134.955 Y126.732 E-.06091
G1 X134.842 Y127.468 E-.28297
G1 X134.646 Y128.187 E-.28304
G1 X134.524 Y128.515 E-.13308
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 210/250
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L210
M991 S0 P209 ;notify layer change
G17
G3 Z42.2 I.44 J-1.135 P1  F30000
G1 X121.866 Y123.605 Z42.2
G1 Z42
G1 E.8 F1800
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2074
G1 X121.867 Y123.602 E.00011
G3 X127.126 Y119.473 I6.133 J2.398 E.21549
G1 X127.283 Y119.46 E.00485
G1 X127.825 Y119.417 E.01669
G3 X121.69 Y124.116 I.175 J6.583 E1.01764
G1 X121.846 Y123.662 E.01474
M204 S10000
; WIPE_START
G1 F12000
G1 X121.867 Y123.602 E-.02413
G1 X122.157 Y122.964 E-.26636
G1 X122.512 Y122.36 E-.26637
G1 X122.831 Y121.931 E-.20314
; WIPE_END
G1 E-.04 F1800
G1 X129.963 Y124.649 Z42.4 F30000
G1 X135.38 Y126.715 Z42.4
G1 Z42
G1 E.8 F1800
M204 S5000
G1 F2074
G1 X135.37 Y126.715 E.00032
G3 X121.276 Y122.875 I-7.376 J-.711 E.79271
G3 X128.507 Y118.611 I6.73 J3.149 E.27413
G3 X135.404 Y126 I-.514 J7.393 E.34176
G1 X135.382 Y126.655 E.02013
M204 S10000
G1 X134.966 Y126.632 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.4804
G1 F2074
G1 X134.955 Y126.732 E.00358
G3 X121.01 Y125.639 I-6.958 J-.726 E.7707
G1 X121.012 Y125.616 E.00083
G3 X122.164 Y122.142 I7.128 J.437 E.13194
G3 X134.993 Y126 I5.833 J3.864 E.63741
G1 X134.968 Y126.572 E.02041
; CHANGE_LAYER
; Z_HEIGHT: 42.2
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F14400.66
G1 X134.955 Y126.732 E-.06094
G1 X134.842 Y127.468 E-.28297
G1 X134.646 Y128.187 E-.28304
G1 X134.525 Y128.515 E-.13305
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 211/250
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L211
M991 S0 P210 ;notify layer change
G17
G3 Z42.4 I.44 J-1.135 P1  F30000
G1 X121.866 Y123.606 Z42.4
G1 Z42.2
G1 E.8 F1800
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2074
G1 X121.867 Y123.602 E.00013
G3 X127.126 Y119.473 I6.133 J2.398 E.21549
G1 X127.274 Y119.461 E.00456
G1 X127.825 Y119.417 E.01698
G3 X121.647 Y124.267 I.175 J6.583 E1.01279
G1 X121.847 Y123.663 E.01956
M204 S10000
; WIPE_START
G1 F12000
G1 X121.867 Y123.602 E-.02442
G1 X122.157 Y122.964 E-.26637
G1 X122.512 Y122.36 E-.26636
G1 X122.831 Y121.931 E-.20285
; WIPE_END
G1 E-.04 F1800
G1 X129.963 Y124.65 Z42.6 F30000
G1 X135.38 Y126.715 Z42.6
G1 Z42.2
G1 E.8 F1800
M204 S5000
G1 F2074
G1 X135.37 Y126.715 E.00032
G3 X121.276 Y122.875 I-7.376 J-.711 E.79271
G3 X128.517 Y118.612 I6.73 J3.149 E.27443
G3 X135.404 Y126 I-.523 J7.392 E.34146
G1 X135.382 Y126.655 E.02013
M204 S10000
G1 X134.966 Y126.632 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.4804
G1 F2074
G1 X134.955 Y126.732 E.00358
G3 X121.01 Y125.639 I-6.958 J-.726 E.7707
G1 X121.012 Y125.616 E.00083
G3 X122.164 Y122.142 I7.277 J.486 E.13188
G3 X134.993 Y126 I5.833 J3.864 E.63741
G1 X134.968 Y126.572 E.02041
; CHANGE_LAYER
; Z_HEIGHT: 42.4
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F14400.655
G1 X134.955 Y126.732 E-.06095
G1 X134.842 Y127.468 E-.28297
G1 X134.646 Y128.187 E-.28304
G1 X134.525 Y128.515 E-.13303
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 212/250
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L212
M991 S0 P211 ;notify layer change
G17
G3 Z42.6 I.44 J-1.135 P1  F30000
G1 X121.865 Y123.607 Z42.6
G1 Z42.4
G1 E.8 F1800
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2074
G1 X121.867 Y123.602 E.00015
G3 X127.126 Y119.473 I6.133 J2.398 E.21549
G1 X127.265 Y119.462 E.00427
G1 X127.825 Y119.417 E.01727
G3 X121.647 Y124.267 I.175 J6.583 E1.01279
G1 X121.846 Y123.664 E.01954
M204 S10000
; WIPE_START
G1 F12000
G1 X121.867 Y123.602 E-.02467
G1 X122.157 Y122.964 E-.26636
G1 X122.512 Y122.36 E-.26636
G1 X122.83 Y121.932 E-.2026
; WIPE_END
G1 E-.04 F1800
G1 X129.962 Y124.65 Z42.8 F30000
G1 X135.38 Y126.715 Z42.8
G1 Z42.4
G1 E.8 F1800
M204 S5000
G1 F2074
G1 X135.37 Y126.715 E.00032
G3 X121.276 Y122.875 I-7.376 J-.711 E.79271
G3 X128.527 Y118.613 I6.73 J3.149 E.27473
G3 X135.404 Y126 I-.533 J7.391 E.34116
G1 X135.382 Y126.655 E.02013
M204 S10000
G1 X134.966 Y126.632 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.4804
G1 F2074
G1 X134.955 Y126.732 E.00358
G3 X121.01 Y125.639 I-6.958 J-.726 E.7707
G1 X121.012 Y125.616 E.00083
G3 X122.164 Y122.142 I7.277 J.486 E.13188
G3 X134.993 Y126 I5.833 J3.864 E.63741
G1 X134.968 Y126.572 E.02041
; CHANGE_LAYER
; Z_HEIGHT: 42.6
; LAYER_HEIGHT: 0.199997
; WIPE_START
G1 F14400.655
G1 X134.955 Y126.732 E-.06095
G1 X134.842 Y127.468 E-.28297
G1 X134.646 Y128.187 E-.28304
G1 X134.525 Y128.515 E-.13303
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 213/250
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L213
M991 S0 P212 ;notify layer change
G17
G3 Z42.8 I.44 J-1.135 P1  F30000
G1 X121.865 Y123.607 Z42.8
G1 Z42.6
G1 E.8 F1800
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
M73 P88 R3
G1 F2073
G1 X121.869 Y123.603 E.00017
G3 X127.126 Y119.473 I6.131 J2.394 E.21547
G1 X127.255 Y119.463 E.00398
G1 X127.825 Y119.417 E.01756
G3 X121.649 Y124.268 I.175 J6.58 E1.01218
G1 X121.847 Y123.664 E.01952
M204 S10000
; WIPE_START
G1 F12000
G1 X121.869 Y123.603 E-.02484
G1 X122.157 Y122.964 E-.26633
G1 X122.512 Y122.36 E-.26637
G1 X122.83 Y121.932 E-.20246
; WIPE_END
G1 E-.04 F1800
G1 X129.962 Y124.65 Z43 F30000
G1 X135.38 Y126.715 Z43
G1 Z42.6
G1 E.8 F1800
M204 S5000
G1 F2073
G1 X135.37 Y126.715 E.00032
G3 X121.276 Y122.875 I-7.376 J-.711 E.79271
G3 X128.536 Y118.613 I6.73 J3.149 E.27503
G3 X135.404 Y126 I-.543 J7.391 E.34085
G1 X135.382 Y126.655 E.02013
M204 S10000
G1 X134.966 Y126.632 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.4804
G1 F2073
G1 X134.955 Y126.732 E.00358
G3 X121.01 Y125.639 I-6.958 J-.726 E.7707
G1 X121.012 Y125.616 E.00083
G3 X122.164 Y122.142 I7.132 J.438 E.13194
G3 X134.993 Y126 I5.833 J3.864 E.63741
G1 X134.968 Y126.572 E.02041
; CHANGE_LAYER
; Z_HEIGHT: 42.8
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F14400.655
G1 X134.955 Y126.732 E-.06095
G1 X134.842 Y127.468 E-.28297
G1 X134.646 Y128.187 E-.28304
G1 X134.525 Y128.515 E-.13303
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 214/250
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L214
M991 S0 P213 ;notify layer change
G17
G3 Z43 I.44 J-1.135 P1  F30000
G1 X121.865 Y123.607 Z43
G1 Z42.8
G1 E.8 F1800
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2073
G1 X121.868 Y123.603 E.00018
G3 X127.126 Y119.473 I6.131 J2.394 E.21547
G1 X127.246 Y119.463 E.00369
G1 X127.825 Y119.417 E.01785
G3 X121.649 Y124.268 I.175 J6.58 E1.01224
G1 X121.846 Y123.664 E.01951
M204 S10000
; WIPE_START
G1 F12000
G1 X121.868 Y123.603 E-.02497
G1 X122.157 Y122.964 E-.26633
G1 X122.512 Y122.36 E-.26637
G1 X122.83 Y121.932 E-.20234
; WIPE_END
G1 E-.04 F1800
G1 X129.962 Y124.65 Z43.2 F30000
G1 X135.38 Y126.715 Z43.2
G1 Z42.8
G1 E.8 F1800
M204 S5000
G1 F2073
G1 X135.37 Y126.715 E.00032
G3 X121.276 Y122.875 I-7.376 J-.711 E.79271
G3 X128.546 Y118.614 I6.73 J3.149 E.27533
G3 X135.404 Y126 I-.553 J7.39 E.34055
G1 X135.382 Y126.655 E.02013
M204 S10000
G1 X134.966 Y126.632 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.4804
G1 F2073
G1 X134.954 Y126.732 E.00358
G3 X121.01 Y125.639 I-6.958 J-.726 E.77062
G1 X121.012 Y125.616 E.00083
G3 X122.164 Y122.142 I7.277 J.486 E.13188
G3 X134.992 Y126 I5.832 J3.863 E.63735
G1 X134.968 Y126.572 E.02041
; CHANGE_LAYER
; Z_HEIGHT: 43
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F14400.655
G1 X134.954 Y126.732 E-.06093
G1 X134.842 Y127.468 E-.28295
G1 X134.646 Y128.187 E-.28304
G1 X134.524 Y128.515 E-.13308
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 215/250
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L215
M991 S0 P214 ;notify layer change
G17
G3 Z43.2 I.44 J-1.135 P1  F30000
G1 X121.865 Y123.607 Z43.2
G1 Z43
G1 E.8 F1800
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2073
G1 X121.868 Y123.602 E.00018
G3 X127.126 Y119.473 I6.131 J2.395 E.21547
G1 X127.236 Y119.464 E.0034
G1 X127.825 Y119.417 E.01814
G3 X121.649 Y124.268 I.175 J6.58 E1.01227
G1 X121.846 Y123.664 E.01951
M204 S10000
; WIPE_START
G1 F12000
G1 X121.868 Y123.602 E-.025
G1 X122.157 Y122.964 E-.26633
G1 X122.512 Y122.36 E-.26637
G1 X122.83 Y121.932 E-.2023
; WIPE_END
G1 E-.04 F1800
G1 X129.962 Y124.65 Z43.4 F30000
G1 X135.38 Y126.715 Z43.4
G1 Z43
G1 E.8 F1800
M204 S5000
G1 F2073
G1 X135.37 Y126.715 E.00032
G3 X121.276 Y122.875 I-7.376 J-.711 E.79271
G3 X128.556 Y118.615 I6.73 J3.149 E.27563
G3 X135.404 Y126 I-.563 J7.389 E.34025
G1 X135.382 Y126.655 E.02013
M204 S10000
G1 X134.966 Y126.632 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.4804
G1 F2073
M73 P88 R2
G1 X134.955 Y126.732 E.00358
G3 X121.01 Y125.639 I-6.958 J-.726 E.7707
G1 X121.012 Y125.616 E.00083
G3 X122.164 Y122.142 I7.277 J.486 E.13188
G3 X134.993 Y126 I5.833 J3.864 E.63741
G1 X134.968 Y126.572 E.02041
; CHANGE_LAYER
; Z_HEIGHT: 43.2
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F14400.66
G1 X134.955 Y126.732 E-.06092
G1 X134.842 Y127.468 E-.28298
G1 X134.646 Y128.187 E-.28304
G1 X134.524 Y128.515 E-.13307
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 216/250
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L216
M991 S0 P215 ;notify layer change
G17
G3 Z43.4 I.44 J-1.135 P1  F30000
G1 X121.865 Y123.607 Z43.4
G1 Z43.2
G1 E.8 F1800
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2073
G1 X121.869 Y123.603 E.00019
G3 X127.126 Y119.473 I6.13 J2.392 E.21546
G1 X127.227 Y119.465 E.00311
G1 X127.825 Y119.417 E.01843
G3 X121.677 Y124.171 I.175 J6.578 E1.01505
G1 X121.846 Y123.664 E.01642
M204 S10000
; WIPE_START
G1 F12000
G1 X121.869 Y123.603 E-.02492
G1 X122.157 Y122.964 E-.26631
G1 X122.512 Y122.36 E-.26637
G1 X122.83 Y121.932 E-.2024
; WIPE_END
G1 E-.04 F1800
G1 X129.962 Y124.65 Z43.6 F30000
G1 X135.38 Y126.715 Z43.6
G1 Z43.2
G1 E.8 F1800
M204 S5000
G1 F2073
G1 X135.37 Y126.715 E.00032
G3 X121.276 Y122.875 I-7.376 J-.711 E.79272
G3 X128.566 Y118.615 I6.73 J3.149 E.27594
G3 X135.404 Y126 I-.572 J7.388 E.33995
G1 X135.382 Y126.655 E.02013
M204 S10000
G1 X134.966 Y126.632 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.4804
G1 F2073
G1 X134.955 Y126.732 E.00358
G3 X121.01 Y125.639 I-6.958 J-.726 E.7707
G1 X121.012 Y125.616 E.00083
G3 X122.164 Y122.142 I7.277 J.486 E.13188
G3 X134.993 Y126 I5.833 J3.864 E.63741
G1 X134.968 Y126.572 E.02042
; CHANGE_LAYER
; Z_HEIGHT: 43.4
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F14400.655
G1 X134.955 Y126.732 E-.06089
M73 P89 R2
G1 X134.842 Y127.468 E-.28298
G1 X134.646 Y128.187 E-.28304
G1 X134.524 Y128.515 E-.1331
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 217/250
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L217
M991 S0 P216 ;notify layer change
G17
G3 Z43.6 I.44 J-1.135 P1  F30000
G1 X121.865 Y123.607 Z43.6
G1 Z43.4
G1 E.8 F1800
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2073
G1 X121.869 Y123.603 E.00017
G3 X127.126 Y119.473 I6.13 J2.392 E.21546
G1 X127.217 Y119.466 E.00282
G1 X127.825 Y119.417 E.01872
G3 X121.65 Y124.268 I.175 J6.578 E1.01194
G1 X121.847 Y123.664 E.01953
M204 S10000
; WIPE_START
G1 F12000
G1 X121.869 Y123.603 E-.02471
G1 X122.157 Y122.964 E-.26631
G1 X122.512 Y122.36 E-.26637
G1 X122.83 Y121.932 E-.20261
; WIPE_END
G1 E-.04 F1800
G1 X129.962 Y124.65 Z43.8 F30000
G1 X135.38 Y126.715 Z43.8
G1 Z43.4
G1 E.8 F1800
M204 S5000
G1 F2073
G1 X135.37 Y126.715 E.00032
G3 X121.276 Y122.875 I-7.376 J-.711 E.79272
G3 X128.576 Y118.616 I6.73 J3.149 E.27624
G3 X135.404 Y126 I-.582 J7.388 E.33965
G1 X135.382 Y126.655 E.02013
M204 S10000
G1 X134.966 Y126.632 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.4804
G1 F2073
G1 X134.955 Y126.732 E.00357
G3 X121.01 Y125.639 I-6.958 J-.726 E.7707
G1 X121.012 Y125.616 E.00083
G3 X122.164 Y122.142 I7.277 J.486 E.13188
G3 X134.993 Y126 I5.833 J3.864 E.63741
G1 X134.968 Y126.572 E.02042
; CHANGE_LAYER
; Z_HEIGHT: 43.6
; LAYER_HEIGHT: 0.199997
; WIPE_START
G1 F14400.655
G1 X134.955 Y126.732 E-.06086
G1 X134.842 Y127.468 E-.28297
G1 X134.646 Y128.187 E-.28304
G1 X134.524 Y128.515 E-.13313
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 218/250
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L218
M991 S0 P217 ;notify layer change
G17
G3 Z43.8 I.44 J-1.135 P1  F30000
G1 X121.866 Y123.606 Z43.8
G1 Z43.6
G1 E.8 F1800
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2073
G1 X121.869 Y123.603 E.00015
G3 X127.126 Y119.473 I6.13 J2.392 E.21546
G1 X127.208 Y119.466 E.00253
G1 X127.825 Y119.417 E.01901
G3 X121.672 Y124.189 I.175 J6.578 E1.01446
G1 X121.847 Y123.663 E.01704
M204 S10000
; WIPE_START
G1 F12000
G1 X121.869 Y123.603 E-.02438
G1 X122.157 Y122.964 E-.26632
G1 X122.512 Y122.36 E-.26636
G1 X122.831 Y121.931 E-.20295
; WIPE_END
G1 E-.04 F1800
G1 X129.963 Y124.65 Z44 F30000
G1 X135.38 Y126.715 Z44
G1 Z43.6
G1 E.8 F1800
M204 S5000
G1 F2073
G1 X135.372 Y126.715 E.00026
G3 X129.6 Y133.24 I-7.382 J-.714 E.2861
G3 X128.585 Y118.617 I-1.6 J-7.236 E.7829
G1 X128.894 Y118.639 E.0095
G3 X135.406 Y126 I-.904 J7.361 E.3301
G1 X135.382 Y126.655 E.02014
M204 S10000
G1 X134.966 Y126.632 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.4804
G1 F2073
G1 X134.955 Y126.732 E.00357
G3 X121.01 Y125.639 I-6.958 J-.726 E.7707
G1 X121.012 Y125.616 E.00083
G3 X122.164 Y122.142 I7.137 J.44 E.13194
G3 X134.993 Y126 I5.833 J3.864 E.63741
G1 X134.968 Y126.572 E.02042
; CHANGE_LAYER
; Z_HEIGHT: 43.8
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F14400.657
G1 X134.955 Y126.732 E-.06082
G1 X134.842 Y127.468 E-.28298
G1 X134.646 Y128.187 E-.28304
G1 X134.524 Y128.515 E-.13317
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 219/250
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L219
M991 S0 P218 ;notify layer change
G17
G3 Z44 I.44 J-1.135 P1  F30000
G1 X121.866 Y123.605 Z44
G1 Z43.8
G1 E.8 F1800
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2073
G1 X121.869 Y123.603 E.00012
G3 X127.126 Y119.473 I6.13 J2.392 E.21546
G1 X127.198 Y119.467 E.00224
G1 X127.825 Y119.417 E.0193
G3 X121.65 Y124.268 I.175 J6.578 E1.01194
G1 X121.847 Y123.662 E.0196
M204 S10000
; WIPE_START
G1 F12000
G1 X121.869 Y123.603 E-.02387
G1 X122.157 Y122.964 E-.26632
G1 X122.512 Y122.36 E-.26636
G1 X122.832 Y121.93 E-.20345
; WIPE_END
G1 E-.04 F1800
G1 X129.963 Y124.649 Z44.2 F30000
G1 X135.38 Y126.715 Z44.2
G1 Z43.8
G1 E.8 F1800
M204 S5000
G1 F2073
G1 X135.372 Y126.715 E.00026
G3 X129.6 Y133.24 I-7.382 J-.714 E.2861
G3 X128.595 Y118.618 I-1.599 J-7.236 E.78319
G1 X128.894 Y118.639 E.0092
G3 X135.406 Y126 I-.904 J7.361 E.3301
G1 X135.382 Y126.655 E.02014
M204 S10000
G1 X134.966 Y126.632 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.4804
G1 F2073
G1 X134.955 Y126.732 E.00357
G3 X121.01 Y125.639 I-6.958 J-.726 E.77069
G1 X121.012 Y125.616 E.00083
G3 X122.164 Y122.142 I7.277 J.486 E.13188
G3 X134.993 Y126 I5.833 J3.864 E.6374
G1 X134.968 Y126.572 E.02043
; CHANGE_LAYER
; Z_HEIGHT: 44
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F14400.657
G1 X134.955 Y126.732 E-.06078
G1 X134.842 Y127.468 E-.28297
G1 X134.646 Y128.187 E-.28304
G1 X134.524 Y128.515 E-.13321
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 220/250
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L220
M991 S0 P219 ;notify layer change
G17
G3 Z44.2 I.44 J-1.135 P1  F30000
G1 X121.867 Y123.603 Z44.2
G1 Z44
G1 E.8 F1800
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2073
G1 X121.868 Y123.602 E.00005
G3 X127.126 Y119.473 I6.132 J2.396 E.21548
G1 X127.189 Y119.468 E.00194
G1 X127.825 Y119.417 E.01959
G3 X121.648 Y124.268 I.175 J6.581 E1.01246
G1 X121.848 Y123.66 E.01966
M204 S10000
; WIPE_START
G1 F12000
G1 X121.868 Y123.602 E-.02321
G1 X122.157 Y122.964 E-.26635
G1 X122.512 Y122.36 E-.26636
G1 X122.833 Y121.929 E-.20408
; WIPE_END
G1 E-.04 F1800
G1 X129.964 Y124.649 Z44.4 F30000
G1 X135.38 Y126.715 Z44.4
G1 Z44
G1 E.8 F1800
M204 S5000
G1 F2073
G1 X135.372 Y126.715 E.00026
G3 X129.6 Y133.24 I-7.382 J-.714 E.2861
M73 P90 R2
G3 X128.605 Y118.618 I-1.599 J-7.236 E.78349
G1 X128.894 Y118.639 E.00889
G3 X135.406 Y126 I-.904 J7.361 E.3301
G1 X135.382 Y126.655 E.02015
M204 S10000
G1 X134.966 Y126.633 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.4804
G1 F2073
G1 X134.955 Y126.732 E.00356
G3 X121.01 Y125.639 I-6.958 J-.726 E.7707
G1 X121.012 Y125.616 E.00083
G3 X122.164 Y122.142 I7.277 J.486 E.13188
G3 X134.993 Y126 I5.833 J3.864 E.63741
G1 X134.968 Y126.573 E.02043
; CHANGE_LAYER
; Z_HEIGHT: 44.2
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F14400.655
G1 X134.955 Y126.732 E-.06074
G1 X134.842 Y127.468 E-.28298
G1 X134.646 Y128.187 E-.28304
G1 X134.524 Y128.515 E-.13325
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 221/250
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L221
M991 S0 P220 ;notify layer change
G17
G3 Z44.4 I.44 J-1.134 P1  F30000
G1 X121.869 Y123.603 Z44.4
G1 Z44.2
G1 E.8 F1800
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2076
G3 X127.126 Y119.473 I6.13 J2.392 E.21546
G1 X127.18 Y119.469 E.00165
G1 X127.825 Y119.417 E.01989
G3 X121.848 Y123.659 I.175 J6.578 E1.03164
M204 S10000
; WIPE_START
G1 F12000
G1 X122.157 Y122.964 E-.28907
G1 X122.512 Y122.36 E-.26637
G1 X122.833 Y121.928 E-.20456
; WIPE_END
G1 E-.04 F1800
G1 X129.964 Y124.649 Z44.6 F30000
G1 X135.38 Y126.715 Z44.6
G1 Z44.2
G1 E.8 F1800
M204 S5000
G1 F2076
G1 X135.372 Y126.715 E.00026
G3 X129.6 Y133.24 I-7.382 J-.714 E.2861
G3 X128.615 Y118.619 I-1.599 J-7.236 E.7838
G1 X128.894 Y118.639 E.00859
G3 X135.406 Y126 I-.904 J7.361 E.3301
G1 X135.382 Y126.655 E.02015
M204 S10000
G1 X134.966 Y126.633 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.480401
G1 F2076
G1 X134.955 Y126.732 E.00356
G3 X121.01 Y125.639 I-6.958 J-.726 E.7707
G1 X121.012 Y125.616 E.00083
G3 X122.164 Y122.142 I7.139 J.44 E.13194
G3 X134.993 Y126 I5.833 J3.864 E.63741
G1 X134.968 Y126.573 E.02044
; CHANGE_LAYER
; Z_HEIGHT: 44.4
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F14400.654
G1 X134.955 Y126.732 E-.06069
G1 X134.842 Y127.468 E-.28298
G1 X134.646 Y128.187 E-.28304
G1 X134.524 Y128.516 E-.13329
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 222/250
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L222
M991 S0 P221 ;notify layer change
G17
G3 Z44.6 I.441 J-1.134 P1  F30000
G1 X121.868 Y123.599 Z44.6
G1 Z44.4
G1 E.8 F1800
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2076
G1 X122.158 Y122.964 E.02143
G3 X127.126 Y119.473 I5.842 J3.032 E.19392
G1 X127.17 Y119.469 E.00136
G1 X127.825 Y119.417 E.02018
G3 X121.849 Y123.655 I.175 J6.58 E1.032
M204 S10000
; WIPE_START
G1 F12000
G1 X122.158 Y122.964 E-.28753
G1 X122.512 Y122.36 E-.26634
G1 X122.836 Y121.924 E-.20613
; WIPE_END
G1 E-.04 F1800
G1 X129.966 Y124.648 Z44.8 F30000
G1 X135.38 Y126.715 Z44.8
G1 Z44.4
G1 E.8 F1800
M204 S5000
G1 F2076
G1 X135.372 Y126.715 E.00026
G3 X129.6 Y133.24 I-7.382 J-.714 E.2861
G3 X128.625 Y118.62 I-1.599 J-7.236 E.78411
G1 X128.894 Y118.639 E.00829
G3 X135.406 Y126 I-.904 J7.361 E.3301
G1 X135.382 Y126.655 E.02015
M204 S10000
G1 X134.965 Y126.633 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.4804
G1 F2076
G1 X134.955 Y126.732 E.00355
G3 X121.01 Y125.639 I-6.958 J-.726 E.7707
G1 X121.012 Y125.616 E.00083
G3 X122.164 Y122.142 I7.14 J.44 E.13194
G3 X134.993 Y126 I5.833 J3.864 E.63741
G1 X134.968 Y126.573 E.02044
; CHANGE_LAYER
; Z_HEIGHT: 44.6
; LAYER_HEIGHT: 0.199997
; WIPE_START
G1 F14400.655
G1 X134.955 Y126.732 E-.06064
G1 X134.842 Y127.468 E-.28298
G1 X134.646 Y128.187 E-.28303
G1 X134.524 Y128.516 E-.13334
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 223/250
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L223
M991 S0 P222 ;notify layer change
G17
G3 Z44.8 I.441 J-1.134 P1  F30000
G1 X121.87 Y123.596 Z44.8
G1 Z44.6
G1 E.8 F1800
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2076
G1 X122.164 Y122.967 E.02132
G3 X127.15 Y119.471 I5.842 J3.028 E.19454
G3 X128.525 Y119.436 I.853 J6.416 E.04236
G3 X121.857 Y123.651 I-.52 J6.56 E1.01053
M204 S10000
; WIPE_START
G1 F12000
G1 X122.164 Y122.967 E-.28479
G1 X122.512 Y122.36 E-.26622
G1 X122.84 Y121.918 E-.20899
; WIPE_END
G1 E-.04 F1800
G1 X129.969 Y124.645 Z45 F30000
G1 X135.38 Y126.716 Z45
G1 Z44.6
G1 E.8 F1800
M204 S5000
G1 F2076
G1 X135.372 Y126.715 E.00026
G3 X129.6 Y133.24 I-7.382 J-.714 E.2861
G3 X128.634 Y118.62 I-1.599 J-7.236 E.7844
G1 X128.894 Y118.639 E.00799
G3 X135.406 Y126 I-.904 J7.361 E.3301
G1 X135.382 Y126.656 E.02016
M204 S10000
G1 X134.965 Y126.633 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.480464
G1 F2076
G1 X134.955 Y126.732 E.00355
G3 X121.01 Y125.639 I-6.958 J-.726 E.77081
G1 X121.012 Y125.616 E.00083
G3 X122.164 Y122.142 I7.271 J.484 E.1319
G3 X134.993 Y126 I5.833 J3.864 E.6375
G1 X134.968 Y126.573 E.02045
; CHANGE_LAYER
; Z_HEIGHT: 44.8
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F14398.555
G1 X134.955 Y126.732 E-.0606
G1 X134.842 Y127.468 E-.28298
G1 X134.646 Y128.187 E-.28304
G1 X134.524 Y128.516 E-.13339
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 224/250
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L224
M991 S0 P223 ;notify layer change
G17
G3 Z45 I.441 J-1.134 P1  F30000
G1 X121.871 Y123.593 Z45
G1 Z44.8
G1 E.8 F1800
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2081
G1 X122.162 Y122.966 E.02122
G3 X127.14 Y119.472 I5.842 J3.029 E.19429
G3 X128.525 Y119.436 I.861 J6.46 E.04265
G3 X121.855 Y123.649 I-.522 J6.56 E1.0105
M204 S10000
; WIPE_START
G1 F12000
G1 X122.162 Y122.966 E-.28443
G1 X122.512 Y122.36 E-.26626
M73 P91 R2
G1 X122.841 Y121.917 E-.20931
; WIPE_END
G1 E-.04 F1800
G1 X129.969 Y124.645 Z45.2 F30000
G1 X135.38 Y126.716 Z45.2
G1 Z44.8
G1 E.8 F1800
M204 S5000
G1 F2081
G1 X135.268 Y127.423 E.022
G3 X129.6 Y133.24 I-7.279 J-1.422 E.26411
G3 X128.644 Y118.621 I-1.599 J-7.236 E.78471
G1 X128.894 Y118.639 E.00769
G3 X135.376 Y126.664 I-.904 J7.361 E.35052
M204 S10000
G1 X134.965 Y126.641 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.480451
G1 F2081
G1 X134.955 Y126.732 E.00325
G3 X121.01 Y125.639 I-6.958 J-.726 E.77079
G1 X121.012 Y125.616 E.00083
G3 X122.164 Y122.142 I7.274 J.485 E.13189
G3 X134.993 Y126 I5.833 J3.864 E.63748
G1 X134.968 Y126.581 E.02074
; CHANGE_LAYER
; Z_HEIGHT: 45
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F14398.976
G1 X134.955 Y126.732 E-.05744
G1 X134.842 Y127.468 E-.28298
G1 X134.646 Y128.187 E-.28304
G1 X134.521 Y128.524 E-.13655
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 225/250
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L225
M991 S0 P224 ;notify layer change
G17
G3 Z45.2 I.442 J-1.134 P1  F30000
G1 X121.873 Y123.589 Z45.2
G1 Z45
G1 E.8 F1800
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2081
G1 X122.16 Y122.965 E.02109
G3 X127.131 Y119.473 I5.843 J3.032 E.19404
G1 X127.825 Y119.417 E.02139
G3 X121.854 Y123.646 I.177 J6.58 E1.03244
M204 S10000
; WIPE_START
G1 F12000
G1 X122.16 Y122.965 E-.28341
G1 X122.512 Y122.36 E-.2663
G1 X122.842 Y121.915 E-.21029
; WIPE_END
G1 E-.04 F1800
G1 X129.97 Y124.645 Z45.4 F30000
G1 X135.38 Y126.717 Z45.4
G1 Z45
G1 E.8 F1800
M204 S5000
G1 F2081
G1 X135.268 Y127.423 E.02196
G3 X129.6 Y133.24 I-7.279 J-1.422 E.26411
G3 X128.654 Y118.622 I-1.599 J-7.236 E.78502
G1 X128.894 Y118.639 E.00738
G3 X135.376 Y126.664 I-.904 J7.361 E.35052
M204 S10000
G1 X134.965 Y126.641 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.480418
G1 F2081
G1 X134.955 Y126.732 E.00325
G3 X121.01 Y125.639 I-6.958 J-.726 E.77072
G1 X121.012 Y125.616 E.00083
G3 X122.164 Y122.142 I7.276 J.486 E.13188
G3 X134.993 Y126 I5.833 J3.864 E.63743
G1 X134.968 Y126.581 E.02074
; CHANGE_LAYER
; Z_HEIGHT: 45.2
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F14400.091
G1 X134.955 Y126.732 E-.05747
G1 X134.84 Y127.473 E-.28483
G1 X134.646 Y128.187 E-.28112
G1 X134.521 Y128.524 E-.13659
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 226/250
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L226
M991 S0 P225 ;notify layer change
G17
G3 Z45.4 I.443 J-1.134 P1  F30000
G1 X121.868 Y123.581 Z45.4
G1 Z45.2
G1 E.8 F1800
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2082
G1 X122.152 Y122.956 E.02112
G3 X127.126 Y119.465 I5.845 J3.04 E.19404
G3 X128.54 Y119.43 I.873 J6.598 E.04354
G3 X121.845 Y123.637 I-.543 J6.566 E1.01135
M204 S10000
; WIPE_START
G1 F12000
G1 X122.152 Y122.956 E-.28392
G1 X122.509 Y122.352 E-.26649
G1 X122.838 Y121.909 E-.2096
; WIPE_END
G1 E-.04 F1800
G1 X129.964 Y124.642 Z45.6 F30000
G1 X135.38 Y126.718 Z45.6
G1 Z45.2
G1 E.8 F1800
M204 S5000
G1 F2082
G1 X135.268 Y127.423 E.02192
G3 X129.6 Y133.24 I-7.279 J-1.422 E.26411
G3 X128.664 Y118.623 I-1.599 J-7.236 E.78533
G1 X128.894 Y118.639 E.00708
G3 X135.376 Y126.664 I-.904 J7.361 E.35053
M204 S10000
G1 X134.968 Y126.641 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.473017
G1 F2082
G1 X134.959 Y126.74 E.00346
G3 X121.007 Y125.632 I-6.962 J-.734 E.7581
G1 X121.009 Y125.609 E.00081
G3 X122.164 Y122.136 I7.28 J.493 E.12965
G3 X134.997 Y126 I5.833 J3.87 E.62686
G1 X134.971 Y126.582 E.0204
; CHANGE_LAYER
; Z_HEIGHT: 45.4
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F14647.876
G1 X134.959 Y126.74 E-.06025
G1 X134.844 Y127.475 E-.28295
G1 X134.647 Y128.194 E-.28299
G1 X134.525 Y128.524 E-.13382
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 227/250
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L227
M991 S0 P226 ;notify layer change
G17
G3 Z45.6 I.443 J-1.133 P1  F30000
G1 X121.856 Y123.57 Z45.6
G1 Z45.4
G1 E.8 F1800
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2084
G1 X122.146 Y122.941 E.02128
G3 X127.777 Y119.398 I5.855 J3.059 E.21425
G3 X129.903 Y119.672 I.231 J6.587 E.06614
G1 X129.953 Y119.69 E.00163
G3 X121.836 Y123.626 I-1.952 J6.311 E.97024
M204 S10000
; WIPE_START
G1 F12000
G1 X122.146 Y122.941 E-.2858
G1 X122.501 Y122.336 E-.26667
G1 X122.828 Y121.898 E-.20753
; WIPE_END
G1 E-.04 F1800
G1 X129.953 Y124.635 Z45.8 F30000
G1 X135.38 Y126.719 Z45.8
G1 Z45.4
G1 E.8 F1800
M204 S5000
G1 F2084
G1 X135.268 Y127.423 E.02189
G3 X129.6 Y133.24 I-7.279 J-1.422 E.26411
G3 X128.674 Y118.623 I-1.599 J-7.236 E.78564
G1 X128.894 Y118.639 E.00678
G3 X135.376 Y126.664 I-.904 J7.361 E.35054
M204 S10000
G1 X134.978 Y126.644 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.458088
G1 F2084
G1 X134.972 Y126.676 E.00111
G3 X121.001 Y125.617 I-6.975 J-.67 E.73522
G1 X121.002 Y125.595 E.00076
G3 X121.785 Y122.765 I7.021 J.418 E.10007
G3 X135.004 Y126.012 I6.212 J3.242 E.6309
G1 X134.98 Y126.584 E.01937
; CHANGE_LAYER
; Z_HEIGHT: 45.6
; LAYER_HEIGHT: 0.199997
; WIPE_START
G1 F15000
G1 X134.972 Y126.676 E-.03521
G1 X134.877 Y127.346 E-.25726
G1 X134.714 Y128.004 E-.25729
G1 X134.53 Y128.525 E-.21024
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 228/250
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L228
M991 S0 P227 ;notify layer change
G17
G3 Z45.8 I.444 J-1.133 P1  F30000
G1 X121.845 Y123.558 Z45.8
G1 Z45.6
G1 E.8 F1800
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2086
G1 X122.142 Y122.928 E.02141
G3 X127.744 Y119.386 I5.863 J3.072 E.2133
G3 X131.795 Y120.573 I.252 J6.647 E.13199
M73 P92 R2
G3 X121.833 Y123.611 I-3.789 J5.427 E.90962
M204 S10000
; WIPE_START
G1 F12000
G1 X122.142 Y122.928 E-.28483
G1 X122.494 Y122.32 E-.2668
G1 X122.822 Y121.881 E-.20837
; WIPE_END
G1 E-.04 F1800
G1 X129.944 Y124.626 Z46 F30000
G1 X135.379 Y126.72 Z46
G1 Z45.6
G1 E.8 F1800
M204 S5000
G1 F2086
G1 X135.268 Y127.423 E.02186
G3 X129.6 Y133.24 I-7.279 J-1.422 E.26411
G3 X128.683 Y118.624 I-1.599 J-7.236 E.78596
G1 X128.894 Y118.639 E.00648
G3 X135.376 Y126.665 I-.904 J7.361 E.35055
M204 S10000
G1 X134.986 Y126.646 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.44283
G1 F2086
G1 X134.977 Y126.677 E.00105
G3 X120.997 Y126.428 I-6.98 J-.679 E.68178
G1 X120.99 Y125.674 E.02457
G1 X120.996 Y125.583 E.00297
G3 X135.01 Y126 I7.001 J.415 E.70454
G1 X134.989 Y126.586 E.0191
; CHANGE_LAYER
; Z_HEIGHT: 45.8
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F15000
G1 X134.977 Y126.677 E-.03482
G1 X134.886 Y127.348 E-.25752
G1 X134.722 Y128.006 E-.2576
G1 X134.538 Y128.527 E-.21005
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 229/250
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L229
M991 S0 P228 ;notify layer change
G17
G3 Z46 I.444 J-1.133 P1  F30000
G1 X121.834 Y123.545 Z46
G1 Z45.8
G1 E.8 F1800
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2086
G1 X121.843 Y123.548 E.00029
G3 X127.716 Y119.373 I6.164 J2.453 E.23408
G3 X131.799 Y120.557 I.28 J6.665 E.13295
G3 X121.618 Y124.213 I-3.792 J5.444 E.89222
G1 X121.815 Y123.602 E.01971
M204 S10000
; WIPE_START
G1 F12000
G1 X121.843 Y123.548 E-.02316
G1 X122.08 Y123.003 E-.22572
G1 X122.488 Y122.303 E-.3082
G1 X122.809 Y121.875 E-.20291
; WIPE_END
G1 E-.04 F1800
G1 X129.93 Y124.621 Z46.2 F30000
G1 X135.379 Y126.721 Z46.2
G1 Z45.8
G1 E.8 F1800
M204 S5000
G1 F2086
G1 X135.268 Y127.423 E.02183
G3 X129.6 Y133.24 I-7.279 J-1.422 E.26411
G3 X128.693 Y118.625 I-1.599 J-7.237 E.78627
G1 X128.894 Y118.639 E.00618
G3 X135.376 Y126.665 I-.904 J7.361 E.35056
M204 S10000
G1 X134.986 Y126.641 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.42753
G1 F2086
G1 X134.974 Y126.812 E.00535
G3 X120.982 Y126.312 I-6.976 J-.806 E.65651
G1 X120.982 Y125.688 E.01957
G3 X121.204 Y124.229 I6.921 J.305 E.04633
G1 X121.375 Y123.669 E.01836
G3 X135.021 Y126 I6.623 J2.336 E.61664
M73 P92 R1
G1 X134.989 Y126.581 E.01824
; CHANGE_LAYER
; Z_HEIGHT: 46
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F15000
G1 X134.974 Y126.812 E-.08767
G1 X134.881 Y127.409 E-.22969
G1 X134.73 Y128.008 E-.23496
G1 X134.548 Y128.524 E-.20768
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 230/250
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L230
M991 S0 P229 ;notify layer change
G17
G3 Z46.2 I.444 J-1.133 P1  F30000
G1 X121.823 Y123.532 Z46.2
G1 Z46
G1 E.8 F1800
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2088
G1 X121.835 Y123.533 E.00036
G3 X127.688 Y119.36 I6.174 J2.467 E.23339
G3 X131.803 Y120.542 I.287 J6.757 E.13385
G3 X121.609 Y124.198 I-3.795 J5.459 E.8947
G1 X121.805 Y123.59 E.01965
M204 S10000
; WIPE_START
G1 F12000
G1 X121.835 Y123.533 E-.02418
G1 X122.058 Y123.013 E-.2154
G1 X122.48 Y122.287 E-.31899
G1 X122.799 Y121.863 E-.20144
; WIPE_END
G1 E-.04 F1800
G1 X129.919 Y124.613 Z46.4 F30000
G1 X135.379 Y126.722 Z46.4
G1 Z46
G1 E.8 F1800
M204 S5000
G1 F2088
G1 X135.268 Y127.423 E.02182
G3 X129.6 Y133.24 I-7.279 J-1.422 E.26411
G3 X128.703 Y118.625 I-1.599 J-7.237 E.78658
G1 X128.894 Y118.639 E.00588
G3 X135.376 Y126.665 I-.904 J7.361 E.35057
M204 S10000
G1 X134.993 Y126.642 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.412353
G1 F2088
G1 X134.982 Y126.825 E.00553
G3 X120.975 Y126.298 I-6.983 J-.821 E.63133
G1 X120.975 Y125.702 E.01795
G3 X121.192 Y124.242 I6.867 J.279 E.0445
G1 X121.368 Y123.667 E.01813
G3 X135.031 Y126 I6.631 J2.337 E.59311
G1 X134.996 Y126.582 E.01754
; CHANGE_LAYER
; Z_HEIGHT: 46.2
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F15000
G1 X134.982 Y126.825 E-.09264
G1 X134.892 Y127.395 E-.21941
G1 X134.737 Y128.01 E-.24103
G1 X134.556 Y128.524 E-.20693
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 231/250
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L231
M991 S0 P230 ;notify layer change
G17
G3 Z46.4 I.445 J-1.133 P1  F30000
G1 X121.812 Y123.519 Z46.4
G1 Z46.2
G1 E.8 F1800
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2090
G1 X121.823 Y123.517 E.00031
G3 X127.661 Y119.347 I6.181 J2.481 E.2328
G3 X131.806 Y120.525 I.319 J6.76 E.13476
G1 X131.937 Y120.624 E.00506
G3 X121.595 Y124.183 I-3.934 J5.375 E.89165
G1 X121.794 Y123.576 E.01962
M204 S10000
; WIPE_START
G1 F12000
G1 X121.823 Y123.517 E-.02478
G1 X122.037 Y123.022 E-.20511
G1 X122.473 Y122.272 E-.32977
G1 X122.79 Y121.851 E-.20034
; WIPE_END
G1 E-.04 F1800
G1 X129.908 Y124.605 Z46.6 F30000
G1 X135.379 Y126.722 Z46.6
G1 Z46.2
G1 E.8 F1800
M204 S5000
G1 F2090
G1 X135.268 Y127.423 E.02181
G3 X129.6 Y133.24 I-7.279 J-1.422 E.26411
G3 X128.713 Y118.626 I-1.599 J-7.237 E.7869
G1 X128.894 Y118.639 E.00557
G3 X135.376 Y126.665 I-.904 J7.361 E.35058
M204 S10000
G1 X135.009 Y126.648 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.397202
M73 P93 R1
G1 F2090
G1 X135 Y126.679 E.00093
G3 X120.967 Y126.284 I-7.003 J-.679 E.61031
G1 X120.967 Y125.716 E.01641
G3 X120.977 Y125.542 I1.806 J.019 E.00504
G1 X121.034 Y124.983 E.01621
G1 X121.166 Y124.316 E.01964
G3 X135.033 Y126 I6.831 J1.685 E.58904
G1 X135.011 Y126.588 E.01698
; CHANGE_LAYER
; Z_HEIGHT: 46.4
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F15000
G1 X135 Y126.679 E-.03481
G1 X134.908 Y127.352 E-.25838
G1 X134.744 Y128.013 E-.25845
G1 X134.562 Y128.53 E-.20836
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 232/250
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L232
M991 S0 P231 ;notify layer change
G17
G3 Z46.6 I.446 J-1.132 P1  F30000
G1 X121.802 Y123.505 Z46.6
G1 Z46.4
G1 E.8 F1800
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2092
G1 X121.813 Y123.502 E.00034
G3 X127.633 Y119.334 I6.191 J2.497 E.23214
G3 X131.81 Y120.51 I.35 J6.765 E.13573
G1 X131.964 Y120.625 E.00591
G3 X121.585 Y124.168 I-3.96 J5.374 E.89333
G1 X121.783 Y123.562 E.0196
M204 S10000
; WIPE_START
G1 F12000
G1 X121.813 Y123.502 E-.02521
G1 X122.016 Y123.032 E-.19481
G1 X122.465 Y122.256 E-.34055
G1 X122.782 Y121.837 E-.19943
; WIPE_END
G1 E-.04 F1800
G1 X129.898 Y124.597 Z46.8 F30000
G1 X135.379 Y126.722 Z46.8
G1 Z46.4
G1 E.8 F1800
M204 S5000
G1 F2092
G1 X135.268 Y127.423 E.0218
G3 X129.6 Y133.24 I-7.279 J-1.422 E.26411
G3 X128.723 Y118.627 I-1.599 J-7.237 E.78721
G1 X128.894 Y118.639 E.00527
G3 X135.376 Y126.666 I-.904 J7.361 E.35058
M204 S10000
G1 X135.016 Y126.648 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.382078
G1 F2092
G1 X135.008 Y126.68 E.00089
G3 X120.959 Y126.27 I-7.011 J-.681 E.58517
G1 X120.959 Y125.73 E.01494
G3 X120.971 Y125.528 I2.094 J.019 E.00559
G1 X121.027 Y124.982 E.01517
G1 X121.158 Y124.314 E.01882
G3 X135.041 Y126 I6.839 J1.684 E.5646
G1 X135.018 Y126.588 E.01627
; CHANGE_LAYER
; Z_HEIGHT: 46.6
; LAYER_HEIGHT: 0.199997
; WIPE_START
G1 F15000
G1 X135.008 Y126.68 E-.03491
G1 X134.916 Y127.354 E-.25866
G1 X134.752 Y128.015 E-.25873
G1 X134.57 Y128.53 E-.2077
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 233/250
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L233
M991 S0 P232 ;notify layer change
G17
G3 Z46.8 I.447 J-1.132 P1  F30000
G1 X121.792 Y123.49 Z46.8
G1 Z46.6
G1 E.8 F1800
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2095
G1 X121.801 Y123.486 E.00029
G3 X127.605 Y119.321 I6.202 J2.517 E.23153
G3 X132.533 Y121.076 I.382 J6.727 E.16509
G3 X121.571 Y124.152 I-4.53 J4.927 E.87387
G1 X121.773 Y123.547 E.01961
M204 S10000
; WIPE_START
G1 F12000
G1 X121.801 Y123.486 E-.02537
G1 X122.093 Y122.845 E-.26792
G1 X122.458 Y122.241 E-.26806
G1 X122.748 Y121.851 E-.18461
G1 X122.77 Y121.822 E-.01404
; WIPE_END
G1 E-.04 F1800
G1 X129.885 Y124.587 Z47 F30000
G1 X135.379 Y126.722 Z47
G1 Z46.6
G1 E.8 F1800
M204 S5000
G1 F2095
G1 X135.268 Y127.423 E.0218
G3 X129.6 Y133.24 I-7.279 J-1.422 E.26411
G3 X128.732 Y118.628 I-1.599 J-7.237 E.78753
G1 X128.894 Y118.639 E.00497
G3 X135.376 Y126.666 I-.904 J7.361 E.35058
M204 S10000
G1 X135.021 Y126.627 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.366963
G1 F2095
G3 X120.951 Y126.256 I-7.023 J-.62 E.5619
G1 X120.951 Y125.744 E.01353
G3 X121.055 Y124.777 I9.035 J.48 E.02568
G3 X135.026 Y126.567 I6.943 J1.229 E.56706
; CHANGE_LAYER
; Z_HEIGHT: 46.8
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F15000
G1 X134.923 Y127.355 E-.30221
G1 X134.759 Y128.017 E-.25901
G1 X134.585 Y128.51 E-.19878
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 234/250
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L234
M991 S0 P233 ;notify layer change
G17
G3 Z47 I.445 J-1.133 P1  F30000
G1 X121.782 Y123.475 Z47
G1 Z46.8
G1 E.8 F1800
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2098
G1 X121.794 Y123.472 E.00037
G3 X127.577 Y119.309 I6.21 J2.528 E.23084
G3 X132.559 Y121.079 I.412 J6.735 E.16694
G3 X121.563 Y124.138 I-4.555 J4.921 E.875
G1 X121.763 Y123.532 E.01963
M204 S10000
; WIPE_START
G1 F12000
G1 X121.794 Y123.472 E-.02544
G1 X122.085 Y122.829 E-.26812
G1 X122.45 Y122.225 E-.2683
G1 X122.724 Y121.857 E-.1743
G1 X122.763 Y121.808 E-.02384
; WIPE_END
G1 E-.04 F1800
G1 X129.875 Y124.578 Z47.2 F30000
G1 X135.379 Y126.722 Z47.2
G1 Z46.8
G1 E.8 F1800
M204 S5000
G1 F2098
G1 X135.268 Y127.423 E.02181
G3 X129.6 Y133.24 I-7.279 J-1.422 E.26411
G3 X128.742 Y118.628 I-1.6 J-7.237 E.78785
G1 X128.894 Y118.639 E.00467
G3 X135.376 Y126.665 I-.904 J7.361 E.35058
M204 S10000
G1 X135.034 Y126.618 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.351861
G1 F2098
G1 X134.926 Y127.356 E.01878
G3 X120.944 Y126.242 I-6.928 J-1.35 E.51807
G1 X120.944 Y125.758 E.0122
G3 X121.05 Y124.764 I8.656 J.422 E.02518
G3 X135.034 Y126.559 I6.948 J1.242 E.54072
; CHANGE_LAYER
; Z_HEIGHT: 47
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F15000
G1 X134.926 Y127.356 E-.30557
G1 X134.767 Y128.019 E-.2592
G1 X134.596 Y128.504 E-.19523
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 235/250
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L235
M991 S0 P234 ;notify layer change
G17
G3 Z47.2 I.446 J-1.132 P1  F30000
G1 X121.772 Y123.459 Z47.2
G1 Z47
G1 E.8 F1800
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2100
G1 X121.782 Y123.456 E.0003
G3 X127.549 Y119.296 I6.222 J2.547 E.23024
G3 X133.075 Y121.591 I.461 J6.692 E.19058
G3 X121.549 Y124.122 I-5.072 J4.413 E.85546
G1 X121.753 Y123.516 E.01966
M204 S10000
; WIPE_START
G1 F12000
G1 X121.782 Y123.456 E-.02523
G1 X122.076 Y122.814 E-.26841
G1 X122.443 Y122.21 E-.26855
G1 X122.7 Y121.863 E-.16399
G1 X122.755 Y121.794 E-.03383
; WIPE_END
G1 E-.04 F1800
M73 P94 R1
G1 X129.865 Y124.569 Z47.4 F30000
G1 X135.379 Y126.722 Z47.4
G1 Z47
G1 E.8 F1800
M204 S5000
G1 F2100
G1 X135.268 Y127.423 E.02182
G3 X129.6 Y133.24 I-7.279 J-1.422 E.26411
G3 X128.752 Y118.629 I-1.6 J-7.237 E.78816
G1 X128.894 Y118.639 E.00437
G3 X135.376 Y126.665 I-.904 J7.361 E.35057
M204 S10000
G1 X135.04 Y126.619 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.336812
G1 F2100
G1 X134.933 Y127.357 E.01787
G3 X120.936 Y126.228 I-6.935 J-1.352 E.49366
G1 X120.936 Y125.772 E.01094
G3 X121.045 Y124.75 I8.355 J.374 E.02462
G3 X135.042 Y126.559 I6.953 J1.255 E.51464
; CHANGE_LAYER
; Z_HEIGHT: 47.2
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F15000
G1 X134.933 Y127.357 E-.30617
G1 X134.774 Y128.021 E-.25948
G1 X134.604 Y128.504 E-.19435
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 236/250
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L236
M991 S0 P235 ;notify layer change
G17
G3 Z47.4 I.446 J-1.132 P1  F30000
G1 X121.763 Y123.443 Z47.4
G1 Z47.2
G1 E.8 F1800
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2102
G1 X121.772 Y123.441 E.00029
G3 X127.521 Y119.283 I6.231 J2.563 E.2296
G3 X133.1 Y121.596 I.488 J6.707 E.19244
G3 X121.538 Y124.107 I-5.096 J4.407 E.85709
G1 X121.743 Y123.5 E.01971
M204 S10000
; WIPE_START
G1 F12000
G1 X121.772 Y123.441 E-.02494
G1 X122.067 Y122.798 E-.26865
G1 X122.435 Y122.194 E-.2688
G1 X122.676 Y121.87 E-.15367
G1 X122.748 Y121.779 E-.04394
; WIPE_END
G1 E-.04 F1800
G1 X129.856 Y124.56 Z47.6 F30000
G1 X135.379 Y126.721 Z47.6
G1 Z47.2
G1 E.8 F1800
M204 S5000
G1 F2102
G1 X135.268 Y127.423 E.02183
G3 X129.6 Y133.24 I-7.279 J-1.422 E.26411
G3 X128.762 Y118.63 I-1.6 J-7.237 E.78848
G1 X128.894 Y118.639 E.00406
G3 X135.376 Y126.665 I-.904 J7.361 E.35056
M204 S10000
G1 X135.046 Y126.62 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.321779
G1 F2102
G1 X134.941 Y127.359 E.01696
G3 X120.928 Y126.214 I-6.942 J-1.354 E.4692
G1 X120.928 Y125.786 E.00974
G3 X121.04 Y124.737 I8.113 J.332 E.02399
G3 X135.05 Y126.56 I6.958 J1.268 E.48859
; CHANGE_LAYER
; Z_HEIGHT: 47.4
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F15000
G1 X134.941 Y127.359 E-.30636
G1 X134.781 Y128.024 E-.25976
G1 X134.611 Y128.505 E-.19388
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 237/250
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L237
M991 S0 P236 ;notify layer change
G17
G3 Z47.6 I.447 J-1.132 P1  F30000
G1 X121.753 Y123.427 Z47.6
G1 Z47.4
G1 E.8 F1800
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2105
G1 X121.763 Y123.426 E.00031
G3 X127.493 Y119.27 I6.241 J2.576 E.22895
G3 X133.124 Y121.602 I.51 J6.732 E.19428
G3 X121.528 Y124.093 I-5.12 J4.401 E.85852
G1 X121.734 Y123.484 E.01976
M204 S10000
; WIPE_START
G1 F12000
G1 X121.763 Y123.426 E-.02458
G1 X122.058 Y122.783 E-.26888
G1 X122.428 Y122.179 E-.26905
G1 X122.653 Y121.876 E-.14336
G1 X122.741 Y121.764 E-.05414
; WIPE_END
G1 E-.04 F1800
G1 X129.847 Y124.551 Z47.8 F30000
G1 X135.379 Y126.721 Z47.8
G1 Z47.4
G1 E.8 F1800
M204 S5000
G1 F2105
G1 X135.268 Y127.423 E.02185
G3 X129.6 Y133.24 I-7.279 J-1.422 E.26411
G3 X128.772 Y118.63 I-1.6 J-7.238 E.7888
G1 X128.894 Y118.639 E.00376
G3 X135.376 Y126.665 I-.904 J7.361 E.35055
M204 S10000
G1 X135.053 Y126.649 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.306723
G1 F2105
G1 X135.046 Y126.683 E.00075
G3 X120.921 Y126.2 I-7.048 J-.679 E.45933
G1 X120.921 Y125.8 E.00862
G3 X121.035 Y124.723 I7.917 J.295 E.02329
G3 X135.079 Y126 I6.964 J1.281 E.4504
G1 X135.055 Y126.589 E.01268
; CHANGE_LAYER
; Z_HEIGHT: 47.6
; LAYER_HEIGHT: 0.199997
; WIPE_START
G1 F15000
G1 X135.046 Y126.683 E-.0359
G1 X134.952 Y127.361 E-.26004
G1 X134.789 Y128.026 E-.26011
G1 X134.61 Y128.532 E-.20394
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 238/250
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L238
M991 S0 P237 ;notify layer change
G17
G3 Z47.8 I.45 J-1.131 P1  F30000
G1 X121.744 Y123.41 Z47.8
G1 Z47.6
G1 E.8 F1800
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2106
G1 X121.746 Y123.408 E.00011
G3 X127.116 Y119.285 I6.254 J2.587 E.21784
G1 X127.465 Y119.257 E.01077
G3 X131.231 Y120.048 I.523 J6.872 E.11982
G3 X121.618 Y123.743 I-3.23 J5.947 E.9471
G1 X121.722 Y123.466 E.00908
M204 S10000
; WIPE_START
G1 F12000
G1 X121.746 Y123.408 E-.02404
G1 X122.05 Y122.768 E-.26926
G1 X122.42 Y122.163 E-.26929
G1 X122.736 Y121.751 E-.19741
; WIPE_END
G1 E-.04 F1800
G1 X129.84 Y124.543 Z48 F30000
G1 X135.38 Y126.72 Z48
G1 Z47.6
G1 E.8 F1800
M204 S5000
G1 F2106
G1 X135.268 Y127.423 E.02187
G3 X129.6 Y133.24 I-7.279 J-1.422 E.26411
G3 X128.781 Y118.631 I-1.6 J-7.238 E.78912
G1 X128.894 Y118.639 E.00346
G3 X135.376 Y126.664 I-.904 J7.361 E.35054
M204 S10000
G1 X135.06 Y126.649 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.29172
G1 F2106
G1 X135.054 Y126.684 E.00072
G3 X120.913 Y126.186 I-7.055 J-.681 E.43393
G1 X120.913 Y125.814 E.00756
G3 X121.03 Y124.71 I7.757 J.262 E.02252
G3 X135.087 Y126 I6.969 J1.294 E.42501
G1 X135.062 Y126.589 E.01196
; CHANGE_LAYER
; Z_HEIGHT: 47.8
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F15000
G1 X135.054 Y126.684 E-.03615
G1 X134.959 Y127.362 E-.26032
G1 X134.796 Y128.028 E-.26038
G1 X134.618 Y128.532 E-.20315
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 239/250
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L239
M991 S0 P238 ;notify layer change
G17
G3 Z48 I.451 J-1.13 P1  F30000
G1 X121.734 Y123.394 Z48
G1 Z47.8
G1 E.8 F1800
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2108
G1 X121.736 Y123.393 E.00008
G3 X127.115 Y119.27 I6.264 J2.603 E.21804
M73 P95 R1
G1 X127.437 Y119.244 E.00993
G3 X131.234 Y120.033 I.551 J6.884 E.12077
G3 X121.499 Y124.061 I-3.234 J5.963 E.9389
G1 X121.714 Y123.45 E.01988
M204 S10000
; WIPE_START
G1 F12000
G1 X121.736 Y123.393 E-.02355
G1 X122.041 Y122.752 E-.26951
G1 X122.412 Y122.148 E-.26954
G1 X122.729 Y121.736 E-.19741
; WIPE_END
G1 E-.04 F1800
G1 X129.83 Y124.533 Z48.2 F30000
G1 X135.38 Y126.719 Z48.2
G1 Z47.8
G1 E.8 F1800
M204 S5000
G1 F2108
G1 X135.268 Y127.423 E.02189
G3 X129.6 Y133.24 I-7.279 J-1.422 E.26411
G3 X128.791 Y118.632 I-1.6 J-7.238 E.78944
G1 X128.894 Y118.639 E.00316
G3 X135.376 Y126.664 I-.904 J7.361 E.35054
M204 S10000
G1 X135.067 Y126.649 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.276733
G1 F2108
G1 X135.062 Y126.685 E.00068
G3 X120.905 Y126.172 I-7.063 J-.682 E.40847
G1 X120.905 Y125.828 E.00657
G3 X121.025 Y124.696 I7.627 J.232 E.0217
G3 X135.095 Y126 I6.974 J1.307 E.39962
G1 X135.07 Y126.589 E.01124
; CHANGE_LAYER
; Z_HEIGHT: 48
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F15000
G1 X135.062 Y126.685 E-.0364
G1 X134.967 Y127.364 E-.26059
G1 X134.803 Y128.03 E-.26065
G1 X134.626 Y128.532 E-.20235
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 240/250
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L240
M991 S0 P239 ;notify layer change
G17
G3 Z48.2 I.452 J-1.13 P1  F30000
G1 X121.725 Y123.377 Z48.2
G1 Z48
G1 E.8 F1800
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2110
G1 X121.726 Y123.377 E.00004
G3 X127.114 Y119.255 I6.274 J2.618 E.21825
G1 X127.41 Y119.232 E.0091
G1 X127.823 Y119.2 E.01273
G3 X121.487 Y124.046 I.177 J6.796 E1.05057
G1 X121.705 Y123.434 E.01995
M204 S10000
; WIPE_START
G1 F12000
G1 X121.726 Y123.377 E-.02302
G1 X122.032 Y122.737 E-.26976
G1 X122.405 Y122.132 E-.26979
G1 X122.722 Y121.721 E-.19742
; WIPE_END
G1 E-.04 F1800
G1 X129.821 Y124.524 Z48.4 F30000
G1 X135.38 Y126.718 Z48.4
G1 Z48
G1 E.8 F1800
M204 S5000
G1 F2110
G1 X135.268 Y127.423 E.02192
G3 X129.6 Y133.24 I-7.279 J-1.422 E.26411
G3 X128.801 Y118.633 I-1.6 J-7.238 E.78976
G1 X128.894 Y118.639 E.00286
G3 X135.376 Y126.664 I-.904 J7.361 E.35053
M204 S10000
G1 X135.075 Y126.649 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.261801
G1 F2110
G1 X135.069 Y126.685 E.00065
G3 X120.898 Y126.159 I-7.07 J-.683 E.38303
G1 X120.898 Y125.841 E.00565
G3 X121.02 Y124.683 I7.521 J.206 E.0208
G3 X135.102 Y126 I6.979 J1.32 E.3743
G1 X135.077 Y126.589 E.01052
; CHANGE_LAYER
; Z_HEIGHT: 48.2
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F15000
G1 X135.069 Y126.685 E-.03664
G1 X134.974 Y127.365 E-.26087
G1 X134.81 Y128.032 E-.26092
G1 X134.634 Y128.533 E-.20157
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 241/250
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L241
M991 S0 P240 ;notify layer change
G17
G3 Z48.4 I.452 J-1.13 P1  F30000
G1 X121.716 Y123.362 Z48.4
G1 Z48.2
G1 E.8 F1800
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2116
G3 X127.114 Y119.24 I6.284 J2.633 E.21845
G1 X127.382 Y119.219 E.00826
G1 X127.822 Y119.185 E.01358
G3 X121.693 Y123.417 I.177 J6.811 E1.07323
M204 S10000
; WIPE_START
G1 F12000
G1 X122.024 Y122.721 E-.29276
G1 X122.397 Y122.117 E-.27004
G1 X122.715 Y121.706 E-.19719
; WIPE_END
G1 E-.04 F1800
G1 X129.812 Y124.514 Z48.6 F30000
G1 X135.38 Y126.717 Z48.6
G1 Z48.2
G1 E.8 F1800
M204 S5000
G1 F2116
G1 X135.268 Y127.423 E.02195
G3 X129.6 Y133.24 I-7.279 J-1.422 E.26411
G3 X128.811 Y118.633 I-1.6 J-7.238 E.79009
G1 X128.894 Y118.639 E.00256
G3 X135.376 Y126.664 I-.904 J7.361 E.35052
M204 S10000
G1 X135.082 Y126.649 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.246845
G1 F2116
G1 X135.077 Y126.686 E.00062
G3 X120.89 Y126.145 I-7.078 J-.684 E.35745
G1 X120.89 Y125.855 E.0048
G3 X121.015 Y124.669 I7.435 J.181 E.01984
G3 X135.11 Y126 I6.985 J1.333 E.3489
G1 X135.084 Y126.59 E.00981
; CHANGE_LAYER
; Z_HEIGHT: 48.4
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F15000
G1 X135.077 Y126.686 E-.03685
G1 X134.981 Y127.367 E-.26114
G1 X134.817 Y128.034 E-.26119
G1 X134.642 Y128.533 E-.20082
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 242/250
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L242
M991 S0 P241 ;notify layer change
G17
G3 Z48.6 I.453 J-1.13 P1  F30000
G1 X121.706 Y123.345 Z48.6
G1 Z48.4
G1 E.8 F1800
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2118
G1 X122.016 Y122.706 E.0218
G3 X127.113 Y119.225 I5.984 J3.289 E.19679
G1 X127.354 Y119.206 E.00743
G1 X127.822 Y119.17 E.01443
G3 X121.684 Y123.4 I.178 J6.826 E1.07597
M204 S10000
; WIPE_START
G1 F12000
G1 X122.016 Y122.706 E-.29214
G1 X122.39 Y122.101 E-.27027
G1 X122.708 Y121.69 E-.19759
; WIPE_END
G1 E-.04 F1800
G1 X129.803 Y124.504 Z48.8 F30000
G1 X135.38 Y126.717 Z48.8
G1 Z48.4
G1 E.8 F1800
M204 S5000
G1 F2118
G1 X135.268 Y127.423 E.02198
G3 X129.6 Y133.24 I-7.279 J-1.422 E.26411
G3 X128.821 Y118.634 I-1.6 J-7.238 E.79041
G1 X128.894 Y118.639 E.00225
G3 X135.376 Y126.664 I-.904 J7.361 E.35052
M204 S10000
G1 X135.089 Y126.65 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.231904
G1 F2118
G1 X135.086 Y126.687 E.00058
G3 X120.882 Y126.131 I-7.086 J-.686 E.33184
G1 X120.882 Y125.869 E.00402
G3 X121.009 Y124.656 I7.365 J.158 E.01882
G3 X135.119 Y126 I6.99 J1.346 E.32353
G1 X135.092 Y126.59 E.00909
; CHANGE_LAYER
; Z_HEIGHT: 48.6
; LAYER_HEIGHT: 0.199997
; WIPE_START
G1 F15000
G1 X135.086 Y126.687 E-.03704
G1 X134.988 Y127.368 E-.26144
G1 X134.824 Y128.036 E-.26146
G1 X134.649 Y128.533 E-.20007
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 243/250
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L243
M991 S0 P242 ;notify layer change
G17
G3 Z48.8 I.454 J-1.129 P1  F30000
G1 X121.696 Y123.328 Z48.8
G1 Z48.6
G1 E.8 F1800
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2120
G1 X122.007 Y122.691 E.02179
G3 X127.112 Y119.21 I5.993 J3.304 E.19698
M73 P96 R1
G1 X127.326 Y119.193 E.00659
G1 X127.822 Y119.155 E.01529
G3 X121.675 Y123.384 I.178 J6.841 E1.07867
M204 S10000
; WIPE_START
G1 F12000
G1 X122.007 Y122.691 E-.29207
G1 X122.382 Y122.086 E-.27052
G1 X122.701 Y121.676 E-.19741
; WIPE_END
G1 E-.04 F1800
G1 X129.793 Y124.496 Z49 F30000
G1 X135.372 Y126.715 Z49
G1 Z48.6
G1 E.8 F1800
M204 S5000
G1 F2120
G3 X129.6 Y133.24 I-7.382 J-.714 E.2861
G3 X128.83 Y118.635 I-1.6 J-7.239 E.79073
G1 X128.894 Y118.639 E.00195
G3 X135.377 Y126.655 I-.904 J7.361 E.35026
M204 S10000
G1 X135.097 Y126.642 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.217015
G1 F2120
G1 X135.092 Y126.688 E.00066
G3 X120.875 Y126.117 I-7.093 J-.687 E.30619
G1 X120.875 Y125.883 E.00331
G3 X121.004 Y124.642 I7.31 J.137 E.01773
G3 X135.125 Y126 I6.995 J1.359 E.29818
G1 X135.1 Y126.582 E.00826
; CHANGE_LAYER
; Z_HEIGHT: 48.8
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F15000
M73 P96 R0
G1 X135.092 Y126.688 E-.04041
G1 X134.995 Y127.37 E-.26169
G1 X134.831 Y128.038 E-.26173
G1 X134.66 Y128.525 E-.19617
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 244/250
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L244
M991 S0 P243 ;notify layer change
G17
G3 Z49 I.454 J-1.129 P1  F30000
G1 X121.687 Y123.312 Z49
G1 Z48.8
G1 E.8 F1800
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2122
G1 X121.999 Y122.676 E.02179
G3 X127.111 Y119.195 I6.001 J3.32 E.19716
G1 X127.298 Y119.18 E.00576
G1 X127.822 Y119.14 E.01614
G3 X121.665 Y123.368 I.178 J6.856 E1.08137
M204 S10000
; WIPE_START
G1 F12000
G1 X121.999 Y122.676 E-.29206
G1 X122.375 Y122.07 E-.27077
G1 X122.693 Y121.661 E-.19716
; WIPE_END
G1 E-.04 F1800
G1 X129.783 Y124.487 Z49.2 F30000
G1 X135.372 Y126.715 Z49.2
G1 Z48.8
G1 E.8 F1800
M204 S5000
G1 F2122
G3 X129.6 Y133.24 I-7.382 J-.714 E.2861
G3 X128.84 Y118.635 I-1.6 J-7.239 E.79106
G1 X128.894 Y118.639 E.00165
G3 X135.377 Y126.655 I-.904 J7.361 E.35026
M204 S10000
G1 X135.104 Y126.642 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.202139
G1 F2122
G1 X135.1 Y126.688 E.00061
G3 X120.867 Y126.103 I-7.1 J-.688 E.2805
G1 X120.867 Y125.897 E.00266
G3 X120.999 Y124.629 I7.267 J.117 E.01657
G3 X135.133 Y126 I7 J1.372 E.27284
G1 X135.107 Y126.582 E.00756
; CHANGE_LAYER
; Z_HEIGHT: 49
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F15000
G1 X135.1 Y126.688 E-.04055
G1 X135.002 Y127.371 E-.26197
G1 X134.838 Y128.04 E-.262
G1 X134.667 Y128.526 E-.19548
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 245/250
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L245
M991 S0 P244 ;notify layer change
G17
G3 Z49.2 I.454 J-1.129 P1  F30000
G1 X121.677 Y123.297 Z49.2
G1 Z49
G1 E.8 F1800
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2119
G1 X121.99 Y122.66 E.02179
G3 X127.11 Y119.18 I6.01 J3.335 E.19734
G1 X127.27 Y119.167 E.00492
G1 X127.822 Y119.125 E.017
G3 X121.655 Y123.352 I.178 J6.871 E1.08405
M204 S10000
; WIPE_START
G1 F12000
G1 X121.99 Y122.66 E-.29214
G1 X122.367 Y122.055 E-.27102
G1 X122.686 Y121.647 E-.19684
; WIPE_END
G1 E-.04 F1800
G1 X129.774 Y124.477 Z49.4 F30000
G1 X135.38 Y126.715 Z49.4
G1 Z49
G1 E.8 F1800
M204 S5000
G1 F2119
G1 X135.372 Y126.715 E.00026
G3 X129.6 Y133.24 I-7.382 J-.714 E.2861
G3 X128.85 Y118.636 I-1.6 J-7.239 E.79138
G1 X128.894 Y118.639 E.00135
G3 X135.406 Y126 I-.904 J7.361 E.3301
G1 X135.382 Y126.655 E.02015
M204 S10000
G1 X135.113 Y126.638 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.187272
G1 F2119
G1 X135.107 Y126.689 E.00061
G3 X120.859 Y126.089 I-7.108 J-.688 E.25475
G1 X120.859 Y125.911 E.00209
G3 X120.889 Y125.348 I5.834 J.022 E.00663
G3 X135.135 Y126.285 I7.111 J.653 E.25954
G1 X135.116 Y126.578 E.00345
; CHANGE_LAYER
; Z_HEIGHT: 49.2
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F15000
G1 X135.107 Y126.689 E-.04238
G1 X135.01 Y127.372 E-.26224
G1 X134.845 Y128.043 E-.26227
G1 X134.676 Y128.522 E-.19312
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 246/250
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L246
M991 S0 P245 ;notify layer change
G17
G3 Z49.4 I.455 J-1.129 P1  F30000
G1 X121.667 Y123.281 Z49.4
G1 Z49.2
G1 E.8 F1800
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2122
G1 X121.981 Y122.645 E.02181
G3 X127.11 Y119.165 I6.019 J3.353 E.19753
G1 X127.242 Y119.154 E.00409
G1 X127.822 Y119.11 E.01785
G3 X121.644 Y123.337 I.178 J6.888 E1.08707
M204 S10000
; WIPE_START
G1 F12000
G1 X121.981 Y122.645 E-.29246
G1 X122.359 Y122.039 E-.27129
G1 X122.678 Y121.633 E-.19625
; WIPE_END
G1 E-.04 F1800
G1 X129.764 Y124.468 Z49.6 F30000
G1 X135.38 Y126.715 Z49.6
G1 Z49.2
G1 E.8 F1800
M204 S5000
G1 F2122
G1 X135.372 Y126.715 E.00026
G3 X129.6 Y133.24 I-7.382 J-.714 E.2861
G3 X128.86 Y118.637 I-1.6 J-7.239 E.79171
G1 X128.894 Y118.639 E.00105
G3 X135.406 Y126 I-.904 J7.361 E.3301
G1 X135.382 Y126.655 E.02015
M204 S10000
G1 X135.12 Y126.638 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.172412
G1 F2122
G1 X135.114 Y126.69 E.00055
G3 X120.852 Y126.075 I-7.115 J-.689 E.2289
G1 X120.852 Y125.925 E.00158
G3 X120.882 Y125.335 I6.121 J.022 E.00624
G3 X135.141 Y126.299 I7.117 J.666 E.23307
M73 P97 R0
G1 X135.124 Y126.578 E.00295
; CHANGE_LAYER
; Z_HEIGHT: 49.4
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F15000
G1 X135.114 Y126.69 E-.04264
G1 X135.017 Y127.374 E-.2625
G1 X134.852 Y128.045 E-.26254
G1 X134.684 Y128.522 E-.19232
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 247/250
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L247
M991 S0 P246 ;notify layer change
G17
G3 Z49.6 I.455 J-1.129 P1  F30000
G1 X121.657 Y123.266 Z49.6
G1 Z49.4
G1 E.8 F1800
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2124
G1 X121.973 Y122.63 E.02184
G3 X127.109 Y119.15 I6.027 J3.366 E.1977
G1 X127.214 Y119.142 E.00326
G1 X127.821 Y119.095 E.01871
G3 X121.635 Y123.322 I.178 J6.901 E1.0894
M204 S10000
; WIPE_START
G1 F12000
G1 X121.973 Y122.63 E-.29267
G1 X122.352 Y122.024 E-.27153
G1 X122.67 Y121.618 E-.19581
; WIPE_END
G1 E-.04 F1800
G1 X129.754 Y124.459 Z49.8 F30000
G1 X135.38 Y126.715 Z49.8
G1 Z49.4
G1 E.8 F1800
M204 S5000
G1 F2124
G1 X135.372 Y126.715 E.00026
G3 X129.6 Y133.24 I-7.382 J-.714 E.2861
G3 X128.87 Y118.638 I-1.6 J-7.24 E.79204
G1 X128.894 Y118.639 E.00074
G3 X135.406 Y126 I-.904 J7.361 E.3301
G1 X135.382 Y126.655 E.02015
M204 S10000
G1 X135.127 Y126.638 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.157613
G1 F2124
G1 X135.123 Y126.691 E.00049
G3 X120.844 Y126.061 I-7.123 J-.69 E.20309
G1 X120.844 Y125.939 E.00114
G3 X120.876 Y125.321 I6.409 J.022 E.00579
G3 X135.149 Y126.312 I7.124 J.68 E.20667
G1 X135.131 Y126.578 E.00249
; CHANGE_LAYER
; Z_HEIGHT: 49.6
; LAYER_HEIGHT: 0.199997
; WIPE_START
G1 F15000
G1 X135.123 Y126.691 E-.04291
G1 X135.024 Y127.375 E-.26279
G1 X134.859 Y128.047 E-.26281
G1 X134.692 Y128.522 E-.19149
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 248/250
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L248
M991 S0 P247 ;notify layer change
G17
G3 Z49.8 I.456 J-1.128 P1  F30000
G1 X121.647 Y123.251 Z49.8
G1 Z49.6
G1 E.8 F1800
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2123
G1 X121.649 Y123.252 E.00007
G3 X127.108 Y119.135 I6.351 J2.743 E.21976
G1 X127.187 Y119.129 E.00242
G1 X127.821 Y119.08 E.01956
G3 X121.399 Y123.926 I.179 J6.916 E1.07181
G1 X121.626 Y123.308 E.02023
M204 S10000
; WIPE_START
G1 F12000
G1 X121.649 Y123.252 E-.02287
G1 X121.964 Y122.611 E-.2715
G1 X122.346 Y122.006 E-.2717
G1 X122.661 Y121.605 E-.19393
; WIPE_END
G1 E-.04 F1800
G1 X129.743 Y124.451 Z50 F30000
G1 X135.38 Y126.715 Z50
G1 Z49.6
G1 E.8 F1800
M204 S5000
G1 F2123
G1 X135.369 Y126.715 E.00033
G3 X127.463 Y118.605 I-7.375 J-.719 E1.03452
G3 X128.87 Y118.638 I.534 J7.27 E.0433
G3 X135.404 Y126 I-.875 J7.358 E.33083
G1 X135.382 Y126.655 E.02014
M204 S10000
G1 X135.135 Y126.638 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.142905
G1 F2123
G1 X135.13 Y126.691 E.00044
G3 X120.836 Y126.047 I-7.13 J-.691 E.17735
G1 X120.836 Y125.953 E.00076
G3 X120.87 Y125.307 I6.697 J.023 E.00527
G3 X135.156 Y126.326 I7.13 J.693 E.18037
G1 X135.139 Y126.578 E.00206
; CHANGE_LAYER
; Z_HEIGHT: 49.8
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F15000
G1 X135.13 Y126.691 E-.04317
G1 X135.031 Y127.377 E-.26307
G1 X134.866 Y128.049 E-.26308
G1 X134.699 Y128.522 E-.19068
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 249/250
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L249
M991 S0 P248 ;notify layer change
G17
G3 Z50 I.456 J-1.128 P1  F30000
G1 X121.636 Y123.238 Z50
G1 Z49.8
G1 E.8 F1800
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2126
G1 X121.638 Y123.236 E.00005
G3 X127.107 Y119.12 I6.363 J2.762 E.21998
G1 X127.159 Y119.116 E.00159
G1 X127.821 Y119.065 E.02041
G3 X121.387 Y123.907 I.179 J6.934 E1.07514
G1 X121.615 Y123.294 E.02009
M204 S10000
; WIPE_START
G1 F12000
G1 X121.638 Y123.236 E-.02342
G1 X121.955 Y122.595 E-.27193
G1 X122.338 Y121.991 E-.27195
G1 X122.652 Y121.592 E-.1927
; WIPE_END
G1 E-.04 F1800
G1 X129.733 Y124.442 Z50.2 F30000
G1 X135.38 Y126.715 Z50.2
G1 Z49.8
G1 E.8 F1800
M204 S5000
G1 F2126
G1 X135.372 Y126.715 E.00026
G3 X127.463 Y118.605 I-7.375 J-.719 E1.03446
G3 X128.879 Y118.638 I.535 J7.32 E.0436
G3 X135.407 Y126 I-.883 J7.357 E.33061
G1 X135.382 Y126.655 E.02014
M204 S10000
G1 X135.135 Y126.63 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.128126
G1 F2126
G1 X135.089 Y127.086 E.00318
G3 X120.828 Y125.981 I-7.089 J-1.087 E.14899
G1 X120.828 Y125.977 E.00003
G1 X120.837 Y125.654 E.00225
G3 X135.163 Y126.346 I7.163 J.346 E.15644
G1 X135.141 Y126.571 E.00157
; CHANGE_LAYER
; Z_HEIGHT: 50
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F15000
G1 X135.089 Y127.086 E-.19693
G1 X134.94 Y127.811 E-.28114
G1 X134.717 Y128.516 E-.28117
G1 X134.716 Y128.518 E-.00076
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 250/250
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L250
M991 S0 P249 ;notify layer change
G17
G3 Z50.2 I.456 J-1.128 P1  F30000
G1 X121.626 Y123.224 Z50.2
G1 Z50
G1 E.8 F1800
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2128
G1 X121.632 Y123.223 E.00021
G3 X127.12 Y119.104 I6.371 J2.773 E.22052
G3 X128.537 Y119.068 I.881 J6.833 E.04362
G3 X121.381 Y123.893 I-.534 J6.927 E1.05528
G1 X121.605 Y123.281 E.02003
M204 S10000
; WIPE_START
G1 F12000
G1 X121.632 Y123.223 E-.02436
M73 P98 R0
G1 X121.947 Y122.58 E-.27209
G1 X122.331 Y121.975 E-.27219
G1 X122.643 Y121.58 E-.19137
; WIPE_END
G1 E-.04 F1800
G1 X129.722 Y124.434 Z50.4 F30000
G1 X135.38 Y126.715 Z50.4
G1 Z50
G1 E.8 F1800
M204 S5000
G1 F2128
G1 X135.375 Y126.715 E.00016
G3 X128.179 Y118.587 I-7.377 J-.718 E1.05671
G1 X128.889 Y118.639 E.02187
G3 X135.41 Y126 I-.891 J7.358 E.33039
G1 X135.383 Y126.655 E.02015
M204 S10000
G1 X135.148 Y126.644 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.113078
G1 F2128
G1 X135.145 Y126.693 E.00028
G3 X120.821 Y125.995 I-7.145 J-.7 E.12493
G1 X120.821 Y125.991 E.00002
G3 X135.18 Y126 I7.18 J.002 E.12898
G1 X135.151 Y126.584 E.00334
; close powerlost recovery
M1003 S0
; WIPE_START
G1 F15000
G1 X135.145 Y126.693 E-.04149
G1 X135.045 Y127.379 E-.26361
G1 X134.88 Y128.053 E-.26361
G1 X134.713 Y128.528 E-.19129
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
G1 Z50.5 F900 ; lower z a little
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

    G1 Z150 F600
    G1 Z148

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

