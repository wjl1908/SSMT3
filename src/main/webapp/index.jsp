<%--
  Created by IntelliJ IDEA.
  User: YangML
  Date: 2019/3/11
  Time: 上午8:57
  version:TODO
  To change this template use File | Settings | File Templates.
--%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="static/bootstrap-3.3.7-dist/css/bootstrap.css">
    <link rel="stylesheet" href="static/dist/bootstrap-table.css">
    <script src="static/jquery-3.3.1.min.js" type="text/javascript"></script>
    <script src="static/bootstrap-3.3.7-dist/js/bootstrap.js" type="text/javascript"></script>
    <script src="static/dist/bootstrap-table.js" type="text/javascript"></script>
    <script src="static/dist/locale/bootstrap-table-zh-CN.js" type="text/javascript"></script>

    <script>

        $(function(){
            //创建bootstrapTable
            console.log("123");
            $("#tab").bootstrapTable({
                method:"POST",
                //极为重要，缺失无法执行queryParams，传递page参数
                contentType : "application/x-www-form-urlencoded",
                dataType:"json",
                url:'book/find',
                queryParams:queryParam,
                pagination:true,//显示分页条：页码，条数等
                striped:true,//隔行变色
                pageNumber:1,//首页页码
                pageSize:10,//分页，页面数据条数
                uniqueId:"id",//Indicate an unique identifier for each row
                sidePagination:"server",//在服务器分页
                responseHandler:responseHandler,
                height:500,
                toolbar:"#toolbar",//工具栏
                columns : [{
                    checkbox:"true",
                    field : "box"
                },  {
                    title : "图书编号",
                    field : "id"
                }, {
                    title : "图书名称",
                    field : "bookname"
                }, {
                    title : "图书作者",
                    field : "author"
                },{
                    title : "图书单价",
                    field : "price"
                }, {
                    field : 'operate',
                    title : '操作',
                    formatter:function(value, row, index){
                        return '<button name="del" class="btn btn btn-danger btn-sm" onclick="delBook('+row.id+')"><span class="glyphicon glyphicon-trash">&nbsp;</span>删除</button>'+
                            ' <button name="change" class="btn btn-info btn-sm"   onclick="preUp('+row.id+')" ><span class="glyphicon glyphicon-random">&nbsp;</span>修改</button>';
                    }
                }],
                showRefresh : true,//刷新
            });


        })

        function responseHandler(res) {
            if (res) {
                return {
                    "rows" : res.result.list,
                    "total" : res.result.total
                };
            } else {
                return {
                    "rows" : [],
                    "total" : 0
                };
            }
        }
        function queryParam(params) {
            var param = {
                limit : this.limit, // 页面大小
                offset : this.offset, // 页码
                pageNumber : this.pageNumber,
                pageSize : this.pageSize
            };
            return param;
        }

        function addBook(){
            var p=$("#addForm").serializeArray();
            console.log(p)
           $.ajax({
                url:"book/addBook",
                type:"post",
                data:p,
                dataType:"json",
                success:function(data){
                    if(data.errorCode==0) {
                        $("#tab").bootstrapTable('refresh');
                        $("#addModal").modal("hide");
                    }
                }
            })
        }


        function updateBook(){
            var  p = $("#updateForm").serializeArray();
            console.log(p)
            $.ajax({
                url:"book/updateBook",
                type:"post",
                data:p,
                dataType:"json",
                success:function(data){
                    $("#tab").bootstrapTable('refresh');
                    $("#change").modal("hide");
                }
            })
        }

        function preUp(obj){
            var $id=obj;
            console.log($id)
            $("#change").modal('show');
            $.ajax({
                url:"book/findBookById",
                data:{id:$id},
                dataType:'json',
                success:function(dt){
                    if(dt.errorCode==0){
                        console.log(dt.result);
                        $("#id").val(dt.result.id);
                        $("#changeBookName").val(dt.result.bookname);
                        $("#changeAuthor").val(dt.result.author);
                        $("#changePrice").val(dt.result.price);

                    }
                }
            })


        }

        function delBook(obj){
            var $id=obj;
                $.ajax({
                    url:"book/delBook",
                    data:{id:$id},
                    dataType:'json',
                    success:function(dt){
                        if(dt.errorCode==0){
                            $("#tab").bootstrapTable('refresh');
                        }
                    }

                })
        }
    </script>
</head>
<body>

<div>
    <div class="container">
        <div id="toolbar">
            <input type="button" value="新增图书" id="addBtn" data-toggle="modal" data-target="#addModal" class="btn btn-primary"></input>

        </div>
    </div>

</div>


    <table id="tab"></table>

    <!--添加图书 -->
    <div class="modal fade" id="addModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <div class="modal-header">
                        <h3 class="modal-title" style="text-align: center;" >添加图书</h3>
                    </div>
                    <div class="modal-body">
                        <form id="addForm">
                            <span>图书名称:</span><input type="text" class="form-control" name="bookname"  />
                            <span>图书作者:</span><input type="text" class="form-control" name="author"  />
                            <span>图书单价:</span><input type="text" class="form-control" name="price"  />
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                        <button type="button" class="btn btn-primary" onclick="addBook()" >提交</button>
                    </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal -->
    </div>
    </div>

    <!-- 修改图书 -->
    <div class="modal fade"  id="change" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h3 class="modal-title" style="text-align: center;" >修改图书</h3>
                </div>
                <div class="modal-body">
                    <form id="updateForm">
                        <span>图书编号:</span><input type="text" class="form-control" id="id" name="id"  readonly="readonly"/>
                        <span>图书名称:</span><input type="text" class="form-control" id="changeBookName"  name="bookname"  />
                        <span>图书作者:</span><input type="text" class="form-control" id="changeAuthor"  name="author"  />
                        <span>图书单价:</span><input type="text" class="form-control" id="changePrice"  name="price"  />
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="button" class="btn btn-primary"  onclick="updateBook()">提交</button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal -->
    </div>


</body>
</html>
