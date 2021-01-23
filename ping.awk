BEGIN{
pingDrop=0;
}
{
if($1 =="d")
{
pingDrop++;
}
}
END{
printf("Total number of ping packets dropped due to congestion is =%d\n",pingDrop);
}
