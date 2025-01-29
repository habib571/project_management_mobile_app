class Pagination {
   int page ;
   int size ;
   Pagination(this.page, this.size);
   Map<String, dynamic> toJson() {
     return {
       'page': page,
       'size': size,
     };
   }
}