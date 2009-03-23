From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Mon, 23 Mar 2009 23:05:34 +0100
References: <3ebdcf0a0903180743q3968e6a0wd480347cf70a50ff@mail.gmail.com>
	<3ebdcf0a0903210607v5346dfbn7bb2e1f5bce854b4@mail.gmail.com>
	<200903240116.07288.lindner_marek@yahoo.de>
In-Reply-To: <200903240116.07288.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2137909.ZCei7GYSxD";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200903232305.39161.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] Problem with B.A.T.M.A.N. 0.3.1 rv1206
	(compatibility version 5)
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>
Cc: Marek Lindner <lindner_marek@yahoo.de>

--nextPart2137909.ZCei7GYSxD
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 23 March 2009 18:13:32 Marek Lindner wrote:
> I downloaded the OpenWRT trunk and compiled the i386 image before loading
> it into a qemu environment. I can confirm that batman does nothing if
> started without a debug level. It seems the main thread is not doing
> anything. Interestingly, if I compile & run batman on my debian machine it
> runs without problems. I guess OpenWRT uses some different libs / compile
> time options / etc that provoke that problem.
Seems to a different behaviour when doing a fork+pthreads_create... somehow=
=2E=20
Try to remove the fork and the setgid from posix/init.c:my_daemon and compi=
le=20
it again (against uclib of course). You should notice that it works without=
=20
any problems.
If you do a static build against a current glibc on i386 (2.7 here) it work=
s=20
as expected.
So I would guess a uClibc specific behaviour when calling pthread_create af=
ter=20
a fork. The thread (unix_listen) itself runs without any problems but the m=
ain=20
thread seems to be blocked at
 pthread_create( &unix_if.listen_thread_id, NULL, &unix_listen, NULL );
in posix/init.c:apply_init_args.

Please read http://www.mail-archive.com/uclibc@uclibc.org/msg00357.html for=
=20
some hints.

Best regards,
	Sven

--nextPart2137909.ZCei7GYSxD
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAknIB68ACgkQqQGwKVlMoDsbeQCg534FtTr4VT+SStLd1eiImJob
N4wAn2xZcKikcli7vINzX+lT/rxvOYAQ
=r2lq
-----END PGP SIGNATURE-----

--nextPart2137909.ZCei7GYSxD--
