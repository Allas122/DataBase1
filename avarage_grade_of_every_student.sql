SELECT
    s.full_name AS "Student Name",
    sub.name AS "Subject",
    AVG(g.grade) AS "Average Grade"
FROM
    Grades AS g
JOIN
    Students AS s ON g.student_id = s.student_id
JOIN
    Subjects AS sub ON g.subject_id = sub.subject_id
GROUP BY
    s.full_name,
    sub.name
ORDER BY
    s.full_name,
    "Average Grade" DESC;