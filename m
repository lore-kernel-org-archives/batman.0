Return-Path: <batman@kevinsteen.net>
Message-ID: <4D47E5A4.2020005@kevinsteen.net>
Date: Tue, 01 Feb 2011 10:51:16 +0000
From: Kevin Steen <batman@kevinsteen.net>
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

On 31/01/11 18:32, Clemens John wrote:
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
> This is not possible in this case (I don=B4t have another router).
>
> Is there onother (maybe harder) way or a hack to do get the same result l=
ike
> when bridging two interfaces? Maybe with iptables?
>
> Or does anyone know what the status of multiple ssid on wrt54g with kerne=
l 2.6
> is?
>
> Regards
> Clemens
If your non-batman clients don't need incoming connections, you could=20
NAT outgoing connections :
   [client]-->[adhoc ath1]-->NAT-->[br-mesh]
You would have to run a DHCP server on the ath1 interface to give those=20
clients a private IP and tell them to use the private IP on ath1 as=20
their router.

-Kevin

---
Have a vacancy for a Network Engineer/IT guy in London, UK? Please let me k=
now.

