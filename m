Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7961CC4451C
	for <batman-adv@archiver.kernel.org>; Wed, 22 Jul 2026 07:24:20 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 9A88F8132F
	for <batman-adv@archiver.kernel.org>; Wed, 22 Jul 2026 09:24:18 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1784705058;
 b=AKE0XxI8dfx/J21LdqYs8tcMe9/pjlnKtvXknOxCqAvpi2+OxVIKydzF9q+7yTYbnCJ+a
 s2zYX+nU/QP0+aSrffwXbn2NJ3bCQpWofLze/bZDlFdJuVfflnqJNrYzLJZdq5GUAdX1ZaX
 exgyOIDd8fHRnNJcC2q6ITMvE3tSCI4=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1784705058; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=UFnIWz2Nf4oUmI95LJn2mBTPi1+qnjVXm5gBbynqpfo=;
 b=kmxttl2sKRFTua0wV+xoq7cHpqmIvkyPmEimCol4FeBMk1SFa5ZHvPwiMWf+ar5a6ErUj
 9hrM13VczsqeDJLza0oZ8wnx4ERo5wL26fOXK9HzsOjqvN6e4XrhRpv5hlf/b9pAe9PIekH
 rvJYpcYV97bnng/rRsidKwUpZg8CbaU=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 9D37981164
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 22 Jul 2026 09:23:43 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1784705033;
	b=fJDiQisOByhh2UBr3XUz2Kt8RbpNN8OTRQsrmpyvlxlW5LhWAIr4cmAgo3n/Boxbl2/sTp
	iduoQIeSHUXZ3X7XN/zV9BnfPSG09q6nTblrPzH5PKy3J9L285j7c+u7tUDpUsmlXid4gl
	dEaxvwrFPDEh5j/F7WjAomuxlLCfJRU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1784705033;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=UFnIWz2Nf4oUmI95LJn2mBTPi1+qnjVXm5gBbynqpfo=;
	b=IZoW8xxUZHWUEk8y/EC8WnVXhg05i9hDfL5bmlZsv5YxiFj9aGKQTejUDNweHyzHYKglOd
	DJuipB0dfNOMi4zWeviNuGZEzINW0DstRS5KNboZyMLegwd1xXXpq7RNaniR/gWLBHqnrn
	oFD/K6P57cDZy2AiDoulG42Bj/SHSsM=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=EjUAyVYx;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org
Received: by dvalin.narfation.org (Postfix) id 1408B1FDD3;
	Wed, 22 Jul 2026 07:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1784705022;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=UFnIWz2Nf4oUmI95LJn2mBTPi1+qnjVXm5gBbynqpfo=;
	b=EjUAyVYxaccWWRRo9xGtrAGTE4aEEOm0X/fbb4AaKkyGzmO7enwF0tccqqwQ+AjDl0T/9x
	GzXfkc4KhqF6abSIw/siGbHTOqfT2izASNqoKeCCVNPtiICMId+xXDnSA+veU3k3gOM8X9
	vog/UyEI4PTYAFN2LvdxfwWq2bB/Kt4=
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 22 Jul 2026 09:23:20 +0200
Subject: [PATCH v2] batctl: drop bisect_iv tool
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260722-drop-bisect_iv-v2-1-e32cade8ccc5@narfation.org>
X-B4-Tracking: v=1; b=H4sIAOdvYGoC/3WOzQ6CMBAGX4Xs2Rqo1qon38MQ058trAdKtthoC
 O9uwbPHSWbn2xkSMmGCazUDY6ZEcSggdxW43gwdCvKFQdbyVOv6LDzHUVhK6KYHZXEISh+1RZT
 qAuVoZAz03oL39sfpZZ/FXiur0VOaIn+2xdys3t94bkQjLspoF5x13qvbYDiYqfy4j9xBuyzLF
 /o3pjDCAAAA
X-Change-ID: 20260708-drop-bisect_iv-3f5747bee259
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=60903; i=sven@narfation.org;
 h=from:subject:message-id; bh=tTdtKECUVUnNL0hAnRM4ozMkyWcXwL1cNT6Ih56Y/+Q=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFkJ+W+0Nrgotyj3S4i3KUv4purP37Nt+uOt61PED9idV
 Q3RYX3WUcrCIMbFICumyLLnSv75zexv5T9P+3gUZg4rE8gQBi5OAZhINg8jw3fBRxNV2WIPFb/5
 3bS410xSXIJTcfnqP6pMh1hm8sndn8rIsPrFc4bzewR136ReDlrBuTns19T9a72Ynl1JuMNdy+X
 +hxUA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: N7VAEAYKCD6A7MPHAXHQDQ4JTCZKITVN
X-Message-ID-Hash: N7VAEAYKCD6A7MPHAXHQDQ4JTCZKITVN
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/N7VAEAYKCD6A7MPHAXHQDQ4JTCZKITVN/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The bisect_iv was used in the past to analyze logfiles. But this tool is
not build by default and wasn't updated since a long time. It is currently
not even able to parse the output from trace-cmd.

The bisect_iv tool is most likely not actively used and can be dropped.
This reduces the maintenance overhead. Because it is one of the larger
portions of the codebase and has various known problems.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
See https://www.open-mesh.org/issues/454 for some pending reports.
---
Changes in v2:
- rebased
- drop now no longer used functions
- Link to v1: https://patch.msgid.link/20260708-drop-bisect_iv-v1-1-95a7cfcbcdd5@narfation.org
---
 Makefile        |    6 +-
 README.rst      |  103 ----
 cmd/bisect_iv.c | 1652 -------------------------------------------------------
 cmd/bisect_iv.h |   85 ---
 functions.c     |   11 -
 functions.h     |    1 -
 hash.c          |    2 +-
 hash.h          |    3 -
 man/batctl.8    |    9 -
 9 files changed, 2 insertions(+), 1870 deletions(-)

diff --git a/Makefile b/Makefile
index e98a6ee..0a2fdfe 100755
--- a/Makefile
+++ b/Makefile
@@ -6,9 +6,6 @@
 #
 # License-Filename: LICENSES/preferred/GPL-2.0
 
-# just for backward compatibility - please use CONFIG_bisect_iv instead
-export CONFIG_BATCTL_BISECT=n
-
 # batctl build
 BINARY_NAME = batctl
 
@@ -34,12 +31,11 @@ define add_command
   obj-$$(CONFIG_$(1)) += cmd/$(1).o
 endef # add_command
 
-# using the make parameter CONFIG_* (e.g. CONFIG_bisect_iv) with the value 'y'
+# using the make parameter CONFIG_* (e.g. CONFIG_aggregation) with the value 'y'
 # enables the related feature and 'n' disables it
 $(eval $(call add_command,aggregation,y))
 $(eval $(call add_command,ap_isolation,y))
 $(eval $(call add_command,backbonetable,y))
-$(eval $(call add_command,bisect_iv,$(CONFIG_BATCTL_BISECT)))
 $(eval $(call add_command,bla_backbone_json,y))
 $(eval $(call add_command,bla_claim_json,y))
 $(eval $(call add_command,bonding,y))
diff --git a/README.rst b/README.rst
index d3cfe0e..7fca2e8 100644
--- a/README.rst
+++ b/README.rst
@@ -1313,109 +1313,6 @@ Example::
       "vlanid": 1
   }
 
