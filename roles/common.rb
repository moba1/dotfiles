packages = [
  "fish",
  "tmux",
  "vim",
  "bat",
  "exa",
]
for pack in packages do
  include_recipe File.join("..", "cookbooks", pack, "default")
end
