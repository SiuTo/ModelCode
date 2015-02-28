program rmq_st;
//O(n log n)-O(1)
uses math;
var
  n,i,j,x,y,k:integer;
  f:array[1..1000,0..9] of integer;
begin
  assign(input,'rmq.in');
  reset(input);
  assign(output,'rmq1.out');
  rewrite(output);
  readln(n);
  for i:=1 to n do read(f[i,0]);
  readln;
  for j:=1 to trunc(ln(n)/ln(2)) do
    for i:=1 to n-1 shl j+1 do
      f[i,j]:=min(f[i,j-1],f[i+1 shl(j-1),j-1]);
  readln(n);
  for i:=1 to n do
    begin
      readln(x,y);
      k:=trunc(ln(y-x+1)/ln(2));
      writeln(min(f[x,k],f[y-1 shl k+1,k]));
    end;
  close(input);
  close(output);
end.