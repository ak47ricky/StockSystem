<%@ Page Language="C#" AutoEventWireup="true" CodeFile="V_Sample.aspx.cs" Inherits="View_V_Sample" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>

<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no"/>
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" integrity="sha384-WskhaSGFgHYWDcbwN70/dfYBj47jz9qbsMId/iRN3ewGhXQFZCSftd1LZCfmhktB" crossorigin="anonymous">
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js" integrity="sha384-smHYKdLADwkXOn1EmN1qk/HfnUcbVRZyYmZ4qpPea6sjB/pTJ0euyQp0Mk8ck+5T" crossorigin="anonymous"></script>
    <title></title>
</head>
<body>
    <div class="container text-center">
<nav class="navbar navbar-expand-xl bg-dark navbar-dark">
  <!-- Brand -->
  <a class="navbar-brand" href="../View/V_Index.aspx">台股模擬器</a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#ButtonList">
                <span class="navbar-toggler-icon"></span>
            </button>
  <!-- Links -->
    <div id="ButtonList" class="collapse navbar-collapse">
          <ul class="navbar-nav mr-auto">
            <li class="nav-item" id="StockSearch">
              <a class="nav-link" href="../View/V_StockSearch.aspx">個股查詢</a>
            </li>
            <li class="nav-item" id="Favourite">
              <a class="nav-link" href="#">我的最愛</a>
            </li>

            <!-- Dropdown -->
            <li class="nav-item dropdown">
              <a class="nav-link dropdown-toggle" href="#" id="navbardrop" data-toggle="dropdown">
                個人帳戶
              </a>
              <div class="dropdown-menu">
                <a class="dropdown-item" href="#">Link 1</a>
                <a class="dropdown-item" href="#">Link 2</a>
                <a class="dropdown-item" href="#">Link 3</a>
              </div>
            </li>
          </ul>

        <ul class="navbar-nav">
            <li class="nav-item" style="display:block;">
                <a class="nav-link" id="Login" href="{{ url('/register') }}">登入</a>
            </li>
            <li class="nav-item" style="margin-top:7px;">
                <label id="Wellcome" style="color:darkgray"></label>
            </li>
            <li class="nav-item" style="display:block;">
                <a class="nav-link" id="Signup" href="{{ url('/register') }}">註冊</a>
            </li>
            <li class="nav-item" style="display:block;">
                <a class="nav-link" id="SignOut" href="#">登出</a>
            </li>
        </ul>
    </div>
</nav>
    </div>
</body>
</html>
<script type="text/javascript" src="../JS/MenuButton.js"></script>

<script>
    $(document).ready(function () {
        Init();
    })

    function Init()
    {
        
        //document.getElementById("Index").className = "active";
    }

</script>
