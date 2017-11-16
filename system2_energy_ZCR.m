training_files_yes = dir('C:\Users\Ahmad Dar Khalil\Dropbox\rt\DSP\DSP codes\project\train\yes\*.wav');
testing_files_yes = dir('C:\Users\Ahmad Dar Khalil\Dropbox\rt\DSP\DSP codes\project\test\yes\*.wav');
training_files_no = dir('C:\Users\Ahmad Dar Khalil\Dropbox\rt\DSP\DSP codes\project\train\no\*.wav');
testing_files_no = dir('C:\Users\Ahmad Dar Khalil\Dropbox\rt\DSP\DSP codes\project\test\no\*.wav');

% read the 'yes' training files and calculate the energy of them.
data_yes = [];
for i = 1:length(training_files_yes)
file_path = strcat(training_files_yes(i).folder,'\',training_files_yes(i).name);
[y,fs] = audioread(file_path);
%divide the signal into 3 parts and calculate the ZCR for each part
ZCR_yes1 = mean(abs(diff(sign(y(1:floor(end/3))))))./2;
ZCR_yes2 = mean(abs(diff(sign(y(floor(end/3):floor (end*2/3))))))./2;
ZCR_yes3 = mean(abs(diff(sign(y(floor(end*2/3):end)))))./2;
%calculate the energy
energy = sum(y.^2);
ZCR_yes = [ZCR_yes1 ZCR_yes2 ZCR_yes3 energy];
data_yes = [data_yes ;ZCR_yes];
end
ZCR_yes=mean(data_yes);
fprintf('The ZCR of yes is \n');
disp(ZCR_yes);

% read the 'no' training files and calculate the energy of them.
data_no = [];
for i = 1:length(training_files_no)
file_path = strcat(training_files_no(i).folder,'\',training_files_no(i).name);
[y,fs] = audioread(file_path);

%divide the signal into 3 parts and calculate the ZCR for each part
ZCR_no1 = mean(abs(diff(sign(y(1:floor(end/3))))))./2;
ZCR_no2 = mean(abs(diff(sign(y(floor(end/3):floor (end*2/3))))))./2;
ZCR_no3 = mean(abs(diff(sign(y(floor(end*2/3):end)))))./2;
%calculate the energy
energy = sum(y.^2);

ZCR_no = [ZCR_no1 ZCR_no2 ZCR_no3 energy];

data_no = [data_no ;ZCR_no];
end
ZCR_no=mean(data_no);
fprintf('The ZCR of no is \n');
disp(ZCR_no);



% read the 'yes' tesing files and calculate the energy of them.

for i = 1:length(testing_files_yes)
file_path = strcat(testing_files_yes(i).folder,'\',testing_files_yes(i).name);
[y,fs] = audioread(file_path);

%divide the signal into 3 parts and calculate the ZCR for each part
ZCR_yes1 = mean(abs(diff(sign(y(1:floor(end/3))))))./2;
ZCR_yes2 = mean(abs(diff(sign(y(floor(end/3):floor (end*2/3))))))./2;
ZCR_yes3 = mean(abs(diff(sign(y(floor(end*2/3):end)))))./2;
%calculate the energy
energy = sum(y.^2);

y_ZCR = [ZCR_yes1 ZCR_yes2 ZCR_yes3 energy];
    %make the decision based on cosine distance
    if(pdist([y_ZCR;ZCR_yes],'cosine') < pdist([y_ZCR;ZCR_no],'cosine'))
        fprintf('Test file [yes] #%d classified as yes \n',i);
    else
        fprintf('Test file [yes] #%d classified as no \n',i);
    end
end

% read the 'no' tesing files and calculate the energy of them.
for i = 1:length(testing_files_no)
file_path = strcat(testing_files_no(i).folder,'\',testing_files_no(i).name);
[y,fs] = audioread(file_path);
%divide the signal into 3 parts and calculate the ZCR for each part
ZCR_no1 = mean(abs(diff(sign(y(1:floor(end/3))))))./2;
ZCR_no2 = mean(abs(diff(sign(y(floor(end/3):floor (end*2/3))))))./2;
ZCR_no3 = mean(abs(diff(sign(y(floor(end*2/3):end)))))./2;
energy = sum(y.^2);

y_ZCR = [ZCR_no1 ZCR_no2 ZCR_no3 energy];
    %make the decision based on cosine distance
    if(pdist([y_ZCR;ZCR_yes],'cosine') < pdist([y_ZCR;ZCR_no],'cosine'))
        fprintf('Test file [no] #%d classified as yes \n',i);
    else
        fprintf('Test file [no] #%d classified as no \n',i);
    end
end
