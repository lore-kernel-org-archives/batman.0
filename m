Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
MIME-Version: 1.0
From: Andi Depressivum <andidepressivum@gmail.com>
Date: Sun, 4 Apr 2021 19:52:35 +0200
Message-ID: <CAEX-Y1Z8vHvj_TD-EL-Y9AiSeKV9WHb=BxJMwJx0h5z0xfk5OA@mail.gmail.com>
Subject: How to mesh over ethernet VLAN?
Content-Type: text/plain; charset="UTF-8"
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: b.a.t.m.a.n@lists.open-mesh.org

Hello everybody,

What's the correct setup to mesh also over an existing ethernet VLAN link?

My core network with all routers & servers is running on VLAN 3
(eth0.3 in the routers). How do I have to setup batman-adv to a) mesh
also over this existing link and b) propagate this VLAN also over
wireless links. Bridging eth0.3 with bat0.3 and adding eth0.3 also as
a hardif doesn't work, as it will remove eth0.3 from the bridge.

If I add eth0 instead as hardif the routers are only seeing each other
over wireless link. Or do I have to use a separate VLAN for ethernet
meshing which isn't bridged to a bat0.X interface?

Thanks a lot!
