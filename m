Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4831CA5FED
	for <batman@archiver.kernel.org>; Tue,  6 Oct 2026 11:04:38 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id E6EEA842E5
	for <batman@archiver.kernel.org>; Tue, 06 Oct 2026 13:04:36 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1791284676;
 b=rgqXd6WJQefvAeaXDtqJBGtxmgGWZyw+bMeNj4eddpjZPq2WTHkDML/7J9V8beS2XIRxe
 HSQFmIzt/TwvQSy0VvatvPpgW0Bo1Pfn2PppU74LkkpqusJNFFw61IK51Pn6vp4OWKY+A0c
 cyzeKRBCUIWMWdH7/krRVEIejn0mqBY=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1791284676; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=irvTIbRziepJLkSkqL0aVR7rV8FhvDzfqREWnWZPkqU=;
 b=0sNamxbLiCtON9toOI/Tn99YhaS1hLeuwsxl+MWSMtghs4j164VMalbQLOeh42Eu1iHve
 6fnBSNZY9nhGE5XknQ3wGev2mrSyWTxFwOZlhnCHPraQBgEd8g/HI+w6K737hegyl0Dn+oJ
 Io/HIu4hMYzU4Ygf0nq0niCjkYdBSZk=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=fail;
 arc=pass;
 dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass; dmarc=none
Received: from mail.aperture-lab.de (mail.aperture-lab.de
 [IPv6:2a01:4f8:c2c:665b::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 117DB81474
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 06 Oct 2026 13:04:15 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1791284666;
	b=d/bSfJqWmE2YArmfuBkeG3Amymy2dBd47HnDWAFGuIZLsl0vpXhRaACmceHcHP8Q8cEmIg
	CA0uSggM4Eh2anrzSM3WF+imm9UzjTYp/l8HkecpVDaNYyIF5VlLdD510WYbJrJbz1/ZHF
	PF5u51TacCu5lls63+rv8V3RwmVzz2w=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1791284666;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=irvTIbRziepJLkSkqL0aVR7rV8FhvDzfqREWnWZPkqU=;
	b=U3XShVjHW36Cjd2U8JKrw9lZXUchzm8asFwQHFrofkvmRHY8DYtCO/a9LFYspv8M15FG7f
	vbd0LlMM2j7SVKhEXrO72FEgsZ+zjjwWdx5pkKWRTqoYgSvEsYGe9SZ9iqOgIFFUPPO/MH
	Qn1DDUOFYO6gClB2wnZ2NV8JoaJwZdI=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	dmarc=none;
	spf=pass (diktynna.open-mesh.org: domain of linus.luessing@c0d3.blue
 designates 2a01:4f8:c2c:665b::1 as permitted sender)
 smtp.mailfrom=linus.luessing@c0d3.blue
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 8F01323245;
	Tue, 06 Oct 2026 13:04:09 +0200 (CEST)
Date: Tue, 6 Oct 2026 13:04:08 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
To: Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org, Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH batadv] batman-adv: dat: initialize orig_node of unfilled
 candidate slots
Message-ID: <asTVqLO0EWAVM_IE@sellars>
References: 
 <20261004-dat-eligable-uninitialized-v1-1-9674029343da@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: 
 <20261004-dat-eligable-uninitialized-v1-1-9674029343da@narfation.org>
X-Last-TLS-Session-Version: TLSv1.3
Message-ID-Hash: S6U2H4F5H5FMTF7L2UVM4ORJBHTPFNZR
X-Message-ID-Hash: S6U2H4F5H5FMTF7L2UVM4ORJBHTPFNZR
X-MailFrom: linus.luessing@c0d3.blue
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/S6U2H4F5H5FMTF7L2UVM4ORJBHTPFNZR/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

On Sun, Oct 04, 2026 at 10:10:06AM +0200, Sven Eckelmann wrote:
> batadv_dat_select_candidates() allocates the candidate array without
> zeroing it. batadv_choose_next_candidate() marks each slot as
> BATADV_DAT_CANDIDATE_NOT_FOUND but only sets orig_node when an eligible
> originator was found. In the following rounds,
> batadv_is_orig_node_eligible() compares res[j].orig_node of all previous
> slots against the evaluated originator. For slots without candidates, it
> reads uninitialized memory.
> 
> The orig_node has to be cleared together with the
> BATADV_DAT_CANDIDATE_NOT_FOUND type.

Acked-by: Linus Lüssing <linus.luessing@c0d3.blue>

(Though this issue seems very hard/unlikely to trigger? And even
then the consequences would be minor and temporary?)

(Also, I can't read the Sashiko link, I guess it's only accessible for
maintainers?)
