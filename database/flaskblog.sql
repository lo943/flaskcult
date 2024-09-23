-- ----------------------------- --
-- Banco de dados para FlaskBlog --
-- ----------------------------- --
-- Versão MySQL / MariaDB        --
-- ----------------------------- --

-- Apaga o banco de dados se ele existir
-- PERIGO! Só faça isso em tempo de desenvolvimento
DROP DATABASE IF EXISTS flaskblogdb;

-- (Re)cria o banco de dados
-- PERIGO! Só faça isso em tempo de desenvolvimento
CREATE DATABASE flaskblogdb
	-- Usando a tabela de caracteres universal extendida
	CHARACTER SET utf8mb4
    -- Buscas também em utf8 e case insensitive
    COLLATE utf8mb4_general_ci;

-- Seleciona o banco de dados para os próximos comandos
USE flaskblogdb;

-- Cria a tabela 'staff' conforme o modelo lógico
CREATE TABLE staff (
	-- Define o id como chave primária
	emp_id INT PRIMARY KEY AUTO_INCREMENT,
    -- Define a data com valor do sistema
    emp_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    -- Define o nome do usuário com 127 caracteres
    emp_name VARCHAR(127) NOT NULL,
    -- Define o email do usuário com 255 caracteres (RFC)
    emp_email VARCHAR(255) NOT NULL,
    emp_password VARCHAR(63) NOT NULL,
    emp_image VARCHAR(255),
    -- Data em formato ISO / System Date
    emp_birth DATE NOT NULL,
    emp_description VARCHAR(255),
    emp_type ENUM('admin', 'author', 'moderator') DEFAULT 'moderator',
	emp_status ENUM('on', 'off', 'del') DEFAULT 'on'
);

-- Cria a tabela 'article' conforme o modelo lógico
CREATE TABLE article (
	art_id INT PRIMARY KEY AUTO_INCREMENT,
    art_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    art_author INT NOT NULL,
    art_title VARCHAR(127) NOT NULL,
    art_resume VARCHAR(255) NOT NULL,
    art_thumbnail VARCHAR(255) NOT NULL,
    art_content TEXT NOT NULL,
    art_views INT NOT NULL DEFAULT 0,
    art_status ENUM('on', 'off', 'del') DEFAULT 'on',
    FOREIGN KEY (art_author) REFERENCES staff (emp_id)
);

-- Cria a tabela 'comment' conforme o modelo lógico
CREATE TABLE `comment` (
	com_id INT PRIMARY KEY AUTO_INCREMENT,
    com_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    com_article INT NOT NULL,
    com_author_name VARCHAR(127) NOT NULL,
    com_author_email VARCHAR(255) NOT NULL,
    com_comment TEXT,
	com_status ENUM('on', 'off', 'del') DEFAULT 'on',
    FOREIGN KEY (com_article) REFERENCES article (art_id)
);

-- Cria a tabela 'contact' conforme o modelo lógico
CREATE TABLE contact (
	id INT PRIMARY KEY AUTO_INCREMENT,
    date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    name VARCHAR(127) NOT NULL, 
    email VARCHAR(255) NOT NULL, 
    subject VARCHAR(255) NOT NULL,
    message TEXT,
    status ENUM('on', 'off', 'del') DEFAULT 'on'
);

-- -------------------------------- --
-- Populando tabelas com dados fake --
-- -------------------------------- --


-- Tabela "staff" --

INSERT INTO staff (
	emp_name,
    emp_email,
    emp_password,
    emp_image,
    emp_birth,
    emp_description
) VALUES (
	'Joca da Silva',
    'jocasilva@email.com',
    SHA1('Senha123'),
    'https://randomuser.me/api/portraits/men/43.jpg',
    '2000-05-28',
    'Programador, escultor, pescador e enrolador.'
), (
	'Marineuza Siriliano',
    'marisiri@email.com',
    SHA1('Senha123'),
    'https://randomuser.me/api/portraits/women/6.jpg',
    '1997-12-18',
    'Programadora, psicultora, dustribuidora e controladora.'
), (
	'Setembrino Trocatapas',
    'trocatapasset@email.com',
    SHA1('Senha123'),
    'https://randomuser.me/api/portraits/men/16.jpg',
    '1980-10-25',
    'Proramador, psicografador e destruidor de computador.'
), (
	'Edicleuza Sarvastania',
    'edisarva@email.com',
    SHA1('Senha123'),
    'https://randomuser.me/api/portraits/women/25.jpg',
    '2001-06-18',
    'Programadora, organizadora e comentadora.'
);

