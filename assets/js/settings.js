$(document).ready(function(){


    $('#maintenance').on('change',function () {
        $("#maintenance-bloc-msg").toggleClass('js-hide')
    })

    if($("input[name='maintenance']").length){
        var isInMaintenance= Boolean($("input[name='maintenance']").val());

        if(isInMaintenance){
            $('#maintenance').bootstrapToggle('off');
        }else{
            $('#maintenance').bootstrapToggle('on');
        }
    }
    $('#form-settings').submit(function(e){

        e.preventDefault();
        e.stopPropagation();
        var url=$(this).attr('action')
        var id = $("#idSettings").val();
        var path = $.trim($("#url").val());

        var logo = $("#url").val();
        var mail = $("input[name='mail']").val();
        var description = $("textarea[name='description']").val();
        var sitename = $("input[name='sitename']").val();
        var keywords = $("input[name='website_keyword']").val();
        var maintenance = $(this).find("input[name='is_active']").prop('checked')?0:1;
        var maintenance_msg = tinymce.get('maintenance-msg').getContent();
        var website_fb = $("input[name='fb']").val();
        var website_fb_id = $("input[name='fbid']").val();
        var website_tw = $("input[name='tw']").val();
        var website_tw_id = $("input[name='twid']").val();
        var website_insta = $("input[name='insta']").val();
        var website_insta_id = $("input[name='instaid']").val();


        var data={
            "website_logo":logo,
            "website_title":sitename,
            "website_keywords":keywords,
            "website_description":description,
            "website_email":mail,
            "website_maintenance":maintenance,
            "website_fb":website_fb,
            "website_fb_id":website_fb_id,
            "website_tw":website_tw,
            "website_tw_id":website_tw_id,
            "website_insta":website_insta,
            "website_insta_id":website_insta_id
    };

        $.ajax({
            method:'POST',
            url:url,
            data:{datas:data},
            success:function(callback){
                console.log(callback)
                try{
                    var result = JSON.parse(callback);
                    console.log(result.status)
                    if (result.status == 'success') {
                        var msg = "Les paramètres ont été mis à jour";
                        /*  setTimeout(function(){
                              location.href='/admin/media'
                          },2000);*/
                        Notification.push(msg, "success");
                    } else {
                        var listErrorHTML = "Un problème est survenu lors de la mise à jour des paramètres."
                        if (typeof result.errors != 'undefined') {
                            $.each(result.errors, function (k, m) {
                                listErrorHTML += "<li>" + m + "</li>";
                            })
                        }

                    }

                }catch (e){
                    var msgErr='Erreur:Format de sortie illisible lors de la mise à jour des paramètres';
                    Notification.push(msgErr, "danger");
                }
            },

        })
        return false;
    })


});
