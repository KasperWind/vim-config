local status_ok, lua_snip = pcall(require, "luasnip")
if not status_ok then
  print("lua snip not found")
  return
end

local status_ok_loader, loaders = pcall(require, "luasnip.loaders.from_snipmate")
if not status_ok_loader then
  print("lua snip loaders not found")
  return
end

loaders.load({ })
