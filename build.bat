@echo off
set SCRIPT_DIR=%~dp0
set MSBUILD_PATH=C:\Windows\Microsoft.NET\Framework\v4.0.30319\
set /p VERSION=<VERSION.txt
set COMMON_INFO=%SCRIPT_DIR%\src\CommonAssemblyInfo.cs

echo using System.Reflection; > %COMMON_INFO%
echo using System.Runtime.InteropServices; >> %COMMON_INFO%
echo [assembly: AssemblyVersion("%VERSION%")] >> %COMMON_INFO%

%MSBUILD_PATH%\msbuild.exe /p:Configuration=Release src\ServiceRunner.sln
mkdir %SCRIPT_DIR%\build
copy %SCRIPT_DIR%\src\ServiceRunner\bin\Release\ServiceRunner.exe build\
