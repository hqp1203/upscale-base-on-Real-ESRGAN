@echo off
:loop
rem ��ȡ�ű�����Ŀ¼��·��
set "script_dir=%~dp0"

rem Ҫ���õĳ��ֳ�������
set "program_name=realesrgan-ncnn-vulkan.exe"

rem ƴ�ӳ��ֳ��������·��
set "program_path=%script_dir%%program_name%"

rem ��ӡ�˵������û�ѡ�񳬷�ģ��
echo ��ѡ�񳬷�ģ�ͣ�
echo 1. realesrgan-x4plus (default)
echo 2. realesrnet-x4plus
echo 3. realesrgan-x4plus-anime (optimized for anime images, small model size)
echo 4. realesr-animevideov3 (animation video)
set /p model=����ģ�ͱ��:


rem ����û������ģ�ͱ���Ƿ�Ϸ�
if not "%model%"=="1" if not "%model%"=="2" if not "%model%"=="3" if not "%model%"=="4" (
    echo �����ģ�ͱ�Ų��Ϸ���
    pause
    exit /b 1
)


rem ���û�����Ҫ���ֵ��ļ�·��
set /p filepath=����Ҫ���ֵ��ļ�·��:

rem ��ȡ������չ����ԭ�ļ���
for %%F in ("%filepath%") do set "filename=%%~nF"

rem ����ļ��Ƿ����
if not exist "%filepath%" (
    echo �ļ������ڣ�
    pause
    exit /b 1
)

rem ���û����볬����ɺ������ļ��ĺ�׺
set /p ext=���볬�ֺ���ļ�����(jpg/png/webp, default=png):

rem ��ȡ file_path ��Ŀ¼����
for %%i in ("%filepath%") do set "file_dir=%%~dpi"

rem ƴ�ӳ��ֺ���ļ���
set "output_filename=%filename%_clear.%ext%"

rem ƴ��Ŀ¼���ļ���
set "output_path=%file_dir%%output_filename%"

echo %output_path%



rem �����û�ѡ���ģ�ͽ��г���
if "%model%"=="1" (
    echo ����ʹ�ó���ģ��1...
    rem ���賬������Ϊ upscale1.exe
    "%program_path%" -i "%filepath%" -o "%output_path%" -n realesrgan-x4plus
) else if "%model%"=="2" (
    echo ����ʹ�ó���ģ��2...
    rem ���賬������Ϊ upscale2.exe
   "%program_path%" -i "%filepath%" -o "%output_path%" -n realesrnet-x4plus
) else if "%model%"=="3" (
    echo ����ʹ�ó���ģ��3...
    rem ���賬������Ϊ upscale3.exe
   "%program_path%" -i "%filepath%" -o "%output_path%" -n realesrgan-x4plus-anime
) else if "%model%"=="4" (
    echo ����ʹ�ó���ģ��4...
    rem ���賬������Ϊ upscale4.exe
    "%program_path%" -i "%filepath%" -o "%output_path%"-n realesr-animevideov3
)


rem �жϳ����Ƿ�ɹ�
if not exist "%output_path%" (
    echo ����ʧ�ܣ�
    pause
    exit /b 1
)

echo ������ɣ����ɵ��ļ���Ϊ "%output_path%"
pause
goto loop
