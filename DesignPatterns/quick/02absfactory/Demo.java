public class Demo {
	public static void main(String[] args) {
		AbstractFactory shapeFactory = FactoryProducer.getFactory("SHAPE");

		Shape shape01 = shapeFactory.getShape("CIRCLE");
		shape01.draw();

		Shape shape02 = shapeFactory.getShape("RECTANGLE");
		shape02.draw();

		Shape shape03 = shapeFactory.getShape("SQUARE");
		shape03.draw();

		AbstractFactory colorFactory = FactoryProducer.getFactory("COLOR");

		Color color01 = colorFactory.getColor("RED");
		color01.fill();

		Color color02 = colorFactory.getColor("GREEN");
		color02.fill();

		Color color03 = colorFactory.getColor("BLUE");
		color03.fill();
	}
}