INSERT INTO staff (
	emp_name,
    emp_email,
    emp_password,
    emp_image,
    emp_birth,
    emp_description
) VALUES (
	'Maria Oliveira',
    'maria.oliveira@email.com',
    SHA1('Senha456'),
    'https://randomuser.me/api/portraits/women/44.jpg',
    '1995-07-15',
    'Desenvolvedora, pintora, ciclista e cozinheira.'
);

INSERT INTO staff (
	emp_name,
    emp_email,
    emp_password,
    emp_image,
    emp_birth,
    emp_description
) VALUES (
	'Carlos Pereira',
    'carlos.pereira@email.com',
    SHA1('Senha789'),
    'https://randomuser.me/api/portraits/men/45.jpg',
    '1988-11-22',
    'Analista de sistemas, músico, fotógrafo e viajante.'
);

INSERT INTO staff (
	emp_name,
    emp_email,
    emp_password,
    emp_image,
    emp_birth,
    emp_description
) VALUES (
	'Ana Costa',
    'ana.costa@email.com',
    SHA1('Senha321'),
    'https://randomuser.me/api/portraits/women/46.jpg',
    '1992-03-10',
    'Engenheira de software, escritora, maratonista e voluntária.'
);

INSERT INTO staff (
	emp_name,
    emp_email,
    emp_password,
    emp_image,
    emp_birth,
    emp_description
) VALUES (
	'Pedro Souza',
    'pedro.souza@email.com',
    SHA1('Senha654'),
    'https://randomuser.me/api/portraits/men/47.jpg',
    '1985-08-30',
    'Designer gráfico, escultor, surfista e amante de gatos.'
);

-- Atualiza o type do staff --
UPDATE `flaskblogdb`.`staff` SET `emp_type` = 'admin' WHERE (`emp_id` = '1');
UPDATE `flaskblogdb`.`staff` SET `emp_type` = 'author' WHERE (`emp_id` = '2');
UPDATE `flaskblogdb`.`staff` SET `emp_type` = 'author' WHERE (`emp_id` = '4');
UPDATE `flaskblogdb`.`staff` SET `emp_type` = 'author' WHERE (`emp_id` = '5');
UPDATE `flaskblogdb`.`staff` SET `emp_type` = 'author' WHERE (`emp_id` = '7');
UPDATE `flaskblogdb`.`staff` SET `emp_type` = 'author' WHERE (`emp_id` = '8');

-- Tabela "article" --
INSERT INTO article (
    art_author,
    art_title,
    art_resume,
    art_thumbnail,
    art_content
) VALUES (
	-- 'emp_id' de um staff existente --
	'2',
    'Primeiro artigo',
    -- Deixe os mesmos valores para todos os outros artigos
    'Lorem ipsum dolor sit amet consectetur adipisicing elit.',
    'https://picsum.photos/300',
    '
<p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Velit eum, dolor ad alias nesciunt consequuntur in error enim numquam sit sunt! Quia eius tempora provident tempore culpa cupiditate sunt dignissimos?</p>
<p>Lorem, ipsum dolor sit amet consectetur adipisicing elit. Autem qui voluptatum hic repudiandae labore quod deleniti temporibus perferendis quisquam recusandae, eum alias natus, dolor at! Error saepe est cupiditate consectetur!</p>
<img src="https://picsum.photos/200/300" alt="Imagem aleatória">
<p>Lorem ipsum dolor, sit amet consectetur adipisicing elit. Eligendi consequatur laboriosam reiciendis dolorem, exercitationem dolor natus hic quisquam itaque maxime doloribus. Adipisci debitis quod perferendis repudiandae similique quam voluptatum eveniet.</p>
<h4>Links:</h4>
<ul>
    <li><a href="https://catabist.com.br">Site do Fessô</a></li>
    <li><a href="https://github.com/Luferat">Github do fessô</a></li>
</ul>
<p>Lorem ipsum dolor sit amet consectetur, adipisicing elit. Perspiciatis a mollitia doloribus repudiandae incidunt ullam debitis, minima iure quia, recusandae odio magnam velit quos ad nam eaque. Ut, dolorem eveniet?</p>    
    '
);

