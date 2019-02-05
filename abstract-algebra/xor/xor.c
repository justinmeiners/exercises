/*
A unix program for [XOR Encryption](https://en.wikipedia.org/wiki/XOR_cipher). 
I created this for an abstract algebra project, so the comments explain how the steps of XOR relate to the 
[external direct product](https://en.wikipedia.org/wiki/Direct_product#Group_direct_product) of `Z_{2}`.

## Usage

Encryption:

`cat unencrypted.txt | xor -k my_keyword > encrypted.txt `

Decryption:

`cat encrypted.txt | xor -k my_keyword > decrypted.txt `

Verification:
`md5 decrypted.txt; md5 unencrypted.txt`

*/

#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#define MAX_KEY_LENGTH 2048 /* just to avoid overflow */
#define CHUNK_SIZE     4096 /* 4 KB */

int main(int argc, const char* argv[])
{
    const char* key = NULL;

    /* boring stuff to get argument input */
    int j;
    for (j = 1; j < argc; ++j)
    {
        if (strcmp(argv[j], "-k") == 0)
        {
            if (j + 1 < argc)
            {
                key = argv[j + 1];
                ++j;
            }
        }
    }

    if (!key)
    {
        /* user didn't enter a key */
        printf("xor: -k [key] \n");
        return 0;
    }

    /* find out the key size */
    size_t key_length = strnlen(key, MAX_KEY_LENGTH);

    /* Prepare a buffer to store data as it is read.
       we will read in larger batches to improve performance */
    char* chunk_buffer = malloc(sizeof(char) * CHUNK_SIZE);

    size_t total_length = 0;

    while (!feof(stdin))
    {
        /* read one chunk. read_length will be <= CHUNK_SIZE depending on amount of data left */
        size_t read_length = fread(chunk_buffer, sizeof(char), CHUNK_SIZE, stdin); 
        
        /* ^ (exclusive or) is the same as addition mod 2.
           0 + 0 = 0     F xor F = F
           1 + 0 = 1     T xor F = T 
           0 + 1 = 1     F xor T = T
           1 + 1 = 0     T xor T = F */

        /* Since are we encrypting a byte at a time this is equivalent to 
          an addition within the following external direct product:
          Let G = Z_2 (+) Z_2 (+) Z_2 (+) Z_2 (+) Z_2 (+) Z_2 (+) Z_2 (+) Z_2 */
        size_t i;
        for (i = 0; i < read_length; ++i)
        {
            char c = chunk_buffer[i];     // c in G
            char k = key[total_length % key_length]; // k in G
            chunk_buffer[i] = c ^ k;      // (c + k) in G
            ++total_length;
        }

        // write modified chunk back out
        fwrite(chunk_buffer, sizeof(char), read_length, stdout);
    }

    /* free the buffer */
    free(chunk_buffer);

    return 0; 
}
