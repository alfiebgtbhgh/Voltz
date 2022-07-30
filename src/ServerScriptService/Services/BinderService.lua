local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Knit = require(ReplicatedStorage.Packages.Knit)
local BinderProvider = require(ReplicatedStorage.Common.BinderProvider)

--[=[
	@class BinderService
]=]
local BinderService = Knit.CreateService {
    Name = "BinderService";
    Client = {};
}

BinderService._binderProvider = BinderProvider.new()

--[=[
	Searches for a particular Binder by its tag name.

	@param tagName string -- The tag to search for.
	@return Binder? -- The Binder, if found.
]=]
function BinderService:Get(tagName)
    return self._binderProvider:Get(tagName)
end

function BinderService:KnitInit()
    for _, instanceComponentModule in ipairs(ServerScriptService.InstanceComponents.Structures) do
        self._binderProvider:Add(instanceComponentModule.Name, require(instanceComponentModule))
    end

    for _, instanceComponentModule in ipairs(ServerScriptService.InstanceComponents.Tools) do
        self._binderProvider:Add(instanceComponentModule.Name, require(instanceComponentModule))
    end

    for _, instanceComponentModule in ipairs(ServerScriptService.InstanceComponents.Misc) do
        self._binderProvider:Add(instanceComponentModule.Name, require(instanceComponentModule))
    end
end

function BinderService:KnitStart()
    self._binderProvider:Start()
end

return BinderService