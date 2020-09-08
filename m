Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
MIME-Version: 1.0
From: Oguzhan Kayhan <oguzhan@kayhan.name.tr>
Date: Tue, 8 Sep 2020 15:04:11 +0300
Message-ID: <CANKYHpe825qzeW9g7HbrHcacsO36x0=W_nRBCGKy_UfybvL7gw@mail.gmail.com>
Subject: alfred/batman issue
Content-Type: text/plain; charset="UTF-8"
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: b.a.t.m.a.n@lists.open-mesh.org

  Hello
I have two questions which most of you may find very novice.


I set up a batman mesh network between 3 nodes..all running
B.A.T.M.A.N. adv openwrt-2018.4-0 on batman V protocol.
And also installed alfred which version 2016.5


node-1 ( 00:30:1a:4e:aa:20 ) connection
  IF             Neighbor              last-seen
00:30:1a:4e:aa:23    0.190s (       15.8) [     wlan0]
00:30:1a:4e:aa:1d    0.050s (        8.9) [     wlan0]

node-2 ( 00:30:1a:4e:aa:23 ) connection
IF             Neighbor              last-seen
00:30:1a:4e:aa:1d    0.420s (       22.7) [     wlan0]
00:30:1a:4e:aa:20    0.520s (       15.8) [     wlan0]

node-3 ( 00:30:1a:4e:aa:1d )connection
IF             Neighbor              last-seen
00:30:1a:4e:aa:20    0.500s (        9.0) [     wlan0]
00:30:1a:4e:aa:23    0.180s (       22.6) [     wlan0]

No clients connected to any of the nodes. Only one of them (node 1)
is connected  br-wan port to my internal gateway. And all others are
reachable via this node (node1)

alfred output does not show any neighborhood on this case..
alfred config is ;
config 'alfred' 'alfred'
        option interface 'br-wan'
        option mode 'master'
        option batmanif 'bat0'
        option start_vis '1'
        option run_facters '1'


node-1
digraph {
        subgraph "cluster_00:30:1a:4e:aa:20" {
                "00:30:1a:4e:aa:20"
        }
        "00:30:1a:4e:aa:20" -> "6c:4b:90:61:e3:d6" [label="TT"]
        "00:30:1a:4e:aa:20" -> "02:b9:87:a6:4f:66" [label="TT"]
        "00:30:1a:4e:aa:20" -> "28:d2:44:68:bd:1b" [label="TT"]
        "00:30:1a:4e:aa:20" -> "90:6c:ac:51:b9:dc" [label="TT"]
        "00:30:1a:4e:aa:20" -> "34:29:8f:74:59:c9" [label="TT"]
        "00:30:1a:4e:aa:20" -> "50:7b:9d:56:43:08" [label="TT"]
        "00:30:1a:4e:aa:20" -> "00:30:1a:4e:aa:21" [label="TT"]
        "00:30:1a:4e:aa:20" -> "02:b9:87:a6:4f:66" [label="TT"]
        "00:30:1a:4e:aa:20" -> "00:25:36:c1:13:3a" [label="TT"]
        "00:30:1a:4e:aa:20" -> "00:24:9b:53:55:62" [label="TT"


node-2
digraph {
        subgraph "cluster_00:30:1a:4e:aa:23" {
                "00:30:1a:4e:aa:23"
        }
        "00:30:1a:4e:aa:23" -> "32:21:1f:29:72:04" [label="TT"]
        "00:30:1a:4e:aa:23" -> "00:30:1a:4e:aa:24" [label="TT"]
        "00:30:1a:4e:aa:23" -> "32:21:1f:29:72:04" [label="TT"]
}

node-3

digraph {
        subgraph "cluster_00:30:1a:4e:aa:1d" {
                "00:30:1a:4e:aa:1d"
        }
        "00:30:1a:4e:aa:1d" -> "3a:ed:c5:16:bb:e6" [label="TT"]
        "00:30:1a:4e:aa:1d" -> "00:30:1a:4e:aa:1e" [label="TT"]
        "00:30:1a:4e:aa:1d" -> "3a:ed:c5:16:bb:e6" [label="TT"]
}


Even after adding an ethernet client to node 2..
the output replaced as
digraph {
        subgraph "cluster_00:30:1a:4e:aa:23" {
                "00:30:1a:4e:aa:23"
        }
        "00:30:1a:4e:aa:23" -> "32:21:1f:29:72:04" [label="TT"]
        "00:30:1a:4e:aa:23" -> "00:30:1a:4e:aa:24" [label="TT"]
        "00:30:1a:4e:aa:23" -> "32:21:1f:29:72:04" [label="TT"]
        "00:30:1a:4e:aa:23" -> "00:24:9b:53:55:62" [label="TT"]
This client traffic is normally passing from eth port of the node-2 to
node-3 via wifi, and then node 1 via wifi and then eth of node-1 to
internet.

but didnt see an update on other nodes even node 1 has all the traffic
carrying to the new added client.
Is it something expected? Or am I missing something?

By the way.. on batctl tg output.. the client appears on the list
  Client             VID Flags Last ttvn     Via        ttvn  (CRC       )
 * 32:21:1f:29:72:04    0 [....] (  1) 00:30:1a:4e:aa:23 (  2) (0x3e5717a8)
 * 3a:ed:c5:16:bb:e6   -1 [....] (  1) 00:30:1a:4e:aa:1d (  1) (0x10f0fbd0)
 * 00:30:1a:4e:aa:1e   -1 [....] (  1) 00:30:1a:4e:aa:1d (  1) (0x10f0fbd0)
 * 3a:ed:c5:16:bb:e6    0 [....] (  1) 00:30:1a:4e:aa:1d (  1) (0x2eef010b)
 * 00:30:1a:4e:aa:24   -1 [....] (  1) 00:30:1a:4e:aa:23 (  2) (0xcfe8055b)
 * 32:21:1f:29:72:04   -1 [....] (  1) 00:30:1a:4e:aa:23 (  2) (0xcfe8055b)
 * 00:24:9b:53:55:62   -1 [....] (  2) 00:30:1a:4e:aa:23 (  2) (0xcfe8055b)


Second question is valid only after I see the neighborhood information correct..
Which tool can I use on openwrt to visualize this relation between
nodes.Any ready tools for luci?

Regards
