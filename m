In-Reply-To: <200710091450.50135.axel@open-mesh.net>
References: <20070608201844.GM20739@localhost>
	<200710090953.43820.axel@open-mesh.net> <470B45AE.40502@poelzi.org>
	<200710091450.50135.axel@open-mesh.net>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <00C3015B-8933-42C5-975D-22FE7DCF83AF@lo-res.org>
Content-Transfer-Encoding: 7bit
From: Aaron Kaplan <aaron@lo-res.org>
Subject: Re: [B.A.T.M.A.N.] Texas UML instances and OLSR+BATMAN tests
Date: Tue, 9 Oct 2007 16:23:23 +0200
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
Cc: Petrovitsch Bernd <bernd@firmix.at>


Just yesterday I had a brief talk with Herbert from vserver. He  
mentioned that it should be ok to use different routing tables in  
each vserver instance. If this works out then I would like to know if  
vserver is a viable alternative. Vserver is very low overhead. One of  
the problems that I had with UML is the high (soft-)IRQ load.
this produces permanent context switches and no work gets done. (if  
you start 1000 instances that is!) :)

Can somebody test what happens if you start many instances in openVZ  
and vserver?
I hope our dev server is up and living soon again.

best,
a.



On Oct 9, 2007, at 2:50 PM, Axel Neumann wrote:

> Hello,
>
>> in openvz usuall all ebtables and iptables modules are supported  
>> in the
>> 0 instance. modules that can be used inside of virtuall instances  
>> have
>> to be prepared for this. but this shouldn't be a problem for your  
>> setup,
>> so i guess the problem may be somewhere else.
>
> As fare as I remember there have been some promlems with the  
> development
> versions of openVZ. With the stable version for kernel 2.6.18  
> everything
> worked fine.
> Except, the ebtables module oopsed when applying more than 25  
> rules !! Because
> I wanted to configure virtual networks with up to 100 nodes this was a
> problem. The mentioned patch solved this problem.
>
> ciao
> /axel
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n
>

---
there's no place like 127.0.0.1



