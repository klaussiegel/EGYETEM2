// Oláh Tamás-Lajos
// otim1750
// 523 / 2

import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.WindowAdapter;
import java.awt.event.WindowEvent;

public class NewFoodFrame extends Frame {
    public NewFoodFrame() {
        this.setBounds(100,100,610,610);
        this.setLayout(new GridLayout(1,3,10,10));
        this.setState(Frame.NORMAL);
        this.setVisible(true);
        this.setBackground(new Color(30,30,30));
        this.addWindowListener(new WindowAdapter() {
            @Override
            public void windowClosing(WindowEvent e) {
                System.exit(0);
            }
        });
        this.setPreferredSize(new Dimension(600,500));

        List l1 = new List();
        List l2 = new List();

        l1.add("alma");
        l1.add("korte");
        l1.add("szilva");
        l1.add("barack");
        l1.add("khaki");
        l1.add("papaya");
        l1.add("pomelo");
        l1.add("granatalma");
        l1.add("durian");

        l2.add("HAGYMA");
        l2.add("zeller");
        l2.add("petrezselyem");
        l2.add("cekla");
        l2.add("kaposzta");
        l2.add("uborka");
        l2.add("murok");
        l2.add("bolyoka");

        l1.setMultipleMode(true);
        l2.setMultipleMode(true);

        Button b1 = new Button(">>");
        Button b2 = new Button("<<");

        b1.setBackground(new Color(190,190,190));
        b2.setBackground(new Color(190,190,190));
        b1.setForeground(new Color(0,0,0));
        b2.setForeground(new Color(0,0,0));

        Container c = new Container();
        c.setLayout(new GridLayout(2,0,2,2));
        c.add(b1);
        c.add(b2);

        b1.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                String[] x = l1.getSelectedItems();

                for (String a : x) {
                    l2.add(a);
                    l1.remove(a);
                }
            }
        });

        b2.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                String[] x = l2.getSelectedItems();

                for (String a : x) {
                    l1.add(a);
                    l2.remove(a);
                }
            }
        });

        this.add(l1);
        this.add(c);
        this.add(l2);

        this.pack();
    }
}
