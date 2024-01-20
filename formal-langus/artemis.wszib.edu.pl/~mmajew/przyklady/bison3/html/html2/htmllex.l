%{
#include "html.tab.h"
%}

%%
\<HTML\>|\<html\>		return HTML_O;
"</HTML>"|"</html>"		return HTML_Z;
"<!DOCTYPE html>"		return DOCTYPE;
"<BODY>"|"<body>"		return BODY_O;
"</BODY>"|"</body>"		return BODY_Z;
[ \t]+				;
\n				;
