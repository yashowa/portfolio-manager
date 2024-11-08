

$(document).ready(function(){

    // loading biblio files
    $.ajax({
        url:'/fileupload',
        type:'GET',
        success:function(data){
            try {
                res = JSON.parse(data);
                //  console.clear()
                $table=$(".table-fileupload");
                $remove=$(".js-multifile-delete");
                $table.bootstrapTable({
                    data:res
                })
               $table.on('check.bs.table uncheck.bs.table ' +
                    'check-all.bs.table uncheck-all.bs.table',
                    function () {
                        $remove.prop('disabled', !$table.bootstrapTable('getSelections').length)
                })

                /*init  if a radio is checked*/

                if($('#filepath').val()!=''){
                    var url =$('#filepath').val();
                    $(".table-fileupload td input[type='radio']").each(function(k,v){
                       if(url ==$(v).val()){
                           $(v).prop('checked',true);
                       }
                    })
                }
            }
            catch (err) {
                console.log(err);
            }
        }
    })



    //form upload file submit
    $(document).on('submit', '#form-upload', function (e) {
        e.preventDefault();
        var url =$(this).find("input[name='files']").val();
        var urlArray = url.split("\\");
        var urlFile = urlArray[urlArray.length - 1];
        var $table =$('.table-fileupload');
        $.ajax({
            type: 'POST',
            data: new FormData(this),
            url: '/fileupload',
            success: (callback) => {
                var res = JSON.parse(callback);
                var msg = res.msg;
                if (res.status == 'success') {
                    Biblio.viewMedia(urlFile);
                    Biblio.addMedia($table,urlFile);
                    status = "success";
                } else {
                    status = "danger";
                }
                Notification.push(msg, status);
            },
            processData: false,
            contentType: false
        })
        return false;
    })

    $(document).on('submit','#form-select-file',function (e) {  //selection of file
        e.preventDefault();
        e.stopPropagation();
        var url='';
        var tabLink =($(this).closest('.modal-content').find('.nav-link.active').attr('id'));

        if(tabLink=='biblio-tab'){
     //       url ='/assets/uploads';
        }
        url += $("input[name='biblio-item']:checked").val();
        //focus sur le slide
        var idSelector = $(".tab-slide.active").attr('id');
        $('#url_slide_'+idSelector).val(url);

        Biblio.viewMedia(url,idSelector);
        $('.tab-pane.active .form-group .choose-file > input').val(url);
        return false;
    })



    $(document).on('blur','.file-input-text',function(e){
        e.preventDefault();

        var currentUrl =$(this).val();
        var url = '/assets/uploads/'+currentUrl;
        $.ajax({
            url:'url',
            type:'HEAD',
            error: function()
            {
                $(".blc-img").css('background-image','url(/assets/img/default.png)')
            },
            success: function()
            {
                Biblio.viewMedia(currentUrl);
            }
        });
    })

    //button delete unique file from a line
    $(document).on('click','.js-delete-upload-file',function(e){

        e.preventDefault();
        var fileToDelete =$(this).attr('data-path');
        var idRowToDelete= parseInt($(this).closest('tr').data('uniqueid'));

        if(confirm('Supprimer cet élément de la bibliothèque? (Les chemins des médias associés aux entités ne seront pas impactés')){
            $.ajax({
                url:'/fileupload/delete',
                type:'POST',
                data:{fileToDelete:fileToDelete},
                success:function(callBack){
                    try {
                        var res = JSON.parse(callBack);
                        if (res.status == 'success') {
                            Notification.push(res.msg, "success");
                            var  $table=$('.table-fileupload');

                            $table.bootstrapTable('removeByUniqueId', idRowToDelete)

                            //  $table.bootstrapTable('remove', {field:'id',values:[idRowToDelete]});

                        } else {
                            listErrorHTML = ''
                            $.each(result.errors, function (k, m) {
                                listErrorHTML += "<li>" + m + "</li>";
                            })
                            Notification.push(listErrorHTML, "danger");
                        }
                    }catch(err){
                        console.log(err)
                    }

                }
            })
        }
    })

    //validate
    $(document).on("click",".js-select-file",function(e){
        $(".js-select-file").not($(this)).prop('checked',false);
        $(this).prop('checked');
    })


    $(document).on('click','.blc-img',function(){
        $(".js-btn-loadfile").trigger('click');
    });

    $('.js-validate-file-upload').on('click',function(e){
        e.preventDefault();
        var id =$('.tab-pane.active form').attr('id');
        $('.tab-pane.active form').submit();
        $('#loadFileModal').modal('toggle');
    })


    /*multi delete of file selection*/
    $(document).on('click','.js-multifile-delete',function(){

        var id= $(this).data('entity');
        var $table= $(".table-"+id);
        var heading ;
        var strSubmitFunc="confirmDeleteListFile('"+id+"')";
        var  btnText="Confirmer et valider";
        var placementId="actionModal";
        var formContent ="<ul>";
        var label ="";

        $.map($table.bootstrapTable('getSelections'), function (row) {
            label = 'le fichier ';
            formContent += "<li>"+label + " n° "+ row.id + "</li>";
        })

        formContent+="</ul>";
        heading =  'Supprimer la sélection';
        Modal.do(placementId, heading, formContent, strSubmitFunc, btnText);
    })



/*

                $remove.click(function () {
                    var ids = Biblio.getIdSelection($table)
                    $table.bootstrapTable('remove', {
                        field: 'id',
                        values: ids
                    })
                    $remove.prop('disabled', true)
                })
 */





})



