# Benchmark of map<k1, map<k2, v>>

After writing [The Skills Poor Programmers Lack](https://gist.github.com/justinmeiners/be4540f515986d93ee12ac2f1980631a)
I got some feedback wondering about the performance using nested maps compared to other strategies.

This code is a benchmark to answer that question. It compares these:

1. `std::map<, std::map<,>` 
2. `std::unorded_map<, std::map<,>`
3. `std::map<std::pair<,>>`

Here are a few data sets to try:

- [Webster's Unabridged Dictionary ](http://www.gutenberg.org/ebooks/673)
- [The King James Bible](http://www.gutenberg.org/ebooks/10)
- [The Republic](http://www.gutenberg.org/ebooks/1497)

Of course, C++ microbenchmarks are always tricky, since the compiler can do clever things.
So please point out if there is a major issue.

## Results

You can get comparable search times depending on the data set and how lucky you are.
Pairs seem to offer no advantage of map-map. However, hash map is regularly
faster at the build step.

```
cat the_bible.txt | ./bench-map-map;
0
build time: 103.458 ms
occurrences: 140736424921372
search time: 68.819 ms
cat the_bible.txt | ./bench-map-pair;
1
build time: 103.73 ms
occurrences: 384013503
search time: 69.627 ms
cat the_bible.txt | ./bench-hash-map;
2
build time: 92.319 ms
occurrences: 140736423932875
search time: 63.65 ms
cat the_bible.txt | ./bench-hash-pair;
3
build time: 48.089 ms
occurrences: 140736425066275
search time: 62.439 ms
```

