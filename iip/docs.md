# Installation

## Ruby

Wiresnark requires Ruby 1.9 – you can install
it from your system’s package manager or from
[ruby-lang.org](http://www.ruby-lang.org/en/downloads):

    wget http://ftp.ruby-lang.org/pub/ruby/1.9/ruby-1.9.3-p125.tar.gz
    tar xf ruby-1.9.3-p125.tar.gz
    cd ruby-1.9.3-p125
    ./configure
    make
    make install

## Wiresnark

For the time being, Wiresnark installation is a two-step
process – installation from gem and compilation of a C
driver (this will be fixed in a later release).

### Install from gem

    gem install wiresnark

### Compile C driver

    cd $(dirname `gem which wiresnark`)/..
    rake build_regset

### IIP

Install from the `system_iip` repository; the provided
drivers and `konfig.py` are configured to use Wiresnark.

# supported IIP commands

Wiresnark can be used as an `iip.py` backend; `iip.py`
implements the `iip set` commands (used to create the
XML configuration), while the `iip commit`, `iip get`
and `iip show` commands are forwarded to Wiresnark.

Supported `iip show` parameters are `CL`, `ifgap`,
`MACDA`, `MACSA`, `MACT`, `MTU`, `NP`, `PIH` and `PL`.

XML elements set by `iip get` are `PIH`, `MACSourceAddress`,
`MACDestinationAddress`, `MACType`, `MTU`, `ifgap`,
`Cyclelength`, `NumberPhases` and `PhaseLength`.
