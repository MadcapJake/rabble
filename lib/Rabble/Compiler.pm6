unit class Rabble::Compiler;

has $!context;
has %!lexicon;

submethod BUILD(:$!context, :%!lexicon) {}

method compile-words(@entries) {
  my Callable @actions;
  for @entries -> %entry {
    %entry<immediate>
      ?? %entry<block>()
      !! @actions.push: %entry<block>;
  }
  { $_() for @actions }
}


method Name($/) { $/.make: ~$/ }
method Number($/) { $/.make: +$/ }
method Word($/) {
  $/.make: %!lexicon{~$/} // {
    name      => ~$/,
    block     => { $!context.stack.push: $/ },
    immediate => False
  }
}
method Interpretation($/) {
  $/.make: self.compile-words($<Expression>».made)
}
method Definition($/) {
  my $block = self.compile-words($<Expression>».made);
  %!lexicon.define-word :name($<Name>) :$block;
}
method Expression($/) {
  $/.make: $<Word>.made // $<Interpretation>.made;
}
method Line($/) { $!context.stack.append: $<Expression>».made }
