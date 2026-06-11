Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07F8FCD98C7
	for <batman-adv@archiver.kernel.org>; Thu, 11 Jun 2026 17:24:39 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 5881783EF9
	for <batman-adv@archiver.kernel.org>; Thu, 11 Jun 2026 19:24:38 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1781198678;
 b=PWANjyql62xgbWFxJca6TTG7HbKRbri46JnlGj0l9DdSk3AGBjvjy8dT12NdxT7bX/jdR
 PSOwiR9R0auFXMTNs++aTe2ookahOdbcaUzEAumMPjJTZtrwKuXwEtZFQr0/S7Aa1jXG20V
 zaYktKXEhulfm/fxB/RCYbeMAvEmyB0=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1781198678; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=ftJOfMad88fHRLewx4xxu6QCb9sojZzqDFeDJDbdtnE=;
 b=eNZzJvSj6UFy9GaQa0QQwlT5CCq/mjb27vbpJk4pnms/CLvEpKdM4kwA38hSBHEJaQpXv
 kSI8iBjKRjn34gQXE/Pv4gbeAVsgjJatLrWN8gzSjBBoNzN31NaCOUvRvRcz0/3HVBVziPa
 3B3nSnC52Ds95+5EppmysAIZo8Byee4=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 23E7580794
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 11 Jun 2026 19:24:18 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1781198668;
	b=gooDCvW4JSomNtHTyo4UMZOY0h8pAAraQTZrFJs+IFqubevkCeD8crZU2upq2/vCXmPvKc
	4JjyErDLNmyHGx3Mv8wu88kaXt8swAn0L36wBT6zfrQpAplLlycuSg4nIZ2PSuCdqD2yVX
	ivck8ujX+v7qgQtJ+d5ja1r8mtQWAcI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1781198668;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=ftJOfMad88fHRLewx4xxu6QCb9sojZzqDFeDJDbdtnE=;
	b=mbI8K20zh2UfSCqeieYflCIjkYZHV7fvmIR+Z9viH3x2vCOwWU3Web0n3fhjp2IrvtNb70
	IRBqC/3BrdrEiX51jVZtN4PZyAKYajOqMzZZPLTuZ8N/1yjc8zKQx6fNit+H2OzFuNln0/
	1JNLOHkh3zWRgNf9fWuiGYmvZy2JtBA=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=W77EuPPX;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org
Received: by dvalin.narfation.org (Postfix) id 6A1C420019;
	Thu, 11 Jun 2026 17:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1781198656;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ftJOfMad88fHRLewx4xxu6QCb9sojZzqDFeDJDbdtnE=;
	b=W77EuPPXNxNErRTgv0VY+V6Xd66b3cRtF3p9SlCpQNnu8JKyIbkVz3jRIcLKtbQAilNI2j
	FXrnmZkZpMsKtI2hwR7pNFOFs/TPDGMmEugNYn0T2fe/9f5GkDoKyBk9XwsuqsAfVIVaxh
	D/MNzxMIEwnDxBWYg3ryzIOm6TeiyhU=
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH batadv v2 0/9] batman-adv: tp_meter: unacked list/state
 fixes and optimization
Date: Thu, 11 Jun 2026 19:24:05 +0200
Message-Id: <20260611-tp-unacked-list-v2-0-47389466c5c1@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADXvKmoC/3WOwQ6CMBBEf8Xs2TVtDRg8+R+GQ9tdoGoKaUujI
 fy7Bc8eZzJvZhaIHBxHuB4WCJxddKMvQh0PYAfte0ZHRYMSqha1FJgmnL22TyZ8uZiQaqMbElJ
 euIJCTYE7994b72B00pSh/flxNg+2aavbkkPBx/DZp7Pc839XskSJQrGlpjqzIbp5HTqdytvTG
 Hpo13X9AjpbsX/MAAAA
X-Change-ID: 20260610-tp-unacked-list-d6ba9d0117e5
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2261; i=sven@narfation.org;
 h=from:subject:message-id; bh=M3e8kWYt/HoLHMMR0St4mBKeqTN9dxG0lBTdGnMVFTk=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFla7628ghzaazc7/Xwd9rr/w9e7NYXmOxeVbNFIkXzt0
 cohbHOzo5SFQYyLQVZMkWXPlfzzm9nfyn+e9vEozBxWJpAhDFycAjCRJV8ZGdb/OFwYeGRG981l
 jy/lPl4udnfW9oB7M/3ers8yaWwJKSlkZHhtYLdJ613s3+d/PjJFT32xn2mqyL2visc1JkXPKua
 QzuQEAA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: A4Q37SZG44QUQIIS4YOV6PT3JIRJLLKY
X-Message-ID-Hash: A4Q37SZG44QUQIIS4YOV6PT3JIRJLLKY
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/A4Q37SZG44QUQIIS4YOV6PT3JIRJLLKY/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

As we all know, after the tp_meter fix is before the tp_meter fix. I've
started to go through some of the problems in the receiver code and noticed
even more things which were real bugs and some things which required
cleanup/optimization:

* limit the number of entries in the unacked list

  - using an actual limit
  - by avoiding (merging) new entries when adjacent to an older (smaller seqno) one
  - by merging with newer (smaller seqno) entries in case a recently
    received one closed a gap in the seqnos

* concurrency problems

  - fix next Ack packet seqno corruption due to missing locking of RMW
    operations
  - avoid compiler induced data races when handling last_recv_time

* various code cleanups

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Changes in v2:
- rebased
- add "delay allocation of unacked entry"
- add "adjust name of receiver lock"
- add "combine adjacent/overlapping unacked entries"
- add "simplify unordered ack calculation"
- add "handle overlapping packets"
- add "prevent parallel modifications of last_recv"
- add "annotate last_recv_time access with READ/WRITE_ONCE"
- Link to v1: https://patch.msgid.link/20260610-tp-unacked-list-v1-1-02ecd953ebdd@narfation.org

To: b.a.t.m.a.n@lists.open-mesh.org

---
Sven Eckelmann (9):
      batman-adv: tp_meter: restrict number of unacked list entries
      batman-adv: tp_meter: annotate last_recv_time access with READ/WRITE_ONCE
      batman-adv: tp_meter: prevent parallel modifications of last_recv
      batman-adv: tp_meter: handle overlapping packets
      batman-adv: tp_meter: simplify unordered ack calculation
      batman-adv: tp_meter: combine adjacent/overlapping unacked entries
      batman-adv: tp_meter: keep unacked list for receivers
      batman-adv: tp_meter: adjust name of receiver lock
      batman-adv: tp_meter: delay allocation of unacked entry

 net/batman-adv/tp_meter.c | 255 +++++++++++++++++++++++++++++-----------------
 net/batman-adv/types.h    |  19 ++--
 2 files changed, 174 insertions(+), 100 deletions(-)
---
base-commit: 385b248dd4e46c4ce022adeb1b13e547d1954901
change-id: 20260610-tp-unacked-list-d6ba9d0117e5

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

