#include<iostream>
using namespace std;
void div(int t[],int g[],int n,int r);

int main()
{
    int n,r,m[30],g[20],t[30];
    cout<<"Total number of message bits : ";
    cin>>n;
    cout<<"Total number of generator bits : ";
    cin>>r;
    cout<<"Message to be transmitted: ";
    for(int i=0;i<n;i++)
        cin>>m[i];
    cout<<"Enter the generator : ";
    for(int i=0;i<r;i++)
        cin>>g[i];
    r--;
    for(int i=0;i<r;i++)
        m[n+i] = 0;
    for(int i=0;i<n+r;i++)
        t[i] = m[i];
    div(t,g,n,r);
    cout<<"CRC : ";
    for(int i=0;i<r;i++)
    {
        cout<<t[n+i]<<" ";
        m[n+i] = t[n+i];
    }
    cout<<endl<<"Transmitted Message : ";
    for(int i=0;i<n+r;i++)
        cout<<m[i]<<" ";
    cout<<endl;
    cout<<"Received message : ";
    for(int i=0;i<n+r;i++)
        cin>>m[i];
    for(int i=0;i<n+r;i++)
        t[i] = m[i];
    div(t,g,n,r);
    for(int i=0;i<r;i++)
    {
        if(t[n+i])
        {
            cout<<"\nError detected in received message.\n";
            return 0;
        } 
    }
    cout<<"\nNo error in received Message. ";
    cout<<"\n";
    return 0;
}
void div(int t[],int g[],int n,int r)
{
    int i=0;
    while(i<n){
    {if (g[0]==t[i])
        {for(int j=0,k=i;j<r+1;j++,k++)
                if(t[k]==g[j])
                    t[k]=0;
                else
                    t[k]=1;
        } 
    }
    i++;
    }
}