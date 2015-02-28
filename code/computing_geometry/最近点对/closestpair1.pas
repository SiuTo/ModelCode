program closestpair;
//O(n^2)
type
  point=record
    x,y:longint;
  end;
var
  n,i,j,min,dist:longint;
  a:array[1..10000] of point;

begin
  assign(input,'input.in');
  reset(input);
  assign(output,'output.ans');
  rewrite(output);
  readln(n);
  for i:=1 to n do readln(a[i].x,a[i].y);
  min:=maxlongint;
  for i:=1 to n-1 do
    for j:=i+1 to n do
      begin
        dist:=sqr(a[i].x-a[j].x)+sqr(a[i].y-a[j].y);
        if dist<min then min:=dist;
      end;
  writeln(sqrt(min):0:2);
  close(input);
  close(output);
end.
