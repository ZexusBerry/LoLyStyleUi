local LoLyStyleUi = {}
LoLyStyleUi.__index = LoLyStyleUi

-- Create base frame
function LoLyStyleUi:CreateFrame(name, parent, position, size, color)
    local frame = Instance.new("Frame")
    frame.Name = name
    frame.Parent = parent
    frame.Position = position
    frame.Size = size
    frame.BackgroundColor3 = color
    frame.BorderSizePixel = 0
    frame.Visible = true
    return frame
end

-- Create button
function LoLyStyleUi:CreateButton(name, parent, position, size, text, color, textColor)
    local button = Instance.new("TextButton")
    button.Name = name
    button.Parent = parent
    button.Position = position
    button.Size = size
    button.Text = text
    button.BackgroundColor3 = color
    button.TextColor3 = textColor
    button.Font = Enum.Font.SourceSans
    button.TextSize = 20
    button.BorderSizePixel = 0
    return button
end

-- Create label
function LoLyStyleUi:CreateLabel(name, parent, position, size, text, textColor)
    local label = Instance.new("TextLabel")
    label.Name = name
    label.Parent = parent
    label.Position = position
    label.Size = size
    label.Text = text
    label.TextColor3 = textColor
    label.BackgroundTransparency = 1
    label.Font = Enum.Font.SourceSans
    label.TextSize = 20
    label.BorderSizePixel = 0
    return label
end

-- Create checkbox
function LoLyStyleUi:CreateCheckBox(name, parent, position, size, text, textColor, boxColor)
    local checkBoxFrame = Instance.new("Frame")
    checkBoxFrame.Name = name
    checkBoxFrame.Parent = parent
    checkBoxFrame.Position = position
    checkBoxFrame.Size = size
    checkBoxFrame.BackgroundColor3 = boxColor

    local box = Instance.new("TextButton")
    box.Name = "CheckBox"
    box.Parent = checkBoxFrame
    box.Size = UDim2.new(0.2, 0, 1, 0)
    box.Text = ""
    box.BackgroundColor3 = Color3.new(1, 1, 1)

    local label = self:CreateLabel("Label", checkBoxFrame, UDim2.new(0.25, 0, 0, 0), UDim2.new(0.75, 0, 1, 0), text, textColor)

    box.MouseButton1Click:Connect(function()
        if box.BackgroundColor3 == Color3.new(1, 1, 1) then
            box.BackgroundColor3 = boxColor
        else
            box.BackgroundColor3 = Color3.new(1, 1, 1)
        end
    end)

    return checkBoxFrame
end

-- Create dropdown
function LoLyStyleUi:CreateDropdown(name, parent, position, size, options, color, textColor)
    local dropdownFrame = Instance.new("Frame")
    dropdownFrame.Name = name
    dropdownFrame.Parent = parent
    dropdownFrame.Position = position
    dropdownFrame.Size = size
    dropdownFrame.BackgroundColor3 = color

    local dropdownButton = self:CreateButton("DropdownButton", dropdownFrame, UDim2.new(0, 0, 0, 0), UDim2.new(1, 0, 1, 0), options[1], color, textColor)

    local optionsFrame = Instance.new("Frame")
    optionsFrame.Name = "OptionsFrame"
    optionsFrame.Parent = dropdownFrame
    optionsFrame.Size = UDim2.new(1, 0, #options, 0)
    optionsFrame.Position = UDim2.new(0, 0, 1, 0)
    optionsFrame.BackgroundTransparency = 1
    optionsFrame.Visible = false

    for i, option in ipairs(options) do
        local optionButton = self:CreateButton("Option" .. i, optionsFrame, UDim2.new(0, 0, (i - 1) / #options, 0), UDim2.new(1, 0, 1 / #options, 0), option, color, textColor)
        optionButton.MouseButton1Click:Connect(function()
            dropdownButton.Text = option
            optionsFrame.Visible = false
        end)
    end

    dropdownButton.MouseButton1Click:Connect(function()
        optionsFrame.Visible = not optionsFrame.Visible
    end)

    return dropdownFrame
end

-- Create trackbar
function LoLyStyleUi:CreateTrackBar(name, parent, position, size, min, max, default, color)
    local trackBarFrame = Instance.new("Frame")
    trackBarFrame.Name = name
    trackBarFrame.Parent = parent
    trackBarFrame.Position = position
    trackBarFrame.Size = size
    trackBarFrame.BackgroundColor3 = color

    local handle = self:CreateFrame("Handle", trackBarFrame, UDim2.new((default - min) / (max - min), 0, 0, 0), UDim2.new(0.1, 0, 1, 0), Color3.new(0.5, 0.5, 0.5))

    local dragging = false
    handle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
        end
    end)

    handle.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)

    handle.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local mousePos = input.Position.X
            local barPos = trackBarFrame.AbsolutePosition.X
            local barSize = trackBarFrame.AbsoluteSize.X
            local newX = math.clamp(mousePos - barPos, 0, barSize - handle.Size.X.Offset)
            handle.Position = UDim2.new(0, newX, 0, 0)
        end
    end)

    return trackBarFrame
