unit grammar Rabble::Reader;

token TOP            { [ <Line> \n+ ]+ }
token Line           { [ <Expression> \s+ ]+ <EOLComment>? }
token Expression     { <Word> | <Interpretation> | <Definition> }
token Word           { <Name> | <Number> }
token Name           { <:Letter+:Punctuation+:Symbol-[\[\]:;\\()]>+ }
token Number         { <:Number>+ [ '.' <:Number>+ ]? }
token Interpretation { '[' [ <Expression> | <InlineComment> ]+ ']' }
token Definition     { ':' <Name> [ <Expression> | <InlineComment> ]+ ';' }
token EOLComment     { '\\' .* }
token InlineComment  { '(' <-[)]>* ')' }
