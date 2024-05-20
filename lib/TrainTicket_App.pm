#!/usr/bin/env perl

package TrainTicket_App;
use Mojolicious::Lite;
use Data::Dumper;
use Mojo::Util 'url_unescape';

my $ticket_price = 5;
my %users;
my %seats = (A => [], B => []);

# API to purchase a ticket
post '/purchase_ticket' => sub {
    my $c = shift;
 
    my $user = $c->req->json;
    
    my $first_name = $user->{first_name};
    my $last_name  = $user->{last_name};
    my $email = $user->{email};
    my $section = $user->{section};
    my $from = 'US';
    my $to = 'London';
    
    if ($section ne "A" && $section ne "B") {
        return $c->render(json => { error => 'Invalid section' }, status => 400);
    }
    my $seat_number = scalar @{ $seats{$section} } + 1;
    
	# app->log->debug("seatsection: " . Dumper ($seats{$section}));
	# app->log->debug("seatnumber: " . $seat_number);
	
    push @{ $seats{$section} }, $email;
    $users{$email} = {
        first_name => $first_name,
        last_name => $last_name,
        email    => $email,
        from    => $from,
        to      => $to,
        price   => $ticket_price,
        section => $section,
        seat    => $seat_number,
    };
    
    $c->render(json => { message => 'Ticket purchased successfully', receipt => $users{ $email } });
};

# API to show receipt details
get '/receipt' => sub {
    my $c = shift;
    
    my $email = $c->param('email');
    
    if (exists $users{$email}) {
        $c->render(json => $users{$email});
    } else {
        $c->render(json => { error => 'Receipt not found' }, status => 404);
    }
};

# API to view users by section
get '/section/:section' => sub {
    my $c = shift;
    my $section = $c->stash('section');
    if (exists $seats{$section}) {
        $c->render(json => { section => $section, users => [ map { $users{$_} } @{ $seats{$section} } ] });
    } else {
        $c->render(json => { error => 'Section not found' }, status => 404);
    }
};

# API to remove a user
del '/remove_user' => sub {
    my $c = shift;
    my $email = $c->param('email');
    if (exists $users{$email}) {
        my $section = $users{$email}->{section};
        $seats{$section} = [ grep { $_ ne $email } @{ $seats{$section} } ];
        delete $users{$email};
        $c->render(json => { message => 'User removed successfully' });
    } else {
        $c->render(json => { error => 'User not found' }, status => 404);
    }
};

# API to modify a user's seat
put '/modify_seat' => sub {
    my $c = shift;
    my $muser = $c->req->json;
    
    my $memail = $muser->{email};
    my $newsection = $muser->{new_section};
    
    if ($newsection ne 'A' && $newsection ne 'B') {
        return $c->render(json => { error => 'Invalid section' }, status => 400);
    }
    if (exists $users{$memail} && exists $seats{$newsection}) {
        my $old_section = $users{$memail}->{section};
        $seats{$old_section} = [ grep { $_ ne $memail } @{ $seats{$old_section} } ];
        push @{ $seats{$newsection} }, $memail;
        $users{$memail}->{section} = $newsection;
        $users{$memail}->{seat} = scalar @{ $seats{$newsection} };
        
        $c->render(json => { message => 'Seat modified successfully', user => $users{$memail} });
    } else {
        $c->render(json => { error => 'User or section not found' }, status => 404);
    }
};

# API to remove a user and refund ticket amount
del '/cancel_ticket' => sub {
    my $c = shift;
    my $email = $c->param('email');
    
	if (exists $users{$email}) {
        my $section = $users{$email}->{section};
        $seats{$section} = [ grep { $_ ne $email } @{ $seats{$section} } ];
		my $refund_amount = $users{$email}->{price};
        delete $users{$email};
        $c->render(json => { message => 'Ticket canceled successfully', refund_amount => $refund_amount });
    } else {
        $c->render(json => { error => 'User not found' }, status => 404);
    }
};

app->start;

1;
