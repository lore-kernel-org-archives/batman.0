Return-Path: <David.Laight@ACULAB.COM>
From: David Laight <David.Laight@ACULAB.COM>
Date: Mon, 30 Jan 2017 12:07:19 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6DB0273A88@AcuExch.aculab.com>
References: <20170128105651.3061-1-sw@simonwunderlich.de>
 <20170128105651.3061-2-sw@simonwunderlich.de>
In-Reply-To: <20170128105651.3061-2-sw@simonwunderlich.de>
Content-Language: en-US
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: Fix double call of
	dev_queue_xmit
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: 'Simon Wunderlich' <sw@simonwunderlich.de>, "davem@davemloft.net" <davem@davemloft.net>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "b.a.t.m.a.n@lists.open-mesh.org" <b.a.t.m.a.n@lists.open-mesh.org>

From: Simon Wunderlich
> Sent: 28 January 2017 10:57
> From: Sven Eckelmann <sven@narfation.org>
>=20
> The net_xmit_eval has side effects because it is not making sure that e
> isn't evaluated twice.
>=20
>     #define net_xmit_eval(e)        ((e) =3D=3D NET_XMIT_CN ? 0 : (e))

It is probably worth fixing the #define.

	David

