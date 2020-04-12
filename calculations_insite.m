%% Script to read the results from Insite and compare with calculations
%% Compare pl from insite and calculated
% pr_dbm = power_phase(:,1);
% pl_db = pt_dbm - pr_dbm + gt_max + gr_max - ls_db;
% pl_diff = abs(pl_db- pl_db_insite);

%% Compare power from insite and calculated
powerpaths_W(powerpaths_W == 0.001) = 0;

% Compare the sum of the power
[rx_W, rx_phase] = comparison_power_paths(powerpaths_W,powerphase_deg);

a=length(rx_W);
b=length(power_phase);

if a<b
    rx_W(numel(power_phase(:,2))) = NaN;
    rx_phase(numel(power_phase(:,2)))= NaN;
end

rx_dbm=W2dbm(rx_W,ls_db);
rx_pdbm_phase = zeros(2,rx);
rx_pdbm_phase=[rx_dbm ; rx_phase];

rxdiff = abs(rx_pdbm_phase'-power_phase);

if ds_enable == 1;
    [totaldiff_power,totaldiff_phase] = comparison_totalpower(ds_power_file,ls_db);
end

% File power_phase is equal to ds_power_file's column 11 and 11