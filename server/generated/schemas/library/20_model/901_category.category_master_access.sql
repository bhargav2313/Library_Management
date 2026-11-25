-- GENERATED from library blueprint by vyuh_blueprint. Do not edit.

CREATE VIEW category.category_master_full WITH (security_invoker = true) AS
SELECT
  h.*
FROM category.category_master h
;

ALTER TABLE category.category_master ENABLE ROW LEVEL SECURITY;

REVOKE DELETE ON category.category_master FROM PUBLIC;

ALTER TABLE category.category_master_identity_audit ENABLE ROW LEVEL SECURITY;

DROP TRIGGER IF EXISTS category_master_identity_audit_immutable ON category.category_master_identity_audit;

CREATE TRIGGER category_master_identity_audit_immutable
BEFORE UPDATE OR DELETE ON category.category_master_identity_audit
FOR EACH ROW EXECUTE FUNCTION category.reject_history_mutation();
