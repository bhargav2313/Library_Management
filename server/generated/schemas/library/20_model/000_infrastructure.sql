-- GENERATED from library blueprint by vyuh_blueprint. Do not edit.

CREATE SCHEMA IF NOT EXISTS category;

CREATE SCHEMA IF NOT EXISTS books;

CREATE SCHEMA IF NOT EXISTS locations;

CREATE TABLE category.number_series (
  tenant_id text NOT NULL,
  series text NOT NULL,
  last_number bigint NOT NULL,
  PRIMARY KEY (tenant_id, series)
);

CREATE TABLE category.number_holds (
  tenant_id text NOT NULL,
  series text NOT NULL,
  number bigint NOT NULL,
  record_id text NOT NULL,
  released_at timestamptz,
  PRIMARY KEY (tenant_id, series, number)
);

CREATE INDEX IF NOT EXISTS idx_number_holds_record ON category.number_holds (tenant_id, record_id);

CREATE TABLE books.number_series (
  tenant_id text NOT NULL,
  series text NOT NULL,
  last_number bigint NOT NULL,
  PRIMARY KEY (tenant_id, series)
);

CREATE TABLE books.number_holds (
  tenant_id text NOT NULL,
  series text NOT NULL,
  number bigint NOT NULL,
  record_id text NOT NULL,
  released_at timestamptz,
  PRIMARY KEY (tenant_id, series, number)
);

CREATE INDEX IF NOT EXISTS idx_number_holds_record ON books.number_holds (tenant_id, record_id);

CREATE TABLE locations.number_series (
  tenant_id text NOT NULL,
  series text NOT NULL,
  last_number bigint NOT NULL,
  PRIMARY KEY (tenant_id, series)
);

CREATE TABLE locations.number_holds (
  tenant_id text NOT NULL,
  series text NOT NULL,
  number bigint NOT NULL,
  record_id text NOT NULL,
  released_at timestamptz,
  PRIMARY KEY (tenant_id, series, number)
);

CREATE INDEX IF NOT EXISTS idx_number_holds_record ON locations.number_holds (tenant_id, record_id);

CREATE OR REPLACE FUNCTION category.take_number(p_tenant text, p_series text, p_floor bigint, p_reuse boolean, p_record text)
RETURNS bigint
LANGUAGE plpgsql SECURITY DEFINER SET search_path = pg_catalog, pg_temp
AS $$
DECLARE
  v_last bigint;
  v_number bigint;
BEGIN
  IF coalesce(p_tenant, '') <> '' AND p_tenant <> coalesce(NULLIF(current_setting('vyuh.tenant_id', true), ''), '') THEN
    RAISE EXCEPTION 'numbering: tenant % is not the request tenant', coalesce(p_tenant, '') USING ERRCODE = 'insufficient_privilege';
  END IF;
  INSERT INTO category.number_series (tenant_id, series, last_number)
  VALUES (p_tenant, p_series, 0)
  ON CONFLICT (tenant_id, series) DO NOTHING;
  SELECT last_number INTO v_last FROM category.number_series
  WHERE tenant_id = p_tenant AND series = p_series FOR UPDATE;
  IF p_reuse THEN
    SELECT number INTO v_number FROM category.number_holds
    WHERE tenant_id = p_tenant AND series = p_series
      AND released_at IS NOT NULL AND number >= p_floor
    ORDER BY number LIMIT 1 FOR UPDATE;
    IF FOUND THEN
      UPDATE category.number_holds SET record_id = p_record, released_at = NULL
      WHERE tenant_id = p_tenant AND series = p_series
        AND number = v_number;
      RETURN v_number;
    END IF;
  END IF;
  v_number := greatest(v_last + 1, p_floor);
  UPDATE category.number_series SET last_number = v_number
  WHERE tenant_id = p_tenant AND series = p_series;
  IF p_reuse THEN
    INSERT INTO category.number_holds (tenant_id, series, number, record_id)
    VALUES (p_tenant, p_series, v_number, p_record);
  END IF;
  RETURN v_number;
END;
$$;

REVOKE ALL ON FUNCTION category.take_number(text, text, bigint, boolean, text) FROM PUBLIC;

CREATE OR REPLACE FUNCTION category.release_number(p_tenant text, p_record text)
RETURNS text[]
LANGUAGE plpgsql SECURITY DEFINER SET search_path = pg_catalog, pg_temp
AS $$
DECLARE
  v_freed text[];
  v_at timestamptz := NULLIF(current_setting('vyuh.occurred_at', true), '')::timestamptz;
