Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: Re: [PATCH] batman-adv: don't warn when enslaving hard interface failed
Date: Sun, 06 Jun 2021 16:35:31 +0200
Message-ID: <19096778.Bt7unJmvIX@sven-l14>
In-Reply-To: <99650324-734d-54ed-cd9a-e7b55b8f3630@i-love.sakura.ne.jp>
References: <04896d08-4bc0-019b-966e-41064effdef6@i-love.sakura.ne.jp> <99650324-734d-54ed-cd9a-e7b55b8f3630@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart26609172.PVNqou5XFX"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: Marek Lindner <mareklindner@neomailbox.ch>, Simon Wunderlich <sw@simonwunderlich.de>, Antonio Quartulli <a@unstable.cc>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: b.a.t.m.a.n@lists.open-mesh.org

 
--nextPart26609172.PVNqou5XFX
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: Marek Lindner <mareklindner@neomailbox.ch>, Simon Wunderlich <sw@simonwunderlich.de>, Antonio Quartulli <a@unstable.cc>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: b.a.t.m.a.n@lists.open-mesh.org
Subject: Re: [PATCH] batman-adv: don't warn when enslaving hard interface failed
Date: Sun, 06 Jun 2021 16:35:31 +0200
Message-ID: <19096778.Bt7unJmvIX@sven-l14>
In-Reply-To: <99650324-734d-54ed-cd9a-e7b55b8f3630@i-love.sakura.ne.jp>
References: <04896d08-4bc0-019b-966e-41064effdef6@i-love.sakura.ne.jp> <99650324-734d-54ed-cd9a-e7b55b8f3630@i-love.sakura.ne.jp>

On Sunday, 6 June 2021 16:28:17 CEST Tetsuo Handa wrote:
> syzbot is hitting
> 
>   WARN_ON(forw_packet->if_outgoing->soft_iface != soft_iface)
> 
> at batadv_iv_ogm_emit() [1], for forw_packet->if_outgoing->soft_iface
> can remain NULL if batadv_hardif_enable_interface() failed due to e.g.
> memory allocation fault injection.

Cannot apply this because following (conflicting) is already queued up in 
batadv/net:  
https://git.open-mesh.org/linux-merge.git/blobdiff/b741596468b010af2846b75f5e75a842ce344a6e..9f460ae31c4435fd022c443a6029352217a16ac1:/net/batman-adv/bat_iv_ogm.c

    Applying patch #18340 using 'git am -s'
    Description: batman-adv: don't warn when enslaving hard interface failed
    Applying: batman-adv: don't warn when enslaving hard interface failed
    error: patch failed: net/batman-adv/bat_iv_ogm.c:409
    error: net/batman-adv/bat_iv_ogm.c: patch does not apply
    Patch failed at 0001 batman-adv: don't warn when enslaving hard interface failed
    hint: Use 'git am --show-current-patch=diff' to see the failed patch
    When you have resolved this problem, run "git am --continue".
    If you prefer to skip this patch, run "git am --skip" instead.
    To restore the original branch and stop patching, run "git am --abort".
    'git am' failed with exit status 128

Please rebase your patch in case it is really needed.

And the explanation you give seems to be bogus. Or am I missing some error 
handling in batadv_hardif_enable_interface [1]?

Kind regards,
	Sven

[1] https://git.open-mesh.org/linux-merge.git/blob/refs/heads/batadv/net-next:/net/batman-adv/hard-interface.c

--nextPart26609172.PVNqou5XFX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmC83TMACgkQXYcKB8Em
e0bRKxAAlJaXKj4hhbXmgpdcT+gMvXAiXeVriPGD//KlPtxfQp3Q4pTM5Qgg2O4n
beBgY9i8eyardY7HERAohZsc6z3CoivaTbnh68Vo+EeqSEAywLhoEdrhT/wPUsqn
P3QaoXA+X5jRzsRRYuULAsyneco+gTXU1RvJXoGgs810RtOnyXh3XiDAgJEXCNUd
DqQiI6rRSWnHAzF8/Dp/GY4j0zLxjXA/X0sqVYd7BRl5UGWSKUzFyAHt6DZq65Xu
d/T/eJjKcQQr2rnqHwDsTV7hXK3WAsPB+fzChV5abjkzJU/e1ARxKo9R3lj7OJx0
JmirGFbUqhTGWXKwh9eLp/Uwg0+lbKxWM5zdl1fVlpyL20MCEsC/Og9hLW30F/dz
ssAPSKFZR/iLON3P+wdbSJINVP//ArZeX8heKr/uYECX7L7tk4D7gyJJ7ULJ9eIx
JQwkTgype5Rl9zXob5De+evNnucXrVdSSS3SrmDBxkjhfuVIQt2IAvjmvM5JdLXX
C/PUxWaLs7fB04UBEIon2vnUSgFa/Uhg6n2ChnMf2bg6UZD/hcWxEqwyXfuBbRQq
dP7Pf3icXhtjXuW2iJksmJeiJtyJXkbBFSvFmyFqnvYNJCRkfFpK7frllW4hxcSY
ZiwoFWZIyOmWypMcQ3Zl7lcAPoSM8xeW5l0J5H588mfqtPtewfo=
=4Pk5
-----END PGP SIGNATURE-----

--nextPart26609172.PVNqou5XFX--


