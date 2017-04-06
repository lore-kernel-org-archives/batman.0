Return-Path: <xbing6@gmail.com>
From: Xuebing Wang <xbing6@gmail.com>
Message-ID: <9309484e-a9c2-0476-3ddf-a2d68a51c58e@gmail.com>
Date: Thu, 6 Apr 2017 10:32:29 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [B.A.T.M.A.N.] [batman-adv] Does batman-adv works perfectly?
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

Hi community,

We have batman-adv working on OpenWRT Chaos Calmer.
- Atheros ar9331 MIPS platform + built-in ath9k WiFi
- batman-adv version 2016.1
- routing_algos = BATMAN_IV
- Wireless interface MTU = 1532, adhoc network encryption "psk2-ccmp"
- bat0 interface MTU = 1500

We have batman-adv running on 10+ sites. For each site, there are 10-20 
nodes in the mesh network.

batman-adv runs almost perfectly (*almost*). Occasionally (occurrence 
rate is low), node drops off the batman-adv / adhoc mesh.
- Sometimes, node can recover (re-joins the mesh network automatically), 
but not always.

Any suggestions? Does batman-adv works perfectly in the field (i.e. 
running for 1 year with 100+ nodes without any issues)?

What about I use one node as Master, and other nodes ping this Master 
every 10s (or 30 seconds) (to keep mesh from inactivity)? Does this help?

Thanks.
Xuebing Wang

