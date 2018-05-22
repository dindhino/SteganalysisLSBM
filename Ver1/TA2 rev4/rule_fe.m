function [output] = rule_fe(input)
    output = '';
%     1
    if strcmp(input,'kecilkonstankonstankecilkecil')
        output = 'stego';
    end
%     2
    if strcmp(input,'kecilkonstankonstankecilbesar')
        output = 'cover';
    end
%     3
    if strcmp(input,'kecilkonstankonstanbesarkecil')
        output = 'stego';
    end
%     4
    if strcmp(input,'kecilkonstankonstanbesarbesar')
        output = 'cover';
    end
%     5
    if strcmp(input,'kecilkonstanbiasakecilkecil')
        output = 'stego';
    end
%     6
    if strcmp(input,'kecilkonstanbiasakecilbesar')
        output = 'cover';
    end
%     7
    if strcmp(input,'kecilkonstanbiasabesarkecil')
        output = 'stego';
    end
%     8
    if strcmp(input,'kecilkonstanbiasabesarbesar')
        output = 'cover';
    end
%     9
    if strcmp(input,'kecilbiasakonstankecilkecil')
        output = 'stego';
    end
%     10
    if strcmp(input,'kecilbiasakonstankecilbesar')
        output = 'cover';
    end
%     11
    if strcmp(input,'kecilbiasakonstanbesarkecil')
        output = 'stego';
    end
%     12
    if strcmp(input,'kecilbiasakonstanbesarbesar')
        output = 'cover';
    end
%     13
    if strcmp(input,'kecilbiasabiasakecilkecil')
        output = 'stego';
    end 
%     14
    if strcmp(input,'kecilbiasabiasakecilbesar')
        output = 'cover';
    end 
%     15
    if strcmp(input,'kecilbiasabiasabesarkecil')
        output = 'stego';
    end 
%     16
    if strcmp(input,'kecilbiasabiasabesarbesar')
        output = 'cover';
    end 
%     17
    if strcmp(input,'besarkonstankonstankecilkecil')
        output = 'stego';
    end 
%     18
    if strcmp(input,'besarkonstankonstankecilbesar')
        output = 'cover';
    end 
%     19
    if strcmp(input,'besarkonstankonstanbesarkecil')
        output = 'stego';
    end 
%     20
    if strcmp(input,'besarkonstankonstanbesarbesar')
        output = 'cover';
    end 
%     21
    if strcmp(input,'besarkonstanbiasakecilkecil')
        output = 'stego';
    end 
%     22
    if strcmp(input,'besarkonstanbiasakecilbesar')
        output = 'cover';
    end 
%     23
    if strcmp(input,'besarkonstanbiasabesarkecil')
        output = 'stego';
    end 
%     24
    if strcmp(input,'besarkonstanbiasabesarbesar')
        output = 'cover';
    end 
%     25
    if strcmp(input,'besarbiasakonstankecilkecil')
        output = 'stego';
    end 
%     26
    if strcmp(input,'besarbiasakonstankecilbesar')
        output = 'cover';
    end 
%     27
    if strcmp(input,'besarbiasakonstanbesarkecil')
        output = 'stego';
    end 
%     28
    if strcmp(input,'besarbiasakonstanbesarbesar')
        output = 'cover';
    end 
%     29
    if strcmp(input,'besarbiasabiasakecilkecil')
        output = 'stego';
    end 
%     30
    if strcmp(input,'besarbiasabiasakecilbesar')
        output = 'cover';
    end 
%     31
    if strcmp(input,'besarbiasabiasabesarkecil')
        output = 'stego';
    end
%     32
    if strcmp(input,'besarbiasabiasabesarbesar')
        output = 'cover';
    end
end