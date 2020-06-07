/* Created By: Justin Meiners (2017) */
 
#ifndef LEXER_H
#define LEXER_H

#include <stdio.h>
#include <ctype.h>
#include <string.h>

const char* token_to_string_table[] = {
    "COMMA",
    "PERIOD",
    "Q_MARK",
    "LEFT_PAREN",
    "RIGHT_PAREN",
    "COLON",
    "COLON_DASH",
    "MULTIPLY",
    "ADD",
    "SCHEMES",
    "FACTS",
    "RULES",
    "QUERIES",
    "ID",
    "STRING",
    "COMMENT",
    "WHITESPACE",
    "UNDEFINED",
    "END_OF_FILE",
};

typedef enum
{
    TOKEN_COMMA = 0,
    TOKEN_PERIOD,
    TOKEN_Q_MARK,
    TOKEN_LEFT_PAREN,
    TOKEN_RIGHT_PAREN,
    TOKEN_COLON,
    TOKEN_COLON_DASH,
    TOKEN_MULTIPLY,
    TOKEN_ADD,
    TOKEN_SCHEMES,
    TOKEN_FACTS,
    TOKEN_RULES,
    TOKEN_QUERIES,
    TOKEN_ID,
    TOKEN_STRING,
    TOKEN_COMMENT,
    TOKEN_WHITESPACE,
    TOKEN_UNDEFINED,
    TOKEN_END_OF_FILE,
} token_type;

#define TOKEN_VALUE_MAX 512

typedef struct
{
    char value[TOKEN_VALUE_MAX];
    token_type type;
    int line_number;
    
    int multiline_comment;
} token;

void token_set_value(token* token, const char* value)
{
    strncpy(token->value, value, TOKEN_VALUE_MAX);
}

#define LINE_BUFFER_SIZE 1024


typedef struct
{
    int token_count;
    token tokens[256];
    
    char read_buffer[LINE_BUFFER_SIZE];
    const char* c;

    FILE* file;
    
} lexer;



static const char* _lexer_skip_whitespace(const char* buffer)
{
    if (buffer == NULL) { return NULL; }
    
    const char* c = buffer;
    if (isspace(*c)) { ++c; }
    return c;
}

static const char* _lexer_match_word(const char* buffer, const char* word)
{
    
    int i = 0;
    while (word[i] != '\0')
    {
        // buffer ends early
        if (buffer[i] == '\0') { return NULL; }

        // comparison fail
        if (buffer[i] != word[i]) { return NULL; }
        
        ++i;
    }
    
    return buffer + i;
}

static const char* _lexer_match_id(const char* buffer)
{
    const char* c = buffer;
    
    while (isalpha(*c) || isnumber(*buffer))
    {
        c+=1;
        
        if (*c == '\0' || *c == '\n')
        {
            return NULL;
        }
    }
    
    return c;
}

static const char* _lexer_read_string(const char* buffer, char* dest)
{
    int i = 0;
    
    if (buffer[i] != '\'')
    {
        return NULL;
    }
    
    i++;
    
    while (buffer[i] != '\'')
    {
        if (buffer[i] == '\n' || buffer[i] == '\0')
        {
            return NULL;
        }
        
        dest[i - 1] = buffer[i];
        i += 1;
    }
    
    i += 1;
    
    return buffer + i;
}

static const char* _lexer_read_comment(const char* buffer, char* dest)
{
    int i = 0;
    
    if (buffer[i] != '#')
    {
        return NULL;
    }
    
    i += 1;
    
    while (buffer[i] != '\n' && buffer[i] != '\0')
    {
        dest[i - 1] = buffer[i];
        i += 1;
    }

    
    return buffer + i;
}


