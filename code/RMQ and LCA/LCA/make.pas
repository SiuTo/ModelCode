var
  n,i,x,y,xx,yy,q:integer;
  u:array[1..1000] of integer;
  function find(x:integer):integer;
    begin
      while u[x]>0 do x:=u[x];
      find:=x;
    end;
begin
  randomize;
  assign(output,'LCA.in');
  rewrite(output);
  n:=random(500)+500;
  writeln(n);
  fillchar(u,sizeof(u),0);
  i:=0;
  while i<n-1 do
    begin
      x:=random(n)+1;
      y:=random(n)+1;
      xx:=find(x);
      yy:=find(y);
      if xx=yy then continue;
      u[xx]:=yy;
      writeln(x,' ',y);
      inc(i);
    end;
  q:=random(1000)+1;
  writeln(q);
  for i:=1 to q do
    begin
      x:=random(n)+1;
      y:=random(n)+1;
      writeln(x,' ',y);
    end;
  close(output);
end.
