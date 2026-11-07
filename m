Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51B3606AC31
	for <batman@archiver.kernel.org>; Sat,  7 Nov 2026 16:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=pZJGbm9g
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 5A9F884085
	for <batman@archiver.kernel.org>; Sat, 07 Nov 2026 17:09:45 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1794067785;
 b=GM3lNN/JDT8ZZizM8/MY2ASytKE+nGGG5KgZrZ/9hJBctXaFKSuQH7vBaHDwf9C3xNVwu
 l134v29cURi0ZT9KPrpOOfwgdCn6bPFhKA0dHP3b2ln8dm5ln735Q56rIQDJfkxe3iMd5XS
 NnvmBWgPeyYkWOICCN5FaUDANZ3slx4=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1794067785; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=vIAj7l5Jlj+n89RkaOVhXvL2gmy1qdAa86kB1XQGEDM=;
 b=c2uS+v9s9P4/1Up3SrZ89n/UkgpAio/YZLmXQtUIr3irP1u9kyzNX3Yl/EJyxeNwxYucW
 JC0dG/L4ZueOHzJ5m4xNQVHF61qw2qy/X9E6DRb63tkn0DJMVMq7hRGGCixFpmwfAv9Y4gf
 wJx6VZd0INvpjE3SOp5JGwj6FjsEJQ4=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 7FCD3810EE
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat, 07 Nov 2026 17:09:11 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1794067761;
	b=Riomr74Vtz9qroB6mqBocYTsRREIQOWHWkizJF/ZscbgO6XMjjkiSOdT1W+txBQouZZMI1
	A5yvrBxDoo1wF+RSSc2FSbcymtCuXWH0D0iF0C7PnH0JY6sfT8cWp7/u3ju8UiQLdXwYLy
	Gm1Zbcs0HbjLmnYlNEAtMX3xMoMtI9o=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1794067761;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=vIAj7l5Jlj+n89RkaOVhXvL2gmy1qdAa86kB1XQGEDM=;
	b=Vf0UnGU/e36TElnAtwcFJcKRx/df8ktN6QhkgbyVuL67EzNCuNpESTzhnRxC4nV3Nql26w
	ayRFpKaxYP52rDXBAvzaG65fgbod18gvtKF+IQ4c9BDz3eG7kHGjuUMOSVVFteRBrBSX9x
	WYX9Pbfic9y0WsliNActx+//YHXpKRQ=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=pZJGbm9g;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 86DF01FD15;
	Sat, 07 Nov 2026 16:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1794067750;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vIAj7l5Jlj+n89RkaOVhXvL2gmy1qdAa86kB1XQGEDM=;
	b=pZJGbm9g2ViAr3/SHnce66nqPs5FUwIffxXtnT2VRvCNkbHG8+6xL569nBKn4Q+dvAYeGR
	CzehOkZ4qi9dosblU7NQqEAOW/8KrHkDWgUaWn1BFTeY/EZcrxho/Y638EiPmg+PH9TkEe
	aoO/WQtxnkE4CrTD/tyajrsE+7/D3k4=
From: Sven Eckelmann <sven@narfation.org>
To: =?UTF-8?B?w5ZtZXI=?= Mete Kaya <omermetekaya0@gmail.com>,
 syzbot+61b202fdc410840f0198@syzkaller.appspotmail.com
Cc: b.a.t.m.a.n@lists.open-mesh.org
Subject: Re: [PATCH batadv-next v2] batman-adv: tt: batch BH re-enable during
 TT hash
 walks
Date: Sat, 07 Nov 2026 17:09:04 +0100
Message-ID: <5115119.GXAFRqVoOG@sven-l14>
In-Reply-To: <20261107153923.797338-1-omermetekaya0@gmail.com>
References: <20261107153923.797338-1-omermetekaya0@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1973153.tdWV9SEqCh";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: KHKUZQCHB2WPYX7FPADNCAQ2B4BTZUPO
X-Message-ID-Hash: KHKUZQCHB2WPYX7FPADNCAQ2B4BTZUPO
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/KHKUZQCHB2WPYX7FPADNCAQ2B4BTZUPO/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_NONE autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--nextPart1973153.tdWV9SEqCh
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org
Date: Sat, 07 Nov 2026 17:09:04 +0100
Message-ID: <5115119.GXAFRqVoOG@sven-l14>
In-Reply-To: <20261107153923.797338-1-omermetekaya0@gmail.com>
References: <20261107153923.797338-1-omermetekaya0@gmail.com>
MIME-Version: 1.0

On Saturday, 7 November 2026 16:37:25 CET =C3=96mer Mete Kaya wrote:
> Closes: https://syzkaller.appspot.com/bug\?extid\=3D61b202fdc410840f0198

This link doesn't seem to work.

On Saturday, 7 November 2026 16:37:25 CET =C3=96mer Mete Kaya wrote:
>         unsigned short vid;
> +       u32 buckets_done =3D 0;

Breaks the reverse x-mas tree order of variable declarations.

(there are multiple occurrences of this problem)

>   batadv_tt_global_del_orig():
>     Called from workqueue context; yields every 64 buckets. The
>     local_bh_enable() is placed before clear_bit() so that pending
>     softirqs run while no per-bucket lock is held.
>=20

Are you sure? It is called from so many different places. Including this on=
e=20
(which clearly doesn't allow you to sleep due to the spinlock around the=20
call):

void batadv_purge_orig_ref(struct batadv_priv *bat_priv)
{
[...]
	/* for all origins... */
	for (i =3D 0; i < hash->size; i++) {
		head =3D &hash->table[i];
		if (hlist_empty(head))
			continue;
		list_lock =3D &hash->list_locks[i];

		spin_lock_bh(list_lock);
[....]
				batadv_tt_global_del_orig(orig_node->bat_priv,
							  orig_node, -1,
							  "originator timed out");
[...]
		spin_unlock_bh(list_lock);
	}

	batadv_gw_election(bat_priv);
}

Regards,
	Sven
--nextPart1973153.tdWV9SEqCh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCau9NIAAKCRBND3cr0xT1
y15OAQCoXcM8vpMiO7h79wrCzT2knc3oVe6xD+DnJ887EIrMkQEA9o8S8luu65dI
5CFKKSegUk2qrEuabiIpsRklArVBgAE=
=E5ka
-----END PGP SIGNATURE-----

--nextPart1973153.tdWV9SEqCh--



