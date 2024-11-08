
function uninstall(id){
  $("#row-"+id+" form.uninstall-module").submit();
}

$(document).ready(function(){
    if($('#module').length){

      $('form.install-module').submit(function (e) {  //form category media
          e.preventDefault();
          e.stopPropagation();
          var url = $(this).attr('action');
          var name = $(this).find("input[name='moduleName']").val();
          var data = {
              'moduleName': name,
          };

          $.ajax({
              type: "POST",
              url: url,
              data: data,
              success: function (callback) {
                  var result = JSON.parse(callback);
                  if (result.status == 'success') {
                      var result = JSON.parse(callback);
                      if (result.status == 'success') {
                          var msg = "le module  " + name + " a été installé avec succès !";
                          Notification.push(msg, "success");
                          location.reload();
                      } else {
                          listErrorHTML = ''
                          $.each(result.errors, function (k, m) {
                              listErrorHTML += "<li>" + m + "</li>";
                          })
                          Notification.push(listErrorHTML, "danger");
                      }
                  }
              }
          });
          $('.notification-push').remove();
          return false;
      })

      $('.js-install-action').on('click',function(e) {
        e.preventDefault();
        e.stopPropagation();
          var url = $(this).attr('href');
          var name = $(this).find("input[name='moduleName']").val();
          var action = $(this).attr('href');
          var data = {
              'moduleName': name,
          };
          $.ajax({
            type: "POST",
            url: url,
            data: data,
            success: function (callback) {
                return false;
                var result = JSON.parse(callback);
                if (result.status == 'success') {
                    var result = JSON.parse(callback);
                    if (result.status == 'success') {
                        var msg = "le module  " + name + " a été installé avec succès !";
                        Notification.push(msg, "success");
                        location.reload();
                    } else {
                        listErrorHTML = ''
                        $.each(result.errors, function (k, m) {
                            listErrorHTML += "<li>" + m + "</li>";
                        })
                        Notification.push(listErrorHTML, "danger");
                    }
                }
            }
        });
          return false;
      })

      $(document).on('click','.js-uninstall-action',function(e){
          //au clic de ce bouton la checkbox est sélectionnée

          e.stopPropagation();
          e.preventDefault();
          var id = $(this).closest('tr').children('.td-id').text();
          var title =$(this).data('name');
          var entity=$(this).data('entity');
          var index = $(this).closest('tr').data('index');
          id = $(this).data('id');

          var action = $(this).attr('href');
          heading ="Désinstallation de module";
          var formContent="Souhaitez vous désinstaller le module";
          var strSubmitFunc="uninstall('"+id+"')";
          var  btnText="Confirmer et desinstaller";
          var placementId="actionModal";

          formContent+= " n° "+id+": <br>"+title;
          formContent+= "<p><small class='alert alert-warning'><i class='fa fa-exclamation-triangle'></i> Attention, cette opération est définitive</small></p>";

          Modal.do(placementId, heading, formContent, strSubmitFunc, btnText)
          return false;
      })

      $('form.uninstall-module').submit(function (e) {  //form category media
          e.preventDefault();
          e.stopPropagation();
          var url = $(this).attr('action');
          var name = $(this).find("input[name='moduleName']").val();
          var idModule = $(this).find("input[name='moduleName']").data('id-module')
          var data = {
              'moduleName': name,
              'idModule'  : idModule
          };

          $.ajax({
              type: "POST",
              url: url,
              data: data,
              success: function (callback) {
                  var result = JSON.parse(callback);
                  if (result.status == 'success') {
                      var result = JSON.parse(callback);
                      if (result.status == 'success') {
                          var msg = "le module  " + name + " a été désinstallé";
                          Notification.push(msg, "success");
                          location.reload();
                      } else {
                          listErrorHTML = ''
                          $.each(result.errors, function (k, m) {
                              listErrorHTML += "<li>" + m + "</li>";
                          })
                          Notification.push(listErrorHTML, "danger");
                      }
                  }
              }
          });
          $('.notification-push').remove();
          return false;
      })
    }
});
