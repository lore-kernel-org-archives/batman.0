Message-ID: <480E35DC.801@gmx.net>
Date: Tue, 22 Apr 2008 21:00:44 +0200
From: elektra <onelektra@gmx.net>
MIME-Version: 1.0
Subject: Re: [B.A.T.M.A.N.] Who can help with BATMAN-ADV integration into
	ROBIN-FW?
References: <003a01c894a2$8f7ebe00$ae7c3a00$@com>	<20080403133445.GA29070@hrz.tu-chemnitz.de>	<001001c8959b$2596d2d0$70c47870$@com>
	<47F6072D.2050503@gmx.net>	<1768846515.20080405222610@pyro.de>
	<bccbc6690804220924w3af5cffeqbdc9a122b7840537@mail.gmail.com>
In-Reply-To: <bccbc6690804220924w3af5cffeqbdc9a122b7840537@mail.gmail.com>
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
Content-Transfer-Encoding: quoted-printable
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

Hi Max -

this is solely a issue of malfunctioning drivers/ WiFi cards in ad-hoc=20
mode. The proprietary Broadcom driver for 2.4 Linux kernels shipped with=20
devices like Linksys WRT54GL, Buffalo WHR-G54S, Asus WL500GP works=20
flawlessly.

The Madwifi driver for Atheros cards works but still has issues that=20
developers are working on. The best working Madwifi driver seems to come=20
with OpenWRT.

This is basically what works at the moment. Most Intel drivers have=20
issues (there are firmware issues as well, as I have experienced with=20
IPW2200). IPW2100 seems to work, IPW3945 works more or less with some=20
tricks (and occasional firmware errors).

Marvel drivers are nowadays shipped with the Linux kernel, but because I=20
lack Marvell hardware I couldn't test it in ad-hoc mode.

In general the ad-hoc mode has been widely neglected by manufacturers=20
and developers. From the first day I started to work on mesh networks I=20
have been battling with firmware/driver issues. But as more and more=20
people start using mesh networks the demand for working drivers is=20
increasing. So we can expect that - finally, after many years - the=20
situation will improve quickly.

cu elektra


> hi
>
> will it be some day technically possible to use the marvel wifi chip=20
> of the laptop to join the mesh network or is always a router needed?
>
> Why can=B4t that drawn to the laptops with a software solution ?
>
> Max
> ------------------------------------------------------------------------
>
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n
>  =20

