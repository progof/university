%{
#include "html.tab.h"
%}

%%
\<HTML\>|\<html\>		return HTML_O;
"</HTML>"|"</html>"		return HTML_Z;
"<!DOCTYPE html>"		return DOCTYPE;
"<BODY>"|"<body>"		return BODY_O;
"</BODY>"|"</body>"		return BODY_Z;
"<P>"|"<p>"			return P_O;
"</P>"|"</p>"			return P_Z;
"<B>"|"<b>"			return B_O;
"</B>"|"</b>"			return B_Z;
"<BR>"|"<br>"			return BR;
[a-zA-Z.]+			return TEXT;
[ \t]+				;
\n				;
