using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.System;
using Toybox.Lang;
using Toybox.Math as math;
using Toybox.ActivityMonitor as Am;
using Toybox.SensorHistory;

class HelloWorldView extends Ui.WatchFace {
	var backgrounds;
	var logo;
	var step;
	var calorieslogo;
    function initialize() {
        WatchFace.initialize();
    }

    // Load your resources here
    function onLayout(dc) {
    	logo = Ui.loadResource(Rez.Drawables.Logo);
    	step = Ui.loadResource(Rez.Drawables.step);
    	calorieslogo = Ui.loadResource(Rez.Drawables.Calories);
		 setLayout(Rez.Layouts.WatchFace(dc));
    }

    function onShow() {

    }

    // Update the view
    function onUpdate(dc) {
    	var width = dc.getWidth();
        var height = dc.getHeight();
        var radus = width/2;
        var centerX = width>>1;
        var centerY = height>>1;
        //GET INFO FROM THE WATCH
  		var info  =   ActivityMonitor.getInfo();
  		var history = Am.getHistory();
  		
  		var yesterdayStep = ((history[0].steps)/(140))+50;
  		var yesterdayFloors = ((history[0].floorsClimbed) *2)+50;
  		var yesterdayCalories = ((history[0].calories)/100)+50;
  		var yesterdaymeters = ((history[0].distance/100)/130)+50;
  		
  		//who in display
		var stringSteps = info.steps.toString();
		var stringCalories = info.calories.toString();
		var stringFloors = info.floorsClimbed.toString();
		var stringMeters = (info.distance/1000).toString();
		var stringHearRate = null ;
		//adjust
		
		var steps = ((info.steps)/(140)) + 50;//max 10000
		var calories = (info.calories/100) + 50;//
		var floors = (info.floorsClimbed * 2) + 50;
		var meters = ((info.distance/100)/130) + 50;
		var heartRate = Activity.getActivityInfo().currentHeartRate;
	    
		if(heartRate==null) {
			var HRH=ActivityMonitor.getHeartRateHistory(1, true);
			var HRS=HRH.next();

			if(HRS!=null && HRS.heartRate!= ActivityMonitor.INVALID_HR_SAMPLE){
				heartRate = HRS.heartRate;
				
			}
			if(heartRate!=null) {
				stringHearRate = heartRate.toString();
			}
		}

			    
	    
     System.println("Steps:"+ info.steps);
     System.println("meters:"+ ((info.distance)/100));
     System.println("calories:"+ info.calories);
     System.println("floors:"+ info.floorsClimbed);
     System.println("heartRate:" + heartRate);
     System.println("floor goal" + yesterdayStep + "---" + yesterdayFloors +"calories" + yesterdayCalories);
     System.println("---------");
     
	// //testing
	dc.setColor(Gfx.COLOR_BLUE, Gfx.COLOR_RED);
	dc.clear();


 


  		var p_x = steps;//Affects steps, miles, calories       White
		var c_x = calories; //Red
		var f_x = floors; //Blue
		var m_x = meters; //Green
		//var h_x = heartRate

	View.onUpdate(dc);
	
 	
	dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT);
	dc.setPenWidth(1);
	//dc.drawLine(5,5,25,25);
	//*******************Work On make 5 Xs so that we can put separtae value.*********************
		//get x will be value of data
	//444444444444444444444444444444444444444444444444444444444444444
	var p_xWhiteYES = yesterdayStep;
	var p_xGreenYES = yesterdaymeters;
	var p_xRedYES = yesterdayCalories;
	
	
	//need to be negitive
	var p_xBlueYES = -(yesterdayFloors);
	var p_xYelloYES = -(heartRate)/2;//heartRate
	
	//==================SLOP======================
	//Green line slope
	var p_yGreenYES = (4017.0/12364.0)*p_xGreenYES;
	//Red line slope
	var p_yRedYES = -(7641.0/10517.0)*p_xRedYES;


