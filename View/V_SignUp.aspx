<%@ Page Language="C#" AutoEventWireup="true" CodeFile="V_SignUp.aspx.cs" Inherits="View_V_SignUp" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js"></script>
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no"/>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous"/>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
<script src="http://static.runoob.com/assets/jquery-validation-1.14.0/dist/jquery.validate.min.js"></script>
    <title></title>
 
<style>
.error{
	color:red;
}
    .InputObj div {
        margin-top:20px;
    }
    body {
    }
    #SignUpForm{
        margin:0px;
    }
    #Base {
        text-align:center;
        margin:auto;
    }
</style>

</head>
<body>
    <form id="SignUpForm">
         <div class="container bg-info">
            <div class="col-xs-7 col-md-offset-3 InputObj" style="margin:auto;width:400px;"><p id="Base">會員註冊</p>
               
                <div>
                     <label style="font-size:20px;">帳號:</label>
                     <input class="form-control" id="Account" name="Account" type="text" placeholder="請輸入帳號" required="required"/>
                </div>
                 <div>
                     <label style="font-size:20px;">密碼:</label>
                     <input class="form-control" id="Password" name="Password" type="password" placeholder="請輸入密碼" required="required"/>
                </div>
                 <div>
                     <label style="font-size:20px;">請再次輸入密碼:</label>
                     <input class="form-control" id="AgainPassword" name="AgainPassword" type="password" placeholder="請再次輸入密碼" required="required"/>
                </div>
                <div>
                     <label style="font-size:20px;">暱稱:</label>
                     <input class="form-control" id="NickName" name="NickName" placeholder="請輸入暱稱" required="required"/>
                </div>
                <div>
                     <label style="font-size:20px;">信箱:</label>
                     <input class="form-control" id="Email" type="email" name="Email" placeholder="請輸入信箱" required="required"/>
                </div>
                <div>
                     <label style="font-size:20px;">電話:</label>
                     <input class="form-control" id="Phone" name="Phone" placeholder="請輸入電話" required="required"/>
                </div>
                <input style="margin:50px 150px 100px" class="submit" type="submit" value="確認"/>
            </div>
        </div> 
    </form>

</body>
</html>
<script>
//$.validator.setDefaults({

//});
$().ready(function() {
    $("#SignUpForm").validate({
        rules: {
            Account: {
                required:true
            },
            Passowrd:{
                required: true,

            },
            AgainPassword: {
                required:true,
                equalTo: "#Password",
            },
            Eamil: {
                required: true,
                email:true
            },
            Phone: {
                required:true,
                number: true,
                maxlength: 10,
                minlength: 10,
            },
            NickName: {
                required:true,
            }
        },
        messages: {
            Account: {
                required: "請輸入帳號"
            },
            Password: {
                required:"請輸入密碼"
            },
            AgainPassword: {
                required: "請輸入密碼",
                equalTo: "兩次密碼输入不一致"
            },
            Phone: {
                required: "請輸入電話",
                number: "只能輸入數字",
                minlength: "號碼是10個數字",
                maxlength: "號碼是10個數字",
            },
            Email: {
                required: "請輸入信箱",
                email:"信箱格式錯誤"
            },
            NickName:{
                required:"請輸入暱稱"
            },
        },
        submitHandler: function (result) {
            SignUp();
            return false;
        }
    });
    });

    function SignUp()
    {
        $.ajax({
            type: "GET",
            url: "../Model/M_SignUp.aspx",
            data: {
                Account: $("#Account").val(),
                Password: $("#Password").val(),
                Email: $("#Email").val(),
                Phone: $("#Phone").val(),
                NickName: $("#NickName").val()
            },
            success: function (result) {
                switch (result) {
                    case "0":
                        alert("創立成功,請重新登入");
                        window.location.href = "../View/V_Login.aspx";
                        break;
                    case "1":
                        alert("參數錯誤");
                        break;
                    case "2":
                        alert("帳號重複");
                        break;
                    default:
                        alert(result);
                        break;
                }
            },
            error: function (err) {
                alert(err);
            }
        });
    }

</script>