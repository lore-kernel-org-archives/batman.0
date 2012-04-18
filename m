Return-Path: <puyou.lu@gmail.com>
Message-ID: <4f8e5bfe.043c440a.68b1.4cde@mx.google.com>
From: "puyou.lu" <puyou.lu@gmail.com>
Date: Wed, 18 Apr 2012 14:15:19 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20120417092530.GA10402@pandem0nium>
Subject: Re: [B.A.T.M.A.N.] Problem with multi-radio,
	multi-channel in batman-adv
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
To: 'The list for a Better Approach To Mobile Ad-hoc Networking' <b.a.t.m.a.n@lists.open-mesh.org>

Hi Simon,
I have tried again, and I think the problem is caused by the same ESSID, =
as you said. I used the same ESSID on every wireless cards of every =
nodes.When I use different ESSIDs in different channel, the problem =
seems diappeared.

Another question, does the two wireless cards(wlan0 and wlan1) of one =
node have any differences in receiving and forwarding unicast and =
broadcast package? Can a gw_client node get IP address from a dhcp =
server from both wireless cards?

> -----Original Message-----
> From: b.a.t.m.a.n-bounces@lists.open-mesh.org
> [mailto:b.a.t.m.a.n-bounces@lists.open-mesh.org] On Behalf Of Simon
> Wunderlich
> Sent: Tuesday, April 17, 2012 5:26 PM
> To: The list for a Better Approach To Mobile Ad-hoc Networking
> Subject: Re: [B.A.T.M.A.N.] Problem with multi-radio, multi-channel in
> batman-adv
>=20
> Hey Puyou,
>=20
> On Mon, Apr 16, 2012 at 06:35:04PM +0800, puyou.lu wrote:
> > Hi guys.
> > =E3=80=80=E3=80=80I=E2=80=99m trying to make a for nodes WMN using =
four devices with two wireless
> cards each. I would like to use three different channels to reduce the
> interference, like this:
> > =E3=80=80=E3=80=80[Node A]  <- channel 1 ->  [Node B]  <- channel 2 =
->  [Node C]  <-
> channel 3 ->  [Node D]
> > =E3=80=80=E3=80=80First I configure eight wireless cards to the =
specific channel in ad-hoc
> mode using =E2=80=9Ciw dev wlan0 ibss join =E2=80=A6=E2=80=9D.
> > =E3=80=80=E3=80=80Then, I think I should add wlan0 and wlan1 to the =
same batman-adv
> interface (that is bat0) in every device. So I need to configure four =
nodes
> with the same commands like:
> > =E3=80=80=E3=80=80              echo bat0 > =
/sys/class/net/wlan0/batman_adv/mesh_iface
> > =E3=80=80=E3=80=80              echo bat0 > =
/sys/class/net/wlan1/batman_adv/mesh_iface
> > =E3=80=80=E3=80=80Last configure an IP address to each bat0. (Node =
A-10.0.0.1, Node
> B-10.0.0.2, Node C-10.0.0.3, Node D-10.0.0.4).
> > =E3=80=80=E3=80=80But it seem Node A can reach Node B and Node =
C(using ping), but can=E2=80=99
> t for Node D.
> >
> > =E3=80=80=E3=80=80Am I following the right procedure?
> > =E3=80=80=E3=80=80Sorry for my poor English. Any help would be =
appreciated.
>=20
> The procedure looks right in general. A few questions to debug:
>=20
>  * do you use different ESSIDs for the IBSS-networks? ad-hoc devices =
joining
> may override the configured channel
>    and select another IBSS-network instead when it has the same ESSID.
>  * have you confirmed that the WiFi connection works without =
batman-adv? just
> set up your WiFi, configure different
>    IP addresses and ping for each hop to test.
>  * does the output of "batctl originators" helps you? Are the other =
nodes
> displayed on node 4?
>=20
> Cheers,
> 	Simon

