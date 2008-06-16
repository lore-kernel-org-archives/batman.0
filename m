From: Marek Lindner <lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] Batman doesn't add default route...
Date: Tue, 17 Jun 2008 01:49:43 +0800
References: <c1004cd20806160901m70ff21d2y97830fdd128c5f75@mail.gmail.com>
In-Reply-To: <c1004cd20806160901m70ff21d2y97830fdd128c5f75@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200806170149.43572.lindner_marek@yahoo.de>
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

On Tuesday, 17. June 2008 00:01:23 thomas anderson wrote:
> The problem is that when i start batman on the client pc it doesn't add the
> default route to 192.168.9.1 infact if i add it manually with:
> route add default gw 192.168.9.1
> everything goes ok and i can surf on internet but without the manual add of
> the route i can't surf..
> Can someone help me?

All routing table entries are not shown in the default table (254) but can be 
found elsewhere. Please read: http://open-mesh.net/batman/doc/RoutingVodoo
If your internet connection still does not work, please log debug level 3 and 
watch out for errors / warnings or post them here.

Greetings,
Marek
