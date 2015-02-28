type
  point=^node;
  node=record
    x:longint;
    link:point;
  end;
const
  maxn=1000;
var
  p:point;
  n,i,x,y,v,top,dfn:longint;
  a,o,fa:array[1..maxn] of longint;
  g,next:array[1..maxn] of point;
  procedure dfs;
    begin
      top:=1; o[top]:=1; fa[1]:=0;
      dfn:=1; a[1]:=1;
      next:=g;
      repeat
        v:=o[top]; p:=next[v];
        if p=nil then dec(top) else
          begin
            if p^.x<>fa[v] then
              begin
                inc(dfn); a[dfn]:=p^.x;
                inc(top); o[top]:=p^.x; fa[p^.x]:=v;
              end;
            next[v]:=p^.link;
          end;
      until top=0;
    end;
begin
  readln(n);
  for i:=1 to n-1 do
    begin
      readln(x,y);
      new(p); p^.x:=y; p^.link:=g[x]; g[x]:=p;
      new(p); p^.x:=x; p^.link:=g[y]; g[y]:=p;
    end;
  dfs;
  for i:=1 to n do write(a[i],' ');
  writeln;
end.