BEGIN
  IF coalesce(p_tenant, '') <> '' AND p_tenant <> coalesce(NULLIF(current_setting('vyuh.tenant_id', true), ''), '') THEN
    RAISE EXCEPTION 'numbering: tenant % is not the request tenant', coalesce(p_tenant, '') USING ERRCODE = 'insufficient_privilege';
  END IF;
  IF v_at IS NULL THEN
    RAISE EXCEPTION 'numbering: a release runs in a request with its captured time'
      USING ERRCODE = 'insufficient_privilege';
  END IF;
  WITH freed AS (
    UPDATE category.number_holds SET released_at = v_at
    WHERE tenant_id = p_tenant AND record_id = p_record
      AND released_at IS NULL
    RETURNING series
  )
  SELECT coalesce(array_agg(DISTINCT series), '{}') INTO v_freed
  FROM freed;
  RETURN v_freed;
END;
$$;

REVOKE ALL ON FUNCTION category.release_number(text, text) FROM PUBLIC;

CREATE OR REPLACE FUNCTION category.series_last(p_tenant text, p_series text)
RETURNS bigint
LANGUAGE plpgsql STABLE SECURITY DEFINER SET search_path = pg_catalog, pg_temp
AS $$
BEGIN
  IF coalesce(p_tenant, '') <> '' AND p_tenant <> coalesce(NULLIF(current_setting('vyuh.tenant_id', true), ''), '') THEN
    RAISE EXCEPTION 'numbering: tenant % is not the request tenant', coalesce(p_tenant, '') USING ERRCODE = 'insufficient_privilege';
  END IF;
  RETURN coalesce((SELECT last_number FROM category.number_series
    WHERE tenant_id = p_tenant AND series = p_series), 0);
END;
$$;

REVOKE ALL ON FUNCTION category.series_last(text, text) FROM PUBLIC;

CREATE OR REPLACE FUNCTION category.series_lowest_released(p_tenant text, p_series text, p_floor bigint)
RETURNS bigint
LANGUAGE plpgsql STABLE SECURITY DEFINER SET search_path = pg_catalog, pg_temp
AS $$
BEGIN
  IF coalesce(p_tenant, '') <> '' AND p_tenant <> coalesce(NULLIF(current_setting('vyuh.tenant_id', true), ''), '') THEN
    RAISE EXCEPTION 'numbering: tenant % is not the request tenant', coalesce(p_tenant, '') USING ERRCODE = 'insufficient_privilege';
  END IF;
  RETURN (SELECT min(number) FROM category.number_holds
    WHERE tenant_id = p_tenant AND series = p_series
      AND released_at IS NOT NULL AND number >= p_floor);
END;
$$;

REVOKE ALL ON FUNCTION category.series_lowest_released(text, text, bigint) FROM PUBLIC;

CREATE OR REPLACE FUNCTION books.take_number(p_tenant text, p_series text, p_floor bigint, p_reuse boolean, p_record text)
RETURNS bigint
LANGUAGE plpgsql SECURITY DEFINER SET search_path = pg_catalog, pg_temp
AS $$
DECLARE
  v_last bigint;
  v_number bigint;
BEGIN
  IF coalesce(p_tenant, '') <> '' AND p_tenant <> coalesce(NULLIF(current_setting('vyuh.tenant_id', true), ''), '') THEN
    RAISE EXCEPTION 'numbering: tenant % is not the request tenant', coalesce(p_tenant, '') USING ERRCODE = 'insufficient_privilege';
  END IF;
  INSERT INTO books.number_series (tenant_id, series, last_number)
  VALUES (p_tenant, p_series, 0)
  ON CONFLICT (tenant_id, series) DO NOTHING;
  SELECT last_number INTO v_last FROM books.number_series
  WHERE tenant_id = p_tenant AND series = p_series FOR UPDATE;
  IF p_reuse THEN
    SELECT number INTO v_number FROM books.number_holds
    WHERE tenant_id = p_tenant AND series = p_series
      AND released_at IS NOT NULL AND number >= p_floor
    ORDER BY number LIMIT 1 FOR UPDATE;
    IF FOUND THEN
      UPDATE books.number_holds SET record_id = p_record, released_at = NULL
      WHERE tenant_id = p_tenant AND series = p_series
        AND number = v_number;
      RETURN v_number;
    END IF;
  END IF;
  v_number := greatest(v_last + 1, p_floor);
  UPDATE books.number_series SET last_number = v_number
  WHERE tenant_id = p_tenant AND series = p_series;
  IF p_reuse THEN
    INSERT INTO books.number_holds (tenant_id, series, number, record_id)
    VALUES (p_tenant, p_series, v_number, p_record);
  END IF;
  RETURN v_number;
END;
$$;

REVOKE ALL ON FUNCTION books.take_number(text, text, bigint, boolean, text) FROM PUBLIC;

