Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 3 Jan 2013 23:14:22 +0800
References: <B9683C50-CBE6-40F6-B084-187E41B04CE4@stephan.homeunix.net>
 <201301032258.15573.lindner_marek@yahoo.de>
 <82C77F63-2AB3-4AEB-A86A-23B3488E6C51@stephan.homeunix.net>
In-Reply-To: <82C77F63-2AB3-4AEB-A86A-23B3488E6C51@stephan.homeunix.net>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201301032314.22606.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] Unterstanding gateway-mode - why do nodes have a
	"sticky" gateway
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

On Thursday, January 03, 2013 23:01:07 Jan L=FChr wrote:
> > Ah! You failed to mention this part in your initial email.
> >=20
> > The behavior is easily explained: batman-adv does not switch gateway
> > whenever a new gateway is found (even if it is a better gateway) unless
> > the selection class is on fast or late switching.
>=20
> It is. - Sorry, forgot to mention:
> Freifunk-b0487acb2d58:~# batctl gw_mode
> client (selection class: 1)
>=20
> =3D> 1 -> fast connection consider the gateway's advertised  throughput as
> well as the link quality towards the gateway

You did mention you were using selection class 1. I was referring to your t=
est=20
in which you turn on/off your best gateway. As I explained in my previous=20
mail: batman-adv does not switch the gateway once it has chosen a gateway=20
unless you select fast or late switching as selection class. Selection clas=
s 1=20
does not fall into this category which means a gateway reselection only=20
happens if the currently selected gateway disappears.

Run the foloowing test: enable both gateways before setting the gateway cli=
ent=20
to selection class 1. The gateway announcing the higher bandwidth should be=
=20
selected.

Cheers,
Marek
