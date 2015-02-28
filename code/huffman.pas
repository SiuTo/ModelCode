program huffman_heap;
type
  node=record
    num,father,left,right:integer;
    s:string;
  end;
var
  i,n,m,sum:integer;
  st:string;
  tree:array[1..200] of node;
  ch:array[1..100] of char;
  procedure create;
    var min1,min2,p1,p2,j:integer;
    begin
      for i:=n+1 to m do
        begin
          min1:=maxint;
          min2:=maxint;
          for j:=1 to i-1 do
            if tree[j].father=0 then
              begin
                if tree[j].num<min1 then
                  begin
                    min2:=min1;
                    min1:=tree[j].num;
                    p2:=p1;
                    p1:=j;
                  end else
                  if tree[j].num<min2 then
                    begin
                      min2:=tree[j].num;
                      p2:=j;
                    end;
              end;
          with tree[i] do
            begin
              num:=min1+min2;
              inc(sum,num);
              left:=p1;
              right:=p2;
              tree[p1].father:=i;
              tree[p2].father:=i;
            end;
        end;
    end;
  procedure bianma(k:node);
    begin
      if k.left=0 then exit;
      with k do
        begin
          tree[left].s:=s+'0';
          bianma(tree[left]);
          tree[right].s:=s+'1';
          bianma(tree[right]);
        end;
    end;
  procedure fanyi(k:integer; s:string);
    begin
      if tree[k].left=0 then
        begin
          write(ch[k]);
          if s<>'' then fanyi(m,s);
        end else
        begin
          st:=copy(s,2,length(s)-1);
          if s[1]='0' then fanyi(tree[k].left,st)
            else fanyi(tree[k].right,st);
        end;
    end;
begin
  readln(n);
  fillchar(tree,sizeof(tree),0);
  for i:=1 to n do readln(ch[i],tree[i].num);
  m:=2*n-1;
  sum:=0;
  create;
  writeln(sum);
  bianma(tree[m]);
  for i:=1 to n do writeln(ch[i],' ',tree[i].s);
  readln(st);
  fanyi(m,st);
  writeln;
end.