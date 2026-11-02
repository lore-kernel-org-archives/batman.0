Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C56606A324
	for <batman@archiver.kernel.org>; Mon,  2 Nov 2026 21:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=sWYgP2CA
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id E0293825CD
	for <batman@archiver.kernel.org>; Mon, 02 Nov 2026 22:27:18 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1793654838;
 b=mr3ukr80b7Ez4GJoaPSu+noKMJ6RkI4ViOCVd0s4+C9KtOAYvKiYz6YjINjflNFqTc7Yi
 IJ+XZDcFDDFw2kbt09FQAK8+sl7YXGwQEfd0i8dN5TUngwJwlqq0WrDziL+l8LUGX/7r5DN
 fAGpGm+dEp9Zw5eAp/dIS2SyOM+F1iA=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1793654838; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=8hZosCOztUxW+mzrQyqBRklr7S/rzoq1CFfWL3XfCO8=;
 b=0V8r/dVkEJgKjv5zwGRxqD1rjzDv242CWOM49BMaAVgk848bRMmvyWClRm6Q2D+EwyWAy
 s+CQN1FpxhrL/YPXj26MadEXttMO7P48UpZGfj5X2TuEHmD0mBptE4ogHcD1tAj8pge8XNs
 N538Y+KbMqnBN8GvngttdcIdH7oMTOU=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id F1BB980D64
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 02 Nov 2026 22:27:05 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1793654826;
	b=sAurPbaphc+QnwtgfE42Az4pBh8Dspmz0nO2o7USAgjMFIUXqbo3a97amje+VwhxluRXU6
	ST27rvi1HyxtkI1qIMeKTl7dcFd5c6rjg3xSIR6FtbjLnzef9ipj2JJJT/If885NS6OU0L
	CeQ3woaUFuxzNOrAwixA9/oTefA+nP8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1793654826;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=8hZosCOztUxW+mzrQyqBRklr7S/rzoq1CFfWL3XfCO8=;
	b=l6ptEJMMXGHTJgnH8Oi0Gfn/EiiJs5+ux/U9oUPxV3Telq8slR8jHjrmm13trnZ97RaR3c
	PLIc34RRI+Nt9x0pBuHycZlEykoYZkGowh8bgLtzXAdexnlJ3OzJWcw/Y7KQslBjsaixun
	Po87Xt2nE34Wen6uR1v38qt0gBn02/o=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=sWYgP2CA;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 092C31FDF5;
	Mon, 02 Nov 2026 21:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1793654825;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8hZosCOztUxW+mzrQyqBRklr7S/rzoq1CFfWL3XfCO8=;
	b=sWYgP2CA4YOiSmA40C47ZWUzgoE1ETAd0ASE5696qddG1gEi8JYeLxiicUj6FcAP/U8vWb
	5v8yyNbGIaa++mDMd6hXprs4Lr8CWbaxltSLwPns2DlrJ25hhIwyr5Lsnm3fyrqb8sWnu4
	38RJ/5c3y4cSyruhD25yEozBUQnyVn4=
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH batadv v4 0/5] batman-adv: allow to specify limits for
 remote learned objects
Date: Mon, 02 Nov 2026 22:26:56 +0100
Message-Id: <20261102-resource-limit-v4-0-7ff9da793db4@narfation.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACAA6WoC/3XOyw7CIBAF0F8xrMWU4dHiyv8wLigdFKOtASQa0
 38X60LjYzmTO+fOjUQMHiNZzm4kYPbRD30ZxHxG7M70W6S+KzOBClQlmaIB43AOFunBH32i0jL
 DodGNqy0pR6eAzl8mcE1ak0yXyea5j+d2jzY9tEdy52MawnVqzmzK/yvJjFZUOalrrirsoF31J
 jiTyq+LIWynggzvhP4ioBCi0ZZbzbSR4hfBX0QN4ovghWixEdJB7ZyCT2IcxzsRWC10UAEAAA=
 =
