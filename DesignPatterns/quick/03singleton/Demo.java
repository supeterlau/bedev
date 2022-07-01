public class Demo {
	public static void main(String[] args) {
		// Singleton object = new Singleton();
		Singleton object = Singleton.getInstance();
		object.showMessage();
	}
}
