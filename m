Return-Path: <sophana78@gmail.com>
MIME-Version: 1.0
Date: Sun, 14 Oct 2012 22:36:09 +0200
Message-ID: <CADP5dB6JgRxvUK_3OzC8E9tpBXxwzPPC5uh31QDpEjozEdf7_w@mail.gmail.com>
From: Sophana K <sophana78@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [B.A.T.M.A.N.] How to detect gateway mode in openwrt?
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
To: b.a.t.m.a.n@lists.open-mesh.org

Hi

I'm trying batman-adv on openwrt on tp-link hardware. Some month ago,
there were some bugs in the ar71xx adhoc mode which now seem resolved.
I could setup a 2 node mesh test with batman-adv quite easily.
One node is a gateway, the other is a repeater.
The gateway has coova-chilli and 2 networks exported with batman-adv:
the private and the public network.
Both networks are bridged to batman-adv vlans, ethernet ports and wifi ssids.
The repeater doesn't have coova-chilli, but bridge both networks to
the wifi ssid and ethernet ports.
But I would like to automate deployment with a single firmware, and
need to auto-detect if the internet come from the WAN port or not.

The problem is that if I bridge the wan port, I can't use
hotplug.d/iface feature because the whole bridge is declared up wether
or not the internet port is connected.

Should I unconfigure the bridges first, then detect if internet works,
then connect the bridge to batman?

Anyone have an idea on how I could do this?

Thanks
