Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: Re: [PATCH] batman-adv: don't warn when enslaving hard interface failed
Date: Sun, 06 Jun 2021 18:23:42 +0200
Message-ID: <2840183.ZAG60PTCvJ@sven-l14>
In-Reply-To: <e43b78ae-7a4c-3dd2-d4a4-554f0280efa8@i-love.sakura.ne.jp>
References: <04896d08-4bc0-019b-966e-41064effdef6@i-love.sakura.ne.jp> <19096778.Bt7unJmvIX@sven-l14> <e43b78ae-7a4c-3dd2-d4a4-554f0280efa8@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart10473722.78iBaUREnk"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: Marek Lindner <mareklindner@neomailbox.ch>, Simon Wunderlich <sw@simonwunderlich.de>, Antonio Quartulli <a@unstable.cc>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: b.a.t.m.a.n@lists.open-mesh.org

 
--nextPart10473722.78iBaUREnk
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: Marek Lindner <mareklindner@neomailbox.ch>, Simon Wunderlich <sw@simonwunderlich.de>, Antonio Quartulli <a@unstable.cc>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: b.a.t.m.a.n@lists.open-mesh.org
Subject: Re: [PATCH] batman-adv: don't warn when enslaving hard interface failed
Date: Sun, 06 Jun 2021 18:23:42 +0200
Message-ID: <2840183.ZAG60PTCvJ@sven-l14>
In-Reply-To: <e43b78ae-7a4c-3dd2-d4a4-554f0280efa8@i-love.sakura.ne.jp>
References: <04896d08-4bc0-019b-966e-41064effdef6@i-love.sakura.ne.jp> <19096778.Bt7unJmvIX@sven-l14> <e43b78ae-7a4c-3dd2-d4a4-554f0280efa8@i-love.sakura.ne.jp>

On Sunday, 6 June 2021 17:48:25 CEST Tetsuo Handa wrote:
> > And the explanation you give seems to be bogus. Or am I missing some error 
> > handling in batadv_hardif_enable_interface [1]?
> 
> I told syzbot to try https://syzkaller.appspot.com/text?tag=Patch&x=100b083fd00000
> and the response ( https://syzkaller.appspot.com/text?tag=CrashLog&x=1456f0ffd00000 ) was
> 
>    batman_adv: forw_packet->if_outgoing->soft_iface=0000000000000000 forw_packet->if_incoming->soft_iface=0000000039fa85b7
> 
> indicating that if_outgoing->soft_iface was NULL, and there was a memory allocation
> fault injection immediately before this result.
> 
> Since if_outgoing->soft_iface becomes non-NULL if batadv_hardif_enable_interface()
> succeeds, this situation indicates that batadv_hardif_enable_interface() failure
> caused forw_packet->if_outgoing->soft_iface to remain NULL.

Ok, then I misread the commit message. I've understood is as "soft_iface" 
allocation failed (which doesn't happen here anymore) in 
batadv_hardif_enable_interface. But you meant that was that hard_iface->soft_iface is 
set to the correct value, the OGM transmission is started up by batadv_iv_ogm_schedule_buff
but soft_iface is changed back immediately in batadv_hardif_enable_interface because
netdev_master_upper_dev_link failed.

Kind regards,
	Sven
--nextPart10473722.78iBaUREnk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmC89o4ACgkQXYcKB8Em
e0YNXQ//du8VzQaxaA3p7PfnTtZ4ldUFGWwEYKhCRetPeepW21wLPCPOuugjhLEO
VtKp4T4thgRrRfUhwACuN3WbkIXUvbN3SsY4SsLpwMBaR5E2iTxIkRXC1+GWL0QK
LGswIt18DsN6DljUhDono7LKcwVXwtcNS+tXWuGdf4Lv85cyIl7NziD215Gr/WzW
BWPQtCV3kiMvl2A3dCDPmyMLPWfs43vPdlr+LQCVtyNhSifp42BfsETYP2o3UEGb
71G/cWHuYPPC978hbZk63DOS9N4mmrzC/zoC98v0mPIWCnyMqfj9XQfST9cmFdZD
1FfiH44T7/WUR0sCAfgALLNRoAyAOjM/4Ke0FzKJ+Y0INNQkYrf+TKpZmJz2c95V
lLRq4raIYspEGkDo6GQC2bHyiOf74ZnrSDzGnoFfmdMFVun1nuHk4CVYoH0+GJ5d
7KXyK9l3p2La1ss//ODX3oqrYUQ7IsGwobdChGkRHaPg3mKhkryJ59xvmoM86EXp
bv/iLCBaQZkRRZD7Gim1i6lTXlem+p+RN0uHWM0ko5ZsN9IVklrwj+ak3TyagCaq
peh/nudpaBH/lZw7k4iKfRMbZ2wb2nVP+BNY+LHQXrPClhbwaBGlfKVhpgcftRAW
sAd38C+13VDHWtlPueUo9tvpngVQflq20OYHvZ7AbQVTNzqQSu8=
=HTKz
-----END PGP SIGNATURE-----

--nextPart10473722.78iBaUREnk--


