Return-Path: <maxim.yuschenko1@gmail.com>
MIME-Version: 1.0
From: Maksim Iushchenko <maxim.yuschenko1@gmail.com>
Date: Mon, 16 Mar 2020 13:15:18 +0100
Message-ID: <CADSehqO-iKQ9BVWd_WjR28uZmpwmmLLjctg6AQj_xMAHvtRPdQ@mail.gmail.com>
Subject: batman-adv gateway issue
Content-Type: text/plain; charset="UTF-8"
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

Hello,
I use batman-adv to create a mesh network and recently I faced an
issue related to batman-adv gateways.
I have a mesh network based on batman-adv. Each node in my network has
certain coordinates. Each node uses these coordinates to generate it's
own IPv6 address and sets it to bat0 interface. Therefore, network's
node has a static IPv6 address contains encoded coordinates.
The purpose is to provide an Internet access to all mesh network nodes
via gateway node. I already configured gateway node as gateway server
and all rest nodes as gateway client. But in my case each gateway
client wants to know default route to the gateway node and, in
particular, it's IP-address.
Please, suggest me how can I distribute default route to all nodes in
the mesh network in the case where nodes have static IPv6-addresses
(and also it is necessary to maintain the actual default gateway on
the nodes). Or, please, suggest me how is better to provide an
Internet access to all nodes and distribute their coordinates in the
network.
Thanks in advance
