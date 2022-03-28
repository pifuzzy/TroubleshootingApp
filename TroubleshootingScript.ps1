#Name: Sean Beardmore
#The purpose of this program is to assist in troubleshooting
Clear-Host
#VARIABLE
$UserInput = 0
## FUNCTIONS


#This function obtains your default gateway IP address and sends a ping and shows results in the cli.

Function Ping-DefaultGateway {
    [CmdletBinding()]
	
    $default_gateway = (Get-NetRoute "0.0.0.0/0").NextHop
    $connectivity = ping $default_gateway
    Write-Host "Pinging your Default Gateway...  " $connectivity
    
    	
}

try {
    while ($UserInput -ne 5) {
        Write-Host -ForegroundColor DarkCyan '
        1. Check log files.
        2. Test connection to default gateway.
        3. List the current CPU %, Processor Time, and physical memory usage.
        4. Display running processes.
        5. Exit the script execution.
        '
        # Prompt for the user input
        $UserInput = Read-Host -Prompt 'Select a number'
        #Run specific code based on user input
        switch -Exact ($UserInput)
        {
            #User selects option 1
            1 {eventvwr}

            #User selects option 2
            2 {Ping-DefaultGateway}

            #User selects option 3
            3 {Get-Counter -SampleInterval 5 -MaxSamples 4}

            #User selects option 4
            4 {Get-Process | Select-Object Name, ID, TotalProcessorTime | Sort-Object TotalProcessorTime -Descending | Format-Table}

            #User selects option 5
            5 {}
        }
    }
}
catch [System.OutOfMemoryException] {
    Write-Host -ForegroundColor $_.Exception.Message
}