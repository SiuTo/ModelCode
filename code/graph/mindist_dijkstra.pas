program min1_n_dijkstra;
const
  n=6;
  max=30840;
  cost:array[1..n,1..n] of integer=
    ((0,50,10,max,45,max),
    (max,0,15,max,10,max),
    (20,max,0,15,max,max),
    (max,20,max,0,35,max),
    (max,max,max,30,0,max),
    (max,max,max,3,max,0));
var
  x,i:integer;
  dist:array[1..n] of integer;
  f:array[1..n] of boolean;
  procedure dijkstra(x:integer);
    var j,x1,min:integer;
    begin
      for i:=1 to n-1 do
        begin
          min:=max;
          for j:=1 to n do
            if not f[j] then
              begin
                if dist[x]+cost[x,j]<dist[j]
                  then dist[j]:=dist[x]+cost[x,j];
                if dist[j]<min then
                  begin
                    min:=dist[j];
                    x1:=j;
                  end;
              end;
          x:=x1;
          f[x]:=true;
        end;
    end;
begin
  readln(x);
  fillchar(dist,sizeof(dist),120);
  dist[x]:=0;
  fillchar(f,sizeof(f),0);
  f[x]:=true;
  dijkstra(x);
  for i:=1 to n do
    if i<>x then
      begin
        write('mindist(',x,',',i,'):');
        if dist[i]=max then writeln('No answer')
          else writeln(dist[i]);
      end;
end.