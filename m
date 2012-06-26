Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Tue, 26 Jun 2012 22:00:17 +0200
Message-Id: <1340740822-4516-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH 0/5] new feature: Speedy Join 2012-06-26
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

this feature was proposed some time ago but then many changes were needed and
I took my time to refine the code :-).

Speedy Join enables new client to communicates with other hosts in the network
before being announced by its own mesh node.

In the current implementation a new client has to wait until the first OGM after
its join is sent out and only then it can start communicating with other
clients. However it could be the case that the originator interval is set to an
high value (e.g. 10 secs), which means that the client has to wait a long period
before becoming active. This would lead to several malfunctions like DHCP
timeouts.

This patchset faces this problem by letting nodes in the network "learn" about
the new client by means of its broadcast packets (the client will most likely
send a DHCP or an ARP request upon connection).

This new version composed by 5 patches. 1/5 adds the refcounting to the
tt_orig_list_entry structure, 2/5 generalises already existent code, 3/5 enables
roaming_adv packet to carry flags (this is needed to correctly make the new
client roam), 4/5 adds the code needed to handle the "temporary" clients and,
finally, 5/5 adds an hook for detecting new clients in the RX path.

Thank you!
	Antonio


