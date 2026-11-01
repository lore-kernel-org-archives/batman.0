Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21CF1606A325
	for <batman@archiver.kernel.org>; Sun,  1 Nov 2026 18:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=BW8VhvoW
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id B8A6580B80
	for <batman@archiver.kernel.org>; Sun, 01 Nov 2026 19:25:38 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1793557538;
 b=ggxlslBFqtb0kzNHFE5DxIL8KpWv8sTFmB0X/Nbv+DVYstIYoSWPmpGJf70G3VGoJb+Qg
 Bmq0VCrPpRklBFQquwyRj5GMr+7e2+3iTF+v8IlVMzhj7lwGQtFaDTqOQETNY/u6ow7xwfk
 Or4gYV4mWdykCKfAfTG5VKkBjo9yZ6s=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1793557538; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=dGORBoRXPi4oY7E4VH6CL7La5IJ3iCsPDpfLPbq6+ng=;
 b=xixfHocWSJcLVJcCpS9P52afyVBKTh08FPCKqFvpWQNmlqOmActOfX35K1qITxOoFEovh
 /4raWrlhZcbSP+Gzyu6WfCq1A4QUTymFtPu7qUKmekhR4LC/oBRd/7rHY2Tgt+0K8CMMqcD
 1t4SkZxnZSD8f4kXLFYUyN3vUjk4Pco=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 60F0D80B80
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 01 Nov 2026 19:25:13 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1793557523;
	b=fEo+v7nBcpSDMcQUfKGENFJAnaewpflRDaHFyuhDwhsnuvSHzYpuo7YSDP3SM0nbibzwhF
	KovO1axdPgw7vKKmhhJzUIeAnEYwhHrA1mUeDVuJRWy9wUe4WOpwZ9ywOkTNSB5ZyvZCIO
	Pq/mx65yHPMZNA1v8qAqZ1G0f/roSVA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1793557523;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=dGORBoRXPi4oY7E4VH6CL7La5IJ3iCsPDpfLPbq6+ng=;
	b=yKjDLXnr8LyyhF1fUAbCd0GZ7glHiTiYHXzHlylrYMh1a0Ag5T0Zq4djOAvWC2EQUepB/f
	dTCna6lpEMFvLfOOI22zjFrtD6KTBbcCzLrurJkuYt6E1wdxUUYA/nfO7cIkw0tZFs1pYV
	nY+PXxcMDcpTki0arXqiZBQ6qa6cPbk=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=BW8VhvoW;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id ABCE01FE4D;
	Sun, 01 Nov 2026 18:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1793557511;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dGORBoRXPi4oY7E4VH6CL7La5IJ3iCsPDpfLPbq6+ng=;
	b=BW8VhvoWdVmy6VKWrmmtmo/MzV/lzaT04+pOVlM+MgQPXkr+LQWW7nyB1ykaW+gk97KqQL
	DGWlPeJi2DXEShwPrHXsbvwtqBotTZPXDX9rFvmZwCsXVnW9OUtXikJIMrJM4tA9dWWifx
	mNWviqTQoOL0aa+FvpfZJuVMQbo6MVA=
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH batadv v2 0/2] batman-adv: prepare for context analysis
Date: Sun, 01 Nov 2026 19:24:43 +0100
Message-Id: <20261101-must_hold-v2-0-782bcc7d85fa@narfation.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOuD52oC/22Oyw6CMBREf4XctTW0QkFX/ochpo8L1Ag1bWk0h
 H+31K3LmZycmRU8OoMeLsUKDqPxxs4psEMBahTzgMTolIGVjNOS1mRafLiP9qnJmakK+7pSnLe
 Q+JfD3ryz6wZSBKEjdL/eL/KBKuyinRyND9Z98mikmf/jj5RQ0mgtZcu0aNTpOgvXi5AeHq0bo
 Nu27Qvp61RfwAAAAA==
X-Change-ID: 20261015-must_hold-92c4ef54c668
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1710; i=sven@narfation.org;
 h=from:subject:message-id; bh=Zp6aPMnNXazsqqGpR/YnYYIcRuRR9VKfHFG3W7A0Z8s=;
 b=kA0DAAoWTQ93K9MU9csByyZiAGrng/GgrFflcv0tyim3fi8UicmNQAkgbkL3GBZVT3iu2dpSl
 oh1BAAWCgAdFiEEvNRvz7MH7R/zlvHFTQ93K9MU9csFAmrng/EACgkQTQ93K9MU9cu0wAD9EHQy
 jAfF0DlWBYjoG8pNV7vOUtqmHxKabtS1N7mIfIMBAJZ4QdOREbacmVtrvQaI0Rlr2ZHH56Z8cqO
 idwHs8KAF
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: S3N6YBETRNIBZKZS35NDIKZ7YWBZY3GZ
X-Message-ID-Hash: S3N6YBETRNIBZKZS35NDIKZ7YWBZY3GZ
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/S3N6YBETRNIBZKZS35NDIKZ7YWBZY3GZ/>
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

sparse is no longer used in the kernel for analyzing the locking during
build time. The new LLVM/clang based approach is more powerful but also
build around marking of functions and variables. To get it started, just
mark functions which need some specific locks.

The __guarded_by and following line at the beginning of
net/batman-adv/Makefile are needed before it is possible to enable
`CONFIG_WARN_CONTEXT_ANALYSIS=y` with clang-23

CONTEXT_ANALYSIS := y

But I am not sure at the moment how to correctly handle some of the corner
cases of __guarded_by and thus didn't submit this part (yet).

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Changes in v2:
- add another patch which ensures batadv_mcast_mla_tt_retract() is also
  called with the spinlock when it is called by batadv_mcast_free()
- Link to v1: https://patch.msgid.link/20261015-must_hold-v1-1-7ddbb82da7c3@narfation.org

---
Sven Eckelmann (2):
      batman-adv: mcast: use mla_lock also during mcast_free
      batman-adv: mark functions inheriting critical sections

 net/batman-adv/bat_iv_ogm.c        |  3 +++
 net/batman-adv/bat_v.c             |  2 ++
 net/batman-adv/bat_v_ogm.c         |  4 ++++
 net/batman-adv/fragmentation.c     |  1 +
 net/batman-adv/fragmentation.h     |  1 +
 net/batman-adv/gateway_client.c    |  1 +
 net/batman-adv/multicast.c         | 17 ++++++++++++++++-
 net/batman-adv/translation-table.c |  4 ++++
 net/batman-adv/tvlv.c              |  3 +++
 9 files changed, 35 insertions(+), 1 deletion(-)
---
base-commit: 075858d156c84581f399e46289e9f67a05e68e86
change-id: 20261015-must_hold-92c4ef54c668

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

