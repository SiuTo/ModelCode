var
  x,y:integer;
  flag:boolean;
  f1,f2:text;
begin
  assign(f1,'rmq.out');
  reset(f1);
  assign(f2,'rmq1.out');
  reset(f2);
  flag:=true;
  while not eof(f1) do
    begin
      readln(f1,x);
      readln(f2,y);
      flag:=flag and(x=y);
    end;
  close(f1);
  close(f2);
  if flag then writeln('AC') else
    begin
      writeln('WA');
      while true do;
    end;
end.
