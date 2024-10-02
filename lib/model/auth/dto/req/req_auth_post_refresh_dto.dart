class ReqAuthPostRefreshDTO {
  final String refreshJwt;

  ReqAuthPostRefreshDTO._({required this.refreshJwt});

  factory ReqAuthPostRefreshDTO.of({required String refreshJwt}) {
    return ReqAuthPostRefreshDTO._(
      refreshJwt: refreshJwt,
    );
  }
}
