Return-Path: <linus.luessing@c0d3.blue>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Date: Fri, 21 Dec 2018 16:15:07 +0100
Message-Id: <20181221151511.14923-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH net-next 0/4] bridge: implement Multicast
 Router Discovery (RFC4286)
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Roopa Prabhu <roopa@cumulusnetworks.com>, Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, "David S . Miller" <davem@davemloft.net>, bridge@lists.linux-foundation.org, b.a.t.m.a.n@lists.open-mesh.org, linux-kernel@vger.kernel.org

Hi,

This patchset adds initial Multicast Router Discovery support to
the Linux bridge (RFC4286). With MRD it is possible to detect multicast
routers and mark bridge ports and forward multicast packets to such routers
accordingly.

So far, multicast routers are detected via IGMP/MLD queries and PIM
messages in the Linux bridge. As there is only one active, selected
querier at a time RFC4541 ("Considerations for Internet Group Management
Protocol (IGMP) and Multicast Listener Discovery (MLD) Snooping
Switches") section 2.1.1.a) recommends snooping Multicast Router
Advertisements as provided by MRD (RFC4286).


The first two patches are refactoring some existing code which is reused
for parsing the Multicast Router Advertisements later in the fourth
patch. The third patch lets the bridge join the all-snoopers multicast
address to be able to reliably receive the Multicast Router
Advertisements.


What is not implemented yet from RFC4286 yet:

* Sending Multicast Router Solicitations:
  -> RFC4286: "[...] may be sent when [...] an interface is
     (re-)initialized [or] MRD is enabled"
* Snooping Multicast Router Terminations:
  -> currently this only relies on our own timeouts
* Adjusting timeouts with the values provided in the announcements


Regards, Linus



