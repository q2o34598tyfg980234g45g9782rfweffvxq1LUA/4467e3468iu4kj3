getfenv().hbe = true
    if getfenv().hbe == true then
    local mt = getrawmetatable(game);
    make_writeable(mt);
    local old_index = mt.__index;
    
    mt.__index = function(a, b)
    if tostring(a) == "HumanoidRootPart" then
    if tostring(b) == "Size" then
    return Vector3.new(0,0,0 );
    end
    end
    return old_index(a, b);
    end
    
    
    
    
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
    
        

    
    
    
    local Extender = {};
    Extender.__index = Extender;
    
    Extender.new = function(Character, Player)
        local HRP = Character:FindFirstChild("HumanoidRootPart");
    end
    end
end
