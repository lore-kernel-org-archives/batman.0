Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8DD0C5AE59
	for <batman-adv@archiver.kernel.org>; Sat, 31 May 2025 09:56:49 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 64AD6847B1
	for <batman-adv@archiver.kernel.org>; Sat, 31 May 2025 11:56:48 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1748685408;
 b=f0xkt5lHxDtN1HXEU8aSP9QGxK2xlGmek+z6C9dxX+3hcX20M7Uc2GhB74EK4yzlt3+Rw
 Cr+iaSjNy7Y9CBq3qQ0QGShTXrcO4SeOXI2fTz7rZIYgxAb3BaQp6jUrptkOWyde2Z1GhXK
 aXedHoH7Wq1t65/w869iPpYYpU2y9Fw=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1748685408; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=esolGE2tSmNnPRF4uWyr6841H7n9QIGFhdDzJ0qYsmo=;
 b=FqN0qt2ethBDStYSudUDLUIChAXnGDcBw314dUPZWJFYG7CE0j/599Z5vQ0zPDNU4dWJd
 o+G4Xr7PERAFjKyzthC2VzssAE7haw2JL7TRUXcNezLRJUkLgpxYc7a28uVMY8Og80irQrd
 sAzoVIjIrdb/Cq2G8bAbFe6nBXNQIBg=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=narfation.org
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 2303881EC0
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat, 31 May 2025 11:56:39 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1748685399;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=esolGE2tSmNnPRF4uWyr6841H7n9QIGFhdDzJ0qYsmo=;
	b=X1XQzQqy05641SBHs8JxwfTRgHaQAYgSbVYEi4aQ8OvHJO0SsbGSmdPagVjI6JPOz+TZV1
	6aMKhvrksB9afiqRkdGe3PUq9Dt0Xek/kIXKSvDYVZ6S+Wnxho8VotFEKOoLkT6OlicLuS
	5NAJtzPPLMqU5l3KZJiG6lSJKTd7vuw=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=yXIApW4H;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1748685399; a=rsa-sha256;
	cv=none;
	b=nWTIukzdFfBDe5hceAVVb0VIndsqh+G1+d6OWHUVpKL+2Vh/5FHt+wSyOukDHCtc21MaP5
	LkfUHZjGl3Tmes1pShrXZ+TUYFitG1yroAraXwckp6K9WwAO5eRz0jLYo6sjviSu1KJq1w
	OcbZjQ6oGRrrxbWEz9OtoRmj3dBQnC4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1748685398;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=esolGE2tSmNnPRF4uWyr6841H7n9QIGFhdDzJ0qYsmo=;
	b=yXIApW4HetJxcCx6PbYU2Q6MGzczG2zPhjkkhokn3Wrk5Q5F4MdxlWKesADIWWmNJOo548
	VcTUqqQG9FvvAsjfF6eMVXMn93YX68dm4KK0EIhzX4oFIXTPlPCQpS6l35GJoMhqqPuOgJ
	OUwp+cRrPEtZrF570WH7O4K/For/0DM=
From: Sven Eckelmann <sven@narfation.org>
To: Marek Lindner <marek.lindner@mailbox.org>,
 Simon Wunderlich <sw@simonwunderlich.de>,
 Antonio Quartulli <antonio@mandelbit.com>,
 Matthias Schiffer <mschiffer@universe-factory.net>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Matthias Schiffer <mschiffer@universe-factory.net>
Subject: Re: [PATCH batadv 4/5] batman-adv: remove global hardif list
Date: Sat, 31 May 2025 11:56:34 +0200
Message-ID: <4860101.CbtlEUcBR6@sven-desktop>
In-Reply-To: 
 <262d5c5a5afe3d478d2e65187c0913a3a8c4781f.1747687504.git.mschiffer@universe-factory.net>
References: 
 <0b26554afea5203820faef1dfb498af7533a9b5d.1747687504.git.mschiffer@universe-factory.net>
 <262d5c5a5afe3d478d2e65187c0913a3a8c4781f.1747687504.git.mschiffer@universe-factory.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6384946.cEBGB3zze1";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: H47XL2HNBE6ZZV3D5LSSJZKUOH6KFTYH