CREATE OR REPLACE FUNCTION books.release_number(p_tenant text, p_record text)
RETURNS text[]
LANGUAGE plpgsql SECURITY DEFINER SET search_path = pg_catalog, pg_temp
AS $$
DECLARE
  v_freed text[];
  v_at timestamptz := NULLIF(current_setting('vyuh.occurred_at', true), '')::timestamptz;
BEGIN
  IF coalesce(p_tenant, '') <> '' AND p_tenant <> coalesce(NULLIF(current_setting('vyuh.tenant_id', true), ''), '') THEN
    RAISE EXCEPTION 'numbering: tenant % is not the request tenant', coalesce(p_tenant, '') USING ERRCODE = 'insufficient_privilege';
  END IF;
  IF v_at IS NULL THEN
    RAISE EXCEPTION 'numbering: a release runs in a request with its captured time'
      USING ERRCODE = 'insufficient_privilege';
  END IF;
  WITH freed AS (
    UPDATE books.number_holds SET released_at = v_at
    WHERE tenant_id = p_tenant AND record_id = p_record
      AND released_at IS NULL
    RETURNING series
  )
  SELECT coalesce(array_agg(DISTINCT series), '{}') INTO v_freed
  FROM freed;
  RETURN v_freed;
END;
$$;

REVOKE ALL ON FUNCTION books.release_number(text, text) FROM PUBLIC;

CREATE OR REPLACE FUNCTION books.series_last(p_tenant text, p_series text)
RETURNS bigint
LANGUAGE plpgsql STABLE SECURITY DEFINER SET search_path = pg_catalog, pg_temp
AS $$
BEGIN
  IF coalesce(p_tenant, '') <> '' AND p_tenant <> coalesce(NULLIF(current_setting('vyuh.tenant_id', true), ''), '') THEN
    RAISE EXCEPTION 'numbering: tenant % is not the request tenant', coalesce(p_tenant, '') USING ERRCODE = 'insufficient_privilege';
  END IF;
  RETURN coalesce((SELECT last_number FROM books.number_series
    WHERE tenant_id = p_tenant AND series = p_series), 0);
END;
$$;

REVOKE ALL ON FUNCTION books.series_last(text, text) FROM PUBLIC;

CREATE OR REPLACE FUNCTION books.series_lowest_released(p_tenant text, p_series text, p_floor bigint)
RETURNS bigint
LANGUAGE plpgsql STABLE SECURITY DEFINER SET search_path = pg_catalog, pg_temp
AS $$
BEGIN
  IF coalesce(p_tenant, '') <> '' AND p_tenant <> coalesce(NULLIF(current_setting('vyuh.tenant_id', true), ''), '') THEN
    RAISE EXCEPTION 'numbering: tenant % is not the request tenant', coalesce(p_tenant, '') USING ERRCODE = 'insufficient_privilege';
  END IF;
  RETURN (SELECT min(number) FROM books.number_holds
    WHERE tenant_id = p_tenant AND series = p_series
      AND released_at IS NOT NULL AND number >= p_floor);
END;
$$;

REVOKE ALL ON FUNCTION books.series_lowest_released(text, text, bigint) FROM PUBLIC;

CREATE OR REPLACE FUNCTION locations.take_number(p_tenant text, p_series text, p_floor bigint, p_reuse boolean, p_record text)
RETURNS bigint
LANGUAGE plpgsql SECURITY DEFINER SET search_path = pg_catalog, pg_temp
AS $$
DECLARE
  v_last bigint;
  v_number bigint;
BEGIN
  IF coalesce(p_tenant, '') <> '' AND p_tenant <> coalesce(NULLIF(current_setting('vyuh.tenant_id', true), ''), '') THEN
    RAISE EXCEPTION 'numbering: tenant % is not the request tenant', coalesce(p_tenant, '') USING ERRCODE = 'insufficient_privilege';
  END IF;
  INSERT INTO locations.number_series (tenant_id, series, last_number)
  VALUES (p_tenant, p_series, 0)
  ON CONFLICT (tenant_id, series) DO NOTHING;
  SELECT last_number INTO v_last FROM locations.number_series
  WHERE tenant_id = p_tenant AND series = p_series FOR UPDATE;
  IF p_reuse THEN
    SELECT number INTO v_number FROM locations.number_holds
    WHERE tenant_id = p_tenant AND series = p_series
      AND released_at IS NOT NULL AND number >= p_floor
    ORDER BY number LIMIT 1 FOR UPDATE;
    IF FOUND THEN
      UPDATE locations.number_holds SET record_id = p_record, released_at = NULL
      WHERE tenant_id = p_tenant AND series = p_series
        AND number = v_number;
      RETURN v_number;
    END IF;
  END IF;
  v_number := greatest(v_last + 1, p_floor);
  UPDATE locations.number_series SET last_number = v_number
  WHERE tenant_id = p_tenant AND series = p_series;
  IF p_reuse THEN
    INSERT INTO locations.number_holds (tenant_id, series, number, record_id)
    VALUES (p_tenant, p_series, v_number, p_record);
  END IF;
  RETURN v_number;
