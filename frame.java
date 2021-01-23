import java.util.*;
import java.io.*;

class frame
{
    public static void main(String args[])
    {       
        HashMap<Integer,String> t=new HashMap<Integer,String>();
        ArrayList<Integer> rand = new ArrayList<Integer>(); 
        Scanner s=new Scanner(System.in);
        System.out.println("Enter the string to framesort");
        String tt=s.nextLine();
        
        System.out.println("Enter the number of network");
        int z=s.nextInt();int min=999;
        for(int p=0;p<z;p++)
        {
            System.out.println("---------------------------------------");
            System.out.println("Enter the MTU value");
            int x=s.nextInt();
            if(x<min)
                min=x;            
            x=min;
            String m="";int j=0;
            System.out.println(); 
            System.out.println("After fragmentation");        
            for(int i=0;i<tt.length();i=i+x)
            {
                if(i+x<=tt.length()){
                    m=tt.substring(i,i+x);   
               }
                else
                    m=tt.substring(i,tt.length());
                t.put(j,m);
                System.out.println(j+" "+m);
                if(!rand.contains(j))
                     rand.add(j);
                j++; 

            }
            System.out.println(); 
            System.out.println("After Shuffling"); 
            Collections.shuffle(rand);
            for(int k=0;k<rand.size();k++)
                System.out.println(rand.get(k)+":"+t.get(rand.get(k)));
            System.out.println(); 
            System.out.println("After sorting"); 
            Collections.sort(rand);
            for(int k=0;k<rand.size();k++)
                System.out.println(rand.get(k)+":"+t.get(rand.get(k)));
            System.out.println("---------------------------------------");
        }
    }
}  
