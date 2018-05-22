function [output] = rule_cn(input)
    output = '';
%     1
    if strcmp(input,'rendahrendahrendah')
        output = 'cover';
    end
%     2
    if strcmp(input,'rendahrendahtinggi')
        output = 'stego';
    end
%     3
    if strcmp(input,'rendahtinggirendah')
        output = 'stego';
    end
%     4
    if strcmp(input,'rendahtinggitinggi')
        output = 'stego';
    end
%     5
    if strcmp(input,'tinggirendahrendah')
        output = 'stego';
    end
%     6
    if strcmp(input,'tinggirendahtinggi')
        output = 'stego';
    end
%     7
    if strcmp(input,'tinggitinggirendah')
        output = 'stego';
    end
%     8
    if strcmp(input,'tinggitinggitinggi')
        output = 'stego';
    end