END;
$$;

REVOKE ALL ON FUNCTION locations.take_number(text, text, bigint, boolean, text) FROM PUBLIC;

CREATE OR REPLACE FUNCTION locations.release_number(p_tenant text, p_record text)
RETURNS text[]
LANGUAGE plpgsql SECURITY DEFINER SET search_path = pg_catalog, pg_temp
AS $$
DECLARE
  v_freed text[];
  v_at timestamptz := NULLIF(current_setting('vyuh.occurred_at', true), '')::timestamptz;
BEGIN
  IF coalesce(p_tenant, '') <> '' AND p_tenant <> coalesce(NULLIF(current_setting('vyuh.tenant_id', true), ''), '') THEN
    RAISE EXCEPTION 'numbering: tenant % is not the request tenant', coalesce(p_tenant, '') USING ERRCODE = 'insufficient_privilege';
  END IF;
  IF v_at IS NULL THEN
    RAISE EXCEPTION 'numbering: a release runs in a request with its captured time'
      USING ERRCODE = 'insufficient_privilege';
  END IF;
  WITH freed AS (
    UPDATE locations.number_holds SET released_at = v_at
    WHERE tenant_id = p_tenant AND record_id = p_record
      AND released_at IS NULL
    RETURNING series
  )
  SELECT coalesce(array_agg(DISTINCT series), '{}') INTO v_freed
  FROM freed;
  RETURN v_freed;
END;
$$;

REVOKE ALL ON FUNCTION locations.release_number(text, text) FROM PUBLIC;

CREATE OR REPLACE FUNCTION locations.series_last(p_tenant text, p_series text)
RETURNS bigint
LANGUAGE plpgsql STABLE SECURITY DEFINER SET search_path = pg_catalog, pg_temp
AS $$
BEGIN
  IF coalesce(p_tenant, '') <> '' AND p_tenant <> coalesce(NULLIF(current_setting('vyuh.tenant_id', true), ''), '') THEN
    RAISE EXCEPTION 'numbering: tenant % is not the request tenant', coalesce(p_tenant, '') USING ERRCODE = 'insufficient_privilege';
  END IF;
  RETURN coalesce((SELECT last_number FROM locations.number_series
    WHERE tenant_id = p_tenant AND series = p_series), 0);
END;
$$;

REVOKE ALL ON FUNCTION locations.series_last(text, text) FROM PUBLIC;

CREATE OR REPLACE FUNCTION locations.series_lowest_released(p_tenant text, p_series text, p_floor bigint)
RETURNS bigint
LANGUAGE plpgsql STABLE SECURITY DEFINER SET search_path = pg_catalog, pg_temp
AS $$
BEGIN
  IF coalesce(p_tenant, '') <> '' AND p_tenant <> coalesce(NULLIF(current_setting('vyuh.tenant_id', true), ''), '') THEN
    RAISE EXCEPTION 'numbering: tenant % is not the request tenant', coalesce(p_tenant, '') USING ERRCODE = 'insufficient_privilege';
  END IF;
  RETURN (SELECT min(number) FROM locations.number_holds
    WHERE tenant_id = p_tenant AND series = p_series
      AND released_at IS NOT NULL AND number >= p_floor);
END;
$$;

REVOKE ALL ON FUNCTION locations.series_lowest_released(text, text, bigint) FROM PUBLIC;

CREATE OR REPLACE VIEW category.system_actors AS
  SELECT * FROM (VALUES
    ('system:seed', 'seed', 'Seed', ARRAY['create', 'maintain']::text[]),
    ('system:provisioning', 'provisioning', 'Provisioning', ARRAY['create']::text[]),
    ('system:fixture', 'fixture', 'Fixture', ARRAY['create', 'migrate']::text[]),
    ('system:migration', 'migration', 'Migration', ARRAY['migrate']::text[]),
    ('system:restore', 'restore', 'Restore', ARRAY['migrate']::text[]),
    ('system:kernel', 'kernel', 'Runtime', ARRAY['act']::text[]),
    ('system:outbox-dispatcher', 'outbox-dispatcher', 'Outbox', ARRAY['act']::text[]),
    ('system:workflow-bridge', 'workflow-bridge', 'Workflow', ARRAY['act']::text[]),
    ('system:storage-download', 'storage-download', 'Storage', ARRAY['act']::text[]),
    ('system:storage-sweep', 'storage-sweep', 'Storage', ARRAY['act']::text[]),
    ('system:storage-processor', 'storage-processor', 'Storage', ARRAY['act']::text[])
  ) AS actors(id, facet, label, powers);

