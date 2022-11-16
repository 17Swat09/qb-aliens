local QBCore = exports['qb-core']:GetCoreObject()

players = {}

RegisterServerEvent("qb-aliens:newplayer")
AddEventHandler("qb-aliens:newplayer", function(id)
    players[source] = id
    TriggerClientEvent("qb-aliens:playerupdate", -1, players)
end)

AddEventHandler("playerDropped", function(reason)
    players[source] = nil
    TriggerClientEvent("qb-aliens:clear", source)
    TriggerClientEvent("qb-aliens:playerupdate", -1, players)
end)

AddEventHandler("onResourceStop", function()
	 TriggerClientEvent("qb-aliens:clear", -1)
end)

RegisterServerEvent('qb-aliens:moneyloot')
AddEventHandler('qb-aliens:moneyloot', function()
    local Player = QBCore.Functions.GetPlayer(source)
	local random = math.random(10, 100)
    Player.Functions.AddMoney("cash",random,"zombie-loot")
    TriggerClientEvent("QBCore:Notify", source, 'Has encontrado $' .. random .. ' dolares','success')
end)

RegisterServerEvent('qb-aliens:itemloot')
AddEventHandler('qb-aliens:itemloot', function(listKey)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	local ItemAmount = Config.ItemAmount
    local item = math.random(1, #Config.Items)
    for k,v in pairs(Config.Items) do
        if item == k then
            Player.Functions.AddItem(v, ItemAmount)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[v], 'add')
			TriggerClientEvent("QBCore:Notify", src, 'Has encontrado '..ItemAmount..'x '..QBCore.Shared.Items[v].label..' ','success')
        end
    end
	
    if Config.AddtionalItem then
        local Luck = math.random(1, 8)
        local Odd = math.random(1, 8)
        if Luck == Odd then
            Player.Functions.AddItem(Config.AddItem, Config.AddItemAmount)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[Config.AddItem], 'add')
        end
    end
end)

RegisterServerEvent('qb-aliens:partloot')
AddEventHandler('qb-aliens:partloot', function(listKey)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	local PartAmount = Config.PartItemAmount
    local item = math.random(1, #Config.ZombieParts)
    for k,v in pairs(Config.ZombieParts) do
        if item == k then
            Player.Functions.AddItem(v, PartAmount)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[v], 'add')
			TriggerClientEvent("QBCore:Notify", src, 'Has encontrado '..PartAmount..'x ' .. QBCore.Shared.Items[v].label ..' ','success')
        end
    end

end)


entitys = {}

RegisterServerEvent("RegisterNewZombie")
AddEventHandler("RegisterNewZombie", function(entity)
	TriggerClientEvent("ZombieSync", -1, entity)
	table.insert(entitys, entity)
end)
