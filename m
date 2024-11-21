Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 198CCD63959
	for <batman-adv@archiver.kernel.org>; Thu, 21 Nov 2024 09:37:06 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 9D9A584260
	for <batman-adv@archiver.kernel.org>; Thu, 21 Nov 2024 10:37:04 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1732181824;
 b=aGuKZBfeedZVm+NYE2JSECWbJ1DCSFIlvptxqOJe6VXIs8P8Rk5LM74ChDECgF9u6zt7e
 T14IlCkJGWDVWd9do0lTrxQjvUXlH769kCs7F3CbxelXqXsIv8Ci8vaXXYV/A42t2UTq75n
 fSLE0sGlSVjDx5DWxZc81cD/zS3Q5LA=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1732181824; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=8MOq+ttMrtIu4hr4QOld4Xh/JVpe4o/aqTXHMNaW8E0=;
 b=PpKF+BLIN7q5JJ/LLme5niU0o7l9InhC/uYj1Am00TirI/vusQnIkxFZ2zqZVZJDw0qE9
 MFIu8bDSnudodzD8m5J1AmH4WDwMuaFv62ozaK8WqbZ+K/a5Umap9NEw3qrg7RXrHuMc+Mx
 ZvA6j6oo97b0DF8DpOXy6sdW8hQnxBw=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=fail header.d=smtpservice.net;
  arc=pass;
  dmarc=fail (Used From Domain Record) header.from=triplefau.lt
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=fail header.d=smtpservice.net;
 arc=pass;
 dmarc=fail (Used From Domain Record) header.from=triplefau.lt policy.dmarc=quarantine
Received: from e2i340.smtp2go.com (e2i340.smtp2go.com [103.2.141.84])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 3365083AFB
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 21 Nov 2024 10:36:53 +0100 (CET)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1732181813; a=rsa-sha256;
	cv=none;
	b=JjwitcW3w7bMUbChOU/EuxadzJUqeqfL8b4sT1NRQDwdd0mOvlvOMeUDClUlEpkTbc3Tzs
	YuB39tQkZiQSdZXynUeeRyW7TEdn0+70icYU50ZBa4J+NhnHnbeKuJ6xrBv4dJrUy2mAIU
	kMbiHuJ5UrexCQXbqPMgAYH0VckKd6Y=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none ("invalid DKIM record") header.d=smtpservice.net
 header.s=maxzs0.a1-4.dyn header.b="G0W/1FtA";
	dkim=pass header.d=triplefau.lt header.s=s510616 header.b=mE2H+LcX;
	dmarc=pass (policy=quarantine) header.from=triplefau.lt;
	spf=pass (diktynna.open-mesh.org: domain of
 "bT.ubrd7n4x14z6gy6=f0g27umsgxou=zmtr5pxgueb4as@em510616.triplefau.lt"
 designates 103.2.141.84 as permitted sender)
 smtp.mailfrom="bT.ubrd7n4x14z6gy6=f0g27umsgxou=zmtr5pxgueb4as@em510616.triplefau.lt"
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1732181813;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=8MOq+ttMrtIu4hr4QOld4Xh/JVpe4o/aqTXHMNaW8E0=;
	b=LKSDe3pxRgA7B7vz+LYzXhz2yc9pCFYHUTxdFep+iZ1X4drRwzAeZSPxGuU5n1+AQ4s6F+
	PJRW1tUu9nJTVLlRrQxgdOWeRt+JmyXW4vk/I/3xPc7//c8EuiNvwcyxKTIuPASC86dx34
	jlxvhzeGVKmgN9SkSRRRTjvAEyRaVv8=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpservice.net; s=maxzs0.a1-4.dyn; x=1732182713; h=Feedback-ID:
	X-Smtpcorp-Track:Message-ID:Subject:To:From:Date:Reply-To:Sender:
	List-Unsubscribe:List-Unsubscribe-Post;
	bh=8MOq+ttMrtIu4hr4QOld4Xh/JVpe4o/aqTXHMNaW8E0=; b=G0W/1FtAIl+QjvRiFP03KvhfYx
	b6CB5NMQMhFA2zHMaL2l28P9/9fel96WaYRLTdFhCST6ny+2eukD3PpJso/S4fZQAI9CN8UvUF+TF
	NcBe1/se4qdWhigutWmejc7xgoW2umnJz2Yfkz2L/9K6cgzLsB9e/Qu8MgOVFqdH65mnUJEdSKaK0
	fuhYgKeGR2X/X8cDdwtz7R+e7w2g9lXm9QDYBayI2rZvukA1+CPYumKCnLWbIQNDwts0D7nZX35DJ
	x+Uxz0eCTUpFtsdvVUSF1XqQ3YS0PLrSozOVs0NDiskgxLror22H85bTfjEIjtHw1Xq2Z0qUvKEfe
	wP7JDW/g==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1732181813; h=from : subject
 : to : message-id : date;
 bh=8MOq+ttMrtIu4hr4QOld4Xh/JVpe4o/aqTXHMNaW8E0=;
 b=mE2H+LcXqBKqExlEILvd+v+jzfXTDHVMJglliB4j02XYgM1/DfWw7obNCTV0Xy4axArQ/
 6tlJYB/4kNARV8N80vEfim98npZOg0aJ+aFZVj1p+ajnKhCDJBTtZoERMvOJ0s101c9OSCW
 mW0W7chAkXGM2fGFzx8sxEAuokn7lPllXaQgWZ+cIV6p8JSk70gMdDNGI6cwiKtVeOaQXOr
 EeWv3EghhHlLM8Vi6xkVgo8I8OgGHOEZFAOvzrtpLM80LR5tLCDu/NjDSqFwbuEzhR00olD
 r3ecReAQnz8tHfOS8R8P/EIVIobH+w0Ub8mkpdeEYIRSfPVzhZ7fGakzZl8Q==
