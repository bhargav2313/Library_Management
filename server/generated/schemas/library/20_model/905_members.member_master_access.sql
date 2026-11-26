-- GENERATED from library blueprint by vyuh_blueprint. Do not edit.

CREATE VIEW members.member_master_full WITH (security_invoker = true) AS
SELECT
  h.*
FROM members.member_master h
;

ALTER TABLE members.member_master ENABLE ROW LEVEL SECURITY;

REVOKE DELETE ON members.member_master FROM PUBLIC;

ALTER TABLE members.member_master_identity_audit ENABLE ROW LEVEL SECURITY;

DROP TRIGGER IF EXISTS member_master_identity_audit_immutable ON members.member_master_identity_audit;

CREATE TRIGGER member_master_identity_audit_immutable
BEFORE UPDATE OR DELETE ON members.member_master_identity_audit
FOR EACH ROW EXECUTE FUNCTION members.reject_history_mutation();
