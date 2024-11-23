local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Consistt/Ui/main/UnLeaked"))()
local Viewmodels = game:GetService("ReplicatedStorage"):WaitForChild("Viewmodels")
local MarketplaceService = game:GetService("MarketplaceService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local StarterGui = game:GetService("StarterGui")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local Players = game:GetService("Players")
local Debris = game:GetService("Debris")
local player = Players.LocalPlayer
local originalProperties = {}
setfpscap(5000);

-- Esp Module's
loadstring(game:HttpGet("https://pastebin.com/raw/SA5eTbF8",true))()
loadstring(game:HttpGet("https://pastebin.com/raw/1FPzSk2J",true))()
loadstring(game:HttpGet("https://pastebin.com/raw/721Lrbny",true))()
-- Username Module
loadstring(game:HttpGet("https://pastebin.com/raw/0yfMgGkH",true))()
-- Infinite Jump Module
loadstring(game:HttpGet("https://pastebin.com/raw/F71FKrQ9",true))()

local function getVersion()
    local versionURL = "https://pastebin.com/raw/ik2U2LnC"
    local versionRequest = syn and syn.request or http_request or request 
    local response = versionRequest({Url = versionURL, Method = "GET"})
    if response and response.StatusCode == 200 then
        return response.Body
    else
        return "Unknown"
    end
end

local Version = getVersion()

function ModGun(name, value)
    for i, v in pairs(ReplicatedStorage.Weapons:GetDescendants()) do
		if v.Name == name then
			v.Value = value
		end
	end
end

local flying = false
local flySpeed = 50
local bodyGyro
local bodyVelocity

local function startFlying(speed)
    if flying then return end
    flying = true
    flySpeed = speed or 50

    local character = player.Character
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    
    if not humanoidRootPart then return end

    bodyGyro = Instance.new("BodyGyro")
    bodyGyro.P = 9e4
    bodyGyro.maxTorque = Vector3.new(9e4, 9e4, 9e4)
    bodyGyro.cframe = humanoidRootPart.CFrame
    bodyGyro.Parent = humanoidRootPart

    bodyVelocity = Instance.new("BodyVelocity")
    bodyVelocity.velocity = Vector3.new(0, 0.1, 0)
    bodyVelocity.maxForce = Vector3.new(9e4, 9e4, 9e4)
    bodyVelocity.Parent = humanoidRootPart

    local userInputService = game:GetService("UserInputService")
    local flyDirection = Vector3.new(0, 0, 0)

    local function updateFlyDirection()
        local moveDirection = Vector3.new(0, 0, 0)

        if userInputService:IsKeyDown(Enum.KeyCode.W) then
            moveDirection = moveDirection - Vector3.new(0, 0, -1)
        end
        if userInputService:IsKeyDown(Enum.KeyCode.S) then
            moveDirection = moveDirection - Vector3.new(0, 0, 1)
        end
        if userInputService:IsKeyDown(Enum.KeyCode.A) then
            moveDirection = moveDirection + Vector3.new(-1, 0, 0)
        end
        if userInputService:IsKeyDown(Enum.KeyCode.D) then
            moveDirection = moveDirection + Vector3.new(1, 0, 0)
        end
        if userInputService:IsKeyDown(Enum.KeyCode.Space) then
            moveDirection = moveDirection + Vector3.new(0, 1, 0)
        end
        if userInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
            moveDirection = moveDirection + Vector3.new(0, -1, 0)
        end

        flyDirection = moveDirection
    end

    userInputService.InputBegan:Connect(updateFlyDirection)
    userInputService.InputEnded:Connect(updateFlyDirection)

    game:GetService("RunService").RenderStepped:Connect(function()
        if flying and bodyVelocity and bodyGyro then
            bodyVelocity.velocity = ((workspace.CurrentCamera.CFrame.LookVector * flyDirection.Z)
                                    + (workspace.CurrentCamera.CFrame.RightVector * flyDirection.X)
                                    + (workspace.CurrentCamera.CFrame.UpVector * flyDirection.Y)) * flySpeed
            bodyGyro.cframe = workspace.CurrentCamera.CFrame
        end
    end)
end

local function stopFlying()
    if not flying then return end
    flying = false
    if bodyGyro then bodyGyro:Destroy() end
    if bodyVelocity then bodyVelocity:Destroy() end
end

library.rank = "User"
local Wm = library:Watermark("AppleWare | Solara " .. Version ..  " | " .. library:GetUsername())
local FpsWm = Wm:AddWatermark("fps: " .. library.fps)
coroutine.wrap(function()
    while wait(.75) do
        FpsWm:Text("fps: " .. library.fps)
    end
end)()


local Notif = library:InitNotifications()

for i = 10,0,-1 do 
    task.wait(0.05)
    local LoadingXSX = Notif:Notify("Loading AppleWare | Solara "..Version..", please be patient.", 3, "information") -- notification, alert, error, success, information
end 

library.title = "AppleWare | Solara "..Version

library:Introduction()
wait(1)
local Init = library:Init()

-- Tabs

local MainTab = Init:NewTab("Main")
local Players = Init:NewTab("Player")
local Utilities = Init:NewTab("Utilities")
local Aimbot = Init:NewTab("Aimbot")
local GunMods = Init:NewTab("GunMods")
local Visuals = Init:NewTab("Visuals")
local Misc = Init:NewTab("Misc")
local Info = Init:NewTab("Info")
local Credits = Init:NewTab("Credits")

-- Labels

local ThxForUsing = MainTab:NewLabel("Thank you for using AppleWare!", "center") -- "left", "center", "right"
local PlayersMSG = Players:NewLabel("Players", "center")
local UtilitiesMSG = Utilities:NewLabel("Utilities", "center")
local AimbotMSG = Aimbot:NewLabel("Aimbot", "center")
local GunModsMSG = GunMods:NewLabel("Gun Mods", "center")
local VisualsMSG = Visuals:NewLabel("Visuals", "center")
local MiscMSG = Misc:NewLabel("Misc", "center")
local InfoMSG = Info:NewLabel("Info", "center")
local CreditsMSG = Credits:NewLabel("Credits", "center")

-- Code/Other Shit

-- Player

local SpeedSlider = Players:NewSlider("Speed", "", true, "/", {min = 18.96, max = 100, default = 18.96}, function(value)
    _G.WS = value
    local Humanoid = game:GetService("Players").LocalPlayer.Character.Humanoid;
    Humanoid:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
        Humanoid.WalkSpeed = _G.WS;
    end)
    Humanoid.WalkSpeed = _G.WS;
end)

