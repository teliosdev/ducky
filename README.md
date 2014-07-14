# Ducky

Retreives documentation on any core, stdlib, or gem method.  Core and
stdlib get the added benefit of checking the inheritance chain; for
gems, it only checks the class.

## Installation

Install it yourself:

    $ gem install ducky

## Usage

Check out

    $ ducky help

The ducky command line has three subcommands: `core`, `stdlib`, or
`gem`.  `core` expects 1 or 2 parameters; the first is the method to
lookup, and the second (optional) is the ruby version to look it up
on.  `stdlib` expects 2 or 3 parameters; the first is the stdlib
library that the method is under, the second is the method, and
the third (optional) is the ruby version to look it up on.  `gem`
expects 2 or 3 parameters; the first is the gem the method is under,
the second is the method, and the third (optional) is the version of
the gem to look it up on (by default, selects the latest version).

### Method Value

method values look like `<class><accessor><method>`, where `<class>`
is the class it's defined on, `<accessor>` is how the method is
accessed (i.e. one of `.`, `#`, or `::`), and `method` is the method
name.  `<class>` is optional (it defaults to `Object`); others are
not.  For example, `Kernel#printf`, `Array.new`, `#object_id` are
all valid, but `printf`, `Kernel`, and `Array.` are not.

### Examples

    > ducky gem antelope "Antelope::Generator::Base#template"
    - (void) template(source, destination) {|content| ... } (protected)

    This method returns an undefined value.
    Copies a template from the source, runs it through erb (in the context of this
    class), and then outputs it at the destination. If given a block, it will call
    the block after the template is run through erb with the content from erb; the
    result of the block is then used as the content instead.

    Parameters:
     source (String) — the source file. This should be in source_root.

     destination (String) — the destination file. This will be in Ace::Grammar#output.

    Yield Parameters:
     content (String) — The content that ERB created.

    Yield Returns:
     (String) — The new content to write to the output.

    > ducky core "Array.new"
    new(size=0, obj=nil)
    new(array)
    new(size) {|index| block }


    Returns a new array.
    # (truncated)


## Contributing

1. Fork it ( https://github.com/medcat/ducky/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