static int _lexer_read_token(lexer* lexer, int line_number, token* out_token)
{
    lexer->c = _lexer_skip_whitespace(lexer->c);

    // if we reached a new line we need more data
    if (lexer->c == NULL || *lexer->c == '\0' || *lexer->c == '\n')
    {
        fgets(lexer->read_buffer, LINE_BUFFER_SIZE, lexer->file);
        lexer->c = _lexer_skip_whitespace(lexer->read_buffer);
    }
    
    
    const char* c = lexer->c;
    const char* new_c = NULL;
    
    token new_token;
    new_token.type = TOKEN_UNDEFINED;
    new_token.line_number = line_number;

    switch (*c)
    {
        case ',':
            new_token.type = TOKEN_COMMA;
            token_set_value(&new_token, ",");
            c += 1;
            break;
        case '.':
            new_token.type = TOKEN_PERIOD;
            token_set_value(&new_token, ".");
            c += 1;
            break;
        case '?':
            new_token.type = TOKEN_Q_MARK;
            token_set_value(&new_token, "?");
            c += 1;
            break;
        case '(':
            new_token.type = TOKEN_LEFT_PAREN;
            token_set_value(&new_token, "(");
            c += 1;
            break;
        case ')':
            new_token.type = TOKEN_RIGHT_PAREN;
            token_set_value(&new_token, ")");
            c += 1;
            break;
        case ':':
            if (*(c+1) == '-')
            {
                new_token.type = TOKEN_COLON_DASH;
                token_set_value(&new_token, ":-");
                c += 2;
            }
            else
            {
                new_token.type = TOKEN_COLON;
                token_set_value(&new_token, ":");
                c += 1;
            }
            break;
        case 'Q':
            new_c = _lexer_match_word(c, "Queries");
            
            if (new_c != NULL)
            {
                new_token.type = TOKEN_QUERIES;
                token_set_value(&new_token, "Queries");
                c = new_c;
            }
            break;
        case '#':
            if (*(c+1) == '|')
            {
                c+=2;
                
                int i = 0;
                int done = 0;

                while (!done && !feof(lexer->file))
                {
                    while (*c != '\0')
                    {
                        new_token.value[i] = *c;
                        
                        if (i > 1 && new_token.value[i] == '#' && new_token.value[i - 1] == '|')
                        {
                            new_token.value[i-1] = '\0';
                            done = 1;
                            break;
                        }
                        
                        i++;
                        c++;
                    }
                    if (!done)
                    {
                        fgets(lexer->read_buffer, LINE_BUFFER_SIZE, lexer->file);
                        c = lexer->read_buffer;
                    }

                }
                c++;
                new_token.type = TOKEN_COMMENT;
            }
            else
            {
                new_c = _lexer_read_comment(c, new_token.value);
                
                if (new_c)
                {
                    new_token.type = TOKEN_COMMENT;
                    c = new_c;
                }
            }
            break;
        case '\'':
            new_c = _lexer_read_string(c, new_token.value);
            
            if (new_c != NULL)
            {
                new_token.type = TOKEN_STRING;
                c = new_c;
                break;
            }
            break;
        default:
            if (isalpha(*c))
            {
                new_c = _lexer_match_id(c);
                
                if (new_c != NULL)
                {
                    new_token.type = TOKEN_ID;
                    strncpy(new_token.value, c, new_c-c);
                    c = new_c;
                }
            }
            else
            {
                new_token.type = TOKEN_UNDEFINED;
                new_token.value[0] = *c;
                new_token.value[1] = '\0';
                c += 1;
            }
            
            break;
    }
    
    *out_token = new_token;

    lexer->c = c;
    return 1;
}

void lexer_tokenize_file(lexer* lexer, FILE* file)
{
    lexer->token_count = 0;
    lexer->file = file;
    
    int line_number = 0;
    
    while (!feof(file))
    {
        _lexer_read_token(lexer, line_number, lexer->tokens + lexer->token_count);
        lexer->token_count += 1;
    }
}


void lexer_print_tokens(lexer* lexer)
{
    for (int i = 0; i < lexer->token_count; ++i)
    {
        const token* token = lexer->tokens + i;
        printf("(%s,\"%s\",%i)\n", token_to_string_table[token->type], token->value, token->line_number);
    }
    
}


#endif
