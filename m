Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 17 Apr 2013 23:56:55 +0800
References: <20130417120550.GD20819@ritirata.org>
 <1366202206-32718-1-git-send-email-martin@hundeboll.net>
In-Reply-To: <1366202206-32718-1-git-send-email-martin@hundeboll.net>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201304172356.55561.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2] batman-adv: Avoid double freeing of
	bat_counters
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

On Wednesday, April 17, 2013 20:36:46 Martin Hundeb=C3=B8ll wrote:
> --- a/soft-interface.c
> +++ b/soft-interface.c
> @@ -497,12 +497,10 @@ static int batadv_softif_init_late(struct net_device
> *dev)=20
>         ret =3D batadv_mesh_init(dev);
>         if (ret < 0)
> -               goto unreg_debugfs;
> +               batadv_debugfs_del_meshif(dev);
> =20
> -       return 0;
> +       return ret;
> =20
> -unreg_debugfs:
> -       batadv_debugfs_del_meshif(dev);
>  free_bat_counters:
>         free_percpu(bat_priv->bat_counters);
> =20

This looks like a valid problem but I do suggest setting bat_priv-
>bat_counters to NULL after calling free_percpu(). Otherwise we will run in=
to=20
this problem again when somebody else changes the order of the calls ...


Cheers,
Marek
