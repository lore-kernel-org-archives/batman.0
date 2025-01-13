Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A0C3E7719E
	for <batman@archiver.kernel.org>; Mon, 13 Jan 2025 07:35:39 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 21EA483FEC
	for <batman@archiver.kernel.org>; Mon, 13 Jan 2025 08:35:38 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1736753738;
 b=TxszhTsRzw4AarCjv0h6j/t8KwFpFnw5ArDraEWb6ghx+3xlw/Zvw6x3BuGlJr10xC3q9
 bGCqkYtgL2DfGCdEb0WSdp++oP7WnGSO8AmVUbnHNsT9OG0fYmK0etfUelWJb2oLXOxPIEc
 Z6Yg6Hwv0jZURCK/zy/V89BLMpoimAo=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1736753738; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=ITF2strdj9Y684Qqm+UHAd3Wa5VlD0YwF9xm3pQKmc0=;
 b=WgBiM3x6FCJPdYPKxLjGT7GMH2kJ5uH9fN2n583UaBlslJBx9j6Irp2m1NgeSUD1HRDRe
 iL2r2nxx+izJbp0VAFSSHNCRrMTwB+b6FnE2ylnorSs4yfh0L5gi9Kh3BrNDv5X2acZEebH
 Q5AGCjL2z/lkEufVG6kWnwxPr1zwTx4=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=andrewstrohman-com.20230601.gappssmtp.com;
  arc=pass;
  dmarc=none
Authentication-Results: open-mesh.org;
 dkim=pass header.d=andrewstrohman-com.20230601.gappssmtp.com; arc=pass;
 dmarc=none
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com
 [IPv6:2607:f8b0:4864:20::b2d])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 7C76581B6A
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 13 Jan 2025 08:35:18 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1736753718;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=ITF2strdj9Y684Qqm+UHAd3Wa5VlD0YwF9xm3pQKmc0=;
	b=i1J6off7ynVfAPEc/rY6FbBza6LuuyCbSGseHImXsgyU/y3t7ZCaXFbhmPiEFzXvN4qfnJ
	qVggzcyze2KTyp/v8I+9mU6ijOxs9Su38fWjqx4U+bBXO+eNTjZlZgNwasDsGx0bwiDFYU
	7o0FnZWVzdSqhTfEnd5Bdv+9+GlDHO0=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=andrewstrohman-com.20230601.gappssmtp.com
 header.s=20230601 header.b=by1Yq+XB;
	dmarc=none;
	spf=none (diktynna.open-mesh.org: domain of andrew@andrewstrohman.com has no
 SPF policy when checking 2607:f8b0:4864:20::b2d)
 smtp.mailfrom=andrew@andrewstrohman.com
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1736753718; a=rsa-sha256;
	cv=none;
	b=jZLKkUVGF5sTdV9HAZzR6oGOQKc/S2Zxt+OYy69bPmNboT36RJtLUXDNEbIjo0wZYLsFFr
	1XAdqg2WE4iboeRV0Bed+jxEngqKQiNJDwoYoSpgSzncWAx8jpQCduj4A98I91Ni6+rtWH
	9E+zghAtSG8naa2vFJlEcdA2FN8o0kE=
Received: by mail-yb1-xb2d.google.com with SMTP id
 3f1490d57ef6-e39779a268bso5819959276.1
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Sun, 12 Jan 2025 23:35:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=andrewstrohman-com.20230601.gappssmtp.com; s=20230601; t=1736753717;
 x=1737358517; darn=lists.open-mesh.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ITF2strdj9Y684Qqm+UHAd3Wa5VlD0YwF9xm3pQKmc0=;
        b=by1Yq+XBBJLD32ygWwOTkQAjiD2QvG38dXVLbK4ZjXk9YO5bHO8dVOuOzHCZ31lpeu
         BMhPLw442mV9vNUBh9bHKSeXBc9GZPaD6dAPVxMVbgozKulT9yeRZOblkgfcu6QEcA63
         up+f+jzTrRndBmxWFdOeEElN9Ki9qxKadkcEoYvKNfzUEQx6u67dbkuIKChqo623zNP3
         ceSbC6BbX/u+FGKneSj+U+Y/LXAbXI4hiXK/Ts5AhPj0ongQgeZCqGr3++Avu3945BMT
         ZFDHAyNMrg7HCbTR+rGVQEtr6Ps8Sg23mgD07bv5EUfS1LYKQ79IwSPNiOARMTE6DuV8
         lNjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736753717; x=1737358517;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ITF2strdj9Y684Qqm+UHAd3Wa5VlD0YwF9xm3pQKmc0=;
        b=BQVba2ZTwh6if+w4t0UY/Cymjim+O7TftpW8AwRcarUATaocSSJ0YiBCIOmHfI5MWb
         6c6GpTQyL5FfpuZ6K/vGmDui6sa/2oJ//y72XauTQ70VVDKbrRf56d4l4lcY3jgtHoBz
         vuCBPO8vq4+mefqUxfcXIlW16u29XThQ4Gug8cbMJjea4y1hrl7o9GmLAAY1P8OtiRbB
         jyGHlFr5XWRyLYqmYrRqIzCSgSimsge+u6fEQw7jLMaxtuOUVV7gqtciVxzXSQbN5w2J
         y+yOlU7eeGTaagSVgnMRYjI6fVbKcXoIMK/WDLjTGftXcZ9uoAPqtpA7aSSW6OMQ5xi0
         eACA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXwgq9Wa9mdyuPu961/LGDxEncAwjjYTMFUWG8655BbWs42uxR8zRwGJqQ1MSxcBYnXKq0OV0lBp+Kznw==@lists.open-mesh.org
