// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rider.dart';

// **************************************************************************
// CollectionGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

class _Sentinel {
  const _Sentinel();
}

const _sentinel = _Sentinel();

/// A collection reference object can be used for adding documents,
/// getting document references, and querying for documents
/// (using the methods inherited from Query).
abstract class RiderCollectionReference
    implements
        RiderQuery,
        FirestoreCollectionReference<Rider, RiderQuerySnapshot> {
  factory RiderCollectionReference([
    FirebaseFirestore? firestore,
  ]) = _$RiderCollectionReference;

  static Rider fromFirestore(
    DocumentSnapshot<Map<String, Object?>> snapshot,
    SnapshotOptions? options,
  ) {
    return Rider.fromJson(snapshot.data()!);
  }

  static Map<String, Object?> toFirestore(
    Rider value,
    SetOptions? options,
  ) {
    return _$RiderToJson(value);
  }

  @override
  CollectionReference<Rider> get reference;

  @override
  RiderDocumentReference doc([String? id]);

  /// Add a new document to this collection with the specified data,
  /// assigning it a document ID automatically.
  Future<RiderDocumentReference> add(Rider value);
}

class _$RiderCollectionReference extends _$RiderQuery
    implements RiderCollectionReference {
  factory _$RiderCollectionReference([FirebaseFirestore? firestore]) {
    firestore ??= FirebaseFirestore.instance;

    return _$RiderCollectionReference._(
      firestore.collection('Rider').withConverter(
            fromFirestore: RiderCollectionReference.fromFirestore,
            toFirestore: RiderCollectionReference.toFirestore,
          ),
    );
  }

  _$RiderCollectionReference._(
    CollectionReference<Rider> reference,
  ) : super(reference, reference);

  String get path => reference.path;

  @override
  CollectionReference<Rider> get reference =>
      super.reference as CollectionReference<Rider>;

  @override
  RiderDocumentReference doc([String? id]) {
    assert(
      id == null || id.split('/').length == 1,
      'The document ID cannot be from a different collection',
    );
    return RiderDocumentReference(
      reference.doc(id),
    );
  }

  @override
  Future<RiderDocumentReference> add(Rider value) {
    return reference.add(value).then((ref) => RiderDocumentReference(ref));
  }

  @override
  bool operator ==(Object other) {
    return other is _$RiderCollectionReference &&
        other.runtimeType == runtimeType &&
        other.reference == reference;
  }

  @override
  int get hashCode => Object.hash(runtimeType, reference);
}

abstract class RiderDocumentReference
    extends FirestoreDocumentReference<Rider, RiderDocumentSnapshot> {
  factory RiderDocumentReference(DocumentReference<Rider> reference) =
      _$RiderDocumentReference;

  DocumentReference<Rider> get reference;

  /// A reference to the [RiderCollectionReference] containing this document.
  RiderCollectionReference get parent {
    return _$RiderCollectionReference(reference.firestore);
  }

  @override
  Stream<RiderDocumentSnapshot> snapshots();

  @override
  Future<RiderDocumentSnapshot> get([GetOptions? options]);

  @override
  Future<void> delete();

  Future<void> update({
    String name,
    String phone,
    String city,
    String vehicleType,
    bool active,
    DateTime? createdAt,
    DateTime updatedAt,
  });

  Future<void> set(Rider value);
}

class _$RiderDocumentReference
    extends FirestoreDocumentReference<Rider, RiderDocumentSnapshot>
    implements RiderDocumentReference {
  _$RiderDocumentReference(this.reference);

  @override
  final DocumentReference<Rider> reference;

  /// A reference to the [RiderCollectionReference] containing this document.
  RiderCollectionReference get parent {
    return _$RiderCollectionReference(reference.firestore);
  }

  @override
  Stream<RiderDocumentSnapshot> snapshots() {
    return reference.snapshots().map((snapshot) {
      return RiderDocumentSnapshot._(
        snapshot,
        snapshot.data(),
      );
    });
  }

  @override
  Future<RiderDocumentSnapshot> get([GetOptions? options]) {
    return reference.get(options).then((snapshot) {
      return RiderDocumentSnapshot._(
        snapshot,
        snapshot.data(),
      );
    });
  }

  @override
  Future<void> delete() {
    return reference.delete();
  }

  Future<void> update({
    Object? name = _sentinel,
    Object? phone = _sentinel,
    Object? city = _sentinel,
    Object? vehicleType = _sentinel,
    Object? active = _sentinel,
    Object? createdAt = _sentinel,
    Object? updatedAt = _sentinel,
  }) async {
    final json = {
      if (name != _sentinel) "name": name as String,
      if (phone != _sentinel) "phone": phone as String,
      if (city != _sentinel) "city": city as String,
      if (vehicleType != _sentinel) "vehicleType": vehicleType as String,
      if (active != _sentinel) "active": active as bool,
      if (createdAt != _sentinel) "createdAt": createdAt as DateTime?,
      if (updatedAt != _sentinel) "updatedAt": updatedAt as DateTime,
    };

    return reference.update(json);
  }

  Future<void> set(Rider value) {
    return reference.set(value);
  }

  @override
  bool operator ==(Object other) {
    return other is RiderDocumentReference &&
        other.runtimeType == runtimeType &&
        other.parent == parent &&
        other.id == id;
  }

  @override
  int get hashCode => Object.hash(runtimeType, parent, id);
}

