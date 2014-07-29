Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Tue, 29 Jul 2014 14:55:14 +0200
References: <BLU402-EAS15F34D695A5F704F712449E1FE0@phx.gbl>
In-Reply-To: <BLU402-EAS15F34D695A5F704F712449E1FE0@phx.gbl>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1440970.mUWHjvIbCo";
 protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <201407291455.18505.sw@simonwunderlich.de>
Subject: Re: [B.A.T.M.A.N.] Opportunity to contribute in B.A.T.M.A.N
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
Cc: Dhruvesh Rathore <dhruvesh_r@hotmail.com>

--nextPart1440970.mUWHjvIbCo
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello Dhruvesh,

> Hello,
>=20
> 	We are a group of students that are currently pursuing our undergraduate
> degrees in Computer Science form Pune Institute of Computer Technology
> (PICT), Maharashtra, India. We will be graduating in June 2015 and are
> currently in our final year. For our final year B.E project we have
> selected the domain as Computer Networks and would be very interested in
> working in the field of routing protocols for multihop ad-hoc mesh
> networks, which is where we stumbled upon the B.A.T.M.A.N protocol. Over
> the past few weeks we have been extensively studying the various features
> and working principles which has allowed this protocol to prosper. It will
> be a great learning opportunity for us to work with B.A.T.M.A.N and in
> turn work with you. As per given on the open-mesh.org website for
> contributions, we would appreciate if you could steer us towards the
> direction of choosing the right topic and working towards culminating a
> project in the same, which would be helpful for the community. Following
> are a few details which includes information about us, which would help
> you in making an informed decision:

Thank you very much for your interesting proposal. We have discussed a litt=
le=20
bit about topics you might find interesting and which are currently vacant:

 * Distributed ARP table support for IPv6 - this has been started but they =
guy=20
who has been working on it doesn't have the time anymore. You could pick up=
=20
the patches [1]
 * Interconnecting batman-adv clouds. We have a rough draft proposal [2]=20
already, but nothing more
 * Evaluation and review of BATMAN V - we currently work on the next=20
generation of BATMAN routing, and testing/reviewing that would certainly he=
lp.

I'm not sure how much experience you have in kernel development. Depending =
on=20
the task you choose, it would be a good thing to start reading about how th=
e=20
kernel and kernel modules work. In any case, for submitting code you must=20
comply to the Linux kernel coding style[3], and should run your patches=20
through checkpatch, but you probably have already read that in our=20
contribute[4] page. And please don't hesitate to send patches early, you ca=
n=20
always send unfinished stuff as RFC patches. As you can see on the mailing=
=20
list, we usually have a few review cycles for patches, and even though you=
=20
have a few months planned development, time runs out easily and it would be=
=20
sad to see half-finished stuff stopped being worked on. :) You should plan =
to=20
release the first feature-complete patchset at half-time at latest to have=
=20
enough time for review/corrections.

If you have ideas on your own what you want to work on, please don't hesita=
te=20
to propose them!

Cheers,
     Simon

[1] http://thread.gmane.org/gmane.org.freifunk.batman/10014/focus=3D10574
[2] http://www.open-mesh.org/projects/open-mesh/wiki/Connecting-Batman-adv-
clouds
[3] https://www.kernel.org/doc/Documentation/CodingStyle
[4] http://www.open-mesh.org/projects/open-mesh/wiki/Contribute

--nextPart1440970.mUWHjvIbCo
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlPXmbIACgkQrzg/fFk7axYZcACfQr/4+SCWQcWjJ6Bi/oohrDB5
XY8An0Nzttm01IVb5SaVUQCDvbok+wZQ
=y4sK
-----END PGP SIGNATURE-----

--nextPart1440970.mUWHjvIbCo--
