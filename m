Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Fri, 13 Aug 2010 05:24:22 +0200
References: <4C6437BF.9080909@web.de>
In-Reply-To: <4C6437BF.9080909@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2729911.Y8edOmnlPr";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201008130524.24059.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] Problem openWRT "backfire" and "kmod-batman-adv"
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
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Tim Glaremin <Tim.Glaremin@web.de>

--nextPart2729911.Y8edOmnlPr
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Tim Glaremin wrote:
> Hope it helps.... The part Marek quoted at least did change :)

The biggest problem is, that it is relative unreadable due to the reformatt=
ing=20
done by your mua. The next big problem is that the guessing will begin now=
=20
using the information in the stacktrace.

My first guess would be hardif_min_mtu. Maybe the netdev we want to access =
was=20
removed in the time we try to update our information of the=20
removed/deactivated interface (or another interface we also received some k=
ind=20
of notification).

I would have guessed that this cannot happen because we haven't processed a=
ll=20
notification items, but I am awake a little bit too long to make 100% corre=
ct=20
statements.

Maybe because we use dev_put in hardif_deactivate_interface too early and=20
iterate over the already 'putted' device in our list (will be removed in=20
hardif_remove_interface from our list) - which seems to be wrong too me rig=
ht=20
now. So all references will be gone when the interface goes down (so maybe =
it=20
will be completely deleted at that point), but the pointer to the destroyed=
=20
netdev is still in our list and will only deleted when the device will real=
ly=20
be unregistered.

thanks,
	Sven

--nextPart2729911.Y8edOmnlPr
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJMZLrnAAoJEF2HCgfBJntGB7oQAI3Ysc7EbWZt6nlP8YP7LM3n
MlQjxiGm+dWJXewPGvFcD6TLeAW75dIp99fS6luXQa/+JPsFk+qVTBXI6tpISzpl
JreGBAPinPSWwtnngjnteRX6eLXaX5n5B4e+nEkrgT2tV/TZSIIv1UPGoPepIFbT
zgAPtVj1iELDWlE22lE+1y6ujeEHiAzmzMHaYnje7ZoQywkVMyNY3bq6IOhpjAyt
03LhY3RUif5UfKiMV1lFyiR9sBpSA7ElTN4pmMMynYMFdmy61zO1oeNg7rkZstQm
WYRPlMjf84oDY0KFx5qp+GMbbZeOtLtU0uudvaeFw8ZLF/tqOucpyWcQEllttq0+
aTNNPzbe/bajWUH2giJkhCiciuSd7ErikT/OPj9J3W/T5aODtMJ9EwxoMOQQQeuv
ux2NdC4AzE3kEQhpIiboddP64q2R1YGV0YEsuFLQj1j1ZI8h/3jwL/42UWoeeSV3
tTM9o8mUlKnNwRBKaadVCWsUXmsE+0vV8F9urNa0a3u98Vr6kj85yDXz1YIakq9q
mj/hdbxStnQ3OzL8YpmFY2scrugGzAnbpgj6UWQEyIFPFeBvxOizkBTqgf9o0ucX
3lZKikB63E0o21nuz/Ib8sL58yu9hFkibym8OayOJuYqEz/1zna4JsgibJ5q54Sr
vRuVaL+shYv9b7Le7s/2
=jYNh
-----END PGP SIGNATURE-----

--nextPart2729911.Y8edOmnlPr--
