enum AuthenticationStatus {
  unknown,
  authenticated,
  unauthenticated,
}

enum SortCardItemType {
  date('Date'),
  like('Like'),
  share('Share'),
  comment('Comment');

  const SortCardItemType(this.label);
  final String label;
}