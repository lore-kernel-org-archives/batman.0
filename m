Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Tue, 24 May 2016 14:59:20 +0200
Message-ID: <1549543.i0QYfO90aX@prime>
In-Reply-To: <1876515.iCZETFfYbK@prime>
References: <1464042677-7787-1-git-send-email-linus.luessing@c0d3.blue>
 <20160524100018.GB21783@prodigo.lan> <1876515.iCZETFfYbK@prime>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart20917514.deX9FsXl4E";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] RFC: batman-adv: Remove unused
	primary_if variable
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
Cc: Antonio Quartulli <a@unstable.cc>

--nextPart20917514.deX9FsXl4E
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="ISO-8859-1"

On Tuesday 24 May 2016 14:49:31 Simon Wunderlich wrote:
> Hi,
>=20
> On Tuesday 24 May 2016 18:00:18 Antonio Quartulli wrote:
> > On Tue, May 24, 2016 at 12:31:17AM +0200, Linus L=FCssing wrote:
> > > Fixes: 29b9256e6631 ("batman-adv: consider outgoing interface in =
OGM
> > > sending") Signed-off-by: Linus L=FCssing <linus.luessing@c0d3.blu=
e>
> > > ---
> > >=20
> > > Note sure whether the "forw_packet->if_incoming !=3D primary_if" =
check
> > > vanished on purpose or by accident in the mentioned commit. Or wh=
ether
> > > it
> > > got substituted by some other check. Therefore sending the patch =
as RFC.
> >=20
> > I think Simon can better comment on this, but my understanding is t=
hat
> > such
> > check has been moved to batadv_iv_ogm_schedule(), thus primary_if i=
s
> > useless in this function.
> >=20
> > Simon, comments ?
>=20
> Yes, the check has been moved. I would agree that the check is redund=
ant
> now. Please resend without RFC and add my Acked-by :)

What I meant: the local variable is redundant now. I should start readi=
ng what=20
I type up ... ;) Sorry!

    Simon
--nextPart20917514.deX9FsXl4E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXRFAoAAoJEKEr45hCkp6hwBUQAKg9NHF9FmnUaYojYZBKEu+R
BXJ2JemSAjFtTNp4XdxCQc3QbdMMJGtSjJH1D1eD8qstFNZCGqie3NKI0CIRRq5H
XOyowJRHJx3OiW24Y4M3/pLYqtgLVx0MBgO3Y60XxiTIEDC0rWj6//8z5zCNFdE9
4ux7+C88EPxIEtDJgCZLnDG9pT5CNNWh0wyotdCgC3RmwZaEUZDTtYOsPFDLBF9/
HUW+Nl0AIKN6sVYScw7aZ8dLOnjYuh6FvFTVV/I+3WvnoANW3DSCBAdqafOtTqXX
XNMFxE6koQRwh9M5iB5ICu81acjN4NigvvQxLGdaKGoJwJPr3q1xqtWR0/5zv86+
GZiy8Y+SZtXosjynxjLObl9ccPEa3p3tFoJtGSvOpna/no+7+pUNSeWkcF9VxhpY
hisg2KeMlNc9RhrgDo4SOsXlMjJjkeFYc3q+oj4FtRGKpzgFwJWUsowUJlqQnKpu
Ln4i9vk6jC2/UNR/BRrQHOstImi0+3y7Ut0Q/TdMYdwcnVVaZou+llFPDC4YnT/h
7y1nwocQgclNJ4WsjsPq/l99zqjWLaTvrM6m5x9oCsVzZiCTEHgMyYUKOBJ8b72K
VeewwORwNrWri7zBJlWXN7YCn/uJufUi0lv/cHcJcnzOrDPjzrZENs80gcJE6TUA
yTz2V6NEtEo64GQUwF9x
=RQoB
-----END PGP SIGNATURE-----

--nextPart20917514.deX9FsXl4E--

