Cauldron_Conditions_RegisterCondition("classes", { "PLAYER_LOGIN" }, function(params)
    return tContains(params, UnitClass("player"))
end)

Cauldron_Conditions_RegisterCondition("characters", { "PLAYER_LOGIN" }, function(params)
    return tContains(params, UnitName("player"))
end)

Cauldron_Conditions_RegisterCondition("instances", { "PLAYER_LOGIN", "PARTY_LEADER_CHANGED", "PLAYER_ENTERING_WORLD" }, function(params)
    local _, instanceType = IsInInstance()
    return tContains(params, instanceType)
end)

Cauldron_Conditions_RegisterCondition("races", { "PLAYER_LOGIN" }, function(params)
    return tContains(params, UnitRace("player"))
end)

Cauldron_Conditions_RegisterCondition("realms", { "PLAYER_LOGIN" }, function(params)
    return tContains(params, GetRealmName())
end)

Cauldron_Conditions_RegisterCondition("talents", { "PLAYER_LOGIN", "ACTIVE_TALENT_GROUP_CHANGED" }, function(params)
    local _, name = GetSpecializationInfo(GetSpecialization())
    return tContains(params, name)
end)

