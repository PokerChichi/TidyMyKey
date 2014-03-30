SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

-- 
-- Creation des sequences pour l'auto increment
--
create sequence seq_activite
    start 1
    increment 1
    NO MAXVALUE
    CACHE 1;
ALTER TABLE seq_activite 
OWNER TO multimif;

-- 
-- Creation des sequences pour l'auto increment
--
create sequence seq_contrainte
    start 1
    increment 1
    NO MAXVALUE
    CACHE 1;
ALTER TABLE seq_contrainte
OWNER TO multimif;

-- 
-- Creation des sequences pour l'auto increment
--
create sequence seq_creneau
    start 1
    increment 1
    NO MAXVALUE
    CACHE 1;
ALTER TABLE seq_creneau
OWNER TO multimif;

-- 
-- Creation des sequences pour l'auto increment
--
create sequence seq_permission
    start 1
    increment 1
    NO MAXVALUE
    CACHE 1;
ALTER TABLE seq_permission
OWNER TO multimif;

-- 
-- Creation des sequences pour l'auto increment
--
create sequence seq_reservation
    start 1
    increment 1
    NO MAXVALUE
    CACHE 1;
ALTER TABLE seq_reservation
OWNER TO multimif;


-- 
-- Creation des sequences pour l'auto increment
--
create sequence seq_ressource
    start 1
    increment 1
    NO MAXVALUE
    CACHE 1;
ALTER TABLE seq_ressource
OWNER TO multimif;

-- 
-- Creation des sequences pour l'auto increment
--
create sequence seq_semantique
    start 1
    increment 1
    NO MAXVALUE
    CACHE 1;
ALTER TABLE seq_semantique
OWNER TO multimif;

-- 
-- Creation des sequences pour l'auto increment
--
create sequence seq_typecontrainte
    start 1
    increment 1
    NO MAXVALUE
    CACHE 1;
ALTER TABLE seq_typecontrainte
OWNER TO multimif;

--
-- Name: activite; Type: TABLE; Schema: public; Owner: multimif; Tablespace: 
--

CREATE TABLE activite (
    id integer NOT NULL,
    nom character varying(255)
);


ALTER TABLE public.activite OWNER TO multimif;

--
-- Name: activite_contrainte; Type: TABLE; Schema: public; Owner: multimif; Tablespace: 
--

CREATE TABLE activite_contrainte (
    idact integer NOT NULL,
    idcon integer NOT NULL
);


ALTER TABLE public.activite_contrainte OWNER TO multimif;

--
-- Name: activite_ressource; Type: TABLE; Schema: public; Owner: multimif; Tablespace: 
--

CREATE TABLE activite_ressource (
    idact integer NOT NULL,
    idres integer NOT NULL
);


ALTER TABLE public.activite_ressource OWNER TO multimif;

--
-- Name: contrainte; Type: TABLE; Schema: public; Owner: multimif; Tablespace: 
--

CREATE TABLE contrainte (
    id integer  NOT NULL,
    ressource integer,
    semantique integer NOT NULL,
    typecontrainte integer NOT NULL
);


ALTER TABLE public.contrainte OWNER TO multimif;

--
-- Name: creneau; Type: TABLE; Schema: public; Owner: multimif; Tablespace: 
--

CREATE TABLE creneau (
    id integer NOT NULL,
    datedebut date,
    datefin date,
    heuredebut time without time zone,
    heurefin time without time zone
);


ALTER TABLE public.creneau OWNER TO multimif;

--
-- Name: nombre; Type: TABLE; Schema: public; Owner: multimif; Tablespace: 
--

CREATE TABLE nombre (
    nombre integer,
    id integer NOT NULL
);


ALTER TABLE public.nombre OWNER TO multimif;

--
-- Name: permission; Type: TABLE; Schema: public; Owner: multimif; Tablespace: 
--

CREATE TABLE permission (
    id integer NOT NULL,
    mode integer NOT NULL,
    permissionParent integer NOT NULL
);


