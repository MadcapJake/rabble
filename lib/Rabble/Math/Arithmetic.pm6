unit module Rabble::Math::Arithmetic;

#| [a b -- c]
sub plus($ctx) is export {
  $ctx.stack.push: ($ctx.stack.pop + $ctx.stack.pop);
}

#| [a b -- c]
sub multiply($ctx) is export {
  $ctx.stack.push: ($ctx.stack.pop * $ctx.stack.pop);
}

#| [r l -- m]
sub subtract($ctx) is export {
  my ($left, $right) = ($ctx.stack.pop, $ctx.stack.pop);
  $ctx.stack.push: ($left - $right);
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
