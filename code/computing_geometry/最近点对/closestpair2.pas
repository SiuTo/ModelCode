program closestpair;
//O(n log n)
uses math;
type
  point=array[1..2] of longint;
const
  size=sizeof(point);
var
  n,i,j,k:longint;
  a,b:array[0..100000] of point;

  procedure merge(p,l,m,r:longint);
    var s1,t1,s2,t2,q:longint;
    begin
      s1:=l; t1:=m; s2:=m+1; t2:=r; q:=l;
      while (s1<=t1)and(s2<=t2) do
        begin
          if a[s1,p]<a[s2,p] then
            begin
              b[q]:=a[s1]; inc(s1);
            end else
            begin
              b[q]:=a[s2]; inc(s2);
            end;
          inc(q);
        end;
      if s1<=t1 then move(a[s1],b[q],size*(t1-s1+1)) else move(a[s2],b[q],size*(t2-s2+1));
      move(b[l],a[l],size*(r-l+1));
    end;

  procedure mergesort(l,r:longint);
    var mid:longint;
    begin
      if l=r then exit;
      mid:=(l+r)shr 1;
      mergesort(l,mid);
      mergesort(mid+1,r);
      merge(1,l,mid,r);
    end;
    
  function dist(a,b:point):double;
    begin
      dist:=sqrt(sqr(a[1]-b[1])+sqr(a[2]-b[2]));
    end;
    
  function cp(l,r:longint):double;
    var mid,x0:longint;
    begin
      if l=r then exit(1e10);
      if l+1=r then
        begin
          if a[l,2]>a[r,2] then
            begin
              a[0]:=a[l]; a[l]:=a[r]; a[r]:=a[0];
            end;
          exit(dist(a[l],a[r]));
        end;
      mid:=(l+r)shr 1; x0:=a[mid,1];
      cp:=min(cp(l,mid),cp(mid+1,r));
      merge(2,l,mid,r);
      k:=0;
      for i:=l to r do
        if abs(a[i,1]-x0)<cp then
          begin
            inc(k); b[k]:=a[i];
          end;
      for i:=1 to k-1 do
        for j:=i+1 to min(i+7,k) do
          cp:=min(cp,dist(b[i],b[j]));
    end;

begin
  assign(input,'input.in');
  reset(input);
  assign(output,'output.out');
  rewrite(output);
  readln(n);
  for i:=1 to n do readln(a[i,1],a[i,2]);
  mergesort(1,n);
  writeln(cp(1,n):0:2);
  close(input);
  close(output);
end.
