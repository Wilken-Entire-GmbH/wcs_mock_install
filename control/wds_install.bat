@echo off
setlocal

set START_DIR=%~dp0
set path=%START_DIR%;%path%

set BIN_DIR=%START_DIR%..\app\p5dms
set path=%BIN_DIR%;%path%

rem get absolute path of bin directory
pushd "%BIN_DIR%"
set BIN_DIR=%cd%
popd

set WORKING_DIR=%START_DIR%..

rem get absolute path of working directory
pushd "%WORKING_DIR%"
set WORKING_DIR=%cd%
popd

set WDS_CONFIG_DIR=%WORKING_DIR%\config\p5dms
echo %WDS_CONFIG_DIR%

set WORKING_DIR=%WORKING_DIR%\runtime

set LOG_DIR=%WORKING_DIR%\logs

if "%1%"=="" (
    echo "usage: %0% <tenantid>"
    goto :end 
)

set TENANT=%1%
set TENANTCONFIG=%WDS_CONFIG_DIR%\tenants\%TENANT%.yaml

if not exist %TENANTCONFIG% (
    echo %TENANT% is not a tenant. No configuration available: %TENANTCONFIG%
    goto :end 
)

(set LF=^

)

set WCS3MOCK=p5dmsWCS3Mock_%TENANT%

rem wds_mail setup
nssm install %WCS3MOCK% "%BIN_DIR%\wds_contentservice_mock.exe" 
nssm set %WCS3MOCK% AppDirectory "%WORKING_DIR%"
nssm set %WCS3MOCK% DisplayName "Wilken P/5 DMS WCS3 Mock for %TENANT%"
nssm set %WCS3MOCK% Description "Wilken P/5 DMS WCS3 Mock for %TENANT%"
nssm set %WCS3MOCK% Start SERVICE_DELAYED_AUTO_START
nssm set %WCS3MOCK% AppStdout "%LOG_DIR%\%TENANT%_mock.log"
nssm set %WCS3MOCK% AppStderr "%LOG_DIR%\%TENANT%_mock.log"
nssm set %WCS3MOCK% AppEnvironmentExtra WDS_CONFIG_DIR=%WDS_CONFIG_DIR%^%LF%%LF%WDS_TENANT_CONFIG=%TENANT%^%LF%%LF%WDS_RUNTIME_DIR=%WORKING_DIR%\p5dms\%TENANT%

:end
endlocal
