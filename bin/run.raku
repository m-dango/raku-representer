#!/usr/bin/env raku
use JSON::Fast;

unit sub MAIN (
    $slug,
    $solution-path,
    $output-path,
);

my $ast = $solution-path.IO.add(<lib Leap.rakumod>).slurp.AST.raku;

my %mappings = $ast
    .lines
    .map({.match(/name \s+ .*? (\".*?\")/)[0] andthen .Str orelse Empty})
    .unique
    .pairs
    .map({'PLACEHOLDER' ~ .key => .value});

given $output-path.IO {
    .add('mappings.json'      ).spurt( to-json(%mappings) ~ "\n");
    .add('representation.txt' ).spurt( $ast.trans(%mappings.values => %mappings.keys) ~ "\n" );
    .add('representation.json').spurt( to-json({:version(1)}) ~ "\n" )
}
