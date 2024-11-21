Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A888E6400D
	for <batman-adv@archiver.kernel.org>; Thu, 21 Nov 2024 20:26:04 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id A32A883FCD
	for <batman-adv@archiver.kernel.org>; Thu, 21 Nov 2024 21:26:02 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1732220762;
 b=dXVi2nEvEf/6lIkhOrpQ0ziuu+Az/wKarfYSGM2QlNea/h1rngMqJy6Tm62bYxugWzW7x
 /tB+T2mG2FLXyJBU1CbpQwXO2fJ7f6RM2oKOPXUMt+Oggb5IfMalm9uVbxYzuSxhNVkyL/w
 17clxjxyVCEaUh8qnb0Mb6bWvqd1ix4=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1732220762; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=zuWKOLZKOcBcdKI7XKCTVkA3H+FFtXxUxhS9jk/tYVs=;
 b=pCbOwLn21rf14zIi6lVPACdds7nig/XEVtfLsiu/Z0OfR8I1tAoodifdG1r9txoJm/LMn
 vBxUwxGtEJrjOcFh92eBTlk3MJeI4dVdTxO1xfjkEN9sNC69Z3MK+DtndfI51pkxDapZ6hN
 LnTqQw6cJ8bxoi02FT0E8tvww+bxe58=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=fail header.d=smtpservice.net;
  arc=pass;
  dmarc=fail (Used From Domain Record) header.from=triplefau.lt
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=fail header.d=smtpservice.net;
 arc=pass;
 dmarc=fail (Used From Domain Record) header.from=triplefau.lt policy.dmarc=quarantine
Received: from e2i340.smtp2go.com (e2i340.smtp2go.com [103.2.141.84])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id F2801802EA
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 21 Nov 2024 21:25:49 +0100 (CET)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1732220750; a=rsa-sha256;
	cv=none;
	b=Qcl1aNUzpxOQdFhIs4XEQaeJLpK+J3W9c/wyfR1RAgUoApxXufZ6H61Ba83asVTYdegAIi
	35KqNUg5b1IOh+xmHYClbI6hn/GSnKGkoEzaZQt2VftVDrL/nkydHW5XJsSb8Gfnyj4CQ6
	OkRfq5XE8bsXo7kdNCs+etLSg6RxLmQ=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none ("invalid DKIM record") header.d=smtpservice.net
 header.s=maxzs0.a1-4.dyn header.b=yTLFMUrl;
	dkim=pass header.d=triplefau.lt header.s=s510616 header.b=lsY2pJQE;
	dmarc=pass (policy=quarantine) header.from=triplefau.lt;
	spf=pass (diktynna.open-mesh.org: domain of
 "bT.hnwjm9k4nqhx305=58fmo9cknnr0=xepjdm3m86v375@em510616.triplefau.lt"
 designates 103.2.141.84 as permitted sender)
 smtp.mailfrom="bT.hnwjm9k4nqhx305=58fmo9cknnr0=xepjdm3m86v375@em510616.triplefau.lt"
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1732220750;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=zuWKOLZKOcBcdKI7XKCTVkA3H+FFtXxUxhS9jk/tYVs=;
	b=KqLf37LkivtauKe+g6EKqeUYysu9K0mha8hEp1MdwIbaAVUXkdnHnv23AgS0DP0Dp5hbVG
	EEcoxLwyIquTQIWKtMeAuLex+fZqPkt2hab1gE3mL7KoTQKRIrP06LpbakbQKLX/1FUiOg
	e4qi8ZX9KhDu6d5/YNf6weQMrAe95Rw=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpservice.net; s=maxzs0.a1-4.dyn; x=1732221649; h=Feedback-ID:
	X-Smtpcorp-Track:Message-ID:Subject:To:From:Date:Reply-To:Sender:
	List-Unsubscribe:List-Unsubscribe-Post;
	bh=zuWKOLZKOcBcdKI7XKCTVkA3H+FFtXxUxhS9jk/tYVs=; b=yTLFMUrlxfeTTmkCSuJKw1axhM
	zA2bUj1pOJRy+hi3FJjm4H7CHdzRS/i/mKdCcZBTDKsaLWVUOV51F3cLAWfNTtejYPIo902/0RgL1
	eiBTTvzc/VVTpMke0FswBaAgIkAEf0A7rPGBuYS+WUk1odCqQYhB4WbSO0UF75PQFgTGCB20MHbDk
	POTaKUSzcNp4ewJQvAzuOMHvsUMxm7R/XoXM7FuBP6Qm2ksONvemunxm/T1gJ11ED8EuxmB0m5Tex
	QUVP+c15h0aGDzUgp/eUj2orLKT2FVSX33pIKzwNjskR5OD0VDAjHaeB/AdIHDwnd+pJ3QKONav/X
	xWAxKUXg==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1732220749; h=from : subject
 : to : message-id : date;
 bh=zuWKOLZKOcBcdKI7XKCTVkA3H+FFtXxUxhS9jk/tYVs=;
 b=lsY2pJQEa22Utc/rxY/ji2I2j2ppUXE92j3LXi9r6y9F4vZPWdSSNdPF9Ga+GvmS/PjKK
 XN2AC66NHbqoitBojTB5Vx/4B9DzRGzwmG3DPwtDAfcrUyI97hxjQsqCV+9AIW7hQBQZKCj
 E38DJJ69LpjKN2SjI/VsORd0YCS3vlzdErs8BXX2+lKEnFkqzbPJt/5yD15UVa7BfydhOuB
 RtQshbMzw3fhdT0g9gK2EQSkBHK4+h+2h6/Lgh7D1RmAD9VB2t/N1BRas0N6HR2T0OUoVLG
 VUNj+yDNV0uzqPaZ1pC8+6xae/ECEDiw3fAUDwqMAuaqGkQvKgA30cXiVy9A==
