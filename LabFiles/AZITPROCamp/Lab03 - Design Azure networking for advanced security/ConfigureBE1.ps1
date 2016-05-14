Configuration ConfigureBE1
{
  param ($MachineName)

  Node $MachineName
  {
	Script ConfigureVM { 
		SetScript = { 
	    $dir = "c:\Source"
            $FileURI = "https://github.com/AZITCAMP/Labfiles/raw/master/lab03/PortQryUI.zip"
            New-Item $dir -ItemType directory
            $output = "$dir\PortQryUI.zip"
            (New-Object System.Net.WebClient).DownloadFile($FileURI,$output)

            Import-Module ServerManager 
	    Add-WindowsFeature -Name Telnet-Client,Telnet-Server
            Get-Service -Name tlntsvr | Set-Service -StartupType Automatic
            Start-Service tlntsvr 
            New-NetFirewallRule -DisplayName Telnet-In -Protocol tcp -LocalPort 23			
		    
        } 

		TestScript = { 
			Test-Path c:\source 
		} 
		GetScript = { <# This must return a hash table #> }          }   
  }
} 