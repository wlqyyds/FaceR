<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>
<%--<%
    String path=request.getContextPath();
    String basePath=request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>--%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>信息管理</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/lib/layui-v2.5.5/css/layui.css" media="all">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/public.css" media="all">
    <script src="${pageContext.request.contextPath}/lib/layui-v2.5.5/layui.js" charset="utf-8"></script>
</head>
<body>


<%--<div class="layui-row layui-col-space10">
    <div class="layui-col-md9">
        <div class="grid-demo grid-demo-bg1">9/12</div>
    </div>
    <div class="layui-col-md3">
        <div class="grid-demo">3/12</div>
    </div>
</div>--%>


<div class="layuimini-row">

    <div class="layui-col-md3">
        <fieldset class="layui-elem-field layui-field-title" style="margin-top: 30px;">
            <legend>树形结构查询</legend>
        </fieldset>

        <div id="test1" class="demo-tree demo-tree-box"></div>



    </div>

    <div class="layui-col-md9">

        <div class="demoTable">
            <div class="layui-form-item layui-form ">
                政策名称：
                <div class="layui-inline">
                    <input class="layui-input" name="name" id="name" autocomplete="off">
                </div>
                发文字号：
                <div class="layui-inline">
                    <input class="layui-input" name="document" id="document" autocomplete="off">
                </div>
                发文机构：
                <div class="layui-inline">
                    <input class="layui-input" name="organ" id="organ" autocomplete="off">
                </div>
                政策分类：
                <div class="layui-inline">
                    <input class="layui-input" name="type" id="type" autocomplete="off">
                </div>
                <button class="layui-btn" data-type="reload">搜索</button>
            </div>
        </div>



        <script type="text/html" id="toolbarDemo">
            <div class="layui-btn-container">
                <button class="layui-btn layui-btn-normal layui-btn-sm data-add-btn" lay-event="add"> 添加 </button>
                <button class="layui-btn layui-btn-sm layui-btn-danger data-delete-btn" lay-event="delete"> 删除 </button>
            </div>
        </script>

        <!--表单，查询出的数据在这里显示-->
        <table class="layui-hide" id="currentTableId" lay-filter="currentTableFilter"></table>

        <script type="text/html" id="currentTableBar">
            <a class="layui-btn layui-btn-normal layui-btn-xs data-count-edit" lay-event="update">查看</a>
<%--            <a class="layui-btn layui-btn-xs layui-btn-danger data-count-delete" lay-event="delete">删除</a>--%>
        </script>

    </div>

</div>

