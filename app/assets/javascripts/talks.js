//= require jquery.ui.datepicker
//= require jquery.ui.datepicker-pt-BR
//= require jquery_nested_form
//= require bootstrap-wysihtml5
//= require bootstrap-wysihtml5/locales/pt-BR
//= require speakingurl.min

var UTIL = {
  slugAvailable: function() {
    var $slug = $('.js-talk-slug');
    var slubVal = $slug.val();

    if (slubVal.length >= 3) {
      $.getJSON('/slug_available', { slug: slubVal }, function(data) {
        var $availabilityLabel = $('#js-talk-slug-availability-label').show();
        if (data["status"]) {
          $availabilityLabel
            .addClass("label-important")
            .removeClass("label-success")
            .text('Indisponível');
        } else {
          $availabilityLabel
            .addClass("label-success")
            .removeClass("label-important")
            .text('Disponível');
        }
      });
    }
  }
};

$(document)
  .on('page:load', function() {
    window['rangy'].initialized = false;
  })
  .on('keyup', '.js-talk-title', function() {
    var titleVal = $(this).val();
    var $slug = $('.js-talk-slug');

    $slug.val(getSlug(titleVal));
  })
  .on('focusout', '.js-talk-slug', function() {
    var $slug = $(this);

    $slug.val(getSlug($slug.val()));
    UTIL.slugAvailable();
  })
  .on('focusout', '.js-talk-title', function() {
    UTIL.slugAvailable();
  })
  .on('page:change', function() {
    $('.wysihtml5').each(function(i, elem) {
      $(elem).wysihtml5({locale: "pt-BR"});
    });

    $('.datepicker').datepicker({ minDate: "0d" });

    // Copiar link da palestra.
    var $copyLink = $('#js-copy-talk-link');
    if ($copyLink.length) {
      var _defaults = {
        title: 'Copiar',
        copiedHint: 'Copiado!'
      };

      var clip = new ZeroClipboard($copyLink);
      var $bridge = $('#global-zeroclipboard-html-bridge');

      clip
        .on('load', function(client) {
          $bridge.tooltip({ title: _defaults.title });
        })
        .on('complete', function(client, args) {
          $bridge
            .attr('data-original-title', _defaults.copiedHint)
            .tooltip('show');
        })
        .on('noflash wrongflash', function(client) {
          $copyLink.hide();
        });
    }
  });