	//Blue line slope
	var p_yBlueYES = -(4017.0/12364.0)*p_xBlueYES;

	//Yellow line
	var p_yYelloYES = (7641.0/10517.0) *p_xYelloYES;
	
	dc.setPenWidth(1);
	dc.setColor(Gfx.COLOR_DK_GRAY, Gfx.COLOR_TRANSPARENT);
	//Make line GREEN TO RED
	dc.drawLine(p_xGreenYES + 130, 130 - p_yGreenYES , 130 + (- p_yRedYES),p_xRedYES + 130);
	//Make line Red to yello
	dc.drawLine( 130 + (- p_yRedYES),p_xRedYES + 130,p_yYelloYES +130 , -(p_xYelloYES) +130);
	//Make line Yello to Blue
	dc.drawLine(p_yYelloYES +130 , -(p_xYelloYES) +130 ,p_xBlueYES + 130 , 130 - p_yBlueYES);
	//Make line White to Blue
	dc.drawLine(p_xBlueYES + 130 , 130 - p_yBlueYES, 130, -(p_xWhiteYES -130));
	//Make line White to Green
	dc.drawLine(130, -(p_xWhiteYES -130),p_xGreenYES + 130, 130 - p_yGreenYES );
	
	//444444444444444444444444444444444444444444444444444444444444444
	
	//get x will be value of data
	var p_xWhite = steps;
	var p_xGreen = meters;
	var p_xRed = calories;
	
	
	//need to be negitive
	var p_xBlue = -(floors);
	var p_xYello = -(heartRate)/2;//heartRate
	
	//==================SLOP======================
	//Green line slope
	var p_yGreen = (4017.0/12364.0)*p_xGreen;
	//Red line slope
	var p_yRed = -(7641.0/10517.0)*p_xRed;


	//Blue line slope
	var p_yBlue = -(4017.0/12364.0)*p_xBlue;

	//Yellow line
	var p_yYello = (7641.0/10517.0) *p_xYello;

	//==================SLOP======================


	var y = (130 * (math.sin(math.toRadians(18))));
	var x = 130 * (math.cos(math.toRadians(18)));
	//red and yello
	var bottonX = (130 * (math.cos(math.toRadians(54))));
	var bottonY = (130 * (math.sin(math.toRadians(54))));
	//================Slop=========================
	
	//--------------Pentogon----------------------------
	//first line
	dc.drawLine(centerX, centerY, centerX, 0);
	//3rd line
	dc.setColor(Gfx.COLOR_RED, Gfx.COLOR_TRANSPARENT);
	dc.drawLine(centerX,centerY, bottonX + 130, bottonY + 130);
	//Blue line 5th
	dc.setColor(Gfx.COLOR_BLUE, Gfx.COLOR_TRANSPARENT);
	dc.drawLine(centerX,centerY,(-x)+130,(-y)+130);
	//Green line 1st
	dc.setColor(Gfx.COLOR_DK_GREEN, Gfx.COLOR_TRANSPARENT);
	dc.drawLine(centerX,centerY,(x)+130,(-y)+130);
	//4th line
	dc.setColor(Gfx.COLOR_YELLOW, Gfx.COLOR_TRANSPARENT);
	dc.drawLine(centerX,centerY,-(bottonX)+130, bottonY+130);
	//--------------Pentogon----------------------------
	
	//49logo in middle
	dc.drawBitmap(100, 90, logo);
	//dc.drawBitmap(85, 10, step);
	//dc.drawBitmap(200, 150, calorieslogo);
	
	
	//====================CURRENT line between the point==========================
	dc.setPenWidth(1.5);
	dc.setColor(Gfx.COLOR_GREEN, Gfx.COLOR_TRANSPARENT);
	//Make line GREEN TO RED
	dc.drawLine(p_xGreen + 130, 130 - p_yGreen , 130 + (- p_yRed),p_xRed + 130);
	//Make line Red to yello
	dc.drawLine( 130 + (- p_yRed),p_xRed + 130,p_yYello +130 , -(p_xYello) +130);
	//Make line Yello to Blue
	dc.drawLine(p_yYello +130 , -(p_xYello) +130 ,p_xBlue + 130 , 130 - p_yBlue);

