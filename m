Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DF37C25B74
	for <batman@archiver.kernel.org>; Tue, 21 May 2024 07:01:25 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id A2520825C9
	for <batman@archiver.kernel.org>; Tue, 21 May 2024 09:01:23 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1716274883;
 b=WLq8fCz8bQjOSRVtS6EeHbVn/e9F2WqPJwEaKNmcbg9TiqKkNifXvx6arbtQH3Zg8bKzd
 vZ35CTfL/VxgdHd2KXtCT/S3CHYVnzfmKPg3MzCphONp7MwZkZfFxVDel9ka+3knAJy4eoP
 a1BYMg3QbSfrGDOXByNtyu9Soe1jHSE=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1716274883; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=UkWR+t4coTvUfqKps9eZBaaz7b4Ay7sWZdC6HnQxB+Y=;
 b=RWyTqXuExbZrAxizJxe6z7sWtxgyqZLxX4t9bqUedG7qtxISVnMviNd3NHc/Xo1REfTJ4
 UvkAf4XL5vWucp0ho/OMNfGKdJlEmUMkzAV8Ka2SwW+6uLExux3BhjH3tD3ZMzFYRgZc6Wu
 94EDdGaOjNOg4RM5SFlGcO4qG9mwawc=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=gmail.com;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=gmail.com; arc=pass;
 dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com
 [IPv6:2a00:1450:4864:20::230])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id E7CBA81A52
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 21 May 2024 09:01:10 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1716274871;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=UkWR+t4coTvUfqKps9eZBaaz7b4Ay7sWZdC6HnQxB+Y=;
	b=nXrPBOb9/alToUk9Gsv2ax1yviveBoM4pQ0VTm5ULYjM6Czgzzax4SDxS0Z8oD+sSu9vZg
	LudFCZiKntrVjKE+CvdfWuUPeCZMCrgI/Agl6JZJxDoveqPZz83FEefH/cAt1db2KnYmRb
	+B1ymUCEwxpB5bcNXblGBesCB+z59i8=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=gmail.com header.s=20230601 header.b=SaoYYRTV;
	spf=pass (diktynna.open-mesh.org: domain of nico.escande@gmail.com designates
 2a00:1450:4864:20::230 as permitted sender)
 smtp.mailfrom=nico.escande@gmail.com;
	dmarc=pass (policy=none) header.from=gmail.com
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1716274871; a=rsa-sha256;
	cv=none;
	b=vC+w74V8anRGvuOYvCcAzByu3uIITu+N765Hbsuno0pweFEH2ypM4nExhjivCS4JYzNP/o
	oPDQTyFJGh1d67vbkOr+kTBZKCIFp9TwmtpoIHS5UvqxhxCzhJmdkPr3FZLVaScvKgnNub
	kozOALo7nUJr59NV0lcL+FnTjgkBvMs=
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2e724bc46c4so20899681fa.2
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Tue, 21 May 2024 00:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716274870; x=1716879670;
 darn=lists.open-mesh.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UkWR+t4coTvUfqKps9eZBaaz7b4Ay7sWZdC6HnQxB+Y=;
        b=SaoYYRTVC802ScDvcLsDFh3lC9lsJMppcziUw/0EmDcF4EHvs7USLMz4vTZO7rFx/7
         aazywLQRBuiSPNYzMXhKmwVn/2ZHCxyNL5fP+VUmLcz9y//VOz8ozhdBjwA24vCxsGNW
         Gh9paPvS5vSXIi8w38qllGOuX/pjNNDbw+5ttKnsAEl5xxiyowHiWueb4iNYXjGjnhk+
         W3muDOtD0cYDBam0SGKQ42VqI2ipcFchZba6wc9oEP6K/6wQEmVXZAYyfuNpSW/reTTv
         w8BhFVHyLpu02CrVFf0CB+aPDb/vBQwhFC6Ms9eKqyxytDKovVnk7bmuQzym4TikZZLg
         l0/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716274870; x=1716879670;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UkWR+t4coTvUfqKps9eZBaaz7b4Ay7sWZdC6HnQxB+Y=;
        b=XVRGE+xApkoR4Ir4QphWJEdURW4NBQwn0BaseQk2fn751GHr6I6EGa6xLijzMGETmv
         SL3XaU79pBcEnwjis1AvpcgJ1NsXBMzQUnS7KvBWWkacvpzt//kCdMbIg4xA1FCMDn4q
         EPElbxGzfjygaf734y9cKt/HqCQnsKIggaaYuHp+TzvXO1bGdUmhPIvZ5wGDkeGnrl7C
         lHW1uM0L0LUEsuM/XxxlRDSY23LQJx7V6sXaizqI7wox4iR7EOl7nEGjJOJ/sOBN2llP
         2KR6y7XfJLhknFDYKxDdYGDRUqGDe6dGLrVYXf5+T7exfo7qEGFAaVw3JREXxImQ6zac
         2aXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQ1qioaLcVYeeEsvGUEbaMm9BDm78Kfxp3u3no1oMN2+n4VBHYCES+7yGRbhSos/6znxFe3tjG1HjjxSt+1FQppl3TNgSLYWAnqUTiwmxx
X-Gm-Message-State: AOJu0YyYaApO2eyU86F6JbyXFD4Q2V7h1mpp82BjmWqQXo6LL8gs1xfa
	J0Kw1nmv/DN16C6tFRn+4L4dUqYeSZ9MdiIrwlVan4zcLtQPcLLX
