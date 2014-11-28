Return-Path: <antonio@meshcoding.com>
Message-ID: <547883C2.4030003@meshcoding.com>
Date: Fri, 28 Nov 2014 15:16:34 +0100
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <CAHmnjeBwBO7WYbor7CUkfHFwAZ+P-tfcSYEPpUbdFwi0r3dcjQ@mail.gmail.com>
In-Reply-To: <CAHmnjeBwBO7WYbor7CUkfHFwAZ+P-tfcSYEPpUbdFwi0r3dcjQ@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="L8fXA1SSTclArVRUC6EecEbHthIi9hmFb"
Subject: Re: [B.A.T.M.A.N.] mib for batman-adv
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
--L8fXA1SSTclArVRUC6EecEbHthIi9hmFb
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 24/11/14 22:53, Lucas Aimaretto wrote:
> Hi All,
>=20
> A simple question: is there any snmp MIB for batman-adv so we can
> gather routing information, that otherwise can only obtained by using
> batctl?

There is no MIB for batman-adv.
You can use batctl or you can also directly read the tables from debugfs
(which is what batctl  does).

Cheers,

--=20
Antonio Quartulli


--L8fXA1SSTclArVRUC6EecEbHthIi9hmFb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJUeIPKAAoJEJgn97Bh2u9eTB0QAL8m8bG08uNFECWEUxHU6hIK
0sG+FLb90De34eYotGHYjmJcgC8fUL3CGDoGcirxQj3pTi9GsSs8hCYMt7YVSAAn
8jvv0zLmpWg+rNi55XSG2NT06/AbiknpzyAUaXaMn3e7QKlFk1OIw3Lx5DW8xqhO
i4nXYGoaVZRbBaMsX2hDQ60i6dPCYp8s6e6SlLMP6LDAgOkyeRc4FgK8PKMKnJ1v
Yul+9XbLWl0g8UFdvx6be4JXyvv07ZQAKF5+g1kBZs48Ql2qunwCeS3sMAfHnB0K
lP3AQuW0n5fGhlbgBDSs28/QgaOAeQvBnJ1BGi+cjUarzAwT6QWCTCjRH8S/szLp
KZ0YxPnODwVF8+bwtbekuFe/OcfXTZBshxmUERKPfewFGfEEUtHtOTyDyn27Wpbo
61WjDp7+8zzV9PFWSnZaS3xRDAX0y6SCswMRdDMpIXyyQGnHIszNoGn3Lu2DDX8L
I3BHI8esZgTQe+1l1EmHlLvYoppOAH1uiNzQlBw7k08ISuxhAgF/dAOOqt++JXGe
Rcb9HNk7m3x97vUlv2qpRuB0iFzyp3nJoGMBtPpHmOuBN3Hg5lnRrOm2k67tKoFv
AeZriC9rl+72ow0DqhvcJA75i7A13n+BftBGNFC5rC6/ns3GwMPubSaPexGgYagy
pLWJvDXJUxv5XFDhFpNZ
=x2mi
-----END PGP SIGNATURE-----

--L8fXA1SSTclArVRUC6EecEbHthIi9hmFb--
