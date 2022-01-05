@echo off
:path=D:\TOOLS\Z80asm
path=..\zmac\
cls
for %%v in (*.asm) do zmac.exe --zmac --oo hex,lst --od .\ -j -i -n -z -c  %%v
:for %%v in (*.out) do del %%v
:for %%v in (*.bin) do del %%v
