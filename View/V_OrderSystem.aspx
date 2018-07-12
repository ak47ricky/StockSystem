﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="V_OrderSystem.aspx.cs" Inherits="View_V_OrderSystem" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js"></script>
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no"/>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous"/>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
 <script src="http://static.runoob.com/assets/jquery-validation-1.14.0/dist/jquery.validate.min.js"></script>
    <title>股票下單</title>
    <style>
        input[type=number]::-webkit-inner-spin-button, 
        input[type=number]::-webkit-outer-spin-button { 
        -webkit-appearance: none; 
        margin: 0; 
        
        }
    </style>
</head>
<body>
    <div class="container text-center" id="Base">
        <div id="Menu"></div>
        <div id="SelectRadio" style="margin-top:50px;">
            <div class="form-check-inline">
              <label class="form-check-label">
                <input type="radio" class="form-check-input" id="Buy" name="optradio" value="1" onclick="SetBuy()" />買
              </label>
            </div>
            <div class="form-check-inline">
              <label class="form-check-label">
                <input type="radio" class="form-check-input" id="Sale" value="2" name="optradio" onclick="SetSale()"/>賣
              </label>
            </div>
        </div>

        <div  style="margin-top:30px;" >   
             <div class="form-check-inline">
                <input id="SetStockNumber" class="form-control" type="text" style="width:200px;" placeholder="請輸入股票編號" aria-label="請輸入股票編號"/>
             </div>
             <div class="form-check-inline">
                <button class="btn btn-primary" onclick="GetSearchStockData()">確認</button>
             </div>
        </div>

        <div id="StockOrderSystem" style="margin-top:50px;">
            <div>
             <div class="form-check-label">
                <label for="StockCount">請輸入您想購買的數量</label>
            </div>
            <div class="form-check-inline">
                
                <button class="btn btn-info" onclick="Button_Del()" style="margin-right:10px;">-</button>
                <input id="StockCount" type="number" class="form-control" style="width:100px;text-align:right;" value="1" min="1" max="1000" placeholder="請輸入數量" aria-label="請輸入數量"/>
                <button class="btn btn-info" style="margin-left:10px" onclick="Button_Add()">+</button>
            </div>
            </div>

            <div style="margin-top:30px;">
                <div class="form-check-label">
                    <label for="SalePrice">請輸入您想販賣的金額</label>
                </div>
                <div class="form-check-inline">
                    <button class="btn btn-info" onclick="Button_Del()" style="margin-right:10px;">-</button>
                    <input id="SalePrice" type="number" class="form-control" style="width:100px;text-align:right;" value="1" min="1" max="1000" placeholder="請輸入數量" aria-label="請輸入數量"/>
                    <button class="btn btn-info" style="margin-left:10px" onclick="Button_Add()">+</button>
                </div>
                <div class="form-check-label">
                    昨日收
                </div>
            </div>
        </div>
   </div>
</body>
</html>
<script type="text/javascript" src="../JS/MenuButton.js"></script>
<script>
    var aKind = 0;

    $(document).ready(function () {
        Init();
    });

    function Init()
    {
        
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
    function Button_Search()
    {
        var aStockNumber = $("#SetStockNumber").val();
    }
    function SetBuy()
    {
        $("#Base").css('background-color', 'red');
        aKind = 1;
    }
    function SetSale()
    {
        $("#Base").css('background-color', 'green');
        aKind = 2;
    }

    function GetSearchStockData()
    {
        $.ajax({
            url: "../Model/GetStockData.aspx",
            data: {
                Number: $("#SetStockNumber").val()
            },
            type: "GET",
            dataType: "JSON",
            success: function (result)
            {
                if (result.Result != "0")
                {
                    alert("資訊錯誤");
                    return;
                }
            }
        })
    }

    function Button_Add()
    {
        var aNowValue = $("#StockCount").val();

        aNowValue++;

        $("#StockCount").val(aNowValue);
    }

    function Button_Del()
    {
        var aNowValue = $("#StockCount").val();

        aNowValue--;

        if (aNowValue < 1)
            aNowValue = 1;

        $("#StockCount").val(aNowValue);
    }
</script>