$user = "<user>"
$token = "<pat>" #https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token

$base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(("{0}:{1}" -f $user,$token)))

$filename = "c:/temp/<filename>"
$gitfilepath = "https://api.github.com/repos/<org>/<repo>/contents/<file_path>"

function InvokeGetRequest ($PostUrl)
{   
    return Invoke-RestMethod -Uri $PostUrl -Method Get -ContentType "application/json" -Headers @{Authorization=("Basic {0}" -f $base64AuthInfo)}
}

$answ = InvokeGetRequest $gitfilepath

$bytes = [Convert]::FromBase64String($answ.content)
[IO.File]::WriteAllBytes($filename, $bytes)
