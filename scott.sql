-- SQL 쿼리문은 대소문자를 구별하지 않음
-- 단, 비밀번호는 구별함
-- DML : 데이터 조작어 (CRUD - Create / Read / Update / Delete)
-- 1) 조회
-- SELECT 컬럼명 -------------- ⑤
-- FROM 테이블명 --------------- ①
-- WHERE 조건절 ---------------- ②
-- GROUP BY 컬럼명 ------------- ③
-- HAVING 집계함수 조건절 --------- ④
-- ORDER BY 컬럼명.. ----------- ⑥


-- EMP(employee - 사원 테이블)
-- DEPT(department - 부서 테이블)
-- SALGRADE(급여 테이블)

-- 전체 조회
SELECT * FROM EMP;

-- 선택 조회
-- 1) 컬럼 지정
SELECT
	EMPNO,
	ENAME,
	MGR
FROM
	EMP e ;

-- 증복 조회 : distinct
SELECT DISTINCT DEPTNO 
FROM EMP e ;

-- 별칭
SELECT EMPNO AS "사원번호"
FROM EMP e ;

SELECT EMPNO "사원번호"
FROM EMP e ;

SELECT EMPNO AS "사원 번호"
FROM EMP e ;

--
SELECT EMPNO,ENAME, SAL,COMM ,SAL*12 + COMM AS "연봉"
FROM EMP e ;

-- 조회 후 정렬(오름차순- asc, 내림차순-desc)
-- sal 내림차순
SELECT ENAME,SAL 
FROM EMP e 
ORDER BY SAL DESC;

--SAL 오름차순 (ASC 생략가능)
SELECT ENAME,SAL 
FROM EMP e 
ORDER BY SAL ;

SELECT *FROM EMP e 
ORDER BY EMPNO DESC;

-- DEPTNO 오름차순, SAL 내림차순
SELECT*
	FROM EMP e
ORDER BY
	DEPTNO ASC,
	SAL DESC;
SELECT EMPNO AS "EMPLOYEE_NO",ENAME AS "EMPLOYEE_NAME",MGR AS "MANAGER",SAL AS "SALARY",COMM AS "COMMISSION",DEPTNO AS "DEPARTMENT_NO"
FROM EMP e
ORDER BY DEPTNO DESC,ENAME  ASC;

-- 선택 조회
-- 2) 조건 지정
-- SELECT 컬럼나열,.. FROM 테이블명 WHERE 조건 나열;

SELECT *FROM  EMP e WHERE DEPTNO = 30;

-- 사원번호가 7839 인 사원 조회
-- 사원번호 증복되지 않음
-- where 조건으로 증복되지 않는 값이 사용된다면 결과는 하나만 조회됨
SELECT *FROM  EMP e WHERE EMPNO = 7839;

-- 부서번호가 30이고(and) 직책이 salesman 인 사원 조회
-- 문자열은 홑따옴표만 사용

SELECT *FROM  EMP e WHERE DEPTNO =30 AND JOB ='SALESMAN';

-- 사원번호 7698이고 부서번호가 30인 사원조회
SELECT *FROM  EMP e WHERE DEPTNO =30 AND EMPNO = 7698;

-- 부서번호가 30 이거나 직책이 CLERK인 사원조회
SELECT *FROM  EMP e WHERE DEPTNO =30 OR JOB = 'CLERK';

-- 연봉이 36000 인 사원 조회
SELECT * FROM  EMP e WHERE SAL*12 = 36000;

-- 급여가 3000보다 큰 사원 조회
SELECT * FROM  EMP e WHERE E.SAL > 3000;
-- 급여가 3000이상인 사원 조회
SELECT * FROM  EMP e WHERE E.SAL >= 3000;

-- ENAME >'F'
SELECT * FROM  EMP e WHERE  E.ENAME >='F';

-- 급여가 2500 이상이고 직업이 ANALYST 인 사원 조회
SELECT * FROM  EMP e WHERE E.SAL >=2500 AND e.JOB = 'ANALYST';

--JOB이 MANAGER, SALESMAN, CLERK인 사원 조회
SELECT * FROM  EMP e WHERE E.JOB ='MANAGER' OR E.JOB= 'SALESMAN' OR E.JOB= 'CLERK';

-- SAL 이 3000 이 아닌 사원 조회
-- !=, <>, ^=
SELECT * FROM  EMP e WHERE SAL != 3000;

