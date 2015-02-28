program LCA_tarjan;
//O(n+q)
type
  point=^node;
  node=record
    x,t:integer;
    link:point;
  end;
var
  n,m,i,x,y:integer;
  g,q:array[1..1000] of point;
  ans,u:array[1..1000] of integer;
  procedure insert(var pp:point; v:integer);
    var p:point;
    begin
      new(p);
      p^.x:=v;
      p^.link:=pp;
      pp:=p;
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
  procedure dfs(v,fa:integer);
    var p:point;
    begin
      u[v]:=v;
      p:=g[v];
      while p<>nil do
        begin
          if p^.x<>fa then
            begin
              dfs(p^.x,v);
              u[p^.x]:=v;
            end;
          p:=p^.link;
        end;
      p:=q[v];
      while p<>nil do
        begin
          if u[p^.x]>0 then ans[p^.t]:=find(p^.x);
          p:=p^.link;
        end;
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
      insert(g[x],y);
      insert(g[y],x);
    end;
  readln(m);
  for i:=1 to m do
    begin
      readln(x,y);
      insert(q[x],y); q[x]^.t:=i;
      insert(q[y],x); q[y]^.t:=i;
    end;
  fillchar(u,sizeof(u),0);
  dfs(1,0);
  for i:=1 to m do writeln(ans[i]);
  close(input);
  close(output);
end.