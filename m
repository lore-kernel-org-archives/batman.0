Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5472DC53219
	for <batman@archiver.kernel.org>; Tue, 28 Jul 2026 07:05:07 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 707058409D
	for <batman@archiver.kernel.org>; Tue, 28 Jul 2026 09:05:05 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1785222305;
 b=LNpCVk02SxujT1UDIIMgVMQ50dgQqkbb2aidrjWX4DRThM/8g88Kn62mpHPmjtXZGfnEF
 WriNC5bOlWE56hoewAUrfig3hLLaNrYdxZstP9Z2TX6CsMtr5iIEmLGQ8niltcnQ0wHA1Cx
 eW18T7pNYAG71Ctn5sLXda5inVrbRF0=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1785222305; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=u7jacpBXpBTqofCgNjTjUOYN4l08CWb2DrfC5FriODs=;
 b=0J2F5muMMH8L8AsYZ1flE7+CJT3oGFalmObEVV9VAk9qwfjNpLhZKW7jzxV0Di18IQ8K/
 0zCpUqrJ3me1msRFVX1BMV2iIsoE+C3/JC3KnQmhEIzoV/zePM4mFxNp0O+H9GZFrrVyvg6
 mbh+HmXyUAydx/GMakwL0TSLaWzuDzE=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id B352E8145C
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 28 Jul 2026 09:04:49 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1785222299;
	b=nP6JIB4CP0+hTOXCyC1xuo1jK6Kz0xNkJtVWIcdEMOSk1X4hk2RRQ4sOyFI5cOLNcYRcAP
	18BFMWAHx22zPbDoWCA0RuwhHrrpe2PIsTiFrIYTLfs61RVNk/YBh1iundk6MwGu0tn9Vk
	SpmeMSS9BQXu86ZHlDwKa9PkxLUYmKk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1785222299;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=u7jacpBXpBTqofCgNjTjUOYN4l08CWb2DrfC5FriODs=;
	b=S1etzHtAAdapfgQTClkB3NGLVCYjh9AILD6hpqfmgA8174gs/rk4sTe5Xsv0FI1T5o1X60
	0T3CYGsfLMruRQoiG4I3JfHi6XI16IJFGYTEJSkKynX1r9h2xtj1n4eEBvAwRRbakuufIp
	2R5cHTVCcog1ZnUBWxXuuTkkDeA761E=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=dhf4Qw09;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 4122C200C7;
	Tue, 28 Jul 2026 07:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1785222284;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=u7jacpBXpBTqofCgNjTjUOYN4l08CWb2DrfC5FriODs=;
	b=dhf4Qw09Om4JWfmLM2aJiBNGyMgzcruX8el0QiaxxbpLBgQNMkCnvl7DZRqhCGiq40A4kK
	UAAnFq0PA1snxHvlF3WEhUqgIWOxGoLp4RWUS6PvxpKYsKGdzQZGVGv94OXK5MvrJayvvZ
	vbjM8/qT0EhXbu4kaYmRfCUXEHOlkE4=
From: Sven Eckelmann <sven@narfation.org>
To: Marek Lindner <marek.lindner@mailbox.org>,
 Simon Wunderlich <sw@simonwunderlich.de>,
 Antonio Quartulli <antonio@mandelbit.com>, b.a.t.m.a.n@lists.open-mesh.org,
 Minhong He <heminhong@kylinos.cn>
Cc: linux-kernel@vger.kernel.org, Markus Pargmann <mpa@pengutronix.de>,
 Aditya Pakki <pakki001@umn.edu>,
 Artem Chernyshev <artem.chernyshev@red-soft.ru>
Subject: Re: [PATCH net] batman-adv: check register_netdevice_notifier() and
 rtnl_link_register() errors
