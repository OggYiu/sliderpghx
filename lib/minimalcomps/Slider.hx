/**
 * Slider.as
 * Keith Peters
 * version 0.97
 * 
 * Abstract base slider class for HSlider and VSlider.
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
import nme.events.Event;
import nme.events.MouseEvent;
import nme.geom.Rectangle;
// import flash.display.DisplayObjectContainer;
// import flash.display.Sprite;
// import flash.events.Event;
// import flash.events.MouseEvent;
// import flash.geom.Rectangle;

class Slider extends Component {
	
	public inline static var HORIZONTAL:String = "horizontal";
	public inline static var VERTICAL:String = "vertical";
	
	public var backClick(getBackClick, setBackClick) : Bool;
	public var maximum(getMaximum, setMaximum) : Float;
	public var minimum(getMinimum, setMinimum) : Float;
	public var tick(getTick, setTick) : Float;
	public var value(getValue, setValue) : Float;
	
	var _handle:Sprite;
	var _back:Sprite;
	var _backClick:Bool;
	var _value:Float ;
	var _max:Float ;
	var _min:Float ;
	var _orientation:String;
	var _tick:Float ;
	
	/**
	 * Constructor
	 * @param parent The parent DisplayObjectContainer on which to add this Slider.
	 * @param xpos The x position to place this component.
	 * @param ypos The y position to place this component.
	 * @param defaultHandler The event handling function to handle the default event for this component (change in this case).
	 */
	public function new(?orientation:String = Slider.HORIZONTAL, ?parent:Dynamic = null, ?xpos:Float = 0, ?ypos:Float =  0, ?defaultHandler:Dynamic = null) {
		_backClick = true;
		_value = 0;
		_max = 100;
		_min = 0;
		_tick = 1;
		_orientation = orientation;
		super(parent, xpos, ypos);
		if(defaultHandler != null)
			addEventListener(Event.CHANGE, defaultHandler);
	}
	
	/**
	 * Initializes the component.
	 */
	override function init() {
		super.init();

		if(_orientation == HORIZONTAL)
			setSize(100, 10);
		else
			setSize(10, 100);
	}
	
	/**
	 * Creates and adds the child display objects of this component.
	 */
	override function addChildren() {
		_back = new Sprite();
		_back.filters = [getShadow(2, true)];
		addChild(_back);
		
		_handle = new Sprite();
		_handle.filters = [getShadow(1)];
		_handle.addEventListener(MouseEvent.MOUSE_DOWN, onDrag);
		_handle.buttonMode = true;
		_handle.useHandCursor = true;
		addChild(_handle);
	}
	
	/**
	 * Draws the back of the slider.
	 */
	function drawBack() {
		_back.graphics.clear();
		_back.graphics.beginFill(Style.BACKGROUND);
		_back.graphics.drawRect(0, 0, _width, _height);
		_back.graphics.endFill();

		if(_backClick)
			_back.addEventListener(MouseEvent.MOUSE_DOWN, onBackClick);
		else
			_back.removeEventListener(MouseEvent.MOUSE_DOWN, onBackClick);
	}
	
	/**
	 * Draws the handle of the slider.
	 */
	function drawHandle() {	
		_handle.graphics.clear();
		_handle.graphics.beginFill(Style.BUTTON_FACE);
		if(_orientation == HORIZONTAL)
			_handle.graphics.drawRect(1, 1, _height - 2, _height - 2);
		else
			_handle.graphics.drawRect(1, 1, _width - 2, _width - 2);
		_handle.graphics.endFill();
		positionHandle();
	}
	
	/**
	 * Adjusts value to be within minimum and maximum.
	 */
	function correctValue() {
		if(_max > _min)	{
			_value = Math.min(_value, _max);
			_value = Math.max(_value, _min);
		} else {
			_value = Math.max(_value, _max);
			_value = Math.min(_value, _min);
		}
	}
	
	/**
	 * Adjusts position of handle when value, maximum or minimum have changed.
	 * TODO: Should also be called when slider is resized.
	 */
	function positionHandle() {
		var range:Float;
		switch(_orientation) {
			case HORIZONTAL:
				range = _width - _height;
				_handle.x = (_value - _min) / (_max - _min) * range;
			case VERTICAL:
				range = _height - _width;
				_handle.y = _height - _width - (_value - _min) / (_max - _min) * range;
		}
	}
	
	
	
	
	///////////////////////////////////
	// public methods
	///////////////////////////////////
	
	/**
	 * Draws the visual ui of the component.
	 */
	public override function draw() {
		super.draw();
		drawBack();
		drawHandle();
	}
	
	/**
	 * Convenience method to set the three main parameters in one shot.
	 * @param min The minimum value of the slider.
	 * @param max The maximum value of the slider.
	 * @param value The value of the slider.
	 */
	public function setSliderParams(min:Float, max:Float, value:Float) {
		this.minimum = min;
		this.maximum = max;
		this.value = value;
	}
	
	
	
	
	///////////////////////////////////
	// event handlers
	///////////////////////////////////
	
	/**
	 * Handler called when user clicks the background of the slider, causing the handle to move to that point. Only active if backClick is true.
	 * @param event The MouseEvent passed by the system.
	 */
	function onBackClick(event:MouseEvent) {
		if(_orientation == HORIZONTAL) {
			_handle.x = mouseX - height / 2;
			_handle.x = Math.max(_handle.x, 0);
			_handle.x = Math.min(_handle.x, width - height);
			_value = _handle.x / (width - height) * (_max - _min) + _min;
		} else {
			_handle.y = mouseY - width / 2;
			_handle.y = Math.max(_handle.y, 0);
			_handle.y = Math.min(_handle.y, height - width);
			_value = (_height - _width - _handle.y) / (height - width) * (_max - _min) + _min;
		}
		dispatchEvent(new Event(Event.CHANGE));
	}
	
	/**
	 * Internal mouseDown handler. Starts dragging the handle.
	 * @param event The MouseEvent passed by the system.
	 */
	function onDrag(event:MouseEvent) {
		stage.addEventListener(MouseEvent.MOUSE_UP, onDrop);
		stage.addEventListener(MouseEvent.MOUSE_MOVE, onSlide);
		switch(_orientation) {
			case HORIZONTAL: _handle.startDrag(false, new Rectangle(0, 0, width - height, 0));
			case VERTICAL: _handle.startDrag(false, new Rectangle(0, 0, 0, height - width));
		}
	}
	
	/**
	 * Internal mouseUp handler. Stops dragging the handle.
	 * @param event The MouseEvent passed by the system.
	 */
	function onDrop(event:MouseEvent) {
		stage.removeEventListener(MouseEvent.MOUSE_UP, onDrop);
		stage.removeEventListener(MouseEvent.MOUSE_MOVE, onSlide);
		stopDrag();
	}
	
	/**
	 * Internal mouseMove handler for when the handle is being moved.
	 * @param event The MouseEvent passed by the system.
	 */
	function onSlide(event:MouseEvent) {
		var oldValue:Float = _value;
		_value = switch(_orientation) {
			case HORIZONTAL: _handle.x / (width - height) * (_max - _min) + _min;
			case VERTICAL: (_height - _width - _handle.y) / (height - width) * (_max - _min) + _min;
		}
		if(_value != oldValue)
			dispatchEvent(new Event(Event.CHANGE));
	}
	
	
	
	
	///////////////////////////////////
	// getter/setters
	///////////////////////////////////
	
	/**
	 * Sets / gets whether or not a click on the background of the slider will move the handler to that position.
	 */
	public function setBackClick(b:Bool):Bool{
		_backClick = b;
		invalidate();
		return b;
	}
	public function getBackClick():Bool{
		return _backClick;
	}
	
	/**
	 * Sets / gets the current value of this slider.
	 */
	public function setValue(v:Float):Float {
		_value = v;
		correctValue();
		positionHandle();
		return v;
	}
	public function getValue():Float {
		return Math.round(_value / _tick) * _tick;
	}
	
	/**
	 * Gets / sets the maximum value of this slider.
	 */
	public function setMaximum(m:Float):Float{
		_max = m;
		correctValue();
		positionHandle();
		return m;
	}
	public function getMaximum():Float{
		return _max;
	}
	
	/**
	 * Gets / sets the minimum value of this slider.
	 */
	public function setMinimum(m:Float):Float {
		_min = m;
		correctValue();
		positionHandle();
		return m;
	}
	public function getMinimum():Float {
		return _min;
	}
	
	/**
	 * Gets / sets the tick value of this slider. This round the value to the nearest multiple of this number. 
	 */
	public function setTick(t:Float):Float {
		_tick = t;
		return t;
	}
	public function getTick():Float {
		return _tick;
	}
	
}
