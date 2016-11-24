program Pnn_and_number;
const
  jie:array[1..10] of longint=(1,2,6,24,120,720,5040,40320,362880,3628800);
var
  n,i,j:integer;
  num:longint;
  s,p:string;
  a:array[1..10] of integer;
  f:array[1..10] of boolean;
  procedure donum;
    var k:integer;
    begin
      num:=1;
      for i:=1 to n-1 do
        begin
          k:=0;
          for j:=i+1 to n do
            if s[j]<s[i] then inc(k);
          inc(num,k*jie[n-i]);
        end;
    end;
  procedure sort;
    var c:char;
    begin
      for i:=2 to n do
        begin
          c:=s[i];
          j:=i-1;
          while (j>0)and(s[j]>c) do
            begin
              s[j+1]:=s[j];
              dec(j);
            end;
          s[j+1]:=c;
        end;
    end;
  procedure dop;
    begin
      dec(num);
      i:=1;
      fillchar(a,sizeof(a),0);
      while num>0 do
        begin
          inc(i);
          a[i]:=num mod i;
          num:=num div i;
        end;
      p:='';
      fillchar(f,sizeof(f),0);
      for i:=n downto 1 do
        begin
          j:=0;
          inc(a[i]);
          while a[i]>0 do
            begin
              inc(j);
              if not f[j] then dec(a[i]);
            end;
          f[j]:=true;
          p:=p+s[j];
        end;
    end;
begin
  readln(s);
  n:=length(s);
  donum;
  writeln('number is ',num);
  sort;
  dop;
  writeln('P is ',p);
end.