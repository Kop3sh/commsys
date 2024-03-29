[sig_t,fs] = audioread('dove.mp3');
L = length(sig_t);
sound(sig_t,fs);

%plot in time domain 
tvec = linspace(0,length(sig_t)/fs,length(sig_t));
figure; subplot(2,1,1);
plot(tvec,sig_t); title('Original Signal in Time');

%plot in frequency domain
sig_f = abs(fftshift(fft(sig_t)));
fvec = linspace(-fs/2,fs/2,length(sig_f));
subplot(2,1,2); plot(fvec,sig_f); title('Original Signal in Frequency');

%channel

nh = input('\n\nChoose the number of the impluse response\n 1.Delta\n 2. exp(-2pi*5000t)\n 3. exp(-2pi*1000t)\n 4. 2*delta(t)+0.5*delta(t-1)\n');
tvec = linspace(0,0.5,0.5*fs);
switch nh
    case 1
        h = [1];
    case 2
        h = exp(-2*pi*5000*tvec);
    case 3
        h = exp(-2*pi*1000*tvec);
    case 4
        h = [2 zeros(1,0.5*fs) 0.5];
%         h = [2 zeros(1,fs-1) 0.5];
%         h = [h zeros(1, (L/2)-length(h))];
end


s1 = sig_t(:,1).';
s1 = conv(s1,h);


s2 = sig_t(:,2).';
s2 = conv(s2,h);


sig_t = [s1; s2].'


tvec = linspace(0,length(sig_t)/fs,length(sig_t));
figure; subplot(2,1,1);
plot(tvec,sig_t); title('Convoluted Signal in Time');
sig_f = abs(fftshift(fft(sig_t)));
fvec = linspace(-fs/2,fs/2,length(sig_f));
subplot(2,1,2); plot(fvec,sig_f); title('Convoluted Signal in Frequency');

sound(sig_t,fs);

%Noise
sigma = input('Please input the standard deviation of the noise:');

%Generaing the noise
noise = sigma*randn(size(sig_t));

%Adding noise to the signal
sig_noise = sig_t + noise;

%Signal representation
tvec = linspace(0,length(sig_noise)/fs,length(sig_noise));
figure; subplot(2,1,1);
plot(tvec,sig_noise); title('Signal with Noise in Time');
sig_f = abs(fftshift(fft(sig_noise)));
fvec = linspace(-fs/2,fs/2,length(sig_f));
subplot(2,1,2); plot(fvec,sig_f); title('Signal with Noise in Frequency');

sound(sig_noise,fs);

% LPF construction cut-off 3.4kHz
n = length(sig_f);
sampPerFreq = int64(n/fs);
limit = sampPerFreq * (fs/2 - 3400);
sig_f([1:limit n-limit+1:end]) = 0;
figure;
subplot(2,1,2);
plot(fvec, sig_f);
title('Filtered signal in f-domain');
sig_t = real(ifft(ifftshift(sig_f)));
subplot(2,1,1);
plot(tvec, sig_t);
title('Filtered signal in t-domain');

sound(sig_t,fs);

