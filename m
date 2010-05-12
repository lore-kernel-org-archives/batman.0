Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Wed, 12 May 2010 20:55:56 +0200
References: <1273177132-8792-1-git-send-email-andrew@lunn.ch>
	<201005130119.39204.lindner_marek@yahoo.de>
	<20100512173830.GA27912@kroah.com>
In-Reply-To: <20100512173830.GA27912@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1566239.EZr7xrxkAX";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201005122056.05476.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 13/26] staging:batman-adv: convert
	multiple /proc files to use sysfs
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
To: b.a.t.m.a.n@lists.open-mesh.org, gregkh@suse.de
Cc: Greg KH <greg@kroah.com>, Marek Lindner <lindner_marek@yahoo.de>, b.a.t.m.a.n@lists.open-mesh.net

--nextPart1566239.EZr7xrxkAX
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Thank you for the fast answer.=20

Greg KH wrote:
> On Thu, May 13, 2010 at 01:19:38AM +0800, Marek Lindner wrote:
> > Hi Greg,
> >=20
> > > Please document all sysfs files with a Documentation/ABI/ entry.  You
> > > can put it in the drivers/staging/batman-adv/ directory for now.
> > >=20
> > > Also note, binary sysfs files are for things that are "pass-through",
> > > not for things that you try to intrepret like I think you are doing
> > > here.  What's wrong with configfs for something like this?
> >=20
> > I drafted the ABI documentation which you will find attached to this
> > mail. Since this is my very first attempt I'd appreciate feedback from
> > your side before we submit it. I looked at various existing ABI docs in
> > the linux kernel tree to get an idea how it should look like. Bear with
> > me if it is not perfect yet.  ;-)
> >=20
> > Regarding the question which kernel configuration interface to use, we
> > would be more than happy to receive some guidance. At this point we are
> > rather unsure which of the many (procfs/sysfs/configfs/etc) filesystems
> > are we supposed to go forward with. To better judge our case I recommend
> > reading this page http://www.open-mesh.org/wiki/tweaking-batman-adv
> > as it explains the purpose of the various sysfs files.
> >=20
> > Right now, I would say that configfs does not belong to my favorite
> > solutions, simply because it seems to be a rather new/uncommon choice.
>=20
> configfs is very old, and has been around almost as long as sysfs has
> been.  But yes, it's not used as much, that is true.
>=20
> > Batman's main deployment field are embedded devices (mostly low cost
> > routers) that have quite some contraints regarding cpu power and
> > available disk space. Typically, those systems try to deactivate all
> > "unnecessary" functionality in the kernel to have a few more bytes
> > available for other stuff. For example OpenWRT: They deactivated
> > configfs on all platforms (except one). I fear we create more problems
> > than we solve if we go down this path.
>=20
> Well, it is simple to enable configfs if you need/want batman, right?
> It's not that much extra kernel code.

Yes, it should be possible to enable it. It was just meant to describe the=
=20
current situation and the target systems were batman-adv is currently used.=
=20
There is for example the requirement by one developer that it runs on his=20
hardware which currently only support 2.6.24 as kernel due to different out=
 of=20
kernel drivers. There were also some request to port it back to 2.6.15 to g=
et=20
the Atheros drivers working... which is out of scope for us due to differen=
t=20
changes in the kernel since 2.6.15. It isn't always easy to support all tho=
se=20
requirements and get it in the right shape for a merge in the mainline kern=
el=20
(and my/our gap in education about all virtualfs doesn't help either).

This makes invalid entries in sysfs not better, but maybe helps you to get =
in=20
the correct mood to point us in the right direction.

> > What:           /sys/class/net/<mesh_iface>/mesh/originators
[...]
>=20
> Sorry, but sysfs is for "one value per file" attributes, which this one
> violates.
>=20
> Is this something that everyone always needs to know?  Or could it be a
> debugfs file?

Everyone/always - not really. They are needed by someone who wants to test =
and=20
debug the status of batman-adv - which sounds like a perfect target for=20
debugfs, right?

So batctl has to check if /sys/kernel/debug/ is mounted (or the batman-
adv/mesh_iface/originator) file can be found and give the user a helpful er=
ror=20
message that either batman-adv is not loaded, debugfs is not mounted at=20
/sys/kernel/debug/ or the mesh_iface just doesn't exists.

> > What:           /sys/class/net/<mesh_iface>/mesh/transtable_global
[...]
>=20
> Again, no "tables" in sysfs please.
>=20
> > What:           /sys/class/net/<mesh_iface>/mesh/transtable_local
[...]
>=20
> Same here.
>=20
> > What:           /sys/class/net/<mesh_iface>/mesh/vis_mode
[...]
> >=20
> > What:           /sys/class/net/<mesh_iface>/mesh/vis_data
[...]
>=20
> Again, this is not a single value, so please move it somewhere else.

As far as I can see only these files with (more or less) debug information =
are=20
the problem right now and should go to the debugfs?

The rest can be in sysfs?:
 * /sys/class/net/<iface>/batman-adv/mesh_iface
 * /sys/class/net/<iface>/batman-adv/iface_status
 * /sys/class/net/<mesh_iface>/mesh/aggregate_ogm
 * /sys/class/net/<mesh_iface>/mesh/orig_interval
 * /sys/class/net/<mesh_iface>/mesh/vis_mode (not sure about that one becau=
se
   it is in the no-list, but without comment. You can only write "client"/
   "server" into that file and read the same value. So probably in the sysfs
   list)


Best regards,
	Sven Eckelmann

--nextPart1566239.EZr7xrxkAX
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJL6vm8AAoJEF2HCgfBJntGNMMP/jHhXy3Kokspuzdu18iySB+P
JXp0fYdPC6gfxyQ7tNKkZPbu5DOA7C4VHKzrh/hL9dQK5lPBInzNJaliI/Ud3dds
Z3Ra3krK3OdBJq0NBmWSizHQ7TGLQmO+kDn3k4IzhlojU6e2sgVQytfve+4YWM2G
DWqUnYrQ6g+oQoMkmv3zGfaDprwrmzJLXJP2QpW1kUJ7gRfxyU4YMZ8CmXVz8D5/
bbmodH/ZFyplVtvmVNpDs5HkCbRKw39XK2gG4waqBmlSd3YV8Lbwmen/xVLxgt1r
5C4S+BbKhwhYGTzGMnabbVCrG7Sw+cef2FYTHMJrSucwEjvoAQh4PJ47s5rgD9kB
9e1c3BNCq417NWRKQDf7Mzgbh7774+RL0wn8IIA+zBcvOFgHkhLsvE61aWM2Itro
+vuLXYd8wk9biTWmC6H91AMsz3ENOm/nay6w1ySml472AtVSAVrxbi/aRPs0kjvS
1NQh5aIHdowU0Aywo3VNOdDLTAaIL6Nmf+IecfcYR6Z/DrnkR/76+vh9v38LuMe4
qCCI+rq55CRzBisizIj3PcaRZRzWZrhNrM45098ZLKlpPu8D7+NY42cQRW2fD1Bo
s2zsK9OgMzID4dJqYKKUE7FzataAjbNiXafFI92X7EBf0FyNMhs8zmP/mq/Y1eou
BmWpfxBTu9vsjFSUnk30
=pf/Y
-----END PGP SIGNATURE-----

--nextPart1566239.EZr7xrxkAX--
