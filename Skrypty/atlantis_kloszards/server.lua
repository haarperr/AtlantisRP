local ESX = nil

TriggerEvent("esx:getSharedObject", function(obj) 
    ESX = obj 
end)

ESX.RegisterUsableItem('vine2', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)

    xPlayer.removeInventoryItem('vine2', 1)
    xPlayer.addInventoryItem('bottle', 1)
    TriggerClientEvent('komandos', source)
end)

RegisterServerEvent("craft:vine")
AddEventHandler("craft:vine", function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local botlle = xPlayer.getInventoryItem("bottle")["count"]
    local oranges = xPlayer.getInventoryItem("orange")["count"]
    local vodka = xPlayer.getInventoryItem("vodka")["count"]

    if botlle > 0 then
        if oranges >= 5 then
            if vodka > 0 then
                TriggerClientEvent('craftprocess', source)
                xPlayer.removeInventoryItem("bottle", 1)
                xPlayer.removeInventoryItem("orange", 5)
                xPlayer.removeInventoryItem("vodka", 1)
            else
                TriggerClientEvent("pNotify:SendNotification", source, {text = "NA GŁOWE UPADŁEŚ? Mikstura bez procentów????." , type = "atlantisError", queue = "global", timeout = 3000, layout = "atlantis"})
            end
        else
            TriggerClientEvent("pNotify:SendNotification", source, {text = "Nie masz jakże pysznych pomarańczek które nadadzą niesamowitego smaku do naszej mikstury." , type = "atlantisError", queue = "global", timeout = 3000, layout = "atlantis"})
        end
    else
        TriggerClientEvent("pNotify:SendNotification", source, {text = "Nie masz butleki w której mogłbyś przygotować tą miksturę." , type = "atlantisError", queue = "global", timeout = 3000, layout = "atlantis"}) 
    end
end)

RegisterServerEvent("craft:giveitem")
AddEventHandler("craft:giveitem", function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local komandos = xPlayer.getInventoryItem("vine2")["count"]
    if komandos < 10 then
        xPlayer.addInventoryItem("vine2", 1)
    end
end)

RegisterServerEvent("esx-ecobottles:sellBottles")
AddEventHandler("esx-ecobottles:sellBottles", function()
    local player = ESX.GetPlayerFromId(source)

    local currentBottles = player.getInventoryItem("bottle")["count"]
    
    if currentBottles > 0 then
        math.randomseed(os.time())
        local randomMoney = math.random((Config.BottleReward[1] or 1), (Config.BottleReward[2] or 4))
        local totalMoney = randomMoney * currentBottles
        player.removeInventoryItem("bottle", currentBottles)
        player.addMoney(totalMoney)

        TriggerClientEvent("pNotify:SendNotification", source, {text = "Sprzedałeś "..currentBottles.." puste butelki, za "..totalMoney , type = "atlantisOk", queue = "global", timeout = 3000, layout = "atlantis"})
    else
        TriggerClientEvent("pNotify:SendNotification", source, {text = "Nie posiadasz butelek na sprzedaż." , type = "atlantisError", queue = "global", timeout = 3000, layout = "atlantis"})
    end
end)

RegisterServerEvent("esx-ecobottles:retrieveBottle")
AddEventHandler("esx-ecobottles:retrieveBottle", function()
    local player = ESX.GetPlayerFromId(source)

    math.randomseed(os.time())
    local luck = math.random(0, 69)
    local randomBottle = math.random((Config.BottleRecieve[1] or 1), (Config.BottleRecieve[2] or 6))

    if luck >= 0 and luck <= 29 then
        TriggerClientEvent("pNotify:SendNotification", source, {text = "W tych śmieciach nic nie znajdziesz." , type = "atlantisError", queue = "global", timeout = 3000, layout = "atlantis"})
    else
        player.addInventoryItem("bottle", randomBottle)
        TriggerClientEvent('extraluck', source)
        if randomBottle > 1 then
            TriggerClientEvent("pNotify:SendNotification", source, {text = "Znaleziono: "..randomBottle.." puste butelki." , type = "atlantisOk", queue = "global", timeout = 3000, layout = "atlantis"})
        elseif randomBottle == 1 then
            TriggerClientEvent("pNotify:SendNotification", source, {text = "Znaleziono: "..randomBottle.." pustą butelkę." , type = "atlantisOk", queue = "global", timeout = 3000, layout = "atlantis"})
        end
    end
end)

RegisterServerEvent("esx-ecobottles:extraitem")
AddEventHandler("esx-ecobottles:extraitem", function()
    local player = ESX.GetPlayerFromId(source)
    player.addInventoryItem("phone", 1)
    TriggerClientEvent("pNotify:SendNotification", source, {text = "WOW! Masz dzisiaj szczęście znajdujesz sprawny telefon." , type = "atlantisOk", queue = "global", timeout = 3000, layout = "atlantis"})
end)