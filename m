Return-Path: <fboehm@aon.at>
Message-ID: <4BC95AC1.9030109@aon.at>
Date: Sat, 17 Apr 2010 08:52:49 +0200
From: =?ISO-8859-1?Q?Franz_B=F6hm?= <fboehm@aon.at>
MIME-Version: 1.0
References: <4BC2CB9E.4050309@aon.at> <4BC8B421.9090308@gmail.com>
In-Reply-To: <4BC8B421.9090308@gmail.com>
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] Patch batman-adv for kernel 2.6.15
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

Hi Gus,

I am using Ubiquiti SDK v5.1.2 together with Nanostation M5 and Bullet=20
M5. I already thought about trying newest OpenWrt but it doesn't support=20
DFS. Ubiquiti products instead are tested to comply with european=20
regulations. Although the tests did not take brand new ETSI regulations=20
into account.

There is some binary code in the SDK like the special Atheros wireless=20
driver. I don't think it's promising to replace the kernel.

It seems like I have to do my testing with batman-adv-kernelland 0.1 for=20
a while.

Regards,
Franz


Gus Wirth schrieb:
> On 04/12/2010 12:28 AM, Franz B=F6hm wrote:
>> Hi,
>>
>> I am trying to get batman-adv (kernelland) running on Ubiquiti Networks =

>> hardware. Unfortunately the Ubiquiti SDK uses kernel 2.6.15 and=20
>> batman-adv needs at least 2.6.20. I did have some success in patching=20
>> and running batman-adv-kernelland 0.1 (r1176). I would of course prefer =

>> using batman-adv 0.2 but I do have problems implementing the older=20
>> kernel workqueue API.
>=20
> I'm doing a lot of work with Ubiquiti devices and have had great success
> with the stock OpenWrt trunk in their Bullet2HP, regular Bullet and
> MiniStation and PicoStation products. Their XR2 and XR9 cards are giving
> me problems right now, so I can't recommend them.
>=20
> Which SDK are you working with, and for which product?
>=20
> Is there any particular reason you want to use their SDK?
>=20
> It might be possible to just substitute the kernel and keep the rest of
> the SDK as is. Unless there is something tied directly to the kernel,
> that may be an easier approach.
>=20
> Gus
>=20
