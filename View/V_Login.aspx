<%@ Page Language="C#" AutoEventWireup="true" CodeFile="V_Login.aspx.cs" Inherits="View_V_Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js"></script>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no"/>
    <!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous"/>

<!-- Optional theme -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous"/>

<!-- Latest compiled and minified JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>

    <title>登入</title>
    <style>
        .InputObj {
            margin-top:50px;
        }

    </style>
</head>
<body>
    <div class="container" sytle="margin-top:30px;" >
        <div class="pull-left" style="padding-top:30px;">
            <img src="../Image/Login/Dokkan_0.jpg"/>
        </div>
        <div class="pull-right" style="width:400px;margin-top:100px;">
            <div class="text-center"">登入</div>
                <div class="col-xs-7 col-md-offset-2 InputObj">
                    <label for="Account">帳號:</label>
                     <input id="Account" class="form-control" type="text" placeholder="請輸入帳號" />
                </div>
               <div class="col-xs-7 col-md-offset-2 InputObj">
                    <label for="Password">密碼:</label>
                   <input id="Password" class="form-control" type="password" placeholder="請輸入密碼" />
               </div>
            
            <div class="col-xs-7 col-md-offset-2 InputObj">
                <button id="Btn_Login" type="button" class="btn btn-primary" data-loading-text="Loading..." onclick="Login()">登入</button>
                <button type="button" class="btn btn-primary" onclick="SignUp()">註冊</button>
            </div>

        </div>
         <!-- The Modal -->
  <div class="modal fade" id="myModal">
    <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content">
       
        <!-- Modal body -->
        <div class="modal-body text-center">
          登入成功
        </div>
        
      </div>
    </div>
  </div>
    </div>
    <script>
        $(function () {
            $("#myModal").on("hidden.bs.modal", function () {

                window.location.href = "../View/V_Index.aspx";
            })
        });
          
        $(function () {
            $("#Btn_Login").click(function () {
                $(this).button('loading').delay(1000).queue(function () {
                });        
            });
        });

        function Login()
        {
            $.ajax({
                url: "../Model/M_Login.aspx",
                type: "GET",
                data: {
                    Account: $("#Account").val(),
                    Password: $("#Password").val(),
                    Kind: 1
                },
                success: function (result)
                {
                    switch (result)
                    {
                        case "0":
                            $("#myModal").modal('show');
                            break;
                        case "1":
                            window.location.href = "../View/V_Login.aspx";
                            alert("密碼錯誤");
                            break;
                        case "2":
                            window.location.href = "../View/V_Login.aspx";
                            alert("無此帳號");
                            break;
                    }
                }
            })
        }
        function SignUp()
        {
            window.location.href = "../View/V_SignUp.aspx";
        }
    </script>

</body>
</html>
