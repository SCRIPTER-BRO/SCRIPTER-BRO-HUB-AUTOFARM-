-- ==================================================
-- SCRIPTER BRO HUB | PART 1/5
-- Config + UI + Components + Tabs Manager
-- ==================================================

_G.YOKUDO = {
    Name = "SCRIPTER BRO HUB",
    Version = "Discord: discord.gg/NaQArhFZy",
    Author = "SCRIPTER BRO",
    AssetID = "",
    UI = {
        Width = 480, Height = 340, SidebarWidth = 115, TabHeight = 32,
        Theme = {
            Background = Color3.fromRGB(14, 15, 24),
            Sidebar = Color3.fromRGB(20, 18, 34),
            TopBar = Color3.fromRGB(31, 22, 49),
            Accent = Color3.fromRGB(168, 85, 247),
            Text = Color3.fromRGB(255, 255, 255),
            SubText = Color3.fromRGB(145, 145, 165),
        }
    },
}

do
    local Services = {
        Players = game:GetService("Players"),
        TweenService = game:GetService("TweenService"),
        UserInputService = game:GetService("UserInputService"),
        RunService = game:GetService("RunService"),
        CoreGui = game:GetService("CoreGui"),
    }

    local Settings = _G.YOKUDO
    local Theme = Settings.UI.Theme

    local GuiParent = Services.CoreGui
    pcall(function()
        if type(gethui) == "function" then
            local HUI = gethui()
            if HUI then GuiParent = HUI end
        end
    end)

    pcall(function()
        local Old = GuiParent:FindFirstChild("YOKUDO_HUB")
        if Old then Old:Destroy() end
        local OldToggle = GuiParent:FindFirstChild("ToggleGUI")
        if OldToggle then OldToggle:Destroy() end
    end)

    -- ============ Toggle Button (FIXED: TextButton not ImageButton) ============
    local ToggleScreenGui = Instance.new("ScreenGui")
    ToggleScreenGui.Name = "ToggleGUI"
    ToggleScreenGui.ResetOnSpawn = false
    ToggleScreenGui.IgnoreGuiInset = true
    ToggleScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ToggleScreenGui.Parent = GuiParent

    local Toggle = Instance.new("TextButton")  -- ✅ FIXED
    Toggle.Name = "SB_Toggle"
    Toggle.Size = UDim2.new(0, 55, 0, 55)
    Toggle.Position = UDim2.new(0.02, 0, 0.5, -27.5)
    Toggle.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    Toggle.BorderSizePixel = 0
    Toggle.Text = "SB"                          -- ✅ يعمل الآن
    Toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
    Toggle.TextSize = 20
    Toggle.Font = Enum.Font.GothamBlack
    Toggle.AutoButtonColor = false
    Toggle.ZIndex = 999
    Toggle.Parent = ToggleScreenGui

    local ToggleCorner = Instance.new("UICorner")
    ToggleCorner.CornerRadius = UDim.new(1, 0)
    ToggleCorner.Parent = Toggle

    local ToggleStroke = Instance.new("UIStroke")
    ToggleStroke.Color = Color3.fromRGB(168, 85, 247)
    ToggleStroke.Thickness = 1.5
    ToggleStroke.Transparency = 0.2
    ToggleStroke.Parent = Toggle

    -- ============ Main GUI ============
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "YOKUDO_HUB"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.IgnoreGuiInset = true
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.DisplayOrder = 999
    ScreenGui.Parent = GuiParent

    local Main = Instance.new("Frame")
    Main.Name = "Main"
    Main.Size = UDim2.new(0, Settings.UI.Width, 0, Settings.UI.Height)
    Main.Position = UDim2.new(0.5, -Settings.UI.Width / 2, 0.5, -Settings.UI.Height / 2)
    Main.BackgroundColor3 = Theme.Background
    Main.BorderSizePixel = 0
    Main.ClipsDescendants = true
    Main.Active = true
    Main.Parent = ScreenGui

    local MainCorner = Instance.new("UICorner")
    MainCorner.CornerRadius = UDim.new(0, 0)
    MainCorner.Parent = Main

    local MainBorder = Instance.new("UIStroke")
    MainBorder.Color = Color3.fromRGB(168, 85, 247)
    MainBorder.Thickness = 2
    MainBorder.Transparency = 0.1
    MainBorder.Parent = Main

    -- TopBar
    local TopBar = Instance.new("Frame")
    TopBar.Name = "TopBar"
    TopBar.Size = UDim2.new(1, 0, 0, 58)
    TopBar.BackgroundColor3 = Theme.TopBar
    TopBar.BorderSizePixel = 0
    TopBar.Active = true
    TopBar.ZIndex = 20
    TopBar.Parent = Main

    local TopGradient = Instance.new("UIGradient")
    TopGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(65, 35, 96)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(25, 18, 38))
    })
    TopGradient.Parent = TopBar

    local TopLine = Instance.new("Frame")
    TopLine.Size = UDim2.new(1, 0, 0, 2)
    TopLine.Position = UDim2.new(0, 0, 1, -2)
    TopLine.BackgroundColor3 = Color3.fromRGB(168, 85, 247)
    TopLine.BackgroundTransparency = 0.2
    TopLine.BorderSizePixel = 0
    TopLine.ZIndex = 22
    TopLine.Parent = TopBar

    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, -36, 0, 27)
    Title.Position = UDim2.new(0, 18, 0, 7)
    Title.BackgroundTransparency = 1
    Title.Text = Settings.Name
    Title.TextColor3 = Theme.Text
    Title.TextSize = 18
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Font = Enum.Font.GothamBold
    Title.ZIndex = 21
    Title.Parent = TopBar

    local Subtitle = Instance.new("TextLabel")
    Subtitle.Size = UDim2.new(1, -36, 0, 18)
    Subtitle.Position = UDim2.new(0, 18, 0, 32)
    Subtitle.BackgroundTransparency = 1
    Subtitle.Text = Settings.Version
    Subtitle.TextColor3 = Theme.SubText
    Subtitle.TextSize = 10
    Subtitle.TextXAlignment = Enum.TextXAlignment.Left
    Subtitle.Font = Enum.Font.GothamMedium
    Subtitle.ZIndex = 21
    Subtitle.Parent = TopBar

    -- Sidebar
    local Sidebar = Instance.new("Frame")
    Sidebar.Name = "Sidebar"
    Sidebar.Size = UDim2.new(0, Settings.UI.SidebarWidth, 1, -58)
    Sidebar.Position = UDim2.new(0, 0, 0, 58)
    Sidebar.BackgroundColor3 = Theme.Sidebar
    Sidebar.BorderSizePixel = 0
    Sidebar.ZIndex = 5
    Sidebar.Parent = Main

    local SidebarLine = Instance.new("Frame")
    SidebarLine.Size = UDim2.new(0, 2, 1, 0)
    SidebarLine.Position = UDim2.new(1, -2, 0, 0)
    SidebarLine.BackgroundColor3 = Color3.fromRGB(168, 85, 247)
    SidebarLine.BackgroundTransparency = 0.15
    SidebarLine.BorderSizePixel = 0
    SidebarLine.ZIndex = 6
    SidebarLine.Parent = Sidebar

    local TabScroll = Instance.new("ScrollingFrame")
    TabScroll.Name = "TabScroll"
    TabScroll.Size = UDim2.new(1, 0, 1, 0)
    TabScroll.BackgroundTransparency = 1
    TabScroll.BorderSizePixel = 0
    TabScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
    TabScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
    TabScroll.ScrollingDirection = Enum.ScrollingDirection.Y
    TabScroll.ScrollBarThickness = 0
    TabScroll.Active = true
    TabScroll.ZIndex = 6
    TabScroll.Parent = Sidebar

    local TabPadding = Instance.new("UIPadding")
    TabPadding.PaddingTop = UDim.new(0, 6)
    TabPadding.PaddingBottom = UDim.new(0, 6)
    TabPadding.PaddingLeft = UDim.new(0, 2)
    TabPadding.PaddingRight = UDim.new(0, 2)
    TabPadding.Parent = TabScroll

    local TabList = Instance.new("UIListLayout")
    TabList.Padding = UDim.new(0, 2)
    TabList.SortOrder = Enum.SortOrder.LayoutOrder
    TabList.Parent = TabScroll

    local Content = Instance.new("Frame")
    Content.Name = "Content"
    Content.Size = UDim2.new(1, -Settings.UI.SidebarWidth, 1, -58)
    Content.Position = UDim2.new(0, Settings.UI.SidebarWidth, 0, 58)
    Content.BackgroundColor3 = Theme.Background
    Content.BorderSizePixel = 0
    Content.ZIndex = 5
    Content.Parent = Main

    _G.YOKUDO_Main = Main
    _G.YOKUDO_TopBar = TopBar
    _G.YOKUDO_TabScroll = TabScroll
    _G.YOKUDO_Content = Content
    _G.YOKUDO_ScreenGui = ScreenGui
    _G.YOKUDO_Toggle = Toggle
    _G.YOKUDO_GuiParent = GuiParent

    -- Drag System
    local Dragging, DragStart, StartPosition, ActiveTouch = false, nil, nil, nil

    local function StartDrag(Input)
        if Dragging then return end
        if Input.UserInputType == Enum.UserInputType.Touch then ActiveTouch = Input end
        Dragging = true
        DragStart = Input.Position
        StartPosition = Main.Position
    end

    local function StopDrag()
        Dragging = false; ActiveTouch = nil; DragStart = nil; StartPosition = nil
    end

    TopBar.InputBegan:Connect(function(Input)
        if Input.UserInputType == Enum.UserInputType.MouseButton1 or
           Input.UserInputType == Enum.UserInputType.Touch then StartDrag(Input) end
    end)

    local function CreateDragZone(Name, Position, Size)
        local Zone = Instance.new("Frame")
        Zone.Name = Name
        Zone.Position = Position
        Zone.Size = Size
        Zone.BackgroundTransparency = 1
        Zone.BorderSizePixel = 0
        Zone.Active = true
        Zone.ZIndex = 50
        Zone.Parent = Main
        Zone.InputBegan:Connect(function(Input)
            if Input.UserInputType == Enum.UserInputType.MouseButton1 or
               Input.UserInputType == Enum.UserInputType.Touch then StartDrag(Input) end
        end)
    end

    CreateDragZone("DragTop", UDim2.new(0, 0, 0, 0), UDim2.new(1, 0, 0, 5))
    CreateDragZone("DragBottom", UDim2.new(0, 0, 1, -5), UDim2.new(1, 0, 0, 5))
    CreateDragZone("DragLeft", UDim2.new(0, 0, 0, 0), UDim2.new(0, 5, 1, 0))
    CreateDragZone("DragRight", UDim2.new(1, -5, 0, 0), UDim2.new(0, 5, 1, 0))

    Services.UserInputService.InputChanged:Connect(function(Input)
        if not Dragging then return end
        if Input.UserInputType == Enum.UserInputType.Touch then
            if ActiveTouch and Input ~= ActiveTouch then return end
        end
        if not DragStart or not StartPosition then return end
        if Input.UserInputType ~= Enum.UserInputType.MouseMovement and
           Input.UserInputType ~= Enum.UserInputType.Touch then return end
        local Delta = Input.Position - DragStart
        Main.Position = UDim2.new(
            StartPosition.X.Scale, StartPosition.X.Offset + Delta.X,
            StartPosition.Y.Scale, StartPosition.Y.Offset + Delta.Y
        )
    end)

    Services.UserInputService.InputEnded:Connect(function(Input)
        if Input.UserInputType == Enum.UserInputType.Touch then
            if ActiveTouch and Input == ActiveTouch then StopDrag() end
            return
        end
        if Input.UserInputType == Enum.UserInputType.MouseButton1 then
            if Dragging then StopDrag() end
        end
    end)

    -- Toggle Drag
    local TDrag, TDragStart, TStartPos, TActiveTouch = false, nil, nil, nil

    Toggle.InputBegan:Connect(function(Input)
        if Input.UserInputType == Enum.UserInputType.MouseButton1 or
           Input.UserInputType == Enum.UserInputType.Touch then
            if TDrag then return end
            if Input.UserInputType == Enum.UserInputType.Touch then TActiveTouch = Input end
            TDrag = true
            TDragStart = Input.Position
            TStartPos = Toggle.Position
        end
    end)

    Services.UserInputService.InputChanged:Connect(function(Input)
        if not TDrag then return end
        if Input.UserInputType == Enum.UserInputType.Touch then
            if TActiveTouch and Input ~= TActiveTouch then return end
        end
        if not TDragStart or not TStartPos then return end
        if Input.UserInputType ~= Enum.UserInputType.MouseMovement and
           Input.UserInputType ~= Enum.UserInputType.Touch then return end
        local Delta = Input.Position - TDragStart
        Toggle.Position = UDim2.new(
            TStartPos.X.Scale, TStartPos.X.Offset + Delta.X,
            TStartPos.Y.Scale, TStartPos.Y.Offset + Delta.Y
        )
    end)

    Services.UserInputService.InputEnded:Connect(function(Input)
        if Input.UserInputType == Enum.UserInputType.Touch then
            if TActiveTouch and Input == TActiveTouch then
                TDrag = false; TActiveTouch = nil; TDragStart = nil; TStartPos = nil
            end
            return
        end
        if Input.UserInputType == Enum.UserInputType.MouseButton1 then
            if TDrag then TDrag = false TDragStart = nil TStartPos = nil end
        end
    end)

    -- Toggle Show/Hide
    local isUIVisible = true
    Toggle.MouseButton1Click:Connect(function()
        isUIVisible = not isUIVisible
        ScreenGui.Enabled = isUIVisible
    end)
end

-- ============ Components ============
function CreateTab(Name, Order)
    local Tab = Instance.new("TextButton")
    Tab.Name = Name:gsub("%s+", "_") .. "_Tab"
    Tab.Size = UDim2.new(1, 0, 0, 32)
    Tab.BackgroundColor3 = Color3.fromRGB(38, 40, 52)
    Tab.BackgroundTransparency = 1
    Tab.BorderSizePixel = 0
    Tab.Text = ""
    Tab.AutoButtonColor = false
    Tab.LayoutOrder = Order or 1
    Tab.ZIndex = 7
    Tab.Parent = _G.YOKUDO_TabScroll

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 6)
    Corner.Parent = Tab

    local TabBorder = Instance.new("UIStroke")
    TabBorder.Color = Color3.fromRGB(168, 85, 247)
    TabBorder.Thickness = 1
    TabBorder.Transparency = 0.2
    TabBorder.Parent = Tab

    local Indicator = Instance.new("Frame")
    Indicator.Name = "Indicator"
    Indicator.Size = UDim2.new(0, 3, 0, 18)
    Indicator.Position = UDim2.new(0, 2, 0.5, -9)
    Indicator.BackgroundColor3 = Color3.fromRGB(168, 85, 247)
    Indicator.BackgroundTransparency = 1
    Indicator.BorderSizePixel = 0
    Indicator.ZIndex = 8
    Indicator.Parent = Tab

    local IndicatorCorner = Instance.new("UICorner")
    IndicatorCorner.CornerRadius = UDim.new(1, 0)
    IndicatorCorner.Parent = Indicator

    local Text = Instance.new("TextLabel")
    Text.Name = "TabText"
    Text.Size = UDim2.new(1, -10, 1, 0)
    Text.Position = UDim2.new(0, 8, 0, 0)
    Text.BackgroundTransparency = 1
    Text.Text = Name
    Text.TextColor3 = Color3.fromRGB(155, 155, 175)
    Text.TextSize = (#Name >= 13 and 11) or (#Name >= 9 and 12) or 13
    Text.TextXAlignment = Enum.TextXAlignment.Left
    Text.TextYAlignment = Enum.TextYAlignment.Center
    Text.Font = Enum.Font.GothamMedium
    Text.TextTruncate = Enum.TextTruncate.AtEnd
    Text.ZIndex = 8
    Text.Parent = Tab

    return Tab
end

function CreatePage(Name)
    local Page = Instance.new("ScrollingFrame")
    Page.Name = Name .. "_Page"
    Page.Size = UDim2.new(1, 0, 1, 0)
    Page.BackgroundTransparency = 1
    Page.BorderSizePixel = 0
    Page.Visible = false
    Page.CanvasSize = UDim2.new(0, 0, 0, 0)
    Page.AutomaticCanvasSize = Enum.AutomaticSize.Y
    Page.ScrollingDirection = Enum.ScrollingDirection.Y
    Page.ScrollBarThickness = 4
    Page.ScrollBarImageColor3 = Color3.fromRGB(168, 85, 247)
    Page.ScrollBarImageTransparency = 0.1
    Page.VerticalScrollBarInset = Enum.ScrollBarInset.Always
    Page.Active = true
    Page.ZIndex = 6
    Page.Parent = _G.YOKUDO_Content

    local Padding = Instance.new("UIPadding")
    Padding.PaddingTop = UDim.new(0, 12)
    Padding.PaddingBottom = UDim.new(0, 14)
    Padding.PaddingLeft = UDim.new(0, 14)
    Padding.PaddingRight = UDim.new(0, 12)
    Padding.Parent = Page

    local List = Instance.new("UIListLayout")
    List.Padding = UDim.new(0, 4)
    List.SortOrder = Enum.SortOrder.LayoutOrder
    List.Parent = Page

    return Page
end

function CreateSectionTitle(Parent, TextValue, Order)
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, 0, 0, 23)
    Label.BackgroundTransparency = 1
    Label.Text = TextValue
    Label.TextColor3 = Color3.fromRGB(235, 235, 245)
    Label.TextSize = 13
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.TextYAlignment = Enum.TextYAlignment.Center
    Label.Font = Enum.Font.GothamBold
    Label.LayoutOrder = Order or 1
    Label.ZIndex = 8
    Label.Parent = Parent
    return Label
end

-- ============ Tabs Manager ============
do
    local TweenService = game:GetService("TweenService")
    local TabsManager = {}
    TabsManager.Tabs = {}

    function TabsManager:RegisterTab(Name, Order, PageName)
        local Tab = CreateTab(Name, Order)
        local Page = CreatePage(PageName or Name:upper())
        table.insert(self.Tabs, { Tab = Tab, Page = Page, Name = Name })
        Tab.MouseButton1Click:Connect(function() self:SelectTab(Tab, Page) end)
        return Tab, Page
    end

    function TabsManager:SelectTab(SelectedTab, SelectedPage)
        for _, data in ipairs(self.Tabs) do
            data.Page.Visible = false
            local Indicator = data.Tab:FindFirstChild("Indicator")
            local TabText = data.Tab:FindFirstChild("TabText")
            TweenService:Create(data.Tab, TweenInfo.new(0.15), {BackgroundTransparency = 1}):Play()
            if Indicator then TweenService:Create(Indicator, TweenInfo.new(0.15), {BackgroundTransparency = 1}):Play() end
            if TabText then TweenService:Create(TabText, TweenInfo.new(0.15), {TextColor3 = Color3.fromRGB(155, 155, 175)}):Play() end
        end
        SelectedPage.Visible = true
        task.wait(0.05)
        pcall(function() SelectedPage.CanvasPosition = Vector2.new(0, 0) end)
        TweenService:Create(SelectedTab, TweenInfo.new(0.15), {BackgroundTransparency = 0}):Play()
        local Indicator = SelectedTab:FindFirstChild("Indicator")
        local TabText = SelectedTab:FindFirstChild("TabText")
        if Indicator then TweenService:Create(Indicator, TweenInfo.new(0.15), {BackgroundTransparency = 0}):Play() end
        if TabText then TweenService:Create(TabText, TweenInfo.new(0.15), {TextColor3 = Color3.fromRGB(255, 255, 255)}):Play() end
    end

    function TabsManager:GetTab(Name)
        for _, data in ipairs(self.Tabs) do
            if data.Name == Name then return data.Tab, data.Page end
        end
        return nil, nil
    end

    function TabsManager:SelectTabByName(Name)
        local Tab, Page = self:GetTab(Name)
        if Tab and Page then self:SelectTab(Tab, Page) end
    end

    _G.YOKUDO_TabsManager = TabsManager
end

print("✅ PART 1/5 OK - UI Ready")
-- ==================================================
-- SCRIPTER BRO HUB | PART 2/5
-- AntiAFK + WalkSpeed + AntiTrap + GodMode + TeleportSystem
-- ==================================================

-- ============ AntiAFK ============
do
    local AntiAFKEnabled = false
    local MouseThread, CameraThread, ZoomThread

    local function DoMouseMove()
        pcall(function() mousemoverel(math.random(-15, 15), math.random(-15, 15)) end)
    end

    local function DoCameraRotation()
        pcall(function()
            local Camera = workspace.CurrentCamera
            if Camera then
                Camera.CFrame = Camera.CFrame * CFrame.Angles(
                    math.rad(math.random(-2, 2)), math.rad(math.random(-3, 3)), 0
                )
            end
        end)
    end

    local function DoCameraZoom()
        pcall(function()
            local Camera = workspace.CurrentCamera
            if Camera then
                local Original = Camera.FieldOfView
                Camera.FieldOfView = Original + math.random(-5, 5)
                task.wait(0.3)
                Camera.FieldOfView = Original
            end
        end)
    end

    local function EnableAntiAFK()
        if AntiAFKEnabled then return end
        AntiAFKEnabled = true
        MouseThread = task.spawn(function()
            while AntiAFKEnabled do
                task.wait(math.random(45, 120))
                if not AntiAFKEnabled then break end
                DoMouseMove()
            end
        end)
        CameraThread = task.spawn(function()
            while AntiAFKEnabled do
                task.wait(math.random(60, 180))
                if not AntiAFKEnabled then break end
                DoCameraRotation()
            end
        end)
        ZoomThread = task.spawn(function()
            while AntiAFKEnabled do
                task.wait(math.random(90, 240))
                if not AntiAFKEnabled then break end
                DoCameraZoom()
            end
        end)
    end

    local function DisableAntiAFK()
        if not AntiAFKEnabled then return end
        AntiAFKEnabled = false
        if MouseThread then pcall(function() task.cancel(MouseThread) end) MouseThread = nil end
        if CameraThread then pcall(function() task.cancel(CameraThread) end) CameraThread = nil end
        if ZoomThread then pcall(function() task.cancel(ZoomThread) end) ZoomThread = nil end
    end

    _G.YOKUDO_AntiAFK = {
        Enable = EnableAntiAFK,
        Disable = DisableAntiAFK,
        Toggle = function() if AntiAFKEnabled then DisableAntiAFK() else EnableAntiAFK() end end,
        IsEnabled = function() return AntiAFKEnabled end,
    }
end

-- ============ WalkSpeed ============
do
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    local Player = Players.LocalPlayer

    local WalkSpeedEnabled = false
    local WalkSpeedValue = 50
    local OriginalWalkSpeed = 16
    local Connection = nil

    local function GetHumanoid()
        local Char = Player.Character
        if not Char then return nil end
        return Char:FindFirstChildOfClass("Humanoid")
    end

    local function ApplyWalkSpeed()
        local Hum = GetHumanoid()
        if Hum then Hum.WalkSpeed = WalkSpeedValue end
    end

    local function StopWalkSpeed()
        local Hum = GetHumanoid()
        if Hum then Hum.WalkSpeed = OriginalWalkSpeed end
        if Connection then Connection:Disconnect() Connection = nil end
    end

    local function StartWalkSpeed()
        local Hum = GetHumanoid()
        if Hum then OriginalWalkSpeed = Hum.WalkSpeed end
        ApplyWalkSpeed()
        if Connection then Connection:Disconnect() end
        Connection = RunService.Heartbeat:Connect(function()
            if WalkSpeedEnabled then ApplyWalkSpeed() end
        end)
    end

    _G.YOKUDO_WalkSpeed = {
        Toggle = function()
            WalkSpeedEnabled = not WalkSpeedEnabled
            if WalkSpeedEnabled then StartWalkSpeed() else StopWalkSpeed() end
        end,
        Enable = function() WalkSpeedEnabled = true StartWalkSpeed() end,
        Disable = function() WalkSpeedEnabled = false StopWalkSpeed() end,
        SetValue = function(v)
            WalkSpeedValue = math.clamp(v, 50, 1000)
            if WalkSpeedEnabled then ApplyWalkSpeed() end
        end,
        IsEnabled = function() return WalkSpeedEnabled end,
        GetValue = function() return WalkSpeedValue end,
    }
end

-- ============ AntiTrap ============
do
    local AntiTrapEnabled = false

    local function RemoveDebrisChildren()
        local Folder = workspace:FindFirstChild("__DEBRIS")
        if not Folder then return end
        for _, child in ipairs(Folder:GetChildren()) do
            pcall(function() child:Destroy() end)
        end
    end

    local function EnableAntiTrap()
        if AntiTrapEnabled then return end
        AntiTrapEnabled = true
        RemoveDebrisChildren()
        task.spawn(function()
            while AntiTrapEnabled do
                task.wait(1)
                if AntiTrapEnabled then RemoveDebrisChildren() end
            end
        end)
    end

    local function DisableAntiTrap() AntiTrapEnabled = false end

    _G.YOKUDO_AntiTrap = {
        Toggle = function() if AntiTrapEnabled then DisableAntiTrap() else EnableAntiTrap() end end,
        Enable = EnableAntiTrap,
        Disable = DisableAntiTrap,
        IsEnabled = function() return AntiTrapEnabled end,
    }
end

-- ============ GodMode ============
do
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    local Player = Players.LocalPlayer

    local GodModeEnabled = false
    local GodModeConnection = nil

    local function RunGodMode()
        local Character = Player.Character
        if not Character then return end
        local OldHumanoid = Character:FindFirstChildOfClass("Humanoid")
        if not OldHumanoid then return end

        local SavedJump = {}
        pcall(function() SavedJump.JumpPower = OldHumanoid.JumpPower end)
        pcall(function() SavedJump.JumpHeight = OldHumanoid.JumpHeight end)
        pcall(function() SavedJump.UseJumpPower = OldHumanoid.UseJumpPower end)

        local SavedStates = {}
        local States = {
            Enum.HumanoidStateType.FallingDown, Enum.HumanoidStateType.Running,
            Enum.HumanoidStateType.RunningNoPhysics, Enum.HumanoidStateType.Climbing,
            Enum.HumanoidStateType.StrafingNoPhysics, Enum.HumanoidStateType.Ragdoll,
            Enum.HumanoidStateType.GettingUp, Enum.HumanoidStateType.Jumping,
            Enum.HumanoidStateType.Landed, Enum.HumanoidStateType.Flying,
            Enum.HumanoidStateType.Freefall, Enum.HumanoidStateType.Seated,
            Enum.HumanoidStateType.PlatformStanding, Enum.HumanoidStateType.Dead,
            Enum.HumanoidStateType.Swimming, Enum.HumanoidStateType.Physics,
        }
        for _, State in ipairs(States) do
            local Success, Enabled = pcall(function() return OldHumanoid:GetStateEnabled(State) end)
            if Success then SavedStates[State] = Enabled end
        end

        local NewHumanoid = OldHumanoid:Clone()
        if not NewHumanoid then return end
        NewHumanoid.Name = OldHumanoid.Name

        for _, Child in ipairs(OldHumanoid:GetChildren()) do
            local Existing = NewHumanoid:FindFirstChild(Child.Name)
            if Existing then pcall(function() Existing:Destroy() end) end
            pcall(function() Child.Parent = NewHumanoid end)
        end

        OldHumanoid:Destroy()
        task.wait()
        NewHumanoid.Parent = Character
        task.wait()
        if not NewHumanoid.Parent then return end

        pcall(function() NewHumanoid.UseJumpPower = SavedJump.UseJumpPower end)
        pcall(function() NewHumanoid.JumpPower = SavedJump.JumpPower end)
        pcall(function() NewHumanoid.JumpHeight = SavedJump.JumpHeight end)
        for State, Enabled in pairs(SavedStates) do
            pcall(function() NewHumanoid:SetStateEnabled(State, Enabled) end)
        end

        local Animator = NewHumanoid:FindFirstChildOfClass("Animator")
        if not Animator then Animator = Instance.new("Animator") Animator.Parent = NewHumanoid end

        local Animate = Character:FindFirstChild("Animate")
        if Animate then
            pcall(function() Animate.Disabled = true end)
            task.wait()
            pcall(function() Animate.Disabled = false end)
        end
        task.wait(0.15)

        if GodModeConnection then GodModeConnection:Disconnect() GodModeConnection = nil end

        GodModeConnection = RunService.Heartbeat:Connect(function()
            if not GodModeEnabled then return end
            local Char = Player.Character
            if not Char then return end
            local Hum = Char:FindFirstChildOfClass("Humanoid")
            if not Hum then return end
            pcall(function()
                Hum.MaxHealth = math.huge
                Hum.Health = math.huge
                Hum:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
                Hum.BreakJointsOnDeath = false
                Hum.RequiresNeck = false
            end)
        end)

        pcall(function()
            local Camera = workspace.CurrentCamera
            if Camera then Camera.CameraSubject = NewHumanoid end
        end)
    end

    local function EnableGodMode()
        GodModeEnabled = true
        task.spawn(RunGodMode)
    end

    local function DisableGodMode()
        GodModeEnabled = false
        if GodModeConnection then GodModeConnection:Disconnect() GodModeConnection = nil end
    end

    _G.YOKUDO_GodMode = {
        Toggle = function() if GodModeEnabled then DisableGodMode() else EnableGodMode() end end,
        Enable = EnableGodMode,
        Disable = DisableGodMode,
        IsEnabled = function() return GodModeEnabled end,
    }
