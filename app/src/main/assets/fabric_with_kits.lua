-- This file is part of XPrivacyLua.

-- XPrivacyLua is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.

-- XPrivacyLua is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.

-- You should have received a copy of the GNU General Public License
-- along with XPrivacyLua.  If not, see <http://www.gnu.org/licenses/>.

-- Copyright 2017-2018 Marcel Bokhorst (M66B)

function after(hook, param)
    local kits = param:getArgument(1)
    if kits == nil then
        return false
    end

    local clsArray = luajava.bindClass('java.lang.reflect.Array')
    for index = 0, kits.length - 1 do
        local kit = clsArray:get(kits, index)
        if kit ~= nil and kit.getIdentifier ~= nil and type(kit.getIdentifier) == 'function' then
            local identifier = kit:getIdentifier()
            log(identifier)
            if identifier == 'com.crashlytics.sdk.android:crashlytics' then
                log(kit)
                if kit.core ~= nil and kit.core.disabled ~= nil then
                    kit.core.disabled = true
                    return true
                elseif kit.disabled ~= nil then
                    kit.disabled = true
                    return true
                else
                    log('Crashlytics not disabled')
                end
            end
        end
    end

    return false
end
