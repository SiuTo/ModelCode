import java.io.*;
import java.util.*;

public class InputOutput
{
	static void stdIO() throws IOException
	{
		BufferedReader stdin=new BufferedReader(new InputStreamReader(System.in));
		System.out.println(stdin.readLine());
	}
	
	static void fileIO() throws IOException
	{
		BufferedReader filein=new BufferedReader(new FileReader("input.txt"));
		BufferedWriter fileout=new BufferedWriter(new FileWriter("output.txt"));
		String str,s=new String();
		str="";
		while ((s=filein.readLine())!=null) str+=s+"\n";
		fileout.write(str);
		filein.close();
		fileout.close();
	}
	
	static void stringIO() throws IOException
	{
		String str="abcdedf";
		StringReader sin=new StringReader(str);
		int c;
		while ((c=sin.read())!=-1) System.out.print((char)c);
		System.out.println();
	}
	
	static void scannerIO()
	{
		Scanner sin=new Scanner(System.in);
		int x=sin.nextInt();
		System.out.println(x);
		sin.close();
	}
	
	public static void main(String[] args) throws IOException
	{
		stdIO();
		fileIO();
		stringIO();
		scannerIO();
	}
}
