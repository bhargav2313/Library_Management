-- GENERATED from library blueprint by vyuh_blueprint. Do not edit.

INSERT INTO library_runtime.app_ui (revision_id, kind, name, title, route_ref, entity, ui, metadata) VALUES ('library:1.0.0#24118fd0d1350f51', 'shell', 'app_shell', NULL, NULL, NULL, '{"scope":{"actor":{"enabled":true,"delegation":true,"impersonation":false},"tenant":{"enabled":true},"site":{"enabled":true},"selectors":[]},"deployment":{"enabled":false,"showProductionEnvironment":false,"separator":" • "},"userMenu":{"enabled":true,"items":[]},"appearance":{"defaultThemeMode":"system","supportedThemeModes":["light","dark","system"],"textScaleSteps":[1.0]},"savedViews":[],"reports":[],"help":{"enabled":true,"shortcut":"F1","fragments":[]}}'::jsonb, '{}'::jsonb) ON CONFLICT (revision_id, kind, name) DO NOTHING;

INSERT INTO library_runtime.app_ui (revision_id, kind, name, title, route_ref, entity, ui, metadata) VALUES ('library:1.0.0#24118fd0d1350f51', 'branding', 'main', NULL, NULL, NULL, '{"mark":null,"wordmark":null,"features":[],"supportUrl":null,"metadata":{}}'::jsonb, '{}'::jsonb) ON CONFLICT (revision_id, kind, name) DO NOTHING;

INSERT INTO library_runtime.app_ui (revision_id, kind, name, title, route_ref, entity, ui, metadata) VALUES ('library:1.0.0#24118fd0d1350f51', 'authentication', 'main', NULL, NULL, NULL, '{"enabled":false,"required":true,"loginPath":"/login","callbackPath":"/auth/callback","authenticatedPath":"/","publicPaths":[],"allowPasswordReset":false}'::jsonb, '{}'::jsonb) ON CONFLICT (revision_id, kind, name) DO NOTHING;

INSERT INTO library_runtime.app_ui (revision_id, kind, name, title, route_ref, entity, ui, metadata) VALUES ('library:1.0.0#24118fd0d1350f51', 'scope', 'main', NULL, NULL, NULL, '{"actor":{"enabled":true,"delegation":true,"impersonation":false},"tenant":{"enabled":true},"site":{"enabled":true},"selectors":[]}'::jsonb, '{}'::jsonb) ON CONFLICT (revision_id, kind, name) DO NOTHING;

INSERT INTO library_runtime.app_ui (revision_id, kind, name, title, route_ref, entity, ui, metadata) VALUES ('library:1.0.0#24118fd0d1350f51', 'deployment', 'main', NULL, NULL, NULL, '{"enabled":false,"showProductionEnvironment":false,"separator":" • "}'::jsonb, '{}'::jsonb) ON CONFLICT (revision_id, kind, name) DO NOTHING;

INSERT INTO library_runtime.app_ui (revision_id, kind, name, title, route_ref, entity, ui, metadata) VALUES ('library:1.0.0#24118fd0d1350f51', 'user_menu', 'main', NULL, NULL, NULL, '{"enabled":true,"items":[]}'::jsonb, '{}'::jsonb) ON CONFLICT (revision_id, kind, name) DO NOTHING;

INSERT INTO library_runtime.app_ui (revision_id, kind, name, title, route_ref, entity, ui, metadata) VALUES ('library:1.0.0#24118fd0d1350f51', 'appearance', 'main', NULL, NULL, NULL, '{"defaultThemeMode":"system","supportedThemeModes":["light","dark","system"],"textScaleSteps":[1.0]}'::jsonb, '{}'::jsonb) ON CONFLICT (revision_id, kind, name) DO NOTHING;

INSERT INTO library_runtime.app_ui (revision_id, kind, name, title, route_ref, entity, ui, metadata) VALUES ('library:1.0.0#24118fd0d1350f51', 'help', 'main', NULL, NULL, NULL, '{"enabled":true,"shortcut":"F1","fragments":[]}'::jsonb, '{}'::jsonb) ON CONFLICT (revision_id, kind, name) DO NOTHING;
