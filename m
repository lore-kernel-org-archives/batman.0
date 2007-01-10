Message-ID: <45A4C4FC.5010803@ehas.org>
Date: Wed, 10 Jan 2007 11:50:36 +0100
From: Pablo Osuna <posuna@ehas.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Subject: [B.A.T.M.A.N.] make failure
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://list.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: b.a.t.m.a.n@open-mesh.net

Hi,

We are having a problem with the first release of B.A.T.M.A.N. When we=20
try to compile it (trying both gcc-3.4 and 4.0), we got the following=20
error:

root@Pablo:/home/pablo/Desktop/batman# make
gcc -Wall -O0 -g3   -c -o batman.o batman.c
batman.c: En la funci=F3n `send_outstanding_packets':
batman.c:889: error: error sint=E1ctico before '<<' token
batman.c:891: error: error sint=E1ctico before ')' token
batman.c:894: error: error sint=E1ctico before '>>' token
batman.c:896: error: error sint=E1ctico before ')' token
batman.c:891: aviso: statement with no effect
batman.c:896: aviso: statement with no effect
batman.c: En el nivel principal:
batman.c:927: error: error sint=E1ctico before '}' token
make: *** [batman.o] Error 1

We are using Ubuntu distro.

Regards:

Pablo
