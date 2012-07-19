Return-Path: <gbastien@versatic.net>
MIME-version: 1.0
Content-type: multipart/mixed; boundary="Boundary_(ID_BzHRvSgXfbFrmJRBewhA7g)"
Message-id: <50076056.4050907@versatic.net>
Date: Wed, 18 Jul 2012 21:18:14 -0400
From: =?ISO-8859-1?Q?Genevi=E8ve_Bastien?= <gbastien@versatic.net>
Subject: [B.A.T.M.A.N.] Internet gateway or not: dhcp or static ip?
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

This is a multi-part message in MIME format.

--Boundary_(ID_BzHRvSgXfbFrmJRBewhA7g)
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
Content-Transfer-Encoding: quoted-printable

Hi!

I had a chat the other day on IRC about how to assign ip addresses=20
whether there is an internet gateway available or not.

Here is the problem and the solution I came up with.  Let me know if=20
that makes sense or if I'm complicating my life.

* Problem *

Our network is still small, there may or may not be an internet gateway=20
available on it, it doesn't matter.  From what I read here=20
http://www.open-mesh.org/projects/batman-adv/wiki/Gateways for nodes to=20
have access to the internet, the internet gateway has to be a dhcp server.

The node requests an ip by dhcp and then knows what the default route=20
is.  But if the gateway disappears, there is no more dhcp server, the=20
nodes do not have ip addresses and the mesh network is about useless.

But if I set nodes with static ips, then the mesh is routable all the=20
time, but nodes do not know the default route to reach the internet.

Am I right so far?

* Solution *

Someone on irc pointed me out to this page:=20
http://www.open-mesh.org/projects/batman-adv/wiki/Uevent
I use this uevent to send a dhcp request if a gateway becomes available=20
or go back to a static ip if all gateways are gone.

Attached is the hotplug script I use.  It is in=20
/etc/hotplug.d/net/99-batman-adv-gw.  It supposes the interface is=20
configured by default with a static ip.

It works perfectly, but I can't believe there is no simpler solution to=20
this.  Our problem should be a quite common one.  What is the general=20
solution to it?

Thanks,
Genevi=E8ve

--Boundary_(ID_BzHRvSgXfbFrmJRBewhA7g)
Content-type: text/plain; CHARSET=US-ASCII; name=99-batman-adv-gw
Content-transfer-encoding: 7BIT
Content-disposition: attachment; filename=99-batman-adv-gw

#!/bin/sh

# This is the interface as mentioned in the /etc/config/network file
IMESH="lan"

# This is the interface on which to ask for dhcp.  May not be same as previous if interface is a bridge, like br-lan
IDHCP="br-lan"

hostname=$(uci get system.@system[0].hostname)

case "$ACTION" in
	change)
		if [ "$BATTYPE" == "gw" ]; then
			case "$BATACTION" in
				add)
					logger "Now has a gateway available.  Will request dhcp."
					udhcpc -i $IDHCP -h $hostname
					;;
				del)
					logger "No more gateway available.  Will go back to static ip."
					ifdown $IMESH
					ifup $IMESH
					;;
				change)
					logger "New default gateway.  Will request dhcp"
					udhcpc -i $IDHCP -h $hostname
					;;
			esac
		fi
		;;
esac


--Boundary_(ID_BzHRvSgXfbFrmJRBewhA7g)--
