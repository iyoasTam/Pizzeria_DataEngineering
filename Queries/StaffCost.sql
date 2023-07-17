------------------------------------
/* shift_id as a foreign key was in a format of (sh001,sh002). So I had to change it to a normal integer ID
with the following code using SUBSTRING */

UPDATE shiftTable
SET shift_id = CAST(SUBSTRING(shift_id, 3, LEN(shift_id) - 2) AS INT)


/*start_time and end_time columns have a varchar datatype so I changed
 to datetime datatype. */

ALTER TABLE [dbo].[shiftTable] ALTER COLUMN [start_time] datetime
ALTER TABLE [dbo].[shiftTable] ALTER COLUMN [end_time] datetime;
-------------------------------------
--Daily cost to pay for the staff members

SELECT	ro.date,
		s.first_name,
		s.last_name,
		s.hourly_rate,
		sh.start_time,
		sh.end_time,
		--ROUND(((datediff(hour,sh.start_time,sh.end_time)*60)+
		((datediff(minute,sh.start_time,sh.end_time)))/60.0 as hours_in_shift,

		--ROUND(((datediff(hour,sh.start_time,sh.end_time)*60)+
		(((datediff(minute,sh.start_time,sh.end_time)))/60.0 * s.hourly_rate) as Staff_cost_in_$

FROM rotaTable ro
	LEFT JOIN staffTable s
		ON ro.staff_id = s.staff_id
	LEFT JOIN shiftTable sh
		ON ro.shift_id = sh.shift_id