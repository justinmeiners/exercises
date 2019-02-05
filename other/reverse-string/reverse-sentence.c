/*
    My solution to a problem posed by Ryan.
    I went for speed.
*/

#include <stdio.h>
#include <ctype.h>
#include <string.h>
#include <assert.h>

typedef struct 
{
    const char* start;
    unsigned int len;
    unsigned int is_word;
} Token;

#define MAX_TOKENS 256
typedef struct
{
    unsigned int count;
    unsigned int cap;
    Token tokens[MAX_TOKENS];
} Sentence;

const char* next_token(const char* c, Token* out_token)
{
    out_token->start = c;
    if (isalnum(*c))
    {
        out_token->is_word = 1;
        while (isalnum(*(++c)));
    }
    else if (*c)
    {
        out_token->is_word = 0;
        while (*c && !isalnum(*(++c)));
    }
    
    // len will be 0 for failed read
    out_token->len = (int)(c - out_token->start);
    return c;
}

void tokenize(Sentence* sen, const char* string)
{
    sen->count = 0;
    sen->cap = 64;
    
    const char* c = string;
    
    while (1)
    {
        Token* out_token = sen->tokens + sen->count;
        c = next_token(c, out_token);
        
        if (out_token->len == 0)
        {
            break;
        }
        else
        {
            ++sen->count;
            assert(sen->count < MAX_TOKENS);
        }
    }
}
    

void reverse(Sentence* sen)
{
    int left = 0;
    int right = sen->count - 1;
    
    // move left and right to the first words
    while (!sen->tokens[left].is_word && left < right) ++left;
    while (!sen->tokens[right].is_word && left < right) --right;
    
    while (left < right)
    {
        // swap tokens
        Token temp;
        temp = sen->tokens[right];
        sen->tokens[right] = sen->tokens[left];
        sen->tokens[left] = temp;
        
        // words have a one gap of punctuation between them
        // _A_B_C_D_
        left += 2;
        right -= 2;
    }
}

void copy_to_string(const Sentence* sen, char* out_str)
{
    size_t offset = 0;
    
    for (int i = 0; i < sen->count; ++i)
    {
        memcpy(out_str + offset, sen->tokens[i].start, sen->tokens[i].len);
        offset += sen->tokens[i].len;
    }
    out_str[offset] = '\0';
}

int main(int arg, const char* argv[])
{
    const char* text = "Hello, how are you today? I am doing great!";
    char out_text[1024];

    Sentence sen;
    tokenize(&sen, text); 
    reverse(&sen);
    copy_to_string(&sen, out_text);
    puts(out_text);  
    return 0;
}


