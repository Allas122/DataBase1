SELECT
    s.full_name AS "Student Name",
    s.group_name,
    AVG(g.grade) AS "Average Grade in Databases"
FROM
    Grades AS g
JOIN
    Students AS s ON g.student_id = s.student_id
JOIN
    Subjects AS sub ON g.subject_id = sub.subject_id
WHERE
    sub.name = 'Databases'
GROUP BY
    s.full_name,
    s.group_name
ORDER BY
    "Average Grade in Databases" DESC
LIMIT 3;