end

-- ============ TeleportSystem ============
do
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local TweenService = game:GetService("TweenService")
    local Player = Players.LocalPlayer

    local Container = workspace:FindFirstChild("AreaEggSlotsClient")
    if not Container then
        local Timeout = 0
        while not Container and Timeout < 30 do
            task.wait(0.5)
            Timeout = Timeout + 0.5
            Container = workspace:FindFirstChild("AreaEggSlotsClient")
        end
    end

    local Networking
    pcall(function()
        local Packages = ReplicatedStorage:FindFirstChild("Packages")
        if Packages then Networking = Packages:FindFirstChild("Networking") end
    end)

    local CollectEvent = Networking and Networking:FindFirstChild("RF/EggWorld/AskFieldEggCarry")
    local ForestStrike = Networking and Networking:FindFirstChild("RE/GuardPatrol/ForestStrike")

    local Config = {
        TeleportSpeed = 300, NearOffset = 20, FlyOffset = 3, ShotDistance = 25,
        LockAbove = 1, ArriveDistance = 2, SafeStopDistance = 5, Timeout = 20,
        CollectInterval = 0.05, TargetCollectTimeout = 10, MaxRecoveryAttempts = 10000,
        BodyVelocityP = 5000, BodyGyroP = 50000, BodyGyroD = 2000,
        SafeZone = Vector3.new(533, 70, -366),
        LockPosition = Vector3.new(607.6259155273438, 70.57420349121094, -326.8830261230469),
        SearchPrefix = "FirstAreaEgg", PositionThreshold = 1,
    }

    local State = {
        Running = false, Step = "idle", Mode = "none", Method = "TeleportFly", TargetUid = nil,
        FlySequence = 0, TweenConnection = nil, FlyConnection = nil, LockConnection = nil,
        BodyVelocity = nil, BodyGyro = nil, ActiveHeartbeat = nil,
        FirstEggList = {}, FirstEggUid = nil, FirstEggSlotKey = nil,
        SavedTargetPosition = nil, TargetLockedCFrame = nil,
        FlyTargetStarted = false, CollectDone = false, TargetCollected = false,
        RemotesFired = false, RecoveryTriggered = false, RecoveryAttempts = 0,
        CollectAttempts = 0, CollectTime = 0, TargetCollectStartTime = 0,
        PlayerGui = nil, DropHeldEgg = nil, DropHeldEggConnection = nil,
        RagdollEnabled = false, RagdollConnection = nil, ForceUpConnection = nil,
        SavedWalkSpeed = nil, SavedJumpPower = nil, SavedJumpHeight = nil, SavedUseJumpPower = nil,
    }

    local function GetHumanoid()
        local Char = Player.Character
        if not Char then return nil, nil end
        return Char:FindFirstChildOfClass("Humanoid"), Char:FindFirstChild("HumanoidRootPart")
    end

    local function GetPosition(Object)
        if not Object then return nil end
        if Object:IsA("Model") then
            if Object.PrimaryPart then return Object.PrimaryPart.Position end
            local Part = Object:FindFirstChildWhichIsA("BasePart")
            if Part then return Part.Position end
            for _, Desc in ipairs(Object:GetDescendants()) do
                if Desc:IsA("BasePart") then return Desc.Position end
            end
        elseif Object:IsA("BasePart") then
            return Object.Position
        end
        return nil
    end

    local function SaveStats()
        local Hum = GetHumanoid()
        if not Hum then return end
        if State.SavedWalkSpeed == nil then State.SavedWalkSpeed = Hum.WalkSpeed end
        if State.SavedJumpPower == nil then State.SavedJumpPower = Hum.JumpPower end
        if State.SavedJumpHeight == nil then State.SavedJumpHeight = Hum.JumpHeight end
        if State.SavedUseJumpPower == nil then State.SavedUseJumpPower = Hum.UseJumpPower end
    end

    local function RestoreStats()
        local Hum = GetHumanoid()
        if not Hum then return end
        if State.SavedWalkSpeed ~= nil then pcall(function() Hum.WalkSpeed = State.SavedWalkSpeed end) end
        if State.SavedJumpPower ~= nil then pcall(function() Hum.JumpPower = State.SavedJumpPower end) end
        if State.SavedJumpHeight ~= nil then pcall(function() Hum.JumpHeight = State.SavedJumpHeight end) end
        if State.SavedUseJumpPower ~= nil then pcall(function() Hum.UseJumpPower = State.SavedUseJumpPower end) end
    end

    local function ForceUp()
        local Hum, Root = GetHumanoid()
        if not Hum or not Root then return end
        pcall(function()
            if Hum:GetState() == Enum.HumanoidStateType.Physics then
                Hum:ChangeState(Enum.HumanoidStateType.GettingUp)
            end
            Hum:SetStateEnabled(Enum.HumanoidStateType.Physics, false)
            Hum:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
            Hum:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
            Hum:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
            Hum.PlatformStand = false
            Hum.Sit = false
            Root.AssemblyLinearVelocity = Vector3.zero
            Root.AssemblyAngularVelocity = Vector3.zero
            Root.CanCollide = true
            Hum.BreakJointsOnDeath = false
            Hum.RequiresNeck = false
        end)
    end

    local function CleanupRagdollConstraints()
        local Char = Player.Character
        if not Char then return end
        pcall(function()
            for _, d in ipairs(Char:GetDescendants()) do
                if d.Name:find("RagdollConstraint") or d.Name:find("RagdollAttachment") then
                    d:Destroy()
                end
            end
            for _, d in ipairs(Char:GetDescendants()) do
                if d:IsA("Motor6D") then d.Enabled = true end
            end
        end)
    end

    local function EnableRagdollBypass()
        if State.RagdollEnabled then return end
        State.RagdollEnabled = true
        State.RagdollConnection = RunService.Heartbeat:Connect(function()
            if not State.RagdollEnabled then return end
            ForceUp()
        end)
        State.ForceUpConnection = task.spawn(function()
            while State.RagdollEnabled do
                task.wait(0.1)
                ForceUp()
                CleanupRagdollConstraints()
            end
        end)
    end

    local function DisableRagdollBypass()
        if not State.RagdollEnabled then return end
        State.RagdollEnabled = false
        if State.RagdollConnection then State.RagdollConnection:Disconnect() State.RagdollConnection = nil end
    end

    local function CleanupMovers(KeepPlatformStand)
        if State.TweenConnection then pcall(function() State.TweenConnection:Cancel() end) State.TweenConnection = nil end
        if State.FlyConnection then State.FlyConnection:Disconnect() State.FlyConnection = nil end
        if State.LockConnection then State.LockConnection:Disconnect() State.LockConnection = nil end
        if State.BodyVelocity then
            pcall(function()
                State.BodyVelocity.Velocity = Vector3.zero
                State.BodyVelocity.MaxForce = Vector3.zero
            end)
            State.BodyVelocity:Destroy() State.BodyVelocity = nil
        end
        if State.BodyGyro then
            pcall(function() State.BodyGyro.MaxTorque = Vector3.zero end)
            State.BodyGyro:Destroy() State.BodyGyro = nil
        end
        local Hum, Root = GetHumanoid()
        if Root then
            for _, c in ipairs(Root:GetChildren()) do
                if c.Name == "YokudoBV" or c.Name == "YokudoBG" then
                    pcall(function() c:Destroy() end)
                end
            end
        end
        if Hum and not KeepPlatformStand then
            pcall(function() Hum.PlatformStand = false Hum.Sit = false end)
        end
        if Root then
            pcall(function()
                Root.AssemblyLinearVelocity = Vector3.zero
                Root.AssemblyAngularVelocity = Vector3.zero
            end)
        end
    end

    local function StartLock(Position)
        if not Position then return end
        State.TargetLockedCFrame = CFrame.new(Position + Vector3.new(0, Config.LockAbove, 0))
        if State.LockConnection then State.LockConnection:Disconnect() end
        State.LockConnection = RunService.Heartbeat:Connect(function()
            if not State.Running then
                if State.LockConnection then State.LockConnection:Disconnect() State.LockConnection = nil end
                return
            end
            local _, Root = GetHumanoid()
            if not Root then return end
            Root.CFrame = State.TargetLockedCFrame
            Root.AssemblyLinearVelocity = Vector3.zero
            Root.AssemblyAngularVelocity = Vector3.zero
        end)
    end

    local function TweenTeleportDirect(Destination, Callback)
        State.FlySequence = State.FlySequence + 1
        local Seq = State.FlySequence
        CleanupMovers()
        local Hum, Root = GetHumanoid()
        if not Hum or not Root or Hum.Health <= 0 then
            if Callback then Callback() end
            return
        end
        local FlyPos = Vector3.new(Destination.X, Destination.Y + Config.FlyOffset, Destination.Z)
        local TargetCFrame = CFrame.new(FlyPos)
        Hum.PlatformStand = true
        local Distance = (FlyPos - Root.Position).Magnitude
        local Duration = Distance / Config.TeleportSpeed
        local Tween = TweenService:Create(Root, TweenInfo.new(Duration, Enum.EasingStyle.Linear), { CFrame = TargetCFrame })
        State.TweenConnection = Tween
        Tween:Play()
        Tween.Completed:Wait()
        if Seq ~= State.FlySequence then return end
        if not State.Running then CleanupMovers() return end
        local Hum2, Root2 = GetHumanoid()
        if not Hum2 or not Root2 or Hum2.Health <= 0 then CleanupMovers() return end
        Root2.CFrame = TargetCFrame
        Root2.AssemblyLinearVelocity = Vector3.zero
        Root2.AssemblyAngularVelocity = Vector3.zero
        task.wait(0.05)
        CleanupMovers(true)
        if Callback then Callback() end
    end

    local function FlyTP(Destination, UseShotTP, IsSafeZone, Callback)
        State.FlySequence = State.FlySequence + 1
        local Seq = State.FlySequence
        CleanupMovers()
        local Hum, Root = GetHumanoid()
        if not Hum or not Root or Hum.Health <= 0 then return end

        local FlyPos = Vector3.new(Destination.X, Destination.Y + Config.FlyOffset, Destination.Z)
        local LockCFrame = CFrame.new(Destination + Vector3.new(0, Config.LockAbove, 0))
        Hum.PlatformStand = true

        local StartPos = Root.Position
        local Direction = (FlyPos - StartPos)
        local TotalDist = Direction.Magnitude
        local DirUnit = TotalDist > 0 and Direction.Unit or Vector3.new(0, 0, -1)
        local NearPos = FlyPos - (DirUnit * Config.NearOffset)
        local NearDist = (NearPos - StartPos).Magnitude
        local NearDuration = NearDist / Config.TeleportSpeed

        local TweenNear = TweenService:Create(Root,
            TweenInfo.new(NearDuration, Enum.EasingStyle.Linear),
            { CFrame = CFrame.new(NearPos, FlyPos) })
        State.TweenConnection = TweenNear
        TweenNear:Play()

        task.spawn(function()
            TweenNear.Completed:Wait()
            if Seq ~= State.FlySequence then return end
            if not State.Running then CleanupMovers() return end
            task.wait(0.03)
            local Hum2, Root2 = GetHumanoid()
            if not Hum2 or not Root2 or Hum2.Health <= 0 then CleanupMovers() return end

            State.BodyVelocity = Instance.new("BodyVelocity")
            State.BodyVelocity.Name = "YokudoBV"
            State.BodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
            State.BodyVelocity.P = Config.BodyVelocityP
            State.BodyVelocity.Velocity = Vector3.zero
            State.BodyVelocity.Parent = Root2

            State.BodyGyro = Instance.new("BodyGyro")
            State.BodyGyro.Name = "YokudoBG"
            State.BodyGyro.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
            State.BodyGyro.P = Config.BodyGyroP
            State.BodyGyro.D = Config.BodyGyroD
            State.BodyGyro.CFrame = Root2.CFrame
            State.BodyGyro.Parent = Root2

            local InitDir = (FlyPos - Root2.Position)
            if InitDir.Magnitude > 1 then
                State.BodyVelocity.Velocity = InitDir.Unit * Config.TeleportSpeed
            end

            local StartTime = tick()
            local ShotDone = false

            State.FlyConnection = RunService.Heartbeat:Connect(function()
                if Seq ~= State.FlySequence then
                    if State.FlyConnection then State.FlyConnection:Disconnect() State.FlyConnection = nil end
                    return
                end
                if not State.Running then CleanupMovers() return end
                local Hum3, Root3 = GetHumanoid()
                if not Hum3 or not Root3 or Hum3.Health <= 0 then CleanupMovers() return end
                if not State.BodyVelocity or not State.BodyGyro then CleanupMovers() return end

                local CurrentPos = Root3.Position
                local Dir = FlyPos - CurrentPos
                local HorizDist = Vector3.new(Dir.X, 0, Dir.Z).Magnitude
                local VertDist = math.abs(Dir.Y)
                local TotalDist2 = Dir.Magnitude

                if IsSafeZone and HorizDist <= Config.SafeStopDistance then
                    if State.BodyVelocity then State.BodyVelocity.Velocity = Vector3.zero State.BodyVelocity.MaxForce = Vector3.zero end
                    if State.BodyGyro then State.BodyGyro.MaxTorque = Vector3.zero end
                    if State.FlyConnection then State.FlyConnection:Disconnect() State.FlyConnection = nil end
                    Root3.CFrame = CFrame.new(Config.SafeZone + Vector3.new(0, Config.FlyOffset, 0))
                    Root3.AssemblyLinearVelocity = Vector3.zero
                    Root3.AssemblyAngularVelocity = Vector3.zero
                    task.spawn(function()
                        task.wait(0.1)
                        CleanupMovers()
                        if Callback then Callback() end
                    end)
                    return
                end

                if not IsSafeZone and UseShotTP and not ShotDone and HorizDist <= Config.ShotDistance then
                    ShotDone = true
                    if State.BodyVelocity then State.BodyVelocity.Velocity = Vector3.zero State.BodyVelocity.MaxForce = Vector3.zero end
                    if State.BodyGyro then State.BodyGyro.MaxTorque = Vector3.zero end
                    if State.FlyConnection then State.FlyConnection:Disconnect() State.FlyConnection = nil end
                    task.spawn(function()
                        task.wait(0.05)
                        CleanupMovers(true)
                        Root3.CFrame = LockCFrame
                        Root3.AssemblyLinearVelocity = Vector3.zero
                        Root3.AssemblyAngularVelocity = Vector3.zero
                        task.wait(0.05)
                        StartLock(Destination)
                        if Callback then Callback() end
                    end)
                    return
                end

                if HorizDist <= Config.ArriveDistance and VertDist <= 2 then
                    if State.BodyVelocity then State.BodyVelocity.Velocity = Vector3.zero State.BodyVelocity.MaxForce = Vector3.zero end
                    if State.BodyGyro then State.BodyGyro.MaxTorque = Vector3.zero end
                    if State.FlyConnection then State.FlyConnection:Disconnect() State.FlyConnection = nil end
                    task.spawn(function()
                        task.wait(0.05)
                        CleanupMovers(true)
                        Root3.CFrame = LockCFrame
                        Root3.AssemblyLinearVelocity = Vector3.zero
                        Root3.AssemblyAngularVelocity = Vector3.zero
                        task.wait(0.05)
                        StartLock(Destination)
                        if Callback then Callback() end
                    end)
                    return
                end

                if tick() - StartTime > Config.Timeout then
                    CleanupMovers()
                    if Callback then Callback() end
                    return
                end

                if TotalDist2 > 1 then
                    State.BodyVelocity.Velocity = Dir.Unit * Config.TeleportSpeed
                else
                    State.BodyVelocity.Velocity = Vector3.zero
                end
                State.BodyGyro.CFrame = CFrame.new(CurrentPos, CurrentPos + Vector3.new(Dir.X, 0, Dir.Z))
            end)
        end)
    end

    local function InstantTP(Destination, Callback)
        if not Destination then if Callback then Callback() end return end
        State.FlySequence = State.FlySequence + 1
        CleanupMovers()
        local Hum, Root = GetHumanoid()
        if not Hum or not Root or Hum.Health <= 0 then return end
        local LockCFrame = CFrame.new(Destination + Vector3.new(0, Config.LockAbove, 0))
        Hum.PlatformStand = true
        task.spawn(function()
            task.wait(0.03)
            Root.CFrame = LockCFrame
            Root.AssemblyLinearVelocity = Vector3.zero
            Root.AssemblyAngularVelocity = Vector3.zero
            task.wait(0.05)
            StartLock(Destination)
            if Callback then Callback() end
        end)
    end

    local function TeleportToTarget(TargetPos, Callback)
        if State.Method == "InstantTeleport" then
            InstantTP(TargetPos, Callback)
        else
            FlyTP(TargetPos, false, false, Callback)
        end
    end

    local function RemoteCollectFirst()
        if not CollectEvent or not State.FirstEggSlotKey or not State.FirstEggUid then return false end
        return pcall(function()
            return CollectEvent:InvokeServer({ FirstAreaSlotKey = State.FirstEggSlotKey, Uid = State.FirstEggUid })
        end)
    end

    local function RemoteCollectTarget()
        if not CollectEvent or not State.TargetUid then return false end
        return pcall(function()
            return CollectEvent:InvokeServer({ Uid = State.TargetUid })
        end)
    end

    local function FireForestStrike()
        if State.RemotesFired then return end
        State.RemotesFired = true
        EnableRagdollBypass()
        pcall(function()
            if ForestStrike then
                ForestStrike:FireServer({
                    EggUid = State.FirstEggUid,
                    GuardCFrame = CFrame.new(Config.LockPosition)
                })
            end
        end)
        task.spawn(function()
            for i = 1, 10 do
                task.wait(0.05)
                ForceUp()
                CleanupRagdollConstraints()
            end
        end)
    end

    local function SetupDropHeldEgg()
        State.PlayerGui = Player:FindFirstChild("PlayerGui")
        if not State.PlayerGui then
            local T = 0
            while not State.PlayerGui and T < 5 do
                task.wait(0.1)
                T = T + 0.1
                State.PlayerGui = Player:FindFirstChild("PlayerGui")
            end
        end
        if not State.PlayerGui then return end
        State.DropHeldEgg = State.PlayerGui:FindFirstChild("DropHeldEgg")
        if not State.DropHeldEgg then return end
        if State.DropHeldEggConnection then State.DropHeldEggConnection:Disconnect() end
        State.DropHeldEggConnection = State.DropHeldEgg:GetPropertyChangedSignal("Enabled"):Connect(function() end)
    end

    local function IsTargetCollected()
        return State.DropHeldEgg and State.DropHeldEgg.Enabled == true
    end

    local function SearchFirstEggs()
        State.FirstEggList = {}
        if not Container then return end
        for _, Slot in ipairs(Container:GetChildren()) do
            if string.find(Slot.Name, Config.SearchPrefix) then
                local SlotNum = string.match(Slot.Name, "Slot_(%d+)")
                if SlotNum then
                    table.insert(State.FirstEggList, {
                        Slot = Slot, Uid = Slot.Name, SlotKey = "Forest:Slot_" .. SlotNum,
                    })
                end
            end
        end
    end

    local function FindClosestEgg()
        local _, Root = GetHumanoid()
        if not Root then return nil end
        local Closest, ClosestDist = nil, 9999
        for _, Egg in ipairs(State.FirstEggList) do
            local Pos = GetPosition(Egg.Slot)
            if Pos then
                local Dist = (Pos - Root.Position).Magnitude
                if Dist < ClosestDist then
                    ClosestDist = Dist
                    Closest = Egg
                end
            end
        end
        if Closest then
            State.FirstEggUid = Closest.Uid
            State.FirstEggSlotKey = Closest.SlotKey
        end
        return Closest
    end

    local function IsFirstEggInWorkspace()
        return State.FirstEggUid and workspace:FindFirstChild(State.FirstEggUid) ~= nil
    end
    local function IsFirstEggInContainer()
        return State.FirstEggUid and Container and Container:FindFirstChild(State.FirstEggUid) ~= nil
    end
    local function IsTargetInContainer()
        return State.TargetUid and Container and Container:FindFirstChild(State.TargetUid) ~= nil
    end
    local function IsTargetInWorkspace()
        return State.TargetUid and workspace:FindFirstChild(State.TargetUid) ~= nil
    end

    local function AutoStop()
        if State.LockConnection then State.LockConnection:Disconnect() State.LockConnection = nil end
        State.TargetLockedCFrame = nil
        if State.ActiveHeartbeat then State.ActiveHeartbeat:Disconnect() State.ActiveHeartbeat = nil end
        CleanupMovers()
        DisableRagdollBypass()
        RestoreStats()
        State.Running = false
        State.Step = "done"
        State.FlySequence = State.FlySequence + 1
        State.FirstEggList = {}
        State.FirstEggUid = nil
        State.FirstEggSlotKey = nil
        State.CollectAttempts = 0
        State.CollectTime = 0
        State.TargetCollectStartTime = 0
        State.FlyTargetStarted = false
        State.CollectDone = false
        State.TargetCollected = false
        State.RemotesFired = false
        State.RecoveryTriggered = false
        State.RecoveryAttempts = 0
        State.SavedTargetPosition = nil
    end

    local StartFlyToTarget, FlyToTargetAgain, FlyToSafeZone, StartActiveHeartbeat, StartProcess, FullReset

    StartFlyToTarget = function()
        if State.FlyTargetStarted then return end
        State.FlyTargetStarted = true
        State.Step = "to_target"
        local TargetPos
        if State.Mode == "spawn" then
            local Egg = Container and Container:FindFirstChild(State.TargetUid)
            if Egg then TargetPos = GetPosition(Egg) end
        elseif State.Mode == "workspace" then
            TargetPos = State.SavedTargetPosition
            if not TargetPos then
                local Egg = workspace:FindFirstChild(State.TargetUid)
                if Egg then TargetPos = GetPosition(Egg) State.SavedTargetPosition = TargetPos end
            end
        end
        if not TargetPos then AutoStop() return end
        TeleportToTarget(TargetPos, function()
            State.TargetCollected = false
            State.CollectTime = 0
            State.CollectAttempts = 0
            State.RecoveryTriggered = false
            State.TargetCollectStartTime = tick()
            State.Step = "collect_target"
        end)
    end

    FlyToTargetAgain = function()
        State.RecoveryAttempts = State.RecoveryAttempts + 1
        if State.RecoveryAttempts > Config.MaxRecoveryAttempts then AutoStop() return end
        State.Step = "recovery"
        State.FlySequence = State.FlySequence + 1
        CleanupMovers()
        local TargetPos
        if IsTargetInContainer() then
            State.Mode = "spawn"
            local Egg = Container:FindFirstChild(State.TargetUid)
            if Egg then TargetPos = GetPosition(Egg) end
        elseif IsTargetInWorkspace() then
            State.Mode = "workspace"
            local Egg = workspace:FindFirstChild(State.TargetUid)
            if Egg then TargetPos = GetPosition(Egg) State.SavedTargetPosition = TargetPos end
        else
            AutoStop() return
        end
        if not TargetPos then AutoStop() return end
        State.RecoveryTriggered = false
        State.TargetCollected = false
        TweenTeleportDirect(TargetPos, function()
            State.TargetCollected = false
            State.CollectTime = 0
            State.CollectAttempts = 0
            State.RecoveryTriggered = false
            State.RemotesFired = false
            State.TargetCollectStartTime = tick()
            State.Step = "collect_target"
        end)
    end

    FlyToSafeZone = function()
        State.Step = "to_safe"
        State.RecoveryTriggered = false
        State.TargetCollected = false
        FlyTP(Config.SafeZone, false, true, function()
            if State.LockConnection then State.LockConnection:Disconnect() State.LockConnection = nil end
            State.TargetLockedCFrame = nil
            if State.ActiveHeartbeat then State.ActiveHeartbeat:Disconnect() State.ActiveHeartbeat = nil end
            CleanupMovers()
            DisableRagdollBypass()
            RestoreStats()
            State.Running = false
            State.Step = "idle"
            State.Mode = "none"
            State.FlySequence = State.FlySequence + 1
            State.FirstEggList = {}
            State.FirstEggUid = nil
            State.FirstEggSlotKey = nil
            State.CollectAttempts = 0
            State.CollectTime = 0
            State.TargetCollectStartTime = 0
            State.FlyTargetStarted = false
            State.CollectDone = false
            State.TargetCollected = false
            State.RemotesFired = false
            State.RecoveryTriggered = false
            State.RecoveryAttempts = 0
            State.SavedTargetPosition = nil
        end)
    end

    StartActiveHeartbeat = function()
        if State.ActiveHeartbeat then State.ActiveHeartbeat:Disconnect() end
        State.ActiveHeartbeat = RunService.Heartbeat:Connect(function()
            if not State.Running then return end
            local Hum, Root = GetHumanoid()
            if not Hum or not Root or Hum.Health <= 0 then return end

            if State.Step == "collect_first" and not State.CollectDone then
                if IsFirstEggInWorkspace() then
                    State.CollectDone = true
                    FireForestStrike()
                    State.Step = "wait_spawn_back"
                    return
                end
                if tick() - State.CollectTime > Config.CollectInterval then
                    State.CollectTime = tick()
                    if IsFirstEggInContainer() then
                        RemoteCollectFirst()
                        State.CollectAttempts = State.CollectAttempts + 1
                    elseif IsFirstEggInWorkspace() then
                        State.CollectDone = true
                        FireForestStrike()
                        State.Step = "wait_spawn_back"
                    end
                end
            end

            if State.Step == "wait_spawn_back" and not State.FlyTargetStarted then
                if IsFirstEggInContainer() then
                    task.spawn(function() task.wait(0.05) StartFlyToTarget() end)
                end
            end

            if State.Step == "collect_target" and not State.TargetCollected then
                if IsTargetCollected() then
                    State.TargetCollected = true
                    State.RecoveryTriggered = false
                    task.spawn(function() task.wait(0.05) FlyToSafeZone() end)
                    return
                end
                if State.Mode == "spawn" then
                    if workspace:FindFirstChild(State.TargetUid) then
                        State.TargetCollected = true
                        task.spawn(function() task.wait(0.05) FlyToSafeZone() end)
                        return
                    end
                elseif State.Mode == "workspace" and State.SavedTargetPosition then
                    local Egg = workspace:FindFirstChild(State.TargetUid)
                    if Egg then
                        local Pos = GetPosition(Egg)
                        if Pos and (Pos - State.SavedTargetPosition).Magnitude >= Config.PositionThreshold then
                            State.TargetCollected = true
                            task.spawn(function() task.wait(0.05) FlyToSafeZone() end)
                            return
                        end
                    end
                end
                if tick() - State.CollectTime > Config.CollectInterval then
                    State.CollectTime = tick()
                    RemoteCollectTarget()
                    State.CollectAttempts = State.CollectAttempts + 1
                end
                if tick() - State.TargetCollectStartTime > Config.TargetCollectTimeout then
                    if not State.RecoveryTriggered then
                        State.RecoveryTriggered = true
                        task.spawn(function() task.wait(0.05) FlyToTargetAgain() end)
                    end
                end
            end

            if State.Step == "to_safe" then
                if not IsTargetCollected() then
                    if not State.RecoveryTriggered then
                        State.RecoveryTriggered = true
                        task.spawn(function() task.wait(0.05) FlyToTargetAgain() end)
                    end
                else
                    State.RecoveryTriggered = false
                end
            end
        end)
    end

    StartProcess = function()
        State.Running = true
        State.Step = "search"
        State.FlySequence = 0
        State.CollectAttempts = 0
        State.CollectTime = 0
        State.TargetCollectStartTime = 0
        State.FlyTargetStarted = false
        State.CollectDone = false
        State.TargetCollected = false
        State.RemotesFired = false
        State.RecoveryTriggered = false
        State.RecoveryAttempts = 0
        State.SavedTargetPosition = nil
        State.TargetLockedCFrame = nil

        SetupDropHeldEgg()
        SaveStats()
        EnableRagdollBypass()

        if IsTargetInContainer() then
            State.Mode = "spawn"
        elseif IsTargetInWorkspace() then
            State.Mode = "workspace"
            local Egg = workspace:FindFirstChild(State.TargetUid)
            if Egg then State.SavedTargetPosition = GetPosition(Egg) end
        else
            local Waited = 0
            while State.Running and not IsTargetInContainer() and not IsTargetInWorkspace() do
                task.wait(0.2)
                Waited = Waited + 0.2
                if Waited > 30 then AutoStop() return end
            end
            if IsTargetInContainer() then
                State.Mode = "spawn"
            elseif IsTargetInWorkspace() then
                State.Mode = "workspace"
                local Egg = workspace:FindFirstChild(State.TargetUid)
                if Egg then State.SavedTargetPosition = GetPosition(Egg) end
            end
        end

        SearchFirstEggs()
        if #State.FirstEggList == 0 then AutoStop() return end
        local Closest = FindClosestEgg()
        if not Closest then AutoStop() return end
        local EggPos = GetPosition(Closest.Slot)
        if not EggPos then AutoStop() return end
        State.Step = "fly_first"
        StartActiveHeartbeat()
        FlyTP(EggPos, true, false, function()
            State.CollectDone = false
            State.CollectTime = 0
            State.Step = "collect_first"
        end)
    end

    FullReset = function()
        if State.LockConnection then State.LockConnection:Disconnect() State.LockConnection = nil end
        State.TargetLockedCFrame = nil
        if State.ActiveHeartbeat then State.ActiveHeartbeat:Disconnect() State.ActiveHeartbeat = nil end
        if State.DropHeldEggConnection then State.DropHeldEggConnection:Disconnect() State.DropHeldEggConnection = nil end
        State.DropHeldEgg = nil
        State.PlayerGui = nil
        CleanupMovers()
        DisableRagdollBypass()
        RestoreStats()
        State.Running = false
        State.Step = "idle"
        State.Mode = "none"
        State.FlySequence = State.FlySequence + 1
        State.FirstEggList = {}
        State.FirstEggUid = nil
        State.FirstEggSlotKey = nil
        State.CollectAttempts = 0
        State.CollectTime = 0
        State.TargetCollectStartTime = 0
        State.FlyTargetStarted = false
        State.CollectDone = false
        State.TargetCollected = false
        State.RemotesFired = false
        State.RecoveryTriggered = false
        State.RecoveryAttempts = 0
        State.SavedTargetPosition = nil
    end

    _G.YOKUDO_TeleportSystem = {
        Enable = function()
            if State.Running then return end
            if not CollectEvent then return end
            if not State.TargetUid then return end
            FullReset()
            StartProcess()
        end,
        Disable = function() FullReset() end,
        SetTargetId = function(Id) State.TargetUid = Id end,
        SetSpeed = function(Value) Config.TeleportSpeed = math.clamp(Value, 50, 1100) end,
        SetMethod = function(Method)
            State.Method = (Method == "InstantTeleport") and "InstantTeleport" or "TeleportFly"
        end,
        GetMethod = function() return State.Method end,
        GetSpeed = function() return Config.TeleportSpeed end,
        IsEnabled = function() return State.Running end,
        GetTargetId = function() return State.TargetUid end,
    }
