Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 397EBCD4F57
	for <batman-adv@archiver.kernel.org>; Tue, 19 May 2026 07:46:09 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id AB2BB80C51
	for <batman-adv@archiver.kernel.org>; Tue, 19 May 2026 09:46:07 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1779176767;
 b=kqrJ34pWArOhlV6T1ZdP2niRLwQsuhyBEzG6m/Ag0/KqV0i91JgB2Gvva/b+L4zBbyCey
 kErPD7IiljndGgFhBaEZmcXAwWQqBc5keomFxcqIka2ZOqtC70C69yqMD19ByjEABPvthEc
 aMwkp6r8c2mAc9QQicNKpH+bMwVrzwk=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1779176767; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=ufCjQtbFnz6ww2PZy7MlIKFOHXIcXYIcz3A0RQZDeBI=;
 b=sRksnEWOd8K11gvVDkr40BztqJgAcIBr5wOVnP7KbJmlegjonIwNRpBa/sNv06KxB/Bjy
 qE8hN3x/7avX5qdZrwXSIQfh/D1dhhrqd7UIN9dovwDP/J5YeipjDVZB6gsbmH/ZDhT0m7z
 2FnZCFJrulztwntD5o1N2Ds16k3Txtc=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id F3FEA8032D
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 19 May 2026 09:45:21 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1779176732;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=ufCjQtbFnz6ww2PZy7MlIKFOHXIcXYIcz3A0RQZDeBI=;
	b=WmhwNqCWPgs+XWpaelk8oJZ6386VYDzH+gk7MjFCHdmxljN9iEO/Lj76O/uD+/gK8UunFP
	6yjL1cnfxqtPvqWLlCBTx4nJNTiP4YfOa180OGzGln+5FrnFCRBuv8pvLcBFZWX+M1ZKuO
	UaiQjA0vcpIGJLQML2nEfQhocFtkMKQ=
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1779176732;
	b=ViYv9ZkEu2NJhcvzhVMokv9VXQNmDnJ3TpKuJbSzJHm5203WMuGujzjo6XCkDemZmGfVdM
	ahuUwVRiOskewKGgbM4CqRjTIJlyq2ESxlwPSdhu/VRl/NfFbxVMHIWHetLdtDTH/mWEUY
	lVRRwdb9OZ6HewBI7XkAm1UDlzYS6YY=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=VOPQ0LMy;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 18B9D1FE7B;
	Tue, 19 May 2026 07:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1779176721;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ufCjQtbFnz6ww2PZy7MlIKFOHXIcXYIcz3A0RQZDeBI=;
	b=VOPQ0LMyYuGRmv3+L8mCPnXWitkyojweeYIQKu4ixOedw4yt1ulU7w7F8vxoEjzZUjPGWE
	tpHFuI0cy/lTFU0OxAmMveA9q1V6hSpDciRlffMbqQakFwZLMmmWXj3HR86ajj8RChSejb
	ugEzizrvP4D8u6TuO0CDB66HDRWIJ8U=
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 19 May 2026 09:45:18 +0200
Subject: [PATCH batadv] batman-adv: bla: avoid NULL-ptr deref for claim via
 dropped interface
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: 
 <20260519-bla-unchecked-hardif-meshif-deref-v1-1-59cddf032f0e@narfation.org>
X-B4-Tracking: v=1; b=H4sIAA0VDGoC/yWNSw7CMAwFr1J5jaW0FChcBbFwYpeYT0BJWyFVv
 XsNrJ5mFm9mKJJVCpyqGbJMWvSVDOpNBSFSugoqG0Pjmr3b1Uf0D8IxhSjhLoyRMmuPTynRhiV
 Lj8TdlttD8NQ5sJ+3Sf38GmfwNBBPcPn7MvqbhOEbgGVZAbT864uNAAAA
X-Change-ID: 20260519-bla-unchecked-hardif-meshif-deref-ad83d47cba80
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Ido Schimmel <idosch@nvidia.com>, stable@kernel.org,
 syzbot+9fdcc9f05a98a540b816@syzkaller.appspotmail.com,
 Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2107; i=sven@narfation.org;
 h=from:subject:message-id; bh=xd8/W00+3lFECWJuPAIu0VSMgphausXzngx6Xdf7dNs=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFk8onyzGoSXtc76Hlu152htg6XR2iPpbvOfatfOnC6/8
 f0tnZZpHaUsDGJcDLJiiix7ruSf38z+Vv7ztI9HYeawMoEMYeDiFICJXNzGyDDxzvFNWlsVT00z
 CIv/2M/xUfuwrbHu9YV3ntdXR9YeOruL4a+Y/i2bCM0lPlw8vdl828+dFVymxlmmEzKJfflmtxO
 ++/kB
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: GMOM4L6KQAR4HTQJJPQHOJ6FBGHJBRQV
X-Message-ID-Hash: GMOM4L6KQAR4HTQJJPQHOJ6FBGHJBRQV
X-MailFrom: sven@narfation.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-3; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/GMOM4L6KQAR4HTQJJPQHOJ6FBGHJBRQV/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Without rtnl_lock held, a hardif might be retrieved as primary interface of
a meshif, but then (while operating on this interface) getting decoupled
from the mesh interface. In this case, the meshif still exists but the
pointer from the primary hardif to the meshif is set to NULL.

The mesh_iface must be checked first to be non-NULL before continuing to
send an ARP request using meshif.

Cc: stable@kernel.org
Fixes: 23721387c409 ("batman-adv: add basic bridge loop avoidance code")
Reported-by: Ido Schimmel <idosch@nvidia.com>
Reported-by: syzbot+9fdcc9f05a98a540b816@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=9fdcc9f05a98a540b816
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Another reason why I should sit down and rebase + polish Nora Schiffer's
"remove global hardif list" patchset. But first, I need to get the pile of
other fixes out or otherwise I will never get out of these endless
conflicts.

Btw. thanks to Ido for checking the backtrace in more detail and giving a
really precise reason.
---
 net/batman-adv/bridge_loop_avoidance.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index cec11f12..c801b3ed 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -356,12 +356,14 @@ static void batadv_bla_send_claim(struct batadv_priv *bat_priv, const u8 *mac,
 	       sizeof(local_claim_dest));
 	local_claim_dest.type = claimtype;
 
-	mesh_iface = primary_if->mesh_iface;
+	mesh_iface = READ_ONCE(primary_if->mesh_iface);
+	if (!mesh_iface)
+		goto out;
 
 	skb = arp_create(ARPOP_REPLY, ETH_P_ARP,
 			 /* IP DST: 0.0.0.0 */
 			 zeroip,
-			 primary_if->mesh_iface,
+			 mesh_iface,
 			 /* IP SRC: 0.0.0.0 */
 			 zeroip,
 			 /* Ethernet DST: Broadcast */

---
base-commit: ff182fc0c666754e3f35f7b63c9ccf0dff239e52
change-id: 20260519-bla-unchecked-hardif-meshif-deref-ad83d47cba80

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

