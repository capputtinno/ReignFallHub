--[[
    Reign Fall Hub - Loader Autônomo
    Este arquivo contém tudo que precisa
]]

-- Verificar se GUI já existe
if game.CoreGui:FindFirstChild("ReignFallHub") then
    game.CoreGui.ReignFallHub:Destroy()
end

-- Serviços
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local LocalPlayer = Players.LocalPlayer

-- Criar GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ReignFallHub"
ScreenGui.Parent = CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Frame principal
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 550, 0, 380)
MainFrame.Position = UDim2.new(0.5, -275, 0.5, -190)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

-- Corner
local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 8)
MainCorner.Parent = MainFrame

-- Borda
local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(60, 60, 60)
MainStroke.Thickness = 1
MainStroke.Parent = MainFrame

-- Barra de título
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 40)
TitleBar.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 8)
TitleCorner.Parent = TitleBar

-- Título
local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(0, 200, 1, 0)
TitleLabel.Position = UDim2.new(0, 15, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "Reign Fall Hub"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextSize = 18
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.Parent = TitleBar

-- Botão Minimizar
local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Size = UDim2.new(0, 30, 0, 30)
MinimizeButton.Position = UDim2.new(1, -75, 0, 5)
MinimizeButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
MinimizeButton.Text = "—"
MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeButton.TextSize = 20
MinimizeButton.Font = Enum.Font.GothamBold
MinimizeButton.BorderSizePixel = 0
MinimizeButton.Parent = TitleBar

local MinimizeCorner = Instance.new("UICorner")
MinimizeCorner.CornerRadius = UDim.new(0, 4)
MinimizeCorner.Parent = MinimizeButton

-- Botão Fechar
local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(1, -35, 0, 5)
CloseButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseButton.Text = "×"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 24
CloseButton.Font = Enum.Font.GothamBold
CloseButton.BorderSizePixel = 0
CloseButton.Parent = TitleBar

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 4)
CloseCorner.Parent = CloseButton

-- Container do conteúdo
local ContentContainer = Instance.new("Frame")
ContentContainer.Size = UDim2.new(1, 0, 1, -40)
ContentContainer.Position = UDim2.new(0, 0, 0, 40)
ContentContainer.BackgroundTransparency = 1
ContentContainer.BorderSizePixel = 0
ContentContainer.Parent = MainFrame

-- Barra lateral de abas
local TabBar = Instance.new("Frame")
TabBar.Size = UDim2.new(0, 120, 1, 0)
TabBar.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
TabBar.BorderSizePixel = 0
TabBar.Parent = ContentContainer

local TabBarCorner = Instance.new("UICorner")
TabBarCorner.CornerRadius = UDim.new(0, 8)
TabBarCorner.Parent = TabBar

-- Container das páginas
local PagesContainer = Instance.new("Frame")
PagesContainer.Size = UDim2.new(1, -130, 1, 0)
PagesContainer.Position = UDim2.new(0, 130, 0, 0)
PagesContainer.BackgroundTransparency = 1
PagesContainer.BorderSizePixel = 0
PagesContainer.Parent = ContentContainer

-- Variáveis de controle
local minimized = false
local tabs = {}

-- Função para criar abas
local function createTab(name, icon)
    local tabButton = Instance.new("TextButton")
    tabButton.Name = name .. "Tab"
    tabButton.Size = UDim2.new(1, -10, 0, 35)
    tabButton.Position = UDim2.new(0, 5, 0, 10 + (#tabs * 40))
    tabButton.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    tabButton.Text = "  " .. icon .. "  " .. name
    tabButton.TextColor3 = Color3.fromRGB(200, 200, 200)
    tabButton.TextSize = 13
    tabButton.Font = Enum.Font.GothamSemibold
    tabButton.TextXAlignment = Enum.TextXAlignment.Left
    tabButton.BorderSizePixel = 0
    tabButton.AutoButtonColor = false
    tabButton.Parent = TabBar
    
    local tabCorner = Instance.new("UICorner")
    tabCorner.CornerRadius = UDim.new(0, 5)
    tabCorner.Parent = tabButton
    
    -- Página
    local page = Instance.new("ScrollingFrame")
    page.Name = name .. "Page"
    page.Size = UDim2.new(1, -20, 1, -20)
    page.Position = UDim2.new(0, 10, 0, 10)
    page.BackgroundTransparency = 1
    page.BorderSizePixel = 0
    page.ScrollBarThickness = 3
    page.ScrollBarImageColor3 = Color3.fromRGB(60, 60, 60)
    page.Visible = false
    page.Parent = PagesContainer
    
    local pageLayout = Instance.new("UIListLayout")
    pageLayout.Padding = UDim.new(0, 8)
    pageLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    pageLayout.SortOrder = Enum.SortOrder.LayoutOrder
    pageLayout.Parent = page
    
    table.insert(tabs, {button = tabButton, page = page})
    
    tabButton.MouseButton1Click:Connect(function()
        for _, tab in ipairs(tabs) do
            tab.page.Visible = false
            tab.button.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
            tab.button.TextColor3 = Color3.fromRGB(200, 200, 200)
        end
        
        page.Visible = true
        tabButton.BackgroundColor3 = Color3.fromRGB(70, 130, 200)
        tabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    end)
    
    return page
end

-- Função para criar seção
local function createSection(page, title)
    local section = Instance.new("Frame")
    section.Size = UDim2.new(1, -10, 0, 80)
    section.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    section.BorderSizePixel = 0
    section.Parent = page
    
    local sectionCorner = Instance.new("UICorner")
    sectionCorner.CornerRadius = UDim.new(0, 5)
    sectionCorner.Parent = section
    
    local sectionTitle = Instance.new("TextLabel")
    sectionTitle.Size = UDim2.new(1, -20, 0, 25)
    sectionTitle.Position = UDim2.new(0, 10, 0, 5)
    sectionTitle.BackgroundTransparency = 1
    sectionTitle.Text = title
    sectionTitle.TextColor3 = Color3.fromRGB(150, 150, 150)
    sectionTitle.TextSize = 14
    sectionTitle.Font = Enum.Font.GothamBold
    sectionTitle.TextXAlignment = Enum.TextXAlignment.Left
    sectionTitle.Parent = section
    
    return section
end

-- Função para criar botão
local function createButton(parent, text, position, callback)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0, 150, 0, 35)
    button.Position = position or UDim2.new(0, 10, 0, 35)
    button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    button.Text = text
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.TextSize = 13
    button.Font = Enum.Font.GothamSemibold
    button.BorderSizePixel = 0
    button.Parent = parent
    
    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 4)
    buttonCorner.Parent = button
    
    if callback then
        button.MouseButton1Click:Connect(callback)
    end
    
    return button
