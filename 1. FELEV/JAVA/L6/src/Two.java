import javax.swing.*;
import java.awt.*;

public class Two extends JPanel {
    private int circle_x = 200;
    private int circle_y = 200;
    public int circle_size = 100;
    public int spd = 10;
    public Color c = new Color(255,0,0);
    public Color bc = new Color(219, 219, 219);

    public enum egtaj {
        E, W, N, S
    }

    public Two() {
        this.setVisible(true);
        this.setSize(100,100);
        this.setBackground(bc);
    }

    public void move(egtaj x) {
        switch (x) {
            case E: { // >
                if (circle_x+spd-circle_size>this.getWidth()) circle_x = 0;
                else circle_x+=spd;
            } break;

            case N: { // ^
                if (circle_y-spd+circle_size<0) circle_y = this.getHeight();
                else circle_y-=spd;
            } break;

            case S: { // V
                if (circle_y+spd-circle_size>this.getHeight()) circle_y=0;
                else circle_y+=spd;
            } break;

            case W: { // <
                if (circle_x-spd+circle_size<0) circle_x=this.getWidth();
                else circle_x-=spd;
            } break;
        }

        this.repaint();
    }

    @Override
    protected void paintComponent(Graphics g) {
        super.paintComponent(g);
        g.create(this.getWidth()/2,this.getHeight()/2,this.getWidth(),this.getHeight());
        g.setColor(c);
        g.fillOval(circle_x,circle_y,circle_size,circle_size);
        this.repaint();
    }
}
