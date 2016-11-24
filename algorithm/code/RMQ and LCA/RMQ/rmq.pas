program rmq;
//O(nq)
var
  n,i,j,l,r,min:integer;
  a:array[1..1000] of integer;
begin
  assign(input,'rmq.in');
  reset(input);
  assign(output,'rmq.ans');
  rewrite(output);
  readln(n);
  for i:=1 to n do read(a[i]);
  readln;
  readln(n);
  for i:=1 to n do
    begin
      readln(l,r);
      min:=maxint;
      for j:=l to r do
        if a[j]<min then min:=a[j];
      writeln(min);
    end;
  close(input);
  close(output);
end.