-Advanced Analytics
-==================
-
-batctl bisect_iv
-----------------
-
-Analyzes the B.A.T.M.A.N. IV logfiles to build a small internal database of all sent sequence
-numbers and routing table changes. This database can be used to search for routing loops
-(default action), to trace OGMs of  a  host  (use  "-t"  to specify  the  mac address or
-bat-host name) throughout the network or to display routing tables of the nodes (use "-r" to
-specify the mac address or bat-host name). You can name a specific sequence number or a range
-using the "-s"  option  to limit the output's range. Furthermore you can filter the output by
-specifying an originator (use "-o" to specify the mac address or bat-host name) to only see
-data connected to  this  originator.  If  "-n"  was given batctl will not replace the mac
-addresses with bat-host names in the output.
-
-Usage::
-
-  batctl bisect_iv [parameters] <file1> <file2> .. <fileN>
-  parameters:
-  
-           -h print this help
-           -l run a loop detection of given mac address or bat-host (default)
-           -n don't convert addresses to bat-host names
-           -r print routing tables of given mac address or bat-host
-           -s seqno range to limit the output
-           -t trace seqnos of given mac address or bat-host
-
-Examples::
-
-  $ batctl bisect_iv log/* -l uml3
-  Analyzing routing tables of originator: uml3 [all sequence numbers]
-  
-  Checking host: uml3
-  Path towards uml7 (seqno 9 via neigh uml5): -> uml5 -> uml6
-  Path towards uml7 (seqno 10 via neigh uml4): -> uml4 -> uml5 -> uml6
-  Path towards uml6 (seqno 4 via neigh uml4): -> uml4
-  Path towards uml8 (seqno 12 via neigh uml4): -> uml4 -> uml5 -> uml6 -> uml7
-  Path towards uml8 (seqno 203 via neigh uml4): -> uml4 -> uml6 -> uml7
-  Path towards uml8 (seqno 391 via neigh uml2): -> uml2 -> uml3 -> uml2 aborted due to loop!
-  Path towards uml8 (seqno 396 via neigh uml4): -> uml4 -> uml6 -> uml7
-  Path towards uml9 (seqno 10 via neigh uml5): -> uml5 -> uml6 -> uml7 -> uml9.
-  Path towards uml9 (seqno 10 via neigh uml4): -> uml4 -> uml5 -> uml6 -> uml7 -> uml9.
-  Path towards uml9 (seqno 11 via neigh uml4): -> uml4 -> uml6 -> uml7 -> uml8 -> uml9.
-  Path towards uml9 (seqno 12 via neigh uml4): -> uml4 -> uml5 -> uml6 -> uml7 -> uml8 -> uml9.
-  Path towards uml9 (seqno 21 via neigh uml5): -> uml5 -> uml6 -> uml7 -> uml8 -> uml9.
-  Path towards uml9 (seqno 22 via neigh uml4): -> uml4 -> uml5 -> uml6 -> uml7 -> uml8 -> uml9.
-  
-  $ ./batctl bisect_iv -t uml3 log/*
-  Sequence number flow of originator: uml3 [all sequence numbers]
-  [...]
-  +=> uml3 (seqno 19)
-  |- uml2 [tq: 255, ttl: 50, neigh: uml3, prev_sender: uml3]
-  |   |- uml3 [tq: 154, ttl: 49, neigh: uml2, prev_sender: uml3]
-  |   \- uml1 [tq: 154, ttl: 49, neigh: uml2, prev_sender: uml3]
-  |       |- uml3 [tq: 51, ttl: 48, neigh: uml1, prev_sender: uml2]
-  |       \- uml2 [tq: 51, ttl: 48, neigh: uml1, prev_sender: uml2]
-  |- uml5 [tq: 255, ttl: 50, neigh: uml3, prev_sender: uml3]
-  |   |- uml6 [tq: 33, ttl: 48, neigh: uml5, prev_sender: uml3]
-  |   |   |- uml5 [tq: 11, ttl: 47, neigh: uml6, prev_sender: uml5]
-  |   |   |- uml7 [tq: 11, ttl: 47, neigh: uml6, prev_sender: uml5]
-  |   |   |   |- uml8 [tq: 3, ttl: 46, neigh: uml7, prev_sender: uml6]
-  |   |   |   |   |- uml6 [tq: 0, ttl: 45, neigh: uml8, prev_sender: uml7]
-  |   |   |   |   |- uml9 [tq: 0, ttl: 45, neigh: uml8, prev_sender: uml7]
-  |   |   |   |   \- uml7 [tq: 0, ttl: 45, neigh: uml8, prev_sender: uml7]
-  |   |   |   |- uml6 [tq: 3, ttl: 46, neigh: uml7, prev_sender: uml6]
-  |   |   |   |- uml9 [tq: 3, ttl: 46, neigh: uml7, prev_sender: uml6]
-  |   |   |   \- uml5 [tq: 3, ttl: 46, neigh: uml7, prev_sender: uml6]
-  |   |   \- uml4 [tq: 11, ttl: 47, neigh: uml6, prev_sender: uml5]
-  |   |- uml7 [tq: 33, ttl: 48, neigh: uml5, prev_sender: uml3]
-  |   \- uml4 [tq: 33, ttl: 48, neigh: uml5, prev_sender: uml3]
-  \- uml4 [tq: 255, ttl: 50, neigh: uml3, prev_sender: uml3]
-      |- uml3 [tq: 106, ttl: 49, neigh: uml4, prev_sender: uml3]
-      |- uml6 [tq: 106, ttl: 49, neigh: uml4, prev_sender: uml3]
-      |- uml2 [tq: 106, ttl: 49, neigh: uml4, prev_sender: uml3]
-      \- uml5 [tq: 106, ttl: 49, neigh: uml4, prev_sender: uml3]
-  +=> uml3 (seqno 20)
-  |- uml2 [tq: 255, ttl: 50, neigh: uml3, prev_sender: uml3]
-  |   |- uml3 [tq: 160, ttl: 49, neigh: uml2, prev_sender: uml3]
-  |   |- uml1 [tq: 160, ttl: 49, neigh: uml2, prev_sender: uml3]
-  |   \- uml4 [tq: 160, ttl: 49, neigh: uml2, prev_sender: uml3]
-  |- uml5 [tq: 255, ttl: 50, neigh: uml3, prev_sender: uml3]
-  |   |- uml3 [tq: 43, ttl: 48, neigh: uml5, prev_sender: uml3]
-  |   |- uml6 [tq: 43, ttl: 48, neigh: uml5, prev_sender: uml3]
-  |   |   |- uml8 [tq: 16, ttl: 47, neigh: uml6, prev_sender: uml5]
-  |   |   |- uml5 [tq: 16, ttl: 47, neigh: uml6, prev_sender: uml5]
-  |   |   |- uml7 [tq: 16, ttl: 47, neigh: uml6, prev_sender: uml5]
-  |   |   |   |- uml8 [tq: 5, ttl: 46, neigh: uml7, prev_sender: uml6]
-  |   |   |   |   |- uml6 [tq: 0, ttl: 45, neigh: uml8, prev_sender: uml7]
-  |   |   |   |   |- uml9 [tq: 0, ttl: 45, neigh: uml8, prev_sender: uml7]
-  |   |   |   |   \- uml7 [tq: 0, ttl: 45, neigh: uml8, prev_sender: uml7]
-  |   |   |   \- uml6 [tq: 5, ttl: 46, neigh: uml7, prev_sender: uml6]
-  |   |   \- uml4 [tq: 16, ttl: 47, neigh: uml6, prev_sender: uml5]
-  |   \- uml4 [tq: 43, ttl: 48, neigh: uml5, prev_sender: uml3]
-  |- uml1 [tq: 255, ttl: 50, neigh: uml3, prev_sender: uml3]
-  |   \- uml2 [tq: 49, ttl: 48, neigh: uml1, prev_sender: uml3]
-  \- uml4 [tq: 255, ttl: 50, neigh: uml3, prev_sender: uml3]
-      |- uml3 [tq: 114, ttl: 49, neigh: uml4, prev_sender: uml3]
-      |- uml6 [tq: 114, ttl: 49, neigh: uml4, prev_sender: uml3]
-      |- uml2 [tq: 114, ttl: 49, neigh: uml4, prev_sender: uml3]
-      \- uml5 [tq: 114, ttl: 49, neigh: uml4, prev_sender: uml3]
-  [...]
-
 
 Appendix
 ========
diff --git a/cmd/bisect_iv.c b/cmd/bisect_iv.c
deleted file mode 100644
index d91f03b..0000000
--- a/cmd/bisect_iv.c
+++ /dev/null
@@ -1,1652 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) B.A.T.M.A.N. contributors:
- *
- * Marek Lindner <marek.lindner@mailbox.org>
- *
- * License-Filename: LICENSES/preferred/GPL-2.0
- */
-
-#include "bisect_iv.h"
-
-#include <stdint.h>
-#include <stdio.h>
-#include <stdlib.h>
-#include <string.h>
-#include <errno.h>
-#include <unistd.h>
-#include <stddef.h>
-#include <netinet/ether.h>
-
-#include "../bat-hosts.h"
-#include "../hash.h"
-#include "../main.h"
-#include "../functions.h"
-
-static struct hashtable_t *node_hash;
-static struct bat_node *curr_bat_node;
-
-static void bisect_iv_usage(void)
-{
-	fprintf(stderr, "Usage: batctl bisect_iv [parameters] <file1> <file2> .. <fileN>\n");
-	fprintf(stderr, "parameters:\n");
-	fprintf(stderr, " \t -h print this help\n");
-	fprintf(stderr, " \t -l run a loop detection of given mac address or bat-host (default)\n");
-	fprintf(stderr, " \t -n don't convert addresses to bat-host names\n");
-	fprintf(stderr, " \t -o only display orig events that affect given mac address or bat-host\n");
-	fprintf(stderr, " \t -r print routing tables of given mac address or bat-host\n");
-	fprintf(stderr, " \t -s seqno range to limit the output\n");
-	fprintf(stderr, " \t -t trace seqnos of given mac address or bat-host\n");
-}
-
-static int compare_name(void *data1, void *data2)
-{
-	return (memcmp(data1, data2, NAME_LEN) == 0 ? 1 : 0);
-}
-
-static int choose_name(void *data, int32_t size)
-{
-	uint32_t m_size = NAME_LEN - 1;
-	unsigned char *key = data;
-	uint32_t hash = 0;
-	size_t i;
-
-	for (i = 0; i < m_size; i++) {
-		hash += key[i];
-		hash += (hash << 10);
-		hash ^= (hash >> 6);
-	}
-
-	hash += (hash << 3);
-	hash ^= (hash >> 11);
-	hash += (hash << 15);
-
-	return (hash % size);
-}
-
-static struct bat_node *node_get(char *name)
-{
-	struct bat_node *bat_node;
-
-	if (!name)
-		return NULL;
-
-	bat_node = (struct bat_node *)hash_find(node_hash, name);
-	if (bat_node)
-		goto out;
-
-	bat_node = malloc(sizeof(struct bat_node));
-	if (!bat_node) {
-		fprintf(stderr,
-			"Could not allocate memory for data structure (out of mem?) - skipping");
-		return NULL;
-	}
-
-	strncpy(bat_node->name, name, NAME_LEN);
-	bat_node->name[NAME_LEN - 1] = '\0';
-	INIT_LIST_HEAD(&bat_node->orig_event_list);
-	INIT_LIST_HEAD(&bat_node->rt_table_list);
-	memset(bat_node->loop_magic, 0, sizeof(bat_node->loop_magic));
-	memset(bat_node->loop_magic2, 0, sizeof(bat_node->loop_magic2));
-	hash_add(node_hash, bat_node);
-
-out:
-	return bat_node;
-}
-
-static struct orig_event *orig_event_new(struct bat_node *bat_node, struct bat_node *orig_node)
-{
-	struct orig_event *orig_event;
-
-	orig_event = malloc(sizeof(struct orig_event));
-	if (!orig_event) {
-		fprintf(stderr,
-			"Could not allocate memory for orig event structure (out of mem?) - skipping");
-		return NULL;
-	}
-
-	INIT_LIST_HEAD(&orig_event->event_list);
-	INIT_LIST_HEAD(&orig_event->rt_hist_list);
-	orig_event->orig_node = orig_node;
-	list_add_tail(&orig_event->list, &bat_node->orig_event_list);
-
-	return orig_event;
-}
-
-static struct orig_event *orig_event_get_by_name(struct bat_node *bat_node, char *orig)
-{
-	struct orig_event *orig_event;
-	struct bat_node *orig_node;
-
-	if (!bat_node)
-		return NULL;
-
-	list_for_each_entry(orig_event, &bat_node->orig_event_list, list) {
-		if (compare_name(orig_event->orig_node->name, orig))
-			return orig_event;
-	}
-
-	orig_node = node_get(orig);
-	if (!orig_node)
-		return NULL;
-
-	return orig_event_new(bat_node, orig_node);
-}
-
-static struct orig_event *orig_event_get_by_ptr(struct bat_node *bat_node,
-						struct bat_node *orig_node)
-{
-	struct orig_event *orig_event;
-
-	if (!bat_node)
-		return NULL;
-
-	list_for_each_entry(orig_event, &bat_node->orig_event_list, list) {
-		if (orig_event->orig_node == orig_node)
-			return orig_event;
-	}
-
-	return orig_event_new(bat_node, orig_node);
-}
-
-static void node_free(void *data)
-{
-	struct bat_node *bat_node = (struct bat_node *)data;
-	struct seqno_event *seqno_event_tmp;
-	struct orig_event *orig_event_tmp;
-	struct seqno_event *seqno_event;
-	struct orig_event *orig_event;
-	struct rt_table *rt_table_tmp;
-	struct rt_hist *rt_hist_tmp;
-	struct rt_table *rt_table;
-	struct rt_hist *rt_hist;
-
-	list_for_each_entry_safe(orig_event, orig_event_tmp, &bat_node->orig_event_list, list) {
-		list_for_each_entry_safe(seqno_event, seqno_event_tmp,
-					 &orig_event->event_list, list) {
-			list_del(&seqno_event->list);
-			free(seqno_event);
-		}
-
-		list_for_each_entry_safe(rt_hist, rt_hist_tmp, &orig_event->rt_hist_list, list) {
-			list_del(&rt_hist->list);
-			free(rt_hist);
-		}
-
-		list_del(&orig_event->list);
-		free(orig_event);
-	}
-
-	list_for_each_entry_safe(rt_table, rt_table_tmp, &bat_node->rt_table_list, list) {
-		list_del(&rt_table->list);
-
-		free(rt_table->entries);
-		free(rt_table);
-	}
-
-	free(bat_node);
-}
-
-static int routing_table_new(char *orig, char *next_hop, char *old_next_hop, char rt_flag)
-{
-	struct rt_table *prev_rt_table = NULL;
-	struct seqno_event *seqno_event;
-	struct bat_node *next_hop_node;
-	struct orig_event *orig_event;
-	struct rt_table *rt_table;
-	struct rt_hist *rt_hist;
-	int j = -1;
-	int i;
-
-	if (!curr_bat_node) {
-		fprintf(stderr, "Routing table change without preceding OGM - skipping");
-		goto err;
-	}
-
-	if (!orig) {
-		fprintf(stderr, "Invalid originator found - skipping");
-		goto err;
-	}
-
-	if (rt_flag != RT_FLAG_DELETE && !next_hop) {
-		fprintf(stderr, "Invalid next hop found - skipping");
-		goto err;
-	}
-
-	if (rt_flag == RT_FLAG_UPDATE && !old_next_hop) {
-		fprintf(stderr, "Invalid old next hop found - skipping");
-		goto err;
-	}
-
-	next_hop_node = node_get(next_hop);
-	if (rt_flag != RT_FLAG_DELETE && !next_hop_node)
-		goto err;
-
-	orig_event = orig_event_get_by_name(curr_bat_node, orig);
-	if (!orig_event)
-		goto err;
-
-	if (list_empty(&orig_event->event_list)) {
-		fprintf(stderr,
-			"Routing table change without any preceding OGM of that originator - skipping");
-		goto err;
-	}
-
-	if (!compare_name(((struct seqno_event *)orig_event->event_list.prev)->orig->name, orig)) {
-		fprintf(stderr,
-			"Routing table change does not match with last received OGM - skipping");
-		goto err;
-	}
-
-	rt_table = malloc(sizeof(struct rt_table));
-	if (!rt_table) {
-		fprintf(stderr,
-			"Could not allocate memory for routing table (out of mem?) - skipping");
-		goto err;
-	}
-
-	rt_hist = malloc(sizeof(struct rt_hist));
-	if (!rt_hist) {
-		fprintf(stderr,
-			"Could not allocate memory for routing history (out of mem?) - skipping");
-		goto table_free;
-	}
-
-	rt_table->num_entries = 1;
-
-	rt_hist->prev_rt_hist = NULL;
-	rt_hist->next_hop = next_hop_node;
-	rt_hist->flags = rt_flag;
-	memset(rt_hist->loop_magic, 0, sizeof(rt_hist->loop_magic));
-
-	if (!list_empty(&orig_event->rt_hist_list))
-		rt_hist->prev_rt_hist = (struct rt_hist *)(orig_event->rt_hist_list.prev);
-
-	if (!list_empty(&curr_bat_node->rt_table_list))
-		prev_rt_table = (struct rt_table *)(curr_bat_node->rt_table_list.prev);
-
-	switch (rt_flag) {
-	case RT_FLAG_ADD:
-		if (prev_rt_table)
-			rt_table->num_entries = prev_rt_table->num_entries + 1;
-		break;
-	case RT_FLAG_UPDATE:
-		if (prev_rt_table) {
-			rt_table->num_entries = prev_rt_table->num_entries + 1;
-
-			/* if we had that route already we just change the entry */
-			for (i = 0; i < prev_rt_table->num_entries; i++) {
-				if (compare_name(orig, prev_rt_table->entries[i].orig)) {
-					rt_table->num_entries = prev_rt_table->num_entries;
-					break;
-				}
-			}
-		}
-		break;
-	case RT_FLAG_DELETE:
-		if (prev_rt_table) {
-			rt_table->num_entries = prev_rt_table->num_entries + 1;
-
-			/* if we had that route already we just change the entry */
-			for (i = 0; i < prev_rt_table->num_entries; i++) {
-				if (compare_name(orig, prev_rt_table->entries[i].orig)) {
-					rt_table->num_entries = prev_rt_table->num_entries;
-					break;
-				}
-			}
-
-			if (rt_table->num_entries != prev_rt_table->num_entries) {
-				fprintf(stderr,
-					"Found a delete entry of orig '%s' but no existing record - skipping",
-					orig);
-				goto rt_hist_free;
-			}
-
-			/* we need to create a special seqno event as a timer instead
-			 * of an OGM triggered that event
-			 */
-			seqno_event = malloc(sizeof(struct seqno_event));
-			if (!seqno_event) {
-				fprintf(stderr,
-					"Could not allocate memory for delete seqno event (out of mem?) - skipping");
-				goto rt_hist_free;
-			}
-
-			seqno_event->orig = node_get(orig);
-			seqno_event->neigh = NULL;
-			seqno_event->prev_sender = NULL;
-			seqno_event->seqno = -1;
-			seqno_event->tq = -1;
-			seqno_event->ttl = -1;
-			seqno_event->rt_hist = NULL;
-			list_add_tail(&seqno_event->list, &orig_event->event_list);
-		}
-		break;
-	default:
-		fprintf(stderr, "Unknown rt_flag received: %i - skipping", rt_flag);
-		goto rt_hist_free;
-	}
-
-	rt_table->entries = malloc(sizeof(struct rt_entry) * rt_table->num_entries);
-	if (!rt_table->entries) {
-		fprintf(stderr,
-			"Could not allocate memory for routing table entries (out of mem?) - skipping");
-		goto rt_hist_free;
-	}
-
-	if (prev_rt_table) {
-		for (i = 0; i < prev_rt_table->num_entries; i++) {
-			/* if we have a previously deleted item don't copy it over */
-			if (prev_rt_table->entries[i].flags == RT_FLAG_DELETE) {
-				rt_table->num_entries--;
-				continue;
-			}
-
-			/* if we delete one item the entries are not in sync anymore,
-			 * therefore we need to counters: one for the old and one for
-			 * the new routing table
-			 */
-			j++;
-
-			memcpy((char *)&rt_table->entries[j],
-			       (char *)&prev_rt_table->entries[i],
-			       sizeof(struct rt_entry));
-
-			if (compare_name(orig, rt_table->entries[j].orig)) {
-				if (rt_flag != RT_FLAG_DELETE)
-					rt_table->entries[j].next_hop = next_hop_node;
-				rt_table->entries[j].flags = rt_flag;
-				continue;
-			}
-
-			rt_table->entries[j].flags = 0;
-		}
-	}
-
-	if (rt_table->num_entries == 1 || rt_table->num_entries != j + 1) {
-		i = rt_table->num_entries;
-		strncpy(rt_table->entries[i - 1].orig, orig, NAME_LEN);
-		rt_table->entries[i - 1].orig[NAME_LEN - 1] = '\0';
-		rt_table->entries[i - 1].next_hop = next_hop_node;
-		rt_table->entries[i - 1].flags = rt_flag;
-	}
-
-	rt_table->rt_hist = rt_hist;
-	rt_hist->seqno_event = (struct seqno_event *)(orig_event->event_list.prev);
-	rt_hist->seqno_event->rt_hist = rt_hist;
-	rt_hist->rt_table = rt_table;
-	list_add_tail(&rt_table->list, &curr_bat_node->rt_table_list);
-	list_add_tail(&rt_hist->list, &orig_event->rt_hist_list);
-
-	return 1;
-
-rt_hist_free:
-	free(rt_hist);
-table_free:
-	free(rt_table);
-err:
-	return 0;
-}
-
-static int seqno_event_new(char *iface_addr, char *orig, char *prev_sender,
-			   char *neigh, long long seqno, int tq, int ttl)
-{
-	struct bat_node *prev_sender_node;
-	struct seqno_event *seqno_event;
-	struct orig_event *orig_event;
-	struct bat_node *neigh_node;
-	struct bat_node *orig_node;
-
-	if (!iface_addr) {
-		fprintf(stderr, "Invalid interface address found - skipping");
-		goto err;
-	}
-
-	if (!orig) {
-		fprintf(stderr, "Invalid originator found - skipping");
-		goto err;
-	}
-
-	if (!neigh) {
-		fprintf(stderr, "Invalid neighbor found - skipping");
-		goto err;
-	}
-
-	if (seqno < 0 || seqno > UINT32_MAX) {
-		fprintf(stderr, "Invalid sequence number found (%lli) - skipping", seqno);
-		goto err;
-	}
-
-	if (tq < 0 || tq > UINT8_MAX) {
-		fprintf(stderr, "Invalid tq value found (%i) - skipping", tq);
-		goto err;
-	}
-
-	if (ttl < 0 || ttl > UINT8_MAX) {
-		fprintf(stderr, "Invalid ttl value found (%i) - skipping", ttl);
-		goto err;
-	}
-
-	curr_bat_node = node_get(iface_addr);
-	if (!curr_bat_node)
-		goto err;
-
-	orig_node = node_get(orig);
-	if (!orig_node)
-		goto err;
-
-	neigh_node = node_get(neigh);
-	if (!neigh_node)
-		goto err;
-
-	prev_sender_node = node_get(prev_sender);
-	if (!prev_sender_node)
-		goto err;
-
-	orig_event = orig_event_get_by_ptr(curr_bat_node, orig_node);
-	if (!orig_event)
-		goto err;
-
-	seqno_event = malloc(sizeof(struct seqno_event));
-	if (!seqno_event) {
-		fprintf(stderr,
-			"Could not allocate memory for seqno event (out of mem?) - skipping");
-		goto err;
-	}
-
-	seqno_event->orig = orig_node;
-	seqno_event->neigh = neigh_node;
-	seqno_event->prev_sender = prev_sender_node;
-	seqno_event->seqno = seqno;
-	seqno_event->tq = tq;
-	seqno_event->ttl = ttl;
-	seqno_event->rt_hist = NULL;
-	list_add_tail(&seqno_event->list, &orig_event->event_list);
-
-	return 1;
-
-err:
-	return 0;
-}
-
-static int parse_log_file(char *file_path)
-{
-	char line_buff[MAX_LINE];
-	char *start_ptr_safe;
-	int line_count = 0;
-	char *prev_sender;
-	char *iface_addr;
-	char *start_ptr;
-	long long seqno;
-	char *tok_ptr;
-	char rt_flag;
-	char *neigh;
-	char *orig;
-	FILE *fd;
-	int ttl;
-	int res;
-	int max;
-	int tq;
-	int i;
-
-	fd = fopen(file_path, "r");
-
-	if (!fd) {
-		fprintf(stderr, "Error - could not open file '%s': %s\n",
-			file_path, strerror(errno));
-		return 0;
-	}
-
-	while (fgets(line_buff, sizeof(line_buff), fd)) {
-		/* ignore the timestamp at the beginning of each line */
-		start_ptr = line_buff + 13;
-		line_count++;
-
-		if (strstr(start_ptr, "Received BATMAN packet via NB")) {
-			strtok_r(start_ptr, " ", &start_ptr_safe);
-			neigh = NULL;
-			iface_addr = NULL;
-			orig = NULL;
-			prev_sender = NULL;
-			seqno = -1;
-			tq = -1;
-			ttl = -1;
-
-			for (i = 0; i < 21; i++) {
-				tok_ptr = strtok_r(NULL, " ", &start_ptr_safe);
-				if (!tok_ptr)
-					break;
-
-				switch (i) {
-				case 4:
-					neigh = tok_ptr;
-					neigh[strlen(neigh) - 1] = 0;
-					break;
-				case 7:
-					iface_addr = tok_ptr + 1;
-					iface_addr[strlen(iface_addr) - 1] = 0;
-					break;
-				case 10:
-					orig = tok_ptr;
-					orig[strlen(orig) - 1] = 0;
-					break;
-				case 14:
-					prev_sender = tok_ptr;
-					prev_sender[strlen(prev_sender) - 1] = 0;
-					break;
-				case 16:
-					seqno = strtoll(tok_ptr, NULL, 10);
-					break;
-				case 18:
-					tq = strtol(tok_ptr, NULL, 10);
-					break;
-				case 20:
-					ttl = strtol(tok_ptr, NULL, 10);
-					break;
-				}
-			}
-
-			if (ttl ==  -1) {
-				fprintf(stderr,
-					"Broken 'received packet' line found - skipping [file: %s, line: %i]\n",
-					file_path, line_count);
-				continue;
-			}
-
-			res = seqno_event_new(iface_addr, orig, prev_sender, neigh, seqno, tq, ttl);
-			if (res < 1)
-				fprintf(stderr, " [file: %s, line: %i]\n", file_path, line_count);
-
-		} else if (strstr(start_ptr, "Adding route towards") ||
-			   strstr(start_ptr, "Changing route towards") ||
-			   strstr(start_ptr, "Deleting route towards")) {
-			rt_flag = RT_FLAG_UPDATE;
-			max = 12;
-
-			if (strstr(start_ptr, "Adding route towards")) {
-				rt_flag = RT_FLAG_ADD;
-				max = 5;
-			} else if (strstr(start_ptr, "Deleting route towards")) {
-				rt_flag = RT_FLAG_DELETE;
-				max = 3;
-			}
-
-			strtok_r(start_ptr, " ", &start_ptr_safe);
-			orig = NULL;
-			neigh = NULL;
-			prev_sender = NULL;
-
-			for (i = 0; i < max; i++) {
-				tok_ptr = strtok_r(NULL, " ", &start_ptr_safe);
-				if (!tok_ptr)
-					break;
-
-				switch (i) {
-				case 2:
-					orig = tok_ptr;
-					if (rt_flag == RT_FLAG_DELETE)
-						orig[strlen(orig) - 1] = 0;
-					break;
-				case 4:
-					if (rt_flag == RT_FLAG_ADD) {
-						neigh = tok_ptr;
-						neigh[strlen(neigh) - 2] = 0;
-					}
-					break;
-				case 5:
-					neigh = tok_ptr;
-					break;
-				case 9:
-					prev_sender = tok_ptr;
-					prev_sender[strlen(prev_sender) - 2] = 0;
-					break;
-				}
-			}
-
-			if ((rt_flag == RT_FLAG_ADD && !neigh) ||
-			    (rt_flag == RT_FLAG_UPDATE && !prev_sender) ||
-			    (rt_flag == RT_FLAG_DELETE && !orig)) {
-				fprintf(stderr,
-					"Broken '%s route' line found - skipping [file: %s, line: %i]\n",
-					(rt_flag == RT_FLAG_UPDATE ? "changing" :
-					 (rt_flag == RT_FLAG_ADD ? "adding" : "deleting")),
-					file_path, line_count);
-				continue;
-			}
-
-			res = routing_table_new(orig, neigh, prev_sender, rt_flag);
-			if (res < 1)
-				fprintf(stderr, " [file: %s, line: %i]\n", file_path, line_count);
-		}
-	}
-
-//	printf("File '%s' parsed (lines: %i)\n", file_path, line_count);
-	fclose(fd);
-	curr_bat_node = NULL;
-	return 1;
-}
-
-static struct rt_hist *get_rt_hist_by_seqno(struct orig_event *orig_event, long long seqno)
-{
-	struct seqno_event *seqno_event;
-	struct rt_hist *rt_hist = NULL;
-
-	list_for_each_entry(seqno_event, &orig_event->event_list, list) {
-		if (seqno_event->seqno > seqno)
-			break;
-
-		if (seqno_event->rt_hist)
-			rt_hist = seqno_event->rt_hist;
-	}
-
-	return rt_hist;
-}
-
-static struct rt_hist *get_rt_hist_by_node_seqno(struct bat_node *bat_node,
-						 struct bat_node *orig_node, long long seqno)
-{
-	struct orig_event *orig_event;
-	struct rt_hist *rt_hist;
-
-	orig_event = orig_event_get_by_ptr(bat_node, orig_node);
-	if (!orig_event)
-		return NULL;
-
-	rt_hist = get_rt_hist_by_seqno(orig_event, seqno);
-	return rt_hist;
-}
-
-static int print_rt_path_at_seqno(struct bat_node *src_node, struct bat_node *dst_node,
-				  struct bat_node *next_hop, long long seqno,
-				  long long seqno_rand, int read_opt)
-{
-	char curr_loop_magic[LOOP_MAGIC_LEN];
-	struct bat_node *next_hop_tmp;
-	struct orig_event *orig_event;
-	struct rt_hist *rt_hist;
-
-	snprintf(curr_loop_magic, sizeof(curr_loop_magic), "%s%s%lli%lli", src_node->name,
-		 dst_node->name, seqno, seqno_rand);
-
-	printf("Path towards %s (seqno %lli ",
-	       get_name_by_macstr(dst_node->name, read_opt), seqno);
-
-	printf("via neigh %s):", get_name_by_macstr(next_hop->name, read_opt));
-
-	next_hop_tmp = next_hop;
-
-	while (1) {
-		printf(" -> %s%s",
-		       get_name_by_macstr(next_hop_tmp->name, read_opt),
-		       (dst_node == next_hop_tmp ? "." : ""));
-
-		/* destination reached */
-		if (dst_node == next_hop_tmp)
-			break;
-
-		orig_event = orig_event_get_by_ptr(next_hop_tmp, dst_node);
-		if (!orig_event)
-			goto out;
-
-		/* no more data - path seems[tm] fine */
-		if (list_empty(&orig_event->event_list))
-			goto out;
-
-		/* same here */
-		if (list_empty(&orig_event->rt_hist_list))
-			goto out;
-
-		/* we are running in a loop */
-		if (memcmp(curr_loop_magic, next_hop_tmp->loop_magic, LOOP_MAGIC_LEN) == 0) {
-			printf("   aborted due to loop!");
-			goto out;
-		}
-
-		memcpy(next_hop_tmp->loop_magic, curr_loop_magic, sizeof(next_hop_tmp->loop_magic));
-
-		rt_hist = get_rt_hist_by_seqno(orig_event, seqno);
-
-		/* no more routing data - what can we do ? */
-		if (!rt_hist)
-			break;
-
-		next_hop_tmp = rt_hist->next_hop;
-	}
-
-out:
-	printf("\n");
-	return 1;
-}
-
-static int find_rt_table_change(struct bat_node *src_node, struct bat_node *dst_node,
-				struct bat_node *curr_node, long long seqno_min,
-				long long seqno_max, long long seqno_rand, int read_opt)
-{
-	char curr_loop_magic[LOOP_MAGIC_LEN];
-	long long seqno_min_tmp = seqno_min;
-	struct orig_event *orig_event;
-	struct rt_hist *rt_hist_tmp;
-	struct rt_hist *rt_hist;
-	char loop_check = 0;
-	long long seqno_tmp;
-	int res;
-
-	/* recursion ends here */
-	if (curr_node == dst_node) {
-		rt_hist = get_rt_hist_by_node_seqno(src_node, dst_node, seqno_max);
-
-		if (rt_hist)
-			print_rt_path_at_seqno(src_node, dst_node, rt_hist->next_hop,
-					       seqno_max, seqno_rand, read_opt);
-		return 0;
-	}
-
-	snprintf(curr_loop_magic, sizeof(curr_loop_magic), "%s%s%lli%lli",
-		 src_node->name, dst_node->name,
-		 seqno_min_tmp, seqno_rand);
-
-	orig_event = orig_event_get_by_ptr(curr_node, dst_node);
-	if (!orig_event)
-		goto out;
-
-	list_for_each_entry(rt_hist, &orig_event->rt_hist_list, list) {
-		/* special seqno that indicates an originator timeout */
-		if (rt_hist->seqno_event->seqno == -1) {
-			printf("Woot - originator timeout ??\n");
-			continue;
-		}
-
-		if (seqno_min_tmp != -1 && rt_hist->seqno_event->seqno < seqno_min_tmp)
-			continue;
-
-		if (seqno_max != -1 && rt_hist->seqno_event->seqno >= seqno_max)
-			continue;
-
-		/* we are running in a loop */
-		if (memcmp(curr_loop_magic, rt_hist->loop_magic, LOOP_MAGIC_LEN) == 0) {
-			rt_hist_tmp = get_rt_hist_by_node_seqno(src_node, dst_node,
-								rt_hist->seqno_event->seqno);
-
-			if (rt_hist_tmp)
-				print_rt_path_at_seqno(src_node, dst_node, rt_hist_tmp->next_hop,
-						       rt_hist->seqno_event->seqno, seqno_rand,
-						       read_opt);
-			goto loop;
-		}
-
-		memcpy(rt_hist->loop_magic, curr_loop_magic, sizeof(rt_hist->loop_magic));
-		loop_check = 1;
-
-		res = find_rt_table_change(src_node, dst_node, rt_hist->next_hop,
-					   seqno_min_tmp, rt_hist->seqno_event->seqno,
-					   seqno_rand, read_opt);
-
-		seqno_min_tmp = rt_hist->seqno_event->seqno + 1;
-
-		/* find_rt_table_change() did not run into a loop and printed the path */
-		if (res == 0)
-			continue;
-
-		/* retrieve routing table towards dst at that point and
-		 * print the routing path
-		 */
-		rt_hist_tmp = get_rt_hist_by_node_seqno(src_node, dst_node,
-							rt_hist->seqno_event->seqno);
-
-		if (!rt_hist_tmp)
-			continue;
-
-		print_rt_path_at_seqno(src_node, dst_node, rt_hist_tmp->next_hop,
-				       rt_hist->seqno_event->seqno, seqno_rand, read_opt);
-	}
-
-	/* if we have no routing table changes within the seqno range
-	 * the loop detection above won't be triggered
-	 */
-	if (!loop_check) {
-		if (memcmp(curr_loop_magic, curr_node->loop_magic2, LOOP_MAGIC_LEN) == 0) {
-			rt_hist_tmp = get_rt_hist_by_node_seqno(src_node, dst_node, seqno_min);
-
-			if (rt_hist_tmp)
-				print_rt_path_at_seqno(src_node, dst_node, rt_hist_tmp->next_hop,
-						       seqno_min, seqno_rand, read_opt);
-
-			/* no need to print the path twice */
-			if (seqno_min == seqno_max)
-				goto out;
-			else
-				goto loop;
-		}
-
-		memcpy(curr_node->loop_magic2, curr_loop_magic, sizeof(curr_node->loop_magic2));
-	}
-
-	seqno_tmp = seqno_max - 1;
-	if (seqno_min == seqno_max)
-		seqno_tmp = seqno_max;
-
-	rt_hist = get_rt_hist_by_seqno(orig_event, seqno_tmp);
-
-	if (rt_hist)
-		return find_rt_table_change(src_node, dst_node, rt_hist->next_hop,
-					    seqno_min_tmp, seqno_max, seqno_rand, read_opt);
-
-out:
-	return -1;
-loop:
-	return -2;
-}
-
-static void loop_detection(char *loop_orig, long long seqno_min, long long seqno_max,
-			   char *filter_orig, int read_opt)
-{
-	struct hash_it_t *hashit = NULL;
-	struct orig_event *orig_event;
-	struct rt_hist *prev_rt_hist;
-	struct bat_node *bat_node;
-	long long last_seqno = -1;
-	long long seqno_count = 0;
-	char check_orig[NAME_LEN];
-	struct rt_hist *rt_hist;
-	int res;
-
-	printf("\nAnalyzing routing tables ");
-
-	/* if no option was given loop_orig is empty */
-	memset(check_orig, 0, NAME_LEN);
-	if (!compare_name(loop_orig, check_orig))
-		printf("of originator: %s ",
-		       get_name_by_macstr(loop_orig, read_opt));
-
-	if ((seqno_min == -1) && (seqno_max == -1))
-		printf("[all sequence numbers]");
-	else if (seqno_min == seqno_max)
-		printf("[sequence number: %lli]", seqno_min);
-	else
-		printf("[sequence number range: %lli-%lli]", seqno_min, seqno_max);
-
-	if (!compare_name(filter_orig, check_orig))
-		printf(" [filter originator: %s]",
-		       get_name_by_macstr(filter_orig, read_opt));
-
-	printf("\n");
-
-	while (NULL != (hashit = hash_iterate(node_hash, hashit))) {
-		bat_node = hashit->bucket->data;
-
-		if (!compare_name(loop_orig, check_orig) &&
-		    !compare_name(loop_orig, bat_node->name))
-			continue;
-
-		printf("\nChecking host: %s\n",
-		       get_name_by_macstr(bat_node->name, read_opt));
-
-		list_for_each_entry(orig_event, &bat_node->orig_event_list, list) {
-			if (bat_node == orig_event->orig_node)
-				continue;
-
-			if (!compare_name(filter_orig, check_orig) &&
-			    !compare_name(filter_orig, orig_event->orig_node->name))
-				continue;
-
-			/* we might have no log file from this node */
-			if (list_empty(&orig_event->event_list)) {
-				fprintf(stderr, "No seqno data of originator '%s' - skipping\n",
-					get_name_by_macstr(orig_event->orig_node->name, read_opt));
-				continue;
-			}
-
-			/* or routing tables */
-			if (list_empty(&orig_event->rt_hist_list)) {
-				fprintf(stderr,
-					"No routing history of originator '%s' - skipping\n",
-					get_name_by_macstr(orig_event->orig_node->name, read_opt));
-				continue;
-			}
-
-			list_for_each_entry(rt_hist, &orig_event->rt_hist_list, list) {
-				/* special seqno that indicates an originator timeout */
-				if (rt_hist->seqno_event->seqno == -1)
-					continue;
-
-				if (seqno_min != -1 && rt_hist->seqno_event->seqno < seqno_min)
-					continue;
-
-				if (seqno_max != -1 && rt_hist->seqno_event->seqno > seqno_max)
-					continue;
-
-				/* sometime we change the routing table more than once
-				 * with the same seqno
-				 */
-				if (last_seqno == rt_hist->seqno_event->seqno)
-					seqno_count++;
-				else
-					seqno_count = 0;
-
-				last_seqno = rt_hist->seqno_event->seqno;
-
-				if (rt_hist->flags == RT_FLAG_DELETE) {
-					printf("Path towards %s deleted (originator timeout)\n",
-					       get_name_by_macstr(rt_hist->seqno_event->orig->name,
-								  read_opt));
-					continue;
-				}
-
-				prev_rt_hist = rt_hist->prev_rt_hist;
-
-				if (prev_rt_hist &&
-				    rt_hist->seqno_event->seqno != prev_rt_hist->seqno_event->seqno) {
-					if (rt_hist->seqno_event->seqno < prev_rt_hist->seqno_event->seqno) {
-						fprintf(stderr,
-							"Smaller seqno (%lli) than previously received seqno (%lli) of orig %s triggered routing table change - skipping recursive check\n",
-							rt_hist->seqno_event->seqno,
-							prev_rt_hist->seqno_event->seqno,
-							get_name_by_macstr(rt_hist->seqno_event->orig->name,
-									   read_opt));
-						goto validate_path;
-					}
-
-					if (rt_hist->seqno_event->seqno == prev_rt_hist->seqno_event->seqno + 1)
-						goto validate_path;
-
-					res = find_rt_table_change(bat_node,
-								   rt_hist->seqno_event->orig,
-								   prev_rt_hist->next_hop,
-								   prev_rt_hist->seqno_event->seqno + 1,
-								   rt_hist->seqno_event->seqno,
-								   seqno_count, read_opt);
-
-					if (res != -2)
-						continue;
-				}
-
-validate_path:
-				print_rt_path_at_seqno(bat_node, rt_hist->seqno_event->orig,
-						       rt_hist->next_hop,
-						       rt_hist->seqno_event->seqno,
-						       seqno_count, read_opt);
-			}
-		}
-	}
-}
-
-static void seqno_trace_print_neigh(struct seqno_trace_neigh *seqno_trace_neigh,
-				    struct seqno_event *seqno_event_parent,
-				    int num_sisters, char *head, int read_opt)
-{
-	char new_head[MAX_LINE];
-	int i;
-
-	printf("%s%s- %s [tq: %i, ttl: %i", head,
-	       (strlen(head) == 1 ? "" : num_sisters == 0 ? "\\" : "|"),
-	       get_name_by_macstr(seqno_trace_neigh->bat_node->name, read_opt),
-	       seqno_trace_neigh->seqno_event->tq,
-	       seqno_trace_neigh->seqno_event->ttl);
-
-	printf(", neigh: %s",
-	       get_name_by_macstr(seqno_trace_neigh->seqno_event->neigh->name, read_opt));
-	printf(", prev_sender: %s]",
-	       get_name_by_macstr(seqno_trace_neigh->seqno_event->prev_sender->name, read_opt));
-
-	if (seqno_event_parent &&
-	    seqno_trace_neigh->seqno_event->tq > seqno_event_parent->tq)
-		printf("  TQ UP!\n");
-	else
-		printf("\n");
-
-	for (i = 0; i < seqno_trace_neigh->num_neighbors; i++) {
-		snprintf(new_head, sizeof(new_head), "%s%s",
-			 (strlen(head) > 1 ? head : num_sisters == 0 ? " " : head),
-			 (strlen(head) == 1 ? "   " : num_sisters == 0 ? "    " : "|   "));
-
-		seqno_trace_print_neigh(seqno_trace_neigh->seqno_trace_neigh[i],
-					seqno_trace_neigh->seqno_event,
-					seqno_trace_neigh->num_neighbors - i - 1,
-					new_head, read_opt);
-	}
-}
-
-static void seqno_trace_print(struct list_head *trace_list, char *trace_orig,
-			      long long seqno_min, long long seqno_max, char *filter_orig,
-			      int read_opt)
-{
-	struct seqno_trace *seqno_trace;
-	char check_orig[NAME_LEN];
-	char head[MAX_LINE];
-	int i;
-
-	/* if no option was given filter_orig is empty */
-	memset(check_orig, 0, NAME_LEN);
-
-	printf("Sequence number flow of originator: %s ",
-	       get_name_by_macstr(trace_orig, read_opt));
-
-	if ((seqno_min == -1) && (seqno_max == -1))
-		printf("[all sequence numbers]");
-	else if (seqno_min == seqno_max)
-		printf("[sequence number: %lli]", seqno_min);
-	else
-		printf("[sequence number range: %lli-%lli]", seqno_min, seqno_max);
-
-	if (!compare_name(filter_orig, check_orig))
-		printf(" [filter originator: %s]",
-		       get_name_by_macstr(filter_orig, read_opt));
-
-	printf("\n");
-
-	list_for_each_entry(seqno_trace, trace_list, list) {
-		if (!seqno_trace->print)
-			continue;
-
-		printf("+=> %s (seqno %lli)\n",
-		       get_name_by_macstr(trace_orig, read_opt),
-		       seqno_trace->seqno);
-
-		for (i = 0; i < seqno_trace->seqno_trace_neigh.num_neighbors; i++) {
-			snprintf(head, sizeof(head), "%c",
-				 seqno_trace->seqno_trace_neigh.num_neighbors == i + 1 ? '\\' : '|');
-
-			seqno_trace_print_neigh(seqno_trace->seqno_trace_neigh.seqno_trace_neigh[i],
-						NULL,
-						seqno_trace->seqno_trace_neigh.num_neighbors - i - 1,
-						head, read_opt);
-		}
-
-		printf("\n");
-	}
-}
-
-static int _seqno_trace_neigh_add(struct seqno_trace_neigh *seqno_trace_mom,
-				  struct seqno_trace_neigh *seqno_trace_child)
-{
-	struct seqno_trace_neigh **data_ptr;
-
-	data_ptr = calloc(seqno_trace_mom->num_neighbors + 1, sizeof(*data_ptr));
-	if (!data_ptr)
-		return 0;
-
-	if (seqno_trace_mom->num_neighbors > 0) {
-		memcpy(data_ptr, seqno_trace_mom->seqno_trace_neigh,
-		       seqno_trace_mom->num_neighbors * sizeof(struct seqno_trace_neigh *));
-		free(seqno_trace_mom->seqno_trace_neigh);
-	}
-
-	seqno_trace_mom->num_neighbors++;
-	seqno_trace_mom->seqno_trace_neigh = data_ptr;
-	seqno_trace_mom->seqno_trace_neigh[seqno_trace_mom->num_neighbors - 1] = seqno_trace_child;
-	return 1;
-}
-
-static struct seqno_trace_neigh *seqno_trace_neigh_add(struct seqno_trace_neigh *seqno_trace_neigh,
-						       struct bat_node *bat_node,
-						       struct seqno_event *seqno_event)
-{
-	struct seqno_trace_neigh *seqno_trace_neigh_new;
-	int res;
-
-	seqno_trace_neigh_new = malloc(sizeof(struct seqno_trace_neigh));
-	if (!seqno_trace_neigh_new)
-		goto err;
-
-	seqno_trace_neigh_new->bat_node = bat_node;
-	seqno_trace_neigh_new->seqno_event = seqno_event;
-	seqno_trace_neigh_new->num_neighbors = 0;
-
-	res = _seqno_trace_neigh_add(seqno_trace_neigh, seqno_trace_neigh_new);
-
-	if (res < 1)
-		goto free_neigh;
-
-	return seqno_trace_neigh_new;
-
-free_neigh:
-	free(seqno_trace_neigh_new);
-err:
-	return NULL;
-}
-
-static struct seqno_trace_neigh *seqno_trace_find_neigh(struct bat_node *neigh,
-							struct bat_node *prev_sender,
-							struct seqno_trace_neigh *seqno_trace_neigh)
-{
-	struct seqno_trace_neigh *seqno_trace_neigh_tmp;
-	struct seqno_trace_neigh *seqno_trace_neigh_ret;
-	int i;
-
-	for (i = 0; i < seqno_trace_neigh->num_neighbors; i++) {
-		seqno_trace_neigh_tmp = seqno_trace_neigh->seqno_trace_neigh[i];
-
-		if (neigh == seqno_trace_neigh_tmp->bat_node &&
-		    prev_sender == seqno_trace_neigh_tmp->seqno_event->neigh)
-			return seqno_trace_neigh_tmp;
-
-		seqno_trace_neigh_ret = seqno_trace_find_neigh(neigh, prev_sender,
-							       seqno_trace_neigh_tmp);
-
-		if (seqno_trace_neigh_ret)
-			return seqno_trace_neigh_ret;
-	}
-
-	return NULL;
-}
-
-static void seqno_trace_neigh_free(struct seqno_trace_neigh *seqno_trace_neigh)
-{
-	int i;
-
-	for (i = 0; i < seqno_trace_neigh->num_neighbors; i++)
-		seqno_trace_neigh_free(seqno_trace_neigh->seqno_trace_neigh[i]);
-
-	if (seqno_trace_neigh->num_neighbors > 0)
-		free(seqno_trace_neigh->seqno_trace_neigh);
-
-	free(seqno_trace_neigh);
-}
-
-static int seqno_trace_fix_leaf(struct seqno_trace_neigh *seqno_trace_mom,
-				struct seqno_trace_neigh *seqno_trace_old_mom,
-				struct seqno_trace_neigh *seqno_trace_child)
-{
-	struct seqno_trace_neigh *seqno_trace_neigh;
-	struct seqno_trace_neigh **data_ptr;
-	int j = 0;
-	int i;
-
-	data_ptr = calloc(seqno_trace_old_mom->num_neighbors - 1, sizeof(*data_ptr));
-	if (!data_ptr)
-		return 0;
-
-	/* copy all children except the child that is going to move */
-	for (i = 0; i < seqno_trace_old_mom->num_neighbors; i++) {
-		seqno_trace_neigh = seqno_trace_old_mom->seqno_trace_neigh[i];
-
-		if (seqno_trace_neigh != seqno_trace_child) {
-			data_ptr[j] = seqno_trace_neigh;
-			j++;
-		}
-	}
-
-	seqno_trace_old_mom->num_neighbors--;
-	free(seqno_trace_old_mom->seqno_trace_neigh);
-	seqno_trace_old_mom->seqno_trace_neigh = data_ptr;
-
-	return _seqno_trace_neigh_add(seqno_trace_mom, seqno_trace_child);
-}
-
-static int seqno_trace_check_leaves(struct seqno_trace *seqno_trace,
-				    struct seqno_trace_neigh *seqno_trace_neigh_new)
-{
-	struct seqno_trace_neigh *seqno_trace_neigh_tmp;
-	int res;
-	int i;
-
-	for (i = 0; i < seqno_trace->seqno_trace_neigh.num_neighbors; i++) {
-		seqno_trace_neigh_tmp = seqno_trace->seqno_trace_neigh.seqno_trace_neigh[i];
-
-		if (seqno_trace_neigh_tmp->seqno_event->neigh == seqno_trace_neigh_new->bat_node &&
-		    seqno_trace_neigh_tmp->seqno_event->prev_sender == seqno_trace_neigh_new->seqno_event->neigh) {
-			res = seqno_trace_fix_leaf(seqno_trace_neigh_new,
-						   &seqno_trace->seqno_trace_neigh,
-						   seqno_trace_neigh_tmp);
-
-			if (res < 1)
-				return res;
-
-			/* restart checking procedure because we just changed
-			 * the array we are working on
-			 */
-			return seqno_trace_check_leaves(seqno_trace, seqno_trace_neigh_new);
-		}
-	}
-
-	return 1;
-}
-
-static struct seqno_trace *seqno_trace_new(struct seqno_event *seqno_event)
-{
-	struct seqno_trace *seqno_trace;
-
-	seqno_trace = malloc(sizeof(struct seqno_trace));
-	if (!seqno_trace) {
-		fprintf(stderr,
-			"Could not allocate memory for seqno tracing data (out of mem?)\n");
-		return NULL;
-	}
-
-	seqno_trace->seqno = seqno_event->seqno;
-	seqno_trace->print = 0;
-
-	seqno_trace->seqno_trace_neigh.num_neighbors = 0;
-
-	return seqno_trace;
-}
-
-static void seqno_trace_free(struct seqno_trace *seqno_trace)
-{
-	int i;
-
-	for (i = 0; i < seqno_trace->seqno_trace_neigh.num_neighbors; i++)
-		seqno_trace_neigh_free(seqno_trace->seqno_trace_neigh.seqno_trace_neigh[i]);
-
-	free(seqno_trace);
-}
-
-static int seqno_trace_add(struct list_head *trace_list, struct bat_node *bat_node,
-			   struct seqno_event *seqno_event, char print_trace)
-{
-	struct seqno_trace *seqno_trace_prev = NULL;
-	struct seqno_trace_neigh *seqno_trace_neigh;
-	struct seqno_trace *seqno_trace_tmp = NULL;
-	struct seqno_trace *seqno_trace = NULL;
-
-	list_for_each_entry(seqno_trace_tmp, trace_list, list) {
-		if (seqno_trace_tmp->seqno == seqno_event->seqno) {
-			seqno_trace = seqno_trace_tmp;
-			break;
-		}
-
-		if (seqno_trace_tmp->seqno > seqno_event->seqno)
-			break;
-
-		seqno_trace_prev = seqno_trace_tmp;
-	}
-
-	if (!seqno_trace) {
-		seqno_trace = seqno_trace_new(seqno_event);
-		if (!seqno_trace)
-			goto err;
-
-		if (list_empty(trace_list) ||
-		    seqno_event->seqno > list_last_entry(trace_list, struct seqno_trace, list)->seqno)
-			list_add_tail(&seqno_trace->list, trace_list);
-		else if (seqno_event->seqno < list_first_entry(trace_list, struct seqno_trace, list)->seqno)
-			list_add(&seqno_trace->list, trace_list);
-		else
-			list_add_behind(&seqno_trace->list, &seqno_trace_prev->list);
-	}
-
-	if (print_trace)
-		seqno_trace->print = print_trace;
-
-	seqno_trace_neigh = seqno_trace_find_neigh(seqno_event->neigh,
-						   seqno_event->prev_sender,
-						   &seqno_trace->seqno_trace_neigh);
-
-	/* no neighbor found to hook up to - adding new root node */
-	if (!seqno_trace_neigh)
-		seqno_trace_neigh = seqno_trace_neigh_add(&seqno_trace->seqno_trace_neigh,
-							  bat_node, seqno_event);
-	else
-		seqno_trace_neigh = seqno_trace_neigh_add(seqno_trace_neigh, bat_node, seqno_event);
-
-	if (seqno_trace_neigh)
-		seqno_trace_check_leaves(seqno_trace, seqno_trace_neigh);
-
-	return 1;
-
-err:
-	return 0;
-}
-
-static void trace_seqnos(char *trace_orig, long long seqno_min, long long seqno_max,
-			 char *filter_orig, int read_opt)
-{
-	struct seqno_trace *seqno_trace_tmp;
-	struct seqno_trace *seqno_trace;
-	struct seqno_event *seqno_event;
-	struct hash_it_t *hashit = NULL;
-	struct orig_event *orig_event;
-	struct list_head trace_list;
-	struct bat_node *bat_node;
-	char check_orig[NAME_LEN];
-	char print_trace;
-	int res;
-
-	/* if no option was given filter_orig is empty */
-	memset(check_orig, 0, NAME_LEN);
-	INIT_LIST_HEAD(&trace_list);
-
-	while (NULL != (hashit = hash_iterate(node_hash, hashit))) {
-		bat_node = hashit->bucket->data;
-
-		list_for_each_entry(orig_event, &bat_node->orig_event_list, list) {
-			/* we might have no log file from this node */
-			if (list_empty(&orig_event->event_list))
-				continue;
-
-			list_for_each_entry(seqno_event, &orig_event->event_list, list) {
-				/* special seqno that indicates an originator timeout */
-				if (seqno_event->seqno == -1)
-					continue;
-
-				if (!compare_name(trace_orig, seqno_event->orig->name))
-					continue;
-
-				if (seqno_min != -1 && seqno_event->seqno < seqno_min)
-					continue;
-
-				if (seqno_max != -1 && seqno_event->seqno > seqno_max)
-					continue;
-
-				/* if no filter option was given all seqno
-				 * traces are to be printed
-				 */
-				print_trace = compare_name(filter_orig, check_orig);
-
-				if (!compare_name(filter_orig, check_orig) &&
-				    compare_name(filter_orig, bat_node->name))
-					print_trace = 1;
-
-				res = seqno_trace_add(&trace_list, bat_node, seqno_event, print_trace);
-
-				if (res < 1) {
-					hash_iterate_free(hashit);
-					goto out;
-				}
-			}
-		}
-	}
-
-	seqno_trace_print(&trace_list, trace_orig, seqno_min, seqno_max, filter_orig, read_opt);
-
-out:
-	list_for_each_entry_safe(seqno_trace, seqno_trace_tmp, &trace_list, list) {
-		list_del(&seqno_trace->list);
-		seqno_trace_free(seqno_trace);
-	}
-}
-
-static void print_rt_tables(char *rt_orig, long long seqno_min, long long seqno_max,
-			    char *filter_orig, int read_opt)
-{
-	struct seqno_event *seqno_event;
-	struct bat_node *bat_node;
-	struct rt_table *rt_table;
-	char check_orig[NAME_LEN];
-	int i;
-
-	/* if no option was given filter_orig is empty */
-	memset(check_orig, 0, NAME_LEN);
-
-	printf("Routing tables of originator: %s ",
-	       get_name_by_macstr(rt_orig, read_opt));
-
-	if ((seqno_min == -1) && (seqno_max == -1))
-		printf("[all sequence numbers]");
-	else if (seqno_min == seqno_max)
-		printf("[sequence number: %lli]", seqno_min);
-	else
-		printf("[sequence number range: %lli-%lli]", seqno_min, seqno_max);
-
-	if (!compare_name(filter_orig, check_orig))
-		printf(" [filter originator: %s]",
-		       get_name_by_macstr(filter_orig, read_opt));
-
-	printf("\n");
-
-	bat_node = node_get(rt_orig);
-	if (!bat_node)
-		goto out;
-
-	/* we might have no log file from this node */
-	if (list_empty(&bat_node->rt_table_list))
-		goto out;
-
-	list_for_each_entry(rt_table, &bat_node->rt_table_list, list) {
-		seqno_event = rt_table->rt_hist->seqno_event;
-
-		if (!compare_name(filter_orig, check_orig) &&
-		    !compare_name(filter_orig, seqno_event->orig->name))
-			continue;
-
-		if (seqno_min != -1 && seqno_event->seqno < seqno_min)
-			continue;
-
-		if (seqno_max != -1 && seqno_event->seqno > seqno_max)
-			continue;
-
-		if (seqno_event->seqno > -1) {
-			printf("rt change triggered by OGM from: %s (tq: %i, ttl: %i, seqno %lli",
-			       get_name_by_macstr(seqno_event->orig->name, read_opt),
-			       seqno_event->tq, seqno_event->ttl, seqno_event->seqno);
-			printf(", neigh: %s",
-			       get_name_by_macstr(seqno_event->neigh->name, read_opt));
-			printf(", prev_sender: %s)\n",
-			       get_name_by_macstr(seqno_event->prev_sender->name, read_opt));
-		} else {
-			printf("rt change triggered by originator timeout:\n");
-		}
-
-		for (i = 0; i < rt_table->num_entries; i++) {
-			printf("%s %s via next hop",
-			       (rt_table->entries[i].flags ? "   *" : "    "),
-			       get_name_by_macstr(rt_table->entries[i].orig, read_opt));
-			printf(" %s",
-			       get_name_by_macstr(rt_table->entries[i].next_hop->name, read_opt));
-
-			switch (rt_table->entries[i].flags) {
-			case RT_FLAG_ADD:
-				printf(" (route added)\n");
-				break;
-			case RT_FLAG_UPDATE:
-				printf(" (next hop changed)\n");
-				break;
-			case RT_FLAG_DELETE:
-				printf(" (route deleted)\n");
-				break;
-			default:
-				printf("\n");
-				break;
-			}
-		}
-
-		printf("\n");
-	}
-
-out:
-	return;
-}
-
-static int get_orig_addr(char *orig_name, char *orig_addr)
-{
-	char *orig_name_tmp = orig_name;
-	struct ether_addr *orig_mac;
-	struct bat_host *bat_host;
-
-	bat_host = bat_hosts_find_by_name(orig_name_tmp);
-
-	if (bat_host) {
-		orig_name_tmp = ether_ntoa_long((struct ether_addr *)&bat_host->mac_addr);
-		goto copy_name;
-	}
-
-	orig_mac = ether_aton(orig_name_tmp);
-
-	if (!orig_mac) {
-		fprintf(stderr,
-			"Error - the originator is not a mac address or bat-host name: %s\n",
-			orig_name);
-		goto err;
-	}
-
-	/* convert the given mac address to the long format to
-	 * make sure we can find it
-	 */
-	orig_name_tmp = ether_ntoa_long(orig_mac);
-
-copy_name:
-	strncpy(orig_addr, orig_name_tmp, NAME_LEN);
-	orig_addr[NAME_LEN - 1] = '\0';
-	return 1;
-
-err:
-	return 0;
-}
-
-static int bisect_iv(struct state *state __maybe_unused, int argc, char **argv)
-{
-	int read_opt = USE_BAT_HOSTS;
-	char *filter_orig_ptr = NULL;
-	char *trace_orig_ptr = NULL;
-	char *loop_orig_ptr = NULL;
-	char filter_orig[NAME_LEN];
-	char *rt_orig_ptr = NULL;
-	long long seqno_max = -1;
-	long long seqno_min = -1;
-	int ret = EXIT_FAILURE;
-	int num_parsed_files;
-	long long tmp_seqno;
-	char orig[NAME_LEN];
-	char *dash_ptr;
-	int optchar;
-	int res;
-
-	memset(orig, 0, NAME_LEN);
-	memset(filter_orig, 0, NAME_LEN);
-
-	while ((optchar = getopt(argc, argv, "hl:no:r:s:t:")) != -1) {
-		switch (optchar) {
-		case 'h':
-			bisect_iv_usage();
-			return EXIT_SUCCESS;
-		case 'l':
-			loop_orig_ptr = optarg;
-			break;
-		case 'n':
-			read_opt &= ~USE_BAT_HOSTS;
-			break;
-		case 'o':
-			filter_orig_ptr = optarg;
-			break;
-		case 'r':
-			rt_orig_ptr = optarg;
-			break;
-		case 's':
-			dash_ptr = strchr(optarg, '-');
-			if (dash_ptr)
-				*dash_ptr = 0;
-
-			tmp_seqno = strtol(optarg, NULL, 10);
-			if (tmp_seqno >= 0 && tmp_seqno <= UINT32_MAX)
-				seqno_min = tmp_seqno;
-			else
-				fprintf(stderr,
-					"Warning - given sequence number is out of range: %lli\n",
-					tmp_seqno);
-
-			if (dash_ptr) {
-				tmp_seqno = strtol(dash_ptr + 1, NULL, 10);
-				if (tmp_seqno >= 0 && tmp_seqno <= UINT32_MAX)
-					seqno_max = tmp_seqno;
-				else
-					fprintf(stderr,
-						"Warning - given sequence number is out of range: %lli\n",
-						tmp_seqno);
-
-				*dash_ptr = '-';
-			}
-
-			break;
-		case 't':
-			trace_orig_ptr = optarg;
-			break;
-		default:
-			bisect_iv_usage();
-			return EXIT_FAILURE;
-		}
-	}
-
-	if (argc <= optind + 1) {
-		fprintf(stderr, "Error - need at least 2 log files to compare\n");
-		bisect_iv_usage();
-		goto err;
-	}
-
-	node_hash = hash_new(64, compare_name, choose_name);
-
-	if (!node_hash) {
-		fprintf(stderr, "Error - could not create node hash table\n");
-		goto err;
-	}
-
-	bat_hosts_init(read_opt);
-	num_parsed_files = 0;
-
-	if ((rt_orig_ptr) && (trace_orig_ptr)) {
-		fprintf(stderr,
-			"Error - the 'print routing table' option can't be used together with the 'trace seqno' option\n");
-		goto err;
-	} else if ((loop_orig_ptr) && (trace_orig_ptr)) {
-		fprintf(stderr,
-			"Error - the 'loop detection' option can't be used together with the 'trace seqno' option\n");
-		goto err;
-	} else if ((loop_orig_ptr) && (rt_orig_ptr)) {
-		fprintf(stderr,
-			"Error - the 'loop detection' option can't be used together with the 'print routing table' option\n");
-		goto err;
-	} else if (rt_orig_ptr) {
-		res = get_orig_addr(rt_orig_ptr, orig);
-
-		if (res < 1)
-			goto err;
-	} else if (trace_orig_ptr) {
-		res = get_orig_addr(trace_orig_ptr, orig);
-
-		if (res < 1)
-			goto err;
-	} else if (loop_orig_ptr) {
-		res = get_orig_addr(loop_orig_ptr, orig);
-
-		if (res < 1)
-			goto err;
-	}
-
-	/* we search a specific seqno - no range */
-	if (seqno_min > 0 && seqno_max == -1)
-		seqno_max = seqno_min;
-
-	if (seqno_min > seqno_max) {
-		fprintf(stderr,
-			"Error - the sequence range minimum (%lli) should be smaller than the maximum (%lli)\n",
-			seqno_min, seqno_max);
-		goto err;
-	}
-
-	if (filter_orig_ptr) {
-		res = get_orig_addr(filter_orig_ptr, filter_orig);
-
-		if (res < 1)
-			goto err;
-	}
-
-	while (argc > optind) {
-		res = parse_log_file(argv[optind]);
-
-		if (res > 0)
-			num_parsed_files++;
-
-		optind++;
-	}
-
-	if (num_parsed_files < 2) {
-		fprintf(stderr, "Error - need at least 2 log files to compare\n");
-		goto err;
-	}
-
-	if (trace_orig_ptr)
-		trace_seqnos(orig, seqno_min, seqno_max, filter_orig, read_opt);
-	else if (rt_orig_ptr)
-		print_rt_tables(orig, seqno_min, seqno_max, filter_orig, read_opt);
-	else
-		loop_detection(orig, seqno_min, seqno_max, filter_orig, read_opt);
-
-	ret = EXIT_SUCCESS;
-
-err:
-	if (node_hash)
-		hash_delete(node_hash, node_free);
-	bat_hosts_free();
-	return ret;
-}
-
-COMMAND(SUBCOMMAND, bisect_iv, "bisect_iv", 0, NULL,
-	"<file1> .. <fileN>\tanalyze given batman iv log files for routing stability");
diff --git a/cmd/bisect_iv.h b/cmd/bisect_iv.h
deleted file mode 100644
index 2e9482e..0000000
--- a/cmd/bisect_iv.h
+++ /dev/null
@@ -1,85 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) B.A.T.M.A.N. contributors:
- *
- * Marek Lindner <marek.lindner@mailbox.org>
- *
- * License-Filename: LICENSES/preferred/GPL-2.0
- */
-
-#ifndef _BATCTL_BISECT_IV_H
-#define _BATCTL_BISECT_IV_H
-
-#include "../list.h"
-
-#define NAME_LEN 18
-#define MAX_LINE 256
-#define LOOP_MAGIC_LEN ((2 * NAME_LEN) + (2 * sizeof(int)) - 2)
-
-#define RT_FLAG_ADD 1
-#define RT_FLAG_UPDATE 2
-#define RT_FLAG_DELETE 3
-
-struct bat_node {
-	char name[NAME_LEN];
-	struct list_head orig_event_list;
-	struct list_head rt_table_list;
-	char loop_magic[LOOP_MAGIC_LEN];
-	char loop_magic2[LOOP_MAGIC_LEN];
-};
-
-struct orig_event {
-	struct list_head list;
-	struct bat_node *orig_node;
-	struct list_head event_list;
-	struct list_head rt_hist_list;
-};
-
-struct rt_table {
-	struct list_head list;
-	int num_entries;
-	struct rt_entry *entries;
-	struct rt_hist *rt_hist;
-};
-
-struct rt_hist {
-	struct list_head list;
-	struct rt_table *rt_table;
-	struct rt_hist *prev_rt_hist;
-	struct seqno_event *seqno_event;
-	struct bat_node *next_hop;
-	char flags;
-	char loop_magic[LOOP_MAGIC_LEN];
-};
-
-struct rt_entry {
-	char orig[NAME_LEN];
-	struct bat_node *next_hop;
-	char flags;
-};
-
-struct seqno_event {
-	struct list_head list;
-	struct bat_node *orig;
-	struct bat_node *neigh;
-	struct bat_node *prev_sender;
-	long long seqno;
-	int tq;
-	int ttl;
-	struct rt_hist *rt_hist;
-};
-
-struct seqno_trace_neigh {
-	struct bat_node *bat_node;
-	struct seqno_event *seqno_event;
-	int num_neighbors;
-	struct seqno_trace_neigh **seqno_trace_neigh;
-};
-
-struct seqno_trace {
-	struct list_head list;
-	long long seqno;
-	char print;
-	struct seqno_trace_neigh seqno_trace_neigh;
-};
-
-#endif
diff --git a/functions.c b/functions.c
index e535c1e..24c79da 100644
--- a/functions.c
+++ b/functions.c
@@ -99,17 +99,6 @@ char *get_name_by_macaddr(struct ether_addr *mac_addr, int read_opt)
 	return host_name;
 }
 