INSERT INTO article (
    art_author,
    art_title,
    art_resume,
    art_thumbnail,
    art_content
) VALUES (
	-- 'emp_id' de um staff existente --
	'3',
    'Segundo artigo',
    -- Deixe os mesmos valores para todos os outros artigos
    'Lorem ipsum dolor sit amet consectetur adipisicing elit.',
    'https://picsum.photos/300',
    '
<p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Velit eum, dolor ad alias nesciunt consequuntur in error enim numquam sit sunt! Quia eius tempora provident tempore culpa cupiditate sunt dignissimos?</p>
<p>Lorem, ipsum dolor sit amet consectetur adipisicing elit. Autem qui voluptatum hic repudiandae labore quod deleniti temporibus perferendis quisquam recusandae, eum alias natus, dolor at! Error saepe est cupiditate consectetur!</p>
<img src="https://picsum.photos/200/300" alt="Imagem aleatória">
<p>Lorem ipsum dolor, sit amet consectetur adipisicing elit. Eligendi consequatur laboriosam reiciendis dolorem, exercitationem dolor natus hic quisquam itaque maxime doloribus. Adipisci debitis quod perferendis repudiandae similique quam voluptatum eveniet.</p>
<h4>Links:</h4>
<ul>
    <li><a href="https://catabist.com.br">Site do Fessô</a></li>
    <li><a href="https://github.com/Luferat">Github do fessô</a></li>
</ul>
<p>Lorem ipsum dolor sit amet consectetur, adipisicing elit. Perspiciatis a mollitia doloribus repudiandae incidunt ullam debitis, minima iure quia, recusandae odio magnam velit quos ad nam eaque. Ut, dolorem eveniet?</p>    
    '
);

INSERT INTO article (
    art_author,
    art_title,
    art_resume,
    art_thumbnail,
    art_content
) VALUES (
	-- 'emp_id' de um staff existente --
	'4',
    'Terceiro artigo',
    -- Deixe os mesmos valores para todos os outros artigos
    'Lorem ipsum dolor sit amet consectetur adipisicing elit.',
    'https://picsum.photos/300',
    '
<p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Velit eum, dolor ad alias nesciunt consequuntur in error enim numquam sit sunt! Quia eius tempora provident tempore culpa cupiditate sunt dignissimos?</p>
<p>Lorem, ipsum dolor sit amet consectetur adipisicing elit. Autem qui voluptatum hic repudiandae labore quod deleniti temporibus perferendis quisquam recusandae, eum alias natus, dolor at! Error saepe est cupiditate consectetur!</p>
<img src="https://picsum.photos/200/300" alt="Imagem aleatória">
<p>Lorem ipsum dolor, sit amet consectetur adipisicing elit. Eligendi consequatur laboriosam reiciendis dolorem, exercitationem dolor natus hic quisquam itaque maxime doloribus. Adipisci debitis quod perferendis repudiandae similique quam voluptatum eveniet.</p>
<h4>Links:</h4>
<ul>
    <li><a href="https://catabist.com.br">Site do Fessô</a></li>
    <li><a href="https://github.com/Luferat">Github do fessô</a></li>
</ul>
<p>Lorem ipsum dolor sit amet consectetur, adipisicing elit. Perspiciatis a mollitia doloribus repudiandae incidunt ullam debitis, minima iure quia, recusandae odio magnam velit quos ad nam eaque. Ut, dolorem eveniet?</p>    
    '
);

