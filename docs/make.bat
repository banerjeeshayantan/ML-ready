@ECHO OFF
set SPHINXBUILD=sphinx-build
set SOURCEDIR=.
set BUILDDIR=_build

IF "%1" == "" GOTO help
%SPHINXBUILD% -M %1 %SOURCEDIR% %BUILDDIR%
GOTO end

:help
ECHO.Usage: make.bat [html^|clean]

:end
