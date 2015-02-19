Return-Path: <APape@phoenixcontact.com>
In-Reply-To: <1485649.labZ4ZGvMV@voltaire>
References: <OF6F534CD3.B9570448-ONC1257DF0.00289AC2-C1257DF0.0029BB69@phoenixcontact.com>
 <1549090.s6anOn0kWk@voltaire>
 <OF7D539C0F.7F2029AA-ONC1257DF1.002DB2B5-C1257DF1.002ECBFC@phoenixcontact.com>
 <1485649.labZ4ZGvMV@voltaire>
MIME-Version: 1.0
From: Andreas Pape <APape@phoenixcontact.com>
Message-ID: <OFA96D7726.B38F8A68-ONC1257DF1.0038B77B-C1257DF1.003988B0@phoenixcontact.com>
Date: Thu, 19 Feb 2015 11:28:24 +0100
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: [B.A.T.M.A.N.] Antwort: Re: Antwort: Re: Antwort: Antwort: Re:
	Antwort: Re:	Question concerning batman-adv bug #173 "Mesh
	packets on bat0"
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

I started with a freshly unpacked source code of the 2014.4.0 release and=20
applied only  your latest patch.=20

As expected from the tests done so far with the old kernel effectively not =

calling netdev=5Fset=5Fmaster allows the usage of the latest batman-adv=20
version in combination with older kernels (at least the 2.6.32 I tested=20
with).

I think this patch is worth to be integrated into the next batman-adv=20
version.

Regards,
Andreas


"B.A.T.M.A.N" <b.a.t.m.a.n-bounces@lists.open-mesh.org> schrieb am=20
19.02.2015 10:40:34:

> Von: Marek Lindner <mareklindner@neomailbox.ch>
> An: The list for a Better Approach To Mobile Ad-hoc Networking=20
> <b.a.t.m.a.n@lists.open-mesh.org>,=20
> Datum: 19.02.2015 10:42
> Betreff: Re: [B.A.T.M.A.N.] Antwort: Re: Antwort: Antwort: Re:=20
> Antwort: Re: Question concerning batman-adv bug #173 "Mesh packets on=20
bat0"
> Gesendet von: "B.A.T.M.A.N" <b.a.t.m.a.n-bounces@lists.open-mesh.org>
>=20
> On Thursday, February 19, 2015 09:31:08 Andreas Pape wrote:
> > the problem seems to be a little bit more complex. Your latest patch=20
does=20
> > not solve the problem.
> >=20
> > But I found out, that commenting out the following line in your patch=20
> > makes bat0 work:
> >=20
> > slave->master =3D master;
> >=20
> > But as this is the core of "enslaving" a device to a master device,=20
this=20
> > breaks the complete concept behind this I guess (I'm not a skilled=20
kernel=20
> > developer). From this I conclude that there might be a bug somewhere=20
> > deeper in the kernel version I use.  I don't want to give up too=20
early,=20
> > but it looks a little bit as if this "enslaving concept using rtnl"=20
might=20
> > not be usable in these older kernels. What do you think?
>=20
> Please try the attached patch instead. This time we are replacing=20
> the function=20
> with our own function doing nothing at all. The net=5Fdev->master=20
> variable seems=20
> to be reserved for interface bonding and shouldn't be touched at allon=20
these=20
> ancient kernels.
>=20
> Cheers,
> Marek
> [Anhang "0001-batman-adv-ignore-netdev=5Fset=5Fmaster-calls-on-
> kernels.patch" gel=F6scht von Andreas Pape/Phoenix Contact] [Anhang=20
> "signature.asc" gel=F6scht von Andreas Pape/Phoenix Contact]=20
