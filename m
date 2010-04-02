Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sat, 3 Apr 2010 00:08:21 +0800
References: <201004021744.01077.clemens-john@gmx.de>
In-Reply-To: <201004021744.01077.clemens-john@gmx.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201004030008.21717.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] Batman Advanced Internet Gateway
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

> We are testing Batman Advanced as described in my other thread and I want
>  to share my Internetconnection on our network. How do I do this with
>  Batman Advanced?
>=20
> Is there already a working Batman Advanced version that supports Internet
> connection sharing (Maybe Trunk? Which revision?)?
> In Olsr there was the dyn_gateway_plugin. How can I have something like
>  it=B4s functionality in Batman Advanced?

I'm not familiar with the dyn_gateway_plugin plugin - what is it good for ?

The "advanced gateway handling" tries to deal with multiple gateways in the=
=20
same mesh network in a smart way. AFAIK olsrd never had this functionality,=
 so=20
it is unlikely that you will miss it.  :-)

As soon as your router has an internet connection and "shares" it (firewall=
,=20
NAT, etc) everybody will be able to use it. You can do this with all batman-
adv versions out there - no need to go to the trunk.

Regards,
Marek
