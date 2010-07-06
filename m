Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 6 Jul 2010 22:15:45 +0200
References: <201007061948.05784.clemens-john@gmx.de>
In-Reply-To: <201007061948.05784.clemens-john@gmx.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201007062215.45412.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] Batman advanced and internet gateways
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


Hi,

> I know I asked this question some time ago but I didn=B4t got it till now=
 so
> I have to ask again.

some mails get lost in this stream, so just keep bothering us until you hav=
e=20
your answers. :)


> How can I do this automatically and how can I automatically choose the be=
st
> gateway for my client? I know that Batman advanced does not do this for n=
ow
> but I already saw something that sounded like made for this in the trunk
> version and on the manpage of batctl. The function is called gw_mode.

Yes, there is such a functionality. The online manpage shows the version of=
=20
the trunk.


> *How do you this?
> *What do you recommend for this task?
> *What=B4s about the funktion in trunk? Is the function made for this?

It requires each gateway to have a DHCP server running. The clients will=20
select their gateway and relay the dhcp requests via unicast to the selecte=
d=20
gateway only.
You only need to activate the gateway / client mode and have a dhcp server=
=20
running.=20


> **If so why do you mix Layer 2 and Layer 3 now?

If you don't want to mix layer2 / layer3 then just don't use this feature. =
It=20
is disabled per default.
If you have a better idea how to handle multiple gateways in a layer2 mesh =
we=20
are very open to your suggestions. :)


> **When do you think this function will be in the stable release?

Unfortunately, we did not get around finishing it to the point that we feel=
=20
comfortable with releasing this feature. I think the trunk is quite stable =
but=20
still lacks some things. E.g. blacklisting / whitelisting gateways, IPv6, e=
tc.=20

Regards,
Marek

