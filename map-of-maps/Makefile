CFLAGS=-std=c++14 -O3
FILE=the_bible.txt

.PHONY: all test clean

all: bench-map-map bench-map-pair bench-hash-map bench-hash-pair

test: bench-map-map bench-map-pair bench-hash-map bench-hash-pair
	cat ${FILE} | ./bench-map-map;
	cat ${FILE} | ./bench-map-pair;
	cat ${FILE} | ./bench-hash-map;
	cat ${FILE} | ./bench-hash-pair;

clean:
	rm bench-map-map bench-map-pair bench-hash-map bench-hash-pair

bench-map-map: maps.cpp
	g++ ${CFLAGS} -D TEST_MODE=0 $^ -o $@

bench-map-pair: maps.cpp
	g++ ${CFLAGS} -D TEST_MODE=1 $^ -o $@

bench-hash-map: maps.cpp
	g++ ${CFLAGS} -D TEST_MODE=2 $^ -o $@

bench-hash-pair: maps.cpp
	g++ ${CFLAGS} -D TEST_MODE=3 $^ -o $@


