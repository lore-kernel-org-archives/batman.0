Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C111D6ED3B
	for <batman-adv@archiver.kernel.org>; Thu, 21 Nov 2024 13:57:47 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 8F453842E3
	for <batman-adv@archiver.kernel.org>; Thu, 21 Nov 2024 14:57:45 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1732197465;
 b=da0yR5xsAg/I5p4m57xWZeAnC0SvmmTmutPTR9wtyQAcX29EzmQvKfZ+9pg3KcKjAfV3G
 hc9bkrkUU4vKrb4GlmI6eco5ShxdHCW+7f29gXCFz5iUDfNWm+WPWn8fX3aEgfqvATMBndh
 5oSoNdDTBAiN7Aaoxelj/XWS8H8g4wo=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1732197465; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=6j4sHc19rFxoZbUA+lzZBsP3YTp2DPtQCWagZc2xsdk=;
 b=D+tnOV2N7tXpNOzBHmORS2r1i9O09euq8l4drSgUHKh5FQt+gjrcA/56KaviuLcCkYuw4
 R+Alrch7CczrEUxwj9+8SS/Ehd+xgYMxrxyM1XbqDYZTVW7d+7RB6vm6IEc/im7BOcsbJ7x
 rIM3xcj33tcKxN7phA251T+QCKfqi0o=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=fail header.d=smtpservice.net;
  arc=pass;
  dmarc=fail (Used From Domain Record) header.from=triplefau.lt
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=fail header.d=smtpservice.net;
 arc=pass;
 dmarc=fail (Used From Domain Record) header.from=triplefau.lt policy.dmarc=quarantine
Received: from e2i340.smtp2go.com (e2i340.smtp2go.com [103.2.141.84])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 4DD8682600
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 21 Nov 2024 14:57:29 +0100 (CET)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1732197449; a=rsa-sha256;
	cv=none;
	b=ARpLT+jrIG4YZ/nuoc1l9JdoQfmMyr/iCBNamhWVWs6KZiXG/pcaABP+lzCDC1vMgRQ2TG
	Q/g6pm2hoXi5O4CST8waNUD7jleCkTyj5kInLw4vKXwre4qLHy57645W1oHq+Mhl29oHln
	Q07e9vtbl3tIGo5zhVqM37a3M2wpZD8=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none ("invalid DKIM record") header.d=smtpservice.net
 header.s=maxzs0.a1-4.dyn header.b=2XN5z13f;
	dkim=pass header.d=triplefau.lt header.s=s510616 header.b=Ycy1GKuE;
	dmarc=pass (policy=quarantine) header.from=triplefau.lt;
	spf=pass (diktynna.open-mesh.org: domain of
 "bT.x81x4ssdcy1pbj6=5vpavxx8wtad=23fdhq4n0txlbr@em510616.triplefau.lt"
 designates 103.2.141.84 as permitted sender)
 smtp.mailfrom="bT.x81x4ssdcy1pbj6=5vpavxx8wtad=23fdhq4n0txlbr@em510616.triplefau.lt"
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1732197449;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=6j4sHc19rFxoZbUA+lzZBsP3YTp2DPtQCWagZc2xsdk=;
	b=2Qm69QfSnn8IxQT+BY2N13S1s2wYPAKaDetz+gKRmG6cdCfttM26Xon92Y8l0q2VvJcHPv
	PNm+F0gmM+qz1VkR95my3qAFZkI5NyaQXhcay2Ii2viU4a8vWLL1BTxbsz1sEsmKSjbKOB
	4U6MOHXG6O0lnC7edz/0MEiah0gWX4I=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpservice.net; s=maxzs0.a1-4.dyn; x=1732198349; h=Feedback-ID:
	X-Smtpcorp-Track:Message-ID:Subject:To:From:Date:Reply-To:Sender:
	List-Unsubscribe:List-Unsubscribe-Post;
	bh=6j4sHc19rFxoZbUA+lzZBsP3YTp2DPtQCWagZc2xsdk=; b=2XN5z13fByJP636W+kvYEPnp3/
	ChbhFChDHya2QaFUfVYLA/vcRTXjXN8diJFiXMqg3uIPiL71t3AFRxSlZuVPz7QhZlbwOXZdpLRQD
	V8YazcC4QwvEPHwkR+BVGShxRfzyV/OdhEOBv8S/1lafBw10OeGjy1OVmobFnOQyLhbXLJwGRIr/L
	npESubZdtwFG8eOvpdsCA03JoJzTqMaT2ip6PIxUklJHWbwuK4Tfs3+DKZLVkLEE/Yi0dTeiIOZZS
	nsBQakuclJ4UMe3ijEE7CgLDzeiJj+YzNsjm5XEf0F2v52v2E9op5my1g1o+2HJnkDuGS3KGT/ezt
	+TiCimHQ==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1732197449; h=from : subject
 : to : message-id : date;
 bh=6j4sHc19rFxoZbUA+lzZBsP3YTp2DPtQCWagZc2xsdk=;
 b=Ycy1GKuE+Ti82TUj4ehGa+vCXX+3+is+AkaSC+kuuAA6/ItK8LPFr4iUbej5un/ZxhUzv
 ZBE+ZnG4mcsl9RjziGdKjrS+QhqaGc8hQWocXKP2+xr6UfBQD5FQqENP4TZrWJ2cV+KpGsl
 UnxIGElY6iCvTcCkX57zU71S5pRk5M1ChVyT7IAb5TMPWxYx0VpBsuaiQNdM+DNPVMg+MOB
 a8EGCFSpDiBFD19o5UnjLBJAVZ8lWfgDB1KKwDV3YF++gxHjh+HiDs2RTxzP4vbHDFRMaMT
 tBXubR575PmFdJZluNr0MeFUCdyYE2ugi3/WhuKxIXug2ln+0fcOPu6ZPmSw==
