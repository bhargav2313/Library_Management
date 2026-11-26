-- GENERATED from library blueprint by vyuh_blueprint. Do not edit.

CREATE VIEW locations.section_master_full WITH (security_invoker = true) AS
SELECT
  h.*
FROM locations.section_master h
;

ALTER TABLE locations.section_master ENABLE ROW LEVEL SECURITY;

REVOKE DELETE ON locations.section_master FROM PUBLIC;

ALTER TABLE locations.section_master_identity_audit ENABLE ROW LEVEL SECURITY;

DROP TRIGGER IF EXISTS section_master_identity_audit_immutable ON locations.section_master_identity_audit;

CREATE TRIGGER section_master_identity_audit_immutable
BEFORE UPDATE OR DELETE ON locations.section_master_identity_audit
FOR EACH ROW EXECUTE FUNCTION locations.reject_history_mutation();
