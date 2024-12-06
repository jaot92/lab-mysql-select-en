USE publications;

-- Challenge 1
SELECT 
    ta.au_id AS 'AUTHOR ID',
    a.au_lname AS 'LAST NAME',
    a.au_fname AS 'FIRST NAME',
    t.title AS 'TITLE',
    p.pub_name AS 'PUBLISHER'
FROM titleauthor ta
JOIN authors a ON ta.au_id = a.au_id
JOIN titles t ON ta.title_id = t.title_id
JOIN publishers p ON t.pub_id = p.pub_id
ORDER BY ta.au_id;

-- Verificacion Challenge 1
SELECT COUNT(*) FROM titleauthor;

-- Challenge 2

SELECT 
    a.au_id AS 'AUTHOR ID',
    a.au_lname AS 'LAST NAME',
    a.au_fname AS 'FIRST NAME',
    p.pub_name AS 'PUBLISHER',
    COUNT(*) AS 'TITLE COUNT'
FROM authors a
JOIN titleauthor ta ON a.au_id = ta.au_id
JOIN titles t ON ta.title_id = t.title_id
JOIN publishers p ON t.pub_id = p.pub_id
GROUP BY a.au_id, p.pub_id
ORDER BY a.au_id;

-- Verificación del total de registros en titleauthor
SELECT COUNT(*) as total_titleauthor FROM titleauthor;

-- Verificación de la suma de TITLE COUNT
SELECT SUM(title_count) as sum_title_count
FROM (
    SELECT 
        COUNT(ta.title_id) as title_count
    FROM titleauthor ta
    JOIN authors a ON ta.au_id = a.au_id
    JOIN titles t ON ta.title_id = t.title_id
    JOIN publishers p ON t.pub_id = p.pub_id
    GROUP BY a.au_id, a.au_lname, a.au_fname, p.pub_name
) as subquery;

-- Challenges 3
SELECT 
    a.au_id AS 'AUTHOR ID',
    a.au_lname AS 'LAST NAME',
    a.au_fname AS 'FIRST NAME',
    COALESCE(SUM(s.qty), 0) AS 'TOTAL'
FROM authors a
LEFT JOIN titleauthor ta ON a.au_id = ta.au_id
LEFT JOIN titles t ON ta.title_id = t.title_id
LEFT JOIN sales s ON t.title_id = s.title_id
GROUP BY a.au_id
ORDER BY TOTAL DESC
LIMIT 3;

-- Challenge 4
SELECT 
    a.au_id AS 'AUTHOR ID',
    a.au_lname AS 'LAST NAME',
    a.au_fname AS 'FIRST NAME',
    COALESCE(SUM(s.qty), 0) AS 'TOTAL'
FROM authors a
LEFT JOIN titleauthor ta ON a.au_id = ta.au_id
LEFT JOIN titles t ON ta.title_id = t.title_id
LEFT JOIN sales s ON t.title_id = s.title_id
GROUP BY a.au_id
ORDER BY TOTAL DESC;
