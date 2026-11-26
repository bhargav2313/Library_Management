// Module "locations": owns Section and Rack (one Section has many Racks).
import 'package:vyuh_blueprint/vyuh_blueprint.dart';

abstract final class LocationRefs {
  static const module = ModuleRef('locations');
  static const section = EntityRef(module: module, name: 'section');
  static const rack = EntityRef(module: module, name: 'rack');
}

/// The fields of the Create Section form.
abstract final class SectionProperties {
  /// Auto-generated: SEC-00001, SEC-00002 … (read-only in the form).
  static final code = StandardProperties.number(
    name: 'section_code',
    prefix: 'SEC',
    scheme: NumberScheme.prefixed(digits: 5),
    maxLength: 9,
  );

  static final name = Property.text(
    'section_name',
    title: 'Section Name',
    required: true,
    minLength: 1,
    maxLength: 100,
  );

  static final floorNo = Property.wholeNumber(
    'floor_no',
    title: 'Floor No',
    required: true,
    atLeast: 0,
    atMost: 10,
  );
}

final sectionEntity = Entity(
  name: 'section',
  title: 'Section',
  nature: EntityNature.place,
  db: const EntityDb(tableName: 'section_master'),
  ui: const EntityUI(display: RecordDisplay(title: 'section_name')),
  uniqueKeys: [
    UniqueKey([SectionProperties.code]),
  ],
  facets: [
    // Every field sits in the identity facet, so all of them are columns of
    // locations.section_master.
    IdentityFacet(
      properties: [
        SectionProperties.code,
        SectionProperties.name,
        SectionProperties.floorNo,
      ],
    ),
  ],
);

/// The fields of the Create Rack form.
abstract final class RackProperties {
  /// Auto-generated: RK-00001, RK-00002 … (read-only in the form).
  static final code = StandardProperties.number(
    name: 'rack_code',
    prefix: 'RK',
    scheme: NumberScheme.prefixed(digits: 5),
    maxLength: 8,
  );

  static final name = Property.text(
    'rack_name',
    title: 'Rack Name',
    required: true,
    minLength: 1,
    maxLength: 100,
  );

  /// Parent Section (dropdown in the form).
  static final sectionId = StandardProperties.reference(
    'section_id',
    title: 'Section',
    required: true,
    target: LocationRefs.section,
  );

  static final section = Relationship(
    name: 'section',
    target: LocationRefs.section,
    field: sectionId,
    cardinality: RelationshipCardinality.hasOne,
    kind: RelationshipMeaning.locatedIn,
    onDelete: OnDelete.restrict,
  );

  static final capacity = Property.wholeNumber(
    'capacity',
    title: 'Capacity',
    required: true,
    atLeast: 1,
  );
}

final rackEntity = Entity(
  name: 'rack',
  title: 'Rack',
  nature: EntityNature.place,
  db: const EntityDb(tableName: 'rack_master'),
  ui: const EntityUI(display: RecordDisplay(title: 'rack_name')),
  uniqueKeys: [
    UniqueKey([RackProperties.code]),
  ],
  facets: [
    // One facet = one table: locations.rack_master holds every field,
    // including the section_id foreign key.
    IdentityFacet(
      properties: [
        RackProperties.code,
        RackProperties.name,
        RackProperties.sectionId,
        RackProperties.capacity,
      ],
      relationships: [RackProperties.section],
    ),
  ],
);

final locationsModule = Module(
  name: 'locations',
  title: 'Locations',
  entities: [sectionEntity, rackEntity],
  exports: const [
    EntityExport(entity: LocationRefs.section),
    EntityExport(entity: LocationRefs.rack),
  ],
);
