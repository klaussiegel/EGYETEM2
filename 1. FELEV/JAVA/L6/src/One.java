import javax.swing.*;
import java.awt.*;
import java.awt.event.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import static java.lang.System.exit;

public class One extends JFrame {
    One() {
        this.setVisible(true);
        this.setResizable(true);
        this.setSize(300,300);
        this.setPreferredSize(new Dimension(300,300));
        this.setBackground(new Color(37, 37, 37));
        this.setLayout(new BorderLayout(3,3));
        Container c = new Container();
        c.setLayout(new GridLayout(2,1,3,3));

        JLabel lab = new JLabel();
        lab.setFont(new Font("Arial",2,20));
        lab.setHorizontalAlignment(SwingConstants.CENTER);
        lab.setVerticalAlignment(SwingConstants.CENTER);
        Button but = new Button("( ͡° ͜ʖ ͡°)");
        but.setFont(new Font("Arial Black",2,20));
        but.setBackground(new Color(154, 154, 154));

        but.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                LocalDateTime time = LocalDateTime.now();
                // WTF INLINE HTML???
                lab.setText(
                        "<html>"+
                            time.getYear() +
                            ". " + time.getMonth() + ". " +
                            time.getDayOfMonth() + ". " +
                            "<br><div style=\"text-align: center;\">" +
                                time.getHour() + " : " + time.getMinute()+
                            "</div>" +
                        "</html>");
            }
        });

        this.addWindowListener(new WindowAdapter() {
            @Override
            public void windowClosing(WindowEvent e) {
                System.exit(0);
            }
        });

        c.add(lab); c.add(but);

        this.add(c,BorderLayout.CENTER);

        this.pack();
    }
}
