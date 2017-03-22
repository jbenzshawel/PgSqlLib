/**
 * Generate Script for YourApplicationDBName DB and Tables
 * -------------------------------------------------------
 * Description : "YourApplicationDBName" and "YourApplicationAdmin" with the name of
 *               the PostgreSql database you would like to create and "YourApplicationAdmin"
 *               with the db owner, respectively. The table "model_name" is just an example 
 *               model. For each model in your application a table should be made. 
 * Author      : Addison B. 
 * SqlType     : PostgreSql 
 */

-- Database: YourApplicationDBName

-- DROP DATABASE "YourApplicationDBName";

CREATE DATABASE "YourApplicationDBName"
    WITH 
    OWNER = "YourApplicationAdmin"
    ENCODING = 'UTF8'
    LC_COLLATE = 'C'
    LC_CTYPE = 'C'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1;


-- Table: public.model_name

-- DROP TABLE public.model_name;

CREATE TABLE public.model_name
(
    model_id uuid NOT NULL,
    name text COLLATE pg_catalog."default" NOT NULL,
    description text COLLATE pg_catalog."default",
    created timestamp with time zone DEFAULT now(),
    updated timestamp with time zone,
    is_visible boolean,
    CONSTRAINT "ModelIdPK" PRIMARY KEY (model_id)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.model_name
    OWNER to "YourApplicationDBName";

