Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BA11C43458
	for <batman-adv@archiver.kernel.org>; Sun, 28 Jun 2026 19:50:40 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id B57E281499
	for <batman-adv@archiver.kernel.org>; Sun, 28 Jun 2026 21:50:38 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1782676238;
 b=Q0MXlaP712U0T0768GjnxxLnH5PgPy3XW1cOT0qVmD7lDVNov/98mGubgJSfu3cZ8h5hI
 IqKHbp6mkQKVuPKC2k2Dy65Cw20HKsPIQhvCGrmVSkThH+O5ecvUvENA47L3uI1X7MfAZt7
 78ScvmRRnh9n9vvmmvCD/eS3Z+Tlf84=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1782676238; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=WhAaJlXT0e4z+Vb2fI7sdvRfERjmZoFYu4jmPVCdCAU=;
 b=HnBYi8+WmpcwXMZnX40jfI4RFKGfCHYlCkrlbV5kId/9lBlz8K0weEzcic3txu9dTFwdH
 phD4NPeScgIMnnZij7qdwuyVTb3jDpVBnH7rIOGlaYxCKueSGvFEpwquVbyRy81pm7HP3ru
 Vkw8rQHe0AxxoAs8wo8v7pt4+j1K3cs=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id DE2D180517
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 28 Jun 2026 21:50:08 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1782676219;
	b=UfFZni5r0qEOdNN/mpBz5LfZGF3i3tmFOWc9CW0nC9XRyYNED+ykVepsh+op7TELKF3TVQ
	5jyViFTdnH75CiOxJbI0UJ0FG5SuRUKBdDweC/47yZnvBkaHA8YEWnSlNJCf3Qov+Wz9KT
	746ZKGhxL5TJhgEZJZsl9manE8wzmKQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1782676219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=WhAaJlXT0e4z+Vb2fI7sdvRfERjmZoFYu4jmPVCdCAU=;
	b=2UhykKl0WiB7kVWQYW/nLnosza3Otm7Q5/5DwyIAda9e9fHROehgfFgRidk0+crQoP+e+v
	vJRWQBsLH547w6mzVDZZZZ6/lVPmq9FXkw6serrIrTLaQ+dmRVgCiSGPwN8EVcbWCUton4
	U5G0CZkWdiG9IWaolFc5jd1+sNwhQ4E=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=FxMX8hrE;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id B0C78207F5;
	Sun, 28 Jun 2026 19:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1782676207;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WhAaJlXT0e4z+Vb2fI7sdvRfERjmZoFYu4jmPVCdCAU=;
	b=FxMX8hrEs4mSoryrnPMjEGVQNHa8DycWZzISdT6NRLuB8NeS2CnighjA9PqpEXUJJr4aTo
	kpd/XvdGkPUyn8WaO4jAybmHpzBdu8tbTbIJ42grEZTNc6rCyDDlQ68vwdj5G3N5iCMrxP
	wwKw8vTnugSolO3D1nYcQs2z9q+CWAA=
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org,
 Nora Schiffer <neocturne@universe-factory.net>
In-Reply-To: <cover.1782658366.git.neocturne@universe-factory.net>
References: <cover.1782658366.git.neocturne@universe-factory.net>
Subject: Re: [PATCH batadv v5 0/6] batman-adv: drop global hard interface
 list
Message-Id: <178267611077.406239.4674024353226372101.b4-ty@b4>
Date: Sun, 28 Jun 2026 21:48:30 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1370; i=sven@narfation.org;
 h=from:subject:message-id; bh=clf2DqttHmKPxc3L7mCFlzwLeLMwzJGc/HEP8j49CCU=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFmOVadyZbf852+S2hSp+4/79TLmw5pLjqyY/u70oXLHS
 ypbt4Tf7ShlYRDjYpAVU2TZcyX//Gb2t/Kfp308CjOHlQlkCAMXpwBMJCSQkWFVuMnOwkcrDBbs
 ysiM1rb3XuDNtWb+xpBl6RYO84/XJB1iZJi85G3XleLLfk3WKR/t5GXUTN5POdYg+nHilexYtcW
 9PbwA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: HCAOJYRDMB37M3FXRYPJ4S2IDBM65SJ2
X-Message-ID-Hash: HCAOJYRDMB37M3FXRYPJ4S2IDBM65SJ2
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/HCAOJYRDMB37M3FXRYPJ4S2IDBM65SJ2/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>


On Sun, 28 Jun 2026 17:07:27 +0200, Nora Schiffer wrote:
> batman-adv: drop global hard interface list
> 
> Cover letter from Sven's v4:
> 
> The global hard interface list was used in the past to provide and sysfs
> (debugfs, procfs) based configuration interface. This requirement is gone
> after it was switched to generic netlink and NETLINK_ROUTE. And after the
> wifi-flags cache was introduced, it is also no longer used to get
> non-batman-adv attached interface information (for ap_isolation and
> re-broadcast configuration).
> 
> [...]

Applied, thanks!

[1/6] batman-adv: create hardif only for netdevs that are part of a mesh
      https://git.open-mesh.org/batadv/c/fcba102e0e4a
[2/6] batman-adv: remove global hardif list
      https://git.open-mesh.org/batadv/c/49e9de6e124f
[3/6] batman-adv: make hard_iface->mesh_iface immutable
      https://git.open-mesh.org/batadv/c/f846e779532e
[4/6] batman-adv: remove BATADV_IF_NOT_IN_USE hardif state
      https://git.open-mesh.org/batadv/c/48ea7b6b7b94
[5/6] batman-adv: move hardif generation counter into batadv_priv
      https://git.open-mesh.org/batadv/c/cbda6a6cf2a5
[6/6] batman-adv: drop unneeded goto and initialization from batadv_hardif_disable_interface()
      https://git.open-mesh.org/batadv/c/2b429dbc50b4

Best regards,
-- 
Sven Eckelmann <sven@narfation.org>

