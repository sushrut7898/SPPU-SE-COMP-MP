#include<iostream>
using namespace std;
int main()
{
	int a[5] = {60,10,50,20,30};
	int t;
	for(int i = 0;i < 4;i++)
	{
		for(int j = 0;j < 4;j++)
		{
			if(a[j] > a[j+1])
			{
				t = a[j];
				a[j] = a[j+1];
				a[j+1] = t;
			}
		}
	}
	for(int i = 0;i < 5;i++)
	{
		cout << a[i] << endl;
	}
	return 0;
}