local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local CollectionService = game:GetService("CollectionService")
local Players = game:GetService("Players")

local Knit = require(ReplicatedStorage.Packages.Knit)

local BulletHandlerService = Knit.CreateService {
    Name = "BulletHandlerService";
    Client = {};
}

local function TempCodeToGiveGunsRemoveLaterOkayThxBye()
    local InsertService = game:GetService("InsertService")
    local toolBase = InsertService:LoadAsset(10442641704):FindFirstChildOfClass("Tool")

    local function playerAdded(player: Player)
        local function giveGun(tagName)
            local tool = toolBase:Clone()
            CollectionService:AddTag(tool, tagName)
            tool.Parent = player.Backpack
        end

        local function characterAdded(character: Model)
            giveGun("AssaultRifle")
        end

        player.CharacterAdded:Connect(characterAdded)
        if player.Character then
            task.spawn(characterAdded, player.Character)
        end
    end

    Players.PlayerAdded:Connect(playerAdded)

    for _, player in Players:GetPlayers() do
        task.spawn(playerAdded, player)
    end
end

function BulletHandlerService:KnitInit()
    TempCodeToGiveGunsRemoveLaterOkayThxBye()
end

function BulletHandlerService:KnitStart()

end

return BulletHandlerService