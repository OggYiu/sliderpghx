package game;

import box2D.dynamics.B2DebugDraw;
import box2D.common.math.B2Transform;
import box2D.common.math.B2Vec2;
import box2D.common.B2Color;

class DebugDraw extends B2DebugDraw {
	public function new() {
		super();

		m_fillAlpha = 0.2;
	}

	override public function drawSolidPolygon(vertices:Array <B2Vec2>, vertexCount:Int, color:B2Color) : Void {
		super.drawSolidPolygon( vertices, vertexCount, new B2Color( Math.random(), Math.random(), Math.random() ) ) ;
	}
}