INSERT INTO article (
    art_author,
    art_title,
    art_resume,
    art_thumbnail,
    art_content
) VALUES (
	-- 'emp_id' de um staff existente --
	'5',
    'Quarto artigo',
    -- Deixe os mesmos valores para todos os outros artigos
    'Lorem ipsum dolor sit amet consectetur adipisicing elit.',
    'https://picsum.photos/300',
    '
<p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Velit eum, dolor ad alias nesciunt consequuntur in error enim numquam sit sunt! Quia eius tempora provident tempore culpa cupiditate sunt dignissimos?</p>
<p>Lorem, ipsum dolor sit amet consectetur adipisicing elit. Autem qui voluptatum hic repudiandae labore quod deleniti temporibus perferendis quisquam recusandae, eum alias natus, dolor at! Error saepe est cupiditate consectetur!</p>
<img src="https://picsum.photos/200/300" alt="Imagem aleatória">
<p>Lorem ipsum dolor, sit amet consectetur adipisicing elit. Eligendi consequatur laboriosam reiciendis dolorem, exercitationem dolor natus hic quisquam itaque maxime doloribus. Adipisci debitis quod perferendis repudiandae similique quam voluptatum eveniet.</p>
<h4>Links:</h4>
<ul>
    <li><a href="https://catabist.com.br">Site do Fessô</a></li>
    <li><a href="https://github.com/Luferat">Github do fessô</a></li>
</ul>
<p>Lorem ipsum dolor sit amet consectetur, adipisicing elit. Perspiciatis a mollitia doloribus repudiandae incidunt ullam debitis, minima iure quia, recusandae odio magnam velit quos ad nam eaque. Ut, dolorem eveniet?</p>    
    '
);

INSERT INTO article (
    art_author,
    art_title,
    art_resume,
    art_thumbnail,
    art_content
) VALUES (
	-- 'emp_id' de um staff existente --
	'2',
    'Quinto artigo',
    -- Deixe os mesmos valores para todos os outros artigos
    'Lorem ipsum dolor sit amet consectetur adipisicing elit.',
    'https://picsum.photos/300',
    '
<p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Velit eum, dolor ad alias nesciunt consequuntur in error enim numquam sit sunt! Quia eius tempora provident tempore culpa cupiditate sunt dignissimos?</p>
<p>Lorem, ipsum dolor sit amet consectetur adipisicing elit. Autem qui voluptatum hic repudiandae labore quod deleniti temporibus perferendis quisquam recusandae, eum alias natus, dolor at! Error saepe est cupiditate consectetur!</p>
<img src="https://picsum.photos/200/300" alt="Imagem aleatória">
<p>Lorem ipsum dolor, sit amet consectetur adipisicing elit. Eligendi consequatur laboriosam reiciendis dolorem, exercitationem dolor natus hic quisquam itaque maxime doloribus. Adipisci debitis quod perferendis repudiandae similique quam voluptatum eveniet.</p>
<h4>Links:</h4>
<ul>
    <li><a href="https://catabist.com.br">Site do Fessô</a></li>
    <li><a href="https://github.com/Luferat">Github do fessô</a></li>
</ul>
<p>Lorem ipsum dolor sit amet consectetur, adipisicing elit. Perspiciatis a mollitia doloribus repudiandae incidunt ullam debitis, minima iure quia, recusandae odio magnam velit quos ad nam eaque. Ut, dolorem eveniet?</p>    
    '
);

INSERT INTO article (
    art_author,
    art_title,
    art_resume,
    art_thumbnail,
    art_content
) VALUES (
	-- 'emp_id' de um staff existente --
	'6',
    'Sexto artigo',
    -- Deixe os mesmos valores para todos os outros artigos
    'Lorem ipsum dolor sit amet consectetur adipisicing elit.',
    'https://picsum.photos/300',
    '
<p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Velit eum, dolor ad alias nesciunt consequuntur in error enim numquam sit sunt! Quia eius tempora provident tempore culpa cupiditate sunt dignissimos?</p>
<p>Lorem, ipsum dolor sit amet consectetur adipisicing elit. Autem qui voluptatum hic repudiandae labore quod deleniti temporibus perferendis quisquam recusandae, eum alias natus, dolor at! Error saepe est cupiditate consectetur!</p>
<img src="https://picsum.photos/200/300" alt="Imagem aleatória">
<p>Lorem ipsum dolor, sit amet consectetur adipisicing elit. Eligendi consequatur laboriosam reiciendis dolorem, exercitationem dolor natus hic quisquam itaque maxime doloribus. Adipisci debitis quod perferendis repudiandae similique quam voluptatum eveniet.</p>
<h4>Links:</h4>
<ul>
    <li><a href="https://catabist.com.br">Site do Fessô</a></li>
    <li><a href="https://github.com/Luferat">Github do fessô</a></li>
</ul>
<p>Lorem ipsum dolor sit amet consectetur, adipisicing elit. Perspiciatis a mollitia doloribus repudiandae incidunt ullam debitis, minima iure quia, recusandae odio magnam velit quos ad nam eaque. Ut, dolorem eveniet?</p>    
    '
);

