$(document).ready(function(){



    if($('#users').length) {

        $('#table').bootstrapTable('uncheckAll');
        $('#table-users').bootstrapTable('uncheckAll');

        $(document).on('submit','#form-user',function (e) {
            e.preventDefault();
            e.stopPropagation();
            //  console.log($(this).children('input'));
            var id = $("#idUser").val();
            var lastname = $("#lastname").val();
            var firstname = $.trim($("#firstname").val());
            var profile = $('#profile').val();
            var email = $('#email').val();
            var pwd = $('#password').val();

            var path = $("#url").val();
            var url = $(this).attr('action');

            var values = $(this).serialize();
            //console.log(category)
            var data = {
                'firstname': firstname,
                'email': email,
                'url': path,
                'lastname': lastname,
                'profile': profile,
                'password': pwd
            };

            $.ajax({
                type: "POST",
                url: url,
                data: data,
                success: function (callback) {
                    var result = JSON.parse(callback);
                    if (result.status == 'success') {
                        var msg = "L'utilisateur n° " + result.lastInsertId + " a été crée !";


                        if (typeof id != 'undefined') {
                            msg = "La modification de l'utilisateur  n° " + id + " a été effectuée avec succès !";
                        }else{
                            $("#firstname").val('');
                            $("#lastname").val('');
                            $("#email").val('');

                            $("input[name='active']:checked").prop("checked", false);

                            $('#password').val('');

                        }
                        setTimeout(function(){
                            location.href='/admin/user'
                        },2000);
                        Notification.push(msg, "success");
                    } else {
                        listErrorHTML = ''
                        $.each(result.errors, function (k, m) {
                            listErrorHTML += "<li>" + m + "</li>";
                        })
                        Notification.push(listErrorHTML, "danger");
                    }
                }
            });
            $('.notification-push').remove()
            return false;
        })

        $('.delete-user').on('click', function (e) {
            e.stopPropagation();
            e.preventDefault();
            var id = $(this).closest('tr').children('.td-id').text();
            var title = $(this).closest('tr').children('.td-name').text();
            var entity = $(this).data('entity');
            var action = $(this).attr('href');
            console.log(action)

            var heading = "Suppression de l'utilisateur " + id;
            var strSubmitFunc = "confirmAction('user','" + action + "')";
            var btnText = "Confirmer et valider";
            var placementId = "actionModal";
            var formContent = "Etes-vous sûr de vouloir supprimer l'utilisateur";
            formContent += "n° " + id + ": <br>" + title;

            //Modal.do(placementId, heading, formContent, strSubmitFunc, btnText)
            return false;
        })

        $(".table-user .validate-action").on('click', function () {//action validate click

            var id = $(this).data('entity');
            var action = $("#select-action-" + id).val();
            var heading;
            var strSubmitFunc = "confirmAction('" + id + "')";
            var btnText = "Confirmer et valider";
            var placementId = "actionModal";
            var formContent = "<ul>";

            $(".table-" + id + " input[type='checkbox'].form-check-input:checked").each(function () {
                if (id == 'category') {
                    formContent += "<li>Type d'utilsateur n°" + $(this).val() + "</li>";
                } else {
                    formContent += "<li>l'utilisateur n°" + $(this).val() + "</li>";
                }

            })
            formContent += "</ul>";

            switch (action) {
                case 'deleteList':
                    heading = 'Supprimer la sélection'
                    break;
                case 'disable':
                    heading = 'Activer la sélection'
                    break;
                case 'unable':
                    heading = 'Désactiver la sélection'
                    break;
                default:
                    break;
            }

            //Modal.do(placementId, heading, formContent, strSubmitFunc, btnText)
        })

        /*  $('.table-user .js-delete-action').on('click',function(e){//action  confirmAction delete
              e.stopPropagation();
              e.preventDefault();
              var id = $(this).closest('tr').children('.td-id').text();
              var title = $(this).closest('tr').children('.td-firstname').text() +" " + $(this).closest('tr').children('.td-lastname').text().toUpperCase();
              var entity=$(this).data('entity');
              var action = $(this).attr('href');
             // console.log(action)

              var heading ="Suppression d'utilisateur";
              var strSubmitFunc="confirmAction('user','"+action+"')";
              var  btnText="Confirmer et valider";
              var placementId="actionModal";
              var formContent ="Etes-vous sûr de vouloir supprimer ";
              if(entity=='category'){
                formContent+=" le groupe d'utilisateur ";
              }else{
                formContent+= "L'utilisateur";
              }
              formContent+= " n° "+id+": <br>"+title;

              //Modal.do(placementId, heading, formContent, strSubmitFunc, btnText)
              return false;
          })*/

    }
})


function confirmDelete(url){
    type='DELETE';
   // console.log(url);
    /*$.ajax({
        type:type,
        url: url,
        data: {},
        success: function(callback){
            console.log(callback);
            var res = JSON.parse(callback);
            Modal.hide();
            if(res.status=='success'){
                var msg= "La suppression de l'utilisateur a été effectuée avec succès !";
                Notification.push(msg,"success");
            }else{
                listErrorHTML=''
                $.each(result.errors,function(k,m){
                    listErrorHTML+="<li>"+m+"</li>";
                })
                Notification.push(listErrorHTML,"danger");
            }

            $("input[type='checkbox'].form-control:checked").closest('tr').each(function(){
                $(this).remove();
            })
        }
    })*/
    return false
}
