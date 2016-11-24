program cost;
const
  maxd=2000000000;
var
  n,x,y,d,c,i:integer;
  mincost:longint;
  last:array[1..100] of integer;
  dist:array[1..100] of longint;
  u:array[1..100] of boolean;
  o:array[1..10000] of integer;
  r,w:array[1..100,1..100] of integer;
  procedure spfa;
    var q1,q2:integer;
    begin
      fillchar(dist,sizeof(dist),120);
      dist[1]:=0;
      fillchar(u,sizeof(u),0);
      q1:=0; q2:=1;
      o[1]:=1;
      repeat
        inc(q1);
        x:=o[q1];
        for i:=2 to n do
          if (x<>i)and(r[x,i]>0)and(dist[x]+w[x,i]<dist[i]) then
            begin
              dist[i]:=dist[x]+w[x,i];
              last[i]:=x;
              if not u[i] then
                begin
                  u[i]:=true;
                  inc(q2);
                  o[q2]:=i;
                end;
            end;
        u[x]:=false;
      until q1=q2;
    end;
  procedure add;
    var flow:longint;
    begin
      flow:=maxint;
      i:=n;
      while i>1 do
        begin
          if r[last[i],i]<flow then flow:=r[last[i],i];
          i:=last[i];
        end;
      i:=n;
      while i>1 do
        begin
          dec(r[last[i],i],flow);
          inc(r[i,last[i]],flow);
          i:=last[i];
        end;
      inc(mincost,flow*dist[n]);
    end;
begin
  readln(n);
  fillchar(r,sizeof(r),0);
  readln(x,y,d,c);
  repeat
    r[x,y]:=d;
    w[x,y]:=c;
    w[y,x]:=-c;
    readln(x,y,d,c);
  until x+y+d+c=0;
  mincost:=0;
  spfa;
  while dist[n]<maxd do
    begin
      add;
      spfa;
    end;
  write(mincost);
end.
