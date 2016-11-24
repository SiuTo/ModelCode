program get_one_euler;
var
  n,i,phi:longint;
begin
  readln(n);
  phi:=n;
  i:=1;
  while (n>1)and(i*i<=n) do
    begin
      inc(i);
      if n mod i=0 then
        begin
          while n mod i=0 do n:=n div i;
          phi:=phi div i*(i-1);
        end;
    end;
  if n>1 then phi:=phi div n*(n-1);
  writeln(phi);
end.