X-Gm-Message-State: AOJu0Ywb9sJ6trt2D4HRJ+ZaGGLkyzOYRqoJ3avP/1pA3aZcjtks/im8
	cIEHCcS2G0rVdvrbfpkpR9d/Ejd1KDqGAMl5AMbVLP0/QsOODI+8Nz7illG39eGvzRuwu28Zv0H
	L0AWLF21YKt0Vysx2JcObRnTVfF7jXibLuyLnqIL7uJo6wo7Nmhw=
X-Gm-Gg: ASbGncskKYYHM6MVgXvUGZUlPRdT651u4ZlkpJZOTYj/2WexMjeCM0nrdSRQinPhNQa
	2yyqqGQkyApqEnvbjPsIR/VCdqsU/uNGNU2OphQ==
X-Google-Smtp-Source: 
 AGHT+IG5Pi04XDhL3GNGT0wXGGQhziDaM8X+fx8/lWujz9bFIC6KPRmCTUli2BIMAtqFEHYm4go6l55hGT72hZgL27c=
X-Received: by 2002:a25:2d23:0:b0:e57:3165:296a with SMTP id
 3f1490d57ef6-e5731652b53mr6601404276.22.1736753717055; Sun, 12 Jan 2025
 23:35:17 -0800 (PST)
MIME-Version: 1.0
References: <20250109022756.1138030-1-andrew@andrewstrohman.com>
 <1882889.atdPhlSkOF@ripper>
 <CAA8ajJkhd=CaNoqZ+juKHh8PV975s_vEfLU4xLfwn-Yj+caEPg@mail.gmail.com>
 <5533653.Sb9uPGUboI@ripper>
 <CAA8ajJnVQWO3fhLAjQtEfjEVReY7x-==TEkhrKQKZMrVJms44w@mail.gmail.com>
 <Z4EcPQOMU1BUtO07@pilgrim>
In-Reply-To: <Z4EcPQOMU1BUtO07@pilgrim>
From: Andrew Strohman <andrew@andrewstrohman.com>
Date: Sun, 12 Jan 2025 23:35:05 -0800
X-Gm-Features: AbW1kvYqnZzy2mSCr6FiOwLwkRyebsgYpE4Hs3hcie5Pbz5fD9jVqw8GQACtmAw
Message-ID: 
 <CAA8ajJ=etpv--YNTww2uuYvNnoe2tCSNqas2cVLdZodHnqZb_g@mail.gmail.com>
Subject: Re: [PATCH] batman-adv: fix panic during interface removal
To: Remi Pommarel <repk@triplefau.lt>
Cc: Sven Eckelmann <sven@narfation.org>, b.a.t.m.a.n@lists.open-mesh.org
Content-Type: text/plain; charset="UTF-8"
Message-ID-Hash: IJCAWOC5BV52SMWELKDAG46GUNMDWOTA
X-Message-ID-Hash: IJCAWOC5BV52SMWELKDAG46GUNMDWOTA
X-MailFrom: andrew@andrewstrohman.com
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/IJCAWOC5BV52SMWELKDAG46GUNMDWOTA/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Hi Remi,

 Thanks for your thoughts.

> Quickly looking at that I think that metric_work may need to sleep so
> calling cancel_work_sync() on this work does not seem safe while in rcu
> protected context.

Thanks, you're right. I'm not supposed to call cancel_work_sync() unless
it's OK to sleep.


> I would try to frame the cancel_work_sync() call with
> rcu_read_unlock()/rcu_read_lock() as below:
>
>   rcu_read_unlock();
>   cancel_work_sync(...);
>   rcu_read_lock();
>   batadv_hardif_neigh_put(...);


Despite the necessity to not sleep while in the RCU read side
critical section, this was not the cause of the hang.

I enabled hung task detection and was able see the call
stacks of all the tasks during the hang, which made the
issue clear.  batadv_v_elp_iface_disable() is called with
the RTNL lock held (via setlink). Calling cancel_work_sync()
will wait on batadv_v_elp_throughput_metric_update()
to complete, but batadv_v_elp_throughput_metric_update()
calls batadv_v_elp_get_throughput(), which acquires
the RTNL lock. So this is why I have deadlock: the work
cannot move forward until the RTNL is released, but the
caller of cancel_work_sync() holds the lock and won't release
it until the work finishes.

Sven, does this change your opinion about how this
issue should be handled? I'm not sure yet if it's safe
to temporarily release RTNL lock during the
duration of the cancel_work_sync() call.


> But be careful as batadv_hardif_neigh_put() could modify the list you
> are currently traversing.

Yes, batadv_hardif_neigh_put() can cause the reference count to go to zero.
If so, batadv_hardif_neigh_release() will be called, but it frees the
memory allocated for the neighbor with kfree_rcu(). Since the suggestion
was to acquire the RCU read lock before calling batadv_hardif_neigh_put,
I don't anticipate a use-after-free outcome.

> At first glance it seems safe to realease
> rcu read constraint to call cancel_work_sync() as long as you take it
> back before calling batadv_hardif_neigh_put(), but this could need more
> though on that.

Do you happen to know where I can find an example of this usage
pattern?

I wonder if unlocking and then re-locking will invalidate this [1]
guarantee:

"The reader is guaranteed to see all of the elements which were
added to the list before they acquired the rcu_read_lock() and are
still on the list when they drop the rcu_read_unlock()."

>From testing, I don't see any issue when trying your suggestion,
but it would be reassuring to see an example of this elsewhere
in the code.


[1] https://docs.kernel.org/RCU/listRCU.html

Thanks,

Andy
