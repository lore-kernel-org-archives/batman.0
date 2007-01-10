Date: Wed, 10 Jan 2007 14:13:41 +0100 (MET)
From: Marek Lindner <lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] make failure
References: <45A4C4FC.5010803@ehas.org>
In-Reply-To: <45A4C4FC.5010803@ehas.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Message-Id: <200701101352.51076.lindner_marek@yahoo.de>
Content-Transfer-Encoding: quoted-printable
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


> root@Pablo:/home/pablo/Desktop/batman# make
> gcc -Wall -O0 -g3   -c -o batman.o batman.c
> batman.c: En la funci=F3n `send_outstanding_packets':
> batman.c:889: error: error sint=E1ctico before '<<' token
> batman.c:894: error: error sint=E1ctico before '>>' token

which version are you trying to compile ? From which source ?
In the current SVN this error doesn't exist. But it looks like a typical SV=
N=20
<> make problem: Did you checkout the source code more than once and altere=
d=20
your local copy ? May be you just deleted some whitespace or so ?! SVN woul=
d=20
recognize your changes and tries to merge the code.=20

This looks like that:
<<<<<<< .mine
...
=3D=3D=3D=3D=3D=3D=3D
...
>>>>>>> .r2

Try a fresh checkout from here: svn co https://dev.open-mesh.net/svn/batman/
or the stable release http://downloads.open-mesh.net/batman/batman-0.1.tgz

Regards,
Marek

