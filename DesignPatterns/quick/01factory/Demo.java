public class Demo {
	public static void main(String[] args) {
		ShapeFactory shapeFactory  = new ShapeFactory();

		Shape shape1 = shapeFactory.makeShape("Rectangle");
		shape1.draw();

		Shape shape2 = shapeFactory.makeShape("Square");
		shape2.draw();

		Shape shape3 = shapeFactory.makeShape("Circle");
		shape3.draw();
	}
}
