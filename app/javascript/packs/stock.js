// app/javascript/packs/stock.js

var Stock_List_Js = (function() {
    var addBtn, rowCount, tableBody;

    addBtn = $("#addNew");
    tableBody = $("#stocksList tbody");
    rowCount = $("#stocksList tbody tr").length + 1;

    function formHtml() {
        html = '<tr>';
        html += '<td scope="row">';
        html += '<span class="flag-icon delete-row" title="Xóa dòng hiện tại"></span>';
        html += '</td>';
        html += '<td scope="row">';
        html += '<input class="form-control" type="text" value="" name="user[stocks_attributes]['+rowCount+'][code]" id="user_stocks_attributes_'+rowCount+'_code">';
        html += '</td>';
        html += '<td scope="row">';
        html += '<input class="form-control" type="text" value="" name="user[stocks_attributes]['+rowCount+'][name]" id="user_stocks_attributes_'+rowCount+'_name">';
        html += '</td>';
        html += '<td scope="row">';
        html += '<input class="form-control" type="text" value="0" name="user[stocks_attributes]['+rowCount+'][registrationVolume]" id="user_stocks_attributes_'+rowCount+'_registrationVolume">';
        html += '</td>';
        html += '<td scope="row">';
        html += '<input class="form-control" type="text" value="0" name="user[stocks_attributes]['+rowCount+'][outstandingVolume]" id="user_stocks_attributes_'+rowCount+'_outstandingVolume">';
        html += '</td>';
        html += '<td scope="row">';
        html += '<input class="form-control" type="text" value="" name="user[stocks_attributes]['+rowCount+'][website]" id="user_stocks_attributes_'+rowCount+'_website">';
        html += '</td>';
        html += '<td scope="row">';
        html += '<input class="form-control" type="text" value="" name="user[stocks_attributes]['+rowCount+'][industry]" id="user_stocks_attributes_'+rowCount+'_industry">';;
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
    Stock_List_Js.init();
});