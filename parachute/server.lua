ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('parachute:buy')
AddEventHandler('parachute:buy', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local price = Config.price

    if xPlayer.getMoney() >= price then
        xPlayer.removeMoney(price)
        TriggerClientEvent('esx:showNotification', _source, "Vous avez acheté un parachute pour ~g~$ " ..price)
        xPlayer.addWeapon('GADGET_PARACHUTE', 1)
    else
        TriggerClientEvent('esx:showNotification', _source, "Vous n'avez pas assez d'argent")
    end
end)