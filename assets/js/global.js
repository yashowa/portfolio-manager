$(document).ready(function(){
    // chargement des notifications
    Notification.load();
    //init datetimepicker
    //$.fn.datepicker.defaults.language = 'fr';

    // init textarea tinymce
    tinymce.init({
        selector: '.js-textarea-tinymce',
        language: 'fr_FR',
        element_format : 'html',
        plugins: "code"
    });

    /*generic table event*/
  $('table')
        .on("check.bs.table", function(){

            var entity=$(this).closest('table').data('entity');
            enableAction(entity);
        })
        .on("uncheck.bs.table", function(){
            var entity=$(this).closest('table').data('entity');
            enableAction(entity);
        })
        .on(' check-all.bs.table',function(){
            var entity=$(this).closest('table').data('entity');
            enableAction(entity);
        })
        .on(' uncheck-all.bs.table',function(){
            var entity=$(this).closest('table').data('entity');
            enableAction(entity);
        });

    //global controls actions
    $("select[name='select-action']").on('change',function(){

      let btnDestinationSelector = "#"+(this.id).replace('select','validate');
      $(btnDestinationSelector).attr('data-action',$(this).val());

    })

    $(document).on('click', ".validate-action",function(){//action validate click

        var id= $(this).data('entity');
        var $table= $(".table-"+id);
        var action = $("#select-action-"+id).val();
        var heading ;
        var actionToDo = $(this).data('action');
        var strSubmitFunc="confirmAction('"+id+"')";
        var  btnText="Confirmer et valider";
        var placementId="actionModal";
        var formContent ="<ul>";
        var label ="";

        $.map($table.bootstrapTable('getSelections'), function (row) {

            switch(id) {
                case 'category-media':
                    label = " la catégorie de Média ";
                    break;
                case 'category-event':
                    label = "la catégorie d'évènement";
                    break;
                case 'media':
                    label = "le média";
                    break;
                case 'user':
                    label = "l'utilisateur";
                    break;
                case 'event':
                    label = " L'évènement\"";
                    break;

                default:
                    label = "l'entité";
                    break;
            }

            formContent += "<li>"+label + " n° "+ row.id + "</li>";
        })

        formContent+="</ul>";

        switch(action){
            case 'deleteList':
                heading =  'Supprimer la sélection';
                break;
            case 'enable':
                heading =  'Activer la sélection'
                break;
            case 'disable':
                heading =  'Désactiver la sélection'
                break;
            default:

                var id= $(this).data('entity');
                var $table= $(".table-"+id);
                var heading ;
                var  btnText="Confirmer et valider";
                var placementId="actionModal";
                var formContent ="Aucune action n'a été sélectionnée";

                Modal.do(placementId, '', formContent, '', '')

                return false;
                break;
        }

        Modal.do(placementId, heading, formContent, strSubmitFunc, btnText);

    })

    // call popin action  confirmAction delete
    $(document).on('click','.js-delete-action,.js-un',function(e){
        //au clic de ce bouton la checkbox est sélectionnée

        e.stopPropagation();
        e.preventDefault();
        var id = $(this).closest('tr').children('.td-id').text();
        var title = $(this).closest('tr').children('.td-name').text();
        var entity=$(this).data('entity');
        var index = $(this).closest('tr').data('index');
        id = $(this).closest('tr').data('uniqueid')

        $('.table-'+entity).bootstrapTable('uncheckAll');
        $('.table-'+entity).bootstrapTable('check',index);

        var action = $(this).attr('href');
        var heading ="Suppression de média";
        var strSubmitFunc="confirmAction('"+entity+"','deleteList')";
        var  btnText="Confirmer et valider";
        var placementId="actionModal";
        var formContent ="Etes-vous sûr de vouloir supprimer ";

        switch(entity){
            case 'category-media':
                heading ="Suppression de la catégorie de média";
                formContent+=" la catégorie de Média ";
                break;
            case 'category-event':
                heading ="Suppression de la catégorie d'évènement";
                formContent+=" la catégorie d'évènement";
                break;
            case 'media':
                formContent+= " le média";
                break;
            case 'user':
                heading ="Suppression d'utilisateur";
                formContent+= " l'utilisateur";
                break;
            case 'event':
                heading ="Suppression d'évènement";
                formContent+=" l'évènement";
                break;
            case 'module':
                heading ="Désinstallation de module";
                formContent+=" le module";
                break;
                default:
                    heading ="Suppression d'élément inconnu";
                    formContent+="l'entité";
                break;
        }

        formContent+= " n° "+id+": <br>"+title;

        Modal.do(placementId, heading, formContent, strSubmitFunc, btnText)
        return false;
    })

    $('.js-default-lang *:required').on('keyup',function(e){

        Global.checkLangFields('event')
    })

    function enableAction(entity){//enable or disable the global action of the entity
      var countMediaChecked = $(".table-"+entity+" input[type='checkbox'].form-check-input:checked").length;
      var $table= $(".table-"+entity);
      var ids = $.map($table.bootstrapTable('getSelections'), function (row) {
          return row.id;
      })
      var countEntities =ids.length;

      if(countEntities>=1){
          $("#select-action-"+entity).removeAttr('disabled');
          if($("#select-action-"+entity).val()!='undefined'){
              $("#validate-action-"+entity).removeAttr('disabled');
          }
      }else{
          $("#validate-action-"+entity+",#select-action-"+entity).attr('disabled',true);
      }
    }
    // end generic control actions//////////////////////////////////////////////////////////////////////////////
});

