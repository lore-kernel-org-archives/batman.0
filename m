Return-Path: <antonio@meshcoding.com>
Message-ID: <52DBA6D4.5000500@meshcoding.com>
Date: Sun, 19 Jan 2014 11:20:04 +0100
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <6312194.LhI8hzXjyH@bentobox> <52D84B0A.10208@meshcoding.com>
 <32326825.BW0GZpyDjI@bentobox>
In-Reply-To: <32326825.BW0GZpyDjI@bentobox>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="AB2XaUNWLluFLLCFbgEGWe13AJuS2dLRw"
Subject: Re: [B.A.T.M.A.N.] [PATCH 0/3] batctl: Use libnl(-tiny) for netlink
 communication
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--AB2XaUNWLluFLLCFbgEGWe13AJuS2dLRw
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 17/01/14 10:37, Sven Eckelmann wrote:
> On Thursday 16 January 2014 22:11:38 Antonio Quartulli wrote:
>> I think that it may still be the case that we want to compile batctl o=
n
>> an host without libnl.
>=20
> We =3D=3D "I have this use case"?
>=20
>> In the end batman-adv can run on Ethernet and we may have an embedded
>> system with no wifi which has no libnl at all.
>=20
> (Now a little bit sarcasm): batctl can also run without batman-adv, ple=
ase=20
> allow to drop the useless sysfs/debugfs stuff ;)
>=20
>> I was wondering....what if we check if libnl is installed or not and i=
n
>> case it is missing we disable the address translation and vlan operati=
ons?
>> In this way we can add the dependency to libnl and avoid code
>> duplication but at the same time we keep libnl-free users happy.
>=20
> I agree that it is possible but would like to avoid to provide a "fallb=
ack"=20
> because it justs adds more complexity without an actual use case (pleas=
e=20
> correct me but I don't see it right now).
>=20

My use case was only about an embedded device (e.g. raspberry pi) having
an Eth connection but no wireless at all, thus it may not have libnl.

> If you still think it is necessary then please feel free to add it late=
r.
>=20

Anyway I agree with you: that requires too much complexity for a very
little gain.

I like this patchset as it is.

Thanks.

Cheers,


--=20
Antonio Quartulli


--AB2XaUNWLluFLLCFbgEGWe13AJuS2dLRw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJS26bYAAoJEEKTMo6mOh1VPAAP/0pNl8CLJpX7gBA3+XB8SuGH
gJ/2ZC4QzgyBaOV9fx6L16EwnSiYu8/J1hwlishuypP6Xw5vhlOVPJ6m9//kTZma
MA8xdNI/rLZOoVna3edchRqSTmxJN5Zprqrkj3+G/bh7jgCZHTCfbMn9AvDgnkV4
4q4pPRFebHNhcqsNadJraMysKIxeLiOdX2Pc1xNCVfV20nzZMQxfvKIsAsVDXFct
2lsmSaWbpbI7aM+mIV3dHy1iCBZB4DW1tJ5FcWIh5D7Uz+otWrJdLCwzqk+eWpG0
+QXpuPd0yn2PjwrtiYpJKHdKrpTXD60QMaKMZ9kRvoIqi8Fj3EJVuajQYAT3Qbrn
rrhpMKjlR8vhUjrg4pooQB6AwnCLRpyuS8eB3o1Iq2K7eBIUnWYHK/yPW6FaKvzq
jSRLqFsqy+2VfBsa3aRW/N+BwGc2xKD1Hls7BePjAdshaOV6wOt7BYFResrk4X/0
LC2FQwerwzSzGvzp4lkacRSARrMcHrgp1Ady30XdwJAkZhZxwWpk5gYdhZSnOoHZ
jfnD5aEmsV7JT0xVNCLtc8+ivRq5yx5Hq3bHqB/YOvZGgXoDPr1+wcmvAC8wICoy
K5rdq/+56kQu8qttgigrApn/9EAP1nj7yNh5bulbUOCTkQQ+LYlQJAP7qIV6SgYm
qAMdI6RWAW3Vu0Kl0R33
=6fLi
-----END PGP SIGNATURE-----

--AB2XaUNWLluFLLCFbgEGWe13AJuS2dLRw--
