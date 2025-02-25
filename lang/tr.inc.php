<?php
#==============================================================================
# LTB Self Service Password
#
# Copyright (C) 2009 Clement OUDOT
# Copyright (C) 2009 LTB-project.org
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# GPL License: http://www.gnu.org/licenses/gpl.txt
#
#==============================================================================

#==============================================================================
# Turkish
#==============================================================================
$messages['phpupgraderequired'] = "PHP güncellemesi gerekli";
$messages['nophpldap'] = "Bu aracı kullanabilmek için PHP LDAP yüklemelisiniz";
$messages['nophpmhash'] = "Samba modunu kullanmak için PHP mhash yüklemelisiniz";
$messages['nokeyphrase'] = "Belirteç şifrelemesi için keyphrase ayarında rastgele bir metin olması gerekir";
$messages['ldaperror'] = "LDAP dizinine ulaşılamıyor";
$messages['loginrequired'] = "Kullanıcı adınız gereklidir";
$messages['oldpasswordrequired'] = "Eski parolanız gereklidir";
$messages['newpasswordrequired'] = "Yeni parolanız gereklidir";
$messages['confirmpasswordrequired'] = "Lütfen yeni parolanızı doğrulayın";
$messages['passwordchanged'] = "Parolanız değiştirildi";
$messages['nomatch'] = "Parolalar uyuşmuyor";
$messages['badcredentials'] = "Kullanıcı adı ya da parola hatalı";
$messages['passworderror'] = "Parola LDAP dizini tarafından reddedildi";
$messages['title'] = "Self servis parola";
$messages['login'] = "Kullanıcı adı";
$messages['oldpassword'] = "Eski parola";
$messages['newpassword'] = "Yeni parola";
$messages['confirmpassword'] = "Onayla";
$messages['submit'] = "Gönder";
$messages['getuser'] = "Kullanıcıyı al";
$messages['tooshort'] = "Parolanız çok kısa";
$messages['toobig'] = "Parolanız çok uzun";
$messages['minlower'] = "Parolanızda yeterli sayıda küçük harf yok";
$messages['minupper'] = "Parolanızda yeterli sayıda büyük harf yok";
$messages['mindigit'] = "Parolanızda yeterli sayıda rakam yok";
$messages['minspecial'] = "Parolanızda yeterli sayıda özel karakter yok";
$messages['sameasold'] = "Yeni parolanız ile eski parolanız aynı";
$messages['policy'] = "Parolanız bu kısıtlamalara uymalıdır:";
$messages['policyminlength'] = "Minimum uzunluk:";
$messages['policymaxlength'] = "Maksimum uzunluk:";
$messages['policyminlower'] = "Minimum küçük harf sayısı:";
$messages['policyminupper'] = "Minimum büyük harf sayısı:";
$messages['policymindigit'] = "Minimum rakam sayısı:";
$messages['policyminspecial'] = "Minimum özel karakter sayısı:";
$messages['forbiddenchars'] = "Parolanız izin verilmeyen karakterler içermektedir";
$messages['policyforbiddenchars'] = "İzin verilmeyen karakterler:";
$messages['policynoreuse'] = "Yeni parolanız eski parolanız ile aynı olamaz";
$messages['questions']['birthday'] = "Doğum tarihiniz ne?";
$messages['questions']['color'] = "En sevdiğiniz renk ne?";
$messages['password'] = "Parola";
$messages['question'] = "Soru";
$messages['answer'] = "Cevap";
$messages['setquestionshelp'] = "Parola sıfırlama soru/yanıtınızı değiştirin veya oluşturun. Bu işlemden sonra parolanızı <a href=\"?action=resetbyquestions\">buradan</a> sıfırlayabilirsiniz.";
$messages['answerrequired'] = "Cevap girilmedi";
$messages['questionrequired'] = "Soru seçilmedi";
$messages['passwordrequired'] = "Parolanız gereklidir";
$messages['answermoderror'] = "Cevabınız kaydedilmedi";
$messages['answerchanged'] = "Cevabınız kaydedildi";
$messages['answernomatch'] = "Cevabınız hatalı";
$messages['resetbyquestionshelp'] = "Parolanızı sıfırlamak için seçtiğiniz bir soruyu yanıtlayın. Bu işlemi yapabilmek için önceden bir <a href=\"?action=setquestions\">cevap kaydetmiş</a> olmanız gerekmektedir.";
$messages['changehelp'] = "Eski parolanızı girin ve yeni bir parola belirleyin.";
$messages['changehelpreset'] = "Parolanızı mı unuttunuz?";
$messages['changehelpquestions'] = "<a href=\"?action=resetbyquestions\">Soru yanıtlayarak parolanızı sıfırlayın</a>";
$messages['changehelptoken'] = "<a href=\"?action=sendtoken\">Parola sıfırlama e-postası alın</a>";
$messages['changehelpsms'] = "<a href=\"?action=sendsms\">SMS ile parolanızı sıfırlayın</a>";
$messages['resetmessage'] = "Merhaba {login},\n\nParolanızı sıfırlamak için buraya tıklayın:\n{url}\n\nEğer parola sıfırlama talep etmediyseniz bu e-postayı dikkate almayın.";
$messages['resetsubject'] = "Parolanızı sıfırlayın";
$messages['sendtokenhelp'] = "Parolanızı sıfırlamak için kullanıcı adınızı ve e-posta adresinizi girin. İşlemi tamamlamak için e-postanın içindeki linke tıklayın.";
$messages['sendtokenhelpnomail'] = "Parolanızı sıfırlamak için kullanıcı adınızı girin. İşlemi tamamlamak için e-postanın içindeki linke tıklayın.";
$messages['mail'] = "E-posta adresi";
$messages['mailrequired'] = "E-posta adresiniz gereklidir";
$messages['mailnomatch'] = "E-posta adresi ile kullanıcı adı uyuşmuyor";
$messages['tokensent'] = "Doğrulama e-postası gönderildi";
$messages['tokensent_ifexists'] = "Eğer hesap mevcutsa bir doğrulama e-postası hesaba ilişkili e-posta adresine gönderilmiştir";
$messages['tokennotsent'] = "Doğrulama e-postası gönderilirken hata oluştu";
$messages['tokenrequired'] = "Belirteç gerekli";
$messages['tokennotvalid'] = "Belirteç geçerli değil";
$messages['resetbytokenhelp'] = "E-postayla gönderilen link ile parolanızı sıfırlayabilirsiniz. Yeni bir link talep etmek için <a href=\"?action=sendtoken\">buraya</a> tıklayın.";
$messages['resetbysmshelp'] = "SMS ile gönderilen belirteçle parolanızı sıfırlayabilirsiniz. Yeni bir belirteç almak için <a href=\"?action=sendsms\">buraya</a> tıklayın.";
$messages['changemessage'] = "Merhaba {login},\n\nParolanız değiştirildi.\n\nEğer bu değişikliği siz yapmadıysanız en kısa sürede sistem yöneticinizle irtibata geçin.";
$messages['changesubject'] = "Parolanız değiştirildi";
$messages['badcaptcha'] = "Girilen güvenlik kodu hatalı, tekrar deneyin.";
$messages['captcharequired'] = "CAPTCHA gereklidir.";
$messages['captcha'] = "CAPTCHA";
$messages['notcomplex'] = "Parolanız yeterli sayıda değişik sınıf karaktere sahip değil";
$messages['policycomplex'] = "Minimum değişik karakter sınıfı sayısı:";
$messages['sms'] = "SMS numarası";
$messages['smsresetmessage'] = "Parola sıfırlama belirteciniz:";
$messages['sendsmshelp'] = "SMS almak için kullanıcı adınızı, sonrasında da SMS ile yollanan belirteci girin.";
$messages['smssent'] = "SMS ile bir doğrulama kodu gönderildi";
$messages['smsnotsent'] = "SMS gönderilirken hata oluştu";
$messages['smsnonumber'] = "Mobil numara bulunamıyor";
$messages['userfullname'] = "Kullanıcının tam adı";
$messages['username'] = "Kullanıcı adı";
$messages['smscrypttokensrequired'] = "crypt_tokens ayarı yapılmadan SMS ile sıfırlamayı kullanamazsınız";
$messages['smsuserfound'] = "Bilgilerin doğru olduğundan emin olduktan sonra SMS almak için Gönder'e basın";
$messages['smstoken'] = "SMS belirteci";
$messages['nophpmbstring'] = "PHP mbstring yüklemelisiniz";
$messages['menuquestions'] = "Soru";
$messages['menutoken'] = "E-posta";
$messages['menusms'] = "SMS";
$messages['nophpxml'] = "Bu aracı kullanabilmek için PHP XML yüklemelisiniz";
$messages['tokenattempts'] = "Geçersiz belirteç, tekrar deneyin";
$messages['emptychangeform'] = "Parolanızı değiştirin";
$messages['emptysendtokenform'] = "Parola sıfırlama e-postası yolla";
$messages['emptyresetbyquestionsform'] = "Parolanızı sıfırlayın";
$messages['emptysetquestionsform'] = "Parola sıfırlama sorularınızı belirleyin";
$messages['emptysendsmsform'] = "Sıfırlama kodu alın";
$messages['sameaslogin'] = "Yeni parolanız kullanıcı adınız ile aynı";
$messages['policydifflogin'] = "Yeni parolanız kullanıcı adınız ile aynı olamaz";
$messages['changesshkeymessage'] = "Sayın {login}, \n\nSSH Anahtarınız değiştirildi. \n\nBu değişikliği başlatmadıysanız lütfen derhal yöneticinize başvurun.";
$messages['menusshkey'] = "SSH Anahtarı";
$messages['changehelpsshkey'] = "<a href=\"?action=changesshkey\">SSH Anahtarınızı değiştirin</a>";
$messages['sshkeychanged'] = "SSH Anahtarınız değiştirildi";
$messages['sshkeyrequired'] = "SSH Anahtarı gerekiyor";
$messages['invalidsshkey'] = "Girilen SSH anahtarı geçerli gözükmüyor";
$messages['changesshkeysubject'] = "SSH Anahtarınız değiştirildi";
$messages['sshkey'] = "SSH Anahtarı";
$messages['emptysshkeychangeform'] = "SSH Anahtarınızı Değiştirin";
$messages['changesshkeyhelp'] = "Parolanızı ve yeni SSH anahtarınızı girin.";
$messages['sshkeyerror'] = "SSH Anahtarı LDAP dizini tarafından reddedildi";
$messages['pwned'] = "Yeni parolanız sızıntılarda yayınlanmış, bu parolayı kullandığınız servislerdeki parolanızı değiştirmenizi öneririz";
$messages['policypwned'] = "Yeni parolanız herhangi bir sızıntıda yayınlanmış olmamalıdır";
$messages['throttle'] = "Çok hızlı! Lütfen daha sonra tekrar deneyin (tabii eğer bir insansanız)";
$messages['policydiffminchars'] = "Gerekli yeni tekil karakter sayısı:";
$messages['diffminchars'] = "Yeni parolanız eski parolanıza çok benzer";
$messages['specialatends'] = "Yeni parolanızdaki tek özel karakter ya en başta ya da en sonda yer alıyor";
$messages['policyspecialatends'] = "Yeni parolanız tek özel karakterini en başında veya en sonunda bulunduramaz";
$messages['checkdatabeforesubmit'] = "Formu onaylamadan önce lütfen girdilerinizi kontrol edin";
$messages['forbiddenwords'] = "Parolanız yasaklı kelimeler içeriyor";
$messages['policyforbiddenwords'] = "Parolanız bunu içeremez:";
$messages['forbiddenldapfields'] = "Parolanız LDAP girdinizden bilgiler içeriyor";
$messages['policyforbiddenldapfields'] = "Parolanız bu LDAP alanlarından değerler içeremez:";
$messages['ldap_cn'] = "yerel ad";
$messages['ldap_givenName'] = "verilen ad";
$messages['ldap_sn'] = "soyad";
$messages['ldap_mail'] = "posta adresi";
$messages["questionspopulatehint"] = "Daha önceden girdiğiniz soruları yüklemek için sadece kullanıcı adınızı girin.";
$messages['badquality'] = "Parola kaliteniz çok düşük";
$messages['tooyoung'] = "Parolanız çok kısa bir süre önce değiştirildi";
$messages['inhistory'] = "Parola geçmiş parolalarınız arasında yer alıyor";
$messages['attributesmoderror'] = "Bilgileriniz güncellenmedi";
$messages['attributeschanged'] = "Bilgileriniz güncellendi";
$messages['setattributeshelp'] = "Parolanızı sıfırlamak için kullanılan bilgileri güncelleyebilirsiniz. Kullanıcı adınız ile parolanızı girin ve yeni bilgilerinizi belirleyin.";
$messages['phone'] = "Telefon numarası";
$messages['sendtokenhelpupdatemail'] = "E-posta adresinizi <a href=\"?action=setattributes\">bu sayfada</a> güncelleyebilirsiniz.";
$messages['sendsmshelpupdatephone'] = "Telefon numaranızı <a href=\"?action=setattributes\">bu sayfada</a> güncelleyebilirsiniz.";
