Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Wed, 25 Jul 2012 22:22:57 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20120725202257.GA11999@pandem0nium>
References: <1368807.4KENUl02G1@sven-laptop.home.narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="lrZ03NoBR/3+SXJZ"
Content-Disposition: inline
In-Reply-To: <1368807.4KENUl02G1@sven-laptop.home.narfation.org>
Subject: Re: [B.A.T.M.A.N.] RFC: Migration to a new git server backend
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


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,

On Sun, Jul 22, 2012 at 01:43:25AM +0200, Sven Eckelmann wrote:
> Hi,
>=20
> maybe some of you have seen that I talked in the channel to Antonio wheth=
er we=20
> should migrate to a different solution to serve our git repositories. Thi=
s is=20
> (in my opinion) a good idea because gitosis [1] (the software that we are=
=20
> currently using) isn't maintained anymore and will be dropped [2] in the =
next=20
> version of Debian. My preferred replacement is gitolite [3].
>=20
> I already talked with Simon and discussed what side effect this could hav=
e.=20
> Maybe side effects is not the correct word to describe it... lets call it=
=20
> options. Gitolite allows to define access rights for refs. For people tha=
t are=20
> not familiar with the storage in git: You can for example say that people=
 can=20
> only commit to branches with a specific prefix.
>=20
> Just to give an example. We want that only the release team can create ta=
gs ->=20
> refs/tags/ is only marked for the release team as read-write. Now we have=
 more=20
> interesting features like ordex is only allowed to write in branches star=
ting=20
> with ordex/ -> refs/heads/ordex/ is marked as rw for ordex.
>=20
> Now the question is: Do we want to use this feature or not. We had follow=
ing=20
> ideas:
>=20
> 1. 1 repository per project
>=20
>    use only one repo for each project (batman-adv, batctl, batmand, ...) =
and
>    use branch namespaces for individual users:
>    * master, next, maint for the main stuff
>    * ordex/ (for example ordex/dat), hundeboll/, ... for users
>    * tags only for release team
>=20
> 2. 2 repositories per project
>=20
>    use one official repo for each project (batman-adv, batctl, batmand, .=
=2E.)
>    and one for other people
>    * master, next, maint in both repos (synced from the main one)
>    * ordex/ (for example ordex/dat), hundeboll/, ... for users in the sec=
ond
>      repo
>    * tags in both repositories allowed (but in the second repo only with
>      user prefix)
>
> 3. 1+x repositories per project
>=20
>    Keep everything like now
>    * master, next, maint for the main stuff
>    * each user has his own copy of the main repo in his user folder
>    * tags can freely commit in his own repo
>=20
> Special repositories with big differences like linux-merge are kept in a=
=20
> special repository.


I'd prefer to go with option one, or maybe two. To me, it looks like having=
 tags=20
is the main practical difference? (I don't use any, but maybe others do ...=
).

Changing the repos is more a cosmetic change IMHO and may decrease administ=
ration
work. I have no practical concerns whatsoever, but git.open-mesh.org will l=
ook
more beautiful :)

Cheers,
	Simon

--lrZ03NoBR/3+SXJZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAlAQVaEACgkQrzg/fFk7axaC8wCaAleXRu63Z+CMMawU0KppQzPU
nfMAoKEjgpKnle3VMlwUnS8TPWoUxMPG
=OA0I
-----END PGP SIGNATURE-----

--lrZ03NoBR/3+SXJZ--
