{$M 100000000}
program Spoj375_QTREE;
const
  maxn=10000;
var
  tt,n,i,tot,x1,y1,z,k,lca,ans,vl:longint;
  t:array[1..maxn*4] of longint;
  g,o,s,d,e,e1,a,b,l:array[0..maxn] of longint;
  u:array[-maxn..maxn] of boolean;
  x,w,next:array[-maxn..maxn] of longint;
  f:array[1..maxn,0..trunc(ln(maxn)/ln(2))] of longint;
  procedure init;
    var u,v,c:longint;
    begin
      readln;
      readln(n);
      fillchar(g,sizeof(g),0);
      for i:=1 to n-1 do
        begin
          readln(u,v,c);
          x[i]:=v; w[i]:=c; next[i]:=g[u]; g[u]:=i;
          x[-i]:=u; w[-i]:=c; next[-i]:=g[v]; g[v]:=-i;
        end;
    end;
  function log(num:longint):longint;
    begin
      if num=0 then log:=-1 else log:=trunc(ln(num)/ln(2));
    end;
  function min(x,y:longint):longint;
    begin
      if x<y then min:=x else min:=y;
    end;
  function max(x,y:longint):longint;
    begin
      if x>y then max:=x else max:=y;
    end;
  procedure dfs1(dep,v,fa:longint);
    var p,p1,max:longint;
    begin
      o[dep]:=v; d[v]:=dep;
      for i:=0 to log(dep) do f[v,i]:=o[dep-1 shl i];
      inc(dep); p:=g[v]; s[v]:=1; max:=0;
      while p<>0 do
        begin
          if x[p]<>fa then
            begin
              e[x[p]]:=-p;
              dfs1(dep,x[p],v);
              inc(s[v],s[x[p]]);
              if s[x[p]]>max then
                begin
                  max:=s[x[p]]; p1:=p;
                end;
            end;
          p:=next[p];
        end;
      if max=0 then exit;
      e1[v]:=p1; u[p1]:=true; u[-p1]:=true;
    end;
  procedure dfs2(v,fa:longint);
    var p:longint;
    begin
      inc(n); o[n]:=v;
      a[v]:=tot; b[v]:=n;
      if s[v]=1 then exit;
      dfs2(x[e1[v]],v);
      p:=g[v];
      while p<>0 do
        begin
          if (x[p]<>fa)and not u[p]and(s[x[p]]>1) then
            begin
              inc(tot);
              l[tot]:=x[p];
              dfs2(x[p],v);
            end;
          p:=next[p];
        end;
    end;
  procedure build(p,l,r:longint);
    var mid:longint;
    begin
      if l+1=r then
        begin
          t[p]:=w[e[o[r]]]; exit;
        end;
      mid:=(l+r)shr 1;
      build(p*2,l,mid);
      build(p*2+1,mid,r);
      t[p]:=max(t[p*2],t[p*2+1]);
    end;
  procedure insert(p,l,r:longint);
    var mid:longint;
    begin
      if l+1=r then
        begin
          t[p]:=y1; exit;
        end;
      mid:=(l+r)shr 1;
      if x1<=mid then insert(p*2,l,mid) else insert(p*2+1,mid,r);
      t[p]:=max(t[p*2],t[p*2+1]);
    end;
  function count(p,l,r,x,y:longint):longint;
    var mid:longint;
    begin
      if (l=x)and(r=y) then exit(t[p]);
      mid:=(l+r)shr 1;
      if y<=mid then exit(count(p*2,l,mid,x,y));
      if x>=mid then exit(count(p*2+1,mid,r,x,y));
      count:=max(count(p*2,l,mid,x,mid),count(p*2+1,mid,r,mid,y));
    end;
  function find(x,y:longint):longint;
    begin
      if d[x]<d[y] then
        begin
          z:=x; x:=y; y:=z;
        end;
      while d[x]>d[y] do
        begin
          k:=log(d[x]-d[y]);
          x:=f[x,k];
        end;
      if x=y then exit(x);
      k:=log(d[x]);
      while k>=0 do
        if f[x,k]=f[y,k] then dec(k) else
          begin
            x:=f[x,k]; y:=f[y,k];
            k:=min(log(d[x]),k-1);
          end;
      find:=f[x,0];
    end;
  procedure wander(v:longint);
    begin
      while v<>lca do
        if u[e[v]] then
          begin
            vl:=l[a[v]];
            if d[vl]<d[lca] then
              begin
                ans:=max(ans,count(1,1,n,b[lca],b[v])); exit;
              end;
            ans:=max(ans,count(1,1,n,b[vl],b[v]));
            v:=vl;
          end else
          begin
            ans:=max(ans,w[e[v]]);
            v:=x[e[v]];
          end;
    end;
  procedure main;
    var c1,c2:char;
    begin
      read(c1);
      repeat
        repeat
          read(c2);
        until c2=' ';
        readln(x1,y1);
        if c1='Q' then
          begin
            lca:=find(x1,y1);
            ans:=0;
            wander(x1);
            wander(y1);
            writeln(ans);
          end else
          if u[x1] then
            begin
              if e[x[x1]]=-x1 then x1:=b[x[x1]] else x1:=b[x[-x1]];
              insert(1,1,n);
            end else
            begin
              w[x1]:=y1; w[-x1]:=y1;
            end;
        read(c1);
      until c1='D';
      readln;
    end;
begin
  readln(tt);
  for tt:=1 to tt do
    begin
      init;
      fillchar(u,sizeof(u),0);
      dfs1(0,1,0);
      tot:=1; l[1]:=1; n:=0;
      dfs2(1,0);
      build(1,1,n);
      main;
    end;
end.