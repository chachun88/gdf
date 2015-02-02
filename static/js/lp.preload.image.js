(function($) {

    $.fn.preload_image = function() {

        $(this).each(function()
        {
            var image_src = $(this).attr( "lp-load-big" );
            var _img = $(this);

            var newImg = new Image;

            newImg.onload = function() 
            {
                var new_src = this.src;

                // fadeout animation 
                _img.fadeOut( 250, function()
                {
                    _img.attr("src", new_src);

                    // fadein animation
                    _img.fadeIn( 250, function()
                    {
                        // nothing here
                    });
                });
            }
            newImg.src = image_src;
        });
    };

})(jQuery);