Configuration ConfigureFE1
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
	    Add-WindowsFeature -Name Telnet-Client,Telnet-Server, Web-Common-Http,Web-Asp-Net,Web-Net-Ext,Web-ISAPI-Ext,Web-ISAPI-Filter,Web-Http-Logging,Web-Request-Monitor,Web-Basic-Auth,Web-Windows-Auth,Web-Filtering,Web-Performance,Web-Mgmt-Console,Web-Mgmt-Compat,WAS -IncludeAllSubFeature -restart
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