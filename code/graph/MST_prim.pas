program mintree_prim;
var
  ans:real;
  n,i,j:integer;
  a:array[1..100,1..100] of real;
  tree:array[1..100] of real;
  v:array[1..100] of integer;
  procedure init;
    var b:array[1..100,1..2] of integer;
    begin
      readln(n);
      for i:=1 to n do readln(b[i,1],b[i,2]);
      for i:=1 to n do
        for j:=1 to n do
          a[i,j]:=sqrt(sqr(b[i,1]-b[j,1])+sqr(b[i,2]-b[j,2]));
    end;
  procedure prim;
    var min,tl:real;
        k,tv:integer;
    begin
      for i:=2 to n do
        begin
          tree[i]:=a[1,i];
          v[i]:=i;
        end;
      for i:=2 to n do
        begin
          min:=tree[i];
          for j:=i+1 to n do
            if tree[j]<min then
              begin
                min:=tree[j];
                k:=j;
              end;
          if min<>tree[i] then
            begin
              tl:=tree[i]; tree[i]:=tree[k]; tree[k]:=tl;
              tv:=v[i]; v[i]:=v[j]; v[j]:=tv;
            end;
          ans:=ans+tree[i];
          for j:=i+1 to n do
            if a[v[i],j]<tree[j] then tree[j]:=a[v[i],j];
        end;
    end;
begin
  init;
  ans:=0;
  prim;
  writeln(ans:0:2);
end.