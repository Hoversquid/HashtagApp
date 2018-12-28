$(document).ready(function () {
    UpdateGrid();
});

function UpdateGrid() {
    var i = 0;
    var c = 0;

    var _grididx = 0;

    //loop through all grids on the page
    for (_grididx = 0; _grididx < $(".GridViewHeaderContainer").length; _grididx++) {
        var headerdiv = $(".GridViewHeaderContainer")[_grididx];
        var bodydiv = $(".GridViewBodyContainer")[_grididx];
        // gridheader->table->tbody->row
        var headerrow = headerdiv.children[0].children[0].children[0];

        // gridbody->table->tbody
        var tbody = bodydiv.children[0].children[0];
        // tbody->rows[0]
        var bodyheaderrow = tbody.children[0];

        $(headerdiv).height($(tbody.children[0]).height()); // copy height of first row which contains the header

        for (i = 1; i < tbody.children.length; i++) { // loop through rows
            var tr = tbody.children[i];
            for (var c = 0; c < tr.children.length; c++) { // loop through cols
                var td = tr.children[c];
                $(td).width($(bodyheaderrow.children[c]).width()); // assign colum width to the cell
            }
        }
        for (var c = 0; c < headerrow.children.length; c++) { // loop through cols of header
            var td = headerrow.children[c];
            $(td).width($(bodyheaderrow.children[c]).width() - 1); // assign colum width to the cell
        }
        $(bodyheaderrow).css("display", "none"); // hide first row which contains header
    }
}

