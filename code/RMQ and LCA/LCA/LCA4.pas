program LCA;
//O(n^2)-O(1)
type
  point=^node;
  node=record
    x:integer;
    link:point;
  end;
var
  p:point;
  n,i,x,y:integer;
  fa,o:array[1..1000] of integer;
  g:array[1..1000] of point;
  f:array[1..1000,1..1000] of integer;
  procedure bfs;
    var q1,q2,v:integer;
    begin
      o[1]:=1;
      q1:=0; q2:=1;
      repeat
        inc(q1);
        v:=o[q1];
        for i:=1 to q1-1 do
          begin
            f[v,o[i]]:=f[fa[v],o[i]];
            f[o[i],v]:=f[v,o[i]];
          end;
        f[v,v]:=v;
        p:=g[v];
        while p<>nil do
          begin
            if p^.x<>fa[v] then
              begin
                inc(q2); o[q2]:=p^.x;
                fa[p^.x]:=v;
              end;
            p:=p^.link;
          end;
      until q1=q2;
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
  bfs;
  readln(n);
  for i:=1 to n do
    begin
      readln(x,y);
      writeln(f[x,y]);
    end;
  close(input);
  close(output);
end.