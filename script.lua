--[[
    GUI de Mantenimiento - Dreyvid Hub (con botón de cerrar)
    Colocar en: StarterPlayerScripts (LocalScript)
--]]

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer

local CONFIG = {
    Titulo = "DREYVID HUB",
    Mensaje = "🔧 MANTENIMIENTO EN CURSO 🔧",
    SubMensaje = "Estamos trabajando para mejorar tu experiencia.\nVuelve pronto.",
    ColorPrimario = Color3.fromRGB(88, 101, 242),
    ColorFondo = Color3.fromRGB(30, 31, 34),
    ColorTexto = Color3.fromRGB(255, 255, 255),
    ColorAcento = Color3.fromRGB(237, 66, 69),
    ColorCerrar = Color3.fromRGB(237, 66, 69),
}

-- Helper
local function new(className, props, children)
    local inst = Instance.new(className)
    for k, v in pairs(props or {}) do
        inst[k] = v
    end
    for _, c in ipairs(children or {}) do
        c.Parent = inst
    end
    return inst
end

-- ScreenGui
local ScreenGui = new("ScreenGui", {
    Name = "DreyvidHubMaintenance",
    ResetOnSpawn = false,
    IgnoreGuiInset = true,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
    Parent = LocalPlayer:WaitForChild("PlayerGui"),
})

-- Fondo oscuro (bloquea clics detrás)
local FondoOscuro = new("Frame", {
    Name = "FondoOscuro",
    Size = UDim2.fromScale(1, 1),
    BackgroundColor3 = Color3.fromRGB(0, 0, 0),
    BackgroundTransparency = 0.4,
    BorderSizePixel = 0,
    Parent = ScreenGui,
})

-- Ventana principal
local Ventana = new("Frame", {
    Name = "Ventana",
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.fromScale(0.5, 0.5),
    Size = UDim2.fromOffset(0, 0),
    BackgroundColor3 = CONFIG.ColorFondo,
    BorderSizePixel = 0,
    Parent = FondoOscuro,
}, {
    new("UICorner", { CornerRadius = UDim.new(0, 12) }),
    new("UIStroke", {
        Color = CONFIG.ColorPrimario,
        Thickness = 2,
        Transparency = 0.2,
    }),
})

-- Barra superior
local BarraTitulo = new("Frame", {
    Name = "BarraTitulo",
    Size = UDim2.new(1, 0, 0, 50),
    BackgroundColor3 = CONFIG.ColorPrimario,
    BorderSizePixel = 0,
    Parent = Ventana,
}, {
    new("UICorner", { CornerRadius = UDim.new(0, 12) }),
    new("Frame", {
        Size = UDim2.new(1, 0, 0.5, 0),
        Position = UDim2.fromScale(0, 0.5),
        BackgroundColor3 = CONFIG.ColorPrimario,
        BorderSizePixel = 0,
    }),
    new("TextLabel", {
        Name = "Titulo",
        Size = UDim2.new(1, -60, 1, 0), -- deja espacio a la X
        BackgroundTransparency = 1,
        Text = CONFIG.Titulo,
        TextColor3 = CONFIG.ColorTexto,
        TextScaled = true,
        Font = Enum.Font.GothamBold,
        TextXAlignment = Enum.TextXAlignment.Left,
    }, {
        new("UIPadding", {
            PaddingLeft = UDim.new(0, 15),
            PaddingRight = UDim.new(0, 5),
            PaddingTop = UDim.new(0, 10),
            PaddingBottom = UDim.new(0, 10),
        }),
    }),
})

-- ============================================
-- BOTÓN DE CERRAR (X)
-- ============================================
local BotonCerrar = new("TextButton", {
    Name = "BotonCerrar",
    AnchorPoint = Vector2.new(1, 0.5),
    Position = UDim2.new(1, -10, 0.5, 0),
    Size = UDim2.fromOffset(36, 36),
    BackgroundColor3 = CONFIG.ColorCerrar,
    BackgroundTransparency = 0.3,
    BorderSizePixel = 0,
    Text = "✕",
    TextColor3 = Color3.fromRGB(255, 255, 255),
    TextScaled = true,
    Font = Enum.Font.GothamBold,
    AutoButtonColor = false,
    Parent = BarraTitulo,
}, {
    new("UICorner", { CornerRadius = UDim.new(0, 8) }),
    new("UIPadding", {
        PaddingLeft = UDim.new(0, 10),
        PaddingRight = UDim.new(0, 10),
        PaddingTop = UDim.new(0, 10),
        PaddingBottom = UDim.new(0, 10),
    }),
})

-- Hover del botón X
BotonCerrar.MouseEnter:Connect(function()
    TweenService:Create(
        BotonCerrar,
        TweenInfo.new(0.15),
        { BackgroundTransparency = 0, Size = UDim2.fromOffset(40, 40) }
    ):Play()
end)

