Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 24 Mar 2015 12:47:27 +0100
Message-ID: <12859573.VW3gFST3da@bentobox>
In-Reply-To: <20150324114107.GD28604@pengutronix.de>
References: <1419594103-10928-1-git-send-email-mpa@pengutronix.de>
 <2376189.i7svKM7Q39@sven-edge> <20150324114107.GD28604@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3321001.05AYDb0IhV";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 00/26] batman-adv: Cleanups
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
To: Markus Pargmann <mpa@pengutronix.de>
Cc: b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <mareklindner@neomailbox.ch>, Antonio Quartulli <antonio@meshcoding.com>


--nextPart3321001.05AYDb0IhV
Content-Type: multipart/mixed; boundary="nextPart1757407.5OSSQHo2tk"
Content-Transfer-Encoding: quoted-printable

This is a multi-part message in MIME format.

=2D-nextPart1757407.5OSSQHo2tk
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday 24 March 2015 12:41:07 Markus Pargmann wrote:
> Hi Sven,
> 
> On Sun, Mar 22, 2015 at 02:34:33AM +0100, Sven Eckelmann wrote:
> > On Sunday 22 March 2015 01:52:40 Sven Eckelmann wrote:
> > > On Friday 26 December 2014 12:41:17 Markus Pargmann wrote:
> > > > Markus Pargmann (26):
> > > [...]
> > > 
> > > >   batman-adv: packet.h, add some missing includes
> > > >   batman-adv: types.h, add missing include
> > > 
> > > Just went through the includes and noticed that a lot more are missing
> > > (also in the files which you are already touched). I have attached the
> > > current state of my analysis so you can compare it with your notes.
> 
> Do you have any tool which makes this include analysis easier?

I've started to test iwyu but the output cannot really be trusted. But at 
least it can help to spot things.

make -k CC="iwyu -Xiwyu --no_default_mappings  -Xiwyu --verbose=1 -Xiwyu --
mapping_file=$HOME/kernel_mappings.iwyu" CONFIG_BATMAN_ADV_NC=y 
CONFIG_BATMAN_ADV_DEBUG=y

The header files are for example also not all analyzed. So you have to fiddle 
around with them too.

Kind regards,
	Sven
=2D-nextPart1757407.5OSSQHo2tk
Content-Disposition: attachment; filename="kernel_mappings.iwyu"
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"; name="kernel_mappings.iwyu"

