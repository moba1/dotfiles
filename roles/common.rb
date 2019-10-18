packages = [
  "rcs",
  "rust",
  "fish",
  "tmux",
  "vim",
  "neomutt",
  "git"
]
for pack in packages do
  include_recipe File.join("..", "cookbooks", pack, "default")
end

