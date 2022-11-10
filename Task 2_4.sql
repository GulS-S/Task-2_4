-- task 2
-- a.     Попробуйте вывести не просто самую высокую зарплату во всей команде, 
--а вывести именно фамилию сотрудника 
--с самой высокой зарплатой.

SELECT fio, salary_level AS MAX_SALARY 
FROM public.employees WHERE salary_level = (SELECT MAX(salary_level) FROM public.employees)

--b. Попробуйте вывести фамилии сотрудников в алфавитном порядке

SELECT *FROM public.employees ORDER BY fio 


--c.Рассчитайте средний стаж для каждого уровня сотрудников

SELECT employee_level, AVG((current_date)-(start_date))  as experience  FROM public.employees
		GROUP BY employee_level;

--d. Выведите фамилию сотрудника и название отдела, в котором он работает

SELECT fio, department_id FROM public.employees WHERE fio = 'Сидоров' 

--e.Выведите название отдела и фамилию сотрудника с самой высокой зарплатой в данном отделе и саму зарплату также.
		-- сотрудники с самой большой зп в каждом отделе
		-- 1 вариант
SELECT fio, department_id, salary_level AS MAX_SALARY 
FROM public.employees WHERE (department_id, salary_level) 
IN (SELECT department_id, MAX(salary_level) FROM public.employees GROUP BY department_id)


		-- 2 вариант
SELECT employees.fio,departments.name_department,employees.salary_level
FROM employees,departments
WHERE salary_level IN (
	SELECT MAX(employees.salary_level) AS maxsal
	FROM employees INNER JOIN departments ON employees.department_id = name_department
	GROUP BY departments.name_department) AND employees.department_id = name_department; 

		-- сотрудник одного отдела с высокой зп
SELECT fio, department_id, salary_level FROM public.employees WHERE 
salary_level=(SELECT MAX(salary_level) FROM public.employees 
			  WHERE department_id = 'отдел Интеллектуального анализа данных' )	