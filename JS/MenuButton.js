$("#Menu").html("<nav class=\"navbar navbar-expand-xl bg-dark navbar-dark\">"+
  "<a class=\"navbar-brand\" href=\"../View/V_Index.aspx\">台股模擬器</a>"+
    "<button class=\"navbar-toggler\" type=\"button\" data-toggle=\"collapse\" data-target=\"#ButtonList\">"+
        "<span class=\"navbar-toggler-icon\"></span>"+
    "</button>"+
    "<div id=\"ButtonList\" class=\"collapse navbar-collapse\">"+
        "<ul class=\"navbar-nav mr-auto\">"+
            "<li class=\"nav-item\" id=\"StockSearch\">"+
                "<a class=\"nav-link\" href=\"../View/V_StockSearch.aspx\">個股查詢</a>"+
            "</li>"+
            "<li class=\"nav-item\" id=\"Favourite\">"+
                "<a class=\"nav-link\" href=\"../View/V_Favourite.aspx\">我的最愛</a>"+
            "</li>"+
            "<li class=\"nav-item dropdown\">"+
    "<a class=\"nav-link dropdown-toggle\" href= \"#\" id= \"navbardrop\" data-toggle=\"dropdown\" > "+
    "個人帳戶"+
    "</a > "+
                "<div class=\"dropdown-menu\">" + 
                    "<a class=\"dropdown-item\" href=\"../View/V_OrderSystem.aspx\">下單</a>"+
                    "<a class=\"dropdown-item\" href=\"#\">Link 2</a>"+
                    "<a class=\"dropdown-item\" href=\"#\">Link 3</a>"+
                "</div>"+
            "</li>"+
        "</ul>" +
    GetAccountHtml() +
    "</div>"+
    "</nav>");


function GetAccountHtml()
{
    var aHtml = "";

    var aAccount = readCookie("Account");

    if (aAccount == null) {
        aHtml = "<ul class=\"navbar-nav\">" +
            "<li class=\"nav-item\" style=\"display:block;\">" +
            "<a class=\"nav-link\" id=\"Login\" href=\"../View/V_Login.aspx\">登入</a>" +
            "</li>"
        "<li class=\"nav-item\" style=\"margin-top:7px;\">" +
            "<label id=\"Wellcome\" style=\"color:darkgray\"></label>" +
            "</li>" +
            "<li class=\"nav-item\" style=\"display:block;\">" +
            "<a class=\"nav-link\" id=\"Signup\" href=\"../View/V_SignUp.aspx\">註冊</a>" +
            "</li>" +
            "<li class=\"nav-item\" style=\"display:none;\">" +
            "<a class=\"nav-link\" id=\"SignOut\" href=\"#\" onclick=\"SignOut()\">登出</a>" +
            "</li>" +
            "</ul>";
    }
    else
    {
        aHtml = "<ul class=\"navbar-nav\">" +
            "<li class=\"nav-item\" style=\"display:none;\">" +
            "<a class=\"nav-link\" id=\"Login\" href=\"../View/V_Login.aspx\">登入</a>" +
            "</li>"+
            "<li class=\"nav-item\" style=\"margin-top:7px;\">" +
                "<label id=\"Wellcome\" style=\"color:darkgray\">" + GetNickName() +"</label>" +
            "</li>" +
            "<li class=\"nav-item\" style=\"display:none;\">" +
            "<a class=\"nav-link\" id=\"Signup\" href=\"../View/V_SignUp.aspx\">註冊</a>" +
            "</li>" +
            "<li class=\"nav-item\" style=\"display:block;\">" +
            "<a class=\"nav-link\" id=\"SignOut\" href=\"#\" onclick=\"SignOut()\">登出</a>" +
            "</li>" +
            "</ul>";
    }

    return aHtml;
}

function GetNickName()
{
    var aNickName = readCookie("NickName");

    if (aNickName != null)
        return "歡迎 " + aNickName;
    else
        return "";
}

// 建立cookie
function createCookie(name, value, days, path) {
    if (days) {
        var date = new Date();
        date.setTime(date.getTime() + (days * 24 * 60 * 60 * 1000));
        var expires = "; expires=" + date.toGMTString();
    }
    else var expires = "";
    document.cookie = name + "=" + value + expires + "; path=/";
}
//讀取
function readCookie(name) {
    var nameEQ = name + "=";
    var ca = document.cookie.split(';');
    for (var i = 0; i < ca.length; i++) {
        var c = ca[i];
        while (c.charAt(0) == ' ') c = c.substring(1, c.length);
        if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length, c.length);
    }
    return null;
}
//刪除
function eraseCookie(name) {
    createCookie(name, "", -1);
}

function CheckLogin()
{
    if (readCookie("NickName") != null)
        return true;
    else
        return false;
}

