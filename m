Return-Path: <mschiffer@universe-factory.net>
References: <1459340372-6971-1-git-send-email-sven@narfation.org>
 <1459340372-6971-2-git-send-email-sven@narfation.org>
From: Matthias Schiffer <mschiffer@universe-factory.net>
Message-ID: <56FCE2A0.7000200@universe-factory.net>
Date: Thu, 31 Mar 2016 10:41:04 +0200
MIME-Version: 1.0
In-Reply-To: <1459340372-6971-2-git-send-email-sven@narfation.org>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="Vmg8dviEvfLHLlVAK7dkuBS8fQhwBiCVT"
Subject: Re: [B.A.T.M.A.N.] [RFC 2/2] batman-adv: Don't re-broadcast packets
 on non-wifi devices
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
--Vmg8dviEvfLHLlVAK7dkuBS8fQhwBiCVT
Content-Type: multipart/mixed; boundary="lnclvwAW4FqoOLn82var7oLGHpJC8jtib"
From: Matthias Schiffer <mschiffer@universe-factory.net>
To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
Message-ID: <56FCE2A0.7000200@universe-factory.net>
Subject: Re: [B.A.T.M.A.N.] [RFC 2/2] batman-adv: Don't re-broadcast packets
 on non-wifi devices
References: <1459340372-6971-1-git-send-email-sven@narfation.org>
 <1459340372-6971-2-git-send-email-sven@narfation.org>
In-Reply-To: <1459340372-6971-2-git-send-email-sven@narfation.org>

--lnclvwAW4FqoOLn82var7oLGHpJC8jtib
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 03/30/2016 02:19 PM, Sven Eckelmann wrote:
> It is not necessary to re-broadcast a received broadcast packet on the
> rx-device when it is a standard ethernet device. The link medium alread=
y
> takes care of transporting it to all participants in the broadcast doma=
in.
>=20
> The re-broadcast on other devices is still necessary to allow the broad=
cast
> packet to be received by devices which are using a different link mediu=
m.
>=20
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---

I don't think completely disabling the rebroadcast here without a way to
enable it again is a viable option.

At least when using batman-adv over VPN tunnels, making batman-adv take
care of establishing transitive connectivity may make sense, as batman-ad=
v
does this very well and without much configuration. This is actually the
recommended setup for non-full-mesh setups using the VPN tool fastd (whic=
h
is developed by me.)

Regards,
Matthias


--lnclvwAW4FqoOLn82var7oLGHpJC8jtib--

--Vmg8dviEvfLHLlVAK7dkuBS8fQhwBiCVT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCgAGBQJW/OKgAAoJEBbvP2TLIB2cxpoQAOraWLzeFfjBm+QcVdYwMkhA
jwrLjFqgpIcGCfefpgpBnixG/rGKf8SMZq1VYJVTFNgIP0Q7WODevZiVFun8iQfn
EztHUVi6JT/gHhstivy2kdsqoc3SUbXfxxOGG/mfxQ5S3RGJGBBytNNTtoyekONU
6q7oEdcQ4/TmoospwjfLOJuVatcSyyom/EVieXacRBqrCmrohtDQs5xHbjO4X5YA
jyNU6MM6w6HRvLJpxDgatud7lrpNLtgSHRtjvtvNUMtejr3RzpHLdn3+1wR4hA2S
L0tE6i6P9XScdpu4s9NOELBHXuahlyA+2G0Af8LY1Xa1Wg4G5ZlU4hGkpKmIFsdA
RvxsdtnKu5DkFiKH/IVm6Ci7jRS3vOTXBpWHmvz+41eUtnsOtA8mTy1Q2Ik1cm0Y
6vAS1R7SttOxaTtSJMlJ66GoA8Y2OPMlD45NuP7VLVve+T3ZbC2SyNhOYuNqXYeq
aJ4J3YXvhn8U84NlCEBMhVexMg+vvY1aQikPDxAmAr8jqTNZhME8NIsQ00VRq5AX
935akqunKk1R1aE2epnAwmckW4lSL4ubeDUZG2Hej33iABDOfrp24GKGRbArMvE9
VuBZzaxLE8Co+UE92YU1Nv16+2QSJkKBuTZqt48pPxbz74mWX/xNmo77IeUOjOTI
Fr6Bys0eahMiwcQT8n4N
=OKTe
-----END PGP SIGNATURE-----

--Vmg8dviEvfLHLlVAK7dkuBS8fQhwBiCVT--
