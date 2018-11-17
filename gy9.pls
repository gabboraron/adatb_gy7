create or replace function  hello2(nev VARCHAR2) return VARCHAR2 is
    nev2 VARCHAR2(10) := nev;
begin
    nev2 := 'Jozsi';
    return 'Hello ' || nev2;
end hello2;

/*
DECLARE
    nev VARCHAR2(10) :='PETI';
BEGIN
    DBMS_OUTPUT.PUT_LINE(hello2(nev));
END;
*/

-- set serveroutput on;
select hello2('Béla') from dual;
select SUBSTR('alma', 1, 1) from dual;


DECLARE
    szoveg VARCHAR2(20) := 'almafa123456789';
BEGIN
    for i in 1..LENGTH(szoveg) LOOP
        dbms_output.put_line(SUBSTR(szoveg, i, 1));
    end LOOP;
END;

--------- FELADATOK ---------

/*2, Prím-e Függvény 
   SELECT prim(263062) from dual;*/
   
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

Select prim(dkod), dolgozo.* from dolgozo where prim(dkod) = 1;
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


/*3, N. fibonacci függvény
   select fib(10) from dual;*/
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

/*4, LNKO függvény
   select lnko(80,100) from dual;*/
create or replace function  lnko(a int, b int) return int is   
begin
    for i in reverse 1..a loop
        if MOD(a,i)=0 and MOD(b,i)=0 then
            return i;
        end if;
    end loop;
end; 

select lnko(80,100) from dual;

/*5, Faktoriális függvény
   select faktor(5) from dual;*/
   
create or replace function  faktor(n int) return int is   
    myresult int := 1;
begin
    for i in 1..n loop
        myresult := myresult * i;
    end loop;
    return myresult;
end;   

select faktor(5) from dual;


/*6, Hanyszor fordul elõ egy szövegben egy másik string
   SELECT hanyszor ('ab c ab ab de ab fg a', 'ab') FROM dual;*/
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

