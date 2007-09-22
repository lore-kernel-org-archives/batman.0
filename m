Message-ID: <43989.85.41.146.90.1190484004.squirrel@krisma.oltrelinux.com>
In-Reply-To: <200709221903.39304.lindner_marek@yahoo.de>
References: <43619.85.41.146.90.1190473783.squirrel@krisma.oltrelinux.com>
	<200709221903.39304.lindner_marek@yahoo.de>
Date: Sat, 22 Sep 2007 20:00:04 +0200 (CEST)
Subject: Re: [B.A.T.M.A.N.] 0.3 alpha (today revison)
From: a.anselmi@oltrelinux.com
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Reply-To: Antonio <Anselmi@krisma.oltrelinux.com>,
	The list for a Better Approach To Mobile Ad-hoc Networking
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

great work Marek,
now client can ping outside mesh obtaining the correct IP from gateway.
Thanks!

Still remain the minor problem in arrangement of IPIPA subnet mask:
169.254.0.0/16 on clients
169.254.0.0/24 on gateway

Have a fine weekend


--
Antonio


space (line 2-log_gateway): suffix
> Hi,
>
>> since you use mipsel device I think these mips log could be of more help
>> in fixing mips/mipsel bug in 0.3 branches (alpha and experimental).
>
>> Hopeing this will be usefull... I know today weekend begins :)
>
> thanks a lot for your thorough description - it did help.  :-)
> Since the weekend is shorter than one might think I already issued a
> patch. It
> should work now but due to the lack of Big Endian CPUs I can't test it. I
> would be happy if you checked on that. After you confirmed the end of this
> bug I will fix the experimental branch as well.
>
> Regards,
> Marek
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n
>