Received: from [10.172.233.45] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <repk@triplefau.lt>)
 id 1tEDkD-TRjyLZ-63; Thu, 21 Nov 2024 20:25:41 +0000
Received: from [10.12.239.196] (helo=localhost) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.97.1-S2G) (envelope-from <repk@triplefau.lt>)
 id 1tEDkC-AIkwcC8iKHv-KRD8; Thu, 21 Nov 2024 20:25:40 +0000
Date: Thu, 21 Nov 2024 21:24:31 +0100
From: Remi Pommarel <repk@triplefau.lt>
To: Sven Eckelmann <sven@narfation.org>
Cc: Antonio Quartulli <a@unstable.cc>, b.a.t.m.a.n@lists.open-mesh.org,
 Marek Lindner <mareklindner@neomailbox.ch>,
 Simon Wunderlich <sw@simonwunderlich.de>
Subject: Re: [PATCH v3 1/5] batman-adv: Do not send uninitialized TT changes
Message-ID: <Zz-W_3A9diBFXz79@pilgrim>
References: <cover.1732124716.git.repk@triplefau.lt>
 <Zz88AYyDTv5W9gQk@pilgrim>
 <Zz9MrP6LBw0eY_Uv@pilgrim> <4345009.mogB4TqSGs@ripper>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4345009.mogB4TqSGs@ripper>
X-Smtpcorp-Track: YnL3dLmB59kX.toJoGUhBriKR.dB90FgWTFux
Feedback-ID: 510616m:510616apGKSTK:510616shuy2ZSTuu
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>
Message-ID-Hash: WTFV37ZEJROR5Y3INGO6XW6GV4CHC7CE
X-Message-ID-Hash: WTFV37ZEJROR5Y3INGO6XW6GV4CHC7CE
X-MailFrom: 
 bT.hnwjm9k4nqhx305=58fmo9cknnr0=xepjdm3m86v375@em510616.triplefau.lt
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/WTFV37ZEJROR5Y3INGO6XW6GV4CHC7CE/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

