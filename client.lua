local QBCore = exports['qb-core']:GetCoreObject()
local bag = nil

RegisterNetEvent('kg-outfitbag:client:PlaceBag', function()
    local model = `xm_prop_x17_bag_01b`
    RequestModel(model)
    while not HasModelLoaded(model) do
      Wait(1)
    end

    if bag ~= nil then
        exports.ox_target:removeLocalEntity(bag)
        DeleteEntity(bag)
        bag = nil
    end

    TriggerEvent('animations:client:EmoteCommandStart', {"medic2"})
    Wait(1000)
    local ped = PlayerPedId()
    local pos = GetOffsetFromEntityInWorldCoords(ped, 0.0, 0.5, 0.0)
    bag = CreateObject(model, pos, true, true, false)
    TriggerEvent('animations:client:EmoteCommandStart', {"c"})

    PlaceObjectOnGroundProperly(bag)

    FreezeEntityPosition(bag, true)

    TriggerServerEvent('kg-outfitbag:server:PlaceBag')

    local options = {}
    
    options[1] = {
        label = "Open Outfit Bag",
        event = "kg-outfitbag:client:OpenBag",
    }

    options[2] = {
        label = "Pickup Outfit Bag",
        event = "kg-outfitbag:client:PickupBag"
    }

    exports.ox_target:addLocalEntity(bag, options)
end)

RegisterNetEvent('kg-outfitbag:client:PickupBag', function()
    exports.ox_target:removeLocalEntity(bag)
    DeleteEntity(bag)
    bag = nil
    TriggerServerEvent('kg-outfitbag:server:Pickupbag')
end)

RegisterNetEvent('kg-outfitbag:client:OpenBag', function()
    local outfits = lib.callback.await("illenium-appearance:server:getOutfits", false)

    local Menu = {
        [1] = {
            isMenuHeader = true,
            header = 'Change Outfit',
        },
    }

    for i = 1, #outfits, 1 do
        Menu[#Menu + 1 ] = {
            header = outfits[i].name,
            txt = outfits[i].model,
            params = {
                isServer = false,
                event = 'illenium-appearance:client:changeOutfit',
                args = {
                    type = mType,
                    name = outfits[i].name,
                    model = outfits[i].model,
                    components = outfits[i].components,
                    props = outfits[i].props,
                    disableSave = mType and true or false
                },
            }
        }
    end

    exports['qb-menu']:openMenu(Menu)
end)