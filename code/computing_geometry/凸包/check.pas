type
  point=record
    x,y:longint;
  end;
var
  flag:boolean;
  n,m,i:longint;
  p,p1:point;
  a:array[1..101] of point;
  function min(x,y:longint):longint;
    begin
      if x<y then min:=x else min:=y;
    end;
  function max(x,y:longint):longint;
    begin
      if x>y then max:=x else max:=y;
    end;
  function mul(a,b,c:point):longint;
    begin
      mul:=(b.x-a.x)*(c.y-a.y)-(b.y-a.y)*(c.x-a.x);
    end;
  function get(x:longint):longint;
    begin
      if x=0 then get:=0 else
        if x<0 then get:=-1 else get:=1;
    end;
  function online(p,p1,p2:point):boolean;
    begin
      if not((p.x>=min(p1.x,p2.x))and(p.x<=max(p1.x,p2.x))
          and(p.y>=min(p1.y,p2.y))and(p.y<=max(p1.y,p2.y))) then exit(false);
      online:=mul(p,p1,p2)=0;
    end;
  function within:boolean;
    var i,count:longint;
    begin
      count:=0;
      for i:=1 to n do
        begin
          if online(p,a[i],a[i+1]) then exit(true);
          if a[i].y=a[i+1].y then continue;
          if (a[i].x<=p.x)and(a[i].y=p.y) then
            begin
              if a[i].y>a[i+1].y then inc(count); continue;
            end;
          if (a[i+1].x<=p.x)and(a[i+1].y=p.y) then
            begin
              if a[i+1].y>a[i].y then inc(count); continue;
            end;
          p1.x:=min(a[i].x,a[i+1].x); p1.y:=p.y;
          if (p1.x<=p.x)and(get(a[i].y-p.y)*get(a[i+1].y-p.y)<0)and
            (get(mul(a[i],a[i+1],p))*get(mul(a[i],a[i+1],p1))<=0) then inc(count);
        end;
      within:=odd(count);
    end;
begin
  assign(input,'output.out');
  reset(input);
  n:=0;
  repeat
    inc(n); readln(a[n].x,a[n].y);
  until eof;
  a[n+1]:=a[1];
  close(input);
  assign(input,'input.in');
  reset(input);
  readln(m);
  flag:=true;
  for i:=1 to m do
    begin
      readln(p.x,p.y);
      if not within then
        begin
          flag:=false; break;
        end;
    end;
  close(input);
  if flag then write('AC   ') else
    begin
      writeln('WA');
      writeln(i);
      while true do;
    end;
end.