class RiderDocumentSnapshot extends FirestoreDocumentSnapshot<Rider> {
  RiderDocumentSnapshot._(
    this.snapshot,
    this.data,
  );

  @override
  final DocumentSnapshot<Rider> snapshot;

  @override
  RiderDocumentReference get reference {
    return RiderDocumentReference(
      snapshot.reference,
    );
  }

  @override
  final Rider? data;
}

abstract class RiderQuery implements QueryReference<Rider, RiderQuerySnapshot> {
  @override
  RiderQuery limit(int limit);

  @override
  RiderQuery limitToLast(int limit);

  /// Perform an order query based on a [FieldPath].
  ///
  /// This method is considered unsafe as it does check that the field path
  /// maps to a valid property or that parameters such as [isEqualTo] receive
  /// a value of the correct type.
  ///
  /// If possible, instead use the more explicit variant of order queries:
  ///
  /// **AVOID**:
  /// ```dart
  /// collection.orderByFieldPath(
  ///   FieldPath.fromString('title'),
  ///   startAt: 'title',
  /// );
  /// ```
  ///
  /// **PREFER**:
  /// ```dart
  /// collection.orderByTitle(startAt: 'title');
  /// ```
  RiderQuery orderByFieldPath(
    FieldPath fieldPath, {
    bool descending = false,
    Object? startAt,
    Object? startAfter,
    Object? endAt,
    Object? endBefore,
    RiderDocumentSnapshot? startAtDocument,
    RiderDocumentSnapshot? endAtDocument,
    RiderDocumentSnapshot? endBeforeDocument,
    RiderDocumentSnapshot? startAfterDocument,
  });

  /// Perform a where query based on a [FieldPath].
  ///
  /// This method is considered unsafe as it does check that the field path
  /// maps to a valid property or that parameters such as [isEqualTo] receive
  /// a value of the correct type.
  ///
  /// If possible, instead use the more explicit variant of where queries:
  ///
  /// **AVOID**:
  /// ```dart
  /// collection.whereFieldPath(FieldPath.fromString('title'), isEqualTo: 'title');
  /// ```
  ///
  /// **PREFER**:
  /// ```dart
  /// collection.whereTitle(isEqualTo: 'title');
  /// ```
  RiderQuery whereFieldPath(
    FieldPath fieldPath, {
    Object? isEqualTo,
    Object? isNotEqualTo,
    Object? isLessThan,
    Object? isLessThanOrEqualTo,
    Object? isGreaterThan,
    Object? isGreaterThanOrEqualTo,
    Object? arrayContains,
    List<Object?>? arrayContainsAny,
    List<Object?>? whereIn,
    List<Object?>? whereNotIn,
    bool? isNull,
  });

  RiderQuery whereDocumentId({
    String? isEqualTo,
    String? isNotEqualTo,
    String? isLessThan,
    String? isLessThanOrEqualTo,
    String? isGreaterThan,
    String? isGreaterThanOrEqualTo,
    bool? isNull,
    List<String>? whereIn,
    List<String>? whereNotIn,
  });
  RiderQuery whereName({
    String? isEqualTo,
    String? isNotEqualTo,
    String? isLessThan,
    String? isLessThanOrEqualTo,
    String? isGreaterThan,
    String? isGreaterThanOrEqualTo,
    bool? isNull,
    List<String>? whereIn,
    List<String>? whereNotIn,
  });
  RiderQuery wherePhone({
    String? isEqualTo,
    String? isNotEqualTo,
    String? isLessThan,
    String? isLessThanOrEqualTo,
    String? isGreaterThan,
    String? isGreaterThanOrEqualTo,
    bool? isNull,
    List<String>? whereIn,
    List<String>? whereNotIn,
  });
  RiderQuery whereCity({
    String? isEqualTo,
    String? isNotEqualTo,
    String? isLessThan,
    String? isLessThanOrEqualTo,
    String? isGreaterThan,
    String? isGreaterThanOrEqualTo,
    bool? isNull,
    List<String>? whereIn,
    List<String>? whereNotIn,
  });
  RiderQuery whereVehicleType({
    String? isEqualTo,
    String? isNotEqualTo,
    String? isLessThan,
    String? isLessThanOrEqualTo,
    String? isGreaterThan,
    String? isGreaterThanOrEqualTo,
    bool? isNull,
    List<String>? whereIn,
    List<String>? whereNotIn,
  });
  RiderQuery whereActive({
    bool? isEqualTo,
    bool? isNotEqualTo,
    bool? isLessThan,
    bool? isLessThanOrEqualTo,
    bool? isGreaterThan,
    bool? isGreaterThanOrEqualTo,
    bool? isNull,
    List<bool>? whereIn,
    List<bool>? whereNotIn,
  });
  RiderQuery whereCreatedAt({
    DateTime? isEqualTo,
    DateTime? isNotEqualTo,
    DateTime? isLessThan,
    DateTime? isLessThanOrEqualTo,
    DateTime? isGreaterThan,
    DateTime? isGreaterThanOrEqualTo,
    bool? isNull,
    List<DateTime?>? whereIn,
    List<DateTime?>? whereNotIn,
  });
  RiderQuery whereUpdatedAt({
    DateTime? isEqualTo,
    DateTime? isNotEqualTo,
    DateTime? isLessThan,
    DateTime? isLessThanOrEqualTo,
    DateTime? isGreaterThan,
    DateTime? isGreaterThanOrEqualTo,
    bool? isNull,
    List<DateTime>? whereIn,
    List<DateTime>? whereNotIn,
  });

