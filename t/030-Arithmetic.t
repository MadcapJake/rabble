use v6.c;
use Test;

use lib 'lib';
use Rabble;

class Output is IO::Handle {
  has $.said;
  method say(*@args) { $!said = @args }
}
my Output $out .= new;

$_ = Rabble.new(:$out);

plan 5;

.run: '5 2 + .';
is $out.said, "7", 'addition';

.run: '5 2 * .';
is $out.said, '10', 'multiplication';

.run: '5 2 - .';
is $out.said, '3', 'subtraction';

.run: '10 2 / .';
is $out.said, '5', 'division';

.run: '-10 abs .';
is $out.said, '10', 'absolute';
