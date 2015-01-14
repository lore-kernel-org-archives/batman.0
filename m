Return-Path: <mpa@pengutronix.de>
Date: Wed, 14 Jan 2015 16:24:17 +0100
From: Markus Pargmann <mpa@pengutronix.de>
Message-ID: <20150114152417.GB11698@pengutronix.de>
References: <1419594103-10928-1-git-send-email-mpa@pengutronix.de>
 <1419594103-10928-6-git-send-email-mpa@pengutronix.de>
 <3044505.BN7NZDCpey@diderot>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="QTprm0S8XgL7H0Dt"
Content-Disposition: inline
In-Reply-To: <3044505.BN7NZDCpey@diderot>
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 05/26] batman-adv: init,
 Add some error handling
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
To: Marek Lindner <mareklindner@neomailbox.ch>
Cc: b.a.t.m.a.n@lists.open-mesh.org, Sven Eckelmann <sven@narfation.org>, Antonio Quartulli <antonio@meshcoding.com>


--QTprm0S8XgL7H0Dt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 11, 2015 at 08:38:10PM +0800, Marek Lindner wrote:
> On Friday 26 December 2014 12:41:22 Markus Pargmann wrote:
> >  static int __init batadv_init(void)
> >  {
> > +       int ret;
> > +
> >         INIT_LIST_HEAD(&batadv_hardif_list);
> >         INIT_HLIST_HEAD(&batadv_algo_list);
> > =20
> >         batadv_recv_handler_init();
> > =20
> > -       batadv_iv_init();
> > -       batadv_nc_init();
> > +       ret =3D batadv_iv_init();
> > +       if (ret)
> > +               return ret;
> > +
> > +       ret =3D batadv_nc_init();
> > +       if (ret)
> > +               return ret;
> > =20
> >         batadv_event_workqueue =3D
> > create_singlethread_workqueue("bat_events"); -
> >         if (!batadv_event_workqueue)
> >                 return -ENOMEM;
> > =20
> >         batadv_socket_init();
> >         batadv_debugfs_init();
> > =20
> > -       register_netdevice_notifier(&batadv_hard_if_notifier);
> > -       rtnl_link_register(&batadv_link_ops);
> > +       ret =3D register_netdevice_notifier(&batadv_hard_if_notifier);
> > +       if (ret)
> > +               goto err_netdev_notifier;
> > +
> > +       ret =3D rtnl_link_register(&batadv_link_ops);
> > +       if (ret)
> > +               goto err_link_register;
> > =20
> >         pr_info("B.A.T.M.A.N. advanced %s (compatibility version %i)
> > loaded\n", BATADV_SOURCE_VERSION, BATADV_COMPAT_VERSION);
> > =20
> >         return 0;
> > +
> > +err_link_register:
> > +       unregister_netdevice_notifier(&batadv_hard_if_notifier);
> > +err_netdev_notifier:
> > +       batadv_debugfs_destroy();
> > +
> > +       return ret;
> >  }
>=20
> To be truely clean, I guess the workqueue should be destroyed as well ?

Yes, thanks, added destroy_workqueue() for v3.

Best Regards,

Markus

--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--QTprm0S8XgL7H0Dt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUtoohAAoJEEpcgKtcEGQQQNoP/10Z26nok1L0WE6aZb3H/0G7
ILSwAOAyw0YZLBPBmyJU8CRA4wztOMKERUY0Hke7y6GuAeRYUZhbxDeS3OYUwwVQ
1momMBTh116uu+ndrMSWP0dY2K/2Rp2b3FhLBqKqptqoW6n0bL9/2dJPbNZOFGJ2
lCV6IhGevPP1lpJohf9txEsMwDyzLkW5zbLGYwEM+s2wLOcEKMA1mz1EvH6bpC7d
DmmHW05fplAUyzf7lOTAx7XUNg8fI2cYFb0oe3+PR20Thfqw9XgAhbHHo2V4jh8M
aKjAPwkaEaHHCFF9xTAYEnlE9TcLc21k8HURltWkIKkRYBt1U2iccp3XImTCXjkF
dYy5IHxctCcEof9jszue983Gb+8Pbck75YYfvSBZ4DaBv4CsOSKV5zW817Yx7ADs
/wX3hzUmfyV9NQZOvky9uI07YYSaTUmaviJ6trdYDoIvWmoRjUk32kOQHD9GwgQC
guXfcyEi8YDhXt9aJhDdlNow9tad6RgcPhADeEfxzJLLRETXCwFrtvGX2AwPJ0p3
1JAztg4v27U0btiLkyLxtzr36oNMJbjaUqqwExps6Yqe54ow0DDpnrDiS0pzoPyT
b3DsD4hIdMfIil7+Kq3isrboYqoxW80SgPvnCINK9jKd9Zex9nGWTYQHTm8nY+Fq
fjovr79NmF1JI6GvR/wC
=J4aN
-----END PGP SIGNATURE-----

--QTprm0S8XgL7H0Dt--
