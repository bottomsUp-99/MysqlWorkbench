-- 커서
delimiter $$
create procedure customerHeightAVGProc()
begin
	declare userheight int; -- 고객 키
    declare cnt int default 0; -- 고객의 인원 수
    declare totalheight int default 0; -- 고객의 키 합계

    declare endOfRow boolean default false; -- 행의 끝 여부(기본은 false로 둔다.)

    declare userCursor cursor for
		select height from usertbl;

	declare continue handler for not found set endOfRow = true; -- 행의 끝이면 endrow 변수에 true 대입.
    open userCursor;

    c_loop : loop -- 그냥 loop만 해도 됨. C_LOOP는 그냥 따로 라벨링 한겨.
			fetch userCursor into userheight;
				if endOfRow then
					leave c_loop;
				end if;
			set cnt = cnt + 1;
            set totalheight = totalheight + userHeight;
            end loop c_loop;
	select concat('고객의 키 평균 =>', (totalheight/cnt));
    close userCursor;
end $$
delimiter ;
call customerHeightAVGProc;