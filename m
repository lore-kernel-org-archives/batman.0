Message-ID: <54551.85.41.146.90.1190668169.squirrel@krisma.oltrelinux.com>
In-Reply-To: <200709242227.12925.lindner_marek@yahoo.de>
References: <53923.85.41.146.90.1190656836.squirrel@krisma.oltrelinux.com>
	<200709242038.29535.axel@open-mesh.net>
	<54331.85.41.146.90.1190664332.squirrel@krisma.oltrelinux.com>
	<200709242227.12925.lindner_marek@yahoo.de>
Date: Mon, 24 Sep 2007 23:09:29 +0200 (CEST)
Subject: Re: [B.A.T.M.A.N.] a strange case
From: a.anselmi@oltrelinux.com
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>

Ok Marek

At present I can't test neither send any logs or printouts :(
tomorrow morning I'll try 0.3 alpha into same scenario and feedback to you.
Thanks for tip!

ciao

Antonio

>
>> Is not a problem of ports or firewall (batman' stream flows well over
>> the
>> mesh... otherwise client node itself would not browse or would not find
>> any other originator): iI believe problem stay "in front" of mesh and
>> not
>> inside the mesh. I've two roads to walk:
>
> ok - seems logic.  :-)
>
>
>> 1) AP IP space is in HNA: maybe exists a different way of managing HNA
>> routes in gateways and in clients ? (remember that users associated with
>> gateway AP browse). It seems client node batmand daemon  (the 0.3
>> release)
>> doesn't how to manage/route packets coming from HNA - it desn't matter
>> if
>> coming from wifi conenctions or wired one but its source IP
>>
>> 2) Something of wrong in route table 65?
>
> At first: Could you check on the batman alpha branch ? I fxed the HNA
> settings
> which may be the cause of your trouble. AFAIK Axel did not merge this into
> experimental yet.
>
> Normally the packet flow would be like this: AP -> client which routes the
> traffic into the tun device. Batman 0.3 has a "default route protection"
> which disallows other mesh users to access the tunnel. All other
> interfaces
> should be routed through the tunnel. Could you send us your routing tables
> (as Axel already suggested) ?
>
> Regards,
> Marek
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n
>


