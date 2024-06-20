local UI = {}

local TweenService = game:GetService("TweenService")


function UI:CreateMenu(parent, title, width, height)
    local menu = Instance.new("Frame")
    menu.Name = "Menu"
    menu.Size = UDim2.new(0, width, 0, height)
    menu.Position = UDim2.new(0.5, -width/2, 0.5, -height/2)
    menu.BackgroundTransparency = 0.1
    menu.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    menu.ClipsDescendants = true
    menu.Visible = true
    menu.Parent = parent

    -- Закругленные углы
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0.02, 0)
    corner.Parent = menu

    -- Тени
    local shadow = Instance.new("ImageLabel")
    shadow.Name = "Shadow"
    shadow.Size = UDim2.new(1, 20, 1, 20)
    shadow.Position = UDim2.new(0, -10, 0, -10)
    shadow.Image = "rbxassetid://1316045217"
    shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    shadow.ImageTransparency = 0.5
    shadow.ScaleType = Enum.ScaleType.Slice
    shadow.SliceCenter = Rect.new(10, 10, 118, 118)
    shadow.Parent = menu

    local header = Instance.new("TextLabel")
    header.Name = "Header"
    header.Size = UDim2.new(1, 0, 0, 50)
    header.BackgroundTransparency = 1
    header.Text = title
    header.TextScaled = true
    header.TextColor3 = Color3.fromRGB(255, 255, 255)
    header.Font = Enum.Font.GothamBold
    header.Parent = menu

    -- Градиентный фон
    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(40, 40, 40)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(60, 60, 60))
    })
    gradient.Rotation = 90
    gradient.Parent = menu

    return menu
end

-- Функция для создания кнопки
function UI:CreateButton(parent, text, onClick)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, -20, 0, 50)
    button.Position = UDim2.new(0.5, 0, 0.2, 0)
    button.AnchorPoint = Vector2.new(0.5, 0)
    button.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    button.Text = text
    button.TextScaled = true
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Font = Enum.Font.GothamBold
    button.Parent = parent

    -- Закругленные углы
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0.1, 0)
    corner.Parent = button

    -- Градиент
    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 100, 100)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0))
    })
    gradient.Rotation = 90
    gradient.Parent = button

    -- Тени
    local shadow = Instance.new("ImageLabel")
    shadow.Name = "Shadow"
    shadow.Size = UDim2.new(1, 15, 1, 15)
    shadow.Position = UDim2.new(0, -7.5, 0, -7.5)
    shadow.Image = "rbxassetid://1316045217"
    shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    shadow.ImageTransparency = 0.5
    shadow.ScaleType = Enum.ScaleType.Slice
    shadow.SliceCenter = Rect.new(10, 10, 118, 118)
    shadow.Parent = button

    -- Анимация нажатия
    button.MouseButton1Click:Connect(function()
        local tween = TweenService:Create(button, TweenInfo.new(0.1), {Size = UDim2.new(1, -25, 0, 45)})
        tween:Play()
        tween.Completed:Connect(function()
            local tweenBack = TweenService:Create(button, TweenInfo.new(0.1), {Size = UDim2.new(1, -20, 0, 50)})
            tweenBack:Play()
        end)
        if onClick then onClick() end
    end)

    return button
end

