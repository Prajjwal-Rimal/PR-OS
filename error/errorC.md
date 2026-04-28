# C Error Log

|#| what | why | fix |
| - | ---- | --- | --- |
| 1 | used `const char *tagline[] = "..."` | this declares an array of pointers, but you assigned a single string | use `const char *tagline = "..."` |
| 2 | used `start_col_tagline << 8` for color | column value is not a color, so VGA showed wrong colors | use `tagline_vga_color_scheme << 8` |
| 3 | wrote logo text without quotes | C treats unquoted text as variables, causing syntax errors | wrap each line in quotes `"..."` |
| 4 | missing function declaration for `terminal_clear` | compiler saw function call before its definition | add prototype `void terminal_clear();` or move function above |
| 5 | misunderstanding VGA write | writing only character without proper 16-bit format breaks display | combine char + color using `char \| (color << 8)`|
