Return-Path: <mschiffer@universe-factory.net>
References: <6d1b250c047fb4cd3aac72d9e921ed33428fdaf5.1516648598.git.mschiffer@universe-factory.net>
 <2357913.Ue9Sgfg8BR@sven-edge>
From: Matthias Schiffer <mschiffer@universe-factory.net>
Message-ID: <9411aa2d-e39f-718e-9c99-40be6a0143f8@universe-factory.net>
Date: Mon, 22 Jan 2018 22:18:34 +0100
MIME-Version: 1.0
In-Reply-To: <2357913.Ue9Sgfg8BR@sven-edge>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="HkxpBOWsoZWlIj51AOXgSovKk4ngi1OSX"
Subject: Re: [B.A.T.M.A.N.] [PATCH maint] batman-adv: fix packet checksum in
 receive path
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sven Eckelmann <sven@narfation.org>, b.a.t.m.a.n@lists.open-mesh.org
Cc: Maximilian Wilhelm <max@sdn.clinic>, Felix Kaechele <felix@kaechele.ca>, Mephisto <mephisto@mephis.to>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HkxpBOWsoZWlIj51AOXgSovKk4ngi1OSX
Content-Type: multipart/mixed; boundary="Sh0jGXJBghQ4fyuvO8d5iWSdueAQgNJcO";
 protected-headers="v1"
From: Matthias Schiffer <mschiffer@universe-factory.net>
To: Sven Eckelmann <sven@narfation.org>, b.a.t.m.a.n@lists.open-mesh.org
Cc: Maximilian Wilhelm <max@sdn.clinic>, Felix Kaechele <felix@kaechele.ca>,
 Mephisto <mephisto@mephis.to>
Message-ID: <9411aa2d-e39f-718e-9c99-40be6a0143f8@universe-factory.net>
Subject: Re: [B.A.T.M.A.N.] [PATCH maint] batman-adv: fix packet checksum in
 receive path
References: <6d1b250c047fb4cd3aac72d9e921ed33428fdaf5.1516648598.git.mschiffer@universe-factory.net>
 <2357913.Ue9Sgfg8BR@sven-edge>
In-Reply-To: <2357913.Ue9Sgfg8BR@sven-edge>

--Sh0jGXJBghQ4fyuvO8d5iWSdueAQgNJcO
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 01/22/2018 09:52 PM, Sven Eckelmann wrote:
> On Montag, 22. Januar 2018 20:24:50 CET Matthias Schiffer wrote:
>> skb_postpull_rcsum() is necessary after eth_type_trans() to adjust the=

>> skb checksum, otherwise log spam of the form "bat0: hw csum failure" w=
ill
>> result when packets with CHECKSUM_COMPLETE are received (at least in s=
ome
>> setups, e.g. when stacking batman-adv on top of VXLAN).
>=20
> Would be nice to have a better explanation here.
>=20
> The comment previously assumed that skb_pull_rcsum would be enough. But=
 the=20
> problem here is that the skb_pull_rcsum only pulls the batman-adv heade=
rs. The=20
> actual pull of the ethernet header (with skb_pull_inline) happens insid=
e=20
> eth_type_trans. Or did I miss anything?

This is correct, eth_type_trans() contains a simple skb_pull(), so the cs=
um
must be adjusted afterwards (grepping the kernel for eth_type_trans will
find a lot of this). I can send a v2 with a better commit message later.

>=20
> [...]
>> I don't know what the exact circumstances are that trigger the log spa=
m,
>> but it seems this was broken forever (I could also reproduce the issue=
 with
>> our compat-14 legacy branch)... so please ask David to queue this up f=
or
>> stable :)
>=20
> Yes, this is broken since earliest commits. The most relevant commit in=
=20
> batman-adv is:
>=20
> Fixes: fe28a94c01e1 ("batman-adv: receive packets directly using skbs")=

>=20
> But I would propose to use following in the kernel tree:
>=20
> Fixes: c6c8fea29769 ("net: Add batman-adv meshing protocol")
>=20
> The 4.15 release will be soon(tm) and Simon is currently on vacation. S=
o we=20
> will most likely postpone the submission to David until Simon found a w=
ay out=20
> of the snow and after 4.15 is released...
>=20
> But it would be nice when some people could test the patch [1] (togethe=
r with=20
> vxlan?) on batman-adv or batman-adv-legacy. And please provide a=20
> "Tested-by: Full Name <email@example.org>" [2] reply when it works.
>=20
> Thanks,> 	Sven

I've tested this on Kernel 4.14.14 (everything working correctly now) and=

4.4.110 (here, there are still checksum errors; it seems on older kernels=
,
the checksum handling in VXLAN is broken too? Still debugging this...)

Matthias



>=20
> [1] https://patchwork.open-mesh.org/patch/17250/
> [2] https://www.kernel.org/doc/html/v4.12/process/submitting-patches.ht=
ml#using-reported-by-tested-by-reviewed-by-suggested-by-and-fixes
>=20



--Sh0jGXJBghQ4fyuvO8d5iWSdueAQgNJcO--

--HkxpBOWsoZWlIj51AOXgSovKk4ngi1OSX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEZmTnvaa2aYgexS51Fu8/ZMsgHZwFAlpmVSoACgkQFu8/ZMsg
HZwhMhAA0kNSG8Kw/1jOgWywHnCo3xxopDnm9W4HgYeEwa320DY6YEdpnzRipYiE
Sq3YUIbjKwJuootXuTjL9P6othvnmsaGQHxdLGTE8QMiZEO/SrncFh4Z0faOIWdL
/KyOMSMGmp8vvvB+gQS31IxXUvP+TrRIPpE5bnuolfAJWuKT5inSXJ6miO8+6Gd4
OFrQZop60R5GbY2H2TNaO8GCnou72g60YTa5apMpyr5PVjfEnoZkBaUPNqmPAR15
SSKI/IEVJQqe9IL7ieQKHTub+9r/u4Jr+dgmCeK7kbC/I0/Hllvz+h9zr8tSMK0X
I0j2U9voA57McQkf8KfCNXbzabvGLmEy2iUo95VHJXu9HgCM6FCo0Fb/pBB5WNHI
Q/33TYe8iM+K1YfIdHil8UIAa2v3CQC00F1F04MTt2x6FzUotTrKr14ENfQTW9yU
RUPW2gpWW6h051kOIAOeTPhHBj0+l8BNLJlliQECT2c5JuXGxeYltvbYpCYnCvgx
3QRL7FfMYiR8MCqQqdbM2Lca04KK21z+TFAFBBNnk/JKBrY/tQcUtRBQodX1RD52
+NmYi4KsbQ0/GMYSY7mOUvBt8a4N3Akv24bj3g2ns4ZOgD1P/dtErlSD+aGYXmfp
iCfQ1E4uc761lhohHTLv8Ab3neaBqcQ/U4WPZVxLaB+VBftKG9w=
=6nub
-----END PGP SIGNATURE-----

--HkxpBOWsoZWlIj51AOXgSovKk4ngi1OSX--
