-- Config
local mash = {
  split   = {"ctrl", "alt", "cmd"},
  corner  = {"ctrl", "alt", "shift"},
  focus   = {"ctrl", "alt"},
  utils   = {"fn", "ctrl", "alt"}
}

hs.hotkey.bind({"cmd", "shift", "ctrl"}, "Up", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y
  f.w = max.w
  f.h = max.h
  win:setFrame(f, 0)
end)

hs.hotkey.bind({"cmd", "shift", "ctrl"}, "Down", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x + max.w * 0.05
  f.y = max.y + max.h * 0.05
  f.w = max.w * 0.9
  f.h = max.h * 0.9
  win:setFrame(f, 0)
end)

hs.hotkey.bind({"cmd", "shift", "ctrl"}, "Left", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y
  f.w = max.w / 2
  f.h = max.h
  win:setFrame(f, 0)
end)

hs.hotkey.bind({"cmd", "shift", "ctrl"}, "Right", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x + max.w / 2
  f.y = max.y
  f.w = max.w / 2
  f.h = max.h
  win:setFrame(f, 0)
end)


-- Bind ctrl+[ to escape
hs.hotkey.bind({"ctrl"}, "[", function()
  hs.eventtap.keyStroke({}, "ESCAPE")
end)

-- Focus iTerm2 when hitting tmux keycombo ctrl+a
-- ctrlPlusAActivatesIterm = hs.hotkey.new({"ctrl"}, "A", function()
--   hs.application.launchOrFocus("iTerm")
--   ctrlPlusAActivatesIterm:disable() -- does not work without this, even though it should
--   hs.eventtap.keyStroke({"ctrl"}, "A")
-- end)
-- hs.window.filter.new("iTerm2")
--   :subscribe(hs.window.filter.windowFocused,function() ctrlPlusAActivatesIterm:disable() end)
--   :subscribe(hs.window.filter.windowUnfocused,function() ctrlPlusAActivatesIterm:enable() end)

-- Focus iTerm2 when hitting tmux keycombo ctrl+a
cmdReturnIsDownReturn = hs.hotkey.new({"cmd"}, "return", function()
  hs.eventtap.keyStroke({}, "down")
  hs.eventtap.keyStroke({}, "return")
end)
hs.window.filter.new("Todoist")
  :subscribe(hs.window.filter.windowFocused,function() cmdReturnIsDownReturn:enable() end)
  :subscribe(hs.window.filter.windowUnfocused,function() cmdReturnIsDownReturn:disable() end)


-- Config reloading, diff'rent strokes
hs.hotkey.bind({"ctrl", "alt", "cmd"}, "R", function()
    hs.reload()
end)
hs.alert.show("Config loaded")

-- Defeating paste blocking with cmd+alt+ctrl+v
hs.hotkey.bind({"ctrl", "alt", "cmd"}, "V", function() hs.eventtap.keyStrokes(hs.pasteboard.getContents()) end)
