unit class Rabble::Compiler;

use Rabble::Util;

has $!context;
has %!lexicon;

submethod BUILD(:$!context, :%lexicon) {
  %!lexicon := %lexicon;
}

method Name($/) { $/.make: %!lexicon{~$/} // die "Unable to find $/" }
method Number($/) {
  $/.make: {
    name      => ~$/,
    block     => { $!context.stack.push: +$/ },
    immediate => False
  }
}
method Word($/) {
  say "Word: $/" if $*DEBUG;
  $/.make: $<Name>.made // $<Number>.made;
}
method Quotation($/) {
  say "Quotation: $/" if $*DEBUG;
  my Map @internals = $<Expression>».made;
  $/.make: {
    name      => ~$/,
    block     => compile-words(@internals),
    immediate => False,
    quotation => True
  }
}
method Definition($/) {
  my $block = compile-words($<Expression>».made);
  %!lexicon.define-word :name($<Name>) :$block;
}
method Expression($/) {
  $/.make: $<Word>.made // $<Quotation>.made;
}
method Line($/) {
  for $<Expression>».made {
    $_.say if $*DEBUG;
    $_<quotation> ?? ($!context.stack ↞ $_<block>) !! $_<block>();
    $!context.stack.say if $*DEBUG;
  }
}
