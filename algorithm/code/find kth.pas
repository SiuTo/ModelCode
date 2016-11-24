var
  n,k,i,mid:longint;
  a:array[0..100000] of longint;
  procedure select(l,r:longint);
    var i,j:longint;
    begin
      if l=r then exit;
      i:=l; j:=r;
      mid:=a[(l+r)shr 1];
      repeat
        while a[i]<mid do inc(i);
        while a[j]>mid do dec(j);
        if i<=j then
          begin
            a[0]:=a[i]; a[i]:=a[j]; a[j]:=a[0];
            inc(i); dec(j);
          end;
      until i>j;
      if k<=j then select(l,j) else
        if k>=i then select(i,r);
    end;
begin
  readln(n,k);
  for i:=1 to n do read(a[i]);
  readln;
  select(1,n);
  writeln(a[k]);
end.