<script>
    layui.use(['form', 'table','tree', 'util'], function () {
        var $ = layui.jquery,
            form = layui.form,
            table = layui.table,
            tree = layui.tree
            ,layer = layui.layer
            ,util = layui.util
            ,data1 = [{
                title: '综合(88)'
                ,id: 1
            },
                {
                    title: '科研机构改革(18)'
                    ,id: 2
                },
                {
                    title: '科技计划管理(95)'
                    ,id: 3
                },
                {
                    title: '科技经费与财务(39)'
                    ,id: 4
                },
                {
                    title: '基础研究与科研基地(108)'
                    ,id: 5
                    ,children: [
                        {
                            title: '基础研究(29)'
                            ,id: 1
                        },
                        {
                            title: '平台基地(79)'
                            ,id: 2
                        }
                    ]
                },
                {
                    title: '企业技术进步与高新技术产业化(142)'
                    ,id: 6
                    ,children: [
                        {
                            title: '企业(90)'
                            ,id: 1
                        },
                        {
                            title: '产业(27)'
                            ,id: 2
                        },
                        {
                            title: '创新载体(25)'
                            ,id: 3
                        }
                    ]
                },
                {
                    title: '科技人才(39)'
                    ,id: 7
                },
                {
                    title: '科技中介服务(18)'
                    ,id: 8
                },
                {
                    title: '科技条件与标准(2)'
                    ,id: 9
                },
                {
                    title: '科技金融与税收(41)'
                    ,id: 10
                },
                {
                    title: '科技成果与知识产权(84)'
                    ,id: 11
                },
                {
                    title: '科技奖励(28)'
                    ,id: 12
                },
                {
                    title: '科学技术普及(11)'
                    ,id: 13
                }];



        table.render({
            elem: '#currentTableId',
            url: '${pageContext.request.contextPath}/policyAll',//查询数据
            toolbar: '#toolbarDemo',
            defaultToolbar: ['filter', 'exports', 'print', {
                title: '提示',
                layEvent: 'LAYTABLE_TIPS',
                icon: 'layui-icon-tips'
            }],
            cols: [[
                {type: "checkbox", width: 50},
                {field: 'name', width: 350, title: '政策名称'},
                {field: 'organ', width: 150, title: '发文机构'},
                {field: 'pubdata', width: 150, title: '颁布日期'},
                {field: 'type', width: 100, title: '政策分类'},
                {title: '操作', Width: 50, toolbar: '#currentTableBar', align: "center"}
            ]],
            limits: [10, 15, 20, 25, 50, 100],
            limit: 15,  <!--默认显示15条-->
            page: true,
            skin: 'line',
            id:'testReload'
        });

        var $ = layui.$, active = {
            reload: function(){
                var Name = $('#name').val();
                var document = $('#document').val();
                var organ = $('#organ').val();
                var type = $('#type').val();
                console.log(name)
                //执行重载
                table.reload('testReload', {
                    page: {
                        curr: 1 //重新从第 1 页开始
                    }
                    ,where: {
                        Name: Name,
                        document:document,
                        organ:organ,
                        type:type
                    }
                }, 'data');
            }
        };

        function getData(){
            var data = [];
            $.ajax({
                url: "selectTree",    //后台数据请求地址
                type: "get",
                async:false,
                success: function(resut){
                    data = resut;
                }
            });
            return data;
        }
        tree.render({
            elem: '#test1'
            ,data: getData()
            ,click: function(obj){
                    var data = obj.data
                    var type = data.title;
                    console.log(name)
                    //执行重载
                    table.reload('testReload', {
                        page: {
                            curr: 1 //重新从第 1 页开始
                        }
                        ,where: {
                            type:type
                        }
                    }, 'data');
                }
        });





        $('.demoTable .layui-btn').on('click', function(){
            var type = $(this).data('type');
            active[type] ? active[type].call(this) : '';
        });

        /**
         * tool操作栏监听事件
         */
        table.on('tool(currentTableFilter)', function (obj) {
            var data=obj.data;
            if (obj.event === 'update') {  // 监听修改操作
                var index = layer.open({
                    title: '文件内容',
                    type: 2,
                    shade: 0.2,
                    maxmin:true,
                    shadeClose: true,
                    area: ['100%', '100%'],
                    content: '${pageContext.request.contextPath}/queryPoliceById?id='+data.id,
                });
                $(window).on("resize", function () {
                    layer.full(index);
                });
            } else if (obj.event === 'delete') {  // 监听删除操作
                layer.confirm('确定是否删除', function (index) {
                    //调用删除功能
                    deleteInfoByIds(data.id,index);
                    layer.close(index);
                });
            }
        });

        //监听表格复选框选择
        table.on('checkbox(currentTableFilter)', function (obj) {
            console.log(obj)
        });

        /**
         * 获取选中记录的id信息
         */
        function getCheackId(data){
            var arr=new Array();
            for(var i=0;i<data.length;i++){
                arr.push(data[i].id);
            }
            //拼接id,变成一个字符串
            return arr.join(",");
        };


        /**
         * 提交删除功能
         */
        function deleteInfoByIds(ids ,index){
            //向后台发送请求
            $.ajax({
                url: "deleteReader",
                type: "POST",
                data: {ids: ids},
                success: function (result) {
                    if (result.code == 0) {//如果成功
                        layer.msg('删除成功', {
                            icon: 6,
                            time: 500
                        }, function () {
                            parent.window.location.reload();
                            var iframeIndex = parent.layer.getFrameIndex(window.name);
                            parent.layer.close(iframeIndex);
                        });
                    } else {
                        layer.msg("删除失败");
                    }
                }
            })
        };

        /**
         * toolbar栏监听事件
         */
        table.on('toolbar(currentTableFilter)', function (obj) {
            if (obj.event === 'add') {  // 监听添加操作
                var index = layer.open({
                    title: '添加图书',
                    type: 2,
                    shade: 0.2,
                    maxmin:true,
                    shadeClose: true,
                    area: ['100%', '100%'],
                    content: '${pageContext.request.contextPath}/readerAdd',
                });
                $(window).on("resize", function () {
                    layer.full(index);
                });
            } else if (obj.event === 'delete') {
                /*
                  1、提示内容，必须删除大于0条
                  2、获取要删除记录的id信息
                  3、提交删除功能 ajax
                */
                //获取选中的记录信息
                var checkStatus=table.checkStatus(obj.config.id);
                var data=checkStatus.data;
                if(data.length==0){//如果没有选中信息
                    layer.msg("请选择要删除的记录信息");
                }else{
                    //获取记录信息的id集合,拼接的ids
                    var ids=getCheackId(data);
                    layer.confirm('确定是否删除', function (index) {
                        //调用删除功能
                        deleteInfoByIds(ids,index);
                        layer.close(index);
                    });
                }
            }
        });

    });
</script>
</body>

</html>
