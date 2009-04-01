From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Wed, 1 Apr 2009 12:28:56 +0200
References: <200903251044.05666.lindner_marek@yahoo.de>
	<1238072366-8109-1-git-send-email-sven.eckelmann@gmx.de>
	<200904010226.08922.lindner_marek@yahoo.de>
In-Reply-To: <200904010226.08922.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1287199.YB229IngTK";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200904011229.01236.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] Don't detach batmand to background by
	default
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

--nextPart1287199.YB229IngTK
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tuesday 31 March 2009 20:26:08 Marek Lindner wrote:
> thanks a lot for addressing this issue by sending your patch. Although I'm
> not too happy about the chosen approach. Changing the default behaviour a=
nd
> adding a new command line option seems not to be the best solution. Do you
> think we can put this exec call into batman itself and thus hiding this
> ulibc thread disaster ?
=46irst thing is that you have to add a option to disable the fork to the=20
background. Otherwise all batmand execs will again fork to the background a=
nd=20
exec again a batmand. Then there is the issue of finding the right executab=
le=20
to execute. The argv[0] approach isn't ideal since there must not be any=20
connections to the real executable. Take for example this small snipped:

 #include <unistd.h>
 int main()
 {
 	char* const argv[] =3D {"/fake", NULL};
 	execv("/bin/sh", argv);
 	return 0;
 }

Make a `echo $0` in a normal shell and one in the shell started by this=20
program. An approach to start a program again is to use start the program=20
again over /proc/self/exe. This can fail due to different reasons. First on=
e=20
is that there is no proc filesystem mounted. Second one is that there is th=
at=20
the file which was used to start the program was moved to another location =
(or=20
deleted). Maybe there are other ways I don't know, but please don't suggest=
=20
fexecve since this is even less POSIX and takes a similar approach, but=20
involves more 'guessing' since you first have to open a file to get the=20
correct fd.
Under (Free)BSD you will have to find a similar approach since it doesn't h=
ave=20
/proc/self/exe unless you mounted linprocfs.

As you can see the real problem is the association between the process and=
=20
it's executable you need to execute batmand again. I will post a proof-of-
concept patch to show this approach. Be prepared that it eats your pets and=
=20
converts wine into water. I cannot test the patches again the current openw=
rt=20
trunk since https://svn.openwrt.org/openwrt/trunk is broken at the moment.

Regards,
	Sven

--nextPart1287199.YB229IngTK
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAknTQekACgkQqQGwKVlMoDumbwCg+/wsBO7DcpKwo1LvafKO/yGZ
3LUAoJSSHf+HZnpQJd8BKq8eymnCjJk0
=866l
-----END PGP SIGNATURE-----

--nextPart1287199.YB229IngTK--
