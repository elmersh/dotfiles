Import-Module git-aliases -DisableNameChecking
Invoke-Expression (&starship init powershell)

Set-Alias -Name subl -Value subl.exe

# Función para mostrar texto con un color específico
function Show-ColorText {
  param (
    [string]$text,
    [ConsoleColor]$color
  )
  $originalColor = $Host.UI.RawUI.ForegroundColor
  $Host.UI.RawUI.ForegroundColor = $color
  Write-Host $text
  $Host.UI.RawUI.ForegroundColor = $originalColor
}

# Comando que crea un commit con un mensaje
function commit {
  git add .
  git commit -m "$($args -join ' ')" # Agrega todos los cambios y realiza un commit con el mensaje proporcionado
}

# Alias para crear una carpeta y cambiar a ella
function mkd {
  mkdir $($args -join ' ') # Crea un nuevo directorio con el nombre proporcionado
  Set-Location -Path $($args -join ' ') # Cambia a ese directorio
}

# Alias para ejecutar comandos de Artisan de Laravel
function art {
  php artisan $($args -join ' ') # Ejecuta un comando Artisan con los argumentos proporcionados
}

# Alias para crear un componente Livewire en Laravel
function alm {
  php artisan livewire:make $($args -join ' ') # Crea un componente Livewire
}

# Alias para crear un modelo con controlador, migración, factory y seeder
function amm {
  php artisan make:model $($args -join ' ') -mcfs # Crea un modelo con varias opciones
}

# cdh - Cambiar a un directorio de proyectos
function cdh {
  $herdPath = $env:DEV_DIR # Obtiene el directorio base desde la variable de entorno
  Show-ColorText "DEV_DIR: $herdPath" "Cyan"

  # Si hay argumentos, cambia al directorio especificado
  if ($args.Count -gt 0) {
    $targetPath = Join-Path $herdPath $args[0]
    Show-ColorText "Intentando cambiar al directorio: $targetPath" "Cyan"

    # Verifica si el directorio de destino existe antes de cambiar
    if (Test-Path -Path $targetPath) {
      Set-Location -Path $targetPath
      Show-ColorText "Has cambiado al directorio $args[0]" "Cyan"
    }
    else {
      Show-ColorText "Error: El directorio '$targetPath' no existe." "Red"
    }
    return
  }

  # Verifica si la carpeta Herd existe, y la crea si no
  if (-not (Test-Path -Path $herdPath)) {
    Show-ColorText "El directorio Herd no existe. Creándolo ahora..." "Yellow"
    New-Item -ItemType Directory -Path $herdPath | Out-Null
  }

  # Recupera la lista de directorios dentro de Herd
  $directoryItems = Get-ChildItem -Path $herdPath -Directory
  $directories = @() # Inicializa un arreglo para almacenar los nombres de directorio

  # Llena el arreglo $directories con los nombres completos de los directorios
  foreach ($item in $directoryItems) {
    $directories += $item.Name
  }

  Show-ColorText "Directorios encontrados en Herd:" "Green"
  for ($i = 0; $i -lt $directories.Count; $i++) {
    Write-Host "$i - $($directories[$i])"
  }

  # Verifica si hay directorios disponibles
  if ($directories.Count -eq 0) {
    Show-ColorText "No se encontraron proyectos en Herd. Por favor, añade algunos directorios/proyectos." "Red"
    Set-Location -Path $herdPath
    return
  }

  # Solicita al usuario que seleccione un directorio
  Write-Host ""
  $choice = Read-Host "Introduce el número del directorio al que quieres cd o presiona Enter para ir al directorio de proyectos"

  # Cambia al directorio de proyectos si el usuario no selecciona ninguno
  if ($choice -eq '') {
    Set-Location -Path $herdPath
    Show-ColorText "Cambiado al directorio de proyectos." "Cyan"
  }
  elseif ($choice -match '^\d+$') {
    $choiceIndex = [int]$choice  # Asegura que la elección sea tratada como un entero
    if ($choiceIndex -ge 0 -and $choiceIndex -lt $directories.Count) {
      # Accede al nombre completo del directorio utilizando el índice
      $selectedDirectory = [string]$directories[$choiceIndex]
      $targetPath = Join-Path $herdPath $selectedDirectory
      Show-ColorText "Intentando cambiar al directorio: $targetPath" "Cyan"

      # Verifica si el directorio de destino existe antes de cambiar
      if (Test-Path -Path $targetPath) {
        Set-Location -Path $targetPath
        $editors = @("VS Code", "Sublime Text", "PhpStorm", "Notepad")
        Show-ColorText "Elige un editor para abrir el proyecto:" "Green"
        $editors | ForEach-Object { Write-Host "$($editors.IndexOf($_)) $_" }
        $editorChoice = Read-Host "Ingresa el número del editor"

        switch ($editorChoice) {
          "0" { Start-Process "code" $PWD }
          "1" { Start-Process "subl.exe" $PWD }
          "2" { Start-Process "phpstorm" $PWD | Out-Null }
          "3" { Start-Process "notepad.exe" $PWD }
          default { Show-ColorText "Has cambiado al directorio $selectedDirectory" "Cyan" }
        }
      }
      else {
        Show-ColorText "Error: El directorio '$targetPath' no existe." "Red"
      }
    }
    else {
      Show-ColorText "Selección no válida. Por favor, introduce un número válido o presiona Enter sin escribir nada para ir al directorio de proyectos." "Red"
    }
  }
  else {
    Show-ColorText "Selección no válida. Por favor, introduce un número válido o presiona Enter sin escribir nada para ir al directorio de proyectos." "Red"
  }
}
