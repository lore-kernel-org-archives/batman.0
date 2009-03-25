From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 25 Mar 2009 10:44:01 +0800
References: <3ebdcf0a0903180743q3968e6a0wd480347cf70a50ff@mail.gmail.com>
	<200903232305.39161.sven.eckelmann@gmx.de>
	<200903242017.51987.sven.eckelmann@gmx.de>
In-Reply-To: <200903242017.51987.sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200903251044.05666.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] Problem with B.A.T.M.A.N. 0.3.1 rv1206
	(compatibility version 5)
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>

On Wednesday 25 March 2009 03:17:47 Sven Eckelmann wrote:
> 0.9.28 worked without any problems and 0.9.30.1 without nptl showed the
> same problem - the nptl version doesn't compile at the moment. So changing
> the uclibc is a possible solution. Otherwise ask the openwrt developers to
> take a look at the problem. Please add this example (or a similar one) and
> the expected results + a list of uclibc versions which worked.

Thanks a lot for sharing your test results. I suspected ulibc to be the 
culprit as we had trouble with fork() and pthread_create() before. Actually, 
thats the reason why batman has its own daemonize function. It seems they 
still have trouble with it.

I'll try to get in touch with some OpenWRT developers to see what can be done.

Regards,
Marek

