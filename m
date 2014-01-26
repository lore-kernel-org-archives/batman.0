Return-Path: <antonio@meshcoding.com>
Message-ID: <52E5341F.30800@meshcoding.com>
Date: Sun, 26 Jan 2014 17:13:19 +0100
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <1390299725-1873-1-git-send-email-antonio@meshcoding.com>	<86mwipch0u.fsf@coulee.tdb.com>
 <86lhy8pn5v.fsf@coulee.tdb.com>	<52DF7556.9090200@makrotopia.org>
 <86y527oqpl.fsf_-_@coulee.tdb.com>	<52E003DD.6040302@meshcoding.com>
 <52E02EDC.3080805@wirelesspt.net> <86iotbo9hw.fsf@coulee.tdb.com>
 <52E05E0F.7010203@wirelesspt.net> <52E08DFE.9030604@makrotopia.org>
 <52E5063E.3080408@makrotopia.org> <52E51A04.8020800@meshcoding.com>
 <52E5322D.60202@wirelesspt.net> <52E532D0.2000907@meshcoding.com>
In-Reply-To: <52E532D0.2000907@meshcoding.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="R02uXk8TBoLQxGDtECRMjFEwEKJuUUVPA"
Subject: Re: [B.A.T.M.A.N.] batman-adv: memory leak?
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
To: b.a.t.m.a.n@lists.open-mesh.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--R02uXk8TBoLQxGDtECRMjFEwEKJuUUVPA
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 26/01/14 17:07, Antonio Quartulli wrote:Can you explain in what
>=20
> This is a patch to fix the memleak we were discussing about.
> This bug appeared with and it is meant to be applied on
> batman-adv-2014.0.0 (regardless of the openwrt revision).

sorry, bad copy/paste.

The patch is for batman-adv-2014.0.0 (I don't know what version you have
in AA).
It fixes the memleak bug that we were discussing about.


--=20
Antonio Quartulli


--R02uXk8TBoLQxGDtECRMjFEwEKJuUUVPA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJS5TQkAAoJEEKTMo6mOh1V/FsP/2E5qp8jwk1t6ZIoyx5x11Az
M2cv5Dad9NtJmEBUPEvnoT+1oGaXEIoCOmnkFa+ymSkBWKlOuwomK1rvtpMM/eN1
9Pxwn+soNNrUjt+rW1h6jkEvLmj7eOPdEXrDgRCaLR+llrPrh9/MMNKe9V+FEEgv
XaewUzoW1z7nzmWffmnKswfvYbeaZjnTI1smMsFBUWGYKIXIQmafwDhylTykvpI+
z+Q9RUibm4VWmMQAyqRBbrGGwskYhyQlJ0FcoVFtH0s10kiBtC1CbSZPe8jRjjCZ
IcoyY4/doRvszdVSa6c9n10i2NhJJUq/lk3ACj9LdUxGv5KvZEgCknVLCue0bfxs
5jtQ1x5arrIF+2v02GVrqbgbKPIxF9yAnaHjFc2cAqHr4bmpA3TqG7OszazuHs98
q2jaTwDkrJEOS8Fr6RofvJaSixO7Q56peg2gv1SVekilCXhIb/Dd/hTk+FZD6HYN
dHBqGKU7c6uvcZp7mkCqNvto9kLEqoUPrTXhajaSe+WArUMkSToDhHCV1t2L0AzZ
AL3c7iX9tSOCTH4x5x2h00qcPCw4AUPnV4hDz3VBYEU4VdpXIzREzJqvDlb8f1L3
9zUYInWZfLZpVGAqP60I056MQjmqf5W1d3GUtEH70Kh0oDiLkugHoWhysc+oa4Pu
eTN6odDnFxjFsA4O0IbQ
=fitQ
-----END PGP SIGNATURE-----

--R02uXk8TBoLQxGDtECRMjFEwEKJuUUVPA--
