fpc make.pas
fpc LCA.pas
g++ -o LCA1 LCA.cpp
while true; do
	./make
	./LCA
	./LCA1
	if diff LCA.out LCA.ans; then
		echo -n Y
	else
		echo N
		break
	fi
done
