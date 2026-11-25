-- GENERATED from library blueprint by vyuh_blueprint. Do not edit.

CREATE INDEX IF NOT EXISTS idx_vyuh_runtime_controls_intent ON library_runtime.action_controls (intent_digest);

CREATE INDEX IF NOT EXISTS idx_vyuh_runtime_failures_record ON library_runtime.action_failures (action_record_id);

REVOKE ALL ON SCHEMA library_runtime FROM PUBLIC;

REVOKE ALL ON ALL TABLES IN SCHEMA library_runtime FROM PUBLIC;

REVOKE ALL ON ALL SEQUENCES IN SCHEMA library_runtime FROM PUBLIC;

REVOKE ALL ON ALL FUNCTIONS IN SCHEMA library_runtime FROM PUBLIC;

ALTER TABLE library_runtime.blueprint_revisions ENABLE ROW LEVEL SECURITY;

ALTER TABLE library_runtime.blueprint_archives ENABLE ROW LEVEL SECURITY;

ALTER TABLE library_runtime.blueprint_revision_refs ENABLE ROW LEVEL SECURITY;

ALTER TABLE library_runtime.blueprint_migration_plans ENABLE ROW LEVEL SECURITY;

ALTER TABLE library_runtime.blueprint_manifests ENABLE ROW LEVEL SECURITY;

ALTER TABLE library_runtime.entity_projections ENABLE ROW LEVEL SECURITY;

ALTER TABLE library_runtime.projection_sources ENABLE ROW LEVEL SECURITY;

ALTER TABLE library_runtime.action_capabilities ENABLE ROW LEVEL SECURITY;

ALTER TABLE library_runtime.app_ui ENABLE ROW LEVEL SECURITY;

ALTER TABLE library_runtime.policy_artifacts ENABLE ROW LEVEL SECURITY;

ALTER TABLE library_runtime.query_reads ENABLE ROW LEVEL SECURITY;

ALTER TABLE library_runtime.query_reads_undated ENABLE ROW LEVEL SECURITY;

ALTER TABLE library_runtime.action_requests ENABLE ROW LEVEL SECURITY;

ALTER TABLE library_runtime.action_commands ENABLE ROW LEVEL SECURITY;

ALTER TABLE library_runtime.execution_plans ENABLE ROW LEVEL SECURITY;

ALTER TABLE library_runtime.action_preflights ENABLE ROW LEVEL SECURITY;

ALTER TABLE library_runtime.replay_sequences ENABLE ROW LEVEL SECURITY;

ALTER TABLE library_runtime.action_records ENABLE ROW LEVEL SECURITY;

ALTER TABLE library_runtime.action_failures ENABLE ROW LEVEL SECURITY;

ALTER TABLE library_runtime.action_results ENABLE ROW LEVEL SECURITY;

ALTER TABLE library_runtime.action_effects ENABLE ROW LEVEL SECURITY;

ALTER TABLE library_runtime.action_snapshots ENABLE ROW LEVEL SECURITY;

ALTER TABLE library_runtime.action_events ENABLE ROW LEVEL SECURITY;

ALTER TABLE library_runtime.action_evidence ENABLE ROW LEVEL SECURITY;

ALTER TABLE library_runtime.action_controls ENABLE ROW LEVEL SECURITY;

ALTER TABLE library_runtime.bridge_cursors ENABLE ROW LEVEL SECURITY;

ALTER TABLE library_runtime.bridge_parked_items ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS query_reads_tenant_select ON library_runtime.query_reads;

CREATE POLICY query_reads_tenant_select ON library_runtime.query_reads FOR SELECT USING (tenant_id IS NOT NULL AND tenant_id = NULLIF(current_setting('vyuh.tenant_id', true), ''));

DROP POLICY IF EXISTS query_reads_tenant_insert ON library_runtime.query_reads;

CREATE POLICY query_reads_tenant_insert ON library_runtime.query_reads FOR INSERT WITH CHECK (tenant_id IS NOT NULL AND tenant_id = NULLIF(current_setting('vyuh.tenant_id', true), ''));

DROP POLICY IF EXISTS bridge_cursors_tenant_select ON library_runtime.bridge_cursors;

