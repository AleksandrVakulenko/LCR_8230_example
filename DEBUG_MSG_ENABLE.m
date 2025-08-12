function DEBUG_MSG_ENABLE(status)
arguments
    status {mustBeMember(status, ["enable", "disable"])}
end
    global debug_mgs_status
    debug_mgs_status = status;
end
