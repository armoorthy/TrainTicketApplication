use Test::More;
use Test::Mojo;

# Create a Test::Mojo object
my $t = Test::Mojo->new('TrainTicket_App');

# Test API to purchase a ticket
$t->post_ok('/purchase_ticket' => json => {
    email      => "moorthy.arumugam@cloudbees.com",
    first_name => "moorthy",
    last_name  => "arumugam",
    section    => "A",
})
->status_is(200)
->json_is('/receipt' => {
    email      => "moorthy.arumugam@cloudbees.com",
    first_name => "moorthy",
    last_name  => "arumugam",
    from       => "US",
    to         => "London",
    price      => 5,
    seat       => 1,
    section    => "A",
});

done_testing();