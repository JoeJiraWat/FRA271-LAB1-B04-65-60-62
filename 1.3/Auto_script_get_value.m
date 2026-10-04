if exist('out', 'var')
    t = out.tout;

    % ดึงค่ากรณีตัวแปรซุกอยู่ใน out
    if isprop(out, 'pos_data')
        p = out.pos_data.Data;
        v = out.vel_data.Data;
    else
        error('ไม่พบตัวแปร pos_data และ vel_data ใน out! ตรวจสอบการตั้งชื่อบล็อก To Workspace');
    end
elseif exist('pos_data', 'var') && exist('vel_data', 'var')
    % ดึงค่ากรณีอยู่ใน Workspace โดยตรง
    t = tout;
    p = pos_data.Data;
    v = vel_data.Data;
else
    error('ไม่พบข้อมูลการทดลองใน Workspace กรุณากด Run Simulation ใน Simulink ก่อน');
end

% 2. สร้าง Table
exp_table = table(t, p, v, 'VariableNames', {'Time_sec', 'Position_rad', 'Velocity_rad_s'});

% 3. เซฟเป็นไฟล์ CSV
output_file = 'Lab1_3_Encoder_Data.csv';
writetable(exp_table, output_file);

disp('----------------------------------------------------');
fprintf(' บันทึกข้อมูลสำเร็จ! ไฟล์ถูกเก็บไว้ที่: %s\\%s\n', pwd, output_file);
disp('----------------------------------------------------');