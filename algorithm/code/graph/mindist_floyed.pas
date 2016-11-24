program minn_n_floyed;
var
  n,i,j:integer;
  a:array[1..100,1..100] of integer;
  procedure floyed;
    var k:integer;
    begin
      for k:=1 to n do
        for i:=1 to n do
          for j:=1 to n do
            if a[i,k]+a[k,j]<a[i,j]
              then a[i,j]:=a[i,k]+a[k,j];
    end;
begin
  readln(n);
  for i:=1 to n do
    begin
      for j:=1 to n do read(a[i,j]);
      readln;
    end;
  floyed;
  writeln('Answer:');
  for i:=1 to n do
    begin
      for j:=1 to n-1 do write(a[i,j],' ');
      writeln(a[i,n]);
    end;
end.