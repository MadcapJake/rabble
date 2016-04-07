unit grammar Rabble::Reader;

token TOP           { [ <Line> \n+ ]+ }
token Line          { [ <Expression> \s* ]+ <EOLComment>? }
token Expression    { <Word> | <Quotation> | <Definition> }
token Word          { <Name> | <Number> }
token Name          { <:Letter+:Punctuation+:Symbol-[\[\]:;\\()]>+ }
token Number        { <:Number>+ [ '.' <:Number>+ ]? }
token Quotation     { '[' \s* [ <Expression> | <InlineComment> | \s ]+ \s* ']' }
token Definition    { ':' <Name> [ <Expression> | <InlineComment> ]+ ';' }
token EOLComment    { '\\' .* }
token InlineComment { '(' <-[)]>* ')' }
