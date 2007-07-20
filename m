From: Marek Lindner <lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] TTL-Interface specific
Date: Fri, 20 Jul 2007 22:56:27 +0200
References: <20070720172531.tjq2at48zqo048sk@webmail.ddmesh.de>
In-Reply-To: <20070720172531.tjq2at48zqo048sk@webmail.ddmesh.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200707202256.27470.lindner_marek@yahoo.de>
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


Hi,


> Questions 2:
>   batman on mipsel runs in three instances independed of number of
> interfaces listen. on i386 only one instance is running (three
> interfaces). How does this work?

the words "instances" means threads. I guess you found that word on the batman 
freifunk gui ?! It is a bit misleading.
Batman is a threaded application. Several tasks are done by different threads. 
OpenWRT (Whiterussian) has no good thread implementation - so called 
LinuxThreads. They emulate thread behaviour via processes. Thats why you see 
so many. 
However, this library is deprecated and a newer (NPTL) is in widely use today 
but requires Linux Kernel 2.6. This is a real thread implementation where you 
have only one process. I guess that you use this lib on your i386 ?!

Regards,
Marek
