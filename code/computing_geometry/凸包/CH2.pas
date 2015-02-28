program CH2;
//O(n log n)
type
  point=record
    x,y:longint;
  end;
var
  n,i,k,top:longint;
  mid:point;
  a:array[0..100000] of point;

  procedure swap(var a,b:point);
    var c:point;
    begin
      c:=a; a:=b; b:=c;
    end;

  function mul(a,b,c:point):longint;
    begin
      mul:=(b.x-a.x)*(c.y-a.y)-(b.y-a.y)*(c.x-a.x);
    end;
    
  function dist(a,b:point):longint;
    begin
      dist:=sqr(a.x-b.x)+sqr(a.y-b.y);
    end;

  procedure qsort(l,r:longint);
    var j:longint;
    begin
      i:=l; j:=r;
      mid:=a[random(r-l+1)+l];
      repeat
        while (mul(a[1],a[i],mid)>0)or(mul(a[1],a[i],mid)=0)and(dist(a[1],a[i])<dist(a[1],mid)) do inc(i);
        while (mul(a[1],a[j],mid)<0)or(mul(a[1],a[j],mid)=0)and(dist(a[1],a[j])>dist(a[1],mid)) do dec(j);
        if i<=j then
          begin
            swap(a[i],a[j]); inc(i); dec(j);
          end;
      until i>j;
      if i<r then qsort(i,r);
      if j>l then qsort(l,j);
    end;

begin
  randomize;
  assign(input,'input.in');
  reset(input);
  assign(output,'output.out');
  rewrite(output);
  readln(n);
  k:=1;
  for i:=1 to n do
    begin
      readln(a[i].x,a[i].y);
      if a[i].y<a[k].y then k:=i;
    end;
  swap(a[1],a[k]);
  qsort(2,n);
  top:=2;
  for i:=3 to n do
    begin
      while (top>1)and(mul(a[top-1],a[top],a[i])<=0) do dec(top);
      inc(top); a[top]:=a[i];
    end;
  for i:=1 to top do writeln(a[i].x,' ',a[i].y);
  close(input);
  close(output);
end.
