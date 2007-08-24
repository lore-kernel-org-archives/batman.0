Message-ID: <46CEB78B.7050403@saxnet.de>
Date: Fri, 24 Aug 2007 12:48:43 +0200
From: Robert Tulke <ml@saxnet.de>
MIME-Version: 1.0
Subject: Re: [B.A.T.M.A.N.] battool Speicherzugriffsfehler (update - strace/ldd
	output)
References: <46CEB292.5080201@saxnet.de>
In-Reply-To: <46CEB292.5080201@saxnet.de>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://list.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>

Robert Tulke schrieb:
> Hello i use the latest batman-advanced svn from trunk
>
> zeus:/usr/src/# svn co https://dev.open-mesh.net/svn/batman/trunk/
> ...
> ...
>
> zeus:/usr/src/# cd trunk/batman-advanced/batool
>
> zeus:/usr/src/batman-advanced/battool# make clean
> rm -f battool *.o *~
>
> zeus:/usr/src/batman-advanced/battool# make
> gcc -Wall -O0 -g   -c -o battool.o battool.c
> gcc -Wall -O0 -g   -c -o batping.o batping.c
> gcc -Wall -O0 -g   -c -o functions.o functions.c
> gcc -Wall -O0 -g   -c -o batroute.o batroute.c
> gcc -Wall -O0 -g   -c -o batdump.o batdump.c
> gcc -Wall -O0 -g   -c -o list-batman.o list-batman.c
> gcc -lpthread  battool.o batping.o functions.o batroute.o batdump.o 
> list-batman.o   -o battool
>
> <- looks good but:
>
> zeus:/usr/src/batman-advanced/battool# ./battool
> Speicherzugriffsfehler
>
> i use Debian Etch 4.0 with latest upgrades
http://paste.debian.net/35349
