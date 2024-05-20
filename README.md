# TrainTicketApplication
Train Ticket Application is a Perl-based tool with used Mojolicious FrameWork designed to handle ticket purchases efficiently. It allows users to purchase tickets, view available events, and manage their orders.

### Installation & Prerequisites
- Perl (version 5.16.3)
- CPAN modules: `Mojolicious::Lite`, `Data::Dumper`, `Mojo::Util 'url_unescape'`, `Test::Mojo`,  `FindBin`, `lib "$FindBin::Bin/../lib"`, `Mojolicious::Commands` etc.

### Steps
1. Clone the repository:
    ```sh
    git clone https://github.com/armoorthy/TrainTicketApplication.git
    ```
2. Navigate to the project directory:
    ```cd
    cd C:/TrainTicketApplication
    ```
	
## Usage
To run the application, use the following command:
```cmd
morbo script/ticket_app_script.pl	
```
To run the Test cases
``` cmd
prove -l t/testcase.t
```

## User Details to Purchase the Ticket

User Details Below
{
    "email": "moorthy.arumugam@cloudbees.com",
    "first_name": "moorthy",
    "last_name": "arumugam",
    "section": "A"
}

# Description
I have created APi Call's for the below checks

1) Purchasing Ticket             --  http://127.0.0.1:3000/purchase_ticket
2) View Receipts for the Users   --  http://127.0.0.1:3000/receipt?email=moorthy.arumugam@cloudbees.com
3) API to view users by section  --  http://127.0.0.1:3000/section/A
4) API to remove a user          --  http://127.0.0.1:3000/remove_user?email=moorthy.arumugam@cloudbees.com  
5) API to modify a user's seat   --  http://127.0.0.1:3000/modify_seat

Additionally one Api Call Added to Cancel the ticket if User Email is already Exists.
6) API to remove a user and refund ticket amount  -- http://127.0.0.1:3000/cancel_ticket?email=moorthy.arumugam@cloudbees.com

-------------------------------------------------------
