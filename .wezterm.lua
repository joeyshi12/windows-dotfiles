local wezterm = require 'wezterm'
local act = wezterm.action
local config = wezterm.config_builder()

-- ---------------------------------------------------------------------------
-- User settings (edit these)
-- ---------------------------------------------------------------------------
-- Default shell for new windows and Ctrl+Shift+T
local DEFAULT_SHELL = 'nu.exe'

-- Use 'pwsh.exe' for PowerShell 7+, or 'powershell.exe' for Windows PowerShell 5.1
local POWERSHELL = 'pwsh.exe'

-- ---------------------------------------------------------------------------
-- Shell & domains
-- ---------------------------------------------------------------------------
config.default_prog = { DEFAULT_SHELL }

-- Registers WSL domains named "WSL:<distro>" for every installed distro
config.wsl_domains = wezterm.default_wsl_domains()

config.launch_menu = {
  { label = 'Nushell', args = { 'nu.exe' } },
  { label = 'PowerShell', args = { POWERSHELL, '-NoLogo' } },
  { label = 'WSL (default distro)', args = { 'wsl.exe', '--cd', '~' } },
  { label = 'Windows PowerShell 5.1', args = { 'powershell.exe', '-NoLogo' } },
  { label = 'Command Prompt', args = { 'cmd.exe' } },
}

-- ---------------------------------------------------------------------------
-- Appearance
-- ---------------------------------------------------------------------------
config.color_scheme = 'Catppuccin Mocha'

config.font = wezterm.font_with_fallback {
  'JetBrains Mono',
  'Cascadia Code',
  'Consolas',
}
config.font_size = 11.0

config.window_background_opacity = 1.0
config.window_decorations = 'TITLE | RESIZE'
config.window_padding = { left = 8, right = 8, top = 8, bottom = 8 }
config.initial_cols = 130
config.initial_rows = 36

config.default_cursor_style = 'BlinkingBar'
config.cursor_blink_rate = 600
config.scrollback_lines = 20000
config.audible_bell = 'Disabled'

-- Dim inactive panes slightly
config.inactive_pane_hsb = { saturation = 0.9, brightness = 0.7 }

-- ---------------------------------------------------------------------------
-- Tab bar (Catppuccin Mocha palette)
-- ---------------------------------------------------------------------------
local mocha = {
  crust = '#11111b',
  mantle = '#181825',
  base = '#1e1e2e',
  surface0 = '#313244',
  surface1 = '#45475a',
  text = '#cdd6f4',
  subtext0 = '#a6adc8',
  mauve = '#cba6f7',
}

-- Fancy tab bar gives proper Windows-style window buttons and rounded tabs
config.use_fancy_tab_bar = true
config.tab_bar_at_bottom = false
config.hide_tab_bar_if_only_one_tab = false
config.tab_max_width = 24

-- Title bar / window buttons
config.window_frame = {
  font = wezterm.font { family = 'JetBrains Mono', weight = 'Medium' },
  font_size = 10.0,
  active_titlebar_bg = mocha.mantle,
  inactive_titlebar_bg = mocha.mantle,
  button_fg = mocha.subtext0,
  button_bg = mocha.mantle,
  button_hover_fg = mocha.text,
  button_hover_bg = mocha.surface0,
}

config.colors = {
  tab_bar = {
    background = mocha.mantle,
    active_tab = { bg_color = mocha.base, fg_color = mocha.mauve, intensity = 'Bold' },
    inactive_tab = { bg_color = mocha.mantle, fg_color = mocha.subtext0 },
    inactive_tab_hover = { bg_color = mocha.surface0, fg_color = mocha.text },
    new_tab = { bg_color = mocha.mantle, fg_color = mocha.subtext0 },
    new_tab_hover = { bg_color = mocha.surface0, fg_color = mocha.text },
  },
}

-- Cleaner tab titles: "pwsh" / "Arch" instead of "pwsh in joey"
wezterm.on('format-tab-title', function(tab)
  local pane = tab.active_pane
  local title = tab.tab_title

  if not title or #title == 0 then
    if pane.domain_name and pane.domain_name:find('^WSL:') then
      title = pane.domain_name:gsub('^WSL:', '') .. ' (WSL)'
    else
      local proc = pane.foreground_process_name or ''
      proc = proc:gsub('.*[/\\]', ''):gsub('%.exe$', '')
      title = (proc ~= '' and proc) or pane.title
    end
  end

  return string.format('  %s  ', title)
end)

-- ---------------------------------------------------------------------------
-- Key bindings
-- ---------------------------------------------------------------------------
config.keys = {
  -- New tab in the default shell (Nushell)
  {
    key = 'T',
    mods = 'CTRL|SHIFT',
    action = act.SpawnTab 'DefaultDomain',
  },
  -- New tab in PowerShell
  {
    key = 'P',
    mods = 'CTRL|SHIFT',
    action = act.SpawnCommandInNewTab { args = { POWERSHELL, '-NoLogo' } },
  },
  -- Toggle fullscreen
  { key = 'F11', action = act.ToggleFullScreen },
  -- Launcher menu: pick any shell / WSL distro
  {
    key = 'L',
    mods = 'CTRL|SHIFT',
    action = act.ShowLauncherArgs { flags = 'FUZZY|TABS|LAUNCH_MENU_ITEMS|DOMAINS' },
  },

  -- Splits
  { key = '|', mods = 'CTRL|SHIFT', action = act.SplitHorizontal { domain = 'CurrentPaneDomain' } },
  { key = '_', mods = 'CTRL|SHIFT', action = act.SplitVertical { domain = 'CurrentPaneDomain' } },

  -- Pane navigation
  { key = 'LeftArrow',  mods = 'ALT', action = act.ActivatePaneDirection 'Left' },
  { key = 'RightArrow', mods = 'ALT', action = act.ActivatePaneDirection 'Right' },
  { key = 'UpArrow',    mods = 'ALT', action = act.ActivatePaneDirection 'Up' },
  { key = 'DownArrow',  mods = 'ALT', action = act.ActivatePaneDirection 'Down' },

  -- Close pane without the confirmation prompt
  { key = 'W', mods = 'CTRL|SHIFT', action = act.CloseCurrentPane { confirm = false } },

  -- Tab navigation
  { key = 'Tab', mods = 'CTRL', action = act.ActivateTabRelative(1) },
  { key = 'Tab', mods = 'CTRL|SHIFT', action = act.ActivateTabRelative(-1) },

  -- Font size
  { key = '=', mods = 'CTRL', action = act.IncreaseFontSize },
  { key = '-', mods = 'CTRL', action = act.DecreaseFontSize },
  { key = '0', mods = 'CTRL', action = act.ResetFontSize },
}

-- Jump to tab N with ALT+1..9
for i = 1, 9 do
  table.insert(config.keys, {
    key = tostring(i),
    mods = 'ALT',
    action = act.ActivateTab(i - 1),
  })
end

return config