end

-- Função para criar toggle
local function createToggle(parent, text, position, callback)
    local toggleFrame = Instance.new("Frame")
    toggleFrame.Size = UDim2.new(1, -20, 0, 40)
    toggleFrame.Position = position or UDim2.new(0, 10, 0, 0)
    toggleFrame.BackgroundTransparency = 1
    toggleFrame.Parent = parent
    
    local toggleLabel = Instance.new("TextLabel")
    toggleLabel.Size = UDim2.new(0, 200, 1, 0)
    toggleLabel.BackgroundTransparency = 1
    toggleLabel.Text = text
    toggleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    toggleLabel.TextSize = 13
    toggleLabel.Font = Enum.Font.Gotham
    toggleLabel.TextXAlignment = Enum.TextXAlignment.Left
    toggleLabel.Parent = toggleFrame
    
    local toggleButton = Instance.new("TextButton")
    toggleButton.Size = UDim2.new(0, 40, 0, 20)
    toggleButton.Position = UDim2.new(1, -50, 0.5, -10)
    toggleButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    toggleButton.Text = ""
    toggleButton.BorderSizePixel = 0
    toggleButton.AutoButtonColor = false
    toggleButton.Parent = toggleFrame
    
    local toggleCorner = Instance.new("UICorner")
    toggleCorner.CornerRadius = UDim.new(1, 0)
    toggleCorner.Parent = toggleButton
    
    local toggleIndicator = Instance.new("Frame")
    toggleIndicator.Size = UDim2.new(0, 16, 0, 16)
    toggleIndicator.Position = UDim2.new(0, 2, 0, 2)
    toggleIndicator.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
    toggleIndicator.BorderSizePixel = 0
    toggleIndicator.Parent = toggleButton
    
    local indicatorCorner = Instance.new("UICorner")
    indicatorCorner.CornerRadius = UDim.new(1, 0)
    indicatorCorner.Parent = toggleIndicator
    
    local toggled = false
    
    toggleButton.MouseButton1Click:Connect(function()
        toggled = not toggled
        if toggled then
            TweenService:Create(toggleButton, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {BackgroundColor3 = Color3.fromRGB(70, 130, 200)}):Play()
            TweenService:Create(toggleIndicator, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {Position = UDim2.new(1, -18, 0, 2)}):Play()
        else
            TweenService:Create(toggleButton, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {BackgroundColor3 = Color3.fromRGB(60, 60, 60)}):Play()
            TweenService:Create(toggleIndicator, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {Position = UDim2.new(0, 2, 0, 2)}):Play()
        end
        if callback then callback(toggled) end
    end)
    
    return toggleButton
end

-- Criar abas
local mainPage = createTab("Main", "🏠")
local combatPage = createTab("Combat", "⚔️")
local farmPage = createTab("Farm", "🌾")
local espPage = createTab("ESP", "👁️")
local teleportPage = createTab("Teleport", "📍")
local miscPage = createTab("Misc", "⚙️")

-- PÁGINA MAIN
local mainSection = createSection(mainPage, "Informações do Jogador")
mainSection.Size = UDim2.new(1, -10, 0, 150)

