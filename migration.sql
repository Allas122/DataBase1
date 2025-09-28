BEGIN;
CREATE TABLE Students (
    student_id SERIAL PRIMARY KEY,
    full_name VARCHAR(255) NOT NULL,
    record_book_number VARCHAR(20) UNIQUE NOT NULL,
    birth_date DATE,
    group_name VARCHAR(10)
);

CREATE TABLE Subjects (
    subject_id SERIAL PRIMARY KEY,
    name VARCHAR(255) UNIQUE NOT NULL,
    total_hours INTEGER
);

CREATE TABLE Teachers (
    teacher_id SERIAL PRIMARY KEY,
    full_name VARCHAR(255) NOT NULL,
    department VARCHAR(100)
);

CREATE TABLE Grades (
    grade_id SERIAL PRIMARY KEY,
    student_id INTEGER NOT NULL,
    subject_id INTEGER NOT NULL,
    teacher_id INTEGER NOT NULL,
    exam_date DATE NOT NULL,
    grade INTEGER NOT NULL CHECK (grade >= 2 AND grade <= 5),

    CONSTRAINT fk_student
        FOREIGN KEY(student_id)
        REFERENCES Students(student_id)
        ON DELETE CASCADE,

    CONSTRAINT fk_subject
        FOREIGN KEY(subject_id)
        REFERENCES Subjects(subject_id)
        ON DELETE RESTRICT,

    CONSTRAINT fk_teacher
        FOREIGN KEY(teacher_id)
        REFERENCES Teachers(teacher_id)
        ON DELETE SET NULL
);

CREATE INDEX idx_grades_student_id ON Grades (student_id);
CREATE INDEX idx_grades_subject_id ON Grades (subject_id);
CREATE INDEX idx_grades_teacher_id ON Grades (teacher_id);
END;