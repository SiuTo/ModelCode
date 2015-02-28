#include <cstdio>
#include <algorithm>
using namespace std;
const int Maxn=1501, K=100000;
typedef long long LL;
struct Point
{
	LL x,y;
} a[Maxn],b[Maxn];
int n;

int sign(LL x)
{
	if (!x) return 0;
	return x>0? 1:-1;
}

LL cross(Point a,Point b,Point c)
{
	return (b.x-a.x)*(c.y-a.y)-(b.y-a.y)*(c.x-a.x);
}

LL dot(Point a,Point b,Point c)
{
	return (b.x-a.x)*(c.x-a.x)+(b.y-a.y)*(c.y-a.y);
}

bool segcross(Point a,Point b,Point c,Point d)
{
	int s1=sign(cross(a,b,c)), s2=sign(cross(a,b,d)), s3=sign(cross(c,d,a)), s4=sign(cross(c,d,b));
	if ((s1^s2)==-2 && (s3^s4)==-2 ||
		!s1 && dot(c,a,b)<=0 || !s2 && dot(d,a,b)<=0 || !s3 && dot(a,c,d)<=0 || !s4 && dot(b,c,d)<=0)
		return true; else return false;
}

int count(Point p,Point q)
{
	int cnt=0;
	for (int i=0; i<n; ++i)
		if (segcross(p,q,a[i],b[i])) ++cnt;
	return cnt;
}

int main()
{
	int T,i,ans;
	Point p,q;
	scanf("%d",&T);
	while (T--)
	{
		scanf("%d",&n);
		for (i=0; i<n; ++i) scanf("%lld%lld%lld%lld",&a[i].x,&a[i].y,&b[i].x,&b[i].y);
		scanf("%lld%lld",&p.x,&p.y);
		for (i=0; i<n; ++i) a[i].x-=p.x, a[i].y-=p.y, b[i].x-=p.x, b[i].y-=p.y;
		ans=0;
		p.x=p.y=0;
		for (i=0; i<n; ++i)
		{
			q.x=a[i].x*K, q.y=a[i].y*K;
			ans=max(ans,count(p,q));
			q.x=b[i].x*K, q.y=b[i].y*K;
			ans=max(ans,count(p,q));
		}
		printf("%d\n",ans);
	}
	return 0;
}

