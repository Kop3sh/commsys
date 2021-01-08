[sig_t,fs] = audioread('file_example_WAV_1MG Trim.wav');
L = length(sig_t);
sound(sig_t,fs);

%plot in time domain 
t = linspace(0,length(sig_t)/fs,length(sig_t));
figure; plot(t,sig_t); title('Original Signal in Time');

%plot in frequency domain
sig_f = abs(fftshift(fft(sig_t)));
fvec = linspace(-fs/2,fs/2,length(sig_f));
figure; plot(fvec,sig_f); title('Original Signal in Frequency');

%channel
nh = input('\n\nChoose the number of the impluse response\n 1.Delta\n 2. exp(-2pi*5000t)\n 3. exp(-2pi*1000t)\n 4. 2*delta(t)+0.5*delta(t-1)\n');
switch nh
    case 1
        h = [1 zeros(1,length(sig_t))];
    case 2
        h = exp(-2*pi*5000*tvec);
    case 3
        h = exp(-2*pi*1000*tvec);
    case 4
        h = [2 zeros(1,fs-1) 0.5];
        h = [h zeros(1, length(sig_t)-length(h))];
end
sig_t = conv(sig_t,h);

tvec = linspace(0,length(sig_t)/fs,length(sig_t));
figure; plot(t,sig_t); title('Convoluted Signal in Time');
sig_f = abs(fftshift(fft(sig_t)));
fvec = linspace(-fs/2,fs/2,length(sig_f));
figure; plot(fvec,sig_f); title('Convoluted Signal in Frequency');

sound(sig_t,fs);

%Noise
sigma = input('Please input the standard deviation of the noise:');

%Generaing the noise
noise = sigma*randn(size(sig_t));

%Adding noise to the signal
sig_noise = sig_t + noise;

%Signal representation
tvec = linspace(0,length(sig_noise)/fs,length(sig_noise));
figure; plot(tvec,sig_noise); title('Signal with Noise in Time');
sig_f = abs(fftshift(fft(sig_noise)));
fvec = linspace(-fs/2,fs/2,length(sig_f));
figure; plot(fvec,sig_f); title('Signal with Noise in Frequency');

sound(sig_noise,fs);



