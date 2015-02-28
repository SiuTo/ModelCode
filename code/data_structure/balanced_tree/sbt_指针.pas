program GDKOI2011_park;
type
  point=^node;
  node=record
    x,y,s:longint;
    l,r:point;
  end;
var
  v,p:point;
  t:array[0..1] of point;
  n,m,i,x,y,x1,x2,y1,y2,ans:longint;
  procedure left_rotate(var p:point);
    begin
      v:=p^.r;
      p^.r:=v^.l;
      v^.l:=p;
      v^.s:=p^.s;
      p^.s:=1;
      if p^.l<>nil then inc(p^.s,p^.l^.s);
      if p^.r<>nil then inc(p^.s,p^.r^.s);
      p:=v;
    end;
  procedure right_rotate(var p:point);
    begin
      v:=p^.l;
      p^.l:=v^.r;
      v^.r:=p;
      v^.s:=p^.s;
      p^.s:=1;
      if p^.l<>nil then inc(p^.s,p^.l^.s);
      if p^.r<>nil then inc(p^.s,p^.r^.s);
      p:=v;
    end;
  procedure insert(var p:point; x,y:longint);
    begin
      if p=nil then
        begin
          new(p);
          p^.l:=nil; p^.r:=nil;
          p^.s:=1;
          p^.x:=x; p^.y:=y;
          exit;
        end;
      inc(p^.s);
      if (x<p^.x)or(x=p^.x)and(y<p^.y) then
        begin
          insert(p^.l,x,y);
          if (p^.l^.l<>nil)and((p^.r=nil)or(p^.l^.l^.s>p^.r^.s)) then right_rotate(p);
        end else
        begin
          insert(p^.r,x,y);
          if (p^.r^.r<>nil)and((p^.l=nil)or(p^.r^.r^.s>p^.l^.s)) then left_rotate(p);
        end;
    end;
  function succ(p:point; x,y:longint):point;
    begin
      if (p=nil)or(x=p^.x)and(y=p^.y) then exit(p);
      if (x>p^.x)or(x=p^.x)and(y>p^.y) then exit(succ(p^.r,x,y));
      succ:=succ(p^.l,x,y);
      if succ=nil then succ:=p;
    end;
  function delete(var p:point; x,y:longint):point;
    begin
      dec(p^.s);
      if (x=p^.x)and(y=p^.y) then
        begin
          if p^.l=nil then p:=p^.r else
            if p^.r=nil then p:=p^.l else
              begin
                v:=delete(p^.l,x+1,y);
                p^.x:=v^.x; p^.y:=v^.y;
              end;
          exit;
        end;
      if (x<p^.x)or(x=p^.x)and(y<p^.y) then delete:=delete(p^.l,x,y) else
        if p^.r<>nil then delete:=delete(p^.r,x,y) else
          begin
            delete:=p;
            p:=p^.l;
          end;
    end;
  procedure count(q,x,y1,y2:longint);
    begin
      p:=succ(t[q],x,y1);
      while (p<>nil)and(p^.x=x)and(p^.y<=y2) do
        begin
          inc(ans);
          y1:=p^.y;
          delete(t[q],x,y1);
          delete(t[1-q],y1,x);
          p:=succ(t[q],x,y1);
        end;
    end;
begin
  readln(n,m);
  t[0]:=nil; t[1]:=nil;
  for i:=1 to n do
    begin
      readln(x,y);
      insert(t[0],x,y);
      insert(t[1],y,x);
    end;
  for i:=1 to m do
    begin
      readln(x1,y1,x2,y2);
      ans:=0;
      count(0,x1,y1,y2);
      count(0,x2,y1,y2);
      count(1,y1,x1,x2);
      count(1,y2,x1,x2);
      writeln(ans);
    end;
end.