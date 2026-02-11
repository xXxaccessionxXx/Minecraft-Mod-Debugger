@echo off
setlocal EnableDelayedExpansion
cls

:: ========================================================
::      MINECRAFT MOD DEBUGGER - GITHUB SYNC v3.1
:: ========================================================
echo.

:: Check if we are in the correct folder (looking for build.gradle)
if not exist "..\build.gradle" (
    if not exist "build.gradle" (
        echo [WARNING] 'build.gradle' not found.
        echo Please ensure this script is in the PROJECT ROOT folder, not in 'src'.
        echo.
    )
)

:: --------------------------------------------------------
:: STEP 1: CONFIRMATION
:: --------------------------------------------------------
:Step1
echo [STEP 1/3] READY TO PUSH?
choice /C YN /M "Do you want to push the latest changes to GitHub?"

:: STRICT FLOW CONTROL
if %errorlevel% equ 2 goto Cancelled
if %errorlevel% equ 1 goto Step2

:Cancelled
echo.
echo [INFO] Push cancelled. 
echo "The heart of man plans his way, but the Lord establishes his steps." (Prov 16:9)
echo.
exit /b

:: --------------------------------------------------------
:: STEP 2: VERSION CONTROL
:: --------------------------------------------------------
:Step2
echo.
echo [STEP 2/3] VERSIONING
echo Enter the version number (e.g. v0.1.0).
set /p version="Version Number: "

if "%version%"=="" (
    set version=v0.0.x
    echo [INFO] No version given. Defaulting to v0.0.x
)

:: --------------------------------------------------------
:: STEP 3: COMMIT MESSAGE & VERSE POOL
:: --------------------------------------------------------
:Step3
echo.
echo [STEP 3/3] COMMIT DETAILS
echo Enter additional notes (Leave BLANK for a random verse).
set /p user_notes="Notes: "

if "%user_notes%"=="" (
    call :PickRandomVerse
) else (
    set final_msg=%user_notes%
)

:: --------------------------------------------------------
:: EXECUTION PHASE
:: --------------------------------------------------------
echo.
echo ========================================================
echo Pushing Version: [%version%]
echo Message: "!final_msg!"
echo ========================================================
echo.

echo [Git] Adding files...
git add .

echo [Git] Committing...
git commit -m "[%version%] !final_msg!"

echo [Git] Pushing to origin/main...
git push origin main

if %errorlevel% equ 0 (
    echo.
    echo [SUCCESS] Repo is up to date.
    echo "Commit your work to the Lord, and your plans will be established." (Prov 16:3)
) else (
    echo.
    echo [ERROR] Push failed. Check your internet or git status.
)

echo.
pause
exit /b

:: ========================================================
:: LOGIC: RANDOM VERSE GENERATOR
:: ========================================================
:PickRandomVerse
set verse[0]=For God is not a God of confusion but of peace. (1 Cor 14:33)
set verse[1]=Everything should be done in a fitting and orderly way. (1 Cor 14:40)
set verse[2]=Whatever you do, work at it with all your heart. (Col 3:23)
set verse[3]=For every house is built by someone, but God is the builder of everything. (Heb 3:4)
set verse[4]=I can do all things through Christ who strengthens me. (Phil 4:13)
set verse[5]=Let all that you do be done in love. (1 Cor 16:14)
set verse[6]=Iron sharpens iron, and one man sharpens another. (Prov 27:17)
set verse[7]=But test everything; hold fast what is good. (1 Thess 5:21)
set verse[8]=In the beginning was the Word, and the Word was with God. (John 1:1)
set verse[9]=Commit your way to the Lord; trust in him, and he will act. (Ps 37:5)

set /a idx=%random% %% 10
set final_msg=!verse[%idx%]!
echo [INFO] No notes provided. Selected Verse:
echo "!final_msg!"
exit /b