file1 = "C:\Users\Srinath\Documents\NITK\SEM 5\EE386\Experiment-1\Experiment-1\RainFallIndia_Jan.txt"
file2 = "C:\Users\Srinath\Documents\NITK\SEM 5\EE386\Experiment-1\Experiment-1\RainFallIndia_July.txt"
data1 = importdata(file1)
data2 = importdata(file2) 
subplot(2,1,1)
histogram(data1)
title("Rain Fall in India (JAN & JULY)")
subplot(2,1,2)
histogram(data2)
Jan_mean = mean(data1)
July_mean = mean(data2)
Standard_Deviation_Jan = std(data1)
Standard_Deviation_July = std(data2)