CREATE POLICY bridge_cursors_tenant_select ON library_runtime.bridge_cursors FOR SELECT USING (tenant_id IS NOT NULL AND tenant_id = NULLIF(current_setting('vyuh.tenant_id', true), ''));

DROP POLICY IF EXISTS bridge_parked_items_tenant_select ON library_runtime.bridge_parked_items;

CREATE POLICY bridge_parked_items_tenant_select ON library_runtime.bridge_parked_items FOR SELECT USING (tenant_id IS NOT NULL AND tenant_id = NULLIF(current_setting('vyuh.tenant_id', true), ''));

DROP POLICY IF EXISTS action_requests_tenant_select ON library_runtime.action_requests;

CREATE POLICY action_requests_tenant_select ON library_runtime.action_requests FOR SELECT USING (tenant_id IS NOT NULL AND tenant_id = NULLIF(current_setting('vyuh.tenant_id', true), ''));

DROP POLICY IF EXISTS action_commands_tenant_select ON library_runtime.action_commands;

CREATE POLICY action_commands_tenant_select ON library_runtime.action_commands FOR SELECT USING (EXISTS (SELECT 1 FROM library_runtime.action_requests r WHERE r.id = action_commands.request_id AND r.tenant_id IS NOT NULL AND r.tenant_id = NULLIF(current_setting('vyuh.tenant_id', true), '')));

DROP POLICY IF EXISTS execution_plans_tenant_select ON library_runtime.execution_plans;

CREATE POLICY execution_plans_tenant_select ON library_runtime.execution_plans FOR SELECT USING (EXISTS (SELECT 1 FROM library_runtime.action_requests r WHERE r.id = execution_plans.request_id AND r.tenant_id IS NOT NULL AND r.tenant_id = NULLIF(current_setting('vyuh.tenant_id', true), '')));

DROP POLICY IF EXISTS action_preflights_tenant_select ON library_runtime.action_preflights;

CREATE POLICY action_preflights_tenant_select ON library_runtime.action_preflights FOR SELECT USING (EXISTS (SELECT 1 FROM library_runtime.action_requests r WHERE r.id = action_preflights.request_id AND r.tenant_id IS NOT NULL AND r.tenant_id = NULLIF(current_setting('vyuh.tenant_id', true), '')));

DROP POLICY IF EXISTS action_records_tenant_select ON library_runtime.action_records;

CREATE POLICY action_records_tenant_select ON library_runtime.action_records FOR SELECT USING (EXISTS (SELECT 1 FROM library_runtime.action_requests r WHERE r.id = action_records.request_id AND r.tenant_id IS NOT NULL AND r.tenant_id = NULLIF(current_setting('vyuh.tenant_id', true), '')));

DROP POLICY IF EXISTS action_failures_tenant_select ON library_runtime.action_failures;

CREATE POLICY action_failures_tenant_select ON library_runtime.action_failures FOR SELECT USING (EXISTS (SELECT 1 FROM library_runtime.action_requests r WHERE r.id = action_failures.request_id AND r.tenant_id IS NOT NULL AND r.tenant_id = NULLIF(current_setting('vyuh.tenant_id', true), '')));

DROP POLICY IF EXISTS action_results_tenant_select ON library_runtime.action_results;

CREATE POLICY action_results_tenant_select ON library_runtime.action_results FOR SELECT USING (EXISTS (SELECT 1 FROM library_runtime.action_requests r WHERE r.id = action_results.request_id AND r.tenant_id IS NOT NULL AND r.tenant_id = NULLIF(current_setting('vyuh.tenant_id', true), '')));

DROP POLICY IF EXISTS action_effects_tenant_select ON library_runtime.action_effects;

CREATE POLICY action_effects_tenant_select ON library_runtime.action_effects FOR SELECT USING (EXISTS (SELECT 1 FROM library_runtime.action_requests r WHERE r.id = action_effects.request_id AND r.tenant_id IS NOT NULL AND r.tenant_id = NULLIF(current_setting('vyuh.tenant_id', true), '')));

DROP POLICY IF EXISTS action_snapshots_tenant_select ON library_runtime.action_snapshots;