[
{ include: ["\"linux/compiler-gcc.h\"", "private", "<linux/compiler.h>", "public"] },
{ include: ["\"asm/atomic.h\"", "private", "<linux/atomic.h>", "public"] },
{ include: ["\"asm/bitops.h\"", "private", "<linux/bitops.h>", "public"] },
{ include: ["\"asm/cache.h\"", "private", "<linux/cache.h>", "public"] },
{ include: ["\"asm-generic/bug.h\"", "private", "<linux/bug.h>", "public"] },
{ include: ["\"asm-generic/errno-base.h\"", "private", "<linux/errno.h>", "public"] },
{ include: ["\"asm-generic/errno.h\"", "private", "<linux/errno.h>", "public"] },
{ include: ["\"asm-generic/fcntl.h\"", "private", "<linux/fcntl.h>", "public"] },
{ include: ["\"asm-generic/int-ll64.h\"", "private", "<linux/types.h>", "public"] },
{ include: ["\"asm-generic/poll.h\"", "private", "<linux/poll.h>", "public"] },
{ include: ["\"asm/percpu.h\"", "private", "<linux/percpu.h>", "public"] },
{ include: ["\"asm/string_64.h\"", "private", "<linux/string.h>", "public"] },
{ include: ["\"asm/uaccess.h\"", "private", "<linux/uaccess.h>", "public"] },
{ include: ["\"linux/atomic.h\"", "private", "<linux/atomic.h>", "public"] },
{ include: ["\"linux/bitmap.h\"", "private", "<linux/bitmap.h>", "public"] },
{ include: ["\"linux/bitops.h\"", "private", "<linux/bitops.h>", "public"] },
{ include: ["\"linux/bug.h\"", "private", "<linux/bug.h>", "public"] },
{ include: ["\"linux/byteorder/generic.h\"", "private", "<linux/byteorder/generic.h>", "public"] },
{ include: ["\"linux/compiler.h\"", "private", "<linux/compiler.h>", "public"] },
{ include: ["\"linux/cpumask.h\"", "private", "<linux/cpumask.h>", "public"] },
{ include: ["\"linux/device.h\"", "private", "<linux/device.h>", "public"] },
{ include: ["\"linux/err.h\"", "private", "<linux/device.h>", "public"] },
{ include: ["\"linux/etherdevice.h\"", "private", "<linux/etherdevice.h>", "public"] },
{ include: ["\"linux/ethtool.h\"", "private", "<linux/ethtool.h>", "public"] },
{ include: ["\"linux/export.h\"", "private", "<linux/export.h>", "public"] },
{ include: ["\"linux/fs.h\"", "private", "<linux/fs.h>", "public"] },
{ include: ["\"linux/gfp.h\"", "private", "<linux/fs.h>", "public"] },
{ include: ["\"linux/if_arp.h\"", "private", "<linux/if_arp.h>", "public"] },
{ include: ["\"linux/if_ether.h\"", "private", "<linux/if_ether.h>", "public"] },
{ include: ["\"linux/if.h\"", "private", "<linux/if.h>", "public"] },
{ include: ["\"linux/if_packet.h\"", "private", "<linux/if_packet.h>", "public"] },
{ include: ["\"linux/if_vlan.h\"", "private", "<linux/if_vlan.h>", "public"] },
{ include: ["\"linux/in6.h\"", "private", "<linux/in6.h>", "public"] },
{ include: ["\"linux/in.h\"", "private", "<linux/in.h>", "public"] },
{ include: ["\"linux/init.h\"", "private", "<linux/init.h>", "public"] },
{ include: ["\"linux/ip.h\"", "private", "<linux/ip.h>", "public"] },
{ include: ["\"linux/ipv6.h\"", "private", "<linux/ipv6.h>", "public"] },
{ include: ["\"linux/jhash.h\"", "private", "<linux/jhash.h>", "public"] },
{ include: ["\"linux/jiffies.h\"", "private", "<linux/jiffies.h>", "public"] },
{ include: ["\"linux/kconfig.h\"", "private", "<linux/kconfig.h>", "public"] },
{ include: ["\"linux/kernel.h\"", "private", "<linux/kernel.h>", "public"] },
{ include: ["\"linux/kern_levels.h\"", "private", "<linux/printk.h>", "public"] },
{ include: ["\"linux/kobject.h\"", "private", "<linux/printk.h>", "public"] },
{ include: ["\"linux/list.h\"", "private", "<linux/list.h>", "public"] },
{ include: ["\"linux/lockdep.h\"", "private", "<linux/lockdep.h>", "public"] },
{ include: ["\"linux/module.h\"", "private", "<linux/module.h>", "public"] },
{ include: ["\"linux/moduleparam.h\"", "private", "<linux/moduleparam.h>", "public"] },
{ include: ["\"linux/netdev_features.h\"", "private", "<linux/netdevice.h>", "public"] },
{ include: ["\"linux/netdevice.h\"", "private", "<linux/netdevice.h>", "public"] },
{ include: ["\"linux/net.h\"", "private", "<linux/netdevice.h>", "public"] },
{ include: ["\"linux/notifier.h\"", "private", "<linux/notifier.h>", "public"] },
{ include: ["\"linux/percpu.h\"", "private", "<linux/percpu.h>", "public"] },
{ include: ["\"linux/pkt_sched.h\"", "private", "<linux/pkt_sched.h>", "public"] },
{ include: ["\"linux/poll.h\"", "private", "<linux/poll.h>", "public"] },
{ include: ["\"linux/printk.h\"", "private", "<linux/printk.h>", "public"] },
{ include: ["\"linux/random.h\"", "private", "<linux/random.h>", "public"] },
{ include: ["\"linux/rculist.h\"", "private", "<linux/rculist.h>", "public"] },
{ include: ["\"linux/rcupdate.h\"", "private", "<linux/rcupdate.h>", "public"] },
{ include: ["\"linux/rcutree.h\"", "private", "<linux/rcupdate.h>", "public"] },
{ include: ["\"linux/rtnetlink.h\"", "private", "<linux/rtnetlink.h>", "public"] },
{ include: ["\"linux/seq_file.h\"", "private", "<linux/seq_file.h>", "public"] },
{ include: ["\"linux/skbuff.h\"", "private", "<linux/skbuff.h>", "public"] },
{ include: ["\"linux/slab.h\"", "private", "<linux/slab.h>", "public"] },
{ include: ["\"linux/socket.h\"", "private", "<linux/socket.h>", "public"] },
{ include: ["\"linux/spinlock.h\"", "private", "<linux/spinlock.h>", "public"] },
{ include: ["\"linux/spinlock_types.h\"", "private", "<linux/spinlock.h>", "public"] },
{ include: ["\"linux/stat.h\"", "private", "<linux/stat.h>", "public"] },
{ include: ["\"linux/stddef.h\"", "private", "<linux/stddef.h>", "public"] },
{ include: ["\"linux/string.h\"", "private", "<linux/string.h>", "public"] },
{ include: ["\"linux/stringify.h\"", "private", "<linux/stringify.h>", "public"] },
{ include: ["\"linux/sysfs.h\"", "private", "<linux/sysfs.h>", "public"] },
{ include: ["\"linux/types.h\"", "private", "<linux/types.h>", "public"] },
{ include: ["\"linux/udp.h\"", "private", "<linux/udp.h>", "public"] },
{ include: ["\"linux/wait.h\"", "private", "<linux/wait.h>", "public"] },
{ include: ["\"linux/workqueue.h\"", "private", "<linux/workqueue.h>", "public"] },
{ include: ["\"net/addrconf.h\"", "private", "<net/addrconf.h>", "public"] },
{ include: ["\"net/ipv6.h\"", "private", "<net/ipv6.h>", "public"] },
{ include: ["\"net/net_namespace.h\"", "private", "<net/net_namespace.h>", "public"] },
{ include: ["\"net/rtnetlink.h\"", "private", "<net/rtnetlink.h>", "public"] },
]
=2D-nextPart1757407.5OSSQHo2tk--
This is a multi-part message in MIME format.

