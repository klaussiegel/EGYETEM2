import javax.swing.*;
import java.awt.*;
import java.awt.event.*;
import java.util.Random;

public class Three extends JFrame {
    public Random r = new Random();

    public Three() {
        this.addWindowListener(new WindowAdapter() {
            @Override
            public void windowClosing(WindowEvent e) {
                System.exit(0);
            }
        });

        this.setVisible(true);
        this.setSize(600,600);
        this.setLayout(null);

        JButton b = new JButton("Click Me!");
        b.setSize(100,50);
        b.setLocation(0,0);
        b.setBackground(new Color(45,45,45));
        b.setForeground(new Color(255,255,255));

        b.addMouseListener(new MouseAdapter() {
            @Override
            public void mouseEntered(MouseEvent e) {
                super.mouseEntered(e);
                b.setLocation(r.nextInt(400),r.nextInt(400));
            }

            @Override
            public void mouseClicked(MouseEvent e) {
                super.mouseClicked(e);
                System.out.println("WINNER WINNER CHICKEN DINNER!");
            }
        });

        this.add(b);
    }

}
