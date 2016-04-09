unit module Rabble::Math::Arithmetic;

use Rabble::Util;

#| [a b -- c]
sub plus($ctx) is export {
  $ctx.stack ↞ ($ctx.stack.pop + $ctx.stack.pop);
}

#| [a b -- c]
sub multiply($ctx) is export {
  $ctx.stack ↞ ($ctx.stack.pop * $ctx.stack.pop);
}

#| [x y -- z]
sub subtract($ctx) is export {
  my ($y, $x) = ($ctx.stack.pop xx 2);
  $ctx.stack ↞ $x - $y;
}

#| [d n -- q]
sub divide($ctx) is export {
  my ($d, $n) = ($ctx.stack.pop xx 2);
  $ctx.stack ↞ $n / $d;
}

#| [a -- b]
sub abs($ctx) is export {
  $ctx.stack ↞ $ctx.stack.pop.abs;
}

#| [a -- b]
sub inc($ctx) is export {
  $ctx.stack ↞ ++$ctx.stack.pop;
}

#| [a -- b]
sub dec($ctx) is export {
  $ctx.stack ↞ --$ctx.stack.pop;
}