-char *get_name_by_macstr(char *mac_str, int read_opt)
-{
-	struct ether_addr *mac_addr;
-
-	mac_addr = ether_aton(mac_str);
-	if (!mac_addr)
-		return mac_str;
-
-	return get_name_by_macaddr(mac_addr, read_opt);
-}
-
 static void file_open_problem_dbg(const char *full_path)
 {
 	fprintf(stderr, "Error - can't open file '%s': %s\n", full_path, strerror(errno));
diff --git a/functions.h b/functions.h
index 19334df..b6b33f5 100644
--- a/functions.h
+++ b/functions.h
@@ -41,7 +41,6 @@ void start_timer(void);
 double end_timer(void);
 char *ether_ntoa_long(const struct ether_addr *addr);
 char *get_name_by_macaddr(struct ether_addr *mac_addr, int read_opt);
-char *get_name_by_macstr(char *mac_str, int read_opt);
 int read_file(const char *full_path, int read_opt);
 struct ether_addr *translate_mac(struct state *state,
 				 const struct ether_addr *mac);
diff --git a/hash.c b/hash.c
index 4b64d17..58046fa 100644
--- a/hash.c
+++ b/hash.c
@@ -101,7 +101,7 @@ static void hash_destroy(struct hashtable_t *hash)
 }
 
 /* free hash_it_t pointer when stopping hash_iterate early */