function confirmDeleteListFile(entity,action =null){

    var data={};
    var url="/"+entity+"/delete";
    var type="POST";
    var type="POST";

    if( action==null){
        var action = $("#select-action-"+entity).val();
    }

    var $table = $(".table-"+entity);
    var urlPart = entity;
    var listId=[];

    listFile = $.map($table.bootstrapTable('getSelections'), function (row) {
        return row.name;
    })


    data.listFile = JSON.stringify(listFile);
    var partialurlArr = entity.split('-');
    var ko='shampoo'
    var sh = ko.split('-');
    var ctrl;
    var msg= "";

    $.ajax({
        type:type,
        url: url,
        data: data,
        success: function(callback){
            try{
                var res = JSON.parse(callback);
                var status=res.status
                if(res.status=='success'){
                   msg=res.msg;
                }else{
                    msg = 'Une erreur est survenue lorsde la suppressionde la sélection';
                    status= 'danger'
                }

                Notification.push(msg,status);
                var $table = $(".table-"+entity);
                var ids = $.map($table.bootstrapTable('getSelections'), function (row) {
                    return row.id;
                })
            }catch(err){
                console.log(err);
            }

            $table.bootstrapTable('remove', {
                field: 'id',
                values:ids
            });

            Modal.hide();
        }
    })
}


var Biblio={

    loadIndex:(row,value)=>{
        return value.id;
    },
    loadAction:(row,value)=>{
        return "<a class='btn btn-danger js-delete-upload-file' data-path='"+value.name+"'> <i class='fa fa-trash'></i></a>"
    },
    loadImage:(row,value)=>{
        return "<img style='max-width:100%' src='/assets/uploads/"+value.name+"'/>"
    },
    loadRadio:(row,value)=>{
        return "<div class='form-check'>"+
            "<input type='radio' id='biblio-radio-item-"+value.id+"' name ='biblio-item' class='form-check-input biblio-item' value='"+value.name+"'>"+
            " </div>"
    },
    viewMedia:(path)=>{
        var url = '/assets/uploads/' + path;

        $.ajax({
            url:url,
            type:'HEAD',
            error: function()
            {
                $(".blc-img").css('background-image','url(/assets/img/default.png)')
            },
            success: function()
            {
                $('.blc-img').css("background-image","url('"+url+"')");
                $("input[name='filepath']").val(path);
            }
        });
    },
    getIdSelection:($table)=>{
        return $.map($table.bootstrapTable('getSelections'), function (row) {
            return row.id;
        })
    },
    addMedia:($table,url)=>{
        var nbRow =$table.find('tr').length;
        $table.bootstrapTable('insertRow',{
            index:nbRow,
            row:{
                id:nbRow,
                name:url
            }
        })
    },
}
