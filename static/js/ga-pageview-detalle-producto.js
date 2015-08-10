// Es necesario crear este js, porque detalle-producto.js se ocupa en muchos lugares
// por lo cual puede ejecutarse aunque no este viendo un producto
$(document).ready(function()
{
    if ( document.location.href.indexOf("gianidafirenze.cl") != -1) {
        // Obtencion de datos para ga
        var datos_analytics = $("div.datos-analytic");
        var ga_id = $(".ga-id", datos_analytics).html();
        var ga_name = $(".ga-name", datos_analytics).html();
        var ga_category = $(".ga-category", datos_analytics).html();
        var ga_variant = $(".ga-variant", datos_analytics).html();
        var ga_price = $(".ga-price", datos_analytics).html();

        ga('ec:addProduct', {
            'id': ga_id,
            'name': ga_name,
            'brand': 'Giani Da Firenze',
            'category': ga_category,
            'variant': ga_variant,
            'price': ga_price,
            // 'quantity': ga_quantity,
            // 'coupon': 'SUMMER2013',
            // 'position': 1
        });

        ga('ec:setAction', 'detail');

        ga('send', 'pageview');

        console.log("send page view detalle producto");
    }
});