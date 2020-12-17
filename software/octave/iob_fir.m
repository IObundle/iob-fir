#
# CREATE FIR 
#

clear all
close all

#read following parameters from params.m produced by makefile
#log2 of number of taps
#N_W = 10

#coefficient width
#C_W = 32

#coefficients fractional bits
#C_Q = 8

#your filter specific parameters
#cut frequency 
#FC = 1000e3
#sample frequency 
#FS = 32e6
#gain
#G = 1

C_Q = 0;

L=32 ; L_W=5; C_W=2;COEFF_FILE='fir1coeffs.v';

if (exist ("params.m"))
  source ("params.m");
else
  printf("Parameter file not given\n");
end

#time vector if needed
t = 1/L:1/L:1;

#uncomment or create response below;

#flat response (moving average)
h(1:L) = 1;

#octave fir1
#h = fir1(L-1, pi*FC/FS);

#windowed sinc 
#h = sinc(t).*blackmanharris(32)';

#plot filter before coeff quantization
#freqz(h)

#quantize coeffs
h = rem(round(h*2^C_Q),2^C_W);

#plot filter after coeff quantization
#figure
#freqz(h)

#2s complement
for i=1:length(h)
  if(h(i)<0)
    h(i) = 2^C_W+h(i);
  end
end

#print coeffs file
j = 0;
fp = fopen(COEFF_FILE, "w");
for i=1+length(h)/2:length(h)
  fprintf(fp, "   assign h[%d] = %d'h%s;\n", j, C_W, dec2hex(h(i)));
  j=j+1;
end
fclose(fp);
