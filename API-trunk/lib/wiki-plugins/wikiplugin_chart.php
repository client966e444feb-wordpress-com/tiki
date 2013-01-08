<?php
// (c) Copyright 2002-2013 by authors of the Tiki Wiki CMS Groupware Project
//
// All Rights Reserved. See copyright.txt for details and a complete list of authors.
// Licensed under the GNU LESSER GENERAL PUBLIC LICENSE. See license.txt for details.
// $Id$

function wikiplugin_chart_info()
{
	return array(
		'name' => tra('Chart'),
		'documentation' => 'PluginChart',
		'description' => tra('Display a chart from TikiSheet'),
		'prefs' => array( 'feature_sheet', 'wikiplugin_chart' ),
		'icon' => 'img/icons/chart_curve.png',
		'body' => tra('Chart caption.'),
		'params' => array(
			'id' => array(
				'required' => true,
				'name' => tra('Sheet ID'),
				'description' => tra('Data sheet ID'),
			),
			'type' => array(
				'required' => true,
				'name' => tra('Chart Type'),
				'description' => 'BarStackGraphic | MultibarGraphic | MultilineGraphic | PieChartGraphic', // Removed translation call since these are all system names. TODO: Make an actual English sentence from this
			),
			'width' => array(
				'required' => true,
				'name' => tra('Chart Width'),
				'description' => tra('Width in pixels.'),
			),
			'height' => array(
				'required' => true,
				'name' => tra('Chart Height'),
				'description' => tra('Height in pixels.'),
			),
			'value' => array(
				'required' => false,
				'name' => tra('Value series'),
				'description' => tra('Required for pie charts'),
			),
			'x' => array(
				'required' => false,
				'name' => tra('Independant series'),
				'description' => tra('Required for types other than pie chart'),
			),
			'y0' => array(
				'required' => false,
				'name' => tra('Dependant series'),
				'description' => tra('Required for types other than pie chart'),
			),
			'y1' => array(
				'required' => false,
				'name' => tra('Dependant series'),
				'description' => tra('Description needed'),
			),
			'y2' => array(
				'required' => false,
				'name' => tra('Dependant series'),
				'description' => tra('Description needed'),
			),
			'y3' => array(
				'required' => false,
				'name' => tra('Dependant series'),
				'description' => tra('Description needed'),
			),
			'y4' => array(
				'required' => false,
				'name' => tra('Dependant series'),
				'description' => tra('Description needed'),
			),
			'color' => array(
				'required' => false,
				'name' => tra('Colors'),
				'description' => tra('List of colors to use.'),
			),
			'style' => array(
				'required' => false,
				'name' => tra('Styles'),
				'description' => tra('List of styles to use.'),
			),
			'label' => array(
				'required' => false,
				'name' => tra('Labels'),
				'description' => tra('Labels for the series or values in the legend.'),
			),
		),
	);
}

function wikiplugin_chart($data, $params)
{
	extract($params, EXTR_SKIP);

	if (!isset($id))
		return ("<b>missing id parameter for plugin</b><br />");

	if (!isset($type))
		return ("<b>missing type parameter for plugin</b><br />");

	$params = array( "sheetId" => $id, "graphic" => $type, "title" => $data );
	switch( $type ) {
		case 'PieChartGraphic':
			if ( !isset( $value ) ) {
				return "<b>missing value parameter for plugin</b><br />";
			}

			$params['series[value]'] = $value;
	    	break;

	default:
		$params['independant'] = isset( $independant ) ? $independant : 'horizontal';
		$params['horizontal'] = isset( $horizontal ) ? $horizontal : 'bottom';
		$params['vertical'] = isset( $vertical ) ? $vertical : 'left';

		if ( !isset( $x ) ) {
			return "<b>missing x parameter for plugin</b><br />";
		}

		$params['series[x]'] = $x;

		for ( $i = 0; isset( ${'y' . $i} ); $i++ ) {
			$params['series[y' . $i . ']'] = ${'y' . $i};
		}

    	break;
	}

	$params['series[color]'] = isset( $color ) ? $color : '';
	$params['series[style]'] = isset( $style ) ? $style : '';
	$params['series[label]'] = isset( $label ) ? $label : '';

	if ( function_exists('imagepng') ) {
		if ( !isset($width) )
			return "<b>missing width parameter for plugin</b><br />";
		if ( !isset($height) )
			return "<b>missing height parameter for plugin</b><br />";

		$params['width'] = $width;
		$params['height'] = $height;

		$disp = '<img src="' . _wikiplugin_chart_uri($params, 'PNG') . '"/>';
	} elseif ( function_exists('image_jpeg') ) {
		if ( !isset( $width ) )
			return "<b>missing width parameter for plugin</b><br />";
		if ( !isset( $height ) )
			return "<b>missing height parameter for plugin</b><br />";

		$params['width'] = $width;
		$params['height'] = $height;

		$disp = '<img src="' . _wikiplugin_chart_uri($params, 'JPEG') . '"/>';
	}
	elseif ( function_exists('pdf_new') )
		$disp = tra("Chart as PDF");
	elseif ( function_exists('ps_new') )
		$disp = tra("Chart as PostScript");
	else
		return "<b>no valid renderer for plugin</b><br />";

	if ( function_exists('pdf_new') ) {
		$params['format'] = isset( $format ) ? $format : 'A4';
		$params['orientation'] = isset( $orientation ) ? $orientation : 'landscape';

		$disp = '<a href="' . _wikiplugin_chart_uri($params, 'PDF') . '">' . $disp . '</a>';
	} elseif ( function_exists('ps_new') ) {
		$params['format'] = isset( $format ) ? $format : 'A4';
		$params['orientation'] = isset( $orientation ) ? $orientation : 'landscape';

		$disp = '<a href="' . _wikiplugin_chart_uri($params, 'PS') . '">' . $disp . '</a>';
	}

	return $disp;
}

function _wikiplugin_chart_uri( $params, $renderer )
{
	$params['renderer'] = $renderer;
	$array = array();
	foreach ( $params as $key => $value )
		$array[] = rawurlencode($key) . '=' . rawurlencode($value);

	return 'tiki-graph_sheet.php?' . implode('&', $array);
}
