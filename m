Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Mon, 6 Sep 2010 14:07:57 +0200
References: <1283729393-13842-1-git-send-email-linus.luessing@web.de>
	<20100906073046.GA6973@sven-atom.lazhur.ath.cx>
	<20100906100913.GA13044@Sellars>
In-Reply-To: <20100906100913.GA13044@Sellars>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2362549.98KbOFeOte";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201009061407.59606.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Always synchronize rcu's on
	module shutdown
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

--nextPart2362549.98KbOFeOte
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Linus L=FCssing wrote:
> Hi Sven,
>=20
> synchronize_net already contains a synchronize_rcu at its end, so
> the synchronize_rcu in the batman code there has always been
> redundant.
>=20
> I've removed the synchronize_rcu instead of the synchronize_net to
> be on the safe side. I guess usually no more packets should arrive
> anyway as the batman packet type is not registered anymore. But I
> wasn't sure if the might_sleep() of synchronize_net() might be
> needed for something, so I didn't dare to remove synchronize_net.
>=20
> If someone says it'd be ok to remove synchronize_net() instead,
> I could make a new patch, no problem.

Ok, it would have been nice to state such things in the commit message=20
(otherwise the stable@kernel.org will drop such a patch quite easily). Mare=
k=20
and I have ausgekaspert why it only happens in 1765 and also in 1766. So it=
=20
will not be a patch for stable.

And the might_sleep is only for debugging purposes. But yes, it makes sense=
 to=20
use synchronize_net here (for example due to the usage of dev_remove_pack=20
before).

That means that technically the patch seems to be ok, but didn't liked the=
=20
explanation with the problem that we might have to justify it to the=20
stable@kernel.org guys that way.

So I would ack the patch with a minor change in the commit message. So inst=
ead=20
of

> During the module shutdown procedure in batman_exit(), a rcu callback is
> being scheduled (batman_exit -> hardif_remove_interfaces ->
> hardif_remove_interfae -> call_rcu). However, when the kernel unloads
> the module, the rcu callback might not have been executed yet, resulting
> in a "unable to handle kernel paging request" in __rcu_process_callback
> afterwards, causing the kernel to freeze.
> Therefore, we should always flush all rcu callback functions scheduled
> during the shutdown procedure.

something like

> During the module shutdown procedure in batman_exit(), a rcu callback is =
                                                                           =
                                                     =20
> being scheduled (batman_exit -> hardif_remove_interfaces ->              =
                                                                           =
                                                     =20
> hardif_remove_interfae -> call_rcu). However, when the kernel unloads    =
                                                                           =
                                                     =20
> the module, the rcu callback might not have been executed yet, resulting =
                                                                           =
                                                     =20
> in a "unable to handle kernel paging request" in __rcu_process_callback  =
                                                                           =
                                                     =20
> afterwards, causing the kernel to freeze.                                =
                                                                           =
                                                     =20
                                                                           =
                                                                           =
                                                   =20
> The synchronize_net and synchronize_rcu in mesh_free are currently       =
                                                                           =
                                                     =20
> called before the call_rcu in hardif_remove_interface and have no real   =
                                                                           =
                                                     =20
> effect on it.                                                            =
                                                                           =
                                                     =20
                                                                           =
                                                                           =
                                                   =20
> Therefore, we should always flush all rcu callback functions scheduled   =
                                                                           =
                                                     =20
> during the shutdown procedure using synchronize_net. The call to         =
                                                                           =
                                                     =20
> synchronize_rcu can be omitted because synchronize_net already calls it.

thanks,
	Sven

--nextPart2362549.98KbOFeOte
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJMhNmeAAoJEF2HCgfBJntGHbcP/igC/gt2AuVRCYiQM8u7Sn4T
jXGsF7QAWOlmSWJbSnSR+m9DfTeVDvD4cVvjpQ7XlNxWiKSA2yTLSYO5alYp1Gvz
SqwiX6M8Def1lDhsxKG96mSPK/j1PVI4PIvjBgBmOrFJoFTDVZATJfMpPg3zjkRn
94QGzVjC90EnX0678dKpTOhVGMHamcphhiQa4yr1lS2hv8kuU8zfCyz6NY4KaZCb
h9qct/YXmm3Si2+yNeRyt4zf8nRkzQzgTPi8A6066pbGUTISwVKPpasNd/arYXPd
iZp+b6w2dA+ls/NUheioTH8mwdnvGOysvaNkp7fA7xd/RvJ+HtIzBg3ZFVrEfa5a
jpTAhQUVc5neAfKvjXeqg7SNvCCk45+b9xtcivHzGEYtJP0nMBJoHodcP8jWWNqZ
Je/B/AKWjgyhC6p/oB7n/WOXZ917s6d5gbZL1Aqsy7bJGJVaExoVSxBAapmMhZSI
2KLwyzVVMqNwpDw1fLefP9sYfA8D+60M5yeh9CnlQin8y6rfScCr5EkRoDhkFDMH
UloPrH30tFfPP3bG1efryebZnscykJQiktj/GV/VdGNjSEqzrfuQT3zNfN8EhCGN
WCFlb6kG5A3hkJs5PLefcNVkD7AeUqJ4JpFp19pYcqX/LxdNH0/oZmL2avnEFVeO
Ml5Drx3lbm7gPqGe/pe1
=t3uX
-----END PGP SIGNATURE-----

--nextPart2362549.98KbOFeOte--
