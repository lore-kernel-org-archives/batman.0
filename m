Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BE2606A31C
	for <batman@archiver.kernel.org>; Sat, 31 Oct 2026 20:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=GlJRwUhQ
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 692ED83F86
	for <batman@archiver.kernel.org>; Sat, 31 Oct 2026 21:30:43 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1793478643;
 b=IT1/SnYfSIlhNDsqnX2/myP2ioL3+EZK5lFldR8sFHHEm4e1yRDyGubPcKGX79KvDlI79
 KeJs65E3huav58CqnpZ7aowY4mKqEMHT+BBHmq+iidHketLW5ad7WrlxS/5rAUejnVKP+EC
 MapymLXH4F+IBiHL3DfosbzpSBsYSn4=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1793478643; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=HJvg61C9OaNV/HufnfcEtVueKqvKBEO56qai5gn6GoU=;
 b=QsZFygmbAcy9V6I1Eg4H8VbNbLUdHp3hkpOsOqUx12fAdy6vfL9DhtEadKDYI4Z7yObm2
 240xX+uOKF+84yV57co2ir0qZruuJe6M7zAzRYZCBy7WSiSVtHfe0DSNegH0kFyCB0x62JV
 yjZNcwLaCl09NsBpsoWbocQ8PxyYu+U=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id EF7AA805DF
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat, 31 Oct 2026 21:30:17 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1793478628;
	b=FEibcEtg4ga0U7kD86oKTgh256ogjaw8hZE27IBZNyh3Qu0fwX3uXupPzLX74hwKEDh3D/
	JvVObqTDWTcmT6hdKVS+tQYAEt+WAlf/sQQvUhoxKKe4YYa6aAzSDqcaGH3V6NnCeleJXk
	FnIC4nPVO/kWwaf2HXtJwozHYCy+yAY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1793478628;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=HJvg61C9OaNV/HufnfcEtVueKqvKBEO56qai5gn6GoU=;
	b=01LDf5/AxCkLodgGSlqZzJ7FVTOexC2LKhXDxeONDD/mNG/zkfeLO6ra8aTOeFwCESzvte
	k6JhSI4EoRgfBB4CNtNU1Qp2CZlmr2Ek1KGtOcnmYA4CHPQWC77hBj/FaJwWnD15zzO4Mb
	9dE4s9V1YyLP76FnFT+dF2t1vluDlUc=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=GlJRwUhQ;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 74CB520F6B;
	Sat, 31 Oct 2026 20:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1793478616;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HJvg61C9OaNV/HufnfcEtVueKqvKBEO56qai5gn6GoU=;
	b=GlJRwUhQ0yRZafwxHH7CERorG3btdBkzX1sFCdaUh/teKy+Qqumzfv93QbwT1lz5tHyfi/
	ufIXccKwGiHYgr92/Mr/2yTrSXibmtlH8tftJyfnjSrR51CSdlzWscgX10+hp4AL7D+ax/
	spYA8nB1E6z8S/Cx3vk29EjKnXmuXEU=
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH batadv v4 0/7] batman-adv: annotate jiffies members with
 READ/WRITE_ONCE
Date: Sat, 31 Oct 2026 21:29:40 +0100
Message-Id: <20261031-dat-last_update-once-v4-0-3f7994b1f5fe@narfation.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALRP5moC/43OwQrCMAwG4FeRno20XbepJ99DRNI11Ypso61Fk
 b273byIqHhLQvL9ubNA3lFg69mdeUouuK7NjZrPWHPE9kDgTO6Z5LISnCswGOGMIe4vfS4JurY
 hoFrhqiksaStYPu09WXed2C3TGNEktnvOw0WfqImjOW4eXYidv035SUz7v6OSAAG2rpWpFSe1W
 m5a9BZj/nvR+cMUk+Q/kAQOqLmQqLRYkvkEFa9Q9QUqMlSICskaU9rSvkPDMDwA4ubxOGgBAAA
 =
