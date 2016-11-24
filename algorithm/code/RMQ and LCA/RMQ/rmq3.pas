{$M 100000000}
program RMQ_LCA_tarjan;
//O(n)-O(n+q)
type
  point=^node;
  node=record
    x,t:integer;
    l,r:point;
  end;
var
  p,q,root:point;
  n,i,x,y:integer;
  a,u,ans:array[1..1000] of integer;
  g:array[1..1000] of point;
  procedure create;
    var q1:point;
    begin
      readln(n);
      root:=nil;
      for i:=1 to n do
        begin
          read(a[i]);
          new(p);
          p^.x:=a[i];
          p^.t:=i;
          q:=root;
          while (q<>nil)and(p^.x>q^.x) do
            begin
              q1:=q;
              q:=q^.r;
            end;
          if q=root then root:=p else q1^.r:=p;
          p^.l:=q; p^.r:=nil;
        end;
      readln;
    end;
  function find(x:integer):integer;
    var h:integer;
    begin
      y:=x;
      while u[x]<>x do x:=u[x];
      find:=x;
      while y<>x do
        begin
          h:=u[y];
          u[y]:=x;
          y:=h;
        end;
    end;
  procedure dfs(p:point);
    begin
      with p^ do
        begin
          u[t]:=t;
          if l<>nil then
            begin
              dfs(l);
              u[l^.t]:=t;
            end;
          if r<>nil then
            begin
              dfs(r);
              u[r^.t]:=t;
            end;
        end;
      q:=g[p^.t];
      while q<>nil do
        begin
          if u[q^.x]>0 then ans[q^.t]:=a[find(q^.x)];
          q:=q^.l;
        end;
    end;
begin
  assign(input,'RMQ.in');
  reset(input);
  assign(output,'RMQ1.out');
  rewrite(output);
  create;
  readln(n);
  for i:=1 to n do
    begin
      readln(x,y);
      new(p);
      p^.x:=y; p^.t:=i; p^.l:=g[x]; g[x]:=p;
      new(p);
      p^.x:=x; p^.t:=i; p^.l:=g[y]; g[y]:=p;
    end;
  dfs(root);
  for i:=1 to n do writeln(ans[i]);
  close(input);
  close(output);
end.
