//1.Xem thông tin về tất cả các công ty đang hợp tác với các hiệp hội, bao gồm cả chi nhánh và công việc mà họ đang cung cấp:

SELECT c.company_name, c.company_address, c.company_contact, c.company_email, a.asso_name, a.asso_manager, a.asso_contact, a.asso_email, b.branch_name, j.job_name, j.est_salary
FROM abroad.company c
INNER JOIN abroad.association a ON c.asso_id = a.asso_id
INNER JOIN abroad.branch b ON c.branch_id = b.branch_id
INNER JOIN abroad.job j ON c.job_id = j.job_id;

//2.Danh sách các công ty và số lượng tuyển dụng đang mở theo từng công việc, sắp xếp theo số lượng giảm dần:

SELECT c.company_name, j.job_name, COUNT(r.recruitment_id) AS num_recruitments
FROM abroad.recruitment r
INNER JOIN abroad.company c ON r.company_id = c.company_id
INNER JOIN abroad.job j ON r.job_id = j.job_id
GROUP BY c.company_name, j.job_name
ORDER BY num_recruitments DESC;

//3.Danh sách những công ty có số lượng nhân viên nghỉ việc cao nhất:

SELECT c.company_name, COUNT(wi.worker_id) AS num_resignations
FROM abroad.worker_information wi
INNER JOIN abroad.company c ON wi.company_id = c.company_id
WHERE wi.departure_date IS NOT NULL
GROUP BY c.company_name
ORDER BY num_resignations DESC;

//4.Danh sách các nhân viên và tỷ lệ nam/nữ trong doanh nghiệp:

SELECT staff_sex, COUNT(staff_id) AS num_employees, 
       COUNT(CASE WHEN staff_sex = 'NAM' THEN 1 ELSE NULL END) AS num_male,
       COUNT(CASE WHEN staff_sex = 'NỮ' THEN 1 ELSE NULL END) AS num_female
FROM domestic.staff
GROUP BY staff_sex;

//5.Danh sách các công ty và công việc mà họ đang cung cấp, bao gồm cả chi nhánh và mức lương ước tính:

SELECT c.company_name, b.branch_name, j.job_name, j.est_salary
FROM abroad.company c
INNER JOIN abroad.branch b ON c.branch_id = b.branch_id
INNER JOIN abroad.job j ON c.job_id = j.job_id;