end

print("✅ PART 2/5 OK - Core Features Ready")
-- ==================================================
-- SCRIPTER BRO HUB | PART 3/5
-- AutoFarm + AutoAttack + AFKSystem + VIPTP + AttackDrone
-- ==================================================

-- ============ AutoFarm ============
do
    local Players = game:GetService("Players")
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local Player = Players.LocalPlayer

    local Container = workspace:FindFirstChild("AreaEggSlotsClient")

    local Cache = { MeshIdMap = {}, MeshIdMapBuilt = false, PetData = {}, UidCategory = {} }
    local AutoFarmEnabled = false
    local SelectedEgg = nil
    local EggList = {}

    local Assets, Configs, EggsModels
    pcall(function()
        local Data = ReplicatedStorage:FindFirstChild("Data")
        if Data then
            Assets = Data:FindFirstChild("Assets")
            if Assets then Configs = Assets:FindFirstChild("Configs") end
        end
        local RA = ReplicatedStorage:FindFirstChild("Assets")
        if RA then
            local M = RA:FindFirstChild("Models")
            if M then EggsModels = M:FindFirstChild("Eggs") end
        end
    end)

    local MutationsModule = nil
    pcall(function()
        MutationsModule = require(ReplicatedStorage.Shared.Modules.Mutations)
    end)

    local function BuildMeshIdMap()
        if Cache.MeshIdMapBuilt then return end
        if not Configs or not EggsModels then Cache.MeshIdMapBuilt = true return end
        for _, Config in ipairs(Configs:GetChildren()) do
            local Success, Module = pcall(function() return require(Config) end)
            if Success and Module and Module.Egg then
                local ModelName = Module.Egg.ModelName or Config.Name
                local EggTemplate = EggsModels:FindFirstChild(ModelName)
                if EggTemplate then
                    for _, descendant in ipairs(EggTemplate:GetDescendants()) do
                        if descendant:IsA("MeshPart") and descendant.MeshId ~= "" then
                            Cache.MeshIdMap[descendant.MeshId] = Config.Name
                        end
                        if descendant:IsA("SpecialMesh") and descendant.MeshId ~= "" then
                            Cache.MeshIdMap[descendant.MeshId] = Config.Name
                        end
                    end
                end
            end
        end
        Cache.MeshIdMapBuilt = true
    end

    BuildMeshIdMap()

    local function GetPetData(AssetCategory)
        if not AssetCategory then return nil end
        if Cache.PetData[AssetCategory] then return Cache.PetData[AssetCategory] end
        if not Configs then return nil end
        local Config = Configs:FindFirstChild(AssetCategory)
        if not Config then return nil end
        local Data = { Name = AssetCategory, DisplayName = AssetCategory, EarningRate = 0, Icon = nil }
        local Success, Module = pcall(function() return require(Config) end)
        if Success and Module then
            Data.DisplayName = Module.DisplayName or AssetCategory
            Data.EarningRate = Module.EarningRate or 0
            Data.Icon = Module.Icon
        end
        Cache.PetData[AssetCategory] = Data
        return Data
    end

    local function FormatMoney(Amount)
        if type(Amount) ~= "number" then return tostring(Amount) end
        if Amount >= 1e12 then return string.format("%.2fT", Amount / 1e12)
        elseif Amount >= 1e9 then return string.format("%.2fB", Amount / 1e9)
        elseif Amount >= 1e6 then return string.format("%.2fM", Amount / 1e6)
        elseif Amount >= 1e3 then return string.format("%.2fK", Amount / 1e3)
        else return tostring(math.floor(Amount)) end
    end

    local function CalculateRatePerSecond(EarningRate, Scale, Mutations)
        local PayoutFactor
        if Scale <= 5 then PayoutFactor = Scale ^ 1.85
        else PayoutFactor = (Scale / 5) ^ 1.2 * 19.637875755794113 end
        local MutationMultiplier = 1
        if Mutations and #Mutations > 0 and MutationsModule then
            local Success, Result = pcall(function() return MutationsModule.EarningsFor(Mutations) end)
            if Success then MutationMultiplier = Result end
        end
        return math.round(EarningRate * PayoutFactor * MutationMultiplier)
    end

    local function FindAssetCategory(EggModel)
        if not EggModel then return nil end
        local Uid = EggModel.Name
        if Cache.UidCategory[Uid] then return Cache.UidCategory[Uid] end
        for _, descendant in ipairs(EggModel:GetDescendants()) do
            if descendant:IsA("MeshPart") and descendant.MeshId ~= "" then
                local Category = Cache.MeshIdMap[descendant.MeshId]
                if Category then Cache.UidCategory[Uid] = Category return Category end
            end
            if descendant:IsA("SpecialMesh") and descendant.MeshId ~= "" then
                local Category = Cache.MeshIdMap[descendant.MeshId]
                if Category then Cache.UidCategory[Uid] = Category return Category end
            end
        end
        return nil
    end

    local function ScanEggs()
        EggList = {}
        if not Container then return EggList end
        for _, child in ipairs(Container:GetChildren()) do
            if child:IsA("Model") then
                local AssetCategory = FindAssetCategory(child)
                if AssetCategory then
                    local Data = GetPetData(AssetCategory)
                    if Data then
                        local Scale = child:GetAttribute("AssetScale") or 1
                        local Mutations = child:GetAttribute("Mutations") or {}
                        local RealRate = CalculateRatePerSecond(Data.EarningRate, Scale, Mutations)
                        table.insert(EggList, {
                            Id = child.Name, Category = AssetCategory, DisplayName = Data.DisplayName,
                            Icon = Data.Icon, EarningRate = RealRate, Model = child
                        })
                    end
                end
            end
        end
        table.sort(EggList, function(a, b) return a.EarningRate > b.EarningRate end)
        return EggList
    end

    local function StartTeleport()
        if not SelectedEgg then return end
        local Method = _G.YOKUDO_SelectedMethod or "TeleportFly"
        local Speed = _G.YOKUDO_TeleportSpeed or 300
        if _G.YOKUDO_TeleportSystem then
            _G.YOKUDO_TeleportSystem.SetMethod(Method)
            _G.YOKUDO_TeleportSystem.SetSpeed(Speed)
            _G.YOKUDO_TeleportSystem.SetTargetId(SelectedEgg.Id)
            _G.YOKUDO_TeleportSystem.Enable()
        end
    end

    _G.YOKUDO_AutoFarm = {
        Enable = function() AutoFarmEnabled = true end,
        Disable = function() AutoFarmEnabled = false end,
        IsEnabled = function() return AutoFarmEnabled end,
        ScanEggs = ScanEggs,
        GetEggList = function() return EggList end,
        SelectEgg = function(EggData) SelectedEgg = EggData end,
        StartTeleport = StartTeleport,
        StopTeleport = function()
            if _G.YOKUDO_TeleportSystem then _G.YOKUDO_TeleportSystem.Disable() end
        end,
        GetSelectedEgg = function() return SelectedEgg end,
        FormatMoney = FormatMoney,
        ClearCache = function() Cache.UidCategory = {} end,
    }
end

-- ============ AutoAttack ============
do
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local Player = Players.LocalPlayer

    local Backpack = Player:FindFirstChild("Backpack")
    if not Backpack then
        local T = 0
        while not Backpack and T < 10 do
            task.wait(0.1)
            T = T + 0.1
            Backpack = Player:FindFirstChild("Backpack")
        end
    end

    local function GetBatSwingRemote()
        local Success, Remote = pcall(function()
            return ReplicatedStorage.Packages.Networking["RE/BatSwing/Trigger"]
        end)
        if Success and Remote then return Remote end
        return nil
    end

    local ATTACK_RANGE = 60
    local FIRE_INTERVAL = 0.01
    local AutoEquipEnabled = false
    local AutoHitEnabled = false
    local EquipConnection, HitConnection
    local CurrentBat = nil
    local LastFire = 0
    local TraceSequence = 0

    local function GetHumanoid()
        local Char = Player.Character
        if not Char then return nil, nil end
        return Char:FindFirstChildOfClass("Humanoid"), Char:FindFirstChild("HumanoidRootPart")
    end

    local function FindBatTool()
        if Backpack then
            for _, tool in ipairs(Backpack:GetChildren()) do
                if tool:IsA("Tool") then
                    if tool.ToolTip == "Bat" or tool.Name:find("Bat") then return tool end
                end
            end
        end
        local Char = Player.Character
        if Char then
            for _, tool in ipairs(Char:GetChildren()) do
                if tool:IsA("Tool") then
                    if tool.ToolTip == "Bat" or tool.Name:find("Bat") then return tool end
                end
            end
        end
        return nil
    end

    local function EquipBat()
        local Bat = FindBatTool()
        if not Bat then return false end
        if Bat.Parent == Backpack then
            local Hum = GetHumanoid()
            if Hum then Hum:EquipTool(Bat) CurrentBat = Bat return true end
        elseif Bat.Parent == Player.Character then
            CurrentBat = Bat
            return true
        end
        return false
    end

    local function EnableAutoEquip()
        if AutoEquipEnabled then return end
        AutoEquipEnabled = true
        if EquipConnection then EquipConnection:Disconnect() EquipConnection = nil end
        EquipConnection = RunService.Heartbeat:Connect(function()
            if not AutoEquipEnabled then return end
            local Bat = FindBatTool()
            if Bat and Bat.Parent == Backpack then EquipBat() end
        end)
        EquipBat()
    end

    local function DisableAutoEquip()
        if not AutoEquipEnabled then return end
        AutoEquipEnabled = false
        if EquipConnection then EquipConnection:Disconnect() EquipConnection = nil end
    end

    local function FindClosestPlayer()
        local _, Root = GetHumanoid()
        if not Root then return nil end
        local Closest, ClosestDist = nil, ATTACK_RANGE
        for _, otherPlayer in ipairs(Players:GetPlayers()) do
            if otherPlayer ~= Player then
                local otherChar = otherPlayer.Character
                if otherChar then
                    local otherHum = otherChar:FindFirstChildOfClass("Humanoid")
                    local otherRoot = otherChar:FindFirstChild("HumanoidRootPart")
                    if otherHum and otherRoot and otherHum.Health > 0 then
                        local Dist = (otherRoot.Position - Root.Position).Magnitude
                        if Dist < ClosestDist then
                            ClosestDist = Dist
                            Closest = otherPlayer
                        end
                    end
                end
            end
        end
        return Closest
    end

    local function FireRemote()
        local Target = FindClosestPlayer()
        if not Target then return end
        local Remote = GetBatSwingRemote()
        if not Remote then return end
        TraceSequence = TraceSequence + 1
        local TraceId = tostring(Player.UserId) .. ":" .. tostring(TraceSequence) .. ":" .. tostring(math.floor(workspace:GetServerTimeNow() * 1000))
        pcall(function() Remote:FireServer(Target, TraceId) end)
    end

    local function EnableAutoHit()
        if AutoHitEnabled then return end
        AutoHitEnabled = true
        if HitConnection then HitConnection:Disconnect() HitConnection = nil end
        HitConnection = RunService.Heartbeat:Connect(function()
            if not AutoHitEnabled then return end
            local now = tick()
            if now - LastFire < FIRE_INTERVAL then return end
            LastFire = now
            FireRemote()
        end)
    end

    local function DisableAutoHit()
        if not AutoHitEnabled then return end
        AutoHitEnabled = false
        if HitConnection then HitConnection:Disconnect() HitConnection = nil end
    end

    _G.YOKUDO_AutoAttack = {
        ToggleAutoEquip = function() if AutoEquipEnabled then DisableAutoEquip() else EnableAutoEquip() end end,
        EnableAutoEquip = EnableAutoEquip,
        DisableAutoEquip = DisableAutoEquip,
        IsAutoEquipEnabled = function() return AutoEquipEnabled end,
        ToggleAutoHit = function() if AutoHitEnabled then DisableAutoHit() else EnableAutoHit() end end,
        EnableAutoHit = EnableAutoHit,
        DisableAutoHit = DisableAutoHit,
        IsAutoHitEnabled = function() return AutoHitEnabled end,
        FindBatTool = FindBatTool,
        GetBatSwingRemote = GetBatSwingRemote,
        FindClosestPlayer = FindClosestPlayer,
    }
end

-- ============ AFKSystem ============
do
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    local Player = Players.LocalPlayer

    local FLY_SPEED = 350
    local ARRIVE_TIMEOUT = 15
    local JUMP_DISTANCE_THRESHOLD = 5
    local JUMP_MAX_ATTEMPTS = 50
    local JUMP_ATTEMPT_WAIT = 0.2
    local DIST_TREADMILL_THRESHOLD = 5
    local DIST_CHECK_INTERVAL = 4
    local SAFE_WAIT_TIME = 1
    local SAFE_ZONE = Vector3.new(533, 70, -366)

    local AFKEnabled = false
    local MyPlot, MyTreadmill, MyTreadmillPos
    local FlyConnection, BodyVelocity, BodyGyro
    local IsFlying = false
    local DistCheckThread = nil

    local function GetHumanoid()
        local Char = Player.Character
        if not Char then return nil, nil end
        return Char:FindFirstChildOfClass("Humanoid"), Char:FindFirstChild("HumanoidRootPart")
    end

    local function CleanupMovers()
        if FlyConnection then FlyConnection:Disconnect() FlyConnection = nil end
        if BodyVelocity then
            pcall(function()
                BodyVelocity.Velocity = Vector3.zero
                BodyVelocity.MaxForce = Vector3.zero
            end)
            BodyVelocity:Destroy() BodyVelocity = nil
        end
        if BodyGyro then
            pcall(function() BodyGyro.MaxTorque = Vector3.zero end)
            BodyGyro:Destroy() BodyGyro = nil
        end
        local Hum, Root = GetHumanoid()
        if Root then
            for _, Child in ipairs(Root:GetChildren()) do
                if Child.Name == "YokudoBV" or Child.Name == "YokudoBG" then
                    pcall(function() Child:Destroy() end)
                end
            end
        end
        if Hum then pcall(function() Hum.PlatformStand = false Hum.Sit = false end) end
        if Root then
            pcall(function()
                Root.AssemblyLinearVelocity = Vector3.zero
                Root.AssemblyAngularVelocity = Vector3.zero
            end)
        end
        IsFlying = false
    end

    local function FindMyPlotAndTreadmill()
        local Plots = workspace:FindFirstChild("Plots")
        if not Plots then return nil, nil end
        for _, plot in ipairs(Plots:GetChildren()) do
            if plot:IsA("Model") then
                local PlotSign = plot:FindFirstChild("PlotSign")
                if PlotSign then
                    local PlayerPlotSign = PlotSign:FindFirstChild("PlayerPlotSign")
                    if PlayerPlotSign then
                        local Frame = PlayerPlotSign:FindFirstChild("Frame")
                        if Frame then
                            local PlayerName = Frame:FindFirstChild("PlayerName")
                            if PlayerName and PlayerName:IsA("TextLabel") then
                                if PlayerName.Text == Player.Name or PlayerName.Text == Player.DisplayName then
                                    local Treadmill = plot:FindFirstChild("TreadmillBottom")
                                    return plot, Treadmill
                                end
                            end
                        end
                    end
                end
            end
        end
        return nil, nil
    end

    local function FlyTP(Destination, Callback)
        CleanupMovers()
        IsFlying = true
        local Hum, Root = GetHumanoid()
        if not Hum or not Root or Hum.Health <= 0 then
            IsFlying = false
            if Callback then Callback() end
            return
        end
        Hum.PlatformStand = true
        BodyVelocity = Instance.new("BodyVelocity")
        BodyVelocity.Name = "YokudoBV"
        BodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        BodyVelocity.P = 1250
        BodyVelocity.Velocity = Vector3.zero
        BodyVelocity.Parent = Root
        BodyGyro = Instance.new("BodyGyro")
        BodyGyro.Name = "YokudoBG"
        BodyGyro.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
        BodyGyro.P = 3000
        BodyGyro.D = 500
        BodyGyro.CFrame = Root.CFrame
        BodyGyro.Parent = Root

        local StartTime = tick()
        FlyConnection = RunService.Heartbeat:Connect(function()
            if not AFKEnabled then CleanupMovers() return end
            local Hum2, Root2 = GetHumanoid()
            if not Hum2 or not Root2 then CleanupMovers() return end
            if Hum2.Health <= 0 then return end
            if not BodyVelocity or not BodyGyro then CleanupMovers() return end
            local CurrentPos = Root2.Position
            local Direction = Destination - CurrentPos
            local TotalDist = math.floor(Direction.Magnitude)
            if TotalDist <= 2 then
                CleanupMovers()
                Root2.AssemblyLinearVelocity = Vector3.zero
                Root2.AssemblyAngularVelocity = Vector3.zero
                if Callback then Callback() end
                return
            end
            if tick() - StartTime > ARRIVE_TIMEOUT then
                CleanupMovers()
                if Callback then Callback() end
                return
            end
            BodyVelocity.Velocity = Direction.Unit * FLY_SPEED
            BodyGyro.CFrame = CFrame.new(CurrentPos, Destination)
        end)
    end

    local function JumpOutTreadmill(TreadmillPos, Callback)
        local Hum, Root = GetHumanoid()
        if not Hum or not Root or not TreadmillPos then
            if Callback then Callback() end
            return
        end
        task.spawn(function()
            local Attempts = 0
            while AFKEnabled and Attempts < JUMP_MAX_ATTEMPTS do
                local Hum2, Root2 = GetHumanoid()
                if not Hum2 or not Root2 then break end
                if Hum2.Health <= 0 then break end
                local DistToTreadmill = math.floor((Root2.Position - TreadmillPos).Magnitude)
                if DistToTreadmill > JUMP_DISTANCE_THRESHOLD then
                    if Callback then Callback() end
                    return
                end
                pcall(function() Hum2.Jump = true end)
                Attempts = Attempts + 1
                task.wait(JUMP_ATTEMPT_WAIT)
            end
            if Callback then Callback() end
        end)
    end

    local function StartDistanceCheck()
        if DistCheckThread then
            pcall(function() task.cancel(DistCheckThread) end)
            DistCheckThread = nil
        end
        DistCheckThread = task.spawn(function()
            while AFKEnabled do
                task.wait(DIST_CHECK_INTERVAL)
                if not AFKEnabled then break end
                local Hum, Root = GetHumanoid()
                if not Root or not MyTreadmillPos then continue end
                local DistToTreadmill = math.floor((Root.Position - MyTreadmillPos).Magnitude)
                if DistToTreadmill > DIST_TREADMILL_THRESHOLD then
                    FlyTP(MyTreadmillPos)
                end
            end
        end)
    end

    local function EnableAFK()
        if AFKEnabled then return end
        AFKEnabled = true
        MyPlot, MyTreadmill = FindMyPlotAndTreadmill()
        if MyTreadmill then
            MyTreadmillPos = MyTreadmill.Position
        else
            AFKEnabled = false
            return
        end
        FlyTP(SAFE_ZONE, function()
            task.wait(SAFE_WAIT_TIME)
            FlyTP(MyTreadmillPos, function() StartDistanceCheck() end)
        end)
    end

    local function DisableAFK()
        if not AFKEnabled then return end
        AFKEnabled = false
        if DistCheckThread then
            pcall(function() task.cancel(DistCheckThread) end)
            DistCheckThread = nil
        end
        CleanupMovers()
        MyPlot, MyTreadmill, MyTreadmillPos = nil, nil, nil
    end

    _G.YOKUDO_AFKSystem = {
        Enable = EnableAFK,
        Disable = DisableAFK,
        IsEnabled = function() return AFKEnabled end,
        FindMyPlotAndTreadmill = FindMyPlotAndTreadmill,
        FlyTP = FlyTP,
        JumpOutTreadmill = JumpOutTreadmill,
        GetMyTreadmillPos = function() return MyTreadmillPos end,
        GetMyTreadmill = function() return MyTreadmill end,
        GetMyPlot = function() return MyPlot end,
        IsFlying = function() return IsFlying end,
        SAFE_ZONE = SAFE_ZONE,
    }
end