--nextPart1757407.5OSSQHo2tk
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday 24 March 2015 12:41:07 Markus Pargmann wrote:
> Hi Sven,
> 
> On Sun, Mar 22, 2015 at 02:34:33AM +0100, Sven Eckelmann wrote:
> > On Sunday 22 March 2015 01:52:40 Sven Eckelmann wrote:
> > > On Friday 26 December 2014 12:41:17 Markus Pargmann wrote:
> > > > Markus Pargmann (26):
> > > [...]
> > > 
> > > >   batman-adv: packet.h, add some missing includes
> > > >   batman-adv: types.h, add missing include
> > > 
> > > Just went through the includes and noticed that a lot more are missing
> > > (also in the files which you are already touched). I have attached the
> > > current state of my analysis so you can compare it with your notes.
> 
> Do you have any tool which makes this include analysis easier?

I've started to test iwyu but the output cannot really be trusted. But at 
least it can help to spot things.

make -k CC="iwyu -Xiwyu --no_default_mappings  -Xiwyu --verbose=1 -Xiwyu --
mapping_file=$HOME/kernel_mappings.iwyu" CONFIG_BATMAN_ADV_NC=y 
CONFIG_BATMAN_ADV_DEBUG=y

The header files are for example also not all analyzed. So you have to fiddle 
around with them too.

Kind regards,
	Sven
--nextPart1757407.5OSSQHo2tk
Content-Disposition: attachment; filename="kernel_mappings.iwyu"
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"; name="kernel_mappings.iwyu"

