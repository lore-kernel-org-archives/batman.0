Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Thu, 10 Jan 2013 10:02:05 +0100
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20130110090204.GA29050@pandem0nium>
References: <1356910850-17542-1-git-send-email-siwu@hrz.tu-chemnitz.de>
 <cbd56d4714a87d66c4f8a81af5fe1081@autistici.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="J2SCkAp4GZ/dPZZf"
Content-Disposition: inline
In-Reply-To: <cbd56d4714a87d66c4f8a81af5fe1081@autistici.org>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: postpone sysfs removal when
 unregistering
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
To: Antonio Quartulli <ordex@autistici.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org, Simon Wunderlich <siwu@hrz.tu-chemnitz.de>


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Antonio,


On Thu, Jan 10, 2013 at 04:34:47AM +0200, Antonio Quartulli wrote:
> Hello Simon,
>=20
> thanks a lot for taking care of this and sorry for my very late reply..

no problem, thanks for your review!

>=20
>=20
> Il 31.12.2012 01:40 Simon Wunderlich ha scritto:
> >diff --git a/hard-interface.c b/hard-interface.c
> >index f1d37cd..eb3a12d 100644
> >--- a/hard-interface.c
> >+++ b/hard-interface.c
> >@@ -506,6 +506,17 @@ out:
> > 	return NULL;
> > }
> >
> >+static void batadv_hardif_remove_interface_finish(struct
> >work_struct *work)
> >+{
> >+	struct batadv_hard_iface *hard_iface;
> >+
> >+	hard_iface =3D container_of(work, struct batadv_hard_iface,
> >+				  cleanup_work);
> >+
> >+	batadv_sysfs_del_hardif(&hard_iface->hardif_obj);
> >+	batadv_hardif_free_ref(hard_iface);
> >+}
> >+
> > static void batadv_hardif_remove_interface(struct batadv_hard_iface
> >*hard_iface)
> > {
> > 	ASSERT_RTNL();
> >@@ -518,8 +529,9 @@ static void batadv_hardif_remove_interface(struct
> >batadv_hard_iface *hard_iface)
> > 		return;
> >
> > 	hard_iface->if_status =3D BATADV_IF_TO_BE_REMOVED;
> >-	batadv_sysfs_del_hardif(&hard_iface->hardif_obj);
> >-	batadv_hardif_free_ref(hard_iface);
> >+	INIT_WORK(&hard_iface->cleanup_work,
> >+		  batadv_hardif_remove_interface_finish);
> >+	queue_work(batadv_event_workqueue, &hard_iface->cleanup_work);
> > }
> >
>=20
> why do we need to postpone the invocation of
> batadv_hardif_remove_interface_finish() ? Is it also creating a
> possible
> deadlock? As far as I understood only rtnl_lock() would create the
> problem, but it
> is not invoked in batadv_hardif_remove_interface_finish(). It seems
> I am missing
> something?

batadv_hardif_remove_interface() is called by batadv_hard_if_event(),
which is protected rtnl_lock(). You can find an ASSERT_RTNL() there too.
As batadv_hardif_remove_interface() then removes sysfs, this could
be problematic.

>=20
> Other than this, remember that the INIT_WORK macro does not need to
> be invoked
> each and every time you want to enqueue the work. It should be
> invoked once only
> (A patch fixing this "issue" for all the delayed works we have in
> the code has
> been recently applied). However it is not a real issue, but we want
> to keep the
> code consistent :)
>=20

Well, the work item is actually only initialized once, before taking
the interface down. Then the struct is destroyed, so it can't be called
again. But you are right, for consistency I will move the INIT_WORK
macros to positions where the structs are initialized.

> > int batadv_softif_is_valid(const struct net_device *net_dev)
> >diff --git a/types.h b/types.h
> >index d8061ac..a9800ee 100644
> >--- a/types.h
> >+++ b/types.h
> >@@ -63,6 +63,7 @@ struct batadv_hard_iface {
> > 	struct net_device *soft_iface;
> > 	struct rcu_head rcu;
> > 	struct batadv_hard_iface_bat_iv bat_iv;
> >+	struct work_struct cleanup_work;
> > };
> >
>=20
> kernel doc :)
>=20

The Mareks kernel doc patch wasn't applied at this time, so I didn't
bother documenting my single new variable, but will do that in the
next revision. :)

Thanks,
	Simon

--J2SCkAp4GZ/dPZZf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAlDug4wACgkQrzg/fFk7axZT5gCfWPP7o3Mri/8e0XzsJPq4Qp23
mEwAnjzUNHgXF4R+3hhWJ72Q1gXTSORq
=Kkjx
-----END PGP SIGNATURE-----

--J2SCkAp4GZ/dPZZf--
