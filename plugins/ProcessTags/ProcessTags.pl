# Process Tags 1.0.1
# Tag post-processing plugin for Movable Type
#
# Copyright 2002 Kalsey Consulting Group
# http://kalsey.com/
# Using this software signifies your acceptance of the license
# file that accompanies this software.
#
# Installation and usage instructions can be found at
# http://kalsey.com/blog/
#
# Updated by Scott Boms to better support MT4
# Version 1.0.1
# 2009/09/09

package MT::Plugin::ProcessTags;
use strict;
use warnings;

use base qw( MT::Plugin );

use MT::Template::Context;
use MT 4.0;
our $VERSION = '1.0.1';

my $plugin = MT::Plugin::ProcessTags->new({
  id          => 'processtags',
  name        => 'ProcessTags',
  description => 'A plugin to allow MT tag processing in context of an entry.',
  author_name => 'Adam Kalsey (Updated by Scott Boms)',
  author_link => 'http://kalsey.com',
  doc_link    => 'http://kalsey.com/blog/',
  icon        => 'pt-icon.gif',
  version     => $VERSION,
  registry    => {
      tags => {
        modifier => {
          'process_tags' => \&process_tags,
      },
    },
  },
});

MT->add_plugin($plugin);

sub process_tags {
  my ($string, $args, $ctx) = @_;
  my $builder = $ctx->stash('builder');
  my $tokens = $ctx->stash('tokens');
  my $tok = $builder->compile($ctx, $string);
  my $out = $builder->build($ctx, $tok);
  return $ctx->error("Error processing tags with Process Tags plugin: ".$builder->errstr) 
    unless defined $out;
  $string = $out;
}

1;
__END__