Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Sat, 14 Apr 2012 13:15:25 +0200
Message-Id: <1334402127-5211-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH 0/2] Fixes reported by Al Viro
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

The following two patches fix the two issues found by Al Viro and reported in
his email.

Patch 1) simply convert the tt_crc field in the bat_priv structure from atomic_t
to uint16_t. Actually there is no reason to declare it as atomic_t.

Patch 2) fixes a little bug we have when sending a tt_request message: now we
don't convert the tt_crc that we are sending within the request to network
order. OTOH we convert this field from NO to HO on the receiver side.

Therefore, nodes on the path of the request, which have HO different from NO,
will fail to reply to the request and will forward it towards the final
destination.


Cheers,
	Antonio



