Return-Path: <a@unstable.cc>
Date: Sat, 25 Feb 2017 08:55:25 +0800
From: Antonio Quartulli <a@unstable.cc>
Message-ID: <20170225005524.GY12961@prodigo.lan>
References: <CAM0tZWaO3F5D1KzPX85V4ydGSj_a0cXc29xhchUwTxVcnexVdA@mail.gmail.com>
 <20170224175658.GF4202@otheros>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Sr/1Pkwuhjf1+ztR"
Content-Disposition: inline
In-Reply-To: <20170224175658.GF4202@otheros>
Subject: Re: [B.A.T.M.A.N.] Node freezes but still alive
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


--Sr/1Pkwuhjf1+ztR
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 24, 2017 at 06:56:58PM +0100, Linus L=FCssing wrote:
> On Fri, Feb 24, 2017 at 10:48:35AM -0600, Derick Roman De Leon Leal wrote:
> > Thanks for the quick reply Linus,
> >=20
> > No transmission on IPv4
>=20
> If that's for the adhoc0 interface directly then this seems to be
> a wireless driver issue and not a batman-adv one :(.
>=20
> Hm, if I'm not mistaken then the OM2P-HS should have an Atheros AR9285
> chipset. So an ath9k driver which many people use in adhoc mode
> for meshing.=20
>=20
> > Someone suggested that I should use a bssid that
> > starts with 02 (eg. 02:12:34:56:78:9A). Is this a requirement for the
> > mesh to work?
>=20
> Not a "requirement for the mesh to work", afaik. But when a MAC
> address is self-generated, then it should have the second lowest bit set:
>=20
> https://en.wikipedia.org/wiki/MAC_address#Address_details

This is true for the interface MAC address, but this should not apply for
the Cell-ID/BSSID. It can be a random ID.

Cheers,


--=20
Antonio Quartulli

--Sr/1Pkwuhjf1+ztR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYsNX5AAoJEJ6F1zG2JyOs1CQP/0uXbcu9VLVmBOSoLjbd2Zh1
QoaTtaSACT4TjsxlXHms5PmtzBzI9sydwyoMDdl2vV+rlUeUF4Ul1NlW8anEQW3H
bu/iCGAt4UbmVzNqTD8J4FGpO2zT3Ln051e29AcThIuKP6NtlzAaaTVxk9NjolYJ
F2RwaC8JD9Sj1zBaNoznyuxUkuYIEylpVpRNLXOxWBejaaiMLLMsAmmSLVN9mcMM
kpfOFMidVAvBIDVTdPy90vnV6Ft85sh1ehlEKEkJpngyTr82FoDg+pVAjQePDD1J
ZN78AVOWsED2fcP5y7qFjYBA/wUTBaDH7l+jNd+mVtlaYBJyDbFqWIpR31jLCcyv
Imw9YGbUD/nLCyXN6e6Cf/mOqK94Z9EFwBQhXy33NicC8LgFiEzuLgVNSqfJALqZ
R70PxRBMJCEXb/3e/ooqIKt1q3A9WkRoXU6VMlaIvUfl2w40vWOOavmmKjrO7/YE
AUUzdcMWWUVQwoeFmRzix0m+jDhmDTPbwAYF6eky/xMkg3a1TZwbehHCiLuQFSpM
swXsJqQN18qB7ZIVfixGx5yYlaK/8EZzaV9diF2EjgydFWNvxoVjLUjInLQwQKY5
KRV2LI3c9g1o5crqnBQlkpQGT6rsWOY5PalupP2CRiBLQgvXchRomg5ZzsElIfnT
Xfwp7CqaTocFke93k/p8
=kurt
-----END PGP SIGNATURE-----

--Sr/1Pkwuhjf1+ztR--
