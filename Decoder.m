function [Output_msg] = Decoder(code,dict,levels)    
    Decoded_msg = huffmandeco(code,dict);
    
for i =1:length(Decoded_msg)
    Decoded_msg(i) = levels(Decoded_msg(i)+1);
end
Output_msg = Decoded_msg;
end