//function & classes

var Notification={
  push:function(msg,type,params){
  $('.block-notifications').html('')
    $('.block-notifications').append("<ul class='alert alert-"+type+" notification-push'>"+msg+"</ul>");
  $( ".notification-push" ).show('slow');
      setTimeout(function() {
      $( '.notification-push' ).hide('slow');
    }, 5000);
  },
  load:function(){
      $.ajax({
          type: 'POST',
          url: "/notification",
          success: (callback) => {
              if(JSON.parse(callback)){
                  callback = JSON.parse(callback)
                  Notification.push(callback.msg,callback.type)
              }
            }
        })
        //notifications
      /*  try {

          //  console.log(Cookies.get('notification'))
            var notification = JSON.parse(sessionStorage.getItem('notification'));
            console.log(sessionStorage.getItem('notification'))
            var msg = notification.msg;

            var msg = msg.replace(/\+/g,' ');
            if(msg!=""){
                Notification.push(msg,notification.type);
              //  Cookies.remove('notification')
              //document.cookie = "notification= ; expires = Thu, 01 Jan 1970 00:00:00 GMT"
              sessionStorage.removeItem('notification');
            }

        } catch (e) {

            return false;
        }*/
    }
}

function confirmAction(entity,action =null){

    var data={};
    var url="/"+entity+"/delete";
    var type="POST";
    var type="POST";
    var $table = $(".table-"+entity);
  if( action==null){
      var action = $("#select-action-"+entity).val();
  }

  var $table = $(".table-"+entity);
  var urlPart = entity;

  var listId=[];

    listId = $.map($table.bootstrapTable('getSelections'), function (row) {
        return row.id;
    })

   data.listId = JSON.stringify(listId);

  var partialurlArr = entity.split('-');
  var ko='shampoo'
  var sh = ko.split('-');
  var ctrl;
  var msg= "";

  switch(action){
    case 'deleteList':
      msg= "La suppression de la sélection a été effectuée avec succès !";
      if(partialurlArr[0]=='category'){
        url= "/"+partialurlArr[1]+"/category/delete";
      }else{
          urlPart!=''?urlPart=urlPart+'/':urlPart='';
       url="/"+urlPart+"delete";
      }
      type = "POST"
    break;
    case 'disable':
        msg= "La sélection a été désactivée avec succès !";
       url =  '/media/disable';
       if(partialurlArr[0]=='category'){
         url= "/"+partialurlArr[1]+"/category/disable";
       }else{
           urlPart!=''?urlPart=urlPart+'/':urlPart='';
           url="/"+urlPart+"disable";
       }
       type = "POST";
    break;
    case 'enable':
        msg= "La sélection a été activée avec succès !";
      if(partialurlArr[0]=='category'){
        url= "/"+partialurlArr[1]+"/category/enable";
      }else{
          urlPart!=''?urlPart=urlPart+'/':urlPart='';
       url="/"+urlPart+"enable";
      }
      type = "POST";
    break;
    default:
      type='POST';
    break;
  }


  $.ajax({
    type:type,
    url: url,
    data: data,
    success: function(callback){
      try{
          var res = JSON.parse(callback);

          if(res.status=='success'){
            Notification.push(msg,"success");

            var entityClassName = entity.charAt(0).toUpperCase()+ entity.substring(1)+'View';

              if (typeof maybeObject != "undefined") {

              }

            if(typeof entityClassName!='undefined' && entityClassName.hasOwnProperty('update')){
                window[entityClassName]['update'](action,listId);//case for specific treatment of the entity
            }


          }else{
            listErrorHTML=''
            $.each(result.errors,function(k,m){
              listErrorHTML+="<li>"+m+"</li>";
            })
            Notification.push(listErrorHTML,"danger");
          }


            var ids = $.map($table.bootstrapTable('getSelections'), function (row) {
                return row.id;
            })

      }catch(err){
          return false;
      }

        switch(action){
            case 'deleteList':
                $table.bootstrapTable('remove', {
                    field: 'id',
                    values:ids
                });
                break;
            case 'disable':
                $.map($table.bootstrapTable('getSelections'), function (row) {
                    $("#row-"+row.id).addClass('row-inactive');
                    $('tr[data-uniqueid="'+row.id+'"]').addClass('row-inactive');
                })
                break;
            case 'enable':
                $.map($table.bootstrapTable('getSelections'), function (row) {
                    $("#row-"+row.id).removeClass('row-inactive');
                    $('tr[data-uniqueid="'+row.id+'"]').removeClass('row-inactive');

                })
                break;
            default:
                type='POST';
                break;
        }
        Modal.hide();
    }
  })
}
function confirmDelete(url){
 var type='DELETE';
    $.ajax({
      type:type,
      url: url,
      data: {},
      success: function(callback){
        var res = JSON.parse(callback);
        Modal.hide();
        if(res.status=='success'){
          Notification.push(msg,"success");
        }else{
          listErrorHTML=''
          $.each(res.errors,function(k,m){
            listErrorHTML+="<li>"+m+"</li>";
          })
          Notification.push(listErrorHTML,"danger");
        }
          var newdata = [];
          newdata.push(mydata);
          $('#tblPendingRequests').bootstrapTable("load", newdata);
        $("input[type='checkbox'].form-check-input:checked").closest('tr').each(function(){
          $(this).remove();
        })
      }
    })
    return false;
}

