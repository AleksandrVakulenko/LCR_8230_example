
clc

GPIB_adr = -1; % FIXME
Vac = 0.678; % V
Freq = 1234.567; % Hz

lcr_dev = LCR_8230(GPIB_adr);

try
    lcr_dev.initiate;
    lcr_dev.set_out_param;
    lcr_dev.set_measure_speed("fast");
    lcr_dev.set_amplitude(Vac);
    lcr_dev.set_freq(Freq);
    
    IDN_resp = lcr_dev.get_IDN;
    disp('IDN response:');
    disp(IDN_resp);
    disp(' ')
    
    [VAC, IAC] = lcr_dev.get_v_i_ac;
    disp(['AC voltage = ' num2str(VAC), ' V'])
    disp(['AC current = ' num2str(IAC), ' A'])
    disp(' ')
    
    [RDC, Z, DEG, resp] = lcr_dev.measure_and_read();
    desp(['response: <' resp '>'])
    disp(['R(DC) = ' num2str(RDC), ' Ohm'])
    disp(['|Z| = ' num2str(Z), ' Ohm'])
    disp(['Phase = ' num2str(DEG), ' deg'])
    disp(' ')

catch err
    lcr_dev.delete;
    rethrow(err);

end

lcr_dev.terminate;
lcr_dev.delete;





