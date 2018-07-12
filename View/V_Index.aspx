<%@ Page Language="C#" AutoEventWireup="true" CodeFile="V_Index.aspx.cs" Inherits="View_V_Index" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js"></script>
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no"/>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
 <script src="http://static.runoob.com/assets/jquery-validation-1.14.0/dist/jquery.validate.min.js"></script>
    <title></title>
</head>
<body>
    <div class="container text-center">
        <div id="Menu"></div>
    </div>
</body>
</html>
<script type="text/javascript" src="../JS/MenuButton.js"></script>
<script>
    $(document).ready(function () {
        Init();
    });

    function Init()
    {
        //document.getElementById("Index").className = "active";
    }
    function SignOut() {

        $.ajax({
            url: "../Model/M_Login.aspx",
            data: {
                Kind: 2
            },
            success: function (result) {
                if (result == 0)
                {
                    alert("登出成功");
                    eraseCookie("Account");
                    eraseCookie("NickName");
                    window.location.href = "../View/V_Index.aspx";
                }
                    
            }
        })
    }
</script>