  RiderQuery orderByDocumentId({
    bool descending = false,
    String startAt,
    String startAfter,
    String endAt,
    String endBefore,
    RiderDocumentSnapshot? startAtDocument,
    RiderDocumentSnapshot? endAtDocument,
    RiderDocumentSnapshot? endBeforeDocument,
    RiderDocumentSnapshot? startAfterDocument,
  });

  RiderQuery orderByName({
    bool descending = false,
    String startAt,
    String startAfter,
    String endAt,
    String endBefore,
    RiderDocumentSnapshot? startAtDocument,
    RiderDocumentSnapshot? endAtDocument,
    RiderDocumentSnapshot? endBeforeDocument,
    RiderDocumentSnapshot? startAfterDocument,
  });

  RiderQuery orderByPhone({
    bool descending = false,
    String startAt,
    String startAfter,
    String endAt,
    String endBefore,
    RiderDocumentSnapshot? startAtDocument,
    RiderDocumentSnapshot? endAtDocument,
    RiderDocumentSnapshot? endBeforeDocument,
    RiderDocumentSnapshot? startAfterDocument,
  });

  RiderQuery orderByCity({
    bool descending = false,
    String startAt,
    String startAfter,
    String endAt,
    String endBefore,
    RiderDocumentSnapshot? startAtDocument,
    RiderDocumentSnapshot? endAtDocument,
    RiderDocumentSnapshot? endBeforeDocument,
    RiderDocumentSnapshot? startAfterDocument,
  });

  RiderQuery orderByVehicleType({
    bool descending = false,
    String startAt,
    String startAfter,
    String endAt,
    String endBefore,
    RiderDocumentSnapshot? startAtDocument,
    RiderDocumentSnapshot? endAtDocument,
    RiderDocumentSnapshot? endBeforeDocument,
    RiderDocumentSnapshot? startAfterDocument,
  });

  RiderQuery orderByActive({
    bool descending = false,
    bool startAt,
    bool startAfter,
    bool endAt,
    bool endBefore,
    RiderDocumentSnapshot? startAtDocument,
    RiderDocumentSnapshot? endAtDocument,
    RiderDocumentSnapshot? endBeforeDocument,
    RiderDocumentSnapshot? startAfterDocument,
  });

  RiderQuery orderByCreatedAt({
    bool descending = false,
    DateTime? startAt,
    DateTime? startAfter,
    DateTime? endAt,
    DateTime? endBefore,
    RiderDocumentSnapshot? startAtDocument,
    RiderDocumentSnapshot? endAtDocument,
    RiderDocumentSnapshot? endBeforeDocument,
    RiderDocumentSnapshot? startAfterDocument,
  });

  RiderQuery orderByUpdatedAt({
    bool descending = false,
    DateTime startAt,
    DateTime startAfter,
    DateTime endAt,
    DateTime endBefore,
    RiderDocumentSnapshot? startAtDocument,
    RiderDocumentSnapshot? endAtDocument,
    RiderDocumentSnapshot? endBeforeDocument,
    RiderDocumentSnapshot? startAfterDocument,
  });
}

