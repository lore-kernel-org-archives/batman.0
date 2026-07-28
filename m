Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9386EC53219
	for <batman@archiver.kernel.org>; Tue, 28 Jul 2026 21:27:56 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 931B28194C
	for <batman@archiver.kernel.org>; Tue, 28 Jul 2026 23:27:50 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1785274070;
 b=El9BqptjJttK18O9of8IOMc734iwq3+uBLS2+GA5t2DQe0JwJuuEiPj7RfkDOJi30J9MS
 UG5BiM70qV4Ju9Zfe7nz4R1B03LeP9X7onxZ4DAbj052LL3H+UD+BJV6Po11nYeN/ZroRD/
 HwJMDVyquiwYQJ9/K82QPly4HJJa4JA=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1785274070; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=ZyLKpXTDawb+TB8eXTRgOTNVVbekq6qd9LRqnN8Kk1M=;
 b=WcMdTFOGDUlLTfipXxZpn5yyw+X5ILEh7TeuA2Ascp0ORcsQMeaRAU9Npo5kZfiSx3sfx
 xc6eHflagjUSlPPodwqUCV+eGWn/gNSjUxiCcA5Xe7AlXo0GrX/Q84C7yWN/ZmksEMNMw9b
 qZIE1JcK168UsYSz/T5Tj88ERi6z31o=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 7804A80F3E
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 28 Jul 2026 19:07:17 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1785258437;
	b=H8n3r+YGU/lI3AQrFV6MdpDDU1JvwpJAhWGJWH7GoT4Oq1EKuXEXGvMT1BKUbcEhrUUbBl
	TqzJO4AFrowuQGdubnIWMgkYAn5+0H02gG7Nl6k1zlPiCnZ5iQ8alWi/hDUls71h3yCPDC
	01NOlK65Ject5DpJQCWJ2nx/FXf3KyI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1785258437;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=ZyLKpXTDawb+TB8eXTRgOTNVVbekq6qd9LRqnN8Kk1M=;
	b=bkCoX1r9ZW20uejTXLcjvOrOcJ+ddRSJ/5bW/6TegDTt66h4+Vx9n8zsIm5pISDxXTIqMg
	0hk4XSt/D5mV400B/AztrlDFY3XLc+4AsJaoG2qQnEdnkCBpXCgQEZvniDoI2X/8PHrphC
	ez/CKcLu+/bb0P8mrMBxasa/XZGD+o4=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=00xMyb9e;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 99306200C7;
	Tue, 28 Jul 2026 17:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1785258432;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZyLKpXTDawb+TB8eXTRgOTNVVbekq6qd9LRqnN8Kk1M=;
	b=00xMyb9eiAizzAMV/53bB1Sssdwkb7dkuFt1ZO0+2j3rTAENnUooBiSqECuLmweBUhatk5
	cC8GhP0yEKOTv4DlPg/BjSkY7JnFZVST849iUDhdXYJRUw2l0fzBvYXQx/iJapgwnfVzJq
	IAN3W5mboDKmNEQWkQ1rkw+FnBPjb3E=
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 28 Jul 2026 19:06:43 +0200
Subject: [PATCH] alfred: mark alfred_change_bat_iface_v0 as packed
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260728-bugfixes-packed-v1-1-5a1888ab4b87@narfation.org>
X-B4-Tracking: v=1; b=H4sIAKLhaGoC/yXMSwqEMBCE4atIrw1o8H0VcWGSUltBJa3DgHh3M
 +Pyo/jrIoFnCDXRRR4fFt7WgDSOyE79OkKxCyad6CIpdaXMOQ78hai9twucyuoiM66Eq/OUQrV
 7/PcQtd1rOc0Me/xu6L4fE3ipsHMAAAA=
X-Change-ID: 20260728-bugfixes-packed-4964bd7ed951
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=949; i=sven@narfation.org;
 h=from:subject:message-id; bh=t54SIS8LLMFuUZEW9KbqG3GD5t7YDrPzZhcCPdhn8Bg=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFkZD1dsPe7a8rnz/D6Dz5/Vdf7Kv+wQcXHILLqwOiZmQ
 YOYi9vzjlIWBjEuBlkxRZY9V/LPb2Z/K/952sejMHNYmUCGMHBxCsBE5h1jZDi9wmj2Ys4VmZ99
 XVj2TPFUFBV7dkG1jEmBZXu78x7F/pWMDP0peWd6+bKvKZo8ifrC+TBkharGIvGeutt7bljueGh
 0gxcA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: DTUHSXXT6M5MB5H5QNFK4XV4BNCUU5XG
X-Message-ID-Hash: DTUHSXXT6M5MB5H5QNFK4XV4BNCUU5XG
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/DTUHSXXT6M5MB5H5QNFK4XV4BNCUU5XG/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

struct alfred_change_bat_iface_v0 is part of the unix socket protocol and
is the only protocol structure in packet.h not marked as __packed. The
current members happen to not require any padding, so the layout is
unaffected for common ABIs. But to be safe, also mark this struct as
packed.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 packet.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/packet.h b/packet.h
index c0723b8..a7df81e 100644
--- a/packet.h
+++ b/packet.h
@@ -164,7 +164,7 @@ struct alfred_change_interface_v0 {
 struct alfred_change_bat_iface_v0 {
 	struct alfred_tlv header;
 	char bat_iface[IFNAMSIZ];
-};
+} __packed;
 
 /**
  * enum alfred_packet_type - Types of packet stored in the main alfred_tlv

---
base-commit: 462a0cf40615f62e0912c36d72a75accbb26f5ee
change-id: 20260728-bugfixes-packed-4964bd7ed951

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

