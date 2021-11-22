function QuoteArgument {
    param(
        [string]$arg
    )

    if($arg.Contains("=") -and $arg.Contains(".") -and -not $arg.Contains('"')) {
        $parts = $arg.Split('=')

        return -join($parts[0],'=','"',$parts[1],'"')
    }

    return $arg
}

# Prints the message with the passed arguments
Write-Host "Execution Started in CLI mode with the following arguments: $args"

$cleanArgs = "$args"
foreach ($arg in $args) {
    $replace = (QuoteArgument -arg $arg)
    $cleanArgs = $cleanArgs.Replace($arg,  $replace)
}

# Constructs the JMeter command and execute it
$command = -join(".\jmeter ",$cleanArgs)
Invoke-Expression $command

# Prints the execution completed message
Write-Host "Execution has been completed. Please check your host machine for the results."