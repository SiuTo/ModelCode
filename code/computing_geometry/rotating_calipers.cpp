#include <cstdio>
#include <iostream>
#include <algorithm>
using namespace std;
#define Point pair<int,int>
#define x first
#define y second
Point a[50001];

int cross(Point &a, Point &b, Point &c)
{
    return (b.x-a.x)*(c.y-a.y)-(b.y-a.y)*(c.x-a.x);
}

int dist(Point &a, Point &b)
{
    return (a.x-b.x)*(a.x-b.x)+(a.y-b.y)*(a.y-b.y);
}

bool cmp(Point p1, Point p2)
{
    int s=cross(a[0],p1,p2);
    return s>0 || s==0 && dist(a[0],p1)<dist(a[0],p2);
}

int main()
{
    int n,i, j=0;
    scanf("%d",&n);
    for (i=0; i<n; ++i)
    {
        scanf("%d%d",&a[i].x,&a[i].y);
        if (a[i]<a[j]) j=i;
    }
    swap(a[j],a[0]);
    sort(a+1,a+n,cmp);
    int top=1;
    for (i=2; i<n; ++i)
    {
        while (top && cross(a[top-1],a[top],a[i])<=0) --top;
        a[++top]=a[i];
    }
    a[++top]=a[0]; j=1;
    int ans=0;
    for (i=0; i<top; ++i)
    {
        while (cross(a[i],a[i+1],a[j])<cross(a[i],a[i+1],a[j+1])) j=(j+1)%top;
        ans=max(ans,dist(a[i],a[j]));
    }
    printf("%d\n",ans);
    return 0;
}