CREATE OR REPLACE FUNCTION category.is_actor(p_actor text)
RETURNS boolean
LANGUAGE sql IMMUTABLE PARALLEL SAFE
AS $$
  SELECT p_actor IS NULL
    OR NOT (lower(p_actor) = 'system' OR lower(p_actor) LIKE 'system:%')
    OR p_actor = ANY (ARRAY['system:seed', 'system:provisioning', 'system:fixture', 'system:migration', 'system:restore', 'system:kernel', 'system:outbox-dispatcher', 'system:workflow-bridge', 'system:storage-download', 'system:storage-sweep', 'system:storage-processor']::text[])
$$;

CREATE OR REPLACE FUNCTION category.begin_system_write(
  p_facet text,
  p_power text DEFAULT NULL
)
RETURNS jsonb
LANGUAGE plpgsql SECURITY INVOKER
AS $$
DECLARE
  v_powers text[];
  v_power text;
  v_previous jsonb;
BEGIN
  SELECT powers INTO v_powers FROM category.system_actors WHERE facet = p_facet;
  IF v_powers IS NULL THEN
    RAISE EXCEPTION 'system:% is not a declared System facet', p_facet
      USING ERRCODE = '22023';
  END IF;
  v_power := COALESCE(p_power, v_powers[1]);
  IF NOT v_power = ANY (v_powers) THEN
    RAISE EXCEPTION 'system:% may not %', p_facet, v_power
      USING ERRCODE = '42501';
  END IF;
  SELECT jsonb_object_agg(name, COALESCE(current_setting(name, true), ''))
    INTO v_previous FROM unnest(ARRAY['vyuh.actor_id', 'vyuh.actor_source', 'vyuh.actor_roles', 'vyuh.system_power', 'vyuh.system_kept']) AS name;
  PERFORM set_config('vyuh.actor_id', 'system:' || p_facet, true),
    set_config('vyuh.actor_source', 'system', true),
    set_config('vyuh.actor_roles', '["system"]', true),
    set_config('vyuh.system_power', v_power, true),
    set_config('vyuh.system_kept', '', true);
  RETURN v_previous;
END;
$$;

CREATE OR REPLACE FUNCTION category.end_system_write(p_previous jsonb)
RETURNS void
LANGUAGE sql SECURITY INVOKER
AS $$
  SELECT count(set_config(name, COALESCE(p_previous ->> name, ''), true))::int
  FROM unnest(ARRAY['vyuh.actor_id', 'vyuh.actor_source', 'vyuh.actor_roles', 'vyuh.system_power', 'vyuh.system_kept']) AS name;
$$;

CREATE OR REPLACE FUNCTION category.system_writes_kept()
RETURNS integer
LANGUAGE sql STABLE
AS $$
  SELECT count(DISTINCT id)::int FROM unnest(string_to_array(NULLIF(current_setting('vyuh.system_kept', true), ''), ',')) AS id
$$;

CREATE OR REPLACE FUNCTION category.system_write_guard()
RETURNS trigger
LANGUAGE plpgsql SECURITY INVOKER
AS $$
DECLARE
  v_source text := NULLIF(current_setting('vyuh.actor_source', true), '');
  v_power text := NULLIF(current_setting('vyuh.system_power', true), '');
  v_id text;
  v_latest text;
  v_kept text;
BEGIN
  IF v_source IS NULL THEN
    RAISE EXCEPTION 'A write to %.% names no actor. Run it through the runtime, or open the transaction with begin_system_write(<facet>)', TG_TABLE_SCHEMA, TG_TABLE_NAME
      USING ERRCODE = '42501';
  END IF;
  IF v_power IS NULL OR v_power NOT IN ('create', 'maintain') THEN
    RETURN CASE WHEN TG_OP = 'DELETE' THEN OLD ELSE NEW END;
  END IF;
  v_id := to_jsonb(CASE WHEN TG_OP = 'INSERT' THEN NEW ELSE OLD END) ->> TG_ARGV[1];
  EXECUTE format('SELECT actor_source FROM %s WHERE entity_id = $1 ORDER BY version DESC LIMIT 1', TG_ARGV[0])
    INTO v_latest USING v_id::uuid;
  IF v_latest IS NULL OR (v_power = 'maintain' AND v_latest = 'system') THEN
    RETURN CASE WHEN TG_OP = 'DELETE' THEN OLD ELSE NEW END;
  END IF;
  IF v_latest <> 'system' THEN
    RAISE NOTICE 'Kept %.% %: a person changed it, so % leaves it as it is', TG_TABLE_SCHEMA, TG_TABLE_NAME, v_id, current_setting('vyuh.actor_id', true);
    v_kept := NULLIF(current_setting('vyuh.system_kept', true), '');
    PERFORM set_config('vyuh.system_kept', CASE WHEN v_kept IS NULL THEN v_id ELSE v_kept || ',' || v_id END, true);
  END IF;
  RETURN NULL;
