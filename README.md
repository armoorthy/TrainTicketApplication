# TrainTicketApplication


I have used Active State Perl version(5.16.3). I'm Using Mojolicious FrameWork for this task. I have created Api's and request in Postman it work's fine. Also Test Case Partially Completed.
I have created APi Call's for the below checks


User Details Below
{
    "email": "moorthy.arumugam@cloudbees.com",
    "first_name": "moorthy",
    "last_name": "arumugam",
    "section": "A"
}

1) Purchasing Ticket             --  http://127.0.0.1:3000/purchase_ticket
2) View Receipts for the Users   --  http://127.0.0.1:3000/receipt?email=moorthy.arumugam@cloudbees.com
3) API to view users by section  --  http://127.0.0.1:3000/section/A
4) API to remove a user          --  http://127.0.0.1:3000/remove_user?email=moorthy.arumugam@cloudbees.com  
5) API to modify a user's seat   --  http://127.0.0.1:3000/modify_seat

Additionally one Api Call Added to Cancel the ticket if User Email is already Exists.
6) API to remove a user and refund ticket amount  -- http://127.0.0.1:3000/cancel_ticket?email=moorthy.arumugam@cloudbees.com

-------------------------------------------------------
Place the files in your local as below paths
Main Code should be placed into lib folder  -------  "C:\Perl\site\lib\TrainTicket_App.pm"
Test Code should be placed into t folder    -------  "C:\Perl\site\t\testcase.t"