-- ============ VIPTP ============
do
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local TweenService = game:GetService("TweenService")
    local Player = Players.LocalPlayer

    local Container = workspace:FindFirstChild("AreaEggSlotsClient")
    if not Container then
        local T = 0
        while not Container and T < 30 do
            task.wait(0.5)
            T = T + 0.5
            Container = workspace:FindFirstChild("AreaEggSlotsClient")
        end
    end

    local Networking
    pcall(function()
        local P = ReplicatedStorage:FindFirstChild("Packages")
        if P then Networking = P:FindFirstChild("Networking") end
    end)

    local CollectEvent = Networking and Networking:FindFirstChild("RF/EggWorld/AskFieldEggCarry")
    local ForestStrike = Networking and Networking:FindFirstChild("RE/GuardPatrol/ForestStrike")

    local Config = {
        FirstEggSpeed = 1000, RecoverySpeed = 1000, SafeZoneSpeed = 700,
        NearOffset = 20, FlyOffset = 5, ShotDistance = 25, LockAbove = 1,
        ArriveDistance = 2, SafeStopDistance = 5, Timeout = 20,
        CollectInterval = 0.05, TargetCollectTimeout = 10, MaxRecoveryAttempts = 10000,
        BodyVelocityP = 5000, BodyGyroP = 50000, BodyGyroD = 2000,
        SafeZone = Vector3.new(533, 70, -366),
        LockPosition = Vector3.new(607.6259155273438, 70.57420349121094, -326.8830261230469),
        MinSafeY = 60, SafeZoneWait = 0.2,
        SearchPrefix = "FirstAreaEgg", PositionThreshold = 1, RepeatCheckDelay = 0.05,
    }

    local State = {
        Running = false, Step = "idle", Mode = "none", TargetUid = nil,
        FlySequence = 0, TweenConnection = nil, FlyConnection = nil, LockConnection = nil,
        BodyVelocity = nil, BodyGyro = nil, ActiveTask = nil,
        FirstEggList = {}, FirstEggUid = nil, FirstEggSlotKey = nil,
        SavedTargetPosition = nil, TargetLockedCFrame = nil,
        FlyTargetStarted = false, CollectDone = false, TargetCollected = false,
        RemotesFired = false, RecoveryTriggered = false, RecoveryAttempts = 0,
        CollectAttempts = 0, CollectTime = 0, TargetCollectStartTime = 0,
        PlayerGui = nil, DropHeldEgg = nil, DropHeldEggConnection = nil,
        RagdollEnabled = false, RagdollConnection = nil, ForceUpConnection = nil,
        SavedWalkSpeed = nil, SavedJumpPower = nil, SavedJumpHeight = nil, SavedUseJumpPower = nil,
    }

    local function GetRoot()
        local Char = Player.Character
        if not Char then return nil end
        return Char:FindFirstChild("HumanoidRootPart")
    end

    local function GetHum()
        local Char = Player.Character
        if not Char then return nil end
        return Char:FindFirstChildOfClass("Humanoid")
    end

    local function GetPosition(Object)
        if not Object then return nil end
        if Object:IsA("Model") then
            if Object.PrimaryPart then return Object.PrimaryPart.Position end
            local Part = Object:FindFirstChildWhichIsA("BasePart")
            if Part then return Part.Position end
            for _, Desc in ipairs(Object:GetDescendants()) do
                if Desc:IsA("BasePart") then return Desc.Position end
            end
        elseif Object:IsA("BasePart") then
            return Object.Position
        end
        return nil
    end

    local function SaveStats()
        local Hum = GetHum()
        if not Hum then return end
        if State.SavedWalkSpeed == nil then State.SavedWalkSpeed = Hum.WalkSpeed end
        if State.SavedJumpPower == nil then State.SavedJumpPower = Hum.JumpPower end
        if State.SavedJumpHeight == nil then State.SavedJumpHeight = Hum.JumpHeight end
        if State.SavedUseJumpPower == nil then State.SavedUseJumpPower = Hum.UseJumpPower end
    end

    local function RestoreStats()
        local Hum = GetHum()
        if not Hum then return end
        if State.SavedWalkSpeed ~= nil then pcall(function() Hum.WalkSpeed = State.SavedWalkSpeed end) end
        if State.SavedJumpPower ~= nil then pcall(function() Hum.JumpPower = State.SavedJumpPower end) end
        if State.SavedJumpHeight ~= nil then pcall(function() Hum.JumpHeight = State.SavedJumpHeight end) end
        if State.SavedUseJumpPower ~= nil then pcall(function() Hum.UseJumpPower = State.SavedUseJumpPower end) end
    end

    local function ForceUp()
        local Hum = GetHum() local Root = GetRoot()
        if not Hum or not Root then return end
        pcall(function()
            if Hum:GetState() == Enum.HumanoidStateType.Physics then
                Hum:ChangeState(Enum.HumanoidStateType.GettingUp)
            end
            Hum:SetStateEnabled(Enum.HumanoidStateType.Physics, false)
            Hum:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
            Hum:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
            Hum:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
            Hum.PlatformStand = false
            Hum.Sit = false
            Root.AssemblyLinearVelocity = Vector3.zero
            Root.AssemblyAngularVelocity = Vector3.zero
            Root.CanCollide = true
            Hum.BreakJointsOnDeath = false
            Hum.RequiresNeck = false
        end)
    end

    local function CleanupRagdollConstraints()
        local Char = Player.Character
        if not Char then return end
        pcall(function()
            for _, d in ipairs(Char:GetDescendants()) do
                if d.Name:find("RagdollConstraint") or d.Name:find("RagdollAttachment") then
                    d:Destroy()
                end
            end
            for _, d in ipairs(Char:GetDescendants()) do
                if d:IsA("Motor6D") then d.Enabled = true end
            end
        end)
    end

    local function EnableRagdollBypass()
        if State.RagdollEnabled then return end
        State.RagdollEnabled = true
        State.RagdollConnection = RunService.Heartbeat:Connect(function()
            if not State.RagdollEnabled then return end
            ForceUp()
        end)
        State.ForceUpConnection = task.spawn(function()
            while State.RagdollEnabled do
                task.wait(0.1)
                ForceUp()
                CleanupRagdollConstraints()
            end
        end)
    end

    local function DisableRagdollBypass()
        if not State.RagdollEnabled then return end
        State.RagdollEnabled = false
        if State.RagdollConnection then State.RagdollConnection:Disconnect() State.RagdollConnection = nil end
    end

    local function CleanupMovers(KeepPlatformStand)
        if State.TweenConnection then pcall(function() State.TweenConnection:Cancel() end) State.TweenConnection = nil end
        if State.FlyConnection then State.FlyConnection:Disconnect() State.FlyConnection = nil end
        if State.LockConnection then State.LockConnection:Disconnect() State.LockConnection = nil end
        if State.BodyVelocity then
            pcall(function()
                State.BodyVelocity.Velocity = Vector3.zero
                State.BodyVelocity.MaxForce = Vector3.zero
            end)
            State.BodyVelocity:Destroy() State.BodyVelocity = nil
        end
        if State.BodyGyro then
            pcall(function() State.BodyGyro.MaxTorque = Vector3.zero end)
            State.BodyGyro:Destroy() State.BodyGyro = nil
        end
        local Hum = GetHum() local Root = GetRoot()
        if Root then
            for _, c in ipairs(Root:GetChildren()) do
                if c.Name == "YokudoBV" or c.Name == "YokudoBG" then
                    pcall(function() c:Destroy() end)
                end
            end
        end
        if Hum and not KeepPlatformStand then
            pcall(function() Hum.PlatformStand = false Hum.Sit = false end)
        end
        if Root then
            pcall(function()
                Root.CanCollide = true
                Root.AssemblyLinearVelocity = Vector3.zero
                Root.AssemblyAngularVelocity = Vector3.zero
            end)
        end
    end

    local function StartLock(Position)
        if not Position then return end
        State.TargetLockedCFrame = CFrame.new(Position + Vector3.new(0, Config.LockAbove, 0))
        if State.LockConnection then State.LockConnection:Disconnect() end
        State.LockConnection = RunService.Heartbeat:Connect(function()
            if not State.Running then
                if State.LockConnection then State.LockConnection:Disconnect() State.LockConnection = nil end
                return
            end
            local Root = GetRoot()
            if not Root then return end
            Root.CFrame = State.TargetLockedCFrame
            Root.AssemblyLinearVelocity = Vector3.zero
            Root.AssemblyAngularVelocity = Vector3.zero
        end)
    end

    local function TweenTeleportDirect(Destination, Speed, Callback)
        State.FlySequence = State.FlySequence + 1
        local Seq = State.FlySequence
        CleanupMovers()
        local Hum = GetHum() local Root = GetRoot()
        if not Hum or not Root or Hum.Health <= 0 then
            if Callback then Callback() end
            return
        end
        local FlyPos = Vector3.new(Destination.X, Destination.Y + Config.FlyOffset, Destination.Z)
        local TargetCFrame = CFrame.new(FlyPos)
        Hum.PlatformStand = true
        local Distance = (FlyPos - Root.Position).Magnitude
        local Duration = Distance / Speed
        local Tween = TweenService:Create(Root, TweenInfo.new(Duration, Enum.EasingStyle.Linear), { CFrame = TargetCFrame })
        State.TweenConnection = Tween
        Tween:Play()
        Tween.Completed:Wait()
        if Seq ~= State.FlySequence then return end
        if not State.Running then CleanupMovers() return end
        local Hum2 = GetHum() local Root2 = GetRoot()
        if not Hum2 or not Root2 or Hum2.Health <= 0 then CleanupMovers() return end
        Root2.CFrame = TargetCFrame
        Root2.AssemblyLinearVelocity = Vector3.zero
        Root2.AssemblyAngularVelocity = Vector3.zero
        task.wait(0.05)
        CleanupMovers(true)
        if Callback then Callback() end
    end

    local function FlyTP(Destination, Speed, UseShotTP, IsSafeZone, Callback)
        State.FlySequence = State.FlySequence + 1
        local Seq = State.FlySequence
        CleanupMovers()
        local Hum = GetHum() local Root = GetRoot()
        if not Hum or not Root or Hum.Health <= 0 then return end
        local FlyPos = Vector3.new(Destination.X, Destination.Y + Config.FlyOffset, Destination.Z)
        local LockCFrame = CFrame.new(Destination + Vector3.new(0, Config.LockAbove, 0))
        Hum.PlatformStand = true
        local StartPos = Root.Position
        local Direction = (FlyPos - StartPos)
        local TotalDist = Direction.Magnitude
        local DirUnit = TotalDist > 0 and Direction.Unit or Vector3.new(0, 0, -1)
        local NearPos = FlyPos - (DirUnit * Config.NearOffset)
        local NearDist = (NearPos - StartPos).Magnitude
        local NearDuration = NearDist / Speed
        local TweenNear = TweenService:Create(Root,
            TweenInfo.new(NearDuration, Enum.EasingStyle.Linear),
            { CFrame = CFrame.new(NearPos, FlyPos) })
        State.TweenConnection = TweenNear
        TweenNear:Play()
        task.spawn(function()
            TweenNear.Completed:Wait()
            if Seq ~= State.FlySequence then return end
            if not State.Running then CleanupMovers() return end
            task.wait(0.03)
            local Hum2 = GetHum() local Root2 = GetRoot()
            if not Hum2 or not Root2 or Hum2.Health <= 0 then CleanupMovers() return end
            State.BodyVelocity = Instance.new("BodyVelocity")
            State.BodyVelocity.Name = "YokudoBV"
            State.BodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
            State.BodyVelocity.P = Config.BodyVelocityP
            State.BodyVelocity.Velocity = Vector3.zero
            State.BodyVelocity.Parent = Root2
            State.BodyGyro = Instance.new("BodyGyro")
            State.BodyGyro.Name = "YokudoBG"
            State.BodyGyro.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
            State.BodyGyro.P = Config.BodyGyroP
            State.BodyGyro.D = Config.BodyGyroD
            State.BodyGyro.CFrame = Root2.CFrame
            State.BodyGyro.Parent = Root2
            local InitDir = (FlyPos - Root2.Position)
            if InitDir.Magnitude > 1 then
                State.BodyVelocity.Velocity = InitDir.Unit * Speed
            end
            local StartTime = tick()
            local ShotDone = false
            State.FlyConnection = RunService.Heartbeat:Connect(function()
                if Seq ~= State.FlySequence then
                    if State.FlyConnection then State.FlyConnection:Disconnect() State.FlyConnection = nil end
                    return
                end
                if not State.Running then CleanupMovers() return end
                local Hum3 = GetHum() local Root3 = GetRoot()
                if not Hum3 or not Root3 or Hum3.Health <= 0 then CleanupMovers() return end
                if not State.BodyVelocity or not State.BodyGyro then CleanupMovers() return end
                local CurrentPos = Root3.Position
                local Dir = FlyPos - CurrentPos
                local HorizDist = Vector3.new(Dir.X, 0, Dir.Z).Magnitude
                local VertDist = math.abs(Dir.Y)
                local TotalDist2 = Dir.Magnitude

                if IsSafeZone and HorizDist <= Config.SafeStopDistance then
                    if State.BodyVelocity then State.BodyVelocity.Velocity = Vector3.zero State.BodyVelocity.MaxForce = Vector3.zero end
                    if State.BodyGyro then State.BodyGyro.MaxTorque = Vector3.zero end
                    if State.FlyConnection then State.FlyConnection:Disconnect() State.FlyConnection = nil end
                    Root3.CFrame = CFrame.new(Config.SafeZone)
                    Root3.AssemblyLinearVelocity = Vector3.zero
                    Root3.AssemblyAngularVelocity = Vector3.zero
                    Root3.CanCollide = true
                    task.spawn(function()
                        task.wait(Config.SafeZoneWait)
                        local Root4 = GetRoot()
                        if Root4 and Root4.Position.Y < Config.MinSafeY then
                            Root4.CFrame = CFrame.new(Config.SafeZone)
                            Root4.AssemblyLinearVelocity = Vector3.zero
                            Root4.AssemblyAngularVelocity = Vector3.zero
                        end
                        task.wait(0.1)
                        CleanupMovers()
                        if Callback then Callback() end
                    end)
                    return
                end

                if not IsSafeZone and UseShotTP and not ShotDone and HorizDist <= Config.ShotDistance then
                    ShotDone = true
                    if State.BodyVelocity then State.BodyVelocity.Velocity = Vector3.zero State.BodyVelocity.MaxForce = Vector3.zero end
                    if State.BodyGyro then State.BodyGyro.MaxTorque = Vector3.zero end
                    if State.FlyConnection then State.FlyConnection:Disconnect() State.FlyConnection = nil end
                    task.spawn(function()
                        task.wait(0.05)
                        CleanupMovers(true)
                        Root3.CFrame = LockCFrame
                        Root3.AssemblyLinearVelocity = Vector3.zero
                        Root3.AssemblyAngularVelocity = Vector3.zero
                        task.wait(0.05)
                        StartLock(Destination)
                        if Callback then Callback() end
                    end)
                    return
                end

                if HorizDist <= Config.ArriveDistance and VertDist <= 2 then
                    if State.BodyVelocity then State.BodyVelocity.Velocity = Vector3.zero State.BodyVelocity.MaxForce = Vector3.zero end
                    if State.BodyGyro then State.BodyGyro.MaxTorque = Vector3.zero end
                    if State.FlyConnection then State.FlyConnection:Disconnect() State.FlyConnection = nil end
                    task.spawn(function()
                        task.wait(0.05)
                        CleanupMovers(true)
                        Root3.CFrame = LockCFrame
                        Root3.AssemblyLinearVelocity = Vector3.zero
                        Root3.AssemblyAngularVelocity = Vector3.zero
                        task.wait(0.05)
                        StartLock(Destination)
                        if Callback then Callback() end
                    end)
                    return
                end

                if tick() - StartTime > Config.Timeout then
                    CleanupMovers()
                    if Callback then Callback() end
                    return
                end

                if TotalDist2 > 1 then
                    State.BodyVelocity.Velocity = Dir.Unit * Speed
                else
                    State.BodyVelocity.Velocity = Vector3.zero
                end
                State.BodyGyro.CFrame = CFrame.new(CurrentPos, CurrentPos + Vector3.new(Dir.X, 0, Dir.Z))
            end)
        end)
    end

    local function InstantTP(Destination, Callback)
        if not Destination then if Callback then Callback() end return end
        State.FlySequence = State.FlySequence + 1
        CleanupMovers()
        local Hum = GetHum() local Root = GetRoot()
        if not Hum or not Root or Hum.Health <= 0 then return end
        local LockCFrame = CFrame.new(Destination + Vector3.new(0, Config.LockAbove, 0))
        Hum.PlatformStand = true
        task.spawn(function()
            task.wait(0.03)
            Root.CFrame = LockCFrame
            Root.AssemblyLinearVelocity = Vector3.zero
            Root.AssemblyAngularVelocity = Vector3.zero
            task.wait(0.1)
            StartLock(Destination)
            if Callback then Callback() end
        end)
    end

    local function RemoteCollectFirst()
        if not CollectEvent or not State.FirstEggSlotKey or not State.FirstEggUid then return false end
        return pcall(function()
            return CollectEvent:InvokeServer({ FirstAreaSlotKey = State.FirstEggSlotKey, Uid = State.FirstEggUid })
        end)
    end

    local function RemoteCollectTarget()
        if not CollectEvent or not State.TargetUid then return false end
        return pcall(function()
            return CollectEvent:InvokeServer({ Uid = State.TargetUid })
        end)
    end

    local function FireForestStrike()
        if State.RemotesFired then return end
        State.RemotesFired = true
        EnableRagdollBypass()
        pcall(function()
            if ForestStrike then
                ForestStrike:FireServer({
                    EggUid = State.FirstEggUid,
                    GuardCFrame = CFrame.new(Config.LockPosition)
                })
            end
        end)
        task.spawn(function()
            for i = 1, 10 do
                task.wait(0.05)
                ForceUp()
                CleanupRagdollConstraints()
            end
        end)
    end

    local function SetupDropHeldEgg()
        State.PlayerGui = Player:FindFirstChild("PlayerGui")
        if not State.PlayerGui then return end
        State.DropHeldEgg = State.PlayerGui:FindFirstChild("DropHeldEgg")
        if not State.DropHeldEgg then return end
        if State.DropHeldEggConnection then State.DropHeldEggConnection:Disconnect() end
        State.DropHeldEggConnection = State.DropHeldEgg:GetPropertyChangedSignal("Enabled"):Connect(function() end)
    end

    local function IsTargetCollected()
        return State.DropHeldEgg and State.DropHeldEgg.Enabled == true
    end

    local function SearchFirstEggs()
        State.FirstEggList = {}
        if not Container then return end
        for _, Slot in ipairs(Container:GetChildren()) do
            if string.find(Slot.Name, Config.SearchPrefix) then
                local SlotNum = string.match(Slot.Name, "Slot_(%d+)")
                if SlotNum then
                    table.insert(State.FirstEggList, {
                        Slot = Slot, Uid = Slot.Name, SlotKey = "Forest:Slot_" .. SlotNum,
                    })
                end
            end
        end
    end

    local function FindClosestEgg()
        local Root = GetRoot()
        if not Root then return nil end
        local Closest, ClosestDist = nil, 9999
        for _, Egg in ipairs(State.FirstEggList) do
            local Pos = GetPosition(Egg.Slot)
            if Pos then
                local Dist = (Pos - Root.Position).Magnitude
                if Dist < ClosestDist then
                    ClosestDist = Dist
                    Closest = Egg
                end
            end
        end
        if Closest then
            State.FirstEggUid = Closest.Uid
            State.FirstEggSlotKey = Closest.SlotKey
        end
        return Closest
    end

    local function IsFirstEggInWorkspace()
        return State.FirstEggUid and workspace:FindFirstChild(State.FirstEggUid) ~= nil
    end
    local function IsFirstEggInContainer()
        return State.FirstEggUid and Container and Container:FindFirstChild(State.FirstEggUid) ~= nil
    end

    local function CheckTargetUID(TargetUid, Mode)
        if not TargetUid then return "none" end
        Mode = Mode or "spawn_only"
        local InContainer = false
        if Container then InContainer = Container:FindFirstChild(TargetUid) ~= nil end
        if InContainer then return "spawn" end
        if Mode == "both" then
            local InWorkspace = workspace:FindFirstChild(TargetUid) ~= nil
            if InWorkspace then return "workspace" end
        end
        return "none"
    end

    local function ResetForRepeat(Location)
        State.Step = "search"
        State.FlySequence = State.FlySequence + 1
        State.FlyTargetStarted = false
        State.CollectDone = false
        State.TargetCollected = false
        State.RemotesFired = false
        State.RecoveryTriggered = false
        State.RecoveryAttempts = 0
        State.CollectAttempts = 0
        State.CollectTime = 0
        State.TargetCollectStartTime = 0
        State.FirstEggList = {}
        State.FirstEggUid = nil
        State.FirstEggSlotKey = nil
        if Location == "spawn" then
            State.Mode = "spawn"
            State.SavedTargetPosition = nil
        elseif Location == "workspace" then
            State.Mode = "workspace"
            local Egg = workspace:FindFirstChild(State.TargetUid)
            if Egg then State.SavedTargetPosition = GetPosition(Egg) end
        end
        if State.LockConnection then State.LockConnection:Disconnect() State.LockConnection = nil end
    end

    local function AutoStop()
        if State.LockConnection then State.LockConnection:Disconnect() State.LockConnection = nil end
        State.TargetLockedCFrame = nil
        if State.ActiveTask then pcall(function() task.cancel(State.ActiveTask) end) State.ActiveTask = nil end
        CleanupMovers()
        DisableRagdollBypass()
        RestoreStats()
        State.Running = false
        State.Step = "done"
        State.FlySequence = State.FlySequence + 1
        State.FirstEggList = {}
        State.FirstEggUid = nil
        State.FirstEggSlotKey = nil
        State.CollectAttempts = 0
        State.CollectTime = 0
        State.TargetCollectStartTime = 0
        State.FlyTargetStarted = false
        State.CollectDone = false
        State.TargetCollected = false
        State.RemotesFired = false
        State.RecoveryTriggered = false
        State.RecoveryAttempts = 0
        State.SavedTargetPosition = nil
        task.spawn(function()
            task.wait(0.2)
            if _G.YOKUDO_FarmingManager and type(_G.YOKUDO_FarmingManager.OnVIPTPComplete) == "function" then
                pcall(function() _G.YOKUDO_FarmingManager.OnVIPTPComplete() end)
            end
        end)
    end

    local StartProcess, StartFlyToTarget, FlyToTargetAgain, FlyToSafeZone, StartActiveTask

    StartFlyToTarget = function()
        if State.FlyTargetStarted then return end
        State.FlyTargetStarted = true
        State.Step = "to_target"
        local Location = CheckTargetUID(State.TargetUid, "spawn_only")
        local TargetPos
        if Location == "spawn" then
            State.Mode = "spawn"
            local Egg = Container and Container:FindFirstChild(State.TargetUid)
            if Egg then TargetPos = GetPosition(Egg) end
        end
        if not TargetPos then AutoStop() return end
        InstantTP(TargetPos, function()
            State.TargetCollected = false
            State.CollectTime = 0
            State.CollectAttempts = 0
            State.RecoveryTriggered = false
            State.TargetCollectStartTime = tick()
            State.Step = "collect_target"
        end)
    end

    FlyToTargetAgain = function()
        State.RecoveryAttempts = State.RecoveryAttempts + 1
        if State.RecoveryAttempts > Config.MaxRecoveryAttempts then AutoStop() return end
        State.Step = "recovery"
        State.FlySequence = State.FlySequence + 1
        CleanupMovers()
        local TargetPos
        local Location = CheckTargetUID(State.TargetUid, "both")
        if Location == "workspace" then
            State.Mode = "workspace"
            local Egg = workspace:FindFirstChild(State.TargetUid)
            if Egg then TargetPos = GetPosition(Egg) State.SavedTargetPosition = TargetPos end
        elseif Location == "spawn" then
            State.Mode = "spawn"
            local Egg = Container:FindFirstChild(State.TargetUid)
            if Egg then TargetPos = GetPosition(Egg) end
        else
            AutoStop() return
        end
        if not TargetPos then AutoStop() return end
        State.RecoveryTriggered = false
        State.TargetCollected = false
        TweenTeleportDirect(TargetPos, Config.RecoverySpeed, function()
            State.TargetCollected = false
            State.CollectTime = 0
            State.CollectAttempts = 0
            State.RecoveryTriggered = false
            State.RemotesFired = false
            State.TargetCollectStartTime = tick()
            State.Step = "collect_target"
        end)
    end

    FlyToSafeZone = function()
        State.Step = "to_safe"
        State.RecoveryTriggered = false
        State.TargetCollected = false
        FlyTP(Config.SafeZone, Config.SafeZoneSpeed, false, true, function()
            task.spawn(function()
                task.wait(Config.RepeatCheckDelay)
                local NewUid = nil
                local NewLocation = "none"
                if _G.YOKUDO_FarmingManager and _G.YOKUDO_FarmingManager.FindBestEgg then
                    local BestEgg = _G.YOKUDO_FarmingManager.FindBestEgg()
                    if BestEgg then
                        NewUid = BestEgg.Uid
                        NewLocation = CheckTargetUID(NewUid, "spawn_only")
                    end
                end
                if NewUid and NewLocation ~= "none" then
                    State.TargetUid = NewUid
                    State.SavedTargetPosition = nil
                    ResetForRepeat(NewLocation)
                    task.wait(0.05)
                    StartProcess()
                else
                    AutoStop()
                end
            end)
        end)
    end

    StartActiveTask = function()
        if State.ActiveTask then pcall(function() task.cancel(State.ActiveTask) end) State.ActiveTask = nil end
        State.ActiveTask = task.spawn(function()
            while State.Running do
                task.wait(0.05)
                local Hum = GetHum() local Root = GetRoot()
                if not Hum or not Root or Hum.Health <= 0 then break end

                if State.Step == "collect_first" and not State.CollectDone then
                    if IsFirstEggInWorkspace() then
                        State.CollectDone = true
                        FireForestStrike()
                        State.Step = "wait_spawn_back"
                    elseif tick() - State.CollectTime > Config.CollectInterval then
                        State.CollectTime = tick()
                        if IsFirstEggInContainer() then
                            RemoteCollectFirst()
                            State.CollectAttempts = State.CollectAttempts + 1
                        elseif IsFirstEggInWorkspace() then
                            State.CollectDone = true
                            FireForestStrike()
                            State.Step = "wait_spawn_back"
                        end
                    end
                end

                if State.Step == "wait_spawn_back" and not State.FlyTargetStarted then
                    if IsFirstEggInContainer() then
                        task.spawn(function() StartFlyToTarget() end)
                    end
                end

                if State.Step == "collect_target" and not State.TargetCollected then
                    if IsTargetCollected() then
                        State.TargetCollected = true
                        State.RecoveryTriggered = false
                        task.spawn(function() FlyToSafeZone() end)
                    else
                        if State.Mode == "spawn" then
                            if workspace:FindFirstChild(State.TargetUid) then
                                State.TargetCollected = true
                                task.spawn(function() FlyToSafeZone() end)
                            end
                        elseif State.Mode == "workspace" and State.SavedTargetPosition then
                            local Egg = workspace:FindFirstChild(State.TargetUid)
                            if Egg then
                                local Pos = GetPosition(Egg)
                                if Pos and (Pos - State.SavedTargetPosition).Magnitude >= Config.PositionThreshold then
                                    State.TargetCollected = true
                                    task.spawn(function() FlyToSafeZone() end)
                                end
                            end
                        end
                        if tick() - State.CollectTime > Config.CollectInterval then
                            State.CollectTime = tick()
                            RemoteCollectTarget()
                            State.CollectAttempts = State.CollectAttempts + 1
                        end
                        if tick() - State.TargetCollectStartTime > Config.TargetCollectTimeout then
                            if not State.RecoveryTriggered then
                                State.RecoveryTriggered = true
                                task.spawn(function() FlyToTargetAgain() end)
                            end
                        end
                    end
                end

                if State.Step == "to_safe" then
                    if not IsTargetCollected() then
                        if not State.RecoveryTriggered then
                            State.RecoveryTriggered = true
                            task.spawn(function() FlyToTargetAgain() end)
                        end
                    else
                        State.RecoveryTriggered = false
                    end
                end
            end
        end)
    end

    StartProcess = function()
        State.Running = true
        State.Step = "search"
        State.FlySequence = 0
        State.CollectAttempts = 0
        State.CollectTime = 0
        State.TargetCollectStartTime = 0
        State.FlyTargetStarted = false
        State.CollectDone = false
        State.TargetCollected = false
        State.RemotesFired = false
        State.RecoveryTriggered = false
        State.RecoveryAttempts = 0

        SetupDropHeldEgg()
        SaveStats()
        EnableRagdollBypass()

        local Location = CheckTargetUID(State.TargetUid, "spawn_only")
        if Location == "spawn" then
            State.Mode = "spawn"
        else
            local Waited = 0
            while State.Running and CheckTargetUID(State.TargetUid, "spawn_only") == "none" do
                task.wait(0.1)
                Waited = Waited + 0.1
                if Waited > 3 then AutoStop() return end
            end
            State.Mode = "spawn"
        end

        SearchFirstEggs()
        if #State.FirstEggList == 0 then
            task.wait(0.3)
            SearchFirstEggs()
            if #State.FirstEggList == 0 then AutoStop() return end
        end
        local Closest = FindClosestEgg()
        if not Closest then AutoStop() return end
        local EggPos = GetPosition(Closest.Slot)
        if not EggPos then AutoStop() return end
        State.Step = "fly_first"
        StartActiveTask()
        FlyTP(EggPos, Config.FirstEggSpeed, true, false, function()
            State.CollectDone = false
            State.CollectTime = 0
            State.Step = "collect_first"
        end)
    end

    local function FullReset()
        if State.LockConnection then State.LockConnection:Disconnect() State.LockConnection = nil end
        State.TargetLockedCFrame = nil
        if State.ActiveTask then pcall(function() task.cancel(State.ActiveTask) end) State.ActiveTask = nil end
        if State.DropHeldEggConnection then State.DropHeldEggConnection:Disconnect() State.DropHeldEggConnection = nil end
        State.DropHeldEgg = nil
        State.PlayerGui = nil
        CleanupMovers()
        DisableRagdollBypass()
        RestoreStats()
        State.Running = false
        State.Step = "idle"
        State.Mode = "none"
        State.FlySequence = State.FlySequence + 1
        State.FirstEggList = {}
        State.FirstEggUid = nil
        State.FirstEggSlotKey = nil
        State.CollectAttempts = 0
        State.CollectTime = 0
        State.TargetCollectStartTime = 0
        State.FlyTargetStarted = false
        State.CollectDone = false
        State.TargetCollected = false
        State.RemotesFired = false
        State.RecoveryTriggered = false
        State.RecoveryAttempts = 0
        State.SavedTargetPosition = nil
    end

    _G.YOKUDO_VIPTP = {
        Enable = function()
            if State.Running then return end
            if not CollectEvent then return end
            if not State.TargetUid then return end
            FullReset()
            StartProcess()
        end,
        Disable = function() FullReset() end,
        SetTargetId = function(Id) State.TargetUid = Id end,
        IsEnabled = function() return State.Running end,
        GetTargetId = function() return State.TargetUid end,
        GetMode = function() return State.Mode end,
        FIRST_EGG_SPEED = Config.FirstEggSpeed,
        RECOVERY_SPEED = Config.RecoverySpeed,
        SAFE_ZONE_SPEED = Config.SafeZoneSpeed,
        FLY_OFFSET = Config.FlyOffset,
        SAFE_ZONE = Config.SafeZone,
    }
