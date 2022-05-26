$fileName = Read-Host "File Name: "
$delimiter = Read-Host "Delimiter: "
if($delimiter -eq ""){
  $delimniter = ", "
  }
if(Test-Path -Path $fileName){
  if(Test-Path -Path "$fileName.txt") {
  Remove-Item -Path "$fileName.txt" -Force
  }
  New-Item -path .\ -type file -name "$fileName.txt"
  Get-Content -Path $fileName | ForEach-Object {
    $value = "$_"+"$delimiter"
    Add-Content -Path .\"$fileName.txt" -Value $value -NoNewline
    }
  } else {
  echo "Bad file Name"
  pause
}

pause
