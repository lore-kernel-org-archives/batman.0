Return-Path: <ordex@ritirata.org>
From: Antonio Quartulli <ordex@ritirata.org>
Date: Tue, 21 Dec 2010 02:50:44 +0100
Message-Id: <1292896245-23160-1-git-send-email-ordex@ritirata.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Modifing hna_local_fill_buffer()
	return value
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


After changeset 1888, the return value of hna_local_fill_buffer() has
not been changed to _count_. In this way an eroneous num_hna was
calculated before sending the new OGM packet.
