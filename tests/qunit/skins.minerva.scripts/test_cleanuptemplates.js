( function ( M ) {
	var createBanner = M.require( 'skins.minerva.scripts/cleanuptemplates' ).test.createBanner,
		OverlayManager = M.require( 'mobile.startup/OverlayManager' ),
		overlayManager = new OverlayManager( require( 'mediawiki.router' ) ),
		$mockContainer = $(
			'<div id=\'bodyContent\'>' +
				'<table class=\'ambox ambox-content\'>' +
					'<tbody class=\'mbox-text\'>' +
						'<tr><td><span class=\'mbox-text-span\'> ambox text span </span></td></tr>' +
					'</tbody>' +
				'</table>' +
			'</div>'
		),
		labelText = 'label text',
		section = 0,
		inline = true,
		processedAmbox = createBanner( $mockContainer, labelText, section, inline, overlayManager );

	QUnit.module( 'Minerva cleanuptemplates' );

	QUnit.test( 'createBanner() should add a "learn more" message', function ( assert ) {
		assert.strictEqual( /⧼skin-minerva-issue-learn-more⧽/.test( processedAmbox.html() ), true );
	} );

	QUnit.test( 'createBanner() should add an icon', function ( assert ) {
		assert.strictEqual( /mw-ui-icon/.test( processedAmbox.html() ), true );
	} );
	QUnit.test( 'clicking on the product of createBanner() should trigger a URL change', function ( assert ) {
		processedAmbox.click();
		assert.strictEqual( window.location.hash, '#/issues/0' );
	} );

}( mw.mobileFrontend ) );