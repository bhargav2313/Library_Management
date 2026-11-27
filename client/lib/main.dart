// The Category + Book app. Every screen and form is built by
// Blueprint UI from the shared model. We write no forms here.
//
// Run: flutter run -d web-server --web-port 8023
//        --dart-define=API_TOKEN=<token>
import 'package:flutter/services.dart';
import 'package:library_model/library_model.dart';
import 'package:material_ui/material_ui.dart';
import 'package:vyuh_blueprint/vyuh_blueprint.dart'
    show DateKind, PropertyAlso, VariantId, siteToday;
import 'package:vyuh_blueprint_protocol/vyuh_blueprint_protocol.dart';
import 'package:vyuh_blueprint_ui/auth.dart';
import 'package:vyuh_blueprint_ui/vyuh_blueprint_ui.dart';
import 'package:vyuh_cdx_ui/vyuh_cdx_ui.dart' as cdx;
import 'package:vyuh_core/vyuh_core.dart' as vc;
import 'package:vyuh_property_ui/vyuh_property_ui.dart' show PropertyEditor;

import 'library_api.dart' show TokenClient;

const apiBase = String.fromEnvironment(
  'API_BASE_URL',
  defaultValue: 'http://127.0.0.1:8024/api/',
);
const apiToken = String.fromEnvironment('API_TOKEN');

// Must match devActor / devTenant / devGrants in server/lib/auth.dart.
const devActor = '22222222-2222-4222-8222-222222222222';
const devTenant = '11111111-1111-4111-8111-111111111111';
const devGrants = [
  'category.category.create',
  'category.category.read',
  'books.book.create',
  'books.book.read',
  'locations.section.create',
  'locations.section.read',
  'locations.rack.create',
  'locations.rack.read',
  'members.member.create',
  'members.member.read',
];

/// A ready-made "signed in" session built from the dev token, so the app
/// starts signed in. A real app gets this from a login screen instead.
Map<String, Object?> devSession() => {
  'identity': {
    'id': devActor,
    'login_account_id': devActor,
    'directory_user_id': devActor,
    'display_name': 'Developer',
    'email': 'developer@library.local',
    'tenant_id': devTenant,
  },
  'actor_id': devActor,
  'session_id': devActor,
  'grants': devGrants,
  'tokens': {
    'access_token': apiToken,
    'refresh_token': '',
    'expires_at': DateTime.now()
        .toUtc()
        .add(const Duration(hours: 8))
        .toIso8601String(),
  },
  'session_policy': {
    'absolute_timeout_seconds': 28800,
    'inactivity_timeout_seconds': 28800,
    'authority_activity': false,
  },
};

Widget _message(String text) => Scaffold(
  body: Center(child: Text(text, textAlign: TextAlign.center)),
);

/// The screens Blueprint UI shows around sign-in. We keep them minimal.
final surfaces = BlueprintAuthenticationSurfaces(
  signIn: (context, auth) => _message('Signed out. Restart the app.'),
  resolving: (context, auth, {required wait, onSignOut}) =>
      const Scaffold(body: Center(child: CircularProgressIndicator())),
  serviceError: (context, auth) => _message('The API is not reachable.'),
  passwordChange: (context, auth) => _message('Not used in dev mode.'),
  sessionWarning: (context, auth) => _message('Session ending.'),
  sessionUnsavedNotice: (context, auth, {required child}) => child,
  workspaceLoadFailed: (context, auth, {required load, required onSignOut}) =>
      Scaffold(
        body: Center(
          child: FilledButton(
            onPressed: load.retry,
            child: const Text('Retry'),
          ),
        ),
      ),
  contactAdministrator: (
    context,
    plugin, {
    initialName = '',
    initialEmail = '',
    submittedFrom = '',
  }) async => null,
  signature: (context, request) async => false,
);

const _pastOrTodayDateVariant = VariantId('past_or_today_date');
const _validateTillDateVariant = VariantId('validate_till_date');
const _digitsOnlyPhoneVariant = VariantId('digits_only_phone');
const _lettersOnlyNameVariant = VariantId('letters_only_name');

final _digitsOnlyPattern = RegExp(r'^[0-9]*$');
final _lettersOnlyPattern = RegExp(r"^[A-Za-z .'-]*$");

DateTime? _parseDate(Object? raw) => switch (raw) {
  final DateTime d => d,
  final String s when s.isNotEmpty => DateTime.tryParse(s),
  _ => null,
};

String? _formatDdMmYyyy(Object? raw) {
  final parsed = _parseDate(raw);
  if (parsed == null) return null;
  final d = parsed.day.toString().padLeft(2, '0');
  final m = parsed.month.toString().padLeft(2, '0');
  final y = parsed.year.toString().padLeft(4, '0');
  return '$d-$m-$y';
}

Widget _datePickerEditor(
  BuildContext context,
  BlueprintFieldContext field, {
  required bool disableFuture,
  required bool requireJoinedOn,
}) {
  final today = siteToday(field.region);
  final joinedOnParsed = requireJoinedOn
      ? _parseDate(field.render.row?['joined_on'])
      : null;
  final joinedOnUtc = joinedOnParsed == null
      ? null
      : DateTime.utc(
          joinedOnParsed.year,
          joinedOnParsed.month,
          joinedOnParsed.day,
        );

  final waitingForJoinedOn = requireJoinedOn && joinedOnUtc == null;
  final firstDate = joinedOnUtc ?? DateTime(1900);
  final lastDate = disableFuture
      ? DateTime.utc(today.year, today.month, today.day)
      : DateTime(2200);

  final parsed = _parseDate(field.value);
  final rawValue = parsed == null
      ? null
      : DateTime.utc(parsed.year, parsed.month, parsed.day);
  final beforeJoin = rawValue != null && rawValue.isBefore(firstDate);
  final pickerValue = (waitingForJoinedOn || beforeJoin) ? null : rawValue;

  return Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: cdx.DateTimePicker(
      enabled: field.render.fieldEnabled && !waitingForJoinedOn,
      mode: cdx.DateTimePickerMode.date,
      datePattern: 'DD-MM-YYYY',
      value: pickerValue,
      firstDate: firstDate,
      lastDate: lastDate,
      helperText: waitingForJoinedOn ? 'Select Joined On first' : null,
      errorText: beforeJoin ? 'Must be on or after Joined On' : null,
      now: () => siteToday(field.region),
      onChanged: (picked) => field.render.onFieldChanged?.call(
        picked == null
            ? ''
            : DateKind.format(DateTime(picked.year, picked.month, picked.day)),
      ),
    ),
  );
}

