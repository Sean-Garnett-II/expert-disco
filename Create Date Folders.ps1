mkdir "Archived Transfer Forms"
cd .\"Archived Transfer Forms"

$year = 2014

for ($i=0; $i -lt 7; $i++) 
{
echo $year
mkdir "$year Transfer Forms"
cd .\"$year Transfer Forms"

mkdir "01-January-$year"
mkdir "02-February-$year"
mkdir "03-March-$year"
mkdir "04-April-$year"
mkdir "05-May-$year"
mkdir "06-June-$year"
mkdir "07-July-$year"
mkdir "08-August-$year"
mkdir "09-September-$year"
mkdir "10-October-$year"
mkdir "11-November-$year"
mkdir "12-December-$year"
cd..
$year +=1
}
cd..