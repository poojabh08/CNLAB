BEGIN{
ftppack=0;
cbrpack=0;
ftptime=0;
cbrtime=0;
}
{
if($1=="r" && $3=="3" && $4=="4" && ($5=="tcp"))
{
ftppack=ftppack+$6;
ftptime=$2;
}
if($1=="r" && $3=="1" && $4=="2")
{
cbrpack=cbrpack+$6;
cbrtime=$2;
}
}
END{
printf("\n throughput of FTP=%f Mbps\n", (ftppack/ftptime)*(8/1000000));
printf("\n throughput of CBR=%f Mbps\n", (cbrpack/cbrtime)*(8/1000000));
}

