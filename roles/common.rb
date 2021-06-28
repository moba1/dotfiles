packages = [
  "fish",
  "tmux",
  "vim",
  "bat",
  "exa",
  "fd",
]
for pack in packages do
  include_recipe File.join("..", "cookbooks", pack, "default")
end
