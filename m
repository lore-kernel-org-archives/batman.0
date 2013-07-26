Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Fri, 26 Jul 2013 14:16:08 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20130726121608.GA16248@pandem0nium>
References: <51F194D6.3000701@sotun.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="5mCyUwZo2JvN/JJP"
Content-Disposition: inline
In-Reply-To: <51F194D6.3000701@sotun.de>
Subject: Re: [B.A.T.M.A.N.] Mangling broadcast packets
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


--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Jan,

On Thu, Jul 25, 2013 at 11:12:54PM +0200, Jan Huwald wrote:
> Hi,
>=20
> I am currently redesigning hbbp and p2ptbl[1,2]. p2ptbl is a distributed
> key-value database build on top of HBBP link-local UDP broadcasts. Both
> are used in some Freifunk communities and elsewhere.
>=20
> To reduce the bandwidth demand of the employed gossip protocol I would
> like to use something that behaves like a link-local broadcast packet in
> a batman-adv mesh every respect - except that any mesh node on it's
> route may decide to drop it or change it's UDP data.
>=20
> Right now only approaches that are ugly or don't work come to my mind.
>=20
> Ugly:
> * using NFQUEUE on all enslaved interfaces to mangle packets before
>   they are seen by batman; requires out-of-kernel parsing of batman-adv
>   packets and watching enslaved interfaces

out-of-kernel parsing of batman-adv packets will kill you performance compl=
etely.

> * add a custom broadcast TVLV; requires kernel code and either bloats
>   OGMs are requires non-OGM broadcast TVLV packets

We will most probably not accept this upstream. User payload data should be
sent within custom batman packets. You can have your private batman-patch
though, but this leaves the maintainance burden to you.

>=20
> Don't work:
> * using NFQUEUE on bcast payload (without batman header); does not work
>   because they are not exposed to the iptables

Plus batman-adv decides on it's own whether to forward broadcasts. Also mod=
ifying
the content may break a few things (e.g. bridge loop avoidance), which do C=
RC on
the broadcasts content.
> * send link-local UDP on all enslaved interfaces; requires to
>   reimplement all the loop-avoidance / routing / resending logic that
>   already exists in batman-adv

At least this gives you the "only next hop" feature you wanted.
>=20
> If you see a smarter way or a reason why manipulating broadcast packets
> is utter nonsene: please let me know.

Personally I think tinkering with batman-adv packets for this is not a good=
 thing - and
we will not support transporting this kind random user payload inside of
batman-adv packets (unless it's our 'normal' Ethernet traffic). What you co=
uld do:

 * send unicast to each neighbor instead of sending broadcast
   (find out who is a neighbor by reading originator tables)
 --> using unicast might be faster than using broadcast too, which is usual=
ly
     fixed to a lower mcast rate.
   alfred [1], which servers a similar purpose (at least i think so) does t=
he same.
 * create a batman patch for private use
 * don't send so much stuff. :D

I think doing the unicast approach and sending only to neighbors or designa=
ted hosts
is not too bad.

Cheers,
	Simon

[1] http://www.open-mesh.org/projects/open-mesh/wiki/2013-05-19-alfred-open=
-beta

--5mCyUwZo2JvN/JJP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlHyaIgACgkQrzg/fFk7axbjzgCdGAzT6eCBHsTxvNgVtQdITEf2
OOgAn2q2Swl2VX4PqKmzC6pgg+2GhiU+
=A4AV
-----END PGP SIGNATURE-----

--5mCyUwZo2JvN/JJP--
