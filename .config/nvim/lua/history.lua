-- [nfnl] fnl/history.fnl
local pick = require("mini.pick")
local history = {}
local idx = 0
local function history_prev()
  if (#history > 0) then
    idx = math.min((idx + 1), #history)
    return pick.set_picker_query(vim.split(history[idx], ""))
  else
    return nil
  end
end
local function history_next()
  if (idx > 1) then
    idx = (idx - 1)
    return pick.set_picker_query(vim.split(history[idx], ""))
  else
    return nil
  end
end
local function save_current()
  local q = table.concat(pick.get_picker_query(), "")
  if (q ~= "") then
    return table.insert(history, 1, q)
  else
    return nil
  end
end
local function grep_live()
  idx = 0
  return pick.builtin.grep_live({}, {mappings = {hist_prev = {char = "<C-p>", func = history_prev}, hist_next = {char = "<C-n>", func = history_next}}})
end
local function setup()
  local function _4_()
    local q = pick.get_picker_query()
    if q then
      local s = table.concat(q, "")
      if (s ~= "") then
        return table.insert(history, 1, s)
      else
        return nil
      end
    else
      return nil
    end
  end
  vim.api.nvim_create_autocmd("User", {pattern = "MiniPickStop", callback = _4_})
  return vim.api.nvim_create_user_command("PickGrepLive", grep_live, {})
end
return {setup = setup, ["grep-live"] = grep_live, history = history, ["save-current"] = save_current}