-- Функция для создания метки
function UI:CreateLabel(parent, text)
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -20, 0, 50)
    label.Position = UDim2.new(0.5, 0, 0.4, 0)
    label.AnchorPoint = Vector2.new(0.5, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextScaled = true
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.Font = Enum.Font.GothamBold
    label.Parent = parent

    -- Тени
    local shadow = Instance.new("ImageLabel")
    shadow.Name = "Shadow"
    shadow.Size = UDim2.new(1, 15, 1, 15)
    shadow.Position = UDim2.new(0, -7.5, 0, -7.5)
    shadow.Image = "rbxassetid://1316045217"
    shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    shadow.ImageTransparency = 0.5
    shadow.ScaleType = Enum.ScaleType.Slice
    shadow.SliceCenter = Rect.new(10, 10, 118, 118)
    shadow.Parent = label

    return label
end

-- Функция для создания выпадающего списка (DropDown)
function UI:CreateDropDown(parent, options, onSelect)
    local dropDown = Instance.new("Frame")
    dropDown.Size = UDim2.new(1, -20, 0, 50)
    dropDown.Position = UDim2.new(0.5, 0, 0.6, 0)
    dropDown.AnchorPoint = Vector2.new(0.5, 0)
    dropDown.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    dropDown.ClipsDescendants = true
    dropDown.Parent = parent

    -- Закругленные углы
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0.1, 0)
    corner.Parent = dropDown

    -- Тени
    local shadow = Instance.new("ImageLabel")
    shadow.Name = "Shadow"
    shadow.Size = UDim2.new(1, 15, 1, 15)
    shadow.Position = UDim2.new(0, -7.5, 0, -7.5)
    shadow.Image = "rbxassetid://1316045217"
    shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    shadow.ImageTransparency = 0.5
    shadow.ScaleType = Enum.ScaleType.Slice
    shadow.SliceCenter = Rect.new(10, 10, 118, 118)
    shadow.Parent = dropDown

    -- Кнопка для раскрытия списка
    local dropButton = Instance.new("TextButton")
    dropButton.Size = UDim2.new(1, 0, 1, 0)
    dropButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    dropButton.Text = options[1]
    dropButton.TextScaled = true
    dropButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    dropButton.Font = Enum.Font.GothamBold
    dropButton.Parent = dropDown

    -- Градиент (продолжение для DropDown)
    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(30, 30, 30)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(50, 50, 50))
    })
    gradient.Rotation = 90
    gradient.Parent = dropDown

    -- Анимация раскрытия списка
    local isDropdownOpen = false
    dropButton.MouseButton1Click:Connect(function()
        isDropdownOpen = not isDropdownOpen
        local sizeY = isDropdownOpen and UDim2.new(1, 0, 0, 150) or UDim2.new(1, 0, 0, 50)
        local tween = TweenService:Create(dropDown, TweenInfo.new(0.2), {Size = sizeY})
        tween:Play()
    end)

    -- Создание элементов списка
    local listContainer = Instance.new("Frame")
    listContainer.Size = UDim2.new(1, 0, 0, 0)
    listContainer.Position = UDim2.new(0, 0, 1, 0)
    listContainer.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    listContainer.Visible = false
    listContainer.Parent = dropDown

    -- Закругленные углы для контейнера списка
    local listCorner = Instance.new("UICorner")
    listCorner.CornerRadius = UDim.new(0, 6)
    listCorner.Parent = listContainer

    -- Создание элементов списка
    local function createListItems()
        for i, optionText in ipairs(options) do
            local listItem = Instance.new("TextButton")
            listItem.Size = UDim2.new(1, 0, 0, 50)
            listItem.Position = UDim2.new(0, 0, 0, (i - 1) * 50)
            listItem.AnchorPoint = Vector2.new(0, 0)
            listItem.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            listItem.Text = optionText
            listItem.TextScaled = true
            listItem.TextColor3 = Color3.fromRGB(255, 255, 255)
            listItem.Font = Enum.Font.Gotham
            listItem.Parent = listContainer

            -- Анимация выбора элемента списка
            listItem.MouseButton1Click:Connect(function()
                dropButton.Text = optionText
                isDropdownOpen = false
                TweenService:Create(dropDown, TweenInfo.new(0.2), {Size = UDim2.new(1, 0, 0, 50)}):Play()
                if onSelect then onSelect(i, optionText) end
            end)

            -- Тени для элемента списка
            local shadow = Instance.new("ImageLabel")
            shadow.Name = "Shadow"
            shadow.Size = UDim2.new(1, 15, 1, 15)
            shadow.Position = UDim2.new(0, -7.5, 0, -7.5)
            shadow.Image = "rbxassetid://1316045217"
            shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
            shadow.ImageTransparency = 0.5
            shadow.ScaleType = Enum.ScaleType.Slice
            shadow.SliceCenter = Rect.new(10, 10, 118, 118)
            shadow.Parent = listItem
        end
    end

    -- Создание элементов списка
    createListItems()

    return dropDown
end

-- Функция для создания вкладок (Tabs)
function UI:CreateTabs(parent, tabs)
    local tabContainer = Instance.new("Frame")
    tabContainer.Size = UDim2.new(1, 0, 1, 0)
    tabContainer.BackgroundTransparency = 1
    tabContainer.Parent = parent

    local tabButtons = {}

    -- Создание кнопок вкладок
    for i, tabData in ipairs(tabs) do
        local tabButton = Instance.new("TextButton")
        tabButton.Size = UDim2.new(0, 100, 0, 50)
        tabButton.Position = UDim2.new(0, (i - 1) * 110, 0, 0)
        tabButton.AnchorPoint = Vector2.new(0, 0)
        tabButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        tabButton.Text = tabData.name
        tabButton.TextScaled = true
        tabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        tabButton.Font = Enum.Font.GothamBold
        tabButton.Parent = tabContainer

        -- Анимация активной вкладки
        tabButton.MouseButton1Click:Connect(function()
            for _, button in ipairs(tabButtons) do
                button.TextColor3 = Color3.fromRGB(255, 255, 255)
                button.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
            end
            tabButton.TextColor3 = Color3.fromRGB(200, 200, 200)
            tabButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            if tabData.onSelected then tabData.onSelected() end
        end)

        table.insert(tabButtons, tabButton)
    end

    return tabContainer
end

return UI
