Return-Path: <ordex@autistici.org>
Date: Sun, 6 Jan 2013 10:00:17 +0100
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130106090016.GF27589@ritirata.org>
References: <1357215562-6288-1-git-send-email-akinobu.mita@gmail.com>
 <1357215562-6288-20-git-send-email-akinobu.mita@gmail.com>
 <20130104021252.GE27589@ritirata.org>
 <CAC5umyhLB++mh=-pFRzhD-YxZH2RwC5ED4g8mYxS5pYGcbxsvw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="ULyIDA2m8JTe+TiX"
Content-Disposition: inline
In-Reply-To: <CAC5umyhLB++mh=-pFRzhD-YxZH2RwC5ED4g8mYxS5pYGcbxsvw@mail.gmail.com>
Subject: Re: [B.A.T.M.A.N.] [PATCH -v2 19/26] batman-adv: rename random32()
	to prandom_u32()
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
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, linux-kernel@vger.kernel.org, Simon Wunderlich <siwu@hrz.tu-chemnitz.de>, akpm@linux-foundation.org, Marek Lindner <lindner_marek@yahoo.de>, "David S. Miller" <davem@davemloft.net>


--ULyIDA2m8JTe+TiX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 04, 2013 at 10:50:41PM +0900, Akinobu Mita wrote:
> 2013/1/4 Antonio Quartulli <ordex@autistici.org>:
> > On Thu, Jan 03, 2013 at 09:19:15PM +0900, Akinobu Mita wrote:
> >> Use more preferable function name which implies using a pseudo-random
> >> number generator.
> >>
> >> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
> >> Acked-by: Antonio Quartulli <ordex@autistici.org>
> >> Cc: Marek Lindner <lindner_marek@yahoo.de>
> >> Cc: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
> >> Cc: Antonio Quartulli <ordex@autistici.org>
> >> Cc: b.a.t.m.a.n@lists.open-mesh.org
> >> Cc: "David S. Miller" <davem@davemloft.net>
> >> Cc: netdev@vger.kernel.org
> >> ---
> >
> > Hello Akinobu,
> >
> > as you can see in <201301021952.49979.lindner_marek@yahoo.de>, Marek Li=
ndner
> > already applied this change onto our tree. You didn't need to resend th=
is patch
> > to netdev, it will be sent by us through a future pull request.
>=20
> Yes. I read Marek's email. But I included it in v2 again in order not
> to break the build. Because it doesn't show up the latest linux-next yet
> and the last patch 26/26 removes random32() and srandom32().
>=20
> But I should have mentioned it and trimmed the Cc list.
> Sorry for the confusion.

Ok..everything is fine as soon David won't apply this patch.
Cheers,

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--ULyIDA2m8JTe+TiX
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQ6T0gAAoJEADl0hg6qKeORmoP/0ufdpjCTS3JAqZTBxhxztqA
66ijELkVTinlb5XENn72cTm3kSvFzacZN0+nOFyW+MiQ34xCuuvZPeKSHZPa5fdF
YBbWX8+KZPBVKRekMFv12P8wRuh3FBIHF9tnJE//uZ98w5GKyrCjSlC58kLf1Xqy
2jssHcPi/fsqHzjxF7V7NdZV5PtrekUtjyddwmH2pAicpcbwWWpmO4FZH6DkPcho
lR8tbXJh/I3bDo8Qrwk0wW6yAuFduiAwYwXkOOKoTuauq25tP+9VwrU4/yrcl7Fp
JJWHHgUsAAMu/saey22dGR8fckGBYRcxBsuk080vsQ82lsbII5nx9NSDFOsZLyW2
uVbQLZEeERrwPLbovabPwb+rre9QgaW0x57vPpkm5EwJa/0ukO7ojUrymoKhiGcr
kHVNmO633vq+yM2/IYxpAaWGEViuFr0hFkg/9PXqRjUzbnOBLVThUYKqwOO0LIq2
ILA7mEknuQxToFGS3uujxroRRsvTEEh0lOwEJQsOwqzCr61zzPBcAaQbyhONmpnz
bHOAxQcgbuvkCH3x9RknfyPpbJlg/J/ezdG2BV7lsgirBNMLE+7d6xNB0IG6SXyc
CCiVRMFS5Lbp/1RF0KBEAvKiVm+m5X55BcIy1KPr0cFzyAxZy6cRoH3u6TvAp8xn
dAjmVFueY0eZ0lj8yOzQ
=VonP
-----END PGP SIGNATURE-----

--ULyIDA2m8JTe+TiX--
