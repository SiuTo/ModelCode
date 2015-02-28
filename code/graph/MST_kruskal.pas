program mintree_kruskal;
type
  node=record
         x,y:integer;
         s:real;
       end;
var
  n,m,i,j:integer;
  k,ans:real;
  h:node;
  a:array[1..5000] of node;
  v:array[1..100] of integer;
  procedure init;
    var b:array[1..100,1..2] of integer;
    begin
      readln(n);
      m:=0;
      for i:=1 to n do
        begin
          readln(b[i,1],b[i,2]);
          for j:=1 to i-1 do
            begin
              inc(m);
              a[m].x:=i;
              a[m].y:=j;
              a[m].s:=sqrt(sqr(b[i,1]-b[j,1])+sqr(b[i,2]-b[j,2]));
            end;
        end;
    end;
  procedure kp(l,r:integer);
    var j:integer;
    begin
      i:=l; j:=r;
      k:=a[(l+r)div 2].s;
      repeat
        while a[i].s<k do inc(i);
        while a[j].s>k do dec(j);
        if i<=j then
          begin
            h:=a[i]; a[i]:=a[j]; a[j]:=h;
            inc(i); dec(j);
          end;
      until i>j;
      if i<r then kp(i,r);
      if j>l then kp(l,j);
    end;
  function find(x:integer):integer;
    var z,h:integer;
    begin
      z:=x;
      while v[x]>0 do x:=v[x];
      find:=x;
      while z<>x do
        begin
          h:=v[z];
          v[z]:=x;
          z:=h;
        end;
    end;
  procedure kruskal;
    var x,y:integer;
    begin
      j:=0;
      for i:=1 to n-1 do
        begin
          repeat
            inc(j);
            x:=find(a[i].x);
            y:=find(a[j].y);
          until x<>y;
          ans:=ans+a[j].s;
          v[x]:=y;
        end;
    end;
begin
  init;
  kp(1,m);
  ans:=0;
  fillchar(v,sizeof(v),0);
  kruskal;
  writeln(ans:0:2);
end.