X-Message-ID-Hash: H47XL2HNBE6ZZV3D5LSSJZKUOH6KFTYH
X-MailFrom: sven@narfation.org
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/H47XL2HNBE6ZZV3D5LSSJZKUOH6KFTYH/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart6384946.cEBGB3zze1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
Subject: Re: [PATCH batadv 4/5] batman-adv: remove global hardif list
Date: Sat, 31 May 2025 11:56:34 +0200
Message-ID: <4860101.CbtlEUcBR6@sven-desktop>
MIME-Version: 1.0

On Monday, 19 May 2025 22:46:31 CEST Matthias Schiffer wrote:
>  struct batadv_hard_iface *
> -batadv_hardif_get_by_netdev(const struct net_device *net_dev)
> +batadv_hardif_get_by_netdev(struct net_device *net_dev)
>  {
>         struct batadv_hard_iface *hard_iface;
> +       struct net_device *mesh_iface;
> =20
> -       rcu_read_lock();
> -       list_for_each_entry_rcu(hard_iface, &batadv_hardif_list, list) {
> -               if (hard_iface->net_dev =3D=3D net_dev &&
> -                   kref_get_unless_zero(&hard_iface->refcount))
> -                       goto out;
> -       }
> +       mesh_iface =3D netdev_master_upper_dev_get(net_dev);
> +       if (!mesh_iface || !batadv_meshif_is_valid(mesh_iface))
> +               return NULL;
> =20
> -       hard_iface =3D NULL;
> +       hard_iface =3D netdev_lower_dev_get_private(mesh_iface, net_dev);
> +       if (!kref_get_unless_zero(&hard_iface->refcount))
> +               return NULL;
> =20
> -out:
> -       rcu_read_unlock();
>         return hard_iface;
>  }

This code is now relying on rtnl_lock() (see `ASSERT_RTNL` in=20
`netdev_master_upper_dev_get` and most likely some comments somwhere about =
the=20
lists used by `netdev_lower_dev_get_private`). But `batadv_tt_local_add` is=
=20
using this function without holding this lock all the time. For example dur=
ing
packet processing.

See for example `batadv_tt_local_add` calls in `batadv_interface_tx`. This=
=20
will happen when `skb->skb_iif` is not 0 (so it was forwarded).


Please double check this - I have not actually tested it but just went thro=
ugh=20
the code.


And saying this, the `batadv_hardif_get_by_netdev` call was also used to=20
retrieve additional information about alll kind of interfaces - even when t=
hey=20
are not used by batman-adv directly. For example for figuring out if it is =
a=20
wifi interface(for the TT wifi flag). With you change here, you are basical=
ly=20
breaking this functionality because you now require that the netdev is a lo=
wer=20
interface of batman-adv. Therefore, things like:


                   =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=90            =20
       =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=BCbr-lan=E2=94=9C=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90     =20
       =E2=94=82           =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=98      =E2=94=82     =20
       =E2=94=82                         =E2=94=82     =20
       =E2=94=82                         =E2=94=82     =20
     =E2=94=8C=E2=94=80=E2=96=BC=E2=94=80=E2=94=90                    =E2=
=94=8C=E2=94=80=E2=94=80=E2=96=BC=E2=94=80=E2=94=90   =20
     =E2=94=82ap0=E2=94=82                    =E2=94=82bat0=E2=94=82   =20
     =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=98                    =E2=
=94=94=E2=94=80=E2=94=80=E2=94=AC=E2=94=80=E2=94=98   =20
                                 =E2=94=82     =20
                                 =E2=94=82     =20
                              =E2=94=8C=E2=94=80=E2=94=80=E2=96=BC=E2=94=80=
=E2=94=80=E2=94=90  =20
                              =E2=94=82mesh0=E2=94=82  =20
                              =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=98  =20
                                       =20
                                       =20
Is not handled anymore correctly in TT because ap0 is not a lower interface=
 of=20
any batadv mesh interface. And as result, the ap-isolation feature of TT
will break.

Kind regards,
	Sven
--nextPart6384946.cEBGB3zze1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCaDrSUwAKCRBND3cr0xT1
y1CLAP0XdjoI2bffn1RBFQJQ9/80BKTDk7uFDARhT1LU3ccLXgD/VigawRbVt5L8
GQJphRNf9pct+c3yAGqgAEw2JOpY7wA=
=BNYO
-----END PGP SIGNATURE-----

--nextPart6384946.cEBGB3zze1--



