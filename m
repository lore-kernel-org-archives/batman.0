Return-Path: <joe@perches.com>
From: Joe Perches <joe@perches.com>
In-Reply-To: <201006160037.48573.sven.eckelmann@gmx.de>
References: <1275498615.23599.12.camel@Joe-Laptop.home>
	<1275509466.23599.43.camel@Joe-Laptop.home>
	<201006160023.04296.sven.eckelmann@gmx.de>
	<201006160037.48573.sven.eckelmann@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 15 Jun 2010 15:58:17 -0700
Message-ID: <1276642697.1586.151.camel@Joe-Laptop.home>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] [PATCH] drivers/staging/batman-adv: Use
 (pr|netdev)_<level> macro helpers
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
To: Sven Eckelmann <sven.eckelmann@gmx.de>, netdev <netdev@vger.kernel.org>
Cc: devel <devel@driverdev.osuosl.org>, Greg Kroah-Hartman <gregkh@suse.de>, b.a.t.m.a.n@lists.open-mesh.net, b.a.t.m.a.n@lists.open-mesh.org, linux-kernel@vger.kernel.org, Simon Wunderlich <siwu@hrz.tu-chemnitz.de>, Marek Lindner <lindner_marek@yahoo.de>

On Wed, 2010-06-16 at 00:37 +0200, Sven Eckelmann wrote:
> Sven Eckelmann wrote:

Hi Sven.

> > The problem seems to be that dev_printk is used by netdev_printk (which is
> > used by netdev_info). netdev_printk will add (netdev)->dev.parent as second
> > parameter of dev_printk (and parent is NULL in our case). This macro will
> > now call dev_driver_string with NULL as parameter and just dereference
> > this null pointer.
> > 
> > Maybe it is related to something else, but at least I think that this could
> > be the cause of the crash.

Nope, I think that's exactly correct.

> As far as I understand, the netdev_* stuff is made to be used by real drivers 
> with more or less physical hardware. batman-adv is a virtual bridge used for 
> mesh networks. Like net/bridge/ it has no physical parent device and only 
> other net_devices are used inside of it - which may have real physical network 
> devices as parents.

> Please correct me if my assumption is wrong.

No correction necessary...

netdev_printk and netdev_<level> are meant to be used
with parented network devices.

I think that netdev_<level> will eventually do the right
thing when dev->dev.parent is NULL.  Right now, that'd
be a bit of an expensive test as it would be expanded in
place for every use of the macro.

Right now it's:

#define netdev_printk(level, netdev, format, args...)		\
	dev_printk(level, (netdev)->dev.parent,			\
		   "%s: " format,				\
		   netdev_name(netdev), ##args)

It could be something like:

#define netdev_printk(level, netdev, format, args...)		\
do {								\
	if ((netdev)->dev.parent)				\
		dev_printk(level, (netdev)->dev.parent, 	\
			   "%s: " format, 			\
			   netdev_name(netdev), ##args);	\
	else							\
		printk(level "%s: " format,			\
			netdev_name(netdev), ##args);		\
} while (0)

Unfortunately, that just about doubles the format string space,
so I don't really want to do that.

If/when %pV is accepted,

http://lkml.org/lkml/2010/3/4/17
http://lkml.org/lkml/2010/3/4/18

then the netdev_<level> macros will be converted to functions,
so size reduced with an added test for dev.parent == NULL without
the need to double the string space.