SELECT * FROM  EMP e WHERE SAL <> 3000;

SELECT * FROM  EMP e WHERE SAL ^= 3000;

-- IN
SELECT *FROM EMP e WHERE JOB IN ('MANAGER','SALESMAN','CLERK');
--JOB이 MANAGER, SALESMAN, CLERK이 아닌 사원 조회
SELECT * FROM  EMP e WHERE E.JOB !='MANAGER' AND E.JOB!= 'SALESMAN' AND E.JOB!= 'CLERK';
SELECT *FROM EMP e WHERE JOB NOT IN ('MANAGER','SALESMAN','CLERK');


-- 부서 번호가 10번 이거나 20번인 사원 조회
SELECT *FROM EMP e WHERE E.DEPTNO = 10 OR E.DEPTNO= 20;
SELECT *FROM EMP e WHERE E.DEPTNO IN (10,20);

-- BETWEEN A AND B : 일정 범위 내의 데이터 조회 시 사용
-- 급여가 2000 이상이고 3000 이하인 직원 조회
SELECT *FROM EMP e WHERE E.SAL BETWEEN 2000 AND 3000;

--NOT BETWEEN A AND B : 일정 범위가 아닌 데이터 조회 시 사용
-- 급여가 2000 이상이고 3000 이하가 아닌 직원 조회
SELECT *FROM EMP e WHERE E.SAL NOT BETWEEN 2000 AND 3000;

--LIKE 연산자와 와일드 카드(%, _)
-- ENAME = 'JONES' : 전체 일치
-- ENAME 이 J로 시작하는 or A가 들어간.. : 부분 일치 (LIKE)

-- J로 시작하면 그 뒤에 어떤 문자가 몇개가 오던지 상관 없음
SELECT *FROM EMP WHERE ENAME LIKE 'J%';

-- _J% : 어떤 문자로 시작해도 상관 없으나 개수는 하나 / 두번째 문자는 J / 그 뒤에 어떤 문자가 몇개가 오던지 상관 없음
SELECT *FROM EMP WHERE ENAME LIKE '_J%';

SELECT *FROM EMP WHERE ENAME LIKE '_L%';

-- 사원명에 AM 문자가 포함 된 사원 조회
SELECT *FROM EMP WHERE ENAME LIKE '%AM%';

-- 사원명에 AM 문자가 포함 되지 않는 사원 조회
SELECT *FROM EMP WHERE ENAME NOT LIKE '%AM%';

--IS NULL
-- SELECT *FROM EMP W WHERE COMM = NULL; (X)
SELECT *FROM EMP WHERE COMM IS NULL;
SELECT *FROM EMP WHERE COMM IS NOT NULL;


-- 집합 연산자
-- UNION : 합집합(결과 값의 증복 제거)
-- UNION ALL : 합집합 (증복)
-- MINUS : 차집합
-- INTERSECT : 교집합

-- UNION
-- 부서번호가 10번인 사원 조회(사번, 이름, 급여, 부서번호)
-- 부서번호가 20번인 사원 조회(사번, 이름, 급여) => 컬럼이 동일해야 함
SELECT E.EMPNO,E.ENAME,E.SAL,E.DEPTNO
FROM EMP e 
WHERE E.DEPTNO =10
UNION
SELECT E.EMPNO,E.ENAME,E.SAL,E.DEPTNO
FROM EMP e 
WHERE E.DEPTNO =20;


SELECT E.EMPNO,E.ENAME,E.SAL,E.DEPTNO
FROM EMP e 
WHERE E.DEPTNO =10
UNION ALL
SELECT E.EMPNO,E.ENAME,E.SAL,E.DEPTNO
FROM EMP e 
WHERE E.DEPTNO =10;


SELECT E.EMPNO,E.ENAME,E.SAL,E.DEPTNO
FROM EMP e 
MINUS
SELECT E.EMPNO, E.ENAME,E.SAL,E.DEPTNO
FROM EMP e 
WHERE E.DEPTNO =10;

SELECT E.EMPNO,E.ENAME,E.SAL,E.DEPTNO
FROM EMP e 
INTERSECT
SELECT E.EMPNO, E.ENAME,E.SAL,E.DEPTNO
FROM EMP e 
WHERE E.DEPTNO =10;
