-- GENERATED from library blueprint by vyuh_blueprint. Do not edit.

CREATE TABLE locations.section_master (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  section_code text,
  section_name text NOT NULL,
  floor_no integer NOT NULL,
  created_at timestamptz NOT NULL DEFAULT NULLIF(current_setting('vyuh.occurred_at', true), '')::timestamptz,
  created_by text CONSTRAINT created_by_is_actor CHECK (locations.is_actor(created_by)),
  updated_at timestamptz NOT NULL DEFAULT NULLIF(current_setting('vyuh.occurred_at', true), '')::timestamptz,
  updated_by text CONSTRAINT updated_by_is_actor CHECK (locations.is_actor(updated_by)),
  archived_at timestamptz,
  UNIQUE (section_code),
  CONSTRAINT section_master_section_code_issued CHECK (section_code IS NOT NULL OR archived_at IS NOT NULL)
);

CREATE TABLE locations.section_master_identity_audit (
  id bigserial PRIMARY KEY,
  entity_id uuid NOT NULL,
  trigger_name text NOT NULL,
  from_state text,
  to_state text,
  payload jsonb,
  actor_id text,
  on_behalf_of_id text,
  actor_source text NOT NULL DEFAULT 'anonymous',
  signature text,
  reason_code text,
  occurred_at timestamptz NOT NULL DEFAULT NULLIF(current_setting('vyuh.occurred_at', true), '')::timestamptz,
  action_context jsonb NOT NULL,
  action_record_id text,
  request_id text,
  command_id text,
  blueprint_revision text,
  pinned_versions jsonb,
  CONSTRAINT actor_id_is_actor CHECK (locations.is_actor(actor_id))
);
COMMENT ON COLUMN locations.section_master_identity_audit.action_context IS 'Stored document: vyuh.blueprint.historyActionContext/1.';

CREATE OR REPLACE FUNCTION locations.section_master_section_code_taken_fn(p_tenant text, p_number text)
RETURNS boolean
LANGUAGE plpgsql STABLE SECURITY DEFINER SET search_path = pg_catalog, pg_temp
AS $$
BEGIN
  RETURN EXISTS (SELECT 1 FROM locations.section_master
    WHERE lower(btrim(section_code::text)) = lower(btrim(p_number)));
END;
$$;

REVOKE ALL ON FUNCTION locations.section_master_section_code_taken_fn(text, text) FROM PUBLIC;

CREATE OR REPLACE FUNCTION locations.section_master_section_code_count_fn(p_tenant text)
RETURNS bigint
LANGUAGE plpgsql STABLE SECURITY DEFINER SET search_path = pg_catalog, pg_temp
AS $$
BEGIN
  RETURN (SELECT count(*) FROM locations.section_master);
END;
$$;

REVOKE ALL ON FUNCTION locations.section_master_section_code_count_fn(text) FROM PUBLIC;

CREATE INDEX idx_section_master_section_code ON locations.section_master (section_code);

CREATE INDEX section_master_identity_audit_history_idx ON locations.section_master_identity_audit (entity_id, occurred_at DESC, id DESC);