Received: from [10.172.233.45] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <repk@triplefau.lt>)
 id 1tE3cI-TRk4Tz-AH; Thu, 21 Nov 2024 09:36:50 +0000
Received: from [10.12.239.196] (helo=localhost) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.97.1-S2G) (envelope-from <repk@triplefau.lt>)
 id 1tE3cH-AIkwcC8n5jQ-KlLm; Thu, 21 Nov 2024 09:36:50 +0000
Date: Thu, 21 Nov 2024 10:35:43 +0100
From: Remi Pommarel <repk@triplefau.lt>
To: Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org,
 Marek Lindner <mareklindner@neomailbox.ch>,
 Simon Wunderlich <sw@simonwunderlich.de>, Antonio Quartulli <a@unstable.cc>
Subject: Re: [PATCH v3 5/5] batman-adv: Don't keep redundant TT change events
Message-ID: <Zz7-7wMZZmSDJqMI@pilgrim>
References: <cover.1732124716.git.repk@triplefau.lt>
 <Zz75q77puwRSl5hN@pilgrim>
 <13642846.dW097sEU6C@ripper> <1834684.3VsfAaAtOV@ripper>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1834684.3VsfAaAtOV@ripper>
X-Smtpcorp-Track: mMQqNS_-gBwH.VHDO6MhgWIOm.PWNGighstlv
Feedback-ID: 510616m:510616apGKSTK:510616szYJJKf0WC
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>
Message-ID-Hash: YX6ZPVTJZRNRPHTHBX4PWQH6IZG2FHAW
X-Message-ID-Hash: YX6ZPVTJZRNRPHTHBX4PWQH6IZG2FHAW
X-MailFrom: 
 bT.ubrd7n4x14z6gy6=f0g27umsgxou=zmtr5pxgueb4as@em510616.triplefau.lt
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/YX6ZPVTJZRNRPHTHBX4PWQH6IZG2FHAW/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

On Thu, Nov 21, 2024 at 10:30:37AM +0100, Sven Eckelmann wrote:
> On Thursday, 21 November 2024 10:23:33 CET Sven Eckelmann wrote:
> > On Thursday, 21 November 2024 10:13:15 CET Remi Pommarel wrote:
> > > Looks right to me, I would even simplify that more for readability with:
> > [...]
> > > -del:
> > > -               list_del(&entry->list);
> > > -               kmem_cache_free(batadv_tt_change_cache, entry);
> > > -               bat_priv->tt.local_changes--;
> > >  discard:
> > >                 kmem_cache_free(batadv_tt_change_cache, tt_change_node);
> > >                 goto unlock;
> > > 
> > 
> > The "discard" is unused. But the rest looks good.
> 
> No, it doesn't. You've accidental removed "entry->change.flags = flags;". So 
> it should look more like this:

Yes sorry did that too quickly. I'll wait for Antonio point of view on
double DEL before respinning that.

Thanks,

-- 
Remi
