unit class Rabble::Compiler;

has $!context;
has %!lexicon;

submethod BUILD(:$!context, :%lexicon) {
  %!lexicon := %lexicon;
}

sub compile-words(@entries) {
  my Callable @actions;
  for @entries -> %entry {
    %entry<immediate>
      ?? %entry<block>()
      !! @actions.push: %entry<block>;
  }
  { $_() for @actions }
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
method Interpretation($/) {
  $/.make: compile-words($<Expression>».made)
}
method Definition($/) {
  my $block = compile-words($<Expression>».made);
  %!lexicon.define-word :name($<Name>) :$block;
}
method Expression($/) {
  my %expr = $<Word>.made // $<Interpretation>.made;
  %expr<block>();
}
=for UNUSED
method Line($/) {
  my @exprs = $<Expression>».made;
  if $*DEBUG { .say for @exprs }
  $!context.stack.append: @exprs;
}
