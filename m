Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9B44CC6B27
	for <batman@archiver.kernel.org>; Wed, 14 Oct 2026 07:48:26 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 3D8EE81F65
	for <batman@archiver.kernel.org>; Wed, 14 Oct 2026 09:48:25 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1791964105;
 b=QydCJi3opgDH7RMRBxXnZvjEgDxjkrWOIpUpl+igBhuoi0rIPUxCoR6dGFKRwLFrrwxRs
 0M0i3f3BMvEUjCUE4xZR7Uu4gLWfiS+Lm8ygeTX8J0wxz4UAZwa4swm/Rz+tjp2h8A9p4HK
 bW3UeSKF39baeHXb4nS9Fkd3eXAPpVs=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1791964105; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=KHKpFfjnhQR2SMC5Qem0vEEeZ/9cQGadOiM37y04Utc=;
 b=ZA54Y3nxgevMtRIdPE2rQVDN6RrBrSmJ52yAvzR1wd5tGHtcUVYt9lR6NzhXwraFPl1yR
 2V0RH2eDO4rIonK8rYqEVT4v/bs1qMHKSQ9wfX7VtHx74eJ8tB6uLuqVQh0AssRPH8Z8hkw
 R5IDXnOuFzIpiOzSorFTlpKQCtOH+d8=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 63F0384230
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 14 Oct 2026 09:46:27 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1791963997;
	b=wkbEsI4K/jj1Pe3+Lx+ashpBMf30BG0XbUI+stiE62Dqvsy2TzSUY4whOYLdIO69xMgyhX
	or11nXls/0V/ytWCTU3TBPinx7AfH03JaAg9MgkpJWRtb9kEpwCq19iLkAuGRLJEaDBDI4
	MxDYieImge0fqsmlfRDu3E0zuz8/Q9c=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1791963997;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=KHKpFfjnhQR2SMC5Qem0vEEeZ/9cQGadOiM37y04Utc=;
	b=e04QDFth8CggjQBZrD6sU6jLds6gEevDowXOTSyT4iXCzGtR1UPtgeUeAxmKxnXWBmoigs
	bW600/dn2qohWDiDadJdd81nKH/XdE/dThDM/lPAsR6HIUOkkkCsoSOJVM//AZp6M/SKme
	RyjEHfb6rJx6feJHcKxHu8OQwtBxhxk=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=GPCQ3xPV;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 30C0B20411;
	Wed, 14 Oct 2026 07:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1791963985;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KHKpFfjnhQR2SMC5Qem0vEEeZ/9cQGadOiM37y04Utc=;
	b=GPCQ3xPVWGpFJKX+XxvKkoxS/ksDVrwhGGVHrpIkWv/aCpL2txnbYrqjZOkfJrNNUH5bA5
	kbBj8GN3q3OLx8v2cM+v4auaKRV4we3ub0H0ZAb5MQbItQAzO7LNEQLdYYU8zewUt8Qjwy
	WQYmgzwy2FBpYdET65PEXDC1rLbimjk=
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH batadv v2 0/6] batman-adv: make aggregated hash keys easier
 to identify
Date: Wed, 14 Oct 2026 09:45:59 +0200
Message-Id: <20261014-hash-key-v2-0-7cb91c7df2cb@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADczz2oC/2WOQQ7CIBREr9L8tRgophBX3sN08Vs+BU2oASQ2T
 e8urUuXM3l5Myskip4SXJsVIhWf/BxqaE8NjA7DRMybmqHlbSe4kMxhcuxJC1PSKq1Id0peoOK
 vSNZ/DtUdBsxoCvS/Pr2HB4159+yk8ynPcTk2izj4f30RjDMuFSdrjB4NvwWMFnP9d57jBP22b
 V9TPWdlvgAAAA==
X-Change-ID: 20261013-hash-key-73f787e86734
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1757; i=sven@narfation.org;
 h=from:subject:message-id; bh=Y+g/jSwJ0tAxBOEyoJOHh5JIkE3kISiM+9obuswpvuY=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFnnjT0/V7K+f7ynUj+q4KGurYBGw7uPP+wXnNuYtGfby
 V96c2Q1OkpZGMS4GGTFFFn2XMk/v5n9rfznaR+PwsxhZQIZwsDFKQATeSDM8D9gwqSJp4/7L7vw
 kGPifM1DpUdrZ2adfLzV4LikvibDbS0/Rob/O1TeSVj+kohZmbRzehG/cm/Chf1O7tKJGQm3PWP
 9/DgA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: XSOWB6KRONG42EBVR7IKCY2A2B2MACAK
X-Message-ID-Hash: XSOWB6KRONG42EBVR7IKCY2A2B2MACAK
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/XSOWB6KRONG42EBVR7IKCY2A2B2MACAK/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Some of the fixes in the recent past were about the incorrectly hashing
and/or comparison of hash keys. I took the opportunity to have an easier
identifiable key for the hashes by using a separate struct in case they are
aggregated types.

As side effect, it is now possible to reserve less stack space when trying
to find an hash entry. Only they is now needed for the search.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Changes in v2:
- resend due to problems in the sashiko pipeline
- Link to v1: https://patch.msgid.link/20261013-hash-key-v1-0-0370efdd8cd0@narfation.org

---
Sven Eckelmann (6):
      batman-adv: bla: use dedicated key type for claim hash
      batman-adv: bla: use dedicated key type for backbone gateway hash
      batman-adv: dat: use dedicated key type for DAT hash
      batman-adv: tt: use dedicated key type for hashes
      batman-adv: originator: pass explicit key to orig_hash
      batman-adv: hash: document key argument of hash operations

 net/batman-adv/bat_iv_ogm.c            |   2 +-
 net/batman-adv/bat_v_ogm.c             |   2 +-
 net/batman-adv/bridge_loop_avoidance.c | 201 +++++++++++++++++----------------
 net/batman-adv/distributed-arp-table.c |  73 ++++++------
 net/batman-adv/hash.h                  |  13 +--
 net/batman-adv/originator.c            |  19 ++--
 net/batman-adv/originator.h            |   2 +-
 net/batman-adv/translation-table.c     | 177 +++++++++++++++--------------
 net/batman-adv/types.h                 |  57 ++++++++--
 9 files changed, 291 insertions(+), 255 deletions(-)
---
base-commit: 0a79fef370780da6a67906bf2d83be8e2bd4e24d
change-id: 20261013-hash-key-73f787e86734

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

