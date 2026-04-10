| # | what | why | fix |
| - | ---- | --- | --- |
| 1 | used `elseif` instead of `else if` | c/c++ does not support `elseif` keyword | replace `elseif` with `else if` |
| 2 | missing newline in printf output | output appears on same line making it messy | add `\n` at end of each printf statement |