/* Created By: Justin Meiners (2017) */
 
#include <stdio.h>
#include "lexer.h"

int main(int argc, const char * argv[]) {
    
    if (argc != 2)
    {
        printf("bad arguments\n");
        return 1;
    }
    
    FILE* newFile = fopen(argv[1], "r");
    

    lexer lex;
    lexer_tokenize_file(&lex, newFile);
    
    lexer_print_tokens(&lex);
    
    fclose(newFile);
    
    return 0;
}