var Modal={
    do :function(placementId, heading, formContent, strSubmitFunc, btnText){
      var html =  '<div id="modalWindow" class="modal hide fade in" tabindex="-1" role="dialog" style="display:none;">';
      html += '<div class="modal-dialog" role="document">'
      html += '<div class="modal-content">';
      if(heading!='') {
          html += '<div class="modal-header">';
          html += '<h4 class="modal-title">' + heading + '</h4>'
          html += '<a class="close" data-dismiss="modal">×</a>';
          html += '</div>';
      }
      html += '<div class="modal-body">';
      html += '<p>';
      html += formContent;
      html += '</div>';
      html += '<div class="modal-footer">';
      if (btnText!='') {
          html += '<span class="btn btn-success"';
          html += ' onClick="'+strSubmitFunc+'">'+btnText;
          html += '</span>';
      }
      html += '<button class="btn" data-dismiss="modal"> <i class="fa fa-close"></i> ';
      html += 'Fermer';
      html += '</button>'; // close button
      html += '</div>';  // footer
      html += '</div>';  // modalWindow
      html += '</div>';  // modalDialog
      html += '</div>';  // modalWindow
      $("#"+placementId).html(html);
      $("#modalWindow").modal();
    },
    hide:function(){
        // Using a very general selector - this is because $('#modalDiv').hide
        // will remove the modal window but not the mask
        $('.modal-backdrop').modal('hide');
        $('.modal.in').modal('hide');
        $('.modal.in').remove();
        $('.modal-backdrop').remove();
    }
  };


var Biblio={

    loadIndex:(row,value)=>{
        return value.id;
    },
  loadAction:(row,value)=>{
    return "<a class='btn btn-danger js-delete-upload-file' data-path='"+value.name+"'> <i class='fa fa-trash'></i></a>"
  },
  loadImage:(row,value)=>{
    return "<img style='height:250px;width: auto' src='/assets/uploads/"+value.name+"'/>"
  },
  loadRadio:(row,value)=>{

      return "<div class='form-check'>"+
          "<input type='radio' id='biblio-radio-item-"+value.id+"' name ='biblio-item' class='form-check-input biblio-item' value='"+value.name+"'>"+
     " </div>"

  },
    viewMedia:(path=>{

        var url = '/assets/uploads/'+path
        $.ajax({
            url:'url',
            type:'HEAD',
            error: function()
            {
                $(".blc-img").css('background-image','url(/assets/img/default.png)')
            },
            success: function()
            {
                $('.blc-img').css('background-image','url('+url+')');
            }
        });
    }),
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
    }
}


var  Global={
    isValidField:(type,value)=>{
        if(value==''){
            return false;
        }
        switch(type){
            case 'mail':
                break;
            default:
    break;
        }
    },
    fileExist:(urlImg)=>{
        $.get(urlImg)
            .done(function() {
                $('.blc-img').css('backgroundImage','url('+urlImg+')');
            }).fail(function(e) {

            // not exists code
            urlImg='/assets/uploads/'+urlImg;
            $.get(urlImg)
                .done(function(){
                    $('.blc-img').css('backgroundImage','url('+urlImg+')');
                })
                .fail(function(){
                    return false;
                })
        })
    },
    checkLangFields:(entity)=>{

            $('.js-default-lang *:required').each(function(){

                if($(this).val() ==''){
                    $('#btn-submit-'+entity).attr('disabled',true);
                }else{
                    $('#btn-submit-'+entity).removeAttr('disabled');
                };
            })
    }

}
