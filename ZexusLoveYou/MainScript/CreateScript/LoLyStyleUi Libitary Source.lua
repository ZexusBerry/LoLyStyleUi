 Library Setup
local UI = {}
UI.__index = UI

-- Helper functions for creating UI elements
local function createFrame(name, parent, position, size, color)
    local frame = Instance.new("Frame")
    frame.Name = name
    frame.Parent = parent
    frame.Position = position
    frame.Size = size
    frame.BackgroundColor3 = color
    frame.BorderSizePixel = 0
    return frame
end

local function createTextLabel(name, parent, position, size, text, font, textSize, textColor)
    local label = Instance.new("TextLabel")
    label.Name = name
    label.Parent = parent
    label.Position = position
    label.Size = size
    label.Text = text
    label.Font = font
    label.TextSize = textSize
    label.TextColor3 = textColor
    label.BackgroundTransparency = 1
    return label
end

local function createButton(name, parent, position, size, text, font, textSize, textColor, color)
    local button = Instance.new("TextButton")
    button.Name = name
    button.Parent = parent
    button.Position = position
    button.Size = size
    button.Text = text
    button.Font = font
    button.TextSize = textSize
    button.TextColor3 = textColor
    button.BackgroundColor3 = color
    button.BorderSizePixel = 0
    return button
end

local function createDropdown(name, parent, position, size, options, font, textSize, textColor, color)
    local dropdown = Instance.new("Frame")
    dropdown.Name = name
    dropdown.Parent = parent
    dropdown.Position = position
    dropdown.Size = size
    dropdown.BackgroundColor3 = color
    dropdown.BorderSizePixel = 0

    local dropButton = createButton("DropButton", dropdown, UDim2.new(0, 0, 0, 0), size, options[1], font, textSize, textColor, color)
    local dropList = Instance.new("Frame")
    dropList.Name = "DropList"
    dropList.Parent = dropdown
    dropList.Position = UDim2.new(0, 0, 1, 0)
    dropList.Size = UDim2.new(1, 0, #options, size.Y.Offset)
    dropList.Visible = false

    for i, option in ipairs(options) do
        local optionButton = createButton("Option" .. i, dropList, UDim2.new(0, 0, (i - 1), size.Y.Offset), UDim2.new(1, 0, 1, 0), option, font, textSize, textColor, color)
        optionButton.MouseButton1Click:Connect(function()
            dropButton.Text = option
            dropList.Visible = false
        end)
    end

    dropButton.MouseButton1Click:Connect(function()
        dropList.Visible = not dropList.Visible
    end)

    return dropdown
end

local function createCheckBox(name, parent, position, size, text, font, textSize, textColor, boxColor)
    local checkBox = Instance.new("Frame")
    checkBox.Name = name
    checkBox.Parent = parent
    checkBox.Position = position
    checkBox.Size = size

    local box = createFrame("Box", checkBox, UDim2.new(0, 0, 0, 0), UDim2.new(0.3, 0, 1, 0), boxColor)
    local label = createTextLabel("Label", checkBox, UDim2.new(0.4, 0, 0, 0), UDim2.new(0.6, 0, 1, 0), text, font, textSize, textColor)

    local isChecked = false
    box.MouseButton1Click:Connect(function()
        isChecked = not isChecked
        box.BackgroundColor3 = isChecked and boxColor or Color3.new(1, 1, 1)
    end)

    return checkBox
end

local function createTrackBar(name, parent, position, size, min, max, initial, color)
    local trackBar = Instance.new("Frame")
    trackBar.Name = name
    trackBar.Parent = parent
    trackBar.Position = position
    trackBar.Size = size
    trackBar.BackgroundColor3 = Color3.new(0.8, 0.8, 0.8)

    local handle = createFrame("Handle", trackBar, UDim2.new((initial - min) / (max - min), 0, 0, 0), UDim2.new(0.1, 0, 1, 0), color)

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
            local barPos = trackBar.AbsolutePosition.X
            local barSize = trackBar.AbsoluteSize.X
            local newX = math.clamp(mousePos - barPos, 0, barSize - handle.Size.X.Offset)
            handle.Position = UDim2.new(0, newX, 0, 0)
        end
    end)

    return trackBar
end

local function createLoadingBar(name, parent, position, size, color)
    local loadingBar = Instance.new("Frame")
    loadingBar.Name = name
    loadingBar.Parent = parent
    loadingBar.Position = position
    loadingBar.Size = size
    loadingBar.BackgroundColor3 = Color3.new(0.8, 0.8, 0.8)

    local fill = createFrame("Fill", loadingBar, UDim2.new(0, 0, 0, 0), UDim2.new(0, 0, 1, 0), color)

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

    return loadingBar
end

-- UI Library functions
function UI.new(name)
    local self = setmetatable({}, UI)
    self.ScreenGui = Instance.new("ScreenGui", game.Players.LocalPlayer:WaitForChild("PlayerGui"))
    self.ScreenGui.Name = name
    self.MainFrame = createFrame("MainFrame", self.ScreenGui, UDim2.new(0.3, 0, 0.3, 0), UDim2.new(0.4, 0, 0.4, 0), Color3.new(0.2, 0.2, 0.2))
    return self
end

function UI:addTab(name)
    local tab = createButton(name .. "Tab", self.MainFrame, UDim2.new(#self.MainFrame:GetChildren() / 4, 0, 0, 0), UDim2.new(0.25, 0, 0.1, 0), name, Enum.Font.SourceSans, 20, Color3.new(1, 1, 1), Color3.new(0.3, 0.3, 0.3))
    return tab
end

function UI:addButton(name, tab, text, onClick)
    local button = createButton(name, tab, UDim2.new(0, 0, #tab:GetChildren() / 10, 0), UDim2.new(1, 0, 0.1, 0), text, Enum.Font.SourceSans, 20, Color3.new(1, 1, 1), Color3.new(0.4, 0.4, 0.4))
    button.MouseButton1Click:Connect(onClick)
    return button
end

function UI:addDropdown(name, tab, options)
    local dropdown = createDropdown(name, tab, UDim2.new(0, 0, #tab:GetChildren() / 10, 0), UDim2.new(1, 0, 0.1, 0), options, Enum.Font.SourceSans, 20, Color3.new(1, 1, 1), Color3.new(0.4, 0.4, 0.4))
    return dropdown
end

function UI:addCheckBox(name, tab, text)
    local checkBox = createCheckBox(name, tab, UDim2.new(0, 0, #tab:GetChildren() / 10, 0), UDim2.new(1, 0, 0.1, 0), text, Enum.Font.SourceSans, 20, Color3.new(1, 1, 1), Color3.new(0.4, 0.4, 0.4))
    return checkBox
end

function UI:addTrackBar(name, tab, min, max, initial)
    local trackBar = createTrackBar(name, tab, UDim2.new(0, 0, #tab:GetChildren() / 10, 0), UDim2.new(1, 0, 0.1, 0), min, max, initial, Color3.new(0.4, 0.4, 0.4))
    return trackBar
end

function UI:addLoadingBar(name, tab)
    local loadingBar = createLoadingBar(name, tab, UDim2.new(0, 0, #tab:GetChildren() / 10, 0), UDim2.new(1, 0, 0.1, 0), Color3.new(0.4, 0.4, 0.4))
    return loadingBar
end
