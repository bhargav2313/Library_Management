-- GENERATED from library blueprint by vyuh_blueprint. Do not edit.

CREATE VIEW locations.rack_master_full WITH (security_invoker = true) AS
SELECT
  h.*
FROM locations.rack_master h
;

ALTER TABLE locations.rack_master ENABLE ROW LEVEL SECURITY;

REVOKE DELETE ON locations.rack_master FROM PUBLIC;

ALTER TABLE locations.rack_master_identity_audit ENABLE ROW LEVEL SECURITY;

DROP TRIGGER IF EXISTS rack_master_identity_audit_immutable ON locations.rack_master_identity_audit;

CREATE TRIGGER rack_master_identity_audit_immutable
BEFORE UPDATE OR DELETE ON locations.rack_master_identity_audit
FOR EACH ROW EXECUTE FUNCTION locations.reject_history_mutation();
