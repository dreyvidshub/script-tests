--[[
    GUI de Mantenimiento - Dreyvid Hub v3.1
    Con botones de WhatsApp y Discord
    Colocar en: StarterPlayerScripts (LocalScript)
--]]

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local GuiService = game:GetService("GuiService")
local LocalPlayer = Players.LocalPlayer

local CONFIG = {
    Titulo = "DREYVID HUB",
    Mensaje = "🔧 MANTENIMIENTO EN CURSO 🔧",
    SubMensaje = "Preparando el lanzamiento de Dreyvid Hub v3.1\nÚnete para enterarte del lanzamiento.",
    ColorPrimario = Color3.fromRGB(88, 101, 242),
    ColorFondo = Color3.fromRGB(30, 31, 34),
    ColorTexto = Color3.fromRGB(255, 255, 255),
    ColorAcento = Color3.fromRGB(237, 66, 69),
    ColorCerrar = Color3.fromRGB(237, 66, 69),
    ColorWhatsApp = Color3.fromRGB(37, 211, 102),
    ColorDiscord = Color3.fromRGB(88, 101, 242),
    LinkWhatsApp = "https://whatsapp.com/channel/0029VbDGdwi4IBhHMtl68X1R",
    LinkDiscord = "https://discord.gg/TRE4PnNXD",
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

-- Función para copiar al portapapeles (usando SetClipboard de Roblox)
local function copiarAlPortapapeles(texto)
    if setclipboard then
        setclipboard(texto)
        return true
    end
    return false
end

-- ============================
-- GUI PRINCIPAL
-- ============================
local ScreenGui = new("ScreenGui", {
    Name = "DreyvidHubMaintenance",
    ResetOnSpawn = false,
    IgnoreGuiInset = true,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
    Parent = LocalPlayer:WaitForChild("PlayerGui"),
})

local FondoOscuro = new("Frame", {
    Name = "FondoOscuro",
    Size = UDim2.fromScale(1, 1),
    BackgroundColor3 = Color3.fromRGB(0, 0, 0),
    BackgroundTransparency = 0.4,
    BorderSizePixel = 0,
    Parent = ScreenGui,
})

-- Ventana principal (más alta para los botones)
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

-- Barra de título
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
        Size = UDim2.new(1, -60, 1, 0),
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

-- Botón cerrar (X)
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

BotonCerrar.MouseEnter:Connect(function()
    TweenService:Create(BotonCerrar, TweenInfo.new(0.15),
        { BackgroundTransparency = 0, Size = UDim2.fromOffset(40, 40) }):Play()
end)
BotonCerrar.MouseLeave:Connect(function()
    TweenService:Create(BotonCerrar, TweenInfo.new(0.15),
        { BackgroundTransparency = 0.3, Size = UDim2.fromOffset(36, 36) }):Play()
end)

-- Ícono
local Icono = new("TextLabel", {
    Name = "Icono",
    AnchorPoint = Vector2.new(0.5, 0),
    Position = UDim2.new(0.5, 0, 0, 65),
    Size = UDim2.fromOffset(70, 70),
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
    Position = UDim2.new(0.5, 0, 0, 145),
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
    Position = UDim2.new(0.5, 0, 0, 195),
    Size = UDim2.new(1, -60, 0, 60),
    BackgroundTransparency = 1,
    Text = CONFIG.SubMensaje,
    TextColor3 = Color3.fromRGB(200, 200, 200),
    TextScaled = true,
    Font = Enum.Font.Gotham,
    TextWrapped = true,
    Parent = Ventana,
})

-- Etiqueta "Únete para más info"
new("TextLabel", {
    Name = "LabelUnete",
    AnchorPoint = Vector2.new(0.5, 0),
    Position = UDim2.new(0.5, 0, 0, 265),
    Size = UDim2.new(1, -40, 0, 20),
    BackgroundTransparency = 1,
    Text = "Únete para saber cuándo sale la v3.1:",
    TextColor3 = Color3.fromRGB(180, 180, 180),
    TextScaled = true,
    Font = Enum.Font.Gotham,
    Parent = Ventana,
})

-- ============================================
-- CONTENEDOR DE BOTONES (WhatsApp + Discord)
-- ============================================
local ContenedorBotones = new("Frame", {
    Name = "ContenedorBotones",
    AnchorPoint = Vector2.new(0.5, 0),
    Position = UDim2.new(0.5, 0, 0, 295),
    Size = UDim2.new(1, -60, 0, 45),
    BackgroundTransparency = 1,
    Parent = Ventana,
}, {
    new("UIListLayout", {
        FillDirection = Enum.FillDirection.Horizontal,
        HorizontalAlignment = Enum.HorizontalAlignment.Center,
        VerticalAlignment = Enum.VerticalAlignment.Center,
        Padding = UDim.new(0, 12),
        SortOrder = Enum.SortOrder.LayoutOrder,
    }),
})

-- Función para crear botón de enlace
local function crearBotonLink(nombre, texto, color, link, orden)
    local boton = new("TextButton", {
        Name = nombre,
        Size = UDim2.new(0.5, -6, 1, 0),
        BackgroundColor3 = color,
        BackgroundTransparency = 0.15,
        BorderSizePixel = 0,
        Text = texto,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextScaled = true,
        Font = Enum.Font.GothamBold,
        AutoButtonColor = false,
        LayoutOrder = orden,
        Parent = ContenedorBotones,
    }, {
        new("UICorner", { CornerRadius = UDim.new(0, 8) }),
        new("UIPadding", {
            PaddingLeft = UDim.new(0, 8),
            PaddingRight = UDim.new(0, 8),
            PaddingTop = UDim.new(0, 8),
            PaddingBottom = UDim.new(0, 8),
        }),
    })

    -- Hover
    boton.MouseEnter:Connect(function()
        TweenService:Create(boton, TweenInfo.new(0.15),
            { BackgroundTransparency = 0 }):Play()
    end)
    boton.MouseLeave:Connect(function()
        TweenService:Create(boton, TweenInfo.new(0.15),
            { BackgroundTransparency = 0.15 }):Play()
    end)

    -- Click: copia el link y avisa al usuario
    boton.MouseButton1Click:Connect(function()
        local copiado = copiarAlPortapapeles(link)

        -- Texto temporal de confirmación
        local textoOriginal = boton.Text
        boton.Text = copiado and "✅ ¡Copiado!" or "🔗 Ver en consola"
        boton.BackgroundColor3 = Color3.fromRGB(60, 180, 90)

        if not copiado then
            print("[Dreyvid Hub] Link de " .. nombre .. ": " .. link)
        end

        task.wait(1.5)
        if boton and boton.Parent then
            boton.Text = textoOriginal
            boton.BackgroundColor3 = color
        end
    end)

    return boton
end

crearBotonLink("BotonWhatsApp", "📱 WhatsApp", CONFIG.ColorWhatsApp, CONFIG.LinkWhatsApp, 1)
crearBotonLink("BotonDiscord", "💬 Discord", CONFIG.ColorDiscord, CONFIG.LinkDiscord, 2)

-- Barra de progreso
local BarraFondo = new("Frame", {
    Name = "BarraFondo",
    AnchorPoint = Vector2.new(0.5, 1),
    Position = UDim2.new(0.5, 0, 1, -15),
    Size = UDim2.new(0.85, 0, 0, 6),
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
TweenService:Create(Ventana,
    TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
    { Size = UDim2.fromOffset(540, 400) }
):Play()

task.spawn(function()
    while Ventana.Parent do
        BarraProgreso.Size = UDim2.fromScale(0, 1)
        local tw = TweenService:Create(BarraProgreso,
            TweenInfo.new(3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut),
            { Size = UDim2.fromScale(1, 1) })
        tw:Play()
        tw.Completed:Wait()
        task.wait(0.5)
    end
end)

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

    local tw = TweenService:Create(Ventana,
        TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.In),
        { Size = UDim2.fromOffset(0, 0) })
    tw:Play()
    tw.Completed:Wait()

    local twFondo = TweenService:Create(FondoOscuro,
        TweenInfo.new(0.2), { BackgroundTransparency = 1 })
    twFondo:Play()
    twFondo.Completed:Wait()

    ScreenGui:Destroy()
    print("[Dreyvid Hub] GUI cerrada por el usuario.")
end

BotonCerrar.MouseButton1Click:Connect(cerrarVentana)

game:GetService("UserInputService").InputBegan:Connect(function(input, processed)
    if processed then return end
    if input.KeyCode == Enum.KeyCode.Escape then
        cerrarVentana()
    end
end)

print("[Dreyvid Hub] GUI cargada. v3.1 próximamente.")
