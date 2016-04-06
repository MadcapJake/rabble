unit module Rabble::Math::Arithmetic;

#| [a b -- c]
sub plus($ctx) is export {
  $ctx.stack.push: ($ctx.stack.pop + $ctx.stack.pop);
}

#| [a b -- c]
sub multiply($ctx) is export {
  $ctx.stack.push: ($ctx.stack.pop * $ctx.stack.pop);
}

#| [x y -- z]
sub subtract($ctx) is export {
  my ($y, $x) = ($ctx.stack.pop, $ctx.stack.pop);
  $ctx.stack.push: ($x - $y);
}

#| [d n -- q]
sub divide($ctx) is export {
  my ($numerator, $denominator) = ($ctx.stack.pop, $ctx.stack.pop);
  $ctx.stack.push: ($numerator / $denominator);
}

#| [a -- b]
sub abs($ctx) is export {
  $ctx.stack.push: $ctx.stack.pop.abs;
}
