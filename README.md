[![Build Status](https://travis-ci.org/powerman/perl-Export-Attrs.svg?branch=master)](https://travis-ci.org/powerman/perl-Export-Attrs)
[![Coverage Status](https://coveralls.io/repos/powerman/perl-Export-Attrs/badge.svg?branch=master)](https://coveralls.io/r/powerman/perl-Export-Attrs?branch=master)

# NAME

Export::Attrs - The Perl 6 'is export(...)' trait as a Perl 5 attribute

# VERSION

This document describes Export::Attrs version 0.000005

# SYNOPSIS

    package Some::Module;
    use Export::Attrs;

    # Export &foo by default, when explicitly requested,
    # or when the ':ALL' export set is requested...

    sub foo :Export(:DEFAULT) {
        print "phooo!";
    }


    # Export &var by default, when explicitly requested,
    # or when the ':bees', ':pubs', or ':ALL' export set is requested...
    # the parens after 'is export' are like the parens of a qw(...)

    sub bar :Export(:DEFAULT :bees :pubs) {
        print "baaa!";
    }


    # Export &baz when explicitly requested
    # or when the ':bees' or ':ALL' export set is requested...

    sub baz :Export(:bees) {
        print "baassss!";
    }


    # Always export &qux
    # (no matter what else is explicitly or implicitly requested)

    sub qux :Export(:MANDATORY) {
        print "quuuuuuuuux!";
    }


    # Allow the constant $PI to be exported when requested...

    use Readonly;
    Readonly our $PI :Export => 355/113;


    # Allow the variable $EPSILON to be always exported...

    our $EPSILON :Export( :MANDATORY ) = 0.00001;


    sub IMPORT {
        # This subroutine is called when the module is used (as usual),
        # but it is called after any export requests have been handled.
    };

# DESCRIPTION

**NOTE:** This module is a fork of [Perl6::Export::Attrs](https://metacpan.org/pod/Perl6::Export::Attrs) created to
restore compatibility with Perl6::Export::Attrs version 0.0.3.

Implements a Perl 5 native version of what the Perl 6 symbol export mechanism
will look like (with some unavoidable restrictions).

It's very straightforward:

- If you want a subroutine or package variable to be capable of being exported
(when explicitly requested in the `use` arguments), you mark it with
the `:Export` attribute.
- If you want a subroutine or package variable to be automatically exported when
the module is used (without specific overriding arguments), you mark it
with the `:Export(:DEFAULT)` attribute.
- If you want a subroutine or package variable to be automatically exported when
the module is used (even if the user specifies overriding arguments),
you mark it with the `:Export(:MANDATORY)` attribute.
- If the subroutine or package variable should also be exported when particular
export groups are requested, you add the names of those export groups to
the attribute's argument list.

That's it.

## `IMPORT` blocks

Perl 6 replaces the `import` subroutine with an `IMPORT` block. It's
analogous to a `BEGIN` or `END` block, except that it's executed every
time the corresponding module is `use`'d.

The `IMPORT` block is passed the argument list that was specified on
the `use` line that loaded the corresponding module, minus the
arguments that were used to specify exports.

Note that, due to limitations in Perl 5, the `IMPORT` block provided by this
module must be terminated by a semi-colon, unless it is the last statement in
the file.

# DIAGNOSTICS

- %s does not export: %s\\nuse %s failed

    You tried to import the specified subroutine or package variable, but
    the module didn't export it. Often caused by a misspelling, or
    forgetting to add an `:Export` attribute to the definition of the
    subroutine or variable in question.

- Bad tagset in :Export attribute at %s line %s: \[%s\]

    You tried to import a collection of items via a tagset, but the module
    didn't export any subroutines under that tagset. Is the tagset name
    misspelled (maybe you forgot the colon?).

- Can't export lexical %s variable at %s

    The module can only export package variables. You applied the `:Export`
    marker to a non-package variable (almost certainly to a lexical). Change
    the variable's `my` declarator to an `our`.

- Can't export anonymous subroutine at %s

    Although you _can_ apply the `:Export` marker to an anonymous subroutine,
    it rarely makes any sense to do so, since that subroutine can't be
    exported without a name to export it as. Either give the subroutine a
    name, or make sure it's aliased to a named typeglob at compile-time (or,
    at least, before it's exported).

# CONFIGURATION AND ENVIRONMENT

Export::Attrs requires no configuration files or environment variables.

# DEPENDENCIES

This module requires the Attribute::Handlers module to handle the attributes.

# INCOMPATIBILITIES

This module cannot be used with the Memoize CPAN module,
because memoization replaces the original subroutine
with a wrapper. Because the `:Export` attribute is
applied to the original (not the wrapper), the memoized
wrapper is not found by the exporter mechanism.

# LIMITATIONS

Note that the module does not support exporting lexical variables,
since there is no way for the exporter mechanism to determine the name
of a lexical and hence to export it.

Nor does this module support the numerous addition export modes that
Perl 6 offers, such as export-as-lexical or export-as-state.

# SUPPORT

## Bugs / Feature Requests

Please report any bugs or feature requests through the issue tracker
at [https://github.com/powerman/perl-Export-Attrs/issues](https://github.com/powerman/perl-Export-Attrs/issues).
You will be notified automatically of any progress on your issue.

## Source Code

This is open source software. The code repository is available for
public review and contribution under the terms of the license.
Feel free to fork the repository and submit pull requests.

[https://github.com/powerman/perl-Export-Attrs](https://github.com/powerman/perl-Export-Attrs)

    git clone https://github.com/powerman/perl-Export-Attrs.git

## Resources

- MetaCPAN Search

    [https://metacpan.org/search?q=Export-Attrs](https://metacpan.org/search?q=Export-Attrs)

- CPAN Ratings

    [http://cpanratings.perl.org/dist/Export-Attrs](http://cpanratings.perl.org/dist/Export-Attrs)

- AnnoCPAN: Annotated CPAN documentation

    [http://annocpan.org/dist/Export-Attrs](http://annocpan.org/dist/Export-Attrs)

- CPAN Testers Matrix

    [http://matrix.cpantesters.org/?dist=Export-Attrs](http://matrix.cpantesters.org/?dist=Export-Attrs)

- CPANTS: A CPAN Testing Service (Kwalitee)

    [http://cpants.cpanauthors.org/dist/Export-Attrs](http://cpants.cpanauthors.org/dist/Export-Attrs)

# AUTHOR

Alex Efros &lt;powerman@cpan.org>

Damian Conway <DCONWAY@cpan.org>

# COPYRIGHT AND LICENSE

This software is Copyright (c) 2016 by Alex Efros &lt;powerman@cpan.org>.

Copyright (c) 2005,2015 Damian Conway <DCONWAY@cpan.org>. All rights reserved.

This module is free software; you can redistribute it and/or
modify it under the same terms as Perl itself.