X-Change-ID: 20260516-resource-limit-5c1a32898f7c
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3341; i=sven@narfation.org;
 h=from:subject:message-id; bh=+SmRYmYNlT2zGK5btyKjJXkwX+xGidigk3WWuHykFek=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFkvGVQuL339OmHd26MCIjxHlpzP3LKlyd2TaWPdtndO/
 qvqvrvv6yhlYRDjYpAVU2TZcyX//Gb2t/Kfp308CjOHlQlkCAMXpwBMZI8OI8O9b/uYjpbznWk/
 uq9mj/ObE98DFXlP3Nh+7O2HNS73m8+7MPyv2+Qy951kZJ+pfGzJrPX8seud5+moyOqct3Y4IKf
 7p44FAA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: JN723QTDYX672XMNYPJJS5AUFJPTSQZO
X-Message-ID-Hash: JN723QTDYX672XMNYPJJS5AUFJPTSQZO
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/JN723QTDYX672XMNYPJJS5AUFJPTSQZO/>
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

There are some concerns that an external entity could spam the batman-adv
related interfaces with random mac addresses. The batman-adv would use more
and more resources to safe things like neighbors, originators, TT, ... and
would at some point run out of resources.

One idea is to limit the number of entries for each resource type could
have. Things which might need limits

* orig_node
* hardif_neigh_node
* tt_local_entry
* dat_entry
* bla_backbone_gw
* bla_claim

Things which are limited by other things (maybe)

* neigh_node
* gw_node
* orig_node_vlan
* orig_info

Unknown how to handle overly large tt_global_entries:

* tt_global_entry

This approach is also used for the bridge since commit bdb4dfda3b41 ("net:
bridge: Track and limit dynamically learned FDB entries"). And it is also
disabled by default.

For the moment, I just want to demonstrate how this might work with some
example code. I didn't invest any time to actually check out the other
items in the list. So, please consider these lists as vague suggestions.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Changes in v4:
- document special '0' limit in batman_adv.h
- document "random IP" addresses create more DAT entries instead of "random
  MAC" addresses"
- limit batadv_hardif_neigh_node instead of batadv_neigh_node to match what
  is outputted via BATADV_CMD_GET_NEIGHBORS
- rebase on post-2026.4 patches
- Link to v3: https://patch.msgid.link/20260724-resource-limit-v3-0-be845f27ff62@narfation.org

Changes in v3:
- remove RFC
- rebase
- adjust commit messages to mention correct bat_priv members
- exempt own_backbone from resource limit
- keep BLA counters in batadv_priv_bla
- keep DAT counters in batadv_priv_dat
- avoid new over-allocations by first incrementing and then deciding
  whether too many items would have been allocated
- move the decrement of learned to release function (when possible)
- Link to v2: https://patch.msgid.link/20260519-resource-limit-v2-0-489c3c919a54@narfation.org

Changes in v2:
- rebase patches
- Link to v1: https://patch.msgid.link/20260516-resource-limit-v1-0-6f597360ed2b@narfation.org

---
Sven Eckelmann (5):
      batman-adv: limit number of parallel learned neighbors
      batman-adv: limit number of parallel learned originators
      batman-adv: limit number of parallel learned DAT entries
      batman-adv: limit number of parallel learned BLA backbones
      batman-adv: limit number of parallel learned BLA claims

 include/uapi/linux/batman_adv.h        | 30 ++++++++++++++++++++
 net/batman-adv/bat_iv_ogm.c            | 15 ++++++++--
 net/batman-adv/bat_v_ogm.c             | 15 ++++++++--
 net/batman-adv/bridge_loop_avoidance.c | 46 ++++++++++++++++++++++++++++---
 net/batman-adv/distributed-arp-table.c | 17 ++++++++++--
 net/batman-adv/mesh-interface.c        | 15 ++++++++++
 net/batman-adv/netlink.c               | 50 ++++++++++++++++++++++++++++++++++
 net/batman-adv/originator.c            | 22 +++++++++++++--
 net/batman-adv/types.h                 | 33 ++++++++++++++++++++++
 9 files changed, 231 insertions(+), 12 deletions(-)
---
base-commit: d723c2a066d72e1846c3ed81a89c3ae288ec5787
change-id: 20260516-resource-limit-5c1a32898f7c

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

