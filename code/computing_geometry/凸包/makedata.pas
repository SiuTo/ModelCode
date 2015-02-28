program makedata;
const
  n=100; max=1000;
var
  i:longint;
begin
  randomize;
  assign(output,'input.in');
  rewrite(output);
  writeln(n);
  for i:=1 to n do writeln(random(max*2)-max,' ',random(max*2)-max);
  close(output);
end.
