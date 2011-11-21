Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Mon, 21 Nov 2011 23:53:06 +0100
Message-Id: <1321915993-29312-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCHv3 0/7] DAT: Distributed ARP Table
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
To: b.a.t.m.a.n@lists.open-mesh.org

Hello people,

****
This is the third version of this patchset. The whole code has been reviewed
(Thanks Simon!) and a bug related to the skb_mac_header() return value has been
fixed (thanks again Simon!).
****


as most of you may already know, last summer I've been working on the
B.A.T.M.A.N.-Adv GSoC project named "DAT: Distributed ARP Table". For who wants
to get deeper into the details of the project there are two links:
- The GSoC proposal [1]
- The DAT wikipage on open-mesh.org [2], with status and ideas description

Just to recap: DAT is a distributes hash table meant to store ARP entries for
fast lookup. In a normal scenario, whenever a node wants to communicate with
another one, it first needs to issue a broadcast ARP request in order to
retrieve its PHY/MAC address. In a sparse network a broadcast message could be
lost several times before reaching the real destination so creating high
latencies. With DAT, every ARP entries (a pair [IP addr, MAC addr]) is stored on
a "computed" set of nodes, therefore in case of ARP request theses nodes can
directly be contacted (in unicast) and the needed information can be quickly
fetched.


Cheers,
Antonio

[1] http://www.google-melange.com/gsoc/project/google/gsoc2011/ordex/4001
[2] http://www.open-mesh.org/wiki/batman-adv/GSOC2011_DAT


