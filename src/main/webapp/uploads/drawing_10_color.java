import javax.swing.*;
import java.awt.*;

public class Color extends JPanel 
{

    @Override
    protected void paintComponent(Graphics g) {
        super.paintComponent(g);

        // Set color for the circle
        g.setColor(Color.RED); // You can change this to Color.BLUE, Color.GREEN, etc.

        // Draw filled circle (x, y, width, height)
        g.fillOval(50, 50, 150, 150); // Position (50,50) and diameter 150px
    }

    public static void main(String[] args) {
        JFrame frame = new JFrame("Colored Circle Example");
        Color panel = new Color();

        frame.add(panel);
        frame.setSize(300, 300);
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.setVisible(true);
    }
}
