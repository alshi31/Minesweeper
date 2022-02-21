import de.bezier.guido.*;
public final static int NUM_ROWS = 20;
public final static int NUM_COLS = 20;
public final static int NUM_MINES = 5;
//public final static means that we cannot change that value while program is running
//Use numbers and rows as variables so that we can change them later, easily
//Establishes how big the board is and how many mines there are
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
  //creates the apartments buildings 
  for (int row = 0; row < NUM_ROWS; row++)
  {
    for (int column = 0; column < NUM_COLS; column++)
    {
      buttons[row][column] = new MSButton(row, column);
      //creates nested for loops to put the buttons in the apartment buildings
    }
  }
  setMines();
  //put mines in the apartments
}
public void setMines()
{
  while (mines.size() < NUM_MINES)
  {
    int row = (int)(Math.random()*NUM_ROWS);
    int col = (int)(Math.random()*NUM_COLS);
    //Randomize wherever the mines are supposed to go in the array
    if (!mines.contains(buttons[row][col]))
    {
      mines.add(buttons[row][col]);
      System.out.println(row + "," + col);
    }
    //makes sure that the mines do not overlap 
    //if the mines is not at that specific button, add it to that button 
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
//Makes sure that the rows and columns are within bounds
//ensures that array out of bounds does not happen
public int countMines(int row, int col)
{
  int numMines = 0;
  for (int r = row-1; r <= row + 1; r++)
    for (int c = col-1; c <= col + 1; c++)
      if (isValid(r, c) && mines.contains(buttons[r][c]))
        numMines++;
  if (mines.contains(buttons[row][col]))
    numMines--;
  return numMines;
}
//Count the amount of adjacent mines in a button
//If the mine is on that row/col, then it does not count
public class MSButton
{
  private int myRow, myCol;
  private float x, y, width, height;
  private boolean clicked, flagged;
  private String myLabel;
//declare variables before constructor
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
    //constructor 
  }

  // called by manager
  public void mousePressed ()
  {
    clicked = true;
    if (mouseButton == RIGHT)
    {
      flagged=!flagged;
      //returns the opposite of flagged
      if (flagged == false)
      {
        clicked = false;
      }
    } else if (mines.contains(this))
    {
      displayLosingMessage();
    } 
    //if you click a mine, then you lost
    else if (countMines(myRow, myCol) > 0)
    {
      myLabel = countMines(myRow, myCol) + "";
    }
    //assigns the number to the mines
    else 
    {
      for (int row = -1; row <= 1; row++) {
        for (int col = -1; col <= 1; col++) {
          if (isValid(myRow+row, myCol+col) && buttons[myRow+row][myCol+col].clicked == false)
            buttons[myRow+row][myCol+col].mousePressed();
        }
      }
    }
    //recursion so that unclicked squares nearby other unclicked squares are clicked
    //Check the isValid of that next button and if it is clicked
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
