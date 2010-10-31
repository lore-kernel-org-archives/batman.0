Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sun, 31 Oct 2010 17:04:48 +0100
References: <1288539158-26976-1-git-send-email-linus.luessing@web.de>
In-Reply-To: <1288539158-26976-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart23012082.Dky9rgzbuX";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201010311704.48893.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Don't call
	sysfs_del_hardif() in atomic context
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

--nextPart23012082.Dky9rgzbuX
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Linus L=FCssing wrote:
> sysfs_del_hardif invokes kobject_put, which might sleep. However, we
> are not allowed to sleep during a call_rcu. There is also no need to
> do the removal with an atomic call_rcu, as kobject_put only frees the
> kobject when there is no more reference to it anyway.
>=20
> This commit basically revokes 7f32f2e8d97150ba5b80410dda86b01b0879fe8d,
> despite not reintroducing the synchronize_rcu, our rcu_barrier should
> handle this.

This is an extreme bad idea as we would free the object before the rcu grac=
e=20
period is over. This would mean that any parallel run through the list woul=
d=20
probably access memory which is invalid. So this is a good way to crash you=
r=20
machine.

What makes you think that kobject_put sleeps? There is no code which proves=
=20
it. The only reason would be that kobject_put -> kobject_release ->=20
kobject_cleanup -> ... sleeps. Please complete that chain to show were the=
=20
problem is. If it really sleeps then please only do the kobject related=20
cleanup outside of call_rcu.

Best regards,
	Sven

--nextPart23012082.Dky9rgzbuX
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABCgAGBQJMzZOgAAoJEF2HCgfBJntGHDoP/1WF+zmoSpDrOCWfnngGCThd
V+cv4e0hsGkp/f7s5IywMtAKrbYKaj5XiRtZm4dH9rSdl1DInyT4gruDOMT3Y2o0
lGrTySE4+u1uQUbVmHl6LjHDLFwYAYfLBpy/UaJptxITMusPzSFyTSEGPGxVZDnW
VyQxXDlzSK9unp0fAd77J3lHVuyz+fCRfzBq60Q56LE7EzFPBVoNNOr+Zax5A9gT
0ufCQRSf/eJ6RwxvEOFmzAO4ggPY/ZkTTTj3CP1sOKLiBiswddGFDSws+OQiolvm
cXFYZr5LljsbD6z/XQN+ZnQ6SFtWZNKexCT04A3zvzEU3SKuMgpiQWpZSBUKWhoE
37E55Ghu3aCQXSaN4az1MJ/a4WTF5KDOtQpDA3uld8BCBDJBS/KfYOTnp1gF1biP
W8j1aczj/v2wS02tEBlxgPfxVUKOeclLkh22jOh+B+2Oog0jNJMRESvdZc3vnOVI
lojizosvmUMSOPKaXjduTsIykk8nbwa98gW1wnrkFmCkwQw5UzhvavVxRXTJwqAv
TY//7PQgGD3wSYtt9OfdXXSiPP4c5VRZUNBxxPMMKSnGbKn14cbWD7yaSS++Osnh
WhRhOgJ0gpXxdMZtWYi5vT0zdkQedR4Wlippqp4V1weLAUuXbbeq2gi/Ie7l2eCa
nSOs9r8E8g659YUTy3gI
=kxQL
-----END PGP SIGNATURE-----

--nextPart23012082.Dky9rgzbuX--
