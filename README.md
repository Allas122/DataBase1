# Лабораторная работа 1
# Постановка задачи
Назначение системы: Автоматизация учета успеваемости студентов в учебном заведении.
## Сущности: 
Студенты (ФИО, номер зачетной книжки, дата рождения, группа)
Дисциплины (наименование, общее количество часов)
Преподаватели (ФИО, кафедра)
Оценки (дата экзамена, оценка)
## Процессы: 
Студенты сдают экзамены по дисциплинам
Преподаватели принимают экзамены и выставляют оценки
Каждая оценка связана с конкретным студентом, дисциплиной и преподавателем
# Модель базы данных учебного заведения

Логическая модель базы данных для системы учета успеваемости студентов.

## Структура базы данных

### Таблица: Students (Студенты)

Хранит информацию о студентах.

| Поле | Тип | Ограничения | Описание |
|------|-----|-------------|-----------|
| student_id | SERIAL | PRIMARY KEY | Уникальный идентификатор студента |
| full_name | VARCHAR(255) | NOT NULL | Фамилия Имя Отчество студента |
| record_book_number | VARCHAR(20) | UNIQUE, NOT NULL | Номер зачетной книжки |
| birth_date | DATE | NOT NULL | Дата рождения |
| group_name | VARCHAR(10) | NOT NULL | Учебная группа |

### Таблица: Subjects (Дисциплины)

Содержит перечень учебных дисциплин.

| Поле | Тип | Ограничения | Описание |
|------|-----|-------------|-----------|
| subject_id | SERIAL | PRIMARY KEY | Уникальный идентификатор дисциплины |
| name | VARCHAR(255) | UNIQUE, NOT NULL | Наименование дисциплины |
| total_hours | INTEGER | NOT NULL | Общее количество часов |

### Таблица: Teachers (Преподаватели)

Хранит информацию о преподавателях.

| Поле | Тип | Ограничения | Описание |
|------|-----|-------------|-----------|
| teacher_id | SERIAL | PRIMARY KEY | Уникальный идентификатор преподавателя |
| full_name | VARCHAR(255) | NOT NULL | Фамилия Имя Отчество преподавателя |
| department | VARCHAR(100) | NOT NULL | Кафедра |

### Таблица: Grades (Оценки)

Содержит информацию об оценках студентов.

| Поле | Тип | Ограничения | Описание |
|------|-----|-------------|-----------|
| grade_id | SERIAL | PRIMARY KEY | Уникальный идентификатор оценки |
| student_id | INTEGER | FOREIGN KEY REFERENCES Students(student_id) | Ссылка на студента |
| subject_id | INTEGER | FOREIGN KEY REFERENCES Subjects(subject_id) | Ссылка на дисциплину |
| teacher_id | INTEGER | FOREIGN KEY REFERENCES Teachers(teacher_id) | Ссылка на преподавателя |
| exam_date | DATE | NOT NULL | Дата проведения экзамена |
| grade | INTEGER | CHECK (grade BETWEEN 2 AND 5) | Оценка (от 2 до 5) |

## Связи между таблицами

- **Students → Grades**: Один ко многим (один студент может иметь много оценок)
- **Subjects → Grades**: Один ко многим (по одной дисциплине может быть много оценок)
- **Teachers → Grades**: Один ко многим (один преподаватель может выставить много оценок)

## Бизнес-правила

1. Номер зачетной книжки должен быть уникальным для каждого студента
2. Наименование дисциплины должно быть уникальным
3. Оценка должна быть в диапазоне от 2 до 5
4. Каждая оценка связана с конкретным студентом, дисциплиной и преподавателем
5. Дата экзамена обязательна для заполнения

# Физическая модель
```sql
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
```







