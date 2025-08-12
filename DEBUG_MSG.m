% Date: 2025.03.04
% Version: 1.0
% Author: Aleksandr Vakulenko
% Licensed after GNU GPL v3
%
% ----INFO----:
% If global "debug_mgs_status" is eual to "enable":
% - DEBUG_MSG prints a message in Matlab console
%
% If global "debug_mgs_status" is not eual to "enable":
% - no effect
%
% Global flag could be changed by call of DEBUG_MSG_ENABLE(status) with 
% status equal to "enable" or "disable".
%
% Debug messages could be colored in black, orange and red.
% (default color is black).
% Debug message always starts with "debug_msg: ".
% Debug messages could be decorated for call in class constructor or
% destructor. By default messages are plain text (style = "common").
% ------------

% TODO list:
% 1) add 3 levels of msg

function DEBUG_MSG(msg, color, style)
arguments
    msg
    color {mustBeMember(color, ["black", "red", "orange"])} = "black"
    style {mustBeMember(style, ["common", "ctor", "dtor", "tab"])} = "common"
end

try
    msg = char(string(msg));
catch
    warning('problem in debug_msg')
    return;
end

if is_debug_msg_active()

%     fprintf(1, ['debug_msg: '])
    switch style
        case "common"
            fprintf(1, ['debug_msg:'])
            Pref = '';
        case "ctor"
            fprintf(1, ['(>)Constr:'])
            Pref = '';
        case "dtor"
            fprintf(1, ['(<<)Destr:'])
            Pref = '';
        case "tab"
            fprintf(1, ['          '])
            Pref = '';
    end

    msg = [Pref ' ' msg];

    switch color
        case "black"
            fprintf(1, [msg '\n'])

        case "red"
            fprintf(2, [msg '\n'])

        case "orange"
            msg = make_orange(msg);
            fprintf(1, [msg '\n'])
    end


end
end


function str = make_orange(str)
Part1 = ['[' 8];
Part2 = [']' 8];
str = [Part1 str Part2];
end


function status = is_debug_msg_active()
global debug_mgs_status
status = ~isempty(debug_mgs_status) && debug_mgs_status == "enable";
end


