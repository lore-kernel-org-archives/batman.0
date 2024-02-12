Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D807C48297
	for <batman@archiver.kernel.org>; Mon, 12 Feb 2024 13:29:05 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id B901883FA5
	for <batman@archiver.kernel.org>; Mon, 12 Feb 2024 14:29:03 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1707744543;
 b=FG2QUJsZO1YncqjeG5dzGQf2EOuWr/jv5h1wLZFmMcwWi5E0cZ68CFZ2r874PBGMFZ5zq
 DdkjIWGd9ttMSTDa589Fw48biH+wAB3zfDHi6a2IXEEFCLtwcTW4HYsFHGKkoqLG3+NRHfS
 PqNtt8zJC1EhcfdlDnHumNWK4NqEamg=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1707744543; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=PGnywWK+VuepasyvyymY1bcMLIpjuocEbTBNl63teHs=;
 b=uXiaxnwKzGwPAPhPT57nzskMY5Blrono2+X1EDXwdE2yZvSG0gtzS5jQ+DdxdFjBkZNp7
 1rYalV+sSCf6AsafP3ZzEWIORoXMwAau4EUYEpepeCv/DCLukiZfr4YJPsPk7lQbx5hi0h3
 5elg7Mzi612SeNHa8PyuY+DfB8rSA8Q=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=narfation.org
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id C37DB80095
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 12 Feb 2024 14:28:35 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1707744515;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=PGnywWK+VuepasyvyymY1bcMLIpjuocEbTBNl63teHs=;
	b=0wKvnq4LaM755oB/50AWhMFqM2cdL0qQdKGb9DLPzDXWiIrcaz9Tx0t5IR889OlVMK/5js
	ZjczVMoWh2hBXXM+VXVPr6nJWbnCebTspkIS+vn/tZPetmg8pZtY8fdUHWmEsK1IOaOuTH
	lmVtgR+op45Rrg2BO18BlC5nFMVmyJw=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=K4zSzSVH;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1707744515; a=rsa-sha256;
	cv=none;
	b=fsuZ0FoylEMuB0WJAr3JtXqbOP/VtscgQ3VkDYeDWUdxnGwVIZHKurWHeI3oGHZw/HOB8v
	r6qVgvtcIUY8eSng3vpUrHUJKbdXnu43B/zkTg0kWi2PASClnVXbFD8ddqFSlox69nPgSC
	H1NoRkC5X+ME4GXbmHWH+SRYRryKpQ4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1707744514;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PGnywWK+VuepasyvyymY1bcMLIpjuocEbTBNl63teHs=;
	b=K4zSzSVHDMZqVNAl49y59tHLSIQFnx/1oqewsLZuK2PQ8ar9p4T5qNPzz9rmiRNpGlcAnG
	hr5xel56BVLHq6jCJ88Po+dEFExez83fezt7AmEhUjqq9RmCqEzS+ogcf071swhvjHndTM
	2SWRUoH2Dt87gsG5oe3QAIgXJI8sdXA=
From: Sven Eckelmann <sven@narfation.org>
To: a@unstable.cc, b.a.t.m.a.n@lists.open-mesh.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, linux-kernel@vger.kernel.org,
 mareklindner@neomailbox.ch, netdev@vger.kernel.org, pabeni@redhat.com,
 sw@simonwunderlich.de, syzkaller-bugs@googlegroups.com,
 syzbot <syzbot+a6a4b5bb3da165594cff@syzkaller.appspotmail.com>
Subject: Re: [syzbot] [batman?] BUG: soft lockup in sys_sendmsg
Date: Mon, 12 Feb 2024 14:28:32 +0100
Message-ID: <3281463.44csPzL39Z@ripper>
In-Reply-To: <000000000000ae28ce06112cb52e@google.com>
References: <000000000000ae28ce06112cb52e@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart8334104.T7Z3S40VBb";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: XJF3YXILQU7RWAWSTBQCJFE2X5S2DS6G
X-Message-ID-Hash: XJF3YXILQU7RWAWSTBQCJFE2X5S2DS6G
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/XJF3YXILQU7RWAWSTBQCJFE2X5S2DS6G/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart8334104.T7Z3S40VBb
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
Subject: Re: [syzbot] [batman?] BUG: soft lockup in sys_sendmsg
Date: Mon, 12 Feb 2024 14:28:32 +0100
Message-ID: <3281463.44csPzL39Z@ripper>
In-Reply-To: <000000000000ae28ce06112cb52e@google.com>
References: <000000000000ae28ce06112cb52e@google.com>
MIME-Version: 1.0

