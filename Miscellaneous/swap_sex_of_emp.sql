-- approach: using IF() 
update Salary
set sex=if(sex='m', 'f', 'm');


-- approach: using Case statement
update Salary
set sex=
        case 
            when sex='m' then 'f'
            else 'm'
        end;


