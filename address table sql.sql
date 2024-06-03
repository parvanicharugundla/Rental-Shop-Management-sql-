-- Table: public.address

-- DROP TABLE IF EXISTS public.address;

CREATE TABLE IF NOT EXISTS public.address
(
    address_id integer NOT NULL DEFAULT nextval('address_address_id_seq'::regclass),
    address text COLLATE pg_catalog."default" NOT NULL,
    address2 text COLLATE pg_catalog."default",
    district text COLLATE pg_catalog."default" NOT NULL,
    city_id smallint NOT NULL,
    postal_code text COLLATE pg_catalog."default",
    phone text COLLATE pg_catalog."default" NOT NULL,
    last_update timestamp with time zone NOT NULL DEFAULT now(),
    CONSTRAINT address_pkey PRIMARY KEY (address_id),
    CONSTRAINT address_city_id_fkey FOREIGN KEY (city_id)
        REFERENCES public.city (city_id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE RESTRICT
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.address
    OWNER to postgres;
-- Index: idx_fk_city_id

-- DROP INDEX IF EXISTS public.idx_fk_city_id;

CREATE INDEX IF NOT EXISTS idx_fk_city_id
    ON public.address USING btree
    (city_id ASC NULLS LAST)
    TABLESPACE pg_default;

-- Trigger: last_updated

-- DROP TRIGGER IF EXISTS last_updated ON public.address;

CREATE OR REPLACE TRIGGER last_updated
    BEFORE UPDATE 
    ON public.address
    FOR EACH ROW
    EXECUTE FUNCTION public.last_updated();