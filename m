Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AABEC02181
	for <batman-adv@archiver.kernel.org>; Wed, 22 Jan 2025 20:51:41 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id AFDBC83F17
	for <batman-adv@archiver.kernel.org>; Wed, 22 Jan 2025 21:51:39 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1737579099;
 b=dLT+6o1r1lRwYu93Z7xwueQ0t9tIhXFWRJ48Q8NvudHqGSycIQO+pXo2bkxBE8z1Si80n
 GunkIkuzZb8wu7v9S0uV9piDS7RYFHi25mkFZBkWQs0Uf5Q02nCggDJCWCVmmmJg9IW4/+E
 t9DgKJH8uiG3EG0OcyRPEZlnxBuWoLg=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1737579099; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=41LVbGW16i1GrLG2V1oHR03H3r7bYX1I5x1BO+OBVIw=;
 b=lxISkTN3S59TQxErAvi0UT3JyQ1sEPXHadj8tWLZQjQUgXIinGdYfDLidDHUUfEODfQ+c
 GhGCr0OsAW113RXpzMtmVGOxttGUJin8E0Cr168Nf9k36o1WcCUDTpTRnqypg8dp9YC9WfE
 4XNPPBsvjK6q5AjkXFwLlzEYLuMK7z4=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=narfation.org
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id CD22D81071
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 22 Jan 2025 21:51:28 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1737579090;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=41LVbGW16i1GrLG2V1oHR03H3r7bYX1I5x1BO+OBVIw=;
	b=fzmiDIRzkYK9iO8PGa4z+9uRz4dLD4JwnpKUe6eZMezj9wOXDCOe+1cMi+N4e0Bs5WwXK8
	SwlTRIVX+O7SUK58JU9SGqsNjdnvE/xBFJDU88AwOLih7Ch/mysDfPvomS8Ioy96rGr668
	WHMUWVG2cOjJB/9M0yQN4/ca6753+wc=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=wS3J95L8;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1737579090; a=rsa-sha256;
	cv=none;
	b=ywODSmh2onLOd9ngNtPvczgxXj/nSwfj9Xk4ln2f44IRr2MWvnjIY1S7OgBpfhMJKNfe6l
	EeY5TZniOoI9PFdthtjG9yqxI3yhoAczEf6g6xPlmS95+hIjdd7rLseJIhf7nis9Lg7hzr
	37ihOti1n1VwoyyGYFUywIYliXoj3AI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1737579087;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=41LVbGW16i1GrLG2V1oHR03H3r7bYX1I5x1BO+OBVIw=;
	b=wS3J95L8zXj8zAdu7XcaMetyRgq/IisW9+AsH85huGKhuoEvYBj/AARmNWsd6B486JCOz7
	RbqYqhSId9539uz3Mff0DfoMT8rmakmAN4u68ORuN976VNdybwSooS7P/hi0p04rvralN7
	aK6J96DtZ94pPRQCzu4wOQRlSLzEtsk=
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 0/2] batman-adv: Stop ELP metric work when disabling
 interface
Date: Wed, 22 Jan 2025 21:51:19 +0100
Message-Id: <20250122-fix-metric-update-v1-0-c489b3f82f6d@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEdakWcC/x2MQQqAIBAAvxJ7bkENifpKdBBdaw+ZaEUg/j3pO
 DAzBTIlpgxzVyDRw5nP0ED2HdjdhI2QXWNQQmkhlUDPLx50JbZ4R2cuwtE4slpKN/kBWhcTNel
 /LmutH41KnYBjAAAA
X-Change-ID: 20250120-fix-metric-update-7adec511d9f3
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2632; i=sven@narfation.org;
 h=from:subject:message-id; bh=Sr2ZqxxnFi523oourw+3TDV/Jyf7vT3O9uhKbjc44HY=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDOkTo7wmRtRk1kyNeRUjPvfxv5X/jog8z3q+wexAvcT7u
 /Ndl8XmdJSyMIhxMciKKbLsuZJ/fjP7W/nP0z4ehZnDygQyhIGLUwAmIveS4X9pRGNS9a6c15Mr
 HarU02r5RCs/PFJbu+vko6WToqdZOUYw/DMKK10hcqcpxNHkfOdekT17H619ca/ZwEN116blG/Z
 v+8cJAA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: 4BJHTE2N354JKD5YFV6CQNZ7WXQLZFWK
X-Message-ID-Hash: 4BJHTE2N354JKD5YFV6CQNZ7WXQLZFWK
X-MailFrom: sven@narfation.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/4BJHTE2N354JKD5YFV6CQNZ7WXQLZFWK/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The ELP worker needs to calculate new metric values for all neighbors
"reachable" over an interface. Some of the used metric sources require
locks which might need to sleep. This sleep is incompatible with the RCU
list iterator used for the recorded neighbors. The initial approach to work
around of this problem was to queue another work item per neighbor and then
run this in a new context.

Even when this solved the RCU vs might_sleep() conflict, it has a major
problems: Nothing was stopping the work item in case it is not needed
anymore - for example because one of the related interfaces was removed or
the batman-adv module was unloaded - resulting in potential invalid memory
accesses.

Directly canceling the metric worker also has various problems:

* cancel_work_sync for a to-be-deactivated interface is called with
  rtnl_lock held. But the code in the ELP metric worker also tries to use
  rtnl_lock() - which will never return in this case. This also means that
  cancel_work_sync would never return because it is waiting for the worker
  to finish.
* iterating over the neighbor list for the to-be-deactivated interface is
  currently done using the RCU specific methods. Which means that it is
  possible to miss items when iterating over it without the associated
  spinlock - a behaviour which is acceptable for a periodic metric check but
  not for a cleanup routine (which must "stop" all still running workers)

The better approch is to get rid of the per interface neighbor metric
worker and handle everything in the interface worker. The original problems
are solved by:

* creating a list of neighbors which require new metric information inside
  the RCU protected context, gathering the metric according to the new list
  outside the RCU protected context
* only use rcu_trylock inside metric gathering code to avoid a deadlock
  when the cancel_delayed_work_sync is called in the interface removal code
  (which is called with the rtnl_lock held)

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Sven Eckelmann (2):
      batman-adv: Ignore neighbor throughput metrics in error case
      batman-adv: Drop unmanaged ELP metric worker

 net/batman-adv/bat_v.c     |   2 -
 net/batman-adv/bat_v_elp.c | 115 +++++++++++++++++++++++++++++++--------------
 net/batman-adv/bat_v_elp.h |   2 -
 net/batman-adv/types.h     |   3 --
 4 files changed, 79 insertions(+), 43 deletions(-)
---
base-commit: 2aa54a15f1a57a03e6ac415f59e9d7402b9b3558
change-id: 20250120-fix-metric-update-7adec511d9f3

Best regards,
-- 
Sven Eckelmann <sven@narfation.org>