class _FilteredTextField extends StatefulWidget {
  const _FilteredTextField({
    required this.field,
    required this.allowed,
    required this.maxLength,
    this.keyboardType = TextInputType.text,
    this.autofillHints,
    this.placeholder,
  });

  final BlueprintFieldContext field;
  final RegExp allowed;
  final int maxLength;
  final TextInputType keyboardType;
  final Iterable<String>? autofillHints;
  final String? placeholder;

  @override
  State<_FilteredTextField> createState() => _FilteredTextFieldState();
}

class _FilteredTextFieldState extends State<_FilteredTextField> {
  late final TextEditingController _controller = TextEditingController(
    text: widget.field.value?.toString() ?? '',
  );

  @override
  void didUpdateWidget(_FilteredTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    final nextText = widget.field.value?.toString() ?? '';
    if (_controller.text != nextText) {
      _controller.value = TextEditingValue(
        text: nextText,
        selection: TextSelection.collapsed(offset: nextText.length),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: cdx.CdxTextField(
        controller: _controller,
        enabled: widget.field.render.fieldEnabled,
        maxLength: widget.maxLength,
        keyboardType: widget.keyboardType,
        autofillHints: widget.autofillHints,
        placeholder: widget.placeholder,
        inputFormatters: [
          TextInputFormatter.withFunction(
            (oldValue, newValue) =>
                widget.allowed.hasMatch(newValue.text) ? newValue : oldValue,
          ),
        ],
        onChanged: (text) => widget.field.render.onFieldChanged?.call(text),
      ),
    );
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final base = Uri.parse(apiBase);

  // 1. The session: start already signed in with the dev token.
  final store = InMemoryBlueprintAuthSessionStore();
  await store.write(BlueprintAuthenticationSession.fromJson(devSession()));
  final auth = BlueprintAuthPlugin(
    authBase: base.resolve('auth/'),
    environment: 'local-dev',
    sessionStore: store,
  );

  // 2. The protocol client: every API call carries the token.
  final client = HttpBlueprintProtocolClient(
    base,
    httpClient: TokenClient(apiToken),
  );

  // 3. Blueprint UI builds the whole app from the shared libraryBlueprint.
  BlueprintApp.run(
    base,
    client: () => client,
    plugins: vc.PluginDescriptor(auth: auth),
    devTools: false,
    features: [
      vc.FeatureDescriptor(
        name: 'library',
        title: 'Library',
        routes: () => [],
        extensions: [
          BlueprintClientDescriptor(
            blueprints: [libraryBlueprint],
            hostUIBindings: HostUIBindings(
              fieldProperties: {
                'members.member.joined_on': MemberProperties.joinedOn.also(
                  shownAs: _pastOrTodayDateVariant,
                ),
                'members.member.validate_till': MemberProperties.validateTill
                    .also(shownAs: _validateTillDateVariant),
                'members.member.phone': MemberProperties.phone.also(
                  shownAs: _digitsOnlyPhoneVariant,
                ),
                'members.member.member_name': MemberProperties.name.also(
                  shownAs: _lettersOnlyNameVariant,
                ),
                'books.book.author': BookProperties.author.also(
                  shownAs: _lettersOnlyNameVariant,
                ),
              },
              fieldEditors: BlueprintFieldEditors(
                byVariant: {
                  _pastOrTodayDateVariant:
                      PropertyEditor<BlueprintFieldContext>(
                        edit: (context, field) => _datePickerEditor(
                          context,
                          field,
                          disableFuture: true,
                          requireJoinedOn: false,
                        ),
                        format: (view) => _formatDdMmYyyy(view.value),
                      ),
                  _validateTillDateVariant:
                      PropertyEditor<BlueprintFieldContext>(
                        edit: (context, field) => _datePickerEditor(
                          context,
                          field,
                          disableFuture: false,
                          requireJoinedOn: true,
                        ),
                        format: (view) => _formatDdMmYyyy(view.value),
                      ),
                  _digitsOnlyPhoneVariant:
                      PropertyEditor<BlueprintFieldContext>(
                        edit: (context, field) => _FilteredTextField(
                          field: field,
                          allowed: _digitsOnlyPattern,
                          maxLength: 10,
                          keyboardType: TextInputType.phone,
                          autofillHints: const [AutofillHints.telephoneNumber],
                          placeholder: '9876543210',
                        ),
                      ),
                  _lettersOnlyNameVariant:
                      PropertyEditor<BlueprintFieldContext>(
                        edit: (context, field) => _FilteredTextField(
                          field: field,
                          allowed: _lettersOnlyPattern,
                          maxLength: field.property.name == 'author'
                              ? 150
                              : 100,
                          placeholder: field.property.name == 'author'
                              ? 'e.g. Robert C. Martin'
                              : 'e.g. Priya Sharma',
                        ),
                      ),
                },
              ),
            ),
            authenticationSurfaces: surfaces,
          ),
        ],
      ),
    ],
  );
}
