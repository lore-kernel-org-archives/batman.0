MIME-Version: 1.0
Date: Thu, 11 Jun 2009 11:40:11 -0600
Message-ID: <5161afcd0906111040v1e2831ccv79c8ab6a5ca6cb58@mail.gmail.com>
From: Jacob Marble <jacobmarble@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [B.A.T.M.A.N.] batman advanced in openwrt
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
To: b.a.t.m.a.n@open-mesh.net

Hello all-

I am attempting to use batman-adv in openwrt 8.09.1 on three Ubiquiti
NanoStation2.  This is just a test environment.  For now, my goal is
to have:

node 1:
eth0 -> 10.0.0.1/24
ath0 -> bat0 -> 10.0.1.1/24

node 2:
eth0 -> 10.0.0.2/24
ath0 -> bat0 -> 10.0.1.2/24

node 3:
eth0 -> 10.0.0.3/24
ath0 -> bat0 -> 10.0.1.3/24

So far, I have an adhoc network on ath0, and I have installed
batmand-adv, battool, and kmod-batman-advanced.  Do I need
badmand-adv?  Is this the old userspace batman-adv implementation?

- "lsmod" shows that a module batman-adv is loaded, and the directory
/proc/net/batman-adv/ looks right.
- "cat /proc/net/batman-adv/interfaces" shows nothing.
- "ifconfig" does *not* list an interface called bat0.
- "cat ath0 > /proc/net/batman-adv/interfaces" doesn't complain.
- "cat /proc/net/batman-adv/interfaces" *still* shows nothing.

I have no bat0 interface.  Rebooting doesn't help.  At first, I only
installed kmod-batman-advanced.  When that didn't work, I installed
batmand-adv and battool.  Still nothing.

Any ideas?  TIA,

Jake
