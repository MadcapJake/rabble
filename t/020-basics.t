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

.run: '5 .';
is $out.said, '5', 'alias and dot work';

.run: '5 2 + .';
is $out.said, '7', "plus works";

.run: '5 2 1 + .';
is $out.said, '3', 'dot prints last value';

.run: '4 .S';
is $out.said, '5 4>', 'dot-s prints whole stack';

.run: 'drop drop .S';
is $out.said, '>', 'drop removes elems on the stack';

.run: '5 2 .S';
is $out.said, '5 2>', 'dot-s prints stack';

done-testing;
