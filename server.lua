local QBCore = exports['qb-core']:GetCoreObject()

RegisterServerEvent('kg-outfitbag:server:Pickupbag', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    if Config.UseItem then
        Player.Functions.AddItem(Config.ItemName, 1)
    end
end)

RegisterServerEvent('kg-outfitbag:server:PlaceBag', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    if Config.UseItem then
        Player.Functions.RemoveItem(Config.ItemName, 1)
    end
end)


QBCore.Functions.CreateUseableItem(Config.ItemName, function(source, item)
    TriggerClientEvent('kg-outfitbag:client:PlaceBag', source)
end)

if not Config.UseItem then
    QBCore.Commands.Add('outfitbag', 'Open Outfit Bag', {}, false, function(source)
        TriggerClientEvent('kg-outfitbag:client:PlaceBag', source)
    end, 'user')
else
    QBCore.Commands.Add('outfitbag', 'Open Outfit Bag (God Only)', {}, false, function(source)
        TriggerClientEvent('kg-outfitbag:client:PlaceBag', source)
    end, 'god')
end