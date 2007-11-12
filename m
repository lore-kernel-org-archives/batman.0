Message-ID: <2bda28cd0711112357m4864bfb1wbeec080916bd95c1@mail.gmail.com>
Date: Mon, 12 Nov 2007 08:57:40 +0100
From: "Stefano Scipioni" <stefano@one-b.it>
Sender: scipio.it@gmail.com
Subject: Re: [B.A.T.M.A.N.] vis and batman-exp (rv780-792)
In-Reply-To: <000401c824b2$ff271870$fd754950$@com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200711111816.18242.axel@open-mesh.net>
	<840E3F681DF3D043B353C0FDD4A6C353ABFC97@ex9.hostedexchange.local>
	<000401c824b2$ff271870$fd754950$@com>
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
To: pele@balorda.com, The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>

2007/11/11, Predrag Balorda <predrag.balorda@gmail.com>:
> Does batman-exp work with vis (B.A.T.M.A.N. visualisation server 0.3-beta)?
> I don't seem to be getting any topology info but batman beta 0.3 was working
> with the same setup.
>
> Pele


I changed in vis.h:
#define VIS_COMPAT_VERSION 21

Stefano
