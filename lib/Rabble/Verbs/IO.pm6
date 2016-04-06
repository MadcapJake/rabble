unit module Rabble::Verbs::IO;

sub emit($ctx) is export {
  $ctx.out.say: $ctx.stack.last.chr
}

sub dot-s($ctx) is export {
  $ctx.out.say: "{$ctx.stack}>"
}
