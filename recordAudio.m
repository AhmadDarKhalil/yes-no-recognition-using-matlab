
recObj = audiorecorder(44000, 24, 1);% record at Fs=44khz, 24 bits per sample
fprintf('Start speaking for audio\n');
recordblocking(recObj, 2); % record 2 seconds
fprintf('Audio ended\n');


y = getaudiodata(recObj);
y = y - mean(y);
figure
plot(y);
