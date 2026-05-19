Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DCA9CD4F58
	for <batman@archiver.kernel.org>; Tue, 19 May 2026 07:01:28 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 870DA807E5
	for <batman@archiver.kernel.org>; Tue, 19 May 2026 09:01:21 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1779174081;
 b=dKDQiwroUO8AZfjYL/ZKN2UJunspiCjv55vEKVAnjtH6QY6e/+8NO6zOKsX1VDzPDqWWs
 jHZDNx0237PyfpWv5ntJJGgb4jt+MsKabMfayS24yXHC6q8nyel4wBvTIJpEZWAToRhFEh1
 Zf/1AmwBP/8NyKjgzKg8+qLw0fMRqx8=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1779174081; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=ChseJSZa0FQPvCr3vo9J9wH/f+VBqW+4wMW+SX7YMMY=;
 b=d5Usm3L6h8S7OgSsVTW+ZT5DZc9merq84zWfWYcbi+BBUarAq/CYeVWe5+bqAue58AvV9
 CcLguk+FKdINqCkRj3WHFaQMpsaSbLRjBbh/kGgklkhg8ikGKcHQ3RyeUav9WXq3+8RCTfB
 g1ri/giQR+GK/3agMEmsKQ2Yvedj2A8=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 6C70E8084A
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 19 May 2026 09:00:40 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1779174041;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=ChseJSZa0FQPvCr3vo9J9wH/f+VBqW+4wMW+SX7YMMY=;
	b=hwYCnh8y7qwKf9wFbATHtvN07OXZcjX7i+nF7PA6iDauz0RoKH/6Fzjx4WNE1FJ70J1p0a
	zTlZNgDz9O3GfOREk2M4hzN4CWwTFKsLg7Ms6D6irTy/BsGi19oUCmOfFoqK34eVtR3Xi0
	Gv4G2//tUaIrSfn2WXsiHv3esae0nSU=
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1779174041;
	b=x53z0KcCdmC9qb4xiLgEJIVGkQDim7oIuIfbYcu7yAgTTZ8eDR0RMbLkgz2qCzM/JCvod/
	4d00J4E3cjjWqFU0ezjGVNgTKe96uEG9jOHVEVjcxE1PKAkY7RzSrrb9J9+TS+G5dlb9cn
	CEH7TWDyCWx9rGUtKEEiF1zNl2sVK2E=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=XYVGLvI5;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 0E2891FE24;
	Tue, 19 May 2026 07:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1779174040;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ChseJSZa0FQPvCr3vo9J9wH/f+VBqW+4wMW+SX7YMMY=;
	b=XYVGLvI5x9CtLaS7hGQYrBV/OY29JSTeLcW5585QBRfci7XQanuv0ZpRZM2z1NpjOFXaw4
	76GJE8W+cYnWSeizTRpxAQSQ3VDc0Wi8J962QtRj7F2d5px5Hr3VqxTNnYLOH9i2Zugjmx
	CDWZMpdTkH08vNoRBuan7hfRYYCaXSg=
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH batadv v2 0/3] batman-adv: tp_meter: error reporting and
 role mixups
Date: Tue, 19 May 2026 09:00:35 +0200
Message-Id: <20260519-tp-reason-missing-v2-0-9c5cd1824e3b@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJMKDGoC/32Oyw6CMBBFf4XM2hpa5BFX/odhMUALY2JLOrXRE
 P7dUvcu7825jw1Ye9IM12IDryMxOZuEOhUwLmhnLWhKGlSpmrKWlQir8BrZWfEkZrKzMBKxlqY
 yVXuBlFu9NvTOnXcYMOAUof/5/BoeegxH4UEuxMH5Tx6PMvN/dqIUUrS1wq5Tw9RIvFn0BkN6f
 HZ+hn7f9y+QF3/K0AAAAA==
X-Change-ID: 20260513-tp-reason-missing-f1aa51f3f374
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1891; i=sven@narfation.org;
 h=from:subject:message-id; bh=LauzM71LZ7h7bmzmi8hXMMS2F/02dWjgQGFCPCh3c/4=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFk8XFPNdx/fq/tp06/TUWeYX1mZyzzUeXy9vVXnEO928
 ejQyRtVOkpZGMS4GGTFFFn2XMk/v5n9rfznaR+PwsxhZQIZwsDFKQAT0ZVg+CsiuDp3if9k8ftO
 Z2d5zXo80WhZabjMdRWbLRm/ZtkIrS5hZGjY3+GzUXmuVcEu3oiqHU0cJ2bceZr/6zHfzo9Tbx4
 uiGUFAA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: PCBI67KMX6QUA2Y6HHRVQEZUC2CM2GXD
X-Message-ID-Hash: PCBI67KMX6QUA2Y6HHRVQEZUC2CM2GXD
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/PCBI67KMX6QUA2Y6HHRVQEZUC2CM2GXD/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

batadv_tp_sender_shutdown() previously used two separate variables to track
session state: sending (an atomic flag indicating whether the session was
active) and reason (a plain enum storing the stop reason). This introduced
a race window between the two writes: after sending was cleared to 0,
batadv_tp_send() could observe the stopped state and call
batadv_tp_sender_end() before reason was written, causing the wrong stop
reason to be reported to the caller.

The state + reason handling has to be reworked to only modify a single
variable

At the same, time we had some tp_vars role confusion and overly large
tp_vars for receiving. Just split them up. Making sure that the search
functions only search for the correct role and at the same time only use
the required memory.

The last patch should not enter stable/net.git but go through
main/net-next.git. It is just added here because it depends on the first
patch.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Changes in v2:
- fix send_result kernel-doc
- rebase patch
- add patch to avoid role mixup in search functions
- add patch to split sender and receiver sessions
- Link to v1: https://patch.msgid.link/20260513-tp-reason-missing-v1-1-752a882bd61a@narfation.org

---
Sven Eckelmann (3):
      batman-adv: tp_meter: fix race condition in send error reporting
      batman-adv: tp_meter: avoid role confusion in tp_list
      batman-adv: tp_meter: split vars into sender and receiver types

 net/batman-adv/main.c     |   3 +-
 net/batman-adv/tp_meter.c | 453 +++++++++++++++++++++++++++-------------------
 net/batman-adv/types.h    | 109 +++++------
 3 files changed, 325 insertions(+), 240 deletions(-)
---
base-commit: ff182fc0c666754e3f35f7b63c9ccf0dff239e52
change-id: 20260513-tp-reason-missing-f1aa51f3f374

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

