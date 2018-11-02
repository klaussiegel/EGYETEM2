// Oláh Tamás-Lajos
// otim1750
// 523 / 2

import java.awt.*;
import java.awt.event.*;
import java.util.Random;

public class NewColorfulFrame extends Frame {
    public NewColorfulFrame()  {
        this.setBounds(100,100,600,600);
        this.setLayout(new GridLayout(3,3,1,1));
        this.setState(Frame.NORMAL);
        this.setVisible(true);
        this.setBackground(new Color(30,30,30));


        this.addWindowListener(new WindowAdapter() {
            @Override
            public void windowClosing(WindowEvent e) {
                System.exit(0);
            }
        });

        this.add(new Container());
        this.add(new Container());
        this.add(new Container());

        this.add(new Container());

        Choice ch = new Choice();
        ch.add("Death");
        ch.add("Thanos");
        ch.add("Meh...");
        ch.add("Hungarian Orange");
        ch.add("Random");
        ch.select("Meh...");

        ch.addItemListener(new ItemListener() {
            @Override
            public void itemStateChanged(ItemEvent e) {
                String act = ch.getSelectedItem();

                switch (act) {
                    case "Death":
                        NewColorfulFrame.this.setBackground(new Color(0,0,0));
                    break;

                    case "Thanos":
                        NewColorfulFrame.this.setBackground(new Color(109,54,120));
                    break;

                    case "Meh...":
                        NewColorfulFrame.this.setBackground(new Color(30,30,30));
                    break;

                    case "Hungarian Orange":
                        NewColorfulFrame.this.setBackground(new Color(255,255,0));
                    break;

                    case "Random":
                        Random rand = new Random();

                        int r = rand.nextInt(255) + 0;
                        int g = rand.nextInt(255) + 0;
                        int b = rand.nextInt(255) + 0;
                        NewColorfulFrame.this.setBackground(new Color(r,g,b));
                    break;
                }
            }
        });

        this.add(ch);

        this.add(new Container());
        this.add(new Container());
        this.add(new Container());

        this.add(new Container());

        this.pack();
    }
}
