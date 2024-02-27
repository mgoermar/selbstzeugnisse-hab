function Infopanel (contextSelector)
{
    var panels = {};
    var active = undefined;

    return {
        context: function () { return contextSelector; },
        register: function (ident, selector) {
            panels[ident] = $(selector);
        },
        activate: function (ident) {
            if (active === ident) {
                return;
            }
            if (active) {
                panels[active].hide();
            }
            panels[ident].show();
            active = ident;
        }
    };
}

var infopanel = new Infopanel ('#infopanel');

$(document).ready(
    function () {

        var path = [];
        var places = {};
        var events = [];
        var eventMarker;

        infopanel.register('facsimile', '#facsimile');
        infopanel.register('map', '#map');

        function showFacsimile (e) {

            infopanel.activate('facsimile');

            $('img.facsimile').attr('src', this.href);
            $('#facsimile a.facsimile').attr('href', this.href);

            $('#facsimile').trigger('zoom.destroy');
            $('#facsimile').zoom({ magnify: 0.5 });

            e.preventDefault();
            return false;
        }

        function collectEvents () {
            var prevPlace;

            $('.event').each(
                function (undefined, element) {
                    var event = $(element).data();

                    event.element = element;
                    event.geo = Karte.project(event.lat, event.long);

                    if (places[event.where]) {
                    } else {
                        places[event.where] = L.circleMarker(event.geo,
                                                             { opacity: 0.75, stroke: false, fillOpacity: 0.75, fillColor: 'teal', radius: 5 }
                                                            ).bindTooltip(event.place);
                        places[event.where].__element = element;
                        places[event.where].on('click', scrollToEvent);
                        places[event.where].addTo(Karte.map);

                        path.push(event.geo);
                        prevPlace = event.where;
                    }
                    events.push(event);
                }
            );
        }

        function scrollToEvent (e) {
            var target = '#' + this.__element.id;

            $('body').animate({ scrollTop: $(target).offset().top - 150 }, 500, function () { $(target).effect({ effect: 'pulsate', duration: 1000 }); });
            $('a.map', target).click();

            return false;
        }

        function showEvent (e) {
            var data = $(this).closest('.event').data();
            var geo  = Karte.project(data.lat, data.long);

            infopanel.activate('map');
            Karte.map.panTo(geo, { animate: false });
            if (eventMarker === undefined) {
                eventMarker = L.marker(geo).bindTooltip(data.label, { permanent: true }).addTo(Karte.map);
            } else {
                eventMarker.closeTooltip();
                eventMarker.setLatLng(geo);
                eventMarker.setTooltipContent(data.label);
                eventMarker.update();
                eventMarker.openTooltip();
            }

            e.preventDefault();
            return false;
        }

        Karte.initialize();
        Karte.map.setView(Karte.project(48.75, 8.25));

        $('a.facsimile').click(showFacsimile);
        $('a.map').click(showEvent);

        collectEvents();
        L.polyline(
            path,
            { color: 'teal', weight: 2, opacity: .75, dashArray: '5, 5' }
        ).addTo(Karte.map);

        infopanel.activate('map');
    }
);
