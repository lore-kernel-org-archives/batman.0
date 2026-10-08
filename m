Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94AE5CA6007
	for <batman@archiver.kernel.org>; Thu,  8 Oct 2026 14:30:46 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 8D80384292
	for <batman@archiver.kernel.org>; Thu, 08 Oct 2026 16:30:44 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1791469844;
 b=rDtz/iwJ69r86wEkwKwNJTaDB/JNcToLtWnN7Zn3bL+LiwotLPXq7K1/PUYz/mb1ElGl9
 QMR5fPOcsP26Y9CsDzAB9AA7kmwybKZcwnJZy1ZpraDVp6m/eVIyg0qlBF7nZl8jlfCA3+l
 2Wm0hOiGyzDXsklNiJss3VWIaE6hl9E=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1791469844; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=nUajgh9fBWYuSkNGvxDecT60YrVF5D3rHAQQiGDjYc8=;
 b=yRSYKpLbZ4oRYCiOf0xODylWReHH4+waCXYQLxdL6EXVQJACYuYo3VT9gGSD/8FmkoB/x
 r+E6yrYiiXktlC0Tu5R3rC+4OyqSWeu1bLF9WaDDQJCrprTEOk5g0RjTYXbk966qA1Nh9Ha
 P9AMXPWG5AH/rAGD+3DDsIBYsG+K8A0=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 1B86280D4F
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 08 Oct 2026 16:30:25 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1791469835;
	b=htC8Buz3abbjl7uILbr9flsdEEAH2maX+hrA1p+0tk9sZqdCp0rBnW/UoygnLZihHKYDfH
	pb67rcQUAVv1sDdDK0zhDvLiO0hiwDY1hzDbZ26SeekqWNxFxfk2rXhWQOhQrn6PDNITLh
	xR8d3WW8V61Ic0Hp6ELcQncdb/qh7ZE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1791469835;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=nUajgh9fBWYuSkNGvxDecT60YrVF5D3rHAQQiGDjYc8=;
	b=oylaEN+EjorZth5P0GD4nLfUChPSp+ul6sdd8vGYdTCNerj4Cn2fk3fgaZQnNQ819HaMWo
	XqGbli5t2UvGN9TMqoGnrGlmbhb8/q0tyPPdLS3sPASMajOdIKVefOZA3HzuO5kpj9mmBX
	Ev9AqREuPLcOA/d+hi3g/JRXCScn2go=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=hKhTRtgg;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 1DEAE1FEA4;
	Thu, 08 Oct 2026 14:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1791469824;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nUajgh9fBWYuSkNGvxDecT60YrVF5D3rHAQQiGDjYc8=;
	b=hKhTRtggWzBwxe6bKdFNKSj7Q114pv+UIvOFDHkXSA+sd9NpMcu5QVnawXSTcJTZfUdilF
	vQn32/iTdcxYbxK9x8P2M435o8vVZFIehNRDgyCohhCZZAMrwC6iXHT0Ra0EYjLckpaakP
	6epjRO6bHDi3SvHjL0zUR45NtScsatg=
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH batadv v2 0/8] batman-adv: tt: shashiko 20260930 follow ups
Date: Thu, 08 Oct 2026 16:30:05 +0200
Message-Id: <20261008-tt-avoid-unhashed-event-v2-0-7c4eed81606d@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAO2ox2oC/3WOTQ7CIBCFr2Jm7Rio6RBdeQ/TBZRpwQU1QImm6
 d2l1a3L7+X9LZA4ek5wPSwQufjkp1ChOR6gdzqMjN5WhkY0JIUgzBl1mbzFOTidHFvkwiGjImP
 agchK2UJNPyMP/rU338HorG2B7qun2Ty4z1vt5nQ+5Sm+9wtF7v7fmvq7ViQKFLJXdKZWXSTdg
 o6DzvX9aYojdOu6fgAlXC3z3AAAAA==
X-Change-ID: 20261006-tt-avoid-unhashed-event-76bb5f66d115
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>, Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1715; i=sven@narfation.org;
 h=from:subject:message-id; bh=s0+hu1SKUqaPmYT2EH7yfpD7WfszMMQ4XV0EpjjdKIs=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFnHV7y/vGuqFFujrDE3Y303614Gvpii73VRs557Kv4Qv
 c13M6Wqo5SFQYyLQVZMkWXPlfzzm9nfyn+e9vEozBxWJpAhDFycAjCRaAWGX8xnNuYuNeX+0R2R
 8dzb78o9zxvrtJuzlkx4wcNw/6ljmwQjw9lboSFle/7Ouv6k4qs0Q5zZ9mtrm/sXyW1ftDtr2Ub
 dGWwA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: XZ6ZSPWZ7CSDRT74VEWFRMBNSDLY3MKC
X-Message-ID-Hash: XZ6ZSPWZ7CSDRT74VEWFRMBNSDLY3MKC
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/XZ6ZSPWZ7CSDRT74VEWFRMBNSDLY3MKC/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

There were various reports in the Sashiko report from

* https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260930094558.3723766-2-sw%2540simonwunderlich.de
* https://sashiko.dev/#/patchset/20260930094558.3723766-1-sw@simonwunderlich.de

Some of them are about the rather bad locking behavior in TT and addressed
here. While looking at this, it was also noticed that the TT event handling
seems to be broken since the introduction of dynamic flag changes.

As Sashiko now already complained about the ROAM flags, i have added the
ROAM flags handling patches in front of the original patchset.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Changes in v2:
- add patches to handle ROAM flags differently
- Link to v1: https://patch.msgid.link/20261007-tt-avoid-unhashed-event-v1-0-01c763657916@narfation.org

---
Sven Eckelmann (8):
      batman-adv: tt: only transmit local ROAM flag together with DEL
      batman-adv: tt: clear ROAM flag when re-adding a pending local client
      batman-adv: tt: send ROAM_ADV on each roamed back client
      batman-adv: tt: ignore ROAM flag of received ADD changes
      batman-adv: tt: only update flags for TT events
      batman-adv: tt: don't queue local events for unhashed entries
      batman-adv: tt: avoid list_lock for unchanged local clients
      batman-adv: tt: drop ADD+DEL events of never announced clients

 net/batman-adv/translation-table.c | 417 +++++++++++++++++++++++--------------
 1 file changed, 264 insertions(+), 153 deletions(-)
---
base-commit: 0eaac0f4187bc9b69b41d90998fd7b93ab07e53e
change-id: 20261006-tt-avoid-unhashed-event-76bb5f66d115

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

