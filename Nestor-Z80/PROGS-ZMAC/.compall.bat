@echo off
path=D:\TOOLS\Z80asm
cls
:for %%v in (*.asm) do zmac.exe --zmac --oo hex,lst,cim --od .\ -j %%v
for %%v in (*.asm) do zmac.exe --zmac --oo hex,lst --od .\ -j -i -n -z %%v
:for %%v in (*.out) do del %%v
:for %%v in (*.bin) do del %%v
