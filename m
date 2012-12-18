Return-Path: <hexiled@nixbits.net>
Message-ID: <50CFB476.4070207@nixbits.net>
Date: Mon, 17 Dec 2012 19:10:30 -0500
From: HeXiLeD <hexiled@nixbits.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [B.A.T.M.A.N.] Batman-Adv & iptables mac filtering
Reply-To: HeXileD@nixbits.net,
 The list for a Better Approach To Mobile Ad-hoc Networking
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

This is probably a openwrt question but even so it might have some
impact on batman-adv.

I am planing to use mac filtering through iptables on openwrt with a
default policy of deny all, allowing only by white list the clients that
will be allowed t connect.


My question to the batman team is if by applying this idea and since
batman-adv uses MACs to manage the routing; if i will have to white list
the other router MACs on the router or routers that will be filtering
MACs with iptables or batman-adv is not affected by mac filtering.

