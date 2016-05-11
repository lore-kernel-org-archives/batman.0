Return-Path: <alvaro.antelo@gmail.com>
MIME-Version: 1.0
Date: Wed, 11 May 2016 18:58:48 -0300
Message-ID: <CAKOC6KQMSca-tSOoKFm9t1LXrOnwHKbf3Ac0hXT6QZWxM_uwtw@mail.gmail.com>
From: Alvaro Antelo <alvaro.antelo@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [B.A.T.M.A.N.] Problem with DHCP on batman-adv V
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

Hi everyone,

I am testing batman-adv V5 from the development feed on Chaos Calmer
and so far everything is working except for DHCP IPv4, only static
addresses.
In the same setup wich involves bridges connected to bat0 interfaces,
if I change only the routing algorithm to batman-adv IV, DHCP works
fine.

Is it a expected behaviour?

Gateway node
batctl gw server
-----------------------------------
br-lan(ipv4 static and dhcp server)---bat0
-----------------------------------

Mesh node
batctl gw client
-------------------
br-lan(dhcp client)----bat0
-------------------

Best regards,
Alvaro Antelo
