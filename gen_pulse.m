function gen_pulse()
s = daq.createSession('ni');
addDigitalChannel(s,'Dev2','Port1/Line0','OutputOnly');
outputSingleScan(s,0);
pause(0.05);
outputSingleScan(s,1);
pause(0.05);
outputSingleScan(s,0);
end

