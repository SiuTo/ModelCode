bool solve(int p,int *x)
{
	int i,j,l,r,num;
	for (i=1; i<p; ++i)
		for (j=1; j<p; ++j)
			if (i*j%p==1) rev[i]=j;
	for (i=0; i<n; ++i)
		for (j=0; j<=m; ++j) b[i][j]=a[i][j]%p;
	r=0;
	for (l=0; l<m; ++l)
	{
		for (j=r; j<n && !b[j][l]; ++j);
		if (j==n) continue;
		if (j!=r)
			for (i=l; i<=m; ++i) swap(b[j][i],b[r][i]);
		num=rev[b[r][l]];
		for (i=l; i<=m; ++i) b[r][i]=b[r][i]*num%p;
		for (i=0; i<n; ++i)
		{
			if (i==r) continue;
			num=b[i][l];
			for (j=l; j<=m; ++j) b[i][j]=((b[i][j]-b[r][j]*num)%p+p)%p;
		}
		++r;
	}
	for (i=0; i<n; ++i)
	{
		for (j=0; j<m && !b[i][j]; ++j);
		if (j==m)
			if (b[i][m]) return false; else continue;
		x[j]=b[i][m];
	}
	return true;
}