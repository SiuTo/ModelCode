#include <cstdio>

const int Maxn=10000;

int a[Maxn], b[Maxn];

int mergesort(int l, int r)
{
	if (l==r) return 0;
	int mid=(l+r)>>1;
	int sum=mergesort(l, mid)+mergesort(mid+1, r);
	int p=l, q=mid+1, h=l;
	while (p<=mid && q<=r)
		if (a[p]<=a[q]) b[h++]=a[p++]; else
		{
			b[h++]=a[q++];
			sum+=mid-p+1;
		}
	while (p<=mid) b[h++]=a[p++];
	while (q<=r) b[h++]=a[q++];
	for (int i=l; i<=r; ++i) a[i]=b[i];
	return sum;
}

int main()
{
	int n;
	scanf("%d", &n);
	for (int i=0; i<n; ++i) scanf("%d", a+i);
	printf("%d\n", mergesort(0, n-1));
	for (int i=0; i<n; ++i) printf("%d ", a[i]);
	printf("\n");
	return 0;
}

