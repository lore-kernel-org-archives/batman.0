Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88E4ACD4851
	for <batman@archiver.kernel.org>; Thu, 14 May 2026 09:45:06 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id EF23485CAE
	for <batman@archiver.kernel.org>; Thu, 14 May 2026 11:45:04 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1778751904;
 b=B70m42I8R0y6EQzq1MC0kdiGLHMNa8PQTjCs4hbGAgE1Rl9IW7M+mumubR0owAQfAgBfn
 Zv9qUHdgtOfwRhHiV4xT/FFpPt4gArzRgxKbC1H87yOXihF+DptH5Uo4yuNm2adOUq4DODc
 lkbX1BvgU+0tAnooOs+B2IcYziIC2kw=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1778751904; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=A7ENSM+nHUTiwuG8RLxI1ojvDbt+B8w2Kd+sLSDz9GQ=;
 b=NLQw06J0d9EiAMz1YHJ1V1rGoVBJ7g70l6GOqgoy+3eQe3hgxokCqArGqeCB2OdRiICoA
 9CSQxD/HBq0sRewpsP3/Va7ebbudVqDs+Hrll4e4yxOWOo/a+UE/egjrI4UKnrPGobnufae
 lXK4p6sF4IiTlhvJ/+1ES6b4qYFRoKU=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 3E1C78561E
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 14 May 2026 11:43:49 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1778751839;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=A7ENSM+nHUTiwuG8RLxI1ojvDbt+B8w2Kd+sLSDz9GQ=;
	b=jM55PCQJs8E5eAdF/YRot2tHA7Opx2fXCMH102LdaNnSxXWLej4luxLxrAfjCHnVtaNwKB
	IYiLfL6cwZALWjXBH5/6tuGfeBQktGqmo5aKHC59NXlmorX76lgN5S7hcN1C7esofBPt9B
	4dKI3RSMXKKgVwDcW6foXh9DbHHSZno=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=i29Ljo4x;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1778751839;
	b=QkEZU6NwxyWSr10wgxQ5Wf1atL3/kraWgKzXQ1YqHSuu60kql/HU/QmpmZfzff8JQZ0yw6
	FBjrGfMLF3IkcK1n8hIwhm5O4HiaMHD5SgwDPSEYXZHTkL3gg9M20SwNDBvjDtpmtGHrP9
	lrJ+po+BJdBpPDZd9O/goUcUoXvfSLE=
Received: by dvalin.narfation.org (Postfix) id C323921BD1;
	Thu, 14 May 2026 09:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1778751828;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A7ENSM+nHUTiwuG8RLxI1ojvDbt+B8w2Kd+sLSDz9GQ=;
	b=i29Ljo4x9CFtVmBKAh3CoWvGEMTl7UsPAAykNy5Dk07rTTIHyk4zhmJ4OwzX6iUtmQD+AC
	kPd14Vu45TrSTUpOWoqyaqG5SjMhfxrSZlqDrh3gqKrcvtv5aTOgtpVCxphBMTtiXEJe0i
	gemFBkUiUmLUBxqj+ofTlngTJLnl4OU=
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v6 3/3] batman-adv: avoid adding bridge VLAN IDs
 through ndo_vlan_rx_add_vid()
From: Sven Eckelmann <sven@narfation.org>
To: Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org,
 =?utf-8?q?Linus_L=C3=BCssing?= <linus.luessing@c0d3.blue>
In-Reply-To: <20250221-dynamic-vlans-v6-3-fd94c9b782a7@narfation.org>
References: <20250221-dynamic-vlans-v6-0-fd94c9b782a7@narfation.org>
 <20250221-dynamic-vlans-v6-3-fd94c9b782a7@narfation.org>
Date: Thu, 14 May 2026 11:43:27 +0200
Message-Id: <177875180718.12060.5837652701808607571.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=536; i=sven@narfation.org;
 h=from:subject:message-id; bh=HpIb6lAqHP0FkcX/OLA9ykI/CUWEC8a05LPo1Hae+vQ=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFmsM72PPo0y1D68YsLB1zOZShpZNh9g7L5SWTF3/8V61
 ogba1cIdpSyMIhxMciKKbLsuZJ/fjP7W/nP0z4ehZnDygQyhIGLUwAmspaN4X/6Ux2ZGO33f44u
 WG+/rF/HQbG8Smnm64++716LSm4Lj5rByDDn/c4JR7a6OhlOnbNwj8ejjScm1TEe2O1stzTynbi
 UiSYLAA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: MOVSWHKMBHBZ74LDUTF4PKP5E5PRDC5K
X-Message-ID-Hash: MOVSWHKMBHBZ74LDUTF4PKP5E5PRDC5K
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/MOVSWHKMBHBZ74LDUTF4PKP5E5PRDC5K/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

On Fri, 21 Feb 2025 18:27:33 +0100, Sven Eckelmann <sven@narfation.org> wrote:
> diff --git a/net/batman-adv/multicast.c b/net/batman-adv/multicast.c
> index 97665c30..17463c28 100644
> --- a/net/batman-adv/multicast.c
> +++ b/net/batman-adv/multicast.c
> @@ -56,6 +56,7 @@
>  #include "log.h"
>  #include "netlink.h"
>  #include "send.h"
> +#include "mesh-interface.h"
>  #include "translation-table.h"
>  #include "tvlv.h"

This include belongs before the "netlink.h" include

-- 
Sven Eckelmann <sven@narfation.org>
