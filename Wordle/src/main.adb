with Ada.Text_IO;                  use Ada.Text_IO;
with Ada.Integer_Text_IO;          use Ada.Integer_Text_IO;
with Ada.Numerics.Discrete_Random;
with Ada.Strings.Unbounded;        use Ada.Strings.Unbounded;
with Ada.Characters.Handling;       use Ada.Characters.Handling;

procedure main is

   --user variables
   GssNm : Integer := 1;
   GssAcpt: Boolean := True;
   GuessUB : Unbounded_String;
   Guess: String := "-----";
   rslt: String :="-----";

   --Solution variables
   lastChar: Integer;
   wrdChse: Integer; --picks a number that is the word number  " & "
   Wrds: String :=To_Lower("Abuse" & "Adult" & "Agent" & "Anger" & "Apple" & "Award" & "Basis" & "Beach" & "Birth" & "Block" & "Blood" & "Board" & "Brain" & "Bread" & "Break"
                           &"Brown" & "Buyer" & "Cause" & "Chain" & "Chair" & "Chest" & "Chief" & "Child" & "China" & "Claim" & "Class" & "Clock" & "Coach" & "Coast"
                           &"Court" & "Cover" & "Cream" & "Crime" & "Cross" & "Crowd" & "Crown" & "Cycle" & "Dance" & "Death" & "Depth" & "Doubt" & "Draft" & "Drama" & "Dream"&
                             "Dress" & "Drink" & "Drive" & "Earth" & "Enemy" & "Entry" & "Error" & "Event" & "Faith" & "Fault" & "Field" & "Fight" & "Final" & "Floor" & "Focus" & "Force" & "Frame" &
                             "Frank" & "Front" & "Fruit" & "Glass" & "Grant" & "Grass" & "Green" & "Group" & "Guide" & "Heart" & "Henry" & "Horse" & "Hotel" & "House" & "Image" & "Index" & "Input" &
                             "Issue" & "Japan" & "Jones" & "Judge" & "Knife" & "Laura" & "Layer" & "Level" & "Lewis" & "Light" & "Limit" & "Lunch" & "Major" & "March" & "Match" & "Metal" & "Model" &
                             "Money" & "Month" & "Motor" & "Mouth" & "Music" & "Night" & "Noise" & "North" & "Novel" & "Nurse" & "Offer" & "Order" & "Other" & "Owner" & "Panel" & "Paper" & "Party" &
                             "Peace" & "Peter" & "Phase" & "Phone" & "Piece" & "Pilot" & "Pitch" & "Place" & "Plane" & "Plant" & "Plate" & "Point" & "Pound" & "Power" & "Press" & "Price" & "Pride" &
                             "Prize" & "Proof" & "Queen" & "Radio" & "Range" & "Ratio" & "Reply" & "Right" & "River" & "Round" & "Route" & "Rugby" & "Scale" & "Scene" & "Scope" & "Score" & "Sense" &
                             "Shape" & "Share" & "Sheep" & "Sheet" & "Shift" & "Shirt" & "Shock" & "Sight" & "Simon" & "Skill" & "Sleep" & "Smile" & "Smith" & "Smoke" & "Sound" & "South" & "Space" &
                             "Speed" & "Spite" & "Sport" & "Squad" & "Staff" & "Stage" & "Start" & "State" & "Steam" & "Steel" & "Stock" & "Stone" & "Store" & "Study" & "Stuff" & "Style" & "Sugar" &
                             "Table" & "Taste" & "Terry" & "Theme" & "Thing" & "Title" & "Total" & "Touch" & "Tower" & "Track" & "Trade" & "Train" & "Trend" & "Trial" & "Trust" & "Truth" & "Uncle" &
                             "Union" & "Unity" & "Value" & "Video" & "Visit" & "Voice" & "Waste" & "Watch" & "Water" & "While" & "White" & "Whole" & "Woman" & "World" & "Youth");
   Ansr: String :="-----";

   -- help variables
   ChckynUB: Unbounded_String;
   Chckyn: Character := '-';
   RandomHelp: Integer;
   yeshelpUnB: Unbounded_String;
   yeshelp : Integer;
   positionCharacterCheckUB : Unbounded_String;
   positionCharacterCheck: Character :='-';




   --helps if they have matching characters
   procedure YRnHlp (positionModulus : Integer; helpWrds : String; helpAnsr : String) is

      answerCharacterPostion : Integer := positionModulus;


   begin

      if positionModulus = 0 then
         answerCharacterPostion := 5;
      end if;


      for I in 1..helpWrds'length loop



         if (I mod 5) = positionModulus and then helpAnsr(answerCharacterPostion) = helpWrds(I) then

            if positionModulus = 0 then

               Put_Line(helpWrds(I-4..I));

            else

               Put_Line(helpWrds((I-positionModulus+1)..(I+5-positionModulus)));


            end if;




         end if;


      end loop;


   end YRnHlp;


   --num generator dont touch
   function RanNum (L : Integer) return Integer is

      subtype Random_Range is Integer range 1..L;

      package R is new
        Ada.Numerics.Discrete_Random (Random_Range);
      use R;

      G : Generator;
      X : Random_Range;
   begin
      Reset (G);
      X := Random (G);
      return X;
   end RanNum;

