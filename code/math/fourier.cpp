#include <cstdio>
#include <cmath>
#include <complex>
using namespace std;
typedef complex<double> Complex;

const int Maxn=100000;
const double PI=acos(-1.0);

Complex a[Maxn],b[Maxn],c[Maxn];

void fourier(int l,int r,int t)
{
	if (l==r) return;
	int i,n=r-l+1, m=n>>1;
	for (i=0; i<n; ++i)
		if (i&1) c[i>>1]=a[l+i]; else b[i>>1]=a[l+i];
	for (i=0; i<m; ++i) a[l+i]=b[i], a[l+m+i]=c[i];
	fourier(l,r-m,t);
	fourier(l+m,r,t);
	Complex w0(cos(2.0*PI/n*t),sin(2.0*PI/n*t));
	Complex w1(1.0,0.0);
	Complex t1,t2;
	for (i=0; i<m; ++i)
	{
		t1=a[l+i];
		t2=w1*a[l+m+i];
		a[l+i]=t1+t2;
		a[l+m+i]=t1-t2;
		w1=w1*w0;
	}
}

int main()
{
	int n,i;
	scanf("%d",&n);
	double x;
	for (i=0; i<n; ++i)
	{
		scanf("%lf",&x);
		a[i]=x;
	}
	int m=1<<(int)ceil(log2(n));
	for (i=n; i<m; ++i) a[i]=0;
	//for (i=0; i<m; ++i) printf("%.2f+%.2fi ",b[i].x,b[i].y); printf("\n");
	fourier(0,m-1,-1);
	//for (i=0; i<m; ++i) printf("%.2f+%.2fi ",a[i].x,a[i].y); printf("\n");
	fourier(0,m-1,1);
	for (i=0; i<m; ++i) a[i]/=m;
	printf("%d\n",n);
	for (i=0; i<n; ++i) printf("%d ",(int)round(a[i].real()));
	printf("\n");
	return 0;
}

