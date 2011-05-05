Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Thu,  5 May 2011 09:13:06 +0200
Message-Id: <1304579589-5222-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] batman-adv: added uevent support for gw and gw
	propagation for clients
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: "B.A.T.M.A.N" <b.a.t.m.a.n@lists.open-mesh.org>

Three new features have been added:
1) generic uevent support
2) uevent triggering for gw state changes
3) gw propagation for clients

Patch summary:

- 1/3: a wrapper function that permits to trigger uevents has been added.
The function takes a "type", an "action" and a "data" as parameters which
will be used as uevent attributes. In particular they will respectively be
BATTYPE, BATACTION and BATDATA in the uevent environment.
The "type" and the "action" field are managed using two enum definitions and
two char arrais. Currently the supported "type" is 'gw' only and the supported
"actions" are 'add', 'change' and 'del'. The "data" parameter is a free field
which can be filled by the programmer to send any useful data to the userspace.
Uevents can be seen in userspace with the following command:
	"$ udevadm monitor --property"

- 2/3: on a gateway add/change/del event a corresponding uevent of type 'gw' is
triggered. In particular, in case of setting up a gw for the first time a
uevent with action 'add' is triggered. In case of changing the best gateway a
uevent with action 'change' is triggered. In case of deselection of any gateway
a uevent with action DEL is triggered.

- 3/3: a gw propagation feature for clients has been provided. The main target
of this patch is to make clients able to change L3 gateway as soon as the mesh
node currently serving them changes its default one at the batman layer.
For this target a passive approach has been followed: whenever a unicast
DHCPREQUEST for renewal is sent from a client, the node will inspect it and
check if it is directed to the current default gateway or not. If it is not
the case then the packet is dropped. In this way the client will get a
timeout and a new DHCPREQUEST for discover will be sent giving the possibility
to the node to select the best gw to forward this packet to (current gw
selection mode).

