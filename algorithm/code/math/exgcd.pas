program exgcd;
//求二元一次不定方程中某个未知数的最小非负整数解。
var
  a,b,c,gcd,d,x,y:int64;
  function exgcd(a,b:int64; var x,y:int64):int64;
    begin
      if a mod b=0 then
        begin
          x:=0; y:=1;
          exit(b);
        end;
      exgcd:=exgcd(b,a mod b,y,x);
      y:=y-a div b*x;
    end;
begin
  readln(a,b,c);
  gcd:=exgcd(a,b,x,y);
  if c mod gcd>0 then writeln('No solution.') else
    begin
      d:=b div gcd;
      x:=c div gcd*x mod d;
      if x<0 then inc(x,d);
      y:=(c-a*x)div b;
      writeln(x,' ',y);
    end;
end.
