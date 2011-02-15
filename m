Return-Path: <linus.luessing@ascom.ch>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@ascom.ch>
Date: Tue, 15 Feb 2011 18:12:15 +0100
Message-Id: <1297789948-16948-1-git-send-email-linus.luessing@ascom.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] Redundancy bonding mode patches, v1
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

Hi everyone,

The following patches add a redundancy bonding mode to batman-adv: In case
of multiple interfaces available towards a next hop node, instead of sending
packets in interface alternating or round robin bonding fashion, packets
get send redundantly on all available interfaces available for bonding.

This mode increases the packet delivery ratio of unicast data transfers for
the cost of throughput in multi interface mesh networks and is therefore
aimed at high reliability mesh networks.

It is especially useful if the main source of packet loss is not always
reliably detectable by batman-adv's broadcast PDR measurements (i.e.
bursty periods of interference on a single channel, which gets averaged out
due to the windowing; different unicast bitrate; ...). Or if a fault
tolerant packet forwarding scheme which is able to tolerate a sudden link
failure with no impact on the user experience is required.


The first eight patches are mainly some restructuring of the unicast sending
code paths. Patches nine to 13 add the actual redandancy bonding mode.

Please note, that this redundancy bonding mode is not yet compatible with
batman-adv's link layer fragmentation feature.

Cheers, Linus
