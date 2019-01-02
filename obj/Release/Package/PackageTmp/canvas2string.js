(function PrintCanvas() {
    html2canvas(document.body).then(function (canvas) {
        //document.body.appendChild(canvas);
        var dataStr = canvas.ToDataURL;
        var hiddenField = document.getElementById('<%= ImageString.ClientID %>').value;
        alert("Hello");

    })
})