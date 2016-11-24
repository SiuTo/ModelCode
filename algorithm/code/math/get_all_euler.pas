program get_all_euler;
var
  n,i,j,k:longint;
  u:array[1..10000] of boolean;
  phi:array[1..10000] of longint;
begin
  readln(n);
  fillchar(u,sizeof(u),1);
  u[1]:=false;
  for i:=1 to n do phi[i]:=i;
  for i:=2 to n do
    if u[i] then
      begin
        phi[i]:=i-1;
        for j:=2 to n div i do
          begin
            k:=i*j;
            u[k]:=false;
            phi[k]:=phi[k]div i*(i-1);
          end;
      end;
  for i:=1 to n do
    begin
      write(phi[i],' ');
      if i mod 10=0 then writeln;
    end;
end.