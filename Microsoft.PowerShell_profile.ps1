Import-Module git-aliases -DisableNameChecking
Invoke-Expression (&starship init powershell)

Set-Alias -Name subl -Value subl.exe

# Comando que crea un commit con un mensaje
function commit {
    git add .
    git commit -m "$args"
}
# Alias para crear una carpeta y cambiar a ella
function mkd {
    mkdir $args
    cd $args
}

# php artisan
function art {
    php artisan $args
}

# php artsian livewire:make
function alm {
    php artisan livewire:make $args
}

# php artisan make:model -mcfs
function amm {
    php artisan make:model $args -mcfs
}

# cdh - Cambiar a un directorio de proyectos
function cdh {
    $herdPath = $env:DEV_DIR
    # Nos aseguramos de que la carpeta Herd exista
    if (-not (Test-Path -Path $herdPath)) {
        Write-Host "The Herd directory does not exist. Creating it now..."
        New-Item -ItemType Directory -Path $herdPath | Out-Null
    }
    $directories = Get-ChildItem -Path $herdPath -Directory | Select-Object -ExpandProperty Name
    if ($directories.Count -eq 0) {
        Write-Host "No projects found in Herd. Please add some directories/projects."
        Set-Location -Path $herdPath
        return
    }
    $directories | ForEach-Object { "$($directories.IndexOf($_)) $_" }
    $choice = Read-Host "Enter the number of the directory you want to cd into or press Enter to go to the projects directory"
    if ($choice -eq '') {
        Set-Location -Path $herdPath
        Write-Host "Changed directory to the projects directory."
    } elseif ($choice -match '^\d+$' -and $choice -lt $directories.Count) {
        $selectedDirectory = $directories[$choice]
        Set-Location (Join-Path $herdPath $selectedDirectory)
        $editors = @("VS Code", "Sublime Text", "PhpStorm", "Notepad")
        $editors | ForEach-Object { "$($editors.IndexOf($_)) $_" }
        $editorChoice = Read-Host "Choose an editor to open the project with (enter the number)"
        switch ($editorChoice) {
            "0" { Start-Process "code" $PWD }
            "1" { Start-Process "subl.exe" $PWD }
            "2" { Start-Process "phpstorm" $PWD | Out-Null }
            "3" { Start-Process "notepad.exe" $PWD }
            default { Write-Host "You have changed the directory to $selectedDirectory" }
        }
    } else {
        Write-Host "Invalid selection. Please enter a valid number or press Enter without typing anything to go to the projects directory."
    }
}