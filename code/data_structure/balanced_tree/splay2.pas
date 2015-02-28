program BZOJ1251_splay_reversal;
type
  node=record
    num,delta,max,l,r,fa,s:longint;
    rev:boolean;
  end;
var
  n,m,i,l,r,flag,k,root,v,x:longint;
  t:array[0..50000] of node;
  function max(x,y,z:longint):longint;
    begin
      if z>y then y:=z;
      if x>y then max:=x else max:=y;
    end;
  procedure create;
    begin
      root:=1;
      t[0].max:=low(longint);
      for i:=1 to n do
        begin
          t[i-1].r:=i;
          t[i].fa:=i-1;
          t[i].s:=n-i+1;
        end;
    end;
  procedure update(v:longint);
    begin
      t[v].s:=t[t[v].l].s+t[t[v].r].s+1;
      t[v].max:=max(t[v].num,t[t[v].l].max,t[t[v].r].max);
    end;
  procedure l_rotate(v:longint);
    begin
      k:=t[v].fa;
      t[v].fa:=t[k].fa;
      if t[k].fa>0 then
        begin
          if k=t[t[k].fa].l then t[t[k].fa].l:=v else t[t[k].fa].r:=v;
        end;
      t[k].r:=t[v].l;
      t[t[v].l].fa:=k;
      t[v].l:=k;
      t[k].fa:=v;
      update(k);
      update(v);
    end;
  procedure r_rotate(v:longint);
    begin
      k:=t[v].fa;
      t[v].fa:=t[k].fa;
      if t[k].fa>0 then
        begin
          if k=t[t[k].fa].l then t[t[k].fa].l:=v else t[t[k].fa].r:=v;
        end;
      t[k].l:=t[v].r;
      t[t[v].r].fa:=k;
      t[v].r:=k;
      t[k].fa:=v;
      update(k);
      update(v);
    end;
  procedure pushdown(v:longint);
    var h:longint;
    begin
      with t[v] do
        begin
          if delta<>0 then
            begin
              if l>0 then
                begin
                  inc(t[l].num,delta);
                  inc(t[l].delta,delta);
                  inc(t[l].max,delta);
                end;
              if r>0 then
                begin
                  inc(t[r].num,delta);
                  inc(t[r].delta,delta);
                  inc(t[r].max,delta);
                end;
              delta:=0;
            end;
          if rev then
            begin
              h:=l; l:=r; r:=h;
              t[l].rev:=not t[l].rev;
              t[r].rev:=not t[r].rev;
              rev:=false;
            end;
        end;
    end;
  procedure splay(x,goal:longint);
    var y,z:longint;
    begin
      while t[x].fa<>goal do
        begin
          y:=t[x].fa; z:=t[y].fa;
          if z=goal then
            begin
              if x=t[y].l then r_rotate(x) else l_rotate(x);
            end else
          if y=t[z].l then
            begin
              if x=t[y].l then r_rotate(y) else l_rotate(x);
              r_rotate(x);
            end else
            begin
              if x=t[y].r then l_rotate(y) else r_rotate(x);
              l_rotate(x);
            end;
        end;
      if goal=0 then root:=x;
    end;
  function getkth(k:longint):longint;
    var v:longint;
    begin
      v:=root;
      pushdown(v);
      while k<>t[t[v].l].s+1 do
        begin
          if k<=t[t[v].l].s then v:=t[v].l else
            begin
              dec(k,t[t[v].l].s+1);
              v:=t[v].r;
            end;
          pushdown(v);
        end;
      getkth:=v;
    end;
  function divide(l,r:longint):longint;
    begin
      if (l=1)and(r=n) then exit(root);
      if l=1 then
        begin
          splay(getkth(r+1),0);
          exit(t[root].l);
        end;
      if r=n then
        begin
          splay(getkth(l-1),0);
          exit(t[root].r);
        end;
      splay(getkth(l-1),0);
      splay(getkth(r+1),root);
      divide:=t[t[root].r].l;
    end;
begin
  readln(n,m);
  create;
  for m:=1 to m do
    begin
      read(flag,l,r);
      v:=divide(l,r);
      with t[v] do
        case flag of
          1:begin
              read(x);
              inc(num,x); inc(delta,x); inc(max,x);
              pushdown(v);
              splay(v,0);
            end;
          2:rev:=not rev;
          3:writeln(max);
        end;
      readln;
    end;
end.