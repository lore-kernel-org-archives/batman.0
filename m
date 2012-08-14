Return-Path: <nicoechaniz@codigosur.org>
Message-ID: <5029A55A.7060500@codigosur.org>
Date: Mon, 13 Aug 2012 22:09:46 -0300
From: =?ISO-8859-1?Q?Nicol=E1s_Ech=E1niz?= <nicoechaniz@codigosur.org>
MIME-Version: 1.0
References: <CAMVTf1gPjH6GiNy1fnoFCE3-qx42NBTZSgFafgTGBsaOW3tEcA@mail.gmail.com>
In-Reply-To: <CAMVTf1gPjH6GiNy1fnoFCE3-qx42NBTZSgFafgTGBsaOW3tEcA@mail.gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] Change metric and priorize links with the best
 Bandwidth
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

On 08/13/2012 08:18 PM, Esteban Municio wrote:
> Hi all
>=20
> I'm asking myself if should be possible change the actual metric(TQ)
> in batman-adv or if there is a tool to configurte it.
>=20
> We are deploying a rural mesh network where the nodes generally will
> be static in the same place, but maybe the links beetwen the nodes
> will have a unnestable bandwidth.
>=20
> So we are looking for what protocol (with any plugin) is more
> efficient for our network.
>=20
> Batman-adv have TQ like metric, but we would like that the nodes route
> the traffic priorizing the links with best bandwith available instead
> the links with best QoS. That is because finally, all the links tend
> to have ETX=3D1 at the expense of reduce de bandwidth(reducing the
> modulation and codification scheme in order to reduce looses), so the
> nodes route always for the shortest path...
>=20
> Is there any solution for this?Do you recommend us change to another
> mesh protocol(OLSR+plugin) or another "static" protocol(ej: OSPF)? It
> is possible configurate batman-adv to get the fastest route instead
> the safer?
> Or maybe I am not understanding something...Am I proposing a fool thing?

At QuintanaLibre we experimented quite a bit with this and came to the
conclusion that setting a high multicast rate is a good solution to
"force" batman to only use good (in terms of bandwidth) links.

If you set the mcast_rate high, for example (OpenWRT):

config 'wifi-iface'
	option 'device' 'radio0'
	option 'mcast_rate' '54000'

then low bandwidth routes will effectively become invisible to batman.

We are using this setup in a semi-rural network, 3.5Km wide with 15
active nodes (as of today) and it works very well.

By doing this you loose redundancy, so if you have a node with only one
high bandwidth link and that link fails, the node won't have other
routes to use. In our experience this is OK because the alternative
low-bandwidth routes that are available if mcast_rate is very low are
not of much real use.


Cheers,
NicoEch=E1niz
