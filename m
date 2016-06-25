Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 25 Jun 2016 17:05:58 +0200
Message-ID: <2076451.7rm3JqQEl7@sven-edge>
In-Reply-To: <20160620015901.GE3029@otheros>
References: <1463310915-7111-1-git-send-email-sven@narfation.org>
 <20160620015901.GE3029@otheros>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart11551810.KTsvSMzkQR";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [RFC] batman-adv: use kmem_cache for translation
	table
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

--nextPart11551810.KTsvSMzkQR
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Monday 20 June 2016 03:59:01 Linus L=FCssing wrote:
[...]
> https://www.open-mesh.org/projects/batman-adv/wiki/Kmalloc-kmem-cache=
=2Dtests
>=20
>=20
> In a nutshell, on a small TP-Link TL-841NDv8 wireless router
> (MIPS/AR9341), I was able to achieve 34% more global TT entries
> (or 25% less RAM usage).
[...]

Really interesting. I wouldn't have expected that kind of difference. S=
o your=20
ideas really seemed to have worked :)

I have submitted an actual patch [1]. Do you know when it is planned to=
 have=20
your nofdb changes [2] merged in gluon?

Kind regards,
=09Sven

[1] https://patchwork.open-mesh.org/patch/16392/
[2] https://github.com/freifunk-gluon/gluon/pull/780

--nextPart11551810.KTsvSMzkQR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXbp3WAAoJEF2HCgfBJntG2OEP/jddn58/aR64Dkdrdp5VmkxP
rDE1SxAipWYJ/ImPJjxVlCprytnXP/fkp3aaweZqV8BiX0+VgRbQpe1QvtoNk5rX
C0ZudY65gVYC4rJADjfUL0+JNIixngFYh1W2ySLbb5DGz8REQqzc3zLNipOE86b7
GD3cKcWQ8HRXjwujNNLQuT8iNuRLZb/jFyKKHT2JK6LEtGr35xJDffGhcHjuHEEb
dHpvmSiWuYmLlEbGVDSETrenp5WV+IrfGj/aSjz/szpg7zXeVkoCYMgxpn7vbQWi
z4OaBOGvN6USzA2V6HEt4yeqzBB4GaGKvccprd7P51Dqf/AafdauxZE2Ic/4oh1j
2SvtmBCZ/qO7dL4MpRCaBDOb2euvpqmSlMkTpls+58xCKWFW50rhcHb1aBpShtvE
yN8TMNH/gcQStnos/4u2PJldJrElZXPcig7daQMVm2n6MRFNwlkOYKFu2/lK5Q49
OSM4TlYaxWAHfPdy7rwQzIV3CLTnlXWLiGs4yOiKZsUnzk4R56UqJBKeerfukklZ
pr0VCvsaCyBKE120nshyXznWtnPgGUEc7au81qreTRUX9IMc2Z7HQztEdImffDSG
q19OORI4LGq/ArcYkuDathNMomRmsStrLVMiztA+duzU0kvhEjgUfZtkoSH+bbb3
tOH/ayZRRNc3UMsSFo8m
=U2qG
-----END PGP SIGNATURE-----

--nextPart11551810.KTsvSMzkQR--

