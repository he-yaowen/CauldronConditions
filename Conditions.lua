--
-- Copyright (C) 2019 HE Yaowen <he.yaowen@hotmail.com>
--
-- This program is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.
--
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
--
-- You should have received a copy of the GNU General Public License
-- along with this program.  If not, see <http://www.gnu.org/licenses/>.
--

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

