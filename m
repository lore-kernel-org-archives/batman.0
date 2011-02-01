Return-Path: <plettpc@gmail.com>
Message-ID: <4D479EE3.4030608@gmail.com>
Date: Tue, 01 Feb 2011 07:49:23 +0200
From: wayne <plettpc@gmail.com>
MIME-Version: 1.0
References: <201101282346.16035.clemens-john@gmx.de>	<1296323152.2725.6.camel@mytilus>	<201101291900.51081.lindner_marek@yahoo.de>
	<201101311933.01581.clemens-john@gmx.de>
In-Reply-To: <201101311933.01581.clemens-john@gmx.de>
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] Connecting through Batman advanced interface
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

Clemens John wrote:
> Am Samstag 29 Januar 2011, 19:00:50 schrieb Marek Lindner:
>> Hi,
>>
>>> I think if we don't want to change back our configuration (batman-adv on
>>> vpn with its mtu-problems etc.) the simplest way would be connecting a
>>> usual router to the wrt54g.
>> I don't think the VPN is the problem here but the fact that you can't
>> bridge an interface running in adhoc mode. Ad-hoc is "lacks" a field in
>> the wifi header which makes bridging impossible.
>> However, I agree with your proposed solution - another router connected =
to
>> the Ethernet of the wrt54g can solve the issue.
>=20
> This is not possible in this case (I don=B4t have another router).
>=20
> Is there onother (maybe harder) way or a hack to do get the same result l=
ike=20
> when bridging two interfaces? Maybe with iptables?
>=20
> Or does anyone know what the status of multiple ssid on wrt54g with kerne=
l 2.6=20
> is?
>=20
> Regards
> Clemens


IIRC, this is not a software problem, this is a limitation with the=20
hardware radio device, so I wouldnt hold my breath.

Wayne A


