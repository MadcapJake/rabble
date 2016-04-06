unit class Rabble;

use Rabble::Lexicon;
use Rabble::Reader;
use Rabble::Compiler;

has @.stack;

has %!lexicon;
has Rabble::Reader $!reader;
has Rabble::Compiler $!compiler;

has IO::Handle $.in;
has IO::Handle $.out;

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

  %!lexicon.define :name('bye') :block({ exit });
}

method run(Str $code) {
  $!reader.parse($code, :actions($!compiler));

  # for @!stack -> $expr {
  #   if $*DEBUG {
  #     say 'Stack';
  #     for @!stack -> $elem { dd $elem }
  #   }
  #   $expr<block>()
  # }

}
