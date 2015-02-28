program CQ2011_inverse;
const
  maxn=100000;
var
  ans:int64;
  n,m,i,j,k,num,tot:longint;
  a,b,q:array[1..maxn] of longint;
  t:array[1..maxn*4] of longint;
  s,l,r,key:array[0..maxn*20] of longint;
  procedure mergesort(l,r:longint);
    var mid:longint;
    begin
      if l=r then exit;
      mid:=(l+r)shr 1;
      mergesort(l,mid);
      mergesort(mid+1,r);
      i:=l; j:=mid+1; k:=l;
      repeat
        if a[i]<a[j] then
          begin
            b[k]:=a[i]; inc(i);
            inc(ans,j-mid-1);
          end else
          begin
            b[k]:=a[j]; inc(j);
          end;
        inc(k);
      until (i>mid)or(j>r);
      while i<=mid do
        begin
          b[k]:=a[i];
          inc(i); inc(k);
          inc(ans,j-mid-1);
        end;
      while j<=r do
        begin
          b[k]:=a[j];
          inc(j); inc(k);
        end;
      move(b[l],a[l],(r-l+1)*4);
    end;
  procedure l_rotate(var v:longint);
    begin
      k:=r[v];
      r[v]:=l[k];
      l[k]:=v;
      s[k]:=s[v];
      s[v]:=s[l[v]]+s[r[v]]+1;
      v:=k;
    end;
  procedure r_rotate(var v:longint);
    begin
      k:=l[v];
      l[v]:=r[k];
      r[k]:=v;
      s[k]:=s[v];
      s[v]:=s[l[v]]+s[r[v]]+1;
      v:=k;
    end;
  procedure insert(var v:longint);
    begin
      if v=0 then
        begin
          inc(tot);
          v:=tot;
          s[v]:=1;
          key[v]:=num;
          l[v]:=0; r[v]:=0;
          exit;
        end;
      inc(s[v]);
      if num<key[v] then
        begin
          insert(l[v]);
          if s[l[l[v]]]>s[r[v]] then r_rotate(v);
        end else
        begin
          insert(r[v]);
          if s[r[r[v]]]>s[l[v]] then l_rotate(v);
        end;
    end;
  procedure build(p,l,r:longint);
    var mid:longint;
    begin
      for i:=l to r do
        begin
          num:=a[i];
          insert(t[p]);
        end;
      if l=r then exit;
      mid:=(l+r)shr 1;
      build(p*2,l,mid);
      build(p*2+1,mid+1,r);
    end;
  function cal1(v:longint):longint;
    begin
      if v=0 then exit(0);
      if num<key[v] then cal1:=cal1(l[v])+s[r[v]]+1 else cal1:=cal1(r[v]);
    end;
  function count1(p,l,r,x,y:longint):longint;
    var mid:longint;
    begin
      if (l=x)and(r=y) then exit(cal1(t[p]));
      mid:=(l+r)shr 1;
      if y<=mid then exit(count1(p*2,l,mid,x,y));
      if x>mid then exit(count1(p*2+1,mid+1,r,x,y));
      count1:=count1(p*2,l,mid,x,mid)+count1(p*2+1,mid+1,r,mid+1,y);
    end;
  function cal2(v:longint):longint;
    begin
      if v=0 then exit(0);
      if num<=key[v] then cal2:=cal2(l[v]) else cal2:=s[l[v]]+1+cal2(r[v]);
    end;
  function count2(p,l,r,x,y:longint):longint;
    var mid:longint;
    begin
      if (l=x)and(r=y) then exit(cal2(t[p]));
      mid:=(l+r)shr 1;
      if y<=mid then exit(count2(p*2,l,mid,x,y));
      if x>mid then exit(count2(p*2+1,mid+1,r,x,y));
      count2:=count2(p*2,l,mid,x,mid)+count2(p*2+1,mid+1,r,mid+1,y);
    end;
  function delete(var v:longint):longint;
    begin
      dec(s[v]);
      if num=key[v] then
        begin
          if (l[v]=0)or(r[v]=0) then v:=l[v]+r[v] else key[v]:=delete(l[v]);
          exit;
        end;
      if (num>key[v])and(r[v]=0) then
        begin
          delete:=key[v];
          v:=l[v];
          exit;
        end;
      if num<key[v] then delete:=delete(l[v]) else delete:=delete(r[v]);
    end;
  procedure change(p,l,r:longint);
    var mid:longint;
    begin
      delete(t[p]);
      if l=r then exit;
      mid:=(l+r)shr 1;
      if q[num]<=mid then change(p*2,l,mid) else change(p*2+1,mid+1,r);
    end;
begin
  readln(n,m);
  for i:=1 to n do
    begin
      readln(a[i]); q[a[i]]:=i;
    end;
  tot:=0;
  fillchar(t,sizeof(t),0);
  build(1,1,n);
  ans:=0;
  mergesort(1,n);
  for m:=1 to m-1 do
    begin
      writeln(ans);
      readln(num);
      if q[num]>1 then dec(ans,count1(1,1,n,1,q[num]-1));
      if q[num]<n then dec(ans,count2(1,1,n,q[num]+1,n));
      change(1,1,n);
    end;
  writeln(ans);
end.