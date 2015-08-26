Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Wed, 26 Aug 2015 16:41:50 +0200
Message-Id: <1440600113-21305-1-git-send-email-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH-maintv2 0/3] Some fixes for DAT/TT/Speedy
	join corner cases
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
Cc: alessandro@mediaspot.net

This is the second iteration of the patches, with the following changes
(thanks Antonio for review):
 * split out style patch no 3
 * change 4addr check to use only payload (DATA) subtype in the first patch
 * count number of VLANs instead of comparing VLANs explicitly in the last patch

Original (slightly updated) description here:

Upon debugging a network with dangling, bogus TT entries, I found a
couple of bugs for which I would like to propose fixes. The network showed
the following symptoms:

 * DAT was enabled
 * VLANs were used, but not every originator used the same VLANs
 * I've found global entries assigned to originators which actually
   never had the client in question connected to them. These false target
   originators didn't even had the VLANs in use or bridged for which
   the entry was done. This caused packets sent to be sent to these wrong 
   originators.
 * The wrong entries also didn't get purged automatically, since they
   didn't announce the VLAN in question through their TT TLVLs, and the
   TT code didn't check for excess VLANs.
 * Furthermore, the temp flag was removed too early from the TT entries
   so that the purge function was not removing the entry after a timeout
   as well.
 * I've found that with DAT, the cached ARP replies may cause these
   TT entries to be created on behalf of the answering host. This is wrong,
   since the answering host (usually) doesn't actually has the client
   connected.

We have not yet tested these patches in the network, and the bug also appears
only once in a couple of days. Therefore I'd like to ask to review these patches
thoroughly, and if you agree to the fixes we will apply them in this production
network.

Thanks,
     Simon

Simon Wunderlich (3):
  batman-adv: fix speedy join for DAT cache replies
  batman-adv: avoid keeping false temporary entry
  batman-adv: detect local excess vlans in TT request

 net/batman-adv/routing.c           | 19 +++++++++++++++----
 net/batman-adv/translation-table.c | 24 +++++++++++++++++++++---
 2 files changed, 36 insertions(+), 7 deletions(-)

-- 
2.5.0

