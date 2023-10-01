mads.exe -t -l %1.asm 
copy %1.obx .\dysk\autorun
dir2atr -m -E -B xbootdos.obx %1.atr dysk

