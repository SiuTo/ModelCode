var
  n,i,x,y,z,q:integer;
begin
  randomize;
  assign(output,'rmq.in');
  rewrite(output);
  n:=random(500)+500;
  writeln(n);
  for i:=1 to n do write(random(maxint),' ');
  writeln;
  q:=random(500)+500;
  writeln(q);
  for i:=1 to q do
    begin
      x:=random(n)+1;
      y:=random(n)+1;
      if x>y then
        begin
          z:=x; x:=y; y:=z;
        end;
      writeln(x,' ',y);
    end;
  close(output);
end.
