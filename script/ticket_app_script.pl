#!/usr/bin/env perl

use strict;
use warnings;
use FindBin;
use lib "$FindBin::Bin/../lib";
use Mojolicious::Commands;

# Start command line interface for application
Mojolicious::Commands->start_app('TrainTicket_App');
