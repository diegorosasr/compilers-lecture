%{
#include <stdio.h>
#include <time.h>

void yyerror(const char *s);
int yylex(void);
%}

%token HELLO GOODBYE TIME DATE NAME HOW_ARE_YOU

%%

chatbot : greeting
        | farewell
        | query
        ;

greeting : HELLO { printf("Chatbot: Hello! How can I assist you you today?\n"); }
         ;

farewell : GOODBYE { printf("Chatbot: Goodbye! Have a great day!\n"); }
         ;

query : TIME { 
            time_t now = time(NULL);
            struct tm *local = localtime(&now);
            printf("Chatbot: The current time is %02d:%02d.\n", local->tm_hour, local->tm_min);
         }
       //Added date response  
       | DATE { 
            time_t now = time(NULL);
            struct tm *local = localtime(&now);
            printf("Chatbot: Today's date is %02d/%02d/%04d.\n", local->tm_mon + 1, local->tm_mday, local->tm_year + 1900);
         }
       | NAME { printf("Chatbot: My name is Diego's Chatbot. How can I help you?\n"); } //Added name response
       | HOW_ARE_YOU { printf("Chatbot: I'm just a chatbot with no feelings, but I'm always ready to help you!\n"); } //Added state response
       ;

%%

int main() {
    // Initialization message when starting chatbot shows additional available features now
    printf("Chatbot: Hello! You can greet me, ask for the time or date, inquire about my name, ask how I'm doing or say goodbye.\n"); 
    while (yyparse() == 0) {
    }
    return 0;
}

void yyerror(const char *s) {
    fprintf(stderr, "Chatbot: Sorry I didn't understand that.\n");
}
