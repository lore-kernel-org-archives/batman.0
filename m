Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BA9DC2BD09
	for <batman-adv@archiver.kernel.org>; Sat, 29 Jun 2024 01:41:06 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 36B12832B3
	for <batman-adv@archiver.kernel.org>; Sat, 29 Jun 2024 03:41:04 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1719625264;
 b=V5U8bPS8ukuIYyWVf3YeglMmGGP5khinImj3D2zb3tfdqCkJ5KzLohBCusnPfvOxWv8eT
 c10b+LvRsMN1AwvmBje/WbIZxgHHDx7HtxGTLShhlVoRz4Eraf9NT+b+8BRBUL4kTX2SVd2
 rqIlj24zMoOUju6pZSdY8ed/4bjytgE=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1719625264; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=HR5P8ntstYU0dq/+SCYn365aGsmMxSVwvc7BMXvaRwk=;
 b=cW44N9WK2mYOnyb5cUfLyTHgU4YJ3nzLho75ENjf+Fs3IIePlek/xqh11VysxjuFa+A+7
 TnsR9oA2bZSW3vYOpWXRqbHqoRKI/w/mhIolYRlm1lnYb47R0+pkHydF+7IiqsPZauehNgJ
 svGqJOg78dpUlR7AfeSrxkVd3wwJW18=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=fail;
  arc=pass;
  dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass; dmarc=none
Received: from mail.aperture-lab.de (mail.aperture-lab.de
 [IPv6:2a01:4f8:c2c:665b::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 58B8E82354
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat, 29 Jun 2024 03:40:32 +0200 (CEST)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1719625232; a=rsa-sha256;
	cv=none;
	b=xNEmu0qdFreqZxzbdsPAaSFCqdQDp4W84tXFW+vkz12aP/aTI2ZTJiMJhHjw7SX0fZxYI8
	5XiYkfakJ9C4IGxeMe4FoLn7v9XTrsQ73T5OgSsdSpJkyUhyux3KHCOfF+ZSE7l9B6M/IS
	X5nXmu1j16tkr+4EW39x6b8N+j01zjY=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	dmarc=none;
	spf=pass (diktynna.open-mesh.org: domain of linus.luessing@c0d3.blue
 designates 2a01:4f8:c2c:665b::1 as permitted sender)
 smtp.mailfrom=linus.luessing@c0d3.blue
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1719625232;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HR5P8ntstYU0dq/+SCYn365aGsmMxSVwvc7BMXvaRwk=;
	b=SAKOBeA6Fsu2xB7dqtZmaPh6LHeInBDVOgeS63LyA+pwuOc73w+eLddsE3zGm98dT6/sGB
	B3Ye6ji4qKopBEnpHafgl2ieZZyWp+dFT9OeJbqC9nuO2aF4fNqm2TTfgDpwfPCubHfddk
	9KqVK5wdJhWLS07qK+G8db3I/2tcgz4=
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 945DC3EFFE;
	Sat, 29 Jun 2024 03:39:30 +0200 (CEST)
Date: Sat, 29 Jun 2024 03:40:29 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
To: BEAL Romain <Romain.BEAL@knds.fr>
Cc: "b.a.t.m.a.n@lists.open-mesh.org" <b.a.t.m.a.n@lists.open-mesh.org>
Subject: Re: configuration for mobile nodes
Message-ID: <Zn9mDQQNPvq7zeBu@sellars>
References: <0ae0e36496504245bb8ad0fab5c054a4@knds.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0ae0e36496504245bb8ad0fab5c054a4@knds.fr>
X-Last-TLS-Session-Version: TLSv1.3
Message-ID-Hash: 4XSKYCTLSPQAPNBZLHW5AL37ZNZUJOQ7
X-Message-ID-Hash: 4XSKYCTLSPQAPNBZLHW5AL37ZNZUJOQ7
X-MailFrom: linus.luessing@c0d3.blue
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/4XSKYCTLSPQAPNBZLHW5AL37ZNZUJOQ7/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

I'd be careful with just reducing timeouts... A 2 seconds purge
timeout together with a default 1 second OGM interval seems to me
like asking for a lot of route flapping in the best case. And
potential, temporary routing loops in the worst case.

What we typically do is decrease the batman-adv originator
interval instead, which you can do with "batctl orig_interval".

Some people seem to get confused about stale entries from
vanished nodes. They shouldn't have much impact on performance. If
that dead node was a selected router to another node but has not been
heard of for 5 sequence numbers (5x originator interval,
BATADV_TQ_GLOBAL_WINDOW_SIZE) then this other node will use an
alternative neighbor node as a router with the next OGM with a 
seqno > 5 from this alternative.

Regards, Linus


On Thu, Jun 27, 2024 at 07:43:59PM +0000, BEAL Romain wrote:
> Hi,
> 
> I want to use batman-adv for highly mobile nodes.
> All of my nodes are robot or radio module embedded on a human, for example.
> 
> Losing a node is very common and batman-adv needs to self-reconfigure quickly in my case.
> Adding a node is very common too, maybe for only few seconds or minutes.
> 
> The default configuration doesn't work very well for my use case.
> But when I use this configuration :
> 
> #define BATADV_PURGE_TIMEOUT 2000
> #define BATADV_TT_LOCAL_TIMEOUT 6000
> #define BATADV_TT_CLIENT_ROAM_TIMEOUT 6000
> #define BATADV_TT_CLIENT_TEMP_TIMEOUT 6000
> #define BATADV_ORIG_WORK_PERIOD 500
> #define BATADV_DAT_ENTRY_TIMEOUT (5*600)
> 
> The result is better. I have some unstable connection for only 5 seconds when I loss a node.
> Have you done any testing for this type of use ?
> 
> Thanks for help
> 
> 
> Ce message électronique et tous les fichiers qui lui sont attachés sont confidentiels et destinés exclusivement à l'usage de la personne à laquelle ils sont adressés. Si vous avez reçu ce message par erreur, merci d'en avertir immédiatement son émetteur et de supprimer ce message de votre système sans en conserver de copie. La copie, la rediffusion à tout tiers et l'utilisation du contenu de ce message ou des fichiers attachés est strictement interdite sans l'accord préalable écrit de l'émetteur.
> 
> Ce document est susceptible de contenir de l'information soumise à contrôle (ML22) relevant de la réglementation européenne quant aux exportations des matériels de guerre et matériels assimilés. Toute exportation ou réexportation est soumise à autorisation écrite du gouvernement français.
> --------------------------------------------------------------------------------
> This email and any attachments are confidential and intended solely for the use of the individual to whom they are addressed. If you have received this e-mail in error, please inform the sender immediately without keeping any copy thereof and delete it from your system. Copy, use or distribution of contents of this message or attachments to any other person is strictly prohibited without sender's prior written permission.
> 
> This document may contains controlled data submitted to EU military lists regulations. Any export or reexport is submitted to written authorization of French Government.
> 
> 
