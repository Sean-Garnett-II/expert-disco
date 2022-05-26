
$fileName = Read-Host "File Name: "
if(Test-Path -Path $fileName){
New-Item -path .\ -type file -name "$fileName.txt"
} else {
echo "Bad file Name"
pause
}

Get-Content -Path $fileName | ForEach-Object {
Add-Content -Path .\"$fileName.txt" -Value "$_, " -NoNewline
}


pause