class _$RiderQuery extends QueryReference<Rider, RiderQuerySnapshot>
    implements RiderQuery {
  _$RiderQuery(
    this.reference,
    this._collection,
  );

  final CollectionReference<Object?> _collection;

  @override
  final Query<Rider> reference;

  RiderQuerySnapshot _decodeSnapshot(
    QuerySnapshot<Rider> snapshot,
  ) {
    final docs = snapshot.docs.map((e) {
      return RiderQueryDocumentSnapshot._(e, e.data());
    }).toList();

    final docChanges = snapshot.docChanges.map((change) {
      return FirestoreDocumentChange<RiderDocumentSnapshot>(
        type: change.type,
        oldIndex: change.oldIndex,
        newIndex: change.newIndex,
        doc: RiderDocumentSnapshot._(change.doc, change.doc.data()),
      );
    }).toList();

    return RiderQuerySnapshot._(
      snapshot,
      docs,
      docChanges,
    );
  }

  @override
  Stream<RiderQuerySnapshot> snapshots([SnapshotOptions? options]) {
    return reference.snapshots().map(_decodeSnapshot);
  }

  @override
  Future<RiderQuerySnapshot> get([GetOptions? options]) {
    return reference.get(options).then(_decodeSnapshot);
  }

  @override
  RiderQuery limit(int limit) {
    return _$RiderQuery(
      reference.limit(limit),
      _collection,
    );
  }

  @override
  RiderQuery limitToLast(int limit) {
    return _$RiderQuery(
      reference.limitToLast(limit),
      _collection,
    );
  }

  RiderQuery orderByFieldPath(
    FieldPath fieldPath, {
    bool descending = false,
    Object? startAt = _sentinel,
    Object? startAfter = _sentinel,
    Object? endAt = _sentinel,
    Object? endBefore = _sentinel,
    RiderDocumentSnapshot? startAtDocument,
    RiderDocumentSnapshot? endAtDocument,
    RiderDocumentSnapshot? endBeforeDocument,
    RiderDocumentSnapshot? startAfterDocument,
  }) {
    var query = reference.orderBy(fieldPath, descending: descending);

    if (startAtDocument != null) {
      query = query.startAtDocument(startAtDocument.snapshot);
    }
    if (startAfterDocument != null) {
      query = query.startAfterDocument(startAfterDocument.snapshot);
    }
    if (endAtDocument != null) {
      query = query.endAtDocument(endAtDocument.snapshot);
    }
    if (endBeforeDocument != null) {
      query = query.endBeforeDocument(endBeforeDocument.snapshot);
    }

    if (startAt != _sentinel) {
      query = query.startAt([startAt]);
    }
    if (startAfter != _sentinel) {
      query = query.startAfter([startAfter]);
    }
    if (endAt != _sentinel) {
      query = query.endAt([endAt]);
    }
    if (endBefore != _sentinel) {
      query = query.endBefore([endBefore]);
    }

    return _$RiderQuery(query, _collection);
  }

  RiderQuery whereFieldPath(
    FieldPath fieldPath, {
    Object? isEqualTo,
    Object? isNotEqualTo,
    Object? isLessThan,
    Object? isLessThanOrEqualTo,
    Object? isGreaterThan,
    Object? isGreaterThanOrEqualTo,
    Object? arrayContains,
    List<Object?>? arrayContainsAny,
    List<Object?>? whereIn,
    List<Object?>? whereNotIn,
    bool? isNull,
  }) {
    return _$RiderQuery(
      reference.where(
        fieldPath,
        isEqualTo: isEqualTo,
        isNotEqualTo: isNotEqualTo,
        isLessThan: isLessThan,
        isLessThanOrEqualTo: isLessThanOrEqualTo,
        isGreaterThan: isGreaterThan,
        isGreaterThanOrEqualTo: isGreaterThanOrEqualTo,
        arrayContains: arrayContains,
        arrayContainsAny: arrayContainsAny,
        whereIn: whereIn,
        whereNotIn: whereNotIn,
        isNull: isNull,
      ),
      _collection,
    );
  }

  RiderQuery whereDocumentId({
    String? isEqualTo,
    String? isNotEqualTo,
    String? isLessThan,
    String? isLessThanOrEqualTo,
    String? isGreaterThan,
    String? isGreaterThanOrEqualTo,
    bool? isNull,
    List<String>? whereIn,
    List<String>? whereNotIn,
  }) {
    return _$RiderQuery(
      reference.where(
        FieldPath.documentId,
        isEqualTo: isEqualTo,
        isNotEqualTo: isNotEqualTo,
        isLessThan: isLessThan,
        isLessThanOrEqualTo: isLessThanOrEqualTo,
        isGreaterThan: isGreaterThan,
        isGreaterThanOrEqualTo: isGreaterThanOrEqualTo,
        isNull: isNull,
        whereIn: whereIn,
        whereNotIn: whereNotIn,
      ),
      _collection,
    );
  }

  RiderQuery whereName({
    String? isEqualTo,
    String? isNotEqualTo,
    String? isLessThan,
    String? isLessThanOrEqualTo,
    String? isGreaterThan,
    String? isGreaterThanOrEqualTo,
    bool? isNull,
    List<String>? whereIn,
    List<String>? whereNotIn,
  }) {
    return _$RiderQuery(
      reference.where(
        _$RiderFieldMap["name"]!,
        isEqualTo: isEqualTo,
        isNotEqualTo: isNotEqualTo,
        isLessThan: isLessThan,
        isLessThanOrEqualTo: isLessThanOrEqualTo,
        isGreaterThan: isGreaterThan,
        isGreaterThanOrEqualTo: isGreaterThanOrEqualTo,
        isNull: isNull,
        whereIn: whereIn,
        whereNotIn: whereNotIn,
      ),
      _collection,
    );
  }

  RiderQuery wherePhone({
    String? isEqualTo,
    String? isNotEqualTo,
    String? isLessThan,
    String? isLessThanOrEqualTo,
    String? isGreaterThan,
    String? isGreaterThanOrEqualTo,
    bool? isNull,
    List<String>? whereIn,
    List<String>? whereNotIn,
  }) {
    return _$RiderQuery(
      reference.where(
        _$RiderFieldMap["phone"]!,
        isEqualTo: isEqualTo,
        isNotEqualTo: isNotEqualTo,
        isLessThan: isLessThan,
        isLessThanOrEqualTo: isLessThanOrEqualTo,
        isGreaterThan: isGreaterThan,
        isGreaterThanOrEqualTo: isGreaterThanOrEqualTo,
        isNull: isNull,
        whereIn: whereIn,
        whereNotIn: whereNotIn,
      ),
      _collection,
    );
  }

  RiderQuery whereCity({
    String? isEqualTo,
    String? isNotEqualTo,
    String? isLessThan,
    String? isLessThanOrEqualTo,
    String? isGreaterThan,
    String? isGreaterThanOrEqualTo,
    bool? isNull,
    List<String>? whereIn,
    List<String>? whereNotIn,
  }) {
    return _$RiderQuery(
      reference.where(
        _$RiderFieldMap["city"]!,
        isEqualTo: isEqualTo,
        isNotEqualTo: isNotEqualTo,
        isLessThan: isLessThan,
        isLessThanOrEqualTo: isLessThanOrEqualTo,
        isGreaterThan: isGreaterThan,
        isGreaterThanOrEqualTo: isGreaterThanOrEqualTo,
        isNull: isNull,
        whereIn: whereIn,
        whereNotIn: whereNotIn,
      ),
      _collection,
    );
  }

  RiderQuery whereVehicleType({
    String? isEqualTo,
    String? isNotEqualTo,
    String? isLessThan,
    String? isLessThanOrEqualTo,
    String? isGreaterThan,
    String? isGreaterThanOrEqualTo,
    bool? isNull,
    List<String>? whereIn,
    List<String>? whereNotIn,
  }) {
    return _$RiderQuery(
      reference.where(
        _$RiderFieldMap["vehicleType"]!,
        isEqualTo: isEqualTo,
        isNotEqualTo: isNotEqualTo,
        isLessThan: isLessThan,
        isLessThanOrEqualTo: isLessThanOrEqualTo,
        isGreaterThan: isGreaterThan,
        isGreaterThanOrEqualTo: isGreaterThanOrEqualTo,
        isNull: isNull,
        whereIn: whereIn,
        whereNotIn: whereNotIn,
      ),
      _collection,
    );
  }

  RiderQuery whereActive({
    bool? isEqualTo,
    bool? isNotEqualTo,
    bool? isLessThan,
    bool? isLessThanOrEqualTo,
    bool? isGreaterThan,
    bool? isGreaterThanOrEqualTo,
    bool? isNull,
    List<bool>? whereIn,
    List<bool>? whereNotIn,
  }) {
    return _$RiderQuery(
      reference.where(
        _$RiderFieldMap["active"]!,
        isEqualTo: isEqualTo,
        isNotEqualTo: isNotEqualTo,
        isLessThan: isLessThan,
        isLessThanOrEqualTo: isLessThanOrEqualTo,
        isGreaterThan: isGreaterThan,
        isGreaterThanOrEqualTo: isGreaterThanOrEqualTo,
        isNull: isNull,
        whereIn: whereIn,
        whereNotIn: whereNotIn,
      ),
      _collection,
    );
  }

  RiderQuery whereCreatedAt({
    DateTime? isEqualTo,
    DateTime? isNotEqualTo,
    DateTime? isLessThan,
    DateTime? isLessThanOrEqualTo,
    DateTime? isGreaterThan,
    DateTime? isGreaterThanOrEqualTo,
    bool? isNull,
    List<DateTime?>? whereIn,
    List<DateTime?>? whereNotIn,
  }) {
    return _$RiderQuery(
      reference.where(
        _$RiderFieldMap["createdAt"]!,
        isEqualTo: isEqualTo,
        isNotEqualTo: isNotEqualTo,
        isLessThan: isLessThan,
        isLessThanOrEqualTo: isLessThanOrEqualTo,
        isGreaterThan: isGreaterThan,
        isGreaterThanOrEqualTo: isGreaterThanOrEqualTo,
        isNull: isNull,
        whereIn: whereIn,
        whereNotIn: whereNotIn,
      ),
      _collection,
    );
  }

  RiderQuery whereUpdatedAt({
    DateTime? isEqualTo,
    DateTime? isNotEqualTo,
    DateTime? isLessThan,
    DateTime? isLessThanOrEqualTo,
    DateTime? isGreaterThan,
    DateTime? isGreaterThanOrEqualTo,
    bool? isNull,
    List<DateTime>? whereIn,
    List<DateTime>? whereNotIn,
  }) {
    return _$RiderQuery(
      reference.where(
        _$RiderFieldMap["updatedAt"]!,
        isEqualTo: isEqualTo,
        isNotEqualTo: isNotEqualTo,
        isLessThan: isLessThan,
        isLessThanOrEqualTo: isLessThanOrEqualTo,
        isGreaterThan: isGreaterThan,
        isGreaterThanOrEqualTo: isGreaterThanOrEqualTo,
        isNull: isNull,
        whereIn: whereIn,
        whereNotIn: whereNotIn,
      ),
      _collection,
    );
  }

  RiderQuery orderByDocumentId({
    bool descending = false,
    Object? startAt = _sentinel,
    Object? startAfter = _sentinel,
    Object? endAt = _sentinel,
    Object? endBefore = _sentinel,
    RiderDocumentSnapshot? startAtDocument,
    RiderDocumentSnapshot? endAtDocument,
    RiderDocumentSnapshot? endBeforeDocument,
    RiderDocumentSnapshot? startAfterDocument,
  }) {
    var query = reference.orderBy(FieldPath.documentId, descending: descending);

    if (startAtDocument != null) {
      query = query.startAtDocument(startAtDocument.snapshot);
    }
    if (startAfterDocument != null) {
      query = query.startAfterDocument(startAfterDocument.snapshot);
    }
    if (endAtDocument != null) {
      query = query.endAtDocument(endAtDocument.snapshot);
    }
    if (endBeforeDocument != null) {
      query = query.endBeforeDocument(endBeforeDocument.snapshot);
    }

    if (startAt != _sentinel) {
      query = query.startAt([startAt]);
    }
    if (startAfter != _sentinel) {
      query = query.startAfter([startAfter]);
    }
    if (endAt != _sentinel) {
      query = query.endAt([endAt]);
    }
    if (endBefore != _sentinel) {
      query = query.endBefore([endBefore]);
    }

    return _$RiderQuery(query, _collection);
  }

  RiderQuery orderByName({
    bool descending = false,
    Object? startAt = _sentinel,
    Object? startAfter = _sentinel,
    Object? endAt = _sentinel,
    Object? endBefore = _sentinel,
    RiderDocumentSnapshot? startAtDocument,
    RiderDocumentSnapshot? endAtDocument,
    RiderDocumentSnapshot? endBeforeDocument,
    RiderDocumentSnapshot? startAfterDocument,
  }) {
    var query =
        reference.orderBy(_$RiderFieldMap["name"]!, descending: descending);

    if (startAtDocument != null) {
      query = query.startAtDocument(startAtDocument.snapshot);
    }
    if (startAfterDocument != null) {
      query = query.startAfterDocument(startAfterDocument.snapshot);
    }
    if (endAtDocument != null) {
      query = query.endAtDocument(endAtDocument.snapshot);
    }
    if (endBeforeDocument != null) {
      query = query.endBeforeDocument(endBeforeDocument.snapshot);
    }

    if (startAt != _sentinel) {
      query = query.startAt([startAt]);
    }
    if (startAfter != _sentinel) {
      query = query.startAfter([startAfter]);
    }
    if (endAt != _sentinel) {
      query = query.endAt([endAt]);
    }
    if (endBefore != _sentinel) {
      query = query.endBefore([endBefore]);
    }

    return _$RiderQuery(query, _collection);
  }

  RiderQuery orderByPhone({
    bool descending = false,
    Object? startAt = _sentinel,
    Object? startAfter = _sentinel,
    Object? endAt = _sentinel,
    Object? endBefore = _sentinel,
    RiderDocumentSnapshot? startAtDocument,
    RiderDocumentSnapshot? endAtDocument,
    RiderDocumentSnapshot? endBeforeDocument,
    RiderDocumentSnapshot? startAfterDocument,
  }) {
    var query =
        reference.orderBy(_$RiderFieldMap["phone"]!, descending: descending);

    if (startAtDocument != null) {
      query = query.startAtDocument(startAtDocument.snapshot);
    }
    if (startAfterDocument != null) {
      query = query.startAfterDocument(startAfterDocument.snapshot);
    }
    if (endAtDocument != null) {
      query = query.endAtDocument(endAtDocument.snapshot);
    }
    if (endBeforeDocument != null) {
      query = query.endBeforeDocument(endBeforeDocument.snapshot);
    }

    if (startAt != _sentinel) {
      query = query.startAt([startAt]);
    }
    if (startAfter != _sentinel) {
      query = query.startAfter([startAfter]);
    }
    if (endAt != _sentinel) {
      query = query.endAt([endAt]);
    }
    if (endBefore != _sentinel) {
      query = query.endBefore([endBefore]);
    }

    return _$RiderQuery(query, _collection);
  }

  RiderQuery orderByCity({
    bool descending = false,
    Object? startAt = _sentinel,
    Object? startAfter = _sentinel,
    Object? endAt = _sentinel,
    Object? endBefore = _sentinel,
    RiderDocumentSnapshot? startAtDocument,
    RiderDocumentSnapshot? endAtDocument,
    RiderDocumentSnapshot? endBeforeDocument,
    RiderDocumentSnapshot? startAfterDocument,
  }) {
    var query =
        reference.orderBy(_$RiderFieldMap["city"]!, descending: descending);

    if (startAtDocument != null) {
      query = query.startAtDocument(startAtDocument.snapshot);
    }
    if (startAfterDocument != null) {
      query = query.startAfterDocument(startAfterDocument.snapshot);
    }
    if (endAtDocument != null) {
      query = query.endAtDocument(endAtDocument.snapshot);
    }
    if (endBeforeDocument != null) {
      query = query.endBeforeDocument(endBeforeDocument.snapshot);
    }

    if (startAt != _sentinel) {
      query = query.startAt([startAt]);
    }
    if (startAfter != _sentinel) {
      query = query.startAfter([startAfter]);
    }
    if (endAt != _sentinel) {
      query = query.endAt([endAt]);
    }
    if (endBefore != _sentinel) {
      query = query.endBefore([endBefore]);
    }

    return _$RiderQuery(query, _collection);
  }

  RiderQuery orderByVehicleType({
    bool descending = false,
    Object? startAt = _sentinel,
    Object? startAfter = _sentinel,
    Object? endAt = _sentinel,
    Object? endBefore = _sentinel,
    RiderDocumentSnapshot? startAtDocument,
    RiderDocumentSnapshot? endAtDocument,
    RiderDocumentSnapshot? endBeforeDocument,
    RiderDocumentSnapshot? startAfterDocument,
  }) {
    var query = reference.orderBy(_$RiderFieldMap["vehicleType"]!,
        descending: descending);

    if (startAtDocument != null) {
      query = query.startAtDocument(startAtDocument.snapshot);
    }
    if (startAfterDocument != null) {
      query = query.startAfterDocument(startAfterDocument.snapshot);
    }
    if (endAtDocument != null) {
      query = query.endAtDocument(endAtDocument.snapshot);
    }
    if (endBeforeDocument != null) {
      query = query.endBeforeDocument(endBeforeDocument.snapshot);
    }

    if (startAt != _sentinel) {
      query = query.startAt([startAt]);
    }
    if (startAfter != _sentinel) {
      query = query.startAfter([startAfter]);
    }
    if (endAt != _sentinel) {
      query = query.endAt([endAt]);
    }
    if (endBefore != _sentinel) {
      query = query.endBefore([endBefore]);
    }

    return _$RiderQuery(query, _collection);
  }

  RiderQuery orderByActive({
    bool descending = false,
    Object? startAt = _sentinel,
    Object? startAfter = _sentinel,
    Object? endAt = _sentinel,
    Object? endBefore = _sentinel,
    RiderDocumentSnapshot? startAtDocument,
    RiderDocumentSnapshot? endAtDocument,
    RiderDocumentSnapshot? endBeforeDocument,
    RiderDocumentSnapshot? startAfterDocument,
  }) {
    var query =
        reference.orderBy(_$RiderFieldMap["active"]!, descending: descending);

    if (startAtDocument != null) {
      query = query.startAtDocument(startAtDocument.snapshot);
    }
    if (startAfterDocument != null) {
      query = query.startAfterDocument(startAfterDocument.snapshot);
    }
    if (endAtDocument != null) {
      query = query.endAtDocument(endAtDocument.snapshot);
    }
    if (endBeforeDocument != null) {
      query = query.endBeforeDocument(endBeforeDocument.snapshot);
    }

    if (startAt != _sentinel) {
      query = query.startAt([startAt]);
    }
    if (startAfter != _sentinel) {
      query = query.startAfter([startAfter]);
    }
    if (endAt != _sentinel) {
      query = query.endAt([endAt]);
    }
    if (endBefore != _sentinel) {
      query = query.endBefore([endBefore]);
    }

    return _$RiderQuery(query, _collection);
  }

  RiderQuery orderByCreatedAt({
    bool descending = false,
    Object? startAt = _sentinel,
    Object? startAfter = _sentinel,
    Object? endAt = _sentinel,
    Object? endBefore = _sentinel,
    RiderDocumentSnapshot? startAtDocument,
    RiderDocumentSnapshot? endAtDocument,
    RiderDocumentSnapshot? endBeforeDocument,
    RiderDocumentSnapshot? startAfterDocument,
  }) {
    var query = reference.orderBy(_$RiderFieldMap["createdAt"]!,
        descending: descending);

    if (startAtDocument != null) {
      query = query.startAtDocument(startAtDocument.snapshot);
    }
    if (startAfterDocument != null) {
      query = query.startAfterDocument(startAfterDocument.snapshot);
    }
    if (endAtDocument != null) {
      query = query.endAtDocument(endAtDocument.snapshot);
    }
    if (endBeforeDocument != null) {
      query = query.endBeforeDocument(endBeforeDocument.snapshot);
    }

    if (startAt != _sentinel) {
      query = query.startAt([startAt]);
    }
    if (startAfter != _sentinel) {
      query = query.startAfter([startAfter]);
    }
    if (endAt != _sentinel) {
      query = query.endAt([endAt]);
    }
    if (endBefore != _sentinel) {
      query = query.endBefore([endBefore]);
    }

    return _$RiderQuery(query, _collection);
  }

  RiderQuery orderByUpdatedAt({
    bool descending = false,
    Object? startAt = _sentinel,
    Object? startAfter = _sentinel,
    Object? endAt = _sentinel,
    Object? endBefore = _sentinel,
    RiderDocumentSnapshot? startAtDocument,
    RiderDocumentSnapshot? endAtDocument,
    RiderDocumentSnapshot? endBeforeDocument,
    RiderDocumentSnapshot? startAfterDocument,
  }) {
    var query = reference.orderBy(_$RiderFieldMap["updatedAt"]!,
        descending: descending);

    if (startAtDocument != null) {
      query = query.startAtDocument(startAtDocument.snapshot);
    }
    if (startAfterDocument != null) {
      query = query.startAfterDocument(startAfterDocument.snapshot);
    }
    if (endAtDocument != null) {
      query = query.endAtDocument(endAtDocument.snapshot);
    }
    if (endBeforeDocument != null) {
      query = query.endBeforeDocument(endBeforeDocument.snapshot);
    }

    if (startAt != _sentinel) {
      query = query.startAt([startAt]);
    }
    if (startAfter != _sentinel) {
      query = query.startAfter([startAfter]);
    }
    if (endAt != _sentinel) {
      query = query.endAt([endAt]);
    }
    if (endBefore != _sentinel) {
      query = query.endBefore([endBefore]);
    }

    return _$RiderQuery(query, _collection);
  }

  @override
  bool operator ==(Object other) {
    return other is _$RiderQuery &&
        other.runtimeType == runtimeType &&
        other.reference == reference;
  }

  @override
  int get hashCode => Object.hash(runtimeType, reference);
}

