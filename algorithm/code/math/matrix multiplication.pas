type
  matrix=array[1..100,1..100] of longint;
var
  n,l,i,j,k:longint;
  ans,g:matrix;
  operator *(a,b:matrix)c:matrix;
    begin
      for i:=1 to n do
        for j:=1 to n do
          begin
            c[i,j]:=0;
            for k:=1 to n do inc(c[i,j],a[i,k]*b[k,j]);
          end;
    end;
  procedure power;
    begin
      ans:=g; dec(l);
      while l>0 do
        begin
          if odd(l) then ans:=ans*g;
          l:=l shr 1;
          g:=g*g;
        end;
    end;
begin
  readln(n,l);
  for i:=1 to n do
    begin
      for j:=1 to n do read(g[i,j]);
      readln;
    end;
  power;
  for i:=1 to n do
    begin
      for j:=1 to n do write(ans[i,j],' ');
      writeln;
    end;
end.