end

-- ============ AttackDrone ============
do
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local Player = Players.LocalPlayer

    local ATTACK_RANGE = 16
    local ATTACK_INTERVAL = 0.05
    local FOLLOW_SPEED = 500
    local FOLLOW_BEHIND_DISTANCE = 3
    local SHORT_TP_DISTANCE = 20
    local SPAWN_POSITION_1 = Vector3.new(2140, 77, -367)
    local SPAWN_POSITION_2 = Vector3.new(5723, 77, -376)
    local SAFE_ZONE = Vector3.new(533, 70, -366)
    local POINT_1 = Vector3.new(559, 70, -370)
    local SAFE_WAIT_TIME = 1
    local SPAWN_WAIT_TIME = 2
    local ARRIVE_TIMEOUT = 15
    local CONTAINER_NAME = "ScrambleLocalVisuals"
    local SEARCH_PREFIXES = { "DroneVisual_", "PersonalDrone_" }

    local TIER_PRIORITY = { ["AugmentedDrone"] = 1, ["ReactorDrone"] = 2, ["ScrapDrone"] = 3 }
    local MAX_ALLOWED_PRIORITY = 3

    local AttackDroneEnabled = false
    local AttackConnection, FollowConnection, LockConnection
    local BodyVelocity, BodyGyro
    local CurrentTarget, CurrentTargetPriority
    local LastFire = 0
    local TraceSequence = 0
    local IsLocked = false
    local LockCFrame = nil
    local CurrentSpawnIndex = 1
    local IsFlying = false
    local SpawnLoopRunning = false

    local SavedStats = { WalkSpeed = nil, JumpPower = nil, JumpHeight = nil, UseJumpPower = nil, Humanoid = nil }

    local StartFollow, FlyTPToPosition, StartAttackLoop, SpawnLoop, InitialFlyAndStartLoop

    local function GetHumanoid()
        local Char = Player.Character
        if not Char then return nil, nil end
        return Char:FindFirstChildOfClass("Humanoid"), Char:FindFirstChild("HumanoidRootPart")
    end

    local function GetBatSwingRemote()
        local Success, Remote = pcall(function()
            return ReplicatedStorage.Packages.Networking["RE/BatSwing/Trigger"]
        end)
        if Success and Remote then return Remote end
        return nil
    end

    local function SaveLiveStats()
        local Hum = GetHumanoid()
        if not Hum then return end
        SavedStats.Humanoid = Hum
        SavedStats.WalkSpeed = Hum.WalkSpeed
        SavedStats.JumpPower = Hum.JumpPower
        SavedStats.JumpHeight = Hum.JumpHeight
        SavedStats.UseJumpPower = Hum.UseJumpPower
    end

    local function RestoreLiveStats()
        local Hum = GetHumanoid()
        if not Hum then return end
        if SavedStats.WalkSpeed ~= nil then pcall(function() Hum.WalkSpeed = SavedStats.WalkSpeed end) end
        if SavedStats.JumpPower ~= nil then pcall(function() Hum.JumpPower = SavedStats.JumpPower end) end
        if SavedStats.JumpHeight ~= nil then pcall(function() Hum.JumpHeight = SavedStats.JumpHeight end) end
        if SavedStats.UseJumpPower ~= nil then pcall(function() Hum.UseJumpPower = SavedStats.UseJumpPower end) end
    end

    local function CleanupMovers()
        if FollowConnection then FollowConnection:Disconnect() FollowConnection = nil end
        if LockConnection then LockConnection:Disconnect() LockConnection = nil end
        if BodyVelocity then
            pcall(function()
                BodyVelocity.Velocity = Vector3.zero
                BodyVelocity.MaxForce = Vector3.zero
            end)
            BodyVelocity:Destroy() BodyVelocity = nil
        end
        if BodyGyro then
            pcall(function() BodyGyro.MaxTorque = Vector3.zero end)
            BodyGyro:Destroy() BodyGyro = nil
        end
        local Hum, Root = GetHumanoid()
        if Root then
            for _, Child in ipairs(Root:GetChildren()) do
                if Child.Name == "YokudoBV" or Child.Name == "YokudoBG" then
                    pcall(function() Child:Destroy() end)
                end
            end
        end
        if Hum then pcall(function() Hum.PlatformStand = false Hum.Sit = false end) end
        if Root then
            pcall(function()
                Root.AssemblyLinearVelocity = Vector3.zero
                Root.AssemblyAngularVelocity = Vector3.zero
            end)
        end
        IsLocked = false
        LockCFrame = nil
    end

    local function GetPosition(Object)
        if not Object then return nil end
        if Object:IsA("Model") then
            if Object.PrimaryPart then return Object.PrimaryPart.Position end
            local Part = Object:FindFirstChildWhichIsA("BasePart")
            if Part then return Part.Position end
            for _, Desc in ipairs(Object:GetDescendants()) do
                if Desc:IsA("BasePart") then return Desc.Position end
            end
        elseif Object:IsA("BasePart") then
            return Object.Position
        end
        return nil
    end

    local function GetLookVector(Object)
        if not Object then return Vector3.new(0, 0, -1) end
        local Part = nil
        if Object:IsA("Model") then
            Part = Object.PrimaryPart or Object:FindFirstChildWhichIsA("BasePart")
            if not Part then
                for _, Desc in ipairs(Object:GetDescendants()) do
                    if Desc:IsA("BasePart") then Part = Desc break end
                end
            end
        elseif Object:IsA("BasePart") then
            Part = Object
        end
        if Part then return Part.CFrame.LookVector end
        return Vector3.new(0, 0, -1)
    end

    local function FindAllDrones()
        local Container = workspace:FindFirstChild(CONTAINER_NAME)
        if not Container then return {} end
        local Drones = {}
        for _, obj in ipairs(Container:GetChildren()) do
            for _, prefix in ipairs(SEARCH_PREFIXES) do
                if string.sub(obj.Name, 1, #prefix) == prefix then
                    table.insert(Drones, obj)
                    break
                end
            end
        end
        return Drones
    end

    local function GetDroneTier(Drone)
        if not Drone then return nil end
        local Tier = nil
        pcall(function() Tier = Drone:GetAttribute("ScrambleTier") end)
        return Tier
    end

    local function GetDronePriority(Drone)
        local Tier = GetDroneTier(Drone)
        if not Tier then return nil end
        return TIER_PRIORITY[Tier]
    end

    local function FindBestDrone()
        local Drones = FindAllDrones()
        if #Drones == 0 then return nil end
        local CurrentSpawn = (CurrentSpawnIndex == 1) and SPAWN_POSITION_1 or SPAWN_POSITION_2
        local Best = nil
        local BestPriority = math.huge
        local BestDist = math.huge
        for _, Drone in ipairs(Drones) do
            local Priority = GetDronePriority(Drone)
            if Priority and Priority <= MAX_ALLOWED_PRIORITY then
                local Pos = GetPosition(Drone)
                if Pos then
                    local Dist = math.floor((Pos - CurrentSpawn).Magnitude)
                    if Priority < BestPriority or (Priority == BestPriority and Dist < BestDist) then
                        BestPriority = Priority
                        BestDist = Dist
                        Best = Drone
                    end
                end
            end
        end
        return Best, BestPriority, BestDist
    end

    local function GetBehindPosition(Target)
        local TargetPos = GetPosition(Target)
        if not TargetPos then return nil end
        local LookVector = GetLookVector(Target)
        local BehindPos = TargetPos - (LookVector * FOLLOW_BEHIND_DISTANCE)
        BehindPos = Vector3.new(BehindPos.X, TargetPos.Y + 1, BehindPos.Z)
        return BehindPos
    end

    local function StartLock(Position, LookAt)
        LockCFrame = CFrame.new(Position, LookAt or (Position + Vector3.new(0, 0, -1)))
        if LockConnection then LockConnection:Disconnect() end
        IsLocked = true
        LockConnection = RunService.Heartbeat:Connect(function()
            if not AttackDroneEnabled then
                if LockConnection then LockConnection:Disconnect() LockConnection = nil end
                IsLocked = false
                return
            end
            local Hum, Root = GetHumanoid()
            if not Root then return end
            if CurrentTarget and CurrentTarget.Parent then
                local NewBehind = GetBehindPosition(CurrentTarget)
                local NewTargetPos = GetPosition(CurrentTarget)
                if NewBehind and NewTargetPos then LockCFrame = CFrame.new(NewBehind, NewTargetPos) end
            end
            Root.CFrame = LockCFrame
            Root.AssemblyLinearVelocity = Vector3.zero
            Root.AssemblyAngularVelocity = Vector3.zero
        end)
    end

    StartFollow = function()
        CleanupMovers()
        local Hum, Root = GetHumanoid()
        if not Hum or not Root then return end
        if Hum.Health <= 0 then return end
        Hum.PlatformStand = true
        BodyVelocity = Instance.new("BodyVelocity")
        BodyVelocity.Name = "YokudoBV"
        BodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        BodyVelocity.P = 1250
        BodyVelocity.Velocity = Vector3.zero
        BodyVelocity.Parent = Root
        BodyGyro = Instance.new("BodyGyro")
        BodyGyro.Name = "YokudoBG"
        BodyGyro.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
        BodyGyro.P = 3000
        BodyGyro.D = 500
        BodyGyro.CFrame = Root.CFrame
        BodyGyro.Parent = Root
        FollowConnection = RunService.Heartbeat:Connect(function()
            if not AttackDroneEnabled then CleanupMovers() return end
            local Hum2, Root2 = GetHumanoid()
            if not Hum2 or not Root2 then CleanupMovers() return end
            if Hum2.Health <= 0 then return end
            if not BodyVelocity or not BodyGyro then CleanupMovers() return end
            if not CurrentTarget or not CurrentTarget.Parent then CleanupMovers() return end
            local TargetPos = GetPosition(CurrentTarget)
            if not TargetPos then CleanupMovers() return end
            local BehindPos = GetBehindPosition(CurrentTarget)
            if not BehindPos then CleanupMovers() return end
            local CurrentPos = Root2.Position
            local Direction = BehindPos - CurrentPos
            local TotalDist = math.floor(Direction.Magnitude)
            if TotalDist <= SHORT_TP_DISTANCE then
                if BodyVelocity then BodyVelocity.Velocity = Vector3.zero BodyVelocity.MaxForce = Vector3.zero end
                if BodyGyro then BodyGyro.MaxTorque = Vector3.zero end
                task.wait(0.1)
                CleanupMovers()
                Root2.CFrame = CFrame.new(BehindPos, TargetPos)
                Root2.AssemblyLinearVelocity = Vector3.zero
                Root2.AssemblyAngularVelocity = Vector3.zero
                StartLock(BehindPos, TargetPos)
                return
            end
            BodyVelocity.Velocity = Direction.Unit * FOLLOW_SPEED
            BodyGyro.CFrame = CFrame.new(CurrentPos, TargetPos)
        end)
    end

    FlyTPToPosition = function(Destination, Callback)
        CleanupMovers()
        IsFlying = true
        local Hum, Root = GetHumanoid()
        if not Hum or not Root then IsFlying = false if Callback then Callback() end return end
        if Hum.Health <= 0 then IsFlying = false if Callback then Callback() end return end
        Hum.PlatformStand = true
        BodyVelocity = Instance.new("BodyVelocity")
        BodyVelocity.Name = "YokudoBV"
        BodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        BodyVelocity.P = 1250
        BodyVelocity.Velocity = Vector3.zero
        BodyVelocity.Parent = Root
        BodyGyro = Instance.new("BodyGyro")
        BodyGyro.Name = "YokudoBG"
        BodyGyro.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
        BodyGyro.P = 3000
        BodyGyro.D = 500
        BodyGyro.CFrame = Root.CFrame
        BodyGyro.Parent = Root
        local StartTime = tick()
        FollowConnection = RunService.Heartbeat:Connect(function()
            if not AttackDroneEnabled then CleanupMovers() IsFlying = false return end
            local Hum2, Root2 = GetHumanoid()
            if not Hum2 or not Root2 then CleanupMovers() IsFlying = false return end
            if Hum2.Health <= 0 then return end
            if not BodyVelocity or not BodyGyro then CleanupMovers() IsFlying = false return end
            local CurrentPos = Root2.Position
            local Direction = Destination - CurrentPos
            local TotalDist = math.floor(Direction.Magnitude)
            if TotalDist <= 2 then
                if BodyVelocity then BodyVelocity.Velocity = Vector3.zero BodyVelocity.MaxForce = Vector3.zero end
                if BodyGyro then BodyGyro.MaxTorque = Vector3.zero end
                task.wait(0.1)
                CleanupMovers()
                IsFlying = false
                Root2.CFrame = CFrame.new(Destination)
                Root2.AssemblyLinearVelocity = Vector3.zero
                Root2.AssemblyAngularVelocity = Vector3.zero
                if Callback then Callback() end
                return
            end
            if tick() - StartTime > ARRIVE_TIMEOUT then
                CleanupMovers()
                IsFlying = false
                if Callback then Callback() end
                return
            end
            BodyVelocity.Velocity = Direction.Unit * FOLLOW_SPEED
            BodyGyro.CFrame = CFrame.new(CurrentPos, Destination)
        end)
    end

    SpawnLoop = function()
        if SpawnLoopRunning then return end
        SpawnLoopRunning = true
        task.spawn(function()
            while AttackDroneEnabled do
                local CurrentSpawn = (CurrentSpawnIndex == 1) and SPAWN_POSITION_1 or SPAWN_POSITION_2
                if CurrentTarget and CurrentTarget.Parent then
                    task.wait(0.5)
                    continue
                end
                local Arrived = false
                FlyTPToPosition(CurrentSpawn, function() Arrived = true end)
                local WaitTime = 0
                while AttackDroneEnabled and not Arrived and WaitTime < ARRIVE_TIMEOUT do
                    task.wait(0.1)
                    WaitTime = WaitTime + 0.1
                end
                if not AttackDroneEnabled then break end
                task.wait(SPAWN_WAIT_TIME)
                if not AttackDroneEnabled then break end
                local Found = FindBestDrone()
                if Found and Found.Parent then
                    CurrentTarget = Found
                    StartFollow()
                    while AttackDroneEnabled and CurrentTarget and CurrentTarget.Parent do
                        task.wait(0.5)
                    end
                    CurrentSpawnIndex = 1
                else
                    CurrentSpawnIndex = (CurrentSpawnIndex == 1) and 2 or 1
                end
                task.wait(0.2)
            end
            SpawnLoopRunning = false
        end)
    end

    local function FireAtDrone(Drone)
        if not Drone or not Drone.Parent then return end
        local isDrone = false
        for _, prefix in ipairs(SEARCH_PREFIXES) do
            if string.sub(Drone.Name, 1, #prefix) == prefix then
                isDrone = true
                break
            end
        end
        if not isDrone then return end
        local Remote = GetBatSwingRemote()
        if not Remote then return end
        local Hum, Root = GetHumanoid()
        if not Root then return end
        local DronePos = GetPosition(Drone)
        if not DronePos then return end
        local Dist = math.floor((DronePos - Root.Position).Magnitude)
        if Dist > ATTACK_RANGE then return end
        TraceSequence = TraceSequence + 1
        local TraceId = tostring(Player.UserId) .. ":" .. tostring(TraceSequence) .. ":" .. tostring(math.floor(workspace:GetServerTimeNow() * 1000))
        pcall(function() Remote:FireServer(Drone, TraceId) end)
    end

    StartAttackLoop = function()
        if AttackConnection then AttackConnection:Disconnect() AttackConnection = nil end
        AttackConnection = RunService.Heartbeat:Connect(function()
            if not AttackDroneEnabled then return end
            if IsFlying then return end
            local Hum, Root = GetHumanoid()
            if not Hum or not Root then return end
            if Hum.Health <= 0 then return end
            if not CurrentTarget or not CurrentTarget.Parent then
                local NewTarget, NewPriority = FindBestDrone()
                if NewTarget then
                    CurrentTarget = NewTarget
                    CurrentTargetPriority = NewPriority
                    StartFollow()
                end
                return
            end
            local CurrentPriority = GetDronePriority(CurrentTarget)
            local BestDrone, BestPriority = FindBestDrone()
            if BestDrone and BestPriority and CurrentPriority and BestPriority < CurrentPriority then
                CurrentTarget = BestDrone
                CurrentTargetPriority = BestPriority
                StartFollow()
                return
            end
            local now = tick()
            if now - LastFire >= ATTACK_INTERVAL then
                LastFire = now
                FireAtDrone(CurrentTarget)
            end
        end)
    end

    InitialFlyAndStartLoop = function()
        local Hum, Root = GetHumanoid()
        if not Root then return end
        local PlayerPos = Root.Position
        local PlayerToPoint1Signed = math.floor(PlayerPos.X - POINT_1.X)
        if PlayerToPoint1Signed > 0 then
            CurrentSpawnIndex = 1
            SpawnLoop()
        else
            local SafeArrived = false
            FlyTPToPosition(SAFE_ZONE, function() SafeArrived = true end)
            local WaitTime = 0
            while AttackDroneEnabled and not SafeArrived and WaitTime < ARRIVE_TIMEOUT do
                task.wait(0.1)
                WaitTime = WaitTime + 0.1
            end
            if not AttackDroneEnabled then return end
            task.wait(SAFE_WAIT_TIME)
            CurrentSpawnIndex = 1
            SpawnLoop()
        end
    end

    local function StartAttack()
        if AttackDroneEnabled then return end
        AttackDroneEnabled = true
        SaveLiveStats()
        if _G.YOKUDO_AutoAttack then _G.YOKUDO_AutoAttack.EnableAutoEquip() end
        StartAttackLoop()
        task.spawn(function() InitialFlyAndStartLoop() end)
    end

    local function StopAttackDrone()
        if not AttackDroneEnabled then return end
        AttackDroneEnabled = false
        if AttackConnection then AttackConnection:Disconnect() AttackConnection = nil end
        CleanupMovers()
        CurrentTarget = nil
        CurrentTargetPriority = nil
        CurrentSpawnIndex = 1
        IsFlying = false
        SpawnLoopRunning = false
        RestoreLiveStats()
        if _G.YOKUDO_AutoAttack then _G.YOKUDO_AutoAttack.DisableAutoEquip() end
        local Hum, Root = GetHumanoid()
        if Root then
            pcall(function()
                Root.AssemblyLinearVelocity = Vector3.zero
                Root.AssemblyAngularVelocity = Vector3.zero
            end)
        end
    end

    _G.YOKUDO_AttackDrone = {
        Start = StartAttack,
        Stop = StopAttackDrone,
        Enable = StartAttack,
        Disable = StopAttackDrone,
        Toggle = function() if AttackDroneEnabled then StopAttackDrone() else StartAttack() end end,
        IsEnabled = function() return AttackDroneEnabled end,
        StopAttack = function()
            CleanupMovers()
            CurrentTarget = nil
            CurrentTargetPriority = nil
            SpawnLoopRunning = false
        end,
        SpawnLoop = SpawnLoop,
        InitialFlyAndStartLoop = InitialFlyAndStartLoop,
        FindAllDrones = FindAllDrones,
        FindBestDrone = FindBestDrone,
        GetDronePriority = GetDronePriority,
        GetBatSwingRemote = GetBatSwingRemote,
        GetSavedStats = function() return SavedStats end,
        SPAWN_POSITION_1 = SPAWN_POSITION_1,
        SPAWN_POSITION_2 = SPAWN_POSITION_2,
        SAFE_ZONE = SAFE_ZONE,
        POINT_1 = POINT_1,
        TIER_PRIORITY = TIER_PRIORITY,
        MAX_ALLOWED_PRIORITY = MAX_ALLOWED_PRIORITY,
        FOLLOW_SPEED = FOLLOW_SPEED,
    }
end

print("✅ PART 3/5 OK - Farm + Combat Features Ready")
-- ==================================================
-- SCRIPTER BRO HUB | PART 4/5
-- ManagerDrone + ManualFastClick + FarmingManager + ConfigSystem + BypassAntiCheat
-- ==================================================

-- ============ ManagerDrone ============
do
    local Players = game:GetService("Players")
    local Player = Players.LocalPlayer

    local EVENT_CHECK_INTERVAL = 1
    local EVENT_STOP_ATTACK_THRESHOLD = 10
    local AFK_JUMP_WAIT = 0.5

    local ManagerEnabled = false
    local ManagerThread = nil

    local function GetEventInfo()
        local Success, Value = pcall(function()
            return Player.PlayerGui.HUD.GameHUD.BottomRight.ExperimentTimer.Value.Text
        end)
        if not Success or not Value then return 0, "", false end
        local Text = tostring(Value)
        local HasEventEnds = string.find(Text, "Event ends") ~= nil
        local IsEventActive = HasEventEnds
        local M = tonumber(string.match(Text, "(%d+)m")) or 0
        local S = tonumber(string.match(Text, "(%d+)s")) or 0
        return M * 60 + S, Text, IsEventActive
    end

    local function ForceStopAll()
        if _G.YOKUDO_AttackDrone then pcall(function() _G.YOKUDO_AttackDrone.Stop() end) end
        if _G.YOKUDO_AFKSystem then pcall(function() _G.YOKUDO_AFKSystem.Disable() end) end
    end

    local function SwitchAFKToAttack()
        local TreadmillPos = nil
        if _G.YOKUDO_AFKSystem then TreadmillPos = _G.YOKUDO_AFKSystem.GetMyTreadmillPos() end
        if not TreadmillPos and _G.YOKUDO_AFKSystem then
            local _, Treadmill = _G.YOKUDO_AFKSystem.FindMyPlotAndTreadmill()
            if Treadmill then TreadmillPos = Treadmill.Position end
        end
        if not TreadmillPos then
            if _G.YOKUDO_AFKSystem then _G.YOKUDO_AFKSystem.Disable() end
            task.wait(0.5)
            if _G.YOKUDO_AttackDrone then _G.YOKUDO_AttackDrone.Start() end
            return
        end
        _G.YOKUDO_AFKSystem.JumpOutTreadmill(TreadmillPos, function()
            if _G.YOKUDO_AFKSystem then _G.YOKUDO_AFKSystem.Disable() end
            task.wait(AFK_JUMP_WAIT)
            if _G.YOKUDO_AttackDrone then _G.YOKUDO_AttackDrone.Start() end
        end)
    end

    local function MainLoop()
        while ManagerEnabled do
            local EventSec, EventText, IsEventActive = GetEventInfo()
            local EventNotActive = not IsEventActive
            local EventStopAttack = IsEventActive and EventSec > 0 and EventSec <= EVENT_STOP_ATTACK_THRESHOLD
            local EventActive = IsEventActive and EventSec > EVENT_STOP_ATTACK_THRESHOLD

            if EventNotActive then
                if _G.YOKUDO_AttackDrone and _G.YOKUDO_AttackDrone.IsEnabled() then
                    _G.YOKUDO_AttackDrone.Stop()
                end
                if _G.YOKUDO_AFKSystem and not _G.YOKUDO_AFKSystem.IsEnabled() then
                    _G.YOKUDO_AFKSystem.Enable()
                end
            elseif EventStopAttack then
                if _G.YOKUDO_AttackDrone and _G.YOKUDO_AttackDrone.IsEnabled() then
                    _G.YOKUDO_AttackDrone.Stop()
                end
                if _G.YOKUDO_AFKSystem and not _G.YOKUDO_AFKSystem.IsEnabled() then
                    _G.YOKUDO_AFKSystem.Enable()
                end
            elseif EventActive then
                if _G.YOKUDO_AFKSystem and _G.YOKUDO_AFKSystem.IsEnabled() then
                    SwitchAFKToAttack()
                elseif _G.YOKUDO_AttackDrone and not _G.YOKUDO_AttackDrone.IsEnabled() then
                    _G.YOKUDO_AttackDrone.Start()
                end
            end
            task.wait(EVENT_CHECK_INTERVAL)
        end
        ForceStopAll()
    end

    local function EnableManager()
        if ManagerEnabled then return end
        ManagerEnabled = true
        if ManagerThread then pcall(function() task.cancel(ManagerThread) end) ManagerThread = nil end
        ManagerThread = task.spawn(function() MainLoop() end)
    end

    local function DisableManager()
        if not ManagerEnabled then return end
        ManagerEnabled = false
        if ManagerThread then pcall(function() task.cancel(ManagerThread) end) ManagerThread = nil end
        ForceStopAll()
    end

    Player.CharacterAdded:Connect(function(Char)
        if ManagerEnabled then
            task.wait(1)
            if ManagerThread then pcall(function() task.cancel(ManagerThread) end) ManagerThread = nil end
            ManagerThread = task.spawn(function() MainLoop() end)
        end
    end)

    _G.YOKUDO_ManagerDrone = {
        Enable = EnableManager,
        Disable = DisableManager,
        Toggle = function() if ManagerEnabled then DisableManager() else EnableManager() end end,
        IsEnabled = function() return ManagerEnabled end,
        GetEventInfo = GetEventInfo,
        ForceStopAll = ForceStopAll,
        SwitchAFKToAttack = SwitchAFKToAttack,
    }
end

-- ============ ManualFastClick ============
do
    local ProximityPromptService = game:GetService("ProximityPromptService")
    local RunService = game:GetService("RunService")

    local ManualFastClickEnabled = false
    local PromptConnection, HeartbeatConnection

    local function ApplyHoldDuration(prompt)
        if not prompt then return end
        pcall(function() prompt.HoldDuration = 0 end)
    end

    local function ScanAllPrompts()
        for _, descendant in ipairs(workspace:GetDescendants()) do
            if descendant:IsA("ProximityPrompt") then ApplyHoldDuration(descendant) end
        end
        local Player = game.Players.LocalPlayer
        if Player then
            local PlayerGui = Player:FindFirstChild("PlayerGui")
            if PlayerGui then
                for _, descendant in ipairs(PlayerGui:GetDescendants()) do
                    if descendant:IsA("ProximityPrompt") then ApplyHoldDuration(descendant) end
                end
            end
        end
    end

    local function EnableManualFastClick()
        if ManualFastClickEnabled then return end
        ManualFastClickEnabled = true
        ScanAllPrompts()
        if PromptConnection then PromptConnection:Disconnect() PromptConnection = nil end
        PromptConnection = ProximityPromptService.PromptShown:Connect(function(prompt)
            if not ManualFastClickEnabled then return end
            ApplyHoldDuration(prompt)
        end)
        if HeartbeatConnection then HeartbeatConnection:Disconnect() HeartbeatConnection = nil end
        local Counter = 0
        HeartbeatConnection = RunService.Heartbeat:Connect(function()
            if not ManualFastClickEnabled then return end
            Counter = Counter + 1
            if Counter >= 30 then
                Counter = 0
                ScanAllPrompts()
            end
        end)
    end

    local function DisableManualFastClick()
        if not ManualFastClickEnabled then return end
        ManualFastClickEnabled = false
        if PromptConnection then PromptConnection:Disconnect() PromptConnection = nil end
        if HeartbeatConnection then HeartbeatConnection:Disconnect() HeartbeatConnection = nil end
    end

    _G.YOKUDO_ManualFastClick = {
        Enable = EnableManualFastClick,
        Disable = DisableManualFastClick,
        Toggle = function() if ManualFastClickEnabled then DisableManualFastClick() else EnableManualFastClick() end end,
        IsEnabled = function() return ManualFastClickEnabled end,
        ScanAllPrompts = ScanAllPrompts,
        ApplyHoldDuration = ApplyHoldDuration,
    }
end

-- ============ FarmingManager ============
do
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local Workspace = game:GetService("Workspace")
    local Player = Players.LocalPlayer

    local AreaEggCycle = nil
    pcall(function()
        AreaEggCycle = require(ReplicatedStorage.Shared.Util.AreaEggCycle)
    end)

    local NIGHT_CHECK_INTERVAL = 0.03
    local DAY_CHECK_INTERVAL = 0.05
    local SAFE_ZONE = Vector3.new(533, 70, -366)
    local SAFE_ZONE_DIST = 5
    local SAFE_WAIT_AFTER_REACH = 1
    local SAFE_FLY_SPEED = 500

    local Cache = { MeshIdMap = {}, MeshIdMapBuilt = false, PetData = {}, UidCategory = {} }
    local SelectedRarities = { Divine = true, Eternal = true, Secret = true }
    local RARITY_PRIORITY = { Divine = 1, Eternal = 2, Secret = 3 }

    local function BuildMeshIdMap()
        if Cache.MeshIdMapBuilt then return end
        local Data = ReplicatedStorage:FindFirstChild("Data")
        if not Data then return end
        local Assets = Data:FindFirstChild("Assets")
        if not Assets then return end
        local Configs = Assets:FindFirstChild("Configs")
        local RA = ReplicatedStorage:FindFirstChild("Assets")
        if not RA then return end
        local M = RA:FindFirstChild("Models")
        if not M then return end
        local EggModels = M:FindFirstChild("Eggs")
        if not Configs or not EggModels then return end
        for _, Config in ipairs(Configs:GetChildren()) do
            local Success, Module = pcall(function() return require(Config) end)
            if Success and Module and Module.Egg then
                local ModelName = Module.Egg.ModelName or Config.Name
                local Template = EggModels:FindFirstChild(ModelName)
                if Template then
                    for _, Desc in ipairs(Template:GetDescendants()) do
                        if Desc:IsA("MeshPart") and Desc.MeshId ~= "" then
                            Cache.MeshIdMap[Desc.MeshId] = Config.Name
                        end
                        if Desc:IsA("SpecialMesh") and Desc.MeshId ~= "" then
                            Cache.MeshIdMap[Desc.MeshId] = Config.Name
                        end
                    end
                end
            end
        end
        Cache.MeshIdMapBuilt = true
    end

    local function GetPetData(AssetCategory)
        if not AssetCategory then return nil end
        if Cache.PetData[AssetCategory] then return Cache.PetData[AssetCategory] end
        local Data = ReplicatedStorage:FindFirstChild("Data")
        if not Data then return nil end
        local Assets = Data:FindFirstChild("Assets")
        if not Assets then return nil end
        local Configs = Assets:FindFirstChild("Configs")
        if not Configs then return nil end
        local Config = Configs:FindFirstChild(AssetCategory)
        if not Config then return nil end
        local Success, Module = pcall(function() return require(Config) end)
        if not Success or not Module then return nil end
        local PData = {
            Rarity = Module.Rarity and (Module.Rarity._id or Module.Rarity.RarityId) or nil,
            EarningRate = Module.EarningRate or 0,
            DisplayName = Module.DisplayName or AssetCategory,
        }
        Cache.PetData[AssetCategory] = PData
        return PData
    end

    local function FindAssetCategory(EggModel)
        if not EggModel then return nil end
        local Uid = EggModel.Name
        if Cache.UidCategory[Uid] then return Cache.UidCategory[Uid] end
        if not Cache.MeshIdMapBuilt then BuildMeshIdMap() end
        for _, Desc in ipairs(EggModel:GetDescendants()) do
            if Desc:IsA("MeshPart") and Desc.MeshId ~= "" then
                local Cat = Cache.MeshIdMap[Desc.MeshId]
                if Cat then Cache.UidCategory[Uid] = Cat return Cat end
            end
            if Desc:IsA("SpecialMesh") and Desc.MeshId ~= "" then
                local Cat = Cache.MeshIdMap[Desc.MeshId]
                if Cat then Cache.UidCategory[Uid] = Cat return Cat end
            end
        end
        return nil
    end

    local function SortEggs(EggList)
        table.sort(EggList, function(a, b)
            local Pa = RARITY_PRIORITY[a.Rarity] or 999
            local Pb = RARITY_PRIORITY[b.Rarity] or 999
            if Pa ~= Pb then return Pa < Pb end
            return a.EarningRate > b.EarningRate
        end)
    end

    local function FindBestEgg()
        local EggList = {}
        local Container = workspace:FindFirstChild("AreaEggSlotsClient")
        if Container then
            for _, Slot in ipairs(Container:GetChildren()) do
                if Slot:IsA("Model") then
                    local Category = FindAssetCategory(Slot)
                    if Category then
                        local Data = GetPetData(Category)
                        if Data and SelectedRarities[Data.Rarity] then
                            table.insert(EggList, {
                                Slot = Slot, Uid = Slot.Name, Rarity = Data.Rarity,
                                EarningRate = Data.EarningRate, DisplayName = Data.DisplayName,
                                Location = "spawn"
                            })
                        end
                    end
                end
            end
        end
        if #EggList > 0 then SortEggs(EggList) return EggList[1] end
        for _, Obj in ipairs(workspace:GetChildren()) do
            if Obj:IsA("Model") and string.find(Obj.Name, "FirstAreaEgg") then
                local Category = FindAssetCategory(Obj)
                if Category then
                    local Data = GetPetData(Category)
                    if Data and SelectedRarities[Data.Rarity] then
                        table.insert(EggList, {
                            Slot = Obj, Uid = Obj.Name, Rarity = Data.Rarity,
                            EarningRate = Data.EarningRate, DisplayName = Data.DisplayName,
                            Location = "workspace"
                        })
                    end
                end
            end
        end
        if #EggList == 0 then return nil end
        SortEggs(EggList)
        return EggList[1]
    end

    local FarmingEnabled = false
    local CurrentState = "IDLE"
    local CurrentPhase = "UNKNOWN"
    local FarmingThread = nil
    local AFKStarted = false
    local PendingEggUid = nil
    local WaitingForVIPTP = false

    local FlyConnection, BodyVelocity, BodyGyro

    local function GetRoot()
        local Char = Player.Character
        if not Char then return nil end
        return Char:FindFirstChild("HumanoidRootPart")
    end

    local function GetHum()
        local Char = Player.Character
        if not Char then return nil end
        return Char:FindFirstChildOfClass("Humanoid")
    end

    local function CleanupFly()
        if FlyConnection then FlyConnection:Disconnect() FlyConnection = nil end
        if BodyVelocity then
            pcall(function()
                BodyVelocity.Velocity = Vector3.zero
                BodyVelocity.MaxForce = Vector3.zero
            end)
            BodyVelocity:Destroy() BodyVelocity = nil
        end
        if BodyGyro then
            pcall(function() BodyGyro.MaxTorque = Vector3.zero end)
            BodyGyro:Destroy() BodyGyro = nil
        end
        local Hum = GetHum() local Root = GetRoot()
        if Hum then pcall(function() Hum.PlatformStand = false Hum.Sit = false end) end
        if Root then
            pcall(function()
                Root.AssemblyLinearVelocity = Vector3.zero
                Root.AssemblyAngularVelocity = Vector3.zero
            end)
        end
    end

    local function SelfFlyTP(Destination, Speed, Callback)
        CleanupFly()
        local Hum = GetHum() local Root = GetRoot()
        if not Hum or not Root then if Callback then Callback() end return end
        if Hum.Health <= 0 then if Callback then Callback() end return end
        Hum.PlatformStand = true
        BodyVelocity = Instance.new("BodyVelocity")
        BodyVelocity.Name = "YokudoBV"
        BodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        BodyVelocity.P = 1250
        BodyVelocity.Velocity = Vector3.zero
        BodyVelocity.Parent = Root
        BodyGyro = Instance.new("BodyGyro")
        BodyGyro.Name = "YokudoBG"
        BodyGyro.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
        BodyGyro.P = 3000
        BodyGyro.D = 500
        BodyGyro.CFrame = Root.CFrame
        BodyGyro.Parent = Root
        local StartTime = tick()
        FlyConnection = RunService.Heartbeat:Connect(function()
            if not FarmingEnabled then CleanupFly() return end
            local Hum2 = GetHum() local Root2 = GetRoot()
            if not Hum2 or not Root2 then CleanupFly() return end
            if Hum2.Health <= 0 then return end
            if not BodyVelocity or not BodyGyro then CleanupFly() return end
            local CurrentPos = Root2.Position
            local Direction = Destination - CurrentPos
            local TotalDist = Direction.Magnitude
            if TotalDist <= 3 then
                CleanupFly()
                Root2.CFrame = CFrame.new(Destination)
                Root2.AssemblyLinearVelocity = Vector3.zero
                Root2.AssemblyAngularVelocity = Vector3.zero
                if Callback then Callback() end
                return
            end
            if tick() - StartTime > 30 then
                CleanupFly()
                if Callback then Callback() end
                return
            end
            BodyVelocity.Velocity = Direction.Unit * Speed
            BodyGyro.CFrame = CFrame.new(CurrentPos, Destination)
        end)
    end

    local function GetPhase()
        if AreaEggCycle then
            local Success, IsNight = pcall(function()
                return AreaEggCycle.IsNightPhase(Workspace:GetServerTimeNow())
            end)
            if Success then return IsNight and "Night" or "Day" end
        end
        local Success, Text = pcall(function()
            return Player.PlayerGui.HUD.GameHUD.BottomRight.NightTimer.Value.Text
        end)
        if Success and Text then
            local M = tonumber(string.match(Text, "(%d+)m")) or 0
            local S = tonumber(string.match(Text, "(%d+)s")) or 0
            local Sec = M * 60 + S
            return Sec > 10 and "Day" or "Night"
        end
        return "UNKNOWN"
    end

    local function StopAll()
        if _G.YOKUDO_AFKSystem and _G.YOKUDO_AFKSystem.IsEnabled() then
            local TreadmillPos = _G.YOKUDO_AFKSystem.GetMyTreadmillPos()
            if not TreadmillPos then
                local _, Treadmill = _G.YOKUDO_AFKSystem.FindMyPlotAndTreadmill()
                if Treadmill then TreadmillPos = Treadmill.Position end
            end
            if TreadmillPos then
                _G.YOKUDO_AFKSystem.JumpOutTreadmill(TreadmillPos, function()
                    _G.YOKUDO_AFKSystem.Disable()
                    AFKStarted = false
                end)
            else
                _G.YOKUDO_AFKSystem.Disable()
                AFKStarted = false
            end
        end
        if _G.YOKUDO_VIPTP and _G.YOKUDO_VIPTP.IsEnabled() then _G.YOKUDO_VIPTP.Disable() end
        if _G.YOKUDO_TeleportSystem and _G.YOKUDO_TeleportSystem.IsEnabled() then _G.YOKUDO_TeleportSystem.Disable() end
        CleanupFly()
    end

    local function FlyToSafeZoneAndWait()
        local Root = GetRoot()
        if not Root then return false end
        local DistToSafe = (Root.Position - SAFE_ZONE).Magnitude
        if DistToSafe <= SAFE_ZONE_DIST then return true end
        SelfFlyTP(SAFE_ZONE, SAFE_FLY_SPEED)
        local WaitTime = 0
        while FarmingEnabled and WaitTime < 10 do
            local Root2 = GetRoot()
            if Root2 then
                local Dist = (Root2.Position - SAFE_ZONE).Magnitude
                if Dist <= SAFE_ZONE_DIST then return true end
            end
            task.wait(0.05)
            WaitTime = WaitTime + 0.05
        end
        return false
    end

    local function StartVIPTP(EggUid)
        if not _G.YOKUDO_VIPTP then return end
        WaitingForVIPTP = true
        _G.YOKUDO_VIPTP.SetTargetId(EggUid)
        _G.YOKUDO_VIPTP.Enable()
    end

    local function OnVIPTPComplete()
        if not FarmingEnabled then return end
        if not WaitingForVIPTP then return end
        WaitingForVIPTP = false
        AFKStarted = false

        local BestEgg = FindBestEgg()
        if BestEgg then
            PendingEggUid = BestEgg.Uid
            task.spawn(function()
                local ReachedSafe = FlyToSafeZoneAndWait()
                if ReachedSafe and PendingEggUid then
                    task.wait(SAFE_WAIT_AFTER_REACH)
                    StartVIPTP(PendingEggUid)
                    PendingEggUid = nil
                else
                    if _G.YOKUDO_AFKSystem and not _G.YOKUDO_AFKSystem.IsEnabled() then
                        _G.YOKUDO_AFKSystem.Enable()
                        AFKStarted = true
                    end
                end
            end)
        else
            if _G.YOKUDO_AFKSystem and not _G.YOKUDO_AFKSystem.IsEnabled() then
                _G.YOKUDO_AFKSystem.Enable()
                AFKStarted = true
            end
        end
    end

    local function WaitForDay()
        while FarmingEnabled do
            local Phase = GetPhase()
            CurrentPhase = Phase
            if Phase == "Day" then return true end
            task.wait(DAY_CHECK_INTERVAL)
        end
        return false
    end

    local function NightLoop()
        while FarmingEnabled do
            local Phase = GetPhase()
            CurrentPhase = Phase
            if Phase == "Day" then return end
            local BestEgg = FindBestEgg()
            if BestEgg then
                PendingEggUid = BestEgg.Uid
                StopAll()
                task.wait(0.3)
                local ReachedSafe = FlyToSafeZoneAndWait()
                if ReachedSafe then
                    task.wait(SAFE_WAIT_AFTER_REACH)
                    local IsDay = WaitForDay()
                    if IsDay and PendingEggUid then
                        StartVIPTP(PendingEggUid)
                        PendingEggUid = nil
                        while WaitingForVIPTP and FarmingEnabled do task.wait(0.2) end
                    end
                end
                return
            else
                if not AFKStarted then
                    if _G.YOKUDO_AFKSystem and not _G.YOKUDO_AFKSystem.IsEnabled() then
                        _G.YOKUDO_AFKSystem.Enable()
                        AFKStarted = true
                    end
                end
            end
            task.wait(NIGHT_CHECK_INTERVAL)
        end
    end

    local function DayLoop()
        while FarmingEnabled do
            local Phase = GetPhase()
            CurrentPhase = Phase
            if Phase == "Night" then return end
            local BestEgg = FindBestEgg()
            if BestEgg then
                StopAll()
                task.wait(0.3)
                FlyToSafeZoneAndWait()
                task.wait(0.5)
                StartVIPTP(BestEgg.Uid)
                while WaitingForVIPTP and FarmingEnabled do task.wait(0.2) end
            else
                if _G.YOKUDO_AFKSystem and not _G.YOKUDO_AFKSystem.IsEnabled() then
                    _G.YOKUDO_AFKSystem.Enable()
                    AFKStarted = true
                end
            end
            task.wait(DAY_CHECK_INTERVAL)
        end
    end

    local function MainLoop()
        while FarmingEnabled do
            local Phase = GetPhase()
            CurrentPhase = Phase
            if Phase == "Day" then DayLoop() else NightLoop() end
            task.wait(0.05)
        end
    end

    local function Enable()
        if FarmingEnabled then return end
        FarmingEnabled = true
        CurrentState = "CHECK_TIME"
        AFKStarted = false
        PendingEggUid = nil
        WaitingForVIPTP = false
        if FarmingThread then pcall(function() task.cancel(FarmingThread) end) FarmingThread = nil end
        FarmingThread = task.spawn(function() MainLoop() end)
    end

    local function Disable()
        if not FarmingEnabled then return end
        FarmingEnabled = false
        if FarmingThread then pcall(function() task.cancel(FarmingThread) end) FarmingThread = nil end
        StopAll()
        AFKStarted = false
        PendingEggUid = nil
        WaitingForVIPTP = false
        CurrentState = "IDLE"
        CurrentPhase = "UNKNOWN"
    end

    _G.YOKUDO_FarmingManager = {
        Enable = Enable,
        Disable = Disable,
        Toggle = function() if FarmingEnabled then Disable() else Enable() end end,
        IsEnabled = function() return FarmingEnabled end,
        SetRarities = function(List)
            SelectedRarities = {}
            for _, r in ipairs(List) do SelectedRarities[r] = true end
        end,
        GetState = function() return CurrentState end,
        GetPhase = function() return CurrentPhase end,
        FindBestEgg = FindBestEgg,
        GetEggData = function(Uid)
            if not Uid then return nil end
            local Container = workspace:FindFirstChild("AreaEggSlotsClient")
            local Slot = (Container and Container:FindFirstChild(Uid)) or workspace:FindFirstChild(Uid)
            if not Slot then return nil end
            local Category = FindAssetCategory(Slot)
            if not Category then return nil end
            return GetPetData(Category)
        end,
        GetUidLocation = function(Uid)
            if not Uid then return "none" end
            local Container = workspace:FindFirstChild("AreaEggSlotsClient")
            if Container and Container:FindFirstChild(Uid) then return "spawn" end
            if workspace:FindFirstChild(Uid) then return "workspace" end
            return "none"
        end,
        OnVIPTPComplete = OnVIPTPComplete,
    }

    task.spawn(function()
        task.wait(1)
        BuildMeshIdMap()
    end)

    task.spawn(function()
        while task.wait(30) do Cache.UidCategory = {} end
    end)
end

-- ============ ConfigSystem ============
do
    local HttpService = game:GetService("HttpService")

    local CONFIG_FOLDER = "YOKUDO-SAE"
    local CONFIG_FILE = CONFIG_FOLDER .. "/yokudo.json"

    local DefaultConfig = {
        SelectedMethod = "TeleportFly",
        TeleportSpeed = 300,
    }

    local function EnsureFolder()
        pcall(function()
            if not isfolder(CONFIG_FOLDER) then makefolder(CONFIG_FOLDER) end
        end)
    end

    local function FileExists(Path)
        local Exists = false
        pcall(function() Exists = isfile(Path) end)
        return Exists
    end

    local function LoadConfig()
        EnsureFolder()
        local Config = table.clone(DefaultConfig)
        if not FileExists(CONFIG_FILE) then return Config end
        local Success, RawData = pcall(function() return readfile(CONFIG_FILE) end)
        if not Success or not RawData or RawData == "" then return Config end
        local DecodeSuccess, DecodedData = pcall(function() return HttpService:JSONDecode(RawData) end)
        if not DecodeSuccess or type(DecodedData) ~= "table" then return Config end
        if type(DecodedData.SelectedMethod) == "string" then
            if DecodedData.SelectedMethod == "TeleportFly" or DecodedData.SelectedMethod == "InstantTeleport" then
                Config.SelectedMethod = DecodedData.SelectedMethod
            end
        end
        if type(DecodedData.TeleportSpeed) == "number" then
            Config.TeleportSpeed = math.clamp(DecodedData.TeleportSpeed, 50, 1100)
        end
        return Config
    end

    local function SaveConfig(Config)
        EnsureFolder()
        local DataToSave = {
            SelectedMethod = Config.SelectedMethod or DefaultConfig.SelectedMethod,
            TeleportSpeed = Config.TeleportSpeed or DefaultConfig.TeleportSpeed,
        }
        local EncodeSuccess, EncodedData = pcall(function() return HttpService:JSONEncode(DataToSave) end)
        if not EncodeSuccess then return false end
        local WriteSuccess = pcall(function() writefile(CONFIG_FILE, EncodedData) end)
        return WriteSuccess
    end

    local function ApplyConfig(Config)
        _G.YOKUDO_SelectedMethod = Config.SelectedMethod
        _G.YOKUDO_TeleportSpeed = Config.TeleportSpeed
    end

    local LoadedConfig = LoadConfig()
    ApplyConfig(LoadedConfig)

    _G.YOKUDO_ConfigSystem = {
        Folder = CONFIG_FOLDER,
        File = CONFIG_FILE,
        Default = DefaultConfig,
        Load = function()
            local Config = LoadConfig()
            ApplyConfig(Config)
            task.spawn(function()
                task.wait(0.5)
                if _G.YOKUDO_RefreshSettingUI then _G.YOKUDO_RefreshSettingUI() end
            end)
            return Config
        end,
        Save = function()
            local Config = {
                SelectedMethod = _G.YOKUDO_SelectedMethod or DefaultConfig.SelectedMethod,
                TeleportSpeed = _G.YOKUDO_TeleportSpeed or DefaultConfig.TeleportSpeed,
            }
            return SaveConfig(Config)
        end,
        Get = function()
            return {
                SelectedMethod = _G.YOKUDO_SelectedMethod or DefaultConfig.SelectedMethod,
                TeleportSpeed = _G.YOKUDO_TeleportSpeed or DefaultConfig.TeleportSpeed,
            }
        end,
        Reset = function()
            ApplyConfig(DefaultConfig)
            return SaveConfig(DefaultConfig)
        end,
    }
end

-- ============ BypassAntiCheat ============
do
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    local Player = Players.LocalPlayer

    local BypassEnabled = true
    local DiedConnection = nil
    local CharacterConnection = nil

    local function RunBypassAntiCheat()
        local Character = Player.Character
        if not Character then return end
        local OldHumanoid = Character:FindFirstChildOfClass("Humanoid")
        if not OldHumanoid then return end
        if OldHumanoid:GetAttribute("YokudoBypass") then return end

        local GodMode = true
        local SavedJump = {}
        pcall(function() SavedJump.JumpPower = OldHumanoid.JumpPower end)
        pcall(function() SavedJump.JumpHeight = OldHumanoid.JumpHeight end)
        pcall(function() SavedJump.UseJumpPower = OldHumanoid.UseJumpPower end)

        local SavedStates = {}
        local States = {
            Enum.HumanoidStateType.FallingDown, Enum.HumanoidStateType.Running,
            Enum.HumanoidStateType.RunningNoPhysics, Enum.HumanoidStateType.Climbing,
            Enum.HumanoidStateType.StrafingNoPhysics, Enum.HumanoidStateType.Ragdoll,
            Enum.HumanoidStateType.GettingUp, Enum.HumanoidStateType.Jumping,
            Enum.HumanoidStateType.Landed, Enum.HumanoidStateType.Flying,
            Enum.HumanoidStateType.Freefall, Enum.HumanoidStateType.Seated,
            Enum.HumanoidStateType.PlatformStanding, Enum.HumanoidStateType.Dead,
            Enum.HumanoidStateType.Swimming, Enum.HumanoidStateType.Physics,
        }
        for _, State in ipairs(States) do
            local Success, Enabled = pcall(function() return OldHumanoid:GetStateEnabled(State) end)
            if Success then SavedStates[State] = Enabled end
        end

        local NewHumanoid = OldHumanoid:Clone()
        if not NewHumanoid then return end
        NewHumanoid.Name = OldHumanoid.Name
        NewHumanoid:SetAttribute("YokudoBypass", true)

        for _, Child in ipairs(OldHumanoid:GetChildren()) do
            local Existing = NewHumanoid:FindFirstChild(Child.Name)
            if Existing then pcall(function() Existing:Destroy() end) end
            pcall(function() Child.Parent = NewHumanoid end)
        end

        OldHumanoid:Destroy()
        task.wait()
        NewHumanoid.Parent = Character
        task.wait()
        if not NewHumanoid.Parent then return end

        pcall(function() NewHumanoid.UseJumpPower = SavedJump.UseJumpPower end)
        pcall(function() NewHumanoid.JumpPower = SavedJump.JumpPower end)
        pcall(function() NewHumanoid.JumpHeight = SavedJump.JumpHeight end)
        for State, Enabled in pairs(SavedStates) do
            pcall(function() NewHumanoid:SetStateEnabled(State, Enabled) end)
        end

        local Animator = NewHumanoid:FindFirstChildOfClass("Animator")
        if not Animator then
            Animator = Instance.new("Animator")
            Animator.Parent = NewHumanoid
        end

        local Animate = Character:FindFirstChild("Animate")
        if Animate then
            pcall(function() Animate.Disabled = true end)
            task.wait()
            pcall(function() Animate.Disabled = false end)
        end
        task.wait(0.1)

        local function LockHealth()
            if GodMode and NewHumanoid and NewHumanoid.Parent then
                pcall(function()
                    NewHumanoid.MaxHealth = math.huge
                    NewHumanoid.Health = math.huge
                end)
            end
        end
        local function BlockDeathState()
            if not NewHumanoid or not NewHumanoid.Parent then return end
            pcall(function() NewHumanoid:SetStateEnabled(Enum.HumanoidStateType.Dead, false) end)
            pcall(function() NewHumanoid.BreakJointsOnDeath = false end)
            pcall(function() NewHumanoid.RequiresNeck = false end)
        end
        local function BindAntiDeath(Humanoid)
            if not Humanoid then return end
            Humanoid.HealthChanged:Connect(function(Health)
                if GodMode and Humanoid and Humanoid.Parent and Health < Humanoid.MaxHealth then
                    pcall(function() Humanoid.Health = Humanoid.MaxHealth end)
                end
            end)
            Humanoid.Died:Connect(function()
                if GodMode and Humanoid and Humanoid.Parent then
                    pcall(function() Humanoid.Health = Humanoid.MaxHealth end)
                end
            end)
        end
        LockHealth()
        BlockDeathState()
        BindAntiDeath(NewHumanoid)

        task.spawn(function()
            while BypassEnabled do
                task.wait(0.1)
                if GodMode and NewHumanoid and NewHumanoid.Parent then
                    pcall(function()
                        if NewHumanoid.Health < NewHumanoid.MaxHealth then
                            NewHumanoid.Health = NewHumanoid.MaxHealth
                        end
                        NewHumanoid:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
                    end)
                end
            end
        end)

        local function RefreshControls()
            local PlayerScripts = Player:FindFirstChild("PlayerScripts")
            if not PlayerScripts then return end
            local PlayerModule = PlayerScripts:FindFirstChild("PlayerModule")
            if not PlayerModule then return end
            local Success, Module = pcall(function() return require(PlayerModule) end)
            if not Success or not Module then return end
            local Controls
            pcall(function() Controls = Module:GetControls() end)
            if not Controls then return end
            pcall(function() Controls:OnCharacterAdded(Character) end)
            task.wait()
            pcall(function() Controls:UpdateActiveControlModuleEnabled() end)
        end
        RefreshControls()

        pcall(function()
            local Camera = workspace.CurrentCamera
            if Camera then Camera.CameraSubject = NewHumanoid end
        end)
    end

    local function SetupDiedListener(Humanoid)
        if not Humanoid then return end
        if DiedConnection then DiedConnection:Disconnect() DiedConnection = nil end
        DiedConnection = Humanoid.Died:Connect(function()
            task.wait(0.5)
            task.spawn(function() RunBypassAntiCheat() end)
        end)
    end

    local function SetupCharacterListener()
        if CharacterConnection then CharacterConnection:Disconnect() CharacterConnection = nil end
        CharacterConnection = Player.CharacterAdded:Connect(function(Character)
            task.wait(1)
            local Hum = Character:FindFirstChildOfClass("Humanoid")
            if Hum then SetupDiedListener(Hum) end
            RunBypassAntiCheat()
        end)
    end

    local function SetupHumanoidDiedCheck()
        task.spawn(function()
            while BypassEnabled do
                task.wait(1)
                local Char = Player.Character
                if Char then
                    local Hum = Char:FindFirstChildOfClass("Humanoid")
                    if Hum then
                        if not DiedConnection or not DiedConnection.Connected then
                            SetupDiedListener(Hum)
                        end
                    end
                end
            end
        end)
    end

    task.spawn(function()
        task.wait(2)
        RunBypassAntiCheat()
        SetupCharacterListener()
        SetupHumanoidDiedCheck()
        local Char = Player.Character
        if Char then
            local Hum = Char:FindFirstChildOfClass("Humanoid")
            if Hum then SetupDiedListener(Hum) end
        end
    end)
end

print("✅ PART 4/5 OK - Manager + Config + Bypass Ready")
-- ==================================================
-- SCRIPTER BRO HUB | PART 5/5
-- Tabs + فتح مباشر فور التحميل
-- ==================================================

local TabsManager = _G.YOKUDO_TabsManager
if not TabsManager then
    warn("[SCRIPTER BRO HUB] TabsManager not found! تأكد أنك شغلت الأجزاء 1-4 قبل ده")
    return
end

-- ==================================================
-- TAB: Info
-- ==================================================
do
    local InfoTab, InfoPage = TabsManager:RegisterTab("Info", 1, "INFO")
    CreateSectionTitle(InfoPage, "SCRIPTER BRO HUB", 1)

    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Size = UDim2.new(1, 0, 0, 26)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Text = "Join Group For Notification Update Script"
    TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TitleLabel.TextSize = 13
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.LayoutOrder = 2
    TitleLabel.Parent = InfoPage

    local InfoLabel = Instance.new("TextLabel")
    InfoLabel.Size = UDim2.new(1, 0, 0, 20)
    InfoLabel.BackgroundTransparency = 1
    InfoLabel.Text = "Discord: discord.gg/NaQArhFZy"
    InfoLabel.TextColor3 = Color3.fromRGB(168, 85, 247)
    InfoLabel.TextSize = 11
    InfoLabel.TextXAlignment = Enum.TextXAlignment.Left
    InfoLabel.Font = Enum.Font.Gotham
    InfoLabel.LayoutOrder = 3
    InfoLabel.Parent = InfoPage
end

-- ==================================================
-- TAB: Farming
-- ==================================================
do
    local TweenService = game:GetService("TweenService")
    local FarmingTab, FarmingPage = TabsManager:RegisterTab("Farming", 2, "FARMING")
    CreateSectionTitle(FarmingPage, "Farming", 1)

    local RarityHolder = Instance.new("Frame")
    RarityHolder.Size = UDim2.new(1, 0, 0, 52)
    RarityHolder.BackgroundTransparency = 1
    RarityHolder.LayoutOrder = 2
    RarityHolder.ZIndex = 100
    RarityHolder.Parent = FarmingPage

    local RarityLabel = Instance.new("TextLabel")
    RarityLabel.Size = UDim2.new(1, -120, 0, 20)
    RarityLabel.Position = UDim2.new(0, 0, 0, 2)
    RarityLabel.BackgroundTransparency = 1
    RarityLabel.Text = "Select Egg Type"
    RarityLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    RarityLabel.TextSize = 13
    RarityLabel.TextXAlignment = Enum.TextXAlignment.Left
    RarityLabel.Font = Enum.Font.GothamBold
    RarityLabel.ZIndex = 101
    RarityLabel.Parent = RarityHolder

    local RarityTitle = Instance.new("TextLabel")
    RarityTitle.Size = UDim2.new(1, -120, 0, 18)
    RarityTitle.Position = UDim2.new(0, 0, 0, 24)
    RarityTitle.BackgroundTransparency = 1
    RarityTitle.Text = "Select Rarity to Farm"
    RarityTitle.TextColor3 = Color3.fromRGB(180, 180, 180)
    RarityTitle.TextSize = 10
    RarityTitle.TextXAlignment = Enum.TextXAlignment.Left
    RarityTitle.Font = Enum.Font.Gotham
    RarityTitle.ZIndex = 101
    RarityTitle.Parent = RarityHolder

    local SelectedRarities = { Secret = true, Eternal = true, Divine = true }

    local function GetSelectedText()
        local List = {}
        if SelectedRarities.Secret then table.insert(List, "Secret") end
        if SelectedRarities.Eternal then table.insert(List, "Eternal") end
        if SelectedRarities.Divine then table.insert(List, "Divine") end
        if #List == 0 then return "None" end
        if #List == 3 then return "All" end
        return table.concat(List, ", ")
    end

    local DropdownBtn = Instance.new("TextButton")
    DropdownBtn.Size = UDim2.new(0, 120, 0, 28)
    DropdownBtn.Position = UDim2.new(1, -120, 0.5, -14)
    DropdownBtn.BackgroundColor3 = Color3.fromRGB(30, 31, 45)
    DropdownBtn.BorderSizePixel = 0
    DropdownBtn.Text = GetSelectedText() .. " ▼"
    DropdownBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    DropdownBtn.TextSize = 11
    DropdownBtn.Font = Enum.Font.GothamBold
    DropdownBtn.AutoButtonColor = false
    DropdownBtn.ZIndex = 101
    DropdownBtn.Parent = RarityHolder

    local DdCorner = Instance.new("UICorner")
    DdCorner.CornerRadius = UDim.new(0, 6)
    DdCorner.Parent = DropdownBtn

    local DdStroke = Instance.new("UIStroke")
    DdStroke.Color = Color3.fromRGB(168, 85, 247)
    DdStroke.Thickness = 1
    DdStroke.Transparency = 0.3
    DdStroke.Parent = DropdownBtn

    local DropdownList = Instance.new("Frame")
    DropdownList.Size = UDim2.new(0, 120, 0, 80)
    DropdownList.Position = UDim2.new(1, -120, 1, 2)
    DropdownList.BackgroundColor3 = Color3.fromRGB(25, 26, 38)
    DropdownList.BorderSizePixel = 0
    DropdownList.Visible = false
    DropdownList.ZIndex = 200
    DropdownList.Parent = RarityHolder

    local DlCorner = Instance.new("UICorner")
    DlCorner.CornerRadius = UDim.new(0, 6)
    DlCorner.Parent = DropdownList

    local DlStroke = Instance.new("UIStroke")
    DlStroke.Color = Color3.fromRGB(168, 85, 247)
    DlStroke.Thickness = 1
    DlStroke.Transparency = 0.3
    DlStroke.Parent = DropdownList

    local DlLayout = Instance.new("UIListLayout")
    DlLayout.Padding = UDim.new(0, 2)
    DlLayout.SortOrder = Enum.SortOrder.LayoutOrder
    DlLayout.Parent = DropdownList

    local DlPadding = Instance.new("UIPadding")
    DlPadding.PaddingTop = UDim.new(0, 4)
    DlPadding.PaddingBottom = UDim.new(0, 4)
    DlPadding.PaddingLeft = UDim.new(0, 4)
    DlPadding.PaddingRight = UDim.new(0, 4)
    DlPadding.Parent = DropdownList

    local OptionButtons = {}

    local function UpdateOptionVisual(Name)
        local Option = OptionButtons[Name]
        if not Option then return end
        if SelectedRarities[Name] then
            Option.BackgroundColor3 = Color3.fromRGB(168, 85, 247)
            Option.Text = "✓ " .. Name
        else
            Option.BackgroundColor3 = Color3.fromRGB(30, 31, 45)
            Option.Text = Name
        end
    end

    local function CreateDropdownOption(Name, Order)
        local Option = Instance.new("TextButton")
        Option.Size = UDim2.new(1, 0, 0, 22)
        Option.BackgroundColor3 = Color3.fromRGB(30, 31, 45)
        Option.BorderSizePixel = 0
        Option.Text = Name
        Option.TextColor3 = Color3.fromRGB(255, 255, 255)
        Option.TextSize = 11
        Option.Font = Enum.Font.GothamMedium
        Option.AutoButtonColor = false
        Option.LayoutOrder = Order
        Option.ZIndex = 201
        Option.Parent = DropdownList

        local OptCorner = Instance.new("UICorner")
        OptCorner.CornerRadius = UDim.new(0, 4)
        OptCorner.Parent = Option

        OptionButtons[Name] = Option

        Option.MouseButton1Click:Connect(function()
            SelectedRarities[Name] = not SelectedRarities[Name]
            UpdateOptionVisual(Name)
            DropdownBtn.Text = GetSelectedText() .. " ▼"

            local List = {}
            if SelectedRarities.Secret then table.insert(List, "Secret") end
            if SelectedRarities.Eternal then table.insert(List, "Eternal") end
            if SelectedRarities.Divine then table.insert(List, "Divine") end

            if _G.YOKUDO_FarmingManager then _G.YOKUDO_FarmingManager.SetRarities(List) end
        end)

        UpdateOptionVisual(Name)
    end

    CreateDropdownOption("Secret", 1)
    CreateDropdownOption("Eternal", 2)
    CreateDropdownOption("Divine", 3)

    DropdownBtn.MouseButton1Click:Connect(function()
        DropdownList.Visible = not DropdownList.Visible
    end)

    -- Auto Farm Toggle
    local FarmHolder = Instance.new("Frame")
    FarmHolder.Size = UDim2.new(1, 0, 0, 52)
    FarmHolder.BackgroundTransparency = 1
    FarmHolder.LayoutOrder = 3
    FarmHolder.Parent = FarmingPage

    local FarmLabel = Instance.new("TextLabel")
    FarmLabel.Size = UDim2.new(1, -50, 0, 20)
    FarmLabel.Position = UDim2.new(0, 0, 0, 2)
    FarmLabel.BackgroundTransparency = 1
    FarmLabel.Text = "Auto AFK Farming Egg"
    FarmLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    FarmLabel.TextSize = 13
    FarmLabel.TextXAlignment = Enum.TextXAlignment.Left
    FarmLabel.Font = Enum.Font.GothamBold
    FarmLabel.Parent = FarmHolder

    local FarmSub = Instance.new("TextLabel")
    FarmSub.Size = UDim2.new(1, -50, 0, 18)
    FarmSub.Position = UDim2.new(0, 0, 0, 24)
    FarmSub.BackgroundTransparency = 1
    FarmSub.Text = "Auto farm selected rarity"
    FarmSub.TextColor3 = Color3.fromRGB(150, 150, 170)
    FarmSub.TextSize = 10
    FarmSub.TextXAlignment = Enum.TextXAlignment.Left
    FarmSub.Font = Enum.Font.Gotham
    FarmSub.Parent = FarmHolder

    local FarmButton = Instance.new("TextButton")
    FarmButton.Size = UDim2.new(0, 26, 0, 26)
    FarmButton.Position = UDim2.new(1, -26, 0.5, -13)
    FarmButton.BackgroundColor3 = Color3.fromRGB(28, 29, 39)
    FarmButton.BorderSizePixel = 0
    FarmButton.Text = ""
    FarmButton.AutoButtonColor = false
    FarmButton.Parent = FarmHolder

    local FarmCorner = Instance.new("UICorner")
    FarmCorner.CornerRadius = UDim.new(0, 6)
    FarmCorner.Parent = FarmButton

    local FarmStroke = Instance.new("UIStroke")
    FarmStroke.Color = Color3.fromRGB(168, 85, 247)
    FarmStroke.Thickness = 1.5
    FarmStroke.Parent = FarmButton

    local FarmCheck = Instance.new("TextLabel")
    FarmCheck.Size = UDim2.new(1, 0, 1, 0)
    FarmCheck.BackgroundTransparency = 1
    FarmCheck.Text = "✓"
    FarmCheck.TextColor3 = Color3.fromRGB(255, 255, 255)
    FarmCheck.TextSize = 18
    FarmCheck.Font = Enum.Font.GothamBold
    FarmCheck.Visible = false
    FarmCheck.Parent = FarmButton

    local FarmEnabled = false

    FarmButton.MouseButton1Click:Connect(function()
        if not _G.YOKUDO_FarmingManager then return end
        FarmEnabled = not FarmEnabled
        FarmCheck.Visible = FarmEnabled
        if FarmEnabled then
            FarmButton.BackgroundColor3 = Color3.fromRGB(168, 85, 247)
            FarmStroke.Color = Color3.fromRGB(192, 132, 252)
            local List = {}
            if SelectedRarities.Secret then table.insert(List, "Secret") end
            if SelectedRarities.Eternal then table.insert(List, "Eternal") end
            if SelectedRarities.Divine then table.insert(List, "Divine") end
            _G.YOKUDO_FarmingManager.SetRarities(List)
            _G.YOKUDO_FarmingManager.Enable()
        else
            FarmButton.BackgroundColor3 = Color3.fromRGB(28, 29, 39)
            FarmStroke.Color = Color3.fromRGB(168, 85, 247)
            _G.YOKUDO_FarmingManager.Disable()
        end
    end)

    task.spawn(function()
        while task.wait(1) do
            if _G.YOKUDO_FarmingManager then
                local S = _G.YOKUDO_FarmingManager.IsEnabled()
                if S ~= FarmEnabled then
                    FarmEnabled = S
                    FarmCheck.Visible = S
                    if S then
                        FarmButton.BackgroundColor3 = Color3.fromRGB(168, 85, 247)
                        FarmStroke.Color = Color3.fromRGB(192, 132, 252)
                    else
                        FarmButton.BackgroundColor3 = Color3.fromRGB(28, 29, 39)
                        FarmStroke.Color = Color3.fromRGB(168, 85, 247)
                    end
                end
            end
        end
    end)
end

-- ==================================================
-- TAB: Combat
-- ==================================================
do
    local CombatTab, CombatPage = TabsManager:RegisterTab("Combat", 3, "COMBAT")
    CreateSectionTitle(CombatPage, "Combat", 1)

    -- Auto Equip Bat
    local AEH = Instance.new("Frame")
    AEH.Size = UDim2.new(1, 0, 0, 32)
    AEH.BackgroundTransparency = 1
    AEH.LayoutOrder = 2
    AEH.Parent = CombatPage

    local AEL = Instance.new("TextLabel")
    AEL.Size = UDim2.new(1, -50, 1, 0)
    AEL.BackgroundTransparency = 1
    AEL.Text = "Auto Equip Bat"
    AEL.TextColor3 = Color3.fromRGB(220, 220, 235)
    AEL.TextSize = 13
    AEL.TextXAlignment = Enum.TextXAlignment.Left
    AEL.TextYAlignment = Enum.TextYAlignment.Center
    AEL.Font = Enum.Font.GothamBold
    AEL.Parent = AEH

    local AEB = Instance.new("TextButton")
    AEB.Size = UDim2.new(0, 26, 0, 26)
    AEB.Position = UDim2.new(1, -26, 0.5, -13)
    AEB.BackgroundColor3 = Color3.fromRGB(28, 29, 39)
    AEB.BorderSizePixel = 0
    AEB.Text = ""
    AEB.AutoButtonColor = false
    AEB.Parent = AEH

    local AEC = Instance.new("UICorner")
    AEC.CornerRadius = UDim.new(0, 6)
    AEC.Parent = AEB

    local AES = Instance.new("UIStroke")
    AES.Color = Color3.fromRGB(168, 85, 247)
    AES.Thickness = 1.5
    AES.Parent = AEB

    local AECheck = Instance.new("TextLabel")
    AECheck.Size = UDim2.new(1, 0, 1, 0)
    AECheck.BackgroundTransparency = 1
    AECheck.Text = "✓"
    AECheck.TextColor3 = Color3.fromRGB(255, 255, 255)
    AECheck.TextSize = 18
    AECheck.Font = Enum.Font.GothamBold
    AECheck.Visible = false
    AECheck.Parent = AEB

    AEB.MouseButton1Click:Connect(function()
        AECheck.Visible = not AECheck.Visible
        if AECheck.Visible then
            AEB.BackgroundColor3 = Color3.fromRGB(168, 85, 247)
            AES.Color = Color3.fromRGB(192, 132, 252)
            if _G.YOKUDO_AutoAttack then _G.YOKUDO_AutoAttack.EnableAutoEquip() end
        else
            AEB.BackgroundColor3 = Color3.fromRGB(28, 29, 39)
            AES.Color = Color3.fromRGB(168, 85, 247)
            if _G.YOKUDO_AutoAttack then _G.YOKUDO_AutoAttack.DisableAutoEquip() end
        end
    end)

    -- Auto Hit Player
    local AHH = Instance.new("Frame")
    AHH.Size = UDim2.new(1, 0, 0, 52)
    AHH.BackgroundTransparency = 1
    AHH.LayoutOrder = 3
    AHH.Parent = CombatPage

    local AHL = Instance.new("TextLabel")
    AHL.Size = UDim2.new(1, -50, 0, 20)
    AHL.Position = UDim2.new(0, 0, 0, 2)
    AHL.BackgroundTransparency = 1
    AHL.Text = "Auto Hit Player"
    AHL.TextColor3 = Color3.fromRGB(220, 220, 235)
    AHL.TextSize = 13
    AHL.TextXAlignment = Enum.TextXAlignment.Left
    AHL.Font = Enum.Font.GothamBold
    AHL.Parent = AHH

    local AHSub = Instance.new("TextLabel")
    AHSub.Size = UDim2.new(1, -50, 0, 18)
    AHSub.Position = UDim2.new(0, 0, 0, 24)
    AHSub.BackgroundTransparency = 1
    AHSub.Text = "Range: 60 studs"
    AHSub.TextColor3 = Color3.fromRGB(150, 150, 170)
    AHSub.TextSize = 10
    AHSub.TextXAlignment = Enum.TextXAlignment.Left
    AHSub.Font = Enum.Font.Gotham
    AHSub.Parent = AHH

    local AHB = Instance.new("TextButton")
    AHB.Size = UDim2.new(0, 26, 0, 26)
    AHB.Position = UDim2.new(1, -26, 0.5, -13)
    AHB.BackgroundColor3 = Color3.fromRGB(28, 29, 39)
    AHB.BorderSizePixel = 0
    AHB.Text = ""
    AHB.AutoButtonColor = false
    AHB.Parent = AHH

    local AHC = Instance.new("UICorner")
    AHC.CornerRadius = UDim.new(0, 6)
    AHC.Parent = AHB

    local AHS = Instance.new("UIStroke")
    AHS.Color = Color3.fromRGB(168, 85, 247)
    AHS.Thickness = 1.5
    AHS.Parent = AHB

    local AHCheck = Instance.new("TextLabel")
    AHCheck.Size = UDim2.new(1, 0, 1, 0)
    AHCheck.BackgroundTransparency = 1
    AHCheck.Text = "✓"
    AHCheck.TextColor3 = Color3.fromRGB(255, 255, 255)
    AHCheck.TextSize = 18
    AHCheck.Font = Enum.Font.GothamBold
    AHCheck.Visible = false
    AHCheck.Parent = AHB

    AHB.MouseButton1Click:Connect(function()
        AHCheck.Visible = not AHCheck.Visible
        if AHCheck.Visible then
            AHB.BackgroundColor3 = Color3.fromRGB(168, 85, 247)
            AHS.Color = Color3.fromRGB(192, 132, 252)
            if _G.YOKUDO_AutoAttack then _G.YOKUDO_AutoAttack.EnableAutoHit() end
        else
            AHB.BackgroundColor3 = Color3.fromRGB(28, 29, 39)
            AHS.Color = Color3.fromRGB(168, 85, 247)
            if _G.YOKUDO_AutoAttack then _G.YOKUDO_AutoAttack.DisableAutoHit() end
        end
    end)
end

-- ==================================================
-- TAB: Auto Farming
-- ==================================================
do
    local AutoFarmingTab, AutoFarmingPage = TabsManager:RegisterTab("Auto Farming", 4, "AUTO_FARMING")
    CreateSectionTitle(AutoFarmingPage, "Auto Farming", 1)

    local EggScrollFrame = Instance.new("ScrollingFrame")
    EggScrollFrame.Size = UDim2.new(1, 0, 0, 280)
    EggScrollFrame.BackgroundTransparency = 1
    EggScrollFrame.BorderSizePixel = 0
    EggScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    EggScrollFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
    EggScrollFrame.ScrollBarThickness = 4
    EggScrollFrame.ScrollBarImageColor3 = Color3.fromRGB(168, 85, 247)
    EggScrollFrame.LayoutOrder = 2
    EggScrollFrame.Parent = AutoFarmingPage

    local EggListLayout = Instance.new("UIListLayout")
    EggListLayout.Padding = UDim.new(0, 4)
    EggListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    EggListLayout.Parent = EggScrollFrame

    local function RefreshEggList()
        if not _G.YOKUDO_AutoFarm then return end
        for _, c in ipairs(EggScrollFrame:GetChildren()) do
            if c:IsA("Frame") then c:Destroy() end
        end

        local Eggs = _G.YOKUDO_AutoFarm.ScanEggs()
        for i, EggData in ipairs(Eggs) do
            local Entry = Instance.new("Frame")
            Entry.Size = UDim2.new(1, -8, 0, 44)
            Entry.BackgroundColor3 = Color3.fromRGB(30, 31, 45)
            Entry.BorderSizePixel = 0
            Entry.LayoutOrder = i
            Entry.Parent = EggScrollFrame

            local EC = Instance.new("UICorner")
            EC.CornerRadius = UDim.new(0, 6)
            EC.Parent = Entry

            local NameLabel = Instance.new("TextLabel")
            NameLabel.Size = UDim2.new(1, -100, 0, 20)
            NameLabel.Position = UDim2.new(0, 10, 0, 4)
            NameLabel.BackgroundTransparency = 1
            NameLabel.Text = EggData.DisplayName
            NameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            NameLabel.TextSize = 12
            NameLabel.TextXAlignment = Enum.TextXAlignment.Left
            NameLabel.Font = Enum.Font.GothamBold
            NameLabel.Parent = Entry

            local RateLabel = Instance.new("TextLabel")
            RateLabel.Size = UDim2.new(1, -100, 0, 16)
            RateLabel.Position = UDim2.new(0, 10, 0, 24)
            RateLabel.BackgroundTransparency = 1
            RateLabel.Text = "$" .. _G.YOKUDO_AutoFarm.FormatMoney(EggData.EarningRate) .. "/s"
            RateLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
            RateLabel.TextSize = 10
            RateLabel.TextXAlignment = Enum.TextXAlignment.Left
            RateLabel.Font = Enum.Font.Gotham
            RateLabel.Parent = Entry

            local Btn = Instance.new("TextButton")
            Btn.Size = UDim2.new(0, 70, 0, 30)
            Btn.Position = UDim2.new(1, -78, 0.5, -15)
            Btn.BackgroundColor3 = Color3.fromRGB(168, 85, 247)
            Btn.BorderSizePixel = 0
            Btn.Text = "TP"
            Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
            Btn.TextSize = 12
            Btn.Font = Enum.Font.GothamBold
            Btn.AutoButtonColor = false
            Btn.Parent = Entry

            local BC = Instance.new("UICorner")
            BC.CornerRadius = UDim.new(0, 6)
            BC.Parent = Btn

            Btn.MouseButton1Click:Connect(function()
                _G.YOKUDO_AutoFarm.SelectEgg(EggData)
                _G.YOKUDO_AutoFarm.StartTeleport()
            end)
        end
    end

    task.spawn(function()
        task.wait(2)
        pcall(RefreshEggList)
    end)

    task.spawn(function()
        while task.wait(5) do
            pcall(RefreshEggList)
        end
    end)
end

-- ==================================================
-- TAB: Event
-- ==================================================
do
    local EventTab, EventPage = TabsManager:RegisterTab("Event", 5, "EVENT")
    CreateSectionTitle(EventPage, "Event", 1)

    local MH = Instance.new("Frame")
    MH.Size = UDim2.new(1, 0, 0, 52)
    MH.BackgroundTransparency = 1
    MH.LayoutOrder = 2
    MH.Parent = EventPage

    local ML = Instance.new("TextLabel")
    ML.Size = UDim2.new(1, -50, 0, 20)
    ML.Position = UDim2.new(0, 0, 0, 2)
    ML.BackgroundTransparency = 1
    ML.Text = "Auto Attack Drone"
    ML.TextColor3 = Color3.fromRGB(220, 220, 235)
    ML.TextSize = 13
    ML.TextXAlignment = Enum.TextXAlignment.Left
    ML.Font = Enum.Font.GothamBold
    ML.Parent = MH

    local MSub = Instance.new("TextLabel")
    MSub.Size = UDim2.new(1, -50, 0, 18)
    MSub.Position = UDim2.new(0, 0, 0, 24)
    MSub.BackgroundTransparency = 1
    MSub.Text = "AFK Farm Drone"
    MSub.TextColor3 = Color3.fromRGB(150, 150, 170)
    MSub.TextSize = 10
    MSub.TextXAlignment = Enum.TextXAlignment.Left
    MSub.Font = Enum.Font.Gotham
    MSub.Parent = MH

    local MB = Instance.new("TextButton")
    MB.Size = UDim2.new(0, 26, 0, 26)
    MB.Position = UDim2.new(1, -26, 0.5, -13)
    MB.BackgroundColor3 = Color3.fromRGB(28, 29, 39)
    MB.BorderSizePixel = 0
    MB.Text = ""
    MB.AutoButtonColor = false
    MB.Parent = MH

    local MC = Instance.new("UICorner")
    MC.CornerRadius = UDim.new(0, 6)
    MC.Parent = MB

    local MS = Instance.new("UIStroke")
    MS.Color = Color3.fromRGB(168, 85, 247)
    MS.Thickness = 1.5
    MS.Parent = MB

    local MCheck = Instance.new("TextLabel")
    MCheck.Size = UDim2.new(1, 0, 1, 0)
    MCheck.BackgroundTransparency = 1
    MCheck.Text = "✓"
    MCheck.TextColor3 = Color3.fromRGB(255, 255, 255)
    MCheck.TextSize = 18
    MCheck.Font = Enum.Font.GothamBold
    MCheck.Visible = false
    MCheck.Parent = MB

    MB.MouseButton1Click:Connect(function()
        if not _G.YOKUDO_ManagerDrone then return end
        local NS = not _G.YOKUDO_ManagerDrone.IsEnabled()
        MCheck.Visible = NS
        if NS then
            MB.BackgroundColor3 = Color3.fromRGB(168, 85, 247)
            MS.Color = Color3.fromRGB(192, 132, 252)
            _G.YOKUDO_ManagerDrone.Enable()
        else
            MB.BackgroundColor3 = Color3.fromRGB(28, 29, 39)
            MS.Color = Color3.fromRGB(168, 85, 247)
            _G.YOKUDO_ManagerDrone.Disable()
        end
    end)

    task.spawn(function()
        while task.wait(1) do
            if _G.YOKUDO_ManagerDrone then
                local S = _G.YOKUDO_ManagerDrone.IsEnabled()
                if S ~= MCheck.Visible then
                    MCheck.Visible = S
                    if S then
                        MB.BackgroundColor3 = Color3.fromRGB(168, 85, 247)
                        MS.Color = Color3.fromRGB(192, 132, 252)
                    else
                        MB.BackgroundColor3 = Color3.fromRGB(28, 29, 39)
                        MS.Color = Color3.fromRGB(168, 85, 247)
                    end
                end
            end
        end
    end)
end

-- ==================================================
-- TAB: Hop Server
-- ==================================================
do
    local HttpService = game:GetService("HttpService")
    local TeleportService = game:GetService("TeleportService")
    local PLACE_ID = 107778070777162

    local HopServerTab, HopServerPage = TabsManager:RegisterTab("Hop Server", 6, "HOP_SERVER")
    CreateSectionTitle(HopServerPage, "Hop Server", 1)

    local Status = Instance.new("TextLabel")
    Status.Size = UDim2.new(1, 0, 0, 20)
    Status.BackgroundTransparency = 1
    Status.Text = "Click to search servers"
    Status.TextColor3 = Color3.fromRGB(150, 150, 170)
    Status.TextSize = 11
    Status.TextXAlignment = Enum.TextXAlignment.Left
    Status.LayoutOrder = 2
    Status.Parent = HopServerPage

    local ClickBtn = Instance.new("TextButton")
    ClickBtn.Size = UDim2.new(1, 0, 0, 32)
    ClickBtn.BackgroundColor3 = Color3.fromRGB(168, 85, 247)
    ClickBtn.BorderSizePixel = 0
    ClickBtn.Text = "Search Servers"
    ClickBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    ClickBtn.TextSize = 13
    ClickBtn.Font = Enum.Font.GothamBold
    ClickBtn.AutoButtonColor = false
    ClickBtn.LayoutOrder = 3
    ClickBtn.Parent = HopServerPage

    local CC = Instance.new("UICorner")
    CC.CornerRadius = UDim.new(0, 6)
    CC.Parent = ClickBtn

    local ServerScroll = Instance.new("ScrollingFrame")
    ServerScroll.Size = UDim2.new(1, 0, 0, 200)
    ServerScroll.BackgroundTransparency = 1
    ServerScroll.BorderSizePixel = 0
    ServerScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
    ServerScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
    ServerScroll.ScrollBarThickness = 4
    ServerScroll.ScrollBarImageColor3 = Color3.fromRGB(168, 85, 247)
    ServerScroll.LayoutOrder = 4
    ServerScroll.Parent = HopServerPage

    local SL = Instance.new("UIListLayout")
    SL.Padding = UDim.new(0, 4)
    SL.SortOrder = Enum.SortOrder.LayoutOrder
    SL.Parent = ServerScroll

    local function FetchServers()
        local allServers = {}
        local seen = {}
        local cursor = ""
        local pageCount = 0
        repeat
            pageCount = pageCount + 1
            local url = string.format(
                "https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=Asc&limit=100&cursor=%s",
                PLACE_ID, cursor
            )
            local success, response = pcall(function()
                return HttpService:JSONDecode(game:HttpGet(url))
            end)
            if not success or not response or not response.data then break end
            for _, server in ipairs(response.data) do
                if server.playing == 1 and server.id ~= game.JobId
                   and server.maxPlayers > 1 and server.playing < server.maxPlayers then
                    if not seen[server.id] then
                        seen[server.id] = true
                        table.insert(allServers, server)
                    end
                end
            end
            cursor = response.next_cursor or ""
            task.wait(0.15)
        until cursor == "" or pageCount >= 5
        return allServers
    end

    ClickBtn.MouseButton1Click:Connect(function()
        Status.Text = "Searching..."
        Status.TextColor3 = Color3.fromRGB(150, 150, 170)
        for _, c in ipairs(ServerScroll:GetChildren()) do
            if c:IsA("Frame") then c:Destroy() end
        end

        local servers = FetchServers()
        if #servers == 0 then
            Status.Text = "No servers found"
            Status.TextColor3 = Color3.fromRGB(255, 0, 0)
            return
        end

        for i, server in ipairs(servers) do
            local E = Instance.new("Frame")
            E.Size = UDim2.new(1, -8, 0, 40)
            E.BackgroundColor3 = Color3.fromRGB(28, 29, 42)
            E.BorderSizePixel = 0
            E.LayoutOrder = i
            E.Parent = ServerScroll

            local EC = Instance.new("UICorner")
            EC.CornerRadius = UDim.new(0, 6)
            EC.Parent = E

            local JL = Instance.new("TextLabel")
            JL.Size = UDim2.new(1, -80, 1, 0)
            JL.Position = UDim2.new(0, 8, 0, 0)
            JL.BackgroundTransparency = 1
            JL.Text = "Job: " .. server.id
            JL.TextColor3 = Color3.fromRGB(168, 85, 247)
            JL.TextSize = 10
            JL.TextXAlignment = Enum.TextXAlignment.Left
            JL.TextYAlignment = Enum.TextYAlignment.Center
            JL.TextTruncate = Enum.TextTruncate.AtEnd
            JL.Font = Enum.Font.Gotham
            JL.Parent = E

            local JB = Instance.new("TextButton")
            JB.Size = UDim2.new(0, 60, 0, 28)
            JB.Position = UDim2.new(1, -68, 0.5, -14)
            JB.BackgroundColor3 = Color3.fromRGB(168, 85, 247)
            JB.BorderSizePixel = 0
            JB.Text = "Join"
            JB.TextColor3 = Color3.fromRGB(255, 255, 255)
            JB.TextSize = 11
            JB.Font = Enum.Font.GothamBold
            JB.AutoButtonColor = false
            JB.Parent = E

            local JC = Instance.new("UICorner")
            JC.CornerRadius = UDim.new(0, 6)
            JC.Parent = JB

            JB.MouseButton1Click:Connect(function()
                pcall(function()
                    TeleportService:TeleportToPlaceInstance(PLACE_ID, server.id, game.Players.LocalPlayer)
                end)
            end)
        end
        Status.Text = "Found " .. #servers .. " server(s)"
        Status.TextColor3 = Color3.fromRGB(0, 255, 105)
    end)
end

-- ==================================================
-- TAB: Setting
-- ==================================================
do
    local SettingTab, SettingPage = TabsManager:RegisterTab("Setting", 7, "SETTING")
    CreateSectionTitle(SettingPage, "Settings", 1)

    -- Method Dropdown
    local MethodHolder = Instance.new("Frame")
    MethodHolder.Size = UDim2.new(1, 0, 0, 52)
    MethodHolder.BackgroundTransparency = 1
    MethodHolder.LayoutOrder = 2
    MethodHolder.ZIndex = 100
    MethodHolder.Parent = SettingPage

    local MethodLabel = Instance.new("TextLabel")
    MethodLabel.Size = UDim2.new(1, -120, 0, 20)
    MethodLabel.Position = UDim2.new(0, 0, 0, 2)
    MethodLabel.BackgroundTransparency = 1
    MethodLabel.Text = "Select Method Teleport"
    MethodLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    MethodLabel.TextSize = 13
    MethodLabel.TextXAlignment = Enum.TextXAlignment.Left
    MethodLabel.Font = Enum.Font.GothamBold
    MethodLabel.ZIndex = 101
    MethodLabel.Parent = MethodHolder

    local SelectedMethod = _G.YOKUDO_SelectedMethod or "TeleportFly"

    local MDB = Instance.new("TextButton")
    MDB.Size = UDim2.new(0, 110, 0, 28)
    MDB.Position = UDim2.new(1, -110, 0.5, -14)
    MDB.BackgroundColor3 = Color3.fromRGB(30, 31, 45)
    MDB.BorderSizePixel = 0
    MDB.Text = SelectedMethod .. " ▼"
    MDB.TextColor3 = Color3.fromRGB(255, 255, 255)
    MDB.TextSize = 11
    MDB.Font = Enum.Font.GothamBold
    MDB.AutoButtonColor = false
    MDB.ZIndex = 101
    MDB.Parent = MethodHolder

    local MDC = Instance.new("UICorner")
    MDC.CornerRadius = UDim.new(0, 6)
    MDC.Parent = MDB

    local MDS = Instance.new("UIStroke")
    MDS.Color = Color3.fromRGB(168, 85, 247)
    MDS.Thickness = 1
    MDS.Transparency = 0.3
    MDS.Parent = MDB

    local MDL = Instance.new("Frame")
    MDL.Size = UDim2.new(0, 110, 0, 60)
    MDL.Position = UDim2.new(1, -110, 1, 2)
    MDL.BackgroundColor3 = Color3.fromRGB(25, 26, 38)
    MDL.BorderSizePixel = 0
    MDL.Visible = false
    MDL.ZIndex = 200
    MDL.Parent = MethodHolder

    local MDLC = Instance.new("UICorner")
    MDLC.CornerRadius = UDim.new(0, 6)
    MDLC.Parent = MDL

    local MDLS = Instance.new("UIStroke")
    MDLS.Color = Color3.fromRGB(168, 85, 247)
    MDLS.Thickness = 1
    MDLS.Transparency = 0.3
    MDLS.Parent = MDL

    local MDLL = Instance.new("UIListLayout")
    MDLL.Padding = UDim.new(0, 2)
    MDLL.SortOrder = Enum.SortOrder.LayoutOrder
    MDLL.Parent = MDL

    local MDLP = Instance.new("UIPadding")
    MDLP.PaddingTop = UDim.new(0, 4)
    MDLP.PaddingBottom = UDim.new(0, 4)
    MDLP.PaddingLeft = UDim.new(0, 4)
    MDLP.PaddingRight = UDim.new(0, 4)
    MDLP.Parent = MDL

    local function CreateMethodOption(Name, Order)
        local O = Instance.new("TextButton")
        O.Size = UDim2.new(1, 0, 0, 22)
        O.BackgroundColor3 = Color3.fromRGB(30, 31, 45)
        O.BorderSizePixel = 0
        O.Text = Name
        O.TextColor3 = Color3.fromRGB(255, 255, 255)
        O.TextSize = 11
        O.Font = Enum.Font.GothamMedium
        O.AutoButtonColor = false
        O.LayoutOrder = Order
        O.ZIndex = 201
        O.Parent = MDL

        local OC = Instance.new("UICorner")
        OC.CornerRadius = UDim.new(0, 4)
        OC.Parent = O

        O.MouseButton1Click:Connect(function()
            SelectedMethod = Name
            MDB.Text = Name .. " ▼"
            MDL.Visible = false
            _G.YOKUDO_SelectedMethod = Name
            if _G.YOKUDO_ConfigSystem then _G.YOKUDO_ConfigSystem.Save() end
        end)
    end

    CreateMethodOption("TeleportFly", 1)
    CreateMethodOption("InstantTeleport", 2)

    MDB.MouseButton1Click:Connect(function()
        MDL.Visible = not MDL.Visible
    end)

    -- Speed
    local SpeedHolder = Instance.new("Frame")
    SpeedHolder.Size = UDim2.new(1, 0, 0, 52)
    SpeedHolder.BackgroundTransparency = 1
    SpeedHolder.LayoutOrder = 3
    SpeedHolder.Parent = SettingPage

    local SpeedLabel = Instance.new("TextLabel")
    SpeedLabel.Size = UDim2.new(1, -120, 0, 20)
    SpeedLabel.Position = UDim2.new(0, 0, 0, 2)
    SpeedLabel.BackgroundTransparency = 1
    SpeedLabel.Text = "Teleport Speed"
    SpeedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    SpeedLabel.TextSize = 13
    SpeedLabel.TextXAlignment = Enum.TextXAlignment.Left
    SpeedLabel.Font = Enum.Font.GothamBold
    SpeedLabel.Parent = SpeedHolder

    local SpeedSub = Instance.new("TextLabel")
    SpeedSub.Size = UDim2.new(1, -120, 0, 18)
    SpeedSub.Position = UDim2.new(0, 0, 0, 24)
    SpeedSub.BackgroundTransparency = 1
    SpeedSub.Text = "Range: 50 - 1100"
    SpeedSub.TextColor3 = Color3.fromRGB(180, 180, 180)
    SpeedSub.TextSize = 10
    SpeedSub.TextXAlignment = Enum.TextXAlignment.Left
    SpeedSub.Font = Enum.Font.Gotham
    SpeedSub.Parent = SpeedHolder

    local SpeedBox = Instance.new("TextBox")
    SpeedBox.Size = UDim2.new(0, 80, 0, 28)
    SpeedBox.Position = UDim2.new(1, -80, 0.5, -14)
    SpeedBox.BackgroundColor3 = Color3.fromRGB(30, 31, 45)
    SpeedBox.BorderSizePixel = 0
    SpeedBox.Text = tostring(_G.YOKUDO_TeleportSpeed or 300)
    SpeedBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    SpeedBox.TextSize = 12
    SpeedBox.TextXAlignment = Enum.TextXAlignment.Center
    SpeedBox.Font = Enum.Font.GothamBold
    SpeedBox.Parent = SpeedHolder

    local SBC = Instance.new("UICorner")
    SBC.CornerRadius = UDim.new(0, 6)
    SBC.Parent = SpeedBox

    local SBS = Instance.new("UIStroke")
    SBS.Color = Color3.fromRGB(168, 85, 247)
    SBS.Thickness = 1
    SBS.Transparency = 0.3
    SBS.Parent = SpeedBox

    SpeedBox.FocusLost:Connect(function()
        local V = tonumber(SpeedBox.Text)
        if V then
            V = math.clamp(V, 50, 1100)
            SpeedBox.Text = tostring(V)
            _G.YOKUDO_TeleportSpeed = V
            if _G.YOKUDO_TeleportSystem then _G.YOKUDO_TeleportSystem.SetSpeed(V) end
            if _G.YOKUDO_ConfigSystem then _G.YOKUDO_ConfigSystem.Save() end
        else
            SpeedBox.Text = "300"
            _G.YOKUDO_TeleportSpeed = 300
        end
    end)

    -- Walk Speed
    local WSH = Instance.new("Frame")
    WSH.Size = UDim2.new(1, 0, 0, 32)
    WSH.BackgroundTransparency = 1
    WSH.LayoutOrder = 4
    WSH.Parent = SettingPage

    local WSL = Instance.new("TextLabel")
    WSL.Size = UDim2.new(0, 100, 1, 0)
    WSL.BackgroundTransparency = 1
    WSL.Text = "Walk Speed"
    WSL.TextColor3 = Color3.fromRGB(255, 255, 255)
    WSL.TextSize = 12
    WSL.TextXAlignment = Enum.TextXAlignment.Left
    WSL.TextYAlignment = Enum.TextYAlignment.Center
    WSL.Font = Enum.Font.GothamMedium
    WSL.Parent = WSH

    local WSBox = Instance.new("TextBox")
    WSBox.Size = UDim2.new(0, 50, 1, -6)
    WSBox.Position = UDim2.new(0, 105, 0, 3)
    WSBox.BackgroundColor3 = Color3.fromRGB(30, 31, 45)
    WSBox.BorderSizePixel = 0
    WSBox.Text = "50"
    WSBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    WSBox.TextSize = 12
    WSBox.TextXAlignment = Enum.TextXAlignment.Center
    WSBox.Font = Enum.Font.GothamMedium
    WSBox.Parent = WSH

    local WSBC = Instance.new("UICorner")
    WSBC.CornerRadius = UDim.new(0, 4)
    WSBC.Parent = WSBox

    local WSBS = Instance.new("UIStroke")
    WSBS.Color = Color3.fromRGB(168, 85, 247)
    WSBS.Thickness = 0.5
    WSBS.Transparency = 0.2
    WSBS.Parent = WSBox

    local WSBtn = Instance.new("TextButton")
    WSBtn.Size = UDim2.new(0, 26, 0, 26)
    WSBtn.Position = UDim2.new(1, -26, 0.5, -13)
    WSBtn.BackgroundColor3 = Color3.fromRGB(28, 29, 39)
    WSBtn.BorderSizePixel = 0
    WSBtn.Text = ""
    WSBtn.AutoButtonColor = false
    WSBtn.Parent = WSH

    local WSBCorner = Instance.new("UICorner")
    WSBCorner.CornerRadius = UDim.new(0, 6)
    WSBCorner.Parent = WSBtn

    local WSBS2 = Instance.new("UIStroke")
    WSBS2.Color = Color3.fromRGB(168, 85, 247)
    WSBS2.Thickness = 1.5
    WSBS2.Parent = WSBtn

    local WSCheck = Instance.new("TextLabel")
    WSCheck.Size = UDim2.new(1, 0, 1, 0)
    WSCheck.BackgroundTransparency = 1
    WSCheck.Text = "✓"
    WSCheck.TextColor3 = Color3.fromRGB(255, 255, 255)
    WSCheck.TextSize = 18
    WSCheck.Font = Enum.Font.GothamBold
    WSCheck.Visible = false
    WSCheck.Parent = WSBtn

    local WSE = false
    local WSV = 50

    WSBtn.MouseButton1Click:Connect(function()
        WSE = not WSE
        WSCheck.Visible = WSE
        if WSE then
            WSBtn.BackgroundColor3 = Color3.fromRGB(168, 85, 247)
            WSBS2.Color = Color3.fromRGB(192, 132, 252)
            if _G.YOKUDO_WalkSpeed then
                _G.YOKUDO_WalkSpeed.SetValue(WSV)
                _G.YOKUDO_WalkSpeed.Enable()
            end
        else
            WSBtn.BackgroundColor3 = Color3.fromRGB(28, 29, 39)
            WSBS2.Color = Color3.fromRGB(168, 85, 247)
            if _G.YOKUDO_WalkSpeed then _G.YOKUDO_WalkSpeed.Disable() end
        end
    end)

    WSBox.FocusLost:Connect(function()
        local V = tonumber(WSBox.Text)
        if V then
            WSV = math.clamp(V, 50, 1000)
            WSBox.Text = tostring(WSV)
            if WSE and _G.YOKUDO_WalkSpeed then _G.YOKUDO_WalkSpeed.SetValue(WSV) end
        end
    end)

    -- Anti Trap
    local ATH = Instance.new("Frame")
    ATH.Size = UDim2.new(1, 0, 0, 32)
    ATH.BackgroundTransparency = 1
    ATH.LayoutOrder = 5
    ATH.Parent = SettingPage

    local ATL = Instance.new("TextLabel")
    ATL.Size = UDim2.new(1, -50, 1, 0)
    ATL.BackgroundTransparency = 1
    ATL.Text = "Anti Trap"
    ATL.TextColor3 = Color3.fromRGB(255, 255, 255)
    ATL.TextSize = 12
    ATL.TextXAlignment = Enum.TextXAlignment.Left
    ATL.TextYAlignment = Enum.TextYAlignment.Center
    ATL.Font = Enum.Font.GothamMedium
    ATL.Parent = ATH

    local ATBtn = Instance.new("TextButton")
    ATBtn.Size = UDim2.new(0, 26, 0, 26)
    ATBtn.Position = UDim2.new(1, -26, 0.5, -13)
    ATBtn.BackgroundColor3 = Color3.fromRGB(28, 29, 39)
    ATBtn.BorderSizePixel = 0
    ATBtn.Text = ""
    ATBtn.AutoButtonColor = false
    ATBtn.Parent = ATH

    local ATC = Instance.new("UICorner")
    ATC.CornerRadius = UDim.new(0, 6)
    ATC.Parent = ATBtn

    local ATS = Instance.new("UIStroke")
    ATS.Color = Color3.fromRGB(168, 85, 247)
    ATS.Thickness = 1.5
    ATS.Parent = ATBtn

    local ATCheck = Instance.new("TextLabel")
    ATCheck.Size = UDim2.new(1, 0, 1, 0)
    ATCheck.BackgroundTransparency = 1
    ATCheck.Text = "✓"
    ATCheck.TextColor3 = Color3.fromRGB(255, 255, 255)
    ATCheck.TextSize = 18
    ATCheck.Font = Enum.Font.GothamBold
    ATCheck.Visible = false
    ATCheck.Parent = ATBtn

    local ATE = false

    ATBtn.MouseButton1Click:Connect(function()
        ATE = not ATE
        ATCheck.Visible = ATE
        if ATE then
            ATBtn.BackgroundColor3 = Color3.fromRGB(168, 85, 247)
            ATS.Color = Color3.fromRGB(192, 132, 252)
            if _G.YOKUDO_AntiTrap then _G.YOKUDO_AntiTrap.Enable() end
        else
            ATBtn.BackgroundColor3 = Color3.fromRGB(28, 29, 39)
            ATS.Color = Color3.fromRGB(168, 85, 247)
            if _G.YOKUDO_AntiTrap then _G.YOKUDO_AntiTrap.Disable() end
        end
    end)

    -- Anti AFK
    local AAH = Instance.new("Frame")
    AAH.Size = UDim2.new(1, 0, 0, 32)
    AAH.BackgroundTransparency = 1
    AAH.LayoutOrder = 6
    AAH.Parent = SettingPage

    local AAL = Instance.new("TextLabel")
    AAL.Size = UDim2.new(1, -50, 1, 0)
    AAL.BackgroundTransparency = 1
    AAL.Text = "Anti AFK"
    AAL.TextColor3 = Color3.fromRGB(255, 255, 255)
    AAL.TextSize = 12
    AAL.TextXAlignment = Enum.TextXAlignment.Left
    AAL.TextYAlignment = Enum.TextYAlignment.Center
    AAL.Font = Enum.Font.GothamMedium
    AAL.Parent = AAH

    local AABtn = Instance.new("TextButton")
    AABtn.Size = UDim2.new(0, 26, 0, 26)
    AABtn.Position = UDim2.new(1, -26, 0.5, -13)
    AABtn.BackgroundColor3 = Color3.fromRGB(28, 29, 39)
    AABtn.BorderSizePixel = 0
    AABtn.Text = ""
    AABtn.AutoButtonColor = false
    AABtn.Parent = AAH

    local AAC = Instance.new("UICorner")
    AAC.CornerRadius = UDim.new(0, 6)
    AAC.Parent = AABtn

    local AAS = Instance.new("UIStroke")
    AAS.Color = Color3.fromRGB(168, 85, 247)
    AAS.Thickness = 1.5
    AAS.Parent = AABtn

    local AACheck = Instance.new("TextLabel")
    AACheck.Size = UDim2.new(1, 0, 1, 0)
    AACheck.BackgroundTransparency = 1
    AACheck.Text = "✓"
    AACheck.TextColor3 = Color3.fromRGB(255, 255, 255)
    AACheck.TextSize = 18
    AACheck.Font = Enum.Font.GothamBold
    AACheck.Visible = false
    AACheck.Parent = AABtn

    local AAE = false

    AABtn.MouseButton1Click:Connect(function()
        AAE = not AAE
        AACheck.Visible = AAE
        if AAE then
            AABtn.BackgroundColor3 = Color3.fromRGB(168, 85, 247)
            AAS.Color = Color3.fromRGB(192, 132, 252)
            if _G.YOKUDO_AntiAFK then _G.YOKUDO_AntiAFK.Enable() end
        else
            AABtn.BackgroundColor3 = Color3.fromRGB(28, 29, 39)
            AAS.Color = Color3.fromRGB(168, 85, 247)
            if _G.YOKUDO_AntiAFK then _G.YOKUDO_AntiAFK.Disable() end
        end
    end)

    -- God Mode
    local GMH = Instance.new("Frame")
    GMH.Size = UDim2.new(1, 0, 0, 52)
    GMH.BackgroundTransparency = 1
    GMH.LayoutOrder = 7
    GMH.Parent = SettingPage

    local GML = Instance.new("TextLabel")
    GML.Size = UDim2.new(1, -90, 0, 20)
    GML.Position = UDim2.new(0, 0, 0, 2)
    GML.BackgroundTransparency = 1
    GML.Text = "God Mode"
    GML.TextColor3 = Color3.fromRGB(255, 255, 255)
    GML.TextSize = 13
    GML.TextXAlignment = Enum.TextXAlignment.Left
    GML.Font = Enum.Font.GothamBold
    GML.Parent = GMH

    local GMSub = Instance.new("TextLabel")
    GMSub.Size = UDim2.new(1, -90, 0, 18)
    GMSub.Position = UDim2.new(0, 0, 0, 24)
    GMSub.BackgroundTransparency = 1
    GMSub.Text = "Click after Death"
    GMSub.TextColor3 = Color3.fromRGB(180, 180, 180)
    GMSub.TextSize = 10
    GMSub.TextXAlignment = Enum.TextXAlignment.Left
    GMSub.Font = Enum.Font.Gotham
    GMSub.Parent = GMH

    local GMBtn = Instance.new("TextButton")
    GMBtn.Size = UDim2.new(0, 70, 0, 26)
    GMBtn.Position = UDim2.new(1, -70, 0.5, -13)
    GMBtn.BackgroundColor3 = Color3.fromRGB(168, 85, 247)
    GMBtn.BorderSizePixel = 0
    GMBtn.Text = "Click"
    GMBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    GMBtn.TextSize = 12
    GMBtn.Font = Enum.Font.GothamBold
    GMBtn.AutoButtonColor = false
    GMBtn.Parent = GMH

    local GMC = Instance.new("UICorner")
    GMC.CornerRadius = UDim.new(0, 6)
    GMC.Parent = GMBtn

    GMBtn.MouseButton1Click:Connect(function()
        if _G.YOKUDO_GodMode then _G.YOKUDO_GodMode.Enable() end
    end)

    -- Manual Fast Click
    local FCH = Instance.new("Frame")
    FCH.Size = UDim2.new(1, 0, 0, 52)
    FCH.BackgroundTransparency = 1
    FCH.LayoutOrder = 8
    FCH.Parent = SettingPage

    local FCL = Instance.new("TextLabel")
    FCL.Size = UDim2.new(1, -90, 0, 20)
    FCL.Position = UDim2.new(0, 0, 0, 2)
    FCL.BackgroundTransparency = 1
    FCL.Text = "Manual Fast Click"
    FCL.TextColor3 = Color3.fromRGB(255, 255, 255)
    FCL.TextSize = 13
    FCL.TextXAlignment = Enum.TextXAlignment.Left
    FCL.Font = Enum.Font.GothamBold
    FCL.Parent = FCH

    local FCSub = Instance.new("TextLabel")
    FCSub.Size = UDim2.new(1, -90, 0, 18)
    FCSub.Position = UDim2.new(0, 0, 0, 24)
    FCSub.BackgroundTransparency = 1
    FCSub.Text = "Instant Click Eggs"
    FCSub.TextColor3 = Color3.fromRGB(180, 180, 180)
    FCSub.TextSize = 10
    FCSub.TextXAlignment = Enum.TextXAlignment.Left
    FCSub.Font = Enum.Font.Gotham
    FCSub.Parent = FCH

    local FCBtn = Instance.new("TextButton")
    FCBtn.Size = UDim2.new(0, 70, 0, 26)
    FCBtn.Position = UDim2.new(1, -70, 0.5, -13)
    FCBtn.BackgroundColor3 = Color3.fromRGB(168, 85, 247)
    FCBtn.BorderSizePixel = 0
    FCBtn.Text = "Click"
    FCBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    FCBtn.TextSize = 12
    FCBtn.Font = Enum.Font.GothamBold
    FCBtn.AutoButtonColor = false
    FCBtn.Parent = FCH

    local FCC = Instance.new("UICorner")
    FCC.CornerRadius = UDim.new(0, 6)
    FCC.Parent = FCBtn

    FCBtn.MouseButton1Click:Connect(function()
        if _G.YOKUDO_ManualFastClick then
            if _G.YOKUDO_ManualFastClick.IsEnabled() then
                _G.YOKUDO_ManualFastClick.Disable()
            else
                _G.YOKUDO_ManualFastClick.Enable()
            end
        end
    end)

    -- Refresh Setting UI Function
    _G.YOKUDO_RefreshSettingUI = function()
        if _G.YOKUDO_SelectedMethod then
            SelectedMethod = _G.YOKUDO_SelectedMethod
            MDB.Text = SelectedMethod .. " ▼"
        end
        if _G.YOKUDO_TeleportSpeed then
            SpeedBox.Text = tostring(_G.YOKUDO_TeleportSpeed)
        end
    end
end

-- ==================================================
-- SELECT DEFAULT TAB (فتح Info افتراضيًا)
-- ==================================================
task.spawn(function()
    task.wait(0.3)
    pcall(function()
        TabsManager:SelectTabByName("Info")
    end)
end)

-- ==================================================
-- APPLY CONFIG بعد 1 ثانية
-- ==================================================
task.spawn(function()
    task.wait(1)
    if _G.YOKUDO_ConfigSystem then
        pcall(function() _G.YOKUDO_ConfigSystem.Load() end)
    end
end)

print("✅ PART 5/5 OK - Hub Ready & Open!")