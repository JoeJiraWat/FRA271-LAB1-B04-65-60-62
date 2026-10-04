% =========================================================================
% MATLAB Automation Script: Record A0, A1, A2 & Schmitt Output (5 Runs)
% =========================================================================

% 1. ดึงชื่อ Model ที่เปิดอยู่อัตโนมัติ
try
    model_name = bdroot;
    if isempty(model_name)
        error('กรุณาเปิดไฟล์ Simulink (.slx) ก่อนรันสคริปต์นี้ครับ');
    end
catch
    error('กรุณาเปิดไฟล์ Simulink (.slx) ก่อนรันสคริปต์นี้ครับ');
end

fprintf('กำลังใช้งาน Model: %s\n', model_name);

% 2. กำหนด Path ปลายทางแยกสำหรับทุกสัญญาณ
base_path    = 'D:\Lab1.2_rmx\Flip_magnatics\shiel\3.6';

path_A0      = fullfile(base_path, 'RAW_A0');
path_A1      = fullfile(base_path, 'RAW_A1');
path_A2      = fullfile(base_path, 'RAW_A2');
path_Schmitt = fullfile(base_path, 'Square_Wave_Schmitt');

% สร้างโฟลเดอร์อัตโนมัติหากยังไม่มี
if ~exist(path_A0, 'dir'), mkdir(path_A0); end
if ~exist(path_A1, 'dir'), mkdir(path_A1); end
if ~exist(path_A2, 'dir'), mkdir(path_A2); end
if ~exist(path_Schmitt, 'dir'), mkdir(path_Schmitt); end

% =========================================================================
% 3. เริ่ม Loop บันทึก Simulation จำนวน 5 รอบ
% =========================================================================
num_runs = 5;

for i = 1:num_runs
    fprintf('--------------------------------------------------\n');
    fprintf('กำลังเริ่มบันทึกรอบที่ %d / %d ...\n', i, num_runs);
    
    % สั่ง Run Simulink
    simOut = sim(model_name);
    logs = simOut.logsout;
    
    % ดึงข้อมูล LogsOut ของแต่ละสัญญาณ
    sig_A0      = logs.get('A0').Values;
    sig_A1      = logs.get('A1').Values;
    sig_A2      = logs.get('A2').Values;
    sig_Schmitt = logs.get('Schmitt_Out').Values;
    
    % ---------------------------------------------------------------------
    % บันทึกไฟล์ .mat แต่ละโฟลเดอร์ (1.mat, 2.mat, ..., 5.mat)
    file_A0      = fullfile(path_A0, sprintf('%d.mat', i));
    file_A1      = fullfile(path_A1, sprintf('%d.mat', i));
    file_A2      = fullfile(path_A2, sprintf('%d.mat', i));
    file_Schmitt = fullfile(path_Schmitt, sprintf('%d.mat', i));
    
    save(file_A0, 'sig_A0');
    save(file_A1, 'sig_A1');
    save(file_A2, 'sig_A2');
    save(file_Schmitt, 'sig_Schmitt');
    
    fprintf('  [1/4] บันทึก A0      รอบที่ %d เรียบร้อย\n', i);
    fprintf('  [2/4] บันทึก A1      รอบที่ %d เรียบร้อย\n', i);
    fprintf('  [3/4] บันทึก A2      รอบที่ %d เรียบร้อย\n', i);
    fprintf('  [4/4] บันทึก Schmitt รอบที่ %d เรียบร้อย\n', i);
    
    pause(1); % เว้นช่วง 1 วินาที
end

fprintf('--------------------------------------------------\n');
fprintf('บันทึกข้อมูลครบทุกสัญญาณ (A0, A1, A2, Schmitt) 5 รอบเรียบร้อยแล้วครับ!\n');