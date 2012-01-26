Return-Path: <andre_mailinglist@net-forces.com>
Content-Type: text/plain; charset=iso-8859-1
Mime-Version: 1.0 (Apple Message framework v1251.1)
From: Andre Courchesne <andre_mailinglist@net-forces.com>
In-Reply-To: <201201270336.09947.lindner_marek@yahoo.de>
Date: Thu, 26 Jan 2012 15:08:40 -0500
Content-Transfer-Encoding: quoted-printable
Message-Id: <6B4D2168-14EC-4E8C-8260-8479F94DEB45@net-forces.com>
References: <110B6C33195F5F4790292BDD9E7DED401AB93E918F@VA3DIAXVS371.RED001.local>
	<201201270336.09947.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] Disconnecting the nodes in batman-adv
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

Ok, disabling loop avoidance has no effect.

Has ap_isolation been tested in this type of scenario?

On 2012-01-26, at 2:36 PM, Marek Lindner wrote:

> On Monday, January 23, 2012 22:55:09 Bouterse, Robert wrote:
>> My attempts to use the hop_penalty failed, since I do not have =
control over
>> the RF environment. So, I am resurrecting an old thread to find out =
if
>> this is possible :
>> =
https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2011-July/005058.html
>>=20
>> The state of the thread seems to have ended with the idea of wrapping =
a
>> wlan0 interface in a bridge, and then adding the bridge to a =
batman-adv
>> network. This worked (apparently) with batman-adv over ethernet, but =
will
>> not work over 802.11 because the kernel specifically prevents the =
bridge
>> from being created,
>> http://lists.shmoo.com/pipermail/hostap/2010-January/020959.html
>>=20
>> There is some mention that batman-adv has ebtables support.
>>=20
>> How can I get at that, to do what the people in the thread, were =
trying to
>> accomplish?
>=20
> It does not exist. The ebtables support has been removed shortly after =
its=20
> introduction because it came with some disadvantages. Unless you =
invest some=20
> time to implement something you won't have a solution.
>=20
> Regards,
> Marek

