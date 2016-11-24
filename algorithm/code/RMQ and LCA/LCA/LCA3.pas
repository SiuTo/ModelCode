{$M 100000000}
program LCA_RMQ_st;
//O(n)-O(n log n)-O(1)
type
  arr=array[0..1] of integer;
  point=^node;
  node=record
    x:integer;
    link:point;
  end;
var
  ans:arr;
  p:point;
  n,i,x,y,k:integer;
  a:array[1..1000] of integer;
  g:array[1..1000] of point;
  f:array[1..2000,0..11] of arr;
  procedure dfs(dep,v,fa:integer);
    var p:point;
    begin
      p:=g[v];
      if p^.link=nil then
        begin
          inc(n);
          f[n,0,0]:=dep;
          f[n,0,1]:=v;
        end;
      while p<>nil do
        begin
          if p^.x<>fa then
            begin
              dfs(dep+1,p^.x,v);
              inc(n);
              f[n,0,0]:=dep;
              f[n,0,1]:=v;
            end;
          p:=p^.link;
        end;
      a[v]:=n;
    end;
  function min(a,b:arr):arr;
    begin
      if a[0]<b[0] then min:=a else min:=b;
    end;
  procedure st;
    var j:integer;
    begin
      for j:=1 to trunc(ln(n)/ln(2)) do
        for i:=1 to n-1 shl j+1 do
          f[i,j]:=min(f[i,j-1],f[i+1 shl(j-1),j-1]);
    end;
begin
  assign(input,'LCA.in');
  reset(input);
  assign(output,'LCA1.out');
  rewrite(output);
  readln(n);
  for i:=1 to n-1 do
    begin
      readln(x,y);
      new(p);
      p^.x:=y; p^.link:=g[x]; g[x]:=p;
      new(p);
      p^.x:=x; p^.link:=g[y]; g[y]:=p;
    end;
  n:=0;
  dfs(1,1,0);
  st;
  readln(n);
  for i:=1 to n do
    begin
      readln(x,y);
      x:=a[x]; y:=a[y];
      if x>y then
        begin
          k:=x; x:=y; y:=k;
        end;
      k:=trunc(ln(y-x+1)/ln(2));
      ans:=min(f[x,k],f[y-1 shl k+1,k]);
      writeln(ans[1]);
    end;
  close(input);
  close(output);
end.