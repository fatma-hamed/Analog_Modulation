function [SampledVector , QuantizedVector,levels,Delta,Vmax] = Quantizer(X) 

    tv = 0:0.1:15; %Original input signal
    All_Samples = eval(subs(X,tv));
    SampledVector = All_Samples(1,[1:2:end]); %Sampling (Taking 1 Sample every 2 Samples)
    Vmax = max(All_Samples);
    Vmax_Doubled = 2 * Vmax;
    L =16;
    Delta = Vmax_Doubled./L;
    Quantizer_Levels = zeros(L,3);
    intial = 0;
    final = -Vmax;
    level_value = 0;
    for i = 1:L
        intial = final;
        level_value = -((L-1)/2)*Delta + ((i-1)*Delta);
        final = intial + Delta;
        Quantizer_Levels(i,1)= intial;
        Quantizer_Levels(i,2)= final;
        Quantizer_Levels(i,3)= level_value;
    end
    QuantizedVector = SampledVector;
     for i = 1:length(SampledVector)
        [row,cul] = size(Quantizer_Levels);
        for k = 1:row
            if QuantizedVector(i)>=Quantizer_Levels(k,1) && QuantizedVector(i)<=Quantizer_Levels(k,2)
                QuantizedVector(i) = Quantizer_Levels(k,3);
                break;
            end
        end
     end
     for i = 1:length(QuantizedVector)
         for k = 1:row
             if(QuantizedVector(i) == Quantizer_Levels(k,3))
                 QuantizedVector(i) = k-1;
                 break;
             end
         end
     end
     levels = Quantizer_Levels(:,3);
     levels= levels';   
end