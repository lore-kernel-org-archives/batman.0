Return-Path: <tjhowse@gmail.com>
MIME-Version: 1.0
From: tjhowse <tjhowse@gmail.com>
Date: Mon, 17 Feb 2014 08:56:05 +1000
Message-ID: <CAAxzKbQoeJy2dKpaOjUK46Xi6ypSu2F6AR9n1ihxJHWymXHUsA@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [B.A.T.M.A.N.] Bridge loop avoidance required?
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

Behold my shitty diagram:

http://i.imgur.com/9tODwRu.png

In this configuration, where the only route out of the
batman-adv-supported layer 2 network is via a layer 3 router to the
WAN port on the nodes, is there any benefit to enabling bridge loop
avoidance? My understanding is that forming a loop would only be
accidentally possible if the link to the non-mesh LAN doesn't go via a
gateway. The gateway is configured to block all WAN->LAN traffic,
except SSH to the node itself.

The reason I ask is that the operator of the non-mesh network has
demanded that we cease connecting any form of mesh routers to their
network on the basis that it could mesh a route between two routers
connected to their network and form a loop. The situation is quite
political, and the facts aren't necessarily the most important
factors.

Thanks for your time,
Travis.
