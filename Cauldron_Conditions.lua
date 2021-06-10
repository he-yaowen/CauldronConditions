local registeredConditions = {}
local eventFrame = CreateFrame("Frame")

local function ValidateConditions(conditions)
    if not conditions then
        return true
    end

    local result = true
    for name, args in pairs(conditions) do
        if not registeredConditions[name] then
            Cauldron_Error(string.format("Condition '%s' not registered yet.", name))
            return false
        end

        result = result and registeredConditions[name]["validator"](args)
    end

    return result
end

eventFrame:SetScript("OnEvent", function(self, event)
    if self[event] == nil then
        return
    end

    for _, condition in pairs(self[event]) do
        for _, recipe in pairs(condition["recipes"]) do
            if ValidateConditions(recipe["conditions"]) then
                Cauldron_RaiseEvent("RECIPE_ENABLE", recipe)
            else
                Cauldron_RaiseEvent("RECIPE_DISABLE", recipe)
            end
        end
    end
end)

--- Registers a new condition.
-- @param name name of condition
-- @param events condition events
-- @param validator validator function of condition
--
function Cauldron_Conditions_RegisterCondition(name, events, validator)
    if registeredConditions[name] then
        Cauldron_Error(string.format("Condition '%s' already registered.", name))
        return
    end

    local condition = {
        validator = validator,
        recipes = {}
    }

    for _, event in pairs(events) do
        if not eventFrame[event] then
            eventFrame:RegisterEvent(event)
            eventFrame[event] = {}
        end

        table.insert(eventFrame[event], condition)
    end

    registeredConditions[name] = condition
end

Cauldron_RegisterEvent("RECIPE_LOAD", function(_, recipe)
    if not recipe["conditions"] then
        return
    end

    for key, _ in pairs(recipe["conditions"]) do
        if not registeredConditions[key] then
            Cauldron_Error(string.format("Condition '%s' is not registered yet.", key))
            return
        end

        if not tContains(registeredConditions[key]["recipes"], recipe) then
            table.insert(registeredConditions[key]["recipes"], recipe)
        end
    end
end)

Cauldron_RegisterEvent("RECIPE_QUERY_ENABLE", function(_, recipe)
    if not recipe["conditions"] then
        return
    end

    return ValidateConditions(recipe["conditions"])
end)
