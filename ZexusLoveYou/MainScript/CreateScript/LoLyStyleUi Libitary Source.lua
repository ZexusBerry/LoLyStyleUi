local UI = {}

-- Функция для создания основного меню
function UI:CreateMenu(parent, title, width, height)
    local menu = Instance.new("Frame")
    menu.Name = "Menu"
    menu.Size = UDim2.new(0, width, 0, height)
    menu.Position = UDim2.new(0.5, -width/2, 0.5, -height/2)
    menu.BackgroundTransparency = 0.3
    menu.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    menu.Visible = true
    menu.Parent = parent

    -- Закругленные углы
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0.05, 0)
    corner.Parent = menu

    -- Заголовок меню
    local header = Instance.new("TextLabel")
    header.Name = "Header"
    header.Size = UDim2.new(1, 0, 0.1, 0)
    header.BackgroundTransparency = 1
    header.Text = title
    header.TextScaled = true
    header.TextColor3 = Color3.fromRGB(0, 0, 0)
    header.Font = Enum.Font.SourceSansBold
    header.Parent = menu

    -- UIGradient для размытости
    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255))
    })
    gradient.Parent = menu

    return menu
end

-- Функция для создания кнопки
function UI:CreateButton(parent, text, onClick)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, -20, 0, 50)
    button.Position = UDim2.new(0, 10, 0, 60)
    button.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    button.Text = text
    button.TextScaled = true
    button.TextColor3 = Color3.fromRGB(0, 0, 0)
    button.Font = Enum.Font.SourceSansBold
    button.Parent = parent

    -- Закругленные углы
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0.05, 0)
    corner.Parent = button

    -- Привязка события на клик
    button.MouseButton1Click:Connect(onClick)

    return button
end

-- Функция для создания метки
function UI:CreateLabel(parent, text)
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -20, 0, 50)
    label.Position = UDim2.new(0, 10, 0, 120)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextScaled = true
    label.TextColor3 = Color3.fromRGB(0, 0, 0)
    label.Font = Enum.Font.SourceSansBold
    label.Parent = parent

    return label
end

-- Функция для создания выпадающего списка (DropDown)
function UI:CreateDropDown(parent, options, onSelect)
    local dropDown = Instance.new("Frame")
    dropDown.Size = UDim2.new(1, -20, 0, 50)
    dropDown.Position = UDim2.new(0, 10, 0, 180)
    dropDown.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    dropDown.Parent = parent

    -- Закругленные углы
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0.05, 0)
    corner.Parent = dropDown

    -- Кнопка для раскрытия списка
    local dropButton = Instance.new("TextButton")
    dropButton.Size = UDim2.new(1, 0, 1, 0)
    dropButton.Text = options[1]
    dropButton.TextScaled = true
    dropButton.TextColor3 = Color3.fromRGB(0, 0, 0)
    dropButton.Font = Enum.Font.SourceSansBold
    dropButton.Parent = dropDown

    local listFrame = Instance.new("Frame")
    listFrame.Size = UDim2.new(1, 0, 0, 50 * #options)
    listFrame.Position = UDim2.new(0, 0, 1, 0)
    listFrame.BackgroundTransparency = 1
    listFrame.Visible = false
    listFrame.Parent = dropDown

    -- Список опций
    for i, option in ipairs(options) do
        local optionButton = Instance.new("TextButton")
        optionButton.Size = UDim2.new(1, 0, 0, 50)
        optionButton.Position = UDim2.new(0, 0, 0, 50 * (i - 1))
        optionButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        optionButton.Text = option
        optionButton.TextScaled = true
        optionButton.TextColor3 = Color3.fromRGB(0, 0, 0)
        optionButton.Font = Enum.Font.SourceSansBold
        optionButton.Parent = listFrame

        -- Закругленные углы
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0.05, 0)
        corner.Parent = optionButton

        optionButton.MouseButton1Click:Connect(function()
            dropButton.Text = option
            listFrame.Visible = false
            if onSelect then onSelect(option) end
        end)
    end

    dropButton.MouseButton1Click:Connect(function()
        listFrame.Visible = not listFrame.Visible
    end)

    return dropDown
end

-- Функция для создания вкладок (Tabs)
function UI:CreateTab(parent, titles)
    local tabFrame = Instance.new("Frame")
    tabFrame.Size = UDim2.new(1, -20, 0, 50)
    tabFrame.Position = UDim2.new(0, 10, 0, 240)
    tabFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    tabFrame.Parent = parent

    -- Закругленные углы
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0.05, 0)
    corner.Parent = tabFrame

    -- Создание вкладок
    local tabButtons = {}
    for i, title in ipairs(titles) do
        local tabButton = Instance.new("TextButton")
        tabButton.Size = UDim2.new(1 / #titles, 0, 1, 0)
        tabButton.Position = UDim2.new((i - 1) / #titles, 0, 0, 0)
        tabButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        tabButton.Text = title
        tabButton.TextScaled = true
        tabButton.TextColor3 = Color3.fromRGB(0, 0, 0)
        tabButton.Font = Enum.Font.SourceSansBold
        tabButton.Parent = tabFrame

        -- Закругленные углы
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0.05, 0)
        corner.Parent = tabButton

        table.insert(tabButtons, tabButton)
    end

    return tabFrame, tabButtons
end

return UI
