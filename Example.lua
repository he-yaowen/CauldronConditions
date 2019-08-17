-- This recipe will be enabled only if your character is shadow priest.
Cauldron.recipes["conditions-example"] = {
    enable = true,
    conditions = {
        classes = { "Priest" },
        talents = { "Shadow" },
    },
}