ALTER TABLE public.permission OWNER TO multimif;

--
-- Name: reservation; Type: TABLE; Schema: public; Owner: multimif; Tablespace: 
--

CREATE TABLE reservation (
    id integer NOT NULL,
    nom character varying(255),
    activite integer NOT NULL,
    creneau integer NOT NULL
);


ALTER TABLE public.reservation OWNER TO multimif;

--
-- Name: reservation_ressource; Type: TABLE; Schema: public; Owner: multimif; Tablespace: 
--

CREATE TABLE reservation_ressource (
    idresa integer NOT NULL,
    idress integer NOT NULL
);


ALTER TABLE public.reservation_ressource OWNER TO multimif;

--
-- Name: ressource; Type: TABLE; Schema: public; Owner: multimif; Tablespace: 
--

CREATE TABLE ressource (
    id integer NOT NULL,
    nom character varying(255),
    permission integer NOT NULL,
    ressourceparent integer
);


ALTER TABLE public.ressource OWNER TO multimif;

--
-- Name: ressource_semantique; Type: TABLE; Schema: public; Owner: multimif; Tablespace: 
--

CREATE TABLE ressource_semantique (
    idres integer NOT NULL,
    idsem integer NOT NULL
);


ALTER TABLE public.ressource_semantique OWNER TO multimif;

--
-- Name: sdate; Type: TABLE; Schema: public; Owner: multimif; Tablespace: 
--

CREATE TABLE sdate (
    valdate date,
    id integer NOT NULL
);


ALTER TABLE public.sdate OWNER TO multimif;

--
-- Name: semantique; Type: TABLE; Schema: public; Owner: multimif; Tablespace: 
--

CREATE TABLE semantique (
    id integer NOT NULL,
    nom character varying(255)
);


ALTER TABLE public.semantique OWNER TO multimif;

--
-- Name: temps; Type: TABLE; Schema: public; Owner: multimif; Tablespace: 
--

CREATE TABLE temps (
    temps time without time zone,
    id integer NOT NULL
);


ALTER TABLE public.temps OWNER TO multimif;

--
-- Name: texte; Type: TABLE; Schema: public; Owner: multimif; Tablespace: 
--

CREATE TABLE texte (
    lignetexte character varying(255),
    id integer NOT NULL
);


ALTER TABLE public.texte OWNER TO multimif;

--
-- Name: typecontrainte; Type: TABLE; Schema: public; Owner: multimif; Tablespace: 
--

CREATE TABLE typecontrainte (
    id integer NOT NULL,
    nom character varying(255),
    operateur character varying(255)
);


ALTER TABLE public.typecontrainte OWNER TO multimif;

/* Contrainte de clé primaire */
ALTER TABLE ONLY activite
    ADD CONSTRAINT activite_pkey PRIMARY KEY (id);
ALTER TABLE ONLY contrainte
    ADD CONSTRAINT contrainte_pkey PRIMARY KEY (id);
ALTER TABLE ONLY creneau
    ADD CONSTRAINT creneau_pkey PRIMARY KEY (id);
ALTER TABLE ONLY nombre
    ADD CONSTRAINT nombre_pkey PRIMARY KEY (id);
ALTER TABLE ONLY permission
    ADD CONSTRAINT permission_pkey PRIMARY KEY (id);
ALTER TABLE ONLY reservation
    ADD CONSTRAINT reservation_pkey PRIMARY KEY (id);
ALTER TABLE ONLY ressource
    ADD CONSTRAINT ressource_pkey PRIMARY KEY (id);
ALTER TABLE ONLY sdate
    ADD CONSTRAINT sdate_pkey PRIMARY KEY (id);
ALTER TABLE ONLY semantique
    ADD CONSTRAINT semantique_pkey PRIMARY KEY (id);
ALTER TABLE ONLY temps
    ADD CONSTRAINT temps_pkey PRIMARY KEY (id);
ALTER TABLE ONLY texte
    ADD CONSTRAINT texte_pkey PRIMARY KEY (id);
