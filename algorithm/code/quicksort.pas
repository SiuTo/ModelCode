var
  n,i,mid:longint;
  a:array[0..100000] of longint;
  procedure qsort(l,r:longint);
    var i,j:longint;
    begin
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
      if i<r then qsort(i,r);
      if j>l then qsort(l,j);
    end;
begin
  readln(n);
  for i:=1 to n do read(a[i]);
  readln;
  qsort(1,n);
  for i:=1 to n do write(a[i],' ');
  writeln;
end.