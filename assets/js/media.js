$(document).ready(function(){


    if($('#medias').length) {

        $('#table').bootstrapTable('uncheckAll');
        $('#table-category-media').bootstrapTable('uncheckAll');
        //FORM EDITION oF MEDIA


        $('#form-media').submit(function (e) {
            e.preventDefault();
            e.stopPropagation();

            var id = $("#idMedia").val();
            var active =+ $("input[name='active']").prop('checked');
            var ajaxUrl = $(this).attr('action');
            var type = $('#type').val();
            var url = $('#filepath').val();

            var langFields=[];
            //champs du formulaire traduits
            $(".js-lang-version ").each(function(k,v){

                var idLang= this.id;
                var idEvent = $(this).data('media-lang');
                code = idLang.split('-')[1];

                var description = tinymce.get('description-'+code).getContent();
                var title = $(this).find(("input[name='title-"+code+"']")).val();
                if(title==''){

                }

                var category=parseInt($(this).find( '#cat_media-'+code+' option:selected').val());

                var fields={
                    "code"          :code,
                    "description"   :description,
                    "title"         :title,
                    "category"      :category,
                    "id_media_lang" :idEvent,
                };

                if (typeof id != 'undefined') {
                    fields["id_media"] =id
                }

                langFields.push(fields);
            })


            var values = $(this).serialize();
            //console.log(category)
            var data = {
                'url': url,
                'type': type,
                'active': active,
                'lang_fields':langFields,
            };


            $.ajax({
                type: "POST",
                url: ajaxUrl,
                data: data,
                success: function (callback) {
                    var result = JSON.parse(callback);
                    if (result.status == 'success') {
                        var msg = "Le média n° " + result.lastInsertId + " a été crée !";


                        if (typeof id != 'undefined') {
                            msg = "La modification du média n° " + id + " a été effectuée avec succès !";
                        }else {
                            $("#filepath").val('');

                            $("input[name='active']:checked").prop("checked", false);
                            $('#category').val('');
                            $('#type').val('');
                            $('.blc-img').removeAttr('style');

                            $(".js-lang-version").each(function(k,v){//vide les champs commun aux traduction
                                var code = this.id.split('-')[1];
                                $("input[name='title-"+code+"']").val('');
                                tinymce.get('description-'+code).setContent('');
                                $('#cat_media-'+code+' option[value="'+v.cat_media+'"]').removeAttr('selected');
                            })

                        }

                      /*  setTimeout(function(){
                            location.href='/admin/media'
                        },2000);*/
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


        $('#category').on('change', function () {  //control events
            console.log($('#category option').removeAttr('selected'));
        })

        $('#form-category-media').submit(function (e) {  //form category media
            e.preventDefault();
            e.stopPropagation()
            //  console.log($(this).children('input'));
            var id = $("#idCategory").val();
            var name = $("#name").val();
            var alias = $("#alias").val();
            var ajaxUrl = $(this).attr('action');
            var values = $(this).serialize();
            var data = {
                'alias': alias,
                'name': name,
            };

            $.ajax({
                type: "POST",
                url: ajaxUrl,
                data: data,
                success: function (callback) {

                    var result = JSON.parse(callback);
                    if (result.status == 'success') {
                        var result = JSON.parse(callback);
                        if (result.status == 'success') {
                            var msg = "La catégorie média n° " + result.lastInsertId + " a été crée !";
                            if (typeof id != 'undefined') {
                                msg = "La modification de la catégorie média n° " + id + " a été effectuée avec succès !";
                            } else {
                                $('#name').val('');
                                $('#alias').val('');
                            }
                            Notification.push(msg, "success");
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
            $('.notification-push').remove()
            return false;
        })
    }

})

MediaView={
    update:(procedure,listID)=>{

    },
}