INSERT INTO article (
    art_author,
    art_title,
    art_resume,
    art_thumbnail,
    art_content
) VALUES (
	-- 'emp_id' de um staff existente --
	'7',
    'Sétimo artigo',
    -- Deixe os mesmos valores para todos os outros artigos
    'Lorem ipsum dolor sit amet consectetur adipisicing elit.',
    'https://picsum.photos/300',
    '
<p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Velit eum, dolor ad alias nesciunt consequuntur in error enim numquam sit sunt! Quia eius tempora provident tempore culpa cupiditate sunt dignissimos?</p>
<p>Lorem, ipsum dolor sit amet consectetur adipisicing elit. Autem qui voluptatum hic repudiandae labore quod deleniti temporibus perferendis quisquam recusandae, eum alias natus, dolor at! Error saepe est cupiditate consectetur!</p>
<img src="https://picsum.photos/200/300" alt="Imagem aleatória">
<p>Lorem ipsum dolor, sit amet consectetur adipisicing elit. Eligendi consequatur laboriosam reiciendis dolorem, exercitationem dolor natus hic quisquam itaque maxime doloribus. Adipisci debitis quod perferendis repudiandae similique quam voluptatum eveniet.</p>
<h4>Links:</h4>
<ul>
    <li><a href="https://catabist.com.br">Site do Fessô</a></li>
    <li><a href="https://github.com/Luferat">Github do fessô</a></li>
</ul>
<p>Lorem ipsum dolor sit amet consectetur, adipisicing elit. Perspiciatis a mollitia doloribus repudiandae incidunt ullam debitis, minima iure quia, recusandae odio magnam velit quos ad nam eaque. Ut, dolorem eveniet?</p>    
    '
);

INSERT INTO article (
    art_author,
    art_title,
    art_resume,
    art_thumbnail,
    art_content
) VALUES (
	-- 'emp_id' de um staff existente --
	'8',
    'Oitavo artigo',
    -- Deixe os mesmos valores para todos os outros artigos
    'Lorem ipsum dolor sit amet consectetur adipisicing elit.',
    'https://picsum.photos/300',
    '
<p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Velit eum, dolor ad alias nesciunt consequuntur in error enim numquam sit sunt! Quia eius tempora provident tempore culpa cupiditate sunt dignissimos?</p>
<p>Lorem, ipsum dolor sit amet consectetur adipisicing elit. Autem qui voluptatum hic repudiandae labore quod deleniti temporibus perferendis quisquam recusandae, eum alias natus, dolor at! Error saepe est cupiditate consectetur!</p>
<img src="https://picsum.photos/200/300" alt="Imagem aleatória">
<p>Lorem ipsum dolor, sit amet consectetur adipisicing elit. Eligendi consequatur laboriosam reiciendis dolorem, exercitationem dolor natus hic quisquam itaque maxime doloribus. Adipisci debitis quod perferendis repudiandae similique quam voluptatum eveniet.</p>
<h4>Links:</h4>
<ul>
    <li><a href="https://catabist.com.br">Site do Fessô</a></li>
    <li><a href="https://github.com/Luferat">Github do fessô</a></li>
</ul>
<p>Lorem ipsum dolor sit amet consectetur, adipisicing elit. Perspiciatis a mollitia doloribus repudiandae incidunt ullam debitis, minima iure quia, recusandae odio magnam velit quos ad nam eaque. Ut, dolorem eveniet?</p>    
    '
);

