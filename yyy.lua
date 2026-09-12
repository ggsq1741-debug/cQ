-- This script was generated using MoonVeil 2.0.23 [https://moonveil.cc]
local WindUI=loadstring(game:HttpGet"https://github.com/Footagesus/WindUI/releases/latest/download/main.lua")()
local Window=WindUI:CreateWindow{
    Title="\229\138\160\232\189\189\233\133\141\231\189\174",
    Author="\230\184\175\231\140\171\231\154\132\233\128\154\231\188\137",
    Folder="MyHub",
    Size=UDim2 .fromOffset(500,400),
    Theme="Dark",
    Transparent=true,
    SideBarWidth=150,
    User={
        Enabled=true
    },
    ToggleKey=Enum.KeyCode.RightShift
}
local Tabs={
    wj=Window:Tab{
        Title="\232\132\154\230\156\172\229\138\160\232\189\189\233\133\141\231\189\174\233\128\137\230\139\169\228\184\164\228\184\170\233\133\141\231\189\174\229\143\170\231\148\168\233\128\137\228\184\128\228\184\170",
        Icon="users"
    }
}
Tabs.wj:Button{
    Title="ChronixUI\229\138\160\232\189\189",
    Callback=function()
        loadstring(game:HttpGet"https://raw.githubusercontent.com/ggsq1741-debug/BAL/refs/heads/main/Kero.lua")()
    end
}
Tabs.wj:Button{
    Title="WindUI\229\138\160\232\189\189",
    Callback=function()
        loadstring(game:HttpGet"https://raw.githubusercontent.com/ggsq1741-debug/BAL/refs/heads/main/obfuscated.lua")()
    end
}