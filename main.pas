program main;

uses
   GraphABC;

type
   tPoint = record
      x: integer;
      y: integer;
   end;
var
   A, B, C: tPoint;

procedure Init();
const
   max_point = 500;
begin
   Window.Caption := 'graphics';
   window.Width := 750;
   window.Height := 600;
   Window.IsFixedSize := true;
   
   TextOut(10, 0, 'Сравнительное исследование скорости алгоритмов закраски треугольников (минимум три эффективных алгоритма).');
   TextOut(10, 15, 'Разработка эффективных процедур закраски треугольника.');
   TextOut(10, 30, 'Экспериментальное сравнение с процедурой из библиотеки GraphABC');
   
   rectangle(10, 45, max_point, max_point);
   
   A.x := random(10, max_point);
   A.y := random(45, max_point);
   
   B.x := random(10, max_point);
   B.y := random(45, max_point);
   
   C.x := random(10, max_point);
   C.y := random(45, max_point);
end;

procedure Rectangle(A, B, C: tPoint);
begin
   line(A.x, A.y, B.x, B.y);
   line(B.x, B.y, C.x, C.y);
   line(C.x, C.y, A.x, A.y);
end;

begin
   while true do begin
      Init();
      Rectangle(A, B, C);
      sleep(1000);
   end;
   
end.