INSERT INTO article (
    art_author,
    art_title,
    art_resume,
    art_thumbnail,
    art_content
) VALUES (
	-- 'emp_id' de um staff existente --
	'1',
    'Nono artigo',
    -- Deixe os mesmos valores para todos os outros artigos
    'Lorem ipsum dolor sit amet consectetur adipisicing elit.',
    'https://picsum.photos/300',
    '
<p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Velit eum, dolor ad alias nesciunt consequuntur in error enim numquam sit sunt! Quia eius tempora provident tempore culpa cupiditate sunt dignissimos?</p>
<p>Lorem, ipsum dolor sit amet consectetur adipisicing elit. Autem qui voluptatum hic repudiandae labore quod deleniti temporibus perferendis quisquam recusandae, eum alias natus, dolor at! Error saepe est cupiditate consectetur!</p>
<img src="https://picsum.photos/200/300" alt="Imagem aleatória">
<p>Lorem ipsum dolor, sit amet consectetur adipisicing elit. Eligendi consequatur laboriosam reiciendis dolorem, exercitationem dolor natus hic quisquam itaque maxime doloribus. Adipisci debitis quod perferendis repudiandae similique quam voluptatum eveniet.</p>
<h4>Links:</h4>
<ul>
    <li><a href="https://catabist.com.br">Site do Fessô</a></li>
    <li><a href="https://github.com/Luferat">Github do fessô</a></li>
</ul>
<p>Lorem ipsum dolor sit amet consectetur, adipisicing elit. Perspiciatis a mollitia doloribus repudiandae incidunt ullam debitis, minima iure quia, recusandae odio magnam velit quos ad nam eaque. Ut, dolorem eveniet?</p>    
    '
);

INSERT INTO article (
    art_author,
    art_title,
    art_resume,
    art_thumbnail,
    art_content
) VALUES (
	-- 'emp_id' de um staff existente --
	'3',
    'Décimo artigo',
    -- Deixe os mesmos valores para todos os outros artigos
    'Lorem ipsum dolor sit amet consectetur adipisicing elit.',
    'https://picsum.photos/300',
    '
<p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Velit eum, dolor ad alias nesciunt consequuntur in error enim numquam sit sunt! Quia eius tempora provident tempore culpa cupiditate sunt dignissimos?</p>
<p>Lorem, ipsum dolor sit amet consectetur adipisicing elit. Autem qui voluptatum hic repudiandae labore quod deleniti temporibus perferendis quisquam recusandae, eum alias natus, dolor at! Error saepe est cupiditate consectetur!</p>
<img src="https://picsum.photos/200/300" alt="Imagem aleatória">
<p>Lorem ipsum dolor, sit amet consectetur adipisicing elit. Eligendi consequatur laboriosam reiciendis dolorem, exercitationem dolor natus hic quisquam itaque maxime doloribus. Adipisci debitis quod perferendis repudiandae similique quam voluptatum eveniet.</p>
<h4>Links:</h4>
<ul>
    <li><a href="https://catabist.com.br">Site do Fessô</a></li>
    <li><a href="https://github.com/Luferat">Github do fessô</a></li>
</ul>
<p>Lorem ipsum dolor sit amet consectetur, adipisicing elit. Perspiciatis a mollitia doloribus repudiandae incidunt ullam debitis, minima iure quia, recusandae odio magnam velit quos ad nam eaque. Ut, dolorem eveniet?</p>    
    '
);

-- Tabela "commente" --
INSERT INTO comment (
    -- Insira um "art_id" existente --
    com_article,
    com_author_name,
    com_author_email,
    com_comment
    
) VALUES (
    '10',
    'Soraia',
    'soraia@gmail.com'
    'É só mais um lorem ipsum.'
    
), (
    '4',
    'João',
    'joao@email.com'
    'É só mais um lorem ipsum.'

), (
    '2',
    'Marisa',
    'marisa@email.com'
    'É só mais um lorem ipsum.'
    
), (
    '1',
    'Paulo',
    'paulo@email.com'
    'É só mais um lorem ipsum.'
    
), (
    '5',
    'Marcia',
    'marcia@email.com'
    'É só mais um lorem ipsum.'
    
-- ----------------------------------- --
-- Testes de SELECT                    --
-- Dica: execute uma linha de cada vez --
-- ----------------------------------- --

-- Mostra todos os registros da tabela 'staff' --
SELECT * FROM staff;

SELECT * FROM staff WHERE emp_id = '5';

SELECT * FROM staff where EMP_NAME = 'Maria Oliveira';

-- Troque entre 'DESC e 'ASC' para testar a ordem
SELECT * FROM staff ORDER BY emp_name DESC;

-- Somente 'author'
SELECT emp_id, emp_name, emp_email 
FROM staff 
WHERE emp_type = 'author'
ORDER BY emp_name;

-- Mostra todos os registros da tabela 'article' --
SELECT * FROM article;