[
{ include: ["\"linux/compiler-gcc.h\"", "private", "<linux/compiler.h>", "public"] },
{ include: ["\"asm/atomic.h\"", "private", "<linux/atomic.h>", "public"] },
{ include: ["\"asm/bitops.h\"", "private", "<linux/bitops.h>", "public"] },
{ include: ["\"asm/cache.h\"", "private", "<linux/cache.h>", "public"] },
{ include: ["\"asm-generic/bug.h\"", "private", "<linux/bug.h>", "public"] },
{ include: ["\"asm-generic/errno-base.h\"", "private", "<linux/errno.h>", "public"] },
{ include: ["\"asm-generic/errno.h\"", "private", "<linux/errno.h>", "public"] },
{ include: ["\"asm-generic/fcntl.h\"", "private", "<linux/fcntl.h>", "public"] },
{ include: ["\"asm-generic/int-ll64.h\"", "private", "<linux/types.h>", "public"] },
{ include: ["\"asm-generic/poll.h\"", "private", "<linux/poll.h>", "public"] },
{ include: ["\"asm/percpu.h\"", "private", "<linux/percpu.h>", "public"] },
{ include: ["\"asm/string_64.h\"", "private", "<linux/string.h>", "public"] },
{ include: ["\"asm/uaccess.h\"", "private", "<linux/uaccess.h>", "public"] },
{ include: ["\"linux/atomic.h\"", "private", "<linux/atomic.h>", "public"] },
{ include: ["\"linux/bitmap.h\"", "private", "<linux/bitmap.h>", "public"] },
{ include: ["\"linux/bitops.h\"", "private", "<linux/bitops.h>", "public"] },
{ include: ["\"linux/bug.h\"", "private", "<linux/bug.h>", "public"] },
{ include: ["\"linux/byteorder/generic.h\"", "private", "<linux/byteorder/generic.h>", "public"] },
{ include: ["\"linux/compiler.h\"", "private", "<linux/compiler.h>", "public"] },
{ include: ["\"linux/cpumask.h\"", "private", "<linux/cpumask.h>", "public"] },
{ include: ["\"linux/device.h\"", "private", "<linux/device.h>", "public"] },
{ include: ["\"linux/err.h\"", "private", "<linux/device.h>", "public"] },
{ include: ["\"linux/etherdevice.h\"", "private", "<linux/etherdevice.h>", "public"] },
{ include: ["\"linux/ethtool.h\"", "private", "<linux/ethtool.h>", "public"] },
{ include: ["\"linux/export.h\"", "private", "<linux/export.h>", "public"] },
{ include: ["\"linux/fs.h\"", "private", "<linux/fs.h>", "public"] },
{ include: ["\"linux/gfp.h\"", "private", "<linux/fs.h>", "public"] },
{ include: ["\"linux/if_arp.h\"", "private", "<linux/if_arp.h>", "public"] },
{ include: ["\"linux/if_ether.h\"", "private", "<linux/if_ether.h>", "public"] },
{ include: ["\"linux/if.h\"", "private", "<linux/if.h>", "public"] },
{ include: ["\"linux/if_packet.h\"", "private", "<linux/if_packet.h>", "public"] },
{ include: ["\"linux/if_vlan.h\"", "private", "<linux/if_vlan.h>", "public"] },
{ include: ["\"linux/in6.h\"", "private", "<linux/in6.h>", "public"] },
{ include: ["\"linux/in.h\"", "private", "<linux/in.h>", "public"] },
{ include: ["\"linux/init.h\"", "private", "<linux/init.h>", "public"] },
{ include: ["\"linux/ip.h\"", "private", "<linux/ip.h>", "public"] },
{ include: ["\"linux/ipv6.h\"", "private", "<linux/ipv6.h>", "public"] },
{ include: ["\"linux/jhash.h\"", "private", "<linux/jhash.h>", "public"] },
{ include: ["\"linux/jiffies.h\"", "private", "<linux/jiffies.h>", "public"] },
{ include: ["\"linux/kconfig.h\"", "private", "<linux/kconfig.h>", "public"] },
{ include: ["\"linux/kernel.h\"", "private", "<linux/kernel.h>", "public"] },
{ include: ["\"linux/kern_levels.h\"", "private", "<linux/printk.h>", "public"] },
{ include: ["\"linux/kobject.h\"", "private", "<linux/printk.h>", "public"] },
{ include: ["\"linux/list.h\"", "private", "<linux/list.h>", "public"] },
{ include: ["\"linux/lockdep.h\"", "private", "<linux/lockdep.h>", "public"] },
{ include: ["\"linux/module.h\"", "private", "<linux/module.h>", "public"] },
{ include: ["\"linux/moduleparam.h\"", "private", "<linux/moduleparam.h>", "public"] },
{ include: ["\"linux/netdev_features.h\"", "private", "<linux/netdevice.h>", "public"] },
{ include: ["\"linux/netdevice.h\"", "private", "<linux/netdevice.h>", "public"] },
{ include: ["\"linux/net.h\"", "private", "<linux/netdevice.h>", "public"] },
{ include: ["\"linux/notifier.h\"", "private", "<linux/notifier.h>", "public"] },
{ include: ["\"linux/percpu.h\"", "private", "<linux/percpu.h>", "public"] },
{ include: ["\"linux/pkt_sched.h\"", "private", "<linux/pkt_sched.h>", "public"] },
{ include: ["\"linux/poll.h\"", "private", "<linux/poll.h>", "public"] },
{ include: ["\"linux/printk.h\"", "private", "<linux/printk.h>", "public"] },
{ include: ["\"linux/random.h\"", "private", "<linux/random.h>", "public"] },
{ include: ["\"linux/rculist.h\"", "private", "<linux/rculist.h>", "public"] },
{ include: ["\"linux/rcupdate.h\"", "private", "<linux/rcupdate.h>", "public"] },
{ include: ["\"linux/rcutree.h\"", "private", "<linux/rcupdate.h>", "public"] },
{ include: ["\"linux/rtnetlink.h\"", "private", "<linux/rtnetlink.h>", "public"] },
{ include: ["\"linux/seq_file.h\"", "private", "<linux/seq_file.h>", "public"] },
{ include: ["\"linux/skbuff.h\"", "private", "<linux/skbuff.h>", "public"] },
{ include: ["\"linux/slab.h\"", "private", "<linux/slab.h>", "public"] },
{ include: ["\"linux/socket.h\"", "private", "<linux/socket.h>", "public"] },
{ include: ["\"linux/spinlock.h\"", "private", "<linux/spinlock.h>", "public"] },
{ include: ["\"linux/spinlock_types.h\"", "private", "<linux/spinlock.h>", "public"] },
{ include: ["\"linux/stat.h\"", "private", "<linux/stat.h>", "public"] },
{ include: ["\"linux/stddef.h\"", "private", "<linux/stddef.h>", "public"] },
{ include: ["\"linux/string.h\"", "private", "<linux/string.h>", "public"] },
{ include: ["\"linux/stringify.h\"", "private", "<linux/stringify.h>", "public"] },
{ include: ["\"linux/sysfs.h\"", "private", "<linux/sysfs.h>", "public"] },
{ include: ["\"linux/types.h\"", "private", "<linux/types.h>", "public"] },
{ include: ["\"linux/udp.h\"", "private", "<linux/udp.h>", "public"] },
{ include: ["\"linux/wait.h\"", "private", "<linux/wait.h>", "public"] },
{ include: ["\"linux/workqueue.h\"", "private", "<linux/workqueue.h>", "public"] },
{ include: ["\"net/addrconf.h\"", "private", "<net/addrconf.h>", "public"] },
{ include: ["\"net/ipv6.h\"", "private", "<net/ipv6.h>", "public"] },
{ include: ["\"net/net_namespace.h\"", "private", "<net/net_namespace.h>", "public"] },
{ include: ["\"net/rtnetlink.h\"", "private", "<net/rtnetlink.h>", "public"] },
]
--nextPart1757407.5OSSQHo2tk--

