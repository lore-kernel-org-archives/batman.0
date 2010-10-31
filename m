Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sun, 31 Oct 2010 17:12:07 +0100
References: <1288539158-26976-1-git-send-email-linus.luessing@web.de>
	<201010311704.48893.sven.eckelmann@gmx.de>
In-Reply-To: <201010311704.48893.sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1545583.OIWGY5pPtk";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201010311712.07786.sven.eckelmann@gmx.de>
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

--nextPart1545583.OIWGY5pPtk
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Sven Eckelmann wrote:
> Linus L=FCssing wrote:
> > sysfs_del_hardif invokes kobject_put, which might sleep. However, we
> > are not allowed to sleep during a call_rcu. There is also no need to
> > do the removal with an atomic call_rcu, as kobject_put only frees the
> > kobject when there is no more reference to it anyway.
> >=20
> > This commit basically revokes 7f32f2e8d97150ba5b80410dda86b01b0879fe8d,
> > despite not reintroducing the synchronize_rcu, our rcu_barrier should
> > handle this.
>=20
> This is an extreme bad idea as we would free the object before the rcu
> grace period is over. This would mean that any parallel run through the
> list would probably access memory which is invalid. So this is a good way
> to crash your machine.
>=20
> What makes you think that kobject_put sleeps? There is no code which prov=
es
> it. The only reason would be that kobject_put -> kobject_release ->
> kobject_cleanup -> ... sleeps. Please complete that chain to show were the
> problem is. If it really sleeps then please only do the kobject related
> cleanup outside of call_rcu.

=46ound documentation about it in Documentation/kobject.txt

If you need to do a two-stage delete of the kobject (say you are not
allowed to sleep when you need to destroy the object), then call
kobject_del() which will unregister the kobject from sysfs.  This makes the
kobject "invisible", but it is not cleaned up, and the reference count of
the object is still the same.  At a later time call kobject_put() to finish
the cleanup of the memory associated with the kobject.


Please find another way to fix it - reverting=20
7f32f2e8d97150ba5b80410dda86b01b0879fe8d is no option (especially not when=
=20
removing rcu synchronization).

Best regards,
	Sven

--nextPart1545583.OIWGY5pPtk
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABCgAGBQJMzZVXAAoJEF2HCgfBJntG96oP/iXKz9dtwEIhZWn3kd3IOZO9
b6SP3vW7YupJe6w7mCP0UHybzE5BaDjWeXOPAJ98Jt1/KYAy575QyhGb7ltrg81+
b8IwV5FDNdNphL0yZIiQReW6scDtWsOWY4O/+j0b91VTdvpRSAnj3LXUtP0MOrpm
pntf0T6as8eFoAO/wOfHQ8c44c6iWrhCzZ7X0bNE2bRfQKGuR2H4Yr2MTk0Ww6jS
JS6tW52qzJwhbpsfFjM8SvKyr2YiQll0WGz3Xb+zvT8ICHghKw7ZsBxsWhb5DKQq
1nUKY67OZyHTMv26S7bUp3uM+75ir1ziNLjjnTU8CYzxZZMnIsCDyK0Iz1YvAfUr
fdKGjEg/LM6j0U8VzyrMtklIlV+VXbW1mUtL/9Iuxrlujla+9HssutRGOlblYfns
mQVVguMJmSDpeyp1/adZHq+GlI90wEvjiRFI4uwQgzpXe9zhRoDLwIiwudiSkNEG
YfyHUNqYC+hw1Ax8EGFdQrPYaapnBMFTgBM/3Wcfsfir7IVdABBsBbCn15xODz4c
yEA9BjJ/VtyMnTYxYZ/hV0WeBjmJRnjyIhThJIXRMHyyQ7lfI6YCfpIOWHYhjdse
jSJ2uOKnYrY7bfJ654hcA4tEY16CxUmoYobO5bjoE2ku507C1ya/cbQy+6Qh+lxL
HMeDObaX3HvHXBzD1QdM
=W4XS
-----END PGP SIGNATURE-----

--nextPart1545583.OIWGY5pPtk--
