// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$postsNotifierHash() => r'1cd411cacbe89b3d9d564bfd789ab16b8830ed04';

/// See also [PostsNotifier].
@ProviderFor(PostsNotifier)
final postsNotifierProvider =
    AutoDisposeNotifierProvider<PostsNotifier, List<PostModel>>.internal(
      PostsNotifier.new,
      name: r'postsNotifierProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$postsNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$PostsNotifier = AutoDisposeNotifier<List<PostModel>>;
String _$activePostHash() => r'f6686ab0b46afdc1c28fbe561bf821bac5c940a0';

/// See also [ActivePost].
@ProviderFor(ActivePost)
final activePostProvider =
    AutoDisposeNotifierProvider<ActivePost, int>.internal(
      ActivePost.new,
      name: r'activePostProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$activePostHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$ActivePost = AutoDisposeNotifier<int>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
