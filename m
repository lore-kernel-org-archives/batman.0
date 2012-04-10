Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 10 Apr 2012 14:05:16 +0300
References: <1333370896-11295-1-git-send-email-martin@hundeboll.net>
	<201204041007.02852.lindner_marek@yahoo.de>
	<4F840C67.7060707@hundeboll.net>
In-Reply-To: <4F840C67.7060707@hundeboll.net>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201204101405.16743.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [RFC 1/2] batman-adv: Add interface to keep stats
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

On Tuesday, April 10, 2012 13:33:11 Martin Hundeb=C3=B8ll wrote:
> On 04/04/2012 10:07 AM, Marek Lindner wrote:
> > On Monday, April 02, 2012 14:48:15 Martin Hundeb=C3=B8ll wrote:
> >> @@ -265,6 +266,18 @@ static int vis_data_open(struct inode *inode,
> >> struct file *file) return single_open(file, vis_seq_print_text,
> >> net_dev);
> >>=20
> >>   }
> >>=20
> >> +static int bat_stats_open(struct inode *inode, struct file *file)
> >> +{
> >> +	struct net_device *net_dev =3D (struct net_device *)inode->i_private;
> >> +	return single_open(file, bat_stats_show, net_dev);
> >> +}
> >=20
> > Did you consider using bat_priv->stats or ethtool->get_ethtool_stats() ?
>=20
> Wouldn't that require patching netdevice.h? And in that case, is there any
> chance to get batman-adv specific counters into the generel netdev stats
> structure?

No, I did not mean we should patch netdevice.h. The kernel has traffic=20
counters we might be able to re-use for our purpose. Especially=20
get_ethtool_stats() allows to export custom counters to userspace.
The kernel developers don't like duplicating existing infrastructure. At le=
ast=20
we should know what the kernel offers and come up with a reasonable=20
explanation why they don't help us.


> >> +static int bat_stats_clear_open(struct inode *inode, struct file *fil=
e)
> >> +{
> >> +	struct net_device *net_dev =3D (struct net_device *)inode->i_private;
> >> +	return single_open(file, bat_stats_clear, net_dev);
> >> +}
> >=20
> > How about writing 0 to the stats file resets the counters, thus avoiding
> > a second file ?
>=20
> That is possible, but then I would have to write the debugfs-handling
> myself, instead of using the nice macro defined in bat_debugfs.c. It's a
> tradeoff between code size and number of files in debugfs.

Alternatively, you could extend the existing macro to also set a file handl=
er=20
for writes instead of assuming only reads. :-)


> > If you add an ifdef around the definition here would be no need to mall=
oc
> > bat_stats separately, right ?
>=20
> Do we prefer IFDEFs in the definition over mallocs? (I guess so by your
> comment). If thats the case, then no problem with me.

The types.h is full of ifdefs already. It helps to keep the structs smaller=
=20
when functionality is not compiled into the module.

Regards,
Marek