X-Change-ID: 20261004-dat-last_update-once-e74a9c3febf1
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>, Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2838; i=sven@narfation.org;
 h=from:subject:message-id; bh=GVt/Epq+apRG05yFnKQYe2mxHY1w+6A7roxtxYVEt3I=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFnP/HdWLxMNb0/LPrso9Dr/6pNRbV3xCyTsmCbavTScq
 LjL6b1ERykLgxgXg6yYIsueK/nnN7O/lf887eNRmDmsTCBDGLg4BWAiG6UY/pmsaH/nFRD1R1Fy
 wfMrn9V6GA9+87XO9FtZubf0z7Q3bnqMDIcclIsLfny5x7/h6Lxpvq+Mdv6dZLn0m2fkNqOu8PO
 7HjIAAA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: YJPTGTW47ACOETGTKMDRKXVE45W7GKME
X-Message-ID-Hash: YJPTGTW47ACOETGTKMDRKXVE45W7GKME
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/YJPTGTW47ACOETGTKMDRKXVE45W7GKME/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_NONE,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

There are various members which track jiffies value of the most recent
activity and is used to detect timeouts. These accesses are not
consistently protected by a lock, so READ_ONCE/WRITE_ONCE must be used to
prevent data races caused by compiler optimizations.

To avoid an underflow due to an non-strict order read of jffies vs
members, use jiffies_delta_to_msecs instead of jiffies_to_msecs to
evaluate the delta for netlink.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Changes in v4:
- drop tpmeter: avoid underflow in rtt patch because the delta is
  calculated after jiffies_to_msecs
- drop tpmeter testtime patch because it creates the wrong result after
  running a test for 24.8 days (1000 Hz jiffies) - and it is not strictly
  needed
- drop the jiffies_delta_to_msecs paragraph in "neigh_node last_seen"
  commit message
- drop bat_v.last_unicast_tx patch because it is not regularly updated and
  would cause an overflow when not sending for 24.8 days (1000 Hz jiffies)
- document that backbone_gw->lasttime is only about reporting
- Link to v3: https://patch.msgid.link/20261006-dat-last_update-once-v3-0-316aefdd5f5f@narfation.org

Changes in v3:
- rebase on top of "batman-adv: tt: improve pending/CRC handling" patches
- Link to v2: https://patch.msgid.link/20261004-dat-last_update-once-v2-0-ab012a4b18ed@narfation.org

Changes in v2:
- add patches to adjust more places to follow the same approach as shown in
  the DAT one
- Link to v1: https://patch.msgid.link/20261004-dat-last_update-once-v1-1-f774d740e498@narfation.org

To: b.a.t.m.a.n@lists.open-mesh.org

---
Sven Eckelmann (7):
      batman-adv: bat_v: initialize last_unicast_tx on neighbor creation
      batman-adv: dat: annotate last_update with READ/WRITE_ONCE
      batman-adv: bla: avoid negative reported BATADV_ATTR_LAST_SEEN_MSECS
      batman-adv: tt: annotate last_seen with READ/WRITE_ONCE
      batman-adv: annotate originator last_seen with READ/WRITE_ONCE
      batman-adv: annotate neigh_node last_seen with READ/WRITE_ONCE
      batman-adv: annotate hardif_neigh_node last_seen with READ/WRITE_ONCE

 net/batman-adv/bat_iv_ogm.c            | 16 ++++++++++------
 net/batman-adv/bat_v.c                 |  9 +++++++--
 net/batman-adv/bat_v_elp.c             |  6 ++++--
 net/batman-adv/bat_v_ogm.c             |  7 ++++---
 net/batman-adv/bridge_loop_avoidance.c |  4 +++-
 net/batman-adv/distributed-arp-table.c | 11 +++++++----
 net/batman-adv/originator.c            | 14 ++++++++------
 net/batman-adv/translation-table.c     | 15 ++++++++++-----
 8 files changed, 53 insertions(+), 29 deletions(-)
---
base-commit: 04071c46a5cb4fe3078ac44b48d11268ba275438
change-id: 20261004-dat-last_update-once-e74a9c3febf1

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

