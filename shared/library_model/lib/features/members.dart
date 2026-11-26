// Module "members": owns the Member entity.
import 'package:vyuh_blueprint/vyuh_blueprint.dart';

abstract final class MemberRefs {
  static const module = ModuleRef('members');
  static const member = EntityRef(module: module, name: 'member');
}

/// The fields of the Create Member form.
abstract final class MemberProperties {
  /// Auto-generated: MEM-00001, MEM-00002 … (read-only in the form).
  static final code = StandardProperties.number(
    name: 'member_code',
    prefix: 'MEM',
    scheme: NumberScheme.prefixed(digits: 5),
    maxLength: 9,
  );

  static final name = Property.text(
    'member_name',
    title: 'Member Name',
    required: true,
    minLength: 1,
    maxLength: 100,
  );

  static final email = Property.text(
    'email',
    title: 'Email',
    required: true,
    maxLength: 50,
  );

  static final phone = Property.text('phone', title: 'Phone', maxLength: 10);

  static final membershipType = Property.choice(
    'membership_type',
    title: 'Membership Type',
    required: true,
    layout: ChoiceLayout.dropdown,
    options: const {
      'student': Option('Student'),
      'staff': Option('Staff'),
      'public': Option('Public'),
    },
  );

  static final joinedOn = Property.date(
    'joined_on',
    title: 'Joined On',
    required: true,
    checks: const [WithinDaysOfToday(future: 0)],
  ).also(format: Format.date('dd-MM-yyyy'));

  static final validateTill = Property.date(
    'validate_till',
    title: 'Validate Till',
    required: true,
    //checks: const [WithinDaysOfToday(future: 0)],
  ).also(format: Format.date('dd-MM-yyyy'));

  static final isActive = Property.yesNo('is_active', title: 'Active');
}

final memberEntity = Entity(
  name: 'member',
  title: 'Member',
  nature: EntityNature.thing,
  db: const EntityDb(tableName: 'member_master'),
  ui: const EntityUI(display: RecordDisplay(title: 'member_name')),
  uniqueKeys: [
    UniqueKey([MemberProperties.code]),
  ],
  facets: [
    // Every field sits in the identity facet, so all of them are columns of
    // member_master. (Each extra Facet would become its own table.)
    IdentityFacet(
      properties: [
        MemberProperties.code,
        MemberProperties.name,
        MemberProperties.email,
        MemberProperties.phone,
        MemberProperties.membershipType,
        MemberProperties.joinedOn,
        MemberProperties.validateTill,
        MemberProperties.isActive,
      ],
    ),
  ],
);

final membersModule = Module(
  name: 'members',
  title: 'Members',
  entities: [memberEntity],
  exports: const [EntityExport(entity: MemberRefs.member)],
);
