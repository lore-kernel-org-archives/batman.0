From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sat, 13 Sep 2008 00:03:57 +0800
References: <20080912145945.GA27083@sven-desktop.lazhur.ath.cx>
In-Reply-To: <20080912145945.GA27083@sven-desktop.lazhur.ath.cx>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200809130003.57939.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] Don't validate hardware address of batgat
	gate0 device
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

On Friday, 12. September 2008 22:59:45 Sven Eckelmann wrote:
> linux v2.6.24-rc1-1-gbada339 introduces a check for valid ethernet mac
> address. We don't have such a valid one because it is just a virtual
> gateway device which doesn't need such thing. To disable the
> eth_validate_addr check we can override the function pointer inside the
> netdevice structure or just setting it to NULL to disable it at all.

I applied that one as well. Hope you also get some sleep while you are not 
sending patches.  :-)

Greetings,
Marek
