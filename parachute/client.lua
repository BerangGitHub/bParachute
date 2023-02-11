ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

function parachute()

    local parachute_menu = RageUI.CreateMenu("Parachute", "Parachute")

    RageUI.Visible(parachute_menu, not RageUI.Visible(parachute_menu))

    while parachute_menu do
        Citizen.Wait(0)

        RageUI.IsVisible(parachute_menu, true, true, true, function()

            RageUI.ButtonWithStyle("Acheter un parachute", nil, {RightLabel = "~g~$ " ..Config.price}, true, function(Hovered, Active, Selected)
                if Selected then
                    TriggerServerEvent('parachute:buy')
                    RageUI.CloseAll()
                end
            end)

        end, function()
        end)

        if not RageUI.Visible(parachute_menu) then
            parachute_menu = RMenu:DeleteType("Parachute", true)
        end
    end

end

Citizen.CreateThread(function()
    while true do
        local nearParachute = false
        local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), Config.position.x, Config.position.y, Config.position.z, true)
        if distance <= 1.3 then
            nearParachute = true
            ESX.ShowHelpNotification("Appuyez sur ~INPUT_TALK~ pour accéder au menu")
            if IsControlJustPressed(1, 51) then
                parachute()
            end
        end
        if distance <= 6 then
            nearParachute = true
            DrawMarker(Config.MarkerType, Config.position.x, Config.position.y, Config.position.z, vector3(0.0, 0.0, 0.0), vector3(0.0, 0.0, 0.0), Config.MarkerSize, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, Config.MarkerColor.a, false, false, 2, false, nil, nil, false)
        end
        if distance > 6 then
            parachute_menu = RMenu:DeleteType("Parachute", true)
        end
        if nearParachute then
            Wait(1)
        else
            Wait(750)
        end
    end
end)