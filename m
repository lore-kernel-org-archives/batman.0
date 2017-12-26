Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 26 Dec 2017 15:19:41 +0100
Message-ID: <4799954.f95c8XAbim@sven-edge>
In-Reply-To: <2528254.P9avF0yZu7@bentobox>
References: <98a77a75-ac8e-455a-6060-343b9020cd27@viisauksena.de>
 <ba5c036e-e34b-2b43-4df2-bc1c8883eedd@viisauksena.de>
 <2528254.P9avF0yZu7@bentobox>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart10309218.CiRRENcdid";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] limit of if per batman
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

--nextPart10309218.CiRRENcdid
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"

On Mittwoch, 25. Januar 2017 08:15:52 CET Sven Eckelmann wrote:
[...]
> > this made me curious , and i modified your script a bit - turns out
> > after the 127. IF you add to batman-adv you get an Error -
> > all 510 gretap links was succesfully build ...
> > # ifconfig |grep gre| wc -l
> > 515
> > # batctl if|sort|wc -l
> > 127
> > the error is mainly
> > *Error - can't write to file
> > '/sys/class/net/gre128/batman_adv/mesh_iface': Cannot allocate memory
> [...]
[...]
> I would guess that your system mostly fails becauseit  cannot handle the
> allocation of the "large" arrays which store:
[...]

Looks like their could also be a different problem when your test system us=
es=20
signed characters by default. Please try the patch [1] which changes the ty=
pe=20
from=20char/s16 to unsigned int.

Kind regards,
	Sven

[1] https://patchwork.open-mesh.org/patch/17247/
--nextPart10309218.CiRRENcdid
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlpCWn0ACgkQXYcKB8Em
e0Y5nxAAxn4SyGIJ/XcWm1DguUXaxINAvkUdEeoeyLra9UVYBWJH8TKRrBmVuEN1
BiTLGzkxxFhjg+/Xh10kfdyAnqBgeWt9ykJ9QLXwRnhk13yQpg2wc9LuGff7SRiB
+FC1nDJHW79fRLozjBrCTZ2GlK3j1l4bGCzGb/QK9u3wvDwBAeTteO0kpOByjVed
FL5im3znpRgdbGcKT5VQ9VPszFSFyAqbZr8PsgGZUFVOYVju7cFJ0vZlt6cWtxrJ
AFWd2lDnQQ9zaAZdsAcLByKNaBvShP2V1lwnNIeYED0o33bbiwOE38ebi8ZYP/L6
oZedU7Z6pPPwESJi7wHU0cLNUKvA+8I+INPWsg3LZ939FTza0NSCHzYOOaifouB0
A1LSftS0vqW64IWq0ZI5/F68+1CBp/WVtOcHeqHONNbBQBSldCyZq90/vCwRDkmF
sQjG9Lq2MaagxGjaY+5sZIdH5c0Yaaj/tjdgGSIH5PUI2rmXWXqSgf7G4qluNWdr
6ZXsMPTdRlXXyHU69FlTNTliq7flpBxaqRyE2L2U7uDDZhQVX9134/XqQswOTfzW
lqK8jLBNJIOHZMGY7+DhiZaqqpH+Pl/DbKdzftCVaFxtha47CEWuZWDEdq9ao7tE
9h9YBe6f4OX7vc+m3R/7TpHd66KZ6R53kwUdgrOGP7xEShdQX7s=
=GJQC
-----END PGP SIGNATURE-----

--nextPart10309218.CiRRENcdid--

