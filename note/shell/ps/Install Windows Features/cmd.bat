ECHO OFF

CLS

TITLE AUTOMATE INSTALL TOOL

@powershell -NoProfile -ExecutionPolicy unrestricted -Command .\DownloadAndInstall_Fx46.ps1

PAUSE

ECHO ON