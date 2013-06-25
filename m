Return-Path: <ordex@autistici.org>
Date: Tue, 25 Jun 2013 08:38:09 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130625063809.GA3136@ritirata.org>
References: <51C76DDE.20903@altermundi.net> <51C77678.1040904@altermundi.net>
 <20130624070245.GI1124@ritirata.org>
 <51C91911.9000506@altermundi.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="UlVJffcvxoiEqYs2"
Content-Disposition: inline
In-Reply-To: <51C91911.9000506@altermundi.net>
Subject: Re: [B.A.T.M.A.N.] Possible bad interaction between BLA2 and TT?
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


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 25, 2013 at 01:14:09AM -0300, Gui Iribarren wrote:
> On 06/24/2013 04:02 AM, Antonio Quartulli wrote:
> > On Sun, Jun 23, 2013 at 07:28:08PM -0300, Gui Iribarren wrote:
> >> On 06/23/2013 06:51 PM, Gui Iribarren wrote:
> >>>
> >>> the "gap" in labanda-oeste is between seq=3D73 and seq=3D89
> >>> in labanda-oeste there were no messages or traffic for 25secs, and th=
en
> >>> the "TT inconsistency" came up, resolved, and seq=3D89 succeded, traf=
fic
> >>> restored.
> >>> at that time, seq=3D74, labanda-este got a TT update:
> >>> [  23161800] Deleting tdorado from global tt entry 44:d8:84:b0:d2:f5:=
 tt
> >>> removed by changes
> >>> and (AFAIU) dropped traffic coming from labanda-oeste until
> >>> labanda-oeste finally got the TT update and increased the ttvn to 129
> >
> > As we clarified on IRC, BLA2 is not involved at all.
> >  From what I can see I'd say that a node in the middle is dropping the =
traffic
> > due to a wrong re-routing operation. if you could reproduce the issue, =
it would
> > be nice if you could get the tt log on all the nodes along the path.
> > In this way we can clearly see who is doing what.
>=20
> (11:58:09 AM) gui_: ah, ordex, btw, there's no "in the middle" :(
> (11:58:29 AM) ordex: what do you mean?
> (11:58:41 AM) ordex: does it happen with two nodes only?
> (11:58:44 AM) gui_: labanda-este is a direct neighbor of tdorado
> (11:58:49 AM) gui_: i mean the path is
> (11:58:53 AM) gui_: oeste -> este -> tdorado
>=20
> And, finally, to throw some spice into the mix, i downgraded=20
> kmod-batman-adv just in labanda-este (my key suspect) twice, and...
> i can reproduce this issue with 3.8.3+2013.2.0-2 and 3.8.3+2013.1.0-3
> but not with 3.8.3+2012.4.0-1
>=20
> both labanda-oeste and tdorado are still running 2013.2.0. Downgrading=20
> labanda-este to 2012.4.0 was enough to solve the issue.
>=20
> so it looks like a regression introduced between 2012.4.0 and 2013.1.0

why didn't you 2013.0.0 since you were jumping from version to version? :)

Thanks a lot for doing these tests!

Cheers,

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--UlVJffcvxoiEqYs2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBCAAGBQJRyTrRAAoJEADl0hg6qKeOLuoP/3e3JW/qri0zg0JU8RrbNaqk
hoCW5w73KEziaE9x/GYYuv3Wngd5j4sCY9w2AYepweLTuKz+GHejgp/ZjOjXuwae
IjWgpamPH+e/dfst0+wRN3RInYSzk2D4dELnobcHWww06+FaRyjlCRQtWLLXXxGp
ZGB6XccCynv7+IV2DuMUL5FZAdgT+7OMaMgqEn4XEtrCr5BJZLss7Mt5cOuiZolG
U7WuPRe91bxvHNoYZgtpGaLlcRVYohGZXq19s8hkGXcznjEVrAREOCWeeoaiuPGD
YlYclmUOlRxDJ3exF2qauyKZlBJQYWhEHBEMi6cLuZPVp1XNNWPJRCe9mxAKDaur
xEr2IF7R66zz/yrxYpis7hj7b8Vxo7bLdHWf8VnbNaNsPUyvQwTh+BjRr3foM1i1
DJg8wRNzWrjrWeGYlxAUWPQqH4DY5fBnrZ2phRjncRFp7AcYRCtb5ac6S9YCtHp6
uWxehtLD5zIkbeD18L8ptsB9D9jw/7rm++9g0L96/lFU+olWZWx2KNOHwd7zihPv
smgABALNI9m6Sk45fjC+v7SZ0IwnB45VFJltOWS96AudiLxM4twLCRtky768PSwt
AFRTb+zDOxqRcHLEY5PMz+2Ta4m0rq05Yd6AEs6IjRqaur+csiuRpJ8N4lXipT2Q
DwwQE8ZljsM/6/+tyIig
=v4xJ
-----END PGP SIGNATURE-----

--UlVJffcvxoiEqYs2--
