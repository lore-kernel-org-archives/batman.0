From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sat, 13 Jun 2009 00:59:52 +0800
References: <5161afcd0906111040v1e2831ccv79c8ab6a5ca6cb58@mail.gmail.com>
	<200906121913.40206.lindner_marek@yahoo.de>
	<5161afcd0906120821w5698c18ag7b993869377e3d61@mail.gmail.com>
In-Reply-To: <5161afcd0906120821w5698c18ag7b993869377e3d61@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200906130059.52978.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] batman advanced in openwrt
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>

On Friday 12 June 2009 23:21:18 Jacob Marble wrote:
> batman-advanced needs a howto.  I'm a pretty smart guy, but this took
> me all week to figure out.  I'm still shaky and my mesh network isn't
> working very well yet.  I would be willing to put together some more
> detailed info for OpenWrt.

It would be great if you would write something. We can either publish it on 
open-mesh.net or link to your site. Christoph Pilka started writing a howto 
(in German) but the link it not accessable anymore 
(http://debian.asconix.com/batman-advanced-openwrt-howto).


> Also, it's tedious to deal with /proc/net/batman-adv/*  It's cool in
> hacky sort of way, but tedious.  Is there any way that this could be
> manipulated with a script?  brctl is a nice interface, how about
> bactl?  "bactl show originators"  "bactl show interfaces"  "bactl set
> log_level 15"  "bactl help"  Of course, leave the /proc interface for
> hard-core types. ;)

The idea sounds interesting. We could integrate these feature into the 
battools in order to not create another tool. What do you think ?

Regards,
Marek

