Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 29 Aug 2018 08:56:47 +0200
Message-ID: <2069569.jAo6mdz6e2@bentobox>
In-Reply-To: <20180518014754.23644-2-mareklindner@neomailbox.ch>
References: <20180518014754.23644-1-mareklindner@neomailbox.ch>
 <20180518014754.23644-2-mareklindner@neomailbox.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6244887.926kjZLTdD";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 1/7] batman-adv: tp_meter - prevent
 concurrent tp_meter sessions by using workqueue
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
Cc: Marek Lindner <mareklindner@neomailbox.ch>, Antonio Quartulli <a@unstable.cc>

--nextPart6244887.926kjZLTdD
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi,

looks like you have reference counting issues here:

On Freitag, 18. Mai 2018 09:47:48 CEST Marek Lindner wrote:
> -static void batadv_tp_start_kthread(struct batadv_tp_vars *tp_vars)
> +static void batadv_tp_start_work(struct batadv_tp_vars *tp_vars)
>  {
> -       struct task_struct *kthread;
> -       struct batadv_priv *bat_priv = tp_vars->bat_priv;
> -       u32 session_cookie;
> -
> -       kref_get(&tp_vars->refcount);
> -       kthread = kthread_create(batadv_tp_send, tp_vars, "kbatadv_tp_meter");
> -       if (IS_ERR(kthread)) {
> -               session_cookie = batadv_tp_session_cookie(tp_vars->session,
> -                                                         tp_vars->icmp_uid);
> -               pr_err("batadv: cannot create tp meter kthread\n");
> -               batadv_tp_batctl_error_notify(BATADV_TP_REASON_MEMORY_ERROR,
> -                                             tp_vars->other_end,
> -                                             bat_priv, session_cookie);
> -
> -               /* drop reserved reference for kthread */
> -               batadv_tp_vars_put(tp_vars);
> -
> -               /* cleanup of failed tp meter variables */
> -               batadv_tp_sender_cleanup(bat_priv, tp_vars);
> -               return;
> -       }
> -
> -       wake_up_process(kthread);
> +       /* init work item that will actually execute the test and schedule it */
> +       INIT_WORK(&tp_vars->test_work, batadv_tp_send);
> +       queue_work(batadv_tp_meter_queue, &tp_vars->test_work);
>  }

You completely ignore here that queue_work can fail. And then you have an item 
with a reference counter > 0 in memory and no one cares  about it.

>  
>  /**
> @@ -1053,13 +1035,10 @@ void batadv_tp_start(struct batadv_priv *bat_priv, const u8 *dst,
>         /* init work item for finished tp tests */
>         INIT_DELAYED_WORK(&tp_vars->finish_work, batadv_tp_sender_finish);
>  
> -       /* start tp kthread. This way the write() call issued from userspace can
> -        * happily return and avoid to block
> +       /* schedule the tp worker. This way the write() call issued from
> +        * userspace can happily return and avoid to block
>          */
> -       batadv_tp_start_kthread(tp_vars);
> -
> -       /* don't return reference to new tp_vars */
> -       batadv_tp_vars_put(tp_vars);
> +       batadv_tp_start_work(tp_vars);
>  }

Just from the context of this function, it isn't clear what happened with the 
reference.

Kind regards,
	Sven
--nextPart6244887.926kjZLTdD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAluGQ68ACgkQXYcKB8Em
e0ZvXRAAla+2+3BfRSFdyhIHE27wtg/6S9b9PygztZrLkg8YNgAZKuc824NT6mCi
qJw+4uqHvjqrH8W7mr+J5shxaYJlDYMKbQiDBfiGixJUNtR3qKWHNRUKOnmejjcn
2gBGABoeOYaxQoD4BiNiwgftdYDfHFGu2YbIE9KqHHQGdJtDqnURM9HBOKc3Drf2
6d+rZeKHsy5H/qnvNVbWBTga0cfT3HzR0jqzq72pe9tlkEP32LyGCni9AO7xBvZI
xX0mX9qzfacH2NixS/8VGR03X4etydCAaSqLrQj4YnumYDfDuo4deXzUrUvRrvaU
/IIUdeEdK284zAb8UjBOj1fTB+O5HnGjBzXFw8Qa4/1caYGeuFEcCPB9FLMmd7Dk
K5hvTqsBibexN9T9G1fGvXGEd7freaOZ+VvrBmoHeTk5dSEKOlmz99Rskj+nhdTG
QsRs+ETfO+fA8JhZWsqVXtCKIXolbnuq0OwH49h8Lv4RlrzDhrGiYi2vaVnfzU6Q
Zw/IUeqF9EjTsfOCVhvVtvBepuh7lQnh9tN6THANklMMqHs/ain5dEB/JzqDbKLu
tiqLPlXdxAoqqana8VZBPX/5SXJbs/YmPs35mfR2CTwIRL9ANYVcVRhZ4MHzl+gH
FnbKCbyJ7cebe7LWtCdzrkD8RHcJ/9gCdv2KzLeBDvIL44/r5fE=
=i0p1
-----END PGP SIGNATURE-----

--nextPart6244887.926kjZLTdD--

