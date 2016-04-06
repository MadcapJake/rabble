unit module Rabble::Verbs::Shufflers;

#| [a -- ]
sub drop($ctx) is export {
  $ctx.stack.pop;
}

#| [a -- a a]
sub dup($ctx) is export {
  $ctx.stack.push: $ctx.stack[*-1];
}

#| [a b -- b a]
sub swap($ctx) is export {
  $ctx.stack.append: $ctx.stack.pop xx 2;
}

#| [a b c -- b c a]
sub rot($ctx) is export {
  my ($a, $b, $c) = ($ctx.stack.pop, $ctx.stack.pop, $ctx.stack.pop);
  $ctx.stack.append: [$b, $c, $a];
}

sub und($ctx) is export {
  my ($top, $und) = ($ctx.stack.pop xx 2);
  $ctx.stack.append: [$und, $top, $und];
}
