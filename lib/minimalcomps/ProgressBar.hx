/**
 * ProgressBar.as
 * Keith Peters
 * version 0.97
 * 
 * A progress bar component for showing a changing value in relation to a total.
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
import nme.display.Sprite;
// import flash.display.DisplayObjectContainer;
// import flash.display.Sprite;

class ProgressBar extends Component {
	
	public var maximum(getMaximum, setMaximum) : Float;
	public var value(getValue, setValue) : Float;
	public var backgroundColor( default, default ) : Int = Style.BACKGROUND;
	public var barColor( default, default ) : Int = Style.PROGRESS_BAR;
	var _back:Sprite;
	var _bar:Sprite;
	var _value:Float;
	var _max:Float;

	/**
	 * Constructor
	 * @param parent The parent DisplayObjectContainer on which to add this ProgressBar.
	 * @param xpos The x position to place this component.
	 * @param ypos The y position to place this component.
	 */
	public function new(?parent:Dynamic = null, ?xpos:Float = 0, ?ypos:Float =  0) {
		_value = 0;
		_max = 1;
		super(parent, xpos, ypos);
	}
	
	
	/**
	 * Initializes the component.
	 */
	override function init() {
		super.init();
		setSize(100, 10);
	}
	
	/**
	 * Creates and adds the child display objects of this component.
	 */
	override function addChildren() {
		_back = new Sprite();
		_back.filters = [getShadow(2, true)];
		addChild(_back);
		
		_bar = new Sprite();
		_bar.x = 1;
		_bar.y = 1;
		_bar.filters = [getShadow(1)];
		addChild(_bar);
	}
	
	/**
	 * Updates the size of the progress bar based on the current value.
	 */
	function update() {
		_bar.scaleX = _value / _max;
	}

	
	
	
	///////////////////////////////////
	// public methods
	///////////////////////////////////
	
	/**
	 * Draws the visual ui of the component.
	 */
	public override function draw() {
		super.draw();
		_back.graphics.clear();
		_back.graphics.beginFill( backgroundColor );
		_back.graphics.drawRect(0, 0, _width, _height);
		_back.graphics.endFill();
		
		_bar.graphics.clear();
		_bar.graphics.beginFill( barColor );
		_bar.graphics.drawRect(0, 0, _width - 2, _height - 2);
		_bar.graphics.endFill();
	}
	
	
	
	
	///////////////////////////////////
	// event handlers
	///////////////////////////////////
	
	///////////////////////////////////
	// getter/setters
	///////////////////////////////////
	
	/**
	 * Gets / sets the maximum value of the ProgressBar.
	 */
	public function setMaximum(m:Float):Float {
		_max = m;
		_value = Math.min(_value, _max);
		update();
		return m;
	}
	public function getMaximum():Float {
		return _max;
	}
	
	/**
	 * Gets / sets the current value of the ProgressBar.
	 */
	public function setValue(v:Float):Float {
		_value = Math.min(v, _max);
		update();
		return v;
	}
	public function getValue():Float {
		return _value;
	}
	
}
