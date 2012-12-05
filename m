Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 05 Dec 2012 19:04:49 +0100
Message-ID: <50177507.mGlE3T6v1a@bentobox>
In-Reply-To: <201212060140.48732.lindner_marek@yahoo.de>
References: <201212060140.48732.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart8522615.49Ndg0kPyc";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] RFC: Removing one indirection layer for patches
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
Cc: Marek Lindner <lindner_marek@yahoo.de>


--nextPart8522615.49Ndg0kPyc
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Thursday 06 December 2012 01:40:48 Marek Lindner wrote:
[...]
> I am a little confused here. Our "next" branch will be the new "maste=
r" and
> the new "master" will be what "maint" is today ?

Ok, lets rename then:

* new_features (previously called next; in my first explanation called =
next)
* rc_work (previously called maint; in my previous explanation called m=
aster)

> I also don't see the implementation of the new merge policy yet. Davi=
d can
> only receive what we merged before but how do we determine what patch=
 to
> merge when and how ?

Stuff which will be accepted by David B=E1thory in his net repo: put it=
 into=20
rc_work. So small bugfixes

The stuff which will be accepted by David the Impaler in his net-next r=
epo:=20
put it into new_features. This includes non-next related cleanups, feat=
ures,=20
... But no bugs. Bugs will not be accepted by the relentless David.

So it is the same as before but with the master branch removed

> Up to now there was a simple rule (spawned from your
> head iirc): Features into master, cleanups into master, fixes for nex=
t into
> next and very critical stuff into maint. How is that supposed to work=
 in
> the future?

Nope, not entirely. The master requirement was from you.
=20
> One very vocal voice keeps telling me: Just merge everything into the=
 "new
> next" - the rest will fall into place. No need to worry.

Does this "vocal voice" has a name?

Kind regards,
=09Sven
--nextPart8522615.49Ndg0kPyc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAABCgAGBQJQv4zBAAoJEF2HCgfBJntGMdAQAMJCON1bDzq3VSzdxCpyz2+4
OZKWUjhnW46rHFXVXhyUxyT4BxHnm8P473aEJmABnjnVtoUqOnqzCBxrt5Tv8dAy
6JT0Dl0oh825ge8yZWOn+XKa5ybVAVXGVBgsp2hfwrRogaN/w7SduaTu1YSKe4BV
qsmfOAxEjtkJq3E12eGtdXmXuJxLRGQHsDLNofPiOdlPh9/wMMjezOZJsAsJDDFl
vTbGShMpGaaO1ps0AvrHmSEXVO9ZAHaIy5lbrII3j7ZCBejbsWRAEc4lZX8O+a5b
zom/znFr34ExNcn22QerzfwE55+MdRifipQt5mlFFxZ6/V5BESDgNrKJUIC2r1cN
1DWlyww7E7OC9Z2qSqCK8VLBpS4F/PurWR4d6DKhOGxZomRqFMiUdmM1ttUjf2VD
/DSpUuoRHR4aS/ZVAKJr18PDwnWjrzgBqxJyD6HpNHLTpWAO6X6dZSMOY/hSaIHr
DWfd0IO2goqhhCQ10llRwzzrVXd0K2VYmFGf6QgjgQHldpkFeTb877anK/+n5gfb
0rdCbNACSmE4c06k8E7HTxY3rfMo39sJ4h647pDJ8lvR62Q6Fh9scoA5B/bbuoyA
5l47z62WNo75bHmZ2Z0SNcf23qu1/OBF3xgKKwni2fs9IhJaF85zRhyMHYQSy8vD
W7Q8HN6SCwdmuvYcI0aI
=ktA2
-----END PGP SIGNATURE-----

--nextPart8522615.49Ndg0kPyc--

