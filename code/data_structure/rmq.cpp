class RMQ
{
	int n, f[1001][11];
	
	public:

	RMQ(int n0, int *a) : n(n0)
	{
		for (int i = 1; i <= n; ++i)
			f[i][0] = a[i];
		for (int j = 1; (1 << j) <= n; ++j)
			for (int i = 1; i + (1 << j) - 1 <= n; ++i)
				f[i][j] = min(f[i][j - 1], f[i + (1 << (j - 1))][j - 1]);
	}

	int query(int x, int y)
	{
		int k = (int)floor(log2(y - x + 1));
		return min(f[x][k], f[y - (1 << k) + 1][k]);
	}
};

