Return-Path: <antonio@meshcoding.com>
References: <1440600113-21305-1-git-send-email-sw@simonwunderlich.de>
 <1440600113-21305-4-git-send-email-sw@simonwunderlich.de>
From: Antonio Quartulli <antonio@meshcoding.com>
Message-ID: <55E578E8.5010107@meshcoding.com>
Date: Tue, 1 Sep 2015 12:07:36 +0200
MIME-Version: 1.0
In-Reply-To: <1440600113-21305-4-git-send-email-sw@simonwunderlich.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="s9DsvHqWtBVTxDcWlkomKROmq8eU7k4kN"
Subject: Re: [B.A.T.M.A.N.] [PATCH-maintv2 3/3] batman-adv: detect local
 excess vlans in TT request
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Simon Wunderlich <sw@simonwunderlich.de>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>, alessandro@mediaspot.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--s9DsvHqWtBVTxDcWlkomKROmq8eU7k4kN
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 26/08/15 16:41, Simon Wunderlich wrote:
> If the local representation of the global TT table of one originator ha=
s
> more VLAN entries than the respective TT update, there is some
> inconsistency present. By detecting and reporting this inconsistency,
> the global table gets updated and the excess VLAN will get removed in
> the process.

This a nice catch, but I am not sure this is the right way of
implementing the fix.

Imagine this sequence of events:
1) originator O1 sends an OGM
2) client C1 connects to O1 on a newly created VLAN and starts sending
traffic
3) originator O2 detects (speedy join) C1 before receiving the O1's OGM
4) O2 receives O1's OGM and the check will kill C1 because its VLAN is
not advertised in the OGM. O2 needs to wait for O1's next OGM before
getting to know C1 again

Maybe this scenario is rather unlikely? What do you think?



--=20
Antonio Quartulli


--s9DsvHqWtBVTxDcWlkomKROmq8eU7k4kN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJV5XjsAAoJEOb/4TMchkvf9asQALq9ClIEhmOZaEfGVfISIKLs
ZE+CUXFQOTlM6JE3YbU5MjXUTyzuNquA7bSCZMH5Gh5rgcLI3O0kkVYnZ1fLaXMq
ovzRWzPf/P/WQQURETFDJ2/DNjswZH1C0b9OLSGb5J6e3hMW5Qv9M/rYFggcoNMy
oN4AD84ObjOUq8WjQjU2Vi4tW3fXtRrLTdCMV8U8gyHHVnDtPEY6hprREbg79R9E
qBTPreuEOTSFm0GgNSfQs/n8NS1CgTYU9pvaH+w2kxYnHo5vJVF9rOVda/aEcS/r
Xs/FxCo0iVkopLc+q8BEqL0OJ+t3vMd3I5+PaGhvk5wWC3nBe5pMpovKjKQUCcOn
5k9ZBiRx7ZRZrFUc7/1o/ASgSkAummm8BlhEpe2rVjPp5oVjG/IJEybd2AxxIzMN
CKlyPntHSjE40VoBRygGssB5ONxMIXmrS1b2Xtt2NWCnvqZkSBa1HsOw2mz6ipYM
LvJqTBqMG42AuHeAZTLGRUERXU5Eq0mtHvHI/Q10jLEgqZOxzGSDiYhM3PcCJnLT
6jqpEcDSeDaChtJpNJttDVFX2byv3MQ2R9jdC8XrUCsSmeEfNKD/9L0wQo+AeKfw
zrGxY3UwKKzJc8anDPgKDnl5bDplQWMmT2u0NNpOsNlRqXpaDTzrNrtwUODPZKAU
H7zTBXcY/kqpppDsFoG7
=5ofJ
-----END PGP SIGNATURE-----

--s9DsvHqWtBVTxDcWlkomKROmq8eU7k4kN--
