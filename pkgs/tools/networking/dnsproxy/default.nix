{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "dnsproxy";
  version = "0.72.0";

  src = fetchFromGitHub {
    owner = "AdguardTeam";
    repo = "dnsproxy";
    rev = "v${version}";
    hash = "sha256-lhMHGB+/p4+pXZrLwf+NwyNF5TbMhNrJW0tCjRV+U9Q=";
  };

  vendorHash = "sha256-vGIw0Hj0l8SI6zYnTknzc7Lb5volW37yE/KnWZHydQE=";

  ldflags = [ "-s" "-w" "-X" "github.com/AdguardTeam/dnsproxy/internal/version.version=${version}" ];

  # Development tool dependencies; not part of the main project
  excludedPackages = [ "internal/tools" ];

  doCheck = false;

  meta = with lib; {
    description = "Simple DNS proxy with DoH, DoT, and DNSCrypt support";
    homepage = "https://github.com/AdguardTeam/dnsproxy";
    license = licenses.asl20;
    maintainers = with maintainers; [ contrun diogotcorreia ];
    mainProgram = "dnsproxy";
  };
}
