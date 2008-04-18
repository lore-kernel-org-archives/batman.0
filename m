From: Marek Lindner <lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] Node keeps switching back and forth
Date: Fri, 18 Apr 2008 14:48:44 +0800
References: <7BE4D55B-B938-45A8-BCF4-923632152CFC@philippeapril.com>
	<854CEDF6-8307-4BB8-AFD0-EAC208163FE3@gmail.com>
	<B0598FDC-F54D-4D67-BEE2-670F6BD8A064@philippeapril.com>
In-Reply-To: <B0598FDC-F54D-4D67-BEE2-670F6BD8A064@philippeapril.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200804181448.44510.lindner_marek@yahoo.de>
Sender: techsupport@kietzfuerkids.de
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

> I tried the RO.B.IN firmware on 4 nodes and the symptoms are the same,
> it's basically unusable.

when did you try this ? I helped them to fix some of these problems, so I know 
it should be quite stable now.


> Does anybody have a great success story to tell me with this hardware
> (FON/Accton with Atheros) and mesh networks? B.A.T.M.A.N seems to be
> the only thing stable in my setup after all :)

There are a bunch of thing you should pay attention to. the last item which 
made Robin much more stable was:

iwconfig ath0 rate 5.5M

Try this.

Greetings,
Marek