class RiderQuerySnapshot
    extends FirestoreQuerySnapshot<Rider, RiderQueryDocumentSnapshot> {
  RiderQuerySnapshot._(
    this.snapshot,
    this.docs,
    this.docChanges,
  );

  final QuerySnapshot<Rider> snapshot;

  @override
  final List<RiderQueryDocumentSnapshot> docs;

  @override
  final List<FirestoreDocumentChange<RiderDocumentSnapshot>> docChanges;
}

class RiderQueryDocumentSnapshot extends FirestoreQueryDocumentSnapshot<Rider>
    implements RiderDocumentSnapshot {
  RiderQueryDocumentSnapshot._(this.snapshot, this.data);

  @override
  final QueryDocumentSnapshot<Rider> snapshot;

  @override
  RiderDocumentReference get reference {
    return RiderDocumentReference(snapshot.reference);
  }

  @override
  final Rider data;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Rider _$RiderFromJson(Map<String, dynamic> json) => Rider(
      name: json['name'] as String,
      phone: json['phone'] as String,
      city: json['city'] as String,
      vehicleType: json['vehicleType'] as String,
      age: json['age'] as String,
      active: json['active'] as bool? ?? true,
      createdAt: _$JsonConverterFromJson<Timestamp, DateTime>(
          json['createdAt'], const TimestampConverter().fromJson),
      updatedAt:
          const TimestampConverter().fromJson(json['updatedAt'] as Timestamp),
    );

const _$RiderFieldMap = <String, String>{
  'name': 'name',
  'phone': 'phone',
  'city': 'city',
  'vehicleType': 'vehicleType',
  'age': 'age',
  'active': 'active',
  'createdAt': 'createdAt',
  'updatedAt': 'updatedAt',
};

Map<String, dynamic> _$RiderToJson(Rider instance) => <String, dynamic>{
      'name': instance.name,
      'phone': instance.phone,
      'city': instance.city,
      'vehicleType': instance.vehicleType,
      'age': _$RiderAgeCategoryEnumMap[instance.age]!,
      'active': instance.active,
      'createdAt': _$JsonConverterToJson<Timestamp, DateTime>(
          instance.createdAt, const TimestampConverter().toJson),
      'updatedAt': const TimestampConverter().toJson(instance.updatedAt),
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

const _$RiderAgeCategoryEnumMap = {
  RiderAgeCategory.minor: 'minor',
  RiderAgeCategory.adult: 'adult',
};

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