CREATE POLICY action_snapshots_tenant_select ON library_runtime.action_snapshots FOR SELECT USING (EXISTS (SELECT 1 FROM library_runtime.action_requests r WHERE r.id = action_snapshots.request_id AND r.tenant_id IS NOT NULL AND r.tenant_id = NULLIF(current_setting('vyuh.tenant_id', true), '')));

DROP POLICY IF EXISTS action_events_tenant_select ON library_runtime.action_events;

CREATE POLICY action_events_tenant_select ON library_runtime.action_events FOR SELECT USING (EXISTS (SELECT 1 FROM library_runtime.action_requests r WHERE r.id = action_events.request_id AND r.tenant_id IS NOT NULL AND r.tenant_id = NULLIF(current_setting('vyuh.tenant_id', true), '')));

DROP POLICY IF EXISTS action_evidence_tenant_select ON library_runtime.action_evidence;

CREATE POLICY action_evidence_tenant_select ON library_runtime.action_evidence FOR SELECT USING (EXISTS (SELECT 1 FROM library_runtime.action_requests r WHERE r.id = action_evidence.request_id AND r.tenant_id IS NOT NULL AND r.tenant_id = NULLIF(current_setting('vyuh.tenant_id', true), '')));

DROP POLICY IF EXISTS action_controls_tenant_select ON library_runtime.action_controls;

CREATE POLICY action_controls_tenant_select ON library_runtime.action_controls FOR SELECT USING (EXISTS (SELECT 1 FROM library_runtime.action_requests r WHERE r.id = action_controls.request_id AND r.tenant_id IS NOT NULL AND r.tenant_id = NULLIF(current_setting('vyuh.tenant_id', true), '')));

CREATE OR REPLACE FUNCTION library_runtime.reject_immutable_mutation()
RETURNS trigger AS $$
BEGIN
  RAISE EXCEPTION 'immutable Blueprint runtime history cannot be changed';
END;
$$ LANGUAGE plpgsql SECURITY INVOKER SET search_path = pg_catalog, library_runtime;

REVOKE ALL ON FUNCTION library_runtime.reject_immutable_mutation() FROM PUBLIC;

DROP TRIGGER IF EXISTS blueprint_archives_immutable ON library_runtime.blueprint_archives;

CREATE TRIGGER blueprint_archives_immutable BEFORE UPDATE OR DELETE ON library_runtime.blueprint_archives FOR EACH ROW EXECUTE FUNCTION library_runtime.reject_immutable_mutation();

DROP TRIGGER IF EXISTS blueprint_revisions_immutable ON library_runtime.blueprint_revisions;

CREATE TRIGGER blueprint_revisions_immutable BEFORE UPDATE OR DELETE ON library_runtime.blueprint_revisions FOR EACH ROW EXECUTE FUNCTION library_runtime.reject_immutable_mutation();

DROP TRIGGER IF EXISTS blueprint_revision_refs_immutable ON library_runtime.blueprint_revision_refs;

CREATE TRIGGER blueprint_revision_refs_immutable BEFORE UPDATE OR DELETE ON library_runtime.blueprint_revision_refs FOR EACH ROW EXECUTE FUNCTION library_runtime.reject_immutable_mutation();

DROP TRIGGER IF EXISTS blueprint_manifests_immutable ON library_runtime.blueprint_manifests;

CREATE TRIGGER blueprint_manifests_immutable BEFORE UPDATE OR DELETE ON library_runtime.blueprint_manifests FOR EACH ROW EXECUTE FUNCTION library_runtime.reject_immutable_mutation();

DROP TRIGGER IF EXISTS entity_projections_immutable ON library_runtime.entity_projections;

CREATE TRIGGER entity_projections_immutable BEFORE UPDATE OR DELETE ON library_runtime.entity_projections FOR EACH ROW EXECUTE FUNCTION library_runtime.reject_immutable_mutation();

DROP TRIGGER IF EXISTS projection_sources_immutable ON library_runtime.projection_sources;

CREATE TRIGGER projection_sources_immutable BEFORE UPDATE OR DELETE ON library_runtime.projection_sources FOR EACH ROW EXECUTE FUNCTION library_runtime.reject_immutable_mutation();

