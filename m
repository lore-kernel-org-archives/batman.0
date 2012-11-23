Return-Path: <guido@guidoi.com.ar>
MIME-Version: 1.0
Sender: guido@guidoi.com.ar
From: Gui Iribarren <gui@altermundi.net>
Date: Fri, 23 Nov 2012 09:52:48 -0300
Message-ID: <CAHD-aqKfNck0Z4Zqw_MJYzTFN=dEVp=Xxu6SfgRSwtOeCpPXnw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [B.A.T.M.A.N.] [RFC] batman-adv boot setup scheme on OpenWRT
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

Hello Marek and folks,
chasing a race condition, I might have delved a little too deep into
openwrt boot sequence :(

AFAICU, currently there's a /etc/hotplug.d/net/99-batman-adv script
which tries to configure both bat0 , and any interfaces coming up that
might have to be included there. Problem is, hotplug.d/net scripts are
called when interface is "added" but not necessarilly brought up yet.
So there's a "sleep 3s" that works in most cases as a window for slow
hardware bring up the interface.
...in most cases :(
on an old nanoloco2, creating 2 wifi-ifaces in ap mode and 1 in ibss
mode, managed with batman-adv, the sleep 3s is not enough. A 6s
timeout works around it, but maybe there's a better solution?

I've divided the script, putting the "add candidate interfaces to
bat0" into /etc/hotplug.d/*iface*/99-batman-adv , which gets called
precisely after an interface is actually brought up.

This works as expected, and i could even eliminate the original 3s sleep.

hotplug.d/iface script adds candidate interfaces to batX after they
are brought up
hotplug.d/net script configures batX as they appear,

Would that work in general? Or was the single hotplug.d/net
implemented that way, for a reason i'm missing?

Thanks!

Gui