	//Make line White to Blue
	dc.drawLine(p_xBlue + 130 , 130 - p_yBlue, 130, -(p_xWhite -130));
	//Make line White to Green
	dc.drawLine(130, -(p_xWhite -130),p_xGreen + 130, 130 - p_yGreen );
	//dc.drawText(130, 130, Gfx.FONT_SMALL, "test123", Gfx.TEXT_JUSTIFY_CENTER);
	//Make line White to Blue

	//====================line between the point==========================


	// **************draw point current data**************
	dc.setPenWidth(4);
	dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT);
	//System.println(info.maxHeartRate);
	//White Line
	dc.drawPoint(130, -(p_xWhite -130));
	//Green Line
	dc.setColor(Gfx.COLOR_GREEN, Gfx.COLOR_TRANSPARENT);
	dc.drawPoint(p_xGreen + 130, 130 - p_yGreen );
	//Blue Line POINT
	dc.setColor(Gfx.COLOR_BLUE, Gfx.COLOR_TRANSPARENT);
	dc.drawPoint(p_xBlue + 130 , 130 - p_yBlue);
	//Red Line ++++ X and Y change++++
	dc.setColor(Gfx.COLOR_RED, Gfx.COLOR_TRANSPARENT);
	dc.drawPoint( 130 + (- p_yRed),p_xRed + 130);
	//YELLO Line ++++ X and Y Change++++
	dc.setColor(Gfx.COLOR_YELLOW, Gfx.COLOR_TRANSPARENT);
	dc.drawPoint(p_yYello +130 , -(p_xYello) +130 );
	// **************draw point**************

	// Time
        var clockTime = System.getClockTime();
        var timeString = Lang.format("$1$:$2$", [clockTime.hour, clockTime.min.format("%02d")]);
        var view = View.findDrawableById("TimeLabel");
       view.setText(timeString);
	
	//Line Labels
		dc.setColor(Gfx.COLOR_BLUE, Gfx.COLOR_TRANSPARENT);
		dc.drawText(centerX +8,
					0,
    				Gfx.FONT_XTINY,
    				stringSteps,
    				Gfx.TEXT_JUSTIFY_LEFT);
    	//dc.setColor(Gfx.COLOR_RED, Gfx.COLOR_TRANSPARENT);
    	dc.drawText(bottonX + 130 -10,
    				bottonY + 130 -15,
    				Gfx.FONT_XTINY,
    				stringCalories,
    				Gfx.TEXT_JUSTIFY_RIGHT);
    	//dc.setColor(Gfx.COLOR_BLUE, Gfx.COLOR_TRANSPARENT);
    	dc.drawText((-x)+130,
    				(-y)+130 +15,
    				Gfx.FONT_XTINY,
    				stringFloors,
    				Gfx.TEXT_JUSTIFY_LEFT);
    	//dc.setColor(Gfx.COLOR_DK_GREEN, Gfx.COLOR_TRANSPARENT);
    	dc.drawText((x)+130,
    				(-y)+130 +15,
    				Gfx.FONT_XTINY,
    				stringMeters,
    				Gfx.TEXT_JUSTIFY_RIGHT);
   		//dc.setColor(Gfx.COLOR_YELLOW, Gfx.COLOR_TRANSPARENT);
   		dc.drawText(-(bottonX)+130 +10,
   					bottonY+130 -15,
    				Gfx.FONT_XTINY,
    				heartRate,
    				Gfx.TEXT_JUSTIFY_LEFT);
    				dc.clear();
	    
       
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.l
    function onHide() {


    }

    // The user has just looked at their watch. Timers and animations may be started here.
    function onExitSleep() {
    }

    // Terminate any active timers and prepare for slow updates.
    function onEnterSleep() {
    }

}
