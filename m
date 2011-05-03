Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Tue,  3 May 2011 17:54:52 +0200
Message-Id: <1304438096-19009-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1303940106-1457-1-git-send-email-ordex@autistici.org>
References: <1303940106-1457-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] New translation table announcement mechanism
	patchset v2
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

In this new patchset, patch 2/4 has been revised following Andrew's
suggestions.
In particular all the changes are new comments, except one:
send_tt_response() has been slightly modified to avoid it to return
NET_RX_SUCCESS/NET_RX_DROP so avoiding to create confusion.


Regards,
	Antonio Quartulli

