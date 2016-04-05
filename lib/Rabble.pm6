unit class Rabble;

use Rabble::Lexicon;
use Rabble::Reader;
use Rabble::Compiler;

has @.stack;

has %.lexicon;
has Rabble::Reader $.reader;
has Rabble::Compiler $.compiler;

has IO::Handle $!in;
has IO::Handle $!out;

submethod BUILD(:$!in = $*IN, :$!out = $*OUT) {
  $!reader .= new :in($!in);
  %!lexicon := Rabble::Lexicon.new(
    context => self,
    modules => [
      (require Rabble::Verbs::Shufflers),
      (require Rabble::Verbs::StackOps),
      (require Rabble::Verbs::IO),
      (require Rabble::Math::Arithmetic),
      (require Rabble::Verbs::Comparators)
    ]
  );
  $!compiler .= new :context(self) :lexicon(%!lexicon);
  %!lexicon.alias('+', 'plus');
  %!lexicon.alias('*', 'multiply');
  %!lexicon.alias('-', 'subtract');
  %!lexicon.alias('/', 'divide');

  %!lexicon.alias('=', 'equal');
  %!lexicon.alias('<>', 'not-equal');
  %!lexicon.alias('>', 'greater-than');
  %!lexicon.alias('<', 'less-than');

  %!lexicon.alias('.', 'dot');
  %!lexicon.alias('.S', 'dot-s');

  # %!lexicon.define :name(':')   :block({ self.read-and-define-word });
  # %!lexicon.define :name('[')   :block({ read_quotation });
  %!lexicon.define :name('bye') :block({ exit });
  # %!lexicon.define :name('\\')  :block({ $!in.readline }) :immediate;
}

=begin OLD_WAYS
method evaluate {
  my %entry = self.resolve-word($_);

  with %entry { %entry<block>() }
  else { $!out.say: "$_ ??" }
}

method resolve-word(Str $word) {
  return $_ with %!lexicon{$word};
  my $x;
  given $word {
    when /^<:Letter>/ { $x = ~$word }
    when /^<:Number>/ { $x = +$word }
  }
  with $x {
    return {
      name      => $word,
      block     => { @!stack.push: $x },
      immediate => False
    }
  }
}

method read-and-define-word {
  my $name = $!reader.read;
  my @words;
  while (my $word = $!reader.read) {
    last if $word eq ';';
    @words.push: $word;
  }
  my $p = $!compiler.compile-words(self, |@words);
  %!lexicon.define-word :name($name), :block($p);
}

method read_quotation {
  my @words;
  while (my $word = $!reader.read) {
    last if $word eq ']';
    @words.push: $word;
  }
  @!stack.push: $!compiler.compile-words(self, |@words);
}
=end OLD_WAYS

method run(Str $code) {
  $!reader.parse($code, :actions($!compiler));
  $_<block>() for @!stack;
}
