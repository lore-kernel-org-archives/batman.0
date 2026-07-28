Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B569C54F54
	for <batman@archiver.kernel.org>; Tue, 28 Jul 2026 18:06:40 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 82ED580D5F
	for <batman@archiver.kernel.org>; Tue, 28 Jul 2026 20:06:34 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1785261994;
 b=ZdCqLE5pBNPjbx9B15CJYlMGPycKqzV3C1njUJDnFMMwZhI8skEAJ2kiiwclvWW94yaJC
 RFaxOHTFEaAh22aKptJ/B/UpD+tFKEmlON0SXyrEcdPr6j9thDmb0T1XXLKKAcTpSvhAVAO
 w6TDTQC555hfTkObP9L8Wyy5YTiw/pA=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1785261994; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=hm+PNYRhQYVQH9QsqC4fdvk9UfELLS0AaGAH00adH3w=;
 b=sDGpkOt+TdoOZu21KoJS8vhJeSDKXZcPl2pu99vdX7lTt6qLnWCUqdyd0VfZlKgiI0ufM
 ljhx8MHWWcXMeiCJoH6SiRQTiDAIPd01nSuc7SUOZAUTZsojkML4625YoLWnoiZZgOcBvOW
 t3VI/60O18T6lpoELzI7ks9xMxzC9ZI=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id A6CAD81CDC
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 28 Jul 2026 18:03:25 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1785254605;
	b=IYde9FdzmKkHQRGUiW+BEb1hPriP+G6Swd7eQ3P3l+LaKDbDZagKdLPEYkP2bhNBDK9Xb4
	PMjEwKXQ6cwlAH1No5HvWDwVrwpP1/2Im2kmTn4EdnWCIe2EYc2QHtJeqVhvxw7n39XyO5
	9IU4K3tsGkeQtKTvErAzuN6QxGYTF+A=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1785254605;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=hm+PNYRhQYVQH9QsqC4fdvk9UfELLS0AaGAH00adH3w=;
	b=PUNQIeEgcIRd7aBi+tEAQznmZujVYUv923p9ZLQIF+JZGBk7hOiW9F2kKIUZIAWWY2IlTa
	/oL/d2x8E/DECkZC+BEsQ5HPuP3IOCw6GzLCktfhq8AuCdng0i0D58dke6vhFqoesmxQ+d
	0bwvXiZ+vRMDVHadYdoDBEtL89+8FgA=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=wPd8AW7K;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 47E46200D8;
	Tue, 28 Jul 2026 16:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1785254601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hm+PNYRhQYVQH9QsqC4fdvk9UfELLS0AaGAH00adH3w=;
	b=wPd8AW7KaI+8NExLfHsGNMxtrOrAl9n0diinyGhezUJUVe1atgMz8aMd41Q/sAa1hsOD+d
	eloApBxkmAozavhViLo7dSu/PkXS7nF++57gU755mDaYXnkQqQllqdH8d/rYa2GMroafLl
	H5D+aBArt9zxk6LP/fV4mRCjbxlZWbg=
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 28 Jul 2026 18:01:35 +0200
Subject: [PATCH 6/8] alfred: vis: don't drop the rest of the answer for a
 bogus dataset
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260728-bugfixes-vis-v1-6-2540447c8a67@narfation.org>
References: <20260728-bugfixes-vis-v1-0-2540447c8a67@narfation.org>
In-Reply-To: <20260728-bugfixes-vis-v1-0-2540447c8a67@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1113; i=sven@narfation.org;
 h=from:subject:message-id; bh=RJQ1aw3nQxmC/3OG3btGzWpmXtC7V5AbmoJw8HDMS1g=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFkZl2K2cXnuUWZbMOPYnKkuidd45m3ZfPIv44P/or8M2
 6YfrNm0taOUhUGMi0FWTJFlz5X885vZ38p/nvbxKMwcViaQIQxcnAIwkcWGDL9Zpge9yO1qkjf+
 3HB+9Zq1W+sdzNY0L6t3PBOYGeetVXGHkWG6hLRmzos0nuY9S+c8L/nV76lT4zf11YzZMe4igtm
 c9iwA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: 2EBIYDBHASLU633XW4TUYWCJV3JC5PHM
X-Message-ID-Hash: 2EBIYDBHASLU633XW4TUYWCJV3JC5PHM
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/2EBIYDBHASLU633XW4TUYWCJV3JC5PHM/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

A dataset which is too short to even hold the length of the vis_data
(header) aborted the processing of the answer. The positions of all
following nodes were dropped from the printed document although only the
dataset of a single node was malformed.

This skipped the ops->postamble() call. For the jsondoc/dot format, the
syntax was wrong because of this, the output was never finished.

Skip such a bogus datasets instead and process the rest of the answers.

Fixes: 38eae4d50e81 ("vis: Add an output format which is json conformant.")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 vis/vis.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/vis/vis.c b/vis/vis.c
index 451d79c..93f444b 100644
--- a/vis/vis.c
+++ b/vis/vis.c
@@ -1033,7 +1033,7 @@ static int vis_read_answer(struct globals *globals)
 	while ((vis_data =
 		vis_receive_answer_packet(globals->unix_sock, &len, &ret)) != NULL) {
 		if (len < sizeof(*vis_data))
-			return -1;
+			continue;
 
 		/* check size and skip bogus packets */
 		if (len != VIS_DATA_SIZE(vis_data))

-- 
2.47.3