X-Google-Smtp-Source: 
 AGHT+IGMUIWoeq0jhoFs/GRtfBhQ/rk6jS/l8R79/kT9O7NdrOKMHEpwVp27euETugMllwP1USmcSA==
X-Received: by 2002:a2e:730b:0:b0:2dd:409:3b25 with SMTP id
 38308e7fff4ca-2e51fd42038mr215262941fa.4.1716274869853;
        Tue, 21 May 2024 00:01:09 -0700 (PDT)
Received: from localhost (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42012a025dbsm351827435e9.23.2024.05.21.00.01.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 May 2024 00:01:09 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 21 May 2024 09:01:08 +0200
Message-Id: <D1F4NY5F73YD.1T55A9QAAA1N@gmail.com>
Subject: Re: [PATCH] wifi: cfg80211: Lock wiphy in cfg80211_get_station
From: "Nicolas Escande" <nico.escande@gmail.com>
To: "Remi Pommarel" <repk@triplefau.lt>, "Johannes Berg"
 <johannes@sipsolutions.net>
Cc: "Antonio Quartulli" <antonio@open-mesh.com>,
 <linux-wireless@vger.kernel.org>, <b.a.t.m.a.n@lists.open-mesh.org>,
 <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.17.0
References: 
 <983b24a6a176e0800c01aedcd74480d9b551cb13.1716046653.git.repk@triplefau.lt>
In-Reply-To: 
 <983b24a6a176e0800c01aedcd74480d9b551cb13.1716046653.git.repk@triplefau.lt>
Message-ID-Hash: LGHA2QHE6CA6PXFLRAJSVWCLKUA4FC4H
X-Message-ID-Hash: LGHA2QHE6CA6PXFLRAJSVWCLKUA4FC4H
X-MailFrom: nico.escande@gmail.com
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/LGHA2QHE6CA6PXFLRAJSVWCLKUA4FC4H/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

On Sat May 18, 2024 at 5:50 PM CEST, Remi Pommarel wrote:
> Wiphy should be locked before calling rdev_get_station() (see lockdep
> assert in ieee80211_get_station()).
>
> This fixes the following kernel NULL dereference:
>
>  Unable to handle kernel NULL pointer dereference at virtual address 0000=
000000000050
>  Mem abort info:
>    ESR =3D 0x0000000096000006
>    EC =3D 0x25: DABT (current EL), IL =3D 32 bits
>    SET =3D 0, FnV =3D 0
>    EA =3D 0, S1PTW =3D 0
>    FSC =3D 0x06: level 2 translation fault
>  Data abort info:
>    ISV =3D 0, ISS =3D 0x00000006
>    CM =3D 0, WnR =3D 0
>  user pgtable: 4k pages, 48-bit VAs, pgdp=3D0000000003001000
>  [0000000000000050] pgd=3D0800000002dca003, p4d=3D0800000002dca003, pud=
=3D08000000028e9003, pmd=3D0000000000000000
>  Internal error: Oops: 0000000096000006 [#1] SMP
>  Modules linked in: netconsole dwc3_meson_g12a dwc3_of_simple dwc3 ip_gre=
 gre ath10k_pci ath10k_core ath9k ath9k_common ath9k_hw ath
>  CPU: 0 PID: 1091 Comm: kworker/u8:0 Not tainted 6.4.0-02144-g565f9a3a791=
1-dirty #705
>  Hardware name: RPT (r1) (DT)
>  Workqueue: bat_events batadv_v_elp_throughput_metric_update
>  pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)
>  pc : ath10k_sta_statistics+0x10/0x2dc [ath10k_core]
>  lr : sta_set_sinfo+0xcc/0xbd4
>  sp : ffff000007b43ad0
>  x29: ffff000007b43ad0 x28: ffff0000071fa900 x27: ffff00000294ca98
>  x26: ffff000006830880 x25: ffff000006830880 x24: ffff00000294c000
>  x23: 0000000000000001 x22: ffff000007b43c90 x21: ffff800008898acc
>  x20: ffff00000294c6e8 x19: ffff000007b43c90 x18: 0000000000000000
>  x17: 445946354d552d78 x16: 62661f7200000000 x15: 57464f445946354d
>  x14: 0000000000000000 x13: 00000000000000e3 x12: d5f0acbcebea978e
>  x11: 00000000000000e3 x10: 000000010048fe41 x9 : 0000000000000000
>  x8 : ffff000007b43d90 x7 : 000000007a1e2125 x6 : 0000000000000000
>  x5 : ffff0000024e0900 x4 : ffff800000a0250c x3 : ffff000007b43c90
>  x2 : ffff00000294ca98 x1 : ffff000006831920 x0 : 0000000000000000
>  Call trace:
>   ath10k_sta_statistics+0x10/0x2dc [ath10k_core]
>   sta_set_sinfo+0xcc/0xbd4
>   ieee80211_get_station+0x2c/0x44
>   cfg80211_get_station+0x80/0x154
>   batadv_v_elp_get_throughput+0x138/0x1fc
>   batadv_v_elp_throughput_metric_update+0x1c/0xa4
>   process_one_work+0x1ec/0x414
>   worker_thread+0x70/0x46c
>   kthread+0xdc/0xe0
>   ret_from_fork+0x10/0x20
>  Code: a9bb7bfd 910003fd a90153f3 f9411c40 (f9402814)
>
> Fixes: 7406353d43c8 ("cfg80211: implement cfg80211_get_station cfg80211 A=
PI")
> Signed-off-by: Remi Pommarel <repk@triplefau.lt>

Reviewed-by: Nicolas Escande <nico.escande@gmail.com>
