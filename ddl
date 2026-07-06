Script DDL
1. CREATE A DATA BASE
CREATE DATABASE bd_luis_medrano_cayena
    WITH
    OWNER = cayena_luis
    ENCODING = 'UTF8'
    LOCALE_PROVIDER = 'libc'
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;
---------------------------------
CREATE TABLE riwi_client
(
    id_client serial PRIMARY KEY,
    full_name_client character varying(220) NOT NULL,
    phone_client character varying(50),
    adress_client character varying(250),
);
--------------------------------------------
CREATE TABLE riwi_branches 
(
    id_branch integer PRIMARY KEY,
    name_branch character varying(220) NOT NULL,
);
----------------------------------------------
CREATE TABLE riwi_city
(
    id_city integer NOT NULL PRIMARY KEY,
    name_city character varying(220) NOT NULL,
    id_branch integer,
);
------------------------------------------------------------------------
CREATE TABLE riwi_EquipmentCategory
(
    "id_EquipmentCategory" integer NOT NULL PRIMARY KEY ,
    "EquipmentCategory" character varying(220) NOT NULL,
);
-----------------------------------------------------------------------
CREATE TABLE riwi_Equipment
(
    "id_Equipment" integer NOT NULL PRIMARY KEY,
    "name_Equipment" character varying(220) NOT NULL,
    "id_EquipmentCategory" integer,
    CONSTRAINT "id_EquipmentCategory" FOREIGN KEY ("id_EquipmentCategory")
        REFERENCES riwi_EquipmentCategory ("id_EquipmentCategory") MATCH SIMPLE

);
------------------------------------------------------------------------
CREATE TABLE riwi_Technician
(
    "id_Technician" integer NOT NULL PRIMARY KEY,
    "full_name_Technician" character varying(220) NOT NULL,
    "phone_Technician" character varying(220),
    "adress_Technician" character varying(200),
);
------------------------------------------------------------------------
CREATE TABLE riwi_WorkOrders
(
    "id_WorkOrder" serial NOT NULL PRIMARY KEY,
    "name_WorkOrder" character varying(220) NOT NULL,
    id_client integer NOT NULL,
    id_city integer NOT NULL,
    "id_Equipment" integer NOT NULL,
    "id_Technician" integer NOT NULL,
    "id_ServiceType" integer NOT NULL,
    "ServiceDate" integer NOT NULL,
    "Hours" date NOT NULL,
    "Cost" real NOT NULL,
    CONSTRAINT id_client FOREIGN KEY (id_client)
        REFERENCES public.client (id_client) MATCH SIMPLE,
    CONSTRAINT id_city FOREIGN KEY (id_city)
        REFERENCES public.riwi_city (id_city) MATCH SIMPLE,
    CONSTRAINT "id_Equipment" FOREIGN KEY ("id_Equipment")
        REFERENCES public."riwi_Equipment" ("id_Equipment") MATCH SIMPLE,
    CONSTRAINT "id_Technician" FOREIGN KEY ("id_Technician")
        REFERENCES public."riwi_Technician" ("id_Technician") MATCH SIMPLE,
    CONSTRAINT "id_ServiceType" FOREIGN KEY ("id_ServiceType")
        REFERENCES public."riwi_ServiceTypent" ("id_ServiceTypent") MATCH SIMPLE

);


-------------------------------------------------------------