begin
   lastChar :=Integer(Wrds'Length);
   Put_Line ("Enter a 5 letter noun. Must be lower case");
   Put_Line ("! If the letter is present in the word but in the wrong palce");
   Put_Line ("$ if the letter is present and in the right place");
   Put_Line ("- if the letter is not in the word.");
   Put_line ("type !help! to get help and !end! to end the program");
   Put_Line ("Here are some words to get you stated.");
   for I in 1..5 loop
      RandomHelp := RanNum(lastChar/5);
      Put_Line(Wrds(RandomHelp*5-4..RandomHelp*5));
   end loop;


   --Put_Line (Integer'Image(lastChar));
   wrdChse :=RanNum(lastChar/5);
   --Put_line (Integer'Image(wrdChse));
   Ansr := (Wrds(wrdChse*5-4..wrdChse*5));
   --Put_Line (Ansr); -- what im going to use to check if they won

   while GssNm <6 loop
      GssAcpt := True;
      Put_Line(" ");
      Guess :="-----";
      rslt :="-----";
      GuessUB := To_Unbounded_String(Get_Line);
      if ((To_String(GuessUB)'Length)) = 5 and (To_String(GuessUB)) /= "!help!" and (To_String(GuessUB)) /= "!end!" then --checks to make sure input lenght is 5 letters
         Guess := To_String(GuessUB);

         --checks to make sure the word is in the list of words
         WrdVldt : for J in 1..lastChar loop

            --the start of a new word is at 1,6,11 ect
            if (J mod 5)=1 then

               --checks to see if the guess word matches with a potential match
               if Guess(1..5)=Wrds(J..J+4) then
                  exit WrdVldt; --exits the loop if a word match is found
               end if;

               -- output if its not in the word list
            elsif J = lastChar then
               GssAcpt := False;
               Put_Line("you word is not a possiable answer try again.");
               Put_Line("remember your word must be in the list and lower case");
               Put_Line("Type !help! for a list of accepted words");
            end if;
         end loop WrdVldt;


         -- if input is rejected this will be skipped
         if GssAcpt = True then

            -- will put char for guess have correcte char in correct space
            for I in 1..5 loop

               if Guess(I)=Ansr(I) then

                  rslt(I) := '$';

               end if;

            end loop;

            -- will put char for guess have correct char not correct space
            for I in 1..5 loop
               for J in 1..5 loop
                  if Guess(I) = Ansr(J) and rslt(I) /= '$' then
                     rslt (I) := '!';
                  end if;
               end loop;
            end loop;

            Put_Line (rslt);

            If rslt="$$$$$" then

               Put_Line ("congratulations you won!");
               return;

            end if;

            Put_Line("You have"& Integer'image(5-GssNm) & " guesses left");
            -- dashes are default so no adjustment for not correct character.
            GssNm := GssNm + 1;



         end if;






         --User gets help
      elsif (To_String(GuessUB)) = "!help!" then
         help: loop

            --User can get specific help or general help
            Put_Line("do you have any $'s yet y or n?");
            ChckynUB := To_Unbounded_String(Get_Line);
            if ((To_String(ChckynUB)'Length)) = 1 then
               Chckyn := To_String(ChckynUB)(1);

               if Chckyn = 'n' then
                  Put_Line("here are five random valid words");
                  for I in 1..5 loop

                     RandomHelp := RanNum(lastChar/5);
                     Put_Line(Wrds(RandomHelp*5-4..RandomHelp*5));

                  end loop;
                  Put_Line("try one of those");
                  exit help;

               elsif Chckyn = 'y' then
                  Put_Line("What position is the $ 1, 2, 3, 4, or 5");
                  yeshelpUnB := To_Unbounded_String(Get_Line);
                  if (Integer'Value(To_String(yeshelpUnB))) <6 and (Integer'Value(To_String(yeshelpUnB))) > 0 then
                     yeshelp := Integer'Value(To_String(yeshelpUnB));
                     Put_Line(Integer'Image(yeshelp));
                     Put_Line("What letter is in that position?");

                     positionCharacterCheckUB := To_Unbounded_String(Get_Line);


                     if (To_String(positionCharacterCheckUB)'length) = 1 then
                        positionCharacterCheck := To_String(positionCharacterCheckUB)(1);
                        if To_String(positionCharacterCheckUB)(1) = Ansr(yeshelp) then

                           if yeshelp = 5 then
                              yeshelp := 0;
                              YRnHlp (yeshelp, Wrds, Ansr);
                              Put_Line("Put in a new guess");
                              exit help;

                           else

                              YRnHlp (yeshelp, Wrds, Ansr);
                              Put_Line("Put in a new guess");
                              exit help;
                           end if;

                        else

                           Put_Line("That character doesn't match the solutions character");
                           Put_Line("Either type !help! to try to get help again or put in another guess.");
                           exit help;

                        end if;

                     else

                        Put_Line("You entered too many characters");
                        Put_Line("Either type !help! to try to get help again or put in another guess.");
                        exit help;

                     end if;


                  else

                     Put_Line ("Please only enter 1, 2, 3, 4, or 5");
                  end if;



               else
                  Put_Line("put y or n only. nothing else will be accepted");
               end if;


            else

               Put_Line("put y or n only. nothing else will be accepted");

            end if;

         end loop help;






      elsif (To_String(GuessUB)) = "!end!" then

         return;



      else
         Put_Line("that is not a vailid input try again");
      end if;


   end loop;

   if GssNm = 6 then
      Put_Line ("I'm sorry you didn't solve it.You can get it next time!");
      Put_Line ("The answer was " & Ansr);
   end if;


end main;