DROP TRIGGER IF EXISTS action_capabilities_immutable ON library_runtime.action_capabilities;

CREATE TRIGGER action_capabilities_immutable BEFORE UPDATE OR DELETE ON library_runtime.action_capabilities FOR EACH ROW EXECUTE FUNCTION library_runtime.reject_immutable_mutation();

DROP TRIGGER IF EXISTS app_ui_immutable ON library_runtime.app_ui;

CREATE TRIGGER app_ui_immutable BEFORE UPDATE OR DELETE ON library_runtime.app_ui FOR EACH ROW EXECUTE FUNCTION library_runtime.reject_immutable_mutation();

DROP TRIGGER IF EXISTS policy_artifacts_immutable ON library_runtime.policy_artifacts;

CREATE TRIGGER policy_artifacts_immutable BEFORE UPDATE OR DELETE ON library_runtime.policy_artifacts FOR EACH ROW EXECUTE FUNCTION library_runtime.reject_immutable_mutation();

DROP TRIGGER IF EXISTS query_reads_immutable ON library_runtime.query_reads;

CREATE TRIGGER query_reads_immutable BEFORE UPDATE OR DELETE ON library_runtime.query_reads FOR EACH ROW EXECUTE FUNCTION library_runtime.reject_immutable_mutation();

DROP TRIGGER IF EXISTS execution_plans_immutable ON library_runtime.execution_plans;

CREATE TRIGGER execution_plans_immutable BEFORE UPDATE OR DELETE ON library_runtime.execution_plans FOR EACH ROW EXECUTE FUNCTION library_runtime.reject_immutable_mutation();

DROP TRIGGER IF EXISTS action_preflights_immutable ON library_runtime.action_preflights;

CREATE TRIGGER action_preflights_immutable BEFORE UPDATE OR DELETE ON library_runtime.action_preflights FOR EACH ROW EXECUTE FUNCTION library_runtime.reject_immutable_mutation();

DROP TRIGGER IF EXISTS action_records_immutable ON library_runtime.action_records;

CREATE TRIGGER action_records_immutable BEFORE UPDATE OR DELETE ON library_runtime.action_records FOR EACH ROW EXECUTE FUNCTION library_runtime.reject_immutable_mutation();

DROP TRIGGER IF EXISTS action_failures_immutable ON library_runtime.action_failures;

CREATE TRIGGER action_failures_immutable BEFORE UPDATE OR DELETE ON library_runtime.action_failures FOR EACH ROW EXECUTE FUNCTION library_runtime.reject_immutable_mutation();

DROP TRIGGER IF EXISTS action_results_immutable ON library_runtime.action_results;

CREATE TRIGGER action_results_immutable BEFORE UPDATE OR DELETE ON library_runtime.action_results FOR EACH ROW EXECUTE FUNCTION library_runtime.reject_immutable_mutation();

DROP TRIGGER IF EXISTS action_snapshots_immutable ON library_runtime.action_snapshots;

CREATE TRIGGER action_snapshots_immutable BEFORE UPDATE OR DELETE ON library_runtime.action_snapshots FOR EACH ROW EXECUTE FUNCTION library_runtime.reject_immutable_mutation();

DROP TRIGGER IF EXISTS action_events_immutable ON library_runtime.action_events;

CREATE TRIGGER action_events_immutable BEFORE UPDATE OR DELETE ON library_runtime.action_events FOR EACH ROW EXECUTE FUNCTION library_runtime.reject_immutable_mutation();

DROP TRIGGER IF EXISTS action_evidence_immutable ON library_runtime.action_evidence;

CREATE TRIGGER action_evidence_immutable BEFORE UPDATE OR DELETE ON library_runtime.action_evidence FOR EACH ROW EXECUTE FUNCTION library_runtime.reject_immutable_mutation();

DROP TRIGGER IF EXISTS action_controls_immutable ON library_runtime.action_controls;

CREATE TRIGGER action_controls_immutable BEFORE UPDATE OR DELETE ON library_runtime.action_controls FOR EACH ROW EXECUTE FUNCTION library_runtime.reject_immutable_mutation();