end

-- Create loading bar
function LoLyStyleUi:CreateLoadingBar(name, parent, position, size, color)
    local loadingBarFrame = Instance.new("Frame")
    loadingBarFrame.Name = name
    loadingBarFrame.Parent = parent
    loadingBarFrame.Position = position
    loadingBarFrame.Size = size
    loadingBarFrame.BackgroundColor3 = Color3.new(0.8, 0.8, 0.8)

    local fill = self:CreateFrame("Fill", loadingBarFrame, UDim2.new(0, 0, 0, 0), UDim2.new(0, 0, 1, 0), color)

    spawn(function()
        while true do
            for i = 0, size.X.Offset, 5 do
                fill.Size = UDim2.new(0, i, 1, 0)
                wait(0.05)
            end
            wait(0.5)
            fill.Size = UDim2.new(0, 0, 1, 0)
        end
    end)

    return loadingBarFrame
end

function LoLyStyleUi.new(name)
    local self = setmetatable({}, LoLyStyleUi)
    self.ScreenGui = Instance.new("ScreenGui")
    self.ScreenGui.Name = name
    self.ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

    self.MainFrame = self:CreateFrame("MainFrame", self.ScreenGui, UDim2.new(0.3, 0, 0.3, 0), UDim2.new(0.4, 0, 0.4, 0), Color3.new(0.2, 0.2, 0.2))

    self.Tabs = {}
    return self
end

function LoLyStyleUi:addTab(name)
    local tab = self:CreateButton(name .. "Tab", self.MainFrame, UDim2.new(#self.Tabs / 4, 0, 0, 0), UDim2.new(0.25, 0, 0.1, 0), name, Color3.new(0.3, 0.3, 0.3), Color3.new(1, 1, 1))
    self.Tabs[name] = tab
    return tab
end

function LoLyStyleUi:addButton(name, tab, text, onClick)
    local button = self:CreateButton(name, tab, UDim2.new(0, 0, #tab:GetChildren() / 10, 0), UDim2.new(1, 0, 0.1, 0), text, Color3.new(0.4, 0.4, 0.4), Color3.new(1, 1, 1))
    button.MouseButton1Click:Connect(onClick)
    return button
end

function LoLyStyleUi:addDropdown(name, tab, options)
    local dropdown = self:CreateDropdown(name, tab, UDim2.new(0, 0, #tab:GetChildren() / 10, 0), UDim2.new(1, 0, 0.1, 0), options, Color3.new(0.4, 0.4, 0.4), Color3.new(1, 1, 1))
    return dropdown
end

function LoLyStyleUi:addCheckBox(name, tab, text)
    local checkBox = self:CreateCheckBox(name, tab, UDim2.new(0, 0, #tab:GetChildren() / 10, 0), UDim2.new(1, 0, 0.1, 0), text, Color3.new(1, 1, 1), Color3.new(0.4, 0.4, 0.4))
    return checkBox
end

function LoLyStyleUi:addTrackBar(name, tab, min, max, initial)
    local trackBar = self:CreateTrackBar(name, tab, UDim2.new(0, 0, #tab:GetChildren() / 10, 0), UDim2.new(1, 0, 0.1, 0), min, max, initial, Color3.new(0.4, 0.4, 0.4))
    return trackBar
end

function LoLyStyleUi:addLoadingBar(name, tab)
    local loadingBar = self:CreateLoadingBar(name, tab, UDim2.new(0, 0, #tab:GetChildren() / 10, 0), UDim2.new(1, 0, 0.1, 0), Color3.new(0.4, 0.4, 0.4))
    return loadingBar
end

return LoLyStyleUi