END;
$$;

CREATE OR REPLACE VIEW books.system_actors AS
  SELECT * FROM (VALUES
    ('system:seed', 'seed', 'Seed', ARRAY['create', 'maintain']::text[]),
    ('system:provisioning', 'provisioning', 'Provisioning', ARRAY['create']::text[]),
    ('system:fixture', 'fixture', 'Fixture', ARRAY['create', 'migrate']::text[]),
    ('system:migration', 'migration', 'Migration', ARRAY['migrate']::text[]),
    ('system:restore', 'restore', 'Restore', ARRAY['migrate']::text[]),
    ('system:kernel', 'kernel', 'Runtime', ARRAY['act']::text[]),
    ('system:outbox-dispatcher', 'outbox-dispatcher', 'Outbox', ARRAY['act']::text[]),
    ('system:workflow-bridge', 'workflow-bridge', 'Workflow', ARRAY['act']::text[]),
    ('system:storage-download', 'storage-download', 'Storage', ARRAY['act']::text[]),
    ('system:storage-sweep', 'storage-sweep', 'Storage', ARRAY['act']::text[]),
    ('system:storage-processor', 'storage-processor', 'Storage', ARRAY['act']::text[])
  ) AS actors(id, facet, label, powers);

CREATE OR REPLACE FUNCTION books.is_actor(p_actor text)
RETURNS boolean
LANGUAGE sql IMMUTABLE PARALLEL SAFE
AS $$
  SELECT p_actor IS NULL
    OR NOT (lower(p_actor) = 'system' OR lower(p_actor) LIKE 'system:%')
    OR p_actor = ANY (ARRAY['system:seed', 'system:provisioning', 'system:fixture', 'system:migration', 'system:restore', 'system:kernel', 'system:outbox-dispatcher', 'system:workflow-bridge', 'system:storage-download', 'system:storage-sweep', 'system:storage-processor']::text[])
$$;

CREATE OR REPLACE FUNCTION books.begin_system_write(
  p_facet text,
  p_power text DEFAULT NULL
)
RETURNS jsonb
LANGUAGE plpgsql SECURITY INVOKER
AS $$
DECLARE
  v_powers text[];
  v_power text;
  v_previous jsonb;
BEGIN
  SELECT powers INTO v_powers FROM books.system_actors WHERE facet = p_facet;
  IF v_powers IS NULL THEN
    RAISE EXCEPTION 'system:% is not a declared System facet', p_facet
      USING ERRCODE = '22023';
  END IF;
  v_power := COALESCE(p_power, v_powers[1]);
  IF NOT v_power = ANY (v_powers) THEN
    RAISE EXCEPTION 'system:% may not %', p_facet, v_power
      USING ERRCODE = '42501';
  END IF;
  SELECT jsonb_object_agg(name, COALESCE(current_setting(name, true), ''))
    INTO v_previous FROM unnest(ARRAY['vyuh.actor_id', 'vyuh.actor_source', 'vyuh.actor_roles', 'vyuh.system_power', 'vyuh.system_kept']) AS name;
  PERFORM set_config('vyuh.actor_id', 'system:' || p_facet, true),
    set_config('vyuh.actor_source', 'system', true),
    set_config('vyuh.actor_roles', '["system"]', true),
    set_config('vyuh.system_power', v_power, true),
    set_config('vyuh.system_kept', '', true);
  RETURN v_previous;
END;
$$;

CREATE OR REPLACE FUNCTION books.end_system_write(p_previous jsonb)
RETURNS void
LANGUAGE sql SECURITY INVOKER
AS $$
  SELECT count(set_config(name, COALESCE(p_previous ->> name, ''), true))::int
  FROM unnest(ARRAY['vyuh.actor_id', 'vyuh.actor_source', 'vyuh.actor_roles', 'vyuh.system_power', 'vyuh.system_kept']) AS name;
$$;

CREATE OR REPLACE FUNCTION books.system_writes_kept()
RETURNS integer
LANGUAGE sql STABLE
AS $$
  SELECT count(DISTINCT id)::int FROM unnest(string_to_array(NULLIF(current_setting('vyuh.system_kept', true), ''), ',')) AS id
