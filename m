Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Tue,  5 Jul 2011 17:22:59 +0200
Message-Id: <1309879385-21224-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH 0/6] Solve consistency issues in TT code
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

Hello everybody.

In the current TT implementation there are some cases where transtable
consistency is not kept.

In particular, it is possible to observe this problem in case of a tt_response
issued after a request for full-table: if the responding node is _the real
destination of the request_ then it will send within the response message also
those clients added after the last ttvn increment.
This will cause an inconsistency because now we have different nodes with
the same ttvn value but with different tables for the same originator.

These patches are meant to solve this issue and keep consistency among nodes.

Patches 1) and 2) introduce beautifications only. This change helped in writing
patches 5) and 6) by reducing the code complexity.

I would like to read some feedbacks even about the patch decomposition, which
could probably be improved :-)

Thank you all.

Regards,
	Antonio Quartulli

