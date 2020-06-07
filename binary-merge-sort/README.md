# binary-merge-sort

In Alexander Stepanov's course "Efficient Programming With Components", he creates a binary counter which is used to find the 2 minimum elements in a collection. In this excercise I have applied his `list_pool` and `binary_counter` class to merge sort. This implementation is not optimal, but is a good illustration of this beautiful algorithm.

The code for the course can be found [here](https://github.com/rjernst/stepanov-components-course)


## Sample Output

```
unsorted: 3, 4, 13, 11, 8, 6, 10, 7, 16, 15, 5, 12, 1, 9, 2, 14, 

{3}
{}	{3, 4}
{13}	{3, 4}
{}	{}	{3, 4, 11, 13}
{8}	{}	{3, 4, 11, 13}
{}	{6, 8}	{3, 4, 11, 13}
{10}	{6, 8}	{3, 4, 11, 13}
{}	{}	{}	{3, 4, 6, 7, 8, 10, 11, 13}
{16}	{}	{}	{3, 4, 6, 7, 8, 10, 11, 13}
{}	{15, 16}	{}	{3, 4, 6, 7, 8, 10, 11, 13}	
{5}	{15, 16}	{}	{3, 4, 6, 7, 8, 10, 11, 13}
{}	{}	{5, 12, 15, 16}	{3, 4, 6, 7, 8, 10, 11, 13}
{1}	{}	{5, 12, 15, 16}	{3, 4, 6, 7, 8, 10, 11, 13}
{}	{1, 9}	{5, 12, 15, 16}	{3, 4, 6, 7, 8, 10, 11, 13}
{2}	{1, 9}	{5, 12, 15, 16}	{3, 4, 6, 7, 8, 10, 11, 13}
{}	{}	{}	{}	{1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16}

sorted: 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 

```

## Project License

MIT License

Copyright (c) 2017 Justin Meiners

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
