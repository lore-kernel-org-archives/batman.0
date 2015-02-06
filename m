Return-Path: <antonio@meshcoding.com>
Message-ID: <54D46C8C.2040800@meshcoding.com>
Date: Fri, 06 Feb 2015 08:26:04 +0100
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <1423153373-17033-1-git-send-email-sven@narfation.org>
In-Reply-To: <1423153373-17033-1-git-send-email-sven@narfation.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="xXhjXK7559nmjF1lET2BCmTiQRtkvNCDn"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Use safer default config for
 optional features
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
Cc: Sven Eckelmann <sven@narfation.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xXhjXK7559nmjF1lET2BCmTiQRtkvNCDn
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Sven,
thanks for this patch!

On 05/02/15 17:22, Sven Eckelmann wrote:
> The distributed_arp_table is in theory a good solution to reduce connec=
tion
> problems in large networks caused by ARP packet loss. Unfortunatelly, i=
t seems
> to also break ARP resolution in simple mesh setups. The only solution w=
hich
> seems to be used by AP firmwares seems to be the deactivation of this f=
eature.

Could you please be a bit more specific about the issue you are talking
about?

So far the only situation where I personally switched DAT off did not
really get fixed and continued to show the issue. Therefore I am not
really sure that DAT can be blamed for this.

So far I don't know anybody else who complained about DAT.

Cheers,


--=20
Antonio Quartulli


--xXhjXK7559nmjF1lET2BCmTiQRtkvNCDn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJU1GyQAAoJEJgn97Bh2u9eHJ8QALtobbyZf10VLzG+XE7xu4q6
Tk3c7ICTKsylt2TEA5ztA10zSzqbuWhSf9wN4JzEcpc2xOyqPmILVrvEIX/rVH+6
SHR/VwZKG9Q9HiPE8uZIYvnlD35xtkz+EB3vSMHPXW48K/Cf8kusRRkGWPnaxsVa
i4Yf/Tw3GE8cpnizy+1jN0iE6M6Lmi06i+PtxYxq1Yu6fsXFjaJnCDjHz8GI5Qq+
nB/Xe1342StR9NYV78yTv3m3dHZymwpvrCRBGP2XfeqvL3dztbC/V24T4C38rQL7
ZHRnT1rXAmO0ORIPNm51D5lBMGOv35q7ny4jmfxosvrINr87qIOBKUl9XEk2RSk3
WTi6T6HORhW4pWI2wV+LAGmn5csWVVEE0p27yC3naJjhomg4PwtGM/u99ETWZ/f9
yYfucMU6Ab4wUEC5iGrBTtKv2BvHsvnxTC8Mk4n/jLMxd4/MmIEfOMxMc+TN3Bqi
IF5wdQV0tTrBwrp4C5CjBlgfoYcHpdfrwTy0BT4gA6TIP7xKkjW2CCEAPUzmeJxE
c8uQCXvGnpByQctPtA/T9t3LvMgWVzn8KGNJ55WAf4LeakFlkzI5+UoFKu99hVrH
jIIfT/18n5OQYuEPML8oaruCZofJr4fzVxHPmOD1YXNA6zlAUrb586hsXg9aaeyH
XQMYm5DsiXKySwR2jaiZ
=bPLI
-----END PGP SIGNATURE-----

--xXhjXK7559nmjF1lET2BCmTiQRtkvNCDn--
