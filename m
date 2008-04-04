Message-ID: <47F6072D.2050503@gmx.net>
Date: Fri, 04 Apr 2008 12:47:09 +0200
From: elektra <onelektra@gmx.net>
MIME-Version: 1.0
Subject: Re: [B.A.T.M.A.N.] Node with two wireless interfaces - to bridge
	them	or not?
References: <003a01c894a2$8f7ebe00$ae7c3a00$@com>	<20080403133445.GA29070@hrz.tu-chemnitz.de>
	<001001c8959b$2596d2d0$70c47870$@com>
In-Reply-To: <001001c8959b$2596d2d0$70c47870$@com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

Hi -

Fragmentation is broken in current Madwifi. Every packet bigger than the 
fragmentation value will not be send. This is bad, because fragmentation 
is pretty important for smooth data transfers.

Another notorious problem is IBSS cell-splitting, you can fix that by using

iwconfig athX ap 02:CA:FF:EE:BA:BE (or whatever cell-id you wish)

Also it is recommended to select the ministrel rate adaption mechanism 
when loading the driver.

Try a recent Madwifi version from  OpenWRT Kamikaze (i.e. get the 
OpenWRT patches and apply them to the Madwifi version used in OpenWRT).

cu elektra
