program main;

uses
   GraphABC, Timers, ABCobjects, PaintingProcedures, TypesAndConst;

var
   N: integer; //текущий шаг (пеерименовать)
   A, B, C: tPoint; //points
   {API}
   GraphRes, GraphRes2: RoundRectABC;
   avgGraphRes, avgGraphRes2: RoundRectABC;
   Nfield: RoundRectABC;

procedure GraphABCprocedure();
var
   T0, T: real;
begin
   SetBrushColor(clRed);
   T0 := Milliseconds;
   FillPolygon((A.x, A.y), (B.x, B.y), (C.x, C.y));
   T := Milliseconds - T0;
   GraphRes.Text := T.ToString('F2');
   avgGraphRes.Text := (((StrToFloat(avgGraphRes.Text)) + T)/N).ToString('F2');
   Sleep(afterFillSleep);
end;

procedure GraphABCprocedure2();
var
   T0, T: real;
begin
   SetBrushColor(clBlue);
   T0 := Milliseconds;
   SquareMethod(A, B, C, clBlue);
   T := Milliseconds - T0;
   GraphRes2.Text := T.ToString('F2');
   avgGraphRes2.Text := (((StrToFloat(avgGraphRes2.Text)) + T)/N).ToString('F2');
   Sleep(afterFillSleep);
end;

procedure ClearZone();
begin
  SetBrushColor(clWhite);
  FillRectangle(SPACE+1, (SPACE + 3*TEXT_STEP)+1, 500-1, 500-1);
end;
  
//procedure Triangle();
//begin
//   SetBrushColor(clOrange);
//   line(A.x, A.y, B.x, B.y);
//   line(B.x, B.y, C.x, C.y);
//   line(C.x, C.y, A.x, A.y);
//end;
  
procedure NewPoints();
begin
   A.x := random(SPACE, MAX_POINT);
   A.y := random(100, MAX_POINT);
   
   B.x := random(SPACE, MAX_POINT);
   B.y := random(100, MAX_POINT);
   
   C.x := random(SPACE, MAX_POINT);
   C.y := random(100, MAX_POINT);
end;

procedure Run();
begin
   N := 1;
   Nfield.Text := FloatToStr(N);
   while true do begin
      NewPoints();
//      Triangle();
      Sleep(afterFillSleep);
      ClearZone();
      GraphABCprocedure();//процедура закраски из модуля GraphABC
      ClearZone();
      GraphABCprocedure2(); //тут что-то своё надо будет
      ClearZone();
      Sleep(afterLoopSleep);
      N := N + 1;
      Nfield.Text := FloatToStr(N);
   end;
end;  
   
procedure CreateInterface();
begin
   TextOut(SPACE, SPACE, 'Сравнительное исследование скорости алгоритмов закраски треугольников.');
   TextOut(SPACE, SPACE + TEXT_STEP, 'Разработка эффективных процедур закраски треугольника.');
   TextOut(SPACE, SPACE + 2*TEXT_STEP, 'Экспериментальное сравнение с процедурой из библиотеки GraphABC');
   
   Rectangle(SPACE, (SPACE + 3*TEXT_STEP), MAX_POINT, MAX_POINT);
   
   line(MAX_POINT + SPACE, 0, MAX_POINT + SPACE, WINDOW_HIGHT);
   
   GraphRes := new RoundRectABC(650, 300, 70, 20, 5, clWhite);
   GraphRes.TextScale := 1;
   GraphRes.Text := '0';
   
   GraphRes2 := new RoundRectABC(650, 400, 70, 20, 5, clWhite);
   GraphRes2.TextScale := 1;
   GraphRes2.Text := '0';
   
   avgGraphRes := new RoundRectABC(550, 300, 70, 20, 5, clWhite);
   avgGraphRes.TextScale := 1;
   avgGraphRes.Text := '0';
   
   avgGraphRes2 := new RoundRectABC(550, 400, 70, 20, 5, clWhite);
   avgGraphRes2.TextScale := 1;
   avgGraphRes2.Text := '0';
   
   TextOut(MAX_POINT + 2*SPACE, SPACE, 'Step:');
   Nfield := new RoundRectABC(MAX_POINT + 7*SPACE, SPACE, 70, 20, 5, clWhite);
   Nfield.TextScale := 1;
   Nfield.Text := '0'
end;
   
procedure Init();
begin
   Window.Clear;
   Window.Caption := 'graphics';
   window.Width := WINDOW_WIDTH;
   window.Height := WINDOW_HIGHT;
   Window.IsFixedSize := true;
   
   CreateInterface();
//   OnMouseDown := MouseDown;
end;

begin
   Init();
   Run();
end.
