var googleAnalyticsCheckout = function()
{
    $(".carro").each(function()
    {

        var id = $(this).attr("car-id");

        var ga_id = $(".id-" + id).html();
        alert(ga_id);
        var ga_name = $(".name-" + id).html();
        alert(ga_name);
        var ga_category = $(".category-" + id).html();
        alert(ga_category);
        var ga_variant = $(".variant-" + id).html();
        alert(ga_variant);
        var ga_price = $(".price-" + id).html();
        alert(ga_price);
        var ga_quantity = $(".quantity-" + id).html();
        alert(ga_quantity);

        ga('ec:addProduct', {
            'id': ga_id,
            'name': ga_name,
            'brand': 'Giani Da Firenze',
            'category': ga_category,
            'variant': ga_variant,
            'price': ga_price,
            'quantity': ga_quantity,
            // 'coupon': 'SUMMER2013',
            // 'position': 1
        });
    });

    var step = $(".numero-checkout").html();
alert(step);
    ga('ec:setAction','checkout', {
        'step': step,
        // 'option': 'Visa'
    });
    
    ga('send', 'pageview');
};