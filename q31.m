fileid = "C:\Users\Srinath\Documents\NITK\SEM 5\EE386\Experiment-1\Experiment-1\ECG_Data.txt"
fid = importdata(fileid)
plot(fid)
title("ECG Data")
ylabel("Amplitude")
xlabel("Time")