Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 22 May 2011 13:01:00 +0200
References: <1303940106-1457-1-git-send-email-ordex@autistici.org>
	<1306013107-18515-3-git-send-email-ordex@autistici.org>
In-Reply-To: <1306013107-18515-3-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2490827.C9kcW77BMT";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201105221301.02304.sven@narfation.org>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 2/3] batman-adv: improved roaming
	mechanism
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

--nextPart2490827.C9kcW77BMT
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Antonio Quartulli wrote:
>         int16_t diff;
[...]
> =20
>         diff =3D unicast_packet->ttvn - curr_ttvn;


diff is set but never used in recv_unicast_packet

Kind regards,
	Sven

--nextPart2490827.C9kcW77BMT
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABCgAGBQJN2OztAAoJEF2HCgfBJntGrJ0QAMmMLGnSJFx42gvXvbtJ0f6k
Q4DAVZgXaCvNH/eNWj9rA91BSIpA2HI1Lk9MxAcizQlHDtegJhwlsCLDerZKmTkr
HemRJ8oIuqxZjw5ghB76mRtzHNDKR0diHwIFZZeF8Lyw47t4wcWNgwoPda+9dpT6
pQS5uWtlPj5CrTdLFj68+gG3RiGKRzqnZxtB/NMS+WpKb7H3PBhCgYpZ4amKdLV1
ESswCIt2bpu8L7VCp/WM7PCXKUOiJ6ibyPOVwrbkDneW/LFyK6eSu73eeS3CaDjj
WFExGtcmDfAEo+ZKOmcN9hfWLB+phaB4YdXIiEdTruB5vLsuvAv4WLI3go+dHIJl
MEm7LoATJWqcqq136fq6ksQ8jPaZqCTQmDnIBhqHYIzcIjeeYQHdO0kejJLqdddk
P6HQjMVcu251LxutkhZwBIURBRE0FToUArhy1Vtp4Z3+Dnm3w09pQ+fJ5P0IKx3j
5BX2OZRRMDrSBK8+RRi3GkZawC3bRGiNb1QrZ4XgF+4VyMkLpBJR2Wa4xAcZUtn6
nABMEuuW12xo5Y+dQ5GUseio/vGrZ4+xVzmAtCUD3SfkNzeB69wC7h7iyAAFaWpm
rmZuFgoqC6E0aUVzkhzW4ve8R4ErF02e/oQytF35qDqV9sXlFr10JAPUWKP0RYWI
8xwSC2g2IzkBZ5E3YqhH
=Ksey
-----END PGP SIGNATURE-----

--nextPart2490827.C9kcW77BMT--
