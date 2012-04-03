Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Tue,  3 Apr 2012 23:50:17 +0200
Message-Id: <1333489822-27692-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH 0/5] batman-adv: tt code fixes and temporary
	client detection
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

This set of patches aims to first clean & fix the code a little bit in order to
prepare it for the temporary client recognition (patch 5/5).

Temporary client recognition: In the current implementation, whenever a client
joins the network it has to wait the next OGM in order to be announced to the
whole network (by means of the known TT mechanism). Before that time, the client
will be unable to communicate to whichever else client, so generating some delay
that usually leads to DHCP (or any other service) timeout. This problem is
amplified is for large originator interval.

Patch 5/5 add a temporary recognition mechanism which make every node in the
network "autodetect" the location (namely the node serving) the node yet
announced client

Known issues: right now, multiple temporary announcement of the same client is
not supported; roaming of temporary client is not supported.
Support for this two features will be added soon.

