class ApiResponse<T> {
  Status status;

  T data;

  ApiResponse.loading(this.message) {
    status = Status.LOADING;
  }

  String message;

  ApiResponse.completed(this.data) : status = Status.COMPLETED;

  ApiResponse.error(this.message) : status = Status.ERROR;
  ApiResponse.connectionError(this.message) : status = Status.CONNECTION_ERROR;

  @override
  String toString() {
    return "Status : $status \n Message : $message \n Data : $data";
  }
}

enum Status { LOADING, COMPLETED, ERROR, CONNECTION_ERROR }
