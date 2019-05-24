import 'dart:convert';
import 'dart:io';

/// 网络请求
class DTHttpRequest {
  ///主机名
  static final String _host = 'api.dreamstech.cn';

  ///目录
  static final String _path = '/v2/gslian_dev';

  ///票据
  static final String _ticket =
      't0aEYsQo9zHXOEF6uvIXC3ofX7IIkQMVV86mhPRFrwq6P4xwCZ6VhpBdQjKMN4s9kM7fA0yTLJgMHjOCC1tC7cDGEq4jWC+S1FTfPIpQByQdPV3jY2TaVVigZRTCVSKjbOT+ODJg4UPpa6nrVyyESUXz/9ebR+p6zQnfIowZJho=|11|11';

  ///GET请求
  static Future<Map<String, dynamic>> get(String path, [Map<String, String> params]) async {
    return request(DTHttpRequestMethod.Get, path, params);
  }

  ///POST请求
  static Future<Map<String, dynamic>> post(String path, [Map<String, String> params]) async {
    return request(DTHttpRequestMethod.Post, path, params);
  }

  ///网络请求
  static Future<Map<String, dynamic>> request(DTHttpRequestMethod method, String path,
      [Map<String, String> params]) async {
    var client = HttpClient();
    var url = Uri.https(_host, _path + path, params);
    //请求方式
    var request = await (method == DTHttpRequestMethod.Post
        ? client.postUrl(url)
        : client.getUrl(url));
    //请求头
    request.headers
        .add(HttpHeaders.contentTypeHeader, "application/json;charset=utf-8");
    request.headers.add('X-AUTH-HEADER', _ticket);
    //响应数据
    var response = await request.close();
    return _handleReponse(response);
  }

  ///处理响应
  static Future<Map<String, dynamic>> _handleReponse(HttpClientResponse response) async{
    var result = {'ret': 0, 'msg': '', 'data': null};
    if (response.statusCode != HttpStatus.ok) {
      //网络异常
      result['ret'] = 1;
      result['msg'] = '(${response.statusCode}) ${response.reasonPhrase}';
    } else {
      try {
        var data = await response.transform(utf8.decoder).join();
        var json = jsonDecode(data);
        if (json['result'] != true) {
          //接口错误
          result['ret'] = 1;
          result['msg'] = json['errormsg'];
        } else {
          //返回数据
          result['ret'] = 0;
          result['data'] = json['data'];
        }
      } catch (ex) {
        //转换失败
        result['ret'] = 1;
        result['msg'] = '数据转换失败：$ex.message';
      }
    }
    return Future(() {
      return result;
    });
  }
}

///  网络请求方式
enum DTHttpRequestMethod {
  ///GET请求
  Get,

  ///POST请求
  Post,
}
