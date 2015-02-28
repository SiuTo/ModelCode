program heapsort;
var
  n,i,t:integer;
  a:array[1..100] of integer;
  procedure heap(i,n:integer);
    var j:integer;
    begin
      t:=a[i]; j:=i*2;
      while j<=n do
        begin
          if (j<n)and(a[j]<a[j+1]) then inc(j);
          if a[j]>t then
            begin
              a[i]:=a[j]; i:=j; j:=i*2;
            end else break;
        end;
      a[i]:=t;
    end;
begin
  readln(n);
  for i:=1 to n do read(a[i]);
  for i:=n div 2 downto 1 do heap(i,n);
  for i:=n downto 2 do
    begin
      t:=a[1];
      a[1]:=a[i];
      a[i]:=t;
      heap(1,i-1);
    end;
  for i:=1 to n do write(a[i],' ');
  writeln;
end.