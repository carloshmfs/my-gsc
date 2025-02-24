@echo off
echo [104mEE GSC Timer compilation[0m

gsc-tool.exe --mode comp --game t6 --system pc ".\zombie-hp.gsc"

IF %ErrorLevel% equ 0 (
    COPY ".\compiled\t6\zombie-hp.gsc" "%LocalAppData%\Plutonium\storage\t6\scripts\zm\"
)
