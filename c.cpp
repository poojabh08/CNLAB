#include<stdio.h>
#include<iostream>
#include<unistd.h>
#include<fcntl.h>
#include<sys/stat.h>
#include<sys/types.h>

using namespace std;
int main()
{
	char fname[50],buffer[1025];
	int req,res,n,file;

	req=open("req.fifo",O_WRONLY);
	res=open("res.fifo",O_RDONLY);

	// printf("enter the filename\n");
    cout<<"Enter the filename\n";
	cin>>fname;

	write(req,fname,sizeof(fname));

	while((n=read(res,buffer,sizeof(buffer)))>0){
		cout<<buffer;
	}
	
	close(req);
	close(res);

	return 0;
}