Date: Tue, 28 Jul 2026 09:04:37 +0200
Message-ID: <14518281.RDIVbhacDa@sven-l14>
In-Reply-To: <20260728031050.76643-1-heminhong@kylinos.cn>
References: <20260728031050.76643-1-heminhong@kylinos.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart14061147.dW097sEU6C";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: JGHVDJ54FOKUAUJ23DANIG532EGCDJZK
X-Message-ID-Hash: JGHVDJ54FOKUAUJ23DANIG532EGCDJZK
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/JGHVDJ54FOKUAUJ23DANIG532EGCDJZK/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart14061147.dW097sEU6C
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 28 Jul 2026 09:04:37 +0200
Message-ID: <14518281.RDIVbhacDa@sven-l14>
In-Reply-To: <20260728031050.76643-1-heminhong@kylinos.cn>
References: <20260728031050.76643-1-heminhong@kylinos.cn>
MIME-Version: 1.0

On Tuesday, 28 July 2026 05:10:50 CEST Minhong He wrote:
> batadv_init() ignores errors from register_netdevice_notifier() and
> rtnl_link_register(), so the module can load without those registrations
> in place.
> 
> Check both return values and unwind prior initialization in reverse order
> of acquisition on failure.
> 
> Signed-off-by: Minhong He <heminhong@kylinos.cn>
> ---
>  net/batman-adv/main.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)

This is not for the net tree/repo. So please don't mark it as such. You must 
target the batadv tree/repo.

> 
> diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
> index 73becb054948..e6bcaf2d14ed 100644
> --- a/net/batman-adv/main.c
> +++ b/net/batman-adv/main.c
> @@ -108,8 +108,14 @@ static int __init batadv_init(void)
>  	if (ret < 0)
>  		goto err_init_wifi;
>  
> -	register_netdevice_notifier(&batadv_hard_if_notifier);
> -	rtnl_link_register(&batadv_link_ops);
> +	ret = register_netdevice_notifier(&batadv_hard_if_notifier);
> +	if (ret < 0)
> +		goto err_reg_notifier;
> +
> +	ret = rtnl_link_register(&batadv_link_ops);
> +	if (ret < 0)
> +		goto err_rtnl_link;
> +
>  	batadv_netlink_register();


You missed the error handling for:

* batadv_netlink_register()
  - doesn't require a cleanup call now but it would be batadv_netlink_unregister()
  - the error must be returned from this function
* batadv_iv_init()
  - no special cleanup call
  - but if you want to add one, please add a deinit wrapper around
    batadv_recv_handler_unregister(BATADV_IV_OGM);
    in bat_iv_ogm.c
* batadv_v_init()
  - no special cleanup call
  - but if you want to add one, please add a deinit wrapper around
    batadv_recv_handler_unregister(BATADV_OGM2);
    batadv_recv_handler_unregister(BATADV_ELP);
    in bat_v.c and make sure you have a dummy variant in bat_v.h

And please adjust the subject to something which doesn't list all the new 
things you check for errors.

>  
>  	pr_info("B.A.T.M.A.N. advanced %s (compatibility version %i) loaded\n",
> @@ -117,6 +123,10 @@ static int __init batadv_init(void)
>  
>  	return 0;
>  
> +err_rtnl_link:
> +	unregister_netdevice_notifier(&batadv_hard_if_notifier);
> +err_reg_notifier:
> +	batadv_wifi_net_devices_deinit();

There must be an rcu_barrier() before batadv_wifi_net_devices_deinit().

>  err_init_wifi:
>  	destroy_workqueue(batadv_event_workqueue);
>  	batadv_event_workqueue = NULL;
> 

See:

* https://patchwork.open-mesh.org/project/b.a.t.m.a.n./patch/1419594103-10928-6-git-send-email-mpa@pengutronix.de/
* https://patchwork.open-mesh.org/project/b.a.t.m.a.n./patch/20181224174926.20321-1-pakki001@umn.edu/
* https://patchwork.open-mesh.org/project/b.a.t.m.a.n./patch/20221224233311.48678-1-artem.chernyshev@red-soft.ru/

Regards,
	Sven


--nextPart14061147.dW097sEU6C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCamhUhQAKCRBND3cr0xT1
y9xPAP0TcOwhSmzGpyEm/Y0L2luIuJwREfWzXXhBYoGRrXsClgEA04aThrUmH4Vl
rUZiwjTomCo/LIw96MOl/rpIf4YM/QI=
=nCo3
-----END PGP SIGNATURE-----

--nextPart14061147.dW097sEU6C--



