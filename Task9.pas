program Task9;

uses
   graphABC, Timers, ABCobjects, BGL;

const
   N_MAX = 20;

   MAX_POINT = 500;
   
   SPACE= 5;
   TEXT_AREA = 55;
   
   WINDOW_WIDTH = BGL.SizeX;
   WINDOW_HIGHT = BGL.SizeY;
   
   afterFillSleep = 300;   
var
   n: integer;
   A, B, C: tPoint;
   FillPolygonArray, SquereMethodArray, BarycentricArray, FastArray: array[1..N_MAX] of real;
   f: text;

procedure CreateNewFile();
const
   filename = ParamStr(1);
var
   i: integer;
begin
   Console.WriteLine('Результат будет записан в файл: ' + filename);
   Console.WriteLine('Запись...');
   Assign(f, filename);
   Rewrite(f);
   
//   FillPolygonArray (GraphABC)
   Writeln(f, 'FillPolygon:');
   for i := 1 to N_MAX do begin
      Writeln(f, FillPolygonArray[i])
   end;
//   SquereMethod (Моё очевидное)
   Writeln(f, 'SquereMethod:');
   for i := 1 to N_MAX do begin
      Writeln(f, SquereMethodArray[i])
   end;
//   Barycentric (Взял в интернете)
   Writeln(f, 'Barycentric:');
   for i := 1 to N_MAX do begin
      Writeln(f, BarycentricArray[i])
   end;
//   FastArray
   Writeln(f, 'FastArray:');
   for i := 1 to N_MAX do begin
      Writeln(f, FastArray[i])
   end;
   Close(f);
   Console.WriteLine('Данные успешно записаны.');
   Console.WriteLine('Автоматическое завершение программы через 5 секунд.');
   for i := 1 to 5 do begin
      Console.Write(i + ' ');
      sleep(1000);
   end;
   Console.WriteLine();
   Console.Write('Выполнение программы завершено.');
   Halt;
end;

procedure NewPoints();
begin
   A.x := random(0, BGL.SizeX);
   A.y := random(0, BGL.SizeY);
   
   B.x := random(0, BGL.SizeX);
   B.y := random(0, BGL.SizeY);
   
   C.x := random(0, BGL.SizeX);
   C.y := random(0, BGL.SizeY);
   
   Console.WriteLine('треугольник: A:(x=' + A.x + ', y=' + A.y + '), B(x=' + B.x + ', y=' + B.y + '), C(x=' + C.x + ', y=' + C.y + ')');
end;

procedure FillPolygonMethod();
var
   T0, T: real;
begin
   SetColor(Black);
   T0 := Milliseconds;
   FillPolygon((A.x, A.y), (B.x, B.y), (C.x, C.y));
   Draw;
   T := Milliseconds - T0;
   sleep(afterFillSleep);
   FillPolygonArray[n] := T;
   Console.WriteLine('FillPolygon: ' + T);
   Window.Clear;
end;

procedure SquereMethod();
var
   T0, T: real;
begin
   SetColor(Red);
   T0 := Milliseconds;
   SquareFill(A, B, C);
   Draw;
   T := Milliseconds - T0;
   sleep(afterFillSleep);
   SquereMethodArray[n] := T;
   Console.WriteLine('SquereMethod: ' + T);
   ClearDevice;
end;

procedure Barycentric();
var
   T0, T: real;
begin
   SetColor(Blue);
   T0 := Milliseconds;
   BarycentricFill(A, B, C);
   Draw;
   T := Milliseconds - T0;
   sleep(afterFillSleep);
   BarycentricArray[n] := T;
   Console.WriteLine('Barycentric: ' + T);
   ClearDevice;
end;

procedure Fast();
var
   T0, T: real;
begin
   SetColor(Green);
   T0 := Milliseconds;
   FastFill(A, B, C);
   Draw;
   T := Milliseconds - T0;
   sleep(afterFillSleep);
   FastArray[n] := T;
   Console.WriteLine('Fast: ' + T);
   ClearDevice;
end;


procedure Run();
begin
   n := 0;
   while n < N_MAX do begin
      n := n + 1;
      Console.WriteLine('> ' + n + ' шаг:');
      NewPoints();
      FillPolygonMethod(); Draw;
      SquereMethod(); Draw;
      Barycentric(); Draw;
      Fast(); Draw;
   end;
   CreateNewFile();
end;  
      
procedure Init();
begin
   Console.WriteLine('Автор программы: Сысоев Эдуард (ПМ-31).');
   Console.WriteLine('Вологда 2021г.');
   Console.WriteLine();
   Console.WriteLine('Инициализация...');
   Window.Caption := 'sysoev_eduard_9';
   
   ClearDevice;
   
   Window.Width := BGL.SizeX;
   Window.Height := BGL.SizeY;
   SetBkColor(White);
   Draw;
   Window.IsFixedSize := true;
//   CreateInterface(); а ведь когда-то у кода был красивый интерфейс... :(
   Console.WriteLine('Инициализация завершена.');
end;

begin
   Init();
   Run();
end.