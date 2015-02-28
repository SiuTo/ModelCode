program convex_hull;
//O(n^3)
type
  point=record
    x,y:longint;
  end;
var
  flag:boolean;
  n,i,j,k:longint;
  u:array[1..100] of boolean;
  p,a:array[1..100] of point;

  function mul(a,b,c:point):longint;
    begin
      mul:=(b.x-a.x)*(c.y-a.y)-(b.y-a.y)*(c.x-a.x);
    end;

begin
  assign(input,'input.in');
  reset(input);
  assign(output,'output.ans');
  rewrite(output);
  readln(n);
  k:=1;
  for i:=1 to n do
    begin
      readln(a[i].x,a[i].y);
      if a[i].y<a[k].y then k:=i;
    end;
  u[k]:=true; p[1]:=a[k]; k:=1;
  repeat
    flag:=false;
    for i:=1 to n do
      if not u[i] then
        begin
          flag:=true;
          for j:=1 to n do
            if mul(p[k],a[i],a[j])<0 then
              begin
                flag:=false; break;
              end;
          if flag then
            begin
              inc(k); p[k]:=a[i]; u[i]:=true; break;
            end;
        end;
  until not flag;
  for i:=1 to k do writeln(p[i].x,' ',p[i].y);
  close(input);
  close(output);
end.
