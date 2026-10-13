Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0AC1CC6B12
	for <batman@archiver.kernel.org>; Tue, 13 Oct 2026 18:47:59 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id E510A83E09
	for <batman@archiver.kernel.org>; Tue, 13 Oct 2026 20:47:57 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1791917277;
 b=HkVI2+Oso2rGl9wN5Ff8z1lIB6RVaH55TbnAR8myojU0Do4RQZrpOfP2tMxVXPIUs1g6/
 YyyW1G/JiSdHkK2Ea6zBwadjBUZUpxxUH+tculrsBhY1dfo3oxCACBVNnd/TqdnBApGTxZt
 hitNRMwZmFvlaehOsuBpO6qq8KVu4mA=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1791917277; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=NYOsV4+8AmVePeTc/GLSdCsOjbf3pQWsVNVUCCaUFh8=;
 b=g84pFUHt9wVY4q70epuOUylNXE+YFAQqH8yNMWxbqqq4dXuW6kvwL5ds5CT+GTR4dwkvS
 qe8P+Faa35bwBih6Udkb6vjE0Tj7K9hshazh7Py5B/DQx+ymfzsQQDQHCj/E0/MKa7Vctyv
 fIYzdLRuZn63Y9A87A04b9jBp+4qHrI=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id A752A81C22
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 13 Oct 2026 20:47:37 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1791917267;
	b=Y/6vb9salrZkuHohuWWC4Sp4flKcL+hya4VNt/3PtT+Yq7qdmktaNiJS78ZJKvt4Ab5rKW
	GJtUz7w2r0qsDx6kWm5El/jivlLRwJKoGXk3ThOYUFQ/VNbmIEbK/9NlXOZp7KY81QNKIm
	8nKAkTwapG1/KZlenU+4e+9A7F1ZVmg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1791917267;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=NYOsV4+8AmVePeTc/GLSdCsOjbf3pQWsVNVUCCaUFh8=;
	b=OyL2/PEh//6HyxZBlinvEsI1+tVebdy6dmAxUG8BZkQ5cNltSdDFeGHVMf7wFe1XJijfYY
	xQezHLHwHt+M0KkQHkQyJe7qNXw8RV+bs7jwphb/cymiZpMuNUi48Tqzo/arWPpk0TEdwb
	XfgqBHgUt8bcIkcoxUy6/CcYFrxUzvo=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b="G/A2TFwt";
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id AA80D20281;
	Tue, 13 Oct 2026 18:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1791917256;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=NYOsV4+8AmVePeTc/GLSdCsOjbf3pQWsVNVUCCaUFh8=;
	b=G/A2TFwtLEZvV1+Tq7hiV7u4zEN+sqD4dwaCCdlNbVAnmsnPdZ2HCBc6nTvypoTv2iLmpg
	0N0wDet9EZwQM9XzZEgnhCXDZOZcZ7kNOI1Fw+0eYEiXYYrkTdtvsUxTNPYHAvpEZhGN+K
	N49bBM6GRQSl9oYK7gtjW2tgzEkgYc0=
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH batadv 0/6] batman-adv: make aggregated hash keys easier to
 identify
Date: Tue, 13 Oct 2026 20:47:28 +0200
Message-Id: <20261013-hash-key-v1-0-0370efdd8cd0@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMB8zmoC/yWMQQqDMBQFryJv3YAxxYhXkS6ifpuvoJKvooh3b
 7TLGYY5IRSYBGVyItDGwtMYQb8SNN6NX1LcRkaWZrlOtVHeiVcDHcqazhaWityaN2I+B+p4f1Y
 Vare4dsPn72Wte2qW+4Pr+gHsjajHdAAAAA==
X-Change-ID: 20261013-hash-key-73f787e86734
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1594; i=sven@narfation.org;
 h=from:subject:message-id; bh=36fmx3wkaszkHrBpf9b3whzYw41PHs6G8IFHwTFMPk8=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFnnag4dF6potL0X+Lf1jF7L9+kvheX7ql0f/FhZMX11F
 2POzP9HOkpZGMS4GGTFFFn2XMk/v5n9rfznaR+PwsxhZQIZwsDFKQAT6RVgZGhkDl7k1X6zTs9f
 7feZu2rXu0yaViYrxF3dIKst3HKNs4+RYbHCH9+j6hznNt7K25UVKfpO9e6eza8POC30n9r2V07
 FgA8A
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: PM4DDAYPACU2WKIYR5BHRJUONRWSO75M
X-Message-ID-Hash: PM4DDAYPACU2WKIYR5BHRJUONRWSO75M
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/PM4DDAYPACU2WKIYR5BHRJUONRWSO75M/>
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
base-commit: 0eaac0f4187bc9b69b41d90998fd7b93ab07e53e
change-id: 20261013-hash-key-73f787e86734

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