$$;

CREATE OR REPLACE FUNCTION books.system_write_guard()
RETURNS trigger
LANGUAGE plpgsql SECURITY INVOKER
AS $$
DECLARE
  v_source text := NULLIF(current_setting('vyuh.actor_source', true), '');
  v_power text := NULLIF(current_setting('vyuh.system_power', true), '');
  v_id text;
  v_latest text;
  v_kept text;
BEGIN
  IF v_source IS NULL THEN
    RAISE EXCEPTION 'A write to %.% names no actor. Run it through the runtime, or open the transaction with begin_system_write(<facet>)', TG_TABLE_SCHEMA, TG_TABLE_NAME
      USING ERRCODE = '42501';
  END IF;
  IF v_power IS NULL OR v_power NOT IN ('create', 'maintain') THEN
    RETURN CASE WHEN TG_OP = 'DELETE' THEN OLD ELSE NEW END;
  END IF;
  v_id := to_jsonb(CASE WHEN TG_OP = 'INSERT' THEN NEW ELSE OLD END) ->> TG_ARGV[1];
  EXECUTE format('SELECT actor_source FROM %s WHERE entity_id = $1 ORDER BY version DESC LIMIT 1', TG_ARGV[0])
    INTO v_latest USING v_id::uuid;
  IF v_latest IS NULL OR (v_power = 'maintain' AND v_latest = 'system') THEN
    RETURN CASE WHEN TG_OP = 'DELETE' THEN OLD ELSE NEW END;
  END IF;
  IF v_latest <> 'system' THEN
    RAISE NOTICE 'Kept %.% %: a person changed it, so % leaves it as it is', TG_TABLE_SCHEMA, TG_TABLE_NAME, v_id, current_setting('vyuh.actor_id', true);
    v_kept := NULLIF(current_setting('vyuh.system_kept', true), '');
    PERFORM set_config('vyuh.system_kept', CASE WHEN v_kept IS NULL THEN v_id ELSE v_kept || ',' || v_id END, true);
  END IF;
  RETURN NULL;
END;
$$;

CREATE OR REPLACE VIEW locations.system_actors AS
  SELECT * FROM (VALUES
    ('system:seed', 'seed', 'Seed', ARRAY['create', 'maintain']::text[]),
    ('system:provisioning', 'provisioning', 'Provisioning', ARRAY['create']::text[]),
    ('system:fixture', 'fixture', 'Fixture', ARRAY['create', 'migrate']::text[]),
    ('system:migration', 'migration', 'Migration', ARRAY['migrate']::text[]),
    ('system:restore', 'restore', 'Restore', ARRAY['migrate']::text[]),
    ('system:kernel', 'kernel', 'Runtime', ARRAY['act']::text[]),
    ('system:outbox-dispatcher', 'outbox-dispatcher', 'Outbox', ARRAY['act']::text[]),
    ('system:workflow-bridge', 'workflow-bridge', 'Workflow', ARRAY['act']::text[]),
    ('system:storage-download', 'storage-download', 'Storage', ARRAY['act']::text[]),
    ('system:storage-sweep', 'storage-sweep', 'Storage', ARRAY['act']::text[]),
    ('system:storage-processor', 'storage-processor', 'Storage', ARRAY['act']::text[])
  ) AS actors(id, facet, label, powers);

CREATE OR REPLACE FUNCTION locations.is_actor(p_actor text)
RETURNS boolean
LANGUAGE sql IMMUTABLE PARALLEL SAFE
AS $$
  SELECT p_actor IS NULL
    OR NOT (lower(p_actor) = 'system' OR lower(p_actor) LIKE 'system:%')
    OR p_actor = ANY (ARRAY['system:seed', 'system:provisioning', 'system:fixture', 'system:migration', 'system:restore', 'system:kernel', 'system:outbox-dispatcher', 'system:workflow-bridge', 'system:storage-download', 'system:storage-sweep', 'system:storage-processor']::text[])
$$;

CREATE OR REPLACE FUNCTION locations.begin_system_write(
  p_facet text,
  p_power text DEFAULT NULL
)
RETURNS jsonb
LANGUAGE plpgsql SECURITY INVOKER
AS $$
DECLARE
  v_powers text[];
  v_power text;
  v_previous jsonb;
