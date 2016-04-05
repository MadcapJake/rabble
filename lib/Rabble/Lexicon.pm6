unit class Rabble::Lexicon does Associative;

has %!entries;
has $!context;

submethod BUILD(:$!context, :@modules) {
  for @modules -> \wordmod {
    self.import-words-from($!context, wordmod)
  }
}

method AT-KEY($name) { %!entries{$name} }

multi method define(Str :$name!, Code :&block!) {
  %!entries{$name} = { name => $name, block => &block, immediate => False }
}

multi method define(Str :$name!, Code :&block!, :$immediate!) {
  %!entries{$name} = { name => $name, block => &block, immediate => True }
}

method alias($name, $old-name) {
  my %entry = self{$old-name};
  die "No such word $old-name" without %entry;
  my %new-entry = %entry.clone :$name;
  %!entries{$name} = %new-entry;
}

method import-words-from($ctx, \wordmod) {
  for wordmod::EXPORT::DEFAULT::.kv -> $name, $sub {
    self.define-word($name, $sub.assuming($ctx));
  }
}