ALTER TABLE ONLY typecontrainte
    ADD CONSTRAINT typecontrainte_pkey PRIMARY KEY (id);
alter table only activite_contrainte 
    add constraint activite_contrainte_pkey primary key (idact, idcon);
alter table only ressource_semantique 
    add constraint ressource_semantique_pkey primary key (idres, idsem);
alter table only activite_ressource 
    add constraint activite_ressource_pkey primary key (idact, idres);
alter table only reservation_ressource 
    add constraint reservation_ressource_pkey primary key (idresa, idress);

/* Contraintes sur la table contrainte */
alter table contrainte add constraint fk_idSem_contrainte 
    foreign key (semantique) references semantique (id) ;
alter table contrainte add constraint fk_idType_contrainte 
    foreign key (typecontrainte) references typecontrainte (id) ;
alter table contrainte add constraint fk_idRess_contrainte 
    foreign key (ressource) references ressource (id) ;

/* Contrainte sur la table if not exists sdate */
alter table sdate add constraint fk_idSem_sdate 
    foreign key (id) references semantique (id) ;;
/* Contrainte sur la table if not exists nombre */
alter table nombre add constraint fk_idSem_nombre 
    foreign key (id) references semantique (id) ;
/* Contrainte sur la table if not exists nombre */
alter table temps add constraint fk_idSem_temps 
    foreign key (id) references semantique (id) ;
/* Contrainte sur la table if not exists texte */
alter table texte add constraint fk_idSem_texte 
    foreign key (id) references semantique (id) ;

/* Contrainte sur la table if not exists permission */
alter table permission add constraint fk_idParent_permission 
    foreign key (permissionParent) references permission (id) ;

/* Contrainte sur la table if not exists reservation */
alter table reservation add constraint fk_idCre_reservation 
    foreign key (creneau) references creneau(id) ;
alter table reservation add constraint fk_idAct_reservation 
    foreign key (activite) references activite (id) ;

/* Contrainte sur la table if not exists ressource */
alter table ressource add constraint fk_idPar_ressource 
    foreign key (ressourceparent) references ressource(id) ;
alter table ressource add constraint fk_idPerm_ressource 
    foreign key (permission) references permission (id) ;

/* Contrainte sur les tables de liaison */
ALTER TABLE ONLY activite_contrainte
    ADD CONSTRAINT fk_idact_activite_contrainte FOREIGN KEY (idact) REFERENCES activite(id);
ALTER TABLE ONLY activite_contrainte
    ADD CONSTRAINT fk_idcon_activite_contrainte FOREIGN KEY (idcon) REFERENCES contrainte(id);

ALTER TABLE ONLY ressource_semantique
    ADD CONSTRAINT fk_idres_ressource_semantique FOREIGN KEY (idres) REFERENCES ressource(id);
ALTER TABLE ONLY ressource_semantique
    ADD CONSTRAINT fk_idsem_ressource_semantique FOREIGN KEY (idsem) REFERENCES semantique(id);

ALTER TABLE ONLY activite_ressource
    ADD CONSTRAINT fk_idres_activite_ressource FOREIGN KEY (idres) REFERENCES ressource(id);
ALTER TABLE ONLY activite_ressource
    ADD CONSTRAINT fk_adact_activite_ressource FOREIGN KEY (idact) REFERENCES activite(id);

ALTER TABLE ONLY reservation_ressource
    ADD CONSTRAINT fk_idresa_reservation_ressource FOREIGN KEY (idresa) REFERENCES reservation(id);
ALTER TABLE ONLY reservation_ressource
    ADD CONSTRAINT fk_idress_reservation_ressource FOREIGN KEY (idress) REFERENCES ressource(id);

/* Contrainte liée au métier */
alter table only creneau 
    add constraint fk_check_date CHECK (datedebut <= datefin);
alter table only creneau 
    add constraint fk_check_heure CHECK (heuredebut < heurefin);
