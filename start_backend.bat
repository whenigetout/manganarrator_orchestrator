@echo off
title manganarrator_orchestrator - Django Backend Launcher

REM === Activate Conda env and run Django backend ===
call conda activate mn_orch
python manage.py runserver 9000