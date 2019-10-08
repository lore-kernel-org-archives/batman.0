Return-Path: <boqun.feng@gmail.com>
Date: Tue, 8 Oct 2019 11:58:34 +0800
From: Boqun Feng <boqun.feng@gmail.com>
Subject: Re: KCSAN: data-race in find_next_bit / rcu_report_exp_cpu_mult
Message-ID: <20191008035834.GB2609633@tardis>
References: <000000000000604e8905944f211f@google.com>
 <CANpmjNNmSOagbTpffHr4=Yedckx9Rm2NuGqC9UqE+AOz5f1-ZQ@mail.gmail.com>
 <20191007134304.GA2609633@tardis>
 <20191008001131.GB255532@google.com>
 <20191008021233.GD2689@paulmck-ThinkPad-P72>
 <20191008025056.GA2701514@tardis>
 <20191008033353.GK2689@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="wRRV7LY7NUeQGEoC"
Content-Disposition: inline
In-Reply-To: <20191008033353.GK2689@paulmck-ThinkPad-P72>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Joel Fernandes <joel@joelfernandes.org>, Marco Elver <elver@google.com>, syzbot <syzbot+134336b86f728d6e55a0@syzkaller.appspotmail.com>, josh@joshtriplett.org, rostedt@goodmis.org, mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com, rcu@vger.kernel.org, a@unstable.cc, b.a.t.m.a.n@lists.open-mesh.org, davem@davemloft.net, LKML <linux-kernel@vger.kernel.org>, mareklindner@neomailbox.ch, netdev@vger.kernel.org, sw@simonwunderlich.de, syzkaller-bugs@googlegroups.com


--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 07, 2019 at 08:33:53PM -0700, Paul E. McKenney wrote:
[...]
> > ---
> >  kernel/rcu/tree_exp.h | 17 +++++++----------
> >  1 file changed, 7 insertions(+), 10 deletions(-)
> >=20
> > diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
> > index af7e7b9c86af..fb51752ac9a6 100644
> > --- a/kernel/rcu/tree_exp.h
> > +++ b/kernel/rcu/tree_exp.h
> > @@ -372,12 +372,10 @@ static void sync_rcu_exp_select_node_cpus(struct =
work_struct *wp)
> >  	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
> > =20
> >  	/* IPI the remaining CPUs for expedited quiescent state. */
> > -	for_each_leaf_node_cpu_mask(rnp, cpu, rnp->expmask) {
> > +	for_each_leaf_node_cpu_mask(rnp, cpu, mask_ofl_ipi) {
> >  		unsigned long mask =3D leaf_node_cpu_bit(rnp, cpu);
> >  		struct rcu_data *rdp =3D per_cpu_ptr(&rcu_data, cpu);
> > =20
> > -		if (!(mask_ofl_ipi & mask))
> > -			continue;
> >  retry_ipi:
> >  		if (rcu_dynticks_in_eqs_since(rdp, rdp->exp_dynticks_snap)) {
> >  			mask_ofl_test |=3D mask;
>=20
> This part I have already on -rcu branch "dev".
>=20
> > @@ -389,10 +387,10 @@ static void sync_rcu_exp_select_node_cpus(struct =
work_struct *wp)
> >  		}
> >  		ret =3D smp_call_function_single(cpu, rcu_exp_handler, NULL, 0);
> >  		put_cpu();
> > -		if (!ret) {
> > -			mask_ofl_ipi &=3D ~mask;
> > +		/* the CPU responses the IPI, and it will report QS itself */
> > +		if (!ret)
> >  			continue;
> > -		}
> > +
> >  		/* Failed, raced with CPU hotplug operation. */
> >  		raw_spin_lock_irqsave_rcu_node(rnp, flags);
> >  		if ((rnp->qsmaskinitnext & mask) &&
> > @@ -403,13 +401,12 @@ static void sync_rcu_exp_select_node_cpus(struct =
work_struct *wp)
> >  			schedule_timeout_uninterruptible(1);
> >  			goto retry_ipi;
> >  		}
> > -		/* CPU really is offline, so we can ignore it. */
> > -		if (!(rnp->expmask & mask))
> > -			mask_ofl_ipi &=3D ~mask;
> > +		/* CPU really is offline, and we need its QS. */
> > +		if (rnp->expmask & mask)
> > +			mask_ofl_test |=3D mask;
> >  		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
> >  	}
> >  	/* Report quiescent states for those that went offline. */
> > -	mask_ofl_test |=3D mask_ofl_ipi;
> >  	if (mask_ofl_test)
> >  		rcu_report_exp_cpu_mult(rnp, mask_ofl_test, false);
> >  }
>=20
> Would you be willing to port this optimization on top of current -rcu
> branch "dev" with an suitably modified commit message?
>=20

Sure, will do ;-)

Regards,
Boqun

> 							Thanx, Paul

--wRRV7LY7NUeQGEoC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEj5IosQTPz8XU1wRHSXnow7UH+rgFAl2cCWYACgkQSXnow7UH
+rhz7Af+Nij364bAg8HkjALb5BhcfB+hJC9AgMEcFVjStzO0s8BnctHvtlQeh0nM
DKIuwC+YwUX4c1uwWWtI4EQlCwseOQJLFaC3QP7sdyqIzziLeUeL4QEhinAONiAA
nlp9qS/qChRQ21B0RsvxFhT/SoWrpCf7x78rVTjpi2lOc7fopFEX52CeGwwioWLL
o7gfkrBtGhSTwkYI9OCJOiOrzmFLxvkSwKqlYuvC8T5IUSV5LQKWEyEo8bCwEAzs
fNZo4Svq/PhE5nIBOzvy2P/Wfc3VK5MAbe977ptBzV1rEpvnZl/6MA0yp18YwuKC
v0op9RMzpBPyNhZeacKMGigiNyq9lA==
=+lHp
-----END PGP SIGNATURE-----

--wRRV7LY7NUeQGEoC--
