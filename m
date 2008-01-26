Message-ID: <20080126220430.7z7w3ddfkwkos0s0@webmail.ddmesh.de>
Date: Sat, 26 Jan 2008 22:04:30 +0100
From: Freifunk Dresden <freifunk@ddmesh.de>
Subject: Re: [B.A.T.M.A.N.] Memory leak
References: <20080104105751.q5lswookggc040gk@webmail.ddmesh.de>
	<200801042124.18425.axel@open-mesh.net>
	<20080117140452.sf4w0jir48sgwsw0@webmail.ddmesh.de>
	<200801201213.19923.axel@open-mesh.net>
In-Reply-To: <200801201213.19923.axel@open-mesh.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1;
	DelSp="Yes";
	format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
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
To: b.a.t.m.a.n@open-mesh.net

Hi,

I have checked the revision 966 and the memory leak is gone.
calling batmand -c -r3 creates a task and the memory size is set
to 1164. After calling batmand -c -r0 the size is back to 1148.
I can repeat these calles and all looks fine.

/Stephan


Zitat von Axel Neumann <axel@open-mesh.net>:

> Hi,
>
> can you check if the problem is fixed with rv 957.
>
> regards,
> axel
>
> On Donnerstag 17 Januar 2008, Freifunk Dresden wrote:
>> Hi,
>>
>> has anyone could verify the memory-leak problem (see previous thread).
>> I'm currently use the -one-way-tunnel which does not destroy/recreate
>> the gw thread that is causing the memory consumtion.
>>
>> jfi: the system is whiterussian rc6, busybox 1.7.2/1.8.2, uclibc 0.27.
>> I still couldn't get uclibc 29 running to check if this causes the problem.
>> Can somebody check this or first verify the problem?
>>
>> /Stephan
>> _______________________________________________
>> B.A.T.M.A.N mailing list
>> B.A.T.M.A.N@open-mesh.net
>> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n
>
>
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n
>