local ResetSpeed = Players:NewButton("Reset Speed", function()
    _G.WS = 18.96
    SpeedSlider:Value(18.96)
end)

local InfiniteJump = Players:NewToggle("Infinite Jump", false, function(value)
    if value then
        _G.InfiniteJumpEnabled = true
    else
        _G.InfiniteJumpEnabled = false
    end
end)

local Flight = Players:NewToggle("Flight", false, function(value)
    if value then
        startFlying(26)
    else
        stopFlying()
    end
end)

local Noclip = Players:NewToggle("Noclip", false, function(value)
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    local RunService = game:GetService("RunService")

    _G.NoclipEnabled = value

    local function toggleNoclip()
        RunService.Stepped:Connect(function()
            if _G.NoclipEnabled and LocalPlayer.Character then
                for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            else
                for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = true
                    end
                end
            end
        end)
    end

    toggleNoclip()
end)

-- Utilities

local Rejoin = Utilities:NewButton("Rejoin", function()
    TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, player)
end)

-- Aimbot

local SilentAim = Aimbot:NewButton("Silent Aim", function()
    function getplrsname()
       for i,v in pairs(game:GetChildren()) do
           if v.ClassName == "Players" then
               return v.Name
           end
       end
   end
   local players = getplrsname()
   local plr = game[players].LocalPlayer
   coroutine.resume(coroutine.create(function()
       while  wait(1) do
           coroutine.resume(coroutine.create(function()
               for _,v in pairs(game[players]:GetPlayers()) do
                   if v.Name ~= plr.Name and v.Character then
                       v.Character.RightUpperLeg.CanCollide = false
                       v.Character.RightUpperLeg.Transparency = 10
                       v.Character.RightUpperLeg.Size = Vector3.new(13,13,13)

                       v.Character.LeftUpperLeg.CanCollide = false
                       v.Character.LeftUpperLeg.Transparency = 10
                       v.Character.LeftUpperLeg.Size = Vector3.new(13,13,13)

                       v.Character.HeadHB.CanCollide = false
                       v.Character.HeadHB.Transparency = 10
                       v.Character.HeadHB.Size = Vector3.new(13,13,13)

                       v.Character.HumanoidRootPart.CanCollide = false
                       v.Character.HumanoidRootPart.Transparency = 10
                       v.Character.HumanoidRootPart.Size = Vector3.new(13,13,13)

                   end
               end
           end))
       end
   end))
end)


