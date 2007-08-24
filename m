Message-ID: <46CEBB7E.4020809@q-dsl.de>
Date: Fri, 24 Aug 2007 13:05:34 +0200
From: Andreas Langer <a.langer@q-dsl.de>
MIME-Version: 1.0
Subject: Re: [B.A.T.M.A.N.] battool Speicherzugriffsfehler (update - strace/ldd
	output)
References: <46CEB292.5080201@saxnet.de> <46CEB78B.7050403@saxnet.de>
In-Reply-To: <46CEB78B.7050403@saxnet.de>
Content-Type: text/plain; charset=ISO-8859-15
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

hello robert, sorry i forgot an usage message when you run battool
without an argument.
please use battool -h too see how you use this tool.
i will fix this soon. thx


Robert Tulke wrote:
> Robert Tulke schrieb:
>> Hello i use the latest batman-advanced svn from trunk
>>
>> zeus:/usr/src/# svn co https://dev.open-mesh.net/svn/batman/trunk/
>> ...
>> ...
>>
>> zeus:/usr/src/# cd trunk/batman-advanced/batool
>>
>> zeus:/usr/src/batman-advanced/battool# make clean
>> rm -f battool *.o *~
>>
>> zeus:/usr/src/batman-advanced/battool# make
>> gcc -Wall -O0 -g   -c -o battool.o battool.c
>> gcc -Wall -O0 -g   -c -o batping.o batping.c
>> gcc -Wall -O0 -g   -c -o functions.o functions.c
>> gcc -Wall -O0 -g   -c -o batroute.o batroute.c
>> gcc -Wall -O0 -g   -c -o batdump.o batdump.c
>> gcc -Wall -O0 -g   -c -o list-batman.o list-batman.c
>> gcc -lpthread  battool.o batping.o functions.o batroute.o batdump.o
>> list-batman.o   -o battool
>>
>> <- looks good but:
>>
>> zeus:/usr/src/batman-advanced/battool# ./battool
>> Speicherzugriffsfehler
>>
>> i use Debian Etch 4.0 with latest upgrades
> http://paste.debian.net/35349
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n
>