On Monday, 12 February 2024 11:26:24 CET syzbot wrote:
> syzbot found the following issue on:
> 
> HEAD commit:    41bccc98fb79 Linux 6.8-rc2
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
> console output: https://syzkaller.appspot.com/x/log.txt?x=14200118180000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=451a1e62b11ea4a6
> dashboard link: https://syzkaller.appspot.com/bug?extid=a6a4b5bb3da165594cff
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> userspace arch: arm64
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/0772069e29cf/disk-41bccc98.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/659d3f0755b7/vmlinux-41bccc98.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/7780a45c3e51/Image-41bccc98.gz.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+a6a4b5bb3da165594cff@syzkaller.appspotmail.com
> 

#syz test

>From 5984ace8f8df7cf8d6f98ded0eebe7d962028992 Mon Sep 17 00:00:00 2001
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 12 Feb 2024 13:10:33 +0100
Subject: [PATCH] batman-adv: Avoid infinite loop trying to resize local TT

If the MTU of one of an attached interface becomes too small to transmit
the local translation table then it must be resized to fit inside all
fragments (when enabled) or a single packet.

But if the MTU becomes too low to transmit even the header + the VLAN
specific part then the resizing of the local TT will never succeed. This
can for example happen when the usable space is 110 bytes and 11 VLANs are
on top of batman-adv. In this case, at least 116 byte would be needed.
There will just be an endless spam of

   batman_adv: batadv0: Forced to purge local tt entries to fit new maximum fragment MTU (110)

in the log but the function will never finish. Problem here is that the
timeout will be halved in each step and will then stagnate at 0 and
therefore never be able to reduce the table even more.

There are other scenarios possible with a similar result. The number of
BATADV_TT_CLIENT_NOPURGE entries in the local TT can for example be too
high to fit inside a packet. Such a scenario can therefore happen also with
only a single VLAN + 7 non-purgable addresses - requiring at least 120
bytes.

While this should be handled proactively when:

* interface with too low MTU is added
* VLAN is added
* non-purgeable local mac is added
* MTU of an attached interface is reduced
* fragmentation setting gets disabled (which most likely requires dropping
  attached interfaces)

not all of these scenarios can be prevented because batman-adv is only
consuming events without the the possibility to prevent these actions
(non-purgable MAC address added, MTU of an attached interface is reduced).
It is therefore necessary to also make sure that the code is able to handle
also the situations when there were already incompatible system
configurations present.

Cc: stable@vger.kernel.org
Fixes: a19d3d85e1b8 ("batman-adv: limit local translation table max size")
Reported-by: syzbot+a6a4b5bb3da165594cff@syzkaller.appspotmail.com
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/translation-table.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index b95c36765d04..2243cec18ecc 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -3948,7 +3948,7 @@ void batadv_tt_local_resize_to_mtu(struct net_device *soft_iface)
 
 	spin_lock_bh(&bat_priv->tt.commit_lock);
 
-	while (true) {
+	while (timeout) {
 		table_size = batadv_tt_local_table_transmit_size(bat_priv);
 		if (packet_size_max >= table_size)
 			break;
-- 
2.39.2


--nextPart8334104.T7Z3S40VBb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmXKHQAACgkQXYcKB8Em
e0ZN1hAAm4AZPTLa+Uy9iVugO8Yew0bm/73u6VXYtlop/Cj88PdsTAvJtgTO1lXw
Cc23VMSQmgXGVn0kRolo8QnDRDtc4w+icm6LVMJmqHn9YKXiUutDrVjytMUhOglu
X1iR7iRB4deA36lvm2hS4EQEzJQO+u4qwa1BQnUEg/G2X+p5dgYJKwejoLVrklw+
ydyxP31lGadzr7FbqZXMRPxcMcMDmAbp4FkhHBfmb9F1UYXJMWpK8efzJlGlyaCb
kf9Mv7LLUVhXfQmJR9Co27CouKQtI5lMBKBcJglvnFAQ0KqTf0CPn7C0D17V0slN
6kCwS4+oPqcK/PoTyA6DrszeSpbkmiRel+vtxsQItI90t4D8BIlCPVpA/F3WZIT0
kERxR0byXoWHLQhkVQr/vs2rBxbCZU6v7PZOrEbTg1W7cfEslXrv9jSyFD51tFNi
FpH8h5gQJ7Qujcl63MprFvfreKH8JxXHe42yaAxV9h2AmDDzdaPzu3W2uyHDPU2L
K2VksYSFkoE8H/KHW3UAk2H6eZ30fEBQInYxaE/X/cpZ4ecA7VRXD5cEUlbtMRA8
fgwPbhebbj2av7TnLrOHf64sngV1sSd7FMfcAIuMeWu29ALH8z0GpIODrseUIRZF
j3dNrQgQ1viz370WF2AftqaEBEp2+cEpzVoG1MRXbHx+ag2NjaU=
=1+AJ
-----END PGP SIGNATURE-----

--nextPart8334104.T7Z3S40VBb--