local TAimbot = Aimbot:NewToggle("Aimbot", false, function(value)
    if value then
        local Camera = workspace.CurrentCamera
        local Players = game:GetService("Players")
        local RunService = game:GetService("RunService")
        local UserInputService = game:GetService("UserInputService")
        local TweenService = game:GetService("TweenService")
        local LocalPlayer = Players.LocalPlayer
        local Holding = false

        _G.AimbotEnabled = true
        _G.TeamCheck = true -- If set to true then the script would only lock your aim at enemy team members.
        _G.AimPart = "Head" -- Where the aimbot script would lock at.
        _G.Sensitivity = 0 -- How many seconds it takes for the aimbot script to officially lock onto the target's aimpart.

        local function GetClosestPlayer()
            local MaximumDistance = math.huge
            local Target = nil

            coroutine.wrap(function()
                wait(20)
                MaximumDistance = math.huge -- Reset the MaximumDistance so that the Aimbot doesn't remember it as a very small variable and stop capturing players...
            end)()

            for _, v in next, Players:GetPlayers() do
                if v.Name ~= LocalPlayer.Name then
                    if _G.TeamCheck == true then
                        if v.Team ~= LocalPlayer.Team then
                            if v.Character ~= nil then
                                if v.Character:FindFirstChild("HumanoidRootPart") ~= nil then
                                    if v.Character:FindFirstChild("Humanoid") ~= nil and v.Character:FindFirstChild("Humanoid").Health ~= 0 then
                                        local ScreenPoint = Camera:WorldToScreenPoint(v.Character:WaitForChild("HumanoidRootPart", math.huge).Position)
                                        local VectorDistance = (Vector2.new(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y) - Vector2.new(ScreenPoint.X, ScreenPoint.Y)).Magnitude

                                        if VectorDistance < MaximumDistance then
                                            Target = v
                                            MaximumDistance = VectorDistance
                                        end
                                    end
                                end
                            end
                        end
                    else
                        if v.Character ~= nil then
                            if v.Character:FindFirstChild("HumanoidRootPart") ~= nil then
                                if v.Character:FindFirstChild("Humanoid") ~= nil and v.Character:FindFirstChild("Humanoid").Health ~= 0 then
                                    local ScreenPoint = Camera:WorldToScreenPoint(v.Character:WaitForChild("HumanoidRootPart", math.huge).Position)
                                    local VectorDistance = (Vector2.new(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y) - Vector2.new(ScreenPoint.X, ScreenPoint.Y)).Magnitude

                                    if VectorDistance < MaximumDistance then
                                        Target = v
                                        MaximumDistance = VectorDistance
                                    end
                                end
                            end
                        end
                    end
                end
            end

            return Target
        end

        UserInputService.InputBegan:Connect(function(Input)
            if Input.UserInputType == Enum.UserInputType.MouseButton2 then
                Holding = true
            end
        end)

        UserInputService.InputEnded:Connect(function(Input)
            if Input.UserInputType == Enum.UserInputType.MouseButton2 then
                Holding = false
            end
        end)

        RunService.RenderStepped:Connect(function()
            if Holding == true and _G.AimbotEnabled == true then
                TweenService:Create(Camera, TweenInfo.new(_G.Sensitivity, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {CFrame = CFrame.new(Camera.CFrame.Position, GetClosestPlayer().Character[_G.AimPart].Position)}):Play()
            end
        end)
    else
        _G.AimbotEnabled = false
    end
end)

-- GunMods

local AutoGuns = GunMods:NewButton("Automatic Guns", function()
    ModGun("Auto", true)
end)

local RecoilControl = GunMods:NewButton("No Recoil", function()
    ModGun("RecoilControl", 0)
end)

local NoSpread = GunMods:NewButton("No Spread", function()
    ModGun("MaxSpread", 0)
end)

local NoReloadTime = GunMods:NewButton("No Reload Time", function()
    ModGun("ReloadTime", 0)
end)

local FireRate = GunMods:NewButton("Fire Rate", function()
    ModGun("FireRate", 0.05)
end)

local EquipTime = GunMods:NewButton("Equip Time", function()
    ModGun("EquipTime", 0)
end)

local ReloadTime = GunMods:NewButton("Reload Time", function()
    ModGun("ReloadTime", 0)
end)

local InfiniteAmmo = GunMods:NewToggle("Infinite Ammo", false, function(value)
    if value then
        wait(0.1)
        _G.ammo = true
        while _G.ammo == true do
            wait(0.1)
            local replicationstorage = game.ReplicatedStorage
            game:GetService("Players").LocalPlayer.PlayerGui.GUI.Client.Variables.ammocount.Value = 16
		    game:GetService("Players").LocalPlayer.PlayerGui.GUI.Client.Variables.ammocount2.Value = 16
        end
    else
        _G.ammo = false
        local replicationstorage = game.ReplicatedStorage
        game:GetService("Players").LocalPlayer.PlayerGui.GUI.Client.Variables.ammocount.Value = 16
		game:GetService("Players").LocalPlayer.PlayerGui.GUI.Client.Variables.ammocount2.Value = 16
    end
end)

local hidden1 = true
local hidden2 = true
local hidden3 = true

local MyFavCombo = Misc:NewButton("Creators Combo (Knife, Announcer, and Skin Changer)", function()
    game:GetService("Players").LocalPlayer.Data.Melee.Value = "Butterfly Knife"
    game:GetService("Players").LocalPlayer.Data.Announcer.Value = "Russian"
    game:GetService("Players").LocalPlayer.Data.Skin.Value = "Annihilator"
end)

local KnifeChanger = Misc:NewSelector("Knife Changer", "Dagger", {"Dagger", "Butterfly Knife", "Tomahawk", "Karambit", "Brass Knuckles", "Fisticuffs", "Bat", "Shuffle", "Machete", "Space Katana", "Racket", "Pan", "Killbrick Melee", "Ban Hammer", "Scythe", "Chainsaw", "Claws", "Energy Blade", "Kitchen Knife", "Pitchfork", "Rubber Hammer", "Classic Sword", "Swordfish", "Silver Bell", "Icicle", "Coal Sword", "Pencil", "Candy Cane", "Sickle", "Toy Tree", "Kunai", "Kukri", "Gaster Blaster", "Mop", "Bouquet", "SuperSpaceKatana", "Shovel", "Tactical Knife", "Combat Knife", "Sledgehammer", "Katar", "Paddle", "Wrench", "Newspaper", "Saber", "Katana", "Calculator", "Baton", "Literal Melee", "Rokia Hammer", "ACT Trophy", "Crucible", "Bloxy", "Endbringer", "Energy Katar", "Frog", "Moderation Hammer", "Da Melee", "Handy Candy", "Fire Poker", "Electronic Stake", "Pumpkin Staff", "Candleabra", "Pumpkin Bucket", "Balloon Sword", "Garlic Kebab", "Candy Cane Sword", "Coal Scythe", "Candy Cane Claws", "Glacier Blade", "Peppermint Hammer", "Mittens", "Wooden Spoon", "Banana", "The Darkheart", "Delinquent Pop", "Big Sip", "FOAM BLADE 3000", "Sabre", "Rapier", "Blade", "Bat Axe", "Fish", "Khopesh", "Golden Rings", "The Illumina", "The Venomshank", "The Firebrand", "The Ghostwalker", "The Windforce", "The Ice Dagger", "Slicecicle", "Swift End", "Divinity", "Night's Edge", "When Day Breaks", "Moai", "Heart Break", "Nomad's Blade", "Reclaimer", "Annihilator's Broken Sword", "Harvester", "Crowbar", "Rebel's Bat", "Leader's Axe", "Stranger's Handblades", "Roughian's Pipe", "Handblades", "Wired Bat", "Makeshift Axe", "Rusty Pipe", "Aged Shovel", "Brick", "Pumpkin Axe", "Bone Club", "Hero's Sword", "Halberd", "Reliable Hammer", "Let The Skies Fall", "Carrot", "Gingerbread Knife", "Seal", "Assimilator", "Doodle Sign", "Digi-Blade", "Sip O' Stink", "Bunny Staff", "Easter Cleaver", "Egg", "Spring Greatsword", "The Scrambler", "Smug Egg", "OG Space Katana", "R.A.M", "Synthlight Greatsword", "Death's Blade", "Grumpy Hammer", "Loaf", "The Fool's Tool", "Hallow's Scythe", "Stinger", "Ghost Ripper", "Daito", "Blast Hammer", "Doublade", "Electric Flail", "Electro Axe", "Slappy"}, function(value)
    game:GetService("Players").LocalPlayer.Data.Melee.Value = value
end)

local Announcers = Misc:NewSelector("Announcer Changer", "Default", {"Default", "Warcrimes", "YouTuber", "Homeless", "American", "British", "Russian", "Movie Man", "xonae", "John", "Flamingo", "Eprika", "Shuffle", "Petrify", "Bandites", "Santa", "Murderous Child", "Weesnaw", "Hackula", "Jolly Narrator", "Carnival Carnie"}, function(value)
    game:GetService("Players").LocalPlayer.Data.Announcer.Value = value
end)

local SkinChanger = Misc:NewSelector("SkinChanger", "Delinquent That's Cool", {"Beret", "Delinquent That's Cool", "Mobster", "Rabblerouser", "Soldier", "Woods", "Recruit", "Smiles", "Vampire", "John Brick", "Handsome Hoss", "Campbell", "Communicator", "Desperado", "Partygoer", "Santa", "Paintballer", "Fro", "The One", "Rough Houser", "Admin", "Wanderer", "Trainer", "Pirate", "Ninja", "Luchador", "Broadcaster", "BrickBattle", "Anarchist", "Trooper", "Contractor", "Veteran", "King", "Queen", "Marksman", "Shock Force", "Commando", "Phoenix", "Ace Pilot", "Detective", "Snake Eater", "Scarecrow", "Fanboy", "Delinquent", "Throwback Rabblerouser", "Poke", "Shuffle", "Boomer Delinquent", "Cthulhu", "Magician", "Lumberjack", "Corporal", "Secret Agent", "Operative", "Weeb Delinquent", "Summer Woods", "Summer Rabblerouser", "Firefighter", "Shark", "Summer Delinquent", "Material Man", "Flanker", "Uncle Sam", "Kingpin", "Scientist", "Track Star", "Gentleman", "Hidden Star", "Beard", "Alien", "Farmer", "Pizza Boy", "Cow", "Anna", "Smug Zam", "Chef", "Gladiator", "Golf Pro", "Kyle", "Rhino", "Tennis Star", "Corn Cob", "Retro Zombie", "Clown", "Deadlinquent", "Cultist", "Slasher", "Slayer", "Horseman", "Plague Doctor", "Halloween Vampire", "Farmer Scarecrow", "Shinobi", "Red Panda", "Crusader", "Runner", "The Trooper", "Arsonist", "Annihilator", "Brute", "Mechanic", "Doctor", "The Marksman", "Agent", "Funky Monkey", "Long Neck Mobster", "Noodle Man", "Super Bee", "Woods with Drip", "John", "Throwback Delinquent", "Joe", "The Boi", "Holiday Panda", "Holiday Pilot", "Iceborne", "Robot Santa", "Penguini", "Arctic Excavator", "Elflinquent", "Festive Partygoer", "Frosty Smiles", "Ginger-War-Man", "Jockey", "Rioter", "Mini-Gunner", "Private Eye", "Animatronic Dealer", "Entertainer", "Skullberto", "R01-V3 Bot", "Professor", "Performer", "GOC Past", "GOC Present", "GOC Future", "Skullrita", "Viking", "Wizard", "IceBorne", "Hallowed Scarecrow", "Weenie", "Sans", "Yeplash", "Builder", "Janitor", "Seeker of Hearts", "Bachelor Joe", "Jackeryz", "Hitman", "Labourer", "Manufacturer", "News Boy", "News Girl", "Sailor", "Worker", "Gal", "Brick Layer", "Aviator", "Jester Entertainer", "Jester Performer", "Breacher", "Ghillie", "Grunt", "Merc", "Rookie", "Bloxy Delinquent", "Delinquent with No Brim", "Ronaldinho Soccer", "Monky", "Froggy", "Beach Bum", "Garbage Handler", "Icecream Man", "Phantom Thief Magician", "Sightseer", "Tourist", "Trash Worker", "Unga Bunga", "Weightlifter", "Baseball Star", "Football Star", "Soccer Star", "Volleyball Star", "Surfer", "Rider Brute", "Grill Master Chef", "Fro Vice", "Deserted Beret", "Mad Scientist", "Primus The Knight", "Beezul", "Doug", "Mamor", "Spidra", "Cait", "Mothree", "Beelzebub", "Wendigo", "Mania", "Fire Golem", "Chupacabra", "Bigfoot", "Waike Delinquent", "Silent Bot", "Cyber Defence Unit", "Cyber Hero", "Cyber Mercenary", "Cyber Punk", "Rider", "Robo Sorcerer", "Casual Bot", "Digital Warrior", "Space Soldier", "Alien In Disguise", "Segg", "Holiday Scarecrow", "Alchemist Plague Doctor", "Beckoned Pirate", "Fallen Veteran", "Frank", "Gaslight Detective", "Marionette", "Molten Slasher", "Reaper", "RottingRouser", "Tetra", "Agetha", "Boogey Man", "DotD Skullberto", "DotD Skullrita", "Ghastelle", "Gnome", "Grug", "Hazmat", "Mummy", "Phantina", "Pumpking", "Skullmander", "Vahn", "Witch", "Zombella", "Zombert", "Ghost of Developing", "Hackula", "Elf Rabblerouser", "Krampus", "Mrs. Claus", "Snowboarder Kyle", "Toy Soldier", "Enraged Myboe", "Rambo Santa", "Holiday Worker", "Zack", "Christmas Nomad", "Northern Crusader", "Reindeer", "Snowman", "Scrooge", "Lynn", "Winter Anarchist", "Holiday Labourer", "Ski Star", "Jolly Penguini", "Myboe", "Festive Phantina", "Festive Ghastelle", "Dealer", "Animatronic Rabblerouser", "Animatronic Performer", "Animatronic Ninja", "Slaughter Delinquent", "Tech-Head", "Suspicious Stranger", "Bernard", "KillBrick", "Nonexisty", "Tomfoolery Delinquent", "Segg with Drip", "Captain Joe", "Shooker Man", "AClinquent", "Garcello", "Monky With Drip", "Monky Fan", "Reference Delinquent", "Ikuno Pilot", "Ichigo Pilot", "Da Monky", "Buff BrickBattle", "BuffBattle", "Punk Rioter", "Ranger Hoss", "Ranger Desperado", "Lumber Jacked", "Appearance", "Dart Warrior", "Astronut", "Xavier", "Taylor", "Sarah", "Octayah", "Nutty News Caster", "Normal Human", "Nevaeh", "Lenny", "Isaiah", "Crackles", "Cheer Star", "Abandoned Recruit", "Alchemist", "The Conglomerate", "Barbarian", "Blake", "Brawler Rough Houser", "Chief Mate", "Crew Mate", "Ghoulish Diver", "Dread Commando", "Fun-Gus", "Ghastly Sheet", "Goog The Goblin", "Gorgon", "Guest", "Heathen", "Heister", "Hunting Hood", "Incandesa", "Invisible Man", "Jailor", "Jinn", "Lone Wanderer", "Nez", "Noble Spirit", "Noodle", "Prime Gentleman", "Pumpi", "Pumpo", "Quarter Master", "Rafael", "Sayo", "Seagee", "Skeletal Bandit", "The Observer", "Toy Army", "Truhthulu", "Wraps", "Nether Shinobi", "Nether Ninja", "Hollow Haunter", "Herobrine Delinquent", "Hackula DX", "Holiday News Girl", "Holiday News Boy", "Roughian Flanker", "Toy Soldier Nutcracker", "Snow-Op Beard", "Contestant", "Mimic", "Fern", "Winter Wisp", "Snowball Warrior", "Sir. Winter", "Father Time", "Ice Golem", "Victory Bell", "Jolly Singer", "Merry Singer", "Mr. Moon", "Mall Santa", "Bishop Of Time", "Sasquatch", "Arbiter", "Seeker Of Hearts", "Flanker That's Cool", "Nomad", "The Saint", "Oscar", "Bucket Knight", "Crook", "Gardener", "Goro", "Hero of None", "ILLO", "Investigator", "Mother Nature", "Planter", "Rex", "Treasure Hunter", "Adventurer", "Da Monky With Drip", "Nexus Nez", "Nexus Jen", "Nexus Katsu", "Nexus Jackson", "Crow Tender", "HE", "Hazard", "Irza", "No-One", "Pump-Borg", "Scratch", "Tai", "Tender", "The Forgotten", "Warden", "Wilhelm", "Fate", "Hand-Craft", "Heartless", "Lamb", "Pepper Mc'Cool", "Stella", "Tadashi", "Book Keeper", "Jonah", "Mallo", "Missing", "Missing", "Myra", "Naughty Lister", "Nice Lister", "North Star", "Snow Queen", "Wind-Up", "Woodsman", "Mug", "Shard", "Bacon", "Chaos Wizard", "Club Member", "Height Fighter", "HolyPex", "Jon", "Kettlemen", "Splatter", "Retro Horseman", "Retro Mobster", "Retro Ninja", "Retro Viking", "Retro Wizard", "8-UNNY", "Tomfoolery Rabblerouser", "Spirit Of Spring", "Day Walker Vampire", "Naga", "The Designer", "Long Day Farmer", "Figure Head", "Jelly Jam", "Jungle Fighter", "NOT Eggs", "Seedling", "Fisher", "Holiday Castlers", "Hope", "Vengeance", "Hunger", "Jealousy", "Lethargy", "The Acrobat", "The Brave", "The Fool", "The Master", "The Mystic", "The Strong", "Ego", "Avarice", "Overtone", "Frogger", "Batz", "Comedy", "Goatman", "Sorcerer", "Tragedy", "Vagrant", "Castlers", "Arctic Occupier", "Night Cap", "Holiday Performer", "Allocator", "Scavenger", "Scavenger", "Demolitionist", "M.P C-Grade", "Lt. Baron", "Recovery Unit", "Excavator", "Cephalokin Recon", "Cephalokin Elite", "ESM P.Unit", "Corporate Exec", "ESM G.Unit", "Firewall", "Classic Delinquent", "Classic Girl", "Check It Guy", "1x1x1x1"}, function(value)
    game:GetService("Players").LocalPlayer.Data.Skin.Value = value
end)

local HideNShowKnifeChanger = Misc:NewButton("Show/Hide Knife Changer", function()
    if hidden1 == false then
        hidden1 = true
        KnifeChanger:Hide()
    else
        hidden1 = false
        KnifeChanger:Show()
    end
end)

local HideNShowAnnouncer = Misc:NewButton("Show/Hide Announcer Changer", function()
    if hidden2 == false then
        hidden2 = true
        Announcers:Hide()
    else
        hidden2 = false
        Announcers:Show()
    end
end)

local HideNShowSkinChanger = Misc:NewButton("Show/Hide Skin Changer", function()
    if hidden3 == false then
        hidden3 = true
        SkinChanger:Hide()
    else
        hidden3 = false
        SkinChanger:Show()
    end
end)

-- Visuals

local BoxEsp = Visuals:NewToggle("Box ESP", false, function(value)
    _G.on = value
end)



local corner = Visuals:NewToggle("Corner Esp", false, function(value)
    _G.corner = value
end)


local FillBoxes = Visuals:NewToggle("Fill Boxes (a lil goofy)", false, function(value)
    _G.Filled = value
end)

local Usernames = Visuals:NewToggle("Show Usernames", false, function(value)
    _G.ShowUsernames = value
end)

local tracerScriptAlreadyLoaded = false

local Tracers = Visuals:NewToggle("Tracers", false, function(value)
    if value then
        if not tracerScriptAlreadyLoaded then
            loadstring(game:HttpGet("https://raw.githubusercontent.com/AppleWare/AppleWare/main/Tracers.lua",true))()
            tracerScriptAlreadyLoaded = true
        end
        _G.TracersVisible = true
        _G.TeamCheck = true
    else
        _G.TracersVisible = false
        _G.TeamCheck = false
    end
end)

local TracerThickness = Visuals:NewSlider("Tracer Thickness", "", true, "/", {min = 1, max = 5, default = 1}, function(value)
    _G.TracerThickness = value
end)

-- Misc

local Viewmodels = game:GetService("ReplicatedStorage"):WaitForChild("Viewmodels")
local originalProperties = {}

-- Function to save the original properties
local function saveOriginalProperties(model)
for _, item in pairs(model:GetDescendants()) do
if item:IsA("BasePart") then
originalProperties[item] = {
Material = item.Material,
Color = item.Color
}
end
end
end

-- Function to change the material and color of the parts
local function changeMaterialAndColor(model, color)
for _, item in pairs(model:GetDescendants()) do
if item:IsA("BasePart") then
item.Material = Enum.Material.Neon
item.Color = color
end
end
end

-- Function to revert to the original properties
local function revertToOriginalProperties(model)
for _, item in pairs(model:GetDescendants()) do
if item:IsA("BasePart") and originalProperties[item] then
item.Material = originalProperties[item].Material
item.Color = originalProperties[item].Color
end
end
end

local ChangeGunColor = Misc:NewButton("Color Changer", false, function(value)
    for _, item in pairs(Viewmodels:GetChildren()) do
        if item:IsA("Model") and item.Name ~= "Arms" then
            if value then
                saveOriginalProperties(item)
                changeMaterialAndColor(item, Color3.FromRGB(255, 255, 255))
            else
                revertToOriginalProperties(item)
            end
        end
    end
end)

-- Info

local JoinDiscord = Info:NewButton("Join Discord", function()
    setclipboard("https://discord.gg/DwTyG5YKY5")
            local Request = syn and syn.request or request
            Request({
                Url = "http://127.0.0.1:6463/rpc?v=1",
                Method = "POST",
                Headers = {
                    ["Content-Type"] = "application/json",
                    ["Origin"] = "https://discord.com"
                },
                Body = game.HttpService:JSONEncode({
                    cmd = "INVITE_BROWSER",
                    args = {
                        code = "DwTyG5YKY5"
                    },
                    nonce = game.HttpService:GenerateGUID(false)
                }),
            })
end)

-- Credits

local starxzzy = Credits:NewLabel("starxzzy | Owner/Scripter", "left")
local spagetti57 = Credits:NewLabel("spagetti57/Yz Star | Co-Owner", "left")
local szcx6 = Credits:NewLabel("szcx6/Cheesus V2 | Scripter", "left")

local FinishedLoading = Notif:Notify("Loaded AppleWare | Solara", 4, "success")

wait(5)

KnifeChanger:Hide()
Announcers:Hide()
SkinChanger:Hide()