Received: from [10.139.162.187] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <repk@triplefau.lt>)
 id 1tE7gS-TRk1qF-O3; Thu, 21 Nov 2024 13:57:24 +0000
Received: from [10.12.239.196] (helo=localhost) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.97.1-S2G) (envelope-from <repk@triplefau.lt>)
 id 1tE7gS-4o5NDgrkvFO-lPg9; Thu, 21 Nov 2024 13:57:24 +0000
Date: Thu, 21 Nov 2024 14:56:17 +0100
From: Remi Pommarel <repk@triplefau.lt>
To: Antonio Quartulli <a@unstable.cc>
Cc: b.a.t.m.a.n@lists.open-mesh.org,
 Marek Lindner <mareklindner@neomailbox.ch>,
 Simon Wunderlich <sw@simonwunderlich.de>,
 Sven Eckelmann <sven@narfation.org>
Subject: Re: [PATCH v3 1/5] batman-adv: Do not send uninitialized TT changes
Message-ID: <Zz88AYyDTv5W9gQk@pilgrim>
References: <cover.1732124716.git.repk@triplefau.lt>
 <fbc17f32703930e711353d82146a916106acd2f1.1732124716.git.repk@triplefau.lt>
 <bf055638-afff-40af-85d7-dfdbf0afa842@unstable.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf055638-afff-40af-85d7-dfdbf0afa842@unstable.cc>
X-Smtpcorp-Track: jRYoxF-Uf-dJ.XQ4FW9LxFzyC.vEvtngprq5n
Feedback-ID: 510616m:510616apGKSTK:510616shuy2ZSTuu
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>
Message-ID-Hash: DIRYQXFBDDOFEIAXHXFAGOGWWGS5SQTM
X-Message-ID-Hash: DIRYQXFBDDOFEIAXHXFAGOGWWGS5SQTM
X-MailFrom: 
 bT.x81x4ssdcy1pbj6=5vpavxx8wtad=23fdhq4n0txlbr@em510616.triplefau.lt
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/DIRYQXFBDDOFEIAXHXFAGOGWWGS5SQTM/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

On Thu, Nov 21, 2024 at 02:05:58PM +0100, Antonio Quartulli wrote:
> On 20/11/2024 18:47, Remi Pommarel wrote:
> > The number of TT changes can be less than initially expected in
> > batadv_tt_tvlv_container_update() (changes can be removed by
> > batadv_tt_local_event() in ADD+DEL sequence between reading
> > tt_diff_entries_num and actually iterating the change list under lock).
> > 
> > Thus tt_diff_len could be bigger than the actual changes size that need
> > to be sent. Because batadv_send_my_tt_response sends the whole
> > packet, uninitialized data can be interpreted as TT changes on other
> > nodes leading to weird TT global entries on those nodes such as:
> > 
> >   * 00:00:00:00:00:00   -1 [....] (  0) 88:12:4e:ad:7e:ba (179) (0x45845380)
> >   * 00:00:00:00:78:79 4092 [.W..] (  0) 88:12:4e:ad:7e:3c (145) (0x8ebadb8b)
> > 
> > All of the above also applies to OGM tvlv container buffer's tvlv_len.
> > 
> > Remove the extra allocated space to avoid sending uninitialized TT
> > changes in batadv_send_my_tt_response() and batadv_v_ogm_send_softif().
> > 
> > Fixes: e1bf0c14096f ("batman-adv: tvlv - convert tt data sent within OGMs")
> > Signed-off-by: Remi Pommarel <repk@triplefau.lt>
> > ---
> >   net/batman-adv/translation-table.c | 7 +++++++
> >   1 file changed, 7 insertions(+)
> > 
> > diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
> > index 2243cec18ecc..f0590f9bc2b1 100644
> > --- a/net/batman-adv/translation-table.c
> > +++ b/net/batman-adv/translation-table.c
> > @@ -990,6 +990,7 @@ static void batadv_tt_tvlv_container_update(struct batadv_priv *bat_priv)
> >   	int tt_diff_len, tt_change_len = 0;
> >   	int tt_diff_entries_num = 0;
> >   	int tt_diff_entries_count = 0;
> > +	size_t tt_extra_len = 0;
> >   	u16 tvlv_len;
> >   	tt_diff_entries_num = atomic_read(&bat_priv->tt.local_changes);
> > @@ -1027,6 +1028,9 @@ static void batadv_tt_tvlv_container_update(struct batadv_priv *bat_priv)
> >   	}
> >   	spin_unlock_bh(&bat_priv->tt.changes_list_lock);
> 
> what speaks against acquiring tt.changes_list_lock before reading
> tt.local_changes? (and making sure the writer does the update under lock
> too) Any reason for not pursuing that path?

Nothing against, just tried to follow old behavior in case this was
that way for performance reasons. That would mean
batadv_tt_local_commit_changes_nolock() to take the lock; because it
is only called once per OGM interval I think that would be ok.

And now that I've looked into batadv_tt_tvlv_container_update() a bit
deeper I realize that it calls batadv_tt_prepare_tvlv_local_data() every
time, traversing the softif_vlan_list and building the tvlv container
over and over even if no changes occured (I mean even after the two OGM
that repeat last changes in case the first one has been lost).

Using lock for consistency maybe I can try to avoid that also ?

Thanks,

-- 
Remi
