From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Tue, 24 Mar 2009 20:17:47 +0100
References: <3ebdcf0a0903180743q3968e6a0wd480347cf70a50ff@mail.gmail.com>
	<200903240116.07288.lindner_marek@yahoo.de>
	<200903232305.39161.sven.eckelmann@gmx.de>
In-Reply-To: <200903232305.39161.sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart24276711.3PuZzbevd0";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200903242017.51987.sven.eckelmann@gmx.de>
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
To: b.a.t.m.a.n@open-mesh.net
Cc: Marek Lindner <lindner_marek@yahoo.de>

--nextPart24276711.3PuZzbevd0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 23 March 2009 23:05:34 Sven Eckelmann wrote:
> On Monday 23 March 2009 18:13:32 Marek Lindner wrote:
> > I downloaded the OpenWRT trunk and compiled the i386 image before loadi=
ng
> > it into a qemu environment. I can confirm that batman does nothing if
> > started without a debug level. It seems the main thread is not doing
> > anything. Interestingly, if I compile & run batman on my debian machine
> > it runs without problems. I guess OpenWRT uses some different libs /
> > compile time options / etc that provoke that problem.
>
> Seems to a different behaviour when doing a fork+pthreads_create...
> somehow. Try to remove the fork and the setgid from posix/init.c:my_daemon
> and compile it again (against uclib of course). You should notice that it
> works without any problems.
> If you do a static build against a current glibc on i386 (2.7 here) it
> works as expected.
> So I would guess a uClibc specific behaviour when calling pthread_create
> after a fork. The thread (unix_listen) itself runs without any problems b=
ut
> the main thread seems to be blocked at
>  pthread_create( &unix_if.listen_thread_id, NULL, &unix_listen, NULL );
> in posix/init.c:apply_init_args.

=46orgot to add my minimal testcase:

 #include <unistd.h>
 #include <stdio.h>
 #include <pthread.h>
=20
 void* dummy_thread(void* unused)
 {=20
 	printf("from thread\n");
=20
 	return NULL;
 }
=20
 int main(void)
 {
 	pthread_t t;
=20
 	if (fork() =3D=3D 0) {
		printf("from child\n");
 		pthread_create(&t, NULL, &dummy_thread, NULL);
 		printf("after create\n");
 	}
 	return 0;
 }

The output should be (last two lines can be swapped):
 from child
 from thread
 after create

I used the x86 toolchain from the current openwrt trunk to compile it.
 openwrt/build_dir/toolchain-i386_gcc-4.1.2_uClibc-0.9.29/gcc-4.1.2-final/g=
cc/gcc-cross fork_thread.c -static -lpthread -o fork_thread

The result was a stopping main thread at pthread_create. I did the same test
with 0.9.28.2 and 0.9.30.1
 Advanced configuration options  --->
  Toolchain Options  --->
   uClibc Version

0.9.28 worked without any problems and 0.9.30.1 without nptl showed the same
problem - the nptl version doesn't compile at the moment. So changing the
uclibc is a possible solution. Otherwise ask the openwrt developers to take
a look at the problem. Please add this example (or a similar one) and the
expected results + a list of uclibc versions which worked.

Best regards,
	Sven

--nextPart24276711.3PuZzbevd0
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAknJMdwACgkQqQGwKVlMoDsIfACfbghBLe8yJt5wjsuDJd/D3EmL
l7UAn2XHnuR2Mo7SmkZz8MmNXtX11OH/
=dwnC
-----END PGP SIGNATURE-----

--nextPart24276711.3PuZzbevd0--
