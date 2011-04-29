Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 29 Apr 2011 21:58:06 +0200
References: <1302891882-11246-1-git-send-email-linus.luessing@web.de>
	<201104160954.49563.sven@narfation.org>
	<20110427160258.GA32614@Sellars>
In-Reply-To: <20110427160258.GA32614@Sellars>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3504373.K5UkmtGuZs";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201104292158.08430.sven@narfation.org>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Fix crash on module shutdown
	with multiple ifaces
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Linus =?iso-8859-1?q?L=FCssing?= <linus.luessing@web.de>
Cc: b.a.t.m.a.n@lists.open-mesh.org

--nextPart3504373.K5UkmtGuZs
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Linus L=FCssing wrote:

> Ah, oki doki, didn't know about commit 5d4b5a4d and yes, a revert
> of that commit looks kind of similar to my patch.
>=20
> Commit 5d4b5a4d together with your statement confuse me a little. The
> commit message does not say anything about a locking dependancy
> issue, but seems to be a performance patch (which does not seem as
> such a severe problem to me, as removing/adding interfaces /
> removing the batman-adv module does not happen that frequently in
> common setups ;) ). Could you explain a little further which
> combinations of locks could introduce a problem?

No

> Hmm, for the "and explain why it is save to use the spin_lock
> only" part, aggreed, I think it was initially a mistake of mine.
> And usually this would not protect us from a new interface being
> added or an interface being removed from batman during a
> NETDEV_REGISTER/UNREGISTER event while we are trying to flush the
> if_list.
> However, just before calling hardif_remove_interfaces(), we are
> calling unregister_netdevice_notifier(&hard_if_notifier).
> So as far as I know, no hardif_add_interface() or
> hardif_remove_interface() and according list_add/del_rcu for the
> if_list should be called anymore.

Interesting assumption, but how did you ensure that everything is in a=20
synchronous state? The network core also uses rcu - and it doesn't use the=
=20
atomic notifier functions.

> Cheers, Linus
>=20
> PS: And it's actually not an "unhandled kernel paging request" but
> a "Null pointer dereference". Also see this ticket:
> http://www.open-mesh.org/issues/147
>=20
> I'm also wondering why we'd actually need the rtnl_lock() in
> hardif_remove_interfaces() then with that reasoning. What
> operation in hardif_remove_interface() (without the 's') needs to
> be protected with the rtnl_lock(), could be place the rtnl_lock a
> little tighter instead to also fix the issue from here?
> http://www.open-mesh.org/issues/145

See 132b776c22c9b71962a3ed9a33e5b6f9218dae1b

I will propose two different patches.

Regards,
	Sven

--nextPart3504373.K5UkmtGuZs
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABCgAGBQJNuxhPAAoJEF2HCgfBJntGWT0QANiCk8maiV6+FUB+c6Zc82q+
RP9l6svy9S5PuPtEYiQdkd2H0kD+Aosum+jji2JkfRmMbDj3ZgLOhvW93C6b63fg
AX+hIR9b9SiDd6PklRxgjUTdif2RFBWD8SUxy/5ufeGI61PIwG57B3yJZD6Q5YM3
vWopTLE13PXgokcsI8ftyrJ3xV+I+C6sKQa6gOkQgtvMIJeHz00Egn6HqdKPOt5J
cjHd4MU7nDVWJG8a7mf7aVCW8I0s1rTaDp9P8xXla2dxETQvGvGW7g81dIlIRe5P
rX5G0yOlus9opZAR/4UUMPC0Y37shWw/fE2kwSjPpACvKPLc4mYzATYZyO92wV4S
4QSS1WBlpvzF3m+q4u3QTbIJXh2EPBqDZJPbwI/oJHylsBtVwSYExQf1JkUig343
m/BtYHwNsEKWRL4FAbIpkzTDLogpMwzD3gc+B9JhWnhJ6jhHxGZVZ9hq4xhPO9uX
vo7rT1yTVoraKrR8cPz6L+gEhwxg+Dv9BvMUUQPFSXLOMRQPevU8O/kPmD6k01p/
LG/PRJGiAvJTFnCoSErQnk9poPcbuM1ue/xkEz3/mdDXXnJUvUR0QfUWYEqxOfAo
Fvbhig8cjDLZtXo11i9UYVdwv9Jbf13wxauQdqc2Lf5lbieENaTEDeEgpuFTnAsb
HI2T0ugreJldgrdCw/Vx
=mZrf
-----END PGP SIGNATURE-----

--nextPart3504373.K5UkmtGuZs--
