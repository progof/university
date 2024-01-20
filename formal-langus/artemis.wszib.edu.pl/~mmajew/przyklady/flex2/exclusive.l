%{
/* exclusive.l
   demonstruje dzialanie wylacznych stanow startowych */
%}

%x LITERAL
%%

raz                ECHO;
dwa                ECHO;
#                  BEGIN(LITERAL);
<LITERAL>#         BEGIN(INITIAL);
.                  /* empty */
