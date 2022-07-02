function Get-VbrWanAccelInfo {
    <#
    .SYNOPSIS
        Function to extract veeam backup & replication wan accelerator information.
    .DESCRIPTION
        Build a diagram of the configuration of Veeam VBR in PDF/PNG/SVG formats using Psgraph.
    .NOTES
        Version:        0.0.2
        Author:         Jonathan Colon
        Twitter:        @jcolonfzenpr
        Github:         rebelinux
    .LINK
        https://github.com/rebelinux/Veeam.Diagrammer
    #>
    [CmdletBinding()]

    Param
    (

    )
    process {
        Write-Verbose -Message "Collecting Wan Accelerator information from $($VBRServer.Name)."
        try {
            $WANACCELS = Get-VbrWanAccelerator
            $WANACCELInfo = @()
            if ($WANACCELS) {
                foreach ($WANACCEL in $WANACCELS) {

                    $Rows = @{
                        Role = 'Wan Accelerator'
                        IP = Get-NodeIP -HostName $WANACCEL.Name
                    }


                    $TempWANACCELInfo = [PSCustomObject]@{
                        Name = "$($WANACCEL.Name.toUpper().split(".")[0])  ";
                        Label = Get-ImageNode -Name "$($WANACCEL.Name.toUpper().split(".")[0])" -Type "VBR_Wan_Accel" -Align "Center" -Rows $Rows
                    }
                    $WANACCELInfo += $TempWANACCELInfo
                }
            }

            return $WANACCELInfo
        }
        catch {
            $_
        }
    }
    end {}
}