BotonCerrar.MouseLeave:Connect(function()
    TweenService:Create(
        BotonCerrar,
        TweenInfo.new(0.15),
        { BackgroundTransparency = 0.3, Size = UDim2.fromOffset(36, 36) }
    ):Play()
end)

-- Ícono
local Icono = new("TextLabel", {
    Name = "Icono",
    AnchorPoint = Vector2.new(0.5, 0),
    Position = UDim2.new(0.5, 0, 0, 70),
    Size = UDim2.fromOffset(80, 80),
    BackgroundTransparency = 1,
    Text = "🔧",
    TextScaled = true,
    Font = Enum.Font.GothamBold,
    Parent = Ventana,
})

-- Mensaje principal
new("TextLabel", {
    Name = "MensajePrincipal",
    AnchorPoint = Vector2.new(0.5, 0),
    Position = UDim2.new(0.5, 0, 0, 160),
    Size = UDim2.new(1, -40, 0, 40),
    BackgroundTransparency = 1,
    Text = CONFIG.Mensaje,
    TextColor3 = CONFIG.ColorAcento,
    TextScaled = true,
    Font = Enum.Font.GothamBold,
    Parent = Ventana,
})

-- Submensaje
new("TextLabel", {
    Name = "SubMensaje",
    AnchorPoint = Vector2.new(0.5, 0),
    Position = UDim2.new(0.5, 0, 0, 210),
    Size = UDim2.new(1, -60, 0, 60),
    BackgroundTransparency = 1,
    Text = CONFIG.SubMensaje,
    TextColor3 = Color3.fromRGB(200, 200, 200),
    TextScaled = true,
    Font = Enum.Font.Gotham,
    TextWrapped = true,
    Parent = Ventana,
})

-- Barra de progreso
local BarraFondo = new("Frame", {
    Name = "BarraFondo",
    AnchorPoint = Vector2.new(0.5, 0),
    Position = UDim2.new(0.5, 0, 1, -40),
    Size = UDim2.new(0.8, 0, 0, 8),
    BackgroundColor3 = Color3.fromRGB(60, 60, 65),
    BorderSizePixel = 0,
    Parent = Ventana,
}, {
    new("UICorner", { CornerRadius = UDim.new(1, 0) }),
})

local BarraProgreso = new("Frame", {
    Name = "BarraProgreso",
    Size = UDim2.fromScale(0, 1),
    BackgroundColor3 = CONFIG.ColorPrimario,
    BorderSizePixel = 0,
    Parent = BarraFondo,
}, {
    new("UICorner", { CornerRadius = UDim.new(1, 0) }),
})

-- ============================================
-- ANIMACIONES
-- ============================================

-- Animación de entrada
TweenService:Create(
    Ventana,
    TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
    { Size = UDim2.fromOffset(520, 320) }
):Play()

-- Animación de la barra (loop)
task.spawn(function()
    while Ventana.Parent do
        BarraProgreso.Size = UDim2.fromScale(0, 1)
        local tw = TweenService:Create(
            BarraProgreso,
            TweenInfo.new(3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut),
            { Size = UDim2.fromScale(1, 1) }
        )
        tw:Play()
        tw.Completed:Wait()
        task.wait(0.5)
    end
end)

-- Pulso del ícono
task.spawn(function()
    while Ventana.Parent do
        Icono.TextTransparency = 0
        task.wait(0.6)
        Icono.TextTransparency = 0.4
        task.wait(0.6)
    end
end)

-- ============================================
-- LÓGICA DE CIERRE
-- ============================================
local cerrando = false

local function cerrarVentana()
    if cerrando then return end
    cerrando = true

    -- Animación de salida
    local tw = TweenService:Create(
        Ventana,
        TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.In),
        { Size = UDim2.fromOffset(0, 0) }
    )
    tw:Play()
    tw.Completed:Wait()

    local twFondo = TweenService:Create(
        FondoOscuro,
        TweenInfo.new(0.2),
        { BackgroundTransparency = 1 }
    )
    twFondo:Play()
    twFondo.Completed:Wait()

    ScreenGui:Destroy()
    print("[Dreyvid Hub] GUI de mantenimiento cerrada por el usuario.")
end

BotonCerrar.MouseButton1Click:Connect(cerrarVentana)

-- Opcional: cerrar también con tecla Escape
game:GetService("UserInputService").InputBegan:Connect(function(input, processed)
    if processed then return end
    if input.KeyCode == Enum.KeyCode.Escape then
        cerrarVentana()
    end
end)

print("[Dreyvid Hub] GUI de mantenimiento cargada correctamente.")
