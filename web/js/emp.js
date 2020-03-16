


function query() {
    $.ajax({
        type: "POST",
        url: "emp/queryEmp.do",
        success: function (msg) {
            alert(msg)
        }
    });
}


function del(empNo) {
    var result = window.confirm("确认要删除吗?");
    if (true == result) {
        window.location.href = "emp/empDelete.do?empNo=" + empNo;
    }
}