function [output] = rule_cn(input)
    output = '';
%     1
    if strcmp(input,'covercovercover')
        output = 'cover';
    end
%     2
    if strcmp(input,'covercoverstego')
        output = 'stego';
    end
%     3
    if strcmp(input,'coverstegocover')
        output = 'stego';
    end
%     4
    if strcmp(input,'coverstegostego')
        output = 'stego';
    end
%     5
    if strcmp(input,'stegocovercover')
        output = 'stego';
    end
%     6
    if strcmp(input,'stegocoverstego')
        output = 'stego';
    end
%     7
    if strcmp(input,'stegostegocover')
        output = 'stego';
    end
%     8
    if strcmp(input,'stegostegostego')
        output = 'stego';
    end