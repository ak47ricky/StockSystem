<%@ Page Language="C#" AutoEventWireup="true" CodeFile="V_StockSearch.aspx.cs" Inherits="View_V_StockSearch" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no"/>
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js"></script>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script type="text/javascript" src="http://flexslider.woothemes.com/js/jquery.flexslider.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" integrity="sha384-WskhaSGFgHYWDcbwN70/dfYBj47jz9qbsMId/iRN3ewGhXQFZCSftd1LZCfmhktB" crossorigin="anonymous/">
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js" integrity="sha384-smHYKdLADwkXOn1EmN1qk/HfnUcbVRZyYmZ4qpPea6sjB/pTJ0euyQp0Mk8ck+5T" crossorigin="anonymous"></script>

    <title></title>
    <style>
        .InfoTitle {
            font-size:28px;
            font-family:'Blackadder ITC';
            padding:30px 0px;
        }
    </style>
</head>
<body>
    <div class="container">
        <div id="Menu"></div>
        <div class="input-group" style="margin-top:30px;">
              <input type="text" class="form-control" id="StockNumber" placeholder="請輸入股票編號" aria-label="請輸入股票編號" aria-describedby="basic-addon2"/>
                  <div class="input-group-append">
                    <button class="btn btn-outline-secondary" type="button" onclick="GetStockData()">查詢</button>
                  </div>
        </div>
        <div id="TableDiv" style="margin:100px 0px;display:none;">
            <div class="text-center InfoTitle">個股資訊</div>
            <table class="table table-bordered">
              <thead>
                <tr>
                  <th scope="col">股票代碼</th>
                  <th scope="col">時間</th>
                  <th scope="col">成交</th>
                  <th scope="col">買進</th>
                  <th scope="col">賣出</th>
                  <th scope="col">漲跌</th>
                  <th scope="col">張數</th>
                  <th scope="col">昨收</th>
                  <th scope="col">開盤</th>
                  <th scope="col">最高</th>
                  <th scope="col">最低</th>
                </tr>
              </thead>
              <tbody>
                <tr>
                  <td id="StockName"></td>
                  <td id="Time"></td>
                  <td id="DealPrice"></td>
                  <td id="BuyPrice"></td>
                  <td id="SalePrice"></td>
                  <td id="PriceRange"></td>
                  <td id="DealCount"></td>
                  <td id="Yesterday"></td>
                  <td id="StartPrice"></td>
                  <td id="Highest"></td>
                  <td id="Lowest"></td>
                </tr>
              </tbody>
            </table>
            <div style="text-align:right";>
                <button id="FavouriteButton" type="button" class="btn btn-primary" onclick="SetFavourite();">加入我的最愛</button>
            </div>
            <div class="text-center InfoTitle" style="text-align:center;">個股新聞</div>
            <ul>
                <li><a id="News1"></a></li>
                <li><a id="News2"></a></li>
                <li><a id="News3"></a></li>
                <li><a id="News4"></a></li>
            </ul>
        </div>
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
        document.getElementById("StockSearch").className = "active";
    }

    function GetStockData()
    {
        $("#TableDiv").css('display', 'none');

        $.ajax({
            type: "POST",
            url: "../Model/GetStockData.aspx",
            dataType:"JSON",
            data: {
                Number: $("#StockNumber").val()
            },
            success: function (result) {
                //var aData = JSON.parse(result);

                var aData = result;

                switch (aData.Result) {
                    case "0":
                        SetStockData(aData);
                        SetStockNews(aData);
                        SetFavouriteButton($("#StockNumber").val());
                        break;
                }
            }
        });
    }

    function SetStockData(iData)
    {
        var aValueID = ["StockName", "Time", "DealPrice", "BuyPrice", "SalePrice", "PriceRange", "DealCount", "Yesterday", "StartPrice", "Highest", "Lowest"];
        $("#TableDiv").css('display', 'block');

        for (var i = 0; i < aValueID.length; i++)
        {
            document.getElementById(aValueID[i]).innerText = iData.StockValue[i];
            if (iData.StockValue[i].indexOf("△") > -1)
            {
                $("#"+aValueID[i]).css('color','red');
            }
            else if (iData.StockValue[i].indexOf("▽") > -1)
            {
                $("#" + aValueID[i]).css('color', 'green');
            }
            else
            {
                $("#" + aValueID[i]).css('color', 'black');
            }
        }
    }
    function SetStockNews(iData)
    {
        var aID = ["News1","News2","News3","News4"];

        for (var i = 0; i < aID.length; i++)
        {
            document.getElementById(aID[i]).innerText = iData.NewsTitle[i];
            document.getElementById(aID[i]).href = iData.NewsURL[i];
        }
    }

    function SetFavouriteButton(StockNumber)
    {
        var aFavourite = readCookie("FavouriteData");

        if (aFavourite.indexOf(StockNumber) < 0)
        {
            document.getElementById("FavouriteButton").className = "btn btn-primary";
            document.getElementById("FavouriteButton").innerText = "加入我的最愛";
        }
        else
        {
            document.getElementById("FavouriteButton").className = "btn btn-warning";
            document.getElementById("FavouriteButton").innerText = "移除我的最愛";
        }
    }

    function SetFavourite()
    {
        var aKind = 0;

        if (document.getElementById("FavouriteButton").innerText == "加入我的最愛")
            aKind = 1;

        if (document.getElementById("FavouriteButton").innerText == "移除我的最愛")
            aKind = 2;

        $.ajax({
            url: "../Model/M_SetFavourite.aspx",
            data: {
                Kind: aKind,
                Number: $("#StockNumber").val()
            },
            type: "GET",
            success: function (result)
            {
                switch (result)
                {
                    case "0":
                        if (aKind == 1)
                        {
                            alert("加入成功");
                            document.getElementById("FavouriteButton").className = "btn btn-warning";
                            document.getElementById("FavouriteButton").innerText = "移除我的最愛";
                        }
                        else
                        {
                            alert("移除成功");
                            document.getElementById("FavouriteButton").className = "btn btn-primary";
                            document.getElementById("FavouriteButton").innerText = "加入我的最愛";
                        }

                        break;
                    case "1":
                        alert("參數錯誤");
                        break;
                    case "2":
                        alert("尚未登入帳號");
                        break;
                }
            }
        })
    }

    function SignOut() {

        $.ajax({
            url: "../Model/M_Login.aspx",
            data: {
                Kind: 2
            },
            success: function (result) {
                if (result == 0) {
                    alert("登出成功");
                    eraseCookie("Account");
                    eraseCookie("NickName");
                    window.location.href = "../View/V_Index.aspx";
                }

            }
        })
    }
</script>
