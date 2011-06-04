Announcer = { title = ... }

local f = CreateFrame("Frame")
f:SetScript("OnEvent", function(frame, event, ...)
  if Announcer[event] then return Announcer[event](Announcer, event, ...) end
end)
f:RegisterEvent("ADDON_LOADED")

function Announcer:Print(msg)
  print("|cff88ccdd"..self.title..":|r "..msg)
end

function Announcer:ADDON_LOADED(event, addon)
  if addon ~= self.title then return end
    
  self.playerName = UnitName("player")
  
  f:RegisterEvent("CHAT_MSG_ADDON")
  f:RegisterEvent("UI_INFO_MESSAGE")
  
  f:UnregisterEvent("ADDON_LOADED")
end

function Announcer:CHAT_MSG_ADDON(event, prefix, msg, channel, sender)
  if prefix ~= self.title or sender == self.playerName then return end
  
  UIErrorsFrame:AddMessage(sender..": "..msg, 1.0, 1.0, 0.0, 1.0)
  self:Print(sender..": |cffffff00"..msg.."|r")
end

function Announcer:UI_INFO_MESSAGE(event, msg)
  if msg and (msg:find("(.+) %(Complete%)") or msg:find("(.+): (%d+/%d+)")) then
    SendAddonMessage(self.title, msg, "PARTY")
  end
end
