local ESX = exports['es_extended']:getSharedObject()
local playerJob = nil
local cachedWeapons = {}

local function InitializeESX()
    local xPlayer = ESX.GetPlayerData()
    playerJob = xPlayer.job.name
end

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    playerJob = xPlayer.job.name
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    playerJob = job.name
end)

local function CheckWeaponPermission(weaponHash)
    if not Config.WeaponJobList[weaponHash] then return true end
    
    if not playerJob then InitializeESX() end
    
    if cachedWeapons[weaponHash] then return cachedWeapons[weaponHash] end
    
    local hasPermission = false
    for _, allowedJob in ipairs(Config.WeaponJobList[weaponHash]) do
        if playerJob == allowedJob then
            hasPermission = true
            break
        end
    end
    
    cachedWeapons[weaponHash] = hasPermission
    return hasPermission
end

local function CheckAndRestrictWeapon(currentWeapon)
    if currentWeapon == GetHashKey("WEAPON_UNARMED") then
        cachedWeapons = {}
        return
    end

    local weaponName = nil
    for name, _ in pairs(Config.WeaponJobList) do
        if GetHashKey(name) == currentWeapon then
            weaponName = name
            break
        end
    end
    
    if weaponName and Config.WeaponJobList[weaponName] then
        local hasPermission = CheckWeaponPermission(weaponName)
        if not hasPermission then
            local playerPed = PlayerPedId()
            
            if Config.Settings.RemoveWeapon then
                RemoveWeaponFromPed(playerPed, currentWeapon)
            end

            SetCurrentPedWeapon(playerPed, GetHashKey("WEAPON_UNARMED"), true)
            
            if Config.Settings.PreventFiring then
                CreateThread(function()
                    DisablePlayerFiring(PlayerId(), true)
                    Wait(500)
                    DisablePlayerFiring(PlayerId(), false)
                end)
            end
            
            if Config.Settings.NotifyPlayer then
                ESX.ShowNotification(Config.Notification)
            end
        end
    end
end

local lastWeapon = GetHashKey("WEAPON_UNARMED")

CreateThread(function()
    while true do
        local sleep = 1000
        local playerPed = PlayerPedId()
        local currentWeapon = GetSelectedPedWeapon(playerPed)

        if IsPedArmed(playerPed, 7) then
            if currentWeapon ~= lastWeapon then
                CheckAndRestrictWeapon(currentWeapon)
                lastWeapon = currentWeapon
                sleep = 0
            else
                sleep = Config.Settings.CheckInterval
            end
        elseif lastWeapon ~= GetHashKey("WEAPON_UNARMED") then
            lastWeapon = GetHashKey("WEAPON_UNARMED")
            cachedWeapons = {}
            sleep = Config.Settings.IdleInterval
        end

        Wait(sleep)
    end
end)

AddEventHandler('playerSpawned', function()
    InitializeESX()
    cachedWeapons = {}
end)

AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end
    InitializeESX()
end)

AddEventHandler('esx:setJob', function()
    cachedWeapons = {}
    lastCheckedWeapon = nil
    local currentWeapon = GetSelectedPedWeapon(PlayerPedId())
    if currentWeapon ~= GetHashKey("WEAPON_UNARMED") then
        CheckAndRestrictWeapon(currentWeapon)
    end
end)
