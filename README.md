# Installation

## Ruby

Wiresnark IIP requires Ruby 1.9 – you can install
it from your system’s package manager or from
[ruby-lang.org](http://www.ruby-lang.org/en/downloads):

    wget http://ftp.ruby-lang.org/pub/ruby/1.9/ruby-1.9.3-p194.tar.gz
    tar xf ruby-1.9.3-p194.tar.gz
    cd ruby-1.9.3-p194
    ./configure
    make
    make install

## Wiresnark IIP

Wiresnark IIP installation is a two-step process: installing
the gem’s dependencies and installing the gem itself.

### Install the gem’s dependencies

    gem install ffi nokogiri

### Install the gem

    wget https://svn.man.poznan.pl/svnroot/iip-netfpga/system_iip/trunk/wiresnark-iip/wiresnark-iip.gem
    gem install --local wiresnark-iip.gem

### IIP

Install from the `system_iip` repository; the provided
drivers and `konfig.py` are configured to use Wiresnark IIP.

# supported IIP commands

Wiresnark IIP can be used as an `iip.py` backend; `iip.py`
implements the `iip set` commands (used to create the
XML configuration), while the `iip commit`, `iip get`
and `iip show` commands are forwarded to Wiresnark IIP.

Supported `iip show` parameters are `CL`, `ifgap`,
`MACDA`, `MACSA`, `MACT`, `MTU`, `NP`, `PIH` and `PL`.

XML elements set by `iip get` are `PIH`, `MACSourceAddress`,
`MACDestinationAddress`, `MACType`, `MTU`, `ifgap`,
`Cyclelength`, `NumberPhases` and `PhaseLength`.
