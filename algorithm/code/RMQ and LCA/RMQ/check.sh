fpc make.pas
fpc rmq.pas
g++ -o rmq1 rmq.cpp
while true; do
	./make
	./rmq
	./rmq1
	if diff rmq.out rmq.ans; then
		echo -n Y
	else
		echo N
		break
	fi
done
