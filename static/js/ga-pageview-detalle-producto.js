// Es necesario crear este js, porque detalle-producto.js se ocupa en muchos lugares
// por lo cual puede ejecutarse aunque no este viendo un producto
$(document).ready(function()
{
    // Obtencion de datos para ga
    var ga_id = $("select#size ").attr("sku");
    var ga_name = $(".producto-nombre-1").html();
    var ga_category = $(".ga-category").html();
    var ga_variant = $(".ga-variant").html();
    var ga_price = $(".ga-price").html();

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

});