(function($, window, document, undefined) {

    // Create the defaults once
    var pluginName = 'countries';

    /*    // The actual plugin constructor
    function Plugin( element, options ) 
    {
        this.element = element;

        this.options = $.extend( {}, defaults, options);
        this.element.callback = this.options.callback;
        
        this._defaults = defaults;
        this._name = pluginName;
        
        this.init();
    }

    Plugin.prototype.init = function () 
    {
        // Place initialization logic here
        // You already have access to the DOM element and
        // the options via the instance, e.g. this.element 
        // and this.options

        this.element.callback( this.o );
    };
*/
    // A really lightweight plugin wrapper around the constructor, 
    // preventing against multiple instantiations
    $.fn[pluginName] = function(options) {
        return this.each(function() {
            if (!$.data(this, 'plugin_' + pluginName)) {
                $.data(this, 'plugin_' + pluginName,
                    new Cities(this, options));
            }
        });
    };

})(jQuery, window, document); // jshint ignore: line


var Cities = function(element, options) {

    defaults = {
        city_selector: '.cities',
        town_selector: '.town',
        callback: function(user) {
            alert("esta llamando al kjsdsakj");
        } // jshint ignore: line
    };

    this.options = $.extend(this, defaults, options);
    this.element = element;

    this.init();
}

Cities.prototype.init = function() {
    var self = this;
    var cities = this.fillStates();

    $(this.element).change(function() {
        self.fillCities($(this).val());
    });

    $(self.options.city_selector).change(function(){
        self.fillTowns($(this).val());
    });
};

Cities.prototype.fillStates = function() {
    var self = this;

    $(self.options.city_selector).empty();
    $(self.options.town_selector).empty();

    $.getJSON("/static/json/regiones.json", function(data) {
        $.each(data, function(key, val) {
            $(self.element).append('<option value="' + val.id + '">' + val.name + '</option>');
        });
        $(self.element).trigger("change");
    });
};

Cities.prototype.fillCities = function(id_region) {

    var self = this;

    $.getJSON("/static/json/provincias.json", function(data) {

        $(self.options.city_selector).empty();
        $(self.options.town_selector).empty();

        $.each(data, function(key, val) {

            if (val.region_id == id_region) {
                $(self.options.city_selector).append('<option value="' + val.id + '">' + val.name + '</option>');
            }
        });

        $(self.options.city_selector).trigger("change");
    });
}

Cities.prototype.fillTowns = function(id_provincia) {

    var self = this;

    $.getJSON("/static/json/comunas.json", function(data) {
        $(self.options.town_selector).empty();

        $.each(data, function(key, val) {

            if (val.provincia_id == id_provincia) {
                $(self.options.town_selector).append('<option value="' + val.id + '">' + val.name + '</option>');
            }
        });
    });
}