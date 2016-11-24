program SDOI2011_paint;
const
  maxn=100000;
var
  ch1,ch2:char;
  u1,v1,n,m,i,x1,y1,dep,top,v,p,fa,tot,k,z,c1,vl,lca,lastc,ans,lc,rc:longint;
  u:array[1..maxn] of boolean;
  t:array[1..maxn*4,1..4] of longint;
  c,g,last,stack,s,d,mson,l,o,a,b:array[-1..maxn] of longint;
  f:array[1..maxn,0..trunc(ln(maxn)/ln(2))] of longint;
  x,next:array[-maxn..maxn] of longint;
  procedure init;
    var u,v:longint;
    begin
      readln(n,m);
      for i:=1 to n do read(c[i]);
      readln;
      fillchar(g,sizeof(g),0);
      for i:=1 to n-1 do
        begin
          readln(u1,v1);
          x[i]:=v1; next[i]:=g[u1]; g[u1]:=i;
          x[-i]:=u1; next[-i]:=g[v1]; g[v1]:=-i;
        end;
    end;
  function min(x,y:longint):longint;
    begin
      if x<y then min:=x else min:=y;
    end;
  function log(num:longint):longint;
    begin
      if num=0 then log:=-1 else log:=trunc(ln(num)/ln(2));
    end;
  procedure dfs1;
    begin
      dep:=0; stack[0]:=1; stack[-1]:=0;  s[0]:=0; s[1]:=1; d[1]:=0; last:=g;
      fillchar(mson,sizeof(mson),0);
      repeat
        v:=stack[dep]; p:=last[v]; fa:=stack[dep-1];
        for i:=0 to log(dep) do f[v,i]:=stack[dep-1 shl i];
        if p=0 then
          begin
            inc(s[fa],s[v]);
            if s[v]>s[mson[fa]] then mson[fa]:=v;
            dec(dep);
          end else
          if x[p]=fa then last[v]:=next[p] else
            begin
              inc(dep);
              stack[dep]:=x[p];
              s[x[p]]:=1;
              d[x[p]]:=dep;
              last[v]:=next[p];
            end;
      until dep<0;
    end;
  procedure dfs2;
    begin
      top:=1; stack[1]:=1;
      tot:=1; l[tot]:=1; n:=1; o[1]:=1; a[1]:=1; b[1]:=1;
      fillchar(u,sizeof(u),0); u[1]:=true;
      repeat
        v:=stack[top];
        if s[v]=1 then
          begin
            dec(top); continue;
          end;
        if not u[mson[v]] then
          begin
            x1:=mson[v];
            u[x1]:=true;
            inc(n); a[x1]:=tot; b[x1]:=n; o[n]:=x1;
            inc(top); stack[top]:=x1;
            continue;
          end;
        p:=g[v];
        if p=0 then dec(top) else
          if u[x[p]] then g[v]:=next[p] else
            begin
              u[x[p]]:=true;
              inc(top); stack[top]:=x[p];
              inc(tot); inc(n);
              a[x[p]]:=tot; b[x[p]]:=n; o[n]:=x[p]; l[tot]:=x[p];
            end;
      until top=0;
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
  procedure build(p,l,r:longint);
    var mid,p1:longint;
    begin
      t[p,4]:=0;
      if l=r then
        begin
          t[p,1]:=c[o[l]]; t[p,2]:=c[o[l]]; t[p,3]:=1;
          exit;
        end;
      mid:=(l+r)shr 1;
      p1:=p shl 1;
      build(p1,l,mid);
      build(p1+1,mid+1,r);
      t[p,1]:=t[p1,1]; t[p,2]:=t[p1+1,2];
      t[p,3]:=t[p1,3]+t[p1+1,3];
      if t[p1,2]=t[p1+1,1] then dec(t[p,3]);
    end;
  procedure updata(p:longint);
    var c,p1:longint;
    begin
      if t[p,4]=0 then exit;
      p1:=p shl 1;
      c:=t[p,4];
      t[p1,1]:=c; t[p1,2]:=c; t[p1,3]:=1; t[p1,4]:=c;
      t[p1+1,1]:=c; t[p1+1,2]:=c; t[p1+1,3]:=1; t[p1+1,4]:=c;
      t[p,4]:=0;
    end;
  procedure insert(p,l,r,x,y:longint);
    var mid,p1:longint;
    begin
      if (l=x)and(r=y) then
        begin
          t[p,1]:=c1; t[p,2]:=c1; t[p,3]:=1; t[p,4]:=c1;
          exit;
        end;
      updata(p);
      mid:=(l+r)shr 1;
      p1:=p shl 1;
      if y<=mid then insert(p1,l,mid,x,y) else
        if x>mid then insert(p1+1,mid+1,r,x,y) else
          begin
            insert(p1,l,mid,x,mid);
            insert(p1+1,mid+1,r,mid+1,y);
          end;
      t[p,1]:=t[p1,1]; t[p,2]:=t[p1+1,2];
      t[p,3]:=t[p1,3]+t[p1+1,3];
      if t[p1,2]=t[p1+1,1] then dec(t[p,3]);
    end;
  procedure wander1(v:longint);
    begin
      repeat
        vl:=l[a[v]];
        if d[lca]>=d[vl] then
          begin
            insert(1,1,n,b[lca],b[v]); exit;
          end;
        insert(1,1,n,b[vl],b[v]);
        v:=f[vl,0];
      until d[v]<d[lca];
    end;
  function count(p,l,r,x,y:longint; var lc,rc:longint):longint;
    var mid,p1,lc1,lc2,rc1,rc2:longint;
    begin
      if (l=x)and(r=y) then
        begin
          lc:=t[p,1]; rc:=t[p,2];
          exit(t[p,3]);
        end;
      updata(p);
      mid:=(l+r)shr 1;
      p1:=p shl 1;
      if y<=mid then exit(count(p1,l,mid,x,y,lc,rc));
      if x>mid then exit(count(p1+1,mid+1,r,x,y,lc,rc));
      count:=count(p1,l,mid,x,mid,lc1,rc1)+count(p1+1,mid+1,r,mid+1,y,lc2,rc2);
      if rc1=lc2 then dec(count);
      lc:=lc1; rc:=rc2;
    end;
  procedure wander2(v:longint);
    begin
      lastc:=0;
      repeat
        vl:=l[a[v]];
        if d[lca]>=d[vl] then
          begin
            inc(ans,count(1,1,n,b[lca],b[v],lc,rc));
            if rc=lastc then dec(ans);
            exit;
          end;
        inc(ans,count(1,1,n,b[vl],b[v],lc,rc));
        if rc=lastc then dec(ans);
        lastc:=lc;
        v:=f[vl,0];
      until d[v]<d[lca];
    end;
begin
  init;
  dfs1;
  dfs2;
  build(1,1,n);
  for m:=1 to m do
    begin
      read(ch1,ch2,x1,y1);
      lca:=find(x1,y1);
      if ch1='C' then
        begin
          read(c1);
          wander1(x1);
          wander1(y1);
        end else
        begin
          ans:=-1;
          wander2(x1);
          wander2(y1);
          writeln(ans);
        end;
      readln;
    end;
end.