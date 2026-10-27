Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42F9606A31E
	for <batman@archiver.kernel.org>; Tue, 27 Oct 2026 09:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bAD7rJZ0
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 1D32D85463
	for <batman@archiver.kernel.org>; Tue, 27 Oct 2026 10:03:49 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1793091829;
 b=yWZiMdOj423AX+9bGDfbuQzIveaKZvMQRLl6HRFs6Z+7IYyXzG8+Yslfrfu2mLzJqcdBA
 idioqhFgCfVSSOSDSbvULenMuQYpB91Rx6kMVrp3/d2b0ShnDxmfaTaB+/QEr0Dnr9RC5LZ
 V1EjD1343ZeyE9KGrWJYpfrT/NQgRAk=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1793091829; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=KYcSGHUrAWvm7VQvDtNi8wcu3ZV41LzIcdxIJ2/UMio=;
 b=VFHPMl7j864J2G9OO7aiq4biTk+Q0LbMyT9zgZZoUkjv8Kq3koNRTGutrFTm5uUqMLvbH
 on4SicIoVbq+8ES0ssUJGDZYjdbEYIeVnmKeV/zS7BX2iuR656K7OzYpkx8mzaoIsIInUcs
 6UCpFlaSSfLhtygUj3e01fCyov7P6Zo=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=kernel.org;
 arc=pass;
 dmarc=pass header.from=kernel.org policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=kernel.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=kernel.org policy.dmarc=quarantine
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 0675A81350
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 27 Oct 2026 09:55:27 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1793091337;
	b=F96vEAYlPbSJ+ynfSZnJYv8en3vqt0WsmXHzLNUGG3Ue0t1gG6Y16Oe5RzU4Qp883N641J
	wIURiunylzp5rQikT8glQlwRj75fU+0TkGwRYBmZkOEnjy7x/QcDBkxBvWgm56fk8c8lKX
	zm6V87SBfsgOgzr33r+nEYRHuqO2fws=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1793091337;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=KYcSGHUrAWvm7VQvDtNi8wcu3ZV41LzIcdxIJ2/UMio=;
	b=pknXJJFlE0gdJe/SJKsPtfRpfVlPogrwa9eymfOSEjc26W7/+kaPX9gz+GNRYcuyiYXpvv
	JUrtygjYTpF+3iuOsfb4wSRxQUGvpjP05X88aOhLAXKim2ZVmk5azFLL//LVDS5sprrd0C
	vaDqe0e0tZ3EkGSQnYahLhtGGFK/pUQ=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=bAD7rJZ0;
	spf=pass (diktynna.open-mesh.org: domain of netdev-bot+sashiko@kernel.org
 designates 2600:3c0a:e001:78e:0:1991:8:25 as permitted sender)
 smtp.mailfrom=netdev-bot+sashiko@kernel.org;
	dmarc=pass (policy=quarantine) header.from=kernel.org
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id C952243ACF;
	Tue, 27 Oct 2026 08:55:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3809F1F01825;
	Tue, 27 Oct 2026 08:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793091325;
	bh=KYcSGHUrAWvm7VQvDtNi8wcu3ZV41LzIcdxIJ2/UMio=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=bAD7rJZ0QW1LdgPwjT6Dt3d28NY0PsjBfpvJaGWHTcG1XnxkCfyeZ8xjkUdENuAVV
	 ws7dlnqYAXTJQook8iYJNxPbjyv3xqIPPTbzRa+yf/cBcgGa1GQNjoDQhR7hnHxIbb
	 V1mTduBRsLkxZzq941vDDzb5XVDa3pmSwQpISkyWAGdEs1hf8rqLEvigHSOZt37hMw
	 Ui3+5suaNRk5gBNvVl11Lk4lgHsi1PISnFQEK9Oh46z8Q3wionPYafJC/4KIzF5eJH
	 WCSddpodg28jnij5fGhMkYgM6wxLwvKozBq6E3Kz2n8CNUsLM9mq9reN3dziRs5qV5
	 lJh/hGVzc2uqQ==
Subject: Re: [PATCH net 10/10] batman-adv: tt: limit local table to single
 TVLV response size
From: netdev-bot+sashiko@kernel.org
To: sw@simonwunderlich.de
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 b.a.t.m.a.n@lists.open-mesh.org, sven@narfation.org, sashiko-bot@kernel.org
Date: Tue, 27 Oct 2026 08:55:24 +0000
Message-ID: <179309132480.3134.3568656714789779480@kernel.org>
In-Reply-To: <20261026085309.1074911-11-sw@simonwunderlich.de>
References: <20261026085309.1074911-11-sw@simonwunderlich.de>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MailFrom: netdev-bot+sashiko@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-3; emergency; member-moderation
Message-ID-Hash: MBGCL4FOEW2VI6G32V5IL57LQQ6DMTGN
X-Message-ID-Hash: MBGCL4FOEW2VI6G32V5IL57LQQ6DMTGN
X-Mailman-Approved-At: Tue, 27 Oct 2026 10:02:02 +0100
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/MBGCL4FOEW2VI6G32V5IL57LQQ6DMTGN/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_NONE autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The Fixes: tag points at 85fb027f611b ("batman-adv: tt: reject
  VLAN/TT entries before reaching size limit"), but that commit did not…

--

batman-adv: tt: limit local table to single TVLV response size

This patch caps the reservation of local TT entries and VLANs at the
smaller of packet_size_max and the largest full table response that fits
in one unicast TVLV packet, since tvlv_len is only 16 bits wide. A new
helper, batadv_tt_local_transmit_size_max(), computes that limit. The
helper is used in batadv_tt_local_reserve(), in the related log messages
and in batadv_tt_local_resize_to_mtu().

Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260930094558.3723766-2-sw%40simonwunderlich.de?part=8

> Fixes: 85fb027f611b ("batman-adv: tt: reject VLAN/TT entries before reaching size limit")

[Severity: Low]

Does this Fixes: tag point at the commit that introduced the problem?

85fb027f611b removed a check from batadv_tt_local_create() that already
limited the table by packet_size_max only:

-	/* Ignore the client if we cannot send it in a full table response. */
-	table_size = batadv_tt_local_table_transmit_size(bat_priv);
-	table_size += batadv_tt_len(1);
-	packet_size_max = READ_ONCE(bat_priv->packet_size_max);
-	if (table_size > packet_size_max) {

That older check had no cap at the 16-bit tvlv_len either. So the missing
limit seems to predate 85fb027f611b.

Blame on the parent of 85fb027f611b points at defa87f5ce75fe
("batman-adv: tt: extract allocation of new local entries"). That commit
only moved this code, so the check is older still. The original commit
was not identified.

Kernels without 85fb027f611b can still let the local table grow past what
one unicast TVLV full table response can carry. This happens with
fragmentation disabled and a hard interface MTU above
sizeof(struct batadv_unicast_tvlv_packet) + U16_MAX. In that case,
batadv_tt_prepare_tvlv_local_data() hits its check_add_overflow() path and
returns 0, so no response is sent.

With the current tag, stable tooling would only pick this fix for trees
that contain 85fb027f611b. Could the tag name the commit that first added
the packet_size_max-only check? Or could the commit message say that
older trees are affected too?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261026085309.1074911-2-sw%40simonwunderlich.de
