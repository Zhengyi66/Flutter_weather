class BaseBean<T> {
  final String status;
  final String msg;
  final T result;

  BaseBean({this.status, this.msg, this.result});

  factory BaseBean.fromJson(Map<String, dynamic> json){
    return BaseBean(
      status: json['status'],
      msg: json['msg']
    );
  }
}
