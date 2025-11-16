local wezterm = require 'wezterm'

local config = {}

-- Broadcast a shell command to ALL panes in the CURRENT window
local function send_to_all_panes(window, pane, cmd)
  local mux_win = wezterm.mux.get_window(window:window_id())
  for _, tab in ipairs(mux_win:tabs()) do
    for _, p in ipairs(tab:panes()) do
      p:send_text(cmd .. "\n")
    end
  end
end

-- Appearance
config.window_background_opacity = 1.0
config.text_background_opacity = 1.0

-- Persistence
config.unix_domains = {
  { name = "unix" },
}

config.default_gui_startup_args = { "connect", "unix" }


-- Leader key
config.leader = {
  key = "`",
  mods = "",
  timeout_milliseconds = 1000
}

-- Key bindings
config.keys = {
  -- Workspace: create new
  {
    key = "C",
    mods = "LEADER|SHIFT",
    action = wezterm.action.PromptInputLine {
      description = "New workspace name",
      action = wezterm.action_callback(function(window, pane, line)
        if line and #line > 0 then
          window:perform_action(wezterm.action.SwitchToWorkspace {
            name = line
          }, pane)
        end
      end)
    }
  },

  -- Workspace: switch
  {
    key = "W",
    mods = "LEADER|SHIFT",
    action = wezterm.action.ShowLauncherArgs {
      flags = "WORKSPACES"
    }
  },

  -- Pane splitting
  {
    key = "v",
    mods = "LEADER",
    action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" })
  },
  {
    key = "s",
    mods = "LEADER",
    action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" })
  },

  -- Pane navigation (vim-style)
  {
    key = "h",
    mods = "LEADER",
    action = wezterm.action.ActivatePaneDirection("Left")
  },
  {
    key = "j",
    mods = "LEADER",
    action = wezterm.action.ActivatePaneDirection("Down")
  },
  {
    key = "k",
    mods = "LEADER",
    action = wezterm.action.ActivatePaneDirection("Up")
  },
  {
    key = "l",
    mods = "LEADER",
    action = wezterm.action.ActivatePaneDirection("Right")
  },

  -- Window switching
  {
    key = "LeftArrow",
    mods = "SHIFT",
    action = wezterm.action.ActivateTabRelative(-1)
  },
  {
    key = "RightArrow",
    mods = "SHIFT",
    action = wezterm.action.ActivateTabRelative(1)
  },

  -- Pane resizing via shift
  {
    key = "H",
    mods = "SHIFT|LEADER",
    action = wezterm.action.AdjustPaneSize({ "Left", 5 })
  },
  {
    key = "J",
    mods = "SHIFT|LEADER",
    action = wezterm.action.AdjustPaneSize({ "Down", 5 })
  },
  {
    key = "K",
    mods = "SHIFT|LEADER",
    action = wezterm.action.AdjustPaneSize({ "Up", 5 })
  },
  {
    key = "L",
    mods = "SHIFT|LEADER",
    action = wezterm.action.AdjustPaneSize({ "Right", 5 })
  },

  -- Pane resizing via Alt
  {
    key = "h",
    mods = "ALT",
    action = wezterm.action.AdjustPaneSize({ "Left", 1 })
  },
  {
    key = "j",
    mods = "ALT",
    action = wezterm.action.AdjustPaneSize({ "Down", 1 })
  },
  {
    key = "k",
    mods = "ALT",
    action = wezterm.action.AdjustPaneSize({ "Up", 1 })
  },
  {
    key = "l",
    mods = "ALT",
    action = wezterm.action.AdjustPaneSize({ "Right", 1 })
  },

  -- Pane switching via Alt+arrows
  {
    key = "LeftArrow",
    mods = "ALT",
    action = wezterm.action.ActivatePaneDirection("Left")
  },
  {
    key = "RightArrow",
    mods = "ALT",
    action = wezterm.action.ActivatePaneDirection("Right")
  },
  {
    key = "UpArrow",
    mods = "ALT",
    action = wezterm.action.ActivatePaneDirection("Up")
  },
  {
    key = "DownArrow",
    mods = "ALT",
    action = wezterm.action.ActivatePaneDirection("Down")
  },

  -- Create new window (tab)
  {
    key = "c",
    mods = "LEADER",
    action = wezterm.action.SpawnTab("CurrentPaneDomain")
  },

  -- Reload configuration
  {
    key = "r",
    mods = "LEADER",
    action = wezterm.action.ReloadConfiguration
  },

  -- Alt+number for tab switching
  {
    key = "1",
    mods = "ALT",
    action = wezterm.action.ActivateTab(0)
  },
  {
    key = "2",
    mods = "ALT",
    action = wezterm.action.ActivateTab(1)
  },
  {
    key = "3",
    mods = "ALT",
    action = wezterm.action.ActivateTab(2)
  },
  {
    key = "4",
    mods = "ALT",
    action = wezterm.action.ActivateTab(3)
  },
  {
    key = "5",
    mods = "ALT",
    action = wezterm.action.ActivateTab(4)
  },
  {
    key = "6",
    mods = "ALT",
    action = wezterm.action.ActivateTab(5)
  },
  {
    key = "7",
    mods = "ALT",
    action = wezterm.action.ActivateTab(6)
  },
  {
    key = "8",
    mods = "ALT",
    action = wezterm.action.ActivateTab(7)
  },
  {
    key = "9",
    mods = "ALT",
    action = wezterm.action.ActivateTab(8)
  },

  -- Send commands to all wezterm panes
  {
    key = "A",
    mods = "CTRL|SHIFT",
    action = wezterm.action.PromptInputLine({
      description = "Send shell command to all panes:",
      action = wezterm.action_callback(function(window, pane, line)
        if line and #line > 0 then
          send_to_all_panes(window, pane, line)
        end
      end),
    }),
  },
  {
    key = "R",
    mods = "CTRL|SHIFT",
    action = wezterm.action_callback(function(window, pane)
      send_to_all_panes(window, pane, "source ~/.zshrc")
    end),
  },

}

return config
