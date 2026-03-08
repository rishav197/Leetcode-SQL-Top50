select w1.id from Weather w1, Weather w2 
    where date_sub(w1.recordDate, interval 1 day)=w2.recordDate and w1.temperature>w2.temperature;