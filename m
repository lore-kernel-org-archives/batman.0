Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11186CD6E77
	for <batman-adv@archiver.kernel.org>; Thu,  4 Jun 2026 20:12:02 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id B1AE1853DF
	for <batman-adv@archiver.kernel.org>; Thu, 04 Jun 2026 22:12:00 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1780603920;
 b=TjP/7Ow4myBh2YiFOEL71ZizUgUJjJMsM+9ATPdB6TxGfW8zE2CfyCdLcDPGn+/pXwkA/
 25iqAKd+9/0XDFKDt0VC8I19kurXu/sR1hXZyR2ALp/FlFC1ulRoqdNG8a1dN2ONYnGdMAc
 jpM2aFd/WDATU5/33flSs8pr/7zgx5U=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1780603920; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=IMfP8JYXIWQ74usOgmVWM2wBGlEqAMUuXRZGcehS4qM=;
 b=n2K2vJPuHEupY6J+LVp+cpvZBO6g6r6EEco819Edt1iU0t8PWYHgYNpN9MrOGFvdZQz1U
 5NqtDh+FaX8Quz9ki3ETOhCnzSCdiOMG7R0UMfAsi4IEVEA6KubWuunjCymZHoyXAWVhYB4
 IxVdKSUHVohRHVHV2K3ncTnWJIi+GUg=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 2E7FD844FD
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 04 Jun 2026 22:08:48 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1780603738;
	b=VKn8KKWTWAIIHlyTNC7Ohw4CpfvPN0SQZvd0ij+7igoB5711ekPNF6jKOkkoIeJUBbGb/t
	Q4hUAE6dLqdf6LDcxB5i1Oh2ukD5x4BAIkEWHY6q9nbx3bsjTnsNKSG5/u/o8/3dRqSKJv
	V462GTHS46/0f8wEZHiiwq5LEJEBdGw=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=kChADJkR;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1780603738;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=IMfP8JYXIWQ74usOgmVWM2wBGlEqAMUuXRZGcehS4qM=;
	b=TdQ/HJQk+mBpbsKiJRHG8+Tpr0XUBnz3L+937+Zg7sgeTTNkHPHeKOD+WYEOsxxBhMImgF
	YVB5wcviUMIqc6G4aOXdkeVNiMNyOwpwNm99A9K290BS+zEfuc5+xfhcdaqiTV+odUYjBC
	ZGOk8t3WukmGjjDWYSEn5F48F6vsKZ0=
Received: by dvalin.narfation.org (Postfix) id 0F1901FEA8;
	Thu, 04 Jun 2026 20:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1780603727;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=IMfP8JYXIWQ74usOgmVWM2wBGlEqAMUuXRZGcehS4qM=;
	b=kChADJkRg9fuU0qejRDnZPzBpaz4Gl4pgjzcpk9RbJajjz7jISRMfy3JZLQrQZ8OaPA/rd
	/QtIHD+JQa5UWkfub4gyt9LokI7qJT2zn/PgFq4Qn5Klptb6RhZSSMRM1L5Y+YsfJ7GTEH
	bFO73JfaeuUKcqnSQ8uJuhFX0csb9NU=
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH batadv 0/5] batman-adv: kernel-doc fixes 2026.2
Date: Thu, 04 Jun 2026 22:08:42 +0200
Message-Id: <20260604-kernel-doc-cleanup-v1-0-c4c4d4a77c31@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAErbIWoC/yWM0QqDMBAEf0XuuQcxioX+SulDclnbayVKoiKI/
 27a7tsszOyUkRSZbtVOCatmHWOB+lKRvFx8gjUUJmtsZzrT8gcpYuAwCssAF5eJUWZ9018bqam
 IU0Kv2y96J+9mF1Z6/P+8+Ddk/hbpOE6s3CYRfgAAAA==
X-Change-ID: 20260604-kernel-doc-cleanup-eeee2b3f73c1
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1818; i=sven@narfation.org;
 h=from:subject:message-id; bh=b07xgeDQ97MdiLNgl2oYALAaf+t5g5bfDtjeKJFRg9k=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFmKt72rH6uG8XGbnW3J8V+xmeW+tWFowPpazedfG29oT
 rxw+/GFjlIWBjEuBlkxRZY9V/LPb2Z/K/952sejMHNYmUCGMHBxCsBEthUz/LNeOD2xTDQy99vr
 dQtZfootufJdgr3ayt28QUrC/dYBgUUMv5h//C9+Hf5GaHm0ETOP5F6DzX/1GmN/+2Ws49jBIBb
 owggA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: ZPBIZJJ2RFZ2ATASSG6WFKXDZVJOTCMU
X-Message-ID-Hash: ZPBIZJJ2RFZ2ATASSG6WFKXDZVJOTCMU
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/ZPBIZJJ2RFZ2ATASSG6WFKXDZVJOTCMU/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

During the (recent) integration of various fixes and cleanups, some of the
kernel-docs weren't correctly updated. This patchset should sync the
kernel-doc again with the actual implementation. But at the same time, I've
noticed other (older) kernel-doc problems and just added fixes for these in
this patchset too.

The only common thing these patches have - they are kernel-doc changes :)

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Sven Eckelmann (5):
      batman-adv: tp_meter: update stale kernel-doc after refactoring
      batman-adv: bla: update stale kernel-doc
      batman-adv: uapi: keep kernel-doc in struct member order
      batman-adv: fix batadv_v_ogm_packet_recv error handling kernel-doc
      batman-adv: fix kernel-doc typos and grammar errors

 include/uapi/linux/batadv_packet.h     |  6 +++---
 net/batman-adv/bat_v.c                 |  2 +-
 net/batman-adv/bat_v_ogm.c             | 10 +++++-----
 net/batman-adv/bitarray.c              |  2 +-
 net/batman-adv/bitarray.h              |  2 +-
 net/batman-adv/bridge_loop_avoidance.c |  2 +-
 net/batman-adv/bridge_loop_avoidance.h |  2 +-
 net/batman-adv/fragmentation.c         |  3 ++-
 net/batman-adv/hash.h                  |  4 ++--
 net/batman-adv/mesh-interface.c        |  6 +++---
 net/batman-adv/netlink.c               |  4 ++--
 net/batman-adv/originator.c            |  4 ++--
 net/batman-adv/tp_meter.c              | 16 ++++++++--------
 net/batman-adv/tvlv.c                  |  4 ++--
 net/batman-adv/types.h                 | 24 +++++++++++++++---------
 15 files changed, 49 insertions(+), 42 deletions(-)
---
base-commit: 7fb5fc7265f6ce4962357c5383873fd2ef9d50d4
change-id: 20260604-kernel-doc-cleanup-eeee2b3f73c1

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

