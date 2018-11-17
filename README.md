# GY9
> http://vopraai.web.elte.hu/tananyag/adatb1819/8.ora/feladat.txt
## PLSQL
> oracle specifikus nyelv
> a stringek 1 től indexelődnek
> `0` kat furán kezeli


### Függvények:
`function` visszatérési értékkel és `procedure` nincs visszatérési érték
`begin` és `end` közé kerül a kód
változó létrehozása:

`valtozonev típus:= 'érték';`

kiíratás:
````PLSQL

BEGIN
   --PROGRAMBLOKK
   dbms_output.put_line(); -- KIIRATÁS
END;

````

függvény létrehozás:
````PLSQL

CREATE OR REPLACE FUNCTION függvény_neve(n integer) RETURN number IS

````

Hello world:
````PLSQL

create or replace procedure hello is
begin
    dbms_output.put_line('hello');
end hello;

set serveroutput on;
call hello();
````

Értékátadással:
````PLSQL
create or replace procedure hello(nev VARCHAR2) is
begin
    dbms_output.put_line('hello ' || nev);
end hello;

set serveroutput on;
call hello('Béla');
````


váltózó vagy érték:
````PLSQL
create or replace procedure hello(nev VARCHAR2) is
    szoveg VARCHAR2(10) := 'Hello'; /*ha parméterként veszem át akkor nem adom meg milyen hosszú ha változóként veszem át akkor meg kell monsni a változó méretét*/
begin
    dbms_output.put_line('hello ' || nev);
end hello;

set serveroutput on;
call hello('Béla');
````

for ciklus:
````PLSQL
create or replace procedure hello(nev VARCHAR2, n int) is
    szoveg VARCHAR2(10) := 'Hello'; /*ha parméterként veszem át akkor nem adom meg milyen hosszú ha változóként veszem át akkor meg kell monsni a változó méretét*/
begin
    for i in 1..n loop
        dbms_output.put_line('hello ' || nev);
    end loop;
end hello;

set serveroutput on;
call hello('Béla', 10);
````
vissszafele iterálás:
````PLSQL
create or replace procedure hello(nev VARCHAR2, n int) is
    szoveg VARCHAR2(10) := 'Hello'; /*ha parméterként veszem át akkor nem adom meg milyen hosszú ha változóként veszem át akkor meg kell monsni a változó méretét*/
begin
    for i in reverse 1..n loop
        dbms_output.put_line('hello ' || nev || i);
    end loop;
end hello;

set serveroutput on;
call hello('Béla', 10);
````

if:
````PLSQL
create or replace procedure hello(nev VARCHAR2, n int) is
    szoveg VARCHAR2(10) := 'Hello'; /*ha parméterként veszem át akkor nem adom meg milyen hosszú ha változóként veszem át akkor meg kell monsni a változó méretét*/
begin
    for i in reverse 1..n loop
        if mod(i,2) = 0 then
           dbms_output.put_line(szoveg || i || '-'|| nev);
        elsif mod (i,2)=1 then
           dbms_output.put_line('paratlan');
        else
           dbms_output.put_line('lehetetlen');
        end if;
    end loop;
end hello;

set serveroutput on;
call hello('Béla', 10);
````

function:
````PLSQL
create or replace function  hello2(nev VARCHAR2) return VARCHAR2 is
begin
    return 'Hello ' || nev;
end hello2;

set serveroutput on;
select hello2('Béla') from dual;
````

declare és `in out` paraméterezése és meghívása:
````PLSQL
create or replace function  hello2(nev in out VARCHAR2) return VARCHAR2 is
begin
    nev := 'Jozsi';
    return 'Hello ' || nev;
end hello2;

DECLARE
    nev VARCHAR2(10) :='PETI';
BEGIN
    DBMS_OUTPUT.PUT_LINE(hello2(nev));
END;
````


`in out kijátszása beslő változóval:
````PLSQL
create or replace function  hello2(nev VARCHAR2) return VARCHAR2 is
    nev2 VARCHAR2(10) := nev;
begin
    nev2 := 'Jozsi';
    return 'Hello ' || nev2;
end hello2;

select hello2('Béla') from dual;
````

string alstringje:
````PLSQL

select SUBSTR('alma', 1, 1) from dual;

DECLARE
    szoveg VARCHAR2(20) := 'almafa123456789';
BEGIN
    for i in 1..LENGTH(szoveg) LOOP
        dbms_output.put_line(SUBSTR(szoveg, i, 1));
    end LOOP;
END;
````

> 2, Prím-e Függvény 
````PLSQL
create or replace function  prim(szam int) return int is
    
    /*prime boolean := true;*/
begin
    if szam = 2 then
        return 0;
    for i in 2.. SQRT(szam) LOOP
        if mod(szam,i) = 0 then
            --prime := false;
           return 0;
        end if;
    end loop;    
    
    /*if prime then
        dbms_output.put_line('Prim');
    else
        dbms_output.put_line('Nem Prim');
    end if;*/
    return 1;
end prim;

SELECT prim(263062) from dual;
````
> táblázattal összefűzve:
````PLSQL
Select prim(dkod), dolgozo.* from dolgozo where prim(dkod) = 1;
````

> 3, N. fibonacci függvény
````PLSQL
create or replace function  fib(szam int) return int is   
  begin
    if szam <= 0 then
        return 0;
    elsif szam = 1 then
        return 1;
    else
        return fib(szam-1) + fib(szam-2);
    end if;
end fib;

select fib(10) from dual;
````

> 4, LNKO függvény
````PLSQL
create or replace function  lnko(a int, b int) return int is   
begin
    for i in reverse 1..a loop
        if MOD(a,i)=0 and MOD(b,i)=0 then
            return i;
        end if;
    end loop;
end; 

select lnko(80,100) from dual;
````

> 5, Faktoriális függvény

````PLSQL
create or replace function  faktor(n int) return int is   
    myresult int := 1;
begin
    for i in 1..n loop
        myresult := myresult * i;
    end loop;
    return myresult;
end;   

select faktor(5) from dual;
````


> Hanyszor fordul elő egy szövegben egy másik string
````PLSQL
create or replace function  hanyszor(a VARCHAR2, b VARCHAR2) return int is
    res int :=0;
begin
    for i in 1..length(a)-length(b)+1 loop
        if SUBSTR(a, i, LENGTH(b)) = b then
            res := res +1;
        end if;
    end loop;
    return res;
end;   

SELECT hanyszor ('ab c ab ab de ab fg a', 'ab') FROM dual;
````
