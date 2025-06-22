
class OrdersRequest{
   bool pagination;
   int limit;
   int page;
   int status;

   OrdersRequest(this.pagination ,this.limit,this.page,this.status);
}