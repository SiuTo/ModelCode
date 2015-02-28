{$M 100000000}
program atm_APIO2009;
const
  maxn=500000;
type
  point=^node;
  node=record
    x:longint;
    link:point;
  end;
var
  p:point;
  n,m,s,k,i,q1,q2,ans,x,y,dfn,dfm:longint;
  g1,g2,g3,g4:array[1..maxn] of point;
  o,w,a,e,u,f,into:array[1..maxn] of longint;
  procedure insert(var gx:point; y:longint);
    begin
      new(p); p^.x:=y; p^.link:=gx; gx:=p;
    end;
  procedure init;
    begin
      readln(n,m);
      for i:=1 to m do
        begin
          readln(x,y);
          insert(g1[x],y);
          insert(g2[y],x);
        end;
      for i:=1 to n do readln(a[i]);
      readln(s,k);
      for i:=1 to k do read(e[i]);
      readln;
    end;
  procedure dfs1(v:longint);
    var p:point;
    begin
      u[v]:=0;
      p:=g1[v];
      while p<>nil do
        begin
          if u[p^.x]=-1 then dfs1(p^.x);
          p:=p^.link;
        end;
      inc(dfm);
      o[dfm]:=v;
    end;
  procedure dfs2(v:longint);
    var p:point;
    begin
      u[v]:=dfn;
      inc(w[dfn],a[v]);
      p:=g2[v];
      while p<>nil do
        begin
          if u[p^.x]=0 then dfs2(p^.x) else
            if (u[p^.x]>0)and(u[p^.x]<dfn) then
              begin
                inc(into[dfn]);
                insert(g3[u[p^.x]],dfn);
                insert(g4[dfn],u[p^.x]);
              end;
          p:=p^.link;
        end;
    end;
  procedure getgraph;
    begin
      dfm:=0;
      fillchar(u,sizeof(u),255);
      dfs1(s);
      dfn:=0;
      fillchar(into,sizeof(into),0);
      for i:=dfm downto 1 do
        if u[o[i]]=0 then
          begin
            inc(dfn);
            w[dfn]:=0;
            dfs2(o[i]);
          end;
    end;
  procedure sort;
    begin
      q1:=0; q2:=1; o[1]:=u[s];
      repeat
        inc(q1);
        x:=o[q1];
        p:=g3[x];
        while p<>nil do
          begin
            dec(into[p^.x]);
            if into[p^.x]=0 then
              begin
                inc(q2);
                o[q2]:=p^.x;
              end;
            p:=p^.link;
          end;
      until q1=q2;
    end;
  procedure dp;
    begin
      fillchar(f,sizeof(f),0);
      for i:=1 to dfn do
        begin
          x:=o[i];
          p:=g4[x];
          while p<>nil do
            begin
              if f[p^.x]>f[x] then f[x]:=f[p^.x];
              p:=p^.link;
            end;
          inc(f[x],w[x]);
        end;
    end;
begin
  init;
  getgraph;
  sort;
  dp;
  ans:=0;
  for i:=1 to k do
    if (u[e[i]]>0)and(f[u[e[i]]]>ans) then ans:=f[u[e[i]]];
  writeln(ans);
end.