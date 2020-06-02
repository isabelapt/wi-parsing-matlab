addpath(genpath('../wi-parsing-matlab/'))

%% Read MIMO Outputs %%
path = fullfile(pwd,test_n,'sweden_mimo','studyarea');
rx=1;
txSet = '031';
rxSet = '029';

% Read H-Matrix.csv %
hmatrix_path = fullfile(path,'hmatrix');
[Hinsite_NtNr,Hinsite_NrNt] = Hmatrix_insite(rx,numRx,numTx,hmatrix_path,txSet,rxSet);


% Read Received Power files %
power_path = fullfile(path,'power');
[MimoPower_insite, MimoPhase_insite, MimoPathGain_insite] = MIMOPower_insite(numRx,...
    numTx,power_path,txSet,rxSet);
MimoPowerMatrix_insite = dbm2W(MimoPower_insite);

% Read Complex Impulse Response files %
cir_path = fullfile(path,'cir');
[CIR_matrix] = MIMOCir_insite(rx,numRx,numTx,cir_path,txSet,rxSet);
rpower_mimo = squeeze(CIR_matrix(:,3,:));
phase_mimo = rad2deg(squeeze(CIR_matrix(:,4,:)));
toa_mimo = squeeze(CIR_matrix(:,5,:));

% Sum the power and phase of paths and put it a matrix Nt x Nr
for i = 1:numRx*numTx
[MIMO_rx_W(i),MIMO_rx_phase(i)] =  sum_power_phase(CIR_matrix(:,3,i),CIR_matrix(:,4,i));
end
MIMO_rx_W = transpose(reshape(MIMO_rx_W,numTx,numRx));
MIMO_rx_phase = transpose(reshape(MIMO_rx_phase,numTx,numRx));
MIMO_rx_db = W2dbm(MIMO_rx_W,0);
MIMO_rx_phase_rad = deg2rad(MIMO_rx_phase);

%  Check if the summming is correct 
if total_array_input == 0
   MIMO_tx_W=inputpower_W;
else
    MIMO_tx_W=inputpower_W./numTx;
end

Ginsite = (sqrt(MimoPowerMatrix_insite./MIMO_tx_W).* exp(1j*MimoPhase_insite));
Hinsitecheck = Ginsite'


