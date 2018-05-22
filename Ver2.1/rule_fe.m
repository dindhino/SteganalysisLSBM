function [output] = rule_fe(input)
    output = '';
%     1
    if strcmp(input,'covercovercovercovercover')
        output = 'cover';
    end
%     2
    if strcmp(input,'covercovercovercoverstego')
        output = 'cover';
    end
%     3
    if strcmp(input,'covercovercoverstegocover')
        output = 'cover';
    end
%     4
    if strcmp(input,'covercovercoverstegostego')
        output = 'cover';
    end
%     5
    if strcmp(input,'covercoverstegocovercover')
        output = 'cover';
    end
%     6
    if strcmp(input,'covercoverstegocoverstego')
        output = 'cover';
    end
%     7
    if strcmp(input,'covercoverstegostegocover')
        output = 'cover';
    end
%     8
    if strcmp(input,'covercoverstegostegostego')
        output = 'stego';
    end
%     9
    if strcmp(input,'coverstegocovercovercover')
        output = 'cover';
    end
%     10
    if strcmp(input,'coverstegocovercoverstego')
        output = 'cover';
    end
%     11
    if strcmp(input,'coverstegocoverstegocover')
        output = 'cover';
    end
%     12
    if strcmp(input,'coverstegocoverstegostego')
        output = 'stego';
    end
%     13
    if strcmp(input,'coverstegostegocovercover')
        output = 'cover';
    end 
%     14
    if strcmp(input,'coverstegostegocoverstego')
        output = 'stego';
    end 
%     15
    if strcmp(input,'coverstegostegostegocover')
        output = 'cover';
    end 
%     16
    if strcmp(input,'coverstegostegostegostego')
        output = 'stego';
    end 
%     17
    if strcmp(input,'stegocovercovercovercover')
        output = 'stego';
    end 
%     18
    if strcmp(input,'stegocovercovercoverstego')
        output = 'stego';
    end 
%     19
    if strcmp(input,'stegocovercoverstegocover')
        output = 'stego';
    end 
%     20
    if strcmp(input,'stegocovercoverstegostego')
        output = 'stego';
    end 
%     21
    if strcmp(input,'stegocoverstegocovercover')
        output = 'stego';
    end 
%     22
    if strcmp(input,'stegocoverstegocoverstego')
        output = 'stego';
    end 
%     23
    if strcmp(input,'stegocoverstegostegocover')
        output = 'stego';
    end 
%     24
    if strcmp(input,'stegocoverstegostegostego')
        output = 'stego';
    end 
%     25
    if strcmp(input,'stegostegocovercovercover')
        output = 'stego';
    end 
%     26
    if strcmp(input,'stegostegocovercoverstego')
        output = 'stego';
    end 
%     27
    if strcmp(input,'stegostegocoverstegocover')
        output = 'stego';
    end 
%     28
    if strcmp(input,'stegostegocoverstegostego')
        output = 'stego';
    end 
%     29
    if strcmp(input,'stegostegostegocovercover')
        output = 'stego';
    end 
%     30
    if strcmp(input,'stegostegostegocoverstego')
        output = 'stego';
    end 
%     31
    if strcmp(input,'stegostegostegostegocover')
        output = 'stego';
    end
%     32
    if strcmp(input,'stegostegostegostegostego')
        output = 'stego';
    end
end