// app/javascript/packs/trade.js

var Trade_List_Js = (function() {
    var addBtn, rowCount, tableBody, stockSelect;

    addBtn = $("#addNew");
    tableBody = $("#tradesList tbody");
    rowCount = $("#tradesList tbody tr").length + 1;
    stockSelect = $("#tradesList tbody tr select").get(0).outerHTML;

    function formHtml() {
        html = '<tr>';
        html += '<td scope="row">';
        html += '<span class="flag-icon delete-row" title="Xóa dòng hiện tại"></span>';
        html += '</td>';
        html += '<td scope="row">';
        html += '<input class="form-control" type="date" name="user[trades_attributes]['+rowCount+'][tradingDate]" id="user_trades_attributes_'+rowCount+'_tradingDate">';
        html += '</td>';
        html += '<td scope="row">';
        html += stockSelect.replace("0" , rowCount);
        html += '</td>';
        html += '<td scope="row">';
        html += '<select class="form-control" name="user[trades_attributes]['+rowCount+'][tradingType]" id="user_trades_attributes_'+rowCount+'_tradingType"><option selected="selected" value="buy">Mua</option><option value="sell">Bán</option></select>';
        html += '</td>';
        html += '<td scope="row">';
        html += '<input class="form-control" type="text" value="0" name="user[trades_attributes]['+rowCount+'][volume]" id="user_trades_attributes_'+rowCount+'_volume">';
        html += '</td>';
        html += '<td scope="row">';
        html += '<input class="form-control" type="text" value="0" name="user[trades_attributes]['+rowCount+'][price]" id="user_trades_attributes_'+rowCount+'_price">';
        html += '</td>';
        html += '</tr>';
        rowCount++;
        return html;
    }

    function addNewRow() {
        tableBody.append(formHtml());
    }

    function deleteRow() {
        $(this).parentsUntil("tbody").remove();
    }

    function registerEvents() {
        addBtn.on("click", addNewRow);
        $(document).on("click", ".delete-row", deleteRow)
    }

    function init() {
        registerEvents();
    }

    return {
        init: init
    };
})();

//On Page Load
jQuery(document).ready(function() {
    Trade_List_Js.init();
});