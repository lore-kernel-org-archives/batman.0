From: Marek Lindner <lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] faulty dev-batman-adv.ipk
Date: Fri, 14 Mar 2008 06:53:18 +0800
References: <1205401123.47d8f6235d1ae@mail.bluebottle.com>
	<47D93815.9070307@leipzig.freifunk.net>
In-Reply-To: <47D93815.9070307@leipzig.freifunk.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200803140653.18350.lindner_marek@yahoo.de>
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

> with or without leading "./" - its always the same _relative_ path, i
> think...

I agree.


> The files are on the box, but the manager thinks "not fully installed"

Why do you think so ?


> and an "ipkg files batman-adv" leads to zero output.

As far as I remember, the ipkg command is pretty dumb. It does not parse 
packets but only the packet database which can be updated with "ipkg update". 
But these packages are not included in a repos - it is just a plain install. 
So, the ipkg command can't help you here or am I mistaken ?

Greetings,
Marek
