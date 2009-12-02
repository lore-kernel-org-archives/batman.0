Return-Path: <gwirth79@gmail.com>
Message-ID: <4B16A46B.9020909@gmail.com>
Date: Wed, 02 Dec 2009 09:31:23 -0800
From: Gus Wirth <gwirth79@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Subject: [B.A.T.M.A.N.] batman-adv compile fails with DEBUG on
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.net

When trying to compile batman-adv revision 1489 checked out from=20
Subversion I get a failure if I activate debugging by editing the=20
appropriate line in Makefile.kbuild. The error is:

   CC [M]  /home/gus/src/batman/svn-trunk/batman-adv-kernelland/originator.o
/home/gus/src/batman/svn-trunk/batman-adv-kernelland/originator.c: In=20
function =91purge_orig_neigbours=92:
/home/gus/src/batman/svn-trunk/batman-adv-kernelland/originator.c:182:=20
error: =91orig_str=92 undeclared (first use in this function)
/home/gus/src/batman/svn-trunk/batman-adv-kernelland/originator.c:182:=20
error: (Each undeclared identifier is reported only once
/home/gus/src/batman/svn-trunk/batman-adv-kernelland/originator.c:182:=20
error: for each function it appears in.)
make[2]: ***=20
[/home/gus/src/batman/svn-trunk/batman-adv-kernelland/originator.o] Error 1
make[1]: ***=20
[_module_/home/gus/src/batman/svn-trunk/batman-adv-kernelland] Error 2
make[1]: Leaving directory `/usr/src/kernels/2.6.30.9-99.fc11.i686.PAE'
make: *** [all] Error 2

This was caused by revision 1488 and the originator.c file.

I've looked at the Trac system on the web site and it doesn't appear=20
that the ticket system gets used much, if at all. Should I also post=20
this to the Trac system or is this the right way to do this?

Gus
