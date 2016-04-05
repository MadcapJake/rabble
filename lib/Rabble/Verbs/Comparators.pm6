unit module Rabble::Verbs::Comparators;

#| [a b -- true|false]
sub equals($ctx) {
  my ($a, $b) = ($ctx.stack.pop, $ctx.stack.pop);
  $ctx.stack.push: $a == $b;
}

#| [a b -- true|false]
sub not-equals($ctx) {
  my ($a, $b) = ($ctx.stack.pop, $ctx.stack.pop);
  $ctx.stack.push: $a != $b;
}

#| [a b -- true|false]
sub greater-than($ctx) {
  my ($rhs, $lhs) = ($ctx.stack.pop, $ctx.stack.pop);
  $ctx.stack.push: $lhs > $rhs;
}

#| [a b -- true|false]
sub less-than($ctx) {
  my ($rhs, $lhs) = ($ctx.stack.pop, $ctx.stack.pop);
  $ctx.stack.push: $lhs < $rhs;
}