-void hash_iterate_free(struct hash_it_t *iter_in)
+static void hash_iterate_free(struct hash_it_t *iter_in)
 {
 	free(iter_in);
 }
diff --git a/hash.h b/hash.h
index db30017..09cc206 100644
--- a/hash.h
+++ b/hash.h
@@ -83,7 +83,4 @@ void hash_debug(struct hashtable_t *hash);
 struct hash_it_t *hash_iterate(struct hashtable_t *hash,
 			       struct hash_it_t *iter_in);
 
-/* free hash_it_t pointer when stopping hash_iterate early */
-void hash_iterate_free(struct hash_it_t *iter_in);
-
 #endif
diff --git a/man/batctl.8 b/man/batctl.8
index c0f3aa0..e54e1d9 100644
--- a/man/batctl.8
+++ b/man/batctl.8
@@ -56,15 +56,6 @@ print batctl version and batman-adv version (if the module is loaded)
 
 .SH COMMANDS
 
-.TP
-\fBbisect_iv\fP [\fB\-l MAC\fP][\fB\-t\fP \fIMAC\fP][\fB\-r\fP \fIMAC\fP][\fB\-s\fP \fImin\fP [\- \fImax\fP]][\fB\-o\fP \fIMAC\fP][\fB\-n\fP] \fIlogfile1\fP ...
-Analyses the B.A.T.M.A.N. IV logfiles to build a small internal database of all sent sequence numbers and routing table
-changes. This database can then be analyzed in a number of different ways. With "\-l" the database can be used to search
-for routing loops. Use "\-t" to trace OGMs of a host throughout the network. Use "\-r" to display routing tables of the
-nodes. The option "\-s" can be used to limit the output to a range of sequence numbers, between min and max, or to one
-specific sequence number, min. Furthermore using "\-o" you can filter the output to a specified originator. If "\-n" is
-given batctl will not replace the MAC addresses with bat\-host names in the output.
-.RE
 .TP
 \fBevent\fP|\fBe\fP [\fB\-t\fP|\fB\-r\fP]
 batctl will monitor for events from the netlink kernel interface of batman-adv. The local timestamp of the event will be printed

---
base-commit: c8782f50e39e75341988fa98a8a54d07f4b65071
change-id: 20260708-drop-bisect_iv-3f5747bee259

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

