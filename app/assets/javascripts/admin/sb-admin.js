$(function() {

    $('#side-menu').metisMenu();

});

//Loads the correct sidebar on window load,
//collapses the sidebar on window resize.
$(function() {
    $(window).bind("load resize", function() {
        if ($(this).width() < 768) {
            $('div.sidebar-collapse').addClass('collapse')
        } else {
            $('div.sidebar-collapse').removeClass('collapse')
        }
    })

    if ($('#table-listing').length > 0){
        $('#table-listing').dataTable();
    };

    if ($('#enquiry-table').length > 0){
        $('#enquiry-table').dataTable(
            {"order": [[ 2, "desc" ]]}
        );
    };

    if ($('textarea').length > 0) {
        var data = $('textarea');
        $.each(data, function(i) {
            if(data[i].className == 'ckeditor'){
                CKEDITOR.replace(data[i].id);
            }
        });

    }
    if ($('.datepicker').length > 0){
        $('.datepicker').datepicker({
            format: 'yyyy-mm-dd',
            autoclose: true
        });
    }


    // restrict text fields with class num to input only numeric values
    $('body').on('keypress', '.num', function(e){
        var arr = [];
        var key = e.which;

        for (i = 48; i < 58; i++)
            arr.push(i);

        if (!(arr.indexOf(key)>=0))
            e.preventDefault();
    })

    $('.field_with_errors').each(function(index, elem){
        $(elem).addClass('has-error')
    })
    required_fields = $('.required');
    if (required_fields.length > 0){
        required_fields.each(function(idx, val){
            $(val).parent().addClass('test')
        })
    }



    /* type can be either of the ff
     success
     info
     warning
     danger
     */
    $.fn.displayAlert = function(type, msg){
        if(type == ''){
            type = 'success';
        }

        aBox = '<div class="alert alert-' + type + ' alert-dismissable" style="margin-top:15px;">' +
            '<button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>' +
            msg +
            '</div>';
        this.prepend(aBox);
        $('.alert').delay(1000).fadeOut(3000);
    };
})
