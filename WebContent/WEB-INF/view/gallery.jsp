<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>	
<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Facetoday Gallery</title>
        <meta charset="UTF-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"> 
        <meta name="viewport" content="width=device-width, initial-scale=1.0"> 
        <meta name="description" content="Draggable Image Boxes Grid" />
        <meta name="keywords" content="images, boxes, template, thumbnail, css3, transition, jquery, template, fullscreen, grid, draggable" />
        <meta name="author" content="Codrops" />
        <link rel="shortcut icon" href="../favicon.ico"> 
        <link rel="stylesheet" type="text/css" href="css/style.css" />
		<noscript>
			<style>
				.ib-main a{
					cursor:pointer;
				}
				.ib-main-wrapper{
					position:absolute;
					top:0px;
					bottom:24px;
					overflow:scroll;
				}
			</style>
		</noscript>
		<link href="css/bootstrap.min.css" rel="stylesheet">
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
		<script src="http://malsup.github.com/jquery.form.js"></script>
		
        <link href='http://fonts.googleapis.com/css?family=Oswald' rel='stylesheet' type='text/css' />
		<script id="previewTmpl" type="text/x-jquery-tmpl">
			<div id="ib-img-preview" class="ib-preview">
                <img src="${src}" alt="" class="ib-preview-img"/>
                <span class="ib-preview-descr" style="display:none;">${description}</span>
                <div class="ib-nav" style="display:none;">
                    <span class="ib-nav-prev">Previous</span>
                    <span class="ib-nav-next">Next</span>
                </div>
                <span class="ib-close" style="display:none;">Close Preview</span>
                <div class="ib-loading-large" style="display:none;">Loading...</div>
            </div>		
		</script>
		<script id="contentTmpl" type="text/x-jquery-tmpl">	
			<div id="ib-content-preview" class="ib-content-preview">
                <div class="ib-teaser" style="display:none;">{{html teaser}}</div>
                <div class="ib-content-full" style="display:none;">{{html content}}</div>
                <span class="ib-close" style="display:none;">Close Preview</span>
            </div>
		</script>	
    </head>
 <body>
    <!-- upload modal -->
	<div class="modal fade" id="upload" tabindex="-1">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-body">
					<form id="UploadForm" action="upload.do" method="post" enctype="multipart/form-data">
						<div class="form-group">
							<input type="hidden" name="email" id="email" value="${sessionScope.userInfo.email}">
							<input type="hidden" name="social" id="social" value="${sessionScope.userInfo.social}">
							<input type="file" name="file" id="imgInp">
							<img id="screenModal" src="" class="img-responsive img-rounded">
						</div>
						<div class='modal-footer'>
							<input type="submit" class="btn btn-success" value="확인"/>
						</div>
						
					</form>
				</div>
			</div>
		</div>
	</div>
        
        <div class="container">
            <div id="header" class="header">
                <a href="javascript:history.back()"><span>&laquo; 뒤로 가기 </span>Go to BACK</a>
                <span class="right_ab">
					<a data-toggle='modal' data-target='#upload'><strong>갤러리에 사진 올리기</strong></a>
                </span>
            </div>
            <div id="ib-top" class="ib-top">
            </div>
            <div id="ib-main-wrapper" class="ib-main-wrapper">
                <div class="ib-main">
                	<a href="#" class="ib-content">
                        <div class="ib-teaser">
                            <h2>Welcome <span>FACETODAY DRAGGALE GALLERY</span></h2>
                        </div>
                        <div class="ib-content-full">
                            <p style="font: white;">페이스투데이 갤러리에 오신 걸 환영합니다.</p>
                            <p style="font: white;">사진을 선택 후 순서대로 보실 수 있지만 사진을 끌어 이동이 가능합니다!</p>
                            <p style="font: white;">사진을 많이 올릴수록 보기 좋아요! 팍팍 올려주세요.</p>
                            <p style="font: white;">구럼 빠잉!</p>
                        </div>
                    </a>
                	<c:forEach items="${list}" var="e">
                		<a href="#"><img src="http://localhost:9000/projectSpring/facetodayDB/${e.image}" data-largesrc="http://localhost:9000/projectSpring/facetodayDB/${e.image}"/></a>
                	</c:forEach>
					<div class="clr"></div>
				</div><!-- ib-main -->
            </div><!-- ib-main-wrapper -->
        </div>
		<script type="text/javascript" src="js/jquery.tmpl.min.js"></script>
        <script type="text/javascript" src="js/jquery.kinetic.js"></script>
		<script type="text/javascript" src="js/jquery.easing.1.3.js"></script>
        <script type="text/javascript">
	        $(function(){
				$('#UploadForm').ajaxForm({
					success: function(data){
						$('#upload').modal('hide');
				    }
				});
			});
            $(function() {
			
				var $ibWrapper	= $('#ib-main-wrapper'),
				 
					Template	= (function() {
							
							// true if dragging the container
						var kinetic_moving				= false,
							// current index of the opened item
							current						= -1,
							// true if the item is being opened / closed
							isAnimating					= false,
							// items on the grid
							$ibItems					= $ibWrapper.find('div.ib-main > a'),
							// image items on the grid
							$ibImgItems					= $ibItems.not('.ib-content'),
							// total image items on the grid
							imgItemsCount				= $ibImgItems.length,
							init						= function() {
								
								// add a class ib-image to the image items
								$ibImgItems.addClass('ib-image');
								// apply the kinetic plugin to the wrapper
								loadKinetic();
								// load some events
								initEvents();
						
							},
							loadKinetic					= function() {
								
								setWrapperSize();
								
								$ibWrapper.kinetic({
									moved	: function() {
										
										kinetic_moving = true;
										
									},
									stopped	: function() {
										
										kinetic_moving = false;
										
									}
								});
								
							},
							setWrapperSize				= function() {
								
								var containerMargins	= $('#ib-top').outerHeight(true) + $('#header').outerHeight(true) + parseFloat( $ibItems.css('margin-top') );
								$ibWrapper.css( 'height', $(window).height() - containerMargins )
								
							},
							initEvents					= function() {
							
								// open the item only if not dragging the container
								$ibItems.bind('click.ibTemplate', function( event ) {
									
									if( !kinetic_moving )
										openItem( $(this) );
								
									return false;	
								
								});
								
								// on window resize, set the wrapper and preview size accordingly
								$(window).bind('resize.ibTemplate', function( event ) {
									
									setWrapperSize();
									
									$('#ib-img-preview, #ib-content-preview').css({
										width	: $(window).width(),
										height	: $(window).height()
									})
									
								});
							
							},
							openItem					= function( $item ) {
								
								if( isAnimating ) return false;
								
								// if content item
								if( $item.hasClass('ib-content') ) {
									
									isAnimating	= true;
									current	= $item.index('.ib-content');
									loadContentItem( $item, function() { isAnimating = false; } );
									
								}
								// if image item
								else {
								
									isAnimating	= true;
									current	= $item.index('.ib-image');
									loadImgPreview( $item, function() { isAnimating = false; } );
									
								}
								
							},
							// opens one image item (fullscreen)
							loadImgPreview				= function( $item, callback ) {
								
								var largeSrc		= $item.children('img').data('largesrc'),
									description		= $item.children('span').text(),
									largeImageData	= {
										src			: largeSrc,
										description	: description
									};
								
								// preload large image
								$item.addClass('ib-loading');
								
								preloadImage( largeSrc, function() {
									
									$item.removeClass('ib-loading');
									
									var hasImgPreview	= ( $('#ib-img-preview').length > 0 );
									
									if( !hasImgPreview )
										$('#previewTmpl').tmpl( largeImageData ).insertAfter( $ibWrapper );
									else
										$('#ib-img-preview').children('img.ib-preview-img')
															.attr( 'src', largeSrc )
															.end()
															.find('span.ib-preview-descr')
															.text( description );
										
									//get dimentions for the image, based on the windows size
									var	dim	= getImageDim( largeSrc );
									
									$item.removeClass('ib-img-loading');
									
									//set the returned values and show/animate preview
									$('#ib-img-preview').css({
										width	: $item.width(),
										height	: $item.height(),
										left	: $item.offset().left,
										top		: $item.offset().top
									}).children('img.ib-preview-img').hide().css({
										width	: dim.width,
										height	: dim.height,
										left	: dim.left,
										top		: dim.top
									}).fadeIn( 400 ).end().show().animate({
										width	: $(window).width(),
										left	: 0
									}, 500, 'easeOutExpo', function() {
									
										$(this).animate({
											height	: $(window).height(),
											top		: 0
										}, 400, function() {
										
											var $this	= $(this);
											$this.find('span.ib-preview-descr, span.ib-close').show()
											if( imgItemsCount > 1 )
												$this.find('div.ib-nav').show();
												
											if( callback ) callback.call();
										
										});
									
									});
									
									if( !hasImgPreview )
										initImgPreviewEvents();
									
								} );
								
							},
							// opens one content item (fullscreen)
							loadContentItem				= function( $item, callback ) {
								
								var hasContentPreview	= ( $('#ib-content-preview').length > 0 ),
									teaser				= $item.children('div.ib-teaser').html(),
									content				= $item.children('div.ib-content-full').html(),
									contentData			= {
										teaser		: teaser,
										content		: content
									};
									
								if( !hasContentPreview )
									$('#contentTmpl').tmpl( contentData ).insertAfter( $ibWrapper );
									
								//set the returned values and show/animate preview
								$('#ib-content-preview').css({
									width	: $item.width(),
									height	: $item.height(),
									left	: $item.offset().left,
									top		: $item.offset().top
								}).show().animate({
									width	: $(window).width(),
									left	: 0
								}, 500, 'easeOutExpo', function() {
								
									$(this).animate({
										height	: $(window).height(),
										top		: 0
									}, 400, function() {
										
										var $this	= $(this),
											$teaser	= $this.find('div.ib-teaser'),
											$content= $this.find('div.ib-content-full'),
											$close	= $this.find('span.ib-close');
											
										if( hasContentPreview ) {
											$teaser.html( teaser )
											$content.html( content )
										}
									
										$teaser.show();
										$content.show();
										$close.show();
										
										if( callback ) callback.call();
									
									});
								
								});
								
								if( !hasContentPreview )
									initContentPreviewEvents();	
								
							},
							// preloads an image
							preloadImage				= function( src, callback ) {
							
								$('<img/>').load(function(){
								
									if( callback ) callback.call();
								
								}).attr( 'src', src );
							
							},
							// load the events for the image preview : navigation ,close button, and window resize
							initImgPreviewEvents		= function() {
							
								var $preview	= $('#ib-img-preview');
								
								$preview.find('span.ib-nav-prev').bind('click.ibTemplate', function( event ) {
									
									navigate( 'prev' );
									
								}).end().find('span.ib-nav-next').bind('click.ibTemplate', function( event ) {
									
									navigate( 'next' );
									
								}).end().find('span.ib-close').bind('click.ibTemplate', function( event ) {
									
									closeImgPreview();
									
								});
								
								//resizing the window resizes the preview image
								$(window).bind('resize.ibTemplate', function( event ) {
									
									var $largeImg	= $preview.children('img.ib-preview-img'),
										dim			= getImageDim( $largeImg.attr('src') );
									
									$largeImg.css({
										width	: dim.width,
										height	: dim.height,
										left	: dim.left,
										top		: dim.top
									})
									
								});
								
							},
							// load the events for the content preview : close button
							initContentPreviewEvents	= function() {
							
								$('#ib-content-preview').find('span.ib-close').bind('click.ibTemplate', function( event ) {
									
									closeContentPreview();
									
								});
								
							},
							// navigate the image items in fullscreen mode
							navigate					= function( dir ) {
								
								if( isAnimating ) return false;
								
								isAnimating		= true;
								
								var $preview	= $('#ib-img-preview'),
									$loading	= $preview.find('div.ib-loading-large');
								
								$loading.show();
								
								if( dir === 'next' ) {
									
									( current === imgItemsCount - 1 ) ? current	= 0 : ++current;
									
								}
								else if( dir === 'prev' ) {
									
									( current === 0 ) ? current	= imgItemsCount - 1 : --current;
									
								}
								
								var $item		= $ibImgItems.eq( current ),
									largeSrc	= $item.children('img').data('largesrc'),
									description	= $item.children('span').text();
									
								preloadImage( largeSrc, function() {
									
									$loading.hide();
									
									//get dimentions for the image, based on the windows size
									var	dim	= getImageDim( largeSrc );
									
									$preview.children('img.ib-preview-img')
												    .attr( 'src', largeSrc )
													.css({
										width	: dim.width,
										height	: dim.height,
										left	: dim.left,
										top		: dim.top
													})
													.end()
													.find('span.ib-preview-descr')
													.text( description );
									
									$ibWrapper.scrollTop( $item.offset().top )
											  .scrollLeft( $item.offset().left );
									
									isAnimating	= false;
									
								});
								
							},
							// closes the fullscreen image item
							closeImgPreview				= function() {
							
								if( isAnimating ) return false;
								
								isAnimating	= true;
								
								var $item	= $ibImgItems.eq( current );
								
								$('#ib-img-preview').find('span.ib-preview-descr, div.ib-nav, span.ib-close')
												.hide()
												.end()
												.animate({
													height	: $item.height(),
													top		: $item.offset().top
													}, 500, 'easeOutExpo', function() {
													
													$(this).animate({
														width	: $item.width(),
														left	: $item.offset().left
														}, 400, function() {
														
															$(this).fadeOut(function() {isAnimating	= false;});
														
													} );
												
												});
							
							},
							// closes the fullscreen content item
							closeContentPreview			= function() {
								
								if( isAnimating ) return false;
								
								isAnimating	= true;
								
								var $item	= $ibItems.not('.ib-image').eq( current );
								
								$('#ib-content-preview').find('div.ib-teaser, div.ib-content-full, span.ib-close')
														.hide()
														.end()
														.animate({
															height	: $item.height(),
															top		: $item.offset().top
														}, 500, 'easeOutExpo', function() {
															
															$(this).animate({
																width	: $item.width(),
																left	: $item.offset().left
															}, 400, function() {
																
																$(this).fadeOut(function() {isAnimating	= false;});
																
															} );
														
														});
							
							},
							// get the size of one image to make it full size and centered
							getImageDim					= function( src ) {
								
								var img     	= new Image();
								img.src     	= src;
								
								var w_w	= $(window).width(),
									w_h	= $(window).height(),
									r_w	= w_h / w_w,
									i_w	= img.width,
									i_h	= img.height,
									r_i	= i_h / i_w,
									new_w, new_h,
									new_left, new_top;
								
								if( r_w > r_i ) {
								
									new_h	= w_h;
									new_w	= w_h / r_i;
								
								}	
								else {
								
									new_h	= w_w * r_i;
									new_w	= w_w;
								
								}
								
								return {
									width	: new_w,
									height	: new_h,
									left	: (w_w - new_w) / 2,
									top		: (w_h - new_h) / 2
								};
							
							};
						
						return { init : init };
						
					})();
				
				Template.init();
				
            });
        </script>
        <script src="resource/js/bootstrap.min.js"></script> 
    </body>
</html>	