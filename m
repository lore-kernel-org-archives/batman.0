Return-Path: <nikanas@gmail.com>
MIME-Version: 1.0
Date: Thu, 21 Jul 2011 11:33:55 +0800
Message-ID: <CA+qXHzNUGtLUpFqOmvKge05wLYyyoCpkTJG4HKwkd+Zzv81hYQ@mail.gmail.com>
From: "Nik M. Anas Kamarudin" <nikanas@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [B.A.T.M.A.N.] Filtering BATMAN-ADV packet
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
To: b.a.t.m.a.n@lists.open-mesh.org

Hello all,

I need some help with batmand-adv packet filtering on wireless interface.
I successfully filter batman-adv packet using ebtables. This what i do:

/usr/sbin/brctl addbr br0
/usr/sbin/brctl addif br0 eth0
/sbin/ifconfig br0 up
/sbin/ifconfig eth0 192.168.5.2 up

then wait around 15 ~ 30 second.

/sbin/modprobe /lib/modules/`2.6.35.13/batman-adv/batman-adv.ko
/usr/sbin/batctl if add br0
/sbin/ifconfig bat0 192.168.5.41 up
/sbin/ifconfig br0 192.168.5.1 up

and filter up the batman-adv packet using etables like this:
`/usr/sbin/ebtables -A INPUT -s AA:AA:AA:AA:AA -j DROP`

BUT, this only work for Ethernet interface/ wire.. i need to do this
same thing using wireless interface. Anyone got any ideas?
