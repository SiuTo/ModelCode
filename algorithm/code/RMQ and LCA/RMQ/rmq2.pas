program rmq_tree;
//O(n)-O(log n)
uses math;
var
  n,q,i,x,y:integer;
  t:array[1..4000] of integer;
  procedure build(p,l,r:integer);
    var mid:integer;
    begin
      if l=r then
        begin
          read(t[p]);
          exit;
        end;
      mid:=(l+r)shr 1;
      build(p*2,l,mid);
      build(p*2+1,mid+1,r);
      t[p]:=min(t[p*2],t[p*2+1]);
    end;
  function count(p,l,r,x,y:integer):integer;
    var mid:integer;
    begin
      if (l=x)and(r=y) then exit(t[p]);
      mid:=(l+r)shr 1;
      if y<=mid then exit(count(p*2,l,mid,x,y));
      if x>mid then exit(count(p*2+1,mid+1,r,x,y));
      count:=min(count(p*2,l,mid,x,mid),count(p*2+1,mid+1,r,mid+1,y));
    end;
begin
  assign(input,'rmq.in');
  reset(input);
  assign(output,'rmq1.out');
  rewrite(output);
  readln(n);
  build(1,1,n);
  readln;
  readln(q);
  for i:=1 to q do
    begin
      readln(x,y);
      writeln(count(1,1,n,x,y));
    end;
  close(input);
  close(output);
end.
