Return-Path: <xbing6@gmail.com>
Reply-To: xbing6@gmail.com
From: Xuebing Wang <xbing6@gmail.com>
Subject: Any suggestions about configuring batman-adv gateways + modems
Message-ID: <4aaa0e89-d428-a7c9-ef47-67dfef8e1411@gmail.com>
Date: Fri, 8 Nov 2019 18:51:14 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org, Simon Wunderlich <sw@simonwunderlich.de>, Sven Eckelmann <sven@narfation.org>

Hi batman-adv community,

We have been building openwrt 15.05 + batman-adv mesh network for over 2 
years, they work great.

We are planning to use batman-adv gateways + 4G modems. For an example: 
our mesh network is with 20 nodes, 3 nodes have 4G modems connected.

1) My first thought is to use batman-adv gateway (with 4G modem 
connected) as dhcp server, and forward batman-adv interface to wan 
interface (modem).
1.1)  But, there is an issue with this setup. Once a modem is down, 
nodes that are connected to this batman-adv gateway (with modem) can not 
automatically "roam" to another batman-adv gateway (with good modem 
connection).
1.2)  This behavior is expected, right?

2) My second thought is to bridge batman-adv interface and wan interface 
(modem). This works great, I do not see issue (1.1) above.
-  By this setup, all batman-adv clients get ip via dhcp and via modem.
2.1)  Is this the suggested setup to use batman-adv gateways?

3) When I bridge batman-adv interface with other interface (as in step 2 
above), can I use batman-adv interface via *ipv6* to ping other 
batman-adv nodes?

Thanks.
Xuebing Wang

