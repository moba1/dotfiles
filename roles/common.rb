packages = [
  "fish",
  "tmux",
  "vim",
]
for pack in packages do
  include_recipe File.join("..", "cookbooks", pack, "default")
end
