Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4CF4C56207
	for <batman-adv@archiver.kernel.org>; Thu,  6 Aug 2026 15:07:02 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 7C7DE8427C
	for <batman-adv@archiver.kernel.org>; Thu, 06 Aug 2026 17:07:01 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1786028821;
 b=Zyj1Vc/8/Dk6uoLF0yRxIQXLgCHE9OaTpT6QJutEwyR87Iy3vV4QtXbcsDcxCb9ZaAx/0
 doASZqjdfG97xUz7GCJ9/6vaWFyoR95V+x3ppU3xx/UsC3RtMyBN2Y7LxqAMbgMLipVvh+5
 Sbt7eISbn3mYHT9ZHRG95M9Z0PR2nbQ=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1786028821; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=5C15ZLMszwpzs0ZAJwsoCCQ7uC9uR8KvQMouxajjV8Q=;
 b=nKlAfC972YtuJ1XR//trrtxBuen/IDYqLhis5uA59qTVORveCjDYDamwexy3jXq1XVMM5
 ixD8r2UExd0Zp07RdobAE19SHkyCCxOpoCxjdlE1Mwblied9lmm0cuKarTHORdWR6fIiCY2
 nHHswVIUYXZIiUet5jP/7wt34iFaQ5E=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=unstable.cc;
 arc=pass;
 dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=unstable.cc;
 arc=pass; dmarc=none
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id E7BC780759
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 06 Aug 2026 17:06:34 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1786028805;
	b=I0gYlSWeUwF17gkPqeKZXG5KKBRUj/C0Bli6X0hH+QDo1mSbYLux1HgTKc1z1EFIPHOHUH
	3SMyvf2+X74MuF6v8aGTBS9RWnMlI1Fs+PERx7hWBblM7VKs7MBExev5i+SarK8ri6k6bU
	ri5CFh4qTEq+Q3N3CfxTWWyentpvmZM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1786028805;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=5C15ZLMszwpzs0ZAJwsoCCQ7uC9uR8KvQMouxajjV8Q=;
	b=jjachzm5y0f3oNHq7XzaW2GSawuMyE7Wvq5295Nyimgc68suyrutyFnEG35ROGFoPQIzrd
	WQ0+6ST4WkovEjnn16CNV9anm1AR0cGHCWjdIY7UNJGzedlsZSgxO3mb+bnZopXtzTYV6a
	RGBzYejnpjLTXZlU+jSqewkoFDroY7U=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=unstable.cc header.s=MBO0001 header.b=vMNr1XtF;
	spf=pass (diktynna.open-mesh.org: domain of a@unstable.cc designates
 2001:67c:2050:0:465::102 as permitted sender) smtp.mailfrom=a@unstable.cc;
	dmarc=none
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4hG9bW1G26zKvg4;
	Thu, 06 Aug 2026 17:06:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unstable.cc;
 s=MBO0001;
	t=1786028791;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5C15ZLMszwpzs0ZAJwsoCCQ7uC9uR8KvQMouxajjV8Q=;
	b=vMNr1XtFXnX8j+JBve9GyOEPGsO/09S1Qvh9v92rnTlO08onpDhngyvY/jPHXnKkNaslQ/
	e1i2FlNqiOZAycFBlMaHq4wZ6wIPdcq0ceXA7LaSlk6fG2xpY3LxgwoHWx9P7U21ghbWvH
	xE+JVZYR6Zohdot2bGd2Zjd2+2F5dA1NsI+KK6jzI6k6Db8q/lfuNcrVw/XfOllI9c6mNq
	oe5nyGi1ehYEyw23eOCXjTluF5geMYYp4Kd61WDbgbSjcq/75eNTlHVdjfuZjo87gdQOJh
	wM5OOHa+zOzMnBJsNRxNvD6LcSUoMUvhnIx3PUazmXZDw92pa8Ut5pU0iOdpzw==
Message-ID: <a7daf8be-52ed-4b19-b4c0-d6fcb33461d2@unstable.cc>
Date: Thu, 6 Aug 2026 17:06:30 +0200
MIME-Version: 1.0
Subject: Re: [PATCH batadv] batman-adv: dat: fix printing of unknown 4addr
 subtype
To: Sven Eckelmann <sven@narfation.org>, b.a.t.m.a.n@lists.open-mesh.org
References: 
 <20260806-4addr-unknown-subtype-print-v1-1-e906357a5895@narfation.org>
Content-Language: en-US
From: Antonio Quartulli <a@unstable.cc>
In-Reply-To: 
 <20260806-4addr-unknown-subtype-print-v1-1-e906357a5895@narfation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Message-ID-Hash: 745HAXRHJIZVAIBKM5EAMN7DKTTOVXZC
X-Message-ID-Hash: 745HAXRHJIZVAIBKM5EAMN7DKTTOVXZC
X-MailFrom: a@unstable.cc
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/745HAXRHJIZVAIBKM5EAMN7DKTTOVXZC/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

On 06/08/2026 17:02, Sven Eckelmann wrote:
> If an unknown subtype of an unicast 4addr packets was detected in
> batadv_dbg_arp(), it is printing the (known) packet_type instead of the
> subtype. This must be switched to the subtype to have any kind of use for
> the reader of the debug message.
> 
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Signed-off-by: Sven Eckelmann <sven@narfation.org>

Acked-by: Antonio Quartulli <antonio@mandelbit.com>


-- 
Antonio Quartulli

