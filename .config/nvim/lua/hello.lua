-- [nfnl] fnl/hello.fnl
local function hello()
  return print("Hello World Fennel!")
end
local function setup()
  return vim.api.nvim_create_user_command("HelloFennel", hello, {})
end
return {setup = setup}
