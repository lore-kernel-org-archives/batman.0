Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Tue, 7 Sep 2010 19:56:53 +0200
References: <1283646353-17811-1-git-send-email-sven.eckelmann@gmx.de>
	<20100907171917.GD2448@linux.vnet.ibm.com>
In-Reply-To: <20100907171917.GD2448@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1311290.Pq0VgouZE1";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201009071956.54499.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv4] net: Add batman-adv meshing protocol
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
To: paulmck@linux.vnet.ibm.com
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.net, davem@davemloft.net

--nextPart1311290.Pq0VgouZE1
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Thanks for your comment. I removed the parts you don't refer to (makes it l=
ot=20
easier to find the actual comment).

Paul E. McKenney wrote:
> > +
> > +#include <linux/if_arp.h>
> > +
> > +#define MIN(x, y) ((x) < (y) ? (x) : (y))
> > +
> > +struct batman_if *get_batman_if_by_netdev(struct net_device *net_dev)
> > +{
> > +     struct batman_if *batman_if;
> > +
> > +     rcu_read_lock();
> > +     list_for_each_entry_rcu(batman_if, &if_list, list) {
> > +             if (batman_if->net_dev =3D=3D net_dev)
> > +                     goto out;
> > +     }
> > +
> > +     batman_if =3D NULL;
> > +
> > +out:
> > +     rcu_read_unlock();
>=20
> Here we are leaking an RCU-protected pointer outside of the RCU read-side
> critical section.  Why is this safe?

=46irst thing: Their is another rcu related problem with a call_rcu and the=
=20
missing explicit (so not done implizit by another function) synchronize_rcu=
=20
before the shutdown. This was fixed right after this patch was send for a=20
review... bad timing, but ok.

> Here is the sequence of events that I am concerned about:
>=20
> 1.      CPU 0 executes the code above, obtains a pointer, and is about
>         ready to return.
>=20
> 2.      CPU 1 executes hardif_remove_interface(), and calls
>         hardif_disable_interface(), which calls
>         hardif_deactivate_interface(), which sets ->if_status to
>         IF_INACTIVE.  Then hardif_disable_interface() sets ->if_status
>         to IF_NOT_IN_USE.  Then hardif_remove_interface() frees
>         the interface via call_rcu().
>=20
> 3.      Of course, call_rcu() waits for an RCU grace period to elapse,
>         but we are no longer in an RCU read-side critical section,
>         so there is nothing stopping the grace period from completing
>         before we are done with the batman_if pointer.
>=20
> Or am I missing some other interlock that prevents
> hardif_remove_interface() from freeing this structure?
>=20
> I have similar concerns with your other RCU read-side critical sections.

Looks to me like a valid point. I have to think a little bit how to solve i=
t=20
correctly. Feel free to add more comments about other rcu cruelties in it.

thanks,
	Sven

--nextPart1311290.Pq0VgouZE1
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJMhnzlAAoJEF2HCgfBJntGOf4P/13RBz/A/mpV9IiEJQPc0kIM
1YAmnhdsrrP94eIKseY47Qf/yCs9qi78B/WN+5DI9ClEaNXVqa+/hoOpja7BBXyy
CvjQxOAVS5SnL5COQexOPQuDnAOCnafPlZLvRSfCBAXfSXu5oPF1RLv6XD+cjV8j
Nm3M4K3Zinr3CPXK5eoiDfATM+vYCb+JDgaV3arz8SjVGK8dGok0fQzjMpxgk3q5
4riv61LlaqkuFpOzL2cGCfPAFZ8l0GxF+ApBdy1CNO0CvBizkdt2pGsjGUSO+4t/
eTmLTBpGi+jgJw3mj777Za/fS3p94j8aPSrTacLrTwdQg2Hx3G1tjYORJ9gpuiV+
f1HkiNeUNY41o4oS8RQBN+N+CCXs2WGkGGzDrcdFFIpBW1WOqV8p9jsY6YGDhvZ1
bf6suXoM0C8k5xJS4XEJxyNxZoNa1MbXvw5yUctOvZJkz4+Sn3Zs3o8BPx0hN5bZ
8OvFZkPmQd+vcb0D2dCkJX2RUj3SerUPVHvnY/cm03jegy9Q1lJYT9aapeFUIv2q
/aQINk+kZjjoSRZiuW+eYdTYtRCiun4PdSl5nsoP0Bom3X3FgtzzcoDgZE9W2EUc
oZIjZgDIE09iQQ8Ww2lbH24Cx0fFV0whaAVXlV2MeZTPArJscClSD2nzLJZW90WU
OnIkCW3E1ewKRmHv3Pct
=knBd
-----END PGP SIGNATURE-----

--nextPart1311290.Pq0VgouZE1--
