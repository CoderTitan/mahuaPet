
class FuncUntils {
  
  // 格式化手机号, 添加空格
  static String formatPhone(account) {
    String phoneStr = account.toString().replaceAll(' ', '');
    if (phoneStr.length > 7 && phoneStr.length <= 11) {
      phoneStr = phoneStr.substring(0, 7) + ' ' + phoneStr.substring(7);
      phoneStr = phoneStr.substring(0, 3) + ' ' + phoneStr.substring(3);
    }
    if (phoneStr.length > 3 && phoneStr.length < 8) {
      phoneStr = phoneStr.substring(0, 3) + ' ' + phoneStr.substring(3);
    }
    return phoneStr;
  }

  // 手机号去除空格
  static String getPhone(account) {
    return account.toString().replaceAll(' ', '');
  }

  // 判断手机号是否符合规则
  static bool isPhoneNumber(account) {
    // 手机段：134,135,136,137,138,139,147,148[卫星通信],150,151,152,157,158,159,172,178,182,183,184,187,188,198
    final isChinaMobile = new RegExp(r'^(1(3[4-9]|4[78]|5[0-27-9]|7[28]|8[2-478]|98)\d{8}$)');// 中国移动
		// 手机段：130,131,132,145,146[卫星通信],155,156,166,171,175,176,185,186
		final isChinaUnicom = new RegExp(r'^(1(3[0-2]|4[56]|5[56]|66|7[156]|8[56])\d{8}$)');// 中国联通
		// 手机段：133,149,153,173,174,177,180,181,189,199
		final isChinaTelcom = new RegExp(r'^(1(33|49|53|7[347]|8[019]|99)\d{8}$)');// 中国电信
		final isOtherTelphone = new RegExp(r'^(170\\d{8}$)');

    if (isChinaMobile.hasMatch(account)) {
      return true;
    } else if (isChinaUnicom.hasMatch(account)) {
      return true;
    } else if (isChinaTelcom.hasMatch(account)) {
      return true;
    } 
    return isOtherTelphone.hasMatch(account);
  }
}