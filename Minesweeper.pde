import de.bezier.guido.*;
public final static int NUM_ROWS = 5;
public final static int NUM_COLS = 5;
public final static int NUM_MINES = 5;
//public final static means that we cannot change that value while program is running
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> mines = new ArrayList<MSButton>(); //ArrayList of just the minesweeper buttons that are mined

void setup ()
{
  size(400, 400);
  textAlign(CENTER, CENTER);

  // make the manager
  Interactive.make( this );

  //your code to initialize buttons goes here
  buttons = new MSButton[NUM_ROWS][NUM_COLS];
  for (int row = 0; row < NUM_ROWS; row++)
  {
    for (int column = 0; column < NUM_COLS; column++)
    {
      buttons[row][column] = new MSButton(row, column);
    }
  }
  setMines();
}
public void setMines()
{
  while (mines.size() < NUM_MINES)
  {
    int row = (int)(Math.random()*NUM_ROWS);
    int col = (int)(Math.random()*NUM_COLS);
    if (!mines.contains(buttons[row][col]))
    {
      mines.add(buttons[row][col]);
      System.out.println(row + "," + col);
    }
  }
}

public void draw ()
{
  background( 0 );
  if (isWon() == true)
    displayWinningMessage();
}
public boolean isWon()
{
  //your code here
  return false;
}
public void displayLosingMessage()
{
  //your code here
}
public void displayWinningMessage()
{
  //your code here
}
public boolean isValid(int r, int c)
{
  if (r < NUM_ROWS && r >= 0 && c < NUM_COLS && c >= 0)
    return true;
  return false;
}
public int countMines(int row, int col)
{
  int numMines = 0;
  for (int r = row-1; r <= row + 1; r++)
    for (int c = col-1; c <= col + 1; c++)
      if (isValidOnRowbyCol(r, c) && mines.contains(buttons[r][c]))
        numMines++;
  if (mines.contains(buttons[row][col]))
    numMines--;
  return numMines;
}
public boolean isValidOnRowbyCol(int row, int col) {
  if (row >= 0 && row < 5 && col >= 0 && col < 5)
    return true;
  return false;
}

public class MSButton
{
  private int myRow, myCol;
  private float x, y, width, height;
  private boolean clicked, flagged;
  private String myLabel;

  public MSButton ( int row, int col )
  {
    width = 400/NUM_COLS;
    height = 400/NUM_ROWS;
    myRow = row;
    myCol = col; 
    x = myCol*width;
    y = myRow*height;
    myLabel = "";
    flagged = clicked = false;
    Interactive.add( this ); // register it with the manager
  }

  // called by manager
  public void mousePressed () 
  {
    clicked = true;
    if (mouseButton == RIGHT)
    {
      flagged=!flagged;
      if (flagged == false)
      {
        clicked = false;
      }
    } 
    else if (mines.contains(this))
    {
      displayLosingMessage();
    } 
    else if (countMines(myRow, myCol) > 0)
    {
      myLabel = countMines(myRow, myCol) + "";
    }
    else
    {
      if (isValidOnRowbyCol(myRow, myCol) && clicked == false)
      {
        
        mousePressed();
      }
    }
  }
  public void draw () 
  {    
    if (flagged)
      fill(0);
    else if ( clicked && mines.contains(this) ) 
      fill(255, 0, 0);
    else if (clicked)
      fill( 200 );
    else 
    fill( 100 );

    rect(x, y, width, height);
    fill(0);
    text(myLabel, x+width/2, y+height/2);
  }
  public void setLabel(String newLabel)
  {
    myLabel = newLabel;
  }
  public void setLabel(int newLabel)
  {
    myLabel = ""+ newLabel;
  }
  public boolean isFlagged()
  {
    return flagged;
  }
}
