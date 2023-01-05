function [code,dict,prob] = Encoder(Quantized_Values)
   Unique_Elements = unique(Quantized_Values);
n = length(Quantized_Values);
Unique_Elements_Numbers = zeros(1,length(Unique_Elements));
for i = 1:length(Unique_Elements)
    Unique_Elements_Numbers(i) = length(find(Quantized_Values==Unique_Elements(i)));
end
prob = Unique_Elements_Numbers./n;
[dict, avglen] = huffmandict(Unique_Elements,prob);
code = huffmanenco(Quantized_Values,dict);
end