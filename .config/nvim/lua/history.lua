-- [nfnl] fnl/history.fnl
local pick = require("mini.pick")
local state = {grep = {history = {}, idx = 0}, files = {history = {}, idx = 0}}
local current = nil
local function hist_prev()
  local s = state[current]
  if (#s.history > 0) then
    s.idx = math.min((s.idx + 1), #s.history)
    return pick.set_picker_query(vim.split(s.history[s.idx], ""))
  else
    return nil
  end
end
local function hist_next()
  local s = state[current]
  if (s.idx > 1) then
    s.idx = (s.idx - 1)
    return pick.set_picker_query(vim.split(s.history[s.idx], ""))
  else
    return nil
  end
end
local function open_picker(name, builtin_fn)
  current = name
  state[name]["idx"] = 0
  return builtin_fn({}, {mappings = {hist_prev = {char = "<C-p>", func = hist_prev}, hist_next = {char = "<C-n>", func = hist_next}}})
end
local function setup()
  local function _3_()
    local q = pick.get_picker_query()
    if (current and q) then
      local s = table.concat(q, "")
      if (s ~= "") then
        return table.insert(state[current].history, 1, s)
      else
        return nil
      end
    else
      return nil
    end
  end
  vim.api.nvim_create_autocmd("User", {pattern = "MiniPickStop", callback = _3_})
  local function _6_()
    return open_picker("grep", pick.builtin.grep_live)
  end
  vim.api.nvim_create_user_command("PickGrepLive", _6_, {})
  local function _7_()
    return open_picker("files", pick.builtin.files)
  end
  return vim.api.nvim_create_user_command("PickFiles", _7_, {})
end
return {setup = setup}
