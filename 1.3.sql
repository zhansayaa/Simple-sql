with query1 as(
select grade.student_id, grade.GRADE_TYPE_CODE, avg(NUMERIC_GRADE) as average,
grade_type_weight.section_id from grade
left join GRADE_TYPE_weight on
grade.section_id=GRADE_TYPE_weight.section_id
group by grade.student_id,grade.grade_type_code, GRADE_TYPE_weight.section_id),
query2 as(
select sum(average*PERCENT_OF_FINAL_GRADE/100) finalmark,query1.student_id, query1.section_id
from grade_type_weight gtw left join query1 on gtw.GRADE_TYPE_CODE=query1.GRADE_TYPE_CODE and gtw.section_id=query1.section_id
group by query1.student_id, query1.section_id)
select student_id, section_id, finalmark, letter_grade from grade_conversion, query2
where finalmark<=max_grade and finalmark>=min_grade
