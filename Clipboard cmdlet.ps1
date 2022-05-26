$fileName = Read-Host "File Name: "
if(Test-Path -Path $fileName){
Get-Content -Path $fileName | ForEach-Object {
Set-Clipboard -Value "$_"
echo "$_"
pause
}
} else {
echo "Bad file Name"
pause
}

echo "Done"
pause