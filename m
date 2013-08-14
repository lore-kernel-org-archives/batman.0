Return-Path: <ordex@autistici.org>
Date: Wed, 14 Aug 2013 19:42:50 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130814174250.GP849@ritirata.org>
References: <1373242365-763-1-git-send-email-mihail.costea2005@gmail.com>
 <1373242365-763-6-git-send-email-mihail.costea2005@gmail.com>
 <20130810132043.GD849@ritirata.org>
 <CAP5XTDNHTHiU8Pak2qzj19azwCUT=qO9CHj3uv5TZXWi9-+1QQ@mail.gmail.com>
 <20130814154131.GB1162@Linus-Debian>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="FxlYARId5dseejUu"
Content-Disposition: inline
In-Reply-To: <20130814154131.GB1162@Linus-Debian>
Subject: Re: [B.A.T.M.A.N.] [RFC 6/6] batman-adv: Adds snooping of router
 and override flags for NA creation
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


--FxlYARId5dseejUu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2013 at 05:42:19PM +0200, Linus L=C3=BCssing wrote:
> On Wed, Aug 14, 2013 at 06:51:32AM -0700, Mihail Costea wrote:
> > On 10 August 2013 06:20, Antonio Quartulli <ordex@autistici.org> wrote:
> > >>       dat_entry =3D kmalloc(sizeof(*dat_entry), GFP_ATOMIC);
> > >>       if (!dat_entry)
> > >>               goto out;
> > >> +     /* some entries don't have an extra data and useful if allocat=
ion for
> > >> +      * data fails */
> > >
> > > this comment has to be indented
> > >
> > > /* like
> > >  * this
> > >  */
> > >
> > >
> > >
> > > There are other style issues in this patch, but they mostly concern w=
hat I
> > > already pointed out in the other comments.
> > >
> > > Remember to always check your patch with checkpatch.pl --strict in or=
der to find
> > > problems before sending the patches.
> > >
> >=20
> > I still don't know what generated some style problems. Alignments
> > problems shouldn't be here because I already
> > used --strict (but that didn't say anything about comments) and sent
> > the patches with git mail. That is weird.
> >=20
>=20
> These are net/ specific style requirements. Try this before
> running checkpatch.pl:
>=20
> sed -i "s#^--- a/#--- a/net/batman-adv/#;s#^+++ b/#+++ b/net/batman-adv/#=
" *.patch

Right, checkpatch will trigger the warning only if the patches are coming f=
rom
the net/ folder inside the kernel root. Linus's suggestion will help you to=
 make
checkpatch thinks that the patches are coming from net/.

Cheers,


--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--FxlYARId5dseejUu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBCAAGBQJSC8GaAAoJEADl0hg6qKeOg+QQAJmD2eTziYmT0hcEL27loEJK
h0JJP9bqafHeI9cBH+AlRio6oirh2sj/l1kqeV29TVRDUFjSM0zGsNqA2WvJ/wH0
5XZQV1Fay8joiyq3cRbIDiTOwph96hM8SHXC8Bg2ulWXE94i4UEq3STlDjEwzmpn
LkTFJei5Xr4nUtnq6vR2mTKT6CTzulLbFhkvd97ytqIqGKyHqWNXEFpmdfpTjUqn
DXZp3LQ0fmGjhdtYjfVhEojjLc2JKAJLESl4MI2qMBpxh4owSKBip1ubSYLN8CoW
KaQsCwu840IKGJXujssVQp6lDNuaznn2Vn+N9K7PbqtIZdiHLg1UjMW+GGoGRN27
yJlSFcM/aepmeUvYINB/Cd3SqL4xV9Y6epbLRxD2SXSffwMEbrtqyOCopCb63cra
4MyFuE704e8xoxdTEpi1FKvPO8TQEPv9wzsojz0INb8fxj8PK60LMXTdH3298JZN
sARM8o5ApJrPCcerWbaMq9DUy1S7vy2OuOCKNphs8GBpExYa8UzUfbHjFGK1WxX5
rZ+/Pr4SZx0CQLIlQ/XqStyMAMz2zV56Bk4n21SYOuLRrkKR3H5oVSIDB+jxx1rw
V6VLdfjo4YuSgK8kpWN0pWFX0TDqQNZdXpxU7O8i/qy3RHAZV41u+HGUQfEcHnEg
SZ+cJeUWD0BcQinO4BRe
=ysma
-----END PGP SIGNATURE-----

--FxlYARId5dseejUu--
