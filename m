Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 01 Dec 2012 20:04:26 +0100
Message-ID: <10264267.HX5FJDguj3@sven-laptop.home.narfation.org>
In-Reply-To: <1354386972.20109.523.camel@edumazet-glaptop>
References: <1354382991-31350-1-git-send-email-siwu@hrz.tu-chemnitz.de>
 <1354386972.20109.523.camel@edumazet-glaptop>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1362211.nCRniLrfGX";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7Bit
Subject: Re: [B.A.T.M.A.N.] [PATCH] net: fix possible deadlocks in
	rtnl_trylock/unlock
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: netdev@vger.kernel.org, davem@davemloft.net, Eric Dumazet <eric.dumazet@gmail.com>, Simon Wunderlich <siwu@hrz.tu-chemnitz.de>


--nextPart1362211.nCRniLrfGX
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

On Saturday 01 December 2012 10:36:12 Eric Dumazet wrote:
[...]
> > diff --git a/net/batman-adv/sysfs.c b/net/batman-adv/sysfs.c
> > index 66518c7..41b74aa 100644
> > --- a/net/batman-adv/sysfs.c
> > +++ b/net/batman-adv/sysfs.c
> > @@ -635,7 +635,7 @@ static ssize_t batadv_store_mesh_iface(struct kobject
> > *kobj,> 
> >  	ret = batadv_hardif_enable_interface(hard_iface, buff);
> >  
> >  unlock:
> > -	rtnl_unlock();
> > +	__rtnl_unlock();
> > 
> >  out:
> >  	batadv_hardif_free_ref(hard_iface);
> >  	return ret;
> > 
> > diff --git a/net/bridge/br_sysfs_br.c b/net/bridge/br_sysfs_br.c
> > index c5c0593..c122782 100644
> > --- a/net/bridge/br_sysfs_br.c
> > +++ b/net/bridge/br_sysfs_br.c
> > @@ -142,7 +142,7 @@ static ssize_t store_stp_state(struct device *d,
> > 
> >  	if (!rtnl_trylock())
> >  	
> >  		return restart_syscall();
> >  	
> >  	br_stp_set_enabled(br, val);
> > 
> > -	rtnl_unlock();
> > +	__rtnl_unlock();
> > 
> >  	return len;
> >  
> >  }
> 
> I have no idea of why you believe there is a problem here.
> 
> Could you explain how net_todo_list could be not empty ?
> 
> As long as no device is unregistered between
> rtnl_trylock()/rtnl_unlock(), there is no possible deadlock.

I am not sure what "here" means for your. At least batman-adv tries to 
unregister a device -> problem [1]. I will not make any judgements about the 
other uses in the kernel/other parts patched by Simon.

Kind regards,
	Sven

[1] http://article.gmane.org/gmane.linux.kernel/1392295
--nextPart1362211.nCRniLrfGX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAABCgAGBQJQulS6AAoJEF2HCgfBJntGU8kQALxCkbt8UfgdEH3GELtpK3qk
/I06dBXApEwGr3LgjMKbUnY8InjhiUNuoo/Sw9DQmPW24Nv9raSacpG0wnOIO8QH
ltsNlie6pYEka8WUb0dGMVWD7l82sfgja6ExrNJIjLudeb6DAC4qsg3RL26oH2W/
TUk6L7NbJAcg1v3nBs3c9Cjba58aEiNZVMghEEuXySWPi1Lvpa2Sp36PmJgapjVP
Po6yyWvoQPvWR/0iRt/EmTy8Lmdroemexe5gjxTebdVvonagYqX1qudC1TYm3f9/
pUQ2fmY86/bxatO7VIiEeGLM2Y3diQGs0d3PybyEq0AIpDWPmPkNbk5r0VpxREoR
IFKmIrHbCO16leIR9o87GlY0nG2mw1mAsfAaNoNMtwJosUpSx4O5r9MUCDtdLt1s
LUw2rXTg+N2lXCrB36pz5zEGf/rKw/FCmvEKToAtUiKiQE44dxjzBJO1MuEdVcOF
kSO69gpmOFgj0if0Mt/6Wu1w1OiZbwczdlJ7JyVxr2HjGU74dSMxA12f9h7JA+qA
ftm+NXZ/VTYUOoDNHyJ9vOzvZlH8UlpgRxHhbUa46O89qN5Hb2KAvo/HVppf358Q
fIjr+1OegvvL/bk284diL5IUyjZrMsn4XF0sZRwyDdooX5yxnnd4axDp4L/vW8WR
/DYp3R83n7V1f+EXhFqK
=mu+A
-----END PGP SIGNATURE-----

--nextPart1362211.nCRniLrfGX--

