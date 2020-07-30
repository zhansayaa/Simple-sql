with table1 as(select grade.student_id, grade.GRADE_TYPE_CODE, avg(NUMERIC_GRADE) as average,
grade_type_weight.section_id
from grade left join GRADE_TYPE_weight on
grade.section_id=GRADE_TYPE_weight.section_id
group by grade.student_id,
grade.grade_type_code, GRADE_TYPE_weight.section_id),
table2 as(
select sum(average*PERCENT_OF_FINAL_GRADE/100) finalmark,table1.student_id, table1.section_id
from grade_type_weight gtw
left join table1 on gtw.GRADE_TYPE_CODE=table1.GRADE_TYPE_CODE and gtw.section_id=table1.section_id
group by table1.student_id, table1.section_id
)
select student_id, section_id, finalmark from table2
