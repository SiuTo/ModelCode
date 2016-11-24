#include <iostream>
const int Kind=26,Maxl=250001;
struct node
{
    int r,fail,next[Kind];
}t[Maxl];
char s[1000001];
int root,tot,i,p,o[Maxl];

void maketrie()
{
    int n,c;
    memset(t,0,sizeof t);
    root=tot=1;
    scanf("%d",&n);
    getchar();
    while (n--)
    {
        gets(s);
        p=root;
        for (i=0; s[i]; ++i)
        {
            c=s[i]-'a';
            if (!t[p].next[c]) t[p].next[c]=++tot;
            p=t[p].next[c];
        }
        ++t[p].r;
    }
}

void bfs()
{
    int x,q1=0,q2=1;
    o[1]=root;
    while (q1<q2)
    {
        x=o[++q1];
        for (i=0; i<Kind; ++i)
            if (t[x].next[i])
            {
                t[t[x].next[i]].fail=x==root? root:t[t[x].fail].next[i];
                o[++q2]=t[x].next[i];
            }
            else t[x].next[i]=x==root? root:t[t[x].fail].next[i];
    }
}

int match()
{
    int rr=0,q;
    p=root;
    gets(s);
    for (i=0; s[i]; ++i)
    {
        p=t[p].next[s[i]-'a'];
        for (q=p; q!=root && t[q].r>=0; q=t[q].fail)
        {
            rr+=t[q].r;
            t[q].r=-1;
        }
    }
    return rr;
}

int main()
{
	maketrie();
	bfs();
	printf("%d\n",match());
    return 0;
}
