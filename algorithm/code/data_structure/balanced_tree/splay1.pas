program NOI2004_cashier_splay;
var
  ch:char;
  n,m,i,x,k,min,delta,root,v:longint;
  l,r,fa,s,key:array[0..100000] of longint;
  procedure r_rotate(v:longint);
    begin
      k:=fa[v];
      fa[v]:=fa[k];
      if fa[k]<>0 then
        begin
          if k=l[fa[k]] then l[fa[k]]:=v else r[fa[k]]:=v;
        end;
      l[k]:=r[v];
      fa[r[v]]:=k;
      r[v]:=k;
      fa[k]:=v;
      s[v]:=s[k];
      s[k]:=s[l[k]]+s[r[k]]+1;
    end;
  procedure l_rotate(v:longint);
    begin
      k:=fa[v];
      fa[v]:=fa[k];
      if fa[k]<>0 then
        begin
          if k=l[fa[k]] then l[fa[k]]:=v else r[fa[k]]:=v;
        end;
      r[k]:=l[v];
      fa[l[v]]:=k;
      l[v]:=k;
      fa[k]:=v;
      s[v]:=s[k];
      s[k]:=s[l[k]]+s[r[k]]+1;
    end;
  procedure splay(v:longint);
    begin
      while fa[v]>0 do
        if fa[fa[v]]=0 then
          begin
            if v=l[fa[v]] then r_rotate(v) else l_rotate(v);
          end else
        if fa[v]=l[fa[fa[v]]] then
          begin
            if v=l[fa[v]] then r_rotate(fa[v]) else l_rotate(v);
            r_rotate(v);
          end else
          begin
            if v=r[fa[v]] then l_rotate(fa[v]) else r_rotate(v);
            l_rotate(v);
          end;
      root:=v;
    end;
  procedure insert;
    begin
      v:=root;
      if v>0 then
        repeat
          inc(s[v]);
          if x<key[v] then
            begin
              if l[v]=0 then break;
              v:=l[v];
            end else
            begin
              if r[v]=0 then break;
              v:=r[v];
            end;
        until false;
      inc(n);
      s[n]:=1; fa[n]:=v; key[n]:=x; l[n]:=0; r[n]:=0;
      if x<key[v] then l[v]:=n else r[v]:=n;
      splay(n);
    end;
  function find(x:longint):longint;
    begin
      v:=root; find:=0;
      while v>0 do
        if x>key[v] then v:=r[v] else
          begin
            find:=v;
            v:=l[v];
          end;
    end;
  function getkth(k:longint):longint;
    begin
      v:=root;
      while s[r[v]]+1<>k do
        if k<=s[r[v]] then v:=r[v] else
          begin
            dec(k,s[r[v]]+1);
            v:=l[v];
          end;
      getkth:=key[v];
      splay(v);
    end;
begin
  readln(m,min);
  n:=0; root:=0; delta:=0;
  for m:=1 to m do
    begin
      readln(ch,x);
      case ch of
        'I':begin
              dec(x,delta);
              if x>=min then insert;
            end;
        'A':begin
              inc(delta,x); dec(min,x);
            end;
        'S':begin
              dec(delta,x); inc(min,x);
              x:=find(min);
              if x=0 then
                begin
                  root:=0; continue;
                end;
              splay(x);
              l[x]:=0; s[x]:=s[r[x]]+1;
            end;
        'F':if x>s[root] then writeln(-1) else writeln(getkth(x)+delta);
      end;
    end;
  writeln(n-s[root]);
end.