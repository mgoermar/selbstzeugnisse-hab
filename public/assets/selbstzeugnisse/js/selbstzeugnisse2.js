/**
 * Prototyp Geovisualisierung
 *
 * Author: David Maus <maus@hab.de>
 * Timestamp: <2017-07-26 11:57:56 maus>
 */

var Karte = (function () {

    // Kenndaten des Kartenausschnitts:
    //
    //   6144 x 4096 Pixel
    //
    //   Nordosten:  77.11  42.08
    //   Südwesten:  31.55 -26.38
    //
    //   Rechteck:   45.56  68.46
    //

    var tilesUrl = "../assets/tiles/{z}/map_{x}_{y}.png";
    var scaleLat = 4096 / 45.56;
    var scaleLon = 6144  / 68.46;

    return {
        // Latitude ist Breitengrad, d.h. Nord-Süd-Position
        // Longitude ist Längengrad, d.h. Ost-West-Position
        project: function (lat, lon) {
            var x = (lon + 26.38) * scaleLon;
            var y = (77.11 - lat) * scaleLat;
            return Karte.map.unproject([x, y]);
        },
        initialize: function () {
            Karte.map = new L.Map('map', { crs: L.CRS.Simple, minZoom: 20, maxZoom: 20, zoomControl: false });
            Karte.layer = new L.TileLayer(tilesUrl, { minZoom: 20, maxZoom: 20, opacity: 0.5 });

            Karte.map.addLayer(Karte.layer);
            Karte.map.setMaxBounds(new L.LatLngBounds(Karte.map.unproject([0, 4096]), Karte.map.unproject([6144, 0])));
            Karte.map.setZoom(20);
        }
    };

})();

function adjust (selector) {
    var nodelist = $(selector);
    var length   = nodelist.size();

    for (var i = 1; i < length; i++) {
        var prev   = $(nodelist.get(i - 1));
        var node   = $(nodelist.get(i));
        var bottom = prev.offset().top + prev.height() + 16;
        if (node.offset().top < bottom) {
            node.offset({ top: bottom });
        }
    }
}

$(document).ready(
    function () {
        $('.js-toggle-sibling').click(
            function (event) {
                $('.fa', this).toggleClass('fa-chevron-right fa-chevron-down');
                $(this).next().toggle();
                event.preventDefault();
            }
        );
        $('a.pagebreak').click(
            function (event) {
                var imageUri = $(this).attr('href');
                $('.facsimile img').attr('src', imageUri);
                $('#facsimile').attr('href', imageUri);
                $('.facsimile').fadeIn();
                event.preventDefault();
            }
        );
        $('a.fa-close').click(
            function (event) {
                $(this).removeClass('visible');
                event.preventDefault();
            }
        );
        $('.ref')
            .click(
                function (event) {
                    var targetUri = $('span.ref-gloss-target').attr('href');
                    $(targetUri).toggleClass('visible');
                    // var targetUri = $('a.annotation-reference', this).attr('href');
                    // $(targetUri).addClass('active');
                }
            );
            
        $('.annotation')
            .mouseenter(
                function (event) {
                    $(this).addClass('active');
                    // var targetUri = $('a.annotation-reference', this).attr('href');
                    // $(targetUri).addClass('active');
                }
            )
            .mouseleave(
                function (event) {
                    $(this).removeClass('active');
                    // var targetUri = $('a.annotation-reference', this).attr('href');
                    // $(targetUri).addClass('active');
                }
            );
         

        $('.navigation-collapse')
            .mouseenter(
                function (event) {
                    $('.margin-left').fadeOut();
                    $('ul', this).fadeIn();
                }
            )
            .mouseleave(
                function (event) {
                    $('.margin-left').fadeIn();
                    $('ul', this).fadeOut();
                }
            )
    }
);
