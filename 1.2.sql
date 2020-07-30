with query1 as(
select section_id, count(student_id) as students_count
from enrollment group by section_id)
select section.course_no, course.description, query1.students_count,section.capacity
from ((section left join course on section.course_no=course.course_no
inner join query1 on query1.section_id=section.section_id))
