% =========================================================================
% Script: Auto_script_get_value.m
% คำอธิบาย: รัน Simulation และ Export ข้อมูล Encoder ทั้ง 3 Channel ลง CSV
% =========================================================================

% 1. สั่ง Run Simulink Model (ชื่อไฟล์ sensorExpoler.slx)
fprintf('กำลังรัน Simulation...\n');
out = sim('sensorExpoler.slx');

% 2. ดึงข้อมูลเวลา (Time)
t = out.tout;

% 3. ดึงข้อมูล Position (rad) และ Velocity (rad/s) แต่ละ Channel
p1 = out.pos_data_1.Data;
v1 = out.vel_data_1.Data;

p2 = out.pos_data_2.Data;
v2 = out.vel_data_2.Data;

p3 = out.pos_data_3.Data;
v3 = out.vel_data_3.Data;

% 4. รวมข้อมูลทั้งหมดเข้า Table
exp_table = table(t, p1, v1, p2, v2, p3, v3, ...
    'VariableNames', { ...
    'Time_sec', ...
    'Pos_Ch1_rad', 'Vel_Ch1_rad_s', ...
    'Pos_Ch2_rad', 'Vel_Ch2_rad_s', ...
    'Pos_Ch3_rad', 'Vel_Ch3_rad_s'});

% 5. บันทึกเป็นไฟล์ CSV
output_file = 'Lab1_3_Encoder_Data_3.csv';
writetable(exp_table, output_file);

disp('----------------------------------------------------');
fprintf(' บันทึกข้อมูลสำเร็จ! ไฟล์ถูกเก็บไว้ที่:\n %s\\%s\n', pwd, output_file);
disp('----------------------------------------------------');