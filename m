Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 13 May 2018 09:49:13 +0200
Message-ID: <2732493.XFP0Y4VOh4@sven-edge>
In-Reply-To: <20180512220223.3039-1-mareklindner@neomailbox.ch>
References: <20180512220223.3039-1-mareklindner@neomailbox.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2021045.fKA8ImvVj2";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: disable ethtool link speed
 detection when auto negotiation off
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Marek Lindner <mareklindner@neomailbox.ch>

--nextPart2021045.fKA8ImvVj2
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

Name of failed tests
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

ecsv/pu
=2D------

 * sparse linux-3.18 cfg: BLA=3Dn DAT=3Dn DEBUGFS=3Dy DEBUG=3Dy NC=3Dy MCAS=
T=3Dy BATMAN_V=3Dy
 * sparse linux-3.18 cfg: BLA=3Dy DAT=3Dn DEBUGFS=3Dy DEBUG=3Dn NC=3Dn MCAS=
T=3Dn BATMAN_V=3Dy
 * sparse linux-4.2 cfg: BLA=3Dy DAT=3Dn DEBUGFS=3Dn DEBUG=3Dn NC=3Dn MCAST=
=3Dn BATMAN_V=3Dy
 * sparse linux-4.4 cfg: BLA=3Dn DAT=3Dn DEBUGFS=3Dn DEBUG=3Dn NC=3Dn MCAST=
=3Dy BATMAN_V=3Dy
 * sparse linux-4.4 cfg: BLA=3Dy DAT=3Dn DEBUGFS=3Dn DEBUG=3Dn NC=3Dn MCAST=
=3Dn BATMAN_V=3Dy
 * sparse linux-4.4 cfg: BLA=3Dy DAT=3Dn DEBUGFS=3Dy DEBUG=3Dy NC=3Dn MCAST=
=3Dy BATMAN_V=3Dy


Output of different failed tests
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D

ecsv/pu: sparse linux-4.2 cfg: BLA=3Dy DAT=3Dn DEBUGFS=3Dn DEBUG=3Dn NC=3Dn=
 MCAST=3Dn BATMAN_V=3Dy
=2D------------------------------------------------------------------------=
=2D-

    /home/build_test/build_env/tmp.Z3XNaFEJS1/build/net/batman-adv/bat_v_el=
p.c:134:43: error: no member 'autoneg' in struct <unnamed>
    /home/build_test/build_env/tmp.Z3XNaFEJS1/build/net/batman-adv/bat_v_el=
p.c:134:43: warning: unknown expression (8 46)
    /home/build_test/build_env/tmp.Z3XNaFEJS1/build/net/batman-adv/bat_v_el=
p.c: In function =E2=80=98batadv_v_elp_get_throughput=E2=80=99:
    /home/build_test/build_env/tmp.Z3XNaFEJS1/build/net/batman-adv/bat_v_el=
p.c:134:36: error: =E2=80=98struct <anonymous>=E2=80=99 has no member named=
 =E2=80=98autoneg=E2=80=99
      if (ret =3D=3D 0 && link_settings.base.autoneg =3D=3D AUTONEG_ENABLE)=
 {
                                        ^
    make[3]: *** [/home/build_test/build_env/tmp.Z3XNaFEJS1/build/net/batma=
n-adv/bat_v_elp.o] Error 1
    make[2]: *** [/home/build_test/build_env/tmp.Z3XNaFEJS1/build/net/batma=
n-adv] Error 2
    make[1]: *** [_module_/home/build_test/build_env/tmp.Z3XNaFEJS1/build] =
Error 2
    make: *** [all] Error 2

--nextPart2021045.fKA8ImvVj2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlr37fkACgkQXYcKB8Em
e0YQJhAAzvp3mMM+R2QKb2oNIjMsFxloQ8IUAxI/TOKuT/JQUaKfeKH0VL6fsQZ2
fZOfTz26lrlFTWMDrWWP32J5tRuDUllWVX6RhsXhHV+OMuJUhuJoVSxfN6TuEVsL
LC6PeJnTzx70wswDgxc3JhPTIDdpqcCL8MqxCYga0h4/EAVx3aVVbocgQO0QVUeX
wlZhTdK04n+QkI72ie2w9KCzKfeB/OBgLtCt03Hr5cwDky0Yk3nqFqG0PtfEV2NR
7J45h1bFSIkvqP9yBxuGgNVQ5rLK2W+p0M1CZd4vfK3h8LjxBrp6XVzXuS+EIwiI
ZTFZnASkTSVdd98+y7aKs8FpWiO1g/rl3BdRMW4N3R33yx3sd4IUfpuH+jJmq/Tc
ioTk8iJAsHnwHzc+iwujFf9zno2KhpdbBDuzbI2zmBJiPf9AiGgyUR0Yk7dPdxqA
cD8//TOigccWIcjqq65ONw3jIFHTq7E118+WT0E8sG8SmxUhUeu6nNU3yMndEc+g
yyAfXFfcD+YazDXrbtmokVhUdBd4zv65/63Pjevods5mzR3rOe66cZIkFlHz+wL3
m4GIfdE1A0lCJz933jC8xsk6Q+lSrccTHuKyebkHsSSZNSH+U+GEdWCQOPn2FnCh
m+Ar3Hyc8N3Mcyca4zQPUW5SXQqzFmcB6HvicvG4MdccY0fYwpM=
=2QIH
-----END PGP SIGNATURE-----

--nextPart2021045.fKA8ImvVj2--



