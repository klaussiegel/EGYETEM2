import javax.swing.*;
import javax.swing.border.Border;
import java.awt.*;
import java.awt.event.*;
import java.util.Random;

public class Main {
    public static void egy() {
        new One();
    }

    public static void ketto() {
        JFrame s = new JFrame("Masodik feladat");
        Two x = new Two();
        s.setVisible(true);
        s.setSize(600,600);
        s.setLayout(new BorderLayout(3,3));
        s.addWindowListener(new WindowAdapter() {
            @Override
            public void windowClosing(WindowEvent e) {
                System.exit(0);
            }
        });

        Button E = new Button(">");
        Button W = new Button("<");
        Button S = new Button("\\/");
        Button N = new Button("/\\");

        System.out.println(x.getWidth() + " x " + x.getHeight());

        E.setBackground(new Color(0x85858A));
        W.setBackground(new Color(0x85858A));
        S.setBackground(new Color(0x85858A));
        N.setBackground(new Color(0x85858A));

        E.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                x.move(Two.egtaj.E);
                x.repaint();
            }
        });

        W.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                x.move(Two.egtaj.W);
                x.repaint();
            }
        });

        S.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                x.move(Two.egtaj.S);
                x.repaint();
            }
        });

        N.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                x.move(Two.egtaj.N);
            }
        });

        s.add(E,BorderLayout.EAST);
        s.add(W,BorderLayout.WEST);
        s.add(S,BorderLayout.SOUTH);
        s.add(N,BorderLayout.NORTH);
        s.add(x,BorderLayout.CENTER);
        s.addKeyListener(new KeyAdapter() {
            @Override
            public void keyPressed(KeyEvent e) {
                super.keyPressed(e);
                switch (e.getKeyCode()) {
                    case KeyEvent.VK_UP: {
                        x.move(Two.egtaj.N);
                        x.repaint();
                    } break;

                    case KeyEvent.VK_DOWN: {
                        x.move(Two.egtaj.S);
                        x.repaint();
                    } break;

                    case KeyEvent.VK_LEFT: {
                        x.move(Two.egtaj.W);
                        x.repaint();
                    } break;

                    case KeyEvent.VK_RIGHT: {
                        x.move(Two.egtaj.E);
                        x.repaint();
                    } break;

                    case KeyEvent.VK_PLUS: {
                        x.spd++;
                    } break;

                    case KeyEvent.VK_MINUS: {
                        x.spd--;
                    }

                    case KeyEvent.VK_COMMA: {
                        x.circle_size--;
                    } break;

                    case KeyEvent.VK_PERIOD: {
                        x.circle_size++;
                    } break;

                    case KeyEvent.VK_C: {
                        Random r = new Random();
                        x.c = new Color(r.nextInt(255),r.nextInt(255),r.nextInt(255));
                        x.repaint();
                    } break;

                    case KeyEvent.VK_X: {
                        Random r = new Random();
                        x.bc = new Color(r.nextInt(255),r.nextInt(255),r.nextInt(255));
                        x.setBackground(x.bc);
                        x.repaint();
                    }
                }
            }
        });
    }

    public static void harom() {
        new Three();
    }

    public static void main(String args[]) {
        egy();
        // ketto();
        // harom();
    }
}
