From: Marek Lindner <lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] freifunk 1.6.8/1.6.9
Date: Tue, 16 Oct 2007 15:13:52 +0200
References: <20071016020242.GA4608@apoderado.ometepe.net>
In-Reply-To: <20071016020242.GA4608@apoderado.ometepe.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200710161513.52445.lindner_marek@yahoo.de>
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

> i just tried both and batmand_0.3-beta-rv674 gives a segmenation fault and
> batmand_0.2-rv502 doesn't start (probably segfault as well).
> can someone confirm/deny this?
> has someone a link for a working (with batmand)
> openwrt-g-freifunk-1.6.x-x.bin/trx ?

are you sure it segfaults or is it simply not running ? Please 
check "logread -f" to see if batmand is complaining. If you are missing the 
kmod-tun module batmand will exit and write an error to syslog.
Another option is to try the statically linked binary in case some libs 
changed recently.

Greetings,
Marek