BEGIN
  SELECT powers INTO v_powers FROM locations.system_actors WHERE facet = p_facet;
  IF v_powers IS NULL THEN
    RAISE EXCEPTION 'system:% is not a declared System facet', p_facet
      USING ERRCODE = '22023';
  END IF;
  v_power := COALESCE(p_power, v_powers[1]);
  IF NOT v_power = ANY (v_powers) THEN
    RAISE EXCEPTION 'system:% may not %', p_facet, v_power
      USING ERRCODE = '42501';
  END IF;
  SELECT jsonb_object_agg(name, COALESCE(current_setting(name, true), ''))
    INTO v_previous FROM unnest(ARRAY['vyuh.actor_id', 'vyuh.actor_source', 'vyuh.actor_roles', 'vyuh.system_power', 'vyuh.system_kept']) AS name;
  PERFORM set_config('vyuh.actor_id', 'system:' || p_facet, true),
    set_config('vyuh.actor_source', 'system', true),
    set_config('vyuh.actor_roles', '["system"]', true),
    set_config('vyuh.system_power', v_power, true),
    set_config('vyuh.system_kept', '', true);
  RETURN v_previous;
END;
$$;

CREATE OR REPLACE FUNCTION locations.end_system_write(p_previous jsonb)
RETURNS void
LANGUAGE sql SECURITY INVOKER
AS $$
  SELECT count(set_config(name, COALESCE(p_previous ->> name, ''), true))::int
  FROM unnest(ARRAY['vyuh.actor_id', 'vyuh.actor_source', 'vyuh.actor_roles', 'vyuh.system_power', 'vyuh.system_kept']) AS name;
$$;

CREATE OR REPLACE FUNCTION locations.system_writes_kept()
RETURNS integer
LANGUAGE sql STABLE
AS $$
  SELECT count(DISTINCT id)::int FROM unnest(string_to_array(NULLIF(current_setting('vyuh.system_kept', true), ''), ',')) AS id
$$;

CREATE OR REPLACE FUNCTION locations.system_write_guard()
RETURNS trigger
LANGUAGE plpgsql SECURITY INVOKER
AS $$
DECLARE
  v_source text := NULLIF(current_setting('vyuh.actor_source', true), '');
  v_power text := NULLIF(current_setting('vyuh.system_power', true), '');
  v_id text;
  v_latest text;
  v_kept text;
BEGIN
  IF v_source IS NULL THEN
    RAISE EXCEPTION 'A write to %.% names no actor. Run it through the runtime, or open the transaction with begin_system_write(<facet>)', TG_TABLE_SCHEMA, TG_TABLE_NAME
      USING ERRCODE = '42501';
  END IF;
  IF v_power IS NULL OR v_power NOT IN ('create', 'maintain') THEN
    RETURN CASE WHEN TG_OP = 'DELETE' THEN OLD ELSE NEW END;
  END IF;
  v_id := to_jsonb(CASE WHEN TG_OP = 'INSERT' THEN NEW ELSE OLD END) ->> TG_ARGV[1];
  EXECUTE format('SELECT actor_source FROM %s WHERE entity_id = $1 ORDER BY version DESC LIMIT 1', TG_ARGV[0])
    INTO v_latest USING v_id::uuid;
  IF v_latest IS NULL OR (v_power = 'maintain' AND v_latest = 'system') THEN
    RETURN CASE WHEN TG_OP = 'DELETE' THEN OLD ELSE NEW END;
  END IF;
  IF v_latest <> 'system' THEN
    RAISE NOTICE 'Kept %.% %: a person changed it, so % leaves it as it is', TG_TABLE_SCHEMA, TG_TABLE_NAME, v_id, current_setting('vyuh.actor_id', true);
    v_kept := NULLIF(current_setting('vyuh.system_kept', true), '');
    PERFORM set_config('vyuh.system_kept', CASE WHEN v_kept IS NULL THEN v_id ELSE v_kept || ',' || v_id END, true);
  END IF;
  RETURN NULL;
END;
$$;

CREATE OR REPLACE FUNCTION category.reject_history_mutation()
RETURNS trigger AS $$
BEGIN
  RAISE EXCEPTION 'immutable Blueprint history cannot be changed';
END;
$$ LANGUAGE plpgsql SECURITY INVOKER SET search_path = pg_catalog, category;

CREATE OR REPLACE FUNCTION books.reject_history_mutation()
RETURNS trigger AS $$
BEGIN
  RAISE EXCEPTION 'immutable Blueprint history cannot be changed';
END;
$$ LANGUAGE plpgsql SECURITY INVOKER SET search_path = pg_catalog, books;

CREATE OR REPLACE FUNCTION locations.reject_history_mutation()
RETURNS trigger AS $$
BEGIN
  RAISE EXCEPTION 'immutable Blueprint history cannot be changed';
END;
$$ LANGUAGE plpgsql SECURITY INVOKER SET search_path = pg_catalog, locations;
