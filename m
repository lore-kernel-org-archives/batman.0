Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Mon, 5 Apr 2010 16:40:35 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20100405144035.GA13768@pandem0nium>
References: <20100405024603.GA11965@pandem0nium>
	<201004051321.45958.sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5vNYLRcllDrimb99"
Content-Disposition: inline
In-Reply-To: <201004051321.45958.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Limit queue lengths
	for	batman and broadcast packets
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--5vNYLRcllDrimb99
Content-Type: text/plain; charset=utf8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Sven,

you are right, this might be indeed a problem. I'll send an updated patch
which removes the problem by employing atomic_add_unless().

Marek also pointed out that global variables are not very pretty as we are
moving all the global stuff into bat_priv to allow multiple mesh soft=20
interfaces later. However I'd first send the patch with globals as is and
move them later in another patch.

best regards,
	Simon

On Mon, Apr 05, 2010 at 01:21:36PM +0200, Sven Eckelmann wrote:
>=20
> It should be possible to have multiple events accessing these functions a=
t the=20
> same time, or am I wrong?
>=20
> Just say we have following situation (queue is full; full =3D=3D 1):
>=20
>  * bcast comes in and we start add_bcast_packet_to_list  and
>    dec_test(left) =3D=3D 1 -> damn, no room left for us
> -> for easier understanding: someone steals our cpu or the processing is
>     otherwise interleaved with following
>  * another bcast comes in and wants attention (left is now 0):
>    dec_test(left) =3D=3D 0 (because left is now -1... or 0xfff....fff). L=
ets enqueue
>    it and do the rest
>  * first bcast continues and and does atomic_inc(left) -> now it is 0
>  * now a storm of bcasts comes in and all do atomic_dec_and_test... each =
one
>     will be accepted because left is already zero and needs a looooong ti=
me to
>     be 0 again (or enough bcast packets were processed from the queue to =
get
>    positive again)
>=20
> I am not 100% sure if this really can happen, but I thought that it was a=
 hard=20
> requirement for TCP port passed processor selection for parallel processi=
ng of=20
> incoming packets on multicore/multiprocessor architectures.=20
>=20
> Best regards,
> 	Sven



--5vNYLRcllDrimb99
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAku59mMACgkQrzg/fFk7axYNDwCg1131xIJujuIaEoBBbTdSMFJ/
zlYAoPSMuoyjYl+Jnxv91LRPT0HsoYcJ
=Vwt2
-----END PGP SIGNATURE-----

--5vNYLRcllDrimb99--
