const int Maxn=100001;

int a[Maxn], b[Maxn], c[Maxn], s[20][Maxn];

class Partition_tree
{
	private:
	
	int n;

	void build(int d,int l,int r)
	{
		if (l == r) return;
		int mid = (l + r) >> 1, cnt = mid - l + 1, x = c[mid], p = l, q = mid + 1, ss = 0, i;
		for (i = l; i <= r; ++i)
			if (a[i] < x) --cnt;
		for (i = l; i <= r; ++i)
		{
			if (a[i] < x || (a[i] == x && cnt))
			{
				++ss;
				b[p++]=a[i];
				cnt -= (a[i] == x);
			}
			else b[q++] = a[i];
			s[d][i] = ss;
		}
		for (i = l; i <= r; ++i) a[i] = b[i];
		build(d + 1, l, mid);
		build(d + 1, mid + 1, r);
	}

	int query(int d,int l,int r,int x,int y,int k)
	{
		if (l == r) return a[l];
		int mid = (l + r) >>1;
		int hl = x == l? 0:s[d][x-1], hr = s[d][y];
		if (k <= hr - hl) return query(d + 1, l, mid, l + hl, l + hr - 1, k);
		else return query(d + 1, mid + 1, r, mid + 1 + x - l - hl, mid + 1 + y - l - hr, k - (hr - hl));
	}

	public:

	Partition_tree(int n0) : n(n0)
	{
		for (int i = 1; i <= n; ++i)
			c[i] = a[i];
		sort(c + 1, c + n + 1);
		build(0, 1, n);
	}

	int query(int x, int y, int k)
	{
		return query(0, 1, n, x, y, k);
	}
};

