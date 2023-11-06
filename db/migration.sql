CREATE TABLE IF NOT EXISTS companies (
  id serial NOT NULL,
  name VARCHAR(255) NOT NULL,
  document_identification VARCHAR(255) NOT NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),

  PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS users (
  id serial NOT NULL,
  name VARCHAR(255) NOT NULL,
  email VARCHAR(255) NOT NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),

  company_id INT NOT NULL,

  PRIMARY KEY (id),
  FOREIGN KEY (company_id) REFERENCES companies (id)
);

CREATE TABLE IF NOT EXISTS pts (
  id serial NOT NULL,
  name VARCHAR(255) NOT NULL UNIQUE,
  description VARCHAR(255),
  limit_in_days INT NOT NULL,

  created_by_user INT NOT NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  
  approved_by_user INT,
  approved_at TIMESTAMPTZ,

  closed_by_user INT,
  closed_at TIMESTAMPTZ,

  company_id INT NOT NULL,

  PRIMARY KEY (id),
  FOREIGN KEY (created_by_user) REFERENCES users (id),
  FOREIGN KEY (approved_by_user) REFERENCES users (id),
  FOREIGN KEY (closed_by_user) REFERENCES users (id),
  FOREIGN KEY (company_id) REFERENCES companies (id)
);

CREATE TABLE IF NOT EXISTS danger_types (
  id serial NOT NULL,
  name VARCHAR(255) NOT NULL,
  description VARCHAR(255),

  PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS pts_danger_types (
  id serial NOT NULL,

  pts_id INT NOT NULL,
  danger_type_id INT NOT NULL,

  PRIMARY KEY (id),
  FOREIGN KEY (pts_id) REFERENCES pts (id) ON DELETE CASCADE, 
  FOREIGN KEY (danger_type_id) REFERENCES danger_types (id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS questions (
  id serial NOT NULL,
  description VARCHAR(255) NOT NULL,

  danger_type_id INT NOT NULL,

  PRIMARY KEY (id),
  FOREIGN KEY(danger_type_id) REFERENCES danger_types (id)
);

INSERT INTO companies (id,name, document_identification) VALUES 
  (1, 'Empresa', '12345678000011');

INSERT INTO users (name, email, company_id) VALUES
  ('João', 'joao@empresa.com', 1),
  ('Ana', 'ana@empresa.com', 1);

INSERT INTO danger_types(id, name, description) VALUES
  (1,'Trabalho Confinado', 'Espaços menores de 2m²'),
  (2,'Ambientes Quentes', 'Espaços onde a temperatura excede 40ºC e menores à 48ºC');

INSERT INTO questions (description, danger_type_id) VALUES
  ('Permitir instrumentos de medição?', 1),
  ('Permitir ferramentas de torque?', 1),
  ('Realizou o plano de acesso emergêncial?', 2),
  ('Fez todas as checagens do termômetro principal?', 2);