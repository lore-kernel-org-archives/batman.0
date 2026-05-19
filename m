Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EB90CD4F5B
	for <batman-adv@archiver.kernel.org>; Tue, 19 May 2026 07:09:19 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id AC7FF805DF
	for <batman-adv@archiver.kernel.org>; Tue, 19 May 2026 09:09:16 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1779174556;
 b=vY61vnKsmpWBSYZILvvyaXP07G9F0pePmPRegCQRK4KWRyabNf0jyz2ZSJz8UYAidt4sc
 ZtvC0dm5j8XtwqCT0OpQ+xR2zgqGKg76mGScXg8bW5TZRbH0wWD1TGNmfSpozZoZgYodDSu
 OsySpN9llHI0x8N7sJuEpvx136sAZ5Q=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1779174556; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=DBtXw6BVyT250iH/eAVZaqnOafNZLEMZmLoczUq/K+o=;
 b=GFtoPsMJsFR4I37ZKGN+bHo7Qs/FZFfiojccVI277kodo5KzQAzjU1EGDMtZWaJ9+3JOe
 s9bwu06/VXyY9XWfeCiaKpkayxBanInprFRJh7Enwp8PogEMDiKX1S+lachdZhXA/lrhc3/
 bMOUuk0K5JYpOIDDmyF8FgpXNakScUI=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id BF7D680D3E
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 19 May 2026 09:04:42 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1779174282;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=DBtXw6BVyT250iH/eAVZaqnOafNZLEMZmLoczUq/K+o=;
	b=jtzL3PsDhJhsw1vgODtXAeNf+TBv9/90D0SO7VT3cEKk2PEUkXH2ieU8WPDRDUxQrwJVhe
	7Shc4fF62xKAmDzbKnEXKs8Lr7sy7Qp6vZEGBIeY6CjOrKlkfd+oDl4FkTgXK4O3aU9Puh
	KPzavDtxXh95aJ7uq8dG6NPgf5Fg5Rc=
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1779174282;
	b=l5dK6IMfwEHLIceriqkSxchyq28GoYxF/rN/VpPaUFiQyy2w2+KapU9OI1Mip31OXkMOBb
	LC9farVb/nx2CQo0hgaXzvqLmYtKPTNVDvdn8Wz6YVWcRR0vd2svNs5sn9/iGt4Hg03yH3
	sIHb7RcyCjI4ENAS0iIJlY2z6S8Jexc=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=ZsjV60ew;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 0E2661FE24;
	Tue, 19 May 2026 07:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1779174282;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DBtXw6BVyT250iH/eAVZaqnOafNZLEMZmLoczUq/K+o=;
	b=ZsjV60ewPFmuGtEN5cCHU55Nndwpt0WpuDJHsPMe0GkMz3+MZFrgHw4z09fy7hTBvLL9bY
	pgF6Kpbw214km5Sp2snUUPTQfPRRshe51NQbnHCPKMuE3rdJ3yAPJufsCzwTdE0+DdHzRm
	ZiyNcJAqRe27P7gZC7TLuIrHYQbLH+8=
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH batadv v2 0/7] batman-adv: replace non-atomic fields with
 (READ|WRITE)_ONCE
Date: Tue, 19 May 2026 09:04:35 +0200
Message-Id: <20260519-atomic-to-write-once-v2-0-1b643e847a56@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIQLDGoC/32Oyw7CIBBFf8XM2jFA7ENX/ofpgsK0HRPBAKKm6
 b9L697lvTn3MUOkwBThvJshUObI3hWh9jswk3YjIduiQQlVi0oq1Mnf2WDy+AqcCL0zhKdWSGp
 t3VctQYk+Ag383mqv0OukbYbu58dnfyOT1s6VnDgmHz7bfpYb/38qSxTY1PqoGjVoI+zF6TDoV
 H4ffBihW5blCxY0mGjWAAAA
X-Change-ID: 20260512-atomic-to-write-once-9801e8d6b58e
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2584; i=sven@narfation.org;
 h=from:subject:message-id; bh=6NFJ0rnv+Q7WcQTmI2jvSonHebrFr6fhhjuOQDogaRg=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFk83K2pkXIrxY+ucPqgzy9cs+70xbyH6zibM758uJpxQ
 PVTbbhARykLgxgXg6yYIsueK/nnN7O/lf887eNRmDmsTCBDGLg4BWAiS74w/LM5sMZNMqBqp+ZF
 z0vzmz7kpfVOmcJTa5sw5/yfVpPGRW2MDN083NpcLebMZvU17gWsxzckT9+/QJLvdvK1hu2/Xv4
 6xwgA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: Q4UFF6TFRWNFCG6STBUOB2DHCV5UIBTZ
X-Message-ID-Hash: Q4UFF6TFRWNFCG6STBUOB2DHCV5UIBTZ
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/Q4UFF6TFRWNFCG6STBUOB2DHCV5UIBTZ/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Many fields in the batman-adv datastructures are only accessed as plain
loads/stores and do not require full atomic_t semantics. Convert these
fields to native integer types and replace their users with
READ_ONCE()/WRITE_ONCE() to avoid load/store tearing.

This was noticed while searching for other atomic_t code which
(incorrectly) does things like:

    if (atomic_read(foo)) {
        do_important_mutual_exlusive_thing();
        atomic_set(foo, x);
    }

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Changes in v2:
- rebase
- Link to v1: https://patch.msgid.link/20260512-atomic-to-write-once-v1-0-76a4272fac0d@narfation.org

---
Sven Eckelmann (7):
      batman-adv: replace non-atomic meshif config fields with (READ|WRITE)_ONCE
      batman-adv: replace non-atomic hardif config fields with (READ|WRITE)_ONCE
      batman-adv: replace non-atomic vlan config fields with (READ|WRITE)_ONCE
      batman-adv: replace non-atomic mesh state with (READ|WRITE)_ONCE
      batman-adv: replace non-atomic packet_size_max with (READ|WRITE)_ONCE
      batman-adv: replace non-atomic last_ttvn with (READ|WRITE)_ONCE
      batman-adv: replace non-atomic last_acked with (READ|WRITE)_ONCE

 net/batman-adv/bat_iv_ogm.c            | 28 +++++++------
 net/batman-adv/bat_v.c                 | 10 ++---
 net/batman-adv/bat_v_elp.c             |  9 ++--
 net/batman-adv/bat_v_ogm.c             | 13 +++---
 net/batman-adv/bridge_loop_avoidance.c | 14 +++----
 net/batman-adv/distributed-arp-table.c | 16 +++----
 net/batman-adv/gateway_client.c        |  6 +--
 net/batman-adv/gateway_common.c        | 14 +++----
 net/batman-adv/hard-interface.c        | 15 ++++---
 net/batman-adv/log.h                   |  2 +-
 net/batman-adv/main.c                  | 22 +++++-----
 net/batman-adv/mesh-interface.c        | 38 ++++++++---------
 net/batman-adv/multicast.c             |  4 +-
 net/batman-adv/netlink.c               | 77 +++++++++++++++++-----------------
 net/batman-adv/originator.c            |  3 +-
 net/batman-adv/routing.c               |  6 +--
 net/batman-adv/send.c                  |  6 +--
 net/batman-adv/tp_meter.c              | 28 ++++++-------
 net/batman-adv/translation-table.c     | 24 +++++------
 net/batman-adv/types.h                 | 68 +++++++++++++++---------------
 20 files changed, 204 insertions(+), 199 deletions(-)
---
base-commit: ff182fc0c666754e3f35f7b63c9ccf0dff239e52
change-id: 20260512-atomic-to-write-once-9801e8d6b58e

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

