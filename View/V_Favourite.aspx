<%@ Page Language="C#" AutoEventWireup="true" CodeFile="V_Favourite.aspx.cs" Inherits="View_V_Favourite" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no"/>
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" integrity="sha384-WskhaSGFgHYWDcbwN70/dfYBj47jz9qbsMId/iRN3ewGhXQFZCSftd1LZCfmhktB" crossorigin="anonymous">
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js" integrity="sha384-smHYKdLADwkXOn1EmN1qk/HfnUcbVRZyYmZ4qpPea6sjB/pTJ0euyQp0Mk8ck+5T" crossorigin="anonymous"></script>

<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/bootstrap-table/1.12.1/bootstrap-table.min.css"/>

<!-- Latest compiled and minified JavaScript -->
<script src="//cdnjs.cloudflare.com/ajax/libs/bootstrap-table/1.12.1/bootstrap-table.min.js"></script>


    <title></title>
</head>
<body>
 <div class="container text-center">
     <div id="Menu"></div>
     <div>
         <label id="Title" class="text-center">資料載入中，請稍後</label>
     </div>

     <table id="FavouriteTable" class="table" data-row-style="rowStyle" style="margin-top:50px">
        <thead>  
            <tr>  
                <th data-field="StockName">股票名稱</th>  
                <th data-field="NowPrice">現價</th>
                <th data-field="RangePrice" data-formatter="displaycolor">漲幅</th>  
                <th data-field="YesterdayPrice">前收</th>  
            </tr>  
        </thead>  
    </table>
</div>
</body>
</html>
<script type="text/javascript" src="../JS/MenuButton.js"></script>

<script>
    $(document).ready(function ()
    {
        if (CheckLogin() == false) {
            alert("尚未登入");
            window.location.href = "../View/V_Login.aspx";
            return;
        }


        var aData;

        $.ajax({
            url: "../Model/M_Favourite.aspx",
            type: "GET",
            dataType:"JSON",
            success: function (result)
            {
                aData = result.rows;
                $("#FavouriteTable").bootstrapTable({
                    data: aData,
                    column: [
                        { field: 'StockName', title: '股票名稱' },
                        { field: 'NowPrice', title: '現價' },
                        { field: 'RangePrice', title: '漲幅' },
                        { field: 'YesterdayPrice', title: '前收' },
                    ],
                });

                $("#Title").css('display', 'none');
            }
        });
        
    })

    function displaycolor(value, row, index) {
        var a = "";
        if (value.indexOf('△') > -1) {
            var a = '<span style="color:#FF0000">' + value + '</span>';
        } else if (value.indexOf("▽") > -1) {
            var a = '<span style="color:#00FF00">' + value + '</span>';
        } else {
            var a = '<span>' + value + '</span>';
        }
        return a;
    }  

</script>
