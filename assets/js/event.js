var listEvents=[];
var calendar;
var $table = $('.table-event');

$(document).ready(function(){

    Global.checkLangFields('event')

    if($('#events').length) {

        if($('#calendar').length){// if there is a clandar on the view we load ajax

            var calendarEl = document.getElementById('calendar')

            calendar = new FullCalendar.Calendar(calendarEl, {
            plugins: ['dayGrid', 'timeGrid', 'list', 'interaction', 'momentPlugin', 'momentTimezonePlugin'],
            defaultView: 'dayGridMonth',
            selectable: true,
            locale: 'fr',
            isRTL: true,
            header: {
                left: 'prev,next today',
                center: 'title',
                right: 'dayGridMonth,timeGridWeek,list'
            },
            buttonText: {
                today: 'Aujourd\'hui',
                month: 'Mois',
                week: 'Semaine',
                list: 'Liste'
            },
            editable: true, // don't allow event dragging
            eventResourceEditable: true, // except for between resources,
            // events: events,
            eventSources:[
                {
                    events: function(fetchInfo, successCallback, failureCallback) {
                        $.ajax({
                             method: 'GET',
                             url: '/event/getAllAdmin',
                            headers:{
                                'X-Auth-Token':tokenApi
                            },
                             success: function (events) {
                                successCallback(events);
                             }
                        })
                    },
                }
             ],
            eventDrop: (infos) => {//drop event and replace

                if (!confirm("Voulez vous déplacer l'évènement  du " + infos.event.start + " au " + infos.event.end + "?")) {
                 infos.revert();
                } else {

                    var start = moment(infos.event.start).format('DD-MM-YYYY hh:mm:ss');
                    var end = moment(infos.event.end).format('DD-MM-YYYY hh:mm:ss');
                    var event = {
                        'url': infos.event.url,
                        'link_event': infos.event.link_event,
                        'active': infos.event.is_active,
                        'organizer': infos.event.organizer,
                        'date_start':moment(start,'DD-MM-YYYY hh:mm:ss').format('YYYY-MM-DD hh:mm:ss'),
                        'date_end':moment(end,'DD-MM-YYYY hh:mm:ss').format('YYYY-MM-DD hh:mm:ss'),
                        'contact': infos.event.contact,
                        'fees': infos.event.fees,
                        'place': infos.event.place,
                        'author': infos.event.author
                    }

                     $.ajax({
                         method: 'POST',
                         url: '/event/' + infos.event.id + '/update',
                         data: event,
                         success: function (callback) {
                             var res = JSON.parse(callback);

                             if (res.status == 'success') {
                                 var msg = "L'évènement a été mis à jour"

                                 Notification.push(msg, "success");
                             } else {
                                 listErrorHTML = ''
                                 $.each(result.errors, function (k, m) {
                                     listErrorHTML += "<li>" + m + "</li>";
                                 })
                                 Notification.push(listErrorHTML, "danger");
                             }
                         }
                     })
                }

            },
            select: (event) => {
                EventView.loadForm(event);
            },
            eventClick:function(infos, jsEvent, view) {//on click event
                infos.jsEvent.preventDefault();
                EventView.loadForm(infos.event);
            }
        });
            calendar.render();
        }

        $(".js-add-event").on('click', (e) => {
         e.preventDefault();
         var Event = {

             title: "",
             start: new Date(),
             end:  new Date(),
         };
           /* 'date_start':moment(start,'DD-MM-YYYY hh:mm:ss').format('YYYY-MM-DD hh:mm:ss'),
                'date_end':moment(end,'DD-MM-YYYY hh:mm:ss').format('YYYY-MM-DD hh:mm:ss'),*/
         EventView.loadForm();
        })

        $('.js-default-lang *:required').on('keyup',function(e){//controle les  champs obligatoires pour les evenements

           // e.preventDefault();
            $('.js-default-lang *:required').each(function(){
                if($(this).val() ==''){
                    $('#btn-submit-event').attr('disabled',true);
                }else{
                    $('#btn-submit-event').removeAttr('disabled');
                };
            })
        })

        $('#search-tab').on('click',(e)=>{// refresh events on table event  view
            $this =$(e.currentTarget);
            if(!$this.hasClass('active')){
                $.ajax({
                    url     : '/event/getAllAdmin',
                    type    : 'GET',
                    headers : {
                        'X-Auth-Token':tokenApi
                    },
                    success: function( data ) {
                        var  $table =$(".table-event");
                        var res = data.map(event=>{
                            return{
                                id:event.id,
                                name:event.title,
                                start : moment(event.start).format('DD-MM-YYYY hh:mm:ss'),
                                end : moment(event.end).format('DD-MM-YYYY hh:mm:ss'),
                                active:event.active
                            }
                        })
                        $table.bootstrapTable('destroy');
                        $table.bootstrapTable({
                            data:res
                        })
                    },
                    error: function(data){
                        alert('Error');
                    }
                });
            }
        })



        $(document).on('submit', '#form-event', function (e) {
             e.stopPropagation();
             e.preventDefault();

             var title = $(this).find(("input[name='title-"+lang.code+"']")).val();
             var start = $(this).find(("input[name='date_start']")).val();
             var end = $(this).find(("input[name='date_end']")).val();
             var organizer = $(this).find(("input[name='organizer']")).val();
             var address = $(this).find(("input[name='addresse']")).val();
             var media = $(this).find(("input[name='filepath']")).val();
             var url = $(this).find(("input[name='url']")).val();
             //var description = tinymce.get('description').getContent();
             var author = $(this).find(("input[name='author']")).val();
             var place = $(this).find(("textarea[name='place']")).val();
             var active=$(this).find("input[name='is_active']").prop('checked')?1:0;
             var action = $(this).attr('action');
             var category=$(this).find( '#cat_event option:selected').val();
             var id=$(this).attr('data-id');
             var contact =  $("input[name='contact']").val();
             var errors = [];
             var langFields=[];
             //champs du formulaire traduits
            $(".js-lang-version ").each(function(k,v){

                var idLang= this.id;
                var idEvent = $(this).data('event-lang');
                code = idLang.split('-')[1];

                var description = tinymce.get('description-'+code).getContent();
                var title = $(this).find(("input[name='title-"+code+"']")).val();
                if(title==''){

                }

                var category=parseInt($(this).find( '#cat_event-'+code+' option:selected').val());

                var fields={
                    "code"          :code,
                    "description"   :description,
                    "title"         :title,
                    "category"      :category,
                };
                if (typeof id != 'undefined') {
                    fields["id_event_lang"] =idEvent
                }

                langFields.push(fields);
            })


            if (!isValidField(start, 'date')) {
                 errors.push({
                     id: "date_start",
                     msg: "format de date de début invalide"
                 })
             }
             if (!isValidField(end, 'date')) {
                 errors.push({
                     id: "date_end",
                     msg: "format de date de fin invalide"
                 })
             }
            // return false;
             $('#event-errors > ul').remove();
             $('.red-target').removeClass('red-target');

             if (errors.length) {
                 $("#event-errors").append("<ul class='alert alert-danger'></ul>");
                 $.each(errors, function (k, v) {
                     $("#event-errors > ul").append("<li>" + v.msg + "</li>");
                     $("*[name=" + v.id + "]").addClass('red-target');
                 })
             }else{
                 var data = {
                     'url': url,
                     'lang_fields':langFields,
                     'active': active,
                     'category': category,
                     'date_start':moment(start,'DD-MM-YYYY hh:mm:ss').format('YYYY-MM-DD HH:mm:ss'),
                     'date_end':moment(end,'DD-MM-YYYY hh:mm:ss').format('YYYY-MM-DD HH:mm:ss'),
                     'organizer':organizer,
                     'address':address,
                     'media':media,
                     'author':author,
                     'place':place,
                     'fees':0,
                     'contact':contact
                 };

                $.ajax({
                 type: "POST",
                 url: action,
                 data: data,
                 success: function (callback) {

                     var result = JSON.parse(callback);
                     if (result.status == 'success') {
                         var msg = "L'évènement n° " + result.lastInsertId + " a été crée !";

                         //update the event in the fullcalendar instance
                         if (typeof id != 'undefined') {
                             msg = "La modification de l'évènement n° " + id + " a été effectuée avec succès !";
                             var event = calendar.getEventById(id);

                             event.setProp('title',title)
                             event.setProp('url',url)
                             event.setDates( start, end )
                             event.setExtendedProp('langs',langFields)
                             event.setExtendedProp('active',active)
                             event.setExtendedProp('category',category)
                             event.setExtendedProp('organizer',organizer)
                             event.setExtendedProp('media',media)
                             event.setExtendedProp('address',address)
                             event.setExtendedProp('author',author)
                             event.setExtendedProp('place',place)
                             event.setExtendedProp('fees',0)

                             //create the event in the list
                             calendar.refetchEvents();
                            var index = $('tr[data-uniqueid="'+id+'"]').data('index');
                            var rowId= "row-"+id
                             $('.table-event').bootstrapTable('updateRow', {
                                 index: index,
                                 row: {
                                     id: id,
                                     start:start,
                                     end:end,
                                     name:title,
                                     active:active

                                 }
                            })

                         }else {

                             var index=0;
                             var countRow= $('.table-event').bootstrapTable('getData').length;
                             if(countRow>0){
                                 index=countRow - 1 ;
                             }

                             var dataToShow={
                                 id: result.lastInsertId,
                                 start:moment(start,'DD-MM-YYYY hh:mm:ss').format('DD/MM/YYYY hh:mm:ss'),
                                 end:moment(end,'DD-MM-YYYY hh:mm:ss').format('DD/MM/YYYY hh:mm:ss'),
                                 name:title,
                                 active:active
                             }

                             //dataToShow.action = EventView.loadAction(result.lastInsertId,dataToShow);
                             $('.table-event').bootstrapTable('insertRow', {
                                 index: index,
                                 row: dataToShow
                             })
                             calendar.addEvent(dataToShow);//add the event in the FullCalendar instance;*/
                             $("#title").val('');
                             $("#url").val('');
                             $("#description").val('');
                             $("input[name='active']:checked").prop("checked", false);
                             $("textarea[name='place']").val("");
                             $('#category').val('');
                             $('#type').val('');
                             $('#btn-submit-event').attr('disabled',true)
                         }
                            Notification.push(msg, "success");
                            calendar.refetchEvents();
                            $('#eventModal').modal('toggle')
                         //$("#search-tab").trigger("click");

                                } else {
                                    listErrorHTML = ''
                                    $.each(result.errors, function (k, m) {
                                        listErrorHTML += "<li>" + m + "</li>";
                                    })
                                    Notification.push(listErrorHTML, "danger");
                                }
                            }
                        });
             }
             return false;
        })
        $(document).on('submit','#form-category-event',function (e) {  //form category media
            e.preventDefault();
            e.stopPropagation()
            var id = $("#idCategory").val();
            var name = $("#name").val();
            var alias = $("#alias").val();
            var color = $("input[name='color']").val();
            var url = $(this).attr('action');
            var values = $(this).serialize();
            var data = {
                'alias': alias,
                'name': name,
                'color':color
            };

            $.ajax({
                type: "POST",
                url: url,
                data: data,
                success: function (callback) {
                    var result = JSON.parse(callback);

                    if (result.status == 'success') {
                        var msg = "La catégorie évènement n° " + result.lastInsertId + " a été crée !";

                        if (typeof id != 'undefined') {
                            msg = "La modification de la catégorie évènement n° " + id + " a été effectuée avec succès !";
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
            });
            $('.notification-push').remove()
            return false;
        });
        $(document).on('click','.js-load-form-event',function(e){
            e.preventDefault();
            e.stopPropagation();
            var id =parseInt($(this).data('event'))  ;
            EventView.loadForm(calendar.getEventById(id));
        });
        $(document).on('.js-confirm-action',function(){

        });
        $(document).on('click','.blc-img',function(){
            $(".js-btn-loadfile").trigger('click');
        });

        $('#loadFileModal').on('hide.bs.modal', function(e) {
            $('body').addClass('modal-resist-open')
        });
        $('#eventModal').on('hide.bs.modal', function(e) {
            $('body').removeClass('modal-resist-open')

        });


        /*check date format params date and type of format*/
        const isCorrectFormatDate = (dateString, format) => {
            return moment(dateString, format, true).isValid()
        }

        isValidField = (field, type) => {
            switch (type) {
                case 'date':
                    return isCorrectFormatDate(field, 'DD-MM-YYYY HH:mm:ss')
                    break;
                default:
                    return true;
            }
        }

        var DateTimeControl = {
            create: (container, id, label) => {
                var content = "<div class='input-group date' id='" + id + "'>";
                content += " <label for='exampleInputStart'>" + label + "</label>"
                content += "   <input type='text'  name='" + id + "' class='form-control datepicker' required />";
                content += "<span class='input-group-addon'>";
                content += "<span class='fa fa-calendar'></span></span></div>";
                $('.' + container).html(content);
            },
            remove: (id) => {
                $('#' + id).remove();
            }
        }

        /*colorpicker input */
        $(function () {
            $('#color').colorpicker({
                inline: true,
                container: true,
                template: '<div class="colorpicker">' +
                    '<div class="colorpicker-saturation"><i class="colorpicker-guide"></i></div>' +
                    '<div class="colorpicker-hue"><i class="colorpicker-guide"></i></div>' +
                    '<div class="colorpicker-alpha">' +
                    '   <div class="colorpicker-alpha-color"></div>' +
                    '   <i class="colorpicker-guide"></i>' +
                    '</div>' +
                    '<div class="colorpicker-bar">' +
                    '   <div class="input-group">' +
                    '       <input class="form-control input-block color-io" name="color" />' +
                    '   </div>' +
                    '</div>' +
                    '</div>'
            })
                .on('colorpickerCreate', function (e) {
                    // initialize the input on colorpicker creation
                    var io = e.colorpicker.element.find('.color-io');

                    io.val(e.color.string());

                    io.on('change keyup', function () {
                      //  e.colorpicker.setValue(io.val());
                    });
                })
                .on('colorpickerChange', function (e) {
                    var io = e.colorpicker.element.find('.color-io');

                    if (e.value === io.val() || !e.color || !e.color.isValid()) {
                        // do not replace the input value if the color is invalid or equals
                        return;
                    }

                    io.val(e.color.string());
                });
        });
    }
})


    var EventView={
        rowStyle:(row,value)=>{// init style on table event row
            return {classes:row.active==0?'row-inactive':""};
        },
        loadForm: (event) => {
            /*if event is selected we update it in the form*/

            if ($('#date_start').length) {
                $('#date_start').remove();
            }
            if ($('#date_end').length) {
                $('#date_end').remove();
            }

            DateTimeControl.create('startblock', 'date_start', 'Début');
            DateTimeControl.create('endblock', 'date_end', 'Fin');

            var startBloc = "<div class='input-group date' id='date_start'>";
            startBloc += " <label for='exampleInputStart'>Début</label>"
            startBloc += "   <input type='text'  name='date_start' class='form-control' required />";
            startBloc += "<span class='input-group-addon'>";
            startBloc += "<span class='fa fa-calendar'></span></span></div>"

            $('.startblock').html(startBloc);

            var start = new Date();
            var end = new Date();
            $('.blc-img').removeAttr('style');

            if (typeof event != "undefined") {

                start = event.startStr;
                end = event.endStr;

                start = event.start;
                end = event.end;

                $('#date_start').datetimepicker(
                    {
                        locale: 'fr',
                        defaultDate: start,
                        format: 'DD-MM-YYYY HH:mm:ss',
                        useCurrent: false,
                        debug: true,
                    })

                // $('#date_start').datetimepicker('remove');

                $('#date_end').datetimepicker({
                    locale: 'fr',
                    defaultDate: end,
                    format: 'DD-MM-YYYY HH:mm:ss',
                    useCurrent: false,
                    debug: true,

                });
                if(event.id){

                    $("#exampleModalLabel").html(event.title);
                    $("input[name='organizer']").val(event.extendedProps.organizer);
                    $("input[name='adresse']").val(event.extendedProps.organizer);
                    $("input[name='filepath']").val(event.extendedProps.media);
                    $("input[name='url']").val(event.url);
                    $("input[name='link_event']").val(event.link_event);
                    $("input[name='contact']").tagsinput('add', event.extendedProps.contact);
                    $("textarea[name='place']").html(event.extendedProps.place);
                    var eventLangs =event.extendedProps.langs;//charge les valeurs des  champs commun a la traduction
                    $.each(eventLangs,function(k,v){
                        $("#nav-"+v.code).attr('data-event-lang', v.id_event_lang);
                        $("input[name='title-"+v.code+"']").val(v.title);
                        tinymce.get('description-'+v.code).setContent(v.description);
                        $('#cat_event-'+v.code+' option[value="'+v.cat_event+'"]').prop('selected',true);
                    })

                    if(event.extendedProps.media!=''){//check if the image exists


                        urlImg='/assets/uploads/'+event.extendedProps.media;
                        $.get(urlImg)
                            .done(function() {
                                $('.blc-img').css('backgroundImage','url('+urlImg+')');
                            })
                            .fail(function(e) {
                              return false;
                        })

                    }
                    $('#cat_event option[value="'+event.extendedProps.cat_event+'"]').prop('selected',true);

                    var isActive = {
                        on: 'Actif',
                        off: 'Inactif'
                    }
                    if(event.extendedProps.active==0){
                        $('#is_active').bootstrapToggle('off')
                    }else{
                        $('#is_active').bootstrapToggle('on')
                    }
                    document.getElementById('btn-submit-event').setAttribute('data-action', 'update')
                    document.getElementById('form-event').setAttribute('data-id', event.id)
                    var urlYoCall = '/event/'+ event.id+'/update';
                    $("#form-event").attr('action',urlYoCall);

                }else{
                    EventView.resetForm();
                }
            }else{
                EventView.resetForm();
            }


            Global.checkLangFields('event')

            $("#eventModal").modal();
        },
        loadIndex:(row,value)=>{
            return value.id;
        },
        loadAction:(row,value)=>{
            return "<a class='btn btn-warning js-load-form-event' data-event='"+value.id+"'> <i class='fa fa-edit'></i></a> "+
                "<a class='btn btn-danger js-delete-action' data-entity='event' href='/event/"+value.id+"'/delete'><i class='fa fa-trash'></i></a>";
        },
        loadImage:(row,value)=>{
            return "<img style='max-width:100%' src='/assets/uploads/"+value.name+"'/>"
        },
        loadDateStart:(row,value)=>{

           return  moment(value.start,'DD-MM-YYYY HH:mm').format('DD/MM/YYYY HH:mm')
        },
        loadDateEnd:(row,value)=>{
            return moment(value.end,'DD-MM-YYYY HH:mm').format('DD/MM/YYYY HH:mm');
        },
        update:(procedure,listID)=>{//update the fullcalendar
            calendar.refetchEvents();
        },
        resetForm:() => {

            var start = new Date();
            var end = new Date();

            $("#exampleModalLabel").html('Nouvel évènement');
            $("input[name='organizer']").val('');
            $("input[name='adresse']").val('');
            $("input[name='filepath']").val('');
            $("input[name='url']").val('');
            $("input[name='contact']").tagsinput('removeAll');
            $("textarea[name='place']").html('');

            $(".js-lang-version").each(function(k,v){//vide les champs commun aux traduction
                var code = this.id.split('-')[1];
                $("input[name='title-"+code+"']").val('');
                tinymce.get('description-'+code).setContent('');
                $('#cat_event-'+code+' option[value="'+v.cat_event+'"]').removeAttr('selected');
            })

            $('#is_active').bootstrapToggle('on');

            $('#date_start').datetimepicker(
                {
                    locale: 'fr',
                    defaultDate: start,
                    format: 'DD-MM-YYYY HH:mm:ss',
                    useCurrent: false,
                    debug: true,
                })

            $('#date_end').datetimepicker({
                locale: 'fr',
                defaultDate: end,
                format: 'DD-MM-YYYY HH:mm:ss',
            });

            document.getElementById('btn-submit-event').setAttribute('data-action', 'create');
            document.getElementById('form-event').removeAttribute('data-id');
            var urlYoCall = '/event/new';
            $("#form-event").attr('action',urlYoCall);

        }
    }

    var DateTimeControl = {
        create: (container, id, label) => {
            var content = "<div class='input-group date' id='" + id + "'>";
            content += " <label for='exampleInputStart'>" + label + "</label>"
            content += "   <input type='text'  name='" + id + "' class='form-control datepicker' required />";
            content += "<span class='input-group-addon'>";
            content += "<span class='fa fa-calendar'></span></span></div>";
            $('.' + container).html(content);
        },
        remove: (id) => {
            $('#' + id).remove();
        }
    }
