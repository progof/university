%{
#include "html.tab.h"
%}

%%
\<HTML\>		return HTML_O;
"</HTML>"		return HTML_Z;
[ \t]+			;
\n 			;

