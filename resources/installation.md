# Loca installation

Loca opens in a dedicated Edge WebView2 window without browser tabs or an address bar. Closing the window stops its local Streamlit server. The existing model controls and application tabs remain available.

## Requirements

- Windows x64 and Microsoft [Edge WebView2 Runtime](https://developer.microsoft.com/en-us/microsoft-edge/webview2/).
- Python 3.11 or 3.12 for a PyPI installation. The Windows installer includes Python.
- Your own GGUF model files. Sentence-transformer models require a download when not already cached.

## Install from PyPI

After the first publication, run in PowerShell:

```powershell
py -3.11 -m venv .venv
.\.venv\Scripts\Activate.ps1
python -m pip install --upgrade pip
python -m pip install loca-py
loca
```

`loca` launches the tabless Windows UI. `loca-browser` launches ordinary browser mode and supports other operating systems. The distribution is `loca-py`; the import is `loca`.

## Windows installer

1. Open [Windows installer Actions](https://github.com/is-leeroy-jenkins/loca/actions/workflows/windows-installer.yml) after merging the packaging changes.
2. Run **Build Loca Windows desktop installer** on `main`.
3. Download and extract the **Loca-Windows-Installer** artifact from the successful run.
4. Run `Loca-Setup-0.1.0.exe`, choose the optional desktop shortcut, and finish the wizard.
5. Launch Loca from the Start Menu or desktop shortcut.

The default installation is `%LOCALAPPDATA%\Programs\Loca` and requires no administrator privileges. Builds are unsigned unless signing is configured. The workflow uploads an artifact; it does not publish an installer release automatically.

## Model configuration and data

Model weights are supplied separately and are not bundled in the wheel or installer. Set the absolute path for each model you intend to use:

| Model | Environment variable |
|---|---|
| Bro (default) | `BRO_LLM_PATH` |
| Gipity | `GIPITY_LLM_PATH` |
| Buddy | `BUDDY_LLM_PATH` |
| Boo | `BOO_LLM_PATH` |
| Jimi | `JIMI_LLM_PATH` |
| Leeroy | `LEEROY_LLM_PATH` |
| Nisty | `NISTY_LLM_PATH` |

Example in PowerShell:

```powershell
[Environment]::SetEnvironmentVariable('BRO_LLM_PATH', 'C:\Models\bro.gguf', 'User')
```

Use a compatible GGUF file that exists on your machine. Restart the terminal or sign out and back in before launching a shortcut to pick up changed environment variables. Select the configured model through the existing sidebar. Local inference remains unavailable until its model path is configured. No provider API key is required for local inference.

Writable resources, theme settings, databases, exports, and logs use `%LOCALAPPDATA%\Loca`. The `stores\sqlite` directory is created for Loca's database. Bundled defaults are copied only when missing, preserving existing user files. Development databases, logs, notebooks, secrets, and GIF demos are excluded. The local server binds to `127.0.0.1` on an available port.

## Build from source

Install Python 3.11 x64, Git, Visual Studio Build Tools with Desktop development with C++ (for llama-cpp-python source builds), and [Inno Setup 6](https://jrsoftware.org/isinfo.php), then run on Windows:

```powershell
git clone https://github.com/is-leeroy-jenkins/loca.git
cd loca
py -3.11 -m venv .venv
.\.venv\Scripts\Activate.ps1
python -m pip install --upgrade pip setuptools wheel
python -m pip install -r requirements-desktop.txt
python desktop.py
python -m PyInstaller --noconfirm --clean loca.spec
& "C:\Program Files (x86)\Inno Setup 6\ISCC.exe" "installer\loca.iss"
```

The installer is written to `dist-installer`. Build on Windows; PyInstaller does not cross-compile Windows executables from Linux.

## Troubleshooting and upgrades

Check `%LOCALAPPDATA%\Loca\desktop.log` for startup errors. Install WebView2 if the window does not open. Verify the selected GGUF path and model compatibility if inference fails. Back up `%LOCALAPPDATA%\Loca` before upgrading.

Close Loca and run the newer Setup executable to upgrade. Uninstall through Windows Settings → Apps → Loca. User data remains after uninstall and can be removed separately.

A successful Windows build and clean-machine test are required to validate the native installer. Check startup, local inference and retrieval workflows, database persistence, window-close server cleanup, and uninstall.

[PyPI release instructions](pypi-release.md) · [README](../README.md)
