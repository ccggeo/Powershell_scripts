function force-install {

        [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory=$true)]
        $target,
        [Parameter(Mandatory=$true)]
        $package
    )
    
    invoke-command -ComputerName $target -ScriptBlock{
    $package = $package

    set-executionpolicy bypass
    iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1')) 
    
    choco install $package -y
    
    Remove-Item -Recurse -Force "$env:ChocolateyInstall" -WhatIf
    [System.Text.RegularExpressions.Regex]::Replace([Microsoft.Win32.Registry]::CurrentUser.OpenSubKey('Environment').GetValue('PATH', '', [Microsoft.Win32.RegistryValueOptions]::DoNotExpandEnvironmentNames).ToString(), [System.Text.RegularExpressions.Regex]::Escape("$env:ChocolateyInstall\bin") + '(?>;)?', '', [System.Text.RegularExpressions.RegexOptions]::IgnoreCase) | %{[System.Environment]::SetEnvironmentVariable('PATH', $_, 'User')}
    [System.Text.RegularExpressions.Regex]::Replace([Microsoft.Win32.Registry]::LocalMachine.OpenSubKey('SYSTEM\CurrentControlSet\Control\Session Manager\Environment\').GetValue('PATH', '', [Microsoft.Win32.RegistryValueOptions]::DoNotExpandEnvironmentNames).ToString(),  [System.Text.RegularExpressions.Regex]::Escape("$env:ChocolateyInstall\bin") + '(?>;)?', '', [System.Text.RegularExpressions.RegexOptions]::IgnoreCase) | %{[System.Environment]::SetEnvironmentVariable('PATH', $_, 'Machine')}      
    #set-executionpolicy restrict
    
    }


   }

    force-install -target -package brackets