%recobj=audiorecorder;
%recordblocking(recobj, 3);
%y=getaudiodata(recobj);
clc
clear all 
close all
hold off

ref_table= readtable('ScaleFreqs.xls');
%freq_names(1:107)=ref_table(:,1)


%[y,fs]=audioread('A PIANO.mp3');
[y,fs]=audioread('A3.mp3');
%[y,fs]=audioread('c4.mp3');
%[y,fs]=audioread('mix.mp3');

N=length(y);
Nfft=N; %Nfft=time(duration)*FS
%plot(y);
z=fft(y,Nfft);
x=abs(fft(y,Nfft));
for i=1:N
    af(i)=i*fs/N; %Analog Frequencies
end

plot(af(1:Nfft),x)
title('Spectrum')
xlabel('Analog frequency')

%descend=sort(z, 'descend');
[M,I]=max(x);
af_max=I*fs/N;


a=2^(1/12);
f_ref=440; %Perfect pitch A

n=log(af_max/f_ref)/log(a) %number of semitones from A4


i=1;
while i<=107
    if af_max == ref_table{i,2}
        name=ref_table(i,1)
        fprintf('Note is ')
        fprintf(name)
        break
    elseif af_max>ref_table{i,2}
         i=i+1;
    else
        dif=af_max-ref_table{i-1,2};
        
        fprintf('Note is ')
        display(dif)
        fprintf('Hertz sharper than')
        display(ref_table{i-1,1})
        break
    end
end

    


