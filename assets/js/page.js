$(document).ready(function(){

    if($('#pages').length) {

        $('#table').bootstrapTable('uncheckAll');
        $('#table-category-page').bootstrapTable('uncheckAll');
        if($("input[name='page_active']").length){
            var activePage= Boolean($("input[name='page_active']").val());
            if(activePage){
                $('#active').bootstrapToggle('on');
            }
        }
        //FORM EDITION oF Page

        $('#form-page').submit(function (e) {
            e.preventDefault();
            e.stopPropagation();

            var id = $("#idPage").val();
            var path = $("#url").val();
            var url = $(this).attr('action');
            var type = $('#type').val();
            var active=$(this).find("input[name='active']").prop('checked')?1:0;
            var author = $(this).find(("input[name='author']")).val();
            var langFields=[];

            //champs du formulaire traduits
            $(".js-lang-version ").each(function(k,v){

                var idLang= this.id;
                var idPage = $(this).data('page-lang');
                code = idLang.split('-')[1];

                var content = tinymce.get('content-'+code).getContent();
                var title = $(this).find(("input[name='title-"+code+"']")).val();
                var alias = $(this).find(("input[name='alias-"+code+"']")).val();

                var fields={
                    "code"          :code,
                    "content"   :content,
                    "title"         :title,
                    "alias"         :alias,
                    "id_page_lang" :idPage
                };

                if (typeof id != 'undefined') {
                    fields["id_page"] =id
                }

                langFields.push(fields);
            })

            var values = $(this).serialize();
            var data = {
                'url': path,
                'type': type,
                'active': active,
                'author':author,
                'lang_fields':langFields,
            };

            $.ajax({
                type: "POST",
                url: url,
                data: data,
                success: function (callback) {
                    var result = JSON.parse(callback);
                    if (result.status == 'success') {
                        var msg = "La page  n° " + result.lastInsertId + " a été créee !";

                        if (typeof id != 'undefined') {
                            msg = "La modification de la page  n° " + id + " a été effectuée avec succès !";
                        }else {
                            $("#url").val('');

                            $("input[name='active']:checked").prop("checked", false);
                            $('#category').val('');
                            $('#type').val('');
                            $('.blc-img').removeAttr('style');

                            $(".js-lang-version").each(function(k,v){//vide les champs commun aux traduction
                                var code = this.id.split('-')[1];
                                $("input[name='title-"+code+"']").val('');
                                $("input[name='alias-"+code+"']").val('');
                                tinymce.get('content-'+code).setContent('');
                                $('#cat_page-'+code+' option[value="'+v.cat_page+'"]').removeAttr('selected');
                            })

                        }

                        /*  setTimeout(function(){
                              location.href='/admin/page'
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
            $('.notification-push').remove();
            return false;
        })



        $('#category').on('change', function () {  //control events
            console.log($('#category option').removeAttr('selected'));
        })

        $('#form-category-page').submit(function (e) {  //form category page
            e.preventDefault();
            e.stopPropagation()
            var id = $("#idCategory").val();
            var name = $("#name").val();
            var alias = $("#alias").val();
            var url = $(this).attr('action');
            var values = $(this).serialize();
            var data = {
                'alias': alias,
                'name': name,
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


