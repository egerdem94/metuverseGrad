class PhoneNumberResponse {
/*
$message = "1"; //Ulaşılmak istenen kullanıcının yetkisi komple açık ve telefon numarası kayıtlıdır.,
$message = "2"; //Ulaşılmak istenen kullanıcının telefon yetkisi kısmi olarak bazı kişilere açıktır ve ulaşmak isteyen kullanıcı bu kişilere dahildir. Telefon numarası kayıtlıdır.
$message = "3"; //Boyle bir post yok ya da silinmiş ya da gelen postID`si yanlis
$message = "4"; //Ulasilmak istenen kullanıcının telefon yetkisi komple kapalıdır.
$message = "5"; //Ulaşılmak istenen kullanıcının telefon yetkisi kısmi olarak bazı kişilere açıktır fakat ulaşmak isteyen kullanıcı bu kişilere dahil değildir.
$message = "6"; //Ulaşılmak istenen kullanıcının telefonu kayıtlı değldir.
$message = "255" //"wrong token";
*/
  String? message;
  String? relatedUserPublicToken;
  String? relatedPhoneNumber;

  PhoneNumberResponse({this.message, this.relatedUserPublicToken, this.relatedPhoneNumber});

  PhoneNumberResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    relatedUserPublicToken = json['relatedUserPublicToken'];
    relatedPhoneNumber = json['relatedPhoneNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['relatedUserPublicToken'] = this.relatedUserPublicToken;
    data['relatedPhoneNumber'] = this.relatedPhoneNumber;
    return data;
  }
}

