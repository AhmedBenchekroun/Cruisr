

// ============= PRELOADER SCRIPT ===================

$(window).load(function() { // makes sure the whole site is loaded

	"use strict";
    
    $('#preloader').delay(600).fadeOut('slow'); // will fade out the white DIV that covers the website.
    $('#spinner').fadeOut(); // will first fade out the loading animation
	
})


$(document).ready(function(){
	
	"use strict";
	
	$('a').smoothScroll({offset:50});
	
	new WOW().init();
	
	
    // ============= TIMELINE SLIDER SETTINGS =============
    var owl = $("#timeline-slider");
    owl.owlCarousel({
        items : 3, 
        itemsDesktop : [1400,2], 
        itemsDesktopSmall : [900,1], 
        itemsTablet: [800,1], 
        itemsMobile : [500,1],
		autoPlay : 4000,
		stopOnHover:true
    });
	
	
	// ============= OPINION SLIDER SETTINGS =============
    var owl = $("#opinion-slider");
    owl.owlCarousel({
		  navigation : false, // Show next and prev buttons
		  slideSpeed : 300,
		  paginationSpeed : 400,
		  singleItem:true,
		  autoPlay : 8000,
		  stopOnHover:true
    });
	  
	 
	// ============= GOOGLE MAP SCRIPT =============
	var map;
	var brooklyn = new google.maps.LatLng(40.6743890, -73.9455);
				
	var MY_MAPTYPE_ID = 'custom_style';
				
	function initialize() {
				
		var featureOpts = [
			{
				stylers: [
					{ saturation: -20 },
					{ lightness: 40 },
					{ visibility: 'simplified' },
					{ gamma: 0.8 },
					{ weight: 0.4 }
				]
			},
			{
				elementType: 'labels',
				stylers: [
					{ visibility: 'on' }
				]
			},
			{
				featureType: 'water',
				stylers: [
					{ color: '#dee8ff' }
				]
			}
		];
				
		var mapOptions = {
			zoom: 14,
			scrollwheel: false,
			panControl: false,
			mapTypeControl: false,
  			streetViewControl: false,
			center: new google.maps.LatLng(33.978, -118.1),
			mapTypeControlOptions: {
				mapTypeIds: [google.maps.MapTypeId.ROADMAP, MY_MAPTYPE_ID]
			},
			mapTypeId: MY_MAPTYPE_ID
		};
				
		map = new google.maps.Map(document.getElementById('canvas-map'),mapOptions);
		var image = 'images/point.png';
		var myLatLng = new google.maps.LatLng(33.974, -118.07);
		var beachMarker = new google.maps.Marker({
			position: myLatLng,
			map: map,
			icon: image
		});
		var styledMapOptions = {
			name: 'Custom Style'
		};
				
		var customMapType = new google.maps.StyledMapType(featureOpts, styledMapOptions);
				
		map.mapTypes.set(MY_MAPTYPE_ID, customMapType);
	}
				
	google.maps.event.addDomListener(window, 'load', initialize); 
	
	
	
	// ============= SUBSCRIBE FORM VALIDATIONS SETTINGS ========================  
          
    $('#subscribe_form').validate({
        onfocusout: false,
        onkeyup: false,
        rules: {
            email: {
                required: true,
                email: true
            }
        },
        errorPlacement: function(error, element) {
            error.appendTo( element.closest("form"));
        },
        messages: {
            email: {
                required: "We need your email address to contact you",
                email: "Please, enter a valid email"
            }
        },
					
        highlight: function(element) {
            $(element)
        },                    
					
        success: function(element) {
            element
            .text('').addClass('valid')
        }
    }); 
		
				

// ============= SUBSCRIBE FORM MAILCHIMP INTEGRATIONS SCRIPT ========================  
		
    $('#subscribe_form').submit(function() {
        $('.error').hide();
        $('.error').fadeIn();
        // submit the form
        if($(this).valid()){
            $('#subscribe_submit').button('loading'); 
            var action = $(this).attr('action');
            $.ajax({
                url: action,
                type: 'POST',
                data: {
                    newsletter_email: $('#subscribe_email').val()
                },
                success: function(data) {
                    $('#subscribe_submit').button('reset');
                    $('.error').html(data);
                },
                error: function() {
                    $('#subscribe_submit').button('reset');
                    // Change subscribe form error message text here
                    $('.error').html('Oops! Something went wrong!');
                }
            });
        // return false to prevent normal browser submit and page navigation 
        }
        return false; 
    });
	  
	
	  
// ============= CONTACT FORM VALIDATIONS SETTINGS ======================== 
          
    $('#contact_form').validate({
        onfocusout: false,
        onkeyup: false,
        rules: {
            name: "required",
            phone: "required",
            email: {
                required: true,
                email: true
            }
        },
        errorPlacement: function(error, element) {
            error.insertBefore(element);
        },
        messages: {
            name: "What's your name?",
            phone: "What's your phone number?",
            email: {
                required: "What's your email?",
                email: "Please, enter a valid email"
            }
        },
					
        highlight: function(element) {
            $(element)
            .text('').addClass('error')
        },                    
					
        success: function(element) {
            element
            .text('').addClass('valid')
        }
    });   



// ============= CONTACT FORM SCRIPT ======================== 
 	
    $('#contact_form').submit(function() {
        // submit the form
        if($(this).valid()){
            $('#contact_submit').button('loading'); 
            var action = $(this).attr('action');
            $.ajax({
                url: action,
                type: 'POST',
                data: {
                    contactname: $('#contact_name').val(),
                    contactemail: $('#contact_email').val(),
					contactphone: $('#contact_phone').val(),
                    contactmessage: $('#contact_message').val()
                },
                success: function() {
                    $('#contact_submit').button('reset');
                    $('#contact_submit').button('complete');
                },
                error: function() {
                    $('#contact_submit').button('reset');
                    $('#contact_submit').button('error');
                }
            });
        // return false to prevent normal browser submit and page navigation 
        } else {
            $('#contact_submit').button('reset')
        }
        return false; 
    });	


              

});