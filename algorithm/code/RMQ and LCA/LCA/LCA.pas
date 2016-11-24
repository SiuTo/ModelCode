{$M 100000000}
program LCA;
//O(n)-O(n)
type
  point=^node;
  node=record
    x:integer;
    link:point;
  end;
var
  p:point;
  n,q,i,x,y:integer;
  g:array[1..1000] of point;
  dad:array[1..1000] of integer;
  u:array[1..1000] of boolean;
  procedure dfs(v,fa:integer);
    var p:point;
    begin
      dad[v]:=fa;
      p:=g[v];
      while p<>nil do
        begin
          if p^.x<>fa then dfs(p^.x,v);
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
  dfs(1,0);
  readln(q);
  for i:=1 to q do
    begin
      readln(x,y);
      fillchar(u,sizeof(u),0);
      repeat
        u[x]:=true;
        x:=dad[x];
      until x=0;
      while not u[y] do y:=dad[y];
      writeln(y);
    end;
  close(input);
  close(output);
end.
