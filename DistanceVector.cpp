// #include<stdio.h>
#include<iostream>
using namespace std;
struct node
{
    unsigned distance[20];
    unsigned from[20];
}router[10];
int main()
{
    int cm[20][20];
    int nodes,i,j,k,count=0;
    cout<<"\nEnter the number of nodes : ";
    cin>>nodes;//Enter the nodes
    cout<<"\nEnter the cost matrix :\n";
    for(i=0;i<nodes;i++)
    {
        for(j=0;j<nodes;j++)
        {
            cin>>cm[i][j];
            cm[i][i]=0;
            router[i].distance[j]=cm[i][j];
            router[i].from[j]=j;
        }
    }
        do
        {
            count=0;
            for(i=0;i<nodes;i++)
            for(j=0;j<nodes;j++)
            for(k=0;k<nodes;k++)
                if(router[i].distance[j]>cm[i][k]+router[k].distance[j])
                {
                    router[i].distance[j]=router[i].distance[k]+router[k].distance[j];
                    router[i].from[j]=k;
                    count++;
                }
        }while(count!=0);
        for(i=0;i<nodes;i++)
        {
            cout<<"\n\n For router "<<i+1<<"\n";
            for(j=0;j<nodes;j++)
            {
                cout<<"\t\nnode "<<j+1<<" via "<<router[i].from[j]+1<<"distance "<<router[i].distance[j];
            }
        }
    cout<<"\n\n";
}