clc
clear
close all
syms t 
%Input Signal
X = sin(0.2*pi*t); 
%Quantization
[SampledVector,Quantized_Values,levels,Delta,Vmax] = Quantizer(X);
%Encoding
[code,dict,prob] = Encoder(Quantized_Values); 
%Noiseless Channel Simulation
Recieved_msg = Noiseless_Channel(code);
%Decoding
Output_msg = Decoder(code,dict,levels);
%The Requirements
%Plot the input and output signal on the same figure
tv=0:0.2:15;
figure(1)
plot(tv, Output_msg)
hold on
plot(tv,SampledVector)
title("Input and Output Signals")
xlabel("t")
ylabel("x(t)")
figure(2)
stem(tv, Output_msg)
hold on
stem(tv,SampledVector)
title("Input and Output Signals")
xlabel("n")
ylabel("x[n]")
%Calculate the SQNR of the quantizer
Varience = (Delta^2)/12;
P = Vmax^2;
SQNR = P/Varience;
formatSpacA = "SQNR of the quantizer is %4.3f\n";
fprintf(formatSpacA,SQNR)
%Calculate the efficiency of your compression code
E = sum(-1.*prob.*log2(prob));
I = ceil(-log2(prob));
Ldash = sum(prob.*I);
Effeciency = E/Ldash;
formatSpacB = "The efficiency of the compression code is %4.3f\n";
fprintf(formatSpacB,Effeciency)
%Calculate the compression rate
n = log2(16);
CR = n/Ldash;
formatSpacC = "The compression rate of the code is %4.3f\n";
fprintf(formatSpacC,CR)