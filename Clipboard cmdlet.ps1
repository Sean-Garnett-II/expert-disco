$fileName = Read-Host "File Name: "
if(Test-Path -Path $fileName){
$length = (Get-Content -Path $fileName ).Length
$count = 1
Get-Content -Path $fileName | ForEach-Object {
Set-Clipboard -Value "$_"
echo "$_"
echo "$count / $length"
$count+=1
pause
cls
}
} else {
echo "Bad file Name"
pause
}

echo "Done"
pause