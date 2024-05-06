@echo off
:loop
rem 获取脚本所在目录的路径
set "script_dir=%~dp0"

rem 要调用的超分程序名称
set "program_name=realesrgan-ncnn-vulkan.exe"

rem 拼接超分程序的完整路径
set "program_path=%script_dir%%program_name%"

rem 打印菜单，让用户选择超分模型
echo 请选择超分模型：
echo 1. realesrgan-x4plus (default)
echo 2. realesrnet-x4plus
echo 3. realesrgan-x4plus-anime (optimized for anime images, small model size)
echo 4. realesr-animevideov3 (animation video)
set /p model=输入模型编号:


rem 检查用户输入的模型编号是否合法
if not "%model%"=="1" if not "%model%"=="2" if not "%model%"=="3" if not "%model%"=="4" (
    echo 输入的模型编号不合法！
    pause
    exit /b 1
)


rem 让用户输入要超分的文件路径
set /p filepath=输入要超分的文件路径:

rem 获取不带扩展名的原文件名
for %%F in ("%filepath%") do set "filename=%%~nF"

rem 检查文件是否存在
if not exist "%filepath%" (
    echo 文件不存在！
    pause
    exit /b 1
)

rem 让用户输入超分完成后生成文件的后缀
set /p ext=输入超分后的文件类型(jpg/png/webp, default=png):

rem 获取 file_path 的目录部分
for %%i in ("%filepath%") do set "file_dir=%%~dpi"

rem 拼接超分后的文件名
set "output_filename=%filename%_clear.%ext%"

rem 拼接目录和文件名
set "output_path=%file_dir%%output_filename%"

echo %output_path%



rem 根据用户选择的模型进行超分
if "%model%"=="1" (
    echo 正在使用超分模型1...
    rem 假设超分命令为 upscale1.exe
    "%program_path%" -i "%filepath%" -o "%output_path%" -n realesrgan-x4plus
) else if "%model%"=="2" (
    echo 正在使用超分模型2...
    rem 假设超分命令为 upscale2.exe
   "%program_path%" -i "%filepath%" -o "%output_path%" -n realesrnet-x4plus
) else if "%model%"=="3" (
    echo 正在使用超分模型3...
    rem 假设超分命令为 upscale3.exe
   "%program_path%" -i "%filepath%" -o "%output_path%" -n realesrgan-x4plus-anime
) else if "%model%"=="4" (
    echo 正在使用超分模型4...
    rem 假设超分命令为 upscale4.exe
    "%program_path%" -i "%filepath%" -o "%output_path%"-n realesr-animevideov3
)


rem 判断超分是否成功
if not exist "%output_path%" (
    echo 超分失败！
    pause
    exit /b 1
)

echo 超分完成，生成的文件名为 "%output_path%"
pause
goto loop
