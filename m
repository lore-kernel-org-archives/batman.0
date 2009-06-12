MIME-Version: 1.0
In-Reply-To: <200906121913.40206.lindner_marek@yahoo.de>
References: <5161afcd0906111040v1e2831ccv79c8ab6a5ca6cb58@mail.gmail.com>
	<5161afcd0906111112p2cf55955o757f87dc6f75cb41@mail.gmail.com>
	<5161afcd0906111246y446d9bc4hf145a3423ff6653e@mail.gmail.com>
	<200906121913.40206.lindner_marek@yahoo.de>
Date: Fri, 12 Jun 2009 09:21:18 -0600
Message-ID: <5161afcd0906120821w5698c18ag7b993869377e3d61@mail.gmail.com>
From: Jacob Marble <jacobmarble@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

On Fri, Jun 12, 2009 at 5:13 AM, Marek Lindner<lindner_marek@yahoo.de> wrot=
e:
> On Friday 12 June 2009 03:46:05 Jacob Marble wrote:
>> I removed the batmand-adv package, and all is well. =C2=A0This must be t=
he
>> userspace version.
>
> Yes, you should not use the kernel version and the user space version at =
the
> same time. Actually, the user space version is obsolete and has been remo=
ved
> from our SVN (http://www.open-mesh.net/changeset/1283) and from OpenWRT
> lately. It created more confusion than anything else.

Agreed.

> Great that you found your way through. We seeking to make things more obv=
ious
> - any hints ?

batman-advanced needs a howto.  I'm a pretty smart guy, but this took
me all week to figure out.  I'm still shaky and my mesh network isn't
working very well yet.  I would be willing to put together some more
detailed info for OpenWrt.

I'm sure that there are people like me who can "get it" if you just
hold their hand through getting bat0 on one node to see bat0 on
another node.  adhoc mode?  ahdemo mode?  What is the difference?
This might be a little off-topic for batman-adv but it's very
relevant.

Also, it's tedious to deal with /proc/net/batman-adv/*  It's cool in
hacky sort of way, but tedious.  Is there any way that this could be
manipulated with a script?  brctl is a nice interface, how about
bactl?  "bactl show originators"  "bactl show interfaces"  "bactl set
log_level 15"  "bactl help"  Of course, leave the /proc interface for
hard-core types. ;)

Overall, this is really great software, so I hope barriers-to-entry
can be removed.

Jake
