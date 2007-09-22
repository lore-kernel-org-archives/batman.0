From: Marek Lindner <lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] 0.3 alpha (today revison)
Date: Sat, 22 Sep 2007 19:03:38 +0200
References: <43619.85.41.146.90.1190473783.squirrel@krisma.oltrelinux.com>
In-Reply-To: <43619.85.41.146.90.1190473783.squirrel@krisma.oltrelinux.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200709221903.39304.lindner_marek@yahoo.de>
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

> since you use mipsel device I think these mips log could be of more help
> in fixing mips/mipsel bug in 0.3 branches (alpha and experimental).

> Hopeing this will be usefull... I know today weekend begins :)

thanks a lot for your thorough description - it did help.  :-)
Since the weekend is shorter than one might think I already issued a patch. It 
should work now but due to the lack of Big Endian CPUs I can't test it. I 
would be happy if you checked on that. After you confirmed the end of this 
bug I will fix the experimental branch as well.

Regards,
Marek
