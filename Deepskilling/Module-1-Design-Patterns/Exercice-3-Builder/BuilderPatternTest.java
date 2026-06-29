public class BuilderPatternTest {

    public static void main(String[] args) {

        Computer studentComputer = new Computer.Builder()
                .setCpu("Intel i5")
                .setRam("16GB")
                .setStorage("512GB SSD")
                .setWifiEnabled(true)
                .build();

        studentComputer.showConfiguration();

        System.out.println();

        Computer gamingPc = new Computer.Builder()
                .setCpu("Intel i7")
                .setRam("32GB")
                .setStorage("1TB SSD")
                .setGraphicsCard("NVIDIA RTX 4060")
                .setWifiEnabled(true)
                .build();

        gamingPc.showConfiguration();
    }
}