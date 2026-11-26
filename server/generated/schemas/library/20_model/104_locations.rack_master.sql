-- GENERATED from library blueprint by vyuh_blueprint. Do not edit.

CREATE TABLE locations.rack_master (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  rack_code text,
  rack_name text NOT NULL,
  section_id uuid NOT NULL,
  capacity integer NOT NULL,
  created_at timestamptz NOT NULL DEFAULT NULLIF(current_setting('vyuh.occurred_at', true), '')::timestamptz,
  created_by text CONSTRAINT created_by_is_actor CHECK (locations.is_actor(created_by)),
  updated_at timestamptz NOT NULL DEFAULT NULLIF(current_setting('vyuh.occurred_at', true), '')::timestamptz,
  updated_by text CONSTRAINT updated_by_is_actor CHECK (locations.is_actor(updated_by)),
  archived_at timestamptz,
  UNIQUE (rack_code),
  FOREIGN KEY (section_id) REFERENCES locations.section_master(id) ON DELETE RESTRICT,
  CONSTRAINT rack_master_rack_code_issued CHECK (rack_code IS NOT NULL OR archived_at IS NOT NULL)
);

CREATE TABLE locations.rack_master_identity_audit (
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
COMMENT ON COLUMN locations.rack_master_identity_audit.action_context IS 'Stored document: vyuh.blueprint.historyActionContext/1.';

CREATE OR REPLACE FUNCTION locations.rack_master_rack_code_taken_fn(p_tenant text, p_number text)
RETURNS boolean
LANGUAGE plpgsql STABLE SECURITY DEFINER SET search_path = pg_catalog, pg_temp
AS $$
BEGIN
  RETURN EXISTS (SELECT 1 FROM locations.rack_master
    WHERE lower(btrim(rack_code::text)) = lower(btrim(p_number)));
END;
$$;

REVOKE ALL ON FUNCTION locations.rack_master_rack_code_taken_fn(text, text) FROM PUBLIC;

CREATE OR REPLACE FUNCTION locations.rack_master_rack_code_count_fn(p_tenant text)
RETURNS bigint
LANGUAGE plpgsql STABLE SECURITY DEFINER SET search_path = pg_catalog, pg_temp
AS $$
BEGIN
  RETURN (SELECT count(*) FROM locations.rack_master);
END;
$$;

REVOKE ALL ON FUNCTION locations.rack_master_rack_code_count_fn(text) FROM PUBLIC;

CREATE INDEX idx_rack_master_rack_code ON locations.rack_master (rack_code);

CREATE INDEX idx_rack_master_section_id ON locations.rack_master (section_id);

CREATE INDEX rack_master_identity_audit_history_idx ON locations.rack_master_identity_audit (entity_id, occurred_at DESC, id DESC);