On Thu, Nov 21, 2024 at 07:02:43PM +0100, Sven Eckelmann wrote:
> On Thursday, 21 November 2024 16:07:24 CET Remi Pommarel wrote:
> > So the patch would be quite similar, only tt->tt.changes_list_lock will
> > be taken sooner in batadv_tt_tvlv_container_update().
> > 
> > That will fix the ADD between two read situation as you described
> > though.
> > 
> > Do you still prefer this option ?
> 
> I can't speak for Antonio but I think I would prefer for the fix the current 
> version. The locking one would end up again with nested spinlocks and maybe 
> more refactoring. And it might be nicer for the stable backports to have less 
> noise in the patch.

I tend to second that, because if I understand correctly, even if
tt.changes_list_lock is held sooner in batadv_tt_tvlv_container_update()
the scenario Antonio described could still happen. Indeed if the ADD (or
even DEL for that matter) happens between VLAN table CRC computation
(batadv_tt_local_update_crc()) and the lock, neighbor will have CRC
mismatch and send TT_REQUEST anyway. The race window would be smaller
but still here.

So if I am not mistaken, the only solution to eliminate the race
completely would be to compute CRC while holding the lock, and this I
don't really like.

> 
> Btw. just noticed that the code (not in your change - but overall) for the 
> filling of diff entries could have been something like:
> 
> --- a/net/batman-adv/translation-table.c
> +++ b/net/batman-adv/translation-table.c
> @@ -980,6 +980,7 @@ static void batadv_tt_tvlv_container_update(struct 
> batadv_priv *bat_priv)
>  	int tt_diff_entries_count = 0;
>  	bool drop_changes = false;
>  	size_t tt_extra_len = 0;
> +	LIST_HEAD(tt_diffs);
>  	u16 tvlv_len;
>  
>  	tt_diff_entries_num = READ_ONCE(bat_priv->tt.local_changes);
> @@ -1011,9 +1012,10 @@ static void batadv_tt_tvlv_container_update(struct 
> batadv_priv *bat_priv)
>  
>  	spin_lock_bh(&bat_priv->tt.changes_list_lock);
>  	bat_priv->tt.local_changes = 0;
> +	list_splice_init(&bat_priv->tt.changes_list, &tt_diffs);
> +	spin_unlock_bh(&bat_priv->tt.changes_list_lock);
>  
> -	list_for_each_entry_safe(entry, safe, &bat_priv->tt.changes_list,
> -				 list) {
> +	list_for_each_entry_safe(entry, safe, &tt_diffs, list) {
>  		if (tt_diff_entries_count < tt_diff_entries_num) {
>  			memcpy(tt_change + tt_diff_entries_count,
>  			       &entry->change,
> @@ -1023,7 +1025,6 @@ static void batadv_tt_tvlv_container_update(struct 
> batadv_priv *bat_priv)
>  		list_del(&entry->list);
>  		kmem_cache_free(batadv_tt_change_cache, entry);
>  	}
> -	spin_unlock_bh(&bat_priv->tt.changes_list_lock);
>  
>  	tt_extra_len = batadv_tt_len(tt_diff_entries_num -
>  				     tt_diff_entries_count);
> 
> 
> And then you can also move this before "tt_diff_entries_num = ..." and 
> save the corresponding bat_priv->tt.local_changes for the spliced list to the 
> inside the lock also in a local variable. And then operate on this variable 
> for the other decisions. Of course, you must still clean the local list in 
> case of an error. Which of course would slightly change the behavior in case 
> of an allocation error in batadv_tt_prepare_tvlv_local_data (which would 
> previously kept the list as it was).
> 
> But if it would be done like this then we could also remove the READ_ONCE and 
> not introduce the WRITE_ONCE - just because local_changes is only touched
> inside a locked area (see changes_list_lock).
> 
> Please double check these statements - this was just a simple brain dump.

Yes that would be a much more elegant way to handle it. Unfortunately,
if I don't miss anything, the WRITE_ONCE/READ_ONCE would still be
needed because batadv_tt_local_commit_changes_nolock() has to load
tt.local_changes out of the lock to check if it needs to purge client
and recompute CRCs.

Thanks,

-- 
Remi