local playerInfoLabel = Instance.new("TextLabel")
playerInfoLabel.Size = UDim2.new(1, -20, 0, 80)
playerInfoLabel.Position = UDim2.new(0, 10, 0, 35)
playerInfoLabel.BackgroundTransparency = 1
playerInfoLabel.Text = "👤 Jogador: " .. LocalPlayer.Name .. "\n🆔 ID: " .. LocalPlayer.UserId .. "\n❤️ Vida: Carregando..."
playerInfoLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
playerInfoLabel.TextSize = 13
playerInfoLabel.Font = Enum.Font.Gotham
playerInfoLabel.TextXAlignment = Enum.TextXAlignment.Left
playerInfoLabel.TextYAlignment = Enum.TextYAlignment.Top
playerInfoLabel.Parent = mainSection

createButton(mainSection, "Atualizar Info", UDim2.new(0, 10, 0, 120))

-- PÁGINA COMBAT
local combatSection = createSection(combatPage, "Aimbot & Combate")
combatSection.Size = UDim2.new(1, -10, 0, 180)

createToggle(combatSection, "Aimbot", UDim2.new(0, 10, 0, 30))
createToggle(combatSection, "Silent Aim", UDim2.new(0, 10, 0, 70))
createToggle(combatSection, "Auto Disparo", UDim2.new(0, 10, 0, 110))

local hitboxSection = createSection(combatPage, "Hitbox")
hitboxSection.Size = UDim2.new(1, -10, 0, 120)

createToggle(hitboxSection, "Expandir Hitbox", UDim2.new(0, 10, 0, 30))
createButton(hitboxSection, "Configurar", UDim2.new(0, 10, 0, 70))

-- PÁGINA FARM
local farmSection = createSection(farmPage, "Auto Farm")
farmSection.Size = UDim2.new(1, -10, 0, 180)

createToggle(farmSection, "Auto Farm", UDim2.new(0, 10, 0, 30))
createToggle(farmSection, "Coleta Automática", UDim2.new(0, 10, 0, 70))
createToggle(farmSection, "Auto Vender", UDim2.new(0, 10, 0, 110))

-- PÁGINA ESP
local espSection = createSection(espPage, "ESP de Jogadores")
espSection.Size = UDim2.new(1, -10, 0, 220)

createToggle(espSection, "ESP de Jogadores", UDim2.new(0, 10, 0, 30))
createToggle(espSection, "Mostrar Nome", UDim2.new(0, 10, 0, 70))
createToggle(espSection, "Mostrar Vida", UDim2.new(0, 10, 0, 110))
createToggle(espSection, "Mostrar Distância", UDim2.new(0, 10, 0, 150))

-- PÁGINA TELEPORT
local teleportSection = createSection(teleportPage, "Teleportes Rápidos")
teleportSection.Size = UDim2.new(1, -10, 0, 200)

createButton(teleportSection, "Spawn", UDim2.new(0, 10, 0, 35))
createButton(teleportSection, "Área de Farm", UDim2.new(0, 170, 0, 35))
createButton(teleportSection, "Boss", UDim2.new(0, 10, 0, 80))
createButton(teleportSection, "Loja", UDim2.new(0, 170, 0, 80))

-- PÁGINA MISC
local miscSection = createSection(miscPage, "Utilitários")
miscSection.Size = UDim2.new(1, -10, 0, 180)

createToggle(miscSection, "Auto Clicker", UDim2.new(0, 10, 0, 30))
createToggle(miscSection, "No Clip", UDim2.new(0, 10, 0, 70))
createToggle(miscSection, "Velocidade", UDim2.new(0, 10, 0, 110))

-- Selecionar primeira aba
if tabs[1] then
    tabs[1].page.Visible = true
    tabs[1].button.BackgroundColor3 = Color3.fromRGB(70, 130, 200)
    tabs[1].button.TextColor3 = Color3.fromRGB(255, 255, 255)
end

-- Sistema de arrastar
local dragging = false
local dragStart
local startPos

TitleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

-- Minimizar
MinimizeButton.MouseButton1Click:Connect(function()
    minimized = not minimized
    if minimized then
        TweenService:Create(MainFrame, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {Size = UDim2.new(0, 550, 0, 40)}):Play()
        MinimizeButton.Text = "+"
    else
        TweenService:Create(MainFrame, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {Size = UDim2.new(0, 550, 0, 380)}):Play()
        MinimizeButton.Text = "—"
    end
end)

-- Fechar
CloseButton.MouseButton1Click:Connect(function()
    TweenService:Create(MainFrame, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {Size = UDim2.new(0, 0, 0, 0)}):Play()
    wait(0.2)
    ScreenGui:Destroy()
end)

-- Atualizar vida
spawn(function()
    while wait(1) do
        if ScreenGui and ScreenGui.Parent then
            local health = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") and LocalPlayer.Character.Humanoid.Health or 0
            playerInfoLabel.Text = "👤 Jogador: " .. LocalPlayer.Name .. "\n🆔 ID: " .. LocalPlayer.UserId .. "\n❤️ Vida: " .. math.floor(health)
        end
    end
end)

print("✅ Reign Fall Hub carregado com sucesso!")