--nextPart3321001.05AYDb0IhV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJVEU7PAAoJEF2HCgfBJntGPe4P/jvNOz1OAw4vsf7U/RjspMNV
MRc+jZB7/fpZTICM8bfSfCVedlPjsevr84CiufLKpBxnldSH+OWBZ+dcxObqzrjP
Lgh9dj8tREUSoF83v2rFqha+PzWoucKzs6B9fctM9KcZ0n2ak/WG0hw05QPs9a9q
oS1lu90LCNVCN6EIaLb/PWRQ9hCSdh8JOPIcE4EHHQ678ZRZlfbk8KCowtgjWkCr
l/jXWjidefhT97G1uxympR/Grz+U4kGke+kPbIzz4O6eXZSkBU2foP6HDCOmu17W
CE7a+7wumu2TZGN/JcQcyv899RsqMAvFxawlj67Mlm4gQuWUmEPgOHLcLfihHCjI
TqWiRwcWd39Oep7EODS9HFxh3T+1tFz++YiP2jojOnlQ9iDhXkuVJxPweqMERDJc
U3zvn3DqyWHAO3qKq1gCOSyXF6h/lTuyGa6Nfiub5W79KSgB34OIdIMNa28QZ3xe
2CNKp+M9bATIvThCfVRsv9qxlsqCKjG4JadGGshApQJ9UhGNvhAYytTifrY0efP1
nWiYBxw5ulEV4Hg3ffwlXx0fDDqi1mdX+Nk5aFr2/RRSNVDq8YiD0UHSOM9CQMOw
1i4G9vrUFn2mA4/eJZLTcW4LddI/38hzol7s2lJ6nGbXvOQZvr5QEm9jlUeycC/3
o2ZfZwbzo+FjgOxy1EON
=4Dpm
-----END PGP SIGNATURE-----

--nextPart3321001.05AYDb0IhV--

