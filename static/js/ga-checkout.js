var googleAnalyticsCheckout = function()
{
    $(".carro").each(function()
    {

        var id = $(this).attr("car-id");

        var ga_id = $(".id-" + id).html();
        var ga_name = $(".name-" + id).html();
        var ga_category = $(".category-" + id).html();
        var ga_variant = $(".variant-" + id).html();
        var ga_price = $(".price-" + id).html();
        var ga_quantity = $(".quantity-" + id).html();

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
    ga('ec:setAction','checkout', {
        'step': step,
        // 'option': 'Visa'
    });
    
    ga('send', 'pageview');
};