-- GENERATED from library blueprint by vyuh_blueprint. Do not edit.

CREATE VIEW books.book_master_full WITH (security_invoker = true) AS
SELECT
  h.*
FROM books.book_master h
;

ALTER TABLE books.book_master ENABLE ROW LEVEL SECURITY;

REVOKE DELETE ON books.book_master FROM PUBLIC;

ALTER TABLE books.book_master_identity_audit ENABLE ROW LEVEL SECURITY;

DROP TRIGGER IF EXISTS book_master_identity_audit_immutable ON books.book_master_identity_audit;

CREATE TRIGGER book_master_identity_audit_immutable
BEFORE UPDATE OR DELETE ON books.book_master_identity_audit
FOR EACH ROW EXECUTE FUNCTION books.reject_history_mutation();
