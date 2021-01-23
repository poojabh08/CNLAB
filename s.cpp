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

	mkfifo("req.fifo",0777);
	mkfifo("res.fifo",0777);

	cout<<"server ready for connection\n";

	req=open("req.fifo",O_RDONLY);
	res=open("res.fifo",O_WRONLY);

	cout<<"connection established\n";

	read(req,fname,sizeof(fname));
	cout<<"entered filename is "<<fname<<"\n";


	file=open(fname,O_RDONLY);

	if(file<0){
		write(res,"file_not_found",14);
	}
	else{
		while((n=read(file,buffer,sizeof(buffer)))>0){
		write(res,buffer,n);
	}
	}

	close(req);
	close(res);
	unlink("req.fifo");
	unlink("res.fifo");
	

	return 0;
}
