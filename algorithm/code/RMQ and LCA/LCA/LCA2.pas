{$M 100000000}
program LCA_online;
//O(n log n)-O(log n)
uses math;
type
  point=^node;
  node=record
    x:integer;
    link:point;
  end;
var
  p:point;
  n,q,i,k,x,y,z:integer;
  g:array[1..1000] of point;
  d,stack:array[-1..1000] of integer;
  f:array[1..1000,0..10] of integer;
  function log(x:integer):integer;
    begin
      if x=0 then exit(-1);
      log:=trunc(ln(x)/ln(2));
    end;
  procedure dfs(dep,v:integer);
    var p:point;
    begin
      d[v]:=dep;
      stack[dep]:=v;
      for i:=0 to log(dep) do f[v,i]:=stack[dep-1 shl i];
      p:=g[v];
      while p<>nil do
        begin
          if p^.x<>stack[dep-1] then dfs(dep+1,p^.x);
          p:=p^.link;
        end;
    end;
begin
  assign(input,'LCA.in');
  reset(input);
  assign(output,'LCA.ans');
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
  stack[-1]:=0;
  dfs(0,1);
  readln(q);
  for i:=1 to q do
    begin
      readln(x,y);
      if d[x]<d[y] then
        begin
          z:=x; x:=y; y:=z;
        end;
      while d[x]>d[y] do x:=f[x,log(d[x]-d[y])];
      if x<>y then
        begin
          k:=log(d[x]);
          while f[x,0]<>f[y,0] do
            if f[x,k]=f[y,k] then dec(k) else
              begin
                x:=f[x,k]; y:=f[y,k];
                k:=min(log(d[x]),k-1);
              end;
          x:=f[x,0];
        end;
      writeln(x);
    end;
  close(input);
  close(output);
end.
