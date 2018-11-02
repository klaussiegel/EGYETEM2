// Oláh Tamás-Lajos
// otim1750
// 523 / 2

import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.WindowAdapter;
import java.awt.event.WindowEvent;

public class NewTextFrame extends Frame {
    public NewTextFrame() {
        this.setBounds(100,100,610,610);
        this.setLayout(new GridLayout(3,1,10,10));
        this.setState(Frame.NORMAL);
        this.setVisible(true);
        this.setBackground(new Color(30,30,30));
        this.addWindowListener(new WindowAdapter() {
            @Override
            public void windowClosing(WindowEvent e) {
                System.exit(0);
            }
        });

        TextField tf = new TextField();
        Button b = new Button("Filter");
        TextArea ta = new TextArea();

        b.setBackground(new Color(190,190,190));

        b.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                String x = ta.getSelectedText();
                String del = tf.getText();

                String[] out = x.split(del);
                x = "";

                for (String a : out) {
                    x += a;
                }

                ta.setText(x);
            }
        });

        this.add(tf);
        this.add(b);
        this.add(ta);

        this.pack();
    }
}
