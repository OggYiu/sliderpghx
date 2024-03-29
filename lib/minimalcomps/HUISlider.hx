/**
 * HUISlider.as
 * Keith Peters
 * version 0.97
 * 
 * A Horizontal slider with a label and a value label.
 * 
 * Copyright (c) 2009 Keith Peters
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */
 
package minimalcomps;

import nme.display.DisplayObjectContainer;
import nme.events.Event;
// import flash.display.DisplayObjectContainer;
// import flash.events.Event;

class HUISlider extends UISlider {
			
	/**
	 * Constructor
	 * @param parent The parent DisplayObjectContainer on which to add this HUISlider.
	 * @param xpos The x position to place this component.
	 * @param ypos The y position to place this component.
	 * @param label The string to use as the label for this component.
	 * @param defaultHandler The event handling function to handle the default event for this component.
	 */
	public function new(?parent:Dynamic = null, ?x:Float = 0, ?y:Float = 0, ?label:String = "", ?defaultEventHandler:Dynamic = null) {
		_sliderClass = HSlider;
		super(parent, x, y, label, defaultEventHandler);
	}
	
	/**
	 * Initializes the component.
	 */
	override function init() {
		super.init();
		setSize(200, 18);
	}
	
	/**
	 * Centers the label when label text is changed.
	 */
	override function positionLabel() {
		_valueLabel.x = _slider.x + _slider.width + 5;
	}
	
	
	
	
	///////////////////////////////////
	// public methods
	///////////////////////////////////
	
	/**
	 * Draws the visual ui of this component.
	 */
	public override function draw() {
		super.draw();
		_slider.x = _label.width + 5;
		_slider.y = height / 2 - _slider.height / 2;
		_slider.width = width - _label.width - 50 - 10;
		
		_valueLabel.x = _slider.x + _slider.width + 5;
	}
	
	///////////////////////////////////
	// event handlers
	///////////////////////////////////
	
	///////////////////////////////////
	// getter/setters
	///////////////////////////////////
	
}
